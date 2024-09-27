using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditBrands : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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

                FillForm();
                company();


            }

        }
        public void FillForm()
        {
            //Edit details 
            //test
            

            DataTable lstDatas = Obj.loadList("EditBrand", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string brdname, brdcode, Status, Arabic, brdImage,company;                                          

                brdname = lstDatas.Rows[0]["brd_Name"].ToString();                         
                brdcode = lstDatas.Rows[0]["brd_Code"].ToString();
                Status = lstDatas.Rows[0]["Status"].ToString();
                Arabic = lstDatas.Rows[0]["brd_NameArabic"].ToString();
                brdImage = lstDatas.Rows[0]["brd_Img"].ToString();
                company = lstDatas.Rows[0]["brd_CompanyCode"].ToString();


                txtName.Text = brdname.ToString();                                     
                txtCode.Text = brdcode.ToString();
                txtCode.Enabled = false;
                ddlStat.SelectedValue = Status.ToString();
                txtArabic.Text = Arabic.ToString();
                hpl1.NavigateUrl = brdImage.ToString();
                hlval1.Value = ResponseID.ToString();
                img1.ImageUrl = brdImage.ToString();
                ViewState["brdImage"] = brdImage.ToString();
                ddlbrdcompany.SelectedValue = company.ToString();

            }

        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = Obj.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlbrdcompany.DataSource = dt;
            ddlbrdcompany.DataTextField = "com_Name";
            ddlbrdcompany.DataValueField = "com_Code";
            ddlbrdcompany.DataBind();
        }
        protected void SaveData(string mode)
        {
            string brdname, brdcode, Status, User, Arabic, brdImage,company;
            brdname = txtName.Text.ToString();
            brdcode = txtCode.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            User = UICommon.GetCurrentUserID().ToString();
            Arabic = txtArabic.Text.ToString();
            brdImage = "";
            company = ddlbrdcompany.SelectedValue.ToString();


            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;
                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/Brand/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                brdImage = @"../../UploadFiles/Brand/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                ViewState["Image"] = brdImage.ToString();
            }
            //if (brdImage == "")
            //{
            //    brdImage = ViewState["brdImage"].ToString();
            //}
            //else
            //{
            //    brdImage = ViewState["Image"].ToString();
            //}

            //if (brdImage != null)
            //{
               if (mode.Equals("I"))
                {

                    string[] arr = { brdcode, User, Status, Arabic, brdImage,company };
                    string value = Obj.SaveData("sp_Masters", "AddBrand", brdname, arr);
                    int res = Int32.Parse(value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Brand has been saved Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                    }
                }
                else
                {
                    brdImage = ViewState["brdImage"].ToString();
                    string ID = ResponseID.ToString();
                    string[] arr = { brdcode, User, Status, Arabic, ID , brdImage,company };
                    string value = Obj.SaveData("sp_Masters", "UpdateBrand", brdname, arr);
                    int res = Int32.Parse(value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Brand has been updated Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                    }
                }
            ///}
        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListBrand.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            //if ((upd1.UploadedFiles.Count == 0) && (ViewState["brdImage"] == null))
            //{


            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            //}
            //else
            //{
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //}
        }

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ResponseID == 0)
                {
                    string mode = "I";
                    SaveData(mode);
                }
                else
                {
                    string mode = "U";
                    SaveData(mode);
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddEditQuestions.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListBrand.aspx");
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = Obj.loadList("CheckBrandCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                lnkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                lnkSave.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }
    }
}