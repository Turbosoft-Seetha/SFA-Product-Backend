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

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class DetailedDailyTransactions : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }
        public int cseID
        {
            get
            {
                int cseID;
                int.TryParse(Request.Params["Cid"], out cseID);
                return cseID;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                //Customer();
                //CustomerFilter();
                //string cusID = Cus();
                //string cusCondition = "cse_cus_ID in (" + cusID + ")";

            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_ArabicName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_ArabicName"].ToString();
                // lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                //lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                //lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
            }
        }

        public void GetData()
        {


            string mainCondition = "";


            string[] arr = { ResponseID.ToString() };

            string mode = Request.Params["mode"].ToString();
            lblType.Text = mode;
            string proc = "";
            if (mode.Equals("Invoice"))
            {
                proc = "SelUserDailySaleCounts";
                mainCondition = " sal_udp_ID=" + ResponseID;
                string cusCondition = " and sal_cse_ID = (case when '" + cseID + "' = 0 then sal_cse_ID else '" + cseID + "' end) and S.Void = 'N'";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Orders"))
            {
                proc = "SelUserDailyOrderCounts";
                mainCondition = " ord_udp_ID=" + ResponseID;
                string cusCondition = " and ord_cse_ID = (case when '" + cseID + "' = 0 then ord_cse_ID else '" + cseID + "' end) and O.Void = 'N'";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Inventory"))
            {
                proc = "SelUserDailyInvCounts";
                mainCondition = " cse_udp_ID=" + ResponseID;
                string cusCondition = " and inh_cse_ID = (case when '" + cseID + "' = 0 then inh_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Account Recievable"))
            {
                proc = "SelUserDailyARCounts";
                mainCondition = " arh_udp_ID=" + ResponseID;
                string cusCondition = " and arh_cse_ID = (case when '" + cseID + "' = 0 then arh_cse_ID else '" + cseID + "' end) and A.Void = 'N'";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Advance Payment"))
            {
                proc = "SelUserDailyAPCounts";
                mainCondition = " adp_udp_ID=" + ResponseID;
                string cusCondition = " and adp_cse_ID = (case when '" + cseID + "' = 0 then adp_cse_ID else '" + cseID + "' end) and A.Void = 'N'";
                mainCondition += cusCondition;
            }
            DataTable lstDatas = new DataTable();
            if (cseID.ToString().Equals("0"))
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_DailyReports", mainCondition);

                grvRpt.DataSource = lstDatas;
            }
            else
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_DailyReports", mainCondition);

                grvRpt.DataSource = lstDatas;

            }



        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            GetData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("id").ToString();

                //Response.Redirect("DailyTranDetModes.aspx?id=" + id + "&&mode=" + Request.Params["mode"].ToString() + "&&HID=" + ResponseID.ToString());
                Response.Redirect("DailyTranDetModes.aspx?id=" + ResponseID.ToString() + "&&mode=" + Request.Params["mode"].ToString() + "&&HID=" + id);
            }
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;
            radgrid2.MasterTableView.GetColumnSafe("id").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("image").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("Recimage").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("signature").Visible = false;
            radgrid2.HeaderStyle.Width = Unit.Pixel(100);

            if (Request.Params["mode"].ToString().Equals("Advance Payment"))
            {
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["mode"].ToString().Equals("Orders"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RecImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ChequeImg").Visible = false;
            }
            if (Request.Params["mode"].ToString().Equals("Invoice"))
            {

                radgrid2.MasterTableView.GetColumnSafe("ChequeImg").Visible = false;

            }

        }

        protected void ImgExcel_Click(object sender, ImageClickEventArgs e)
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Daily Transactions ", "Xlsx"));
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

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem item = (GridDataItem)e.Item;


                HyperLink imgg1 = (HyperLink)item.FindControl("salImg");
                string att1 = imgg1.NavigateUrl.ToString();

                HyperLink imgg2 = (HyperLink)item.FindControl("salRecImg");
                string att2 = imgg2.NavigateUrl.ToString();

                HyperLink imgg3 = (HyperLink)item.FindControl("salCheque");
                string att3 = imgg3.NavigateUrl.ToString();

                if (att1.Equals("../../UploadFiles/NoImage/imagenotavailable.png"))
                {
                    imgg1.NavigateUrl = "";
                }

                if (att2.Equals("../../UploadFiles/NoImage/imagenotavailable.png"))
                {
                    imgg2.NavigateUrl = "";
                }

                if (att3.Equals("../../UploadFiles/NoImage/imagenotavailable.png"))
                {
                    imgg3.NavigateUrl = "";
                }

            }
        }




    }
}