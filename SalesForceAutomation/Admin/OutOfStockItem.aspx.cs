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
    public partial class OutOfStockItem : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int DetailID
        {
            get
            {
                int DetailID;
                int.TryParse(Request.Params["ID"], out DetailID);

                return DetailID;
            }
        }
        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["HID"], out HeaderID);

                return HeaderID;
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
            lstDatas = ObjclsFrms.loadList("SelectOutOfStockDetailHeader", "sp_Transaction", HeaderID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblBrand = (Label)rp.FindControl("lblBrand");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblTime = (Label)rp.FindControl("lblTime");
                Label lblCompletedDate = (Label)rp.FindControl("lblCompletedDate");
                Label lblMandatory = (Label)rp.FindControl("lblMandatory");
                Label lblLocation = (Label)rp.FindControl("lblLocation");
                Label lblType = (Label)rp.FindControl("lblType");

                lblBrand.Text = lstDatas.Rows[0]["brd_Name"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
                lblCompletedDate.Text = lstDatas.Rows[0]["CompletedDate"].ToString();
                lblTime.Text = lstDatas.Rows[0]["dph_Time"].ToString();
                lblMandatory.Text = lstDatas.Rows[0]["inl_IsMandatory"].ToString();
                lblLocation.Text = lstDatas.Rows[0]["inl_Name"].ToString();
                lblType.Text = lstDatas.Rows[0]["inl_Type"].ToString();
            }
        }

        public void Data()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelectOutOfStockItem", "sp_Transaction", DetailID.ToString());
            grvRpt.DataSource = lstdata;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Data();
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}