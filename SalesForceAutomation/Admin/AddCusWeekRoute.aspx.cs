using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddCusWeekRoute : System.Web.UI.Page
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

        public int DResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["DId"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                fillForm();
                
            }
        }
        protected void fillForm()
        {
            if (ResponseID == 0)
            {

            }
            else
            {
                DataTable lstData = default(DataTable);
                lstData = ObjclsFrms.loadList("SelRouteWeekCusByID", "sp_WeekPlan", ResponseID.ToString());
                if (lstData.Rows.Count > 0)
                {

                    txtCustomer.Text = lstData.Rows[0]["cus_Name"].ToString();
                    txtWeekSeq.Text = lstData.Rows[0]["WeekNum"].ToString();
                    txtRoute.Text = lstData.Rows[0]["rot_name"].ToString();
                    rdSaturday.SelectedValue = lstData.Rows[0]["Sat"].ToString();
                    rdsatseq.Text = lstData.Rows[0]["SatSeq"].ToString();
                    rdSunday.SelectedValue = lstData.Rows[0]["Sun"].ToString();
                    rdsunseq.Text = lstData.Rows[0]["SunSeq"].ToString();
                    rdMonday.SelectedValue = lstData.Rows[0]["Mon"].ToString();
                    rdmonseq.Text = lstData.Rows[0]["MonSeq"].ToString();
                    rdTuesday.SelectedValue = lstData.Rows[0]["Tue"].ToString();
                    rdtueseq.Text = lstData.Rows[0]["TueSeq"].ToString();
                    rdWednesday.SelectedValue = lstData.Rows[0]["Wed"].ToString();
                    rdwedseq.Text = lstData.Rows[0]["WedSeq"].ToString();
                    rdThursday.SelectedValue = lstData.Rows[0]["Thu"].ToString();
                    rdthuseq.Text = lstData.Rows[0]["ThuSeq"].ToString();
                    rdFriday.SelectedValue = lstData.Rows[0]["Fri"].ToString();
                    rdfriseq.Text = lstData.Rows[0]["FriSeq"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string sat = rdSaturday.SelectedValue.ToString();
            string sun = rdSunday.SelectedValue.ToString();
            string mon = rdMonday.SelectedValue.ToString();
            string tue = rdTuesday.SelectedValue.ToString();
            string wed = rdWednesday.SelectedValue.ToString();
            string thu = rdThursday.SelectedValue.ToString();
            string fri = rdFriday.SelectedValue.ToString();
            string friseq = rdfriseq.Text.ToString();
            string satseq = rdsatseq.Text.ToString();
            string sunseq = rdsunseq.Text.ToString();
            string monseq= rdmonseq.Text.ToString();
            string tueseq= rdtueseq.Text.ToString();
            string wedseq = rdwedseq.Text.ToString();
            string thuseq = rdthuseq.Text.ToString();
           

            string[] arr = { sat, sun, mon, tue, wed, thu, fri, satseq,sunseq,monseq,tueseq,wedseq,thuseq,friseq};
            string lstData = ObjclsFrms.SaveData("sp_WeekPlan", "UpdateWeekPlan", ResponseID.ToString(), arr);
            int res = Int32.Parse(lstData);
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerWeekRoute.aspx?Id=" + DResponseID.ToString());
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerWeekRoute.aspx?Id=" + DResponseID.ToString());
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>OpenModal();</script>", false);
        }
    }
}