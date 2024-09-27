using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListCusRouteProducts : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                
                rdFromData.SelectedDate = DateTime.Now;
                rdEndDate.SelectedDate = DateTime.Now;
                rdEndDate.MinDate = DateTime.Now;
                rdFromData.MinDate = DateTime.Now;
                Pricelist();
                Route();
                CusRoute();
                List();
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

        public void List()
        {     DataTable lstdata = obj.loadList("ListCusRouteProduct", "sp_Masters_UOM", ResponseID.ToString());
            if (lstdata.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstdata;
            }
        }
        public void Route()
        {
            DataTable dt = obj.loadList("RotName", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {

                string rotname = dt.Rows[0]["rot_Name"].ToString();
                cusroute.Text = "Route Name : " + rotname;


            }

        }
        public void CusRoute()
        {
            DataTable dt = obj.loadList("CusRoute", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {

                string cusname = dt.Rows[0]["cus_Name"].ToString();
                Cusname.Text = "Customer Name : " + cusname;


            }

        }
        public void Pricelist()
        {
            DataTable dt = obj.loadList("PriceListHeaderwithoutRoute", "sp_Masters", ResponseID.ToString());
            ddlprh.DataSource = dt;
            ddlprh.DataTextField = "prh_Name";
            ddlprh.DataValueField = "prh_ID";
            ddlprh.DataBind();
        }
        public void SaveData()
        {
            string prh;

            string dates = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");

            prh = ddlprh.SelectedValue.ToString();

            string[] arr = { dates, date, ResponseID.ToString() };
            string Value = obj.SaveData("sp_Masters", "AddCusRouteProduct", prh, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Special Price Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

            if (e.CommandName.Equals("Edit"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
            {                                                                           //If it matched the following code will be executed
                GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                string ID = dataItem.GetDataKeyValue("crp_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("AddEditCusRouteProducts.aspx?Id=" + ID);                         //With the ID we can redirect to the add page to edit and update the value.
            }
            if (e.CommandName.Equals("Detail"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
            {                                                                           //If it matched the following code will be executed
                GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                string crpID = dataItem.GetDataKeyValue("crp_ID").ToString();              //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                Response.Redirect("ListCusRouteProductsDetail.aspx?crpId=" + crpID+"&RID="+ RouteID.ToString()+"&ID="+ ResponseID.ToString());                         //With the ID we can redirect to the add page to edit and update the value.
            }
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crp_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCusRouteProducts.aspx?CID=" + ResponseID.ToString() + "&RID=" + RouteID.ToString());
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeletecusrouteProducts", "sp_Masters", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void BtnDelConfrm_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

       
    }
}