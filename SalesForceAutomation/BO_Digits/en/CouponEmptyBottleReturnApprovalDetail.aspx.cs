using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class CouponEmptyBottleReturnApprovalDetail : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
		public int ResponseID
		{
			get
			{
				int ResponseID;
				int.TryParse(Request.Params["CPBID"], out ResponseID);
				return ResponseID;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				radSelectAllApprove.Checked = false;
				HeaderData();
				LoadData();
			}
		}
		public void HeaderData()
		{
			DataTable lstDatas = new DataTable();
			lstDatas = ObjclsFrms.loadList("ListReturnEmptyBottleApprovalHeaderbyID", "sp_CouponCollection", ResponseID.ToString());
			if (lstDatas.Rows.Count > 0)
			{
				RadPanelItem rp = RadPanelBar0.Items[0];
				Label lblRot = (Label)rp.FindControl("lblRot");
				Label lblUser = (Label)rp.FindControl("lblUser");
				Label lblDate = (Label)rp.FindControl("lblDate");
				Label lblCustomer = (Label)rp.FindControl("lblCustomer");
				//Label lblReqID = (Label)rp.FindControl("lblReqID");

				lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
				lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
				lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
				lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
				//lblReqID.Text = lstDatas.Rows[0]["rrh_RequestNumber"].ToString();

				string status = lstDatas.Rows[0]["Status"].ToString();
				LinkButton lnkConfirm = (LinkButton)RadAjaxPanel5.FindControl("lnkConfirm");

				if ((status == "A") || (status == "R") || (status == "AT"))
				{
					lnkConfirm.Visible = false;
					radSelectAllApprove.Visible = false;
				}
				else
				{
					lnkConfirm.Visible = true;
					radSelectAllApprove.Visible = true;
				}
			}
		}
		public void LoadData()
		{
			DataTable lstDatas = new DataTable();
			//string[] ar = { Mode.ToString() };
			lstDatas = ObjclsFrms.loadList("ListReturnEmptyBottleApprovalDetail", "sp_CouponCollection", ResponseID.ToString());
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
						string Reason;
						if (reasonDrop.SelectedValue.Equals(""))
						{
							Reason = "0";
						}
						else
						{
							Reason = reasonDrop.SelectedValue;
						}
						if (!string.IsNullOrEmpty(selectedValue))
						{
							// Do something with the selected value
							if (selectedValue.Equals("R") && Reason.Equals(""))
							{
								ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

							}
							else
							{
								if (selectedValue == "A")
								{
									string Status = "A";
									string dad_ID = item.GetDataKeyValue("cda_ID").ToString();
									createNode(dad_ID, Reason, Status, writer);
									c++;
								}
								else if (selectedValue == "R")
								{
									string Status = "R";
									string dad_ID = item.GetDataKeyValue("cda_ID").ToString();
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
			writer.WriteStartElement("cda_ID");
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
			string cdaID = GetSelectedItemsFromGrid();
			string user = UICommon.GetCurrentUserID().ToString();
			DataTable lstData = new DataTable();
			string[] arr = { user, cdaID.ToString() };

			string resp = ObjclsFrms.SaveData("sp_CouponCollection", "ReturnEmptyBottleApprovalSave", ResponseID.ToString(), arr);
			int res = Int32.Parse(resp);
			string json = "";
			if (res > 0)
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Return updated successfully');</script>", false);
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
			Response.Redirect("CouponEmptyBottleReturnApprovalHeader.aspx");

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
					if (string.IsNullOrEmpty(selectedValue))
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal('You must select  approve or reject for all the items listed here.');</script>", false);
						//break;
					}
					else if (selectedValue.Equals("R") && reason.Equals("") && radselectAllReject.Checked == false)
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal('Please select  Reason for reject');</script>", false);
						// break;
					}
					string ReturnQty = item["ReturnQty"].Text;
					//string ReturnLQty = item["ReturnLQty"].Text;

					if ((ReturnQty == "0") && selectedValue.Equals("A"))
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal('Zero quantity items cannot be approved!');</script>", false);

					}
				}
				//     GetSelectedItemsFromGrid();
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
			}
		}
		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{

		}

		protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
		{
			// Check if the current item is a data item (not header, footer, etc.)
			if (e.Item is GridDataItem)
			{
				GridDataItem item = (GridDataItem)e.Item;
				RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
				RadioButtonList types = (RadioButtonList)item.FindControl("rbActions");

				// Load data into the dropdown
				reasonDrop.DataSource = ObjclsFrms.loadList("SelectReasonforReurnReq", "sp_CouponCollection");
				reasonDrop.DataTextField = "rsn_Name";
				reasonDrop.DataValueField = "rsn_ID";
				reasonDrop.DataBind();

				string id = item["cda_ID"].Text;
				string status = item["ApprovalStatus"].Text;
				//string Type = item["Type"].Text;
				//int counts = Int32.Parse(item["counts"].Text);

				// Check if the current item has a type of 'BBFGR' or 'BBFBR'
				//if (counts > 0)
				//{
				//	disableAllItems = true;
				//}

				// Handle the UI changes based on the approval status
				if (status.Equals("Approved") || status.Equals("Rejected"))
				{
					GridTemplateColumn btnColumn = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("btn");
					btnColumn.Visible = false;
					GridTemplateColumn reason = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("DropDownColum");
					reason.Visible = false;
					GridBoundColumn rad_ApprovalStatus = (GridBoundColumn)grvRpt.MasterTableView.GetColumn("ApprovalStatus");
					rad_ApprovalStatus.Visible = true;
				}
				else
				{
					GridTemplateColumn btnColumn = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("btn");
					btnColumn.Visible = true;
					GridTemplateColumn reason = (GridTemplateColumn)grvRpt.MasterTableView.GetColumn("DropDownColum");
					reason.Visible = true;
					GridBoundColumn rad_ApprovalStatus = (GridBoundColumn)grvRpt.MasterTableView.GetColumn("ApprovalStatus");
					rad_ApprovalStatus.Visible = false;
					lnkConfirm.Visible = true;

					// Disable the controls based on the flag

					if (disableAllItems)
					{
						types.Enabled = false;
						reasonDrop.Enabled = false;
						radselectAllReject.Visible = true;
						BBnote.Visible = true;
					}
					else
					{
						types.Enabled = true;
						reasonDrop.Enabled = true;
						radselectAllReject.Visible = false;
						BBnote.Visible = false;
					}
				}
			}

		}
	

		protected void grvRpt_PreRender(object sender, EventArgs e)
		{
			//RadGrid radgrid2 = (RadGrid)sender;
			//if (Mode == "SC")
			//{
				//radgrid2.MasterTableView.GetColumn("RequestedQty").Display = true;
				//radgrid2.MasterTableView.GetColumn("AdjustedHQty").Display = true;
				//radgrid2.MasterTableView.GetColumn("ExcessHQty").Display = true;
				//radgrid2.MasterTableView.GetColumn("RequestedLQty").Display = true;
				//radgrid2.MasterTableView.GetColumn("AdjustedLQty").Display = true;
				//radgrid2.MasterTableView.GetColumn("ExcessLQty").Display = true;


			//}
			//else
			//{
			//	radgrid2.MasterTableView.GetColumn("RequestedHQty").Display = false;
			//	radgrid2.MasterTableView.GetColumn("AdjustedHQty").Display = false;
			//	radgrid2.MasterTableView.GetColumn("ExcessHQty").Display = false;
			//	radgrid2.MasterTableView.GetColumn("RequestedLQty").Display = false;
			//	radgrid2.MasterTableView.GetColumn("AdjustedLQty").Display = false;
			//	radgrid2.MasterTableView.GetColumn("ExcessLQty").Display = false;

			//}
		}
		protected void radSelectAllApprove_CheckedChanged(object sender, EventArgs e)
		{
			if (radSelectAllApprove.Checked)
			{
				radselectAllReject.Checked = false;
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

		protected void radselectAllReject_CheckedChanged(object sender, EventArgs e)
		{
			if (radselectAllReject.Checked)
			{
				radSelectAllApprove.Checked = false;
				foreach (GridDataItem item in grvRpt.Items)
				{
					RadioButtonList radPresent = (RadioButtonList)item.FindControl("rbActions");
					if (radPresent != null)
					{
						ListItem radApprove = radPresent.Items.FindByValue("A");
						ListItem radReject = radPresent.Items.FindByValue("R");
						if (radApprove != null && radReject != null)
						{
							radApprove.Selected = false;
							radReject.Selected = true;
						}
					}


				}
			}
		}
		bool disableAllItems = false; // Flag to determine whether to disable controls for all items
	}
}