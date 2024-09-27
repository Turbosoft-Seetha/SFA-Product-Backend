using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class DetailedDailyTransactions : System.Web.UI.Page
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
        public int cseID
        {
            get
            {
                int cseID;
                int.TryParse(Request.Params["Cid"], out cseID);
                return cseID;
            }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                //Customer();
                //CustomerFilter();
                //string cusID = Cus();
                //string cusCondition = "cse_cus_ID in (" + cusID + ")";
                //if ((Session["cus"]) != null)
                //{
                //    CheckBox listitem = (CheckBox)Session["cus"];
                //    foreach (CheckBox item in listitem)
                //    {
                //        ddlCustomer.Items.Add(item);
                //    }
                //}

            }
        }

        //public void CustomerFilter()
        //{
        //    int k = 1;
        //    foreach (RadComboBoxItem itme in ddlCustomer.Items)
        //    {
        //        itme.Checked = true;
        //        k++;
        //    }
        //}
        //public string Cus()
        //{
        //    var ColelctionMarkets = ddlCustomer.CheckedItems;
        //    string cusID = "";
        //    int k = 0;
        //    int MarCounts = ColelctionMarkets.Count;
        //    if (ColelctionMarkets.Count > 0)
        //    {
        //        foreach (var item in ColelctionMarkets)
        //        {
        //            //where 1 = 1 
        //            if (k == 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            else if (k > 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            if (k == (MarCounts - 1))
        //            {
        //                cusID += item.Value;
        //            }
        //            k++;
        //        }
        //        return cusID;
        //    }
        //    else
        //    {
        //        return "0";
        //    }
        //}


        
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["routeName"].ToString();
                //lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
            }
        }

        public void GetData()
        {


            string mainCondition = "";


            string[] arr = { ResponseID.ToString() };

            string mode = Request.Params["mode"].ToString();
            lblType.Text = mode;
            string proc = "";
            if (mode.Equals("Invoice"))
            {
                proc = "SelUserDailySaleCounts";
                mainCondition = " sal_udp_ID=" + ResponseID;
                string cusCondition = " and sal_cse_ID = (case when '" + cseID + "' = 0 then sal_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Orders"))
            {
                proc = "SelUserDailyOrderCounts";
                mainCondition = " ord_udp_ID=" + ResponseID;
                string cusCondition = " and ord_cse_ID = (case when '" + cseID + "' = 0 then ord_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("Inventory"))
            {
                proc = "SelUserDailyInvCounts";
                mainCondition = " cse_udp_ID=" + ResponseID;
                string cusCondition = " and inh_cse_ID = (case when '" + cseID + "' = 0 then inh_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("AR"))
            {
                proc = "SelUserDailyARCounts";
                mainCondition = " arh_udp_ID=" + ResponseID;
                string cusCondition = " and arh_cse_ID = (case when '" + cseID + "' = 0 then arh_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            else if (mode.Equals("AP"))
            {
                proc = "SelUserDailyAPCounts";
                mainCondition = " adp_udp_ID=" + ResponseID;
                string cusCondition = " and adp_cse_ID = (case when '" + cseID + "' = 0 then adp_cse_ID else '" + cseID + "' end)";
                mainCondition += cusCondition;
            }
            DataTable lstDatas = new DataTable();
            if (cseID.ToString().Equals("0"))
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_DailyReports", mainCondition);

                grvRpt.DataSource = lstDatas;
            }
            else
            {

                lstDatas = ObjclsFrms.loadList(proc, "sp_DailyReports", mainCondition);

                grvRpt.DataSource = lstDatas;

            }



        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {

        }


        //protected void lnkFilter_Click(object sender, EventArgs e)
        //{
        //    GetData();
        //    grvRpt.DataBind();
        //}
        //public void Customer()
        //{
        //    ddlCustomer.DataSource = ObjclsFrms.loadList("SelUDPCustomer", "sp_DailyReports", ResponseID.ToString());
        //    ddlCustomer.DataTextField = "cus_Name";
        //    ddlCustomer.DataValueField = "cus_ID";
        //    ddlCustomer.DataBind();
        //}

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            GetData();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("id").ToString();

                Response.Redirect("DailyTranDetModes.aspx?id=" + id + "&&mode=" + Request.Params["mode"].ToString() + "&&HID=" + ResponseID.ToString());
            }
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {

            RadGrid radgrid2 = (RadGrid)sender;
            radgrid2.MasterTableView.GetColumnSafe("id").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("image").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("Recimage").Visible = false;
            if (Request.Params["mode"].ToString().Equals("AP"))
            {
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["mode"].ToString().Equals("Orders"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("RecImages").Visible = false;
            }


        }
    }
}