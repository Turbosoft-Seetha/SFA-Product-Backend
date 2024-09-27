using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation
{
    public partial class ARDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
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
            lstDatas = ObjclsFrms.loadList("SelectARByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");
                Label lblcolamnt = (Label)rp.FindControl("lblcolamnt");
                Label lblbalamnt = (Label)rp.FindControl("lblbalamnt");
                Label lblchqno = (Label)rp.FindControl("lblchqno");
                Label lblchqdate = (Label)rp.FindControl("lblchqdate");
                Label lblpaymode = (Label)rp.FindControl("lblpaymode");
                

                rp.Text = "Receipt No: " + lstDatas.Rows[0]["arh_ARNumber"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblcolamnt.Text = lstDatas.Rows[0]["arh_CollectedAmount"].ToString();
                lblbalamnt.Text = lstDatas.Rows[0]["arh_BalanceAmount"].ToString();
                lblchqno.Text = lstDatas.Rows[0]["arp_ChequeNo"].ToString();
                lblchqdate.Text = lstDatas.Rows[0]["arp_ChequeDate"].ToString();
                lblpaymode.Text = lstDatas.Rows[0]["arh_PayMode"].ToString();
                String type = lstDatas.Rows[0]["arp_Type"].ToString();

                
            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelArDetail", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstDatas;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
    }
}