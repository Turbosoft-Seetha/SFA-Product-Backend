using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddProducts : System.Web.UI.Page
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
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["Mode"], out Mode);
                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["upcdup"] = "";
                brand();
                category();
                Uom();
                ViewState["DataTable"] = null;
                try
                {


                    if (Mode == 1)
                    {
                        ViewState["DataTable"] = Session["DataTable"];
                        Uom();

                        string s = Session["pname"].ToString();
                        txtPName.Text = Session["pname"].ToString();
                        txtArabic.Text = Session["arabicName"].ToString();
                        txtCode.Text = Session["pcode"].ToString();
                        ddlcatid.SelectedValue = Session["pcat"].ToString();
                        subcategory(Session["pcat"].ToString());
                        ddlsubcatid.SelectedValue = Session["psubcat"].ToString();
                        ddlbrdid.SelectedValue = Session["pbrd"].ToString();
                        txtrtndys.Text = Session["rtndays"].ToString();
                        txtitemlong.Text = Session["itemlong"].ToString();
                        ddlStat.SelectedValue = Session["Status"].ToString();
                        txtARitemlong.Text = Session["arabicItemlong"].ToString();
                        ddlSalHold.SelectedValue = Session["SalesHold"].ToString();
                        ddlRtnHold.SelectedValue = Session["RtnHold"].ToString();
                        ddlOrdHold.SelectedValue = Session["OrdHold"].ToString();
                        prd_Type.SelectedValue = Session["prd_Type"].ToString();
                        ddprdChargable.SelectedValue = Session["prd_Chargable"].ToString();
                        ddlrtnreqhold.SelectedValue= Session["prd_EnableReturnReqHold"].ToString() ;
                        ddlEnableRb.SelectedValue=Session["prd_EnableRb"].ToString();
                        ddlIsBatchItem.SelectedValue = Session["prd_IsBatchItem"].ToString();
                        txtShortName.Text = Session["prd_ShortName"].ToString();

                        if (Session["prd_Type"].ToString() == "FS")
                        {
                            IsPrdChargable.Visible = true;
                        }
                    }
                    else
                    {
                        if( (Session["prd_Type"] == null) ||(Session["prd_Type"].ToString() == "N"))
                        {
                            IsPrdChargable.Visible = false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    UICommon.LogException(ex, "Add Product");
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ob.LogMessageToFile(UICommon.GetLogFileName(), "AddProducts.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                }


            }
        }
        public void SaveData()
        {
            string pname, arabicName, pcode, pcat, psubcat, pbrd, rtndays, itemlong, Status, SalesHold, user, arabicItemlong, 
                RtnHold, OrdHold, prdType, prdChargable,rtnreqhold,EnableRb, IsBatchItem, ShortName;
            pname = txtPName.Text.ToString();
            arabicName = txtArabic.Text.ToString();
            pcode = txtCode.Text.ToString();
            pcat = ddlcatid.SelectedValue.ToString();
            psubcat = ddlsubcatid.SelectedValue.ToString();
            pbrd = ddlbrdid.SelectedValue.ToString();
            //Session["brand"].ToString();

            rtndays = txtrtndys.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            itemlong = txtitemlong.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            SalesHold = ddlSalHold.SelectedValue.ToString();
            RtnHold = ddlRtnHold.SelectedValue.ToString();
            OrdHold = ddlOrdHold.SelectedValue.ToString();
            rtnreqhold = ddlrtnreqhold.SelectedValue.ToString();
            //stdprice = txtStdPrice.Text.ToString();
            //UPC = txtupc.Text.ToString();
            //Default = ddlDefault.SelectedValue.ToString();
            arabicItemlong = txtARitemlong.Text.ToString();
            prdType = prd_Type.SelectedValue.ToString();
            prdChargable = ddprdChargable.SelectedValue.ToString();
            EnableRb= ddlEnableRb.SelectedValue.ToString();
            IsBatchItem = ddlIsBatchItem.SelectedValue.ToString();
            ShortName = txtShortName.Text.ToString();

            if (prd_Type.SelectedValue == "FS")
            {
                ddprdChargable.Visible = true;
            }
            else
            {
                ddprdChargable.Visible = false;

            }

            //saleshold = ddlsaleshold.SelectedValue.ToString();

            if (psubcat.Equals("0"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
            else
            {
                string detail = GetItemFromGrid();


                string[] arr = { pcode, pcat, psubcat, pbrd, rtndays, user, itemlong, Status, arabicName, arabicItemlong, SalesHold, RtnHold, OrdHold, 
                    detail, prdType, prdChargable,rtnreqhold, EnableRb, IsBatchItem, ShortName };
                string Value = ob.SaveData("sp_Masters_UOM", "InsertProduct", pname, arr);
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
            string mainCondition = "";
            mainCondition = UOMCondition();
            DataTable dt = ob.loadList("SelectUomDrop", "sp_Masters", mainCondition);
            ddlUom.DataSource = dt;
            ddlUom.DataTextField = "uom_Name";
            ddlUom.DataValueField = "uom_ID";
            ddlUom.DataBind();
        }
        public string Item()
        {

            string UOMID = "";
            int j = 0;

            DataTable dsc = (DataTable)ViewState["DataTable"];

            if (dsc != null)
            {
                foreach (DataRow row in dsc.Rows)
                {
                    int MarCount = (dsc.Rows.Count);

                    string uom_ID = row["uomID"].ToString();

                    if (j == 0)
                    {
                        UOMID += uom_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        UOMID += uom_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        UOMID += uom_ID.ToString();
                    }
                    j++;
                }
                return UOMID;
            }
            else
            {
                return "0";
            }


        }
        public string UOMCondition()
        {

            string ID = Item();
            string uomCondition = "";

            string uom = ddlUom.SelectedValue.ToString();

            try
            {
                if (ID.Equals("0"))
                {

                    uomCondition = " uom_ID not in (0)";
                }
                else
                {

                    uomCondition = " uom_ID not in (" + ID + ")";
                }
            }
            catch (Exception ex)
            {

            }


            return uomCondition;
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProducts.aspx");

        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            DataTable dsc = (DataTable)ViewState["DataTable"];
            if (dsc == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('Add Atleast one UOM for the Product');</script>", false);
                return;
            }
            else
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            string pname, arabicName, pcode, pcat, psubcat, pbrd, rtndays, itemlong, Status, user, itmsaleshold, itmRtnHold, itmOrdHold,
                arabicItemlong, prdType, prdChargable,rtnreqhold, EnableRb, IsBatchItem, ShortName;
            pname = txtPName.Text.ToString();
            arabicName = txtArabic.Text.ToString();
            pcode = txtCode.Text.ToString();
            pcat = ddlcatid.SelectedValue.ToString();
            psubcat = ddlsubcatid.SelectedValue.ToString();
            pbrd = ddlbrdid.SelectedValue.ToString();
            //Session["brand"].ToString();
            rtndays = txtrtndys.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            itemlong = txtitemlong.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            itmsaleshold = ddlSalHold.SelectedValue.ToString();
            itmRtnHold = ddlRtnHold.SelectedValue.ToString();
            itmOrdHold = ddlOrdHold.SelectedValue.ToString();
            arabicItemlong = txtARitemlong.Text.ToString();
            prdType = prd_Type.SelectedValue.ToString();
            prdChargable = ddprdChargable.SelectedValue.ToString();
            rtnreqhold =ddlrtnreqhold.SelectedValue.ToString();
            EnableRb= ddlEnableRb.SelectedValue.ToString();
            IsBatchItem = ddlIsBatchItem.SelectedValue.ToString();
            ShortName = txtShortName.Text.ToString();

            try
            {


                Session["pname"] = pname;
                Session["arabicName"] = arabicName;
                Session["pcode"] = pcode;
                Session["pcat"] = pcat;
                Session["psubcat"] = psubcat;
                Session["pbrd"] = pbrd;
                Session["rtndays"] = rtndays;
                Session["itemlong"] = itemlong;
                Session["Status"] = Status;
                Session["arabicItemlong"] = arabicItemlong;
                Session["SalesHold"] = itmsaleshold;
                Session["RtnHold"] = itmRtnHold;
                Session["OrdHold"] = itmOrdHold;
                Session["prd_Type"] = prdType;
                Session["prd_Chargable"] = prdChargable;
                Session["prd_EnableReturnReqHold"] = rtnreqhold;
                Session["prd_EnableRb"] = EnableRb;
                Session["prd_IsBatchItem"] = IsBatchItem;
                Session["prd_ShortName"] = ShortName;

            }
            catch (Exception ex)
            {

                UICommon.LogException(ex, "Add Product");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ob.LogMessageToFile(UICommon.GetLogFileName(), "AddProducts.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

            if (ViewState["DataTable"] == null)
            {
                addTable();
                
            }
            else
            {
                if (Session["prd_type"].ToString() == "FS")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('For Field Service Products, You can add only one UOM');</script>", false);
                    return;
                }
                else
                {
                    addTable();
                }

            }

            Response.Redirect("AddProducts.aspx?Mode=1");

        }
        public void addTable()
        {

            string stdprice, UPC, Default, uom, saleshold, uomID, DefaultVal, salesholdVal, rtnprice;
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();

                dts.Columns.Add("uomID");
                dts.Columns.Add("stdprice");
                dts.Columns.Add("rtnprice");
                dts.Columns.Add("UPC");
                dts.Columns.Add("DefaultVal");
                dts.Columns.Add("Default");
                dts.Columns.Add("salesholdVal");
                dts.Columns.Add("saleshold");
                dts.Columns.Add("uom");







            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }
            if (dts.Rows.Count > 0)
            {

                uomID = ddlUom.SelectedValue.ToString();
                stdprice = txtStdPrice.Text.ToString();
                rtnprice = txtrtnPrice.Text.ToString();
                UPC = txtupc.Text.ToString();
                DefaultVal = ddlDefault.SelectedValue.ToString();
                Default = ddlDefault.SelectedText.ToString();
                salesholdVal = ddlsaleshold.SelectedValue.ToString();
                saleshold = ddlsaleshold.SelectedText.ToString();
                uom = ddlUom.SelectedItem.Text.ToString();




                dts.Rows.Add(uomID, stdprice, rtnprice, UPC, DefaultVal, Default, salesholdVal, saleshold, uom);

            }
            else
            {

                uomID = ddlUom.SelectedValue.ToString();
                stdprice = txtStdPrice.Text.ToString();
                rtnprice = txtrtnPrice.Text.ToString();
                UPC = txtupc.Text.ToString();

                DefaultVal = ddlDefault.SelectedValue.ToString();
                Default = ddlDefault.SelectedText.ToString();
                salesholdVal = ddlsaleshold.SelectedValue.ToString();
                saleshold = ddlsaleshold.SelectedText.ToString();


                uom = ddlUom.SelectedItem.Text.ToString();


                dts.Rows.Add(uomID, stdprice, rtnprice, UPC, DefaultVal, Default, salesholdVal, saleshold, uom);

            }

            ViewState["DataTable"] = dts;
            Session["DataTable"] = dts;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();

            txtupc.Text = "";
            txtStdPrice.Text = "";
            txtrtnPrice.Text = "";



        }
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;
                    DataTable dsc = (DataTable)ViewState["DataTable"];
                    foreach (DataRow row in dsc.Rows)
                    {

                        string uomID = row["uomID"].ToString();
                        string stdprice = row["stdprice"].ToString();
                        string rtnprice = row["rtnprice"].ToString();
                        string upc = row["UPC"].ToString();
                        string defaul = row["DefaultVal"].ToString();
                        string saleshold = row["salesholdVal"].ToString();
                        //string uom = row["uom"].ToString();

                        //if (Mode.Equals("0"))
                        //{
                        createNode(uomID, stdprice, rtnprice, upc, defaul, saleshold, writer);
                        //}
                        c++;
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

                    if (c == 0)
                    {

                        return null;
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string uomID, string stdprice, string rtnprice, string upc, string defaul, string saleshold, XmlWriter writer)
        {
            writer.WriteStartElement("Values");


            writer.WriteStartElement("uomID");
            writer.WriteString(uomID);
            writer.WriteEndElement();

            writer.WriteStartElement("stdprice");
            writer.WriteString(stdprice);
            writer.WriteEndElement();

            writer.WriteStartElement("rtnprice");
            writer.WriteString(rtnprice);
            writer.WriteEndElement();

            writer.WriteStartElement("UPC");
            writer.WriteString(upc);
            writer.WriteEndElement();

            writer.WriteStartElement("Default");
            writer.WriteString(defaul);
            writer.WriteEndElement();

            writer.WriteStartElement("saleshold");
            writer.WriteString(saleshold);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();

        }
        public void LoadData()
        {

            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;

            //string pid = ResponseID.ToString();
            //DataTable lstDatas = default(DataTable);
            //lstDatas = ob.loadList("ListUomProducts", "sp_Masters_UOM", pid);
            //if (lstDatas.Rows.Count >= 0)
            //{
            //    grvRpt.DataSource = lstDatas;
            //    //pnls.Visible = true;
            //}
            //else
            //{
            //    // pnls.Visible = false;
            //}
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {



            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("uomID").ToString();
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


            Response.Redirect("ListProducts.aspx");
        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
            //string id = ViewState["delID"].ToString();
            //GeneralFunctions.loadList_Static("DeleteItemUom", "sp_Masters_UOM", id);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);


            string ID = ViewState["delID"].ToString();
            DataTable dts = (DataTable)ViewState["DataTable"];
            for (int i = dts.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dts.Rows[i];
                string dd = dr["uomID"].ToString();
                if (dr["uomID"].Equals(ID))
                    dr.Delete();
            }
            dts.AcceptChanges();
            ViewState["DataTable"] = dts;
            int x = dts.Rows.Count;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();
            Uom();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);


        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            // Page.Response.Redirect(Page.Request.Url.ToString(), true);

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
            //Session["brand"] = ddlbrdid.SelectedValue.ToString();
        }

        protected void txtupc_TextChanged(object sender, EventArgs e)
        {
            DataTable dtbl = (DataTable)ViewState["DataTable"];
            try
            {
                if (dtbl != null)
                {
                    if (dtbl.Rows.Count > 0)
                    {
                        string upcexist = dtbl.Rows[0]["UPC"].ToString();
                        string upc = txtupc.Text.ToString();
                        if (upc.Equals(upcexist))
                        {
                            upcduplicate.Text = "UPC Already Exists.";
                            BtnAdd.Enabled = false;

                        }
                        else
                        {
                            upcduplicate.Text = " ";
                            BtnAdd.Enabled = true;
                        }
                    }
                }
                

            }
            catch (Exception ex)
            {

            }

        }

        protected void SelectedIndexChanged_prd_Type(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {

            string selectedProductType = e.Value;

            if (selectedProductType == "FS")
            {
                DataTable dsc = (DataTable)ViewState["DataTable"];
                if(dsc != null)
                {
                    if (dsc.Rows.Count > 1)
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
                        ddprdChargable.Enabled = true;
                    }
                }
                else
                {
                    ddprdChargable.SelectedValue = "N";
                    IsPrdChargable.Visible = true;
                    ddprdChargable.Enabled = true;
                }
                

            }
            else
            {

                IsPrdChargable.Visible = false;
                //	ddprdChargable.Enabled = false;
                ddprdChargable.SelectedValue = "N";

            }

        }
    }
}