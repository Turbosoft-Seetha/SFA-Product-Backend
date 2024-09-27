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
    public partial class OutOfStockItem : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["HId"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                LoadInitialImage();
                LoadFinalImage();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectOutOfStockDetailHeader", "sp_Transaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblBrand = (Label)rp.FindControl("lblBrand");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblTime = (Label)rp.FindControl("lblTime");
                Label lblCompletedDate = (Label)rp.FindControl("lblCompletedDate");
                Label lblMandatory = (Label)rp.FindControl("lblMandatory");
                Label lblLocation = (Label)rp.FindControl("lblLocation");
                Label lblType = (Label)rp.FindControl("lblType");
                Image imgInitial = (Image)rp.FindControl("imgInitial");
                Image imgFinal = (Image)rp.FindControl("imgFinal");


                lblBrand.Text = lstDatas.Rows[0]["brd_Name"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
                lblCompletedDate.Text = lstDatas.Rows[0]["CompletedDate"].ToString();
                lblTime.Text = lstDatas.Rows[0]["dph_Time"].ToString();
                lblMandatory.Text = lstDatas.Rows[0]["inl_IsMandatory"].ToString();
                lblLocation.Text = lstDatas.Rows[0]["inl_Name"].ToString();
                lblType.Text = lstDatas.Rows[0]["inl_Type"].ToString();
                string imageUrl = lstDatas.Rows[0]["osd_InitailImage"].ToString();
                string imageUrl1 = lstDatas.Rows[0]["osd_FinalImage"].ToString();

                //if (!string.IsNullOrEmpty(imageUrl) && !imageUrl.Equals("../"))
                //{
                //    imgInitial.ImageUrl = imageUrl;
                //    imgInitial.Visible = true;
                //    lblNoImage.Visible = false;
                //}
                //else
                //{
                //    // If there is no image, hide the image and show the label
                //    imgInitial.Visible = false;
                //    lblNoImage.Visible = true;
                //}

                //if (!string.IsNullOrEmpty(imageUrl1) && !imageUrl.Equals("../"))
                //{
                //    imgFinal.ImageUrl = imageUrl1;
                //    imgFinal.Visible = true;
                //    lblNoImage1.Visible = false;
                //}
                //else
                //{
                //    // If there is no image, hide the image and show the label
                //    imgFinal.Visible = false;
                //    lblNoImage1.Visible = true;
                //}
                //// IMG1.Text = "<img src='" + lstDatas.Rows[0]["osd_InitailImage"].ToString() + "' />";



            }
        }

        public void Data()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelectOutOfStockItem", "sp_Transaction", ResponseID.ToString());
            grvRpt.DataSource = lstdata;
        }

        public void LoadInitialImage()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectOutOfStockDetailHeader", "sp_Transaction", ResponseID.ToString());


            if (lstDatas.Rows.Count > 0)
            {
                string remarks = lstDatas.Rows[0]["osd_InitialRemarks"].ToString();
                string imageUrl = lstDatas.Rows[0]["osd_InitailImage"].ToString();

                lblRemarks.Text = !string.IsNullOrEmpty(remarks) ? remarks : "No remarks";

                if (!string.IsNullOrEmpty(imageUrl))
                {
                    string[] values = imageUrl.Replace(" ", "").Split(',');

                    for (int i = 0; i < values.Length; i++)
                    {
                        if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                        {
                            Image img1 = new Image();
                            img1.ID = "Image1" + i.ToString();
                            img1.ImageUrl = "../" + values[i].ToString();
                            img1.Height = 50;
                            img1.Width =50;
                            img1.BorderStyle = BorderStyle.Groove;
                            img1.BorderWidth = 2;
                            img1.BorderColor = System.Drawing.Color.Black;

                            HyperLink hl = new HyperLink();
                            hl.NavigateUrl = "../" + values[i].ToString();
                            hl.ID = "hl" + i.ToString();
                            hl.Target = "_blank";
                            hl.Controls.Add(img1);

                            pnlImg.Controls.Add(hl);
                        }
                    }
                }
                else
                {
                    // Handle the case when there are no attached images
                    Label lblimg = new Label();
                    lblimg.Style.Add("font-size", "14px");
                    lblimg.Text = "(No attached Images)";
                    pnlImg.Controls.Add(lblimg);
                }

            }


        }

        public void LoadFinalImage()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectOutOfStockDetailHeader", "sp_Transaction", ResponseID.ToString());

            if (lstDatas.Rows.Count > 0)
            {
                string remarks = lstDatas.Rows[0]["osd_FinalRemarks"].ToString();
                string imageUrl = lstDatas.Rows[0]["osd_FinalImage"].ToString();

                FinalR.Text = !string.IsNullOrEmpty(remarks) ? remarks : "No remarks";

                if (!string.IsNullOrEmpty(imageUrl))
                {
                    string[] values = imageUrl.Replace(" ", "").Split(',');

                    for (int i = 0; i < values.Length; i++)
                    {
                        if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                        {
                            Image img1 = new Image();
                            img1.ID = "Image2" + i.ToString();
                            img1.ImageUrl = "../" + values[i].ToString();
                            img1.Height = 50;
                            img1.Width = 50;
                            img1.BorderStyle = BorderStyle.Groove;
                            img1.BorderWidth = 2;
                            img1.BorderColor = System.Drawing.Color.Black;

                            HyperLink hl = new HyperLink();
                            hl.NavigateUrl = "../" + values[i].ToString();
                            hl.ID = "ho" + i.ToString();
                            hl.Target = "_blank";
                            hl.Controls.Add(img1);

                            pnlImg1.Controls.Add(hl);
                        }
                    }
                }
                else
                {
                    // Handle the case when there are no attached images
                    Label lblimg1 = new Label();
                    lblimg1.Style.Add("font-size", "14px");
                    lblimg1.Text = "(No attached Images)";
                    pnlImg1.Controls.Add(lblimg1);
                }
            }

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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "OutOfStock Item", "Xlsx"));
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
            Data();
        }


        protected void lnkimg_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showModal();</script>", false);


        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showModal1();</script>", false);

        }
    }
}