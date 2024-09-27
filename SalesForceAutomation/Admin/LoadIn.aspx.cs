using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using System.Xml;

namespace SalesForceAutomation.Admin
{
    public partial class LoadIn : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        public int RID
        {
            get
            {
                int RID;
                int.TryParse(Request.Params["RId"], out RID);

                return RID;
            }
        }
        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["LIH"], out LIH);

                return LIH;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Rot();
                RouteforAdd();
                if (RID==0)
                {
                    pnls.Visible = false;
                    Product();


                }
                else
                {
                    ddlp.SelectedValue = RID.ToString();
                    ddlp.Enabled = false;
                    Products();
                }

                

            }
        }
        public void Rot()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("GetRotByID", "sp_Masters_UOM", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                
                //RadPanelItem rp = RadPanelBar0.Items[0];
                //Label lblRot = (Label)rp.FindControl("lblRot");
               string RID  = lstDatas.Rows[0]["lih_rot_ID"].ToString();
               
                
                   // Products();
                
            }
        }
        public void Products()
        {
            String[] ar = { RID.ToString() };
            DataTable dts = Obj.loadList("SelProductsFromDrop", "sp_Masters_UOM",LIH.ToString(),ar);
            ddlProduct.DataSource = dts;
            ddlProduct.DataTextField = "prd_Name";
            ddlProduct.DataValueField = "prd_ID";
            ddlProduct.DataBind();
            
        }

        public void Product()
        {
            DataTable dts = Obj.loadList("SelProductsFornewheader", "sp_Masters_UOM", ddlp.SelectedValue.ToString());
            ddlProduct.DataSource = dts;
            ddlProduct.DataTextField = "prd_Name";
            ddlProduct.DataValueField = "prd_ID";
            ddlProduct.DataBind();

        }

        public void SaveData()
        {
            string item, higherqty, lowerqty, higheruom, loweruom, userr, Route;
            item = ddlProduct.SelectedValue.ToString();
            higherqty = txtHQty.Text.ToString();
            lowerqty = txtLQty.Text.ToString();
            higheruom = ddlHUom.SelectedValue.ToString();
            loweruom = ddlLUom.SelectedValue.ToString();
            userr = UICommon.GetCurrentUserID().ToString();
            Route = ddlp.SelectedValue.ToString();
            
            if (RID == 0)
            {
                string[] arr = { higheruom, loweruom, higherqty, lowerqty, userr, Route };
                string Value = Obj.SaveData("sp_Masters_UOM", "InsertLoadInDetail", item, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    LoadData();
                    grvRpt.DataBind();
                    txtHQty.Text = "";
                    txtLQty.Text = "";
                    ddlp.SelectedValue = Route;
                    Response.Redirect("LoadIn.aspx?RId=" + ddlp.SelectedValue.ToString()+"&LIH="+res.ToString());
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            }
            else
            {
                string[] arr = { higheruom, loweruom, higherqty, lowerqty, userr, LIH.ToString() };
                string Value = Obj.SaveData("sp_Masters_UOM", "UpdateLoadInheader", item, arr);
                int LID = Int32.Parse(Value.ToString());
                if (LID > 0)
                {
                    LoadData();
                    grvRpt.DataBind();
                    txtHQty.Text = "";
                    txtLQty.Text = "";
                    ddlp.SelectedValue = Route;
                    Response.Redirect("LoadIn.aspx?RId=" + ddlp.SelectedValue.ToString() + "&LIH=" + LIH.ToString());
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }

                
            }
        }
        public void HUOM(string prdct)
        {
            DataTable dq = Obj.loadList("SelectHighUomFromDrop", "sp_Masters_UOM", prdct);
            ddlHUom.DataSource = dq;
            ddlHUom.DataTextField = "uom_Name";
            ddlHUom.DataValueField = "uom_ID";
            ddlHUom.DataBind();            
        }        
        public void LUOM(string upc)
        {
            //string cat = ddlcatid.SelectedValue.ToString();
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable ds = Obj.loadList("SelectLowUomFromDrop", "sp_Masters_UOM", upc,arr);
            ddlLUom.DataSource = ds;
            ddlLUom.DataTextField = "uom_Name";
            ddlLUom.DataValueField = "uom_ID";
            ddlLUom.DataBind();
            ViewState["dd"] = ds;
        }
        public void UPCC()
        {
            string upc;
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable dt2 = Obj.loadList("selectUPCforHUOM", "sp_Masters_UOM", ddlHUom.SelectedValue.ToString(), arr);
            if (dt2.Rows.Count > 0)
            {

                upc = dt2.Rows[0]["pru_UPC"].ToString();
                LUOM(upc);
            }
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

                    var ColelctionMarkets = ddlProduct.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode(item.Value, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }
        private void createNode(string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("prdID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            //string[] arr = { ddlHUom.SelectedValue.ToString(), ddlLUom.SelectedValue.ToString() };
            
                lstDatas = Obj.loadList("ListLoadIn", "sp_Masters_UOM", LIH.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    grvRpt.DataSource = lstDatas;
                    pnls.Visible = true;
                }
                else
                {
                    pnls.Visible = false;
                }
            
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            SaveData();           
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        protected void ddlProduct_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {          
                    HUOM(ddlProduct.SelectedValue.ToString());        
        }
        protected void ddlHUom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            UPCC();
        }

        protected void ddlp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (RID == 0)
            {
                Product();
            }
            else
            {
                Products();
            }
        }
        public void RouteforAdd()
        {
            DataTable dt = Obj.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlp.DataSource = dt;
            ddlp.DataTextField = "rot_Name";
            ddlp.DataValueField = "rot_ID";
            ddlp.DataBind();
        }

    }
}