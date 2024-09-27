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
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OpenFSJobDetails : System.Web.UI.Page
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
                try
                {
                    LoadData();

                }
                catch (Exception ex)
                {

                }


            }

        }


        public void LoadData()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelUnassignedServiceReqDetail", "sp_ServiceRequest", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                lblServicerqstID.Text = lstdata.Rows[0]["snr_Code"].ToString();
                lblDate.Text = lstdata.Rows[0]["TransTime"].ToString();
                lblStatus.Text = lstdata.Rows[0]["Status"].ToString();
                lblCustomer.Text = lstdata.Rows[0]["cus_Name"].ToString();
                string planogram = lstdata.Rows[0]["ast_Planogram"].ToString();
                lblAsset.Text = lstdata.Rows[0]["asc_Name"].ToString();
                lblComplaint.Text = lstdata.Rows[0]["snr_Complaint"].ToString();
                lblComplaintType.Text = lstdata.Rows[0]["cst_Name"].ToString();
                lblAssetSno.Text = lstdata.Rows[0]["atm_Code"].ToString();
                string comment = lstdata.Rows[0]["snr_Remarks"].ToString();
                lblSchDT.Text = lstdata.Rows[0]["sjh_ScheduledDate"].ToString();
                lblDur.Text = lstdata.Rows[0]["sjh_Duration"].ToString();

                DataTable InvItems = new DataTable();
                InvItems = ObjclsFrms.loadList("SelInvItems", "sp_ServiceRequest", ResponseID.ToString());

                if (InvItems.Rows.Count > 0)
                {
                    lblNoItems.Visible = false;
                    pnlInvItems.Visible = true;

                    GridInvItems.DataSource = InvItems;
                    GridInvItems.DataBind();

                }
                else
                {
                    lblNoItems.Visible = true;
                    pnlInvItems.Visible = false;
                }

                DataTable Invtools = new DataTable();
                Invtools = ObjclsFrms.loadList("SelInvTools", "sp_ServiceRequest", ResponseID.ToString());

                if (Invtools.Rows.Count > 0)
                {
                    lblInvTool.Visible = false;
                    pnlInvTools.Visible = true;

                    GridInvTools.DataSource = Invtools;
                    GridInvTools.DataBind();

                }
                else
                {
                    lblInvTool.Visible = true;
                    pnlInvTools.Visible = false;
                }

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


                string img = lstdata.Rows[0]["snr_Image"].ToString();
                string signimg = lstdata.Rows[0]["sjh_Signature"].ToString();

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

                if (signimg == "")
                {
                    Label lblimg = new Label();
                    lblimg.Style.Add("font-size", "14px");
                    lblimg.Text = "(No Signature)";
                    pnlSign.Controls.Add(lblimg);
                }
                else
                {
                    string imah = signimg.Replace(" ", "");
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

                            pnlSign.Controls.Add(hl);


                        }
                    }

                }


            }
        }
        protected void InvItems_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void InvTools_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

    }
}