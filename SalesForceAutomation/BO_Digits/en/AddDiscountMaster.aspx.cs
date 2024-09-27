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
    public partial class AddDiscountMaster : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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
                Customer();
            }
        }

        public void Customer()
        {
            DataTable dt = ObjclsFrms.loadList("SelCustomer", "sp_CreditNote");
            ddlCustomer.DataSource = dt;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }

        protected void Save()
        {
            string customer, month, percentage, amount, user;
            customer = ddlCustomer.SelectedValue.ToString();
            month = DateTime.Parse(mdpMonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            percentage = txtDiscount.Text.ToString();
            amount = txtAmount.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arrs = { month.ToString() };
                DataTable lstCusMont = ObjclsFrms.loadList("SelCusMontDisCount", "sp_CreditNote", customer.ToString(), arrs);
                if (lstCusMont.Rows.Count > 0)
                {
                    int number = Int32.Parse(lstCusMont.Rows[0]["number"].ToString());
                    if (number > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Already assigned a discount for the selected customer in the selected month');</script>", false);
                    }
                    else
                    {
                        string[] arr = { percentage.ToString(), month.ToString(), amount.ToString(), user.ToString() };
                        string Value = ObjclsFrms.SaveData("sp_CreditNote", "InsertDiscount", customer.ToString(), arr);
                        int res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Discount Saved Successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }
                }
            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDiscountMaster.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDiscountMaster.aspx");
        }
    }
}