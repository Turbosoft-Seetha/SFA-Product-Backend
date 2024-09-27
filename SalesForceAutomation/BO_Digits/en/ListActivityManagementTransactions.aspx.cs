using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListActivityManagementTransactions : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int UID
        {
            get
            {
                int UID;
                int.TryParse(Request.Params["id"], out UID);
                return UID;
            }
        }
        public int cseID
        {
            get
            {
                int cseID;
                int.TryParse(Request.Params["CseID"], out cseID);
                return cseID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {



                cusVisits();

                if (!cseID.ToString().Equals("0"))
                {
                    code.Visible = false;
                    cus.Visible = true;



                }
                HeaderData();
                MerchCount();
                LoadRoute();
                lblActMangmnt.Text = Session["CO_MGMTACT_NAME"].ToString();
            }
        }
        public void LoadRoute()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", UID.ToString());
            //if (lstDatas.Rows.Count > 0)
            //{
            rptRoute.DataSource = lstDatas;
            rptRoute.DataBind();
            //}
        }

        public void cusVisits()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelCustomerVisitCount", "sp_Merchandising", UID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                lblTotalVisits.Text = lstDatas.Rows[0]["cusvisits"].ToString();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", UID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                //Label lblRoute = (Label)rp.FindControl("lblRoute");
                // Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                Label lblProcess = (Label)rp.FindControl("lblProcess");

                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblDuration.Text = lstDatas.Rows[0]["Duration"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
                //lblrotname.Text = lstDatas.Rows[0]["routeName"].ToString();               
                lblProcess.Text = lstDatas.Rows[0]["Process"].ToString();

            }
        }
        public void MerchCount()
        {
            try
            {
                //string Cusid = Session["CusId"].ToString();


                string startExitId = "";
                if (Session["CusStartExitId"] == null)
                {
                    startExitId = "";
                    ViewState["cse_ID"] = "0";
                }
                else
                {
                    startExitId = Session["CusStartExitId"].ToString();
                    ViewState["cse_ID"] = startExitId.ToString();
                }


                DataTable dt = new DataTable();
                string cse = "";
                if (cseID.ToString().Equals("0"))
                {
                    cse = "";
                }
                else
                {
                    cse = cseID.ToString();
                }
                string[] arr = { cse.ToString() };
                dt = ObjclsFrms.loadList("SelMerchTransactionCounts", "sp_Merchandising", UID.ToString(), arr);
                if (dt.Rows.Count > 0)
                {
                  
                    lblTotalCompetitorActivity.Text = dt.Rows[0]["CompetitorActivityCount"].ToString();
                  //  lblTotalAssetTracking.Text = dt.Rows[0]["AssetCount"].ToString();

                    lblTotalSurvey.Text = dt.Rows[0]["SurveyCount"].ToString();
                    lblTotalTasks.Text = dt.Rows[0]["TaskCount"].ToString();
                    lblTotalOutofStock.Text = dt.Rows[0]["OutofStockCount"].ToString();
                    lblTotalCusInventory.Text = dt.Rows[0]["InventoryCount"].ToString();
                    lblImageCapture.Text = dt.Rows[0]["ImageCaptureCount"].ToString();
                    lblTotalDisplayAgreements.Text = dt.Rows[0]["DisplayAgreementCount"].ToString();
                    lblTotCusActivity.Text = dt.Rows[0]["CusActivityCount"].ToString();
                    lblTotCusRequest.Text = dt.Rows[0]["CusRequestCount"].ToString();
                }




                if (cseID.ToString().Equals("0"))
                {
                    code.Visible = true;
                    cus.Visible = false;
                }
                else
                {
                    cus.Visible = true;
                    code.Visible = false;
                    DataTable ds = new DataTable();
                    ds = ObjclsFrms.loadList("SelectCusDetail", "sp_Merchandising", cseID.ToString());
                    if (ds.Rows.Count > 0)
                    {
                        lblcode.Text = ds.Rows[0]["cus_Code"].ToString();
                        lblcusName.Text = ds.Rows[0]["customer"].ToString();
                        lblsTime.Text = ds.Rows[0]["cse_STime"].ToString();
                        lbleTime.Text = ds.Rows[0]["cse_ETime"].ToString();
                        lbldurations.Text = ds.Rows[0]["Duration"].ToString();
                    }

                }

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }
        protected void BtnItemPricing_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=IP&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnItemAvailability_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=IA&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnGComplaints_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=GC&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnPComplaints_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=PC&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnCompetitorActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=CA&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnAssetTracking_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=AT&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnSurvey_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=SR&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnTasks_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=TS&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnCusInventory_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=CI&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnOutOfStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=OS&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnImageCapture_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=IC&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnDisplayAgreement_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=DA&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void CusActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=CSA&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void btnCusRequest_Click(object sender, EventArgs e)
        {
            Response.Redirect("MerchandisingTransaction.aspx?Mode=CSR&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }
    }
}