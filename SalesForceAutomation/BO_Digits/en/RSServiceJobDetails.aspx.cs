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
    public partial class RSServiceJobDetails : System.Web.UI.Page
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


            }

        }

        public void LoadData()
        {
            DataTable lstdata = ObjclsFrms.loadList("ServiceJobDetails", "sp_ServiceRequest", ResponseID.ToString());
            if (lstdata != null && lstdata.Rows.Count > 0)
            {
                lblServicerqstID.Text = lstdata.Rows[0]["snr_Code"].ToString();
                lblDate.Text = lstdata.Rows[0]["TransTime"].ToString();
                lblStatus.Text = lstdata.Rows[0]["Status"].ToString();
                lblActionType.Text = lstdata.Rows[0]["sjh_ActionType"].ToString();
                lblJobID.Text = lstdata.Rows[0]["sjh_Number"].ToString();

                lblSchDT.Text = lstdata.Rows[0]["sjh_ScheduledDate"].ToString();
                lblDur.Text = lstdata.Rows[0]["sjh_Duration"].ToString();

                DataTable InvItems = new DataTable();
                InvItems = ObjclsFrms.loadList("SelRSServiceJobInvItems", "sp_ServiceRequest", ResponseID.ToString());

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
                Invtools = ObjclsFrms.loadList("SelRSServiceJobInvTools", "sp_ServiceRequest", ResponseID.ToString());

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

                string signimg = lstdata.Rows[0]["sjh_Signature"].ToString();

                if (!string.IsNullOrEmpty(signimg))
                {
                    Image signImage = new Image();
                    signImage.ID = "signImage";
                    signImage.ImageUrl = "../" + signimg;
                    signImage.Height = 60;
                    signImage.Width = 60;
                    signImage.BorderStyle = BorderStyle.Groove;
                    signImage.BorderWidth = 2;
                    signImage.BorderColor = System.Drawing.Color.Black;

                    HyperLink hll = new HyperLink();
                    hll.ID = "signatureLink";
                    hll.NavigateUrl = "../" + signimg;
                    hll.Target = "_blank";
                    hll.Controls.Add(signImage);

                    pnlSign.Controls.Add(hll); // Add HyperLink containing the signature image
                }
                else
                {
                    Label lblimg = new Label();
                    lblimg.Style.Add("font-size", "14px");
                    lblimg.Text = "(No Signature)";
                    pnlSign.Controls.Add(lblimg);
                }


                for (int k = 0; k < lstdata.Rows.Count; k++)
                {
                    string Question = lstdata.Rows[k]["sjd_Question"].ToString();
                    string Answer = lstdata.Rows[k]["sjd_Answer"].ToString();
                    string Type = lstdata.Rows[k]["sjd_Type"].ToString();
                    string Remarks = lstdata.Rows[k]["sjd_Remarks"].ToString();

                    if (Question == "Working Status")
                    {
                        lblWorkStatus.Text = Answer;
                    }
                    else if (Question == "Service Type")
                    {
                        lblServiceType.Text = Answer;
                        lblTypeComments.Text = Remarks;
                    }
                    else if (Question == "Warranty")
                    {
                        lblWarranty.Text = Answer;
                    }
                    else if (Question == "Remarks")
                    {
                        lblRemarks.Text = Answer;
                    }
                    else if (Question == "Attach Images")
                    {
                        if (Answer == "")
                        {
                            Label lbljobimg = new Label();
                            lbljobimg.Style.Add("font-size", "14px");
                            lbljobimg.Text = "(No attached Images)";
                            pnljob.Controls.Add(lbljobimg);
                        }
                        else
                        {
                            string imah1 = Answer.Replace(" ", "");
                            string[] values = imah1.Split(',');
                            imah1 = imah1.Replace("&nbsp;", null);
                            for (int i = 0; i < values.Length; i++)
                            {
                                if (!string.IsNullOrEmpty(values[i]) && !values[i].Equals("&nbsp;"))
                                {
                                    Image imgg1 = new Image();
                                    imgg1.ID = "Imag2" + i.ToString();
                                    imgg1.ImageUrl = "../" + values[i];
                                    imgg1.Height = 60;
                                    imgg1.Width = 60;
                                    imgg1.BorderStyle = BorderStyle.Groove;
                                    imgg1.BorderWidth = 2;
                                    imgg1.BorderColor = System.Drawing.Color.Black;
                                    HyperLink hll = new HyperLink();
                                    hll.NavigateUrl = "../" + values[i];
                                    hll.ID = "hll" + i.ToString();
                                    hll.Target = "_blank";
                                    hll.Controls.Add(imgg1);
                                    pnljob.Controls.Add(hll);
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void btnRequireparts_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceJobRequiredParts.aspx?ID=" + ResponseID.ToString());
        }

        protected void btnInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("SalesDetails.aspx?JobID=" + ResponseID.ToString());

        }

        protected void InvItems_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }

        protected void InvTools_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }
    }
}