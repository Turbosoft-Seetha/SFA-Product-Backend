using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using static Telerik.Web.Apoc.Render.Pdf.PdfRendererOptions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ReportMasterDownload : System.Web.UI.Page
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
                string deposubarea = DPOSUBAREA();
                string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
                Route(dposubareacondition);
                int K = 1;
                foreach (RadComboBoxItem itmss in ddlroute.Items)
                {
                    itmss.Checked = true;
                    K++;
                }
                string route = ROT();
                string routecondition = "  rcs_rot_ID in (" + route + ")";
                Customer(routecondition);


            }
        }
        public void Customer(string routeCondition)
        {
            String User = rdCustomer.SelectedValue.ToString();
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerFromDrop", "sp_ExcelMasterReport", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public string Cus()
        {
            var ColelctionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
        public string mainCondition1(string cusID)
        {
            string mainCondition = " and cpm_cus_ID in (" + cusID + ")";
            return mainCondition;
        }

        public string mainConditionsp(string cusID)
        {
            string mainCondition = " and cpm_cus_ID in (" + cusID + ")";
            return mainCondition;
        }

        public string mainCondition2(string cusID)
        {
            string mainCondition = " cpm_cus_ID in (" + cusID + ")";
            return mainCondition;
        }

        public void ExcelHeader(IXLWorksheet worksheet, int ColLength, string ReportName, string ReportSubName)
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

                    Cell0 = worksheet.Cell(5, 5);
                    Cell0.SetValue("Date");
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell0 = worksheet.Cell(5, 6);
                    Cell0.SetValue(DateTime.Parse(DateTime.Now.ToString()).ToString("dd-MM-yyyy"));
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col3 = worksheet.Column(6);
                    col3.Width = Cell0.GetString().Length + 3;

                    Cell0 = worksheet.Cell(5, 7);
                    Cell0.SetValue("Time");
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell0 = worksheet.Cell(5, 8);
                    Cell0.SetValue(DateTime.Now.ToString("HH:mm"));
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

                    Cell1 = worksheet.Cell(5, 5);
                    Cell1.SetValue("Date");
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell1 = worksheet.Cell(5, 6);
                    Cell1.SetValue(DateTime.Parse(DateTime.Now.ToString()).ToString("dd-MM-yyyy"));
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col3 = worksheet.Column(6);
                    col3.Width = Cell1.GetString().Length + 3;

                    Cell1 = worksheet.Cell(5, 7);
                    Cell1.SetValue("Time");
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell1 = worksheet.Cell(5, 8);
                    Cell1.SetValue(DateTime.Now.ToString("HH:mm"));
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

        protected void lnkItemPriceUOM_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "ItemPriceByUOM";
            string dataQuery = "ItemPricingByUOM";
            string reportName = "(Item Pricing By UOM)";
            string reportSubName = "(القطاعات / الفئات)";
            GenerateExcel1(fileName, dataQuery, reportName, reportSubName);
        }
        public void GenerateExcel3(string fileName, string dataQuery, string reportName, string reportSubName, string mainCondition)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { mainCondition };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelMasterReport", "", arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName);
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

        public void GenerateExcel1(string fileName, string dataQuery, string reportName, string reportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { "" };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelMasterReport", "", arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        
                        ExcelHeader(worksheet, ColLength, reportName, reportSubName);
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

        protected void lnkSpecialPrice_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "SpecialPriceByUOM";
            string dataQuery = "SpecialPriceByUOM";
            string reportName = "(Special Price By UOM)";
            string reportSubName = "(القطاعات / الفئات)";
            GenerateExcel1(fileName, dataQuery, reportName, reportSubName);
        }

        protected void lnkOutstandingInvoice_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "OutstandingInvoiceByBranch";
            string fileNames = "OutstandingInvoiceByHO";
            string dataQuery = "OutstandingInvoiceByCustomer";
            string reportName = "(Outstanding Invoice By Customer)";
            string reportSubName = "(القطاعات / الفئات)";
            GenerateExcel2(fileName, fileNames, dataQuery, reportName, reportSubName);
        }

        protected void lnkTotalOutstandingInvoice_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "TotalOutstandingByBranch";
            string fileNames = "TotalOutstandingByHO";
            string dataQuery = "TotalOutstandingByCustomer";
            string reportName = "(Total Outstanding Invoice By Customer)";
            string reportSubName = "(القطاعات / الفئات)";
            GenerateExcel2(fileName, fileNames, dataQuery, reportName, reportSubName);
        }

        public void GenerateExcel2(string fileName, string fileNames, string dataQuery, string reportName, string reportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string[] arr = { "" };
                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_ExcelMasterReport", "", arr, true);
                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        IXLWorksheet worksheets = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        worksheets.Name = fileNames;
                        DataTable dx1 = dxd.Tables[0];
                        DataTable dx2 = dxd.Tables[1];
                        IXLCell Cell0;
                        IXLCell Cell1;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;
                        int ColLengths = dxd.Tables[1].Columns.Count / 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName);

                        ExcelHeaders(worksheets, ColLengths, reportName, reportSubName);

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

                        p = 0;
                        r = 5;

                        foreach (DataColumn dx in dxd.Tables[1].Columns)
                        {
                            Cell1 = worksheets.Cell(r + 1, p + 1);

                            if (dx.ColumnName.ToString().Contains("_"))
                            {
                                string[] ColVal = dx.ColumnName.Split('_');
                                string firstColVal = ColVal[0].ToString();
                                string secondColVal = ColVal[1].ToString();
                                Cell1.SetValue(firstColVal.ToString());
                                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell1.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                if (ViewState["FirstColVal"] == null)
                                {
                                    ViewState["FirstColVal"] = firstColVal.ToString();
                                }
                                else
                                {
                                    if (ViewState["FirstColVal"].Equals(firstColVal))
                                    {
                                        var mergeCells = Cell1.Worksheet.Range(worksheets.Cell(r + 1, p), worksheets.Cell(r + 1, p + 1)).Merge();
                                        Cell1.SetValue(dx.ColumnName.ToString());
                                        mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                        Cell1.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                        Cell1.Worksheet.Range(worksheets.Cell(r + 1, p), worksheets.Cell(r + 1, p + 1)).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                    }
                                    else
                                    {
                                        ViewState["FirstColVal"] = firstColVal.ToString();
                                    }
                                }

                                Cell1 = worksheets.Cell(r + 2, p + 1);
                                Cell1.SetValue(secondColVal.ToString());
                                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell1.Style.Fill.SetBackgroundColor(XLColor.LightGoldenrodYellow);
                            }
                            else
                            {
                                var mergeCells = Cell1.Worksheet.Range(worksheets.Cell(6, p + 1), worksheets.Cell(7, p + 1)).Merge();
                                Cell1.SetValue(dx.ColumnName.ToString());
                                mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell1.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                var col2 = worksheets.Column(p + 1);

                                if (col2.Width < Cell1.GetString().Length)
                                {
                                    col2.Width = Cell1.GetString().Length + 3;
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

                        j = 7;
                        k = 0;

                        foreach (DataRow dr in dx2.Rows)
                        {

                            PrintRow(dr, dx2, worksheets, j, k);
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

       
        protected void rdCustomer_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "SpecialPricing";
            string dataQuery = "SpecialPricing";
            string reportName = "(Special Pricing)";
            string reportSubName = "(أسعار خاصة)";
            string cusID = Cus();
            string rotid = ROT();
            string mainCondition = mainCondition1(cusID);

            GenerateExcel3(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void CustomerItems_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "CustomerItemprice";
            string dataQuery = "CustomerItemsstandardprice";
            string reportName = "(Customer Item standard price)";
            string reportSubName = "(السعر القياسي لعنصر العميل)";
            string cusID = Cus();
            string mainCondition = mainCondition2(cusID);

            GenerateExcel3(fileName, dataQuery, reportName, reportSubName, mainCondition);
        }

        protected void CusWithoutSplPrice_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            lblMessage.Text = "";
            string fileName = "ItemsWithoutSpecialPrice";
            string dataQuery = "CustomerItemsWithoutSpecialPrice";
            string reportName = "(Customer Items Without Special Price)";
            string reportSubName = "(عناصر العملاء بدون سعر خاص)";
            string cusID = Cus();
            string mainCondition = mainCondition1(cusID);

            GenerateExcel3(fileName, dataQuery, reportName, reportSubName, mainCondition);
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

        public void Region()
        {
            region.DataSource = ObjclsFrms.loadList("SelectRegion", "sp_ExcelMasterReport", UICommon.GetCurrentUserID().ToString());
            region.DataTextField = "reg_Name";
            region.DataValueField = "reg_ID";
            region.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            depot.DataSource = ObjclsFrms.loadList("SelectDepot", "sp_ExcelMasterReport", UICommon.GetCurrentUserID().ToString(), arr);
            depot.DataTextField = "dep_Name";
            depot.DataValueField = "dep_ID";
            depot.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            dpoArea.DataSource = ObjclsFrms.loadList("SelectDepotArea", "sp_ExcelMasterReport", UICommon.GetCurrentUserID().ToString(), arr);
            dpoArea.DataTextField = "dpa_Name";
            dpoArea.DataValueField = "dpa_ID";
            dpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            dpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubArea", "sp_ExcelMasterReport", UICommon.GetCurrentUserID().ToString(), arr);
            dpoSubArea.DataTextField = "dsa_Name";
            dpoSubArea.DataValueField = "dsa_ID";
            dpoSubArea.DataBind();
        }
        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            ddlroute.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_ExcelMasterReport", UICommon.GetCurrentUserID().ToString(), arr);
            ddlroute.DataTextField = "rot_Name";
            ddlroute.DataValueField = "rot_ID";
            ddlroute.DataBind();
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

        public string ROT()
        {
            var CollectionMarket3 = ddlroute.CheckedItems;
            string routeID = "";
            int j = 0;
            int MarCount = CollectionMarket3.Count;
            if (CollectionMarket3.Count > 0)
            {
                foreach (var item in CollectionMarket3)
                {
                    if (j == 0)
                    {
                        routeID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        routeID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        routeID += item.Value;
                    }
                    j++;
                }
                return routeID;
            }
            else
            {
                return "rcs_rot_ID";
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

        protected void ddlroute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string routeID = ROT();
            string RouteCondition = " rcs_rot_ID in (" + routeID + ")";
            Customer(RouteCondition);
        }
    }
}