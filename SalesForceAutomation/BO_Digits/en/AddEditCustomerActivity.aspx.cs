using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerActivity : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdFromDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                rdEndDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                Route();
                FillForm();

            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        public void Route()
        {
            ddlrot.DataSource = ObjclsFrms.loadList("SelRoute", "sp_Masters");
            ddlrot.DataTextField = "rot_Name";
            ddlrot.DataValueField = "rot_ID";
            ddlrot.DataBind();
        }
        public void Customer()
        {
            ddlCustomers.DataSource = ObjclsFrms.loadList("SelCustomerfordropdown", "sp_Masters");
            ddlCustomers.DataTextField = "cus_Name";
            ddlCustomers.DataValueField = "cus_ID";
            ddlCustomers.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelCusActivityByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, desc, startdate, enddate,  cus, rot;
                // code = lstDatas.Rows[0]["cah_Code"].ToString();
                name = lstDatas.Rows[0]["cah_Name"].ToString();
                desc = lstDatas.Rows[0]["cah_Description"].ToString();
                startdate = lstDatas.Rows[0]["cah_StartDate"].ToString();
                enddate = lstDatas.Rows[0]["cah_EndDate"].ToString();
               // status = lstDatas.Rows[0]["Status"].ToString();
                cus = lstDatas.Rows[0]["cah_cus_ID"].ToString();
                rot = lstDatas.Rows[0]["cah_rot_ID"].ToString();
                //txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                txtDesc.Text = desc.ToString();
                rdFromDate.SelectedDate = DateTime.Parse(startdate.ToString());
                rdEndDate.SelectedDate = DateTime.Parse(enddate.ToString());
               // ddlStatus.SelectedValue = status.ToString();
                ddlCustomers.SelectedValue = cus.ToString();
                ddlrot.SelectedValue = rot.ToString();

            }
        }

        protected void Save()
        {
            string name, desc, startdate, enddate, user,  cus, rot;

            name = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            desc = txtDesc.Text.ToString();
            startdate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //status = ddlStatus.SelectedValue.ToString();
            cus = ddlCustomers.SelectedValue.ToString();
            rot = ddlrot.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { desc, startdate, enddate, user,  cus, rot };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCusActivity", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name, desc, startdate, enddate, user,  cus, rot };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCusActivity", id, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivity.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivity.aspx");
        }

        protected void ddlrot_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }
    }
}