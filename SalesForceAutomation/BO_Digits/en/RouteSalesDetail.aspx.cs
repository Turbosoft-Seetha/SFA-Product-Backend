using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteSalesDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["FromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                    ViewState["route"] = Session["rdRoute"].ToString();
                    Session["UdpDate"] = ViewState["FromDate"].ToString();
                    Session["UdpRoute"] = ViewState["route"].ToString();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }


                LoadDate();
                //SelLoads();
                TotalInvoices();
                 TotalInvoiceAmount();
                SelSalesDetail();
                SelGRDetail();
                SelBRDetail();
                SelFOCDetail();
            }
        }


        public DataTable LoadData(string mode)
        {

            string[] arr = new string[] { DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);

            return dt;
        }
        public void LoadDate()
        {
            string route = ViewState["route"].ToString();
            string data = DateTime.Parse(ViewState["FromDate"].ToString()).ToString("dd MMM yyyy");
            DataTable datas = ObjclsFrms.loadList("SelKPIrot", "sp_KPI_Dashboard", route);
            string rot;
            rot = datas.Rows[0]["rot_Name"].ToString();
            lbldat.Text = data.ToString();
            lblroute.Text = rot.ToString();
        }
        //public void SelLoads()
        //{
        //    DataTable dt = LoadData("SelLICountSplit");
        //    DataTable dt1 = LoadData("SelLiCount");
        //    DataTable dts = LoadData("SelLICountSplits");

        //    string para1 = dt1.Rows[0][0].ToString();



        //   // lblLoadIn.Text = para1.ToString();
        //    lblLICompleted.Text = dts.Rows[0]["LICompleted"].ToString();
        //    lblLIPending.Text = dts.Rows[0]["LIPending"].ToString();
        //    lblLINotProcss.Text = dts.Rows[0]["LINotProcessed"].ToString();
        //    lblLIRejected.Text = dts.Rows[0]["LIRejected"].ToString();
        //    SelLoadInDetail();
        //    SelLoadInPendingDetail();
        //    SelLoadInNotProDetail();
        //    SelLoadInRejected();
        //}
        //public void SelLoadInDetail()
        //{
        //    DataTable dt = LoadData("SelLoadInDetailKPI");
        //    rptLoadIn.DataSource = dt;
        //    rptLoadIn.DataBind();


        //}
        //public void SelLoadInPendingDetail()
        //{
        //    DataTable dt = LoadData("SelLoadInPendingDetailKPI");
        //    rptLoadInPending.DataSource = dt;
        //    rptLoadInPending.DataBind();

        //}
        //public void SelLoadInNotProDetail()
        //{
        //    DataTable dt = LoadData("SelLoadInNotProcDetailKPI");
        //    rptLoadInNotProc.DataSource = dt;
        //    rptLoadInNotProc.DataBind();

        //}
        //public void SelLoadInRejected()
        //{
        //    DataTable dt = LoadData("SelLoadInRejected");
        //    rptLIRejected.DataSource = dt;
        //    rptLIRejected.DataBind();

        //}
        public void TotalInvoices()
        {
            DataTable dtInvoices = LoadData("SelectTotalInvoice");
            int sales, gr, br, foc, invoices;
            sales = Int32.Parse(dtInvoices.Rows[0]["Sales"].ToString());
            gr = Int32.Parse(dtInvoices.Rows[0]["GoodReturn"].ToString());
            br = Int32.Parse(dtInvoices.Rows[0]["BadReturn"].ToString());
            foc = Int32.Parse(dtInvoices.Rows[0]["FreeCost"].ToString());
            invoices = Int32.Parse(dtInvoices.Rows[0]["Invoices"].ToString());
            lblSalesCount.Text = sales.ToString();
            lblGRCount.Text = gr.ToString();
            lblBRCount.Text = br.ToString();
            lblFCcount.Text = foc.ToString();
            lblTotalInvoices.Text = invoices.ToString();
        }
        public void TotalInvoiceAmount()
        {
            string totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, creditCount, creditAmount;
            DataTable lstInvoice = LoadData("SelectTotalInvoiceCollection");
            if (lstInvoice.Rows.Count > 0)
            {
                totalAmount = lstInvoice.Rows[0]["TotalInvAmount"].ToString();
                hcCount = lstInvoice.Rows[0]["HC_Count"].ToString();
                hcAmount = lstInvoice.Rows[0]["HC_Amount"].ToString();
                posCount = lstInvoice.Rows[0]["POS_Count"].ToString();
                posAmount = lstInvoice.Rows[0]["POS_Amount"].ToString();
                opCount = lstInvoice.Rows[0]["OP_Count"].ToString();
                opAmount = lstInvoice.Rows[0]["OP_Amount"].ToString();
                creditCount = lstInvoice.Rows[0]["CR_Count"].ToString();
                creditAmount = lstInvoice.Rows[0]["CR_Amount"].ToString();

                lblTotalInvAmt.Text = totalAmount.ToString();
                lblArHcAmt.Text = hcAmount.ToString();
                lblArHcCount.Text = hcCount.ToString();
                lblArPosAmt.Text = posAmount.ToString();
                lblArPosCount.Text = posCount.ToString();
                lblArOpAmt.Text = opAmount.ToString();
                lblArOpCount.Text = opCount.ToString();
                lblArChequeAmt.Text = creditAmount.ToString();
                lblArChequeCount.Text = creditCount.ToString();
            }
            else
            {
                lblTotalInvAmt.Text = "0 / 0.00";
                lblArHcAmt.Text = "0.00";
                lblGRCount.Text = "0";
                lblArPosAmt.Text = "0.00";
                lblArPosCount.Text = "0";
                lblArOpAmt.Text = "0.00";
                lblArOpCount.Text = "0";
                lblArChequeAmt.Text = "0.00";
                lblArChequeCount.Text = "0";
            }
        }
        public void SelSalesDetail()
        {
            DataTable dt = LoadData("Selectsales_kpidashboard_detail");
            rptSalesDetail.DataSource = dt;
            rptSalesDetail.DataBind();

        }
        public void SelGRDetail()
        {
            DataTable dt = LoadData("SelGD_kpidashboard_detail");
            rptGRDetail.DataSource = dt;
            rptGRDetail.DataBind();

        }
        public void SelBRDetail()
        {
            DataTable dt = LoadData("SelBD_kpidashboard_detail");
            rptBRDetail.DataSource = dt;
            rptBRDetail.DataBind();

        }
        public void SelFOCDetail()
        {
            DataTable dt = LoadData("SelFOC_kpidashboard_detail");
            rptFOCDetail.DataSource = dt;
            rptFOCDetail.DataBind();

        }




    }
}