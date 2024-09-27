using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class ApprovedInvoiceDetail : System.Web.UI.Page
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
			lstDatas = ObjclsFrms.loadList("ServiceApprovalHeaderByID", "sp_ServiceRequest", ResponseID.ToString());
			if (lstDatas.Rows.Count > 0)
			{
				RadPanelItem rp = RadPanelBar0.Items[0];
				Label lblRot = (Label)rp.FindControl("lblRot");
				Label lblUser = (Label)rp.FindControl("lblUser");
				Label lblDate = (Label)rp.FindControl("lblDate");
				Label lblCustomer = (Label)rp.FindControl("lblCustomer");
				Label lblTotal = (Label)rp.FindControl("lblTotal");
				Label lblDiscount = (Label)rp.FindControl("lblDiscount");
				Label lblSubTotal = (Label)rp.FindControl("lblSubTotal");
				Label lblVat = (Label)rp.FindControl("lblVat");
				Label lblGrandTotal = (Label)rp.FindControl("lblGrandTotal");
				Label lblReqID = (Label)rp.FindControl("lblReqID");





				rp.Text = "Service Job ID: " + lstDatas.Rows[0]["sjh_Number"].ToString();
				lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
				lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
				lblDate.Text = lstDatas.Rows[0]["TransTime"].ToString();
				lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
				lblReqID.Text = lstDatas.Rows[0]["snr_Code"].ToString();
				lblTotal.Text = lstDatas.Rows[0]["sah_Total"].ToString();
				lblDiscount.Text = lstDatas.Rows[0]["sah_Discount"].ToString();
				lblSubTotal.Text = lstDatas.Rows[0]["sah_SubTotal"].ToString();
				lblVat.Text = lstDatas.Rows[0]["sah_VAT"].ToString();
				lblGrandTotal.Text = lstDatas.Rows[0]["sah_GrandTotal"].ToString();




			}
		}
		public void LoadData()
		{
			DataTable lstDatas = new DataTable();
			lstDatas = ObjclsFrms.loadList("ApprovedInvoiceDetail", "sp_ServiceRequest", ResponseID.ToString());
			if (lstDatas.Rows.Count >= 0)
			{
				grvRpt.DataSource = lstDatas;
				ViewState["dd"] = lstDatas;
			}

		}

		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadData();
		}

	
	}
}