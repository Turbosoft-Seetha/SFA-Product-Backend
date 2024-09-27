using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CreateMR : System.Web.UI.Page
    {
        GeneralFunctions objreq = new GeneralFunctions();
        public int SID
        {
            get
            {
                int SID;
                int.TryParse(Request.Params["SId"], out SID);

                return SID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Store();
                ddlStore.SelectedValue = SID.ToString();
                Warehouse(SID.ToString());
                ddlExpDate.MinDate = DateTime.Now;
              
            }

        }

        public void Store()
        {
            ddlStore.DataSource = objreq.loadList("SelectStore", "sp_MaterialRequest");
            ddlStore.DataTextField = "str_Name";
            ddlStore.DataValueField = "str_ID";
            ddlStore.DataBind();
        }

        public void Warehouse(string strID)
        {
            ddlWarehouse.DataSource = objreq.loadList("SelectWareHouse", "sp_MaterialRequest", strID);
            ddlWarehouse.DataTextField = "war_Name";
            ddlWarehouse.DataValueField = "war_ID";
            ddlWarehouse.DataBind();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListMaterialReq.aspx");
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            bool saveDataConditionsMet = false;            

            foreach (GridDataItem row in grvRpt.Items)
            {
                Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtHqnty");
                Telerik.Web.UI.RadNumericTextBox txtelower = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtLqnty");
                Telerik.Web.UI.RadComboBox txtHuom = (Telerik.Web.UI.RadComboBox)row.FindControl("ddlHUom");
                Telerik.Web.UI.RadComboBox txtLuom = (Telerik.Web.UI.RadComboBox)row.FindControl("ddlLuom");

                string HQuantity = txteligible.Text.Trim();
                string LQuantity = txtelower.Text.Trim();
                string HUOM = txtHuom.Text.Trim();
                string LUOM = txtLuom.Text.Trim();

              
                if (string.IsNullOrEmpty(HQuantity) && !string.IsNullOrEmpty(HUOM))                  
                {
                    txtHuom.ClearSelection();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel('Higher Quantity not entered for selected higher UOM');</script>", false);
                    continue;
                }

                if (string.IsNullOrEmpty(LQuantity) && !string.IsNullOrEmpty(LUOM))
                {
                    txtLuom.ClearSelection();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel('Lower Quantity not entered for selected lower UOM');</script>", false);
                    continue;
                }

                if (!string.IsNullOrEmpty(HQuantity) && string.IsNullOrEmpty(HUOM))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel('Higher UOM not selected for entered higher quantity');</script>", false);
                    continue;
                }

                if (!string.IsNullOrEmpty(LQuantity) && string.IsNullOrEmpty(LUOM))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel('Lower UOM not selected for entered lower quantity');</script>", false);
                    continue;
                }

                if ((HQuantity == "0") || (LQuantity == "0"))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel2();</script>", false);
                    continue;
                }

                if (((!string.IsNullOrEmpty(HQuantity)) && (!string.IsNullOrEmpty(HUOM))) || ((!string.IsNullOrEmpty(LQuantity)) && (!string.IsNullOrEmpty(LUOM))))
                {
                    continue;
                }


                saveDataConditionsMet = true;
                continue;
            }

            if (saveDataConditionsMet)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }            
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel();</script>", false);
            }
        }


        protected void ddlStore_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string strID = ddlStore.SelectedValue.ToString();
            ddlWarehouse.Text = "";
            Warehouse(strID);
        }
        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {
            try
            {
                string prd = GetItemFromGrid();
                string ExpectedDate,  user, store, warehouse;
                ExpectedDate = DateTime.Parse(ddlExpDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                user = UICommon.GetCurrentUserID().ToString();
                store = ddlStore.SelectedValue.ToString();
                warehouse = ddlWarehouse.SelectedValue.ToString();
             
                string[] arr = { user.ToString(), store.ToString(), warehouse.ToString(), prd.ToString() };
                string Value = objreq.SaveData("sp_MaterialRequest", "InsertMaterialReq", ExpectedDate.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Material Request has been saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                objreq.LogMessageToFile(UICommon.GetLogFileName(), "AddMaterialReq.aspx ", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListMaterialReq.aspx");
        }
        public void LoadData()
        {

            DataTable withINV = objreq.loadList("SelectProduct", "sp_MaterialRequest");
            grvRpt.DataSource = withINV;

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();

        }
        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;

                Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)item.FindControl("txtHqnty");
                Telerik.Web.UI.RadNumericTextBox txtelower = (Telerik.Web.UI.RadNumericTextBox)item.FindControl("txtLqnty");
                Telerik.Web.UI.RadComboBox txtHuom = (Telerik.Web.UI.RadComboBox)item.FindControl("ddlHuom");
                Telerik.Web.UI.RadComboBox txtLuom = (Telerik.Web.UI.RadComboBox)item.FindControl("ddlLuom");

                    txteligible.Enabled = false;
                    txtLuom.Enabled = false;
                    txtelower.Enabled = false;
               

                RadComboBox HuomDrop = (RadComboBox)item.FindControl("ddlHUom");

                string ID = item.GetDataKeyValue("prd_ID").ToString();

                HuomDrop.DataSource = objreq.loadList("SelHuomDrop", "sp_MaterialRequest", ID);
                HuomDrop.DataTextField = "uom_Name";
                HuomDrop.DataValueField = "uom_ID";
                HuomDrop.DataBind();

                string HUOMID = HuomDrop.SelectedValue.ToString();

                if (HUOMID != null || HUOMID != "")
                {

                    RadComboBox LuomDrop = (RadComboBox)item.FindControl("ddlLuom");
                    string[] arry = { HUOMID };

                    LuomDrop.DataSource = objreq.loadList("SelectLowUomFromDrop", "sp_MaterialRequest", ID, arry);
                    LuomDrop.DataTextField = "uom_Name";
                    LuomDrop.DataValueField = "uom_ID";
                    LuomDrop.DataBind();

                }

            }
        }
        protected void ddlHUom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
            RadComboBox ddlHUom = (RadComboBox)sender;
            GridDataItem gridItem = (GridDataItem)ddlHUom.NamingContainer;
            RadNumericTextBox Hqty = (RadNumericTextBox)gridItem.FindControl("txtHqnty");
            RadComboBox ddlLuom = (RadComboBox)gridItem.FindControl("ddlLuom");
            RadNumericTextBox Lqnty = (RadNumericTextBox)gridItem.FindControl("txtLqnty");

            if (gridItem != null)
            {
                string HUOMID = ddlHUom.SelectedValue;
                Hqty.Enabled = true;
                ddlLuom.ClearSelection();

                string ID = gridItem.GetDataKeyValue("prd_ID").ToString();
                string[] arry = { HUOMID };

                ddlLuom.DataSource = objreq.loadList("SelectLowUomFromDrop", "sp_MaterialRequest", ID, arry);
                ddlLuom.DataTextField = "uom_Name";
                ddlLuom.DataValueField = "uom_ID";
                ddlLuom.DataBind();


                if (ddlLuom.Items.Count != 0)
                {                  
                    ddlLuom.Enabled = true;
                }
                else
                {
                    
                    ddlLuom.Enabled = false;
                    Lqnty.Enabled = false;
                }
                
            }
            else
            {
                Hqty.Enabled = false;
                ddlLuom.Enabled = false;
                Lqnty.Enabled = false;
            }
        }


        public void ddlLuom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox ddlLUom = (RadComboBox)sender;
            GridDataItem gridItem = (GridDataItem)ddlLUom.NamingContainer;
            RadNumericTextBox Lqnty = (RadNumericTextBox)gridItem.FindControl("txtLqnty");

            if (gridItem != null)
            {              
                string LUOMID = ddlLUom.SelectedValue;
                if (!string.IsNullOrEmpty(LUOMID))
                {
                    Lqnty.Enabled = true;
                }
                else
                {
                    Lqnty.Enabled = false;
                }
            }
            else
            {
                Lqnty.Enabled = false;
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

                    var ColelctionMarkets = grvRpt.Items;

                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            RadNumericTextBox HQnty = (RadNumericTextBox)dr.FindControl("txtHqnty");
                            RadNumericTextBox LQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");

                            string HQuantity = HQnty.Text.Trim();
                            string LQuantity = LQnty.Text.Trim();

                            if (!string.IsNullOrEmpty(HQuantity) || !string.IsNullOrEmpty(LQuantity))
                            {
                                string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                                RadNumericTextBox HRQnty = (RadNumericTextBox)dr.FindControl("txtHqnty");
                                RadComboBox ddlHuom = (RadComboBox)dr.FindControl("ddlHUom");
                                RadComboBox ddlLuom = (RadComboBox)dr.FindControl("ddlLuom");
                                RadNumericTextBox LRQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");

                                string HRQuantity = !string.IsNullOrEmpty(HQuantity) ? HQuantity : null;
                                string HUOM = ddlHuom.SelectedValue.ToString();
                                string LUOM = ddlLuom.SelectedValue.ToString();
                                string LRQuantity = !string.IsNullOrEmpty(LQuantity) ? LQuantity : null;

                                createNode(prd_ID, HRQuantity, LRQuantity, HUOM, LUOM, writer);
                                c++;
                            }
                            else
                            {
                               
                            }
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
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string prd_ID, string HRQuantity, string LRQuantity, string HUOM, string LUOM, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteElementString("prd_ID", prd_ID);
            writer.WriteElementString("HRQuantity", HRQuantity);

            if (!string.IsNullOrEmpty(LRQuantity))
            {
                writer.WriteElementString("LRQuantity", LRQuantity);
            }
            else
            {
                writer.WriteElementString("LUOM", "");
            }

            writer.WriteElementString("HUOM", HUOM);
            writer.WriteElementString("LUOM", LUOM);
            writer.WriteEndElement();
        }

        protected void norowslected_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem row in grvRpt.Items)
            {
                RadNumericTextBox HQnty = (RadNumericTextBox)row.FindControl("txtHqnty");
                RadNumericTextBox LQnty = (RadNumericTextBox)row.FindControl("txtLqnty");

                if (HQnty.Text=="0")
                {
                    HQnty.Text = "";
                }
                else if (LQnty.Text=="0")
                {
                    LQnty.Text = "";
                }
                else
                {

                }
            }
        }
    }
}