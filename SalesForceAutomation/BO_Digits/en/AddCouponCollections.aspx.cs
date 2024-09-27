using Stimulsoft.Svg;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddCouponCollections : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                Coupon();
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRotForAddCoupon", "sp_CouponCollection");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        public void Coupon()
        {
            ddlCoupon.DataSource = ObjclsFrms.loadList("SelectCopForAddCoupon", "sp_CouponCollection");
            ddlCoupon.DataTextField = "cpm_Name";
            ddlCoupon.DataValueField = "cpm_ID";
            ddlCoupon.DataBind();
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CouponCollectionHeader.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }


        public void addTable()
        {
            string CouponID, Coupon, HigherQty, AdjHigherQty, FinalHigherQty, CopBookNum, ID;
            int id;

            DataTable dts;

            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("CouponID");
                dts.Columns.Add("Coupon");
                dts.Columns.Add("HigherQty");
                dts.Columns.Add("AdjHigherQty");
                dts.Columns.Add("FinalHigherQty");
                dts.Columns.Add("CopBookNum");
            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }

            id = GetNextId(dts); // Use a function to get the next unique ID

            ID = id.ToString();
            CouponID = ddlCoupon.SelectedValue.ToString();
            Coupon = ddlCoupon.SelectedItem.Text.ToString();
            HigherQty = txtHQty.Text.ToString();
            AdjHigherQty = "0";
            FinalHigherQty = txtHQty.Text.ToString();
            CopBookNum = txtHQty.Text.ToString();

        

            dts.Rows.Add(ID, CouponID, Coupon, HigherQty, AdjHigherQty, FinalHigherQty, CopBookNum);

            ViewState["DataTable"] = dts;

            BindGrid(dts); // Bind the updated DataTable to the grid
            ClearInputs();              // ClearInputs(); // Clear the input fields
            
        }


        private void BindGrid(DataTable dts)
        {
            grvrpt.DataSource = dts;
            grvrpt.DataBind();
        }


        private void ClearInputs()
        {
            ddlCoupon.ClearSelection();
            txtHQty.Text = string.Empty;
           // txtAdjHqty.Text = string.Empty;
           // txtBookNo.Text = string.Empty;
        }


        private int GetNextId(DataTable dataTable)
        {
            int nextId = 1;

            if (dataTable.Rows.Count > 0)
            {
                // Find the maximum ID in the DataTable and increment it
                nextId = dataTable.AsEnumerable().Max(row => int.Parse(row["ID"].ToString())) + 1;
            }

            return nextId;
        }

        protected void grvrpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void AddItem_Click(object sender, EventArgs e)
        {
            addTable();
        }

     
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("CouponCollectionHeader.aspx");
        }

        protected void SaveCoupon()
        {
            DataTable dt = (DataTable)ViewState["DataTable"];
            int x = dt.Rows.Count;

            string rotID = ddlRoute.SelectedValue.ToString();
            string userID = UICommon.GetCurrentUserID().ToString();

            DataSet dx = new DataSet();
            dx.Tables.Add(dt);
            string[] keys = { "@rotID", "@userID" };
            string[] values = { rotID.ToString(), userID.ToString() };
            string[] arr = { "@Items" };
            DataSet Value = ObjclsFrms.bulkUpdate(dx, arr, keys, values, "sp_Coupon");
            DataTable dts = Value.Tables[0];
            string res = dts.Rows[0]["Res"].ToString();

            if (res == "1")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Coupon Saved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }

        protected void save_Click1(object sender, EventArgs e)
        {
            SaveCoupon();
        }
    }

}