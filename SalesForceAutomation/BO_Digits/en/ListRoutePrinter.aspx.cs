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
    public partial class ListRoutePrinter : System.Web.UI.Page
    {
       
            GeneralFunctions obj = new GeneralFunctions();
            public int ResponseID
            {
                get
                {
                    int ResponseID;
                    int.TryParse(Request.Params["RID"], out ResponseID);

                    return ResponseID;
                }
            }
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {
                    DataTable lstRoute = obj.loadList("SelectRouteByID", "sp_Masters", ResponseID.ToString());
                    cusroute.Text = "Route  :" + lstRoute.Rows[0]["rot_Name"].ToString();
                    ViewState["rotcode"] = lstRoute.Rows[0]["rot_Name"].ToString();
                }

            }
            public void List()
            {
                DataTable lstdata = obj.loadList("SelectRoutePrinter", "sp_Masters", ResponseID.ToString());
                grvRpt.DataSource = lstdata;

            }

          

            protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
            {
                List();
            }

            protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
            {
                if (e.CommandName.Equals("Edit"))                                           //To check whether the triggered command name matched or not, in case of multiple command name in aspx side
                {                                                                           //If it matched the following code will be executed
                    GridDataItem dataItem = e.Item as GridDataItem;                         //We are creating an object for grid data item 
                    string CID = dataItem.GetDataKeyValue("rpr_ID").ToString();
                    string RID = ResponseID.ToString();                                                                    //Using the object and a propery "GetDataKeyValue" we can access the value of DataKey in ASPX. which is the ID. 
                    Response.Redirect("AddEditRoutePrinter.aspx?RPID=" + CID + "&RID=" + RID);                         //With the ID we can redirect to the add page to edit and update the value.
                }
                
                if (e.CommandName.Equals("Delete"))
                {
                    GridDataItem dataItem = e.Item as GridDataItem;
                    string ID = dataItem.GetDataKeyValue("rpr_ID").ToString();

                    ViewState["delID"] = ID;
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }
               
            }
            protected void lnkAdds_Click(object sender, EventArgs e)
            {
                string id = ViewState["delID"].ToString();
                GeneralFunctions.loadList_Static("DeleteRoutePrinter", "sp_Masters", id);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }

            protected void btnOK_Click(object sender, EventArgs e)
            {
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }

            protected void imgExcel_Click(object sender, ImageClickEventArgs e)
            {
                DataTable dt = new DataTable();

                int columncount = 0;

                foreach (GridColumn column in grvRpt.MasterTableView.Columns)
                {
                    if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Products")
                        && !column.HeaderText.Equals("Special Pricing")
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


                            if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("ProAssigned") &&
                                !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("EditColumn") &&
                                !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("ProMapping") &&
                                !item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Delete"))
                            {
                                if (!string.IsNullOrEmpty(grvRpt.MasterTableView.Columns[i].UniqueName) && !string.IsNullOrEmpty(grvRpt.MasterTableView.Columns[i].HeaderText) && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Products") && !grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Special Pricing"))
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

            private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Route Customers")
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
                    Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Route Customer" + ViewState["rotcode"].ToString(), "Xlsx"));
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

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            string RID = ResponseID.ToString();
            Response.Redirect("AddEditRoutePrinter.aspx?RID=" + RID);
        }
    }
}