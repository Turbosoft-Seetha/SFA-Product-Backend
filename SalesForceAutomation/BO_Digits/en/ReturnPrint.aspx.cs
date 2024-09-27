using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report.Web;
using Stimulsoft.Report;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ReturnPrint : System.Web.UI.Page
    {

        public string ResponseID
        {
            get
            {
                string ResponseID;
                ResponseID = Request.Params["rtnID"];
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            var s = Server.MapPath("Reports/license.key");
            Stimulsoft.Base.StiLicense.LoadFromFile(s);
        }

        protected void StiWebViewer1_GetReport(object sender, StiReportDataEventArgs e)
        {
            var report = StiReport.CreateNewReport();
            var path = Server.MapPath("Reports/ReturnRequest.mrt");
            report.Load(path);
            report["@para2"] = ResponseID.ToString();
            string DB = ConfigurationManager.AppSettings.Get("MyDB");
            ((StiSqlDatabase)report.Dictionary.Databases["BMReport"]).ConnectionString = DB;



            e.Report = report;

        }
    }
}