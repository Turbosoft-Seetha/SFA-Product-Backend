using Stimulsoft.Report.Dictionary;
using Stimulsoft.Report.Web;
using Stimulsoft.Report;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListOpeningStock : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var s = Server.MapPath("Reports/license.key");
                Stimulsoft.Base.StiLicense.LoadFromFile(s);
            }
            catch (Exception ex)
            {
                //UICommon.LogException(ex, "UserDailyProcessDetail");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListOpeningStock.aspx", "Error from page load : " + ex.Message.ToString() + " - " + innerMessage);

            }


        }
        protected void StiWebViewer1_GetReport(object sender, StiReportDataEventArgs e)
        {

            var report = StiReport.CreateNewReport();

            var path = Server.MapPath("Reports/OpeningStock.mrt");
            try
            {
                report.Load(path);
                string DB = ConfigurationManager.AppSettings.Get("MyDB");
                ((StiSqlDatabase)report.Dictionary.Databases["MS SQL"]).ConnectionString = DB;

                e.Report = report;

            }
            catch (Exception ex)
            {
                //UICommon.LogException(ex, "UserDailyProcessDetail");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListOpeningStock.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }
    }
}