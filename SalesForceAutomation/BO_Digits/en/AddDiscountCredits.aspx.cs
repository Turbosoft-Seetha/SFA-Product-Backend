using SalesForceAutomation;
using SalesForceAutomation.BO_Digits;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddDiscountCredits : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Customers();
            }
        }

        public void Customers()
        {
            DataTable dt = ObjclsFrms.loadList("SelectCustomer", "sp_CreditNote");
            ddlCustomer.DataSource = dt;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }

        public void LoadData()
        {
            string[] arr = { DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd") };
            DataTable dt = ObjclsFrms.loadList("SelCusNoCreditMonthInv", "sp_CreditNote", ddlCustomer.SelectedValue.ToString(), arr);
            grvRpt.DataSource = dt;
            grvRpt.DataBind();
        }

        protected void lnkConfirm_Click(object sender, EventArgs e)
        {
            if (grvRpt.MasterTableView.Items.Count > 0)
            {
                string[] arrs = { DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd") };
                DataTable lstTotAmt = ObjclsFrms.loadList("SelectTotalInvAmtForDisCred", "sp_CreditNote", ddlCustomer.SelectedValue.ToString(), arrs);
                if(lstTotAmt.Rows.Count > 0)
                {
                    double totalAmount = double.Parse(lstTotAmt.Rows[0]["TotalInvAmt"].ToString());
                    double minAmount = double.Parse(txtAmount.Text.ToString());
                    if(totalAmount > minAmount)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SaveAlert();</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Total invoice amount should always be greater then minimum amount in order to claim discount');</script>", false);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Already discount has been processed for all the invoices in this month for this customer');</script>", false);
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dt = ObjclsFrms.loadList("SelCusNoCreditMonthInv", "sp_CreditNote");
            grvRpt.DataSource = dt;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        public void Save()
        {


            string[] arr = { txtDiscount.Text.ToString(), UICommon.GetCurrentUserID().ToString(), DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd") }; //para8
            DataTable dtRes = ObjclsFrms.loadList("InsertDicsountCredit", "sp_CreditNote", ddlCustomer.SelectedValue.ToString(), arr);

            try
            {
                if (dtRes.Rows.Count > 0)
                {
                    string lst = dtRes.Rows[0]["res"].ToString();
                    int resp = Int32.Parse(lst);
                    if (resp > 0)
                    {
                        string clrID = dtRes.Rows[0]["seqNum"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SaveSuccess('" + clrID + "');</script>", false);
                    }
                    else
                    {
                        string remarks = dtRes.Rows[0]["remarks"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Error in submitting the data, please try again /n" + remarks + "' );</script>", false);
                        btnSave.Enabled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('We are facing some technical issues, please try again later');</script>", false);
                btnSave.Enabled = true;
            }
        }

        protected void btnReqSuccess_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDiscountCredits.aspx");
        }

        protected void rdMonth_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string[] arr = { DateTime.Parse(rdMonth.SelectedDate.ToString()).ToString("yyyyMMdd") };
            DataTable dt = ObjclsFrms.loadList("SelCusMonthDiscount", "sp_CreditNote", ddlCustomer.SelectedValue.ToString(), arr);
            if (dt.Rows.Count > 0)
            {
                txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                txtAmount.Text = dt.Rows[0]["Amt"].ToString();
                LoadData();
            }
            else
            {
                rdMonth.SelectedDate = null;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Discount is not configured for this customer, please check the discount master');</script>", false);
                return;
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDiscountCredits.aspx");
        }
    }
}