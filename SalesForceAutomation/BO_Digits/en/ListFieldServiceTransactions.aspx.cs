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
    public partial class ListFieldServiceTransactions : System.Web.UI.Page
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
                FSCount();
                LoadRoute();
                lblFS.Text= Session["CO_COPFS_NAME"].ToString();
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
        public void FSCount()
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
                dt = ObjclsFrms.loadList("FSCounts", "sp_Merchandising", UID.ToString(), arr);
                if (dt.Rows.Count > 0)
                {
                    lblServReq.Text = dt.Rows[0]["ServiceReqCount"].ToString();
                    lblServJob.Text = dt.Rows[0]["ServiceJobCount"].ToString();

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
      

        protected void BtnServReq_Click(object sender, EventArgs e)
        {
            Response.Redirect("FieldServiceTransaction.aspx?Mode=SR&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }

        protected void BtnServJob_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceJobTransactions.aspx?Mode=SJ&&id=" + UID.ToString() + "&&CseID=" + cseID.ToString());

        }
    }
}