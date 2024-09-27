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
    public partial class AssetServiceHistoryHeader : System.Web.UI.Page
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
        public int CustomerID
        {
            get
            {
                int CustomerID;
                int.TryParse(Request.Params["CID"], out CustomerID);

                return CustomerID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    SelTotalPlannedInPlanned();
                    SelTotalVisitedInPlanned();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void SelTotalPlannedInPlanned()
        {
            DataTable dt1 = LoadData("OngoingServiceRequest");
            grvRpt.DataSource = dt1;
            grvRpt.DataBind();
        }

        public void SelTotalVisitedInPlanned()
        {
            DataTable dt2 = LoadData("CompletedServiceRequest");
            RadGrid1.DataSource = dt2;
            RadGrid1.DataBind();
        }

        public DataTable LoadData(string mode)
        {
            string[] arr = { CustomerID.ToString() };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_ServiceRequest", ResponseID.ToString(), arr);
            return dt;
        }

        protected void ButtonTotalPlanned_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string[] arguments = lnkRowSelection.CommandArgument.Split(';');
            string rscID = arguments[0];
            string cusID = arguments[1];
            Response.Redirect("/BO_Digits/en/AssetServiceHistoryDetail.aspx?cusID=" + cusID + "&&mode=pl");
        }

        protected void btnTotalActual_Click(object sender, EventArgs e)
        {
            LinkButton lnkRowSelection = (LinkButton)sender;
            string cusID = lnkRowSelection.CommandArgument.ToString();
            Response.Redirect("/BO_Digits/en/AssetServiceHistoryDetail.aspx?cusID=" + cusID + "&&mode=act");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelTotalPlannedInPlanned();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("snr_ID").ToString();

                Response.Redirect("AssignedServiceRequestDetail.aspx?ID=" + ID.ToString());
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            SelTotalVisitedInPlanned();
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("snr_ID").ToString();

                Response.Redirect("AssignedServiceRequestDetail.aspx?ID=" + ID.ToString());
            }
        }
    }
}