using DocumentFormat.OpenXml.Wordprocessing;
using GoogleApi.Entities.Common.Enums;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class AddEditHelper : System.Web.UI.Page
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
				ViewState["hel_ID"] = null;
				fillForm();
				company();

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
				lstData = ObjclsFrms.loadList("SelectHelperByID", "sp_Masters", ResponseID.ToString());
				if (lstData.Rows.Count > 0)
				{
					string name, code, status,company;

					name = lstData.Rows[0]["hel_name"].ToString();
					code = lstData.Rows[0]["hel_code"].ToString();					
					status = lstData.Rows[0]["Status"].ToString();
                    company = lstData.Rows[0]["hel_CompanyCode"].ToString();


                    hel_name.Text = name.ToString();
					hel_code.Text = code.ToString();					
					ddlStatus.SelectedValue = status.ToString();
                    ddlhelcompany.SelectedValue = company.ToString();


                }
            }
		}
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlhelcompany.DataSource = dt;
            ddlhelcompany.DataTextField = "com_Name";
            ddlhelcompany.DataValueField = "com_Code";
            ddlhelcompany.DataBind();
        }
        protected void Save(string mode)
		{
			string user, name, code, status,company;
			name = hel_name.Text.ToString();
			code = hel_code.Text.ToString();

			status = ddlStatus.SelectedValue.ToString();
			user = UICommon.GetCurrentUserID().ToString();
            company = ddlhelcompany.SelectedValue.ToString();

            if (mode.Equals("I"))
			{
				string[] arr = { code.ToString(), user.ToString(), status.ToString(), company.ToString() };
				string Value = ObjclsFrms.SaveData("sp_Masters", "InsertHelper", name.ToString(), arr);
				int res = Int32.Parse(Value.ToString());
				if (res > 0)
				{
					ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Helper has been Added successfully');</script>", false);
				}
				else
				{
					ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
				}

			}

			else
			{
				string id = ResponseID.ToString();
				string[] arr = { name.ToString(), code.ToString(),  user.ToString(), status.ToString(), company.ToString() };
				string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateHelper", id.ToString(), arr);
				int res = Int32.Parse(Value.ToString());
				if (res > 0)
				{
					ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Helper has been updated');</script>", false);
				}
				else
				{
					ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
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
				ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditHelper.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
			}
		}

		protected void btnOK_Click(object sender, EventArgs e)
		{
			Response.Redirect("ListHelper.aspx");
		}

		protected void helperCode_TextChanged(object sender, EventArgs e)
		{
			string code = this.hel_code.Text.ToString();
			DataTable lstCodeChecker = ObjclsFrms.loadList("CheckHelperCode", "sp_CodeChecker", code);
			if (lstCodeChecker.Rows.Count > 0)
			{
				lblCodeDupli.Text = "Code Already Exist";
				LinkButton1.Enabled = false;
				lblCodeDupli.Visible = true;
			}
			else
			{
				LinkButton1.Enabled = true;
				lblCodeDupli.Visible = false;
			}
		}


	}
}