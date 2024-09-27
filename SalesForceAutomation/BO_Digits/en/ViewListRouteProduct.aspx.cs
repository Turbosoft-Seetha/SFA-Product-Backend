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

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewListRouteProduct : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
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
        public void Route()
        {
            DataTable dt = obj.loadList("RotName", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string rotname = dt.Rows[0]["rot_Name"].ToString();
                Proroute.Text = "Route Name : " + rotname;
            }

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("RouteProduct", "sp_Masters", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                grvRpt.DataSource = lstdata;

            }
        }
        public void Loaddata()
        {
            DataTable lstdata = obj.loadList("RotProduct", "sp_Merchandising", ResponseID.ToString());
            if (lstdata.Rows.Count > 0)
            {
                RadGrid1.DataSource = lstdata;

            }
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