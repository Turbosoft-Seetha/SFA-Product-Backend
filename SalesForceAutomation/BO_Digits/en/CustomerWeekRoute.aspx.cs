﻿using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerWeekRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ListRoute();
                ListWeek();
                Customer();
               
                if (Session["week"] != null)
                {
                    ddlWeek.SelectedValue = Session["week"].ToString();
                }
                


            }
        }
        public void ListRoute()
        {
            DataTable lstUser = default(DataTable);

            lstUser = ObjclsFrms.loadList("SelectRouteName", "sp_Merchandising", ResponseID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                string name = lstUser.Rows[0]["rot_Name"].ToString();
                ltrlRoute.Text = "Route Name : " + name.ToString() + " /";
            }
        }

        public void ListWeek()
        {
            DataTable lstUser = default(DataTable);

            lstUser = ObjclsFrms.loadList("SelectWeekSeq", "sp_WeekPlan");
            if (lstUser.Rows.Count > 0)
            {
                string weekseq = lstUser.Rows[0]["weekseq"].ToString();
                ltrlweek.Text = "Week Seq: " + weekseq.ToString();
                if (Session["week"] == null)
                {
                    Session["week"] = weekseq.ToString();
                }
                else
                {
                    ddlWeek.SelectedValue = Session["week"].ToString();
                }

            }
        }
        public void ListData()
        {
            string mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelRouteWeekCus", "sp_WeekPlan", mainCondition.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {           
            ListData();
            grvRpt.Rebind();

        }
        public string Cus()
        {
            var ColelctionMarket = ddlCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }
        public string mainConditions()
        {
            string cusID = Cus();
            string week = ddlWeek.SelectedValue.ToString();
            Session["week"] = ddlWeek.SelectedValue.ToString();
            string mainCondition = "cwr_rot_ID  = " + ResponseID.ToString() + " and cwr_cus_ID in (" + cusID + ") and csw_WeekSeq = (case when '" + week + "' = '' then csw_WeekSeq else '" + week + "' end)";
            return mainCondition;

        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                Session["week"] = ddlWeek.SelectedValue.ToString();
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("cwr_ID").ToString();
                Response.Redirect("AddCusWeekRoute.aspx?Id=" + ID + "&&DId=" + ResponseID.ToString());
            }
        }
        public void Customer()
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerForDropDown", "sp_Merchandising", ResponseID.ToString());
            ddlCustomer.DataSource = dtc;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlCustomer.Items)
            {
                itmss.Checked = true;
                j++;
            }

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {

            if (e.Item is GridDataItem)
            {


                GridDataItem item = (GridDataItem)e.Item;

                RadNumericTextBox tbsatseq = (RadNumericTextBox)item.FindControl("txtsatseq");
                RadNumericTextBox tbsunseq = (RadNumericTextBox)item.FindControl("txtsunseq");
                RadNumericTextBox tbmonseq = (RadNumericTextBox)item.FindControl("txtmonseq");
                RadNumericTextBox tbtueseq = (RadNumericTextBox)item.FindControl("txttueseq");
                RadNumericTextBox tbwedseq = (RadNumericTextBox)item.FindControl("txtwedseq");
                RadNumericTextBox tbthuseq = (RadNumericTextBox)item.FindControl("txtthuseq");
                RadNumericTextBox tbfriseq = (RadNumericTextBox)item.FindControl("txtfriseq");
                CheckBox cksat = (CheckBox)item.FindControl("cbsat");
                CheckBox cksun = (CheckBox)item.FindControl("cbsun");
                CheckBox ckmon = (CheckBox)item.FindControl("cbmon");
                CheckBox cktue = (CheckBox)item.FindControl("cbtue");
                CheckBox ckwed = (CheckBox)item.FindControl("cbwed");
                CheckBox ckthu = (CheckBox)item.FindControl("cbthu");
                CheckBox ckfri = (CheckBox)item.FindControl("cbfri");
                tbsatseq.Text = item["SatSeq"].Text.ToString();
                tbsunseq.Text = item["SunSeq"].Text.ToString();
                tbmonseq.Text = item["MonSeq"].Text.ToString();
                tbtueseq.Text = item["TueSeq"].Text.ToString();
                tbwedseq.Text = item["WedSeq"].Text.ToString();
                tbthuseq.Text = item["ThuSeq"].Text.ToString();
                tbfriseq.Text = item["FriSeq"].Text.ToString();
                if ((item["Sat"].Text) == "1")
                {
                    cksat.Checked = true;
                }
                if ((item["Sun"].Text) == "1")
                {
                    cksun.Checked = true;
                }
                if ((item["Mon"].Text) == "1")
                {
                    ckmon.Checked = true;
                }
                if ((item["Tue"].Text) == "1")
                {
                    cktue.Checked = true;
                }
                if ((item["Wed"].Text) == "1")
                {
                    ckwed.Checked = true;
                }
                if ((item["Thu"].Text) == "1")
                {
                    ckthu.Checked = true;
                }
                if ((item["Fri"].Text) == "1")
                {
                    ckfri.Checked = true;
                }

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
                    //int i = 0;
                    //while (i < p)
                    //{
                    //grvRpt.CurrentPageIndex = i;
                    //grvRpt.Rebind();

                    foreach (GridDataItem item in grvRpt.Items)
                    {
                        RadNumericTextBox satseq = (RadNumericTextBox)item.FindControl("txtsatseq");
                        RadNumericTextBox sunseq = (RadNumericTextBox)item.FindControl("txtsunseq");
                        RadNumericTextBox monseq = (RadNumericTextBox)item.FindControl("txtmonseq");
                        RadNumericTextBox tueseq = (RadNumericTextBox)item.FindControl("txttueseq");
                        RadNumericTextBox wedseq = (RadNumericTextBox)item.FindControl("txtwedseq");
                        RadNumericTextBox thuseq = (RadNumericTextBox)item.FindControl("txtthuseq");
                        RadNumericTextBox friseq = (RadNumericTextBox)item.FindControl("txtfriseq");
                        CheckBox sat1 = (CheckBox)item.FindControl("cbsat");
                        CheckBox sun1 = (CheckBox)item.FindControl("cbsun");
                        CheckBox mon1 = (CheckBox)item.FindControl("cbmon");
                        CheckBox tue1 = (CheckBox)item.FindControl("cbtue");
                        CheckBox wed1 = (CheckBox)item.FindControl("cbwed");
                        CheckBox thu1 = (CheckBox)item.FindControl("cbthu");
                        CheckBox fri1 = (CheckBox)item.FindControl("cbfri");
                        string sat, sun, mon, tue, wed, thu, fri;
                        sat = (Convert.ToInt32(sat1.Checked)).ToString();
                        sun = (Convert.ToInt32(sun1.Checked)).ToString();
                        mon = (Convert.ToInt32(mon1.Checked)).ToString();
                        tue = (Convert.ToInt32(tue1.Checked)).ToString();
                        wed = (Convert.ToInt32(wed1.Checked)).ToString();
                        thu = (Convert.ToInt32(thu1.Checked)).ToString();
                        fri = (Convert.ToInt32(fri1.Checked)).ToString();
                        string cwrid = item.GetDataKeyValue("cwr_ID").ToString();

                        createNode(cwrid, sat, satseq.Text.ToString(), sun, sunseq.Text.ToString(), mon, monseq.Text.ToString(), tue, tueseq.Text.ToString(), wed, wedseq.Text.ToString(),
                            thu, thuseq.Text.ToString(), fri, friseq.Text.ToString(), writer);


                        c++;
                        //}
                        //i += 1;

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

        private void createNode(string cwrid, string sat, string satseq, string sun, string sunseq, string mon, string monseq, string tue, string tueseq, String wed, string wedseq, string thu, string thuseq, string fri, string friseq, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cwrid");
            writer.WriteString(cwrid);
            writer.WriteEndElement();

            writer.WriteStartElement("Sat");
            writer.WriteString(sat);
            writer.WriteEndElement();

            writer.WriteStartElement("SatSeq");
            writer.WriteString(satseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Sun");
            writer.WriteString(sun);
            writer.WriteEndElement();

            writer.WriteStartElement("SunSeq");
            writer.WriteString(sunseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Mon");
            writer.WriteString(mon);
            writer.WriteEndElement();

            writer.WriteStartElement("MonSeq");
            writer.WriteString(monseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Tue");
            writer.WriteString(tue);
            writer.WriteEndElement();

            writer.WriteStartElement("TueSeq");
            writer.WriteString(tueseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Wed");
            writer.WriteString(wed);
            writer.WriteEndElement();

            writer.WriteStartElement("WedSeq");
            writer.WriteString(wedseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Thu");
            writer.WriteString(thu);
            writer.WriteEndElement();

            writer.WriteStartElement("ThuSeq");
            writer.WriteString(thuseq);
            writer.WriteEndElement();

            writer.WriteStartElement("Fri");
            writer.WriteString(fri);
            writer.WriteEndElement();


            writer.WriteStartElement("FriSeq");
            writer.WriteString(friseq);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }


        public void Save()
        {
            string rotid = ResponseID.ToString();


            int count = grvRpt.Items.Count;

            string week = GetItemFromGrid();
            string[] ar = { ResponseID.ToString() };
            string Value = ObjclsFrms.SaveData("sp_WeekPlan", "UpdateCusWeekRoute", week, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Week   Saved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }



        }
        public string SelectedToWeek()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("Weeks");

                    foreach (RadComboBoxItem item in ddlToWeek.CheckedItems)
                    {
                        string weekValue = item.Value;

                        writer.WriteStartElement("Week");
                        writer.WriteElementString("Value", weekValue);
                        writer.WriteEndElement();
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }


        public void CopyWeekConfig()
        {
            string rotid = ResponseID.ToString();
            string FromWeek = ddlFromWeek.SelectedValue.ToString();
            string ToWeek= SelectedToWeek();   

                    
            string[] ar = {ToWeek, ResponseID.ToString() };
            string Value = ObjclsFrms.SaveData("sp_WeekPlan", "CopyWeekConfiguration", FromWeek, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Week Saved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }



        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            Session["week"] = ddlWeek.SelectedValue.ToString();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerWeekRoute.aspx?Id=" + ResponseID.ToString());
        }

        protected void lnkCopyConfig_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CopyConfig();</script>", false);

        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            CopyWeekConfig();
        }

        protected void ddlFromWeek_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string selectedValue = ddlFromWeek.SelectedValue;
            ddlToWeek.Items.Clear();

            foreach (RadComboBoxItem originalItem in ddlFromWeek.Items)
            {
                if (originalItem.Value != selectedValue)
                {
                    RadComboBoxItem newItem = new RadComboBoxItem(originalItem.Text, originalItem.Value);
                    ddlToWeek.Items.Add(newItem);
                }
            }
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void ViewMap_Click(object sender, EventArgs e)
        {
            try
            {
                string UserID = UICommon.GetCurrentUserID().ToString();
                string RouteID = ResponseID.ToString();
                string SalesWeekID = ddlWeek.SelectedValue.ToString();              

                string url = ConfigurationManager.AppSettings.Get("JourneyPlanUrl");
                string completeURL = url + "UserID=" +UserID+ "&RouteID=" +RouteID+ "&SalesWeekID=" +SalesWeekID;
                OpenNewBrowserWindow(completeURL, this);           

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
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

            Telerik.Web.UI.RadGrid dd = grvRpt;
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


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
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
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "Customer Week Route", "Xlsx"));
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