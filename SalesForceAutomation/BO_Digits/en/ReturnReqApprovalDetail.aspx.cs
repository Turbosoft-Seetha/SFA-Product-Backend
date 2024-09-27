using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using static Stimulsoft.Report.Images.StiReportImages;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class ReturnReqApprovalDetail : System.Web.UI.Page
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
                AssignRoute();


            }
		}

		public void HeaderData()
		{
			DataTable lstDatas = new DataTable();
			lstDatas = ObjclsFrms.loadList("ListReturnReqApprovalHeaderbyID", "sp_ReturnRequest", ResponseID.ToString());
			if (lstDatas.Rows.Count > 0)
			{
				RadPanelItem rp = RadPanelBar0.Items[0];
				Label lblDate = (Label)rp.FindControl("lblDate");
				Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblINV = (Label)rp.FindControl("lblINV");


                string INVID = lstDatas.Rows[0]["rrh_inv_ID"].ToString();
                if(string.IsNullOrEmpty(INVID) || INVID == "0")
                {
                    invid.Visible = false;
                }
                else
                {
                    invid.Visible = true;
                    lblINV.Text = lstDatas.Rows[0]["inv_InvoiceID"].ToString();

                }
                rp.Text = "Request ID: " + lstDatas.Rows[0]["rrh_RequestNumber"].ToString();
				lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
				lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();

                string status = lstDatas.Rows[0]["Status"].ToString();
              //  LinkButton lnkApprove = (LinkButton)rdd.FindControl("lnkApprove");


                if ((status == "AT") || (status == "R"))
                {
                    radSelectAllApprove.Visible= false;
                    lnkApprove.Visible = false;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = false;
                }
                else
                {
                    lnkApprove.Visible = true;
                    radSelectAllApprove.Visible = true;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = true;


                }



            }
        }
		public void LoadData()
		{
			DataTable lstDatas = new DataTable();
			lstDatas = ObjclsFrms.loadList("LisReturnReqApprovalDetail", "sp_ReturnRequest", ResponseID.ToString());
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
                GridDataItem item = (GridDataItem)e.Item;
                RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                GridTemplateColumn DropDownColum = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("DropDownColum");
                
                reasonDrop.DataSource = ObjclsFrms.loadList("SelectReasonforReurnReq", "sp_ReturnRequest");
                reasonDrop.DataTextField = "rsn_Name";
                reasonDrop.DataValueField = "rsn_ID";
                reasonDrop.DataBind();

                string status = item["Status"].Text;
                try
                {
                    if ((item["Status"].Text.Equals("A")))
                    {
                        rbActions.SelectedValue = "A";
                        rbActions.Enabled = false;
                        reasonDrop.Visible = false;
                        DropDownColum.Visible = false;
                        lnkApprove.Enabled = false;
                    }
                    else if ((item["detailStatus"].Text.Equals("R")))
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
     

		protected void lnkApprove_Click(object sender, EventArgs e)
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
                    if (string.IsNullOrEmpty(selectedValue) || reason.Equals(""))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        //break;
                    }
                   else if (selectedValue.Equals("A"))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confimmodel();</script>", false);

                    }

                }
                //     GetSelectedItemsFromGrid();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }





        }
		protected void save_Click(object sender, EventArgs e)
		{
            string rrdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            
            DataTable lstData = new DataTable();
            string[] arr = { user, ResponseID.ToString() };
            string resp = ObjclsFrms.SaveData("sp_ReturnRequest", "RetReqApproval", rrdID.ToString(), arr);
            int res = Int32.Parse(resp);

            DataTable dt = new DataTable();

            dt = ObjclsFrms.loadList("CheckStatus", "sp_ReturnRequest", ResponseID.ToString());

            if (dt.Rows.Count <= 0)
            {
                
                string resupdate = ObjclsFrms.SaveData("sp_ReturnRequest", "UpdateStatus", ResponseID.ToString(),arr);
            }
            string json = "";
            if (res > 0)
            {
                
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Return Request Updated successfully');</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }
        }



		protected void btnOK_Click(object sender, EventArgs e)
		{
			Response.Redirect("ReturnReqApprovalHeader.aspx");

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
                            if (Reason.Equals(""))
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                            }
                            else
                            {
                                if (selectedValue == "A")
                                {
                                    string Status = "A";
                                    string dad_ID = item.GetDataKeyValue("rrd_ID").ToString();
                                    createNode(dad_ID, Reason, Status, writer);
                                    c++;
                                }
                                else if (selectedValue == "R")
                                {
                                    string Status = "R";
                                    string dad_ID = item.GetDataKeyValue("rrd_ID").ToString();
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
            writer.WriteStartElement("rrd_ID");
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

            string rrdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            string Route = ddlRoute.SelectedValue.ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user, ResponseID.ToString(), Route.ToString() };
            string resp = ObjclsFrms.SaveData("sp_ReturnRequest", "RetReqApproval", rrdID.ToString(), arr);
            int res = Int32.Parse(resp);

            DataTable dt = new DataTable();

            dt = ObjclsFrms.loadList("CheckStatus", "sp_ReturnRequest", ResponseID.ToString());

            if (dt.Rows.Count <= 0)
            {

                string resupdate = ObjclsFrms.SaveData("sp_ReturnRequest", "UpdateStatus", ResponseID.ToString(), arr);
            }
            string json = "";
            if (res > 0)
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Return Request Updated successfully');</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
            }
        }


        public void AssignRoute()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_ReturnRequest");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            Save();
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