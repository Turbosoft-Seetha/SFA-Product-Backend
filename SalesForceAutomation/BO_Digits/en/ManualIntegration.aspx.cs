using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ManualIntegration : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectIntegrationInfo", "sp_Transaction");
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("ERPCall"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("iws_ID").ToString();
                string URL = dataItem["iws_URL"].Text;
                string Method = dataItem["iws_Method"].Text;
                ViewState["URL"] = URL.ToString();
                ViewState["Method"] = Method.ToString();
            }
        }

        protected void ERP_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void Run_Click(object sender, EventArgs e)
        {
            string url = ViewState["URL"].ToString();

            // Make the web service call
            string responseJson = WebServiceCall(url);
            string Response = responseJson.Trim();

            string successMessage = "Response: " + responseJson;


            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('" + successMessage + "');</script>", false);

        }

        public string WebServiceCall(string url)
        {
            try
            {
                using (WebClient client = new WebClient())
                {
                    string Method = ViewState["Method"].ToString();
                    client.Headers[HttpRequestHeader.ContentType] = "application/json";
                    string response = client.UploadString(url, Method, "");
                    return client.UploadString(url, Method, "");
                }
            }
            catch (WebException webEx)
            {
                // Log or handle specific web exception details
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ManualIntegration.aspx PageLoad()", "WebException: " + webEx.Message);
                return null;
            }
            catch (Exception ex)
            {
                // Log or handle general exception details
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ManualIntegration.aspx PageLoad()", "Error : " + ex.Message + " - " + ex.InnerException?.Message);
                return null;
            }
        }


        protected void lnkOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManualIntegration.aspx");
        }
    }
}