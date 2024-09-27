using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation
{
    public partial class AddCustomerProductsMapping : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                ProMap();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["CID"], out ResponseID);
                return ResponseID;
            }
        }
        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RID"], out RouteID);
                return RouteID;
            }
        }
        public void ProMap()
        {
            string[] arr = { RouteID.ToString() };
            DataTable dt = Obj.loadList("SelProductMappingGroupfordrop", "sp_Merchandising", ResponseID.ToString(), arr);
            Pgm.DataSource = dt;
            Pgm.DataTextField = "pmg_Name";
            Pgm.DataValueField = "pmg_ID";
            Pgm.DataBind();
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {

        }

        protected void Pgm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            ListProduct();


        }
        public void ListProduct()
        {
            
            DataTable dts = Obj.loadList("SelProductByPgmID", "sp_Merchandising",Pgm.SelectedValue.ToString());
            if (dts.Rows.Count>0)
            { 
            grvRpt.DataSource = dts;
            }
        }
        protected void ADD_Click(object sender, EventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListProduct();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }
    }
}