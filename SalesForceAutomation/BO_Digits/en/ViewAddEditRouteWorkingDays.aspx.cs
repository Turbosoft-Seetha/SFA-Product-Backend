using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditRouteWorkingDays : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int RoutID
        {
            get
            {
                int RoutID;
                int.TryParse(Request.Params["RId"], out RoutID);

                return RoutID;
            }
        }

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["rmdId"], out ResponseID);

                return ResponseID;
            }
        }
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                FillForm();
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRouteworkingDaysByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string mnth, workDays, status;
                mnth = lstDatas.Rows[0]["rmd_Month"].ToString();
                workDays = lstDatas.Rows[0]["rmd_WorkingDays"].ToString();

                status = lstDatas.Rows[0]["Status"].ToString();


                radmonth.SelectedDate = DateTime.Parse(mnth.ToString());
                txtworkdays.Text = workDays.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }
    }
}