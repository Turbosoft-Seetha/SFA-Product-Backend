using ClosedXML.Excel;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using static Telerik.Web.Apoc.Render.Pdf.PdfRendererOptions;
using GridColumn = Telerik.Web.UI.GridColumn;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SettlementSummary : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    DateTime now = DateTime.Now;
                    DateTime startOfMonth = new DateTime(now.Year, now.Month, 1);

                    if (Session["SSFDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["SSFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = startOfMonth;
                    }

                    if (Session["SSTDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["SSTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = now;
                    }

                    rdfromDate.MaxDate = now;
                    rdendDate.MaxDate = now;

                    Route();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


                try
                {
                    GetGridSession(grvRpt, "SSM");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


            }
        }


        public void Route()
        {

            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteForSettilement", "sp_Settlement");
            rdRoute.DataTextField = "Route";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void ListData()
        {
            string route =  GetRouteFromDropforPrice();

            if (!route.Equals("0"))
            {
                string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string Todate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");


                string[] ar = { Todate, route };
                DataTable lstdata = ObjclsFrms.loadList("SettlementSummaryReport", "sp_Settlement", fromdate, ar);
                grvRpt.DataSource = lstdata;
            }
           
        }

        public string GetRouteFromDropforPrice()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("root"); // Root element

                    foreach (RadComboBoxItem item in rdRoute.CheckedItems)
                    {
                        createNodeForComboBox1(item.Value, writer);
                    }

                    writer.WriteEndElement(); // Close root element
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }

        // Example method to create a node for RadComboBox items in XML
        private void createNodeForComboBox1(string value, XmlWriter writer)
        {
            writer.WriteStartElement("row"); // Each route ID under its own element
            writer.WriteElementString("rot_ID", value);
            writer.WriteEndElement();
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            try
            {
                Session["SSFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                if (Session["SSFDate"] != null)
                {                    
                     rdfromDate.SelectedDate = DateTime.Parse(Session["SSFDate"].ToString());                   
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));                   

                }

                Session["SSTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                if (Session["SSTDate"] != null)
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["SSTDate"].ToString());
                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));

                }
                rdfromDate.MaxDate = DateTime.Now;
                rdendDate.MaxDate = DateTime.Now;

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            ListData();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "SSM");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {

        }

        protected void Excel_Click(object sender, ImageClickEventArgs e)
        {

            string fileName = "SettlementSummary";
            string dataQuery = "SettlementSummaryReportExcel";
            string reportName = "(Settlement Summary)";
           
            GenerateExcel1(fileName, dataQuery, reportName);
        }

        public void GenerateExcel1(string fileName, string dataQuery, string reportName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                   

                    string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string Todate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string route = GetRouteFromDropforPrice();

                    string[] ar = { Todate , route };

                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_Settlement", fromdate,ar,true);

                    if (dxd.Tables[0].Rows.Count > 0)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;

                        ExcelHeader(worksheet, ColLength, reportName);
                        int p = 0;
                        int r = 5;

                        ViewState["FirstColVal"] = null;

                        foreach (DataColumn dc in dxd.Tables[0].Columns)
                        {
                            Cell0 = worksheet.Cell(r + 1, p + 1);

                            if (dc.ColumnName.ToString().Contains("_"))
                            {
                                string[] ColVal = dc.ColumnName.Split('_');
                                string firstColVal = ColVal[0].ToString();
                                string secondColVal = ColVal[1].ToString();
                                Cell0.SetValue(firstColVal.ToString());
                                Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                if (ViewState["FirstColVal"] == null)
                                {
                                    ViewState["FirstColVal"] = firstColVal.ToString();
                                }
                                else
                                {
                                    if (ViewState["FirstColVal"].Equals(firstColVal))
                                    {
                                        var mergeCells = Cell0.Worksheet.Range(worksheet.Cell(r + 1, p), worksheet.Cell(r + 1, p + 1)).Merge();
                                        Cell0.SetValue(dc.ColumnName.ToString());
                                        mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                        Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                        Cell0.Worksheet.Range(worksheet.Cell(r + 1, p), worksheet.Cell(r + 1, p + 1)).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                    }
                                    else
                                    {
                                        ViewState["FirstColVal"] = firstColVal.ToString();
                                    }
                                }

                                Cell0 = worksheet.Cell(r + 2, p + 1);
                                Cell0.SetValue(secondColVal.ToString());
                                Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.LightGoldenrodYellow);
                            }
                            else
                            {
                                var mergeCells = Cell0.Worksheet.Range(worksheet.Cell(6, p + 1), worksheet.Cell(7, p + 1)).Merge();
                                Cell0.SetValue(dc.ColumnName.ToString());
                                mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                var col2 = worksheet.Column(p + 1);

                                if (col2.Width < Cell0.GetString().Length)
                                {
                                    col2.Width = Cell0.GetString().Length + 3;
                                }
                            }
                            p = p + 1;
                        }

                        int j = 7;
                        int k = 0;
                        string mode;

                        foreach (DataRow dr in dx1.Rows)
                        {

                            PrintRow(dr, dx1, worksheet, j, k);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" + DateTime.Parse(DateTime.Now.ToString()).ToString("yyyyMMdd") + ".xlsx");

                        using (MemoryStream MyMemoryStream = new MemoryStream())
                        {
                            wb.SaveAs(MyMemoryStream);
                            MyMemoryStream.WriteTo(Response.OutputStream);
                            Response.Flush();
                            Response.End();
                        }
                    }

                    else
                    {

                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

        public void PrintRow(DataRow dr, DataTable dx, IXLWorksheet worksheet, int j, int k)
        {
            IXLCell Cell1;
            foreach (DataColumn data in dx.Columns)
            {
                Cell1 = worksheet.Cell(j + 1, k + 1);
                string name = dr[data.ColumnName].ToString();
                try
                {
                    if (k > 2)
                    {
                        Cell1.SetValue(decimal.Parse(dr[data.ColumnName].ToString()));
                    }
                    else
                    {
                        Cell1.SetValue(dr[data.ColumnName].ToString());
                    }
                }
                catch
                {
                    Cell1.SetValue(dr[data.ColumnName].ToString());
                }
                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                k = k + 1;
            }
        }


        public void ExcelHeader(IXLWorksheet worksheet, int ColLength, string ReportName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string title = ConfigurationManager.AppSettings.Get("ProjectName"); ;
                    IXLCell Cell0;

                    int beforeCol = ColLength - 2;
                    if (beforeCol < 1)
                    {
                        beforeCol = 2;
                        beforeCol = 2;
                    }
                    int afterCol = ColLength + 2;
                    Cell0 = worksheet.Cell(1, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(1, beforeCol), worksheet.Cell(1, afterCol)).Merge();
                    Cell0.SetValue(title.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Font.FontSize = 13;

                    beforeCol = ColLength - 1;
                    afterCol = ColLength + 1;
                    Cell0 = worksheet.Cell(2, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(2, beforeCol), worksheet.Cell(2, afterCol)).Merge();
                    Cell0.SetValue(ReportName.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();

                   
                  
                    Cell0 = worksheet.Cell(5, 7);
                    Cell0.SetValue("Date");
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell0 = worksheet.Cell(5, 8);
                    Cell0.SetValue(DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"));
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col4 = worksheet.Column(8);
                    col4.Width = Cell0.GetString().Length + 3;

                }
                catch (Exception ex)
                {

                }
            }
        }

        public void ExcelHeaders(IXLWorksheet worksheet, int ColLength, string ReportName, string ReportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string title = ConfigurationManager.AppSettings.Get("ProjectName"); ;
                    IXLCell Cell1;

                    int beforeCol = ColLength - 2;
                    if (beforeCol < 1)
                    {
                        beforeCol = 2;
                    }
                    int afterCol = ColLength + 2;
                    Cell1 = worksheet.Cell(1, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(1, beforeCol), worksheet.Cell(1, afterCol)).Merge();
                    Cell1.SetValue(title.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Font.FontSize = 13;

                    beforeCol = ColLength - 1;
                    afterCol = ColLength + 1;
                    Cell1 = worksheet.Cell(2, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(2, beforeCol), worksheet.Cell(2, afterCol)).Merge();
                    Cell1.SetValue(ReportName.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();

                    Cell1 = worksheet.Cell(3, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(3, beforeCol), worksheet.Cell(3, afterCol)).Merge();
                    Cell1.SetValue(ReportSubName.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();

                   

                    Cell1 = worksheet.Cell(5, 7);
                    Cell1.SetValue("Date");
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell1 = worksheet.Cell(5, 8);
                    Cell1.SetValue(DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"));
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col4 = worksheet.Column(8);
                    col4.Width = Cell1.GetString().Length + 3;

                }
                catch (Exception ex)
                {

                }
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

    }
}