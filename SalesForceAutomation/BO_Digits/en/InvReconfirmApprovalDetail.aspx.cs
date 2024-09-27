using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report;
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
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using static Stimulsoft.Report.Images.StiReportImages;
using System.Configuration;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class InvReconfirmApprovalDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["HID"], out ResponseID);
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
            lstDatas = ObjclsFrms.loadList("ListInvReconfirmApprovalHeaderbyID", "sp_InventoryReconfirm", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblReqID = (Label)rp.FindControl("lblReqID");

                rp.Text = "Transaction ID: " + lstDatas.Rows[0]["iah_TransID"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                string s = lstDatas.Rows[0]["iah_Status"].ToString();
                if(s=="AT")
                {
                    lnkApprove.Visible = false;
                    radSelectAllApprove.Visible=false;
                    grvRpt.MasterTableView.GetColumnSafe("btn").Visible = false;
                    grvRpt.MasterTableView.GetColumnSafe("DropDownColum").Visible=false;
                    imgExcel.Visible = true;
                    btnPDF.Visible = true;

                }
                else
                {
                    imgExcel.Visible = false;
                    btnPDF.Visible = false;
                }

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListInvReconfirmApprovalDetail", "sp_InventoryReconfirm", ResponseID.ToString());
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                ViewState["dd"] = lstDatas;
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                reasonDrop.DataSource = ObjclsFrms.loadList("SelectReasonInvReconfirm", "sp_InventoryReconfirm");
                reasonDrop.DataTextField = "rsn_Name";
                reasonDrop.DataValueField = "rsn_ID";
                reasonDrop.DataBind();


            }

        }
        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            if (grvRpt.MasterTableView.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }
            else
            {


                foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                {
                    RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                    RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");

                    string selectedValue = rbActions.SelectedValue;
                    string reason = reasonDrop.SelectedValue;
                    if (string.IsNullOrEmpty(selectedValue))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        break;
                    }
                    else if ((reason.Equals("")) && (selectedValue == "R"))
                    {


                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        //break;
                    }
                    

                }
                GetSelectedItemsFromGrid();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }
        protected void save_Click(object sender, EventArgs e)
        {
            string iad_ID = GetSelectedItemsFromGrid();
            if (iad_ID != null)
            {
                string user = UICommon.GetCurrentUserID().ToString();
                DataTable lstData = new DataTable();
                string[] arr = { user, iad_ID.ToString() };

                string resp = ObjclsFrms.SaveData("sp_InventoryReconfirm", "InvReconfirmApproval", ResponseID.ToString(), arr);
                int res = Int32.Parse(resp);

                //DataTable dt = new DataTable();

                //dt = ObjclsFrms.loadList("CheckStatus", "sp_ReturnRequest", ResponseID.ToString());

                //if (dt.Rows.Count <= 0)
                //{

                //    string resupdate = ObjclsFrms.SaveData("sp_InventoryReconfirm", "UpdateStatus", ResponseID.ToString(), arr);
                //}
                //string json = "";
                if (res > 0)
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Inventory Reconfirm Approval Updated Successfully');</script>", false);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("InvReconfirmApprovalHeader.aspx");

        }


        public string GetSelectedItemsFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {
                        RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");
                        RadComboBox reasonDrop = (RadComboBox)item.FindControl("ddlReason");
                        string selectedValue = rbActions.SelectedValue;
                        string Reason = reasonDrop.SelectedValue;
                        if (!string.IsNullOrEmpty(selectedValue))
                        {
                            // Do something with the selected value
                            if ((Reason.Equals("")) && (selectedValue == "R"))
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                                //break;
                            }
                            else
                            {
                                if (selectedValue == "A")
                                {
                                    string Status = "A";
                                    Reason = "0";
                                    string iad_ID = item.GetDataKeyValue("iad_ID").ToString();
                                    createNode(iad_ID, Reason, Status, writer);
                                    c++;
                                }
                                else if (selectedValue == "R")
                                {
                                    string Status = "R";
                                    string iad_ID = item.GetDataKeyValue("iad_ID").ToString();
                                    createNode(iad_ID, Reason, Status, writer);
                                    c++;
                                }
                            }
                        }


                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                }

                if (c == 0)
                {
                    return null;
                }
                else
                {
                    return sw.ToString();
                }
            }
        }
        private void createNode(string iad_ID, string Reason, string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("iad_ID");
            writer.WriteString(iad_ID);
            writer.WriteEndElement();
            writer.WriteStartElement("Reason");
            writer.WriteString(Reason);
            writer.WriteEndElement();
            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void radSelectAllApprove_CheckedChanged(object sender, EventArgs e)
        {
            if (radSelectAllApprove.Checked)
            {
                foreach (GridDataItem item in grvRpt.Items)
                {
                    RadioButtonList radPresent = (RadioButtonList)item.FindControl("rbActions");
                    if (radPresent != null)
                    {
                        ListItem radApprove = radPresent.Items.FindByValue("A");
                        ListItem radReject = radPresent.Items.FindByValue("R");
                        if (radApprove != null && radReject != null)
                        {
                            radApprove.Selected = true;
                            radReject.Selected = false;
                        }
                    }


                }
            }
        }

        protected void rbActions_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonList rbActions = sender as RadioButtonList;

            if (rbActions != null)
            {
              
                string selectedValue = rbActions.SelectedValue;

              
               
                if (selectedValue == "R")
                {
                    radSelectAllApprove.Checked= false;
                }
            }
        }

        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {
            var s = Server.MapPath("Reports/license.key");
            Stimulsoft.Base.StiLicense.LoadFromFile(s);
            Stimulsoft.Base.StiFontCollection.AddFontFile(Server.MapPath("Reports/THSarabunNew.ttf"));
            var report = new StiReport();
            var path = Server.MapPath("Reports/InventoryReconfirm.mrt");


            report.Load(path);



            string mrhID = ResponseID.ToString();
            report["@Para1"] = mrhID.ToString();



            string url = ConfigurationManager.AppSettings.Get("MyDB");
            ((StiSqlDatabase)report.Dictionary.Databases["SFA Reports"]).ConnectionString = url;
            StiOptions.Export.Pdf.AllowImportSystemLibraries = true;


            var tempPdfPath = Server.MapPath("~/Downloads/InvReconfirm.pdf");
            MemoryStream ms = new MemoryStream();
            report.Render();
            report.ExportDocument(StiExportFormat.Pdf, ms);
            File.WriteAllBytes(tempPdfPath, ms.ToArray());

            // Send the URL of the generated PDF file to client side
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/InvReconfirm.pdf','_blank');", true);
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
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

        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "Inventory Reconfirm")
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Inventory Reconfirm", "Xlsx"));
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