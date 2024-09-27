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
using Telerik.Web.UI.Skins;
using static Stimulsoft.Report.Images.StiReportImages;
using RadComboBox = Telerik.Web.UI.RadComboBox;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class PartialDeliveryApprovalDetail : System.Web.UI.Page
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

            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListApprovalHeaderbyID", "sp_DeliveryApproval", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblOrder = (Label)rp.FindControl("lblOrder");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblFinalamount = (Label)rp.FindControl("lblFinalamount");

                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblOrder.Text = lstDatas.Rows[0]["OrderID"].ToString();
                lblDate.Text = lstDatas.Rows[0]["ExpectedDelDate"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblFinalamount .Text= lstDatas.Rows[0]["dah_FinalAmount"].ToString();

                string status = lstDatas.Rows[0]["dah_ApprovalStatus"].ToString();
                LinkButton lnkApprove = (LinkButton)rdd.FindControl("lnkApprove");

                if ((status == "A") || (status == "R") || (status == "AT"))
                {
                    lnkApprove.Visible = false;
                    radSelectAllApprove.Visible = false;
                }
                else
                {
                    lnkApprove.Visible = true;
                    radSelectAllApprove.Visible = true;
                }

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();

            lstDatas = ObjclsFrms.loadList("LisPartialDeliveryDetail", "sp_DeliveryApproval", ResponseID.ToString());
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
                        string Reason = reasonDrop.SelectedValue;
                        if (!string.IsNullOrEmpty(selectedValue))
                        {
                            // Do something with the selected value
                            if (Reason.Equals("") && selectedValue == "R")
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
        private void createNode(string dad_ID, string Reason, string Status, XmlWriter writer)
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
            string dad_ID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user, dad_ID.ToString() };

            string resp = ObjclsFrms.SaveData("sp_DeliveryApproval", "PartialDeliveryApproval", ResponseID.ToString(), arr);
            int res = Int32.Parse(resp);
            string json = "";
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Partial Delivery Request updated successfully');</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }


        }
        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }



        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("PartialDeliveryApprovalHeader.aspx");

        }
        protected void lnkConfirm_Click(object sender, EventArgs e)
        {

            if (grvRpt.MasterTableView.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }
            else
            {


                foreach (GridDataItem item in grvRpt.SelectedItems)
                {
                    RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                    RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");

                    string selectedValue = rbActions.SelectedValue;
                    string reason = reasonDrop.SelectedValue;
                    if (string.IsNullOrEmpty(selectedValue) || reason.Equals(""))
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
                RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                GridTemplateColumn DropDownColum = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("DropDownColum");
                reasonDrop.DataSource = ObjclsFrms.loadList("SelReason", "sp_DeliveryApproval");
                reasonDrop.DataTextField = "rsn_Name";
                reasonDrop.DataValueField = "rsn_ID";
                reasonDrop.DataBind();

                string status = item["dad_ApprovalStatus"].Text;
                try
                {
                    if (status.Equals("A"))
                    {
                        rbActions.SelectedValue = "A";
                        rbActions.Enabled = false;
                        reasonDrop.Visible = false;
                        DropDownColum.Visible = false;
                        lnkApprove.Enabled = false;
                    }
                    else if (status.Equals("R"))
                    {
                        rbActions.SelectedValue = "R";
                        rbActions.Enabled = false;
                        reasonDrop.Visible = false;
                        DropDownColum.Visible = false;
                        lnkApprove.Enabled = false;
                    }
                    else
                    {
                        rbActions.Enabled = true;
                    }
                }

                catch (Exception ex) { }

            }


        }
        protected void radSelectAllApprove_CheckedChanged(object sender, EventArgs e)
        {
            if (radSelectAllApprove.Checked)
            {
                foreach (GridDataItem item in grvRpt.Items)
                {
                    RadioButtonList radPresent = (RadioButtonList)item.FindControl("rbActions");
                    if (radPresent != null)
                    {
                        ListItem radApprove = radPresent.Items.FindByValue("A");
                        ListItem radReject = radPresent.Items.FindByValue("R");
                        if (radApprove != null && radReject != null)
                        {
                            radApprove.Selected = true;
                            radReject.Selected = false;
                        }
                    }


                }
            }
        }
    }
}