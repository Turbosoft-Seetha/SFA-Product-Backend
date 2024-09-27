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

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ViewLoadIn : System.Web.UI.Page
    {

        GeneralFunctions Obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        public int RID
        {
            get
            {
                int RID;
                int.TryParse(Request.Params["RId"], out RID);

                return RID;
            }
        }
        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["LIH"], out LIH);

                return LIH;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["transid"] = "";
                Rot();
                RouteforAdd();

                ddlp.SelectedValue = RID.ToString();
                rdDate.SelectedDate = DateTime.Parse(ViewState["Date"].ToString());
                ddlp.Enabled = false;
                rdDate.Enabled = false;
                Products();



            }
        }
        public void Rot()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = Obj.loadList("GetRotByID", "sp_Masters_UOM", LIH.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                string RID = lstDatas.Rows[0]["lih_rot_ID"].ToString();
                string date = lstDatas.Rows[0]["lih_LoadDate"].ToString();
                string TransID = lstDatas.Rows[0]["lih_TransID"].ToString();
                string rotname = lstDatas.Rows[0]["rot_ArabicName"].ToString();
                ViewState["Date"] = date;

                labelTno.Text = TransID;
                ViewState["transid"] = TransID + " طريق:" + rotname;
            }
        }
        public void Products()
        {
            String[] ar = { RID.ToString() };
            DataTable dts = Obj.loadList("SelProductsFromDrop", "sp_Masters_UOM", LIH.ToString(), ar);
            ddlProduct.DataSource = dts;
            ddlProduct.DataTextField = "prd_Name";
            ddlProduct.DataValueField = "prd_ID";
            ddlProduct.DataBind();

        }
        public void HUOM(string prdct)
        {
            DataTable dq = Obj.loadList("SelectHighUomFromDrop", "sp_Masters_UOM", prdct);
            ddlHUom.DataSource = dq;
            ddlHUom.DataTextField = "uom_Name";
            ddlHUom.DataValueField = "uom_ID";
            ddlHUom.DataBind();
        }
        public void LUOM(string upc)
        {
            //string cat = ddlcatid.SelectedValue.ToString();
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable ds = Obj.loadList("SelectLowUomFromDrop", "sp_Masters_UOM", upc, arr);
            ddlLUom.DataSource = ds;
            if (ds.Rows.Count > 0)
            {
                ddlLUom.DataTextField = "uom_Name";
                ddlLUom.DataValueField = "uom_ID";
                ddlLUom.DataBind();
                ddlLUom.Enabled = true;
                txtLQty.Enabled = true;

            }
            else
            {
                ddlLUom.ClearSelection();
                ddlLUom.SelectedValue = "";
                txtLQty.Text = "";
                ddlLUom.Enabled = false;
                txtLQty.Enabled = false;
                lq.Visible = false;
            }

            ViewState["dd"] = ds;
        }
        public void UPCC()
        {
            string upc;
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable dt2 = Obj.loadList("selectUPCforHUOM", "sp_Masters_UOM", ddlHUom.SelectedValue.ToString(), arr);
            if (dt2.Rows.Count > 0)
            {

                upc = dt2.Rows[0]["pru_UPC"].ToString();
                LUOM(upc);
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

                    var ColelctionMarkets = ddlProduct.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode(item.Value, writer);
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
        private void createNode(string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("prdID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            //string[] arr = { ddlHUom.SelectedValue.ToString(), ddlLUom.SelectedValue.ToString() };

            lstDatas = Obj.loadList("ListLoadIn", "sp_Masters_UOM", LIH.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                grvRpt.DataSource = lstDatas;
                pnls.Visible = true;
            }
            else
            {
                pnls.Visible = false;
            }

        }

        public void RouteforAdd()
        {
            DataTable dt = Obj.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlp.DataSource = dt;
            ddlp.DataTextField = "rot_Name";
            ddlp.DataValueField = "rot_ID";
            ddlp.DataBind();
        }



        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Products();
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            HUOM(ddlProduct.SelectedValue.ToString());
            ddlHUom.Focus();
        }

        protected void ddlHUom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            UPCC();
            txtHQty.Focus();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("lid_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }


        protected void lnkcancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListLoadInHeader.aspx");
        }

        protected void AddItem_Click(object sender, EventArgs e)
        {
            string hqty = txtHQty.Text.ToString();
            string luom = ddlLUom.SelectedValue.ToString();
            string Lqty = txtLQty.Text.ToString();
            if (hqty == "0")
            {
                qt.Visible = true;
                qt.Text = "<span style='color:red'>HigherQty Must be Greater Than Zero</span>";

                if (Lqty == "0")
                {
                    lq.Visible = true;
                }
                else
                {
                    lq.Visible = false;
                }

            }
            else
            {
                qt.Visible = false;

                if (luom == "")
                {
                    txtLQty.Text = "";
                    SaveItem();
                    LoadData();
                    grvRpt.DataBind();
                }
                else if (Lqty == "" || Lqty == "0")
                {
                    lq.Visible = true;

                    lq.Text = "<span style='color:red'>Please Enter LowerQty Must be Greater Than Zero</span>";

                }
                else
                {

                    SaveItem();
                    LoadData();
                    grvRpt.DataBind();
                }

            }


        }



        public void SaveItem()
        {
            string item, higherqty, lowerqty, higheruom, loweruom, userr, Route;
            item = ddlProduct.SelectedValue.ToString();
            higherqty = txtHQty.Text.ToString();
            lowerqty = txtLQty.Text.ToString();
            higheruom = ddlHUom.SelectedValue.ToString();
            loweruom = ddlLUom.SelectedValue.ToString();
            userr = UICommon.GetCurrentUserID().ToString();
            Route = ddlp.SelectedValue.ToString();
            string[] arr = { higheruom, loweruom, higherqty, lowerqty, userr, LIH.ToString() };
            string Value = Obj.SaveData("sp_Masters_UOM", "UpdateLoadInheader", item, arr);
            int LID = Int32.Parse(Value.ToString());
            if (LID > 0)
            {

                Response.Redirect("LoadIn.aspx?RId=" + ddlp.SelectedValue.ToString() + "&LIH=" + LIH.ToString());
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
            }


        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteDailyLoadItem", "sp_Masters_UOM", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void delOk_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void txtHQty_TextChanged(object sender, EventArgs e)
        {
            ddlLUom.Focus();
        }

        protected void ddlLUom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            txtLQty.Focus();
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName)
                    && !string.IsNullOrEmpty(column.HeaderText)
                    && !column.HeaderText.Equals("Detail") && !column.HeaderText.Equals("Delete")
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
                for (int i = 2; i < grvRpt.MasterTableView.Columns.Count; i++)
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail") && !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Delete") &&
                            !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image") && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Delete"))
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

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "LoadIn Detail")
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

                string trans = ViewState["transid"].ToString();
                trans = "Load In Detail of " + trans;


                Response.ContentType = ContentType;
                Response.Headers.Remove("Content-Disposition");
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", trans.ToString(), "Xlsx"));
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