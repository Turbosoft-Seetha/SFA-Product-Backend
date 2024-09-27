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
    public partial class AddSurveyDetail : System.Web.UI.Page
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
                Questions();
            }
        }
        protected void fillForm()
        {

            DataTable lstData = default(DataTable);
            lstData = Obj.loadList("SelectSurveyMasterById", "sp_Merchandising", ResponseID.ToString());
            if (lstData.Rows.Count > 0)
            {
                string Survey, Number;

                Survey = lstData.Rows[0]["srm_Name"].ToString();

                Number = lstData.Rows[0]["srm_Number"].ToString();

                labelqno.Text = Number + "/" + Survey;
            }


        }
        public void Questions()
        {
            DataTable dt = Obj.loadList("SelectQuestions", "sp_Merchandising", ResponseID.ToString());
            ddlQtns.DataSource = dt;
            ddlQtns.DataTextField = "qsm_Question";
            ddlQtns.DataValueField = "qsm_ID";
            ddlQtns.DataBind();
        }
        protected void Save()
        {
            string surQuestion, Mandat, Orders, user;
            surQuestion = ddlQtns.SelectedValue.ToString();
            Mandat = ddlMandat.SelectedValue.ToString();
            Orders = txtorder.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { surQuestion.ToString(), Mandat.ToString(), Orders.ToString(), user.ToString() };
            string Value = Obj.SaveData("sp_Merchandising", "AddSurveyDetail", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
            }
            //grvRpt.DataSource = lstClaim;
            //grvRpt.DataBind();
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            lstDatas = Obj.loadList("SelectSurveyDetailsById", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                grvRpt.DataSource = lstDatas;
                pnls.Visible = true;
            }
            else
            {
                pnls.Visible = false;
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string delID = dataItem.GetDataKeyValue("smd_ID").ToString();
                ViewState["DeleteID"] = delID.ToString();

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
        }
        public void Delete()
        {
            string dID = ViewState["DeleteID"].ToString();
            Obj.loadList("Deletesmd", "sp_Merchandising", dID.ToString());
            grvRpt.DataBind();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddSurveyDetail.aspx?Id=" + ResponseID.ToString());
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Delete();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}