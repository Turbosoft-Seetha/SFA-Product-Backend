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
using Telerik.Web.UI.HtmlChart;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class AddEditPriceListDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
                return ResponseID;
            }
        }


        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["hid"], out HeaderID);
                return HeaderID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                ViewState["DataTable"] = null;
                product();
                productCode();

                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = ObjclsFrms.loadList("EditPriceListDetail", "sp_Masters_UOM", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {

                        string pname, vat, Status, fromdate, todate;                                          //Declare the variables
                        pname = lstDatas.Rows[0]["pld_prd_ID"].ToString();
                        //caseprice = lstDatas.Rows[0]["pld_CasePrice"].ToString();
                        //  piece = lstDatas.Rows[0]["pld_PiecePrice"].ToString();


                        Status = lstDatas.Rows[0]["Status"].ToString();




                        ddlp.SelectedValue = pname.ToString();
                        //txtcase.Text = caseprice.ToString();
                        //txtPiece.Text = piece.ToString();

                        ddlstatus.SelectedValue = Status.ToString();




                    }
                    else
                    {

                    }
                }
            }

        }
        public void HeaderData()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelPriceListHeader", "sp_Masters", HeaderID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblprh = (Label)rp.FindControl("lblprh");

                // Label lblstatus = (Label)rp.FindControl("lblstatus");
                Label lblPayMode = (Label)rp.FindControl("lblPayMode");

                rp.Text = "Special Price Code: " + lstDatas.Rows[0]["prh_Code"].ToString();
                lblprh.Text = lstDatas.Rows[0]["prh_Name"].ToString();

                //lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
                lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();




            }
        }
        public void Uom()
        {
            string product, header;
            product = ddlp.SelectedValue.ToString();
            header = HeaderID.ToString();
            string[] arr = { header };
            DataTable ds = ObjclsFrms.loadList("SelectUomForDrop", "sp_Masters", product, arr);
            ddlUom.DataSource = ds;
            ddlUom.DataTextField = "uom_Name";
            ddlUom.DataValueField = "uom_ID";
            ddlUom.DataBind();
        }


        public void product()
        {
            DataTable dt = ObjclsFrms.loadList("SelFromDropProductID", "sp_Masters", ResponseID.ToString());
            ddlp.DataSource = dt;
            ddlp.DataTextField = "prd_Name";
            ddlp.DataValueField = "prd_ID";
            ddlp.DataBind();
        }
        public void productCode()
        {
            DataTable dt = ObjclsFrms.loadList("SelFromDropProductCodeID", "sp_Masters", ResponseID.ToString());
            ddlpCode.DataSource = dt;
            ddlpCode.DataTextField = "prd_Code";
            ddlpCode.DataValueField = "prd_ID";
            ddlpCode.DataBind();
        }

        public void StdUomProductPrice()
        {
            string prd, uom;
            prd = ddlp.SelectedValue.ToString();
            uom = ddlUom.SelectedValue.ToString();
            string[] arr = { uom };
            DataTable lstDatas = ObjclsFrms.loadList("StdUomProductPrice", "sp_Masters", prd, arr);
            if (lstDatas.Rows.Count > 0)
            {
                string price;
                price = lstDatas.Rows[0]["pru_Price"].ToString();
                txtstdprice.Text = price.ToString();
            }
        }

        protected void Save()
        {
            string sp, user;
            sp = HeaderID.ToString();

            string detail = "";


            DataTable dsc = (DataTable)ViewState["DataTable"];
            if (dsc == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('No Product is added');</script>", false);
                return;
            }
            detail = GetItemFromGrid();



            user = UICommon.GetCurrentUserID().ToString();




            string[] arr = { user, detail };
            DataTable lstClaim = ObjclsFrms.loadList("InsertPriceListDetail", "sp_Merchandising", sp, arr);

            if (lstClaim.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('تمت إضافة المنتجات بنجاح');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('بعض الحقول مفقودة ');</script>", false);
            }


        }
        //public void SaveData()
        //{

        //    string pname, user, Status, uom, price, rtnprice;                                          //Declare the variables


        //    pname = ddlp.SelectedValue.ToString();
        //    uom = ddlUom.SelectedValue.ToString();
        //    price = txtprice.Text.ToString();
        //    user = UICommon.GetCurrentUserID().ToString();
        //    Status = ddlstatus.SelectedValue.ToString();
        //    rtnprice = txtRtnPrice.Text.ToString();
        //    if (ResponseID.Equals("0") || ResponseID == 0)
        //    {
        //        string[] arr = { pname, user, Status, uom, price, rtnprice };
        //        string Value = ObjclsFrms.SaveData("sp_Masters", "InsertPriceListDetail", HeaderID.ToString(), arr);
        //        int res = Int32.Parse(Value.ToString());
        //        if (res > 0)
        //        {
        //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Price List Detail Saved Successfully');</script>", false);
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
        //        }
        //    }
        //    //else
        //    //{


        //    //    string ID = ResponseID.ToString();
        //    //    string[] arr = {   vat, Status,ID,uom,price };
        //    //    string value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdatePriceListDetail", pname, arr);
        //    //    int res = Int32.Parse(value.ToString());
        //    //    if (res > 0)
        //    //    {
        //    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Price List Detail Updated Successfully');</script>", false);
        //    //    }
        //    //    else
        //    //    {
        //    //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
        //    //    }


        //    //}
        //}

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListPriceListDetail.aspx?hid=" + HeaderID);

        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('');</script>", false);

        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Uom();
            productCode();
            ddlpCode.SelectedValue = ddlp.SelectedValue.ToString();
        }

        protected void ddlUom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            StdUomProductPrice();
        }


        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditPriceListDetail.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListPriceListDetail.aspx?hid=" + HeaderID);

        }

        protected void ddlpCode_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Uom();
            product();
            ddlp.SelectedValue = ddlpCode.SelectedValue.ToString();
        }

        protected void ADD_Click(object sender, EventArgs e)
        {
            addTable();
        }
        public void addTable()
        {
            string ID, product, uomid, uom, stdprice, price, rtnprice, status;
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("Product");
                dts.Columns.Add("UOM");
                dts.Columns.Add("UOMID");
                dts.Columns.Add("StandardPrice");
                dts.Columns.Add("Price");
                dts.Columns.Add("ReturnPrice");
                dts.Columns.Add("Status");
            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }

            if (dts.Rows.Count > 0)
            {
                //int count = dts.Rows.Count + 1;
                //ID = "D" + (count++).ToString();
                //mode = "0";
                ID = ddlp.SelectedValue.ToString();
                product = ddlp.SelectedItem.Text.ToString();
                uomid = ddlUom.SelectedValue.ToString();
                uom = ddlUom.SelectedItem.Text.ToString();
                stdprice = txtstdprice.Text.ToString();
                price = txtprice.Text.ToString();
                rtnprice = txtRtnPrice.Text.ToString();
                status = ddlstatus.SelectedValue.ToString();

                dts.Rows.Add(ID, product, uom, uomid, stdprice, price, rtnprice, status);
            }
            else
            {

                ID = ddlp.SelectedValue.ToString();
                product = ddlp.SelectedItem.Text.ToString();
                uomid = ddlUom.SelectedValue.ToString();
                uom = ddlUom.SelectedItem.Text.ToString();
                stdprice = txtstdprice.Text.ToString();
                price = txtprice.Text.ToString();
                rtnprice = txtRtnPrice.Text.ToString();
                status = ddlstatus.SelectedValue.ToString();

                dts.Rows.Add(ID, product, uom, uomid, stdprice, price, rtnprice, status);
            }
            ViewState["DataTable"] = dts;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();
            txtprice.Text = "";
            txtRtnPrice.Text = "";
            txtstdprice.Text = "";
            ddlp.SelectedValue = "";
            ddlpCode.SelectedValue = "";
            ddlUom.SelectedValue = "";
            //txtOrder.Text = "";

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
                        string prdid = row["ID"].ToString();
                        string uomid = row["UOMID"].ToString();
                        //string stdprice = row["StandardPrice"].ToString();
                        string price = row["Price"].ToString();
                        string rtnprice = row["ReturnPrice"].ToString();
                        string Status = row["Status"].ToString();

                        createNode(prdid, uomid, price, rtnprice, Status, writer);

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

        private void createNode(string prdid, string uomid, string price, string rtnprice, string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("prdid");
            writer.WriteString(prdid);
            writer.WriteEndElement();
            writer.WriteStartElement("uomid");
            writer.WriteString(uomid);
            writer.WriteEndElement();


            writer.WriteStartElement("price");
            writer.WriteString(price);
            writer.WriteEndElement();

            writer.WriteStartElement("rtnprice");
            writer.WriteString(rtnprice);
            writer.WriteEndElement();

            writer.WriteStartElement("Status");
            writer.WriteString(Status);
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
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string delID = dataItem.GetDataKeyValue("ID").ToString();
                ViewState["DeleteID"] = delID.ToString();
                // ViewState["DelMode"] = dataItem["Mode"].Text.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {

            Deleted();
        }
        public void Deleted()
        {


            string ID = ViewState["DeleteID"].ToString();
            DataTable dts = (DataTable)ViewState["DataTable"];
            for (int i = dts.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dts.Rows[i];
                string dd = dr["ID"].ToString();
                if (dr["ID"].Equals(ID))
                    dr.Delete();
            }
            dts.AcceptChanges();
            ViewState["DataTable"] = dts;
            int x = dts.Rows.Count;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);
        }
        protected void LinkButton4_Click(object sender, EventArgs e)
        {

        }
    }
}