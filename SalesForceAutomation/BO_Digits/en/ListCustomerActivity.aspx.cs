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
using static Telerik.Web.Apoc.Render.Pdf.PdfRendererOptions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListCustomerActivity : System.Web.UI.Page
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
               

                if (Mode == 3 ||  Mode == 1)
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
                        Activity();
                        RouteFromDashboard();



                    }
                    catch (Exception ex)
                    {
                        UICommon.LogException(ex, "List Customer Activity");
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListCustomerActivity.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                    }
                }
                else if (Mode == 2) // While loading page from Inventory monitoring dashboard
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdFromDate.Enabled = false;
                    rdEndDate.Enabled = false;
                    ddlActivity.Enabled = false;

                    try
                    {
                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }

                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                        }
                        string route = Session["Route"] != null ? Session["Route"].ToString() : string.Empty;
                        RouteFromInvMontDashboard();
                        string routeCondition = " rcs_rot_ID in (" + route + ")";
                        Customer(routeCondition);
                        Activity();

                    }
                    catch (Exception ex)
                    {

                    }
                    

                }
                else // While loading page from transaction menu
                {
                    
                    try
                    {
                        if (Session["LCAFDate"] != null)
                        {

                            rdFromDate.SelectedDate = DateTime.Parse(Session["LCAFDate"].ToString());
                        }
                        else
                        {
                            rdFromDate.SelectedDate = DateTime.Now;


                        }
                        rdFromDate.MaxDate = DateTime.Now;

                        if (Session["LCATDate"] != null)
                        {

                            rdEndDate.SelectedDate = DateTime.Parse(Session["LCATDate"].ToString());
                        }
                        else
                        {
                            rdEndDate.SelectedDate = DateTime.Now.AddDays(1);

                        }
                        rdEndDate.MaxDate = DateTime.Now.AddDays(1);
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                    try
                    {
                        if (Session["LCArotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string rotID = Session["LCArotID"].ToString();
                            string[] ar = rotID.Split(',');
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
                            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                            Customers(routeCondition);

                        }
                        else
                        {
                            foreach (RadComboBoxItem itmss in rdRoute.Items)
                            {
                                itmss.Checked = true;

                            }

                            string rotID = Rot();
                            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                            Customers(routeCondition);


                        }
                        if (Session["LCAcusID"] != null)
                        {
                            int a = rdCustomer.Items.Count;
                            string cusID = Session["LCAcusID"].ToString();
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
                            string cusCondition = "cah_cus_ID in (" + cusID + ")";
                        }                      

                        if (Session["LCAActivityID"] != null)
                        {
                            int a = ddlActivity.Items.Count;
                            string Activity = Session["LCAActivityID"].ToString();
                            string[] ar = Activity.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in ddlActivity.Items)
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
                            int k = 1;
                            foreach (RadComboBoxItem itmss in ddlActivity.Items)
                            {
                                itmss.Checked = true;
                                k++;
                            }
                            string actvity = ACTVT();
                            string activityCondition = " cah_ID in (" + actvity + ")";


                        }
                    }
                    catch
                    {

                    }
                    Activity();
                }
                try
                {
                    GetGridSession(grvRpt, "LCA");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListCustomerActivity.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
                int B = 1;
                foreach (RadComboBoxItem itmss in rdCustomer.Items)
                {
                    itmss.Checked = true;
                    B++;
                }

            }
        }

        public void RouteFromInvMontDashboard()
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
        public void Customer(string routeCondition)
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_wb_merch_others", routeCondition);
            rdCustomer.DataSource = dtc;
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public string mainConditions(string rotID)
        {
            string CusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string activityCondition = "";
            string actvity = ACTVT();
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
                if(actvity.Equals("0"))
                {
                    activityCondition = "";

                }
                else
                {
                    activityCondition= " and cah_ID in (" + actvity + ")";
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
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                if (Mode == 1)
                {
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
                }
                else if (Mode == 2)
                {
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
                }
                else
                {
                    mainCondition = mainConditions(rotID);
                }

                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("SelectCustomerActivityfromDashboard", "sp_Merch_Dashboard", mainCondition);
                grvRpt.DataSource = lstUser;
            }            
        }
      
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "LCA");
            }
            catch (Exception ex)
            {

            }
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cah_ID").ToString();
                Response.Redirect("AddEditCustomerActivity.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cah_ID").ToString();
                Response.Redirect("ListCustomerActivityDetail.aspx?HID=" + ID);
            }
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName)
                    && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail")
                   && !column.HeaderText.Equals("Edit") && !column.HeaderText.Equals("Image")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail") &&
                            !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Activity", "Xlsx"));
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
            try
            {
                if (Session["LCAFDate"] != null)
                {
                    string fromdate = rdFromDate.SelectedDate.ToString();
                    if (fromdate == Session["LCAFDate"].ToString())
                    {
                        rdFromDate.SelectedDate = DateTime.Parse(Session["LCAFDate"].ToString());
                    }
                    else
                    {
                        Session["LCAFDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdFromDate.SelectedDate = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    Session["LCAFDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());

                }
                rdFromDate.MaxDate = DateTime.Now;

                if (Session["LCATDate"] != null)
                {
                    string todate = rdEndDate.SelectedDate.ToString();
                    if (todate == Session["LCATDate"].ToString())
                    {
                        rdEndDate.SelectedDate = DateTime.Parse(Session["LCATDate"].ToString());
                    }
                    else
                    {
                        Session["LCATDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdEndDate.SelectedDate = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    Session["LCATDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                }
                rdEndDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["LCArotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["LCArotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["LCArotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["LCArotID"] = rotID;
                }

                if (Session["LCAcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["LCAcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["LCAcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["LCAcusID"] = cusID;
                }

                if (Session["LCAActivityID"] != null)
                {
                    string Activity = ACTVT();
                    if (Activity == Session["LCAActivityID"].ToString())
                    {
                        string activity = ACTVT();

                    }
                    else
                    {
                        string activity = ACTVT();
                        Session["LCAActivityID"] = activity;
                    }

                }
                else
                {
                    string activity = ACTVT();
                    Session["LCAActivityID"] = activity;
                }

            }
            catch (Exception ex)
            {

            }
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
        public string ACTVT()
        {
            var ColelctionMarket = ddlActivity.CheckedItems;
            string cahID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        cahID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cahID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cahID += item.Value;
                    }
                    j++;
                }
                return cahID;
            }
            else
            {
                return "cah_ID";
            }
        }
        public void Customers(string routeCondition)
        {
           // DataTable dt = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRoutes", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public void Activity()
        {
            string cus = Cus();
            string cusCondition = " cah_cus_ID in (" + cus + ")";
            ddlActivity.DataSource = ObjclsFrms.loadList("SelectCustomerActivityName", "sp_Masters",cusCondition);
            ddlActivity.DataTextField = "cah_Name";
            ddlActivity.DataValueField = "cah_ID";
            ddlActivity.DataBind();
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

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
           
            Activity();
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

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
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
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
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