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
    public partial class SpecialPriceAssignedCustomers : System.Web.UI.Page
    {
        GeneralFunctions objfrm = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                spPrice();
            }
        }

        public void spPrice()
        {
            DataTable dt = objfrm.loadList("SelSpecialPrice", "sp_Masters");
            rdsprice.DataSource = dt;
            rdsprice.DataTextField = "Name";
            rdsprice.DataValueField = "prh_ID";
            rdsprice.DataBind();
        }

        public string SpecialPrice()
        {
            var ColelctionMarket = rdsprice.CheckedItems;
            string SPID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        SPID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        SPID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        SPID += item.Value;
                    }
                    j++;
                }
                return SPID;
            }
            else
            {
                return "0";
            }
        }
        public void List()
        {
            string condition = mainCondition();
            DataTable lstUser = default(DataTable);
            lstUser = objfrm.loadList("AssignedCustomerforspPrice", "sp_Masters", condition);
            RadGrid1.DataSource = lstUser;

            //}
        }

        public string mainCondition()
        {
            string mainCondition = "";
            string prmID = SpecialPrice();
            if (prmID.Equals(" "))
            {
                mainCondition = " prh_ID in ()";
            }
            else
            {
                mainCondition = "prh_ID in (" + prmID + ")";
            }

            return mainCondition;
        }
        protected void Filter_Click(object sender, EventArgs e)
        {
            List();
            RadGrid1.Rebind();

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in RadGrid1.MasterTableView.Columns)

            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail"))

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
                for (int i = 0; i < RadGrid1.MasterTableView.Columns.Count; i++)
                {
                    if (RadGrid1.MasterTableView.Columns[i].Display == true)
                    {

                        if (!item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if ((!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Asset")) && (!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Documents"))
                                && (!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Location")) && (!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("GeoCode"))
                                && (!RadGrid1.MasterTableView.Columns[i].HeaderText.Equals("Detail")))
                            {
                                if (!item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;"))
                                {
                                    dr[j] = item[RadGrid1.MasterTableView.Columns[i].UniqueName].Text;
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
            string sheetName = "SpecialPriceAssignedCustomers";
            SpreadStreamProcessingForXLSXAndCSV(dt, sheetName);
        }

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, string sheetName, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx)
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", sheetName.ToString(), "Xlsx"));
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