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
    public partial class CustomerPromotionHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["cid"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerPromotionHeader", "sp_Web_Promotion", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
            DataTable lst = default(DataTable);
            lst = ObjclsFrms.loadList("CustomerBYid", "sp_Masters", ResponseID.ToString());
            lblcuscode.Text = lst.Rows[0]["cus_Code"].ToString();
            lblcustomer.Text = lst.Rows[0]["cus_Name"].ToString();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prm_ID").ToString();
                Response.Redirect("CustomerPromotionDetail.aspx?Id=" + ID + "&cid=" + ResponseID.ToString());
            }
        }
    }
}