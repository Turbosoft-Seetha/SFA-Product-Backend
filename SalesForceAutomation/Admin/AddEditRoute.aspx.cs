using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                user();
                FillForm();
                
            }

        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRouteByID", "sp_Backend", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name,username, code,  status,pass,unload,deviceid,stlmnt,enforcejp, odometer, workingdays ;
                name = lstDatas.Rows[0]["rot_Name"].ToString();
                username= lstDatas.Rows[0]["usr_ID"].ToString();
                code = lstDatas.Rows[0]["rot_Code"].ToString();
                pass=lstDatas.Rows[0]["rot_Pass"].ToString();
                unload= lstDatas.Rows[0]["rot_IsUnload"].ToString();
                deviceid = lstDatas.Rows[0]["rot_DeviceID"].ToString();
                stlmnt = lstDatas.Rows[0]["rot_AllowSetlmntDiscrepancy"].ToString();
                enforcejp = lstDatas.Rows[0]["EnforceJP"].ToString();
                odometer = lstDatas.Rows[0]["rot_EnableOdometer"].ToString();
                workingdays = lstDatas.Rows[0]["WorkingDays"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtname.Text = name.ToString();
                txtcode.Text = code.ToString();
                ddlname.SelectedValue = username.ToString();
                txtpass.Text = pass.ToString();
                ddlis.SelectedValue= unload.ToString();
                txtdeviceid.Text = deviceid.ToString();
                ddlstlmnt.SelectedValue = stlmnt.ToString();
                ddlenforcejp.SelectedValue = enforcejp.ToString();
                ddlodometer.SelectedValue = odometer.ToString();
                txtworkingdays.Text = workingdays.ToString();
                ddlStats.SelectedValue = status.ToString();
                txtcode.Enabled = false;
                //ddlname.DataBind();
            }
        }
        protected void Save()
        {
            string name,username, code, user, status,pass,unload,deviceid,enforcejp,stlmnt, odometer, workingdays;

            name = txtname.Text.ToString();
            username = ddlname.SelectedValue.ToString();
            code = txtcode.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            pass = txtpass.Text.ToString();
            unload = ddlis.SelectedValue. ToString();
            status = ddlStats.SelectedValue.ToString();

            deviceid = txtdeviceid.Text.ToString();
            enforcejp = ddlenforcejp.SelectedValue.ToString();
            stlmnt= ddlstlmnt.SelectedValue.ToString();
            odometer = ddlodometer.SelectedValue.ToString();
            workingdays = txtworkingdays.Text.ToString();

            
            if (ResponseID.Equals("") || ResponseID == 0)
            {

                string[] arr = { code,username,pass,unload,  user, deviceid,stlmnt,enforcejp,odometer,workingdays, status };
                string Value = ObjclsFrms.SaveData("sp_Backend", "InsertRoutes", name, arr);
                
                try 
                {
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route saved Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('The Device ID already Exisits');</script>", false);

                    }
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { code, username, pass, unload, deviceid,stlmnt,enforcejp,odometer,workingdays, status, id};
                string Value = ObjclsFrms.SaveData("sp_Backend", "UpdateRoutes", name, arr);
                int res = Int32.Parse(Value.ToString());
                try
                {
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route Updated Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('The Device ID already Exisits');</script>", false);
                    }
                }
                catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        public void user()
        {
            DataTable dt = ObjclsFrms.loadList("SelUserFromDrop", "sp_Backend", ResponseID.ToString());
            ddlname.DataSource = dt;
            ddlname.DataTextField = "usr_Name";
            ddlname.DataValueField = "usr_ID";
            ddlname.DataBind();
        }

        protected void cancel1_Click(object sender, EventArgs e)
        {

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListRoute.aspx");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListRoute.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        
    }
}