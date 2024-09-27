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
    public partial class OutOfStockAnalysis : System.Web.UI.Page
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
                plhFilter.Visible = false;
                Region();
                Route();
                if (Mode == 1 ) // While loading page from dashboard 
                {
                    try
                    {
                        rdRoute.Enabled = false;
                        rdCustomer.Enabled = false;
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;
                        ddlAccessPoint.Enabled = false;
                        ddlBrand.Enabled = false;
                        ddlProducts.Enabled = false;

                        if (Session["FromDate"] != null)
                        {
                            rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                        }
                    }
                    catch
                    {

                    }
                    RegionFromDashboard();
                    string region = REG();
                    string regionCondition = " dep_reg_ID in (" + region + ")";

                    Depot(regionCondition);
                    DepoFromDashboard();
                    string depo = DPO();
                    string dpocondition = " dpa_dep_ID in (" + depo + ")";

                    DpoArea(dpocondition);
                    DepoAreaFromDashboard();
                    string depoarea = DPOarea();
                    string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";

                    DpoSubArea(dpoareacondition);
                    DepoSubAreaFromDashboard();
                    string deposubarea = DPOsubarea();
                    string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";

                   // Route(dposubareacondition);
                    RouteFromDashboard();


                }
                else if (Mode==2) // While loading page from inventory monitoring dashboard 
                {                    
                        try
                        {
                        rdRoute.Enabled = false;
                        rdCustomer.Enabled = false;
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;
                        ddlAccessPoint.Enabled = false;
                        ddlBrand.Enabled = false;
                        ddlProducts.Enabled = false;

                        if (Session["FromDate"] != null)
                            {
                                rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                            }

                            if (Session["ToDate"] != null)
                            {
                                rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                            }
                        string route = Session["Route"] != null ? Session["Route"].ToString() : string.Empty;
                        RouteFromInvMontDashboard();
                        string routeCondition = " rcs_rot_ID in (" + route + ")";
                        Customer(routeCondition);

                    }
                        catch (Exception ex)
                        {
                           
                        }
                        RegionFromDashboard();
                    string region = REG();
                    string regionCondition = " dep_reg_ID in (" + region + ")";

                    Depot(regionCondition);
                    DepoFromDashboard();
                    string depo = DPO();
                    string dpocondition = " dpa_dep_ID in (" + depo + ")";

                    DpoArea(dpocondition);
                    DepoAreaFromDashboard();
                    string depoarea = DPOarea();
                    string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";

                    DpoSubArea(dpoareacondition);
                    DepoSubAreaFromDashboard();
                    string deposubarea = DPOsubarea();
                    string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";

                }
                else
                {


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
                  
                    rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("dd-MMM-yyyy"));
                    rdendDate.SelectedDate = DateTime.Now;

                }
                
              //  RouteFromTransaction();
               // string rotID = Rot();
               // string routeCondition = "rcs_rot_ID in (" + rotID + ")";
               
                //CustomerFilter();

                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                AccessPoint(fromDate, toDate);
                Brands(fromDate, toDate);
                int B = 1;
                foreach (RadComboBoxItem itmss in ddlBrand.Items)
                {
                    itmss.Checked = true;
                    B++;
                }
              //  Customer(routeCondition);
                foreach (RadComboBoxItem itmss in rdCustomer.Items)
                {
                    itmss.Checked = true;
                    B++;
                }
                Products();
                foreach (RadComboBoxItem itmss in ddlProducts.Items)
                {
                    itmss.Checked = true;
                    B++;
                }
                foreach (RadComboBoxItem itmss in ddlAccessPoint.Items)
                {
                    itmss.Checked = true;
                    B++;
                }

            }
        }
        public void RegionFromDashboard()
        {
            try
            {


                if (Session["Region"] != null)
                {
                    string ids = Session["Region"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddlregion.Items)
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
        public void DepoFromDashboard()
        {
            try
            {


                if (Session["Depo"] != null)
                {
                    string ids = Session["Depo"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldepot.Items)
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

        public void DepoAreaFromDashboard()
        {
            try
            {


                if (Session["DepoArea"] != null)
                {
                    string ids = Session["DepoArea"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldpoArea.Items)
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
        public void DepoSubAreaFromDashboard()
        {
            try
            {


                if (Session["Depo"] != null)
                {
                    string ids = Session["DepoSubArea"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in ddldpoSubArea.Items)
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

        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRoutes", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public void Customer(string routeCondition)
        {
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerforTransaction", "sp_Transaction", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }

        public void RouteFromDashboard()
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

        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
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
                return "udp_rot_ID";
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
        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string acpID = Acp();
            string brdID = Brd();
            string prdID = Prd();
            string customerCondition = "";
            string dateCondition = "";
            string aceessCondition = "";
            string brandCondition = "";
            string productCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and osh_cus_ID in (" + cusID + ")";
                }
                if (acpID.Equals("0"))
                {
                    aceessCondition = "";
                }
                else
                {
                    aceessCondition = " and osd_inl_ID in (" + acpID + ")";
                }
                if (brdID.Equals("0"))
                {
                    brandCondition = "";
                }
                else
                {
                    brandCondition = " and osh_brd_ID in (" + brdID + ")";
                }
                if (prdID.Equals("0"))
                {
                    productCondition = "";
                }
                else
                {
                    productCondition = " and osi_itm_ID in (" + prdID + ")";
                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            mainCondition += aceessCondition;
            mainCondition += brandCondition;
            mainCondition += productCondition;
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
                    }
                    catch { }
                }
                else if (Mode == 2)
                {
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                    }
                    catch { }
                }
                else
                {
                    mainCondition = mainConditions(rotID);
                }
               
                DataTable lstdata = ObjclsFrms.loadList("SelectOutOfSockAnalysis", "sp_Merch_Analysis", mainCondition);
                grvRpt.DataSource = lstdata;
            }
        }


        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)

            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                     && !column.HeaderText.Equals("Initial Images") && !column.HeaderText.Equals("Final Images")
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

                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Asset")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Documents"))
                                 && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Initial Images"))
                                && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Final Images")))
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

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("udp_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";
            Customer(routeCondition);
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            ListData();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
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

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void lnkAdvFilter_Click(object sender, EventArgs e)
        {
            if (plhFilter.Visible == true)
            {
                plhFilter.Visible = false;
            }
            else
            {
                plhFilter.Visible = true;
            }
        }

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;
                string imah1 = dataItem["osd_InitailImage"].Text.ToString();
                string imah2 = dataItem["osd_FinalImage"].Text.ToString();

                string[] values = imah1.Split(',');
                string[] values2 = imah2.Split(',');

                imah1 = imah1.Replace("&nbsp;", null);
                imah2 = imah2.Replace("&nbsp;", null);
                for (int i = 0; i < values.Length; i++)
                {
                    if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                    {
                        Image img1 = new Image();
                        img1.ID = "Image1" + i.ToString();
                        img1.ImageUrl = "../" + values[i].ToString();
                        img1.Height = 20;
                        img1.Width = 20;
                        img1.BorderStyle = BorderStyle.Groove;
                        img1.BorderWidth = 2;
                        img1.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        hl.NavigateUrl = "../" + values[i].ToString();
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img1);

                        dataItem["Images1"].Controls.Add(hl);
                    }
                }
                for (int i = 0; i < values2.Length; i++)
                {
                    if (!values2[i].Equals("&nbsp;") && !values2[i].Equals(""))
                    {
                        Image img2 = new Image();
                        img2.ID = "Image2" + i.ToString();
                        img2.ImageUrl = "../" + values2[i].ToString();
                        img2.Height = 20;
                        img2.Width = 20;
                        img2.BorderStyle = BorderStyle.Groove;
                        img2.BorderWidth = 2;
                        img2.BorderColor = System.Drawing.Color.Black;
                        HyperLink hll = new HyperLink();
                        hll.NavigateUrl = "../" + values2[i].ToString();
                        hll.ID = "hll" + i.ToString();
                        hll.Target = "_blank";
                        hll.Controls.Add(img2);

                        dataItem["Images2"].Controls.Add(hll);
                    }
                }
                //dataItem["mei_Images"].Text = imah.Replace("../", "http://93.177.125.68/");
            }
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            AccessPoint(fromDate, toDate);
            Brands(fromDate, toDate);

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
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            AccessPoint(fromDate, toDate);
            Brands(fromDate, toDate);

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

        protected void ddlBrand_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Products();
        }

        protected void AccessPoint(string fromDate, string toDate)
        {
            string[] arr = { toDate };
            DataTable lstAccessPoint = ObjclsFrms.loadList("SelectOOSLocationFilter", "sp_Merch_Analysis", fromDate, arr);
            if (lstAccessPoint.Rows.Count > 0)
            {
                ddlAccessPoint.DataSource = lstAccessPoint;
                ddlAccessPoint.DataValueField = "inl_ID";
                ddlAccessPoint.DataTextField = "inl_Name";
                ddlAccessPoint.DataBind();
            }
        }

        protected void Brands(string fromDate, string toDate)
        {
            string[] arr = { toDate };
            DataTable lstBrands = ObjclsFrms.loadList("SelectOOSBrandFilter", "sp_Merch_Analysis", fromDate, arr);
            if (lstBrands.Rows.Count > 0)
            {
                ddlBrand.DataSource = lstBrands;
                ddlBrand.DataValueField = "brd_ID";
                ddlBrand.DataTextField = "brd_Name";
                ddlBrand.DataBind();
            }
        }

        protected void Products()
        {
            string brdID = Brd();
            string condition = "osh_brd_ID in (" + brdID + ")";
            DataTable lstProducts = ObjclsFrms.loadList("SelectOOSItemFilter", "sp_Merch_Analysis", condition);
            if (lstProducts.Rows.Count > 0)
            {
                ddlProducts.DataSource = lstProducts;
                ddlProducts.DataValueField = "prd_ID";
                ddlProducts.DataTextField = "prd_Name";
                ddlProducts.DataBind();
            }
        }

        public string Acp()
        {
            var CollectionMarket15 = ddlAccessPoint.CheckedItems;
            string acpID = "";
            int j = 0;
            int MarCount = CollectionMarket15.Count;
            if (CollectionMarket15.Count > 0)
            {
                foreach (var item in CollectionMarket15)
                {
                    if (j == 0)
                    {
                        acpID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        acpID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        acpID += item.Value;
                    }
                    j++;
                }
                return acpID;
            }
            else
            {
                return "0";
            }
        }

        public string Brd()
        {
            var CollectionMarket16 = ddlBrand.CheckedItems;
            string brdID = "";
            int j = 0;
            int MarCount = CollectionMarket16.Count;
            if (CollectionMarket16.Count > 0)
            {
                foreach (var item in CollectionMarket16)
                {
                    if (j == 0)
                    {
                        brdID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        brdID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        brdID += item.Value;
                    }
                    j++;
                }
                return brdID;
            }
            else
            {
                return "0";
            }
        }

        public string Prd()
        {
            var CollectionMarket17 = ddlProducts.CheckedItems;
            string prdID = "";
            int j = 0;
            int MarCount = CollectionMarket17.Count;
            if (CollectionMarket17.Count > 0)
            {
                foreach (var item in CollectionMarket17)
                {
                    if (j == 0)
                    {
                        prdID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        prdID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        prdID += item.Value;
                    }
                    j++;
                }
                return prdID;
            }
            else
            {
                return "0";
            }
        }
      
    }
}