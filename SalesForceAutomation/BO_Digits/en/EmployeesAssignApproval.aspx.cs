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
    public partial class EmployeesAssignApproval : System.Web.UI.Page
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
                DataTable lstEmp = ObjclsFrms.loadList("SelectEmployeeByID", "sp_Masters", ResponseID.ToString());
                if (lstEmp.Rows.Count > 0)
                {
                    string code, name;
                    code = lstEmp.Rows[0]["emp_Code"].ToString();
                    name = lstEmp.Rows[0]["emp_Name"].ToString();

                    lblName.Text = name + " - " + code;
                }
            }
        }
        public void ListData()
        {
            DataTable lstUser = ObjclsFrms.loadList("SelectEmployeeRouteApproval", "sp_Masters_UOM", ResponseID.ToString());
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }

        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditEmployeeRotApprl.aspx?Id=" + ResponseID.ToString());
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Remove"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string promoDID = dataItem.GetDataKeyValue("erp_ID").ToString();
                ViewState["erpID"] = promoDID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            string id = ViewState["erpID"].ToString();
            GeneralFunctions.loadList_Static("DeleteEmployeeRouteApproval", "sp_Masters", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}