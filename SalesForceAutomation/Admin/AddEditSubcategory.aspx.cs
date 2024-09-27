using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditSubcategory : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
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
                Route();
                FillForm();
            }
        }
        
        public void FillForm()
        {
            DataTable lstDatas = ob.loadList("SelectSubByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, catid, code, status; 
                 name = lstDatas.Rows[0]["sct_Name"].ToString();
                catid = lstDatas.Rows[0]["sct_cat_ID"].ToString();
                code = lstDatas.Rows[0]["sct_Code"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtname.Text = name.ToString();
                ddlid.SelectedValue = catid.ToString();
                txtcode.Text = code.ToString();
               
                ddlStats.SelectedValue = status.ToString();
            }
        }
        protected void Save()
        {
            string name, code,catid, user, status;

            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            catid = ddlid.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStats.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { catid.ToString(),code.ToString(), user.ToString(), status.ToString() };
                string Value =ob.SaveData("sp_Masters", "InsertSub", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Subcategory Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { catid.ToString(), code.ToString(),  status.ToString(), id.ToString() };
                string Value = ob.SaveData("sp_Masters", "UpdateSub", name.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Subcategory Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        public void Route()
        {
            DataTable dt = ob.loadList("SelectCatFromDrop", "sp_Masters");
            ddlid.DataSource = dt;
            ddlid.DataTextField = "cat_Name";
            ddlid.DataValueField = "cat_ID";
            ddlid.DataBind();
        }

        
        protected void cancel_Click1(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListSubCategory.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();

        }

        protected void save_Click1(object sender, EventArgs e)
        {
            Save();

        }

        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListSubCategory.aspx");
        }
    }
}