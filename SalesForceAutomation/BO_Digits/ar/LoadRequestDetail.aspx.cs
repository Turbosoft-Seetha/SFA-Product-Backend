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
    public partial class LoadRequestDetail : System.Web.UI.Page
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
            lstDatas = ObjclsFrms.loadList("selLoadRequestHeaderById", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRQDate = (Label)rp.FindControl("lblRQDate");
                Label lblRemarks = (Label)rp.FindControl("lblRemarks");


                rp.Text = "رقم الطلب: " + lstDatas.Rows[0]["lrh_Number"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_ArabicName"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_ArabicName"].ToString();
                lblRQDate.Text = lstDatas.Rows[0]["lrh_LoadReqDate"].ToString();
                lblRemarks.Text = lstDatas.Rows[0]["lrh_Remarks"].ToString();
                ViewState["rotid"] = lstDatas.Rows[0]["lrh_rot_ID"].ToString();
                ViewState["usr"] = lstDatas.Rows[0]["lrh_usr_ID"].ToString();



            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("selLoadRequestDetail", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                ViewState["prdid"] = lstDatas.Rows[0]["lrd_prd_ID"].ToString();
                ViewState["Hqty"] = lstDatas.Rows[0]["lrd_HQty"].ToString();
                ViewState["Lqty"] = lstDatas.Rows[0]["lrd_LQty"].ToString();
                ViewState["LUOM"] = lstDatas.Rows[0]["lrd_LUOM"].ToString();
                ViewState["HUOM"] = lstDatas.Rows[0]["lrd_HUOM"].ToString();
                ViewState["totalQty"] = lstDatas.Rows[0]["lrd_totalQty"].ToString();
                ViewState["apv_HQty"] = lstDatas.Rows[0]["lrd_apv_HQty"].ToString();
                ViewState["apv_LQty"] = lstDatas.Rows[0]["lrd_apv_LQty"].ToString();
                ViewState["apv_HUOM"] = lstDatas.Rows[0]["lrd_apv_HUOM"].ToString();
                ViewState["apv_LUOM"] = lstDatas.Rows[0]["lrd_apv_LUOM"].ToString();
                ViewState["apv_totalQty"] = lstDatas.Rows[0]["lrd_apv_totalQty"].ToString();

            }
            grvRpt.DataSource = lstDatas;


        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }



        protected void lnkReject_Click(object sender, EventArgs e)
        {

        }
        public void Approve()
        {
            DataTable lstData = new DataTable();
            string rtid = ViewState["rotid"].ToString();
            string user = ViewState["usr"].ToString();
            string prdid = ViewState["prdid"].ToString();
            string Hqty = ViewState["Hqty"].ToString();
            string Lqty = ViewState["Lqty"].ToString();
            string LUOM = ViewState["LUOM"].ToString();
            string HUOM = ViewState["HUOM"].ToString();
            string totqty = ViewState["totalQty"].ToString();
            string apvHqty = ViewState["apv_HQty"].ToString();
            string apvLQty = ViewState["apv_LQty"].ToString();
            string apvHUOM = ViewState["apv_HUOM"].ToString();
            string apvLUOM = ViewState["apv_LUOM"].ToString();
            string apvtotQty = ViewState["apv_totalQty"].ToString();


            string[] arr = { rtid, user, prdid, Hqty, Lqty, LUOM, HUOM, totqty, apvHqty, apvLQty, apvHUOM, apvLUOM, apvtotQty };
            lstData = ObjclsFrms.loadList("UpdateLoadReqDetail", "sp_InventoryTransaction", ResponseID.ToString(), arr);
            int res = Int32.Parse(lstData.Rows[0]["Res"].ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }

        protected void Approvenow_Click(object sender, EventArgs e)
        {
            Approve();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadRequestHeader.aspx");
        }

        protected void lnkApprove_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //Approve();

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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Load Request Detail ", "Xlsx"));
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

        //public string GetItemFromGrid()
        //{
        //    using (var sw = new StringWriter())
        //    {
        //        using (var writer = XmlWriter.Create(sw))
        //        {

        //            writer.WriteStartDocument(true);
        //            writer.WriteStartElement("r");
        //            int c = 0;
        //            DataTable dsc = new DataTable();
        //            foreach (GridDataItem dr in grvRpt.SelectedItems)
        //            {

        //                string oddID = dr.GetDataKeyValue("odd_ID").ToString();
        //                string remarks = rdRemarks.Text.Trim().ToString();
        //                if (qty > 0)
        //                {
        //                    ViewState["RemarsCount"] = 1;
        //                }
        //                createNode(oddID, qtyVal, remarks, writer);
        //                c++;
        //            }
        //            writer.WriteEndElement();
        //            writer.WriteEndDocument();
        //            writer.Close();

        //        }



        //        if (c == 0)
        //            {

        //                return null;
        //            }
        //            else
        //            {
        //                string ss = sw.ToString();
        //                return sw.ToString();
        //            }
        //        }
        //    }
        //}

        //private void createNode(string Answer, string Order, string Status, XmlWriter writer)
        //{
        //    writer.WriteStartElement("Values");
        //    writer.WriteStartElement("Answer");
        //    writer.WriteString(Answer);
        //    writer.WriteEndElement();
        //    writer.WriteStartElement("Order");
        //    writer.WriteString(Order);
        //    writer.WriteEndElement();
        //    writer.WriteStartElement("Status");
        //    writer.WriteString(Status);
        //    writer.WriteEndElement();
        //    writer.WriteEndElement();
        //}
    }
}
