using System;
using System.Collections.Generic;
using System.Configuration;
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
   
    public partial class OrderDetailListing : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack)
            {
                HeaderData();
                AssignRoute();
                SelectExpDate();
              
            }
        }

        public void LoadData()
        {

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListOrderDetails", "sp_Merchandising_UOM", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;

        }       
        public void AssignRoute()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectDeliveryRoute", "sp_Transaction");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void SelectExpDate()
        {

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelectExpDate", "sp_Merchandising_UOM", ResponseID.ToString());
            DateTime expectedDelDate = DateTime.Parse(lstDatas.Rows[0]["ord_ExpectedDelDate"].ToString());
            //RadDatePicker rdExpDate = (RadDatePicker)FindControl("rdExpDate");
            if (expectedDelDate != null)
            {
                rdExpDate.SelectedDate = expectedDelDate;
                rdExpDate.MinDate = expectedDelDate;
            }

        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelOrderDetail", "sp_Merchandising_UOM", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");
                Label lblDis = (Label)rp.FindControl("lblDis");
                Label lblSub = (Label)rp.FindControl("lblSub");
                Label lblvat = (Label)rp.FindControl("lblvat");
                Label lblGrand = (Label)rp.FindControl("lblGrand");
                Label lblpaymode = (Label)rp.FindControl("lblpaymode");
                Label lbllinetotal = (Label)rp.FindControl("lbllinetotal");

                rp.Text = "Order Number: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblDis.Text = lstDatas.Rows[0]["ord_Discount"].ToString();
                lblSub.Text = lstDatas.Rows[0]["ord_SubTotal"].ToString();
                lblvat.Text = lstDatas.Rows[0]["ord_VAT"].ToString();
                lblGrand.Text = lstDatas.Rows[0]["ord_GrandTotal"].ToString();
                lblpaymode.Text = lstDatas.Rows[0]["ord_PayMode"].ToString();
                lbllinetotal.Text = lstDatas.Rows[0]["ord_SubTotal_WODiscount"].ToString();               

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "OrderDetail", "Xlsx"));
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

        protected void Linkbtn1_Click(object sender, EventArgs e)
        {

            string OID = ResponseID.ToString();
            string UID = UICommon.GetCurrentUserID().ToString();
            string url = ConfigurationManager.AppSettings.Get("OrderUrl");
            OpenNewBrowserWindow(url + "&&userID=" + UID + "&&OrderID=" + OID, this);

        }


        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Assign();</script>", false);

        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            Save();
        }
        public void Save()
        {
            try
            {

                //string ord = GetItemFromGrid();

                string Rot = ddlRoute.SelectedValue.ToString();
                string user = UICommon.GetCurrentUserID().ToString();
                string ExpDate = DateTime.Parse(rdExpDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] arr = {  user ,ResponseID.ToString(), ExpDate };
                string resp = ObjclsFrms.SaveData("sp_Transaction", "AssignRouteAndConfirmOrderDetail", Rot.ToString(), arr);

                int res = Int32.Parse(resp);


                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Order confirmed successfully.');</script>", false);
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderListing.aspx");
        }
    }
}