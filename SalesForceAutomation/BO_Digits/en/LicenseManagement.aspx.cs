using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class LicenseManagement : System.Web.UI.Page
    {

        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                    string Platform = "";
                    string IsStatusChange = "N";
                    obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx  , " + "LicenseKey : " + LicenseKey);
                    LicenseCounts(LicenseKey, Platform, IsStatusChange);
                }
                catch(Exception ex)
                {
                    obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx-1 , "+ "Page_Load() Error: " + ex);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                }

            }
        }
      
        public string WebServiceCall(string URL, string jsonData)
        {

            try
            {

                if (jsonData != null)
                {
                    // Create a request using a URL that can receive a post.
                    WebRequest request = WebRequest.Create(URL);
                    // Set the Method property of the request to POST.
                    request.Method = "POST";
                    request.ContentType = "application/json";

                    byte[] postData = Encoding.UTF8.GetBytes(jsonData);

                    // Set the ContentLength property of the request to the length of the data
                    request.ContentLength = postData.Length;

                    // Get the request stream and write the data to it
                    using (Stream requestStream = request.GetRequestStream())
                    {
                        requestStream.Write(postData, 0, postData.Length);
                    }

                    WebResponse response = request.GetResponse();
                    // Display the status.
                    Console.WriteLine(((HttpWebResponse)response).StatusDescription);

                    // Get the stream containing content returned by the server.
                    // The using block ensures the stream is automatically closed.
                    using (Stream dataStream = response.GetResponseStream())
                    {
                        // Open the stream using a StreamReader for easy access.
                        StreamReader reader = new StreamReader(dataStream);
                        // Read the content.
                        string responseFromServer = reader.ReadToEnd();
                        // Display the content.
                        // dm.TraceService("[" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "] @ " + " DataLake_Service WebServiceCall Success => " + responseFromServer);
                        response.Close();
                        return responseFromServer;
                    }
                }
                else
                {
                    return null;
                }


            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx  -  WebServiceCall() , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }
        public void LicenseCounts(string LicenseKey, string Platform, string IsStatusChange)
        {
            obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx-1 , "+ "Inside LicenseCounts()");

            try
            {

                DataTable lstActive = obj.loadList("LicenseMasterCounts", "sp_LicenseManagement");
                string RouteCount = lstActive.Rows[0]["RouteCount"].ToString();
                string SFA_AppUserCount = lstActive.Rows[0]["SFA_AppUserCount"].ToString();
                string InvUserCount = lstActive.Rows[0]["InventoryUserCount"].ToString();
                string BOUserCount = lstActive.Rows[0]["BackOfficeUserCount"].ToString();
                string CCUserCount = lstActive.Rows[0]["CustomerConnectUserCount"].ToString();

                LicenseInpara LicenseIn = new LicenseInpara();
                LicenseIn = new LicenseInpara
                {
                    LicenseKey = LicenseKey.ToString(),
                    RouteCount = RouteCount.ToString(),
                    InventoryUserCount = InvUserCount.ToString(),
                    BackOfficeUserCount = BOUserCount.ToString(),
                    CustomerConnectUserCount = CCUserCount.ToString(),
                    SFA_AppUserCount = SFA_AppUserCount.ToString(),
                    Platform = Platform.ToString(),
                    IsStatusChange = IsStatusChange.ToString()
                };

                string JSONStr = JsonConvert.SerializeObject(LicenseIn);
                string url = ConfigurationManager.AppSettings.Get("LicenseURL");
                string Json = WebServiceCall(url, JSONStr);

                obj.TraceService(UICommon.GetLogFileName()+ "LicenseManagement.aspx-1 , " + "JSONStr : " + JSONStr);
                obj.TraceService(UICommon.GetLogFileName()+ "LicenseManagement.aspx-1 , " + "url : " + url);
                obj.TraceService(UICommon.GetLogFileName()+ "LicenseManagement.aspx-1 , " + "Json : " + Json);

                if (Json != null)
                {
                    // Deserialize the escaped JSON string to a JObject
                    var jsonObject = JsonConvert.DeserializeObject<JObject>(Json);

                    // Serialize it back to a JSON string with proper formatting
                    string formattedJson = JsonConvert.SerializeObject(jsonObject, Formatting.Indented);


                    ResponseData responseData = JsonConvert.DeserializeObject<ResponseData>(formattedJson);
                    JObject result = (JObject)responseData.result[0];

                    // Extract values from the result object
                    string resCode = result["Res"].ToString();
                    string message = result["Message"].ToString();
                    string ResponseMessage = result["ResponseMessage"].ToString();

                    // Extract the LicenseData array
                    JArray licenseDataArray = (JArray)result["LicenseData"];

                    if (licenseDataArray.Count > 0)
                    {
                        // Access the first LicenseData object
                        JObject licenseData = (JObject)licenseDataArray[0];

                        string LicsNum = licenseData["LicenseNumber"].ToString();
                        string LicsKey = licenseData["LicenseKey"].ToString();
                        string StartDate = licenseData["StartDate"].ToString();
                        string ExpDate = licenseData["ExpiryDate"].ToString();
                        string ContPerson = licenseData["ContactPerson"]?.ToString();
                        string ContNumber = licenseData["ContactNumber"]?.ToString();
                        string LicsType = licenseData["LicenseType"]?.ToString();
                        string Status = licenseData["Status"]?.ToString();

                        string RouteLimit = licenseData["UserLimit"]?.ToString();
                        string CusConnectLimit = licenseData["CusConnectLimit"]?.ToString();
                        string InvLimit = licenseData["InvLimit"]?.ToString();
                        string BOLimit = licenseData["BOLimit"]?.ToString();

                        if (resCode == "200")
                        {
                            lblLicNum.Text = LicsNum;
                            lblLicKey.Text = LicsKey;
                            //txtLicKey.Value = LicsKey;
                            lblLicStDate.Text = StartDate;
                            lblExpOn.Text = ExpDate;
                            lblConPer.Text = ContPerson;
                            lblConNum.Text = ContNumber;
                            lblType.Text = LicsType;
                            lblStatus.Text = Status;

                            lblRoute.Text = RouteCount.ToString();
                            //lblAppUsr.Text = SFA_AppUserCount.ToString();
                            lblInvAppUsr.Text = InvUserCount.ToString();
                            lblCC.Text = CCUserCount.ToString();
                            lblBOUsr.Text = BOUserCount.ToString();

                            lblRotLimit.Text = RouteLimit.ToString();
                            lblInvAppUsrLmt.Text = InvLimit.ToString();
                            lblCCUsrlmt.Text = CusConnectLimit.ToString();
                            lblBOUsrlmt.Text = BOLimit.ToString();

                            int RotBal = Int32.Parse(RouteLimit.ToString()) - Int32.Parse(RouteCount.ToString());
                            int InvBal = Int32.Parse(InvLimit.ToString()) - Int32.Parse(InvUserCount.ToString());
                            int CCBal = Int32.Parse(CusConnectLimit.ToString()) - Int32.Parse(CCUserCount.ToString());
                            int BOBal = Int32.Parse(BOLimit.ToString()) - Int32.Parse(BOUserCount.ToString());

                            lblRotBal.Text = RotBal.ToString();
                            lblInvBal.Text = InvBal.ToString();
                            lblCCBal.Text = CCBal.ToString();
                            lblBOBal.Text = BOBal.ToString();
                            
                        }
                        else
                        {
                            obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx-1 , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        obj.TraceService(UICommon.GetLogFileName()+ "LicenseManagement.aspx-1 , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    obj.TraceService(UICommon.GetLogFileName()+ "LicenseManagement.aspx-1 , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch(Exception ex)
            {
                obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx-1 , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }

            obj.TraceService(UICommon.GetLogFileName()+ " LicenseManagement.aspx-1 , " + "LicenseCounts() ends here.");
        }

        public class LicenseData
        {
            public string ID { get; set; }
            public string LicenseNumber { get; set; }
            public string LicenseKey { get; set; }
            public string LicenseType { get; set; }
            public string ProjectCode { get; set; }
            public string ProjectName { get; set; }
            public string CustomerCode { get; set; }
            public string CustomerName { get; set; }
            public string CreatedDate { get; set; }
            public string StartDate { get; set; }
            public string ExpiryDate { get; set; }
            public string BufferPeriodInDays { get; set; }
            public string NeedExpiryNotification { get; set; }
            public string Prior_Exp_Notfctn_Intrvl_InDays { get; set; }
            public string ModifiedDate { get; set; }
            public string Status { get; set; }
            public string ContactPerson { get; set; }
            public string ContactNumber { get; set; }
            public string Email { get; set; }
            public string UserLimit { get; set; }
            public string CusConnectLimit { get; set; }
            public string InvLimit { get; set; }
            public string BOLimit { get; set; }
           
        }
        public class Result
        {
            public string Res { get; set; }
            public string Message { get; set; }
            public string ResponseMessage { get; set; }
            public List<LicenseData> LicenseData { get; set; }
        }
        public class ResponseData
        {
            public JArray result { get; set; }
        }
        public class LicenseInpara
        {
            public string LicenseKey { get; set; }
            public string RouteCount { get; set; }
            public string InventoryUserCount { get; set; }
            public string BackOfficeUserCount { get; set; }
            public string CustomerConnectUserCount { get; set; }
            public string SFA_AppUserCount { get; set; }
            public string Platform { get; set; }
            public string IsStatusChange { get; set; }
        }
    }
}