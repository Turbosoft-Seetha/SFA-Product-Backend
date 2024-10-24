using EnvDTE;
using SalesForceAutomation.Admin;
using Stimulsoft.Report.Dictionary;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Licensing;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Fixed.Model.Editing;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ItemWiseDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["ItemGrid"] = null;
                    ViewState["CustomerGrid"] = null;
                    ViewState["InvoiceGrid"] = null;

                    lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");

                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    }

                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                        Session["ToDate"] = rdendDate.SelectedDate.ToString();
                    }

                    rdfromDate.MaxDate = DateTime.Now;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    LoadItems();
                    ItemGrid.Rebind();

                    LoadCustomers("");
                    CustGrid.Rebind();

                    LoadInvoices("", "");
                    InvoiceGrid.Rebind();

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void LoadItems()
        {
            DataTable lstItem = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { ToDate.ToString() };

            lstItem = ObjclsFrms.loadList("ListItems", "sp_ItemwiseDashboard", fromDate.ToString(), arr);
            if (lstItem.Rows.Count > 0)
            {
                ItemGrid.DataSource = lstItem;
                ViewState["ItemGrid"] = lstItem;
            }
            else
            {
                ItemGrid.DataSource = new DataTable();
            }

        }

        public void LoadCustomers(string itm_ID = "")
        {
            DataTable lstItem = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), ToDate.ToString() };

            lstItem = ObjclsFrms.loadList("ListCustomers", "sp_ItemwiseDashboard", itm_ID, arr);
            if (lstItem.Rows.Count > 0)
            {
                CustGrid.DataSource = lstItem;
                ViewState["CustomerGrid"] = lstItem;
            }
            else
            {
                CustGrid.DataSource = new DataTable();
            }

        }

        public void LoadInvoices(string cus_ID = "", string itm_ID = "")
        {
            DataTable lstItem = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), ToDate.ToString(), itm_ID.ToString() };

            lstItem = ObjclsFrms.loadList("ListInvoices", "sp_ItemwiseDashboard", cus_ID, arr);
            if (lstItem.Rows.Count > 0)
            {
                InvoiceGrid.DataSource = lstItem;
                ViewState["InvoiceGrid"] = lstItem;
            }
            else
            {
                InvoiceGrid.DataSource = new DataTable();
            }

        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();

            Session["ItemGrid"] = null;
            Session["CustomerGrid"] = null;

            LoadItems();
            ItemGrid.Rebind();

            LoadCustomers("");
            CustGrid.Rebind();

            LoadInvoices("", "");
            InvoiceGrid.Rebind();
        }
        protected void lnkToday_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();

                LoadInvoices("", "");
                InvoiceGrid.Rebind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();

                LoadInvoices("", "");
                InvoiceGrid.Rebind();

            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();

                LoadInvoices("", "");
                InvoiceGrid.Rebind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ItemGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadItems();
        }
        protected void CustGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadCustomers("");
        }

        protected void ItemGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ItemGrid.SelectedItems.Count > 0)
            {
                GridDataItem selectedItem = (GridDataItem)ItemGrid.SelectedItems[0];
                string prd_ID = selectedItem.GetDataKeyValue("prd_ID").ToString();
                Session["SelectedPrdID"] = prd_ID;
                Session["SelectedCusID"] = null;

                LoadCustomers(prd_ID);
                CustGrid.Rebind();

                LoadInvoices("", prd_ID);
                InvoiceGrid.Rebind();

            }
        }
        protected void CustGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (CustGrid.SelectedItems.Count > 0)
            {
                GridDataItem selectedItem = (GridDataItem)CustGrid.SelectedItems[0];
                string cus_ID = selectedItem.GetDataKeyValue("cus_ID").ToString();
                string prd_ID = selectedItem["prd_ID"].Text.ToString();
                Session["SelectedCusID"] = cus_ID;

                LoadInvoices(cus_ID, prd_ID);
                InvoiceGrid.Rebind();

            }
        }
        protected void ItemGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("ItemClick"))
            {
                int itemIndex = System.Convert.ToInt32(e.CommandArgument);
                GridDataItem item = ItemGrid.MasterTableView.Items[itemIndex] as GridDataItem;

                if (item != null)
                {
                    foreach (GridDataItem di in ItemGrid.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    string prd_ID = item.GetDataKeyValue("prd_ID").ToString();
                    Session["SelectedPrdID"] = prd_ID;
                    Session["SelectedCusID"] = null;

                    LoadCustomers(prd_ID);
                    CustGrid.Rebind();

                    LoadInvoices("", prd_ID);
                    InvoiceGrid.Rebind();
                }

            }
        }
        protected void CustGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("CustomerClick"))
            {
                foreach (GridDataItem di in CustGrid.MasterTableView.Items)
                {
                    di.BackColor = Color.Transparent;
                }

                GridDataItem item = CustGrid.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];

                item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                string cus_ID = item.GetDataKeyValue("cus_ID").ToString();
                string cus_csh_ID = item["cus_csh_ID"].Text.ToString();
                Session["SelectedCusID"] = cus_ID;

            }
        }


        protected void InvoiceGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadInvoices("", "");
        }

        protected void InvoiceGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void OutletReset_Click(object sender, ImageClickEventArgs e)
        {
            CustGrid.SelectedIndexes.Clear();
            InvoiceGrid.SelectedIndexes.Clear();

            string prd_ID = "";
            Session["SelectedCusID"] = null;

            if (ItemGrid.SelectedIndexes.Count == 0)
            {
                Session["SelectedPrdID"] = null; 
            }
            else if (Session["SelectedPrdID"].ToString() != "")
            {
                prd_ID = Session["SelectedPrdID"].ToString();
            }
            else
            {
                prd_ID = "";
            }

            LoadCustomers(prd_ID);
            CustGrid.Rebind();

            LoadInvoices("", prd_ID);
            InvoiceGrid.Rebind();
        }


        protected void ItemReset_Click(object sender, ImageClickEventArgs e)
        {
            ItemGrid.SelectedIndexes.Clear();
            CustGrid.SelectedIndexes.Clear();
            InvoiceGrid.SelectedIndexes.Clear();

            Session["SelectedPrdID"] = null;
            Session["SelectedCusID"] = null;            

            LoadItems();
            ItemGrid.Rebind();

            LoadCustomers("");
            CustGrid.Rebind();

            LoadInvoices("","");
            InvoiceGrid.Rebind();
        }

        protected void OutletExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            int columncount = 0;
            foreach (GridColumn column in CustGrid.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Image"))
                {
                    if (column.Display == true)
                    {
                        columncount++;
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }
            foreach (GridDataItem item in CustGrid.MasterTableView.Items)
            {
                if (item.Visible)
                {
                    DataRow dr = dt.NewRow();
                    int j = 0;
                    for (int i = 0; i < CustGrid.MasterTableView.Columns.Count; i++)
                    {
                        if (CustGrid.MasterTableView.Columns[i].Display == true)
                        {
                            if (!item[CustGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")
                                && !CustGrid.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = !item[CustGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;")
                                    ? item[CustGrid.MasterTableView.Columns[i].UniqueName].Text
                                    : " ";
                                j++;
                            }
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
            SpreadStreamProcessingForXLSXAndCSVOutlet(dt);
        }

        protected void InvoiceExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            foreach (GridColumn column in InvoiceGrid.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Image"))
                {
                    if (column.Display)
                    {
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            foreach (GridDataItem item in InvoiceGrid.MasterTableView.Items)
            {
                if (item.Visible) 
                {
                    DataRow dr = dt.NewRow();
                    int j = 0;
                    for (int i = 0; i < InvoiceGrid.MasterTableView.Columns.Count; i++)
                    {
                        if (InvoiceGrid.MasterTableView.Columns[i].Display)
                        {
                            if (!item[InvoiceGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")
                                && !InvoiceGrid.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = !item[InvoiceGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;")
                                    ? item[InvoiceGrid.MasterTableView.Columns[i].UniqueName].Text
                                    : " ";
                                j++;
                            }
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
            SpreadStreamProcessingForXLSXAndCSVInvoice(dt);
        }

        protected void ItemExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            foreach (GridColumn column in ItemGrid.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Image"))
                {
                    if (column.Display)
                    {
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            foreach (GridDataItem item in ItemGrid.MasterTableView.Items)
            {
                if (item.Visible) 
                {
                    DataRow dr = dt.NewRow();
                    int j = 0;
                    for (int i = 0; i < ItemGrid.MasterTableView.Columns.Count; i++)
                    {
                        if (ItemGrid.MasterTableView.Columns[i].Display)
                        {
                            if (!item[ItemGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")
                                && !ItemGrid.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = !item[ItemGrid.MasterTableView.Columns[i].UniqueName].Text.Contains("&nbsp;")
                                    ? item[ItemGrid.MasterTableView.Columns[i].UniqueName].Text
                                    : " ";
                                j++;
                            }
                        }
                    }
                    dt.Rows.Add(dr);
                }
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
                        // Exporting the header
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }
                        ExportHeaderRows(worksheetExporter, dt);

                        // Exporting the data
                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat
                                    {
                                        FontSize = 10,
                                        VerticalAlignment = SpreadVerticalAlignment.Center,
                                        HorizontalAlignment = SpreadHorizontalAlignment.Center
                                    };
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

                // Sending the file for download
                byte[] output = stream.ToArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Items.xlsx");
                Response.BinaryWrite(output);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();  // Avoid using Response.End()
            }
        }
        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat
                {
                    IsBold = true,
                    Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128)),
                    ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255)),
                    HorizontalAlignment = SpreadHorizontalAlignment.Center,
                    VerticalAlignment = SpreadVerticalAlignment.Center
                };

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
        private void SpreadStreamProcessingForXLSXAndCSVOutlet(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        // Exporting the header
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }
                        ExportHeaderRowsOutlet(worksheetExporter, dt);

                        // Exporting the data
                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat
                                    {
                                        FontSize = 10,
                                        VerticalAlignment = SpreadVerticalAlignment.Center,
                                        HorizontalAlignment = SpreadHorizontalAlignment.Center
                                    };
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

                // Sending the file for download
                byte[] output = stream.ToArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Item-Wise Outlets.xlsx");
                Response.BinaryWrite(output);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();  // Avoid using Response.End()
            }
        }
        private void ExportHeaderRowsOutlet(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat
                {
                    IsBold = true,
                    Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128)),
                    ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255)),
                    HorizontalAlignment = SpreadHorizontalAlignment.Center,
                    VerticalAlignment = SpreadVerticalAlignment.Center
                };

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
        private void SpreadStreamProcessingForXLSXAndCSVInvoice(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        // Exporting the header
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                columnExporter.SetWidthInPixels(100);
                            }
                        }
                        ExportHeaderRowsInvoice(worksheetExporter, dt);

                        // Exporting the data
                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat
                                    {
                                        FontSize = 10,
                                        VerticalAlignment = SpreadVerticalAlignment.Center,
                                        HorizontalAlignment = SpreadHorizontalAlignment.Center
                                    };
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

                // Sending the file for download
                byte[] output = stream.ToArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Item-Wise Invoices.xlsx");
                Response.BinaryWrite(output);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();  // Avoid using Response.End()
            }
        }
        private void ExportHeaderRowsInvoice(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat
                {
                    IsBold = true,
                    Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128)),
                    ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255)),
                    HorizontalAlignment = SpreadHorizontalAlignment.Center,
                    VerticalAlignment = SpreadVerticalAlignment.Center
                };

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