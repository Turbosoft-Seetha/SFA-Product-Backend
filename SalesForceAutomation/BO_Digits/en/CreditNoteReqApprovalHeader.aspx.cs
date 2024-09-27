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
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class CreditNoteReqApprovalHeader : System.Web.UI.Page
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
                
                btnAll.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                DateCheck.Checked = true;

                if (Mode == 1) // While loading page from dashboard 
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;

                    try
                    {
                        if (Session["FromDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());

                        }
                        if (Session["ToDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());

                        }
                        Route();
                        Counts();
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");

                    }
                   
                }
				else
				{                  

                    if (Session["CRAFromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CRAFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    }
                    if (Session["CRAToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CRAToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now; ;
                    }
                    Route();
                    Counts();
                }
                try
				{
					
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
					if(Mode==1)
					{
                        if (Session["Route"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string rotID = Session["Route"].ToString();
                            string[] ar = rotID.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdRoute.Items)
                                {
                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            string routeCondition = " cnh_rot_ID in (" + rotID + ")";
                        }
                        else
                        {
                            string rotID = Rot();
                            string routeCondition = " cnh_rot_ID in (" + rotID + ")";

                        }
                    }
					else
					{
                        if (Session["CRArotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string rotID = Session["CRArotID"].ToString();
                            string[] ar = rotID.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdRoute.Items)
                                {


                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            string routeCondition = " cnh_rot_ID in (" + rotID + ")";
                        }
                        else
                        {
                            string rotID = Rot();
                            string routeCondition = " cnh_rot_ID in (" + rotID + ")";

                        }
                    }
					
					Customer();
					if (Session["CRAcusID"] != null)
					{
						int a = rdCustomer.Items.Count;
						string cusID = Session["CRAcusID"].ToString();
						string[] ar = cusID.Split(',');
						for (int i = 0; i < ar.Length; i++)
						{
							foreach (RadComboBoxItem items in rdCustomer.Items)
							{
								if (items.Value == ar[i])
								{
									items.Checked = true;
								}
							}
						}
					}
					else
					{
						string cusID = Cus();
						string customerCondition = " snr_cus_ID in (" + cusID + ")";
					}
                    if (Session["CRAStatus"] == null)
                    {
                        Session["CRAStatus"] = "";
                    }
                    else
                    {
                        //rdStatus.SelectedValue = Session["CRAStatus"].ToString();

                    }

                    try
					{
						GetGridSession(grvRpt, "CRA");
						grvRpt.Rebind();
					}

					catch (Exception ex)
					{
						String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
						ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CreditNoteReqApprovalHeader.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
					}
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}

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
		public void Customer()
		{

			string rotid = Rot();
			string route = "Where rcs_rot_id in(" + rotid + ")";
			rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomers", "sp_wb_merch_others", route.ToString());
			rdCustomer.DataTextField = "cus_Name";
			rdCustomer.DataValueField = "cus_ID";
			rdCustomer.DataBind();
		}
		public void Route()
		{

			string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string[] arr = { toDate.ToString() };
			rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_wb_merch_others", fromDate.ToString(), arr);
			rdRoute.DataTextField = "rot_Name";
			rdRoute.DataValueField = "rot_ID";
			rdRoute.DataBind();
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
			string status = Session["CRAStatus"].ToString();
			string statusCondition = "";

			try
			{
				if (Session["CRAStatus"].ToString() == "")
				{
					statusCondition = " and isnull(A.Status,'P') in ('P', 'AT', 'A', 'R') ";
				}
				else if (Session["CRAStatus"].ToString() == "P")
				{
					statusCondition = " and isnull(A.Status,'P') in ('P') ";
				}
				else if (Session["CRAStatus"].ToString() == "AT")
                {
					statusCondition = " and isnull(A.Status,'P') in ('AT') ";
				}
				else if (Session["CRAStatus"].ToString() == "A")
				{
                    statusCondition = " and isnull(A.Status,'P') in ('A') ";
                }
				else
				{
                    statusCondition = " and isnull(A.Status,'P') in ('R') ";
                }
                    
				if (DateCheck.Checked == true)
				{
					if (Mode ==1)
					{
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;
                    }
					else
					{
                        rdfromDate.Enabled = true;
                        rdendDate.Enabled = true;
                    }
					string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
					string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
					dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))  ";
				}
				else
				{
					rdfromDate.Enabled = false;
					rdendDate.Enabled = false;
                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    dateCondition = "";
                }


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
			mainCondition += statusCondition;
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
            string rotID = "";
            if (Session["Route"] != null)
            {
                rotID = Session["Route"].ToString();
            }
            else
            {
                rotID = Rot();
            }
           
		    string mainCondition = "";

		    mainCondition = mainConditions(rotID);
		    string user = UICommon.GetCurrentUserID().ToString();
			string[] arr = { user.ToString() };

			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("SelCreditNoteReqApproval", "sp_wb_merch_others", mainCondition.ToString(), arr);
			grvRpt.DataSource = lstUser;
			grvRpt.DataBind();
			
		}

		protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
		{
			Customer();
		}

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadList();
		}

		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{
			try
			{
				RadGrid grd = (RadGrid)sender;
				SetGridSession(grd, "CRA");
			}
			catch (Exception ex)
			{

			}
			if (e.CommandName.Equals("Detail"))
			{
				GridDataItem dataItem = e.Item as GridDataItem;
				string ID = dataItem.GetDataKeyValue("cnh_ID").ToString();

				Response.Redirect("CreditNoteReqApprovalDetail.aspx?ID=" + ID);

			}
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
			try
			{
				//Session["CRAStatus"] = rdStatus.SelectedValue.ToString();

				if (Session["CRAFromDate"] != null)
				{
					string fromdate = rdfromDate.SelectedDate.ToString();
					if (fromdate == Session["CRAFromDate"].ToString())
					{
						rdfromDate.SelectedDate = DateTime.Parse(Session["CRAFromDate"].ToString());
					}
					else
					{
						Session["CRAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					}
				}
				else
				{
					rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					Session["CRAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

				}
				// rdfromDate.MaxDate = DateTime.Now;

				if (Session["CRAToDate"] != null)
				{
					string todate = rdendDate.SelectedDate.ToString();
					if (todate == Session["CRAToDate"].ToString())
					{
						rdendDate.SelectedDate = DateTime.Parse(Session["CRAToDate"].ToString());
					}
					else
					{
						Session["CRAToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
					}

				}
				else
				{
					rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
					Session["CRAToDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
				}
				// rdendDate.MaxDate = DateTime.Now.AddDays(1);

				if (Session["CRArotID"] != null)
				{
					string route = Rot();
					if (route == Session["CRArotID"].ToString())
					{
						string rotID = Rot();

					}
					else
					{
						string rotID = Rot();
						Session["CRArotID"] = rotID;
					}


				}
				else
				{
					string rotID = Rot();
					Session["CRArotID"] = rotID;
				}

				if (Session["CRAcusID"] != null)
				{
					string customer = Cus();
					if (customer == Session["CRAcusID"].ToString())
					{
						string cusID = Cus();

					}
					else
					{
						string cusID = Cus();
						Session["CRAcusID"] = cusID;
					}

				}
				else
				{
					string cusID = Cus();
					Session["CRAcusID"] = cusID;
				}


			}
			catch (Exception ex)
			{

			}
			LoadList();
			grvRpt.Rebind();
			Counts();
		}
		public void Route(string DposubAreaCondition)
		{
			string[] arr = { DposubAreaCondition };
			rdRoute.DataSource = ObjclsFrms.loadList("SelectRoutes", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
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
			Response.Redirect("CreditNoteReqApprovalHeader.aspx");

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
		public void SetGridSession(RadGrid grd, string SessionPrefix)
		{
			try
			{
				foreach (GridColumn column in grd.MasterTableView.Columns)
				{
					if (column is GridBoundColumn boundColumn)
					{
						string columnName = boundColumn.UniqueName;
						string filterValue = column.CurrentFilterValue;
						Session[SessionPrefix + columnName] = filterValue;
					}
				}
			}
			catch (Exception ex)
			{

			}

		}
		public void GetGridSession(RadGrid grd, string SessionPrefix)
		{
			try
			{
				string filterExpression = string.Empty;
				foreach (GridColumn column in grd.MasterTableView.Columns)
				{
					if (column is GridBoundColumn boundColumn)
					{
						string columnName = boundColumn.UniqueName;
						if (Session[SessionPrefix + columnName] != null)
						{
							string filterValue = Session[SessionPrefix + columnName].ToString();
							if (filterValue != "")
							{
								column.CurrentFilterValue = filterValue;
								if (!string.IsNullOrEmpty(filterExpression))
								{
									filterExpression += " AND ";
								}
								filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);
							}
						}
					}
				}

				if (filterExpression != string.Empty)
				{
					grvRpt.MasterTableView.FilterExpression = filterExpression;
				}
			}

			catch (Exception ex)
			{

			}

		}

		protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
		{
			Route();
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;
                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }

		protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
		{
			Route();
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdfromDate.SelectedDate = startdate;
                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }


		protected void btnAll_Click(object sender, EventArgs e)
		{
			btnPending.Attributes.Remove("Style");
			btnActionTaken.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnAll.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
			Session["CRAStatus"] = "";
			LoadList();
			grvRpt.Rebind();
			Counts();
			
		}

		protected void btnPending_Click(object sender, EventArgs e)
		{
			btnAll.Attributes.Remove("Style");
			btnActionTaken.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
			Session["CRAStatus"] = "P";
			LoadList();
			grvRpt.Rebind();
			Counts();
		
		}
		protected void btnActionTaken_Click(object sender, EventArgs e)
		{
			btnAll.Attributes.Remove("Style");
			btnPending.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnActionTaken.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
			Session["CRAStatus"] = "AT";
			LoadList();
			grvRpt.Rebind();
			Counts();
			
		}

		protected void Counts()
		{
			
            string cusID = Cus();
            string rotID = "";
            if (Session["Route"]!=null)
			{
				rotID = Session["Route"].ToString();
			}
			else
			{
                rotID = Rot();
            }
		
            string mainCondition = "";
            string customerCondition = "";
			string dateCondition = "";
		
			mainCondition = " cnh_rot_ID in (" + rotID + ")";
			string userID = UICommon.GetCurrentUserID().ToString();
			string[] arr = { userID.ToString() };
			if (DateCheck.Checked == true)
			{
                if (Mode == 1)
                {
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                }
                else
                {
                    rdfromDate.Enabled = true;
                    rdendDate.Enabled = true;
                }
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))  ";
			}
			else
			{
				rdfromDate.Enabled = false;
				rdendDate.Enabled = false;

			}


			if (cusID.Equals("0"))
			{
				customerCondition = "";
			}
			else
			{
				customerCondition = " and cnh_cus_ID in (" + cusID + ")";
			}



			mainCondition += dateCondition;
			mainCondition += customerCondition;
			
			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("SelCreditNoteReqApprovalCount", "sp_wb_merch_others", mainCondition.ToString(), arr);			

			if (lstUser != null && lstUser.Rows.Count > 0)
			{
				btnAll.Text = "All(" + lstUser.Rows[0]["AllCount"].ToString() + ")";
				btnPending.Text = "Pending(" + lstUser.Rows[0]["PendingCount"].ToString() + ")";
				btnActionTaken.Text = "Action Taken(" + lstUser.Rows[0]["ActionTakenCount"].ToString() + ")";
                btnApproved.Text = "Approved(" + lstUser.Rows[0]["ApprovedCount"].ToString() + ")";
                btnRejected.Text = "Rejected(" + lstUser.Rows[0]["RejectedCount"].ToString() + ")";
            }
		}
        protected void DateCheck_CheckedChanged(object sender, EventArgs e)
        {            
            if (DateCheck.Checked)
			{
                if (Mode == 1)
                {
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                }
                else
                {
                    rdfromDate.Enabled = true;
                    rdendDate.Enabled = true;
                }
            }
			else
			{
                rdfromDate.Enabled = false;
                rdendDate.Enabled = false;
            }
            Counts();
            LoadList();

        }

        protected void btnApproved_Click(object sender, EventArgs e)
        {
            btnAll.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnPending.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnApproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["CRAStatus"] = "A";
            LoadList();
            grvRpt.Rebind();
            Counts();
        }

        protected void btnRejected_Click(object sender, EventArgs e)
        {
            btnAll.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnPending.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["CRAStatus"] = "R";
            LoadList();
            grvRpt.Rebind();
            Counts();
        }
    }
}