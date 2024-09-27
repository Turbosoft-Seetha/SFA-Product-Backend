using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class GRNHeader : System.Web.UI.Page
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
				if (Mode == 1) // While loading page from dashboard 
				{
					try
					{
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;

                        if (Session["InvFromDate"] != null)
						{
							rdfromDate.SelectedDate = DateTime.Parse(Session["InvFromDate"].ToString());
						}
						if (Session["InvToDate"] != null)
						{
							rdendDate.SelectedDate = DateTime.Parse(Session["InvToDate"].ToString());
						}
					}
					catch
					{

					}
					RegionFromDashboard();
					string region = REG();
					string regionCondition = " dep_reg_ID in (" + region + ")";

					Depot(regionCondition);
					DepoFromDashboard();
					string depo = DPO();
					string dpocondition = " dpa_dep_ID in (" + depo + ")";

					DpoArea(dpocondition);
					DepoAreaFromDashboard();
					string depoarea = DPOarea();
					string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";

					DpoSubArea(dpoareacondition);
					DepoSubAreaFromDashboard();
					string deposubarea = DPOsubarea();
					string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";

					//Route(dposubareacondition);
					//RouteFromDashboard();


				}
				else
				{

					//rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
					//rdendDate.SelectedDate = DateTime.Now;
                    try
                    {
                        if (Session["GRNFDate"] != null)
                        {

                            rdfromDate.SelectedDate = DateTime.Parse(Session["GRNFDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));


                        }
                        rdfromDate.MaxDate = DateTime.Now;

                        if (Session["GRNTDate"] != null)
                        {

                            rdendDate.SelectedDate = DateTime.Parse(Session["GRNTDate"].ToString());
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now;

                        }
                        rdendDate.MaxDate = DateTime.Now;
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }

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
                    //Route(dposubareacondition);
                    //int j = 1;
                    //foreach (RadComboBoxItem itmss in rdRoute.Items)
                    //{
                    //    itmss.Checked = true;
                    //    j++;
                    //}

                    try
                    {
                        GetGridSession(grvRpt, "GRN");

                        grvRpt.Rebind();
                    }

                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }
                
            }
		}
		public void RegionFromDashboard()
		{
			try
			{


				if (Session["Region"] != null)
				{
					string ids = Session["Region"].ToString();
					string[] words = ids.Split(',');

					foreach (var word in words)
					{
						foreach (RadComboBoxItem rd in ddlregion.Items)
						{
							if (rd.Value.Equals(word))
							{
								rd.Checked = true;
							}
						}
					}
				}
			}
			catch { }
		}
		public void DepoFromDashboard()
		{
			try
			{


				if (Session["Depo"] != null)
				{
					string ids = Session["Depo"].ToString();
					string[] words = ids.Split(',');

					foreach (var word in words)
					{
						foreach (RadComboBoxItem rd in ddldepot.Items)
						{
							if (rd.Value.Equals(word))
							{
								rd.Checked = true;
							}
						}
					}
				}
			}
			catch { }
		}
		public void DepoAreaFromDashboard()
		{
			try
			{


				if (Session["DepoArea"] != null)
				{
					string ids = Session["DepoArea"].ToString();
					string[] words = ids.Split(',');

					foreach (var word in words)
					{
						foreach (RadComboBoxItem rd in ddldpoArea.Items)
						{
							if (rd.Value.Equals(word))
							{
								rd.Checked = true;
							}
						}
					}
				}
			}
			catch { }
		}
		public void DepoSubAreaFromDashboard()
		{
			try
			{


				if (Session["Depo"] != null)
				{
					string ids = Session["DepoSubArea"].ToString();
					string[] words = ids.Split(',');

					foreach (var word in words)
					{
						foreach (RadComboBoxItem rd in ddldpoSubArea.Items)
						{
							if (rd.Value.Equals(word))
							{
								rd.Checked = true;
							}
						}
					}
				}
			}
			catch { }
		}
	
		public void LoadData()
		{
			
			string mainCondition = "";
			
			mainCondition = mainConditions();
			DataTable lstDatas = new DataTable();
			lstDatas = ObjclsFrms.loadList("ListGRNHeader", "sp_Transaction", mainCondition);
			grvRpt.DataSource = lstDatas;
			

		}

	

		protected void imgExcel_Click(object sender, ImageClickEventArgs e)
		{
			DataTable dt = new DataTable();

			int columncount = 0;

			foreach (GridColumn column in grvRpt.MasterTableView.Columns)
			{
				if (!string.IsNullOrEmpty(column.UniqueName)
					&& !string.IsNullOrEmpty(column.HeaderText)
					&& !column.HeaderText.Equals("Detail")
				   && !column.HeaderText.Equals("Edit") && !column.HeaderText.Equals("Image")
					)
				{


					if (column.Display == true)
					{
						columncount++;
						dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
					}
				}
			}

			DataRow dr;
			grvRpt.MasterTableView.AllowPaging = false;

			RadGrid dd = grvRpt;
			dd.AllowPaging = false;
			dd.Rebind();
			int x = grvRpt.MasterTableView.Items.Count;
			foreach (GridDataItem item in dd.MasterTableView.Items)
			{
				dr = dt.NewRow();
				int j = 0;
				for (int i = 1; i < grvRpt.MasterTableView.Columns.Count; i++)
				{
					if (grvRpt.MasterTableView.Columns[i].Display == true)
					{
						//if (i == 0)
						//{
						//    i++;


						//}
						//else
						//{

						//    dr[i] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
						//}


						if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail") &&
							!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
						{
							if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
							{
								if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;"))
								{
									dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
								}
								else
								{
									dr[j] = " ";
								}

								j++;

							}

						}
					}
				}
				dt.Rows.Add(dr);
			}
			SpreadStreamProcessingForXLSXAndCSV(dt);
		}
		private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
		{
			using (MemoryStream stream = new MemoryStream())
			{
				using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
				{
					using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
					{
						for (int i = 0; i < dt.Columns.Count; i++)
						{
							using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
							{
								//make sure the width of the columns is not excessively large
								//I reduced it to 100 in this iteration
								columnExporter.SetWidthInPixels(100);
							}
						}

						ExportHeaderRows(worksheetExporter, dt);

						foreach (DataRow row in dt.Rows)
						{
							using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
							{
								foreach (var item in row.ItemArray)
								{
									SpreadCellFormat normalFormat = new SpreadCellFormat();
									normalFormat.FontSize = 10;

									normalFormat.VerticalAlignment = SpreadVerticalAlignment.Center;
									normalFormat.HorizontalAlignment = SpreadHorizontalAlignment.Center;
									using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
									{

										cellExporter.SetValue(item.ToString());
										cellExporter.SetFormat(normalFormat);
									}
								}

							}
						}

					}
				}

				byte[] output = stream.ToArray();


				Response.ContentType = ContentType;
				Response.Headers.Remove("Content-Disposition");
				Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "GRN Header", "Xlsx"));
				Response.BinaryWrite(output);
				Response.End();
			}
		}


		private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
		{
			using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
			{
				double HeaderRowHeight = 30;
				rowExporter.SetHeightInPoints(HeaderRowHeight);

				SpreadCellFormat format = new SpreadCellFormat();
				format.IsBold = true;
				format.Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128));
				format.ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255));
				format.HorizontalAlignment = SpreadHorizontalAlignment.Center;
				format.VerticalAlignment = SpreadVerticalAlignment.Center;

				for (int i = 0; i < dt.Columns.Count; i++)
				{
					using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
					{
						cellExporter.SetFormat(format);
						cellExporter.SetValue(dt.Columns[i].ColumnName);
					}
				}
			}
		}



		protected void btnPDF_Click(object sender, ImageClickEventArgs e)
		{

		}

		public string mainConditions()
		{
            string statusCondition = "";
            string status = rdStatus.SelectedValue.ToString();
            string dateCondition = "";
		
			string mainCondition = "";
			try
			{
				string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
				dateCondition = " (cast(H.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                if (status.Equals("N"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('N') and grh_Currentlevel = 1 ";

                }
                else if (status.Equals("N2"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('N') and grh_Currentlevel = 2 ";
                }
                else if (status.Equals("P"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('P','PR') and grh_Currentlevel = 1 ";

                }
                else if (status.Equals("P2"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('P','PR') and grh_Currentlevel = 2 ";
                }
                else if (status.Equals("O"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('O') and grh_Currentlevel = 1 ";

                }
                else if (status.Equals("O2"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('O') and grh_Currentlevel = 2 ";
                }
                else if (status.Equals("C"))
                {
                    statusCondition = " and isnull(H.Status,'N') in ('C') and grh_Currentlevel = 0 ";
                }
                else
                {
                    statusCondition = " and isnull(H.Status,'N') in (H.Status)";
                }
            }
			catch (Exception ex)
			{

			}
			mainCondition += dateCondition;
            mainCondition += statusCondition;
            return mainCondition;
		}



		protected void lnkDOwnload_Click(object sender, EventArgs e)
		{
			try
			{
				if (Session["GRNFDate"] != null)
				{
					string fromdate = rdfromDate.SelectedDate.ToString();
					if (fromdate == Session["GRNFDate"].ToString())
					{
						rdfromDate.SelectedDate = DateTime.Parse(Session["GRNFDate"].ToString());
					}
					else
					{
						Session["GRNFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					}
				}
				else
				{
					rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
					Session["GRNFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

				}
				rdfromDate.MaxDate = DateTime.Now;

				if (Session["GRNTDate"] != null)
				{
					string todate = rdendDate.SelectedDate.ToString();
					if (todate == Session["GRNTDate"].ToString())
					{
						rdendDate.SelectedDate = DateTime.Parse(Session["GRNTDate"].ToString());
					}
					else
					{
						Session["GRNTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
					}

				}
				else
				{
					rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
					Session["GRNTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
				}
				rdendDate.MaxDate = DateTime.Now.AddDays(1);
			}
			catch(Exception)
			{
                Response.Redirect("~/SignIn.aspx");
            }
            LoadData();
			grvRpt.Rebind();
		}

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadData();
		}

		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "GRN");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            if (e.CommandName.Equals("Item"))
			{
				GridDataItem dataItem = e.Item as GridDataItem;
				string HID = dataItem.GetDataKeyValue("grh_ID").ToString();
				Response.Redirect("GRNDetail.aspx?hid=" + HID);
			}
		}
		//public void Route(string DposubAreaCondition)
		//{
		//	string[] arr = { DposubAreaCondition };
		//	rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
		//	rdRoute.DataTextField = "rot_Name";
		//	rdRoute.DataValueField = "rot_ID";
		//	rdRoute.DataBind();
		//}
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
			//Route(DposubAreaCondition);
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

		protected void rdCustomer_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{

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

                Response.Redirect("~/SignIn.aspx");


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
                Response.Redirect("~/SignIn.aspx");

            }

        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
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
    }
}