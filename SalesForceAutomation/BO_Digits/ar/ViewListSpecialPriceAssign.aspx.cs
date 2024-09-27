using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ViewListSpecialPriceAssign : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DateTime ds = DateTime.Now;
                TimeSpan AddDay1 = new TimeSpan(8, 0, 0, 0);
                ds = ds.Add(AddDay1);

                rdfromDate.SelectedDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);
                rdfromDate.MinDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);
                DateTime dt = DateTime.Now;
                TimeSpan AddDay = new TimeSpan(8, 0, 0, 0);
                dt = dt.Add(AddDay);
                rdendDate.SelectedDate = dt;
                // rdendDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 8);
                rdendDate.MinDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);

                HeaderData();
                Route();
                // SpecialPrice();
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

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = obj.loadList("SelPriceListHeader", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar1.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");

                Label lblstatus = (Label)rp.FindControl("lblstatus");
                Label lblPayMode = (Label)rp.FindControl("lblPayMode");

                rp.Text = "كود السعر الخاص: " + lstDatas.Rows[0]["prh_Code"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["prh_Name"].ToString();

                lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
                lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();
                ViewState["prhname"] = lblRoute.Text;
                ViewState["paymode"] = lblPayMode.Text;
            }
        }

        //public void SpecialPrice()
        //{
        //    DataTable dt = obj.loadList("SpecialPriceName", "sp_Masters", ResponseID.ToString());
        //    if (dt.Rows.Count > 0)
        //    {
        //        string name = dt.Rows[0]["prh_Name"].ToString();
        //        sp.Text = "Special Price : " + name;
        //    }

        //}
        public void Route()
        {
            DataTable dt = obj.loadList("SelRoute", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }


        public void List()
        {
            string[] arr = { ResponseID.ToString(), ddlPayMode.SelectedValue.ToString() };
            DataTable lstdata = default(DataTable);
            lstdata = obj.loadList("AssignedCusSpecialPrice", "sp_Masters", ddlRoute.SelectedValue.ToString(), arr);
            //if (lstdata.Rows.Count > 0)
            //{
            grvRpt.DataSource = lstdata;

            //}
        }

        public void Loaddata()
        {
            string[] arr = { ResponseID.ToString(), ddlPayMode.SelectedValue.ToString() };
            DataTable lstuser = default(DataTable);
            lstuser = obj.loadList("UnAssignedCusSpecialPrice", "sp_Masters", ddlRoute.SelectedValue.ToString(), arr);
            //if (lstdata.Rows.Count > 0)
            //{
            RadGrid1.DataSource = lstuser;

            //}


        }

        protected void Filter_Click(object sender, EventArgs e)
        {

            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }
    }
}