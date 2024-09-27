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
    public partial class ListProducts : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                uomgrid.Visible= false;
            }
        }
        public void ListData()
        {
            DataTable lstdata = obj.loadList("ListProducts", "sp_Masters_UOM");
            if (lstdata.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstdata;
            }
        }
        public void Listuom()
        {
            DataTable lstdata = obj.loadList("ListProductsuom", "sp_Masters_UOM");
            if (lstdata.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstdata;
            }
        }
        protected void lnkAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddProducts.aspx");
        }
        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }
        protected void Products()
        {
            string name = "Products";
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image") && !column.HeaderText.Equals("Signature")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Signature")))
                            {
                                dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                                j++;
                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt,name);

        }
        protected void productuoms()
        {
            string name = "Product Uom";
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in RadGrid1.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image") && !column.HeaderText.Equals("Signature")
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
            RadGrid1.MasterTableView.AllowPaging = false;

            RadGrid dd = RadGrid1;
            dd.AllowPaging = false;
            dd.Rebind();
            int x = RadGrid1.MasterTableView.Items.Count;
            foreach (GridDataItem item in dd.MasterTableView.Items)
            {
                dr = dt.NewRow();
                int j = 0;
                for (int i = 1; i < RadGrid1.MasterTableView.Columns.Count; i++)
                {
                    if (RadGrid1.MasterTableView.Columns[i].Display == true)
                    {
                        

                        if (!item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if ((!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Image")) && (!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Signature")))
                            {
                                dr[j] = item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text;
                                j++;
                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt, name);

        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, string name, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "List")
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", name, "Xlsx"));
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
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))                                          
            {                                                                        
                GridDataItem dataItem = e.Item as GridDataItem;                        
                string ID = dataItem.GetDataKeyValue("prd_ID").ToString();           
                Response.Redirect("AddEditProducts.aspx?Id=" + ID);                        
            }
            if (e.CommandName.Equals("Route"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prd_ID").ToString();
                Response.Redirect("AssignRoutesForProduct.aspx?id=" + ID);
            }
            if (e.CommandName.Equals("ShowUOMs"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prd_ID").ToString();
                Response.Redirect("ShowUOMsForProduct.aspx?id=" + ID);
            }
        }

      

        protected void Product_Click(object sender, EventArgs e)
        {
            Products(); 
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confimclose();</script>", false);

        }

        protected void productuom_Click(object sender, EventArgs e)
        {
            productuoms();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confimclose();</script>", false);

        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Listuom();
        }
    }
}