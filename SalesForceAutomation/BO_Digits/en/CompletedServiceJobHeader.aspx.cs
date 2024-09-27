using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Common.FormatProviders;
using Telerik.Windows.Documents.Flow.Model;
using Telerik.Windows.Documents.Flow.Model.Editing;
using Telerik.Windows.Documents.Flow.Model.Styles;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using Telerik.Windows.Documents.Spreadsheet.Model;
using Table = Telerik.Windows.Documents.Flow.Model.Table;
using TableCell = Telerik.Windows.Documents.Flow.Model.TableCell;
using TableRow = Telerik.Windows.Documents.Flow.Model.TableRow;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CompletedServiceJobHeader : System.Web.UI.Page
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

                if (Mode == 1) // While loading page from dashboard 
                {
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
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }
                else // While loading page from transaction menu
                {
                    try
                    {
                        if (Session["CSJFDate"] != null)
                        {

                            rdfromDate.SelectedDate = DateTime.Parse(Session["CSJFDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Now;


                        }
                        rdfromDate.MaxDate = DateTime.Now;

                        if (Session["CSJTDate"] != null)
                        {

                            rdendDate.SelectedDate = DateTime.Parse(Session["CSJTDate"].ToString());
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now.AddDays(1);

                        }
                        rdendDate.MaxDate = DateTime.Now.AddDays(1);
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }

                try
                {
                    if (Session["CSJAdvFilter"] != null)
                    {
                        if (Session["CSJAdvFilter"].ToString() == "true")
                        {
                            plhFilter.Visible = true;
                        }
                        else
                        {
                            plhFilter.Visible = false;
                        }
                    }
                    else
                    {
                        plhFilter.Visible = false;
                    }

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }





                Region();
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


                if (Session["CSJrotID"] != null)
                {
                    int a = rdRoute.Items.Count;
                    string route = Session["CSJrotID"].ToString();
                    string[] ar = route.Split(',');
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
                    string routeCondition = " rcs_rot_ID in (" + route + ")";
                    Customers(routeCondition);

                }
                else
                {
                    string rotID = Rot();
                    string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                    Customers(routeCondition);


                }
                if (Session["CSJcusID"] != null)
                {
                    int a = rdCustomer.Items.Count;
                    string cusID = Session["CSJcusID"].ToString();
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
                    string cusCondition = "A.cus_ID in (" + cusID + ")";
                }

                try
                {
                    GetGridSession(grvRpt, "CSJ");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ARHeader.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }



            }
        }
        public void LoadData()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("CompletedServiceJobHeader", "sp_ServiceRequest", mainCondition);
                grvRpt.DataSource = lstDatas;
            }

        }

        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customers(string routeCondition)
        {


            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerforTransaction", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();


        }
        public string Cus()
        {
            var CollectionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }

        }
        public string Rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
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
                return "sjh_rot_ID";
            }
        }
        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " sjh_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date)) ";
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and sjh_cus_ID in (" + cusID + ")";
                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("sjh_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = " sjh_rot_ID in (" + rotID + ")";
            Customers(routeCondition);


        }

        protected void rdCustomer_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkDOwnload_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["CSJFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["CSJFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["CSJFDate"].ToString());
                    }
                    else
                    {
                        Session["CSJFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["CSJFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["CSJTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["CSJTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["CSJTDate"].ToString());
                    }
                    else
                    {
                        Session["CSJTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["CSJTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["CSJrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["CSJrotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["CSJrotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["CSJrotID"] = rotID;
                }

                if (Session["CSJcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["CSJcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["CSJcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["CSJcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {

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

                SetGridSession(grd, "CSJ");
            }
            catch (Exception ex)
            {

            }


            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sjh_ID").ToString();
                string PayType = e.CommandArgument.ToString();
                Response.Redirect("CompletedServiceJobDetail.aspx?Id=" + ID);
            }
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {

            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image") && !column.HeaderText.Equals("Signature") && !column.HeaderText.Equals("Reciept Image")
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
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image") && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Signature")
                            && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Reciept Image"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "AR Collection Summary", "Xlsx"));
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

        public void EditDoc()
        {

            Telerik.Windows.Documents.Flow.FormatProviders.Docx.DocxFormatProvider provider = new Telerik.Windows.Documents.Flow.FormatProviders.Docx.DocxFormatProvider();
            using (Stream input = File.OpenRead(Server.MapPath("../UploadFiles/Template/ARDetails.docx")))
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
                        editor.ReplaceText("{3}", dtHeader.Rows[0]["cus_Code"].ToString());
                        // editor.ReplaceText("{4}", DateTime.Now.ToString("dd-MMM-yyyy"));
                        editor.ReplaceText("{4}", dtHeader.Rows[0]["cus_Name"].ToString());
                        editor.ReplaceText("{5}", dtHeader.Rows[0]["lih_TransID"].ToString());
                        editor.ReplaceText("{6}", dtHeader.Rows[0]["cus_Address"].ToString());
                        editor.ReplaceText("{7}", dtHeader.Rows[0]["arh_CollectedAmount"].ToString());
                        editor.ReplaceText("{8}", dtHeader.Rows[0]["CreatedDate"].ToString());
                        editor.ReplaceText("{9}", dtHeader.Rows[0]["arp_Image1"].ToString());
                        editor.ReplaceText("{10}", dtHeader.Rows[0]["arh_ARNumber"].ToString());
                        //editor.ReplaceText("{11}", dtHeader.Rows[0]["SyncedDateTime"].ToString());
                        //editor.ReplaceText("{12}", dtHeader.Rows[0]["usr_Name"].ToString());
                        editor.ReplaceText("{13}", dtHeader.Rows[0]["Voidstatus"].ToString());
                        editor.ReplaceText("{14}", dtHeader.Rows[0]["Voiduser"].ToString());
                        editor.ReplaceText("{15}", dtHeader.Rows[0]["VoidDate"].ToString());
                        editor.ReplaceText("{16}", dtHeader.Rows[0]["Voidmode"].ToString());
                        editor.ReplaceText("{17}", dtHeader.Rows[0]["bnk_Name"].ToString());
                        editor.ReplaceText("{18}", dtHeader.Rows[0]["arp_ChequeDate"].ToString());
                        editor.ReplaceText("{19}", dtHeader.Rows[0]["arp_ChequeNo"].ToString());



                        //string number = amountInWords.ConvertAmount(double.Parse(dtHeader.Rows[0]["inv_TotalAmount"].ToString()));
                        //editor.ReplaceText("{16}", number.ToUpper());
                    }

                    editor.InsertText("AR Receipt");
                    Table table = editor.InsertTable();

                    document.StyleRepository.AddBuiltInStyle(BuiltInStyleNames.TableGridStyleId);
                    table.StyleId = BuiltInStyleNames.TableGridStyleId;


                    ThemableColor cellBackground = new ThemableColor(Colors.DarkGray);


                    DataTable dtDetail = (DataTable)ViewState["dt"];

                    for (int i = -1; i < dtDetail.Rows.Count + 1; i++)
                    {
                        TableRow row = table.Rows.AddTableRow();
                        string[] Colums = { "Sr#", "AR Number", "Customer Code", "Customer Name", "Coll.Amount", "Payment Type", "Bank", "Cheque No", "Cheque Date" };
                        string[] DataColums = { "S#", "arh_ARNumber", "csh_Code", "cus_Name", "arh_CollectedAmount", "arp_Type", "bnk_Name", "arp_ChequeNo", "arp_ChequeDate" };
                        int[] ColumsWidth = { 50, 170, 150, 150, 100, 80, 80, 80, 80 };

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





                            }

                        }
                    }
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
                Response.AppendHeader("Content-Disposition", "attachment; filename=AR" + DateTime.Now.ToString("hhmmss") + ".pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(renderedBytes);
                Response.End();
            }
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

        protected void lnkAdvFilter_Click(object sender, EventArgs e)
        {
            if (plhFilter.Visible == true)
            {
                plhFilter.Visible = false;
                Session["CSJAdvFilter"] = "false";
            }
            else
            {
                plhFilter.Visible = true;
                Session["CSJAdvFilter"] = "true";
            }
        }

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);

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

        protected string RenderAttachment(string attachmentPath)
        {
            string extension = System.IO.Path.GetExtension(attachmentPath);
            string iconPath = "";

            if (extension != null)
            {
                if (extension.ToLower() == ".pdf")
                {
                    // Display PDF icon
                    iconPath = "../assets/media/svg/Files/File.svg"; // Replace with the actual path to your PDF icon image
                }
                else if (extension == "")
                {
                    iconPath = "../assets/media/svg/Files/File.svg";
                }
                else
                {
                    // Display image itself
                    iconPath = attachmentPath;
                }
            }

            return $"<asp:HyperLink ID='img4' runat='server' ImageHeight='20px' ImageWidth='20px' ImageUrl='{iconPath}' NavigateUrl='{attachmentPath}' Height='20px' Width='20px' Target='_blank'></asp:HyperLink>";
        }
    }
}