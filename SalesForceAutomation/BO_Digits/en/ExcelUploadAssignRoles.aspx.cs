using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ExcelUploadAssignRoles : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
            }
        }
        public void ListData()
        {
            DataTable lstUser = ObjclsFrms.loadList("SelectExceluploadRoles", "sp_ExcelUpload");
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("EditCol"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("upt_ID").ToString();
                ViewState["ID"] = ID;
                ExceluploadRoles();
                FillForm();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
           
        }

       
        public void ExceluploadRoles()
        {
            string ExcelType = ViewState["ID"].ToString();
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
            string ID = ViewState["ID"].ToString();
            DataTable lstDatas = ObjclsFrms.loadList("SelectExcelRolesByID", "sp_ExcelUpload", ID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string ExcelType = lstDatas.Rows[0]["upt_Name"].ToString();
                string ExcelRoles = lstDatas.Rows[0]["Roles"].ToString();

                lblType.Text = ExcelType;

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
            string Type, user;
            Type = ViewState["ID"].ToString();
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
    }
}