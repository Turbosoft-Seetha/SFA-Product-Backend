using ClosedXML.Excel;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.InkML;
using DocumentFormat.OpenXml.Vml;
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
using Telerik.Web.UI.ImageEditor;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ReportDownload : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdfromDate.MaxDate = DateTime.Now;
                rdendDate.MaxDate = DateTime.Now;
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                Route();
                RouteFromTransaction();
            }
        }

        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }

        public string Rot()
        {
            var ColelctionMarket = ddlRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "0";
            }
        }

        public string mainConditions(string rotID)
        {
            string mainCondition = " and rot_ID in (" + rotID + ")";
            return mainCondition;
        }

        public string mainCond(string rotID)
        {
            string mainCondition = " and sal_rot_ID in (" + rotID + ")";
            return mainCondition;
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForDropDowns", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString());
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        public void ExcelHeader(IXLWorksheet worksheet, int ColLength, string ReportName, string ReportSubName, int modes)
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

                    Cell0 = worksheet.Cell(3, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(3, beforeCol), worksheet.Cell(3, afterCol)).Merge();
                    Cell0.SetValue(ReportSubName.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();

                    if (modes == 2)
                    {
                        Cell0 = worksheet.Cell(5, 3);
                        Cell0.SetValue("Date Range");
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        Cell0 = worksheet.Cell(5, 4);
                        Cell0.SetValue("From");
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        Cell0 = worksheet.Cell(5, 5);
                        Cell0.SetValue(DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MM-yyyy"));
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        var col1 = worksheet.Column(5);
                        col1.Width = Cell0.GetString().Length + 3;

                        Cell0 = worksheet.Cell(5, 6);
                        Cell0.SetValue("To");
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        Cell0 = worksheet.Cell(5, 7);
                        Cell0.SetValue(DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("dd-MM-yyyy"));
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        var col2 = worksheet.Column(7);
                        col2.Width = Cell0.GetString().Length + 3;
                    }
                    else if (modes == 1)
                    {
                        Cell0 = worksheet.Cell(5, 4);
                        Cell0.SetValue("Date");
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        Cell0 = worksheet.Cell(5, 5);
                        Cell0.SetValue(DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MM-yyyy"));
                        Cell0.Style.Font.SetBold();
                        Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        var col1 = worksheet.Column(5);
                        col1.Width = Cell0.GetString().Length + 3;
                    }

                    Cell0 = worksheet.Cell(5, 8);
                    Cell0.SetValue("Date");
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell0 = worksheet.Cell(5, 9);
                    Cell0.SetValue(DateTime.Parse(DateTime.Now.ToString()).ToString("dd-MM-yyyy"));
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col3 = worksheet.Column(9);
                    col3.Width = Cell0.GetString().Length + 3;

                    Cell0 = worksheet.Cell(5, 10);
                    Cell0.SetValue("Time");
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell0 = worksheet.Cell(5, 11);
                    Cell0.SetValue(DateTime.Now.ToString("HH:mm"));
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col4 = worksheet.Column(11);
                    col4.Width = Cell0.GetString().Length + 3;

                }
                catch (Exception ex)
                {

                }
            }
        }

        public void GenerateExcel1(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);

                        Cell0 = worksheet.Cell(8, 3);
                        var channelMergeCell = Cell0.Worksheet.Range(worksheet.Cell(8, 3), worksheet.Cell(8, dxd.Tables[0].Columns.Count - 1)).Merge();
                        Cell0.SetValue("Channel / القطاع");
                        Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        Cell0.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                        channelMergeCell.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        Cell0.Style.Font.SetBold();


                        IXLCell Cell1;
                        IXLCell Cell2;
                        IXLCell Cell3;
                        int p = 0;

                        foreach (DataColumn dc in dx1.Columns)
                        {
                            Cell1 = worksheet.Cell(9, p + 1);
                            if (p < 2)
                            {
                                var mergeCell = Cell1.Worksheet.Range(worksheet.Cell(9, p + 1), worksheet.Cell(10, p + 1)).Merge();
                                Cell1.SetValue(dc.ColumnName.ToString());
                                mergeCell.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                                var col2 = worksheet.Column(p + 1);

                                if (col2.Width < Cell1.GetString().Length)
                                {
                                    col2.Width = Cell1.GetString().Length + 3;
                                }
                            }
                            else if (p > 1 && p < dx1.Columns.Count - 1)
                            {
                                string[] val = dc.ColumnName.ToString().Split('/');
                                Cell2 = worksheet.Cell(9, p + 1);
                                Cell2.SetValue(val[1]);
                                Cell2.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell2.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                                Cell2 = worksheet.Cell(10, p + 1);
                                Cell2.SetValue(val[0]);
                                Cell2.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell2.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                                Cell2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                var col2 = worksheet.Column(p + 1);

                                if (col2.Width < Cell2.GetString().Length)
                                {
                                    col2.Width = Cell2.GetString().Length + 3;
                                }

                            }
                            else if (p == dx1.Columns.Count - 1)
                            {
                                var mergeCell = Cell1.Worksheet.Range(worksheet.Cell(9, p + 1), worksheet.Cell(10, p + 1)).Merge();
                                Cell1.SetValue(dc.ColumnName.ToString());
                                mergeCell.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                                var col2 = worksheet.Column(p + 1);

                                if (col2.Width < Cell1.GetString().Length)
                                {
                                    col2.Width = Cell1.GetString().Length + 3;
                                }
                            }

                            for (int q = 0; q < dx1.Rows.Count; q++)
                            {
                                var data = dx1.Rows[q][dx1.Columns[p]].ToString();
                                Cell3 = worksheet.Cell(q + 11, p + 1);
                                Cell3.SetValue(data);
                                try
                                {
                                    Cell3.SetValue(Double.Parse(data));
                                    //normalFormat.NumberFormat = "##";
                                }
                                catch (Exception w)
                                {
                                    Cell3.SetValue(data);

                                }
                                Cell3.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                if (p > 1)
                                {
                                    Cell3.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                                }
                                if (q == dx1.Rows.Count - 1)
                                {
                                    Cell3.Style.Fill.SetBackgroundColor(XLColor.GreenYellow);
                                }
                            }

                            Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                            Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            Cell1.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                            Cell1.Style.Font.SetBold();

                            p = p + 1;
                        }
                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }


            }
        }

        public void GenerateExcel2(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        DataTable dx3 = dxd.Tables[2];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);
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

                        foreach (DataRow dr in dx3.Rows)
                        {
                            string find = "Route = '" + dr["Route"].ToString() + "'";
                            DataRow[] dtCat = dx2.Select(find);
                            foreach (DataRow drc in dtCat)
                            {
                                string findX = "Route = '" + dr["Route"].ToString() + "' and [Item Category] = '" + drc["Item Category"].ToString() + "'";
                                DataRow[] dtItems = dx1.Select(findX);
                                foreach (DataRow dri in dtItems)
                                {
                                    mode = "item";
                                    PrintRows(dri, dx1, worksheet, j, k, mode);
                                    j = j + 1;
                                }
                                mode = "category";
                                PrintRows(drc, dx2, worksheet, j, k, mode);
                                j = j + 1;
                            }
                            mode = "route";
                            PrintRows(dr, dx3, worksheet, j, k, mode);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

        protected void lnkTotSalesByCatAndChannel_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "TotSalesByCatAndChannel";
            string dataQuery = "SelectChannelVSCategory";
            string reportName = "(By Category & By Channel)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel1(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void lnkSalesReportByItemRoute_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "SalesReportByItemRoute";
            string dataQuery = "SalesReportByItemRoute";
            string reportName = "(Sales Report By Item By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel2(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        public void PrintRows(DataRow dr, DataTable dx, IXLWorksheet worksheet, int j, int k, string mode)
        {
            IXLCell Cell1;
            foreach (DataColumn data in dx.Columns)
            {
                Cell1 = worksheet.Cell(j + 1, k + 1);
                string name = dr[data.ColumnName].ToString();
                if (data.ColumnName.Contains("_QTY") || data.ColumnName.Contains("_VAL") || data.ColumnName.Contains("_SAL") || data.ColumnName.Contains("_RTN"))
                {
                    if (name == "")
                    {
                        Cell1.SetValue(decimal.Parse("0.000"));
                    }
                    else
                    {
                        Cell1.SetValue(decimal.Parse(dr[data.ColumnName].ToString()));
                    }
                }
                else
                {
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
                }
                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                if (mode.Equals("category"))
                {
                    Cell1.Style.Fill.SetBackgroundColor(XLColor.LightBlue);
                }
                else if (mode.Equals("route"))
                {
                    Cell1.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                }
                else
                {

                }
                k = k + 1;
            }
        }

        protected void lnkSalesByCustomer_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "SalesByCustomers";
            string dataQuery = "SelectSalesByCustomers";
            string reportName = "(Sales Report By Customer By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel3(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        public void GenerateExcel3(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);
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

                        foreach (DataRow dr in dx2.Rows)
                        {
                            string find = "Route = '" + dr["Route"].ToString() + "'";
                            DataRow[] dtCat = dx1.Select(find);
                            foreach (DataRow drc in dtCat)
                            {
                                mode = "customer";
                                PrintRows(drc, dx1, worksheet, j, k, mode);
                                j = j + 1;
                            }
                            mode = "route";
                            PrintRows(dr, dx2, worksheet, j, k, mode);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

        protected void lnkRouteCustomerVisit_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "RouteCustomerVisit";
            string dataQuery = "SelectRouteCustomerVisit";
            string reportName = "(Daily Visit Status Report By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainConditions(rotID);
            GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        public void GenerateExcel4(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 1;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);
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

                        foreach (DataRow dr in dx2.Rows)
                        {
                            string find = "Route = '" + dr["Route"].ToString() + "'";
                            DataRow[] dtCat = dx1.Select(find);
                            foreach (DataRow drc in dtCat)
                            {
                                mode = "customer";
                                PrintRows(drc, dx1, worksheet, j, k, mode);
                                j = j + 1;
                            }
                            mode = "route";
                            PrintRows(dr, dx2, worksheet, j, k, mode);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

        protected void lblDailyStockByRouteItem_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "DailyStockByRouteItem";
            string dataQuery = "DailyStockByRouteItem";
            string reportName = "(Daily Stock Status Report By Item By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainConditions(rotID);
            GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void lnkStockStatusByRoute_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "StockStatusReportByRouteItem";
            string dataQuery = "SelectStockStatusReport";
            string reportName = "(Stock Status Report By Item By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainConditions(rotID);
            GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void lnkMonthlySalesByCustomer_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "MonthlySalesByCustomers";
            string dataQuery = "SelectRouteSalesSummary";
            string reportName = "(Monthly Sales Summary By Customer By Item)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel5(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        public void GenerateExcel5(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);
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

                        foreach (DataRow dr in dx2.Rows)
                        {
                            string find = "Customer = '" + dr["Customer"].ToString() + "' and [Item Category] = '" + dr["Item Category"].ToString() + "'";
                            DataRow[] dtCat = dx1.Select(find);
                            foreach (DataRow drc in dtCat)
                            {
                                mode = "customer";
                                PrintRow(drc, dx1, worksheet, j, k, mode);
                                j = j + 1;
                            }
                            mode = "route";
                            PrintRow(dr, dx2, worksheet, j, k, mode);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }
        public void PrintRow(DataRow dr, DataTable dx, IXLWorksheet worksheet, int j, int k, string mode)
        {
            IXLCell Cell1;
            foreach (DataColumn data in dx.Columns)
            {
                Cell1 = worksheet.Cell(j + 1, k + 1);
                string name = dr[data.ColumnName].ToString();
                if (data.ColumnName.Contains("_SAL") || data.ColumnName.Contains("_RTN"))
                {
                    if (name == "")
                    {
                        Cell1.SetValue(decimal.Parse("0.000"));
                    }
                    else
                    {
                        Cell1.SetValue(decimal.Parse(dr[data.ColumnName].ToString()));
                    }
                }
                else
                {
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
                }
                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                if (mode.Equals("category"))
                {
                    Cell1.Style.Fill.SetBackgroundColor(XLColor.LightBlue);
                }
                else if (mode.Equals("route"))
                {
                    Cell1.Style.Fill.SetBackgroundColor(XLColor.Yellow);
                }
                else
                {

                }
                k = k + 1;
            }
        }

        protected void lnkMntlySalRetCusByRot_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "MonthlySalesRetByCustRoute";
            string dataQuery = "SelMonthlySalesReturnSummCusByRot";
            string reportName = "(Monthly Sales & Return Summary By Customer By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void lnkMntlySalRetItmByRot_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "MonthlySalesRetByItemByRoute";
            string dataQuery = "SelMonthlySalesReturnSummItmByRot";
            string reportName = "(Monthly Sales Val & Return Summary By Item By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void lnkMntlySalQtyRetItmByRot_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "MonthlySalesQtyRetByItemByROt";
            string dataQuery = "SelMonthlySalesReturnSummItmCategoryByRot";
            string reportName = "(Monthly Sales Qty & Return Summary By Item By Route)";
            string reportSubName = "(القطاعات / الفئات)";
            string rotID = Rot();
            string mainCondition = "";
            mainCondition = mainCond(rotID);
            GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        public void GenerateExcel6(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int modes = 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName, modes);
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

                        foreach (DataRow dr in dx2.Rows)
                        {
                            string find = "Route = '" + dr["Route"].ToString() + "'";
                            DataRow[] dtCat = dx1.Select(find);
                            foreach (DataRow drc in dtCat)
                            {
                                mode = "customer";
                                PrintRow(drc, dx1, worksheet, j, k, mode);
                                j = j + 1;
                            }
                            mode = "route";
                            PrintRow(dr, dx2, worksheet, j, k, mode);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" +
                            DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd") + " to " + DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd") + ".xlsx");

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
                        lblMessage.Visible = true;
                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

    }
}