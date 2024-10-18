using EnvDTE;
using SalesForceAutomation.Admin;
using Stimulsoft.Report.Dictionary;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Licensing;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Fixed.Model.Editing;
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
                    Session["SelectedHeaderID"] = null;
                    Session["SelectedCusID"] = null;
                    ViewState["HeaderDataSource"] = null;
                    ViewState["OutletDataSource"] = null;
                    lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");

                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    }

                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                        Session["ToDate"] = rdendDate.SelectedDate.ToString();
                    }

                    LoadHeaders("");
                    grvRpt.Rebind();

                    LoadOutlets("");
                    RadGrid1.Rebind();

                    rdfromDate.MaxDate = DateTime.Now;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    LoadInvoiceAndSales(fromDate, ToDate, "O");
                    LoadOrderARAdvance(fromDate, ToDate, "O");
                    SelSaleOrdCount(fromDate, ToDate, "O");
                    SelectRotDeliveredCount(fromDate, ToDate, "O");
                    SelOutstandingInvCount(fromDate, ToDate, "O");
                    EnableResetButton();

                }

                catch (Exception ex)
                {
                     Response.Redirect("~/SignIn.aspx");
                }
               
            }
        }
             
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();

            Session["SelectedHeaderID"] = null;
            Session["SelectedCusID"] = null;
               

                LoadHeaders("");
                grvRpt.Rebind(); 
                
                LoadOutlets("");
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "O");
                LoadOrderARAdvance(fromDate, ToDate, "O");
                SelSaleOrdCount(fromDate, ToDate, "O");
                SelectRotDeliveredCount(fromDate, ToDate, "O");
                SelOutstandingInvCount(fromDate, ToDate, "O");
                EnableResetButton();           
        }

        public void LoadHeaders(string cus_csh_ID = "")
        {
            DataTable lstUser = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), ToDate.ToString() };

            lstUser = ObjclsFrms.loadList("ListCustomerHeaders", "sp_CustomerDashboard", cus_csh_ID, arr );
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
                ViewState["HeaderDataSource"] = lstUser;
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
           
        }

        public void LoadOutlets(string csh_ID = "")
        {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] arr = { fromDate.ToString(), ToDate.ToString() };

            DataTable lstUser = ObjclsFrms.loadList("ListCustomerOutlets", "sp_CustomerDashboard", csh_ID, arr);

            if (lstUser.Rows.Count > 0)
            {
                RadGrid1.DataSource = lstUser;
                ViewState["OutletDataSource"] = lstUser;
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
                        Session["SelectedHeaderID"] = csh_ID;
                        Session["SelectedCusID"] = null;

                        LoadOutlets(csh_ID);
                        RadGrid1.Rebind();                        

                        string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                        LoadInvoiceAndSales(fromDate, ToDate, "H");
                        LoadOrderARAdvance(fromDate, ToDate, "H");
                        SelSaleOrdCount(fromDate, ToDate, "H");
                        SelectRotDeliveredCount(fromDate, ToDate, "H");
                        SelOutstandingInvCount(fromDate, ToDate, "H");
                        EnableResetButton();
                    }
              
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("OutletClick"))
            {
                    foreach (GridDataItem di in RadGrid1.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = RadGrid1.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];                  

                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    string selectedCusId = item.GetDataKeyValue("cus_ID").ToString();
                    string cus_csh_ID = item["cus_csh_ID"].Text.ToString();
                    Session["SelectedCusID"] = selectedCusId;                   

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    LoadInvoiceAndSales(fromDate, ToDate, "O");
                    LoadOrderARAdvance(fromDate, ToDate, "O");
                    SelSaleOrdCount(fromDate, ToDate, "O");
                    SelectRotDeliveredCount(fromDate, ToDate, "O");
                    SelOutstandingInvCount(fromDate, ToDate, "O");
                    EnableResetButton();
               
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

        protected void grvRpt_SelectedIndexChanged(object sender, EventArgs e)
        {
          
                if (grvRpt.SelectedItems.Count > 0)
                {
                    GridDataItem selectedItem = (GridDataItem)grvRpt.SelectedItems[0];
                    string csh_ID = selectedItem.GetDataKeyValue("csh_ID").ToString();                    
                    Session["SelectedHeaderID"] = csh_ID;
                    Session["SelectedCusID"] = null;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                LoadOutlets(csh_ID);
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "H");
                LoadOrderARAdvance(fromDate, ToDate , "H");
                SelSaleOrdCount(fromDate, ToDate, "H");
                SelectRotDeliveredCount(fromDate, ToDate, "H");
                SelOutstandingInvCount(fromDate, ToDate, "H");
                EnableResetButton();
                }                
          
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
                if (RadGrid1.SelectedItems.Count > 0)
                {
                    GridDataItem selectedItem = (GridDataItem)RadGrid1.SelectedItems[0];
                    string selectedCusId = selectedItem.GetDataKeyValue("cus_ID").ToString();
                    string cus_csh_ID = selectedItem["cus_csh_ID"].Text.ToString();
                    Session["SelectedCusID"] = selectedCusId;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    LoadInvoiceAndSales(fromDate, ToDate, "O");
                    LoadOrderARAdvance(fromDate, ToDate, "O");
                    SelSaleOrdCount(fromDate, ToDate, "O");
                    SelectRotDeliveredCount(fromDate, ToDate, "O");
                    SelOutstandingInvCount(fromDate, ToDate, "O");
                    EnableResetButton();
                }
           
        }

        public void LoadInvoiceAndSales(string fromDate, string ToDate, string mode)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            List<string> HeaderIDs = new List<string>();
            
            DataTable dtInvSales = new DataTable(); 
            
            if (mode == "H")
            {
                if (Session["SelectedHeaderID"] != null)
                {
                    cusID = Session["SelectedHeaderID"].ToString();
                }
                else
                {
                    int originalPageSize = grvRpt.PageSize;
                    grvRpt.PageSize = int.MaxValue;
                    grvRpt.Rebind();
                    foreach (GridDataItem gridItem in grvRpt.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("csh_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    grvRpt.PageSize = originalPageSize;
                    grvRpt.Rebind();
                    cusID = string.Join(",", HeaderIDs);
                }
            }
            else
            {
                if (Session["SelectedCusID"] != null)
                {
                    cusID = Session["SelectedCusID"].ToString();
                }
                else
                {
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                    cusID = string.Join(",", customerIds);
                }
            }

            string[] args = { fromDate, ToDate , mode };
            dtInvSales = ObjclsFrms.loadList("SelInvoiceAndSales", "sp_CustomerDashboard", cusID, args);
           
            lblTotalInvoice.Text = dtInvSales.Rows[0]["invoiceCount"].ToString();
            lblTotalInvoiceSum.Text = "AED " + dtInvSales.Rows[0]["invoiceSum"].ToString();

            lblSalesCount.Text = dtInvSales.Rows[0]["salesCount"].ToString();
            lblSalesSum.Text = "AED "+ dtInvSales.Rows[0]["salesSum"].ToString();

            lblTotalGReturns.Text = dtInvSales.Rows[0]["grCount"].ToString();
            lblTotalGReturnsSum.Text = "AED " + dtInvSales.Rows[0]["grSum"].ToString();

            lblTotalBReturns.Text = dtInvSales.Rows[0]["brCount"].ToString();
            lblTotalBReturnsSum.Text = "AED " + dtInvSales.Rows[0]["brSum"].ToString();

            lblTotalFreeGoods.Text = dtInvSales.Rows[0]["fgCount"].ToString();


        }
        public void LoadOrderARAdvance(string fromDate, string ToDate, string mode)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            List<string> HeaderIDs = new List<string>();

            DataTable dtInvSales = new DataTable();
            if (mode == "H")
            {
                if (Session["SelectedHeaderID"] != null)
                {
                    cusID = Session["SelectedHeaderID"].ToString();
                }
                else
                {
                    int originalPageSize = grvRpt.PageSize;
                    grvRpt.PageSize = int.MaxValue;
                    grvRpt.Rebind();
                    foreach (GridDataItem gridItem in grvRpt.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("csh_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    grvRpt.PageSize = originalPageSize;
                    grvRpt.Rebind();
                    cusID = string.Join(",", HeaderIDs);
                }
            }
            else
            {
                if (Session["SelectedCusID"] != null)
                {
                    cusID = Session["SelectedCusID"].ToString();
                }
                else
                {
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                    cusID = string.Join(",", customerIds);
                }
            }

            string[] args = { fromDate, ToDate, mode };

            dtInvSales = ObjclsFrms.loadList("SelQuotSalOrdArAdvance", "sp_CustomerDashboard", cusID, args);

            lblQuotations.Text = dtInvSales.Rows[0]["QuotationCount"].ToString();
            lblQuotationSum.Text = "AED " + dtInvSales.Rows[0]["QuotationSum"].ToString();

            lblTotalOrder.Text = dtInvSales.Rows[0]["SalesOrderCount"].ToString();
            lblTotalOrderSum.Text = "AED " + dtInvSales.Rows[0]["SalesOrderSum"].ToString();

            lblTotalAR.Text = dtInvSales.Rows[0]["ARCount"].ToString();
            lblTotalARSum.Text = "AED " + dtInvSales.Rows[0]["ARSum"].ToString();

            lblTotalAdvance.Text = dtInvSales.Rows[0]["AdvanceCount"].ToString();
            lblTotalAdvanceSum.Text = "AED " + dtInvSales.Rows[0]["AdvanceSum"].ToString();
           

        }
        public void SelSaleOrdCount(string fromDate, string ToDate, string mode)
        {
           
            string cusID;
            List<string> customerIds = new List<string>(); 
            List<string> HeaderIDs = new List<string>();

           
            if (mode == "H")
            {
                if (Session["SelectedHeaderID"] != null)
                {
                    cusID = Session["SelectedHeaderID"].ToString();
                }
                else
                {
                    int originalPageSize = grvRpt.PageSize;
                    grvRpt.PageSize = int.MaxValue;
                    grvRpt.Rebind();
                    foreach (GridDataItem gridItem in grvRpt.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("csh_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    grvRpt.PageSize = originalPageSize;
                    grvRpt.Rebind();
                    cusID = string.Join(",", HeaderIDs);
                }
            }
            else
            {
                if (Session["SelectedCusID"] != null)
                {
                    cusID = Session["SelectedCusID"].ToString();
                }
                else
                {
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                    cusID = string.Join(",", customerIds);
                }
            }

            string[] args = { fromDate, ToDate, mode };
           
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

        public void SelectRotDeliveredCount(string fromDate, string ToDate, string mode)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            List<string> HeaderIDs = new List<string>();


            if (mode == "H")
            {
                if (Session["SelectedHeaderID"] != null)
                {
                    cusID = Session["SelectedHeaderID"].ToString();
                }
                else
                {
                    int originalPageSize = grvRpt.PageSize;
                    grvRpt.PageSize = int.MaxValue;
                    grvRpt.Rebind();
                    foreach (GridDataItem gridItem in grvRpt.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("csh_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    grvRpt.PageSize = originalPageSize;
                    grvRpt.Rebind();
                    cusID = string.Join(",", HeaderIDs);
                }
            }
            else
            {
                if (Session["SelectedCusID"] != null)
                {
                    cusID = Session["SelectedCusID"].ToString();
                }
                else
                {
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                    cusID = string.Join(",", customerIds);
                }
            }

            string[] args = { fromDate, ToDate, mode };
            DataTable dtInvSales = new DataTable();           

            dtInvSales = ObjclsFrms.loadList("SelectRotDeliveredCount", "sp_CustomerDashboard", cusID, args);
            lbldelcount.Text = dtInvSales.Rows[0]["count"].ToString();
        
        }
        public void SelOutstandingInvCount(string fromDate, string ToDate, string mode)
        {
            string cusID;
            List<string> customerIds = new List<string>();
            List<string> HeaderIDs = new List<string>();


            if (mode == "H")
            {
                if (Session["SelectedHeaderID"] != null)
                {
                    cusID = Session["SelectedHeaderID"].ToString();
                }
                else
                {
                    int originalPageSize = grvRpt.PageSize;
                    grvRpt.PageSize = int.MaxValue;
                    grvRpt.Rebind();
                    foreach (GridDataItem gridItem in grvRpt.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("csh_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    grvRpt.PageSize = originalPageSize;
                    grvRpt.Rebind();
                    cusID = string.Join(",", HeaderIDs);
                }
            }
            else
            {
                if (Session["SelectedCusID"] != null)
                {
                    cusID = Session["SelectedCusID"].ToString();
                }
                else
                {
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                    cusID = string.Join(",", customerIds);
                }
            }

            string[] args = { fromDate, ToDate, mode };
            DataTable dtInvSales = new DataTable();
            
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }            
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable; 

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
                }
            }

            Session["OHcusID"] = string.Join(",", customerIds);
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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
                    int originalPageSize = RadGrid1.PageSize;
                    RadGrid1.PageSize = int.MaxValue;
                    RadGrid1.Rebind();
                    foreach (GridDataItem gridItem in RadGrid1.Items)
                    {
                        string cusId = gridItem.GetDataKeyValue("cus_ID").ToString();
                        customerIds.Add(cusId);
                    }

                    RadGrid1.PageSize = originalPageSize;
                    RadGrid1.Rebind();
                }
            }
            else
            {
                if (ViewState["OutletDataSource"] != null)
                {
                    DataTable dt = ViewState["OutletDataSource"] as DataTable;

                    if (dt != null)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string cusId = row["cus_ID"].ToString();
                            customerIds.Add(cusId);
                        }
                    }
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

        protected void HeaderReset_Click(object sender, ImageClickEventArgs e)
        {
            grvRpt.SelectedIndexes.Clear();
            RadGrid1.SelectedIndexes.Clear();

            Session["SelectedHeaderID"] = null;
            Session["SelectedCusID"] = null;

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            LoadHeaders("");
            grvRpt.Rebind();

            LoadOutlets("");
            RadGrid1.Rebind();

            LoadInvoiceAndSales(fromDate, ToDate, "O");
            LoadOrderARAdvance(fromDate, ToDate, "O");
            SelSaleOrdCount(fromDate, ToDate, "O");
            SelectRotDeliveredCount(fromDate, ToDate, "O");
            SelOutstandingInvCount(fromDate, ToDate, "O");
            EnableResetButton();

        }

        protected void OutletReset_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid1.SelectedIndexes.Clear();            
            Session["SelectedCusID"] = null;
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");           

            if (Session["SelectedHeaderID"] != null)
            {
                string headID = Session["SelectedHeaderID"].ToString();

                LoadOutlets(headID);
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "H");
                LoadOrderARAdvance(fromDate, ToDate, "H");
                SelSaleOrdCount(fromDate, ToDate, "H");
                SelectRotDeliveredCount(fromDate, ToDate, "H");
                SelOutstandingInvCount(fromDate, ToDate, "H");
                EnableResetButton();
            }
            else
            {
                LoadOutlets("");
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "O");
                LoadOrderARAdvance(fromDate, ToDate, "O");
                SelSaleOrdCount(fromDate, ToDate, "O");
                SelectRotDeliveredCount(fromDate, ToDate, "O");
                SelOutstandingInvCount(fromDate, ToDate, "O");
                EnableResetButton();
            }
           
        }
        public void EnableResetButton()
        {            
            if (Session["SelectedHeaderID"] != null)
            {
                HeaderReset.Visible = true;
                HeaderReset.Enabled = true;
            }
            else
            {
                HeaderReset.Visible = true;
                HeaderReset.Enabled = false;
                OutletReset.Enabled = false;
                OutletReset.Visible = true;
            }
            if (Session["SelectedCusID"] != null)
            {
                OutletReset.Visible = true;
                OutletReset.Enabled = true;
            }
            else
            {
                OutletReset.Visible = true;
                OutletReset.Enabled = false;
            }
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadHeaders("");
                grvRpt.Rebind();

                LoadOutlets("");
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "O");
                LoadOrderARAdvance(fromDate, ToDate, "O");
                SelSaleOrdCount(fromDate, ToDate, "O");
                SelectRotDeliveredCount(fromDate, ToDate, "O");
                SelOutstandingInvCount(fromDate, ToDate, "O");
                EnableResetButton();
            }            
            catch(Exception ex)
            {

            }
}

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadHeaders("");
                grvRpt.Rebind();

                LoadOutlets("");
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "O");
                LoadOrderARAdvance(fromDate, ToDate, "O");
                SelSaleOrdCount(fromDate, ToDate, "O");
                SelectRotDeliveredCount(fromDate, ToDate, "O");
                SelOutstandingInvCount(fromDate, ToDate, "O");
                EnableResetButton();
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadHeaders("");
                grvRpt.Rebind();

                LoadOutlets("");
                RadGrid1.Rebind();

                LoadInvoiceAndSales(fromDate, ToDate, "O");
                LoadOrderARAdvance(fromDate, ToDate, "O");
                SelSaleOrdCount(fromDate, ToDate, "O");
                SelectRotDeliveredCount(fromDate, ToDate, "O");
                SelOutstandingInvCount(fromDate, ToDate, "O");
                EnableResetButton();
            }
            catch(Exception ex)
            {

            }
        }

        protected void HeaderExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Image"))
                {
                    if (column.Display)
                    {
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            foreach (GridDataItem item in grvRpt.MasterTableView.Items)
            {
                if (item.Visible)
                {
                    DataRow dr = dt.NewRow();
                    int j = 0;
                    for (int i = 0; i < grvRpt.MasterTableView.Columns.Count; i++)
                    {
                        if (grvRpt.MasterTableView.Columns[i].Display)
                        {
                            if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")
                                && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;")
                                    ? item[grvRpt.MasterTableView.Columns[i].UniqueName].Text
                                    : " ";
                                j++;
                            }
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
            SpreadStreamProcessingForXLSXAndCSV(dt);
        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }
                        ExportHeaderRows(worksheetExporter, dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat
                                    {
                                        FontSize = 10,
                                        VerticalAlignment = SpreadVerticalAlignment.Center,
                                        HorizontalAlignment = SpreadHorizontalAlignment.Center
                                    };
                                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                                    {
                                        cellExporter.SetValue(item.ToString());
                                        cellExporter.SetFormat(normalFormat);
                                    }
                                }
                            }
                        }
                    }
                }

                byte[] output = stream.ToArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Customer Headers.xlsx");
                Response.BinaryWrite(output);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();  
            }
        }
        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat
                {
                    IsBold = true,
                    Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128)),
                    ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255)),
                    HorizontalAlignment = SpreadHorizontalAlignment.Center,
                    VerticalAlignment = SpreadVerticalAlignment.Center
                };

                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                    {
                        cellExporter.SetFormat(format);
                        cellExporter.SetValue(dt.Columns[i].ColumnName);
                    }
                }
            }
        }
        protected void OutletExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            foreach (GridColumn column in RadGrid1.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Image"))
                {
                    if (column.Display)
                    {
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
            {
                if (item.Visible)
                {
                    DataRow dr = dt.NewRow();
                    int j = 0;
                    for (int i = 0; i < RadGrid1.MasterTableView.Columns.Count; i++)
                    {
                        if (RadGrid1.MasterTableView.Columns[i].Display)
                        {
                            if (!item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")
                                && !RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = !item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;")
                                    ? item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text
                                    : " ";
                                j++;
                            }
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
            SpreadStreamProcessingForXLSXAndCSVOutlet(dt);
        }
        private void SpreadStreamProcessingForXLSXAndCSVOutlet(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }
                        ExportHeaderRowsOutlet(worksheetExporter, dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat
                                    {
                                        FontSize = 10,
                                        VerticalAlignment = SpreadVerticalAlignment.Center,
                                        HorizontalAlignment = SpreadHorizontalAlignment.Center
                                    };
                                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                                    {
                                        cellExporter.SetValue(item.ToString());
                                        cellExporter.SetFormat(normalFormat);
                                    }
                                }
                            }
                        }
                    }
                }

                byte[] output = stream.ToArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Customer Outlets.xlsx");
                Response.BinaryWrite(output);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }
        private void ExportHeaderRowsOutlet(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat
                {
                    IsBold = true,
                    Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128)),
                    ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255)),
                    HorizontalAlignment = SpreadHorizontalAlignment.Center,
                    VerticalAlignment = SpreadVerticalAlignment.Center
                };

                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                    {
                        cellExporter.SetFormat(format);
                        cellExporter.SetValue(dt.Columns[i].ColumnName);
                    }
                }
            }
        }
    }
}