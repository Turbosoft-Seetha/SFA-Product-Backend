using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CollectionDetails : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["rdfromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                    ViewState["rdRoute"] = Session["rdRoute"].ToString();
                    Session["UdpDate"] = ViewState["rdfromDate"].ToString();
                    Session["UdpRoute"] = ViewState["rdRoute"].ToString();
                }
                catch(Exception ex) 
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                

                LoadDate();
                ARCollection();
                AdvanceCollection();
                SelCollectionReport();
            }
        }

        public DataTable LoadData(string mode,string Paymode)
        {
            Session["FromDate"] = ViewState["rdfromDate"].ToString();
            string route = ViewState["rdRoute"].ToString();
            string mainCondition = "";
            string PaymodeCond = "";


            
            if(Paymode != "D")
            {
                PaymodeCond = " and arh_PayMode='" + Paymode + "'";
            }
            else
            {
                PaymodeCond = " and arh_PayMode in('POS','CH','HC','OP')";
            }

            string fromDate = DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("yyyy-MM-dd");
            string dateCondition = " and (cast(B.CreatedDate as date) = cast('" + fromDate + "' as date)) ";

            mainCondition += dateCondition;
            mainCondition += PaymodeCond;

            string[] arr = new string[] { DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("yyyy-MM-dd"), mainCondition };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
            return dt;
        }

        public void LoadDate()
        {
            string route = ViewState["rdRoute"].ToString();
            string data = DateTime.Parse(ViewState["rdfromDate"].ToString()).ToString("dd MMM yyyy");
            DataTable datas = ObjclsFrms.loadList("SelKPIrot", "sp_KPI_Dashboard", route);
            string rot;
            rot = datas.Rows[0]["rot_Name"].ToString();
            lbldat.Text = data.ToString();
            lblroute.Text = rot.ToString();
        }
        public void ARCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAr = LoadData("SelectARCount","D");
            if (lstAr.Rows.Count > 0)
            {
                totalCount = lstAr.Rows[0]["TotalArCount"].ToString();
                totalAmount = lstAr.Rows[0]["TotalARAmount"].ToString();
                hcCount = lstAr.Rows[0]["AR_HC_Count"].ToString();
                hcAmount = lstAr.Rows[0]["AR_HC_Amount"].ToString();
                posCount = lstAr.Rows[0]["AR_POS_Count"].ToString();
                posAmount = lstAr.Rows[0]["AR_POS_Amount"].ToString();
                opCount = lstAr.Rows[0]["AR_OP_Count"].ToString();
                opAmount = lstAr.Rows[0]["AR_OP_Amount"].ToString();
                chequeCount = lstAr.Rows[0]["AR_Chq_Count"].ToString();
                chequeAmount = lstAr.Rows[0]["AR_Chq_Amount"].ToString();

                lblTotalArAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblArHcAmt.Text = hcAmount.ToString();
                lblArHcCount.Text = hcCount.ToString();
                lblArPosAmt.Text = posAmount.ToString();
                lblArPosCount.Text = posCount.ToString();
                lblArOpAmt.Text = opAmount.ToString();
                lblArOpCount.Text = opCount.ToString();
                lblArChequeAmt.Text = chequeAmount.ToString();
                lblArChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalArAmt.Text = "0 / 0.00";
                lblArHcAmt.Text = "0.00";
                lblArHcCount.Text = "0";
                lblArPosAmt.Text = "0.00";
                lblArPosCount.Text = "0";
                lblArOpAmt.Text = "0.00";
                lblArOpCount.Text = "0";
                lblArChequeAmt.Text = "0.00";
                lblArChequeCount.Text = "0";
            }
        }

        public void AdvanceCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAdvance = LoadData("SelectAdvanceCount","D");
            if (lstAdvance.Rows.Count > 0)
            {
                totalCount = lstAdvance.Rows[0]["TotalApCount"].ToString();
                totalAmount = lstAdvance.Rows[0]["TotalAPAmount"].ToString();
                hcCount = lstAdvance.Rows[0]["AP_HC_Count"].ToString();
                hcAmount = lstAdvance.Rows[0]["AP_HC_Amount"].ToString();
                posCount = lstAdvance.Rows[0]["AP_POS_Count"].ToString();
                posAmount = lstAdvance.Rows[0]["AP_POS_Amount"].ToString();
                opCount = lstAdvance.Rows[0]["AP_OP_Count"].ToString();
                opAmount = lstAdvance.Rows[0]["AP_OP_Amount"].ToString();
                chequeCount = lstAdvance.Rows[0]["AP_Chq_Count"].ToString();
                chequeAmount = lstAdvance.Rows[0]["AP_Chq_Amount"].ToString();

                lblTotalAdvAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblAdvHcAmt.Text = hcAmount.ToString();
                lblAdvHcCount.Text = hcCount.ToString();
                lblAdvPosAmt.Text = posAmount.ToString();
                lblAdvPosCount.Text = posCount.ToString();
                lblAdvOpAmt.Text = opAmount.ToString();
                lblAdvOpCount.Text = opCount.ToString();
                lblAdvChequeAmt.Text = chequeAmount.ToString();
                lblAdvChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalAdvAmt.Text = "0 / 0.00";
                lblAdvHcAmt.Text = "0.00";
                lblAdvHcCount.Text = "0";
                lblAdvPosAmt.Text = "0.00";
                lblAdvPosCount.Text = "0";
                lblAdvOpAmt.Text = "0.00";
                lblAdvOpCount.Text = "0";
                lblAdvChequeAmt.Text = "0.00";
                lblAdvChequeCount.Text = "0";
            }
        }

        public void SelCollectionReport()
        {
            DataTable dtARDetail = LoadData("SelAR_KPIDashboard_Detail", "D");
            rptARCollection.DataSource = dtARDetail;
            rptARCollection.DataBind();

            DataTable dtAPDetail = LoadData("SelAP_KPIDashboard_Detail", "D");
            rptAdvCollection.DataSource = dtAPDetail;
            rptAdvCollection.DataBind();

        }

        protected void lnkHC_Click(object sender, EventArgs e)
        {
            DataTable dtARDetail = LoadData("SelAR_KPIDashboard_Detail", "HC");
            rptARCollection.DataSource = dtARDetail;
            rptARCollection.DataBind();
        }

        protected void lnkPOS_Click(object sender, EventArgs e)
        {
            DataTable dtARDetail = LoadData("SelAR_KPIDashboard_Detail", "POS");
            rptARCollection.DataSource = dtARDetail;
            rptARCollection.DataBind();
        }

        protected void LnkOnline_Click(object sender, EventArgs e)
        {
            DataTable dtARDetail = LoadData("SelAR_KPIDashboard_Detail", "OP");
            rptARCollection.DataSource = dtARDetail;
            rptARCollection.DataBind();
        }

        protected void LnkCheque_Click(object sender, EventArgs e)
        {
            DataTable dtARDetail = LoadData("SelAR_KPIDashboard_Detail", "CH");
            rptARCollection.DataSource = dtARDetail;
            rptARCollection.DataBind();
        }

        protected void LnkADHC_Click(object sender, EventArgs e)
        {

        }
    }
}