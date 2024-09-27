using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditEmployees : System.Web.UI.Page
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
                    txtCode.Enabled = true;
                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = obj.loadList("EditEmployees", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {
                        string Empname, Empcode,Emppass, status;                                          //Declare the variables
                        Empname = lstDatas.Rows[0]["emp_Name"].ToString();                         //Set the value to the variables
                        Empcode = lstDatas.Rows[0]["emp_Code"].ToString();
                        Emppass= lstDatas.Rows[0]["emp_Pass"].ToString();
                        status = lstDatas.Rows[0]["Status"].ToString();

                        txtName.Text = Empname.ToString();                                     //Here the binding is done. "txtName" is the ID of the textBox in ASPX
                        txtCode.Text = Empcode.ToString();
                        txtPass.Text = Emppass.ToString();
                        ddlStatus.SelectedValue = status.ToString();
                    }
                    else                                                              //If there is no value you can leave it as it is.
                    {

                    }
                }
            }
        }
        public void Save()
        {
            string Empname, Empcode, User, Emppass,Status;
            Empname = this.txtName.Text.ToString();
            Empcode = this.txtCode.Text.ToString();
            Emppass = this.txtPass.Text.ToString();
            User = UICommon.GetCurrentUserID().ToString();
            Status = this.ddlStatus.SelectedValue.ToString();



            if (ResponseID.Equals("") || ResponseID == 0)
            {
                
                string[] arr = { Empcode, Emppass, User, Status };
                string Value = obj.SaveData("sp_Masters", "InsertEmployee", Empname, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { Empcode, Emppass, User, Status, ID };
                string value = obj.SaveData("sp_Masters", "UpdateEmployee", Empname, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
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
            Response.Redirect("/Admin/ListEmployees.aspx");
        }

        protected void save1_Click(object sender, EventArgs e)
        {
            Save();
        }

        

        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListEmployees.aspx");
        }
    }
}