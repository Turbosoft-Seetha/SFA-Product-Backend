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
    public partial class DetailedUserDailyProcessDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["DId"], out ResponseID);

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
            lstDatas = ObjclsFrms.loadList("SelDailyCustomerOperHeader", "sp_Merchandising", Request.Params["Id"].ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["customer"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        public void LoadList()
        {
            DataTable lstData = default(DataTable);
            lstData = ObjclsFrms.loadList("SelectDailyCustomerOperations", "sp_Merchandising", Request.Params["Id"].ToString());
            grvRpt.DataSource = lstData;
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserDailyProcessDetail.aspx?Id" + ResponseID.ToString());
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            string alternateText = (sender as ImageButton).AlternateText;
            if (grvRpt.MasterTableView.Items.Count > 0)
            {
                //grvRpt.MasterTableView.GetColumn("EditColumn").Visible = false;
                foreach (GridColumn gridColumn in grvRpt.Columns)
                {
                    //gridColumn.HeaderText = gridColumn.HeaderText.Replace("<br/>", " ");
                    gridColumn.HeaderStyle.Font.Bold = true;
                    gridColumn.HeaderStyle.Font.Size = 12;

                }
                grvRpt.ExportSettings.Excel.Format = (GridExcelExportFormat)Enum.Parse(typeof(GridExcelExportFormat), alternateText);
                grvRpt.ExportSettings.IgnorePaging = true;
                grvRpt.ExportSettings.FileName = "Daily Customer Operations";
                grvRpt.ExportSettings.ExportOnlyData = true;
                grvRpt.ExportSettings.OpenInNewWindow = true;
                grvRpt.MasterTableView.ExportToExcel();
            }
        }
    }
}