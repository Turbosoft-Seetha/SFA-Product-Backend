using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;
using Telerik.Web.UI;
using Stimulsoft.Report.Dictionary;
using System.Data;
using Telerik.Web.UI.PivotGrid.Core.Olap;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddServiceRequest : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                ViewState["datatable"] = null;
                ViewState["data"] = null;
                pnlAssetHistory.Visible = false;
                AssetType();
                ComplaintType();
                SCHdate.MinDate = DateTime.Now;
            }

        }

        public void Customer()
        {
            string searchtext = SearchTextBox.Text.ToString();
            string[] ar = { ddlAstType.SelectedValue.ToString(), ddlAstSlNo.SelectedValue.ToString(), txtAssetSearch.Text.ToString() };
            System.Data.DataTable dts = new System.Data.DataTable();
            // ddlCus.ClearSelection();
            if (rbActions.SelectedValue.ToString() == "cus")
            {
                dts = ObjclsFrms.loadList("CustomerForSearch", "sp_ServiceRequest", searchtext.ToString(), ar);

            }
            else if (rbActions.SelectedValue.ToString() == "ast")
            {
                dts = ObjclsFrms.loadList("CustomerForAsset", "sp_ServiceRequest", searchtext.ToString(), ar);

            }
            else if (rbActions.SelectedValue.ToString() == "serial")
            {
                dts = ObjclsFrms.loadList("CustomerForAssetSerial", "sp_ServiceRequest", searchtext.ToString(), ar);

            }
            //int x = dts.Rows.Count;
            ddlCus.DataSource = dts;
            ddlCus.DataTextField = "cus_Name";
            ddlCus.DataValueField = "cus_ID";
            ddlCus.DataBind();
        }
        public void AssetType()
        {
            string[] ar = { ddlAstType.SelectedValue.ToString() };
            System.Data.DataTable dt = ObjclsFrms.loadList("SelectCustomerAssetType", "sp_ServiceRequest", ddlCus.SelectedValue.ToString(), ar);
            ddlAstType.DataSource = dt;
            ddlAstType.DataTextField = "ast_Name";
            ddlAstType.DataValueField = "ast_ID";
            ViewState["datatable"] = dt;
            ddlAstType.DataBind();
        }
        public void Asset()
        {
            string[] ar = { ddlAstType.SelectedValue.ToString(), txtAssetSearch.Text.ToString() };
            System.Data.DataTable dt = new DataTable();
            if (rbActions.SelectedValue.ToString() == "serial")
            {
                dt = ObjclsFrms.loadList("SelectCustomerAsset", "sp_ServiceRequest", ddlCus.SelectedValue.ToString(), ar);

            }
            else if (rbActions.SelectedValue.ToString() == "cus")
            {
                dt = ObjclsFrms.loadList("SelectCustomerAssetbyCustomer", "sp_ServiceRequest", ddlCus.SelectedValue.ToString(), ar);

            }
            else if (rbActions.SelectedValue.ToString() == "ast")
            {
                dt = ObjclsFrms.loadList("SelectCustomerAssetbyType", "sp_ServiceRequest", ddlCus.SelectedValue.ToString(), ar);

            }
            ViewState["data"] = dt;
            ddlAstSlNo.DataSource = dt;
            ddlAstSlNo.DataTextField = "asc_Name";
            ddlAstSlNo.DataValueField = "asc_ID";


            ddlAstSlNo.DataBind();
        }
        public void ComplaintType()
        {
            System.Data.DataTable dt = ObjclsFrms.loadList("SelectComplaintType", "sp_ServiceRequest");
            ddlcmpType.DataSource = dt;
            ddlcmpType.DataTextField = "cst_Name";
            ddlcmpType.DataValueField = "cst_ID";
            ddlcmpType.DataBind();
        }

        protected void Save()
        {
            string user, rot, cus, assetType, Asset, cmpType, cmpTitle, Remark, serimg, date, startTime;
            try
            {



                cus = ddlCus.SelectedValue.ToString();
                assetType = ddlAstType.SelectedValue.ToString();
                Asset = ddlAstSlNo.SelectedValue.ToString();
                cmpType = ddlcmpType.SelectedValue.ToString();
                cmpTitle = txtCmpTitle.Text.ToString();
                Remark = txtRemarks.Text.ToString();
                date = DateTime.Parse(SCHdate.SelectedDate.ToString()).ToString("yyyyMMdd");
                startTime = DateTime.Parse(radTimePicker.SelectedDate.ToString()).ToString("HH:mm");
                serimg = "";
                user = UICommon.GetCurrentUserID().ToString();

                int ImageID = 0;
                foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                {
                    ImageID += 1;
                    string csvPath = Server.MapPath(("..") + @"/../UploadFiles/ServiceReqst/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    if (serimg == "")
                    {
                        serimg = @"../UploadFiles/ServiceReqst/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();

                    }
                    else
                    {
                        serimg = serimg + "," + @"../UploadFiles/ServiceReqst/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    }

                }
                string Values = "";


                try
                {


                    string[] arr = {  assetType.ToString(), Asset.ToString(), cmpType.ToString(), user.ToString(),
                                        cmpTitle.ToString(), Remark.ToString(),serimg.ToString(),date.ToString(),startTime.ToString() };
                    DataTable lstSave = ObjclsFrms.loadList("InsertServiceRequest", "sp_ServiceRequest", cus.ToString(), arr);
                    int res = Int32.Parse(lstSave.Rows[0]["Res"].ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Service Request Saved Successfully');</script>", false);
                    }
                    else
                    {
                        string descr = lstSave.Rows[0]["Descr"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('" + descr + "');</script>", false);
                    }


                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('" + ex + "');</script>", false);

                }

            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Servicerequest");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddServiceRequest.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        protected void ddlAstType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            pnlassetType.Visible = false;
            pnlAssetHistory.Visible = false;
            ddlAstSlNo.ClearSelection();
            ddlCus.ClearSelection();
            Customer();
            Asset();
            DataTable st = new DataTable();

            if (ViewState["datatable"] != null)
            {
                st = (DataTable)ViewState["datatable"];
                for (int i = 0; i < st.Rows.Count; i++)
                {
                    string s = st.Rows[i]["ast_ID"].ToString();
                    if (st.Rows[i]["ast_ID"].ToString() == ddlAstType.SelectedValue.ToString())
                    {
                        string planogram = st.Rows[i]["ast_Planogram"].ToString();
                        HyperLink1.NavigateUrl = planogram.ToString();

                        Image1.ImageUrl = planogram.ToString();
                    }
                }

            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceRequestHeader.aspx");

        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }



        protected void ddlCus_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            ddlAstSlNo.ClearSelection();

            Asset();


        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceRequestHeader.aspx");
        }


        protected void ddlAstSlNo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //ddlAstType.ClearSelection();
            //AssetType();
            if (rbActions.SelectedValue.ToString() == "ast")
            {
                pnlassetType.Visible = false;
                if (ddlAstType.SelectedValue.ToString() != "")
                {
                    if (ddlAstSlNo.SelectedValue.ToString() != "")
                    {
                        Customer();
                        ddlCus.SelectedIndex = 0;
                    }
                }
            }
            else if (rbActions.SelectedValue.ToString() == "serial")
            {
                pnlassetType.Visible = true;
                Customer();
                ddlCus.SelectedIndex = 0;
            }
            else if (rbActions.SelectedValue.ToString() == "cus")
            {
                pnlassetType.Visible = true;
            }

            pnlAssetHistory.Visible = true;

            DataTable st = new DataTable();

            if (ViewState["data"] != null)
            {
                st = (DataTable)ViewState["data"];
                for (int i = 0; i < st.Rows.Count; i++)
                {
                    string s = st.Rows[i]["asc_ID"].ToString();

                    if (st.Rows[i]["asc_ID"].ToString() == ddlAstSlNo.SelectedValue.ToString())
                    {
                        string planogram = st.Rows[i]["ast_Planogram"].ToString();
                        HyperLink1.NavigateUrl = planogram.ToString();

                        Image1.ImageUrl = planogram.ToString();
                        if (rbActions.SelectedValue.ToString() != "ast")
                        {
                            txtAssetType.Text = st.Rows[i]["ast_Name"].ToString();

                        }
                    }
                }

            }
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            ddlCus.ClearSelection();
            ddlAstSlNo.ClearSelection();
            Customer();
            pnlassetType.Visible = false;
            pnlAssetHistory.Visible = false;
        }

        protected void rbActions_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rbActions.SelectedValue.ToString() == "cus")
            {
                pnlassetType.Visible = false;
                pnlAssetHistory.Visible = false;
                ddlCus.ClearSelection();
                ddlAstType.ClearSelection();
                ddlAstSlNo.ClearSelection();
                SearchTextBox.Text = string.Empty;
                txtAssetSearch.Text = string.Empty;
                Customer();
                Asset();
                AssetType();
                pnlcus.Visible = true;
                pnlSerailNo.Visible = false;
                pnlAsset.Visible = false;
            }
            else if (rbActions.SelectedValue.ToString() == "ast")
            {
                pnlassetType.Visible = false;
                pnlAssetHistory.Visible = false;
                ddlCus.ClearSelection();
                ddlAstType.ClearSelection();
                ddlAstSlNo.ClearSelection();
                SearchTextBox.Text = string.Empty;
                txtAssetSearch.Text = string.Empty;
                Customer();
                Asset();
                AssetType();
                pnlcus.Visible = false;
                pnlSerailNo.Visible = false;
                pnlAsset.Visible = true;
            }
            else if (rbActions.SelectedValue.ToString() == "serial")
            {
                pnlassetType.Visible = false;
                pnlAssetHistory.Visible = false;
                ddlCus.ClearSelection();
                ddlAstType.ClearSelection();
                ddlAstSlNo.ClearSelection();
                SearchTextBox.Text = string.Empty;
                txtAssetSearch.Text = string.Empty;
                Customer();
                Asset();
                AssetType();
                pnlcus.Visible = false;
                pnlSerailNo.Visible = true;
                pnlAsset.Visible = false;
            }
        }

        protected void txtAssetSearch_TextChanged(object sender, EventArgs e)
        {
            pnlassetType.Visible = false;
            pnlAssetHistory.Visible = false;
            ddlCus.ClearSelection();
            ddlAstSlNo.ClearSelection();
            Asset();
        }


        protected void lnkServiceDetail_Click(object sender, EventArgs e)
        {
            ViewState["AssetID"] = ddlAstSlNo.SelectedValue.ToString();
            ViewState["CustomerID"] = ddlCus.SelectedValue.ToString();

            string url = "AssetServiceHistoryHeader.aspx?Id=" + ViewState["AssetID"].ToString() + "&CId=" + ViewState["CustomerID"].ToString();
            string script = "window.open('" + url + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenInNewTab", script, true);
        }
    }
}