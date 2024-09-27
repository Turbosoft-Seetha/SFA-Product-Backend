using DocumentFormat.OpenXml.Spreadsheet;
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
    public partial class AddEditTasks : System.Web.UI.Page
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
                Brand();
                ViewState["taskimage"] = null;
                fillForm();
            }
        }
        public void Brand()
        {
            DataTable dt = ObjclsFrms.loadList("SelectBrand", "sp_wb_merch_others");
            ddlBrd.DataSource = dt;
            ddlBrd.DataTextField = "brd_Name";
            ddlBrd.DataValueField = "brd_ID";
            ddlBrd.DataBind();
        }
        protected void fillForm()
        {
            if (ResponseID == 0)
            {

            }
            else
            {
                DataTable lstData = default(DataTable);
                lstData = ObjclsFrms.loadList("SelectTaskByID", "sp_Merchandising", ResponseID.ToString());
                if (lstData.Rows.Count > 0)
                {
                    string name, code, RefImage, brnd,duedate,desc;

                    name = lstData.Rows[0]["tsk_Name"].ToString();
                    code = lstData.Rows[0]["tsk_Code"].ToString();
                    RefImage = lstData.Rows[0]["tsk_ReferenceImage"].ToString();
                    duedate = lstData.Rows[0]["DueDate"].ToString();
                    brnd = lstData.Rows[0]["tsk_brd_ID"].ToString();
                    desc= lstData.Rows[0]["tsk_Desc"].ToString();

                    txtCTName.Text = name.ToString();
                    txtCode.Text = code.ToString();
                    txtduedate.SelectedDate = DateTime.Parse(duedate.ToString());
                    ddlBrd.SelectedValue = brnd.ToString();
                    txtDesc.Text = desc.ToString();
                    hpl1.NavigateUrl = RefImage.ToString();
                    hlval1.Value = ResponseID.ToString();
                    img1.ImageUrl = RefImage.ToString();
                    ViewState["taskimage"] = RefImage.ToString();
                }
            }
        }
        protected void Save(string mode)
        {
            string user, name, code, taskimg, brnd, duedate,desc;
            name = txtCTName.Text.ToString();
            code = txtCode.Text.ToString();

            taskimg = "";
            desc=txtDesc.Text.ToString();
            brnd = ddlBrd.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            duedate = DateTime.Parse(txtduedate.SelectedDate.ToString()).ToString("yyyyMMdd");
            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;
                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/Task/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                taskimg = @"../../UploadFiles/Task/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                ViewState["Image"] = taskimg.ToString();
            }
            if (taskimg == "")
            {
                taskimg = ViewState["taskimage"].ToString();
            }
            else
            {
                taskimg = ViewState["Image"].ToString();
            }

            if (taskimg != null)
            {
                string Values = "";
                try
                {
                    

                    if (mode.Equals("I"))
                    {
                        string[] arr = { name.ToString(), taskimg.ToString(), duedate.ToString(), brnd.ToString(), user.ToString(), desc.ToString() };
                         Values = ObjclsFrms.SaveData("sp_Merchandising", "InsertTasks", code.ToString(), arr);
                        int res = Int32.Parse(Values.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Task has been inserted successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                        }
                    }

                    else
                    {
                        string id = ResponseID.ToString();
                        string[] arr = { name.ToString(), taskimg.ToString(), duedate.ToString(), brnd.ToString(), user.ToString(), id.ToString(), desc.ToString() };
                         Values = ObjclsFrms.SaveData("sp_Merchandising", "UpdateTask", code.ToString(), arr);
                        int res = Int32.Parse(Values.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Task has been updated');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                        }
                    }
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModals('"+Values+"');</script>", false);

                }
            }
           
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                if (ResponseID == 0)
                {
                    string mode = "I";
                    Save(mode);
                }
                else
                {
                    string mode = "U";
                    Save(mode);
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditTask.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListTasks.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            //string planogram = img1.ImageUrl.ToString();

            if ((upd1.UploadedFiles.Count == 0) && (ViewState["taskimage"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }
     
        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckTaskCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                LinkButton2.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                LinkButton2.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListTasks.aspx");
        }
    }
}