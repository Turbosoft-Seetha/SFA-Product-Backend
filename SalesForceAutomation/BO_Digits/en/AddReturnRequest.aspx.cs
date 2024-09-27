//using DocumentFormat.OpenXml.Drawing;
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

using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddReturnRequest : System.Web.UI.Page
    {
        GeneralFunctions objreq = new GeneralFunctions();
       
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

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
        public int RtnID
        {
            get
            {
                int RtnID;
                int.TryParse(Request.Params["RtnID"], out RtnID);

                return RtnID;
            }
        }
        public int cusID
        {
            get
            {
                int cusID;
                int.TryParse(Request.Params["cusID"], out cusID);

                return cusID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    Route();
                    Reason();
                    if (RtnID == 0)
                    {
                        ViewState["DataTable"] = null;
                        
                       
                    }
                    else
                    {
                        pnlwithoutInv.Visible = true;
                        pnlWOI.Visible = true;
                        ViewState["DataTable"] = Session["DataTable"];
                        ddlroute.SelectedValue = RID.ToString();
                        Customer(RID.ToString());
                        ddlCus.SelectedValue = cusID.ToString();
                        ddlType.SelectedValue = Session["Type"].ToString();
                        ddlReturn.SelectedValue = Session["ReturnType"].ToString();
                        
                        ddlroute.Enabled = false;
                        ddlCus.Enabled = false;
                        ddlType.Enabled = false;
                        ddlReturn.Enabled = false;
                        Products();
                    }




                }
                catch
                {

                }

            }
            // grvRpt.ItemDataBound += grvRpt_ItemDataBound;
        }

        public void Route()
        {
            DataTable dt = objreq.loadList("SelectFromDropRouteID", "sp_ReturnRequest");
            ddlroute.DataSource = dt;
            ddlroute.DataTextField = "rot_Name";
            ddlroute.DataValueField = "rot_ID";
            ddlroute.DataBind();
        }

        public void Reason()
        {
            ddlrsn.DataSource = objreq.loadList("SelectReason", "sp_ReturnRequest");
            ddlrsn.DataTextField = "rsn_Name";
            ddlrsn.DataValueField = "rsn_ID";
            ddlrsn.DataBind();
        }
      
        public void Customer(string route)
        {
            DataTable dts = objreq.loadList("DropDownCustomerForRoute", "sp_ReturnRequest", route.ToString());
            int x = dts.Rows.Count;
            ddlCus.DataSource = dts;
            ddlCus.DataTextField = "cus_Name";
            ddlCus.DataValueField = "cus_ID";
            ddlCus.DataBind();
        }
        public void Invoice()
        {
            string ROT = ddlroute.SelectedValue.ToString();
            string CUS = ddlCus.SelectedValue.ToString();
            string[] ar = { CUS };
            DataTable dt = objreq.loadList("SelectInvoice", "sp_ReturnRequest", ROT, ar);
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
            if (FS == "I")
            {


                foreach (GridDataItem row in grvRpt.Items)
                {
                    RadNumericTextBox txteligible = (RadNumericTextBox)row.FindControl("txteligible");
                    RadNumericTextBox txtlwrQnty = (RadNumericTextBox)row.FindControl("txtLqnty");
                    RadNumericTextBox txthqty = (RadNumericTextBox)row.FindControl("txteHqty");
                    RadNumericTextBox txtlqty = (RadNumericTextBox)row.FindControl("ddlLqty");


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
                                RadNumericTextBox txteligible = (RadNumericTextBox)row.FindControl("txteligible");
                                RadNumericTextBox txtelower = (RadNumericTextBox)row.FindControl("txtLqnty");
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
                        bool modal1 = false;
                        bool modal2 = false;

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
                                if ((HUOM == "") && (LUOM == ""))
                                {
                                    modal1 = true;
                                    confirm = false;
                                    break;
                                }
                                else if (((HUOM != "") && (LUOM == "")) || ((HUOM == "") && (LUOM != "")))
                                {
                                    modal1 = true;
                                    confirm = false;
                                    break;
                                    //if (HQuantity == "")
                                    //{
                                    //    modal1 = false;
                                    //    confirm = false;
                                    //    break;
                                    //}
                                    //else if (LQuantity!="")
                                    //{
                                    //    modal1 = false;
                                    //    confirm = false;
                                    //    break;

                                    //}
                                    //else
                                    //{
                                    //    confirm = true;
                                    //}

                                }
                                else if ((LUOM != "") && (HUOM != ""))
                                {
                                    if (LQuantity == "")
                                    {
                                        LQuantity = "0";
                                        confirm = true;
                                        break;
                                    }
                                    else if (HQuantity == "")
                                    {
                                        HQuantity = "0";
                                        if(LQuantity=="0")
                                        {
                                            modal2 = true;
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

                            }

                            //else if ((HUOM != "") && (LUOM != ""))
                            //{
                            //    if ((HQuantity == "") || (LQuantity == ""))
                            //    {
                            //        modal1 = false;
                            //        confirm = false;
                            //        break;
                            //    }
                            //    else if ((HQuantity != "") || (LQuantity != ""))
                            //    {
                            //        confirm = true;
                            //    }

                            //}
                            //else
                            //{
                            //    confirm = true;
                            //}





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
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>NoProducts('Invalid input data..You must enter considerable quantity along with products.');</script>", false);

                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }

        }
        protected void ddlroute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = ddlroute.SelectedValue.ToString();
            ddlCus.ClearSelection();
            ddlinvID.ClearSelection();
            Customer(rot);
            Invoice();
        }
        public void Products()
        {
            string ROT = ddlroute.SelectedValue.ToString();
            string CUS = ddlCus.SelectedValue.ToString();
            string[] ar = { CUS };
            string mainCondition = "";
            mainCondition = productCondition();
            DataTable withOUTINV = objreq.loadList("SelPrdWithoutInvoice", "sp_ReturnRequest",mainCondition.ToString());
            ddlProduct.DataSource = withOUTINV;
            ddlProduct.DataTextField = "prd_Name";
            ddlProduct.DataValueField = "prd_ID";
            ddlProduct.DataBind();


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
            //else
            //{


            //    string ROT = ddlroute.SelectedValue.ToString();
            //    string CUS = ddlCus.SelectedValue.ToString();
            //    string[] ar = { CUS };
            //    DataTable withOUTINV = objreq.loadList("SelProductWithoutInvoice", "sp_ReturnRequest", ROT.ToString(), ar);

            //    grvRpt.DataSource = withOUTINV;

            //}
        }




        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            if (ddlType.SelectedValue.ToString() == "I")
            {


                string prd = GetItemsFromGrid();
                if (prd == "")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>NoProducts('Invalid input data..You must enter considerable quantity along with products.');</script>", false);

                }
                else
                {


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
            }

            else
            {

                string c = "0";
                DataTable dsc = (DataTable)ViewState["DataTable"];
                if (dsc != null)
                {
                    c = dsc.Rows.Count.ToString();
                }
                if (dsc == null || c == "0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                        "tmp", "<script type='text/javascript'>NoProducts('You should add atleast one product');</script>", false);
                    return;
                }
                else
                {
                    string prds = GetItemFromGrid();
                    string CusID = ddlCus.SelectedValue.ToString();

                    string Return = ddlReturn.SelectedValue.ToString();
                    string Route = ddlroute.SelectedValue.ToString();
                    string[] arr = { CusID, user, Return, Route };
                    string Value = objreq.SaveData("sp_ReturnRequest", "InsertWOIReturnRequests", prds, arr);
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
               

            }
        }
        public string GetItemsFromGrid()
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
                            if (Quantity=="")
                            {
                                Quantity = "0";

                            }
                            if (LQuantity=="")
                            {
                                LQuantity= "0";

                            }
                            if(HQTY=="")
                            {
                                HQTY = "0";
                            }
                            if(LQTY=="")
                            {
                                LQTY= "0";
                            }

                            // Check if either txteligible or txtLqnty has values
                            if (!string.IsNullOrEmpty(Quantity) || !string.IsNullOrEmpty(LQuantity) || !string.IsNullOrEmpty(HQTY) || !string.IsNullOrEmpty(LQTY))
                            {
                                if ((Quantity == "0" && LQuantity == "0")&&(HQTY=="0" && LQTY=="0"))
                                {

                                }
                                else
                                {


                                    string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                                    RadNumericTextBox HQnty = (RadNumericTextBox)dr.FindControl("txteHqty");
                                    RadComboBox ddlHuom = (RadComboBox)dr.FindControl("ddlHUom");
                                    RadComboBox ddlLuom = (RadComboBox)dr.FindControl("ddlLuom");
                                    RadComboBox ddlRSN = (RadComboBox)dr.FindControl("ddlrsn");
                                    RadAsyncUpload upd1 = (RadAsyncUpload)dr.FindControl("upd1");
                                    RadNumericTextBox RLQnty = (RadNumericTextBox)dr.FindControl("ddlLqty");

                                    GridBoundColumn indHigherUOMValue = (GridBoundColumn)grvRpt.MasterTableView.GetColumnSafe("ind_HigherUOM");
                                    GridBoundColumn indLowerUOMValue = (GridBoundColumn)grvRpt.MasterTableView.GetColumnSafe("ind_LowerUOM");

                                    string RtnImage = "";
                                    int ImageID = 0;
                                    string HQuantity = HQnty.Text.ToString();
                                    string HUOM = ddlHuom.SelectedValue.ToString();
                                    string LUOM = ddlLuom.SelectedValue.ToString();
                                    string RSN = ddlRSN.SelectedValue.ToString();

                                    string RLQuantity = RLQnty.Text.ToString();
                                    string IHUOM = dr["HUOM"].Text.ToString();
                                    string ILUOM = dr["LUOM"].Text.ToString();
                                    if(HQuantity=="")
                                    {
                                        HQuantity= "0";
                                    }
                                    if(RLQuantity=="")
                                    {
                                        RLQuantity= "0";
                                    }

                                    foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                                    {
                                        ImageID += 1;

                                        string uniqueString = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Guid.NewGuid().ToString("N").Substring(0, 5);
                                        string fileExtension = Path.GetExtension(uploadedFile.FileName);
                                        string newFileName = $"{ImageID}_{uniqueString}{fileExtension}";
                                        string csvPath = Server.MapPath(("..") + @"/../UploadFiles/SRRequest/") + "_" + newFileName;
                                        uploadedFile.SaveAs(csvPath);
                                        RtnImage = @"../../UploadFiles/SRRequest/" +  "_" + newFileName.ToString();
                                        ViewState["Image"] = RtnImage.ToString();

                                    }


                                    createNode(prd_ID, Quantity, HQuantity, LQuantity, HUOM, LUOM, RLQuantity, IHUOM, ILUOM, RSN, RtnImage,writer);
                                    c++;
                                }
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

        private void createNode(string prd_ID, string Quantity, string HQuantity, string LQuantity, string HUOM, string LUOM, string RLQuantity, string IHUOM, string ILUOM, string RSN,string RtnImage, XmlWriter writer)
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

                writer.WriteStartElement("RtnImage");
                writer.WriteString(RtnImage);
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

                writer.WriteStartElement("RtnImage");
                writer.WriteString(RtnImage);
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
            LoadData();
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
                pnlwithInv.Visible= true;
                ddlinv.Visible = true;
                Hqty.Visible = true;
                eluomqty.Visible = true;
                invHuom.Visible = true;
                invLuom.Visible = true;
                invLQnty.Visible = true;
                Lhty.Visible = true;
                HUOM.Visible = false;
                lUOM.Visible = false;
                Huomqty.Visible = false;
                luomqty.Visible = false;
                pnlWOI.Visible = false;
                pnlwithoutInv.Visible = false;
                Invoice();
                grvRpt.Rebind();
                

            }
            else
            {
                pnlWOI.Visible= true;
                pnlwithInv.Visible = false;
                ddlinv.Visible = false;
                txtLQty.Enabled= false;
            }
            //else
            //{
            //    pnlwithInv.Visible= false;
            //    pnlWOI.Visible = true;
            //    pnlwithoutInv.Visible = true;
            //    Lhty.Visible = false;
            //    ddlinv.Visible = false;
            //    Hqty.Visible = false;
            //    HUOM.Visible = true;
            //    eluomqty.Visible = false;
            //    invHuom.Visible = false;
            //    invLuom.Visible = false;
            //    invLQnty.Visible = false;
            //    lUOM.Visible = true;
            //    Huomqty.Visible = true;
            //    luomqty.Visible = true;

            //    grvRpt.Rebind();



            //}
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
                    RadNumericTextBox txteligible = (RadNumericTextBox)sender;
                    var eligibleValue = txteligible.Value;

                    if (!(string.IsNullOrEmpty(higherQty) || !eligibleValue.HasValue))
                    {
                        
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
                    RadNumericTextBox txteligible = (RadNumericTextBox)dr.FindControl("txteligible");

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

           
            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
                RadComboBox reasonDrop = (RadComboBox)itm.FindControl("ddlrsn");
              
                reasonDrop.DataSource = objreq.loadList("SelectReason", "sp_ReturnRequest");
                reasonDrop.DataTextField = "rsn_Name";
                reasonDrop.DataValueField = "rsn_ID";
                reasonDrop.DataBind();
                if (ddlType.SelectedValue.ToString()=="I")
                {

                
                RadNumericTextBox RLQnty = (RadNumericTextBox)itm.FindControl("txtLqnty");
                RadNumericTextBox Qnty = (RadNumericTextBox)itm.FindControl("txteligible");
                string higherQty = itm["ind_HigherQty"].Text.ToString();
                string lowerQty = itm["ind_LowerQty"].Text.ToString();
                int higher =Int32.Parse(higherQty);
                int lower = Int32.Parse(lowerQty);
                Qnty.MaxValue= higher;
                RLQnty.MaxValue= lower;
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
                    RadNumericTextBox txtLqnty = (RadNumericTextBox)sender;
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
                     RadNumericTextBox txteligible = (RadNumericTextBox)dr.FindControl("txtLqnty");

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

        protected void ddlCus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ddlinvID.ClearSelection();
            Invoice();
            ddlProduct.ClearSelection();
            Products();
        }

        protected void AddItem_Click(object sender, EventArgs e)
        {

            string huom = ddlHUom.SelectedValue.ToString();
            string hqty = txtHQty.Text.ToString();
            string luom = ddlLUom.SelectedValue.ToString();
            string Lqty = txtLQty.Text.ToString();

            if (hqty == "")
            {
                hqty = "0";
            }
            if (Lqty == "")
            {
                Lqty = "0";
            }
            if (hqty=="0" && Lqty=="0")
                {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>NoProducts('Invalid input data..You must enter considerable quantity along with products.');</script>", false);

            }
            else
            {
                addTable();
            }


        }


        
        public void addTable()
        {
            string Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID,Reason,ReasonID,img;
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("Item");
                dts.Columns.Add("HigherQty");
                dts.Columns.Add("LowerQty");
                dts.Columns.Add("HigherUom");
                dts.Columns.Add("LowerUom");
                dts.Columns.Add("higheruomID");
                dts.Columns.Add("loweruomID");
                dts.Columns.Add("Reason");
                dts.Columns.Add("ReasonID");
                dts.Columns.Add("img");

            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }
            string ID;

            if (dts.Rows.Count > 0)
            {
                LowerUom = ddlLUom.SelectedValue.ToString();
                //if (LowerUom == "")
                //{
                //    ID = ddlProduct.SelectedValue.ToString();
                //    Item = ddlProduct.SelectedItem.Text.ToString();
                //    HigherQty = txtHQty.Text.ToString();
                //    LowerQty = "-";
                //    higheruomID = ddlHUom.SelectedValue.ToString();
                //    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                //    LowerUom = "-";
                //    //higheruomID = ddlHUom.SelectedValue.ToString();
                //    loweruomID = "-";

                //}
                //else
                //{
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = txtLQty.Text.ToString();
                HigherUom = ddlHUom.SelectedItem.Text.ToString();
                higheruomID = ddlHUom.SelectedValue.ToString();
                loweruomID = ddlLUom.SelectedValue.ToString();
                if (loweruomID=="")
                {
                    LowerUom = "";
                        
                }
                else
                {
                    LowerUom= ddlLUom.SelectedItem.Text.ToString();
                }
               
                ReasonID = ddlrsn.SelectedValue.ToString();
                if (ReasonID == "")
                {
                    Reason = "";
                }
                else
                {
                    Reason = ddlrsn.SelectedItem.Text.ToString();

                }
                if (HigherQty=="")
                {
                    HigherQty = "0";
                }
                if (LowerQty=="")
                {
                    LowerQty="0";
                }


                img = "";
                int ImageID = 0;
                foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                {
                    ImageID += 1;
                    string csvPath = Server.MapPath(("..") + @"/../UploadFiles/SRRequest/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    img = @"../../UploadFiles/SRRequest/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    ViewState["Image"] = img.ToString();
                }
                
               
                if (HigherQty=="0" && LowerQty=="0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>NoProducts('Invalid input data..You must enter considerable quantity along with products.');</script>", false);

                }
                else
                {
                    dts.Rows.Add(ID, Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID,Reason,ReasonID,img);

                }



            }
            else
            {
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = txtLQty.Text.ToString();
                    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                    higheruomID = ddlHUom.SelectedValue.ToString();
                    loweruomID = ddlLUom.SelectedValue.ToString();
                if (loweruomID == "")
                {
                    LowerUom = "";

                }
                else
                {
                    LowerUom = ddlLUom.SelectedItem.Text.ToString();
                }
                ReasonID = ddlrsn.SelectedValue.ToString();
                if (ReasonID == "")
                {
                    Reason = "";
                }
                else
                {
                    Reason = ddlrsn.SelectedItem.Text.ToString();

                }
                if (HigherQty == "")
                {
                    HigherQty = "0";
                }
                if (LowerQty == "")
                {
                    LowerQty = "0";
                }



                img = "";
                int ImageID = 0;
                foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                {
                    ImageID += 1;
                    string csvPath = Server.MapPath(("..") + @"/../UploadFiles/SRRequest/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    img = @"../../UploadFiles/SRRequest/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    ViewState["Image"] = img.ToString();
                }


                if (HigherQty == "0" && LowerQty == "0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>NoProducts('Invalid input data..You must enter considerable quantity along with products.');</script>", false);

                }
                else
                {
                    dts.Rows.Add(ID, Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID,Reason, ReasonID,img);

                }
            }
            ViewState["DataTable"] = dts;
            Session["DataTable"] = dts;
            Session["Customer"] = ddlCus.SelectedValue.ToString();
            Session["Type"] = ddlType.SelectedValue.ToString();
            Session["ReturnType"]=ddlReturn.SelectedValue.ToString();
          
            RadGrid1.DataSource = dts;
            RadGrid1.DataBind();

            Response.Redirect("AddReturnRequest.aspx?RId=" + ddlroute.SelectedValue.ToString() + "&RtnID=1" + "&cusID=" +ddlCus.SelectedValue.ToString()+"&"+ Session["DataTable"] );


        }
        public string Item()
        {

            string PID = "";
            int j = 0;

            DataTable dsc = (DataTable)ViewState["DataTable"];

            if (dsc != null)
            {
                foreach (DataRow row in dsc.Rows)
                {
                    int MarCount = (dsc.Rows.Count);

                    string prd_ID = row["ID"].ToString();

                    if (j == 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        PID += prd_ID.ToString();
                    }
                    j++;
                }
                return PID;
            }
            else
            {
                return "0";
            }


        }
        public string productCondition()
        {

            string ID = Item();
            string productCondition = "";
            string routeCondition = "";
            string rot = ddlroute.SelectedValue.ToString();
            string cus=ddlCus.SelectedValue.ToString();
            try
            {
                if (ID.Equals("0"))
                {
                    routeCondition = "and rot_ID = (" + rot + ")  and rcs_cus_ID in ("+cus+") ";
                    productCondition = " prd_ID not in (0)";
                }
                else
                {
                    routeCondition = "  and rot_ID = (" + rot + ") and rcs_cus_ID in (" + cus + ") ";
                    productCondition = " prd_ID not in (" + ID + ")";
                }
            }
            catch (Exception ex)
            {

            }

            productCondition += routeCondition;
            return productCondition;
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
                        string ID = row["ID"].ToString();
                        string HigherQty = row["HigherQty"].ToString();
                        string LowerQty = row["LowerQty"].ToString();
                        string higheruomID = row["higheruomID"].ToString();
                        string loweruomID = row["loweruomID"].ToString();
                        if (loweruomID == "") 
                        {
                            loweruomID = "0";
                        }
                        string Reason = row["ReasonID"].ToString();
                        if (Reason=="")
                        {
                            Reason= "0";
                        }
                        string img = row["img"].ToString();

                        //if (Mode.Equals("0"))
                        //{
                        createNode(ID, HigherQty, LowerQty, higheruomID, loweruomID,Reason,img, writer);
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

        private void createNode(string ID, string HigherQty, string LowerQty, string higheruomID, string loweruomID,string Reason,string img,XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("ID");
            writer.WriteString(ID);
            writer.WriteEndElement();
            writer.WriteStartElement("HigherQty");
            writer.WriteString(HigherQty);
            writer.WriteEndElement();
            writer.WriteStartElement("LowerQty");
            writer.WriteString(LowerQty);
            writer.WriteEndElement();
            writer.WriteStartElement("higheruomID");
            writer.WriteString(higheruomID);
            writer.WriteEndElement();
            writer.WriteStartElement("loweruomID");
            writer.WriteString(loweruomID);
            writer.WriteEndElement();
            writer.WriteStartElement("ReasonID");
            writer.WriteString(Reason);
            writer.WriteEndElement();

            writer.WriteStartElement("img");
            writer.WriteString(img);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void HUOM()
        {
            string ID = ddlProduct.SelectedValue.ToString();
            DataTable dt = objreq.loadList("SelHuomDrop", "sp_ReturnRequest", ID);
            ddlHUom.DataSource = dt;
            ddlHUom.DataTextField = "uom_Name";
            ddlHUom.DataValueField = "uom_ID";
            ddlHUom.DataBind();
        }
        public void LUOM()
        {
            string[] arry = { ddlHUom.SelectedValue.ToString() };
            string ID = ddlProduct.SelectedValue.ToString();
            ddlLUom.DataSource = objreq.loadList("SelectLowUomFromDrop", "sp_ReturnRequest", ID, arry);
            ddlLUom.DataTextField = "uom_Name";
            ddlLUom.DataValueField = "uom_ID";
            ddlLUom.DataBind();
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ddlHUom.ClearSelection();
            ddlLUom.ClearSelection();
            HUOM();
            txtLQty.Enabled= false;
        }

        protected void ddlHUom_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ddlLUom.ClearSelection();
            LUOM();
            txtLQty.Enabled = false;
        }
        public void Loadgrid()
        {

            DataTable dt = (DataTable)ViewState["DataTable"];
            RadGrid1.DataSource = dt;


        }
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Loadgrid();
        }

        protected void ddlLUom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            txtLQty.Enabled = true;
        }
    }
}