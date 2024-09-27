﻿using System;
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
	public partial class CreditNoteApprovalWorkflow : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
		public int Mode
		{
			get
			{
				int Mode;
				int.TryParse(Request.Params["mode"], out Mode);

				return Mode;
			}
		}
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				plhFilter.Visible = false;
				Region();




				//lnkFilter.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
				rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
				rdendDate.SelectedDate = DateTime.Now;
				//rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
				//rdendDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);


				int o = 1;
				foreach (RadComboBoxItem itmss in ddlregion.Items)
				{
					itmss.Checked = true;
					o++;
				}
				string Reg = REG();
				string regcondition = " dep_reg_ID in (" + Reg + ")";
				Depot(regcondition);

				int p = 1;
				foreach (RadComboBoxItem itmss in ddldepot.Items)
				{
					itmss.Checked = true;
					p++;
				}
				string depo = DPO();
				string dpocondition = " dpa_dep_ID in (" + depo + ")";
				DpoArea(dpocondition);
				int q = 1;
				foreach (RadComboBoxItem itmss in ddldpoArea.Items)
				{
					itmss.Checked = true;
					q++;
				}
				string depoarea = DPOarea();
				string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
				DpoSubArea(dpoareacondition);
				int R = 1;
				foreach (RadComboBoxItem itmss in ddldpoSubArea.Items)
				{
					itmss.Checked = true;
					R++;
				}
				string deposubarea = DPOsubarea();
				string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
				Route(dposubareacondition);
				// RouteFromTransaction();

				string rotID = Rot();
				string routeCondition = "rcs_rot_ID in (" + rotID + ")";
				Customer(routeCondition);
				// CustomerFilter();
			}
		}

		public void RouteFromTransaction()
		{
			int j = 1;
			foreach (RadComboBoxItem itmss in rdRoute.Items)
			{
				itmss.Checked = true;
				j++;
			}
		}
		public void Route()
		{
			DataTable dt = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
			rdRoute.DataSource = dt;
			rdRoute.DataTextField = "rot_Name";
			rdRoute.DataValueField = "rot_ID";
			rdRoute.DataBind();
		}
		public void Customer(string routeCondition)
		{
			DataTable dtc = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_wb_merch_others", routeCondition);
			rdCustomer.DataSource = dtc;
			rdCustomer.DataTextField = "cus_Name";
			rdCustomer.DataValueField = "cus_ID";
			rdCustomer.DataBind();
		}

		public string Rot()
		{
			var ColelctionMarket = rdRoute.CheckedItems;
			string rotID = "";
			int j = 0;
			int MarCount = ColelctionMarket.Count;
			if (ColelctionMarket.Count > 0)
			{
				foreach (var item in ColelctionMarket)
				{
					//where 1 = 1 
					if (j == 0)
					{
						rotID += item.Value + ",";
					}
					else if (j > 0)
					{
						rotID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						rotID += item.Value;
					}
					j++;
				}
				return rotID;
			}
			else
			{
				return "cnh_rot_ID";
			}
		}

		public string Cus()
		{
			var ColelctionMarkets = rdCustomer.CheckedItems;
			string cusID = "";
			int k = 0;
			int MarCounts = ColelctionMarkets.Count;
			if (ColelctionMarkets.Count > 0)
			{
				foreach (var item in ColelctionMarkets)
				{
					//where 1 = 1 
					if (k == 0)
					{
						cusID += item.Value + ",";
					}
					else if (k > 0)
					{
						cusID += item.Value + ",";
					}
					if (k == (MarCounts - 1))
					{
						cusID += item.Value;
					}
					k++;
				}
				return cusID;
			}
			else
			{
				return "0";
			}
		}



		public string mainConditions(string rotID)
		{
			string cusID = Cus();
			string customerCondition = "";
			string dateCondition = "";
			string mainCondition = " cnh_rot_ID in (" + rotID + ")";
			string userID = UICommon.GetCurrentUserID().ToString();
			try
			{
				string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				dateCondition = " and A.Status='P' and uwl_usr_ID= " + userID;

				if (cusID.Equals("0"))
				{
					customerCondition = "";
				}
				else
				{
					customerCondition = " and cnh_cus_ID in (" + cusID + ")";
				}


			}
			catch (Exception ex)
			{

			}
			mainCondition += dateCondition;
			mainCondition += customerCondition;
			return mainCondition;
		}

		public void CustomerFilter()
		{
			int k = 1;
			foreach (RadComboBoxItem itme in rdCustomer.Items)
			{
				itme.Checked = true;
				k++;
			}
		}






		public void LoadList()
		{
			string rotID = Rot();
			if (!rotID.Equals("0"))
			{
				string mainCondition = "";

				mainCondition = mainConditions(rotID);


				DataTable lstUser = default(DataTable);
				lstUser = ObjclsFrms.loadList("SelCreditNoteReqApproval", "sp_wb_merch_others", mainCondition.ToString());
				grvRpt.DataSource = lstUser;
			}
		}

		protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string rotID = Rot();
			if (rotID.Equals("udp_rot_ID"))
			{
				rotID = "0";
			}
			string routeCondition = "rcs_rot_ID in (" + rotID + ")";
			Customer(routeCondition);
		}

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadList();
		}

		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{

		}

		protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
		{
			//if (e.Item is GridDataItem)
			//{
			//	GridDataItem item = (GridDataItem)e.Item;
			//	HyperLink pdf = (HyperLink)item.FindControl("pp2");
			//	string att = item["cnh_Attachment"].Text.Replace("&nbsp;", "");


			//	if (att.Equals(""))
			//	{
			//		pdf.Visible = false;
			//	}
			//	else
			//	{
			//		pdf.Visible = true;
			//	}
			//}
		}



		protected void lnkFilter_Click(object sender, EventArgs e)
		{
			LoadList();
			grvRpt.Rebind();
		}
		public void Route(string DposubAreaCondition)
		{
			string[] arr = { DposubAreaCondition };
			rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
			rdRoute.DataTextField = "rot_Name";
			rdRoute.DataValueField = "rot_ID";
			rdRoute.DataBind();
		}
		public void Region()
		{
			ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
			ddlregion.DataTextField = "reg_Name";
			ddlregion.DataValueField = "reg_ID";
			ddlregion.DataBind();
		}
		public void Depot(string RegCondition)
		{
			string[] arr = { RegCondition };
			ddldepot.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
			ddldepot.DataTextField = "dep_Name";
			ddldepot.DataValueField = "dep_ID";
			ddldepot.DataBind();
		}

		public void DpoArea(string DpoCondition)
		{
			string u = UICommon.GetCurrentUserID().ToString();
			string[] arr = { DpoCondition };
			ddldpoArea.DataSource = ObjclsFrms.loadList("SelectDepotAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
			ddldpoArea.DataTextField = "dpa_Name";
			ddldpoArea.DataValueField = "dpa_ID";
			ddldpoArea.DataBind();
		}
		public void DpoSubArea(string DpoAreaCondition)
		{
			string[] arr = { DpoAreaCondition };
			ddldpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
			ddldpoSubArea.DataTextField = "dsa_Name";
			ddldpoSubArea.DataValueField = "dsa_ID";
			ddldpoSubArea.DataBind();
		}
		public string REG()
		{
			var CollectionMarket1 = ddlregion.CheckedItems;
			string regID = "";
			int j = 0;
			int MarCount = CollectionMarket1.Count;
			if (CollectionMarket1.Count > 0)
			{
				foreach (var item in CollectionMarket1)
				{
					if (j == 0)
					{
						regID += item.Value + ",";
					}
					else if (j > 0)
					{
						regID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						regID += item.Value;
					}
					j++;
				}
				return regID;
			}
			else
			{
				return "0";
			}
		}
		public string DPO()
		{
			var CollectionMarket1 = ddldepot.CheckedItems;
			string dpoID = "";
			int j = 0;
			int MarCount = CollectionMarket1.Count;
			if (CollectionMarket1.Count > 0)
			{
				foreach (var item in CollectionMarket1)
				{
					if (j == 0)
					{
						dpoID += item.Value + ",";
					}
					else if (j > 0)
					{
						dpoID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						dpoID += item.Value;
					}
					j++;
				}
				return dpoID;
			}
			else
			{
				return "0";
			}
		}
		protected void ddldepot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string dpoID = DPO();
			string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
			DpoArea(DpoCondition);
		}

		protected void ddldpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string dpoareaID = DPOarea();
			string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
			DpoSubArea(DpoAreaCondition);
		}
		public string DPOarea()
		{
			var CollectionMarket2 = ddldpoArea.CheckedItems;
			string dpoareID = "";
			int j = 0;
			int MarCount = CollectionMarket2.Count;
			if (CollectionMarket2.Count > 0)
			{
				foreach (var item in CollectionMarket2)
				{
					if (j == 0)
					{
						dpoareID += item.Value + ",";
					}
					else if (j > 0)
					{
						dpoareID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						dpoareID += item.Value;
					}
					j++;
				}
				return dpoareID;
			}
			else
			{
				return "0";
			}
		}
		protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string dposubareaID = DPOsubarea();
			string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
			Route(DposubAreaCondition);
		}
		public string DPOsubarea()
		{
			var CollectionMarket3 = ddldpoSubArea.CheckedItems;
			string dposubareID = "";
			int j = 0;
			int MarCount = CollectionMarket3.Count;
			if (CollectionMarket3.Count > 0)
			{
				foreach (var item in CollectionMarket3)
				{
					if (j == 0)
					{
						dposubareID += item.Value + ",";
					}
					else if (j > 0)
					{
						dposubareID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						dposubareID += item.Value;
					}
					j++;
				}
				return dposubareID;
			}
			else
			{
				return "0";
			}
		}

		protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			string regID = REG();
			string RegCondition = " dep_reg_ID in (" + regID + ")";
			Depot(RegCondition);
		}

		protected void lnkAdvFilter_Click(object sender, EventArgs e)
		{
			if (plhFilter.Visible == true)
			{
				plhFilter.Visible = false;
			}
			else
			{
				plhFilter.Visible = true;
			}
		}
		protected void lnkReject_Click(object sender, EventArgs e)
		{
			int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
			if (addCount == 0)
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
			}
			else
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

			}

		}

		protected void lnkApprove_Click(object sender, EventArgs e)
		{
			int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
			if (addCount == 0)
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
			}
			else
			{

				DataTable lstApprovalLevel = ObjclsFrms.loadList("SelectUserLevelForCreditNoteApproval", "sp_wb_merch_others", UICommon.GetCurrentUserID().ToString());
				if (lstApprovalLevel.Rows.Count > 0)
				{
					int currentLevel, nextLevel;
					currentLevel = Int32.Parse(lstApprovalLevel.Rows[0]["CurrentLevel"].ToString());
					nextLevel = Int32.Parse(lstApprovalLevel.Rows[0]["NextLevel"].ToString());
					ViewState["currentLevel"] = currentLevel.ToString();
					ViewState["nextLevel"] = nextLevel.ToString();
					if (nextLevel == 0)
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('You are the final approver,Do you want to continue?');</script>", false);
					}
					else if (nextLevel > 0)
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('The Approval request will go to the next level user, Do you want to continue?');</script>", false);
					}
					else
					{
						ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

					}
				}

			}
		}

		protected void save_Click(object sender, EventArgs e)
		{
			string user = UICommon.GetCurrentUserID().ToString();

			string Req = GetItemFromGrid();

			string nectlvl = ViewState["nextLevel"].ToString();
			string[] arr = { user, nectlvl };
			string Value = ObjclsFrms.SaveData("sp_wb_merch_others", "ApproveCreditNoteRequest", Req, arr);
			int res = Int32.Parse(Value.ToString());
			if (res > 0)
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Approved Successfully');</script>", false);
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

					var ColelctionMarkets = grvRpt.SelectedItems;
					string cusIDs = "";
					int i = 0;
					int MarCount = ColelctionMarkets.Count;
					if (ColelctionMarkets.Count > 0)
					{
						foreach (GridDataItem dr in ColelctionMarkets)
						{
							//where 1 = 1
							string cnh_ID = dr.GetDataKeyValue("cnh_ID").ToString();

							createNode(cnh_ID, writer);
							c++;

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
						string ss = sw.ToString();
						return sw.ToString();
					}
				}
			}
		}

		private void createNode(string dag_ID, XmlWriter writer)
		{
			writer.WriteStartElement("Values");

			writer.WriteStartElement("cnh_ID");
			writer.WriteString(dag_ID);
			writer.WriteEndElement();

			writer.WriteEndElement();
		}
		protected void btnOK_Click(object sender, EventArgs e)
		{
			Response.Redirect("CreditNoteApprovalWorkflow.aspx");

		}
		protected void btnRejectSave_Click(object sender, EventArgs e)
		{
			string user = UICommon.GetCurrentUserID().ToString();

			string Req = GetItemFromGrid();


			string[] arr = { user };
			string Value = ObjclsFrms.SaveData("sp_wb_merch_others", "RejectCreditNoteRequest", Req, arr);
			int res = Int32.Parse(Value.ToString());
			if (res > 0)
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
			}

			else
			{
				ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
			}
		}
	}
}