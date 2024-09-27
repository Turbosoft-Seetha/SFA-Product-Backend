using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditRouteWorkingDays : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int RoutID
        {
            get
            {
                int RoutID;
                int.TryParse(Request.Params["RId"], out RoutID);

                return RoutID;
            }
        }

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["rmdId"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
                FillForm();
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRouteworkingDaysByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string mnth,workDays, status;
                mnth = lstDatas.Rows[0]["rmd_Month"].ToString();
                workDays = lstDatas.Rows[0]["rmd_WorkingDays"].ToString();

                status = lstDatas.Rows[0]["Status"].ToString();


                radmonth.SelectedDate = DateTime.Parse(mnth.ToString());
                txtworkdays.Text = workDays.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }

        protected void Save()
        {
            string mnth,workDays,user, status;

            mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            workDays = txtworkdays.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { workDays.ToString(), user.ToString(), status.ToString() ,RoutID.ToString()};
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertRouteWorkingDays", mnth.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Working Days Saved Successfully');</script>", false);
                }
                else if(res==0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { workDays.ToString(), status.ToString(),user.ToString(), id.ToString(),RoutID.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateRouteWorkingDays", mnth.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Updated Successfully');</script>", false);
                }
                else if(res==0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

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
            Response.Redirect("/Admin/ListRouteWorkingDays.aspx?RId="+RoutID.ToString());
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListRouteWorkingDays.aspx?RId=" + RoutID.ToString());
        }
    }
}