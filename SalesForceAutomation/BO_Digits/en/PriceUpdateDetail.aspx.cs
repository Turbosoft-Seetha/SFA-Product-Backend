using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Web.UI.HtmlChart.Enums;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class PriceUpdateDetail : System.Web.UI.Page
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
                ViewState["creditlimit"] = "";
                HeaderData();

            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListPriceUpdateApprovalHeaderbyID", "sp_Transaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblTotCreditLimit = (Label)rp.FindControl("lblTotCreditLimit");




                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblTotCreditLimit.Text = lstDatas.Rows[0]["pch_TotCreditLimit"].ToString();
                ViewState["creditlimit"] = lstDatas.Rows[0]["pch_TotCreditLimit"].ToString();

                ViewState["CusType"] = lstDatas.Rows[0]["rcs_cusType"].ToString();

                string s = lstDatas.Rows[0]["pch_ApprovalStatus"].ToString();
                if (s == "AT")
                {
                    lnkConfirm.Visible = false;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = false;
                    radSelectAllApprove.Visible = false;
                    grvRpt.MasterTableView.GetColumn("pcd_ApprovedHPrice").Display = true;
                    grvRpt.MasterTableView.GetColumn("pcd_ApprovedLPrice").Display = true;
                   
                    

                }
                else
                {
                    lnkConfirm.Visible = true;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = true;
                    radSelectAllApprove.Visible = true;
                    grvRpt.MasterTableView.GetColumn("pcd_ApprovedHPrice").Display = false;
                    grvRpt.MasterTableView.GetColumn("pcd_ApprovedLPrice").Display = false;
                }


            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();

            lstDatas = ObjclsFrms.loadList("LisPriceUpdateApprovalDetail", "sp_Transaction", ResponseID.ToString());
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
                        RadNumericTextBox txtaprvdHprice = (RadNumericTextBox)item.FindControl("txtaprvdHprice");
                        RadNumericTextBox txtaprvdLprice = (RadNumericTextBox)item.FindControl("txtaprvdLprice");

                        string aprvdHprice = txtaprvdHprice.Text.ToString();
                        string aprvdLprice = txtaprvdLprice.Text.ToString();

                        if (aprvdHprice == "" || aprvdHprice == "0")
                        {
                            if (item["pcd_changedHPrice"].Text.ToString() == "")
                            {
                                aprvdHprice = item["pcd_stdHPrice"].Text.ToString();

                            }
                            else
                            {
                                aprvdHprice = item["pcd_changedHPrice"].Text.ToString();

                            }



                        }
                        if (aprvdLprice == "" || aprvdLprice == "0")
                        {
                            if (item["pcd_changedLPrice"].Text.ToString() == "")
                            {
                                aprvdLprice = item["pcd_stdLPrice"].Text.ToString();

                            }
                            else
                            {
                                aprvdLprice = item["pcd_changedLPrice"].Text.ToString();

                            }

                        }
                        string selectedValue = rbActions.SelectedValue;
                        string Reason = reasonDrop.SelectedValue;
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
                                    string pcd_ID = item.GetDataKeyValue("pcd_ID").ToString();
                                    createNode(pcd_ID, Reason, Status, aprvdHprice, aprvdLprice, writer);
                                    c++;
                                }
                                else if (selectedValue == "R")
                                {
                                    string Status = "R";
                                    string pcd_ID = item.GetDataKeyValue("pcd_ID").ToString();
                                    createNode(pcd_ID, Reason, Status, aprvdHprice, aprvdLprice, writer);
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
        private void createNode(string pcd_ID, string Reason, string Status, string aprvdHprice, string aprvdLprice, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("pcd_ID");
            writer.WriteString(pcd_ID);
            writer.WriteEndElement();
            writer.WriteStartElement("Reason");
            writer.WriteString(Reason);
            writer.WriteEndElement();
            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();
            writer.WriteStartElement("aprvdHprice");
            writer.WriteString(aprvdHprice);
            writer.WriteEndElement();
            writer.WriteStartElement("aprvdLprice");
            writer.WriteString(aprvdLprice);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        public void Save()
        {
            string pcdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user, pcdID.ToString() };

            string resp = ObjclsFrms.SaveData("sp_Transaction", "PriceUpdateApproval", ResponseID.ToString(), arr);
            int res = Int32.Parse(resp);
            string json = "";
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Price Update Request updated successfully');</script>", false);

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
            Response.Redirect("PriceUpdateHeader.aspx");

        }
        protected void lnkConfirm_Click(object sender, EventArgs e)
        {

            if (grvRpt.MasterTableView.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }
            else
            {

                decimal changeHprice = 0, changeLprice = 0, totchangedprice;
                foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                {
                    RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                    RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                    RadNumericTextBox txtaprvdHprice = (RadNumericTextBox)item.FindControl("txtaprvdHprice");
                    RadNumericTextBox txtaprvdLprice = (RadNumericTextBox)item.FindControl("txtaprvdLprice");
                    if (txtaprvdHprice.Text.ToString() == "")
                    {
                        if (item["pcd_changedHPrice"].Text.ToString() == "")
                        {
                            string AH = item["pcd_stdHPrice"].Text.ToString();
                            txtaprvdHprice.Text = AH;
                        }
                        else
                        {
                            string AH = item["pcd_changedHPrice"].Text.ToString();
                            txtaprvdHprice.Text = AH;
                        }

                    }
                    if (txtaprvdLprice.Text.ToString() == "")
                    {
                        if (item["pcd_changedLPrice"].Text.ToString() == "")
                        {
                            string AL = item["pcd_stdLPrice"].Text.ToString();
                            txtaprvdLprice.Text = AL;
                        }
                        else
                        {
                            string AL = item["pcd_changedLPrice"].Text.ToString();
                            txtaprvdLprice.Text = AL;
                        }

                    }
                    changeHprice = (decimal)txtaprvdHprice.Value;
                    changeLprice = (decimal)txtaprvdLprice.Value;
                    //changeHprice += changeHprice;
                    //changeLprice += changeLprice;
                    string selectedValue = rbActions.SelectedValue;
                    string reason = reasonDrop.SelectedValue;
                    if (string.IsNullOrEmpty(selectedValue) || reason.Equals(""))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        //break;
                    }

                }
                totchangedprice = changeLprice + changeHprice;
                decimal totcreditlimit = decimal.Parse(ViewState["creditlimit"].ToString());
                string custype = ViewState["CusType"].ToString();


                if (custype != "CS")
                {
                    if (totchangedprice > totcreditlimit)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Insufficient Creditlimit');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }

            }
        }
        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {


            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
                RadComboBox reasonDrop = (RadComboBox)itm.FindControl("ddlReason");
                reasonDrop.DataSource = ObjclsFrms.loadList("SelectReasonForPriceUpdate", "sp_Transaction");
                reasonDrop.DataTextField = "rsn_Name";
                reasonDrop.DataValueField = "rsn_ID";
                reasonDrop.DataBind();
                RadNumericTextBox apprvdHigherprice = (RadNumericTextBox)itm.FindControl("txtaprvdHprice");
                RadNumericTextBox apprvdLowerprice = (RadNumericTextBox)itm.FindControl("txtaprvdLprice");

                DataRowView dataItem = (DataRowView)itm.DataItem;

                // Populate the values of "pcd_changedLprice" and "pcd_changedHPrice" into the respective RadNumericTextBox controls
                if (dataItem != null)
                {
                    // Populate "pcd_changedLprice" into txtaprvdLprice
                    if (dataItem["pcd_changedLprice"] != DBNull.Value)
                    {
                        apprvdLowerprice.Value = (double?)System.Convert.ToDecimal(dataItem["pcd_changedLprice"]);

                        double stdLprice = double.Parse(dataItem["pcd_stdLPrice"].ToString());
                        double apprLPrice = double.Parse(apprvdLowerprice.Text.ToString());
                        if (stdLprice == apprLPrice)
                        {
                            apprvdLowerprice.Enabled = false;
                        }
                    }

                    // Populate "pcd_changedHPrice" into txtaprvdHprice
                    if (dataItem["pcd_changedHPrice"] != DBNull.Value)
                    {
                        apprvdHigherprice.Value = (double?)System.Convert.ToDecimal(dataItem["pcd_changedHPrice"]);
                        double stdHprice = double.Parse(dataItem["pcd_stdHPrice"].ToString());
                        double apprHPrice = double.Parse(apprvdHigherprice.Text.ToString());
                        if (stdHprice == apprHPrice)
                        {
                            apprvdHigherprice.Enabled = false;
                        }
                    }
                }

                if (dataItem["pcd_ApprovalStatus"].ToString ().Equals("A"))
                {
                    apprvdHigherprice.Enabled=false;
                    apprvdLowerprice.Enabled=false;
                }
                else if (dataItem["pcd_ApprovalStatus"].ToString().Equals("R"))
                {
                    apprvdHigherprice.Enabled = false;
                    apprvdLowerprice.Enabled = false;
                }
                else
                {
                    apprvdHigherprice.Enabled = true;
                    apprvdLowerprice.Enabled = true;
                }






                string maxhigherprice = itm["maxHigherlimit"].Text.ToString();
                string minhigherprice = itm["MinHigherLimit"].Text.ToString();
                string maxlowerprice = itm["maxLowerlimit"].Text.ToString();
                string minlowerprice = itm["MinLowerLimit"].Text.ToString();
                decimal maxhigh = decimal.Parse(maxhigherprice);
                decimal minhigh = decimal.Parse(minhigherprice);
                decimal maxlow = decimal.Parse(maxlowerprice);
                decimal minlow = decimal.Parse(minlowerprice);
                apprvdHigherprice.MaxValue = System.Convert.ToDouble(maxhigh);
                apprvdHigherprice.MinValue = System.Convert.ToDouble(minhigh);
                apprvdLowerprice.MaxValue = System.Convert.ToDouble(maxlow);
                apprvdLowerprice.MinValue = System.Convert.ToDouble(minlow);






                //if (apprvdHigherprice.Text.Equals("")|| apprvdHigherprice.Text.Equals(0))
                //{

                //}
                //else
                //{
                //    decimal aprvdHprice = decimal.Parse(apprvdHigherprice.Text.ToString());
                //    decimal maxhigherprice = decimal.Parse(item["maxHigherlimit"].Text.ToString());
                //    decimal minhigherprice = decimal.Parse(item["MinHigherLimit"].Text.ToString());
                //    if(aprvdHprice>= maxhigherprice && aprvdHprice<= minhigherprice)
                //    {

                //    }
                //    else
                //    {
                //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Not matching the Changing limit');</script>", false);

                //    }
                //}


                //if (apprvdLowerprice.Text.Equals("") || apprvdLowerprice.Text.Equals(0))
                //{

                //}
                //else
                //{
                //    decimal aprvdLprice = decimal.Parse(apprvdLowerprice.Text.ToString());
                //    decimal maxLowerprice = decimal.Parse(item["maxLowerlimit"].Text.ToString());
                //    decimal minLowerprice = decimal.Parse(item["MinLowerLimit"].Text.ToString());
                //    if (aprvdLprice >= maxLowerprice && aprvdLprice <= minLowerprice)
                //    {

                //    }
                //    else
                //    {
                //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Not matching the Changing limit');</script>", false);

                //    }
                //}
            }


        }

        protected void txtaprvdHprice_TextChanged(object sender, EventArgs e)
        {



        }

        protected void txtaprvdLprice_TextChanged(object sender, EventArgs e)
        {

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