using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Fixed.Model.Common;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditExcelUploadRoles : System.Web.UI.Page
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
                ExceluploadTypes();
                //FillForm();
            }
        }
        public void ExceluploadTypes()
        {
            DataTable dt = ObjclsFrms.loadList("SelectTypesforDropdown", "sp_ExcelUpload");
            ddlType.DataSource = dt;
            ddlType.DataTextField = "upt_Name";
            ddlType.DataValueField = "upt_ID";
            ddlType.DataBind();
        }
        public void ExceluploadRoles()
        {
            string ExcelType = ddlType.SelectedValue.ToString();
            DataTable dt = ObjclsFrms.loadList("SelectUserRolesforDropdown", "sp_ExcelUpload", ExcelType);
            ddlRoles.DataSource = dt;
            ddlRoles.DataTextField = "RoleName";
            ddlRoles.DataValueField = "RoleName";
            ddlRoles.DataBind();
        }

        public string GetRoles()
        {
            var CollectionMarket = ddlRoles.CheckedItems;
            string ID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    ID += item.Text + ",";
                    j++;
                }
                ID = ID.TrimEnd(',');
                return ID;
            }
            else
            {
                return "0";
            }

        }
        public void FillForm()
        {
            string ID = ddlType.SelectedValue.ToString();
            DataTable lstDatas = ObjclsFrms.loadList("SelectExcelRolesByID", "sp_ExcelUpload", ID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string ExcelRoles = lstDatas.Rows[0]["Roles"].ToString();
                string[] ar = ExcelRoles.Split(',');

                for (int i = 0; i < ar.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlRoles.Items)
                    {
                        if (items.Value == ar[i])
                        {
                            items.Checked = true;
                        }
                    }
                }

            }
        }
        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditEmployeeRotApprl.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string Roles = GetRoles();
            string ID, Type, user;
            //ID = ResponseID.ToString();
            Type = ddlType.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { Roles, user };

            string Value = ObjclsFrms.SaveData("sp_ExcelUpload", "UpdateExceluploadRoles", Type, arr);
            int res = Int32.Parse(Value.ToString());
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
            Response.Redirect("ExcelUploadAssignRoles.aspx");
        }

        protected void ddlType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ExceluploadRoles();
            FillForm();
        }
    }
}