using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AssetServiceHistoryDetail : System.Web.UI.Page
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
            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestDetails", "sp_Transaction", ResponseID.ToString());
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

                string troubleshoot = lstdata.Rows[0]["snr_TroubleShoots"].ToString();
                
                if (comment == "")
                {
                    lblComments.Text = "(No Comments)";
                }
                else
                {
                    lblComments.Text = comment;
                }
                string status = lstdata.Rows[0]["Status"].ToString();

                if (status == "Action Taken")
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

        public void LoadJobs()
        {

            DataTable lstdata = ObjclsFrms.loadList("ServiceRequestJobHeader", "sp_Transaction", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                pnlServiceJob.Visible = true;
                RadGridServiceJob.DataSource = lstdata;
            }
            else
            {
                pnlServiceJob.Visible = false;
            }
        }

        protected void RadGridServiceJob_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadJobs();
        }

        protected void RadGridServiceJob_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("ServiceJobDetails.aspx?ID=" + ID.ToString());
            }

            if (e.CommandName.Equals("ReqParts"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("ServiceJobRequiredParts.aspx?ID=" + ID.ToString());
            }
            if (e.CommandName.Equals("Invoice"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("sjh_ID").ToString();

                Response.Redirect("SalesDetails.aspx?JobID=" + ID.ToString());
            }
        }

    }
}