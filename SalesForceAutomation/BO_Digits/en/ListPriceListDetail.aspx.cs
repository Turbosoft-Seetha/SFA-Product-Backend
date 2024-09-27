using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListPriceListDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["hid"], out ResponseID);

                return ResponseID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HeaderData();
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelPriceListByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");

                Label lblstatus = (Label)rp.FindControl("lblstatus");
               // Label lblPayMode = (Label)rp.FindControl("lblPayMode");

                rp.Text = "Special Price Code: " + lstDatas.Rows[0]["prh_Code"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["prh_Name"].ToString();

                lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
               // lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();
               // ViewState["prhname"] = lblRoute.Text;
               
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPriceListDetail", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            string hid = ResponseID.ToString();
            //try
            //{
            //    string prh = ViewState["prhname"].ToString();
            //    string pay = ViewState["paymode"].ToString();
            //}
            //catch
            //{

            //}

            Response.Redirect("AddEditPriceListDetail.aspx?hid=" + hid);

        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image") && !column.HeaderText.Equals("Edit"))
                {
                    columncount++;
                    dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
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
                for (int i = 2; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    var columnValue = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;

                    if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                    {
                        if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Edit"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Price List_Detail", "Xlsx"));
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
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pld_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }

            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pld_ID").ToString();
                Response.Redirect("AddEditPriceListDetail.aspx?ID=" + ID+"&hid="+ResponseID.ToString());
            }
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {

            Delete();
            //string id = ViewState["delID"].ToString();
            //GeneralFunctions.loadList_Static("DeletePriceListUom", "sp_Masters", id);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }
        public void Delete()
        {


            int count = grvRpt.Items.Count;

            string pldid = GetItemFromGrid();
            GeneralFunctions.loadList_Static("DeletePriceListUom", "sp_Masters", pldid);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);


        }

        protected void BtnDelConfrm_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);

        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;
                    int p = grvRpt.PageCount;
                    var ColelctionMarkets = grvRpt.SelectedItems;

                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {

                            string pldID = dr.GetDataKeyValue("pld_ID").ToString();
                            createNode(pldID, writer);
                            c++;

                        }
                    }


                   
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string pldID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("pldID");
            writer.WriteString(pldID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public string GetItemFromGrid2()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;
                    int p = grvRpt.PageCount;
                    var ColelctionMarkets = grvRpt.SelectedItems;

                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            RadNumericTextBox txtSplPrice = (RadNumericTextBox)dr.FindControl("txtSplPrice");
                            RadNumericTextBox txtRtnPrice = (RadNumericTextBox)dr.FindControl("txtRtnPrice");

                            string SpPrc = txtSplPrice.Text.ToString();
                            string RtPrc = txtRtnPrice.Text.ToString();

                            string pldID = dr.GetDataKeyValue("pld_ID").ToString();
                            
                            createNode2(pldID, SpPrc, RtPrc, writer);
                            c++;

                        }
                    }



                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode2(string pldID, string SpPrc, string RtPrc, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("pldID");
            writer.WriteString(pldID);
            writer.WriteEndElement();

            writer.WriteStartElement("SpPrc");
            writer.WriteString(SpPrc);
            writer.WriteEndElement();

            writer.WriteStartElement("RtPrc");
            writer.WriteString(RtPrc);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void lnlUpdate_Click(object sender, EventArgs e)
        {

            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UpdateConfim();</script>", false);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                Telerik.Web.UI.RadNumericTextBox txtSplPrice = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txtSplPrice");
                Telerik.Web.UI.RadNumericTextBox txtRtnPrice = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txtRtnPrice");
               
                txtSplPrice.Text = dataItem["pld_Price"].Text;
                txtRtnPrice.Text = dataItem["pld_ReturnPrice"].Text;
                
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string pldid = GetItemFromGrid2();
            string[] arr = { };
            string resp = ObjclsFrms.SaveData("sp_Masters", "UpdatePriceListUom", pldid.ToString(), arr);
            int res = Int32.Parse(resp.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal2();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }
        
    }
}