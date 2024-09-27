using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VanToVanDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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
            lstDatas = ObjclsFrms.loadList("SelectVanToVanHeaderByID", "sp_Transaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
               
                Label lblTransInRot = (Label)rp.FindControl("lblTransInRot");
                Label lblTransOutRot= (Label)rp.FindControl("lblTransOutRot");
                
                Label lblDate = (Label)rp.FindControl("lblDateTime");
               
                Label lblStatus = (Label)rp.FindControl("lblStatus");

                rp.Text = "Transaction Number: " + lstDatas.Rows[0]["vvh_TransID"].ToString();
                
               lblTransOutRot.Text = lstDatas.Rows[0]["vvh_FromRot"].ToString();
                lblTransInRot.Text = lstDatas.Rows[0]["vvh_ToRot"].ToString();

                
                lblDateTime.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
               
            }
        }
        public void Data()
        {
            DataTable lstdata = ObjclsFrms.loadList("SelectVanToVanDetail", "sp_Transaction", ResponseID.ToString());
            grvRpt.DataSource = lstdata;
        }
      

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Data();
        }

        protected void lnkFlow_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("VanToVanWorkFlow.aspx?ID="+ResponseID.ToString());
        }
    }
}