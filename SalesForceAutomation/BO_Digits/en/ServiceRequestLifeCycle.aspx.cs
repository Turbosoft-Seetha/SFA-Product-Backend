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
    public partial class ServiceRequestLifeCycle : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
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
                HeaderData();
            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = obj.loadList("SelServiceRequestHeader", "sp_ServiceRequest", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblReqID = (Label)rp.FindControl("lblReqID");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblStatus = (Label)rp.FindControl("lblStatus");





                //rp.Text = "Request ID: " + lstDatas.Rows[0]["snr_Code"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();

                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
                lblReqID.Text= lstDatas.Rows[0]["snr_Code"].ToString();







            }
        }

        public void listLifeCycle()
        {
            DataTable lstuser = new DataTable();
            lstuser = obj.loadList("ListServiceLifeCycle", "sp_ServiceRequest", ResponseID.ToString());
            grvRpt.DataSource = lstuser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            listLifeCycle();
        }
    }
}