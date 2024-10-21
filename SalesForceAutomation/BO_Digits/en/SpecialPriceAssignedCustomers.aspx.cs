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
    public partial class SpecialPriceAssignedCustomers : System.Web.UI.Page
    {
        GeneralFunctions objfrm = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                spPrice();
                int j = 1;
                foreach (RadComboBoxItem itmss in rdsprice.Items)
                {
                    itmss.Checked = true;
                    j++;
                }

            }
        }

        public void spPrice()
        {
            DataTable dt = objfrm.loadList("SelSpecialPrice", "sp_Masters");
            rdsprice.DataSource = dt;
            rdsprice.DataTextField = "Name";
            rdsprice.DataValueField = "prh_ID";
            rdsprice.DataBind();
        }

        public string SpecialPrice()
        {
            var ColelctionMarket = rdsprice.CheckedItems;
            string SPID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        SPID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        SPID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        SPID += item.Value;
                    }
                    j++;
                }
                return SPID;
            }
            else
            {
                return "0";
            }
        }
        public void List()
        {
            string condition = mainCondition();
            DataTable lstUser = default(DataTable);
            lstUser = objfrm.loadList("AssignedCustomerforspPrice", "sp_Masters", condition);
            RadGrid1.DataSource = lstUser;

        }

        public string mainCondition()
        {
            string mainCondition = "";
            string prmID = SpecialPrice();
            if (prmID.Equals(" "))
            {
                mainCondition = " prh_ID in ()";
            }
            else
            {
                mainCondition = "prh_ID in (" + prmID + ")";
            }

            return mainCondition;
        }
        protected void Filter_Click(object sender, EventArgs e)
        {
            List();
            RadGrid1.Rebind();

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();
            int columncount = 0;

           
            foreach (GridColumn column in RadGrid1.MasterTableView.Columns)
            {
                // Skip GridClientSelectColumn and ensure valid columns are included
                if (!(column is GridClientSelectColumn) && !string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail"))
                {
                    if (column.Display == true)
                    {
                        columncount++;
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }
                }
            }

            DataRow dr;
            RadGrid1.MasterTableView.AllowPaging = false;

            RadGrid dd = RadGrid1;
            dd.AllowPaging = false;
            dd.Rebind();

           
            foreach (GridDataItem item in dd.MasterTableView.Items)
            {
                dr = dt.NewRow();
                int j = 0;

                // Loop through columns and skip GridClientSelectColumn while filling row data
                for (int i = 0; i < RadGrid1.MasterTableView.Columns.Count; i++)
                {
                    GridColumn column = RadGrid1.MasterTableView.Columns[i];

                    // Skip GridClientSelectColumn and other excluded columns
                    if (column.Display == true && !(column is GridClientSelectColumn))
                    {
                        string cellText = item[column.UniqueName].Text;

                        if (!string.IsNullOrEmpty(cellText) && !cellText.Contains("&nbsp;"))
                        {
                            dr[j] = cellText;
                        }
                        else
                        {
                            dr[j] = " ";
                        }

                        j++;
                    }
                }

                dt.Rows.Add(dr);
            }

            
            string sheetName = "SpecialPriceAssignedCustomers";
            SpreadStreamProcessingForXLSXAndCSV(dt, sheetName);
        }

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, string sheetName, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx)
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", sheetName.ToString(), "Xlsx"));
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

        protected void Delete_Click(object sender, EventArgs e)
        {
            if (RadGrid1.SelectedItems.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            DelSpclPrice();

        }

        public void DelSpclPrice()
        {

            try
            {
                string id = GetItemFromGrid();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = objfrm.SaveData("sp_Masters", "DeleteCusSpclPrices", id.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Deleted Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            catch (Exception ex)
            {

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

                    var ColelctionMarkets = RadGrid1.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string prh_ID = dr.GetDataKeyValue("prh_ID").ToString();
                            string crp_ID = dr["crp_ID"].Text.ToString();


                            createNode(crp_ID, writer);
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

        private void createNode(string crp_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("crp_ID");
            writer.WriteString(crp_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("SpecialPriceAssignedCustomers.aspx");
        }
    }
}