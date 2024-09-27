using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MonthlyTargetDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int tphID
        {
            get
            {
                int tphID;
                int.TryParse(Request.Params["ID"], out tphID);

                return tphID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
				try
				{
					ViewState["date"] = DateTime.Parse(Session["FromDate"].ToString());
					ViewState["route"] = Session["rdRoute"].ToString();
					Session["UdpDate"] = ViewState["date"].ToString();
					Session["UdpRoute"] = ViewState["route"].ToString();
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}				
                DetailHeader();
                ProductDetail();
                DateHeader();
            }
        }

        public void DateHeader()
        {
            string fdate = DateTime.Parse(ViewState["date"].ToString()).ToString("dd MMM yyyy");
            lblDate.Text = fdate.ToString();
            DataTable lstUser = default(DataTable);

            lstUser = ObjclsFrms.loadList("SelectRouteName", "sp_Merchandising", ViewState["route"].ToString());
            if (lstUser.Rows.Count > 0)
            {
                string name = lstUser.Rows[0]["rot_Name"].ToString();
                lblRoute.Text = name.ToString();
            }
        }
        public void DetailHeader()
        {
            string AchAmount, AchAmountPerc, RemainAmount, RemainAmountPerc, AchQty, AchQtyPerc, RemainQty, RemainQtyPerc;
            DataTable dtMonthlyTargetDetail = new DataTable();

            string[] ar = { ViewState["route"].ToString() ,tphID.ToString()};
            string fromdate = ViewState["date"].ToString();
            dtMonthlyTargetDetail = ObjclsFrms.loadList("SelMonthlyItemDetailHeader", "sp_KPI_Dashboard", fromdate, ar);
            if (dtMonthlyTargetDetail.Rows.Count > 0)
            {
                lblPackagenumber.Text = dtMonthlyTargetDetail.Rows[0]["tph_Number"].ToString();
                lblOverTargetAmt.Text = dtMonthlyTargetDetail.Rows[0]["TargetAmount"].ToString();
                lblOverTargetQty.Text = dtMonthlyTargetDetail.Rows[0]["TargetQty"].ToString();
                AchAmount = dtMonthlyTargetDetail.Rows[0]["AchievedAmount"].ToString();
                AchAmountPerc = dtMonthlyTargetDetail.Rows[0]["AmountPerc"].ToString();
                RemainAmount = dtMonthlyTargetDetail.Rows[0]["RemAmount"].ToString();
                RemainAmountPerc = dtMonthlyTargetDetail.Rows[0]["RemAmountPerc"].ToString();
                AchQty = dtMonthlyTargetDetail.Rows[0]["AchievedQty"].ToString();
                AchQtyPerc = dtMonthlyTargetDetail.Rows[0]["QtyPerc"].ToString();
                RemainQty = dtMonthlyTargetDetail.Rows[0]["RemQty"].ToString();
                RemainQtyPerc = dtMonthlyTargetDetail.Rows[0]["RemQtyPerc"].ToString();



                lblAchievedAmt.Text = AchAmount + "/" + AchAmountPerc + "%";

                lblRemainingAmt.Text = RemainAmount + "/" + RemainAmountPerc + "%";

                lblAchievedQty.Text = AchQty + "/" + AchQtyPerc + "%";

                lblRemainQty.Text = RemainQty + "/" + RemainQtyPerc + "%";
            }
        }
        public void ProductDetail()
        {
            DataTable dtProductDetail = new DataTable();
            dtProductDetail = ObjclsFrms.loadList("SelPackageDetails", "sp_KPI_Dashboard", tphID.ToString());
            rptProduct.DataSource = dtProductDetail;
            rptProduct.DataBind();


        }
    }
}