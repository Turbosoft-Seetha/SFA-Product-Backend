using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditUsers : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
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
                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = obj.loadList("EditUsers", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {
                        string name,arabic,code, pass, status, istracking, TrackDuration;                                          //Declare the variables
                        name = lstDatas.Rows[0]["usr_Name"].ToString();
                        arabic = lstDatas.Rows[0]["usr_ArabicName"].ToString();
                        code = lstDatas.Rows[0]["usr_Code"].ToString();
                        pass = lstDatas.Rows[0]["usr_Password"].ToString();
                        status = lstDatas.Rows[0]["Status"].ToString();
                        istracking = lstDatas.Rows[0]["usr_IsTrackingNeeded"].ToString();
                        TrackDuration = lstDatas.Rows[0]["usr_TrackingDuration"].ToString();

                        txtName.Text = name.ToString();
                        txtArabic.Text = arabic.ToString();
                        txtCode.Text = code.ToString();
                        txtPass.Text = pass.ToString();
                        ddlStatus.SelectedValue = status.ToString();
                        txtCode.Enabled = false;
                        rdDuration.Text = TrackDuration.ToString(); 
                        ddlTracking.SelectedValue = TrackDuration.ToString();   
                    }
                    else                                                              //If there is no value you can leave it as it is.
                    {

                    }
                }
            }
        }
        public void Save()
        {
            string name,arabic, code, User, pass, Status , istracking , TrackDuration;
            name = this.txtName.Text.ToString();
            arabic = this.txtArabic.Text.ToString();
            code = this.txtCode.Text.ToString();
            pass = this.txtPass.Text.ToString();
            User = UICommon.GetCurrentUserID().ToString();
            Status = this.ddlStatus.SelectedValue.ToString();
            istracking = this.ddlTracking.SelectedValue.ToString();
            TrackDuration = this.rdDuration.Text.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { code, pass, User, Status , istracking , TrackDuration, arabic };
                string Value = obj.SaveData("sp_Masters", "InsertUser", name, arr);
                try
                {
                    int res = Int32.Parse(Value.ToString());

                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been saved successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
               
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { code, pass, User, Status, ID , istracking  , TrackDuration, arabic };
                string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListUsers.aspx");
        }

        protected void save1_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListUsers.aspx");
        }
    }
}