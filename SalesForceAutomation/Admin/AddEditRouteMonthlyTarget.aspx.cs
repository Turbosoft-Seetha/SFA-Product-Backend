using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SalesForceAutomation.Admin
{
    public partial class AddEditRouteMonthlyTarget : System.Web.UI.Page
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
                Target();
                


              
            }
        }
        public void SaveData()
        {
            string Route, Target, mnth, Qty, Amount, Status;

            Route = ddlrot.SelectedValue.ToString();
            Target = ddlTarget.SelectedValue.ToString();
            mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            Qty = txtQuantity.Text.ToString();
            Amount = txtAmount.Text.ToString();
            //StartDate =  DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //EndDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //  user = UICommon.GetCurrentUserID().ToString();
            Status = ddlStat.SelectedValue.ToString();




            // string[] arr = { Target, StartDate, EndDate, Status };
            string[] arr = { Target, mnth, Qty, Amount, Status };
            string Value = ob.SaveData("sp_Target", "InsertMonthlyTargets", Route, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Monthly Target has been saved sucessfully');</script>", false);
            }
            else if (res == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }




        }
        public void Route()
        {
            DataTable dt = ob.loadList("SelectRouteForTarget", "sp_Target");
            ddlrot.DataSource = dt;
            ddlrot.DataTextField = "rot_Name";
            ddlrot.DataValueField = "rot_ID";
            ddlrot.DataBind();
        }
        public void Target()
        {
            DataTable dt = ob.loadList("SelectTarget", "sp_Target");
            ddlTarget.DataSource = dt;
            ddlTarget.DataTextField = "tph_Name";
            ddlTarget.DataValueField = "tph_ID";
            ddlTarget.DataBind();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        
        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e )
        {
            Response.Redirect("/Admin/RouteMonthlyTarget.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/RouteMonthlyTarget.aspx");

        }

        

        protected void ddlTarget_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            ListTPH(); 
            
        }
        public void ListTPH()
        {
            DataTable lstdata = ob.loadList("selTargetPackageDetail", "sp_Target", ddlTarget.SelectedValue.ToString());
            if (lstdata.Rows.Count > 0)
            {

                RadGrid1.DataSource = lstdata;
                RadGrid1.DataBind();
                pnls.Visible = true;
            }
           
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListTPH();
        }

        protected void radmonth_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { mnth };
            DataTable lstdata = ob.loadList("selPackageWorkingDays", "sp_Target", ddlrot.SelectedValue.ToString(), arr);
            if (lstdata.Rows.Count > 0)
            {
                string Route = lstdata.Rows[0]["rmd_WorkingDays"].ToString();
                txtworkdays.Text = Route.ToString();
            }
        }
    }
}