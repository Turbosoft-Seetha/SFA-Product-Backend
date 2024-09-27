using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class PartialDeliveryDetailApproval : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["HID"], out ResponseID);

                return ResponseID;
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
               
                  lnkConfirm.Visible = true;
                
                //HeaderDataAsync().wait();

            }
        }
        public void ListData()
        {

            DataTable lstUser = default(DataTable);
            
                lstUser = ObjclsFrms.loadList("LisPartialDeliveryDetail", "sp_DeliveryApproval", ResponseID.ToString());
                if (lstUser.Rows.Count >= 0)
                {
                    grvRpt.DataSource = lstUser;
                }
            
            
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListApprovalHeaderbyID", "sp_DeliveryApproval", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRouteID = (Label)rp.FindControl("lblRouteID");
                Label lblOrderID = (Label)rp.FindControl("lblOrderID");
                Label lblExpDelDate = (Label)rp.FindControl("lblExpDelDate");
                Label lblcustomer = (Label)rp.FindControl("lblcustomer");
               

                
                lblOrderID.Text = lstDatas.Rows[0]["OrderID"].ToString();
                lblExpDelDate.Text = lstDatas.Rows[0]["ExpectedDelDate"].ToString();
                lblcustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblRouteID.Text = lstDatas.Rows[0]["rot_Name"].ToString();
            }
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            
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
                        RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                        RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                        string selectedValue = rbActions.SelectedValue;
                        string Reason=reasonDrop.SelectedValue;
                        if (!string.IsNullOrEmpty(selectedValue))
                        {
                            // Do something with the selected value
                            if (Reason.Equals(""))
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                            }
                            else
                            {
                                if (selectedValue == "A")
                                {
                                    string Status = "A";
                                    string dad_ID = item.GetDataKeyValue("dad_ID").ToString();
                                    createNode(dad_ID, Reason, Status, writer);
                                    c++;
                                }
                                else if (selectedValue == "R")
                                {
                                    string Status = "R";
                                    string dad_ID = item.GetDataKeyValue("dad_ID").ToString();
                                    createNode(dad_ID, Reason, Status, writer);
                                    c++;
                                }
                            }
                        }


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
        private void createNode(string dad_ID,string Reason,string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("dad_ID");
            writer.WriteString(dad_ID);
            writer.WriteEndElement();
            writer.WriteStartElement("Reason");
            writer.WriteString(Reason);
            writer.WriteEndElement();
            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

       
        public void Save()
        {
            string dadID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user, ResponseID.ToString() };
            string resp = ObjclsFrms.SaveData("sp_DeliveryApproval", "PartialDeliveryApproval", dadID.ToString(), arr);
            int res = Int32.Parse(resp);
            string json = "";
            if (res > 0)
            {
                
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Partial Delivery Updated successfully');</script>", false);
                
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }


        }
        

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApprovalHeader.aspx");
        }

       

        
        protected void lnkConfirm_Click(object sender, EventArgs e)
        {

            if (grvRpt.MasterTableView.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }
            else
            {


                foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                {
                    RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                    RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");

                    string selectedValue = rbActions.SelectedValue;
                    string reason = reasonDrop.SelectedValue;
                    if (string.IsNullOrEmpty(selectedValue) ||reason.Equals(""))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        //break;
                    }
                   
                }
           //     GetSelectedItemsFromGrid();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                    reasonDrop.DataSource = ObjclsFrms.loadList("SelReason", "sp_DeliveryApproval");
                    reasonDrop.DataTextField = "rsn_Name";
                    reasonDrop.DataValueField = "rsn_ID";
                    reasonDrop.DataBind();


                }
            
            
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;
            
            
                radgrid2.MasterTableView.GetColumn("DropDownColum").Display = true;
                radgrid2.MasterTableView.GetColumn("btn").Display = true;
                radgrid2.MasterTableView.GetColumn("rsn_Name").Display = true;

            
        }
    }
}