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
    public partial class ListCustomerWithoutRoute : System.Web.UI.Page
    {
       
            GeneralFunctions ObjclsFrms = new GeneralFunctions();
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {

                }
            }
            public void LoadList()
            {
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("ListCustomerwithoutRoute", "sp_Merchandising");
                grvRpt.DataSource = lstUser;
            }
            protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
            {
                LoadList();
            }

            protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
            {
            //if (e.CommandName.Equals("Edit"))
            //{
            //    GridDataItem dataItem = e.Item as GridDataItem;
            //    string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
            //    Response.Redirect("AddEditCustomer.aspx?Id=" + ID);
            //}
            if (e.CommandName.Equals("Location"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ListCustomerInnerLocation.aspx?CId=" + ID);
            }
            if (e.CommandName.Equals("Asset"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ListAssetMaster.aspx?CId=" + ID);
            }

            if (e.CommandName.Equals("Documents"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cus_ID").ToString();
                Response.Redirect("ListDocuments.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Map"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string geoCode = dataItem["cus_GeoCode"].Text.ToString();
                string map = "http://maps.google.com?q=" + geoCode.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Open", "window.open('" + map + "');", true);

            }

        }

           


            protected void Excel_Click(object sender, ImageClickEventArgs e)
            {


                DataTable dt = new DataTable();

                int columncount = 0;

                foreach (GridColumn column in grvRpt.MasterTableView.Columns)
                {
                    if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Asset")
                        && !column.HeaderText.Equals("Documents") && !column.HeaderText.Equals("Signature") && !column.HeaderText.Equals("Location")
                        && !column.HeaderText.Equals("GeoCode") && !column.UniqueName.Equals("Edit")
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


                            if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                            {
                                if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Asset")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Documents"))
                                    && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Location")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("GeoCode")))
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
            private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Customer")
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
                    Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customers", "Xlsx"));
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