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
    public partial class LoadInCompleted : System.Web.UI.Page
    {
        
            GeneralFunctions ObjclsFrms = new GeneralFunctions();
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {

                try
                {
                    if (Session["LICFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["LICFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;


                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["LICTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["LICTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;

                    }
                    rdendDate.MaxDate = DateTime.Now;
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                plhFilter.Visible = false;
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
                
                try
                {
                    if (Session["LICrotID"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string route = Session["LICrotID"].ToString();
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
                    }
                    else
                    {

                        int j = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            j++;
                        }


                        string rotID = Rot();
                        string routeCondition = " rcs_rot_ID in (" + rotID + ")";

                    }
                    if (Session["LICStatus"] != null)
                    {
                        string route = Session["LICStatus"].ToString();
                        string[] ar = route.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in rdstatus.Items)
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

                    }
                }
                catch(Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

                try
                {
                    GetGridSession(grvRpt, "LIC");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
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
                    lstDatas = ObjclsFrms.loadList("ListLoadInCompleted", "sp_Backend", mainCondition);
                    if (lstDatas.Rows.Count <= 0)
                    {
                    grvRpt.DataSource = lstDatas;
                    

                    }
                    else
                    {
                    ViewState["rot"] = lstDatas.Rows[0]["rot_ID"].ToString();
                    grvRpt.DataSource = lstDatas;
                }
                }

            }

            public string mainConditions(string rotID)
            {

                string dateCondition = "";
                string mainCondition = " lih_rot_ID in (" + rotID + ")";
                try
                {
                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    dateCondition = " and (cast(L.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

                }
                catch (Exception ex)
                {

                }
                mainCondition += dateCondition;
                string status = rdstatus.Text;

                if (status.Equals("Rejected"))
                {
                    mainCondition += " and ( L.Status='R')";
                }
                else if (status.Equals("Confirmed"))
                {
                    mainCondition += " and (L.Status='LD')";

                }
                else if (status.Equals("Pending Approval"))
                {
                    mainCondition += " and (L.Status='D')";
                }
                else
                {
                    mainCondition += " and (L.Status='LD' or L.Status='D' or  L.Status='R' )";
                }

                return mainCondition;
            }

        public string Sts()
        {
            var CollectionMarket = rdstatus.CheckedItems;
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
                    return "0";
                }
            }
            protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {

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

                SetGridSession(grd, "LIC");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Detail"))
                {
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string ID = dataItem.GetDataKeyValue("lih_ID").ToString();
                    // string rotid = ViewState["rotname"].ToString();
                    Response.Redirect("LoadInCompletedDetail.aspx?LIH=" + ID);
                }
            }

            protected void imgExcel_Click(object sender, ImageClickEventArgs e)
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
            private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "AR")
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
                    Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Load In Header ", "Xlsx"));
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

            protected void Filter_Click(object sender, EventArgs e)
            {
            try
            {
                if (Session["LICFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["LICFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["LICFDate"].ToString());
                    }
                    else
                    {
                        Session["LICFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["LICFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["LICTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["LICTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["LICTDate"].ToString());
                    }
                    else
                    {
                        Session["LICTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["LICTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["LICrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["LICrotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["LICrotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["LICrotID"] = rotID;
                }

                if (Session["LICStatus"] != null)
                {
                    string customer = Sts();
                    if (customer == Session["LICStatus"].ToString())
                    {
                        string cusID = Sts();

                    }
                    else
                    {
                        string cusID = Sts();
                        Session["LICStatus"] = cusID;
                    }

                }
                else
                {
                    string cusID = Sts();
                    Session["LICStatus"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadData();
                grvRpt.Rebind();
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
            }
            else
            {
                plhFilter.Visible = true;
            }
        }

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;


                HyperLink imgg1 = (HyperLink)item.FindControl("img1");
                string att1 = imgg1.NavigateUrl.ToString();

               
                Image lihImage = (Image)item.FindControl("lihImage");
                string url1 = lihImage.ImageUrl.ToString();

               

                if (att1.Equals("../../UploadFiles/NoImage/imagenotavailable.png"))
                {
                    imgg1.NavigateUrl = "";
                    // item["Images"].Text = "";
                    lihImage.ImageUrl = "../assets/media/icons/imagenotavailable.png";
                }

                

            }
        }

        protected void rdstatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
        }

        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["LICStatus"] != null)
                {
                    string customer = Sts();
                    if (customer == Session["LICStatus"].ToString())
                    {
                        string cusID = Sts();

                    }
                    else
                    {
                        string cusID = Sts();
                        Session["LICStatus"] = cusID;
                    }

                }
                else
                {
                    string cusID = Sts();
                    Session["LICStatus"] = cusID;
                }
            }
            catch(Exception ex)
            {

            }
            LoadData();
            grvRpt.DataBind();
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