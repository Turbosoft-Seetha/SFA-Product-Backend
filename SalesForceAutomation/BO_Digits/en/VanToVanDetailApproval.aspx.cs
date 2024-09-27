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
using static Stimulsoft.Report.Images.StiReportImages;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VanToVanDetailApproval : System.Web.UI.Page
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
            lstDatas = ObjclsFrms.loadList("SelectVanToVanHeaderByID", "sp_Transaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];

                Label lblTransInRot = (Label)rp.FindControl("lblTransInRot");
                Label lblTransOutRot = (Label)rp.FindControl("lblTransOutRot");

                Label lblDate = (Label)rp.FindControl("lblDateTime");

                Label lblStatus = (Label)rp.FindControl("lblStatus");

                rp.Text = "Transaction Number: " + lstDatas.Rows[0]["vvh_TransID"].ToString();

                lblTransOutRot.Text = lstDatas.Rows[0]["vvh_FromRot"].ToString();
                lblTransInRot.Text = lstDatas.Rows[0]["vvh_ToRot"].ToString();


                lblDateTime.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();

                string status = lstDatas.Rows[0]["Approval_Status"].ToString();

                if ((status == "AT") || (status == "R") || (status == "A"))
                {
                    radSelectAllApprove.Visible = false;
                    lnkApprove.Visible = false;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = false;
                    grvRpt.MasterTableView.GetColumnSafe("Status").Visible = true;
                }
                else
                {
                    lnkApprove.Visible = true;
                    radSelectAllApprove.Visible = true;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = true;
                    grvRpt.MasterTableView.GetColumnSafe("Status").Visible = false;

                }

            }
        }
        public void Data()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelectVanToVanDetailapproval", "sp_Transaction", ResponseID.ToString());
            grvRpt.DataSource = lstdata;
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Data();
        }



        public void Save()
        {

            string proID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user, ResponseID.ToString()};
            string resp = ObjclsFrms.SaveData("sp_Transaction", "VantoToVanReqApproval", proID.ToString(), arr);
            int res = Int32.Parse(resp);

            DataTable dt = new DataTable();

            dt = ObjclsFrms.loadList("CheckStatusForVanToVan", "sp_Transaction", ResponseID.ToString());

            if (dt.Rows.Count <= 0)
            {

                string resupdate = ObjclsFrms.SaveData("sp_Transaction", "UpdateStatusForVantoVan", ResponseID.ToString(),arr);
            }
            string json = "";
            if (res > 0)
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Van to Van Transfer request approved successfully');</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }
        }
        public bool IsSave()
        {
            bool Saveable= false;
            foreach (GridDataItem item in grvRpt.MasterTableView.Items)
            {
                RadioButton radbtnP = (RadioButton)item.FindControl("rdApprove");
                RadioButton radHD = (RadioButton)item.FindControl("rdReject");

                if (radbtnP.Checked == true || radHD.Checked == true)
                {
                    Saveable= true;
                }
                else
                {
                    Saveable= false;
                    break;
                }
            }
            return Saveable;
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
                        RadNumericTextBox HQnty = (RadNumericTextBox)item.FindControl("txtAppHQty");
                        RadNumericTextBox LQnty = (RadNumericTextBox)item.FindControl("txtAppLQty");
                        RadioButton radbtnP = (RadioButton)item.FindControl("rdApprove");
                        RadioButton radHD = (RadioButton)item.FindControl("rdReject");

                        if (string.IsNullOrEmpty(HQnty.Text) && string.IsNullOrEmpty(LQnty.Text))
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                        }
                        else
                        {
                            if (radbtnP.Checked==true)
                            {
                                string Status = "A";
                                string dad_ID = item.GetDataKeyValue("vvd_ID").ToString();
                                string HQTY = HQnty.Text.ToString();
                                string LQTY = LQnty.Text.ToString();
                                int higher = Int32.Parse(HQTY);
                                int lower = Int32.Parse(LQTY);
                                if (higher == 0 && lower == 0)
                                {
                                    Status = "R";

                                }
                                createNode(dad_ID, HQTY, LQTY, Status, writer);
                                c++;
                            }
                            else if (radHD.Checked == true)
                            {
                                string Status = "R";
                                string dad_ID = item.GetDataKeyValue("vvd_ID").ToString();
                                string HQTY = HQnty.Text.ToString();
                                string LQTY = LQnty.Text.ToString();
                                createNode(dad_ID, HQTY, LQTY, Status, writer);
                                c++;
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
        private void createNode(string dad_ID, string HQTY,string LQTY, string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("vvd_ID");
            writer.WriteString(dad_ID);
            writer.WriteEndElement();
            writer.WriteStartElement("HQTY");
            writer.WriteString(HQTY);
            writer.WriteEndElement();
            writer.WriteStartElement("LQTY");
            writer.WriteString(LQTY);
            writer.WriteEndElement();
            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }



        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            if (IsSave() == true)
            {
                Save();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("VanToVanHeaderApproval.aspx");
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
               
                    RadNumericTextBox RLQnty = (RadNumericTextBox)itm.FindControl("txtAppHQty");
                    RadNumericTextBox Qnty = (RadNumericTextBox)itm.FindControl("txtAppLQty");
                    string higherQty = itm["vvd_HQty"].Text.ToString();
                    string lowerQty = itm["vvd_LQty"].Text.ToString();
                    int higher = Int32.Parse(higherQty);
                    int lower = Int32.Parse(lowerQty);
                    
                    Qnty.MaxValue = lower;
                    RLQnty.MaxValue = higher;
                    RLQnty.Text = higherQty;
                    Qnty.Text = lowerQty;

                RadioButtonList rbActions = (RadioButtonList)itm.FindControl("rbActions");
               

            }
        }

        protected void radSelectAllApprove_CheckedChanged(object sender, EventArgs e)
        {
            if (radSelectAllApprove.Checked)
            {
                foreach (GridDataItem item in grvRpt.Items)
                {
                    RadioButton radPresent = (RadioButton)item.FindControl("rdApprove");
                    RadioButton radHD = (RadioButton)item.FindControl("rdReject") as RadioButton;

                    radPresent.Checked = true;
                    radHD.Checked = false;


                }
            }
        }

        protected void rdReject_CheckedChanged(object sender, EventArgs e)
        {
            radSelectAllApprove.Checked = false;
        }
    }
}