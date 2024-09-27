using DocumentFormat.OpenXml.Wordprocessing;
using GoogleApi.Entities.Common.Enums;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditUsers : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string Id = ResponseID.ToString();

                Store();

                try
                {
                    string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                    obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "LicenseKey : " + LicenseKey);
                    LicenseCounts(LicenseKey);
                }
                catch (Exception ex)
                {
                    obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "Page_Load() Error: " + ex);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                }

                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {
                    
                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = obj.loadList("EditUsers", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {
                        string name, arabic, code, pass, status, istracking, TrackDuration,UserType,isStokecount;                                          //Declare the variables
                        name = lstDatas.Rows[0]["usr_Name"].ToString();
                        arabic = lstDatas.Rows[0]["usr_ArabicName"].ToString();
                        code = lstDatas.Rows[0]["usr_Code"].ToString();
                        pass = lstDatas.Rows[0]["usr_Password"].ToString();
                        status = lstDatas.Rows[0]["Status"].ToString();
                        istracking = lstDatas.Rows[0]["usr_IsTrackingNeeded"].ToString();
                        TrackDuration = lstDatas.Rows[0]["usr_TrackingDuration"].ToString();
                        isStokecount = lstDatas.Rows[0]["IsInstantStockCount"].ToString();
                        UserType = lstDatas.Rows[0]["usr_Type"].ToString();
                        rdappUsrtypes.SelectedValue = UserType;
                        ViewState["CurrentUserType"] = UserType;
                        ViewState["CurrentStatus"] = status;

                        if (UserType == "SFA")
                        {
                            Tracking.Visible = true;
                            Stoke.Visible = false;
                            rdDuration.Text = TrackDuration.ToString();
                            ddlTrackings.SelectedValue = istracking.ToString();
                        }

                        else
                        {
                            Tracking.Visible = false;
                            Stoke.Visible = true;
                            rdInsStockCounts.SelectedValue = isStokecount;
                            DataTable store = obj.loadList("SelStoreByUserID", "sp_Masters", ResponseID.ToString());
                            if (store.Rows.Count > 0)
                            {
                                string strID = store.Rows[0]["strID"].ToString();
                                string[] ar = strID.Split(',');
                                for (int i = 0; i < ar.Length; i++)
                                {
                                    foreach (RadComboBoxItem items in rdStore.Items)
                                    {
                                        if (items.Value == ar[i])
                                        {
                                            items.Checked = true;
                                        }
                                    }
                                }
                            }
                        }

                        txtName.Text = name.ToString();
                        txtArabic.Text = arabic.ToString();
                        txtCode.Text = code.ToString();
                        txtPass.Text = pass.ToString();
                        ddlStatus.SelectedValue = status.ToString();
                        txtCode.Enabled = false;
                       
                        txtCode.Enabled = false;

                        //DataTable store = obj.loadList("SelStoreByUserID", "sp_Masters", ResponseID.ToString());
                        //if (store.Rows.Count > 0)
                        //{
                        //    string strID= store.Rows[0]["strID"].ToString();
                        //    string[] ar = strID.Split(',');
                        //    for (int i = 0; i < ar.Length; i++)
                        //    {
                        //        foreach (RadComboBoxItem items in rdStore.Items)
                        //        {
                        //            if (items.Value == ar[i])
                        //            {
                        //                items.Checked = true;
                        //            }
                        //        }
                        //    }
                        //}
                    }
                    else                                                              //If there is no value you can leave it as it is.
                    {

                    }
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
                obj.TraceService(UICommon.GetLogFileName() + " InvoiceDetail.aspx PageLoad() , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }
        public void LicenseCounts(string LicenseKey)
        {
            obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "Inside LicenseCounts()");

            try
            {
                LicenseInpara LicenseIn = new LicenseInpara();
                LicenseIn = new LicenseInpara
                {
                    LicenseKey = LicenseKey.ToString()
                };

                string JSONStr = JsonConvert.SerializeObject(LicenseIn);
                string url = ConfigurationManager.AppSettings.Get("LicenseURL");
                string Json = WebServiceCall(url, JSONStr);

                obj.TraceService(UICommon.GetLogFileName() + "LicenseManagement.aspx-1 , " + "JSONStr : " + JSONStr);
                obj.TraceService(UICommon.GetLogFileName() + "LicenseManagement.aspx-1 , " + "url : " + url);
                obj.TraceService(UICommon.GetLogFileName() + "LicenseManagement.aspx-1 , " + "Json : " + Json);

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
                            DataTable lstActive = obj.loadList("LicenseMasterCounts", "sp_Masters");                          
                            string InventoryUserCount = lstActive.Rows[0]["InventoryUserCount"].ToString();
                           
                            int AppUserBal = Int32.Parse(InvLimit.ToString()) - Int32.Parse(InventoryUserCount.ToString());
                            if (AppUserBal < 0)
                            {
                                AppUserBal = 0;
                            }

                            ViewState["InventoryUserCount"] = AppUserBal.ToString();
                        }
                        else
                        {
                            obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        obj.TraceService(UICommon.GetLogFileName() + "LicenseManagement.aspx-1 , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    obj.TraceService(UICommon.GetLogFileName() + "LicenseManagement.aspx-1 , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch (Exception ex)
            {
                obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }

            obj.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "LicenseCounts() ends here.");
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
            public List<LicenseData> LicenseData { get; set; }
        }
        public class ResponseData
        {
            public JArray result { get; set; }
        }
        public class LicenseInpara
        {
            public string LicenseKey { get; set; }
        }

        public void Store()
        {

            rdStore.DataSource = obj.loadList("SelStoreforAppUser", "sp_Masters");
            rdStore.DataTextField = "str_Name";
            rdStore.DataValueField = "str_ID";
            rdStore.DataBind();
        }
        public string str()
        {
            var CollectionMarket = rdStore.CheckedItems;
            string strID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        strID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        strID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        strID += item.Value;
                    }
                    j++;
                }
                return strID;
            }
            else
            {
                return "0";
            }

        }

        public void UserStoresSave(string id)
        {
            var CollectionMarket = rdStore.CheckedItems;
            string Id = (id==""?ResponseID.ToString():id);
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    string[] arr = { item.Value };
                    string ustvalue = obj.SaveData("sp_Masters", "InsertUserStores", Id, arr);
                    
                }
            }
        }

        public void Save()
        {
            string name, arabic, code, User, pass, Status, istracking, TrackDuration,IsInstatStockCount,usertype;
            name = this.txtName.Text.ToString();
            arabic = this.txtArabic.Text.ToString();
            code = this.txtCode.Text.ToString();
            pass = this.txtPass.Text.ToString();
            User = UICommon.GetCurrentUserID().ToString();
            Status = this.ddlStatus.SelectedValue.ToString();
            istracking = this.ddlTrackings.SelectedValue.ToString();
            TrackDuration = this.rdDuration.Text.ToString();
            IsInstatStockCount= this.rdInsStockCounts.SelectedValue.ToString();
            usertype = this.rdappUsrtypes.SelectedValue.ToString();

            string userCount = ViewState["InventoryUserCount"].ToString();
            int AppUserCount = Int32.Parse(userCount);

            if (ResponseID.Equals("") || ResponseID == 0)
            {
               
                if(usertype == "INV")
                {
                    if (AppUserCount > 0)
                    {
                        string[] arr = { code, pass, User, Status, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                        string Value = obj.SaveData("sp_Masters", "InsertUser", name, arr);
                        try
                        {
                            int res = Int32.Parse(Value.ToString());

                            if (res > 0)
                            {
                                UserStoresSave(res.ToString());
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been saved successfully');</script>", false);

                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('User Limit Exceeded, Kindly contact DigiTS team to increase the user limit.');</script>", false);
                    }
                }
                else
                {
                    string[] arr = { code, pass, User, Status, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                    string Value = obj.SaveData("sp_Masters", "InsertUser", name, arr);
                    try
                    {
                        int res = Int32.Parse(Value.ToString());

                        if (res > 0)
                        {
                            UserStoresSave(res.ToString());
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been saved successfully');</script>", false);

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                
               
            }
            else
            {
                string CurrentUserType = ViewState["CurrentUserType"].ToString();
                string ChangedUserType = rdappUsrtypes.SelectedValue.ToString();

                string CurrentStatus = ViewState["CurrentStatus"].ToString();
                string ChangedStatus = ddlStatus.SelectedValue.ToString();

                if (CurrentUserType == "SFA" && ChangedUserType == "INV")
                {
                    if (ChangedStatus == "Y")
                    {
                        if (AppUserCount > 0)
                        {
                            string ID = ResponseID.ToString();
                            string[] arr = { code, pass, User, Status, ID, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                            string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                            int res = Int32.Parse(value.ToString());
                            if (res > 0)
                            {
                                try
                                {
                                    DataTable delData = obj.loadList("DeleteUserStores", "sp_Masters", ID.ToString());
                                    UserStoresSave("");
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                                }
                                catch (Exception ex)
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('User Limit Exceeded, Kindly contact DigiTS team to increase the user limit.');</script>", false);
                        }
                    }
                    else
                    {
                        string ID = ResponseID.ToString();
                        string[] arr = { code, pass, User, Status, ID, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                        string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                        int res = Int32.Parse(value.ToString());
                        if (res > 0)
                        {
                            try
                            {
                                DataTable delData = obj.loadList("DeleteUserStores", "sp_Masters", ID.ToString());
                                UserStoresSave("");
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                            }
                            catch (Exception ex)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }

                }
                else
                {
                    if (CurrentStatus == "N" && ChangedStatus == "Y")
                    {
                        if (ChangedUserType == "INV")
                        {
                            if (AppUserCount > 0)
                            {
                                string ID = ResponseID.ToString();
                                string[] arr = { code, pass, User, Status, ID, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                                string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                                int res = Int32.Parse(value.ToString());
                                if (res > 0)
                                {
                                    try
                                    {
                                        DataTable delData = obj.loadList("DeleteUserStores", "sp_Masters", ID.ToString());
                                        UserStoresSave("");
                                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                                    }
                                    catch (Exception ex)
                                    {
                                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                                    }
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('User Limit Exceeded, Kindly contact DigiTS team to increase the user limit.');</script>", false);
                            }
                        }
                        else
                        {
                            string ID = ResponseID.ToString();
                            string[] arr = { code, pass, User, Status, ID, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                            string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                            int res = Int32.Parse(value.ToString());
                            if (res > 0)
                            {
                                try
                                {
                                    DataTable delData = obj.loadList("DeleteUserStores", "sp_Masters", ID.ToString());
                                    UserStoresSave("");
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                                }
                                catch (Exception ex)
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                    }
                    else
                    {
                        string ID = ResponseID.ToString();
                        string[] arr = { code, pass, User, Status, ID, istracking, TrackDuration, arabic, IsInstatStockCount, usertype };
                        string value = obj.SaveData("sp_Masters", "UpdateUser", name, arr);
                        int res = Int32.Parse(value.ToString());
                        if (res > 0)
                        {
                            try
                            {
                                DataTable delData = obj.loadList("DeleteUserStores", "sp_Masters", ID.ToString());
                                UserStoresSave("");
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('User details has been updated successfully');</script>", false);
                            }
                            catch (Exception ex)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }


                }

            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);           
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListUsers.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListUsers.aspx");
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = obj.loadList("CheckUsersCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                lnkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                lnkSave.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }

        protected void rdappUsrtypes_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string FS = rdappUsrtypes.SelectedValue.ToString();

            if (FS.Equals("SFA"))
            {
                Tracking.Visible = true;
                Stoke.Visible = false;
            }

            else
            {
                Tracking.Visible = false;
                Stoke.Visible = true;
            }
        }
    }
}