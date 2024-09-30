using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListUserWorkFlow : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        public int UID
        {
            get
            {
                int UID;
                int.TryParse(Request.Params["UID"], out UID);
                return UID;
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Workflow();
                ViewState["DataTable"] = null;
                Level();
                
                

            }
        }
        public void Workflow()
        {
           string uid = Request.Params["UID"].ToString();

            DataTable dt = Obj.loadList("WorkflowDropdown", "sp_Masters",uid.ToString());
            ddlWorkflow.DataSource = dt;
            ddlWorkflow.DataTextField = "wfm_Name";
            ddlWorkflow.DataValueField = "wfm_ID";
            ddlWorkflow.DataBind();
        }

        public void Level()
        {
            string wfmid = ddlWorkflow.SelectedValue.ToString();

            DataTable dts = Obj.loadList("levelDropdown", "sp_Masters", wfmid);
            ddllevel.DataSource = dts;
            ddllevel.DataTextField = "wfn_Currentlevel";
            ddllevel.DataValueField = "wfn_Currentlevel";
            ddllevel.DataBind();

        }
      
       
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();

        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            string user = Request.Params["UID"].ToString();

            lstDatas = Obj.loadList("ListUserWorkflow", "sp_Masters", user);
            if (lstDatas.Rows.Count > 0)
            {

                grvRpt.DataSource = lstDatas;
  
            }
            


        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

        protected void AddItem_Click(object sender, EventArgs e)
        {

            addTable();
            LoadData();
            grvRpt.DataBind();

        }
        public void addTable()
        {
            string level;
            string wfmid = ddlWorkflow.SelectedValue.ToString();
            level= ddllevel.SelectedValue.ToString();
            string user = Request.Params["UID"].ToString();

            string[] arr = { wfmid,level };
            string Value = Obj.SaveData("sp_Masters", "InsWorkflow", user.ToString(), arr);
            int LID = Int32.Parse(Value.ToString());
            if (LID > 0)
            {

                Response.Redirect("ListUserWorkFlow.aspx?UID=" + user);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
            }

            
            


        }

        protected void lnkcancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListUserWorkFlow.aspx?UID=" + UID);
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        
        
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }

        

        protected void ddlWorkflow_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Level();
        }


        
        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {

            string id = ViewState["delID"].ToString();
            string user = Request.Params["UID"].ToString();

            string[] arr = { id};
            DataTable delData = Obj.loadList("DeleteUseWorkflow", "sp_Masters", user,arr);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            
        }

        protected void delOk_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
            //string user = Request.Params["UID"].ToString();
            //Response.Redirect("ListUserWorkFlow.aspx?UID=" + user);
        }
    }
}