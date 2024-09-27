using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class DailyActivityDetails : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int CseID
        {
            get
            {
                int CseID;
                int.TryParse(Request.Params["cse_ID"], out CseID);

                return CseID;
            }
        }
        public int UdpID
        {
            get
            {
                int UdpID;
                int.TryParse(Request.Params["udp_ID"], out UdpID);

                return UdpID;
            }
        }
        public string mode
        {
            get
            {
                string mode;
                mode = Request.Params["mode"];
                if (mode == null)
                {
                    mode = "";
                    return mode;
                }
                else
                {
                    return mode;
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                RadWizard1.NavigationBarPosition = (RadWizardNavigationBarPosition)Enum.Parse(typeof(RadWizardNavigationBarPosition), "Left");
                RadWizard1.ProgressBarPosition = (RadWizardProgressBarPosition)Enum.Parse(typeof(RadWizardProgressBarPosition), "Left");
                DetailHeaderInfo();

                if (mode=="1")
                {
                    RadWizard1.ActiveStepIndex = 0;
                }
                else if (mode == "2")
                {
                    RadWizard1.ActiveStepIndex = 1;
                }
                else if (mode == "3")
                {
                    RadWizard1.ActiveStepIndex = 2;
                }
                else if (mode == "4")
                {
                    RadWizard1.ActiveStepIndex = 3;
                }
                else if (mode == "5")
                {
                    RadWizard1.ActiveStepIndex = 4;
                }
                else if (mode == "6")
                {
                    RadWizard1.ActiveStepIndex = 5;
                }
                else
                {
                    RadWizard1.ActiveStepIndex = 0;
                }
            }

        }
        public void DetailHeaderInfo()
        {


            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("DetailHeaderInfo", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                lblCustomer.Text= lstUser.Rows[0]["Customer"].ToString();


                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");

                lblRoute.Text= lstUser.Rows[0]["Route"].ToString();
                lblStartTime.Text = lstUser.Rows[0]["cse_StartTime"].ToString();
                lblEndTime.Text = lstUser.Rows[0]["cse_Endime"].ToString();
                
            }


        }

        
        public void CashInvoicesList()
        {
            

            DataTable lstUser = default(DataTable);

            string[] arr = {CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListCashInvoices", "sp_Report", UdpID.ToString(), arr);
            if(lstUser.Rows.Count>0)
            {
                CashInvoiceGrid.DataSource = lstUser;
            }
           
        }

        public void CreditInvoicesList()
        {


            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListCreditInvoices", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                CreditInvoiceGrid.DataSource = lstUser;
            }
           
        }
        public void CreditReturnInvoicesList()
        {


            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListCreditReturnInvoices", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                CreditReturnGrid.DataSource = lstUser;
            }
           
        }
        public void CashReturnInvoicesList()
        {


            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListCashReturnInvoices", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                CashReturnGrid.DataSource = lstUser;
            }
            
        }

        public void ARCashCollectionList()
        {


            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListARCashCollection", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                CashCollectionGrid.DataSource = lstUser;
            }
            
        }
        public void ARChequeCollectionList()
        {

            DataTable lstUser = default(DataTable);

            string[] arr = { CseID.ToString() };
            lstUser = ObjclsFrms.loadList("ListARChequeCollection", "sp_Report", UdpID.ToString(), arr);
            if (lstUser.Rows.Count > 0)
            {
                ChequeCollectionGrid.DataSource = lstUser;
            }
          
        }
       

        protected void CashInvoiceGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            CashInvoicesList();
        }

        protected void CreditInvoiceGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            CreditInvoicesList();
        }

        protected void CreditReturnGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            CreditReturnInvoicesList();
        }

        protected void CashCollectionGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ARCashCollectionList();
        }

        protected void ChequeCollectionGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ARChequeCollectionList();
        }

        protected void CashReturnGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            CashReturnInvoicesList();
        }

        protected void CashInvoiceGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string Type = "";
                OpenNewBrowserWindow("SalesDetails.aspx?Id=" + ID + "&&Type="+Type, this);
            }
        }

        protected void CreditInvoiceGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string Type = "";
                OpenNewBrowserWindow("SalesDetails.aspx?Id=" + ID + "&&Type=" + Type, this);
            }
        }

        protected void CashReturnGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string Type = "";
                OpenNewBrowserWindow("SalesDetails.aspx?Id=" + ID + "&&Type=" + Type, this);
            }
        }

        protected void CreditReturnGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string Type = "";
                OpenNewBrowserWindow("SalesDetails.aspx?Id=" + ID + "&&Type=" + Type, this);
            }

        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        protected void CashCollectionGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string PayType = e.CommandArgument.ToString();
                OpenNewBrowserWindow("ARDetail.aspx?Id=" + ID + "&&mode=" + PayType,this);
            }
        }

        protected void ChequeCollectionGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sal_ID").ToString();
                string PayType = e.CommandArgument.ToString();
                OpenNewBrowserWindow("ARDetail.aspx?Id=" + ID + "&&mode=" + PayType, this);
            }
        }
    }
}