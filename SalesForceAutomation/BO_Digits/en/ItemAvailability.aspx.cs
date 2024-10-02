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
    public partial class ItemAvailability : System.Web.UI.Page
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
                else if (Mode == 2) // While loading page from inventory monitoring dashboard 
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
                else // While loading page from transaction menu
                {
                    try
                    {
                        if (Session["IAFDate"] != null)
                        {

                            rdfromDate.SelectedDate = DateTime.Parse(Session["IAFDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Now;


                        }
                        rdfromDate.MaxDate = DateTime.Now;

                        if (Session["IATDate"] != null)
                        {

                            rdendDate.SelectedDate = DateTime.Parse(Session["IATDate"].ToString());
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

                    try
                    {


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


                        if (Session["IArotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string route = Session["IArotID"].ToString();
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
                            Customer(routeCondition);

                        }
                        else
                        {
                            string rotID = Rot();
                            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                            Customer(routeCondition);


                        }
                        if (Session["IAcusID"] != null)
                        {
                            int a = rdCustomer.Items.Count;
                            string cusID = Session["IAcusID"].ToString();
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

                    }
                    catch (Exception ex)
                    {


                    }
                }

                try
                {
                    if (Session["IAAdvFilter"] != null)
                    {
                        if (Session["IAAdvFilter"].ToString() == "true")
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

                try
                {
                    GetGridSession(grvRpt, "IA");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ItemAvailability.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
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
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
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
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
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
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
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
            catch (Exception ex) 

        { Response.Redirect("~/SignIn.aspx"); }
        }

        public void Customer(string routeCondition)
        {
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerByRoute", "sp_Transaction", routeCondition);
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
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " udp_rot_ID in (" + rotID + ")";

            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(D.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date)) ";
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and iah_cus_ID in (" + cusID + ")";
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }
        public void ListData()
        {
            string mainCondition = "";
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
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
                string[] ar = { mainCondition };
                DataTable lstdata = ObjclsFrms.loadList("SelectItemAvailability", "sp_Transaction", UICommon.GetCurrentUserID().ToString(), ar);

               
                grvRpt.DataSource = lstdata;
            }
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

                SetGridSession(grd, "IA");
            }
            catch (Exception ex)
            {

            }
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("iah_ID").ToString();
                Response.Redirect("ItemAvailabilityDetail.aspx?Id=" + ID);
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
            try
            {
                if (Session["IAFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["IAFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["IAFDate"].ToString());
                    }
                    else
                    {
                        Session["IAFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["IAFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["IATDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["IATDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["IATDate"].ToString());
                    }
                    else
                    {
                        Session["IATDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["IATDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["IArotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["IArotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["IArotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["IArotID"] = rotID;
                }

                if (Session["IAcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["IAcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["IAcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["IAcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {

            }
            ListData();
            grvRpt.Rebind();
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Item Availability", "Xlsx"));
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

        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
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
    }
}