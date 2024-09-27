using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report;
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
using Telerik.Documents.SpreadsheetStreaming;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ScheduleReturnDetail : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
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
                HeaderData();
            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = obj.loadList("ListReturnReqHeaderByID", "sp_ReturnRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblNum = (Label)rp.FindControl("lblNum");
                Label lblcus = (Label)rp.FindControl("lblcus");
                Label lblcuscode= (Label)rp.FindControl("lblcuscode");
                Label lblinv = (Label)rp.FindControl("lblinv");
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblTotalAmt = (Label)rp.FindControl("lblTotalAmt");
                Label lblTotalWithVAt = (Label)rp.FindControl("lblTotalWithVAt");
                Label lblVATTot = (Label)rp.FindControl("lblVATTot");
                Label lblRemarks = (Label)rp.FindControl("lblRemarks");

                lblNum.Text = lstDatas.Rows[0]["rrh_RequestNumber"].ToString();
                lblcus.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblcuscode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblinv.Text = lstDatas.Rows[0]["inv_InvoiceID"].ToString();
                lblRot.Text = lstDatas.Rows[0]["Route"].ToString();
                lblTotalAmt.Text = lstDatas.Rows[0]["TotalwithoutVAT"].ToString();
                lblVATTot.Text = lstDatas.Rows[0]["totalVAT"].ToString();
                lblTotalWithVAt.Text = lstDatas.Rows[0]["TotalwithVAT"].ToString();
                lblRemarks.Text = lstDatas.Rows[0]["rrh_Remarks"].ToString();


                string img = lstDatas.Rows[0]["rrh_Signature"].ToString();
                string url = ConfigurationManager.AppSettings.Get("BackendURL"); 
                hl.NavigateUrl = url + img.ToString();
                Signature.ImageUrl = url + img.ToString();
                if (img == "")
                {
                    Label lblimg = new Label();
                    lblimg.Style.Add("font-size", "14px");
                    lblimg.Text = "(No attached Images)";
                    lblSignature.Controls.Add(lblimg);
                    pnlSignature.Visible = false;
                }
                else
                {
                    pnlSignature.Visible = true;
                }

                ViewState["rrh_RequestNumber"] = lstDatas.Rows[0]["rrh_RequestNumber"].ToString();
            }
        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = obj.loadList("ListReturnReqByID", "sp_ReturnRequest", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {
          


            if (ViewState["rrh_RequestNumber"] != null)
            {
                try
                {
                    var s = Server.MapPath("Reports/license.key");
                    Stimulsoft.Base.StiLicense.LoadFromFile(s);
                    var report = new StiReport();
                    var path = Server.MapPath("Reports/ReturnRequest.mrt");


                    report.Load(path);


                    string ID = ViewState["rrh_RequestNumber"].ToString();
                    string DB = ConfigurationManager.AppSettings.Get("MyDB");
                    ((StiSqlDatabase)report.Dictionary.Databases["BMReport"]).ConnectionString = DB;

                    report["@para2"] = ID;

                    StiOptions.Export.Pdf.AllowImportSystemLibraries = true;
                    var tempPdfPath = Server.MapPath("~/Downloads/Return.pdf");
                    MemoryStream ms = new MemoryStream();
                    report.Render();
                    report.ExportDocument(StiExportFormat.Pdf, ms);
                    File.WriteAllBytes(tempPdfPath, ms.ToArray());

                    // Send the URL of the generated PDF file to client side

                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/Return.pdf','_blank');", true);
                    obj.TraceService("SalesDetail Path=" + tempPdfPath);
                }

                catch (Exception ex)
                {
                    obj.TraceService("ReturnDetails" + ex.Message + "Rtn_ID=" + ResponseID.ToString());
                }





                //string url = "InvoicePrint.aspx?invID=" + invNumber.ToString();
                //OpenNewBrowserWindow(url, this);
            }


        }


        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Return_Detail", "Xlsx"));
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