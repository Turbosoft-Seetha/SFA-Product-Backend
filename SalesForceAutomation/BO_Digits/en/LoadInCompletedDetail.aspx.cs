using ProcessExcel;
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
    public partial class LoadInCompletedDetail : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();

        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["LIH"], out LIH);

                return LIH;
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
            lstDatas = Obj.loadList("ListLoadInCompletedByID", "sp_Backend", LIH.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblstatus = (Label)rp.FindControl("lblstatus");


                rp.Text = "Transaction No: " + lstDatas.Rows[0]["lih_TransID"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
                //ViewState["rotid"] = lstDatas.Rows[0]["lrh_rot_ID"].ToString();
                //ViewState["usr"] = lstDatas.Rows[0]["lrh_usr_ID"].ToString();



            }
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            //string[] arr = { ddlHUom.SelectedValue.ToString(), ddlLUom.SelectedValue.ToString() };

            lstDatas = Obj.loadList("ListLoadInDetail", "sp_Backend", LIH.ToString());

            grvRpt.DataSource = lstDatas;

            

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        //protected void Adjusted_Click(object sender, EventArgs e)
        //{
           
           
        //}

        protected void Adj_CheckedChanged(object sender, EventArgs e)
        {

            if (Adj.Checked == true)
            {
                DataTable lstData = default(DataTable);
                lstData = Obj.loadList("ListLoadInDetailforadj>0", "sp_Backend", LIH.ToString());

                grvRpt.DataSource = lstData;
                grvRpt.DataBind();
            }
            else
            {
                LoadData();
                grvRpt.DataBind();
            }
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
           
            DataTable dt = default(DataTable);
            dt = Obj.loadList("SelLoadInCompletedDetailExcel", "sp_Backend", LIH.ToString());
            BuildExcel excel = new BuildExcel();
            byte[] output = excel.SpreadSheetProcess(dt, "LoadInCompletedDetail");
            Response.ContentType = ContentType;
            Response.Headers.Remove("Content-Disposition");
            Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "LoadIn Completed Detail", "Xlsx"));
            Response.BinaryWrite(output);
            Response.End();
        }
    }
}