using SalesForceAutomation.Admin;
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
    public partial class PromoReport : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                ViewState["Filter"] = "";
                Route();
               // LoadData();

            }
        }

        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRouteWithPromotion", "sp_Masters");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "Route";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }


        public string mainConditions()
        {


            string Route = rot();

            string mainCondition = "";

            string RouteCondition = "";

            try
            {




                if (Route.Equals("0"))
                {
                    RouteCondition = "";
                }
                else
                {
                    RouteCondition = " and rcp_rot_ID in (" + Route + ")";
                }



            }
            catch (Exception ex)
            {

            }

            mainCondition += RouteCondition;
            // mainCondition += Statuscondition;
            return mainCondition;
        }

        public string rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string RotID = " ";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        RotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        RotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        RotID += item.Value;
                    }
                    j++;
                }
                return RotID;
            }
            else
            {
                return "rcp_rot_ID";
            }

        }

        public string GetRouteFromDropforPrice()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("root"); // Root element

                    foreach (RadComboBoxItem item in rdRoute.CheckedItems)
                    {
                        createNodeForComboBox1(item.Value, writer);
                    }

                    writer.WriteEndElement(); // Close root element
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }

        // Example method to create a node for RadComboBox items in XML
        private void createNodeForComboBox1(string value, XmlWriter writer)
        {
            writer.WriteStartElement("row"); // Each route ID under its own element
            writer.WriteElementString("rot_ID", value);
            writer.WriteEndElement();
        }


        public void LoadData()
        {
            string mainCondition = "";
            mainCondition = GetRouteFromDropforPrice();
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListRouteWisePromotion", "sp_Masters", mainCondition);
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                Session["lstTracker"] = lstDatas;

            }



        }


        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Asset")
                    && !column.HeaderText.Equals("Documents") && !column.HeaderText.Equals("Signature") && !column.HeaderText.Equals("Location")
                    && !column.HeaderText.Equals("GeoCode") && !column.UniqueName.Equals("Edit")
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Edit"))
                        {
                            if ((!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Asset")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Documents"))
                                && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Location")) && (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("GeoCode")))
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

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Special Price")
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Promotion_Masters_Detailed_Report", "Xlsx"));
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


        protected void Filter_Click(object sender, EventArgs e)
        {
            ViewState["Filter"] = "Yes";
            LoadData();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            //LoadData();
            if (ViewState["Filter"].ToString().Equals("Yes"))
            {
                grvRpt.DataSource = Session["lstTracker"] as DataTable;
            }
            else
            {
                grvRpt.DataSource = new DataTable(); // Ensure no data is bound initially
            }
        }
    }
}