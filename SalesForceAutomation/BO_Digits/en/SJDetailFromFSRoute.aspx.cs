using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SJDetailFromFSRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }
        public string ResponseType
        {
            get
            {
                string ResponseType = Request.Params["Type"];

                return ResponseType;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    
                    
                    
                    
                }
                catch (Exception ex)
                {

                }
            }
        }

        public void LoadData()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelTodayServiceReqDetail", "sp_ServiceDashboard", ResponseID.ToString());
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

        public void LoadDataJob()
        {
            DataTable lstdata = ObjclsFrms.loadList("TodayServiceJobDetails", "sp_ServiceDashboard", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                lblSerJobID.Text = lstdata.Rows[0]["snr_Code"].ToString();
                lbljobDate.Text = lstdata.Rows[0]["TransTime"].ToString();
                lblJobCurrStatus.Text = lstdata.Rows[0]["Status"].ToString();
                lblActionType.Text = lstdata.Rows[0]["sjh_ActionType"].ToString();



                lblJobID.Text = lstdata.Rows[0]["sjh_Number"].ToString();


                for (int k = 0; k < lstdata.Rows.Count; k++)
                {
                    string Question = lstdata.Rows[k]["sjd_Question"].ToString();
                    string Answer = lstdata.Rows[k]["sjd_Answer"].ToString();
                    string Type = lstdata.Rows[k]["sjd_Type"].ToString();
                    string Remarks = lstdata.Rows[k]["sjd_Remarks"].ToString();
                    if (Question == "Working Status")
                    {
                        lblWorkStatus.Text = Answer.ToString();
                    }
                    else if (Question == "Service Type")
                    {
                        lblServiceType.Text = Answer.ToString();
                        lblTypeComments.Text = Remarks.ToString();
                    }
                    else if (Question == "Warranty")
                    {
                        lblWarranty.Text = Answer.ToString();
                    }
                    else if (Question == "Remarks")
                    {
                        lblRemarks.Text = Answer.ToString();
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
                                if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                                {
                                    Image imgg1 = new Image();
                                    imgg1.ID = "Imag2" + i.ToString();
                                    imgg1.ImageUrl = "../" + values[i].ToString();
                                    imgg1.Height = 60;
                                    imgg1.Width = 60;
                                    imgg1.BorderStyle = BorderStyle.Groove;
                                    imgg1.BorderWidth = 2;
                                    imgg1.BorderColor = System.Drawing.Color.Black;
                                    HyperLink hll = new HyperLink();
                                    hll.NavigateUrl = "../" + values[i].ToString();
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
    }
}