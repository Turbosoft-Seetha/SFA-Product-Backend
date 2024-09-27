using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerNotAvailableDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectCustomerNotAvailableHeader", "sp_Merch_Dashboard", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                //Label lblTime = (Label)rp.FindControl("lblTime");

                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
                //lblTime.Text = lstDatas.Rows[0]["dph_Time"].ToString();
            }
        }
        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }
        public void ListData()
        {
            string fromdate, todate;
            fromdate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
            todate = DateTime.Parse(Session["ToDate"].ToString()).ToString("yyyyMMdd");
            string[] arr = { fromdate, todate };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerNotAvailableDetail", "sp_Merch_Dashboard", ResponseID.ToString(), arr);
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
    }
}