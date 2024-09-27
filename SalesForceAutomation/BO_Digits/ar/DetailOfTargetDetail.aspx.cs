using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class DetailOfTargetDetail : System.Web.UI.Page
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

                ViewState["date"] = DateTime.Parse(Session["FromDate"].ToString());
                ViewState["route"] = Session["rdRoute"].ToString();
                Session["UdpDate"] = ViewState["date"].ToString();
                Session["UdpRoute"] = ViewState["route"].ToString();
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

            DataTable dtDailyTargetDetail = new DataTable();
            string[] ar = { ViewState["route"].ToString(), tphID.ToString() };
            string fromdate = ViewState["date"].ToString();
            dtDailyTargetDetail = ObjclsFrms.loadList("SelDailyItemDetailHeader", "sp_KPI_Dashboard", fromdate, ar);
            if (dtDailyTargetDetail.Rows.Count > 0)
            {
                lblPackagenumber.Text = dtDailyTargetDetail.Rows[0]["tph_Number"].ToString();
                lblOverTargetAmt.Text = dtDailyTargetDetail.Rows[0]["TargetAmount"].ToString();
                lblOverTargetQty.Text = dtDailyTargetDetail.Rows[0]["TargetQty"].ToString();
                AchAmount = dtDailyTargetDetail.Rows[0]["AchievedAmount"].ToString();
                AchAmountPerc = dtDailyTargetDetail.Rows[0]["AmountPerc"].ToString();
                RemainAmount = dtDailyTargetDetail.Rows[0]["RemAmount"].ToString();
                RemainAmountPerc = dtDailyTargetDetail.Rows[0]["RemAmountPerc"].ToString();
                AchQty = dtDailyTargetDetail.Rows[0]["AchievedQty"].ToString();
                AchQtyPerc = dtDailyTargetDetail.Rows[0]["QtyPerc"].ToString();
                RemainQty = dtDailyTargetDetail.Rows[0]["RemQty"].ToString();
                RemainQtyPerc = dtDailyTargetDetail.Rows[0]["RemQtyPerc"].ToString();



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