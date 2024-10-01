using Stimulsoft.Report.Dictionary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Licensing;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {

                    if (Session["CusDBFromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CusDBFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        Session["CusDBFromDate"] = rdfromDate.SelectedDate.ToString();
                    }

                    if (Session["CusDBToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CusDBToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                        Session["CusDBToDate"] = rdendDate.SelectedDate.ToString();
                    }

                    if (Session["SelectedCusID"] != null)
                    {
                        Session["SelectedCusID"] = Session["SelectedCusID"].ToString();

                    }
                    else
                    {
                        Session["SelectedCusID"] = null;
                    }

                    rdfromDate.MaxDate = DateTime.Now;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                                       

                    if (Session["SelectedCusID"] != null)
                    {
                        LoadHeaders(Session["SelectedCusID"].ToString());
                        grvRpt.Rebind();

                        LoadOutlets(Session["SelectedCusID"].ToString());
                        RadGrid1.Rebind();
                    }
                    else
                    {
                        LoadHeaders("");
                        grvRpt.Rebind();

                        LoadOutlets("");
                        RadGrid1.Rebind();
                    }

                    LoadInvoiceAndSales(fromDate, ToDate);
                    LoadOrderARAdvance(fromDate, ToDate);
                    SelSaleOrdCount(fromDate, ToDate);
                    SelectRotDeliveredCount(fromDate, ToDate);
                    SelOutstandingInvCount(fromDate, ToDate);

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }        
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            Session["SelectedCusID"] = null;
            Session["CusDBFromDate"] = rdfromDate.SelectedDate.ToString();        
            Session["CusDBToDate"] = rdendDate.SelectedDate.ToString();

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");


            LoadHeaders("");
            grvRpt.Rebind();

            LoadOutlets("");
            RadGrid1.Rebind();

            LoadInvoiceAndSales(fromDate, ToDate);
            LoadOrderARAdvance(fromDate, ToDate);
            SelSaleOrdCount(fromDate, ToDate);
            SelectRotDeliveredCount(fromDate, ToDate);
            SelOutstandingInvCount(fromDate, ToDate);
        }

        public void LoadHeaders(string cus_csh_ID = "")
        {
            DataTable lstUser = default(DataTable);
            string fromDate = Session["CusDBFromDate"].ToString();
            string ToDate = Session["CusDBToDate"].ToString();
            string[] arr = { fromDate.ToString(), ToDate.ToString() };

            lstUser = ObjclsFrms.loadList("ListCustomerHeaders", "sp_CustomerDashboard", cus_csh_ID, arr );
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;                
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
        }

        public void LoadOutlets(string csh_ID = "")
        {
            string fromDate = Session["CusDBFromDate"].ToString();
            string ToDate = Session["CusDBToDate"].ToString();
            string[] arr = { fromDate.ToString(), ToDate.ToString() };

            DataTable lstUser = ObjclsFrms.loadList("ListCustomerOutlets", "sp_CustomerDashboard", csh_ID, arr);

            if (lstUser.Rows.Count > 0)
            {
                RadGrid1.DataSource = lstUser;                
            }
            else
            {
                RadGrid1.DataSource = new DataTable();                
            }
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("HeaderClick"))
            {
                try
                {
                    int itemIndex = System.Convert.ToInt32(e.CommandArgument);
                    GridDataItem item = grvRpt.MasterTableView.Items[itemIndex] as GridDataItem;

                    if (item != null)
                    {
                        foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                        {
                            di.BackColor = Color.Transparent;
                        }

                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                        string csh_ID = item.GetDataKeyValue("csh_ID").ToString();

                        LoadOutlets(csh_ID);
                        RadGrid1.Rebind();
                    }
                }
                catch (Exception ex)
                {
                    string innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerDashboard.aspx", "Error: " + ex.Message + " - " + innerMessage);
                }
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("OutletClick"))
            {
                try
                {
                    foreach (GridDataItem di in RadGrid1.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = RadGrid1.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                    string cus_csh_ID = item["cus_csh_ID"].Text.ToString();
                    Session["cus_csh_ID"] = cus_csh_ID.ToString();

                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    LoadHeaders(cus_csh_ID);
                    grvRpt.Rebind();

                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerDashboard.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadHeaders("");
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadOutlets("");
        }

        protected void lnkReset_Click(object sender, EventArgs e)
        {
            Session["SelectedCusID"] = null;
            rdfromDate.SelectedDate = DateTime.Now;
            Session["CusDBFromDate"] = rdfromDate.SelectedDate;

            rdendDate.SelectedDate = DateTime.Now;
            Session["CusDBToDate"] = rdendDate.SelectedDate;

            string fromDate = Session["CusDBFromDate"].ToString();
            string ToDate = Session["CusDBToDate"].ToString();

            LoadHeaders("");
            grvRpt.Rebind();

            LoadOutlets("");
            RadGrid1.Rebind();

            LoadInvoiceAndSales(fromDate, ToDate);
            LoadOrderARAdvance(fromDate, ToDate);
            SelSaleOrdCount(fromDate, ToDate);
            SelectRotDeliveredCount(fromDate, ToDate);
            SelOutstandingInvCount(fromDate, ToDate);
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RadGrid1.SelectedItems.Count > 0)
            {
                GridDataItem selectedItem = (GridDataItem)RadGrid1.SelectedItems[0];
                string selectedCusId = selectedItem.GetDataKeyValue("cus_ID").ToString();
                string cus_csh_ID = selectedItem["cus_csh_ID"].Text.ToString();

                Session["SelectedCusID"] = selectedCusId;
                Session["SelectedRowIndex"] = RadGrid1.SelectedIndexes[0];

                LoadHeaders(cus_csh_ID);
                grvRpt.Rebind();

                string fromDate = Session["CusDBFromDate"].ToString();
                string ToDate = Session["CusDBToDate"].ToString();

                LoadInvoiceAndSales(fromDate, ToDate);
                LoadOrderARAdvance(fromDate, ToDate);
                SelSaleOrdCount(fromDate, ToDate);
                SelectRotDeliveredCount(fromDate, ToDate);
                SelOutstandingInvCount(fromDate, ToDate);

                foreach (GridDataItem di in RadGrid1.MasterTableView.Items)
                {
                    di.BackColor = Color.Transparent; 
                }

                selectedItem.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
            }
        }

        public void LoadInvoiceAndSales(string fromDate, string ToDate)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            string[] args = { fromDate, ToDate };
            DataTable dtInvSales = new DataTable();
            if (Session["SelectedCusID"] != null)
            {
                cusID = Session["SelectedCusID"].ToString();
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
                cusID = string.Join(",", customerIds);
            }

            dtInvSales = ObjclsFrms.loadList("SelInvoiceAndSales", "sp_CustomerDashboard", cusID, args);
           
            lblTotalInvoice.Text = dtInvSales.Rows[0]["invoiceCount"].ToString();
            lblTotalInvoiceSum.Text = " AED " + dtInvSales.Rows[0]["invoiceSum"].ToString();

            lblSalesCount.Text = dtInvSales.Rows[0]["salesCount"].ToString();
            lblSalesSum.Text = " AED " + dtInvSales.Rows[0]["salesSum"].ToString();

            lblTotalGReturns.Text = dtInvSales.Rows[0]["grCount"].ToString();
            lblTotalGReturnsSum.Text = " AED " + dtInvSales.Rows[0]["grSum"].ToString();

            lblTotalBReturns.Text = dtInvSales.Rows[0]["brCount"].ToString();
            lblTotalBReturnsSum.Text = " AED " + dtInvSales.Rows[0]["brSum"].ToString();

        }
        public void LoadOrderARAdvance(string fromDate, string ToDate)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            string[] args = { fromDate, ToDate };
            DataTable dtInvSales = new DataTable();
            if (Session["SelectedCusID"] != null)
            {
                cusID = Session["SelectedCusID"].ToString();
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
                cusID = string.Join(",", customerIds);
            }

            dtInvSales = ObjclsFrms.loadList("SelQuotSalOrdArAdvance", "sp_CustomerDashboard", cusID, args);

            lblQuotations.Text = dtInvSales.Rows[0]["QuotationCount"].ToString();
            lblQuotationSum.Text = " AED " + dtInvSales.Rows[0]["QuotationSum"].ToString();

            lblTotalOrder.Text = dtInvSales.Rows[0]["SalesOrderCount"].ToString();
            lblTotalOrderSum.Text = " AED " + dtInvSales.Rows[0]["SalesOrderSum"].ToString();

            lblTotalAR.Text = dtInvSales.Rows[0]["ARCount"].ToString();
            lblTotalARSum.Text = " AED " + dtInvSales.Rows[0]["ARSum"].ToString();

            lblTotalAdvance.Text = dtInvSales.Rows[0]["AdvanceCount"].ToString();
            lblTotalAdvanceSum.Text = " AED " + dtInvSales.Rows[0]["AdvanceSum"].ToString();

        }
        public void SelSaleOrdCount(string fromDate, string ToDate)
        {
            string cusID;
            List<string> customerIds = new List<string>();

            if (Session["SelectedCusID"] != null)
            {
                cusID = Session["SelectedCusID"].ToString();
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
                cusID = string.Join(",", customerIds);
            }

            string[] args = { fromDate, ToDate };
            DataTable dtInvSales = ObjclsFrms.loadList("SelectSalesOrdCount", "sp_CustomerDashboard", cusID, args);
            if (dtInvSales.Rows.Count > 0)
            {
                lblSaleOrdcount.Text = dtInvSales.Rows[0]["count"].ToString();
            }
            else
            {
                lblSaleOrdcount.Text = "0"; 
            }
        }

        public void SelectRotDeliveredCount(string fromDate, string ToDate)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            string[] args = { fromDate, ToDate };
            DataTable dtInvSales = new DataTable();
            if (Session["SelectedCusID"] != null)
            {
                cusID = Session["SelectedCusID"].ToString();
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
                cusID = string.Join(",", customerIds);
            }

            dtInvSales = ObjclsFrms.loadList("SelectRotDeliveredCount", "sp_CustomerDashboard", cusID, args);
            lbldelcount.Text = dtInvSales.Rows[0]["count"].ToString();
        }
        public void SelOutstandingInvCount(string fromDate, string ToDate)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            string[] args = { fromDate, ToDate };
            DataTable dtInvSales = new DataTable();
            if (Session["SelectedCusID"] != null)
            {
                cusID = Session["SelectedCusID"].ToString();
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
                cusID = string.Join(",", customerIds);
            }

            dtInvSales = ObjclsFrms.loadList("SelOutstandingCountSplits", "sp_CustomerDashboard", cusID, args);
            lblOutstanding.Text = dtInvSales.Rows[0]["totcount"].ToString();
        }
        protected void totalInvoices_Click(object sender, EventArgs e)
        {
            Session["SHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["SHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }  

            Session["SHcusID"] = string.Join(",", customerIds);
            Session["SHrotID"] = null;
            Response.Redirect("SalesHeader.aspx?mode=3&&type=INV");            
        }
        protected void salesLink_Click(object sender, EventArgs e)
        {
            Session["SHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["SHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["SHcusID"] = string.Join(",", customerIds);
            Session["SHrotID"] = null;
           
            Response.Redirect("SalesHeader.aspx?mode=3&&type=SL");
        }

        protected void goodReturnLink_Click(object sender, EventArgs e)
        {
            Session["SHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["SHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["SHcusID"] = string.Join(",", customerIds);
            Session["SHrotID"] = null;

            Response.Redirect("SalesHeader.aspx?mode=3&&type=GR");
        }

        protected void badReturnLink_Click(object sender, EventArgs e)
        {
            Session["SHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["SHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["SHcusID"] = string.Join(",", customerIds);
            Session["SHrotID"] = null;

            Response.Redirect("SalesHeader.aspx?mode=3&&type=BR");
        }

        protected void freeOfCostLink_Click(object sender, EventArgs e)
        {
            Session["SHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["SHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["SHcusID"] = string.Join(",", customerIds);
            Session["SHrotID"] = null;

            Response.Redirect("SalesHeader.aspx?mode=3&&type=FG");
        }

        protected void lnkQuotations_Click(object sender, EventArgs e)
        {
            Session["QORFDate"] = rdfromDate.SelectedDate.ToString();
            Session["QORTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["QORcusID"] = string.Join(",", customerIds);
            Session["QORrotID"] = null;

            Response.Redirect("QuotationOrderHeader.aspx?mode=3");
        }

        protected void lnkSalesOrder_Click(object sender, EventArgs e)
        {
            Session["LOFDate"] = rdfromDate.SelectedDate.ToString();
            Session["LOTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["LOcusID"] = string.Join(",", customerIds);
            Session["LOrotID"] = null;

            Response.Redirect("ListOrders.aspx?mode=3");

        }

        protected void lnkARColl_Click(object sender, EventArgs e)
        {
            Session["ARFDate"] = rdfromDate.SelectedDate.ToString();
            Session["ARTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["ARcusID"] = string.Join(",", customerIds);
            Session["ARrotID"] = null;
            Response.Redirect("ARHeader.aspx?mode=3");
        }

        protected void lnkAdvColl_Click(object sender, EventArgs e)
        {
            Session["OHFDate"] = rdfromDate.SelectedDate.ToString();
            Session["OHTDate"] = rdendDate.SelectedDate.ToString();
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["ARcusID"] = string.Join(",", customerIds);
            Session["OHrotID"] = null;
            Response.Redirect("ListAdvancePayment.aspx?mode=3");
        }

        protected void lnkSaleOrdiv_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
           
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["OSDcusID"] = string.Join(",", customerIds);            
            Session["Route"] = null;
            Response.Redirect("OrderStatusDashboard.aspx?mode=1");
        }

        protected void lnkRotdeliv_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();

            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["RDBcusID"] = string.Join(",", customerIds);
            Session["Route"] = null;
            Response.Redirect("RouteDeliveryDashboard.aspx?mode=2");
        }

        protected void lnkOutstandingInv_Click(object sender, EventArgs e)
        {
            List<string> customerIds = new List<string>();

            if (RadGrid1.SelectedItems.Count > 0)
            {
                if (Session["SelectedCusID"] != null)
                {
                    string selectedCusId = Session["SelectedCusID"].ToString();
                    customerIds.Add(selectedCusId);
                }
                else
                {
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }
                }
            }
            else
            {
                foreach (GridDataItem gridItem in RadGrid1.Items)
                {
                    string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                    customerIds.Add(cusId);
                }
            }

            Session["OutcusID"] = string.Join(",", customerIds);
            Session["KPIRoute"] = null;
            Response.Redirect("OutstandingDashboard.aspx?OutStandingMode=2");
        }

        protected void lnkInvMonitoring_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("InventoryMonitoringDashboard.aspx?mode=1");
        }

        protected void lnkActManagement_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("ActivityManagementDashboard.aspx");
        }

        protected void lnkcusservice_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("CustomerServiceDashboard.aspx");
        }

    }
}