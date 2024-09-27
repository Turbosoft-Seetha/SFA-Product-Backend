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
    public partial class serviceReqInvoiceDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int JobID
        {
            get
            {
                int JobID;
                int.TryParse(Request.Params["JobID"], out JobID);

                return JobID;
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public string Type
        {
            get
            {
                string Type;
                Type = (Request.Params["Type"]);

                return Type;
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
            string[] ar = { JobID.ToString() };
            lstDatas = ObjclsFrms.loadList("SelSalesHeader", "sp_Merchandising", ResponseID.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblDis = (Label)rp.FindControl("lblDis");
                Label lblSub = (Label)rp.FindControl("lblSub");
                Label lblvat = (Label)rp.FindControl("lblvat");
                Label lblGrand = (Label)rp.FindControl("lblGrand");
                Label lblTotal = (Label)rp.FindControl("lblTotal");


                rp.Text = "Invoice Number: " + lstDatas.Rows[0]["inv_InvoiceID"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblDis.Text = lstDatas.Rows[0]["inv_Discount"].ToString();
                lblSub.Text = lstDatas.Rows[0]["sal_SubTotal"].ToString();
                lblvat.Text = lstDatas.Rows[0]["inv_VAT"].ToString();
                lblGrand.Text = lstDatas.Rows[0]["inv_GrandTotal"].ToString();
                lblTotal.Text = lstDatas.Rows[0]["inv_SubTotal_WO_Discount"].ToString();
                ViewState["INVNumber"] = lstDatas.Rows[0]["inv_InvoiceID"].ToString();

            }
        }

        public void LoadList()
        {
            string type;
            if (Type == null)
            {
                type = "";

            }
            else
            {
                if (Type.ToString().Equals("INV"))
                {
                    type = "";
                }
                else
                {
                    type = Type.ToString();
                }
            }

            DataTable lstUser = default(DataTable);

            string[] arr = { type.ToString(), JobID.ToString() };
            lstUser = ObjclsFrms.loadList("ListSalesDetail", "sp_Merchandising_UOM", ResponseID.ToString(), arr);
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
    }
}