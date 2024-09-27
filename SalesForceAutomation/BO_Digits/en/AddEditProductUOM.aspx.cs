using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;
using Telerik.Pdf;
using System.Data;
using Telerik.Web.UI.Chat;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditProductUOM : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Uom();
                FillForm();

            }

        }
        public int uomID
        {
            get
            {
                int uomID;
                int.TryParse(Request.Params["uomID"], out uomID);

                return uomID;
            }
        }
        public int prdID
        {
            get
            {
                int prdID;
                int.TryParse(Request.Params["Id"], out prdID);

                return prdID;
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("EditUOMs", "sp_Masters_UOM", uomID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];

                rp.Text = "Product: " + lstDatas.Rows[0]["prd_Name"].ToString();
                string uom, price, upc, rtnprice, isdefault, issaleshols;
                uom = lstDatas.Rows[0]["pru_uom_ID"].ToString();
                price = lstDatas.Rows[0]["pru_Price"].ToString();
                upc = lstDatas.Rows[0]["pru_UPC"].ToString();
                rtnprice = lstDatas.Rows[0]["pru_ReturnPrice"].ToString();
                isdefault = lstDatas.Rows[0]["pru_IsDefault"].ToString();
                issaleshols = lstDatas.Rows[0]["isSalesHold"].ToString();
               
               
                ddlUom.SelectedValue = uom.ToString();
                txtStdPrice.Text = price.ToString();
                txtupc.Text = upc.ToString();
                txtrtnPrice.Text = rtnprice.ToString();
                ddlDefault.SelectedValue = isdefault.ToString();
                ddlsaleshold.SelectedValue = issaleshols.ToString();
                
                
            }
        }
        public void SaveData()

        {
            string stdprice, Default, ID, saleshold, rtnprice,user;
            
            stdprice = txtStdPrice.Text.ToString();
            
            Default = ddlDefault.SelectedValue.ToString();
            ID = uomID.ToString();
            saleshold = ddlsaleshold.SelectedValue.ToString();
            rtnprice = txtrtnPrice.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = {  Default, ID, saleshold, rtnprice,user };
            string value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdateUOM", stdprice, arr);
            int res = Int32.Parse(value.ToString());
           
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succces('Uom has been updated sucessfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }
        public void Uom()
        {
            string ID = prdID.ToString();
            DataTable dt = ObjclsFrms.loadList("SelectUomForEdit", "sp_Masters_UOM", ID);
            ddlUom.DataSource = dt;
            ddlUom.DataTextField = "uom_Name";
            ddlUom.DataValueField = "uom_ID";
            ddlUom.DataBind();
        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditProducts.aspx?Id=" + prdID);
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void BtnConfim_Click(object sender, EventArgs e)
        {

        }

        protected void Okbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditProducts.aspx?ID=" + prdID);
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {

        }
    }
}