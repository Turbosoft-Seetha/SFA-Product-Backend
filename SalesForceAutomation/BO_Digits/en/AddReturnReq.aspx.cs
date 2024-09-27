using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using Convert = System.Convert;
using RadComboBox = Telerik.Web.UI.RadComboBox;
using RadGrid = Telerik.Web.UI.RadGrid;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddReturnReq : System.Web.UI.Page
    {
        GeneralFunctions objreq = new GeneralFunctions();
        private RadComboBox sender;

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
                try
                {
                    Route();
                   




                }
                catch
                {

                }

            }
           // grvRpt.ItemDataBound += grvRpt_ItemDataBound;
        }

        public void Route()
        {
            System.Data.DataTable dt = objreq.loadList("SelectFromDropRouteID", "sp_ReturnRequest");
            ddlroute.DataSource = dt;
            ddlroute.DataTextField = "rot_Name";
            ddlroute.DataValueField = "rot_ID";
            ddlroute.DataBind();
        }


     
        public void Customer(string route)
        {
            System.Data.DataTable dts = objreq.loadList("DropDownCustomerForRoute", "sp_ReturnRequest", route.ToString());
            int x = dts.Rows.Count;
            ddlCus.DataSource = dts;
            ddlCus.DataTextField = "cus_Name";
            ddlCus.DataValueField = "cus_ID";
            ddlCus.DataBind();
        }
        public void Reason()
        {
            RadComboBox ddLrsn = (RadComboBox)grvRpt.FindControl("ddlrsn");

            DataTable dt = objreq.loadList("SelectReason", "sp_ReturnRequest");
            ddLrsn.DataSource = dt;
            ddLrsn.DataTextField = "rsn_Name";
            ddLrsn.DataValueField = "rsn_ID";
            ddLrsn.DataBind();
        }
        public void Invoice()
        {
            string ROT = ddlroute.SelectedValue.ToString();
            string CUS = ddlCus.SelectedValue.ToString();
            string[] ar = { CUS };
            System.Data.DataTable dt = objreq.loadList("SelectInvoice", "sp_ReturnRequest",ROT,ar);
            ddlinvID.DataSource = dt;
            ddlinvID.DataTextField = "inv_InvoiceID";
            ddlinvID.DataValueField = "inv_ID";
            ddlinvID.DataBind();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ScheduledReturn.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
                {
            string FS = ddlType.SelectedValue.ToString();
            bool anyRowHasValues = false;

            foreach (GridDataItem row in grvRpt.Items)
            {
                Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txteligible");
                Telerik.Web.UI.RadNumericTextBox txtlwrQnty = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtLqnty");
                Telerik.Web.UI.RadNumericTextBox txthqty = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txteHqty");
                Telerik.Web.UI.RadNumericTextBox txtlqty = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("ddlLqty");


                string eligibleValue = txteligible.Text;
                string lwrQntyValue = txtlwrQnty.Text;
                string hqty = txthqty.Text;
                string lqty = txtlqty.Text;


                if (!string.IsNullOrEmpty(eligibleValue) || !string.IsNullOrEmpty(lwrQntyValue) || !string.IsNullOrEmpty(hqty) || !string.IsNullOrEmpty(lqty))
                {
                    anyRowHasValues = true;
                    break; // Exit the loop if any row has values
                }
            }

            if (anyRowHasValues)
            {

                if (FS.Equals("I"))
                {
                    bool confirm = false;

                    foreach (GridDataItem dr in grvRpt.Items)
                    {
                        RadNumericTextBox RLQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");
                        RadNumericTextBox Qnty = (RadNumericTextBox)dr.FindControl("txteligible");
                        string LQuantity = RLQnty.Text.Trim();
                        string HQuantity = Qnty.Text.Trim();

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
                            Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txteligible");
                            Telerik.Web.UI.RadNumericTextBox txtelower = (Telerik.Web.UI.RadNumericTextBox)row.FindControl("txtLqnty");
                            var higherQty = row["ind_HigherQty"].Text;
                            var lowerrQty = row["ind_LowerQty"].Text;

                            // Check if at least one text box has a value in the current row
                            if (!string.IsNullOrEmpty(txteligible.Text.Trim()) || !string.IsNullOrEmpty(txtelower.Text.Trim()))
                            {
                                // Additional conditions (modify as needed)
                                if (double.TryParse(higherQty, out double higherQtyValue) && double.TryParse(lowerrQty, out double lowerrQtyValue))
                                {
                                    // Your additional conditions here
                                    if (!(higherQtyValue < txteligible.Value) && !(lowerrQtyValue < txtelower.Value))
                                    {
                                        // Set to true if at least one row has a value and meets additional conditions

                                        saveDataConditionsMet = true;
                                        // Exit the loop as soon as one row has a value and meets conditions
                                    }
                                    else
                                    {
                                        saveDataConditionsMet = false;
                                        break;
                                    }

                                }
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
                }
               
                    else

                    {
                        bool confirm = false;
                        bool modal1 = true;

                        foreach (GridDataItem dr in grvRpt.Items)
                        {
                            RadComboBox ddlHuom = (RadComboBox)dr.FindControl("ddlHUom");
                            RadComboBox ddlLuom = (RadComboBox)dr.FindControl("ddlLuom");
                            RadNumericTextBox HQnty = (RadNumericTextBox)dr.FindControl("txteHqty");
                            RadNumericTextBox LQnty = (RadNumericTextBox)dr.FindControl("ddlLqty");

                            string HUOM = ddlHuom.SelectedValue.ToString();
                            string LUOM = ddlLuom.SelectedValue.ToString();
                            string HQuantity = HQnty.Text.ToString();
                            string LQuantity = LQnty.Text.ToString();

                            if (!string.IsNullOrEmpty(HQuantity) || !string.IsNullOrEmpty(LQuantity))
                            {
                                confirm = true;
                                break;
                            }


                            if ((HUOM == "") && (LUOM == ""))
                            {
                                modal1 = true;
                                confirm = false;
                                break;
                            }
                            else if ((HUOM != "") && (LUOM == ""))
                            {
                                if (HQuantity == "")
                                {
                                    modal1 = false;
                                    confirm = false;
                                    break;
                                }
                                else
                                {
                                    confirm = true;
                                }

                            }
                            else if ((LUOM != "") && (HUOM == ""))
                            {
                                if (LQuantity == "")
                                {
                                    modal1 = false;
                                    confirm = false;
                                    break;
                                }
                                else
                                {
                                    confirm = true;
                                }

                            }
                            else if ((HUOM != "") && (LUOM != ""))
                            {
                                if ((HQuantity == "") || (LQuantity == ""))
                                {
                                    modal1 = false;
                                    confirm = false;
                                    break;
                                }
                                else
                                {
                                    confirm = true;
                                }

                            }
                            else
                            {
                                confirm = true;
                            }


                        }
                        if (confirm == true)
                        {

                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                        }
                        else
                        {
                            if (modal1 == true)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> UOMValidation1();</script>", false);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> UOMValidation2();</script>", false);
                            }

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
        protected void ddlroute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = ddlroute.SelectedValue.ToString();
            Customer(rot);
        }

        public void LoadData()
        {
            string FS = ddlType.SelectedValue.ToString();

            string INV = ddlinvID.SelectedValue.ToString();
            if (FS.Equals("I"))
            {
                DataTable withINV = objreq.loadList("SelProductwithInvoice", "sp_ReturnRequest", INV.ToString());
                grvRpt.DataSource = withINV;

            }
            else
            {


                string ROT = ddlroute.SelectedValue.ToString();
                string CUS = ddlCus.SelectedValue.ToString();
                string[] ar = { CUS };
                DataTable withOUTINV = objreq.loadList("SelProductWithoutInvoice", "sp_ReturnRequest",ROT.ToString(),ar);
                grvRpt.DataSource = withOUTINV;

            }
        }


      

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string prd = GetItemFromGrid();
            string CusID = ddlCus.SelectedValue.ToString();
            string InvID = ddlinvID.SelectedValue.ToString();
            string Return = ddlReturn.SelectedValue.ToString();
            string Route = ddlroute.SelectedValue.ToString();
            string[] arr = { CusID, InvID, user, Return, Route };
            string Value = objreq.SaveData("sp_ReturnRequest", "InsertReturnRequests", prd, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Returns Saved Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
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
                            RadNumericTextBox Qnty = (RadNumericTextBox)dr.FindControl("txteligible");
                            RadNumericTextBox LQnty = (RadNumericTextBox)dr.FindControl("txtLqnty");
                            RadNumericTextBox HRQnty = (RadNumericTextBox)dr.FindControl("txteHqty");
                            RadNumericTextBox LRQnty = (RadNumericTextBox)dr.FindControl("ddlLqty");

                            string Quantity = Qnty.Text.ToString();
                            string LQuantity = LQnty.Text.ToString();
                            string HQTY = HRQnty.Text.ToString();
                            string LQTY = LRQnty.Text.ToString();

                            // Check if either txteligible or txtLqnty has values
                            if (!string.IsNullOrEmpty(Quantity) || !string.IsNullOrEmpty(LQuantity) || !string.IsNullOrEmpty(HQTY) || !string.IsNullOrEmpty(LQTY))
                            {
                                string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                                RadNumericTextBox HQnty = (RadNumericTextBox)dr.FindControl("txteHqty");
                                RadComboBox ddlHuom = (RadComboBox)dr.FindControl("ddlHUom");
                                RadComboBox ddlLuom = (RadComboBox)dr.FindControl("ddlLuom");
                                RadComboBox ddlRSN = (RadComboBox)dr.FindControl("ddlrsn");

                                RadNumericTextBox RLQnty = (RadNumericTextBox)dr.FindControl("ddlLqty");
                                GridBoundColumn indHigherUOMValue = (GridBoundColumn)grvRpt.MasterTableView.GetColumnSafe("ind_HigherUOM");
                                GridBoundColumn indLowerUOMValue = (GridBoundColumn)grvRpt.MasterTableView.GetColumnSafe("ind_LowerUOM");

                                string HQuantity = HQnty.Text.ToString();
                                string HUOM = ddlHuom.SelectedValue.ToString();
                                string LUOM = ddlLuom.SelectedValue.ToString();
                                string RSN = ddlRSN.SelectedValue.ToString();

                                string RLQuantity = RLQnty.Text.ToString();
                                string IHUOM = dr["HUOM"].Text.ToString();
                                string ILUOM = dr["LUOM"].Text.ToString();


                                createNode(prd_ID, Quantity, HQuantity, LQuantity, HUOM, LUOM, RLQuantity, IHUOM, ILUOM, RSN, writer);
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

        private void createNode(string prd_ID, string Quantity, string HQuantity, string LQuantity,string HUOM,string LUOM ,string RLQuantity, string IHUOM,string ILUOM,string RSN, XmlWriter writer)
        {
            string FS = ddlType.SelectedValue.ToString();
            if (FS.Equals("I"))
            {

                writer.WriteStartElement("Values");

                writer.WriteStartElement("prd_ID");
                writer.WriteString(prd_ID);
                writer.WriteEndElement();

                writer.WriteStartElement("Quantity");
                writer.WriteString(Quantity);
                writer.WriteEndElement();

                writer.WriteStartElement("LQuantity");
                writer.WriteString(LQuantity);
                writer.WriteEndElement();

                writer.WriteStartElement("IHUOM");
                writer.WriteString(IHUOM);
                writer.WriteEndElement();

                writer.WriteStartElement("ILUOM");
                writer.WriteString(ILUOM);
                writer.WriteEndElement();

                writer.WriteStartElement("RSN");
                writer.WriteString(RSN);
                writer.WriteEndElement();



                writer.WriteEndElement();
            }

            else
            {
                writer.WriteStartElement("Values");

                writer.WriteStartElement("prd_ID");
                writer.WriteString(prd_ID);
                writer.WriteEndElement();

               

                writer.WriteStartElement("HQuantity");
                writer.WriteString(HQuantity);
                writer.WriteEndElement();

                writer.WriteStartElement("RLQuantity");
                writer.WriteString(RLQuantity);
                writer.WriteEndElement();

                writer.WriteStartElement("HUOM");
                writer.WriteString(HUOM);
                writer.WriteEndElement();

                writer.WriteStartElement("LUOM");
                writer.WriteString(LUOM);
                writer.WriteEndElement();

                writer.WriteStartElement("RSN");
                writer.WriteString(RSN);
                writer.WriteEndElement();


                writer.WriteEndElement();
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ScheduledReturn.aspx");

        }

        protected void ddlinvID_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            grvRpt.Rebind();

        }

     
        protected void ddlType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string FS = ddlType.SelectedValue.ToString();
            ViewState["FS"] = FS.ToString();
            var Hqty = grvRpt.MasterTableView.GetColumn("ind_HigherQty");
            var HUOM = grvRpt.MasterTableView.GetColumn("HigherUOM");
            var lUOM = grvRpt.MasterTableView.GetColumn("LowerUOM");
            var Huomqty = grvRpt.MasterTableView.GetColumn("txteHqty");
            var luomqty = grvRpt.MasterTableView.GetColumn("ddlLqty"); 
            var eluomqty = grvRpt.MasterTableView.GetColumn("txteligible");
            var invHuom = grvRpt.MasterTableView.GetColumn("ind_HigherUOM");
            var invLuom = grvRpt.MasterTableView.GetColumn("ind_LowerUOM");
            var invLQnty = grvRpt.MasterTableView.GetColumn("ind_LowerQty");
            var Lhty = grvRpt.MasterTableView.GetColumn("txtLqnty");




            if (FS.Equals("I"))
            {
                ddlinv.Visible = true;
                Hqty.Visible = true;
                eluomqty.Visible = true;
                invHuom.Visible = true;
                invLuom.Visible=true;
                invLQnty.Visible = true;
                Lhty.Visible = true;
                HUOM.Visible = false;
                lUOM.Visible = false;
                Huomqty.Visible = false;
                luomqty.Visible = false;
                grvRpt.Rebind();
                Invoice();
               
            }
            else
            {
                Lhty.Visible = false;
                ddlinv.Visible = false;
                Hqty.Visible = false;
                HUOM.Visible = true;
                eluomqty.Visible = false;
                invHuom.Visible = false;
                invLuom.Visible = false;
                invLQnty.Visible = false;
                lUOM.Visible = true;
                Huomqty.Visible = true;
                luomqty.Visible = true;

                grvRpt.Rebind();



            }
        }



        //public void UPCC(string selectedID)
        //{

        //    RadComboBox ddlHUom = (RadComboBox)sender;
        //    string HUOM = ddlHUom.SelectedValue;
        //    string upc;

        //   // string selectedValue = ddlHUom.SelectedValue;

        //    string[] arr = { selectedID.ToString() };
        //    DataTable dt2 = objreq.loadList("selectUPCforHUOM", "sp_Masters_UOM", HUOM.ToString(), arr);
        //    if (dt2.Rows.Count > 0)
        //    {
        //        upc = dt2.Rows[0]["pru_UPC"].ToString();
        //      // LUOM(upc);
        //    }
        //}





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
                        Lqnty.Enabled = true;
                    }
                    else
                    {

                        ddlLuom.Enabled = false;
                        Lqnty.Enabled = false;

                    }


                }
                else
                {
                   
                }


            }

        }


       
       
       

        protected void txteligible_TextChanged(object sender, EventArgs e)
        {
            if (grvRpt.SelectedItems.Count > 0)
            {
                GridDataItem selectedRow = (GridDataItem)grvRpt.SelectedItems[0];

                string FS = ddlType.SelectedValue.ToString();
                if (FS.Equals("I"))
                {
                    var higherQty = selectedRow["ind_HigherQty"].Text;
                    Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)sender;
                    var eligibleValue = txteligible.Value;

                    if (!(string.IsNullOrEmpty(higherQty) || !eligibleValue.HasValue))
                    {
                        if (double.Parse(higherQty) > eligibleValue)
                        {
                            // higherQty is greater than eligibleValue
                            // You can add your code here to handle this condition.
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel();</script>", false);

                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                    }
                    // Perform further actions with higherQty
                }
                else
                {

                }


            }
            else
            {
                foreach (GridDataItem dr in grvRpt.Items)
                {

                   
                    var higherQty = dr["ind_HigherQty"].Text;
                    Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)dr.FindControl("txteligible");

                    // Check if txteligible is not null before accessing its value
                    if (txteligible != null)
                    {
                        var txteligibleValueText = txteligible.Text;

                        // Check if the text in txteligibleValue can be parsed to a double
                        if (double.TryParse(txteligibleValueText, out double txteligibleValue))
                        {
                            // Now you can compare higherQty and txteligibleValue
                            if (double.TryParse(higherQty, out double higherQtyValue))
                            {
                                Console.WriteLine($"higherQtyValue: {higherQtyValue}, txteligibleValue: {txteligibleValue}");

                                if (higherQtyValue >= txteligibleValue)
                                {
                                    // higherQty is greater than txteligibleValue
                                    // You can add your code here to handle this condition.
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel();</script>", false);
                                }
                            }
                            else
                            {
                                // Handle the case where higherQty cannot be parsed to a double
                            }
                        }
                        else
                        {
                            // Handle the case where txteligibleValue cannot be parsed to a double
                        }
                    }


                }
            }

        }

        protected void ddlLqty_TextChanged(object sender, EventArgs e)
        {

        }

      

        protected void grvRpt_ItemDataBound1(object sender, GridItemEventArgs e)
        {
           




            string FS = ddlType.SelectedValue.ToString();

            if (FS.Equals("OI"))
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

                    if (e.Item is GridDataItem)
                    {
                        GridDataItem itm = (GridDataItem)e.Item;
                        RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlrsn");
                        reasonDrop.DataSource = objreq.loadList("SelectReason", "sp_ReturnRequest");
                        reasonDrop.DataTextField = "rsn_Name";
                        reasonDrop.DataValueField = "rsn_ID";
                        reasonDrop.DataBind();


                    }
                }

            }
           

            
        }

        protected void grvRpt_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected item
            GridDataItem selectedItem = grvRpt.SelectedItems[0] as GridDataItem;

            if (selectedItem != null)
            {
                string selectedID = selectedItem.GetDataKeyValue("prd_ID").ToString(); // Replace "ID" with the actual name of the ID column in your grid
                //UPCC(selectedID);
            }
        }

        protected void txtLqnty_TextChanged(object sender, EventArgs e)
        {
            if (grvRpt.SelectedItems.Count > 0)
            {
                GridDataItem selectedRow = (GridDataItem)grvRpt.SelectedItems[0];

                string FS = ddlType.SelectedValue.ToString();
                if (FS.Equals("I"))
                {
                    var LowerQty = selectedRow["ind_LowerQty"].Text;
                    Telerik.Web.UI.RadNumericTextBox txtLqnty = (Telerik.Web.UI.RadNumericTextBox)sender;
                    var eligibleValue = txtLqnty.Value;

                    if (!(string.IsNullOrEmpty(LowerQty) || !eligibleValue.HasValue))
                    {
                        if (double.Parse(LowerQty) > eligibleValue)
                        {
                            // higherQty is greater than eligibleValue
                            // You can add your code here to handle this condition.
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel1();</script>", false);

                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                    }
                    // Perform further actions with higherQty
                }
                else
                {



                }


            }
            else
            {
                foreach (GridDataItem dr in grvRpt.Items)
                {
                    var lowerrQty = dr["ind_LowerQty"].Text;
                    Telerik.Web.UI.RadNumericTextBox txteligible = (Telerik.Web.UI.RadNumericTextBox)dr.FindControl("txtLqnty");

                    // Check if txteligible is not null before accessing its value
                    if (txteligible != null)
                    {
                        var txteligibleValueText = txteligible.Text;

                        // Check if the text in txteligibleValue can be parsed to a double
                        if (double.TryParse(txteligibleValueText, out double txteligibleValue))
                        {
                            // Now you can compare lowerrQty and txteligibleValue
                            if (double.TryParse(lowerrQty, out double lowerrQtyValue))
                            {
                                // Log or print the values for debugging
                                Console.WriteLine($"higherQtyValue: {lowerrQtyValue}, txteligibleValue: {txteligibleValue}");

                                if (lowerrQtyValue >= txteligibleValue)
                                {
                                    // Your logic if the condition is met
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel1();</script>", false);
                                }
                            }
                            else
                            {
                                // Handle the case where lowerrQty cannot be parsed to a double
                            }
                        }
                        else
                        {
                            // Handle the case where txteligibleValue cannot be parsed to a double
                        }
                    }
                }
            }


        }
        
        
    }
}