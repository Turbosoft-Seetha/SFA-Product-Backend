using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditCusRouteProducts : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdEndDate.MinDate = DateTime.Now;
                rdFromData.MinDate = DateTime.Now;
                Product();
                Route();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
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
        public void Product()
        {
            DataTable dt = ob.loadList("PriceListHeaderwithoutRoute", "sp_Masters", ResponseID.ToString());
            ddlprh.DataSource = dt;
            ddlprh.DataTextField = "prh_Name";
            ddlprh.DataValueField = "prh_ID";
            ddlprh.DataBind();
        }
        public void Route()
        {
            DataTable dt = ob.loadList("Route", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {
                string rotname, fromdate, todate;  //
                rotname = dt.Rows[0]["rot_Name"].ToString();
                //fromdate = dt.Rows[0]["crp_StartDate"].ToString();
                //todate = dt.Rows[0]["crp_EndDate"].ToString();
                //rdFromData.SelectedDate = DateTime.Parse(fromdate.ToString());
                //rdEndDate.SelectedDate = DateTime.Parse(todate.ToString());
                Proroute.Text = "Route Name : " + rotname;


            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCusRouteProducts.aspx?ID="+ResponseID.ToString()+"&RID="+RouteID.ToString());
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }
        public void SaveData()
        {
            string prh;
            
            string dates = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");


            prh = ddlprh.SelectedValue.ToString();

            string[] arr = { dates, date ,ResponseID.ToString() };
            string Value = ob.SaveData("sp_Masters", "AddCusRouteProduct", prh, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Product Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCusRouteProducts.aspx?CID=" + ResponseID.ToString() + "&RID=" + RouteID.ToString());
        }

        protected void ddlpro_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //DataTable dt = ob.loadList("Productcode", "sp_Masters", ddlpro.SelectedValue.ToString());
            //if (dt.Rows.Count > 0)
            //{
            //    txtCode.Text = dt.Rows[0]["prd_Code"].ToString();
            //}
            //DataTable dtt = ob.loadList("selpricelistheader", "sp_Masters", ddlpro.SelectedValue.ToString());
            //ddlprh.DataSource = dtt;
            //ddlprh.DataTextField = "prh_Name";
            //ddlprh.DataValueField = "prh_ID";
            //ddlprh.DataBind();
        }
    }
}