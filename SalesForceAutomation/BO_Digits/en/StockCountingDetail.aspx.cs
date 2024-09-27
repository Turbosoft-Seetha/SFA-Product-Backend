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
	public partial class StockCountingDetail : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
		public int HID
		{
			get
			{
				int HID;
				int.TryParse(Request.Params["hid"], out HID);

				return HID;
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
			lstDatas = ObjclsFrms.loadList("ListStockCountHeaderByID", "sp_Transaction", HID.ToString());
			if (lstDatas.Rows.Count > 0)
			{
				RadPanelItem rp = RadPanelBar0.Items[0];

				Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
				Label lbluser = (Label)rp.FindControl("lbluser");
                Label lblexpdate = (Label)rp.FindControl("lblexpdate");
                Label lbltype = (Label)rp.FindControl("lbltype");

                rp.Text = "Stock Count  No: " + lstDatas.Rows[0]["stk_trn_Number"].ToString();
				lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
				lbluser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblexpdate.Text = lstDatas.Rows[0]["stk_exp_Date"].ToString();
                lbltype.Text = lstDatas.Rows[0]["Type"].ToString();
            }
		}
		public void LoadList()

		{
			//string[] ar = { HID.ToString() };
			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("ListStockCountDetails", "sp_Transaction", HID.ToString());
			grvRpt.DataSource = lstUser;
		}
		protected void imgExcel_Click(object sender, ImageClickEventArgs e)
		{
			DataTable dt = new DataTable();

			int columncount = 0;

			foreach (GridColumn column in grvRpt.MasterTableView.Columns)
			{
				if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
					&& !column.HeaderText.Equals("Image")
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
				for (int i = 0; i < grvRpt.MasterTableView.Columns.Count; i++)
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


						if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
						{
							if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
							{
								dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
								j++;
							}

						}
					}
				}
				dt.Rows.Add(dr);
			}
			SpreadStreamProcessingForXLSXAndCSV(dt);
		}
		private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "AR")
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
				Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Stock Counting Detail", "Xlsx"));
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

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadList();
		}

		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{
            if (e.CommandName.Equals("Batch"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("std_ID").ToString();
                
                if ((dataItem["prd_IsBatchItem"].Text.Equals("Y")))
                {

                    Response.Redirect("StockCountingBatchDetail.aspx?ID=" + ID + "&&HID=" + HID);
                }
                else
                {
                    Response.Redirect("StockCountingSerailDetail.aspx?ID=" + ID + "&&HID=" + HID);
                }
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem item = (GridDataItem)e.Item;
                ImageButton btnBatch = (ImageButton)item.FindControl("Batch");
                if ((item["prd_IsBatchItem"].Text.Equals("Y"))|| (item["prd_IsBatchItem"].Text.Equals("S")))
                {
                    btnBatch.Visible = true;

                }
                else
                {
                    btnBatch.Visible = false;
                }


            }
        }
    }
}