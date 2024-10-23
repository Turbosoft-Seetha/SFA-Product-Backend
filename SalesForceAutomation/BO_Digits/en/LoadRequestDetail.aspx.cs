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
using System.Configuration;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class LoadRequestDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        //public int ResponseID
        //{
        //    get
        //    {
        //        int ResponseID;
        //        int.TryParse(Request.Params["LRH"], out ResponseID);
        //        return ResponseID;
        //    }
        //}
        public int LRH
        {
            get
            {
                int LRH;
                int.TryParse(Request.Params["LRH"], out LRH);

                return LRH;
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
            lstDatas = ObjclsFrms.loadList("selLoadRequestHeaderById", "sp_InventoryTransaction", LRH.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRQDate = (Label)rp.FindControl("lblRQDate");
                Label lblStatus = (Label)rp.FindControl("lblStatus");


                rp.Text = "Request No: " + lstDatas.Rows[0]["lrh_Number"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblRQDate.Text = lstDatas.Rows[0]["lrh_LoadReqDate"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
                ViewState["rotid"] = lstDatas.Rows[0]["lrh_rot_ID"].ToString();
                ViewState["usr"] = lstDatas.Rows[0]["lrh_usr_ID"].ToString();

                string mode= lstDatas.Rows[0]["StatusMode"].ToString();
                if(mode.Equals("A"))
                {
                    imgExcel.Visible = true;
                    lnkApprove.Visible = false;
                    lnkReject.Visible = false;
                }
                else if(mode.Equals("R"))
                {
                    imgExcel.Visible = false;
                    lnkApprove.Visible = false;
                    lnkReject.Visible = false;
                }
                else
                {
                    imgExcel.Visible = false;
                    lnkApprove.Visible = true;
                    lnkReject.Visible = true;
                }
            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("selLoadRequestDetail", "sp_InventoryTransaction", LRH.ToString());
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
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);
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

                        RadNumericTextBox apvHqty = (RadNumericTextBox)item.FindControl("txt_apv_HQty");
                        RadNumericTextBox apvLQty = (RadNumericTextBox)item.FindControl("txt_apv_LQty");
                        string AHqty = apvHqty.Text.ToString();
                        string ALqty = apvLQty.Text.ToString();

                        if (AHqty == "")
                        {
                            AHqty = "0";
                        }
                        if (ALqty == "")
                        {
                            ALqty = "0";
                        }

                        string lrdID = item["lrd_ID"].Text.ToString();
                        string prdid = item["lrd_prd_ID"].Text.ToString();
                        string Hqty = item["lrd_HQty"].Text.ToString();
                        string Lqty = item["lrd_LQty"].Text.ToString();
                        string LUOM = item["lrd_LUOM"].Text.ToString();
                        string HUOM = item["lrd_HUOM"].Text.ToString();
                        string totqty = item["lrd_totalQty"].Text.ToString();
                        createNode(prdid, Hqty, Lqty, LUOM, HUOM, totqty, AHqty, ALqty, lrdID, writer);
                        c++;
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
             

        private void createNode(string lrd_prd_ID, string Hqty, string Lqty, string HUOM, string LUOM, string totqty, string AHqty, string ALqty, string lrd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");            

            writer.WriteStartElement("lrd_prd_ID");
            writer.WriteString(lrd_prd_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("Hqty");
            writer.WriteString(Hqty);
            writer.WriteEndElement();

            writer.WriteStartElement("Lqty");
            writer.WriteString(Lqty);
            writer.WriteEndElement();

            writer.WriteStartElement("HUOM");
            writer.WriteString(HUOM);
            writer.WriteEndElement();

            writer.WriteStartElement("LUOM");
            writer.WriteString(LUOM);
            writer.WriteEndElement();

            writer.WriteStartElement("totqty");
            writer.WriteString(totqty);
            writer.WriteEndElement();

            writer.WriteStartElement("AHqty");
            writer.WriteString(AHqty);
            writer.WriteEndElement();

            writer.WriteStartElement("ALqty");
            writer.WriteString(ALqty);
            writer.WriteEndElement();

            writer.WriteStartElement("lrd_ID");
            writer.WriteString(lrd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            DataTable lstApprovalLevel = ObjclsFrms.loadList("SelectUserLevelForLoadReqApproval", "sp_InventoryTransaction", UICommon.GetCurrentUserID().ToString());
            if (lstApprovalLevel.Rows.Count > 0)
            {
                int currentLevel, nextLevel;
                currentLevel = Int32.Parse(lstApprovalLevel.Rows[0]["CurrentLevel"].ToString());
                nextLevel = Int32.Parse(lstApprovalLevel.Rows[0]["NextLevel"].ToString());
                ViewState["currentLevel"] = currentLevel.ToString();
                ViewState["nextLevel"] = nextLevel.ToString();
                if (nextLevel == 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ConfimApr('You are the final approver,Do you want to continue?');</script>", false);
                }
                else if (nextLevel > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ConfimApr('The Approval request will go to the next level user, Do you want to continue?');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);

                }
            }
        }


        protected void Approvenow_Click(object sender, EventArgs e)
        {
            DataTable lstData = new DataTable();
            string rtid = ViewState["rotid"].ToString();
            string user = ViewState["usr"].ToString();
            string lrdID = GetSelectedItemsFromGrid();
            string nectlvl = ViewState["nextLevel"].ToString();

            string[] arr = { LRH.ToString(), user, rtid, "","","", nectlvl };
            lstData = ObjclsFrms.loadList("UpdateLoadReqDetail", "sp_InventoryTransaction", lrdID.ToString(), arr);
            int res = Int32.Parse(lstData.Rows[0]["Res"].ToString());

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
                lnkApprove.Visible = false;
                lnkReject.Visible = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
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
           
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ConfimExcel();</script>", false);

        }


        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string lrdID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            //string remark = this.txtRejRem.Text.ToString();
            string lrhid = LRH.ToString();

            string[] arr = { lrhid.ToString(), user };
            string resp = ObjclsFrms.SaveData("sp_InventoryTransaction", "RejectLoadReq", lrdID.ToString(), arr);
            int res = Int32.Parse(resp);
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                Telerik.Web.UI.RadNumericTextBox txtAdjustedHQty = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txt_apv_HQty");
                Telerik.Web.UI.RadNumericTextBox txtAdjustedLQty = (Telerik.Web.UI.RadNumericTextBox)dataItem.FindControl("txt_apv_LQty");
                string LUOM = dataItem["lrd_LUOM"].Text;
                string LQty = dataItem["lrd_LQty"].Text; 

                //if (txtAdjustedLQty != null)
                //{
                //    txtAdjustedLQty.Text = dataItem["lrd_apv_LQty"].Text;
                //    txtAdjustedHQty.Text = dataItem["lrd_apv_LQty"].Text;
                //}

                if (string.IsNullOrEmpty(LUOM) || LUOM == "&nbsp;")
                {
                    txtAdjustedLQty.Visible = false;
                }

            }
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("lrd_ID").ToString();
                Response.Redirect("LoadRequestBatchDetail.aspx?LRH=" + LRH + "&&ID=" + ID);
            }
        }

        protected void withapqty_Click(object sender, EventArgs e)
        {
            var s = Server.MapPath("Reports/license.key");
            Stimulsoft.Base.StiLicense.LoadFromFile(s);
            Stimulsoft.Base.StiFontCollection.AddFontFile(Server.MapPath("Reports/THSarabunNew.ttf"));
            var report = new StiReport();
            var path = Server.MapPath("Reports/LoadRequestswithapprovedQty.mrt");


            report.Load(path);



            string mrhID = LRH.ToString();
            report["@Para1"] = mrhID.ToString();



            string url = ConfigurationManager.AppSettings.Get("MyDB");
            ((StiSqlDatabase)report.Dictionary.Databases["SFA Reports"]).ConnectionString = url;
            StiOptions.Export.Pdf.AllowImportSystemLibraries = true;


            var tempPdfPath = Server.MapPath("~/Downloads/LoadRequests.pdf");
            MemoryStream ms = new MemoryStream();
            report.Render();
            report.ExportDocument(StiExportFormat.Pdf, ms);
            File.WriteAllBytes(tempPdfPath, ms.ToArray());

            // Send the URL of the generated PDF file to client side
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/LoadRequests.pdf','_blank');", true);
        }

        protected void withoutapqty_Click(object sender, EventArgs e)
        {
            var s = Server.MapPath("Reports/license.key");
            Stimulsoft.Base.StiLicense.LoadFromFile(s);
            Stimulsoft.Base.StiFontCollection.AddFontFile(Server.MapPath("Reports/THSarabunNew.ttf"));
            var report = new StiReport();
            var path = Server.MapPath("Reports/LoadRequestswithoutapprovedqty.mrt");


            report.Load(path);



            string mrhID = LRH.ToString();
            report["@Para1"] = mrhID.ToString();



            string url = ConfigurationManager.AppSettings.Get("MyDB");
            ((StiSqlDatabase)report.Dictionary.Databases["SFA Reports"]).ConnectionString = url;
            StiOptions.Export.Pdf.AllowImportSystemLibraries = true;


            var tempPdfPath = Server.MapPath("~/Downloads/LoadRequests.pdf");
            MemoryStream ms = new MemoryStream();
            report.Render();
            report.ExportDocument(StiExportFormat.Pdf, ms);
            File.WriteAllBytes(tempPdfPath, ms.ToArray());

            // Send the URL of the generated PDF file to client side
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenWindow", "window.open('/Downloads/LoadRequests.pdf','_blank');", true);
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