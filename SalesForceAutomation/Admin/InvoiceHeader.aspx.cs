using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Common.FormatProviders;
using Telerik.Windows.Documents.Flow.Model;
using Telerik.Windows.Documents.Flow.Model.Editing;
using Telerik.Windows.Documents.Flow.Model.Styles;
using Telerik.Windows.Documents.Spreadsheet.Model;
using Table = Telerik.Windows.Documents.Flow.Model.Table;
using TableCell = Telerik.Windows.Documents.Flow.Model.TableCell;
using TableRow = Telerik.Windows.Documents.Flow.Model.TableRow;


namespace SalesForceAutomation.Admin
{
    public partial class InvoiceHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                //LoadROute();
                rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                rdendDate.SelectedDate = DateTime.Now;
                //rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                //rdendDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);
                Customers();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }
        public void Customers()
        {
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomer", "sp_Masters");
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void BadReturn()
        {


            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("LoadOutBadRtnDetail", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
            ViewState["db"] = lstDatas;
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelInvoiceByID", "sp_Masters", ResponseID.ToString());
            ViewState["HeaderData"] = lstDatas;
            
        }


        public void EditDoc()
        {

            Telerik.Windows.Documents.Flow.FormatProviders.Docx.DocxFormatProvider provider = new Telerik.Windows.Documents.Flow.FormatProviders.Docx.DocxFormatProvider();
            using (Stream input = File.OpenRead(Server.MapPath("../UploadFiles/Template/Invoice.docx")))
            {

                byte[] renderedBytes = null;

                RadFlowDocument flowDocument = null;

                for (int x = 0; x < 5; x++)
                {



                RadFlowDocument document = provider.Import(input);



                RadFlowDocumentEditor editor = new RadFlowDocumentEditor(document);


                DataTable dtHeader = (DataTable)ViewState["HeaderData"];
                if (dtHeader.Rows.Count > 0)
                {



                    Header defaultHeader = document.Sections.First().Headers.Default;
                    // Create header and move the editor 
                    editor.MoveToParagraphStart(defaultHeader.Blocks.AddParagraph());



                    editor.ReplaceText("{1}", dtHeader.Rows[0]["csh_Code"].ToString());
                    editor.ReplaceText("{2}", dtHeader.Rows[0]["csh_Name"].ToString());
                    editor.ReplaceText("{3}", dtHeader.Rows[0]["csh_Code"].ToString());
                    editor.ReplaceText("{4}", dtHeader.Rows[0]["cus_Name"].ToString());

                    //editor.ReplaceText("{4}", DateTime.Now.ToString("dd-MMM-yyyy"));
                    editor.ReplaceText("{5}", dtHeader.Rows[0]["lih_TransID"].ToString());
                    editor.ReplaceText("{6}", dtHeader.Rows[0]["cus_Address"].ToString());
                    editor.ReplaceText("{7}", dtHeader.Rows[0]["inv_InvoiceID"].ToString());
                    editor.ReplaceText("{8}", dtHeader.Rows[0]["CreatedDate"].ToString());
                    editor.ReplaceText("{9}", dtHeader.Rows[0]["rot_Name"].ToString());
                    editor.ReplaceText("{10}", dtHeader.Rows[0]["Voidstatus"].ToString());
                    editor.ReplaceText("{11}", dtHeader.Rows[0]["Voiduser"].ToString());
                    editor.ReplaceText("{12}", dtHeader.Rows[0]["VoidDate"].ToString());
                    editor.ReplaceText("{13}", dtHeader.Rows[0]["Voidmode"].ToString());


                    //string number = amountInWords.ConvertAmount(double.Parse(dtHeader.Rows[0]["inv_TotalAmount"].ToString()));
                    //editor.ReplaceText("{16}", number.ToUpper());
                }

                editor.InsertText("Sales");
                Table table = editor.InsertTable();

                document.StyleRepository.AddBuiltInStyle(BuiltInStyleNames.TableGridStyleId);
                table.StyleId = BuiltInStyleNames.TableGridStyleId;


                ThemableColor cellBackground = new ThemableColor(Colors.DarkGray);


                DataTable dtDetail = (DataTable)ViewState["dt"];
                DataTable dtDetails = (DataTable)ViewState["df"];
                DataTable dtDetaill = (DataTable)ViewState["db"];
                DataTable dtDetailll = (DataTable)ViewState["dd"];
                for (int i = -1; i < dtDetail.Rows.Count + 1; i++)
                {
                    TableRow row = table.Rows.AddTableRow();
                    string[] Colums = { "Sr#", "Item Code", "Item Name", "UPC", "Cs/PC Qty", "Cs Price", "Pc Price", "Disc", "Sub Total", "VAT ", "Total " };
                    string[] DataColums = { "S#", "prd_Code", "prd_Name", "prd_UPC", "ind_CaseQty", "ind_CasePrice", "ind_PiecePrice", "Disc", "ind_LineTotal", "ind_LineVAT", "subTot" };
                    int[] ColumsWidth = { 60, 105, 200, 60, 100, 90, 120, 100, 120, 100, 90 };

                    for (int j = 0; j < Colums.Length; j++)
                    {
                        if (i == -1)
                        {
                            //Table Heading names configuration
                            TableCell cell = row.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(Colums[j]);
                            runCellTextFormat.FontSize = 12;
                            runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                            cell.Shading.BackgroundColor = cellBackground;
                            cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);
                        }
                        else if (i <= dtDetail.Rows.Count - 1)
                        {
                            //Table Data Configuration
                            TableCell cell = row.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(dtDetail.Rows[i][DataColums[j]].ToString());
                            runCellTextFormat.FontSize = 12;

                            cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);
                        }
                        else
                        {
                            //Last Summary Row Configuration
                            TableCell cell = row.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            cell.Shading.BackgroundColor = cellBackground;


                            if (j == 6)
                            {
                                //Total

                                Run runCellTextFormat = cellPar.Inlines.AddRun("Sales Total");
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackground;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);

                            }
                            else if (j == 7)
                            {
                                //Net Value

                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["Disc"].ToString());
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackground;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);

                            }
                            else if (j == 8)
                            {
                                //Sub Total
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_SubTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackground;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);

                            }
                            else if (j == 9)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_VAT"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackground;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);


                            }
                            else if (j == 10)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_GrandTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackground;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidth[j]);


                            }

                        }

                    }
                }

                //FOC





                //Good return

                editor.InsertText("Delivery Report");
                Table tablesss = editor.InsertTable();

                document.StyleRepository.AddBuiltInStyle(BuiltInStyleNames.TableGridStyleId);
                tablesss.StyleId = BuiltInStyleNames.TableGridStyleId;


                ThemableColor cellBackgroundddd = new ThemableColor(Colors.DarkGray);



                for (int i = -1; i < dtDetailll.Rows.Count + 1; i++)
                {
                    TableRow rowg = tablesss.Rows.AddTableRow();
                    string[] Columsg = { "Sr#", "Item Code", "Item Name", "UPC", "Inv.Details", "Cs/PC Qty", "Cs Price", "Pc Price", "Disc", "Sub Total", "VAT ", "Total " };
                    string[] DataColumsg = { "S#", "prd_Code", "prd_Name", "prd_UPC", "inv_InvoiceID", "ind_CaseQty", "ind_CasePrice", "ind_PiecePrice", "Disc", "ind_LineTotal", "ind_LineVAT", "subTot" };
                    int[] ColumsWidthg = { 60, 105, 200, 60, 100, 90, 120, 90, 100, 120, 100, 90 };

                    for (int j = 0; j < Columsg.Length; j++)
                    {
                        if (i == -1)
                        {
                            //Table Heading names configuration
                            TableCell cell = rowg.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(Columsg[j]);
                            runCellTextFormat.FontSize = 12;
                            runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                            cell.Shading.BackgroundColor = cellBackgroundddd;
                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);
                        }
                        else if (i <= dtDetaill.Rows.Count - 1)
                        {
                            //Table Data Configuration
                            TableCell cell = rowg.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(dtDetailll.Rows[i][DataColumsg[j]].ToString());
                            runCellTextFormat.FontSize = 12;

                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);
                        }
                        else
                        {
                            //Last Summary Row Configuration
                            TableCell cell = rowg.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            cell.Shading.BackgroundColor = cellBackgroundddd;


                            if (j == 7)
                            {
                                //Total

                                Run runCellTextFormat = cellPar.Inlines.AddRun("Sales Total");
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgroundddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);

                            }
                            else if (j == 8)
                            {
                                //Net Value

                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["Disc"].ToString());
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgroundddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);

                            }
                            else if (j == 9)
                            {
                                //Sub Total
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_SubTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgroundddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);

                            }
                            else if (j == 10)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_VAT"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgroundddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);


                            }
                            else if (j == 11)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_GrandTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgroundddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthg[j]);


                            }

                        }

                    }
                }
                //Bad retun

                editor.InsertText("Return Report");
                Table tables = editor.InsertTable();

                document.StyleRepository.AddBuiltInStyle(BuiltInStyleNames.TableGridStyleId);
                tables.StyleId = BuiltInStyleNames.TableGridStyleId;


                ThemableColor cellBackgrounddd = new ThemableColor(Colors.DarkGray);



                for (int i = -1; i < dtDetaill.Rows.Count + 1; i++)
                {
                    TableRow rowb = tables.Rows.AddTableRow();
                    string[] Columsb = { "Sr#", "Item Code", "Item Name", "UPC", "Inv.Details", "Cs/PC Qty", "Cs Price", "Pc Price", "Disc", "Sub Total", "VAT ", "Total " };
                    string[] DataColumsb = { "S#", "prd_Code", "prd_Name", "prd_UPC", "inv_InvoiceID", "ind_CaseQty", "ind_CasePrice", "ind_PiecePrice", "Disc", "ind_LineTotal", "ind_LineVAT", "subTot" };
                    int[] ColumsWidthb = { 60, 105, 200, 60, 100, 90, 120, 90, 100, 120, 100, 90 };

                    for (int j = 0; j < Columsb.Length; j++)
                    {
                        if (i == -1)
                        {
                            //Table Heading names configuration
                            TableCell cell = rowb.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(Columsb[j]);
                            runCellTextFormat.FontSize = 12;
                            runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                            cell.Shading.BackgroundColor = cellBackgrounddd;
                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);
                        }
                        else if (i <= dtDetaill.Rows.Count - 1)
                        {
                            //Table Data Configuration
                            TableCell cell = rowb.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(dtDetaill.Rows[i][DataColumsb[j]].ToString());
                            runCellTextFormat.FontSize = 12;

                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);
                        }
                        else
                        {
                            //Last Summary Row Configuration
                            TableCell cell = rowb.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            cell.Shading.BackgroundColor = cellBackgrounddd;


                            if (j == 7)
                            {
                                //Total

                                Run runCellTextFormat = cellPar.Inlines.AddRun("Sales Total");
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgrounddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);

                            }
                            else if (j == 8)
                            {
                                //Net Value

                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["Disc"].ToString());
                                runCellTextFormat.FontSize = 12;

                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgrounddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);

                            }
                            else if (j == 9)
                            {
                                //Sub Total
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_SubTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgrounddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);

                            }
                            else if (j == 10)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_VAT"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgrounddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);


                            }
                            else if (j == 11)
                            {
                                //Net VAT
                                Run runCellTextFormat = cellPar.Inlines.AddRun(dtHeader.Rows[0]["inv_GrandTotal"].ToString());
                                runCellTextFormat.FontSize = 12;
                                runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                                cell.Shading.BackgroundColor = cellBackgrounddd;
                                cell.PreferredWidth = new TableWidthUnit(ColumsWidthb[j]);


                            }

                        }

                    }
                }

                editor.InsertText("FOC ");
                Table tabless = editor.InsertTable();
                document.StyleRepository.AddBuiltInStyle(BuiltInStyleNames.TableGridStyleId);
                tabless.StyleId = BuiltInStyleNames.TableGridStyleId;
                ThemableColor cellBackgroundd = new ThemableColor(Colors.DarkGray);


                for (int i = -1; i < dtDetails.Rows.Count + 1; i++)
                {
                    TableRow roww = tabless.Rows.AddTableRow();
                    string[] Columss = { "Sr#", "Item Code", "Item Name", "UPC", "Cs/PC Qty" };
                    string[] DataColumss = { "S#", "prd_Code", "prd_Name", "prd_UPC", "ind_CaseQty" };
                    int[] ColumsWidthh = { 100, 200, 200, 200, 200 };

                    for (int j = 0; j < Columss.Length; j++)
                    {

                        if (i == -1)
                        {
                            //Table Heading names configuration
                            TableCell cell = roww.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(Columss[j]);
                            runCellTextFormat.FontSize = 12;
                            runCellTextFormat.FontWeight = System.Windows.FontWeights.Bold;
                            cell.Shading.BackgroundColor = cellBackgroundd;
                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthh[j]);
                        }
                        else if (i <= dtDetails.Rows.Count - 1)
                        {
                            //Table Data Configuration
                            TableCell cell = roww.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            Run runCellTextFormat = cellPar.Inlines.AddRun(dtDetails.Rows[i][DataColumss[j]].ToString());
                            runCellTextFormat.FontSize = 12;

                            cell.PreferredWidth = new TableWidthUnit(ColumsWidthh[j]);
                        }
                        else
                        {
                            //Last Summary Row Configuration
                            TableCell cell = roww.Cells.AddTableCell();
                            Paragraph cellPar = cell.Blocks.AddParagraph();
                            cellPar.TextAlignment = Alignment.Left;
                            cell.Shading.BackgroundColor = cellBackgroundd;




                        }

                    }
                }





                //Heading Set
                //Query Set
                // Code level applying

                if (flowDocument == null)
                {
                    flowDocument = document;
                }
                else
                {
                    flowDocument.Merge(document);
                }


                }
                IFormatProvider<RadFlowDocument> formatProvider = new Telerik.Windows.Documents.Flow.FormatProviders.Pdf.PdfFormatProvider();
                using (MemoryStream ms = new MemoryStream())
                {
                    formatProvider.Export(flowDocument, ms);
                    renderedBytes = ms.ToArray();
                }

                Response.Clear();
                Response.AppendHeader("Content-Disposition", "attachment; filename=Invoice" + DateTime.Now.ToString("hhmmss") + ".pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(renderedBytes);
                Response.End();
            }
        }
    

    public void GoodReturn()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("LoadOutGoodRtnDetail", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
            ViewState["dd"] = lstDatas;
        }

        public void FOC()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListCustomerFOC", "sp_Masters");
            grvRpt.DataSource = lstUser;
            ViewState["df"] = lstUser;
        }


        protected void lnkDOwnload_Click1(object sender, EventArgs e)
        {
            LoadData();
            grvRpt.Rebind();
        }
        
        public void LoadROute()
        {
            DataTable dt = ObjclsFrms.loadList("SelRoute", "sp_Backend");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("inv_ID").ToString();
                Response.Redirect("InvoiceDetail.aspx?Id=" + ID);
            }
        }
        public void LoadData()
        {
            string fromDate, ToDate, Customer;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Customer = rdCustomer.SelectedValue.ToString();
            string[] arr = { fromDate, ToDate };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelInvoices", "sp_Merchandising", Customer, arr);
            grvRpt.DataSource = lstDatas;
            ViewState["dt"] = lstDatas;
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Invoice Collection Summary", "Xlsx"));
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
            EditDoc();
        }
    }
}