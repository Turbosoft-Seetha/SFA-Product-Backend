using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditSurveyMaster : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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
                lstData = Obj.loadList("SelectSurveyMasterById", "sp_Merchandising", ResponseID.ToString());
                if (lstData.Rows.Count > 0)
                {
                    string Name, Number, Status;

                    Name = lstData.Rows[0]["srm_Name"].ToString();
                    Number = lstData.Rows[0]["srm_Number"].ToString();
                    Status = lstData.Rows[0]["Status"].ToString();
                    txtsrmname.Text = Name;
                    ddlStatus.SelectedValue = Status.ToString();

                    labelqno.Text =  Number;
                }

            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddEditSurveyMaster.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string Name, Status, user;
            Name = txtsrmname.Text.ToString();
            Status = ddlStatus.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();


            if (ResponseID == 0)
            {

                string[] arr = { Status.ToString(), user.ToString() };
                String Value = Obj.SaveData("sp_Merchandising", "InsertSurveyMaster", Name.ToString(), arr);
                int res;
                if (Value == "")
                {
                    res = 0;
                }
                else
                {
                    res = Int32.Parse(Value.ToString());
                }
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }

            }
            else
            {
                string id = ResponseID.ToString();
                string[] arr = { Name.ToString(), Status.ToString(), user.ToString() };
                string Value = Obj.SaveData("sp_Merchandising", "updateSurveyMaster", id.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListSurveyMaster.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }
    }
}