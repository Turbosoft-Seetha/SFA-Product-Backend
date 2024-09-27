using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ListRouteCustomerPromotion : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (Session["FromDate"] == null)
                //{
                //    rdFromData.SelectedDate = DateTime.Now;
                //}
                //else
                //{
                //    string fdate = Session["FromDate"].ToString();
                //    rdFromData.SelectedDate = DateTime.Parse(fdate);
                //}
                //if (Session["ToDate"] == null)
                //{
                //    rdEndDate.SelectedDate = DateTime.Now;
                //}
                //else
                //{
                //    string tdate = Session["ToDate"].ToString();
                //    rdEndDate.SelectedDate = DateTime.Parse(tdate);
                //}
                Route();
                Promo();
            }

        }
        public void Route()
        {
            DataTable dtr = ObjclsFrms.loadList("SelectRouteDrop", "sp_Web_Promotion");
            ddlp.DataSource = dtr;
            ddlp.DataTextField = "name";
            ddlp.DataValueField = "id";
            ddlp.DataBind();
        }
        public void Promo()
        {
            DataTable dtp = ObjclsFrms.loadList("SelectPromotionforDrop", "sp_Web_Promotion");
            ddlPromo.DataSource = dtp;
            ddlPromo.DataTextField = "name";
            ddlPromo.DataValueField = "id";
            ddlPromo.DataBind();
        }
        public void Customer()
        {
            string rotID = ddlp.SelectedValue.ToString();
            ddlCus.DataSource = ObjclsFrms.loadList("SelectCustomerByRouteDrop", "sp_Web_Promotion", rotID);
            ddlCus.DataTextField = "name";
            ddlCus.DataValueField = "id";
            ddlCus.DataBind();

            int j = 1;
            foreach (RadComboBoxItem itmss in ddlCus.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string Cus()
        {
            var ColelctionMarket = ddlCus.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }
        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditRouteCustomerPromotions.aspx?Id=0");
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            string condition = mainCondition();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectRouteCustomerPromotion", "sp_Web_Promotion", condition);
            grvRpt.DataSource = lstUser;
        }

        public string mainCondition()
        {
            //string dateCondition = "";
            string mainCondition = "";
            string rotID = ddlp.SelectedValue.ToString();
            string prmID = ddlPromo.SelectedValue.ToString();
            string cusID = Cus();
            if (cusID.Equals("0"))
            {
                mainCondition = " rcp_rot_ID = (case when '" + rotID + "' = '' then rcp_rot_ID else '" + rotID + "' end) and rcp_prm_ID = (case when '" + prmID + "' = '' then rcp_prm_ID else '" + prmID + "' end)";
            }
            else
            {
                mainCondition = " rcp_rot_ID = (case when '" + rotID + "' = '' then rcp_rot_ID else '" + rotID + "' end) and rcp_cus_ID in (" + cusID + ") and rcp_prm_ID = (case when '" + prmID + "' = '' then rcp_prm_ID else '" + prmID + "' end)";
            }

            try
            {
                //string fromDate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
                //string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                //Session["FromDate"] = rdFromData.SelectedDate.ToString();
                //Session["ToDate"] = rdEndDate.SelectedDate.ToString();
                //dateCondition = " and (cast(rcp_EndDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";

            }
            catch (Exception ex)
            {

            }
            //mainCondition += dateCondition;

            return mainCondition;
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rcp_ID").ToString();

            }
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {

        }

        protected void CusPromo_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerPromotionAssignments.aspx");
        }
    }
}