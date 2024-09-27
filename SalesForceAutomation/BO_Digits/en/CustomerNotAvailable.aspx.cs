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
    public partial class CustomerNotAvailable : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }
        public string mainConditions(string rotID)
        {


            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(Session["FromDate"].ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(Session["ToDate"].ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;

            return mainCondition;
        }

        public void ListData()
        {
            string mainCondition = mainConditions(Session["Route"].ToString());
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerNotAvailable", "sp_Merch_Dashboard", mainCondition);
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("iah_ID").ToString();
                Response.Redirect("CustomerNotAvailableDetail.aspx?Id=" + ID);
            }
        }
    }
}