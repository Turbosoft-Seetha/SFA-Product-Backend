using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MustSellApprovalHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {             

                try
                {
                  if (Session["MSAFromDate"] != null)
                  {
                      rdfromDate.SelectedDate = DateTime.Parse(Session["MSAFromDate"].ToString());
                  }
                  else
                  {
                       rdfromDate.SelectedDate = DateTime.Now;
                  }
                  if (Session["MSAToDate"] != null)
                  {
                       rdendDate.SelectedDate = DateTime.Parse(Session["MSAToDate"].ToString());
                  }
                  else
                  {
                       rdendDate.SelectedDate = DateTime.Now;
                  }
                  if (Session["Status"] != null)
                  {
                       ddlStatus.SelectedValue = Session["Status"].ToString();
                  }
                  else
                  {
                        ddlStatus.SelectedValue = "P";
                  }
                }
                catch (Exception ex)
                {

                }
                
                Route();
                RouteFromTransaction();

                string rotID = Rot();
                string routeCondition = "rcs_rot_ID in (" + rotID + ")";
                Customer(routeCondition);
                CustomerFilter();

                try
                {
                    GetGridSession(grvRpt, "MustSellApproval");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectRouteforMSA", "sp_AppServices");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customer(string routeCondition)
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_wb_merch_others", routeCondition);
            rdCustomer.DataSource = dtc;
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }

        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "msa_rot_id";
            }
        }

        public string Cus()
        {
            var ColelctionMarkets = rdCustomer.CheckedItems;
            string cusID = "";
            int k = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (k > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (k == (MarCounts - 1))
                    {
                        cusID += item.Value;
                    }
                    k++;
                }
                return cusID;
            }
            else
            {
                return "msa_cus_id";
            }
        }



        public string mainConditions(string rotID)
        {
            string Statuses = ddlStatus.SelectedValue.ToString();
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string Statuscondition = "";
            string mainCondition = " msa_rot_id in (" + rotID + ")";
            string userID = UICommon.GetCurrentUserID().ToString();

            try
            {


                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
               
                dateCondition = "  and uwl_usr_ID= " + userID;
                dateCondition = dateCondition +" and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and msa_cus_id in (" + cusID + ")";
                }

                if (Statuses == "A")
                {
                    Statuscondition = " and isnull(A.Status,'P') = 'A' ";
                }
                else if (Statuses == "R")
                {
                    Statuscondition = " and isnull(A.Status,'P') = 'R' ";
                }
                else if (Statuses == "AT")
                {
                    Statuscondition = " and isnull(A.Status,'P') = 'AT' ";
                }
                else
                {
                    Statuscondition = "  and isnull(A.Status,'P') = 'P'  ";
                }

            }
            catch (Exception ex)
            {

            }

            mainCondition += dateCondition;
            mainCondition += Statuscondition;
            mainCondition += customerCondition;            
            return mainCondition;
        }

        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }






        public void LoadList()
        {
            string rotID = Rot();

            if (!rotID.Equals("0"))
            {
                string mainCondition = "";

                mainCondition = mainConditions(rotID);


                DataTable lstUser = default(DataTable);
                string[] arr = { mainCondition };
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                lstUser = ObjclsFrms.loadList("SelMustSellApproval", "sp_AppServices", endDate, arr);
                grvRpt.DataSource = lstUser;
            }
        }

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("udp_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";
            Customer(routeCondition);
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "MustSellApproval");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("msa_id").ToString();

                Response.Redirect("MustSellApprovalDetail.aspx?HID=" + ID);



            }
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
           
        }



        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string Status = ddlStatus.SelectedValue.ToString();
            if (Status == "P")
            {
                lnkApprove.Visible = true;
                lnkReject.Visible = true;
            }
            else
            {
                lnkApprove.Visible = false;
                lnkReject.Visible = false;
            }

            Session["Status"] = ddlStatus.SelectedValue.ToString();

            if (Session["MSAFromDate"] != null)
            {
                string fromdate = rdfromDate.SelectedDate.ToString();
                if (fromdate == Session["MSAFromDate"].ToString())
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["MSAFromDate"].ToString());
                }
                else
                {
                    Session["MSAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
            }
            else
            {
                rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                Session["MSAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

            }
            // rdfromDate.MaxDate = DateTime.Now;

            if (Session["MSAToDate"] != null)
            {
                string todate = rdendDate.SelectedDate.ToString();
                if (todate == Session["MSAToDate"].ToString())
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["MSAToDate"].ToString());
                }
                else
                {
                    Session["MSAToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }

            }
            else
            {
                rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                Session["MSAToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
            }
            LoadList();
            grvRpt.Rebind();
        }

        protected void lnkReject_Click(object sender, EventArgs e)
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

        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {

                DataTable lstApprovalLevel = ObjclsFrms.loadList("SelectUserLevel", "sp_AppServices", UICommon.GetCurrentUserID().ToString());
                if (lstApprovalLevel.Rows.Count > 0)
                {
                    int currentLevel, nextLevel;
                    currentLevel = Int32.Parse(lstApprovalLevel.Rows[0]["CurrentLevel"].ToString());
                    nextLevel = Int32.Parse(lstApprovalLevel.Rows[0]["NextLevel"].ToString());
                    ViewState["currentLevel"] = currentLevel.ToString();
                    ViewState["nextLevel"] = nextLevel.ToString();
                    if (nextLevel == 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('You are the final approver,Do you want to continue?');</script>", false);
                    }
                    else if (nextLevel > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('The Approval request will go to the next level user, Do you want to continue?');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

                    }
                }

            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();

            string nectlvl = ViewState["nextLevel"].ToString();
            string[] arr = { user, nectlvl };
            string Value = ObjclsFrms.SaveData("sp_AppServices", "ApproveMustSell", Req, arr);
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
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string msa_id = dr.GetDataKeyValue("msa_id").ToString();

                            createNode(msa_id, writer);
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

        private void createNode(string msa_id, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("msa_id");
            writer.WriteString(msa_id);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("MustSellApprovalHeader.aspx");

        }
        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = ObjclsFrms.SaveData("sp_AppServices", "RejectMustSell", Req, arr);
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

        protected void ddlStatus_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            if (ddlStatus.SelectedValue == "P")
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
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdfromDate.SelectedDate = startdate;
                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
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

                Response.Redirect("~/SignIn.aspx");

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

    }
}