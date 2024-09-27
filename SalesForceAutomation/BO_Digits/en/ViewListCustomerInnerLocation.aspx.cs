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
    public partial class ViewListCustomerInnerLocation : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["CId"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Customer();
            }

        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = obj.loadList("SelInnerLocation", "sp_Masters", ResponseID.ToString());
            if(lstUser.Rows.Count >= 0)
            {

            grvRpt.DataSource = lstUser;
            }
        }
        public void Customer()
        {
            DataTable lstUser = default(DataTable);
            lstUser = obj.loadList("SelectCustomerName", "sp_Merchandising", ResponseID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                string name = lstUser.Rows[0]["cus_Name"].ToString();
                ltrlCustomer.Text = name.ToString();
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}