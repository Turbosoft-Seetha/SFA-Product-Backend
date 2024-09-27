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
using Telerik.Web.UI.Chat;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AssignedServiceRequestDetail : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadData();
                Route();
                SCHdate.MinDate = DateTime.Now;
                SCHdate.SelectedDate = DateTime.Now;
            }

        }
        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectSeviceRoute", "sp_Transaction");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void Save()
        {
            try
            {


                string schDate = DateTime.Parse(SCHdate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string Rot = ddlRoute.SelectedValue.ToString();
                string user = UICommon.GetCurrentUserID().ToString();
                string[] arr = { user, Rot.ToString(), ResponseID.ToString() };
                string resp = ObjclsFrms.SaveData("sp_Transaction", "AssignServiceRequests", schDate.ToString(), arr);

                int res = Int32.Parse(resp);


                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Route assigned successfully.');</script>", false);
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("SignIn.aspx");
            }
        }
        public void LoadData()
        {
            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestDetails", "sp_Transaction", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                lblServicerqstID.Text = lstdata.Rows[0]["snr_Code"].ToString();
                lblDate.Text = lstdata.Rows[0]["AssignedTime"].ToString();
                lblStatus.Text = lstdata.Rows[0]["Status"].ToString();
                lblCustomer.Text = lstdata.Rows[0]["cus_Name"].ToString();
                string planogram = lstdata.Rows[0]["ast_Planogram"].ToString();
                lblAsset.Text = lstdata.Rows[0]["asc_Name"].ToString();
                lblComplaint.Text = lstdata.Rows[0]["snr_Complaint"].ToString();
                lblComplaintType.Text = lstdata.Rows[0]["cst_Name"].ToString();
                string comment = lstdata.Rows[0]["snr_Remarks"].ToString();
                lblAssetSno.Text= lstdata.Rows[0]["atm_Code"].ToString();
                string troubleshoot = lstdata.Rows[0]["snr_TroubleShoots"].ToString();
                if (troubleshoot != "")
                {

                    pnltroubleshoot.Visible = true;

                    string[] ary = troubleshoot.Split(',');

                    string concatenated = "<div class='instruction-container'>";
                    for (int i = 0; i < ary.Length; i++)
                    {

                        concatenated += "<span class='bubble'>&nbsp;</span>" + ary[i] + "<br/>";

                    }

                    concatenated += "</div>";
                    lblTroubleShoot.Text = concatenated;
                }
                else
                {

                    pnltroubleshoot.Visible = false;
                }
                if (comment == "")
                {
                    lblComments.Text = "(No Comments)";
                }
                else
                {
                    lblComments.Text = comment;
                }
                string status = lstdata.Rows[0]["Status"].ToString();

                if (status == "Action Taken" || status == "Assigned")
                {
                    pnlServiceJob.Visible = true;
                }
                else
                {
                    pnlServiceJob.Visible = false;
                }

                string img = lstdata.Rows[0]["snr_Image"].ToString();
                hpl1.NavigateUrl = planogram.ToString();
                hlval1.Value = ResponseID.ToString();
                img1.ImageUrl = planogram.ToString();
                if (img == "")
                {
                    Label lblimg = new Label();
                    lblimg.Style.Add("font-size", "14px");
                    lblimg.Text = "(No attached Images)";
                    pnlimg.Controls.Add(lblimg);
                }
                else
                {
                    string imah = img.Replace(" ", "");
                    string[] values = imah.Split(',');
                    imah = imah.Replace("&nbsp;", null);
                    for (int i = 0; i < values.Length; i++)
                    {
                        if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                        {
                            Image imgg = new Image();
                            imgg.ID = "Image1" + i.ToString();
                            imgg.ImageUrl = "../" + values[i].ToString();
                            imgg.Height = 60;
                            imgg.Width = 60;
                            imgg.BorderStyle = BorderStyle.Groove;
                            imgg.BorderWidth = 2;
                            imgg.BorderColor = System.Drawing.Color.Black;
                            HyperLink hl = new HyperLink();
                            hl.NavigateUrl = "../" + values[i].ToString();
                            hl.ID = "hl" + i.ToString();
                            hl.Target = "_blank";
                            hl.Controls.Add(imgg);

                            pnlimg.Controls.Add(hl);


                        }
                    }

                }



            }
        }

        protected void lnkAssignRot_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Assign();</script>", false);

        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceRequestHeader.aspx");
        }

        protected void btnViewReqst_Click(object sender, EventArgs e)
        {

            Loadlist();
            RadGridSuccess.DataBind();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ViewReqsts();</script>", false);

        }
        public void Loadlist()
        {
            string rout = ddlRoute.SelectedValue.ToString();
            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestAssigned", "sp_Transaction", rout.ToString());
            if (lstdata.Rows.Count >= 0)
            {
                RadGridSuccess.DataSource = lstdata;
            }
        }

        protected void RadGridSuccess_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Loadlist();
        }
        public void TroubleShoots()
        {

            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestTroubleShoots", "sp_Transaction");
            if (lstdata.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstdata;
            }
        }
        protected void btnTroubleShoot_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>TroubleShoot();</script>", false);

        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            TroubleShoots();
        }
        public string Troubleshoot()
        {
            var CollectionMarket = RadGrid1.SelectedItems;
            string stsID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (GridDataItem dr in RadGrid1.SelectedItems)
                {
                    if (j == 0)
                    {
                        stsID += dr.GetDataKeyValue("sts_ID").ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        stsID += dr.GetDataKeyValue("sts_ID").ToString() + ",";
                    }

                    j++;
                }
                return stsID;
            }
            else
            {
                return "0";
            }

        }

        public void SaveTS()
        {
            try
            {
                string TS = Troubleshoot();
                string user = UICommon.GetCurrentUserID().ToString();
                string[] arr = { user, ResponseID.ToString() };
                string resp = ObjclsFrms.SaveData("sp_Transaction", "TroubleShootServiceRequest", TS.ToString(), arr);

                int res = Int32.Parse(resp);


                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Trouble shooting methods saved successfully.');</script>", false);
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("SignIn.aspx");
            }
        }

        protected void btnTroubleshootSubmit_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                SaveTS();
            }

        }
        public void LoadJobs()
        {

            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestJobHeader", "sp_Transaction", ResponseID.ToString());
            if (lstdata.Rows.Count >= 0)
            {
                RadGridServiceJob.DataSource = lstdata;
            }
        }
        protected void RadGridServiceJob_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadJobs();
        }

        protected void RadGridServiceJob_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("AssignedReqJobDetails.aspx?ID=" + id.ToString());
            }

            if (e.CommandName.Equals("ReqParts"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("AssignedReqRequiredParts.aspx?ID=" + id.ToString());
            }
            if (e.CommandName.Equals("Invoice"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("SalesDetails.aspx?JobID=" + id.ToString());
            }

        }

        protected void RadGridServiceJob_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton DelBtn = (ImageButton)item.FindControl("RadDetail");
                ImageButton ReqParts = (ImageButton)item.FindControl("RadReqParts");
                 ImageButton Invoice = (ImageButton)item.FindControl("RadInvoice");
                string status = item["Status"].Text.ToString();
                if (status == "Open"|| status == "Pending")
                {
                    DelBtn.Visible = false;
                    ReqParts.Visible = false;
                    Invoice.Visible = false;
                }
                else
                {
                    DelBtn.Visible = true;
                    ReqParts.Visible = true;
                    Invoice.Visible = true;
                }
            }
        }
    }
}