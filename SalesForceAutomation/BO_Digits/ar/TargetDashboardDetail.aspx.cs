using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class TargetDashboardDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                ViewState["date"] = DateTime.Parse(Session["FromDate"].ToString());
                ViewState["route"] = Session["rdRoute"].ToString();
                Session["UdpDate"] = ViewState["date"].ToString();
                Session["UdpRoute"] = ViewState["route"].ToString();

                DailyTargetHeader();
                DailyTargetDetail();
                MonthlyTargetHeader();
                MonthlyTargetDetail();
                Heading();
            }
        }
        public void Heading()
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
        public void DailyTargetHeader()
        {
            string AchAmount, AchAmountPerc, RemainAmount, RemainAmountPerc, AchQty, AchQtyPerc, RemainQty, RemainQtyPerc;
            DataTable dtDailyTargetHeader = new DataTable();
            string[] ar = { ViewState["route"].ToString() };
            string fromdate = ViewState["date"].ToString();
            dtDailyTargetHeader = ObjclsFrms.loadList("selPackSummHeadDaily", "sp_KPI_Dashboard", fromdate, ar);
            if (dtDailyTargetHeader != null)
            {


                if (dtDailyTargetHeader.Rows.Count > 0)
                {
                    lblOverTargetAmt.Text = dtDailyTargetHeader.Rows[0]["TargetAmount"].ToString();
                    lblOverTargetQty.Text = dtDailyTargetHeader.Rows[0]["TargetQty"].ToString();
                    AchAmount = dtDailyTargetHeader.Rows[0]["AchievedAmount"].ToString();
                    AchAmountPerc = dtDailyTargetHeader.Rows[0]["AmountPerc"].ToString();
                    RemainAmount = dtDailyTargetHeader.Rows[0]["RemAmount"].ToString();
                    RemainAmountPerc = dtDailyTargetHeader.Rows[0]["RemAmountPerc"].ToString();
                    AchQty = dtDailyTargetHeader.Rows[0]["AchievedQty"].ToString();
                    AchQtyPerc = dtDailyTargetHeader.Rows[0]["QtyPerc"].ToString();
                    RemainQty = dtDailyTargetHeader.Rows[0]["RemQty"].ToString();
                    RemainQtyPerc = dtDailyTargetHeader.Rows[0]["RemQtyPerc"].ToString();



                    lblAchievedAmt.Text = AchAmount + "/" + AchAmountPerc + "%";

                    lblRemainingAmt.Text = RemainAmount + "/" + RemainAmountPerc + "%";

                    lblAchievedQty.Text = AchQty + "/" + AchQtyPerc + "%";

                    lblRemainQty.Text = RemainQty + "/" + RemainQtyPerc + "%";
                }
            }

        }
        public void DailyTargetDetail()
        {
            DataTable dtDailyTargetDetail = new DataTable();
            string[] ar = { ViewState["route"].ToString() };
            string fromdate = ViewState["date"].ToString();
            dtDailyTargetDetail = ObjclsFrms.loadList("SelDailyPackageWiseSumm", "sp_KPI_Dashboard", fromdate, ar);

            rptpackage.DataSource = dtDailyTargetDetail;
            rptpackage.DataBind();


        }
        public void MonthlyTargetHeader()
        {
            string AchAmount, AchAmountPerc, RemainAmount, RemainAmountPerc, AchQty, AchQtyPerc, RemainQty, RemainQtyPerc;
            DataTable dtMonthlyTargetHeader = new DataTable();

            string[] ar = { ViewState["route"].ToString() };
            string fromdate = ViewState["date"].ToString();
            dtMonthlyTargetHeader = ObjclsFrms.loadList("selPackSummHeadMonth", "sp_KPI_Dashboard", fromdate, ar);
            if (dtMonthlyTargetHeader.Rows.Count > 0)
            {
                lblMonthTargetAmt.Text = dtMonthlyTargetHeader.Rows[0]["TargetAmount"].ToString();
                lblMonthTargetQty.Text = dtMonthlyTargetHeader.Rows[0]["TargetQty"].ToString();
                AchAmount = dtMonthlyTargetHeader.Rows[0]["AchievedAmount"].ToString();
                AchAmountPerc = dtMonthlyTargetHeader.Rows[0]["AmountPerc"].ToString();
                RemainAmount = dtMonthlyTargetHeader.Rows[0]["RemAmount"].ToString();
                RemainAmountPerc = dtMonthlyTargetHeader.Rows[0]["RemAmountPerc"].ToString();
                AchQty = dtMonthlyTargetHeader.Rows[0]["AchievedQty"].ToString();
                AchQtyPerc = dtMonthlyTargetHeader.Rows[0]["QtyPerc"].ToString();
                RemainQty = dtMonthlyTargetHeader.Rows[0]["RemQty"].ToString();
                RemainQtyPerc = dtMonthlyTargetHeader.Rows[0]["RemQtyPerc"].ToString();



                lblMonthAchievedAmt.Text = AchAmount + "/" + AchAmountPerc + "%";

                lblMonthRemainAmt.Text = RemainAmount + "/" + RemainAmountPerc + "%";

                lblMonthAchievedQty.Text = AchQty + "/" + AchQtyPerc + "%";

                lblMonthRemainQty.Text = RemainQty + "/" + RemainQtyPerc + "%";
            }
        }
        public void MonthlyTargetDetail()
        {
            DataTable dtMonthlyTargetDetail = new DataTable();
            string[] ar = { ViewState["route"].ToString() };
            string fromdate = ViewState["date"].ToString();
            dtMonthlyTargetDetail = ObjclsFrms.loadList("SelPackageWiseSumm", "sp_KPI_Dashboard", fromdate, ar);
            rptMonthPackage.DataSource = dtMonthlyTargetDetail;
            rptMonthPackage.DataBind();
        }



        protected void btnItemDetail_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton DailyTphID = (ImageButton)sender;
            string tphID = DailyTphID.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/DetailOfTargetDetail.aspx?ID=" + tphID);

        }

        protected void btnMonthlyProduct_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton MonthlyTphID = (ImageButton)sender;
            string tphID = MonthlyTphID.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/ar/MonthlyTargetDetail.aspx?ID=" + tphID);


        }
    }
}