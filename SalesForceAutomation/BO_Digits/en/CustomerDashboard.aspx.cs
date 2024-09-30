using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Telerik.Web.UI;
using System.IO;
using System.Xml;
using Telerik.Web.UI.Chat;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {

        }

        public void LoadHeaders()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCustomerHeaders", "sp_Dashboard");
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
        }

        public void LoadOutlets()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCustomerOutlets", "sp_Masters");
            if (lstUser.Rows.Count > 0)
            {
                RadGrid1.DataSource = lstUser;
            }
            else
            {
                RadGrid1.DataSource = new DataTable();
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadHeaders();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadOutlets();
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void totalInvoices_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=INV");
        }

        protected void lnkSales_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            Session["Route"] = null;
            Response.Redirect("SalesHeader.aspx?mode=1&&type=SL");
        }

        protected void lnkGRReturns_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=GR");
        }

        protected void lnkBRReturns_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=BR");
        }
        protected void lnkFreeGood_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesHeader.aspx?mode=1&&type=FG");
        }
    }
}