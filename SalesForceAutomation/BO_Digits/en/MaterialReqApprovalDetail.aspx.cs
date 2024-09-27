using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MaterialReqApprovalDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        private object txtAdjustedHQty;
        private object txtAdjustedLQty;

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["HID"], out ResponseID);
                return ResponseID;
            }
        }
        public string mode
        {
            get
            {
                string mode;
                return Request.Params["mode"];
                
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Store();
                HeaderData();              

                if (mode.Equals("AH"))
                {
                    lnkapvHold.Visible= false;
                    lnkUnHold.Visible= true;
                    lnkApprove.Visible= false;
                    pnlwar.Visible=false;
                }
                else if (mode.Equals("A"))
                {
                    lnkapvHold.Visible = false;
                    lnkApprove.Visible = false;
                    lnkReject.Visible = false;
                    pnlwar.Visible= false;
                }
                else if (mode.Equals("P"))
                {
                    lnkapvHold.Visible = true;
                    lnkApprove.Visible = true;
                    lnkReject.Visible = true;
                }
            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListMRApprovalHeaderbyID", "sp_MaterialRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblReqNo = (Label)rp.FindControl("lblReqNo");
                Label lblExpDate = (Label)rp.FindControl("lblExpDate");
                Label lblStore = (Label)rp.FindControl("lblStore");
                Label lblWarehouse = (Label)rp.FindControl("lblWarehouse");


                rp.Text = "Request ID: " + lstDatas.Rows[0]["mrh_Number"].ToString();
                lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
                lblExpDate.Text = lstDatas.Rows[0]["mrh_ExpDate"].ToString();                
                lblStore.Text = lstDatas.Rows[0]["store"].ToString();
                lblWarehouse.Text = lstDatas.Rows[0]["warehouse"].ToString();
                string str_ID= lstDatas.Rows[0]["mrh_str_ID"].ToString();
                string war_ID = lstDatas.Rows[0]["mrh_war_ID"].ToString();
                string platform = lstDatas.Rows[0]["reqfrom"].ToString();
                string expDate = lstDatas.Rows[0]["mrh_ExpDate"].ToString();

                if (str_ID=="")
                {
                    str_ID = " war_str_ID";
                }
                else
                {
                    str_ID = str_ID.ToString();
                }
                Warehouse(str_ID);

                if(lblWarehouse.Text != "")
                {
                    ddlWarehouse.SelectedValue = war_ID;
                }
                else
                {
                    ddlWarehouse.Text = "Choose a location";
                }

                if (platform=="APP")
                {
                    phApp.Visible = true;
                }
                else
                {
                    ddlRecLoc.SelectedValue = str_ID.ToString();
                    rdExpDate.SelectedDate = DateTime.Parse(expDate.ToString());
                    phApp.Visible = false;
                }
            }
        }
        public void Store()
        {
            ddlRecLoc.DataSource = ObjclsFrms.loadList("SelectStore", "sp_MaterialRequest");
            ddlRecLoc.DataTextField = "str_Name";
            ddlRecLoc.DataValueField = "str_ID";
            ddlRecLoc.DataBind();
        }

        public void Warehouse(string strID)
        {
            ddlWarehouse.DataSource = ObjclsFrms.loadList("SelectWareHouse", "sp_MaterialRequest", strID);
            ddlWarehouse.DataTextField = "war_Name";
            ddlWarehouse.DataValueField = "war_ID";
            ddlWarehouse.DataBind();
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListMRApprovalDetail", "sp_MaterialRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                ViewState["dd"] = lstDatas;

                
                

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                Telerik.Web.UI.RadNumericTextBox txtAdjustedLQty = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txtAdjustedLQty");
                Telerik.Web.UI.RadNumericTextBox txtAdjustedHQty = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txtAdjustedHQty");
                string ReqLUOM = dataItem["ReqLUOM"].Text;
                string ReqLQty = dataItem["RequestedLQty"].Text;

                if (txtAdjustedLQty != null)
                {
                    txtAdjustedLQty.Text = dataItem["AdjustedLQty"].Text;
                    txtAdjustedHQty.Text = dataItem["AdjustedHQty"].Text;
                }

                if (string.IsNullOrEmpty(ReqLUOM) || ReqLQty == "0" || string.IsNullOrEmpty(ReqLUOM) || ReqLQty == "0"|| ReqLUOM== "&nbsp;")
                {
                    txtAdjustedLQty.Visible = false;                   
                }

            }
        }
        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            if(ddlWarehouse.SelectedValue!= "")
            {
                string mode = "A";
                Save(mode);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Choose a picking location');</script>", false);
            }
            
        }
      
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaterialReqApprovalHeader.aspx");

        }


        public string GetSelectedItemsFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {
                       
                        RadNumericTextBox txtAdjustedHQty = (RadNumericTextBox)item.FindControl("txtAdjustedHQty");
                        RadNumericTextBox txtAdjustedLQty = (RadNumericTextBox)item.FindControl("txtAdjustedLQty");
                      
                        string Hqty = txtAdjustedHQty.Text.ToString();
                        string Lqty = txtAdjustedLQty.Text.ToString();
                        
                        if (Hqty=="" )
                        {
                            Hqty = item["RequestedHQty"].Text;
                        }
                        if (Lqty=="")
                        {
                            Lqty = item["RequestedLQty"].Text;
                        }

                        string mrd_ID = item.GetDataKeyValue("mrd_ID").ToString();
                        string prd_ID = item["prd_ID"].Text.ToString();
                        string ReqHUOM = item["ReqHUOM"].Text.ToString();
                        string ReqLUOM = item["ReqLUOM"].Text.ToString();
                        string RequestedHQty = item["RequestedHQty"].Text.ToString();
                        string RequestedLQty = item["RequestedLQty"].Text.ToString();
                        createNode(mrd_ID,prd_ID,ReqHUOM,ReqLUOM,RequestedHQty,RequestedLQty, Hqty, Lqty, writer);
                        c++;
                                                                  


                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                }

                if (c == 0)
                {
                    return null;
                }
                else
                {
                    return sw.ToString();
                }
            }
        }
        private void createNode(string mrd_ID, string prd_ID, string ReqHUOM, string ReqLUOM, string RequestedHQty, string RequestedLQty, string HQTY, string LQTY, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("mrd_ID");
            writer.WriteString(mrd_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("ReqHUOM");
            writer.WriteString(ReqHUOM);
            writer.WriteEndElement();

            writer.WriteStartElement("ReqLUOM");
            writer.WriteString(ReqLUOM);
            writer.WriteEndElement();

            writer.WriteStartElement("RequestedHQty");
            writer.WriteString(RequestedHQty);
            writer.WriteEndElement();

            writer.WriteStartElement("RequestedLQty");
            writer.WriteString(RequestedLQty);
            writer.WriteEndElement();

            writer.WriteStartElement("HQTY");
            writer.WriteString(HQTY);
            writer.WriteEndElement();

            writer.WriteStartElement("LQTY");
            writer.WriteString(LQTY);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        public void Save(string mode)
        {
            string mrdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            string warehouse = ddlWarehouse.SelectedValue.ToString();
            string store = ddlRecLoc.SelectedValue.ToString();
            string expDate = DateTime.Parse(rdExpDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            DataTable lstData = new DataTable();
            string[] arr = { user, ResponseID.ToString(), mode, warehouse, store, expDate };
            string resp = ObjclsFrms.SaveData("sp_MaterialRequest", "MRApproval", mrdID.ToString(), arr);
            int res = Int32.Parse(resp.ToString());
            if (res > 0 && mode.Equals("A"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Material Request Approved successfully'); </script>", false);

            }
            else if (res > 0 && mode.Equals("AH"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Material Request Approved and Holded successfully'); </script>", false);
            }
            else if (res == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('This Material Request is already considered'); </script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }
        }


        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
           // Save();
        }

        protected void lnkReject_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

        }

        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string mrdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            string remark = this.txtRemarks.InnerText.ToString();
            string mrhid = ResponseID.ToString();

            string[] arr = { mrhid.ToString(), user, remark.ToString() };
            string resp = ObjclsFrms.SaveData("sp_MaterialRequest", "RejectMR", mrdID.ToString(), arr);
            int res = Int32.Parse(resp);
            if (res ==1)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }
            else if (res==0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal2('This Material Request is already approved'); </script>", false);
            }
            else if (res ==2)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal2('This Material Request is already rejected'); </script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }



        }

        protected void lnkapvHold_Click(object sender, EventArgs e)
        {
            if (ddlWarehouse.SelectedValue != "")
            {
                string mode = "AH";
                Save(mode);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Choose a picking location');</script>", false);
            }
            
        }

        protected void lnkUnHold_Click(object sender, EventArgs e)
        {
            string mode = "A";
            Save(mode);
        }
    }
}