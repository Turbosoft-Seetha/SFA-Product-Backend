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
    public partial class ListCustomerActivityAnalysis : System.Web.UI.Page
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
                Route();
                if (Mode == 3 || Mode == 2 || Mode == 1)
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdFromDate.Enabled = false;
                    rdEndDate.Enabled = false;
                    ddlActivity.Enabled = false;

                    try
                    {
                        ViewState["fromdate"] = Session["FromDate"];
                        ViewState["todate"] = Session["ToDate"];
                        ViewState["route"] = Session["Route"];
                        string r = Session["Route"].ToString();
                        //string ed = Session["tDate"].ToString();

                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                        }
                        Route();
                        RouteFromDashboard();
                        string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string toDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        Activity(fromDate, toDate);

                    }
                    catch (Exception ex)
                    {
                        UICommon.LogException(ex, "List Customer Activity");
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListCustomerActivity.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                    }
                }
                else // While loading page from transaction menu
                {
                    rdFromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    rdEndDate.SelectedDate = DateTime.Now;
                    string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string toDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    Activity(fromDate, toDate);
                    Route();
                    int j = 1;
                    foreach (RadComboBoxItem itmss in rdRoute.Items)
                    {
                        itmss.Checked = true;
                        j++;
                    }
                }
                int b = 1;
                foreach (RadComboBoxItem itmss in ddlActivity.Items)
                {
                    itmss.Checked = true;
                    b++;
                }

                string rotID = Rot();
                string routeCondition = " rcs_rot_ID in (" + rotID + ")";

                Customers(routeCondition);
                CustomerFilter();
            }
        }

        public string mainConditions(string rotID)
        {
            string CusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string ActID = Act();
            string activityCondition = "";
            string mainCondition = " cah_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (isnull(cast(A.ModifiedDate as date),cast(A.CreatedDate as date)) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                //string CusID = rdCustomer.SelectedValue.ToString();
                if (CusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and cah_cus_ID in (" + CusID + ")";
                }
                if (ActID.Equals("0"))
                {
                    activityCondition = "";
                }
                else
                {
                    activityCondition = " and cah_Name IN (" + ActID + ")";
                }

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            mainCondition += activityCondition;
            return mainCondition;
        }
        public void ListData()
        {

            DataTable lstUser = default(DataTable);
            if (Mode == 1)
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                        string type = Request.Params["type"].ToString();
                        if (type.Equals("CC"))
                        {
                            mainCondition += " and E.Status='Y'";
                        }
                        else if (type.Equals("OP"))
                        {
                            mainCondition += " and E.Status='N'";
                        }
                       
                    }
                    catch { }
                    lstUser = ObjclsFrms.loadList("SelectCustomerActivityAnalysis", "sp_Merch_Analysis", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
            else
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";                  
                    mainCondition = mainConditions(rotID);                                     
                    lstUser = ObjclsFrms.loadList("SelectCustomerActivityAnalysiss", "sp_Merch_Analysis", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
        }
      
        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)

            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Reference Image")
                    && !column.HeaderText.Equals("CaptureImage")
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
                for (int i = 0; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].Display == true)
                    {

                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail")&& !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Images"))
                        {
                            if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Reference Image")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("CaptureImage"))
                                )
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
            string sheetName = "CustomerInventoryAnalysis";
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
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCustomerActivity.aspx?Id=0");
        }

        protected void lnkfilter_Click(object sender, EventArgs e)
        {
            ListData();
            grvRpt.Rebind();
        }
        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
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
        public void Customers(string routeCondition)
        {
            DataTable dt = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Activity(string fromDate, string ToDate)
        {
            string[] arr = { ToDate };
            DataTable dt = ObjclsFrms.loadList("SelectCustActivityFilter", "sp_Merch_Analysis", fromDate, arr);
            ddlActivity.DataSource = dt;
            ddlActivity.DataTextField = "cah_Name";
            ddlActivity.DataValueField = "cah_Name";
            ddlActivity.DataBind();
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRoutes", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }
        public string Cus()
        {
            var ColelctionMarkets = rdCustomer.CheckedItems;
            string cusID = "";
            int k = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (k > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (k == (MarCounts - 1))
                    {
                        cusID += item.Value;
                    }
                    k++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }

        public string Act()
        {
            var ColelctionMarketss = ddlActivity.CheckedItems;
            string actID = "";
            int k = 0;
            int MarCounts = ColelctionMarketss.Count;
            if (ColelctionMarketss.Count > 0)
            {
                foreach (var item in ColelctionMarketss)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        actID += "'" + item.Value + "',";
                    }
                    else if (k > 0)
                    {
                        actID += "'" + item.Value + "',";
                    }
                    if (k == (MarCounts - 1))
                    {
                        actID += "'" + item.Value + "'";
                    }
                    k++;
                }
                return actID;
            }
            else
            {
                return "0";
            }
        }

        public void RouteFromDashboard()
        {
            try
            {


                if (Session["Route"] != null)
                {
                    string ids = Session["Route"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in rdRoute.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch { }
        }
        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string img1 = dataItem["cai_CaptureImage"].Text.ToString();
                string[] arrImg = img1.Split(',');
                //img1 = img1.Replace("&nbsp;", null);
                for (int i = 0; i < arrImg.Length; i++)
                {
                    Image img = new Image();
                    img.ID = "Image1" + i.ToString();
                    img.ImageUrl = "../" + arrImg[i].ToString();
                    img.Height = 20;
                    img.Width = 20;
                    img.BorderStyle = BorderStyle.Groove;
                    img.BorderWidth = 2;
                    img.BorderColor = System.Drawing.Color.Black;
                    HyperLink hl = new HyperLink();
                    hl.NavigateUrl = "../" + arrImg[i].ToString();
                    hl.ID = "hl" + i.ToString();
                    hl.Target = "_blank";
                    hl.Controls.Add(img);
                    dataItem["CaptureImage"].Controls.Add(hl);
                }
            }
        }

        protected void rdFromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Activity(fromDate, toDate);
            if (rdFromDate.SelectedDate != null && rdEndDate.SelectedDate != null)
            {
                TimeSpan difference = rdEndDate.SelectedDate.Value - rdFromDate.SelectedDate.Value;
                DateTime endDate = rdFromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdEndDate.MaxDate = DateTime.Today;
                    rdEndDate.SelectedDate = endDate;
                }
                else
                {
                    rdEndDate.MaxDate = DateTime.Today;
                }
            }
        }

        protected void rdEndDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Activity(fromDate, toDate);
            if (rdFromDate.SelectedDate != null && rdEndDate.SelectedDate != null)
            {
                TimeSpan difference = rdEndDate.SelectedDate.Value - rdFromDate.SelectedDate.Value;
                DateTime startdate = rdEndDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdFromDate.SelectedDate = startdate;
                }
                else
                {
                    rdFromDate.MaxDate = DateTime.Today;
                }
            }
        }
    }
}