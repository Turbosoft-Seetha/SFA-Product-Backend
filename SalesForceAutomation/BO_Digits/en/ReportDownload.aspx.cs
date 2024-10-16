using ClosedXML.Excel;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.InkML;
using DocumentFormat.OpenXml.Vml;
using OfficeOpenXml;
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
using Telerik.Windows.Zip;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ReportDownload : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Region();
                int o = 1;
                foreach (RadComboBoxItem itmss in region.Items)
                {
                    itmss.Checked = true;
                    o++;
                }
                string Reg = REGN();
                string regcondition = " dep_reg_ID in (" + Reg + ")";
                Depot(regcondition);
                int p = 1;
                foreach (RadComboBoxItem itmss in depot.Items)
                {
                    itmss.Checked = true;
                    p++;
                }
                string depo = DPOT();
                string dpocondition = " dpa_dep_ID in (" + depo + ")";
                DpoArea(dpocondition);
                int q = 1;
                foreach (RadComboBoxItem itmss in dpoArea.Items)
                {
                    itmss.Checked = true;
                    q++;
                }
                string depoarea = DPOAREA();
                string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
                DpoSubArea(dpoareacondition);
                int R = 1;
                foreach (RadComboBoxItem itmss in dpoSubArea.Items)
                {
                    itmss.Checked = true;
                    R++;
                }
                
                rdfromDate.MaxDate = DateTime.Now;
                rdendDate.MaxDate = DateTime.Now;
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                // Route();
                string deposubarea = DPOSUBAREA();
                string dposubareacondition = "  rot_dsa_ID in (" + deposubarea + ") ";
                Route(dposubareacondition);
                RouteFromTransaction();
                ViewState["mode"] = "";
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

        public void Route(string DposubAreaCondition)
        {
            if (string.IsNullOrWhiteSpace(SearchTextBox.Text))
            {
                DposubAreaCondition = DposubAreaCondition + "";
            }
            else
            {              
                string searchcondition = " and (rot_Code LIKE  '%" + SearchTextBox.Text.ToString() + "%' OR rot_Name LIKE '%" + SearchTextBox.Text.ToString() + "%')";
                DposubAreaCondition = DposubAreaCondition + searchcondition;
            }

            string[] arr = { DposubAreaCondition };
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString(), arr);
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }


        public void Region()
        {
            region.DataSource = ObjclsFrms.loadList("SelectRegion", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString());
            region.DataTextField = "reg_Name";
            region.DataValueField = "reg_ID";
            region.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            depot.DataSource = ObjclsFrms.loadList("SelectDepot", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString(), arr);
            depot.DataTextField = "dep_Name";
            depot.DataValueField = "dep_ID";
            depot.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            dpoArea.DataSource = ObjclsFrms.loadList("SelectDepotArea", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString(), arr);
            dpoArea.DataTextField = "dpa_Name";
            dpoArea.DataValueField = "dpa_ID";
            dpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            dpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubArea", "sp_ExcelReport", UICommon.GetCurrentUserID().ToString(), arr);
            dpoSubArea.DataTextField = "dsa_Name";
            dpoSubArea.DataValueField = "dsa_ID";
            dpoSubArea.DataBind();
        }
        public string REGN()
        {
            var CollectionMarket1 = region.CheckedItems;
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

        public string DPOT()
        {
            var CollectionMarket1 = depot.CheckedItems;
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
        public string DPOAREA()
        {
            var CollectionMarket2 = dpoArea.CheckedItems;
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

        public string DPOSUBAREA()
        {
            var CollectionMarket3 = dpoSubArea.CheckedItems;
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
            ViewState["mode"] = "1";
            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded.You can only select a maximum of one month at a time');</script>", false);

            }

        }

        protected void lnkSalesReportByItemRoute_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "2";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }


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
            ViewState["mode"] = "3";


            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }

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
            ViewState["mode"] = "4";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }


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
            ViewState["mode"] = "5";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }


        }

        protected void lnkStockStatusByRoute_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "6";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }

        }

        protected void lnkMonthlySalesByCustomer_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "7";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 10 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 10)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 10 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }

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
                            string find = "[Customer Code] = '" + dr["Customer Code"].ToString() + "' and [Item Category] = '" + dr["Item Category"].ToString() + "'";
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
            ViewState["mode"] = "8";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;


            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 10 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 10)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 10 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }


        }

        protected void lnkMntlySalRetItmByRot_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "9";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }


        }

        protected void lnkMntlySalQtyRetItmByRot_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "10";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }


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

        protected void lnkSalesReturnByHO_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "11";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }



        }

        public void GenerateExcel7(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count >= 1)
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
                            foreach (DataRow drc in dx1.Rows)
                            {
                                mode = "";
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
        protected void GetInvoiceDetails_Click1(object sender, EventArgs e)
        {
            ViewState["mode"] = "13";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;

            if (fromDateStr == endDateStr)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' From Date and To Date should be same');</script>", false);

            }

        }
        protected void lnkSalesReturnByArea_Click(object sender, EventArgs e)
         {
            ViewState["mode"] = "12";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;


            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (rotcount <= 50 && numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else if (rotcount > 50)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('You can only select a maximum of 50 routes at a time');</script>", false);

            }
            else if (numberOfDays > 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded. You can only select a maximum of one month at a time');</script>", false);

            }


         }

        public void GenerateExcel8(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr, true);
                    if (dxd.Tables[0].Rows.Count > 0)
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
                            foreach (DataRow drc in dx2.Rows)
                            {
                                string findX = "Area = '" + drc["Area"].ToString() + "'";
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

        protected void lnkAdvanceFilter_Click(object sender, EventArgs e)
        {
            if (lnkFilter.Visible == true)
            {
                lnkFilter.Visible = false;
            }
            else
            {
                lnkFilter.Visible = true;
            }
        }

        protected void region_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REGN();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void depot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPOT();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void dpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOAREA();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
        }

        protected void dpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOSUBAREA();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);

        }

        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            string deposubarea = DPOSUBAREA();
            string dposubareacondition = "  rot_dsa_ID in (" + deposubarea + ") ";
            Route(dposubareacondition);

        }
        public void GenerateExcel10(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
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
                        string mode = "";

                        foreach (DataRow dr in dx1.Rows)
                        {

                            PrintNotFormattedRow(dr, dx1, worksheet, j, k, mode);
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

        protected void download_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>closeModal();</script>", false);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "closeModalScript", "$('#modalConfirm').modal('hide');", true);
            if (ViewState["mode"].ToString().Equals("1"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "1-TotSalesByCatAndChannel";
                string dataQuery = "SelectChannelVSCategory";
                string reportName = "(1-By Category & By Channel)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel1(fileName, dataQuery, reportName, reportSubName, mainCondition);
                // Response.Redirect(Request.RawUrl);
            }
            else if (ViewState["mode"].ToString().Equals("2"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "2-SalesReportByItemRoute";
                string dataQuery = "SalesReportByItemRoute";
                string reportName = "(2-Sales Report By Item By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel2(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("3"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "3-SalesByCustomers";
                string dataQuery = "SelectSalesByCustomers";
                string reportName = "(3-Sales Report By Customer By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel3(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("4"))
            {

                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "4-RouteCustomerVisit";
                string dataQuery = "SelectRouteCustomerVisit";
                string reportName = "(4-Daily Visit Status Report By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("5"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "5-DailyStockByRouteItem";
                string dataQuery = "DailyStockByRouteItem";
                string reportName = "(5-Daily Stock Status Report By Item By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("6"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "6-StockStatusReportByRouteItem";
                string dataQuery = "SelectStockStatusReport";
                string reportName = "(6-Stock Status Report By Item By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                GenerateExcel4(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("7"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "7-MonthlySalesByCustomers";
                string dataQuery = "SelRouteSalesSummary";
                string reportName = "(7-Monthly Sales Summary By Customer By Item)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel5(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("8"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "8-MonthlySalesRetByCustRoute";
                string dataQuery = "SelMonthlySalesReturnSummCusByRot";
                string reportName = "(8-Monthly Sales & Return Summary By Customer By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("9"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "9-MonthlySalesRetByItemByRoute";
                string dataQuery = "SelMonthlySalesReturnSummItmByRot";
                string reportName = "(9-Monthly Sales Val & Return Summary By Item By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("10"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "10-MonthlySalQtyRetByItemByROt";
                string dataQuery = "SelMonthlySalesReturnSummItmCategoryByRot";
                string reportName = "(10-Monthly Sales Qty & Return Summary By Item By Route)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel6(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("11"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "11-SalesRetQtyValByHO";
                string dataQuery = "SelectSalesReturnSummaryByHO";
                string reportName = "(11-Sales Qty & Return Summary By HO)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel7(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("12"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "12-SalesRtnSummaryBySubareaArea";
                string dataQuery = "SelectSalesReturnSummBySubareaArea";
                string reportName = "(12-Sales Return Summary By Subarea By Area)";
                string reportSubName = "(القطاعات / الفئات)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel8(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("13"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "13-ItemWiseSales&Quantity";
                string dataQuery = "GetInvoiceDetailReportData";
                string reportName = "(13-Item Wise Sales & Quantity)";
                string reportSubName = "(البند الحكيم للمبيعات والكمية)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel10(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("14"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "14-ItemWiseSales&Quantity";
                string dataQuery = "GetInvoiceDetailReportDatabyItem";
                string reportName = "(14-Item Wise Sales & Quantity by route)";
                string reportSubName = "(البند الحكيم للمبيعات والكمية)";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel10(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }
            else if (ViewState["mode"].ToString().Equals("15"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "15-Focus-SalesReport";
                string dataQuery = "GetFocusSalesReport";
                string reportName = "(15-Focus-Sales Report)";
                string reportSubName = "";
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);
                GenerateExcel10(fileName, dataQuery, reportName, reportSubName, mainCondition);
            }

            else if (ViewState["mode"].ToString().Equals("16"))
            {
                lblMessage.Visible = false;
                lblMessage.Text = "";
                string fileName = "16-Item-WiseSummaryReport";                
                string rotID = Rot();
                string mainCondition = "";
                mainCondition = mainCond(rotID);

                var reports = new List<(string sheetName, string dataQuery, string reportName)>
                    {
                        ("Sales Report", "GetItemWiseSalesReport", "(Sales Report)"),
                        ("AR Report", "GetItemWiseARReport", "(AR Report)"),
                        ("Order Report", "GetItemWiseOrderReport", "(Order Report)"),
                        ("Van Load Report", "GetItemWiseVanLoadReport", "(Van Load Report)")
                    };

                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;  

                using (ExcelPackage package = new ExcelPackage())
                {
                    foreach (var report in reports)
                    {
                        string sheetName = report.sheetName;
                        string dataQuery = report.dataQuery;
                        string reportName = report.reportName;

                        string[] arr = { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd"), mainCondition };
                        DataTable dtReportData = ObjclsFrms.loadList(dataQuery, "sp_ExcelReport", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd"), arr);

                        ExcelWorksheet sheet = package.Workbook.Worksheets.Add(sheetName);

                        sheet.Cells["A1"].LoadFromDataTable(dtReportData, true);

                        int totalColumns = dtReportData.Columns.Count;
                        string lastColumn = GetExcelColumnName(totalColumns);
                        sheet.Cells[$"A1:{lastColumn}1"].Style.Font.Bold = true;
                    }

                    byte[] output = package.GetAsByteArray();

                    Response.Clear();
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.Headers.Remove("Content-Disposition");
                    Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}.xlsx");
                    Response.BinaryWrite(output);
                    Response.End();
                }            
            }
        }
       
        public static string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = String.Empty;
            int modifier;

            while (dividend > 0)
            {
                modifier = (dividend - 1) % 26;
                columnName = System.Convert.ToChar(65 + modifier).ToString() + columnName;
                dividend = (dividend - modifier) / 26;
            }

            return columnName;
        }


        protected void getItemwiseSales_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "14";

            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;


            
             if (fromDateStr == endDateStr)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
           
            else 
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' From Date and To Date should be same');</script>", false);

            }

        }

        protected void focussales_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "15";
            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded.You can only select a maximum of one month at a time');</script>", false);

            }
        }

        public void PrintNotFormattedRow(DataRow dr, DataTable dx, IXLWorksheet worksheet, int j, int k, string mode)
        {
            IXLCell Cell1;
            foreach (DataColumn data in dx.Columns)
            {
                Cell1 = worksheet.Cell(j + 1, k + 1);
                string name = dr[data.ColumnName].ToString();
                Cell1.SetValue(dr[data.ColumnName].ToString());
                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                k = k + 1;
            }
        }

        protected void ItemWise_Click(object sender, EventArgs e)
        {
            ViewState["mode"] = "16";
            int rotcount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            string fromDateStr = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDateStr = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            DateTime fromDate = DateTime.ParseExact(fromDateStr, "yyyyMMdd", null);
            DateTime endDate = DateTime.ParseExact(endDateStr, "yyyyMMdd", null);
            TimeSpan difference = endDate - fromDate;
            int numberOfDays = difference.Days;



            if (rotcount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert(' Please select routes..');</script>", false);
            }
            else if (numberOfDays <= 31)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Date range exeeded.You can only select a maximum of one month at a time');</script>", false);

            }
        }       

    }
}