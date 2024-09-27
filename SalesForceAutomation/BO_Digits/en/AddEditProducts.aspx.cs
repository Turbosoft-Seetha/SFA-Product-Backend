//using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
//using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditProducts : System.Web.UI.Page
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
                ViewState["upc"] = "";
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

                        string pname, pcode, pcat, psubcat, pbrd, rtndays, itemlong, arabicName, arabicItemlong, Status, itmSalHold,itmRtnHold,itmOrdHold, prdType, prdChargable,rtnreqhold, EnableRb;                                          //Declare the variables
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
                        itmSalHold = lstDatas.Rows[0]["prd_isSalesHold"].ToString();
                        itmRtnHold = lstDatas.Rows[0]["prd_isReturnHold"].ToString();
                        itmOrdHold = lstDatas.Rows[0]["prd_isOrderHold"].ToString();
                       
                        prdType = lstDatas.Rows[0]["prd_Type"].ToString();
						prdChargable = lstDatas.Rows[0]["prd_Chargable"].ToString();
                        rtnreqhold = lstDatas.Rows[0]["prd_EnableReturnReqHold"].ToString();
                        EnableRb= lstDatas.Rows[0]["prd_EnableRb"].ToString();


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
                        ddlSalHold.SelectedValue = itmSalHold.ToString();
                        ddlRtnHold.SelectedValue = itmRtnHold.ToString();
                        ddlOrdHold.SelectedValue = itmOrdHold.ToString();
                        txtCode.Enabled = false;
						prd_Type.SelectedValue = prdType.ToString();
						ddprdChargable.SelectedValue = prdChargable.ToString();
                        ddlrtnreqhold.SelectedValue= rtnreqhold.ToString();
                        ddlEnableRb.SelectedValue= EnableRb.ToString();

                        if (prd_Type.SelectedValue == "FS")
						{
                            IsPrdChargable.Visible = true;
						}
						else
						{
                            IsPrdChargable.Visible = false;
						}


					}
                    else
                    {

                    }
                    DataTable dt = ob.loadList("GetUomCount", "sp_Masters_UOM", ResponseID.ToString());
                    Session["UOMCount"] = dt.Rows[0]["UOMCount"];
                }
                
            }
        }
        public void SaveData()
        {
            string pname, arabicName, pcode, pcat, psubcat, pbrd, rtndays, itemlong, Status, user, uom, stdprice, UPC, Default, arabicItemlong,itmSalHold, itmRtnHold, itmOrdHold, prdType, prdChargable,rtnreqhold, EnableRb;
            pname = txtPName.Text.ToString();
            arabicName = txtArabic.Text.ToString();
            pcode = txtCode.Text.ToString();
            pcat = ddlcatid.SelectedValue.ToString();
            psubcat = ddlsubcatid.SelectedValue.ToString();
            pbrd = ddlbrdid.SelectedValue.ToString();
            rtndays = txtrtndys.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            itemlong = txtitemlong.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            itmSalHold = ddlSalHold.SelectedValue.ToString();
            itmRtnHold = ddlRtnHold.SelectedValue.ToString();
            itmOrdHold = ddlOrdHold.SelectedValue.ToString();
            uom = ddlUom.SelectedValue.ToString();
            stdprice = txtStdPrice.Text.ToString();
            UPC = txtupc.Text.ToString();
            Default = ddlDefault.SelectedValue.ToString();
            arabicItemlong = txtARitemlong.Text.ToString();
			prdType= prd_Type.SelectedValue.ToString();
			prdChargable= ddprdChargable.SelectedValue.ToString();
            rtnreqhold=ddlrtnreqhold.SelectedValue.ToString();
            EnableRb= ddlEnableRb.SelectedValue.ToString();
            if (prd_Type.SelectedValue == "FS")
			{
				ddprdChargable.Visible = true;
			}
			else
			{
				ddprdChargable.Visible = false;
		
			}

			if (ResponseID.Equals("0") || ResponseID == 0)
            {
                if (psubcat.Equals("0"))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
                else
                {
                    if((int)ViewState["RES"] > 0)
                    {

                    
                    string[] arr = { pcode, pcat, psubcat, pbrd, rtndays, user, itemlong, Status, arabicName, arabicItemlong,itmSalHold,itmRtnHold,itmOrdHold , prdType , prdChargable,rtnreqhold, EnableRb };
                    string Value = ob.SaveData("sp_Masters_UOM", "InsertProducts", pname, arr);
                    int res = Int32.Parse(Value.ToString());
                    ViewState["pid"] = res.ToString();
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Product has been saved sucessfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

                    }
                }
            }
            else
            {
                if (psubcat.Equals("0"))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
                else

                {
                    
                    string ID = ResponseID.ToString();
                    string[] arr = { pcode, pcat, psubcat, pbrd, rtndays, user, itemlong, Status, arabicName, arabicItemlong, ID,itmSalHold,itmRtnHold,itmOrdHold, prdType , prdChargable, rtnreqhold , EnableRb };
                    string value = ob.SaveData("sp_Masters_UOM", "UpdateProducts", pname, arr);
                    int res = Int32.Parse(value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Product has been updated sucessfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }


                }

            }

        }
        public void SaveDat()

        {
            string stdprice, UPC, Default, ID, uom,saleshold,rtnprice, prdType, prdChargable;
            uom = ddlUom.SelectedValue.ToString();
            stdprice = txtStdPrice.Text.ToString();
            UPC = txtupc.Text.ToString();
            Default = ddlDefault.SelectedValue.ToString();
            ID = ResponseID.ToString();
            saleshold = ddlsaleshold.SelectedValue.ToString();
            rtnprice = txtrtnPrice.Text.ToString();
			prdType = prd_Type.SelectedValue.ToString();
			prdChargable= ddprdChargable.SelectedValue.ToString();
            string[] arr = { stdprice, UPC, Default, ID, saleshold, rtnprice, prdType, prdChargable };
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
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProducts.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (prd_Type.SelectedValue.ToString() == "FS")
            {
                if ((int)Session["UOMCount"] >= 1)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                   "tmp", "<script type='text/javascript'>failedModal('For Field Service Products, You can add only one UOM');</script>", false);
                    return;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confm();</script>", false);
            }
                
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
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pru_ID").ToString();
                Response.Redirect("AddEditProductUOM.aspx?uomID=" + ID+"&&Id="+ResponseID.ToString());
            }
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pru_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void BtnConfim_Click(object sender, EventArgs e)
        {
            if (ViewState["upc"].Equals("Exists"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UPC();</script>", false);

            }
            else
            {

                SaveDat();
                LoadData();
                grvRpt.DataBind();
            }
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
                lnkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                lnkSave.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }

        protected void ddlbrdid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

      
        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                RadGrid grvpt1 = (RadGrid)sender;
                string EDStatus = item["EndDayStatus"].Text.ToString();



                if (EDStatus.Equals("0"))
                {
                    item["Edit"].Visible = true;
                    grvpt1.MasterTableView.GetColumnSafe("Edit").Visible = true;
                }
                else
                {
                    item["Edit"].Visible = true;
                    grvpt1.MasterTableView.GetColumnSafe("Edit").Visible = true;
                }
                


            }
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            

        }

        protected void txtupc_TextChanged(object sender, EventArgs e)
        {
            string[] arr = { ResponseID.ToString() };
            DataTable lstDatas = default(DataTable);
            lstDatas = ob.loadList("UOMExistCheck", "sp_Masters_UOM", txtupc.Text,arr);
            if (lstDatas.Rows.Count > 0)
            {
                ViewState["upc"] = "Exists";
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UPC();</script>", false);
            
            }
            else
            {
                ViewState["upc"] = "NotExists";
            }
        }
		protected void prd_Type_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
		{

			string selectedProductType = e.Value;

			if (selectedProductType == "FS")
			{

                int UOMCount = (int)Session["UOMCount"];
                if (UOMCount > 1) 
                { 

                    prd_Type.SelectedValue = "N";
                    prd_Type.SelectedText = "NORMAL";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                   "tmp", "<script type='text/javascript'>failedModal('For Field Service Products, You can add only one UOM');</script>", false);
                    return;
                }
                else
                {
                    ddprdChargable.SelectedValue = "N";
                    IsPrdChargable.Visible = true;
                    ddprdChargable.Visible = true;
                    ddprdChargable.Enabled = true;
                }
               

			}
			else
			{

                IsPrdChargable.Visible = false;
				ddprdChargable.Visible = false;
				//	ddprdChargable.Enabled = false;
				ddprdChargable.SelectedValue = "N";

			}

		}

	}
}