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
    public partial class CustomerFOCApproval : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["CFOCStatus"] == null)
                    {
                        Session["CFOCStatus"] = "";
                    }
                    else
                    {
                        rdStatus.SelectedValue = Session["CFOCStatus"].ToString();
                    }

                    if (Session["CFOCFDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CFOCFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["CFOCTDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CFOCTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now.AddDays(1);
                    }
                    rdendDate.MaxDate = DateTime.Now.AddDays(1);
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    Route();
                    if (Session["CFOCrotid"] != null)
                    {
                        string routeID = Session["CFOCrotid"].ToString();
                        string[] ar = routeID.Split(',');
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
                    }
                    else
                    {
                        string rotid = focRot();
                        string routecondition = " cfh_rot_ID  in (" + rotid + ")";
                    }
                    Customers();
                    if (Session["CFOCcusID"] != null)
                    {
                        int a = rdCustomer.Items.Count;
                        string cusID = Session["CFOCcusID"].ToString();
                        string[] ar = cusID.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in rdCustomer.Items)
                            {


                                if (items.Value == ar[i])
                                {
                                    items.Checked = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        string cusID = focCus();
                        string cusCondition = "A.cus_ID in (" + cusID + ")";
                    }
                }
                catch
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    GetGridSession(grvRpt, "CustomerFOCApproval");
                    grvRpt.Rebind();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
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
        public void Customers()
        {

            string rotid = focRot();
            string routeCondition = " cfh_rot_ID in (" + rotid + ")";
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomers", "sp_Masters_UOM", routeCondition.ToString());
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { toDate.ToString() };
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_Masters_UOM", fromDate.ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public string focCus()
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
                return "cfh_cus_ID";
            }
         
        }
        public string focRot()
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
                return "cfh_rot_ID";
            }
          
        }
        public string mainConditions()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotid = focRot();
            string customer = focCus();
            string status = Session["CFOCStatus"].ToString();
            string mainCondition = "";
            string customerCondition = "";
            string rotCondition = "";
            string statusCondition = "";
            string dateCondition = "";
            try
            {
                if (status.Equals(""))
                {
                    statusCondition = "and isnull(A.Status,'A') in ('A')";
                }
                else
                {
                    statusCondition = " and isnull(A.Status,'A')  in ('" + status + "')";
                }
                dateCondition = "  and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";
                if (rotid.Equals("0"))
                {
                    rotCondition = "";
                }
                else
                {
                    rotCondition = " and cfh_rot_ID in (" + rotid + ")";
                }
                if (customer.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " cfh_cus_ID in (" + customer + ")";
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
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
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
            Route();
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
        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCustomerFOCApprovalHeader", "sp_Masters_UOM", mainCondition);
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void Rdcushead_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customers();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "CustomerFOCApproval");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Item"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string ID = dataItem.GetDataKeyValue("cfh_ID").ToString();
                    Console.WriteLine("ID", ID);
                    //string Mode = dataItem["Mode"].Text.ToString();

                    Response.Redirect("CustomerFOCApprovalDetail.aspx?CFOCA=" + ID);

                }
            }
        }
        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
        protected void save_Click(object sender, EventArgs e)
        {
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerFOCApproval.aspx");
        }
        protected void lnkReject_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);
        }

        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string focAppID = GetSelectedItemsFromGrid();
            DataTable lstData = new DataTable();
            string[] arr = { user };
            string resp = ObjclsFrms.SaveData("sp_Masters_UOM", "CFOCApproval", focAppID, arr);
            int res = Int32.Parse(resp);

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer FOC Approved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }

        }


        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string focId= GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            string remark = this.txtRejRem.Text.ToString();

            string[] arr = { user, remark.ToString() };
            string resp = ObjclsFrms.SaveData("sp_Masters_UOM", "RejectustomerFOCApproval", focId.ToString(), arr);
            int res = Int32.Parse(resp);
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }
        public string GetSelectedItemsFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {
                        // Check if the checkbox in the current row is checked
                        CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect"); // Replace "chkSelect" with the actual ID or UniqueName of your checkbox column
                        if (chkSelect != null && chkSelect.Checked)
                        {
                            string cfh_ID = item.GetDataKeyValue("cfh_ID").ToString();
                            createNode(cfh_ID, writer);
                            c++;
                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                }

                if (c == 0)
                {
                    return null;
                }
                else
                {
                    return sw.ToString();
                }
            }
        }
        private void createNode(string cfh_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cfh_ID");
            writer.WriteString(cfh_ID);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {

            try
            {
                Session["CFOCStatus"] = rdStatus.SelectedValue.ToString();

                if (Session["CFOCFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["CFOCFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CFOCFDate"].ToString());
                    }
                    else
                    {
                        Session["CFOCFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["CFOCFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["CFOCTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["CFOCTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CFOCTDate"].ToString());
                    }
                    else
                    {
                        Session["CFOCTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["CFOCTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);
                if (Session["CFOCrotid"] != null)
                {
                    string routeID = focRot();
                    if (routeID == Session["CFOCrotid"].ToString())
                    {
                        string rotid = focRot();
                    }
                    else
                    {
                        string rotid = focRot();
                        Session["CFOCrotid"] = rotid;
                    }
                }
                else
                {
                    string rotid = focRot();
                    Session["CFOCrotid"] = rotid;
                }
                if (Session["CFOCcusID"] != null)
                {
                    string customer = focCus();
                    if (customer == Session["CFOCcusID"].ToString())
                    {
                        string cusID = focCus();

                    }
                    else
                    {
                        string cusID = focCus();
                        Session["CFOCcusID"] = cusID;
                    }
                }
                else
                {
                    string cusID = focCus();
                    Session["CFOCcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
        }
    }
}