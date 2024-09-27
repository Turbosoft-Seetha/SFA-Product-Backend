using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    
    public partial class QuestionDetail : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();

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
                fillForm();
                Route();
            }
        }
        protected void Save()
        {
            string surQuestion, Orders, Mandat, user;
            surQuestion = ddlQtns.SelectedValue.ToString();
            Mandat = ddlMandat.SelectedValue.ToString();
            Orders = txtorder.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { surQuestion.ToString(), Orders.ToString(), Mandat.ToString(), user.ToString() };

            string Value = Obj.SaveData("sp_Merchandising", "AddAssetDetail", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            //grvRpt.DataSource = lstClaim;
            //grvRpt.DataBind();
        }
        protected void fillForm()
        {

            DataTable lstData = default(DataTable);
            lstData = Obj.loadList("Asset", "sp_Merchandising", ResponseID.ToString());
            if (lstData.Rows.Count > 0)
            {
                string Asset;
                Asset = lstData.Rows[0]["ast_Name"].ToString();
                //Number = lstData.Rows[0]["ast_ID"].ToString();
                labelqno.Text =  "/" + Asset;
            }
        }
        public void Route()
        {
            DataTable dt = Obj.loadList("selectTypeQ", "sp_Merchandising", ResponseID.ToString());
            ddlQtns.DataSource = dt;
            ddlQtns.DataTextField = "aqm_Questions";
            ddlQtns.DataValueField = "aqm_ID";
            ddlQtns.DataBind();
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            DataTable lstList = Obj.loadList("SelectAssetQuestionById", "sp_Merchandising", ResponseID.ToString());
            if (lstList.Rows.Count > 0)
            {
                pnls.Visible = true;
                grvRpt.DataSource = lstList;
            }
            else
            {
                pnls.Visible = false;
            }
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string delID = dataItem.GetDataKeyValue("asq_ID").ToString();
                ViewState["DeleteID"] = delID.ToString();

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }

        }
        public void Delete()
        {
            string dID = ViewState["DeleteID"].ToString();
            Obj.loadList("Delete", "sp_Merchandising", dID.ToString());
            DataTable lstDelete = Obj.loadList("SelectAssetQuestionByIDAfterDel", "sp_Merchandising", dID.ToString());
            if (lstDelete.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);
            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Delete();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}