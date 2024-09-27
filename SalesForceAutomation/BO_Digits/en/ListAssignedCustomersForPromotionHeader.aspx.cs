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

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class ListAssignedCustomersForPromotionHeader : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				Promotions();
			}

		}
		
		public void Promotions()
		{
			DataTable dtp = ObjclsFrms.loadList("SelectPromotionforDrop", "sp_Web_Promotion");
			ddlPromotion.DataSource = dtp;
			ddlPromotion.DataTextField = "name";
			ddlPromotion.DataValueField = "id";
			ddlPromotion.DataBind();
		}
		public string Promo()
		{
			var ColelctionMarket = ddlPromotion.CheckedItems;
			string PromID = "";
			int j = 0;
			int MarCount = ColelctionMarket.Count;
			if (ColelctionMarket.Count > 0)
			{
				foreach (var item in ColelctionMarket)
				{
					//where 1 = 1 
					if (j == 0)
					{
						PromID += item.Value + ",";
					}
					else if (j > 0)
					{
						PromID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						PromID += item.Value;
					}
					j++;
				}
				return PromID;
			}
			else
			{
				return "rcp_prm_ID";
			}
		}
		protected void LinkButton1_Click(object sender, EventArgs e)
		{
			LoadList();
			grvRpt.Rebind();
		}

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadList();
		}
		public void LoadList()
		{
			string condition = mainCondition();
			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("SelAssignedCustomerForPromotionHeader", "sp_Web_Promotion", condition);
			grvRpt.DataSource = lstUser;
		}

		public string mainCondition()
		{
			string mainCondition = "";
			string prmID = Promo();
			if (prmID.Equals(" "))
			{
				mainCondition = " rcp_prm_ID in ()";
			}
			else
			{
				mainCondition = "rcp_prm_ID in (" + prmID + ")";
			}

			return mainCondition;
		}
		protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
		{
			if (e.CommandName.Equals("Delete"))
			{
				GridDataItem dataItem = e.Item as GridDataItem;
				string ID = dataItem.GetDataKeyValue("rcp_ID").ToString();

			}
		}

		protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
		{
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName)
                    && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail")
                   && !column.HeaderText.Equals("Edit") && !column.HeaderText.Equals("Images")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail") &&
                            !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Images"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Competitor Activities", "Xlsx"));
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

    }
}