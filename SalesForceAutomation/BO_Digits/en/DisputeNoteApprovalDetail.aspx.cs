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
    public partial class DisputeNoteApprovalDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["drhID"], out ResponseID);
                return ResponseID;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                HeaderData();

            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListDispNoteApprovalHeaderbyID", "sp_DisputeNoteRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblAmount = (Label)rp.FindControl("lblAMount");

                rp.Text = "Request ID: " + lstDatas.Rows[0]["drh_TransID"].ToString();
                lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblAmount.Text= lstDatas.Rows[0]["drh_Amount"].ToString();

                string status = lstDatas.Rows[0]["Status"].ToString();
                LinkButton lnkReject = (LinkButton)rdd.FindControl("lnkReject");
                LinkButton lnkApprove = (LinkButton)rdd.FindControl("lnkApprove");

                if ((status == "P") || (status == " "))
                {
                    lnkReject.Visible = true;
                    lnkApprove.Visible = true;

                }
                else
                {
                    lnkReject.Visible = false;
                    lnkApprove.Visible = false;
                }

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("LisDisputeReqApprovalDetail", "sp_DisputeNoteRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstDatas;
                ViewState["dd"] = lstDatas;
            }

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
        protected void lnkReject_Click(object sender, EventArgs e)
        {

           
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

           


        }

        protected void lnkApprove_Click(object sender, EventArgs e)
        {


            DataTable lstApprovalLevel = ObjclsFrms.loadList("SelectUserLevelforDisputeApproval", "sp_DisputeNoteRequest", UICommon.GetCurrentUserID().ToString());
            if (lstApprovalLevel.Rows.Count > 0)
            {
                int currentLevel, nextLevel;
                currentLevel = Int32.Parse(lstApprovalLevel.Rows[0]["CurrentLevel"].ToString());
                nextLevel = Int32.Parse(lstApprovalLevel.Rows[0]["NextLevel"].ToString());
                ViewState["currentLevel"] = currentLevel.ToString();
                ViewState["nextLevel"] = nextLevel.ToString();
                if (nextLevel == 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('You are the final approver,Do you want to continue?');</script>", false);
                }
                else if (nextLevel > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('The Approval request will go to the next level user, Do you want to continue?');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

                }
            }


        }
        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string remark = this.txtRemarks.Text.ToString();
            string nectlvl = ViewState["nextLevel"].ToString();
            string[] arr = { user, nectlvl,remark };
            string Value = ObjclsFrms.SaveData("sp_DisputeNoteRequest", "ApproveDisputeRequest", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Approved Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }



        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("DisputeNotReqApprovalHeader.aspx");

        }
        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
                    // Access the data key
                    string user = UICommon.GetCurrentUserID().ToString();
                    string remark = this.txtRejRem.Text.ToString();//
                    string[] arr = { user,remark };
                    string drhid = ResponseID.ToString();

                    string Value = ObjclsFrms.SaveData("sp_DisputeNoteRequest", "RejectDisputeRequest", drhid.ToString(), arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
                    }

                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                    }
               
            

        }
    }
}