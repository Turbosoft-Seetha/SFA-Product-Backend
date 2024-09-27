using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.Design;
using Telerik.Web.UI;
using Telerik.Web.UI.HtmlChart;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class FieldServiceDetail : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    HeaderData();
                    LoadList();
                }
                catch(Exception ex)
                {

                }
            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectTodayServiceJobHeaderById", "sp_ServiceDashboard", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblNumber = (Label)rp.FindControl("lblNumber");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblStatus = (Label)rp.FindControl("lblStatus");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["CustomerName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["RouteName"].ToString();
                lblNumber.Text = lstDatas.Rows[0]["sjh_Number"].ToString();
                lblDate.Text = lstDatas.Rows[0]["SchDate"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        public void LoadList()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectServiceJobDetail", "sp_ServiceDashboard", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
            grvRpt.DataBind();
        }
    }
}