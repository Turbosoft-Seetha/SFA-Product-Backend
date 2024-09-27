using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ExcelUpload : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Proc"] = null;
                ViewState["dtAllData"] = null;
                TemplateType();
            }
        }
        public void TemplateType()
        {

            Session["RoleName"] = null;
            RoleName();
            if (Session["RoleName"] == null)
            {

            }
            else
            {
                string mainConditions = mainCondition();
                DataTable lstData = default(DataTable);
                lstData = ObjclsFrms.loadList("SelType", "sp_ExcelUpload", mainConditions);
                cmbType.DataSource = lstData;
                cmbType.DataTextField = "upt_Name";
                cmbType.DataValueField = "upt_ID";
                cmbType.DataBind();

                cmbType.DataBind();
            }

        }

        public string mainCondition()
        {
            string mainCond = " Roles LIKE '%" + Session["RoleName"].ToString() + "%'";
            return mainCond;
        }
        public void RoleName()
        {
            DataTable lstRole = ObjclsFrms.loadList("SelectUserRoles", "sp_ExcelUpload", UICommon.GetCurrentUserID().ToString());
            if (lstRole.Rows.Count > 0)
            {
                string roleName = lstRole.Rows[0]["RoleName"].ToString();
                Session["RoleName"] = roleName.ToString();
            }
        }
        protected void cmbType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string x = cmbType.SelectedValue.ToString();
            DataTable lstData = default(DataTable);
            plcTemplate.Visible = true;
            lstData = ObjclsFrms.loadList("SelTemplate", "sp_ExcelUpload", x);
            if (lstData.Rows.Count > 0)
            {

                lnkDnload.NavigateUrl = lstData.Rows[0]["upt_FileName"].ToString();
                string IsimgUpload = lstData.Rows[0]["upt_IsImageUpload"].ToString();
                ViewState["IsimgUpload"] = IsimgUpload;
                ViewState["Proc"] = lstData.Rows[0]["upt_Procedure"].ToString();
				ViewState["Mode"] = lstData.Rows[0]["upt_Mode"].ToString();
				if (IsimgUpload.Equals("Y"))
                {
                    plcImageUpload.Visible = true;
                }
                else
                {
                    plcImageUpload.Visible = false;
                }
            }
        }

        public DataTable ConvertLoad(DataTable dx)
        {
            DataTable dt = new DataTable();
         
            dt.Columns.Add("RouteID" , typeof(string));
			dt.Columns.Add("ProductCode", typeof(string));
			dt.Columns.Add("LoadQty", typeof(string));
			dt.Columns.Add("LoadDate", typeof(string));

            int i = 0;
			foreach (DataColumn dc in dx.Columns)
			{
                if (i > 1)
                {
                    for (int j = 2;  j < dx.Rows.Count;  j++)
					{
                        DataRow dr = dx.Rows[j];
						string RouteCode = dr[1].ToString();
						string Qty = dr[dc.ColumnName.ToString()].ToString();
						if (!RouteCode.Equals("") && !Qty.Equals(""))
                        {
							string itemCode = dc.ColumnName.ToString();
							string LoadDate = dr[0].ToString();
							dt.Rows.Add(RouteCode, itemCode, Qty, LoadDate);
						}
					}
				}
                i +=1;
			}
			return dt;
        }

        protected void lnkValidate_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (UploadedFile uploadedFile in updImg.UploadedFiles)
                {


                    string csvPath = Server.MapPath("~/UploadFiles/DumbExcels/") + UICommon.RandomString() + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    FileInfo path = new FileInfo(csvPath);
                    DataTable dt = new DataTable();
                    string Mode = ViewState["Mode"].ToString();

                    if (Mode.Equals("1"))
                    {
						dt = getDataTableFromExcels(csvPath);
					}
                    else if (Mode.Equals("2")) 
                    {
					    DataTable dx=getDataTableFromExcels(csvPath);
                        dt = ConvertLoad(dx);
					}
                    DataTable dtNotMatchiing = dt.Clone();
                    DataTable dtMatching = dt.Clone();
                    ViewState["dtAllData"] = dt;
                    int x = dt.Rows.Count;
                    rdImpExc.DataSource = dt;
                    rdImpExc.DataBind();
                    plcSUccess.Visible = true;
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ExcelUpload.aspx lnkValidate_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                plcFailed.Visible = true;
                Label1.Text = ex.Message.ToString();
            }
        }

        public static DataTable getDataTableFromExcels(string path)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                using (var stream = File.OpenRead(path))
                {
                    pck.Load(stream);
                }
                var ws = pck.Workbook.Worksheets.First();
                DataTable tbl = new DataTable();
                bool hasHeader = true; // adjust it accordingly( i've mentioned that this is a simple approach)
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("Column {0}", firstRowCell.Start.Column.ToString().Trim()));
                }
                var startRow = hasHeader ? 2 : 1;
                int x = ws.Dimension.End.Row;
                for (var rowNum = startRow; rowNum <= x; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    var row = tbl.NewRow();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text.Trim();
                    }
                    tbl.Rows.Add(row);
                }
                return tbl;
            }
        }
        protected void rdExcUnMatch_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void rdExcUnMatch_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void rdExcUnMatch_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void tmrFinal_Tick(object sender, EventArgs e)
        {
            int timer = Int32.Parse(lblTimerSuc.Text.ToString());
            timer = timer - 1;
            lblTimerSuc.Text = timer.ToString();

            if (timer <= 1)
            {
                Response.Redirect("ExcelUpload.aspx");
            }
        }

        protected void btnSav_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["dtAllData"];

            string proc = ViewState["Proc"].ToString();

            string res = ObjclsFrms.Bulk_ExcelUpdate(dt, proc, UICommon.GetCurrentUserID().ToString());
            int Resp = 0;
            try
            {
                Resp = Int32.Parse(res);
            }
            catch (Exception ex)
            {

            }
            if (res == null)
            {
                plcFail.Visible = true;
                lnkExit.Visible = true;
                plcBtns.Visible = false;

            }
            else if (res.Contains("@tbl"))
            {
                plcWrong.Visible = true;
                lnkExit.Visible = true;
                plcBtns.Visible = false;
                lblError.Text = res;
            }
            else if (res.Equals("0") || res.Equals("") || res.Contains("-1"))
            {
                plcWrong.Visible = true;
                lnkExit.Visible = true;
                plcBtns.Visible = false;
                lblError.Text = res;

            }

            else if (Resp > 0)
            {

                //string imgUpload = ViewState["IsimgUpload"].ToString();
                //try
                //{

                //    if (imgUpload.Equals("Y"))
                //    {
                //        string extractPath = Server.MapPath("~/UploadFiles/Products/");
                //        ViewState["extractPath"] = extractPath;

                //        if (!Directory.Exists(extractPath))
                //        {
                //            Directory.CreateDirectory((extractPath));
                //        }

                //        UploadedFile ZipUplaod = updZip.UploadedFiles[0];
                //        if (ZipUplaod != null)
                //        {
                //            using (ZipFile zip = ZipFile.Read(ZipUplaod.InputStream))
                //            {
                //                zip.ExtractAll(extractPath, ExtractExistingFileAction.DoNotOverwrite);
                //            }
                //        }


                //    }
                //}
                //catch (Exception ex)
                //{
                //    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                //    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Excel Upload", "Image Error: " + ex.Message.ToString() + " - " + innerMessage);
                //}

                tmrFinal.Enabled = true;
                plcSuc.Visible = true;

            }
            else
            {
                plcWrong.Visible = true;
                lnkExit.Visible = true;
                plcBtns.Visible = false;
                lblError.Text = res;
            }

        }

        protected void lnkExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExcelUpload.aspx");
        }
    }
}