﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class StockCountingBatchDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResID
        {
            get
            {
                int ResID;
                int.TryParse(Request.Params["ID"], out ResID);

                return ResID;
            }
        }
        public int HID
        {
            get
            {
                int HID;
                int.TryParse(Request.Params["ID"], out HID);

                return HID;
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
            lstDatas = ObjclsFrms.loadList("InvStockCountingBatchHeader", "sp_Transaction", HID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblprdcode = (Label)rp.FindControl("lblprdcode");
                Label lblprdname = (Label)rp.FindControl("lblprdname");



                rp.Text = "Stock Counting No: " + lstDatas.Rows[0]["stk_trn_Number"].ToString();
                lblprdcode.Text = lstDatas.Rows[0]["prd_Code"].ToString();
                lblprdname.Text = lstDatas.Rows[0]["prd_Name"].ToString();

            }
        }
        public void LoadData()
        {


            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("InvStockCountingBatch", "sp_Transaction", ResID.ToString());
            grvRpt.DataSource = lstDatas;


        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
    }
}