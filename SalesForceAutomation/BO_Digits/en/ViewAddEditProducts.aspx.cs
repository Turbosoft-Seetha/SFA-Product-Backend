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
    public partial class ViewAddEditProducts : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                brand();
                category();
                Uom();



                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")
                {
                    pnlUOM.Visible = false;
                }
                else
                {
                    pnlUOM.Visible = true;
                    DataTable lstDatas = ob.loadList("EditProducts", "sp_Masters_UOM", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {

                        string pname, pcode, pcat, psubcat, pbrd, rtndays, itemlong, arabicName, arabicItemlong, Status;                                          //Declare the variables
                        pname = lstDatas.Rows[0]["prd_Name"].ToString();
                        pcode = lstDatas.Rows[0]["prd_Code"].ToString();
                        arabicName = lstDatas.Rows[0]["prd_NameArabic"].ToString();
                        pcat = lstDatas.Rows[0]["prd_cat_ID"].ToString();
                        subcategory(pcat);
                        psubcat = lstDatas.Rows[0]["prd_sct_ID"].ToString();
                        pbrd = lstDatas.Rows[0]["prd_brd_ID"].ToString();
                        rtndays = lstDatas.Rows[0]["prd_ReturnDays"].ToString();
                        itemlong = lstDatas.Rows[0]["prd_ItemLongDesc"].ToString();
                        arabicItemlong = lstDatas.Rows[0]["prd_ArabicItemLongDesc"].ToString();
                        Status = lstDatas.Rows[0]["Status"].ToString();

                        txtPName.Text = pname.ToString();
                        txtArabic.Text = arabicName.ToString();
                        txtCode.Text = pcode.ToString();
                        ddlcatid.SelectedValue = pcat.ToString();
                        ddlsubcatid.SelectedValue = psubcat.ToString();
                        ddlbrdid.SelectedValue = pbrd.ToString();
                        txtrtndys.Text = rtndays.ToString();
                        txtitemlong.Text = itemlong.ToString();
                        txtARitemlong.Text = arabicItemlong.ToString();
                        ddlStat.SelectedValue = Status.ToString();
                        txtCode.Enabled = false;
                    }
                    else
                    {

                    }
                }
            }
        }
       
        public void SaveDat()

        {
            string stdprice, UPC, Default, ID, uom, saleshold, rtnprice;
            uom = ddlUom.SelectedValue.ToString();
            stdprice = txtStdPrice.Text.ToString();
            UPC = txtupc.Text.ToString();
            Default = ddlDefault.SelectedValue.ToString();
            ID = ResponseID.ToString();
            saleshold = ddlsaleshold.SelectedValue.ToString();
            rtnprice = txtrtnPrice.Text.ToString();
            string[] arr = { stdprice, UPC, Default, ID, saleshold, rtnprice };
            string value = ob.SaveData("sp_Masters_UOM", "InsertUOM", uom, arr);
            int res = Int32.Parse(value.ToString());
            ViewState["RES"] = res;
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succces('Uom has been added sucessfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }
        public void category()
        {
            DataTable dt = ob.loadList("SelectCatFromDrop", "sp_Masters");
            ddlcatid.DataSource = dt;
            ddlcatid.DataTextField = "cat_Name";
            ddlcatid.DataValueField = "cat_ID";
            ddlcatid.DataBind();
        }
        public void subcategory(string cat)
        {

            DataTable ds = ob.loadList("SelectsubCatFromDrop", "sp_Masters", cat);
            ddlsubcatid.DataSource = ds;
            ddlsubcatid.DataTextField = "sct_Name";
            ddlsubcatid.DataValueField = "sct_ID";
            ddlsubcatid.DataBind();
            ViewState["dd"] = ds;
        }
        public void brand()
        {
            DataTable dt = ob.loadList("SelectbrdFromDrop", "sp_Masters");
            ddlbrdid.DataSource = dt;
            ddlbrdid.DataTextField = "brd_Name";
            ddlbrdid.DataValueField = "brd_ID";
            ddlbrdid.DataBind();
        }
        public void Uom()
        {
            string ID = ResponseID.ToString();
            DataTable dt = ob.loadList("SelectUomFromDrop", "sp_Masters_UOM", ID);
            ddlUom.DataSource = dt;
            ddlUom.DataTextField = "uom_Name";
            ddlUom.DataValueField = "uom_ID";
            ddlUom.DataBind();
        }
        

       
        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confm();</script>", false);
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            string pid = ResponseID.ToString();
            DataTable lstDatas = default(DataTable);
            lstDatas = ob.loadList("ListUomProducts", "sp_Masters_UOM", pid);
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                //pnls.Visible = true;
            }
            else
            {
                // pnls.Visible = false;
            }
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pru_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

       

        protected void BtnConfim_Click(object sender, EventArgs e)
        {
            SaveDat();
            LoadData();
            grvRpt.DataBind();
        }

        protected void Okbtn_Click(object sender, EventArgs e)
        {
            string ID;
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                ID = ViewState["pid"].ToString();
            }
            else
            {
                ID = ResponseID.ToString();
            }

            Response.Redirect("AddEditProducts.aspx?Id=" + ID);

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string ID;
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                ID = ViewState["pid"].ToString();
            }
            else
            {
                ID = ResponseID.ToString();
                Response.Redirect("ListProducts.aspx");
            }

            Response.Redirect("AddEditProducts.aspx?Id=" + ID);

        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteItemUom", "sp_Masters_UOM", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void ddlcatid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string cat = ddlcatid.SelectedValue.ToString();
            ddlsubcatid.DataSource = "";
            ddlsubcatid.DataBind();
            subcategory(cat);
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = ob.loadList("CheckProductCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                
                lblCodeDupli.Visible = true;
            }
            else
            {
               
                lblCodeDupli.Visible = false;
            }
        }

        protected void ddlbrdid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}