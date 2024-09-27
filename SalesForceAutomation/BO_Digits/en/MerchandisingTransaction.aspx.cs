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
    public partial class MerchandisingTransaction : System.Web.UI.Page
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
                int.TryParse(Request.Params["CseID"], out cseID);
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
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["routeName"].ToString();
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

            string mode = Request.Params["Mode"].ToString();
            
            string proc = "";
            if (mode.Equals("IP"))
            {
                lblType.Text = "Item Pricing";
                proc = "SelUDItemPricing";
                mainCondition = " crp_udp_ID=" + ResponseID;
                string cusCondition = " and crp_ucp_ID = (case when '" + cseID + "' = 0 then crp_ucp_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("IA"))
            {
                lblType.Text = "Item Availability";
                proc = "SelUDItemAvailability";
                mainCondition = " iah_dph_ID=" + ResponseID;
                string cusCondition = " and iah_ucp_ID = (case when '" + cseID + "' = 0 then iah_ucp_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("GC"))
            {
                lblType.Text = "General Complaints";
                proc = "SelUDGComplaints";
                mainCondition = " gcm_udp_ID=" + ResponseID;
                string cusCondition = " and gcm_ucp_ID = (case when '" + cseID + "' = 0 then gcm_ucp_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("PC"))
            {
                lblType.Text = "Product Complaints";
                proc = "SelUDPComplaints";
                mainCondition = " psc_udp_ID=" + ResponseID;
                string cusCondition = " and psc_ucp_ID = (case when '" + cseID + "' = 0 then psc_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("CA"))
            {
                lblType.Text = "Competitor Activities";
                proc = "SelUDCompetitorActivity";
                mainCondition = " cma_udp_ID=" + ResponseID;
                string cusCondition = " and cma_ucp_ID = (case when '" + cseID + "' = 0 then cma_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }

            else if (mode.Equals("AT"))
            {
                lblType.Text = "Asset Tracking";
                proc = "SelUDAssetTracking";
                mainCondition = " cas_udp_ID=" + ResponseID;
                string cusCondition = " and cas_ucp_ID = (case when '" + cseID + "' = 0 then cas_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("SR"))
            {
                lblType.Text = "Survey";
                proc = "SelUDSurvey";
                mainCondition = " srh_udp_ID=" + ResponseID;
                string cusCondition = " and srh_cse_ID = (case when '" + cseID + "' = 0 then srh_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("TS"))
            {
                lblType.Text = "Tasks";
                proc = "SelUDTasks";
                mainCondition = " cst_udp_ID=" + ResponseID;
                string cusCondition = " and cst_cse_ID = (case when '" + cseID + "' = 0 then cst_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("OS"))
            {
                lblType.Text = "OutofStock";
                proc = "SelUDOutofStock";
                mainCondition = " osh_dph_ID=" + ResponseID;
                string cusCondition = " and osh_ucp_ID = (case when '" + cseID + "' = 0 then osh_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            
            else if (mode.Equals("CI"))
            {
                lblType.Text = "Customer Inventory";
                proc = "SelUDCustomerInventory";
                mainCondition = " inh_udp_ID=" + ResponseID;
                string cusCondition = " and inh_cse_ID = (case when '" + cseID + "' = 0 then inh_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("IC"))
            {
                lblType.Text = "Image Capture";
                proc = "SelUDImageCapture";
                mainCondition = " mei_dph_ID=" + ResponseID;
                string cusCondition = " and mei_ucp_ID = (case when '" + cseID + "' = 0 then mei_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("DA"))
            {
                lblType.Text = "Display Agreements";
                proc = "SelUDDisplayAgreement";
                mainCondition = " dag_dph_ID=" + ResponseID;
                string cusCondition = " and dag_ucp_ID = (case when '" + cseID + "' = 0 then dag_ucp_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("CSA"))
            {
                lblType.Text = "Customer Activities";
                proc = "SelUDCusActivities";
                mainCondition = " cah_udp_ID=" + ResponseID;
                string cusCondition = " and cah_cse_ID = (case when '" + cseID + "' = 0 then cah_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("CSR"))
            {
                lblType.Text = "Customer Requests";
                proc = "SelUDCusRequest";
                mainCondition = " and req_udp_ID=" + ResponseID;
                
                string cusCondition = " and req_cse_ID = (case when '" + cseID + "' = 0 then req_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("DNR"))
            {
                lblType.Text = "Dispute Note Request";
                proc = "SelUDDebitNoteRequest";
                mainCondition = " drh_udp_ID=" + ResponseID;
                string cusCondition = " and drh_cse_ID = (case when '" + cseID + "' = 0 then drh_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("CNR"))
            {
                lblType.Text = "Credit Note Request";
                proc = "SelUDCreditNoteReq";
                mainCondition = " cnh_udp_ID=" + ResponseID;
                string cusCondition = " and cnh_cse_ID = (case when '" + cseID + "' = 0 then cnh_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("RR"))
            {
                lblType.Text = "Return Request";
                proc = "SelUDReturnReq";
                mainCondition = " rrh_udp_ID=" + ResponseID;
                string cusCondition = " and rrh_cse_ID = (case when '" + cseID + "' = 0 then rrh_cse_ID else '" + cseID + "' end) ";
                mainCondition += cusCondition;
            }

            DataTable lstDatas = new DataTable();
            if (cseID.ToString().Equals("0"))
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_Merchandising", mainCondition);

                grvRpt.DataSource = lstDatas;
            }
            else
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_Merchandising", mainCondition);

                grvRpt.DataSource = lstDatas;

            }



        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            GetData();
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;
                
                string imah = dataItem["Image"].Text.Replace(" ", "");
                string[] values = imah.Split(',');
                imah = imah.Replace("&nbsp;", null);
                for (int i = 0; i < values.Length; i++)
                {
                    if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                    {
                        Image img = new Image();
                        img.ID = "Image1" + i.ToString();
                        img.ImageUrl = "../" + values[i].ToString();
                        img.Height = 20;
                        img.Width = 20;
                        img.BorderStyle = BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        hl.NavigateUrl = "../" + values[i].ToString();
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["Images"].Controls.Add(hl);
                    }
                }
                //dataItem["mei_Images"].Text = imah.Replace("../", "http://93.177.125.68/");
            }
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("id").ToString();

                //Response.Redirect("DailyTranDetModes.aspx?id=" + id + "&&mode=" + Request.Params["mode"].ToString() + "&&HID=" + ResponseID.ToString());
                Response.Redirect("MerchandisingTransactionDetail.aspx?id=" + ResponseID.ToString() + "&&Mode=" + Request.Params["Mode"].ToString() + "&&HID=" + id+"&&CseID="+cseID);
            }
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;
            radgrid2.MasterTableView.GetColumnSafe("id").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("Image").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("ReferenceImage").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("CapturedImage").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("Attachment").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("ResponseImage").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("RequestImage").Visible = false;
            if (Request.Params["Mode"].ToString().Equals("IP"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("IA"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("GC"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("PC"))
            {
               
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("CA"))
            {
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("AT"))
            {
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;

            }
            if (Request.Params["Mode"].ToString().Equals("SR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("TS"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
               
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("CI"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("OS"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;

            }
            if (Request.Params["Mode"].ToString().Equals("IC"))
            {
               
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("DA"))
            {
               
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
              
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("CSA"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("ReqImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RespImages").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("CSR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("DNR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("CNR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("RR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RefImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("CapImages").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Attachments").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
        }

        protected void ImgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Images") && !column.HeaderText.Equals("Captured Image") && !column.HeaderText.Equals("Reference Image")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Images")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Reference Image")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Captured Image")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Attachment")))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Merchandising", "Xlsx"));
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
        }
    }