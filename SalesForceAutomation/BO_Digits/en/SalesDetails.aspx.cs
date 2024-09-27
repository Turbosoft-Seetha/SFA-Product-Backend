using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SalesDetails : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int JobID
        {
            get
            {
                int JobID;
                int.TryParse(Request.Params["JobID"], out JobID);

                return JobID;
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public string Type
        {
            get
            {
                string Type;
                Type = (Request.Params["Type"]);

                return Type;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                StampedCopy();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            string[] ar = { JobID.ToString() };
            lstDatas = ObjclsFrms.loadList("SelSalesHeader", "sp_Merchandising", ResponseID.ToString(),ar);
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblDis = (Label)rp.FindControl("lblDis");
                Label lblSub = (Label)rp.FindControl("lblSub");
                Label lblvat = (Label)rp.FindControl("lblvat");
                Label lblGrand = (Label)rp.FindControl("lblGrand");
                Label lblTotal = (Label)rp.FindControl("lblTotal");


                rp.Text = "Invoice Number: " + lstDatas.Rows[0]["inv_InvoiceID"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblDis.Text = lstDatas.Rows[0]["inv_Discount"].ToString();
                lblSub.Text = lstDatas.Rows[0]["sal_SubTotal"].ToString();
                lblvat.Text = lstDatas.Rows[0]["inv_VAT"].ToString();
                lblGrand.Text = lstDatas.Rows[0]["inv_GrandTotal"].ToString();
                lblTotal.Text = lstDatas.Rows[0]["inv_SubTotal_WO_Discount"].ToString();
                ViewState["INVNumber"] = lstDatas.Rows[0]["inv_InvoiceID"].ToString();

            }
        }


        public void LoadList()
        {
            string type;
            if(Type==null)
            {
                type = "";

            }
            else
            {
                if (Type.ToString().Equals("INV"))
                {
                    type = "";
                }
                else
                {
                    type = Type.ToString();
                }
            }
           
            DataTable lstUser = default(DataTable);

            string[] arr = { type.ToString(),JobID.ToString() };
            lstUser = ObjclsFrms.loadList("ListSalesDetail", "sp_Merchandising_UOM", ResponseID.ToString(), arr);
            grvRpt.DataSource = lstUser;
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Sales_Detail", "Xlsx"));
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
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void BtnEmail_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DateModal();</script>", false);
        }

        protected void btnEmailSave_Click(object sender, EventArgs e)
        {

        }

        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {
            if (ViewState["INVNumber"] != null)
            {
                try
                {
                    var s = Server.MapPath("Reports/license.key");
                    Stimulsoft.Base.StiLicense.LoadFromFile(s);
                    var report = new StiReport();
                    var path = Server.MapPath("Reports/Credit&CashInvoice.mrt");


                    report.Load(path);



                    string DB = ConfigurationManager.AppSettings.Get("MyDB");
                    ((StiSqlDatabase)report.Dictionary.Databases["BMReport"]).ConnectionString = DB;
                    
                    report["@para2"] = ResponseID.ToString();

                    StiOptions.Export.Pdf.AllowImportSystemLibraries = true;
                    var tempPdfPath = Server.MapPath("~/Downloads/CreditandCashInvoice.pdf");
                    MemoryStream ms = new MemoryStream();
                    report.Render();
                    report.ExportDocument(StiExportFormat.Pdf, ms);
                    File.WriteAllBytes(tempPdfPath, ms.ToArray());

                    // Send the URL of the generated PDF file to client side
                  
                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/CreditandCashInvoice.pdf','_blank');", true);
                    ObjclsFrms.TraceService("SalesDetail Path=" + tempPdfPath);
                }
                
                catch(Exception ex)
                {
                    ObjclsFrms.TraceService("SalesDetail"+ex.Message +"Sal_ID="+ResponseID.ToString());
                }




                
                //string url = "InvoicePrint.aspx?invID=" + invNumber.ToString();
                //OpenNewBrowserWindow(url, this);
            }
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;



                HyperLink imgg2 = (HyperLink)item.FindControl("img2");
                string att2 = imgg2.NavigateUrl.ToString();


                Image RtnImage = (Image)item.FindControl("RtnImage");
                string url2 = RtnImage.ImageUrl.ToString();


               

                if (att2.Equals("../../UploadFiles/NoImage/imagenotavailable.png"))
                {
                    imgg2.NavigateUrl = "";
                    // item["RepImages"].Text = "";
                    RtnImage.ImageUrl = "../assets/media/icons/imagenotavailable.png";
                }


            }

        }
        public void StampedCopy()
        {
            ViewState["stamped"] = "";
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectStampedCopy", "sp_Transaction", ResponseID.ToString());
            string stamped;
            if (lstDatas.Rows.Count > 0)
            {
                stamped = lstDatas.Rows[0]["Stamped"].ToString();
                if (stamped == "")
                {
                    BtnAttachment.Visible = true;
                }
                else
                {
                    BtnAttachment.Visible = true;
                    ViewState["stamped"] = stamped;

                }


            }
            else
            {
                BtnAttachment.Visible = true;
            }

        }
        protected void BtnAttachment_Click(object sender, ImageClickEventArgs e)
        {
            string stamped = ViewState["stamped"].ToString();

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectStampedCopy", "sp_Transaction", ResponseID.ToString());
          
            if (lstDatas.Rows.Count > 0)
            {

                string url = ConfigurationManager.AppSettings.Get("Stamped_URL");
                url = url + stamped;
                OpenNewBrowserWindow(url.ToString(), this);

            }
            else
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Success();</script>", false);

            }


          
        }

        protected void btnAR_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showAR();</script>", false);
            PopulateTable();
        }
        public void PopulateTable()
        {
            if (ViewState["INVNumber"] != null)
            {
                try
                {
                    DataTable lstAR = ObjclsFrms.loadList("SelectARCollections", "sp_Merchandising_UOM", ViewState["INVNumber"].ToString());

                    if (lstAR.Rows.Count > 0)
                    {
                        RadGridSuccess.DataSource = lstAR;
                        string invTotal = lstAR.Rows[0]["invTotal"].ToString();
                        string balance = lstAR.Rows[0]["Balance"].ToString();

                        lblTotalInvoiceAmount.Text = invTotal;
                        lblBalanceAmount.Text = balance;
                    }
                    else
                    {
                        DataTable emptyTable = new DataTable();
                        RadGridSuccess.DataSource = emptyTable;

                        lblTotalInvoiceAmount.Text = "0.00";
                        lblBalanceAmount.Text = "0.00";
                    }
                }
                catch (Exception ex)
                {
                    ObjclsFrms.TraceService("SalesDetail" + ex.Message + "Sal_ID=" + ResponseID.ToString());
                }
            }
        }

        protected void RadGridSuccess_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
		{
            PopulateTable();
		}

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            bool hasReturnType = false;

            foreach (GridDataItem item in grvRpt.MasterTableView.Items)
            {
                //string returnType = item["sld_ReturnType"].Text;
                string returnType = HttpUtility.HtmlDecode(item["sld_ReturnType"].Text).Trim();
                if (!string.IsNullOrEmpty(returnType))
                {
                    hasReturnType = true;
                    break;
                }
            }

            grvRpt.MasterTableView.GetColumn("sld_RtnSale_ID").Visible = hasReturnType;
            grvRpt.MasterTableView.GetColumn("sld_ReturnType").Visible = hasReturnType;
            grvRpt.MasterTableView.GetColumn("RepImages").Visible = hasReturnType;

        }
    }
}