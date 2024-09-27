using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditLicenseManagement : System.Web.UI.Page
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
                FillForm();

                if (ResponseID.Equals("0") || ResponseID == 0)
                {
                    dllStartDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                    dllExpiryDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                }
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelLicenseByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string ProjectID, PreSharedKey, LicenseKey, StartDate, ExpiryDate, NoOfLicenses, Status, BufferDays, Version;
                ProjectID = lstDatas.Rows[0]["lim_ProjectID"].ToString();
                PreSharedKey = lstDatas.Rows[0]["lim_PreSharedKey"].ToString();
                LicenseKey = lstDatas.Rows[0]["lim_LicenseKey"].ToString();
                StartDate = lstDatas.Rows[0]["lim_StartDate"].ToString();
                ExpiryDate = lstDatas.Rows[0]["lim_ExpiryDate"].ToString();
                NoOfLicenses = lstDatas.Rows[0]["lim_NoOfLicenses"].ToString();
                Status = lstDatas.Rows[0]["lim_Status"].ToString();
                BufferDays = lstDatas.Rows[0]["lim_BufferDays"].ToString();
                Version = lstDatas.Rows[0]["lim_Version"].ToString();

                dllStartDate.Enabled = true;
                dllExpiryDate.Enabled = true;
                              

                txtProjectID.Text = ProjectID.ToString();
                txtPreSharedKey.Text = PreSharedKey.ToString();
                txtLicenseKey.Text = LicenseKey.ToString();
                dllStartDate.SelectedDate = DateTime.Parse(StartDate.ToString());
                dllExpiryDate.SelectedDate = DateTime.Parse(ExpiryDate.ToString());
                txtNoOfLicenses.Text = NoOfLicenses.ToString();
                ddlStatus.SelectedValue = Status.ToString();
                txtBufferDays.Text = BufferDays.ToString();
                txtVersion.Text = Version.ToString();


            }
        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LicenseManagement.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
        protected void Save(string mode)
        {
            string ProjectID, PreSharedKey, LicenseKey, StartDate, ExpiryDate, NoOfLicenses, Status, BufferDays, Version, user;
            ProjectID = txtProjectID.Text.ToString();
            PreSharedKey = txtPreSharedKey.Text.ToString();
            LicenseKey = txtLicenseKey.Text.ToString();
            StartDate = DateTime.Parse(dllStartDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ExpiryDate = DateTime.Parse(dllExpiryDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            NoOfLicenses = txtNoOfLicenses.Text.ToString();
            BufferDays = txtBufferDays.Text.ToString();
            Version = txtVersion.Text.ToString();
            Status = ddlStatus.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();

            if (mode.Equals("I"))
            {
                string[] arr = { ProjectID, PreSharedKey, LicenseKey, StartDate, ExpiryDate, NoOfLicenses, Status, BufferDays, Version, user };
                DataTable lstClaim = ObjclsFrms.loadList("InsertIntoLicense", "sp_Masters", mode.ToString(), arr);
                if (lstClaim.Rows.Count > 0)
                {
                    string claimID = lstClaim.Rows[0]["sliderID"].ToString();
                    ViewState["claimID"] = claimID.ToString();
                }
            }
            else
            {
                string id = ResponseID.ToString();
                string[] arr = { ProjectID, PreSharedKey, LicenseKey, StartDate, ExpiryDate, NoOfLicenses, Status, BufferDays, Version, id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertIntoLicense", mode.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    string claimID = res.ToString();
                    ViewState["claimID"] = claimID.ToString();
                }
                else
                {
                    ViewState["claimID"] = res.ToString();
                }
            }
            string claim = ViewState["claimID"].ToString();

            if (claim == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('License Details Saved Successfully');</script>", false);
            }
        }
        protected void save_Click(object sender, EventArgs e)
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
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditLicenseManagement.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("LicenseManagement.aspx");
        }
    }
}