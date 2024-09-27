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
    public partial class ListCustomerProductsMapping : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            Route();
            CusRoute();
            ProMap();

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

        public int CusID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["cusID"], out ResponseID);
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
        {
            string[] arr = { RouteID.ToString() };
            DataTable lstdata = obj.loadList("SelCustomerProductMappingGroup", "sp_Merchandising", CusID.ToString(), arr);
            if (lstdata.Rows.Count > 0)
            {
                
                ViewState["flag"] = 1;
                string pmgid = lstdata.Rows[0]["cpm_pmg_ID"].ToString();
                string pmgname = lstdata.Rows[0]["pmg_Name"].ToString();
                string pmgCode = lstdata.Rows[0]["pmg_Code"].ToString();
                string date = lstdata.Rows[0]["CreatedDate"].ToString();
                string user = lstdata.Rows[0]["UserName"].ToString();
                RadPanelItem rp = RadPanelBar0.Items[0];
                rp.Text = "Product Mapping Group : " + pmgname ;
                Progrp.Text = "Product Mapping Code : " + pmgCode;
                lblDate.Text = date;
                lblUser.Text = user;
                ListProduct(pmgid);
            }
            else
            {
                ViewState["flag"] = 0;
            }



        }
        public void Route()
        {
            DataTable dt = obj.loadList("SelectRouteByID", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {

                string rotname = dt.Rows[0]["rot_Name"].ToString();
                cusroute.Text =  rotname;


            }

        }
        public void CusRoute()
        {
            DataTable dt = obj.loadList("CusRoute", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {

                string cusname = dt.Rows[0]["cus_Name"].ToString();
                custname.Text =  cusname;


            }

        }



        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void lnkAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCustomerProductsMapping.aspx?CID=" + ResponseID.ToString() + "&RID=" + RouteID.ToString());
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerRoute.aspx?RID=" + RouteID.ToString());
        }
        public void ListProduct(string pmgid)
        {

            DataTable dts = obj.loadList("SelProductByPgmID", "sp_Merchandising", pmgid);
            if (dts.Rows.Count > 0)
            {
                grvRpt.DataSource = dts;
                ViewState["isdetail"] = dts;

            }
        }
        public void ProMap()
        {
            string[] arr = { RouteID.ToString() };
            DataTable dt = obj.loadList("SelProductMappingGroupfordrop", "sp_Merchandising", ResponseID.ToString(), arr);
            rdPromapping.DataSource = dt;
            rdPromapping.DataTextField = "pmg_Name";
            rdPromapping.DataValueField = "pmg_ID";
            rdPromapping.DataBind();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string f = ViewState["flag"].ToString();
            string user = UICommon.GetCurrentUserID().ToString();
            if (f.Equals("1"))
            {
                string[] arr = { RouteID.ToString(), rdPromapping.SelectedValue.ToString(), user.ToString() };
                string value = obj.SaveData("sp_Merchandising", "UpdateCustomerProductsMapping", CusID.ToString(), arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string[] arr = { RouteID.ToString(), rdPromapping.SelectedValue.ToString(), user.ToString() };
                string value = obj.SaveData("sp_Merchandising", "InsertCustomerProductsMapping", CusID.ToString(), arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void rdPromapping_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string pmg = rdPromapping.SelectedValue.ToString();
            ListProduct(pmg);
            grvRpt.Rebind();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void Proceedmap_Click(object sender, EventArgs e)
        {
            string CustID = CusID.ToString();
            Response.Redirect("CustomerSpecialPriceHeader.aspx?cid=" + CustID);           
        }

        protected void lnkGotoCus_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");
        }
    }
}