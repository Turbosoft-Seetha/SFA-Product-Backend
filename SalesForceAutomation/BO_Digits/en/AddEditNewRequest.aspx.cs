using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditNewRequest : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                ViewState["RefImage"] = null;
                FillForm();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRequestByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string code, response, remarks, img;
                code = lstDatas.Rows[0]["req_Code"].ToString();
                response = lstDatas.Rows[0]["req_ResponseType"].ToString();
                remarks = lstDatas.Rows[0]["req_Remarks"].ToString();
                img = lstDatas.Rows[0]["req_ResponseImage"].ToString();

                txtcode.Text = code.ToString();
                ddlResponse.SelectedValue = response.ToString();
                txtremarks.Text = remarks.ToString();

                //hpl1.NavigateUrl = img.ToString();
                //hlval1.Value = ResponseID.ToString();
                //img1.ImageUrl = img.ToString();

                ViewState["RefImage"] = img.ToString();


                StringBuilder ltrlMessage = new StringBuilder();
                string imgg = img.ToString();
                string[] arrImg = imgg.Split(',');
                for (int i = 0; i < arrImg.Length; i++)
                {
                    img = "../../" + arrImg[i].ToString();

                    if (img != "")
                    {
                        ltrlMessage.AppendFormat("<a href=\"{0}\" target=\"_blank\">", img);
                        ltrlMessage.AppendFormat("<img src=\"{0}\" width=\"50px\"; height=\"50px\"; style=\"padding:5px; border-radius:15%;\">", img);
                        ltrlMessage.Append("</a>");

                    }

                }
                ltr.Text = ltrlMessage.ToString();



            }
        }
        protected void Save()
        {
            string response, remarks, img;

            response = ddlResponse.SelectedValue.ToString();
            remarks = txtremarks.Text.ToString();
            img = "";
            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;
                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/NewRequest/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);

                if (img.Equals(""))
                {
                    img = @"UploadFiles/NewRequest/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    ViewState["Image"] = img.ToString();
                }
                else
                {
                    img = @"UploadFiles/NewRequest/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                    ViewState["Image"] += "," + img.ToString();
                }

            }
            if (img == "")
            {
                img = ViewState["RefImage"].ToString();
            }
            else
            {
                img = ViewState["Image"].ToString();
            }
            if (img != null)
            {
                string id = ResponseID.ToString();
                string[] arr = { id, remarks, img };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateRequestResponse", response, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Request Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }


        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListNewRequest.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListNewRequest.aspx");
        }
    }
}