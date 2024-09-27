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
    public partial class ListCoupon : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCoupon", "sp_CouponCollection");
            grvRpt.DataSource = lstUser;
        }

      

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cpm_ID").ToString();
                Response.Redirect("AddEditCoupon.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("ProAssigned"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cpm_ID").ToString();
                Response.Redirect("ListCouponProduct.aspx?Id=" + ID);
            }
        }

        protected void LnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditCoupon.aspx?Id=0");
        }
    }
}