using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class DailyTranDetModes : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }

        public int HID
        {
            get
            {
                int HID;
                int.TryParse(Request.Params["HID"], out HID);
                return HID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {

        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", HID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["routeName"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
            }
        }

        

        public void GetData()
        {
            string mode = Request.Params["mode"].ToString();
            lblType.Text = mode;
            string proc = "";
            if (mode.Equals("Invoice"))
            {
                proc = "SelSalesDetails";
            }
            else if (mode.Equals("Orders"))
            {
                proc = "SelOrderDetails";
            }
            else if (mode.Equals("Inventory"))
            {
                proc = "";
            }
            else if (mode.Equals("AR"))
            {
                proc = "SelARDetails";
            }
            else if (mode.Equals("AP"))
            {
                proc = "SelAPDetails";
            }
            DataSet lstDatas = new DataSet();
            string[] arr = { HID.ToString() };
            lstDatas = ObjclsFrms.loadList(proc, "sp_DailyReports", ResponseID.ToString(), arr,true);
            grvheader.DataSource = lstDatas.Tables[0];   
            grvheader.DataBind();
            if (lstDatas.Tables.Count > 1)
            {
                grvRpt.DataSource = lstDatas.Tables[1];
            }
        }


        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            GetData();
        }

       

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;

            radgrid2.MasterTableView.GetColumnSafe("id").Visible = false;
        }

        protected void grvheader_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            
        }
    }
}