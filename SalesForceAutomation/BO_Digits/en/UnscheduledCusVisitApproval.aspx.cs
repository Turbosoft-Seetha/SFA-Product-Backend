using DocumentFormat.OpenXml.Office2010.PowerPoint;
using DocumentFormat.OpenXml.Spreadsheet;
using ExcelLibrary.BinaryFileFormat;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class UnscheduledCusVisitApproval : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();


                try
                {
                    if (Session["UVAStatus"] == null)
                    {
                        Session["UVAStatus"] = "";
                    }
                    else
                    {
                        rdStatus.SelectedValue = Session["UVAStatus"].ToString();
                    }

                    if (Session["UVAFDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["UVAFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate =DateTime.Now;
                    }
                    if (Session["UVATDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["UVATDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                    }
                    try
                    {
                        if (Session["UVArotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string route = Session["UVArotID"].ToString();
                            string[] ar = route.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdRoute.Items)
                                {
                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }                            
                            string routeCondition = " uva_rot_ID in (" + route + ")";
                            Customers(routeCondition);
                            int jj = 1;
                            foreach (RadComboBoxItem itmss in rdCustomer.Items)
                            {
                                itmss.Checked = true;
                                jj++;
                            }

                        }
                        else
                        {
                            int j = 1;
                            foreach (RadComboBoxItem itmss in rdRoute.Items)
                            {
                                itmss.Checked = true;
                                j++;
                            }
                            string rotID = Rot();
                            string routeCondition = " uva_rot_ID in (" + rotID + ")";
                            Customers(routeCondition);
                            int jjj = 1;
                            foreach (RadComboBoxItem itmss in rdCustomer.Items)
                            {
                                itmss.Checked = true;
                                jjj++;
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                    

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void GetGridSession(RadGrid grd, string SessionPrefix)
        {
            try
            {
                string filterExpression = string.Empty;
                foreach (GridColumn column in grd.MasterTableView.Columns)
                {
                    if (column is GridBoundColumn boundColumn)
                    {
                        string columnName = boundColumn.UniqueName;
                        if (Session[SessionPrefix + columnName] != null)
                        {
                            string filterValue = Session[SessionPrefix + columnName].ToString();
                            if (filterValue != "")
                            {
                                column.CurrentFilterValue = filterValue;
                                if (!string.IsNullOrEmpty(filterExpression))
                                {
                                    filterExpression += " AND ";
                                }
                                filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);
                            }
                        }
                    }
                }
                if (filterExpression != string.Empty)
                {
                    grvRpt.MasterTableView.FilterExpression = filterExpression;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

        }
        protected void lnkDOwnload_Click(object sender, EventArgs e)
        {
            try
            {
                Session["UVAStatus"] = rdStatus.SelectedValue.ToString();
                if (Session["UVAFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["UVAFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["UVAFDate"].ToString());
                    }
                    else
                    {
                        Session["UVAFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["UVAFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["UVATDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["UVATDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["UVATDate"].ToString());
                    }
                    else
                    {
                        Session["UVATDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["UVATDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);
                if (Session["UVArotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["UVArotID"].ToString())
                    {
                        string rotID = Rot();
                    }
                    else
                    {
                        string rotID = Rot();
                        Session["UVArotID"] = rotID;
                    }
                }
                else
                {
                    string rotID = Rot();
                    Session["UVArotID"] = rotID;
                }

                if (Session["UVAcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["UVAcusID"].ToString())
                    {
                        string cusID = Cus();
                    }
                    else
                    {
                        string cusID = Cus();
                        Session["UVAcusID"] = cusID;
                    }
                }
                else
                {
                    string cusID = Cus();
                    Session["UVAcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadData();
            grvRpt.Rebind();
        }
        public string Rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "uva_rot_ID";
            }
        }
        public string Cus()
        {
            var CollectionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "uva_cus_ID";
            }

        }
        public void LoadData()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions();
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("ListUnscheduledCusVisit", "sp_UnscheduledVisitApproval", mainCondition);
                grvRpt.DataSource = lstDatas;
            }
        }

        public string mainConditions()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotid = Rot();
            string cusid = Cus();
            string status = Session["UVAStatus"].ToString();


            string mainCondition = "";
            string customerCondition = "";
            string rotCondition = "";
            string statusCondition = "";
            string dateCondition = "";
            try
            {
                if (status.Equals(""))
                {
                    statusCondition = "and isnull(U.Status,'P') in ('P')";
                }
                else
                {
                    statusCondition = " and isnull(U.Status,'P')  in ('" + status + "')";
                }

                dateCondition = "  and (cast(U.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";

                if (rotid.Equals("0"))
                {
                    rotCondition = "";
                }
                else
                {
                    rotCondition = " and uva_rot_ID in (" + rotid + ")";
                }

                if (cusid.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " uva_cus_ID in (" + cusid + ")";
                }
               
            }
            catch (Exception ex)
            {

            }

            mainCondition += customerCondition;
            mainCondition += rotCondition;
            mainCondition += dateCondition;
            mainCondition += statusCondition;         
            return mainCondition;
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            Session["UVAtatus"] = rdStatus.SelectedValue.ToString();
            LoadData();
            grvRpt.Rebind();
        }

        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_UnscheduledVisitApproval");
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataTextField = "rot_Name";

            rdRoute.DataBind();
        }
        public void Customers(string routeCondition)
        {


            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerfordropdown", "sp_UnscheduledVisitApproval", routeCondition);
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataBind();


        }
        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals(""))
            {
                rotID = "uva_rot_ID";
            }
            string routeCondition = " uva_rot_ID in (" + rotID + ")";
            Customers(routeCondition);


        }
            

        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    string status = item["Status"].Text;

                    Telerik.Web.UI.GridClientSelectColumn chkAllColumn = (Telerik.Web.UI.GridClientSelectColumn)item.OwnerTableView.GetColumn("chkAll");
                    LinkButton lnkApprove = (LinkButton)rdd.FindControl("lnkApprove");
                    LinkButton lnkReject = (LinkButton)rdd.FindControl("lnkReject");

                    if (status == "Pending")
                    {
                        chkAllColumn.Visible = true;
                        lnkApprove.Visible = true;
                        lnkReject.Visible = true;
                    }
                    else
                    {
                        chkAllColumn.Visible = false;
                        lnkApprove.Visible = false;
                        lnkReject.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {

            }

        }
        

        

        
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;
                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }
        public void SetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        string filterValue = column.CurrentFilterValue;

                        Session[SessionPrefix + columnName] = filterValue;

                    }

                }

            }

            catch (Exception ex)

            {

            }



        }
        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = ObjclsFrms.SaveData("sp_UnscheduledVisitApproval", "ApproveRequest", Req, arr);
            int res = Int32.Parse(Value.ToString());

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Approved Successfully');</script>", false);
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            
        }

        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = grvRpt.SelectedItems;
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string uva_ID = dr.GetDataKeyValue("uva_ID").ToString();

                            createNode(uva_ID, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }
        private void createNode(string uva_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("uva_ID");
            writer.WriteString(uva_ID);
            writer.WriteEndElement();




            writer.WriteEndElement();
        }
        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = ObjclsFrms.SaveData("sp_UnscheduledVisitApproval", "RejectRequest", Req, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("UnscheduledCusVisitApproval.aspx");

        }
        protected void rdStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (rdStatus.SelectedValue == "P")
            {
                lnkApprove.Visible = true;
                lnkReject.Visible = true;
            }
            else
            {
                lnkApprove.Visible = false;
                lnkReject.Visible = false;
            }
        }

        protected void lnkReject_Click1(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

            }
        }
    }
}