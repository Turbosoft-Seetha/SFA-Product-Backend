using ExcelLibrary.BinaryFileFormat;
using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Net.Http;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class UserDailyProcessDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    Session["frmdate"] = DateTime.Parse(Session["fDate"].ToString());
                    Session["todate"] = DateTime.Parse(Session["TDate"].ToString());

                    ViewState["id"] = 0;
                    Session["CusStartExitId"] = null;
                    Session["CusId"] = null;
                    LoadRoute();
                    if (Session["CO_INVMON"].ToString() != null && Session["CO_INVMON"].ToString() == "Y")
                    {
                        pnlInvMonit.Visible = true;
                        lblinvmonit.Text = Session["CO_INVMON_NAME"].ToString();
                    }
                    else
                    {
                        pnlInvMonit.Visible = false;
                    }
                    if (Session["CO_MGMTACT"].ToString() != null && Session["CO_MGMTACT"].ToString() == "Y")
                    {
                        pnlActMgmnt.Visible = true;
                        lblActManag.Text = Session["CO_MGMTACT_NAME"].ToString();
                    }
                    else
                    {
                        pnlActMgmnt.Visible = false;
                    }
                    if (Session["CO_CUSSERV"].ToString() != null && Session["CO_CUSSERV"].ToString() == "Y")
                    {
                        pnlcussrvice.Visible = true;
                        lblcusservice.Text = Session["CO_CUSSERV_NAME"].ToString();
                    }
                    else
                    {
                        pnlcussrvice.Visible = false;

                    }
                    if (Session["CO_SALJOB"].ToString() != null && Session["CO_SALJOB"].ToString() == "Y")
                    {
                        pnlInv.Visible = true;
                        lblInv.Text = Session["CO_SALJOB_NAME"].ToString();
                    }
                    else
                    {
                        pnlInv.Visible = false;
                    }
                    if (Session["CO_ORDTRACK"].ToString() != null && Session["CO_ORDTRACK"].ToString() == "Y")
                    {
                        pnlorders.Visible = true;
                        lblOrder.Text = Session["CO_ORDTRACK_NAME"].ToString();
                    }
                    else
                    {
                        pnlInv.Visible = false;
                    }
                    if (Session["CO_COPAR"].ToString() != null && Session["CO_COPAR"].ToString() == "Y")
                    {
                        pnlAR.Visible = true;
                        lblAR.Text = Session["CO_COPAR_NAME"].ToString();
                    }
                    else
                    {
                        pnlAR.Visible = false;
                    }
                    if (Session["CO_COPADV"].ToString() != null && Session["CO_COPADV"].ToString() == "Y")
                    {
                        pnladv.Visible = true;
                        lblAdv.Text = Session["CO_COPADV_NAME"].ToString();
                    }
                    else
                    {
                        pnladv.Visible = false;
                    }
                   
                    if (Session["CO_COPFS"].ToString() != null && Session["CO_COPFS"].ToString() == "Y")
                    {
                        pnladv.Visible = true;
                        lblFS.Text = Session["CO_COPFS_NAME"].ToString();
                    }
                    else
                    {
                        pnladv.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

                try
                {
                    if (Session["LOStatus"].Equals("Y"))
                    {
                        van.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


                LoadRoute();
                HeaderData();

                Counts();
                SettlementVisibility();
                EndorcVisibility();


            }
        }

        public void SettlementVisibility()
        {
            DataTable lstRouteType = ObjclsFrms.loadList("SelectRouteType", "sp_Settlement", ResponseID.ToString());
            if (lstRouteType.Rows.Count > 0)
            {
                string rotTypes = lstRouteType.Rows[0]["rot_Type"].ToString();

                if (rotTypes.Equals("MER"))
                {
                    pnlSettlement.Visible = false;
                }
                else if (rotTypes.Equals("OR"))
                {
                    pnlSettlement.Visible = false;
                }
                else
                {
                    pnlSettlement.Visible = true;
                }
            }
        }
        public void EndorcVisibility()
        {
            DataTable lstRouteType = ObjclsFrms.loadList("SelectRouteType", "sp_Settlement", ResponseID.ToString());
            if (lstRouteType.Rows.Count > 0)
            {
                string rotTypes = lstRouteType.Rows[0]["rot_Type"].ToString();

                if (rotTypes.Equals("MER"))
                {
                    pnlEndorsement.Visible = false;
                }
                else if (rotTypes.Equals("OR"))
                {
                    pnlEndorsement.Visible = false;
                }
                else
                {
                    pnlEndorsement.Visible = true;
                }
            }
        }

        public void LoadData()
        {
            //string cusID = Cus();
            //if (!cusID.Equals("0"))
            //{
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectUserDailyProcessDetail", "sp_Merchandising", mainCondition);
            grvRpt.DataSource = lstDatas;
            lblTotalVisits.Text = lstDatas.Rows.Count.ToString();

            DataTable lstRouteType = ObjclsFrms.loadList("SelectRouteType", "sp_Settlement", ResponseID.ToString());
            string rotTypes = lstRouteType.Rows[0]["rot_Type"].ToString();
            if ((rotTypes == "SL") || (rotTypes == "DL") || (rotTypes == "FS"))
            {
                van.Visible = true;
            }
            else
            {
                van.Visible = false;
            }


            //}
        }
        public void LoadRoute()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", ResponseID.ToString());
            //if (lstDatas.Rows.Count > 0)
            //{
            rptRoute.DataSource = lstDatas;
            rptRoute.DataBind();
            //}
            string rottype = lstDatas.Rows[0]["rot_Type"].ToString();

            if (rottype == "AR")
            {
                pnlAR.Visible = true;
                pnlInv.Visible = false;
                
                pnladv.Visible = false;
                pnlorders.Visible = false;
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                pnlFS.Visible = false;
            }
            else if (rottype == "DEL")
            {

            }
            else if (rottype == "DL")
            {
                pnlAR.Visible = false;
                pnlInv.Visible = true;
                pnladv.Visible = false;
                pnlorders.Visible = false;
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                pnlFS.Visible = false;
            }
            else if (rottype == "FS")
            {
                pnlFS.Visible = true;
                pnlInv.Visible = false;
                pnlAR.Visible = false;
                pnladv.Visible = false;
                pnlorders.Visible = false;
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                

            }
            else if (rottype == "MER")
            {
                pnlInvMonit.Visible = true;
                pnlcussrvice.Visible = true;
                pnlActMgmnt.Visible = true;
                pnlInv.Visible = false;
                pnlAR.Visible = false;
                pnladv.Visible = false;
                pnlorders.Visible = false;
                
                pnlFS.Visible = false;
            }
            else if (rottype == "SL")
            {
                pnlInv.Visible = true;
                pnlAR.Visible = true;
                pnladv.Visible = true;
                pnlorders.Visible = false;
                
                pnlInvMonit.Visible = true;
                pnlcussrvice.Visible = true;
                pnlActMgmnt.Visible = true;
                pnlFS.Visible = false;
            }
            else if (rottype == "SER")
            {

            }
            else if (rottype == "OR")
            {
                pnlorders.Visible = true;
                pnlInv.Visible = false;
                pnlAR.Visible = false;
                pnladv.Visible = false;
                
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                pnlFS.Visible = false;
            }
            else if (rottype == "OA")
            {
                pnlorders.Visible = true;
                pnlAR.Visible = true;
                pnlInv.Visible = false;
                
                pnladv.Visible = false;
                
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                pnlFS.Visible = false;
            }
            else if (rottype == "NR")
            {

            }
            else
            {
                pnlInv.Visible = false;
                pnlAR.Visible = false;
                pnladv.Visible = false;
                pnlorders.Visible = false;
                pnlInvMonit.Visible = false;
                pnlcussrvice.Visible = false;
                pnlActMgmnt.Visible = false;
                pnlFS.Visible = false;
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                //Label lblRoute = (Label)rp.FindControl("lblRoute");
                // Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                Label lblProcess = (Label)rp.FindControl("lblProcess");

                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblDuration.Text = lstDatas.Rows[0]["Duration"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
                //lblrotname.Text = lstDatas.Rows[0]["routeName"].ToString();               
                lblProcess.Text = lstDatas.Rows[0]["Process"].ToString();
                ViewState["appProcess"] = lstDatas.Rows[0]["Process"].ToString();

                if (lblProcess.Text == "Pending")
                {
                    PdfClick.Visible = false; // Hide the PlaceHolder
                }
                else
                {
                    PdfClick.Visible = true; // Show the PlaceHolder
                }

            }
        }
        public string mainConditions()
        {
            //  string CusID = Cus();
            string mainCondition = " cse_udp_ID=" + ResponseID;
            // string cusCondition = " and  cse_cus_ID in (" + CusID + ")";

            //mainCondition += cusCondition;
            return mainCondition;
        }
        public void Counts()
        {
            try
            {
                //string Cusid = Session["CusId"].ToString();

                string CusId = "";
                try
                {
                    if (Session["CusId"] == null)
                    {
                        CusId = "";
                    }
                    else
                    {
                        CusId = Session["CusId"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


                string startExitId = "";
                try
                {
                    if (Session["CusStartExitId"] == null)
                    {
                        startExitId = "";
                    }
                    else
                    {
                        startExitId = Session["CusStartExitId"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }




                DataTable dt = new DataTable();
                string[] arr = { CusId, startExitId };
                dt = ObjclsFrms.loadList("SelUserDailyprocessCounts", "sp_Merchandising", ResponseID.ToString(), arr);
                if (dt.Rows.Count > 0)
                {
                    lblTotalInvoice.Text = dt.Rows[0]["salecount"].ToString();
                    lblTotalOrders.Text = dt.Rows[0]["ordercount"].ToString();
                    lblTotalAR.Text = dt.Rows[0]["ARcount"].ToString();
                    lblTotalAP.Text = dt.Rows[0]["Adpaymentcount"].ToString();
                }




                if (startExitId == "")
                {
                    code.Visible = true;
                    cus.Visible = false;
                }
                else
                {
                    cus.Visible = true;
                    code.Visible = false;
                    DataTable ds = new DataTable();
                    ds = ObjclsFrms.loadList("SelectCusDetail", "sp_Merchandising", startExitId);
                    if (ds.Rows.Count > 0)
                    {
                        lblcode.Text = ds.Rows[0]["cus_Code"].ToString();
                        lblcusName.Text = ds.Rows[0]["customer"].ToString();
                        lblsTime.Text = ds.Rows[0]["cse_STime"].ToString();
                        lbleTime.Text = ds.Rows[0]["cse_ETime"].ToString();
                        lbldurations.Text = ds.Rows[0]["Duration"].ToString();
                    }

                }

            }
            catch (Exception ex)
            {

            }
        }
        protected void Settlement_Click(object sender, ImageClickEventArgs e)
        {
            DataTable lstParams = ObjclsFrms.loadList("SelectUserDailyProcessDateRotByID", "sp_Merchandising", ResponseID.ToString());
            try
            {
                if (lstParams.Rows.Count > 0)
                {
                    Session["UdpDate"] = null;
                    Session["UdpRoute"] = null;
                    Session["UdpDate"] = lstParams.Rows[0]["CreatedDate"].ToString();
                    Session["UdpRoute"] = lstParams.Rows[0]["udp_rot_ID"].ToString();
                }
                Response.Redirect("RouteDashboard.aspx?Type=udp", false);
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }

        }

        protected void map_Click(object sender, ImageClickEventArgs e)
        {
            string id = ResponseID.ToString();
            string url = ConfigurationManager.AppSettings.Get("TrackingUrlID");
            OpenNewBrowserWindow(url + id + "&&mode=DIGITS-SFA", this);
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        protected void Imgsettlement_Click(object sender, ImageClickEventArgs e)
        {

            //GridDataItem dataItem = e.Item as GridDataItem;
            //string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
            string ID = ResponseID.ToString();
            DataTable lstSettlement = ObjclsFrms.loadList("SelectSettlementStatus", "sp_Settlement", ID.ToString());
            if (lstSettlement.Rows.Count > 0)
            {
                string status = lstSettlement.Rows[0]["udp_SettlementStatus"].ToString();
                if (status.Equals("SC"))
                {
                    Response.Redirect("SettlementReportCompleted.aspx?Id=" + ID);
                }
                else
                {
                    Response.Redirect("SettlementReports.aspx?Id=" + ID);
                }
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserDailyProcess.aspx");
        }


        protected void lnkOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Orders" + "&Cid=" + ViewState["id"]);
        }

        protected void lnkAr_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Account Recievable" + "&Cid=" + ViewState["id"]);
        }

        protected void lnkAp_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Advance Payment" + "&Cid=" + ViewState["id"]);
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick1"))
            {

                foreach (GridDataItem di in grvRpt.MasterTableView.Items)
                {
                    di.BackColor = Color.Transparent;
                }

                GridDataItem item = grvRpt.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                string ID = item.GetDataKeyValue("cse_ID").ToString();

                if (ViewState["id"].ToString() == ID)
                {
                    try
                    {
                        Session["CusStartExitId"] = null;
                        Session["CusId"] = null;
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                    ViewState["id"] = 0;
                }
                else
                {
                    try
                    {
                        ViewState["id"] = ID;
                        Session["CusStartExitId"] = ID.ToString();
                        DataTable lstDatas = new DataTable();
                        lstDatas = ObjclsFrms.loadList("SelectUserDailyProcessDetailCusId", "sp_Merchandising", ID);
                        string cusid = lstDatas.Rows[0]["cse_cus_ID"].ToString();
                        Session["CusId"] = cusid.ToString();
                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }


                }
                Counts();

            }
        }

        protected void Imgexcel_Click(object sender, ImageClickEventArgs e)
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
                                dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                                j++;
                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt);

        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "UDP")
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "UserDailyProcessDetail", "Xlsx"));
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

        protected void lnkInvoices_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailedDailyTransactions.aspx?id=" + ResponseID.ToString() + "&&mode=Invoice" + "&Cid=" + ViewState["id"]);
        }

        protected void LastRouteCom_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("LastRouteCommunicationReport.aspx?id=" + ResponseID.ToString());
        }

        protected void VanStock_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("CurrentVanStock.aspx?Id=" + ResponseID.ToString());
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string masterGeoCode = item["cus_GeoCode"].Text;
                string transGeoCode = item["cse_StartGeoCode"].Text;
                //try
                //{
                //    item["Difference"].Text = ObjclsFrms.CalcDistance(masterGeoCode, transGeoCode);
                //}
                //catch
                //{
                //    item["Difference"].Text = "";
                //}
            }
        }

        protected void lnkMerch_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListMerchTransaction.aspx?id=" + ResponseID.ToString() + "&CseID=" + ViewState["id"]);
        }

        protected void Endorsement_Click(object sender, ImageClickEventArgs e)
        {
            DataTable lstIsAppProcessed = ObjclsFrms.loadList("SelectAppComplEndosStatus", "sp_Settlement", ResponseID.ToString());
            if (lstIsAppProcessed.Rows.Count > 0)
            {
                string appProcess = lstIsAppProcessed.Rows[0]["udp_IsAppProcessComplete"].ToString();
                string endorsement = lstIsAppProcessed.Rows[0]["udp_EndorsementStatus"].ToString();
                if (appProcess.Equals("Completed"))
                {
                    DataTable lstIsEndorsement = ObjclsFrms.loadList("SelectEndorsementStatus", "sp_Settlement", ResponseID.ToString());
                    if (lstIsEndorsement.Rows.Count > 0)
                    {
                        string status = lstIsEndorsement.Rows[0]["udp_EndorsementStatus"].ToString();

                        if (status.Equals("Y"))
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Endorsement already completed for this route..');</script>", false);

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('App process not completed for this route..');</script>", false);

                }
            }

        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            DataTable lstIsAppProcessed = ObjclsFrms.loadList("SelectAppCompleteionStatus", "sp_Settlement", ResponseID.ToString());
            if (lstIsAppProcessed.Rows.Count > 0)
            {
                string status = lstIsAppProcessed.Rows[0]["udp_IsAppProcessComplete"].ToString();
                if (status.Equals("Completed"))
                {
                    string[] arr = { ResponseID.ToString() };
                    var Value = ObjclsFrms.SaveData("sp_Settlement", "UpdateEndorsementStatus", UICommon.GetCurrentUserID().ToString(), arr);
                    int Respons = Int32.Parse(Value);
                    if (Respons > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong, please try again later.');</script>", false);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Please complete app process and try again later.');</script>", false);
                }
            }
        }

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void lnkInvMonit_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListInvMonitoringTransactions.aspx?id=" + ResponseID.ToString() + "&CseID=" + ViewState["id"]);
        }

        protected void lblActMangmnt_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListActivityManagementTransactions.aspx?id=" + ResponseID.ToString() + "&CseID=" + ViewState["id"]);

        }

        protected void lnkCusService_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerServiceTransactions.aspx?id=" + ResponseID.ToString() + "&CseID=" + ViewState["id"]);

        }

        protected void lnkFS_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListFieldServiceTransactions.aspx?id=" + ResponseID.ToString() + "&CseID=" + ViewState["id"]);

        }

        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {
            if (ResponseID != null)
            {
                try
                {
                    var s = Server.MapPath("Reports/license.key");
                    Stimulsoft.Base.StiLicense.LoadFromFile(s);
                    var report = new StiReport();
                    var path = Server.MapPath("Reports/SettlementReport.mrt");


                    report.Load(path);


                    string ID = ResponseID.ToString();
                    string DB = ConfigurationManager.AppSettings.Get("MyDB");
                    ((StiSqlDatabase)report.Dictionary.Databases["BMSettlementREport"]).ConnectionString = DB;

                    report["@para2"] = ID;

                    StiOptions.Export.Pdf.AllowImportSystemLibraries = true;
                    var tempPdfPath = Server.MapPath("~/Downloads/SettlementReport.pdf");
                    MemoryStream ms = new MemoryStream();
                    report.Render();
                    report.ExportDocument(StiExportFormat.Pdf, ms);
                    File.WriteAllBytes(tempPdfPath, ms.ToArray());

                    // Send the URL of the generated PDF file to client side

                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/SettlementReport.pdf','_blank');", true);
                    ObjclsFrms.TraceService("UserDailyProcessDetails Path=" + tempPdfPath);
                }

                catch (Exception ex)
                {
                    ObjclsFrms.TraceService("UserDailyProcessDetails" + ex.Message + "Udp_ID=" + ResponseID.ToString());
                }





                //string url = "InvoicePrint.aspx?invID=" + invNumber.ToString();
                //OpenNewBrowserWindow(url, this);
            }
        }
    }
}