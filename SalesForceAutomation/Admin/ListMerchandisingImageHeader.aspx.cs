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

namespace SalesForceAutomation.Admin
{
    public partial class ListMerchandisingImageHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                rdFromData.SelectedDate = DateTime.Now;
                rdEndDate.SelectedDate = DateTime.Now;
            }
        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectRouteForDropDown", "sp_Merchandising");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void Customer()
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerForDropDown", "sp_Merchandising", ddlRoute.SelectedValue.ToString());
            ddlCustomer.DataSource = dtc;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }
        public string mainConditions(string rotID, string cusID)
        {
            string dateCondition = "";
            string mainCondition = " dph_rot_ID  = (case when '" + rotID + "' = '' then dph_rot_ID else '" + rotID + "' end)  and cus_ID = (case when '" + cusID + "' = '' then cus_ID else '" + cusID + "' end)";
            try
            {
                string fromDate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(B.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;

            return mainCondition;
        }
        public void ListData()
        {
            string condition = mainConditions(ddlRoute.SelectedValue.ToString(), ddlCustomer.SelectedValue.ToString());
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("BeforeMerchImages", "sp_Merchandising", condition.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
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

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                string BmImages = dataItem["BeforeMerchImages"].Text.ToString();
                string AmImages = dataItem["AfterMerchImages"].Text.ToString();

                string[] BmImages1 = BmImages.Split(',');
                string[] AmImages1 = AmImages.Split(',');
                BmImages = BmImages.Replace("&nbsp;", null);
                AmImages = AmImages.Replace("&nbsp;", null);
                for (int i = 0; i < BmImages1.Length; i++)
                {
                    if (!BmImages1[i].Equals("&nbsp;") && !BmImages1[i].Equals(""))
                    {
                        Image img = new Image();
                        img.ID = "Image1" + i.ToString();
                        img.ImageUrl = BmImages1[i].ToString();
                        img.Height = 50;
                        img.Width = 50;
                        img.BorderStyle = BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        hl.NavigateUrl = BmImages1[i].ToString();
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);
                        dataItem["Images"].Controls.Add(hl);
                    }

                }


                for (int j = 0; j < AmImages1.Length; j++)
                {
                    if (!AmImages1[j].Equals("&nbsp;") && !AmImages1[j].Equals(""))
                    {
                        Image imgs = new Image();
                        imgs.ID = "Image1" + j.ToString();
                        imgs.ImageUrl = AmImages1[j].ToString();
                        imgs.Height = 50;
                        imgs.Width = 50;
                        imgs.BorderStyle = BorderStyle.Groove;
                        imgs.BorderWidth = 2;
                        imgs.BorderColor = System.Drawing.Color.Black;
                        HyperLink hls = new HyperLink();
                        hls.NavigateUrl = AmImages1[j].ToString();
                        hls.ID = "hl" + j.ToString();
                        hls.Target = "_blank";
                        hls.Controls.Add(imgs);


                        dataItem["Image"].Controls.Add(hls);
                    }
                }

                dataItem["BeforeMerchImages"].Text = BmImages.Replace("../", "http://93.177.125.68/");
                dataItem["AfterMerchImages"].Text = AmImages.Replace("../", "http://93.177.125.68/");
            }
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText))
                {

                    if (column.ColumnGroupName == "Allow")
                    {
                        if (!column.UniqueName.Equals("Images") && !column.UniqueName.Equals("Image"))
                        {
                            columncount++;
                            dt.Columns.Add(column.HeaderText, typeof(string));
                        }
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
                for (int i = 0; i < columncount; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].ColumnGroupName == "Allow")
                    {
                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Equals("&nbsp;")
                            && !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Equals("Initial Image Captures")
                            && !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Equals("Final Image Captures"))
                        {
                            dr[i] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Image Capture", "Xlsx"));
                Response.BinaryWrite(output);
                Response.End();
            }
        }


        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 50;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat();
                format.IsBold = true;
                format.Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(142, 196, 65));
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

