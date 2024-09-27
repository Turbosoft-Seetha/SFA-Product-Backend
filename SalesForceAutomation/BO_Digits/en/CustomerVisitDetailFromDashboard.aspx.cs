using GoogleApi.Entities.Common.Enums;
using SalesForceAutomation.Admin;
using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerVisitDetailFromDashboard : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public string Mode
        {
            get
            {
                string Mode = Request.Params["Mode"].ToString();

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    Route();

                    ViewState["StatusCondition"] = "";

                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                    }
                    if (Session["Route"] != null)
                    {

                        string rotID = Session["Route"].ToString();
                        string[] ar = rotID.Split(',');
                        int k = 0;
                        foreach (RadComboBoxItem items in ddlRoute.Items)
                        {
                            string rot = items.Value;
                            string arrot = ar[k];
                            if (items.Value == ar[k])
                            {
                                items.Checked = true;
                                k++;
                            }
                        }

                        int c = k;
                        string rotcount = Rot();
                    }
                    else
                    {
                        RouteFromTransaction();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

                if (Mode == "Planned")
                {
                    LoadPlannedVisited();
                    LoadPlannedPending();

                    LoadPlannedData();
                    grvRpt.Rebind();
                    RadGrid1.Rebind();
                    RadGrid2.Rebind();
                    lblHeading.Text = "Planned Visits";
                    pnlUnplanned.Visible = false;
                    pnlPending.Visible = true;
                }
                else if (Mode == "Actual")
                {
                    LoadActualPlanned();
                    LoadActualUnPlanned();

                    LoadActualData();
                    grvRpt.Rebind();
                    RadGrid1.Rebind();
                    RadGrid2.Rebind();
                    lblHeading.Text = "Actual Visits";
                    pnlUnplanned.Visible = true;
                    pnlPending.Visible = false;
                }
                else if (Mode == "Prod")
                {
                    LoadProdPlanned();
                    LoadProdUnPlanned();

                    LoadProdData();
                    grvRpt.Rebind();
                    RadGrid1.Rebind();
                    RadGrid2.Rebind();
                    lblHeading.Text = "Productive Visits";
                    pnlUnplanned.Visible = true;
                    pnlPending.Visible = false;
                }
                else if (Mode == "NonProd")
                {
                    LoadNonProdPlanned();
                    LoadNonProdUnPlanned();

                    LoadNonProdData();
                    grvRpt.Rebind();
                    RadGrid1.Rebind();
                    RadGrid2.Rebind();
                    lblHeading.Text = "Non Productive Visits";
                    pnlUnplanned.Visible = true;
                    pnlPending.Visible = false;
                }
                else
                {


                }
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = obj.loadList("SelRouteForVisitDropDown", "sp_Dashboard", UICommon.GetCurrentUserID().ToString());
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
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
            var CollectionMarket = ddlRoute.CheckedItems;
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
                return "rot_ID";
            }
        }

        public string Routes()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = ddlRoute.CheckedItems;
                    int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (var item in CollectionMarket)
                        {
                            string rotId = item.Value;
                            createNode(rotId, writer);
                            c++;
                        }
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void LoadPlannedData()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            string Status = ViewState["StatusCondition"].ToString();
            string StatCondition = "";

            if (!string.IsNullOrEmpty(Status))
            {
                StatCondition = ViewState["StatusCondition"].ToString();
            }
            else
            {
                StatCondition = "";
            }

            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate, StatCondition };
            lstUser = obj.loadList("CustomerPlannedData", "sp_Dashboard", rot, arr);
            grvRpt.DataSource = lstUser;
        }
        public void LoadActualData()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            string Status = ViewState["StatusCondition"].ToString();
            string StatCondition = "";

            if (!string.IsNullOrEmpty(Status))
            {
                StatCondition = ViewState["StatusCondition"].ToString();
            }
            else
            {
                StatCondition = "";
            }

            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate, StatCondition };
            lstUser = obj.loadList("CustomerVisitsActualData", "sp_Dashboard", rot, arr);
            grvRpt.DataSource = lstUser;
        }
        public void LoadProdData()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            string Status = ViewState["StatusCondition"].ToString();
            string StatCondition = "";

            if (!string.IsNullOrEmpty(Status))
            {
                StatCondition = ViewState["StatusCondition"].ToString();
            }
            else
            {
                StatCondition = "";
            }

            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate, StatCondition };
            lstUser = obj.loadList("CustomerVisitsProdData", "sp_Dashboard", rot, arr);
            grvRpt.DataSource = lstUser;
        }
        public void LoadNonProdData()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            string Status = ViewState["StatusCondition"].ToString();
            string StatCondition = "";

            if (!string.IsNullOrEmpty(Status))
            {
                StatCondition = ViewState["StatusCondition"].ToString();
            }
            else
            {
                StatCondition = "";
            }

            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate, StatCondition };
            lstUser = obj.loadList("CustomerVisitsNonProdData", "sp_Dashboard", rot, arr);
            grvRpt.DataSource = lstUser;
        }

        public void LoadPlannedVisited()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerPlannedVisited", "sp_Dashboard", rot, arr);
            RadGrid1.DataSource = lstUser;
        }
        public void LoadPlannedPending()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerPlannedPending", "sp_Dashboard", rot, arr);
            RadGrid2.DataSource = lstUser;
        }
        public void LoadActualPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerActualPlanned", "sp_Dashboard", rot, arr);
            RadGrid1.DataSource = lstUser;
        }
        public void LoadActualUnPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerActualUnPlanned", "sp_Dashboard", rot, arr);
            RadGrid2.DataSource = lstUser;
        }
        public void LoadProdPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerProductivePlanned", "sp_Dashboard", rot, arr);
            RadGrid1.DataSource = lstUser;
        }
        public void LoadProdUnPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerProductiveUnPlanned", "sp_Dashboard", rot, arr);
            RadGrid2.DataSource = lstUser;
        }
        public void LoadNonProdPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerNonProductivePlanned", "sp_Dashboard", rot, arr);
            RadGrid1.DataSource = lstUser;
        }
        public void LoadNonProdUnPlanned()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            DataTable lstUser = default(DataTable);
            string[] arr = { fromDate, endDate };
            lstUser = obj.loadList("CustomerNonProductiveUnPlanned", "sp_Dashboard", rot, arr);
            RadGrid2.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (Mode == "Planned")
            {
                LoadPlannedData();
            }
            else if (Mode == "Actual")
            {
                LoadActualData();

            }
            else if (Mode == "Prod")
            {
                LoadProdData();

            }
            else if (Mode == "NonProd")
            {
                LoadNonProdData();

            }
            else
            {
            }
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            if (Mode == "Planned")
            {
                LoadPlannedVisited();
                LoadPlannedPending();

                LoadPlannedData();
                grvRpt.Rebind();
                RadGrid1.Rebind();
                RadGrid2.Rebind();
                lblHeading.Text = "Planned Visits";
                pnlUnplanned.Visible = false;
                pnlPending.Visible = true;
            }
            else if (Mode == "Actual")
            {
                LoadActualPlanned();
                LoadActualUnPlanned();

                LoadActualData();
                grvRpt.Rebind();
                RadGrid1.Rebind();
                RadGrid2.Rebind();
                lblHeading.Text = "Actual Visits";
                pnlUnplanned.Visible = true;
                pnlPending.Visible = false;
            }
            else if (Mode == "Prod")
            {
                LoadProdPlanned();
                LoadProdUnPlanned();

                LoadProdData();
                grvRpt.Rebind();
                RadGrid1.Rebind();
                RadGrid2.Rebind();
                lblHeading.Text = "Productive Visits";
                pnlUnplanned.Visible = true;
                pnlPending.Visible = false;
            }
            else if (Mode == "NonProd")
            {
                LoadNonProdPlanned();
                LoadNonProdUnPlanned();

                LoadNonProdData();
                grvRpt.Rebind();
                RadGrid1.Rebind();
                RadGrid2.Rebind();
                lblHeading.Text = "Non Productive Visits";
                pnlUnplanned.Visible = true;
                pnlPending.Visible = false;
            }
            else
            {
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (Mode == "Planned")
            {
                LoadPlannedVisited();
                LoadPlannedPending();

            }
            else if (Mode == "Actual")
            {
                LoadActualPlanned();
                LoadActualUnPlanned();

            }
            else if (Mode == "Prod")
            {
                LoadProdPlanned();
                LoadProdUnPlanned();

            }
            else if (Mode == "NonProd")
            {
                LoadNonProdPlanned();
                LoadNonProdUnPlanned();

            }
            else
            {
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid2_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (Mode == "Planned")
            {
                LoadPlannedVisited();
                LoadPlannedPending();

            }
            else if (Mode == "Actual")
            {
                LoadActualPlanned();
                LoadActualUnPlanned();

            }
            else if (Mode == "Prod")
            {
                LoadProdPlanned();
                LoadProdUnPlanned();

            }
            else if (Mode == "NonProd")
            {
                LoadNonProdPlanned();
                LoadNonProdUnPlanned();

            }
            else
            {


            }
        }
        protected void Adj_CheckedChanged(object sender, EventArgs e)
        {
            if (Adj.Checked == true)
            {

                string StatusCondition = " and isnull(cse_ExistStatus, 'N') <> 'CE' ";
                ViewState["StatusCondition"] = StatusCondition;

                if (Mode == "Planned")
                {
                    LoadPlannedData();
                    grvRpt.Rebind();
                }
                else if (Mode == "Actual")
                {
                    LoadActualData();
                    grvRpt.Rebind();
                }
                else if (Mode == "Prod")
                {
                    LoadProdData();
                    grvRpt.Rebind();
                }
                else if (Mode == "NonProd")
                {
                    LoadNonProdData();
                    grvRpt.Rebind();
                }

            }
            else
            {
                ViewState["StatusCondition"] = "";
                if (Mode == "Planned")
                {
                    LoadPlannedData();
                    grvRpt.Rebind();
                }
                else if (Mode == "Actual")
                {
                    LoadActualData();
                    grvRpt.Rebind();
                }
                else if (Mode == "Prod")
                {
                    LoadProdData();
                    grvRpt.Rebind();
                }
                else if (Mode == "NonProd")
                {
                    LoadNonProdData();
                    grvRpt.Rebind();
                }

            }
        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;
                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdfromDate.SelectedDate = startdate;
                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rot = Routes();
            string[] arr = { fromDate, endDate };
            DataTable dt = new DataTable();

            if (Mode == "Planned")
            {
                dt=obj.loadList("ExcelDtforPlanned", "sp_Dashboard", rot, arr);
            }
            else if (Mode == "Actual")
            {
                dt= obj.loadList("ExcelDtforActual", "sp_Dashboard", rot, arr);
            }
            else if (Mode == "Prod")
            {
                dt = obj.loadList("ExcelDtforProd", "sp_Dashboard", rot, arr);
            }
            else if (Mode == "NonProd")
            {
                dt = obj.loadList("ExcelDtforNoProd", "sp_Dashboard", rot, arr);
            }
            else
            {

            }

            SpreadStreamProcessingForXLSXAndCSV(dt,"N");
        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, string mode, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Sheet1")
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
                if (mode == "D")
                {
                    if (Mode == "Planned")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Visit_Planned", "Xlsx"));
                    }
                    else if (Mode == "Actual")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Visit_Actual", "Xlsx"));
                    }
                    else if (Mode == "Prod")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Visits_Productive", "Xlsx"));
                    }
                    else if (Mode == "NonProd")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Visit_Non Productive ", "Xlsx"));
                    }
                }
                else
                {
                    if (Mode == "Planned")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Planned Visits", "Xlsx"));
                    }
                    else if (Mode == "Actual")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Actual Visits", "Xlsx"));
                    }
                    else if (Mode == "Prod")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Productive Visits", "Xlsx"));
                    }
                    else if (Mode == "NonProd")
                    {
                        Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Non Productive Visits", "Xlsx"));
                    }

                }

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

        protected void Excel2_Click(object sender, ImageClickEventArgs e)
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
                for (int i = 0; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].Display == true)
                    {


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
            SpreadStreamProcessingForXLSXAndCSV(dt,"D");
        }
    }
};