using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using Telerik.Web.UI;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using System.IO;
using Ecosoft.DAL;
using System.Net;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class Users : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                    DataTable lstUser = default(DataTable);
                    lstUser = ObjclsFrms.loadList("SelUserCount", "sp_Masters");
                    if (lstUser != null && lstUser.Rows.Count > 0)
                    {
                        lnkALl.Text = "All Users(" + lstUser.Rows[0]["AllCount"].ToString() + ")";
                        lnlActive.Text = "Active(" + lstUser.Rows[0]["ActiveCount"].ToString() + ")";
                        lnkInactive.Text = "InActive(" + lstUser.Rows[0]["InactiveCount"].ToString() + ")";
                    }
                }
                catch(Exception ex)
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx , " + "Page_Load() Error: " + ex);
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
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "  Users.aspx - WebServiceCall()  , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }
        public void LicenseCounts(string LicenseKey, string Platform, string IsStatusChange)
        {
            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx.aspx  , " + "Inside LicenseCounts()");

            try
            {
                DataTable lstActive = ObjclsFrms.loadList("LicenseMasterCounts", "sp_LicenseManagement");
                string RouteCount = lstActive.Rows[0]["RouteCount"].ToString();
                string InventoryUserCount = lstActive.Rows[0]["InventoryUserCount"].ToString();
                string BackOfficeUserCount = lstActive.Rows[0]["BackOfficeUserCount"].ToString();
                string CustomerConnectUserCount = lstActive.Rows[0]["CustomerConnectUserCount"].ToString();
                string SFA_AppUserCount = lstActive.Rows[0]["SFA_AppUserCount"].ToString();

                LicenseInpara LicenseIn = new LicenseInpara();
                LicenseIn = new LicenseInpara
                {
                    LicenseKey = LicenseKey.ToString(),
                    RouteCount = RouteCount.ToString(),
                    InventoryUserCount = InventoryUserCount.ToString(),
                    BackOfficeUserCount = BackOfficeUserCount.ToString(),
                    CustomerConnectUserCount = CustomerConnectUserCount.ToString(),
                    SFA_AppUserCount = SFA_AppUserCount.ToString(),
                    Platform = Platform.ToString(),
                    IsStatusChange = IsStatusChange.ToString()
                };

                string JSONStr = JsonConvert.SerializeObject(LicenseIn);
                string url = ConfigurationManager.AppSettings.Get("LicenseURL");
                string Json = WebServiceCall(url, JSONStr);

                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "Users.aspx.aspx  , " + "JSONStr : " + JSONStr);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "Users.aspx.aspx  , " + "url : " + url);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "Users.aspx.aspx  , " + "Json : " + Json);

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

                        string LicsKey = licenseData["LicenseNumber"].ToString();
                        string StartDate = licenseData["StartDate"].ToString();
                        string ExpDate = licenseData["ExpiryDate"].ToString();
                        string ContPerson = licenseData["ContactPerson"]?.ToString();
                        string ContNumber = licenseData["ContactNumber"]?.ToString();

                        string UserLimit = licenseData["UserLimit"]?.ToString();
                        string CusConnectLimit = licenseData["CusConnectLimit"]?.ToString();
                        string InvLimit = licenseData["InvLimit"]?.ToString();
                        string BOLimit = licenseData["BOLimit"]?.ToString();

                        if (resCode == "200")
                        {
                            ViewState["ResponseMessage"] = ResponseMessage.ToString();
                        }
                        else
                        {
                            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx.aspx  , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        ObjclsFrms.TraceService(UICommon.GetLogFileName() + "Users.aspx.aspx  , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + "Users.aspx.aspx  , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx.aspx  , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }

            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx.aspx  , " + "LicenseCounts() ends here.");
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
        public void ListData(string StatusCondition)
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectUser", "sp_Masters", StatusCondition);
            grvRpt.DataSource = lstUser;
        }

        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                string Platform = "BO";
                string IsStatusChange = "N";
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx , lnkAddUser_Click() - " + "LicenseKey : " + LicenseKey);
                LicenseCounts(LicenseKey, Platform, IsStatusChange);
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " Users.aspx , lnkAddUser_Click() - " + "Page_Load() Error: " + ex.Message.ToString());

            }
            string ResponseMessage = ViewState["ResponseMessage"].ToString();

            if (ResponseMessage == "Proceed")
            {
                Response.Redirect("AddEditUser.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('" + ResponseMessage + "');</script>", false);
            }          
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData("");
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Roles"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("UserId").ToString();
                Response.Redirect("UserRoles.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("UserId").ToString();
                Response.Redirect("AddEditUser.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Reset"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("UserId").ToString();
                ViewState["User"] = null;
                ViewState["UserName"] = null;
                ViewState["Email"] = null;
                ViewState["ID"] = null;
                DataTable lstUserName = ObjclsFrms.loadList("SelectUserNameByUserID", "sp_Masters", ID.ToString());
                if (lstUserName.Rows.Count > 0)
                {
                    string username = lstUserName.Rows[0]["UserName"].ToString();
                    string email = lstUserName.Rows[0]["Email"].ToString();
                    string ids = lstUserName.Rows[0]["ID"].ToString();
                    ViewState["UserName"] = username;
                    ViewState["Email"] = email;
                    ViewState["ID"] = ids;
                }
                ViewState["User"] = ID;
                string uName = ViewState["UserName"].ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('" + uName + "');</script>", false);
            }

            if (e.CommandName.Equals("Workflow"))
            {
                
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("UserId").ToString();
                DataTable lstUserName = ObjclsFrms.loadList("SelectUserNameByUserID", "sp_Masters", ID.ToString());
                if (lstUserName.Rows.Count > 0)
                {
                    string ids = lstUserName.Rows[0]["ID"].ToString();
                    Response.Redirect("ListUserWorkFlow.aspx?UID=" + ids);
                }
                else
                {

                }                
            }
            if (e.CommandName.Equals("CCSettings"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("UserId").ToString();
                DataTable lstUserName = ObjclsFrms.loadList("SelectUserNameByUserID", "sp_Masters", ID.ToString());
                if (lstUserName.Rows.Count > 0)
                {
                    string ids = lstUserName.Rows[0]["ID"].ToString();
                    Response.Redirect("CustomerConnectSettings.aspx?UID=" + ids);
                }
                else
                {

                }
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("Users.aspx");
        }

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            Reset();
        }

        public void Reset()
        {
            string mail = ViewState["Email"].ToString();
            string ID = ViewState["ID"].ToString();
            string userName = ViewState["UserName"].ToString();

            string password = ConfigurationManager.AppSettings.Get("DeffPass");
            UserProfile userProfile = new UserProfile();
            MembershipUser user;
            user = Membership.GetUser(userName);

            if (user != null)
            {

                //DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForReset", "sp_UserModule", mail.ToString());
                //if (dtLogin.Rows.Count > 0)
                //{
                user.UnlockUser();
                string NewPass = user.ResetPassword();

                string[] arr = { ID.ToString() };
                string svd = ObjclsFrms.SaveData("sp_Masters", "UpdResetPasedStatus", null, arr);

                //string key = ConfigurationManager.AppSettings.Get("ENpublicKey");
                //string encryptPassword = encrypt(NewPass, key);

                Save(NewPass);

            }
            else
            {
                this.ltrlMessage.Text = UICommon.GetErrorMessage("User along with this account not Found");
            }
        }

        public string encrypt(string encryptString, string key)
        {
            string EncryptionKey = "EcoKey%123" + key;
            byte[] clearBytes = Encoding.Unicode.GetBytes(encryptString);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76
        });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    encryptString = Convert.ToBase64String(ms.ToArray());
                }
            }
            return encryptString;
        }

        public void Save(string Password)
        {
            string userName = ViewState["UserName"].ToString();
            string id, user;
            id = ViewState["ID"].ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { Password.ToString(), user.ToString() };
            DataTable lstClaim = ObjclsFrms.loadList("InsertPasswordEncryptionLog", "sp_Masters", id.ToString(), arr);
            if (lstClaim.Rows.Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SuccessModal('" + userName + " . The password is " + Password + "');</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void lnkALl_Click(object sender, EventArgs e)
        {
            lnkInactive.Attributes.Remove("Style");
            lnkALl.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnlActive.Attributes.Remove("Style");
            ListData("");
            grvRpt.DataBind();
        }

        protected void lnlActive_Click(object sender, EventArgs e)
        {
            lnkALl.Attributes.Remove("Style");
            lnlActive.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkInactive.Attributes.Remove("Style");
            ListData(" where IsNull(Active,1)=1");
            grvRpt.DataBind();
        }

        protected void lnkInactive_Click(object sender, EventArgs e)
        {
            lnlActive.Attributes.Remove("Style");
            lnkInactive.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            lnkALl.Attributes.Remove("Style");
            ListData(" where IsNull(Active,1)=0");
            grvRpt.DataBind();
        }
    }
}