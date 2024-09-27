//using DocumentFormat.OpenXml.Drawing.Charts;
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
    public partial class AddMaterialReq : System.Web.UI.Page
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
                //Product();
                //UOM();
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

        //public void Product()
        //{
        //    ddlitem.DataSource = objreq.loadList("SelectProduct", "sp_MaterialRequest");
        //    ddlitem.DataTextField = "prd_Name";
        //    ddlitem.DataValueField = "prd_ID";
        //    ddlitem.DataBind();
        //}

      
        //public void UOM()
        //{
        //    ddlUOM.DataSource = objreq.loadList("SelectUOM", "sp_MaterialRequest");
        //    ddlUOM.DataTextField = "uom_Name";
        //    ddlUOM.DataValueField = "uom_ID";
        //    ddlUOM.DataBind();
        //}


      

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListMaterialReq.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            {

                bool anyRowHasValues = false;

                foreach (GridDataItem row in grvRpt.Items)
                {
                    Telerik.Web.UI.RadNumericTextBox txtRhqty = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtHqnty");
                    Telerik.Web.UI.RadNumericTextBox txtRlqty = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtLqnty");


                    string Hvalue = txtRhqty.Text;
                    string Lvalue = txtRlqty.Text;


                    if (!string.IsNullOrEmpty(Hvalue) || !string.IsNullOrEmpty(Lvalue))
                    {
                        anyRowHasValues = true;
                        break; // Exit the loop if any row has values
                    }
                }

                if (anyRowHasValues)
                {


                    bool confirm = false;

                    foreach (GridDataItem dr in grvRpt.Items)
                    {
                        RadNumericTextBox RHQnty = (RadNumericTextBox)dr.FindControl("txtHqnty");
                        RadNumericTextBox LQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");
                        string HQuantity = RHQnty.Text.Trim();
                        string LQuantity = LQnty.Text.Trim();

                        if (!string.IsNullOrEmpty(HQuantity) || !string.IsNullOrEmpty(LQuantity))
                        {
                            // At least one row has values in txtLqnty or txteligible
                            confirm = true;
                            break;
                        }
                    }

                    if (confirm)
                    {
                        // Your logic to check conditions for saving data
                        bool saveDataConditionsMet = false;

                        foreach (GridDataItem row in grvRpt.Items)
                        {
                            Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtHqnty");
                            Telerik.Web.UI.RadNumericTextBox txtelower = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtLqnty");


                            // Check if at least one text box has a value in the current row
                            if (!string.IsNullOrEmpty(txteligible.Text.Trim()) || !string.IsNullOrEmpty(txtelower.Text.Trim()))
                            {
                                // Additional conditions (modify as needed)


                                // Set to true if at least one row has a value and meets additional conditions

                                saveDataConditionsMet = true;
                                // Exit the loop as soon as one row has a value and meets conditions
                                break;


                            }


                            else
                            {
                                saveDataConditionsMet = false;
                                break;
                            }
                        }

                        // Check if conditions for saving data are met
                        if (saveDataConditionsMet)
                        {
                            // Your logic to save data
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                        }
                        else
                        {
                            // Your logic if none of the rows have a value or meet conditions
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel2();</script>", false);
                        }
                    }





                    // At least one row has values in the specified text fields
                    // Your code here
                }
                else
                {
                    // No row has values in the specified text fields
                    // Your code here
                }


            }

                // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }

            protected void ddlStore_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string strID = ddlStore.SelectedValue.ToString();
           
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
                string ExpectedDate, status, user, store,warehouse;
                ExpectedDate = DateTime.Parse(ddlExpDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                user = UICommon.GetCurrentUserID().ToString();
                //status = ddlStatus.SelectedValue.ToString();
                store = ddlStore.SelectedValue.ToString();
                warehouse = ddlWarehouse.SelectedValue.ToString();
                //qty = txtRQty.Text.ToString();
                //product = ddlitem.SelectedValue.ToString();
                //uom = ddlUOM.SelectedValue.ToString();




                    string[] arr = { user.ToString(),  store.ToString(), warehouse.ToString(),prd.ToString() };
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

                    // Find the control (ddlHUom) in the grid row
                    RadComboBox HuomDrop = (RadComboBox)item.FindControl("ddlHUom");

                    // Assuming you have a data item with a field named "ResponseID"
                    string ID = item.GetDataKeyValue("prd_ID").ToString();

                    // ViewState["ID"] = ID.ToString();
                    // Now you can use ID to load data into the RadComboBox
                    HuomDrop.DataSource = objreq.loadList("SelHuomDrop", "sp_ReturnRequest", ID);
                    HuomDrop.DataTextField = "uom_Name";
                    HuomDrop.DataValueField = "uom_ID";
                    HuomDrop.DataBind();

                    string HUOMID = HuomDrop.SelectedValue.ToString();

                    if (HUOMID != null || HUOMID != "")
                    {

                        RadComboBox LuomDrop = (RadComboBox)item.FindControl("ddlLuom");
                        string[] arry = { HUOMID };

                        LuomDrop.DataSource = objreq.loadList("SelectLowUomFromDrop", "sp_ReturnRequest", ID, arry);
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

            if (gridItem != null)
            {
                RadComboBox ddlLuom = (RadComboBox)gridItem.FindControl("ddlLuom");
                RadNumericTextBox Lqnty = (RadNumericTextBox)gridItem.FindControl("ddlLqty");
                string HUOMID = ddlHUom.SelectedValue;

                ddlLuom.ClearSelection();

                if (!string.IsNullOrEmpty(HUOMID))
                {
                    // Assuming you have a data item with a field named "prd_ID"
                    string ID = gridItem.GetDataKeyValue("prd_ID").ToString();
                    string[] arry = { HUOMID };

                    ddlLuom.DataSource = objreq.loadList("SelectLowUomFromDrop", "sp_ReturnRequest", ID, arry);
                    ddlLuom.DataTextField = "uom_Name";
                    ddlLuom.DataValueField = "uom_ID";
                    ddlLuom.DataBind();


                    if (ddlLuom.Items.Count != 0)
                    {
                        ddlLuom.Enabled = true;
                        //Lqnty.Enabled = true;
                    }
                    else
                    {

                        ddlLuom.Enabled = false;
                        //Lqnty.Enabled = false;

                    }


                }
                else
                {

                }


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
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            RadNumericTextBox HQnty = (RadNumericTextBox)dr.FindControl("txtHqnty");
                            RadNumericTextBox LQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");
                         

                            string HQuantity = HQnty.Text.ToString();
                            string LQuantity = LQnty.Text.ToString();
                          

                            // Check if either txteligible or txtLqnty has values
                            if (!string.IsNullOrEmpty(HQuantity) || !string.IsNullOrEmpty(LQuantity))
                            {
                                string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                                RadNumericTextBox HRQnty = (RadNumericTextBox)dr.FindControl("txtHqnty");
                                RadComboBox ddlHuom = (RadComboBox)dr.FindControl("ddlHUom");
                                RadComboBox ddlLuom = (RadComboBox)dr.FindControl("ddlLuom");

                                RadNumericTextBox LRQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");
                              

                                string HRQuantity = HRQnty.Text.ToString();
                                string HUOM = ddlHuom.SelectedValue.ToString();
                                string LUOM = ddlLuom.SelectedValue.ToString();
                                 string LRQuantity = LRQnty.Text.ToString();
                               


                                createNode(prd_ID, HRQuantity, LRQuantity, HUOM, LUOM, writer);
                                c++;
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

        private void createNode(string prd_ID, string HRQuantity, string LRQuantity,  string HUOM, string LUOM,  XmlWriter writer)
        {
           
          
                writer.WriteStartElement("Values");

                writer.WriteStartElement("prd_ID");
                writer.WriteString(prd_ID);
                writer.WriteEndElement();

                writer.WriteStartElement("HRQuantity");
                writer.WriteString(HRQuantity);
                writer.WriteEndElement();

                writer.WriteStartElement("LRQuantity");
                writer.WriteString(LRQuantity);
                writer.WriteEndElement();

                writer.WriteStartElement("HUOM");
                writer.WriteString(HUOM);
                writer.WriteEndElement();

                writer.WriteStartElement("LUOM");
                writer.WriteString(LUOM);
                writer.WriteEndElement();

              


                writer.WriteEndElement();
            }

          
        
    }
}