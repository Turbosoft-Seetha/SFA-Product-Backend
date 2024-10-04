using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Ecosoft.DAL;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Configuration;
using Telerik.Web.UI;
using System.Xml;
using System.IO;
using Telerik.Windows.Documents.Fixed.Model.Common;
using ExcelLibrary.BinaryFileFormat;
using System.Net;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Formatting = Newtonsoft.Json.Formatting;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditUser : System.Web.UI.Page
    {


        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    

                    if (string.IsNullOrEmpty(Request.Params["Id"]))
                    {
                        this.chkActive.Checked = true;
                    }
                    //Division();
                    DM.Visible = false;
                    DSAM.Visible = false;
                    DAM.Visible = false;
                    
                    SM.Visible = false;
                    UserTypes();
                    Roles();
                    this.FillForm();


                }
            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Edit User");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditUser.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);



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
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "  AddEditUser.aspx - WebServiceCall()  , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }
        public void LicenseCounts(string LicenseKey, string Platform, string IsStatusChange)
        {
            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx.aspx  , " + "Inside LicenseCounts()");

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

                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditUser.aspx.aspx  , " + "JSONStr : " + JSONStr);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditUser.aspx.aspx  , " + "url : " + url);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditUser.aspx.aspx  , " + "Json : " + Json);

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
                            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx.aspx  , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditUser.aspx.aspx  , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditUser.aspx.aspx  , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx.aspx  , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }

            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx.aspx  , " + "LicenseCounts() ends here.");
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

        private void FillForm()
        {
            if (string.IsNullOrEmpty(Request.Params["Id"]))
            {
                return;
            }


            UserProfile userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(Request.Params["Id"])).First();

            this.txtUsername.Text = userProfile.UserName;
            this.txtContactInfo.Text = userProfile.ContacInfo;
            this.txtFirstName.Text = userProfile.FirstName;
            this.txtLastName.Text = userProfile.LastName;
            this.txtEmail.Text = userProfile.Email;

            MembershipUser user = Membership.GetUser(this.txtUsername.Text);

            this.chkActive.Checked = user.IsApproved;
            ViewState["Active"] = user.IsApproved;

            this.txtUsername.Enabled = false;

            string ID = userProfile.ID.ToString();
            //DataTable lstData = ObjclsFrms.loadList("SelectUserDivisionByUserID", "sp_Masters", ID.ToString());
            //if (lstData.Rows.Count > 0)
            //{
            //    string[] words = new string[500];
            //    for (int i = 0; i<lstData.Rows.Count; i++)
            //    {
            //        string id = lstData.Rows[i]["usd_sdv_ID"].ToString();
            //        words[i] = id;
            //    }
            //    foreach (var word in words)
            //    {
            //        foreach (RadComboBoxItem rd in ddlDivision.Items)
            //        {
            //            if (rd.Value.Equals(word))
            //            {
            //                rd.Checked = true;
            //            }
            //        }
            //    }
            //}

           

            
            
                DataTable lstUser = ObjclsFrms.loadList("checkroles", "sp_Masters", ID.ToString());
                string chkRoles = string.Empty;

                if (lstUser.Rows.Count > 0)
                {
                    chkRoles = lstUser.Rows[0]["RoleId"].ToString();
                }

                if (!string.IsNullOrEmpty(chkRoles))
                {
                    string[] arr = chkRoles.Split(',');

                    for (int i = 0; i < arr.Length; i++)
                    {
                        string roleId = arr[i].Trim(); 

                        foreach (RadComboBoxItem items in rdRoles.Items)
                        {
                            if (items.Value.Trim().Equals(roleId, StringComparison.OrdinalIgnoreCase)) 
                            {
                                items.Checked = true;
                            }
                        }
                    }
                }

            DataTable lstAccess = ObjclsFrms.loadList("SelectMapAccess", "sp_Masters", ID.ToString());
            if (lstAccess.Rows.Count > 0)
            {
                string MapAccess = lstAccess.Rows[0]["MapsDirectionAccess"].ToString();


                ddlAccess.SelectedValue = MapAccess;


            }

             DataTable dt = ObjclsFrms.loadList("SelectCCUser", "sp_Masters", ID.ToString());
            if (dt.Rows.Count > 0)
            {
                string ccuser = dt.Rows[0]["IsCustomerConnectUser"].ToString();


                ddlEnableCCUser.SelectedValue = ccuser;


            }


            DataTable lstCode = ObjclsFrms.loadList("SelectEmployeeCodeForUser", "sp_Masters", ID.ToString());
            if (lstCode.Rows.Count > 0)
            {
                string code = lstCode.Rows[0]["EmployeeCode"].ToString();
            }

            DataTable lstdatas = ObjclsFrms.loadList("SelDepotEdit", "sp_Masters", ID.ToString());
            if (lstdatas.Rows.Count > 0)
            {
                ddlUserType.SelectedValue = lstdatas.Rows[0]["usl_ust_ID"].ToString();
                DataTable lstData = ObjclsFrms.loadList("SelUserTypeByID", "sp_Masters", ddlUserType.SelectedValue.ToString());
                if (lstData.Rows.Count > 0)
                {


                    string Usertype = lstData.Rows[0]["ust_Value"].ToString();

                    ViewState["UserType"] = Usertype;
                }
                else
                {
                    ViewState["UserType"] = "";
                }

                if (ViewState["UserType"].ToString() != "")
                {


                    if (ViewState["UserType"].ToString() == "SM")
                    {

                        SM.Visible = true;
                        DM.Visible = false;
                        DAM.Visible = false;
                        DSAM.Visible = false;




                        SMCheckB();
                        DataTable Depot = ObjclsFrms.loadList("SelDepotcheckbox", "sp_Masters", ID.ToString());
                        if (Depot.Rows.Count > 0)
                        {
                            foreach (DataRow row in Depot.Rows)
                            {
                                foreach (RadComboBoxItem items in SMCheckBox.Items)
                                {
                                    if ((items.Value.ToString()) == (row["usl_LevelID"].ToString()))
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    if (ViewState["UserType"].ToString() == "DM")
                    {
                        DM.Visible = true;
                        DAM.Visible = false;
                        DSAM.Visible = false;

                        SM.Visible = false;

                        DataTable userlevelDM = ObjclsFrms.loadList("SelUserLevelIDInDM", "sp_Masters", ID.ToString());

                        string SalesM = userlevelDM.Rows[0]["reg_ID"].ToString();

                        SMDropinDM();

                        ddlSMinDM.SelectedValue = SalesM;


                        DepotCheckB();
                        DataTable Depot = ObjclsFrms.loadList("SelDepotcheckbox", "sp_Masters", ID.ToString());
                        if (Depot.Rows.Count > 0)
                        {
                            foreach (DataRow row in Depot.Rows)
                            {
                                foreach (RadComboBoxItem items in cbDepot.Items)
                                {
                                    if ((items.Value.ToString()) == (row["usl_LevelID"].ToString()))
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    if (ViewState["UserType"].ToString() == "AM")
                    {
                        DAM.Visible = true;
                        DM.Visible = false;
                        DSAM.Visible = false;

                        SM.Visible = false;


                        DataTable DepotinAM = ObjclsFrms.loadList("SelDepotIDInAM", "sp_Masters", ID.ToString());

                        string SalesM = DepotinAM.Rows[0]["reg_ID"].ToString();
                        string depot = DepotinAM.Rows[0]["dep_ID"].ToString();

                        SMDropinAM();
                        ddlSMinAM.SelectedValue = SalesM;

                        DepotDropAM();


                        ddlDepotAM.SelectedValue = depot;
                        DepotAMCheckB();
                        DataTable DepotAM = ObjclsFrms.loadList("SelDepotcheckbox", "sp_Masters", ID.ToString());

                        if (DepotAM.Rows.Count > 0)
                        {
                            foreach (DataRow row in DepotAM.Rows)
                            {
                                foreach (RadComboBoxItem items in cbDepotAM.Items)
                                {
                                    if (items.Value.ToString() == row["usl_LevelID"].ToString())
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }

                            //for (int i = 0; i < arr.Length; i++)
                            //{
                            //    foreach (RadComboBoxItem items in cbDepotAM.Items)
                            //    {
                            //        if (items.Value == arr[i])
                            //        {
                            //            items.Checked = true;
                            //        }
                            //    }
                            //}

                        }
                    }
                    if (ViewState["UserType"].ToString() == "SS")
                    {
                        DSAM.Visible = true;
                        DM.Visible = false;
                        DAM.Visible = false;

                        SM.Visible = false;


                        DataTable DepotinSAM = ObjclsFrms.loadList("SelDepotIDInSAM", "sp_Masters", ID.ToString());

                        string SalesM = DepotinSAM.Rows[0]["reg_ID"].ToString();
                        string depot = DepotinSAM.Rows[0]["dep_ID"].ToString();
                        string depotarea = DepotinSAM.Rows[0]["dpa_ID"].ToString();


                        SMDropinSS();
                        ddlSMinSS.SelectedValue = SalesM;
                        DepotDropSAM();
                        ddlDepotSAM.SelectedValue = depot;
                        DepotAMDropSAM();





                        ddlDepotAreaSAM.SelectedValue = depotarea;
                        DepotSAMCheckB();
                        DataTable DepotSAM = ObjclsFrms.loadList("SelDepotcheckbox", "sp_Masters", ID.ToString());


                        if (DepotSAM.Rows.Count > 0)
                        {
                            foreach (DataRow row in DepotSAM.Rows)
                            {
                                foreach (RadComboBoxItem items in cbDepotSAM.Items)
                                {
                                    if ((items.Value.ToString()) == (row["usl_LevelID"].ToString()))
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            //for (int i = 0; i < arr.Length; i++)
                            //    {
                            //        foreach (RadComboBoxItem items in cbDepotSAM.Items)
                            //        {
                            //            if (items.Value == arr[i])
                            //            {
                            //                items.Checked = true;
                            //            }
                            //        }
                            //    }

                        }
                    }
                }
            }
            else
            {
                DataTable lstData = ObjclsFrms.loadList("SelectUserTypeByID", "sp_Masters",ID.ToString() );
                if(lstData.Rows.Count > 0)
                {
                    //string Usertype = lstData.Rows[0]["UserType"].ToString();
                    string UsertypeID = lstData.Rows[0]["ust_ID"].ToString();
                    ddlUserType.SelectedValue = UsertypeID;

                    
                }
            }



        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                string Platform = "BO";
                string IsStatusChange = "N";
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx , " + "LicenseKey : " + LicenseKey);
                LicenseCounts(LicenseKey, Platform, IsStatusChange);
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditUser.aspx , " + "btnSave_Click() Error: " + ex.Message.ToString());

            }

            try
            {
                UserProfile userProfile = new UserProfile();
                MembershipUser user;
                //string password = Membership.GeneratePassword(8, 1);
                string password = ConfigurationManager.AppSettings.Get("DeffPass").ToString();
                //string password = "User@123";
                if (!string.IsNullOrEmpty(Request.Params["Id"]))
                {
                    userProfile = DALHelper.GetUsers(userCriteria => userCriteria.UserId == new Guid(Request.Params["id"])).First();
                    user = Membership.GetUser(this.txtUsername.Text);
                }
                else
                {
                    if (Membership.GetUser(this.txtUsername.Text) != null)
                    {
                        //this.ltrlMessage.Text = UICommon.GetErrorMessage("User already exists");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>fail();</script>", false);

                        //System.Windows.Forms.MessageBox.Show("User already exists", "Add Edit User");
                        return;
                    }

                    string ResponseMessage = ViewState["ResponseMessage"].ToString();

                    if (ResponseMessage == "Proceed")
                    {
                        //string password = "user@123";
                        user = Membership.CreateUser(this.txtUsername.Text, password);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('"+ ResponseMessage + "');</script>", false);
                        return;
                    }

                    user = Membership.GetUser(this.txtUsername.Text);
                    userProfile.CreatedDate = DateTime.Now;
                    userProfile.CreatedBy = UICommon.GetCurrentUserID();
                }

                user.IsApproved = this.chkActive.Checked;

                bool CurrentStatus = Convert.ToBoolean(ViewState["Active"]);

                string CCUser = this.ddlEnableCCUser.SelectedValue.ToString();

                if (user.IsApproved ==  true && CurrentStatus == false)
                {

                    string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                    string Platform = "BO";
                    string IsStatusChange = "Y";
                    LicenseCounts(LicenseKey, Platform, IsStatusChange);

                    if (CCUser == "Y")
                    {
                        Platform = "CC";
                        LicenseCounts(LicenseKey, Platform, IsStatusChange);

                        string ResponseMessage = ViewState["ResponseMessage"].ToString();

                        if (ResponseMessage == "Proceed")
                        {
                            Membership.UpdateUser(user);
                            userProfile.ModifiedDate = DateTime.Now;
                            userProfile.ModifiedBy = UICommon.GetCurrentUserID();
                            userProfile.UserId = new Guid(user.ProviderUserKey.ToString());
                            userProfile.FirstName = this.txtFirstName.Text;
                            userProfile.LastName = this.txtLastName.Text;
                            userProfile.Email = this.txtEmail.Text;
                            userProfile.ContacInfo = this.txtContactInfo.Text;
                            userProfile.CreatedDate = DateTime.Now;
                            userProfile.Active = this.chkActive.Checked;
                            userProfile.UserName = user.UserName;
                            int USTID = Int32.Parse(this.ddlUserType.SelectedValue.ToString());
                            userProfile.ust_ID = USTID;
                            // userProfile.UserType = ViewState["UserType"].ToString();
                            int Id = DALHelper.UpdateUserProfile(userProfile);
                            ViewState["userID"] = Id.ToString();

                            string userType = ddlUserType.SelectedItem.Text.ToString();
                            if (userType == "Depot Manager")
                            {
                                SaveDM();

                            }
                            if (userType == "Area Manager")
                            {
                                SaveDAM();

                            }
                            if (userType == "Sales Supervisor")
                            {
                                SaveDSAM();

                            }
                            if (userType == "Data Admin")
                            {
                                SaveAdmin();

                            }

                            if (userType == "Region Manager")
                            {
                                SaveSM();

                            }
                            SaveRoles();

                            SaveMapaccess();

                            SaveCCUser();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('"+ ResponseMessage + "');</script>", false);
                            return;
                        }
                    }
                    else
                    {
                        string ResponseMessage = ViewState["ResponseMessage"].ToString();

                        if (ResponseMessage == "Proceed")
                        {
                            Membership.UpdateUser(user);
                        userProfile.ModifiedDate = DateTime.Now;
                        userProfile.ModifiedBy = UICommon.GetCurrentUserID();
                        userProfile.UserId = new Guid(user.ProviderUserKey.ToString());
                        userProfile.FirstName = this.txtFirstName.Text;
                        userProfile.LastName = this.txtLastName.Text;
                        userProfile.Email = this.txtEmail.Text;
                        userProfile.ContacInfo = this.txtContactInfo.Text;
                        userProfile.CreatedDate = DateTime.Now;
                        userProfile.Active = this.chkActive.Checked;
                        userProfile.UserName = user.UserName;
                        int USTID = Int32.Parse(this.ddlUserType.SelectedValue.ToString());
                        userProfile.ust_ID = USTID;
                        // userProfile.UserType = ViewState["UserType"].ToString();
                        int Id = DALHelper.UpdateUserProfile(userProfile);
                        ViewState["userID"] = Id.ToString();

                        //ObjclsFrms.loadList("DeleteUserDivisionByUserID", "sp_Masters", Id.ToString());
                        //var SelectedDivision = ddlDivision.CheckedItems;
                        //string divi = "";
                        //string[] arr = { Id.ToString() };
                        //foreach (var item in SelectedDivision)
                        //{
                        //    divi = item.Value;
                        //    ObjclsFrms.SaveData("sp_Masters", "InsertUserDivision", divi.ToString(), arr);
                        //}

                        //string empCode;
                        //empCode = txtEmpCode.Text.ToString();
                        //string[] arrs = { empCode.ToString() };
                        //ObjclsFrms.SaveData("sp_Masters", "UpdateEmployeeCodeForUserProfile", Id.ToString(), arrs);

                        //DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForNAC", "sp_Masters");
                        //if (dtLogin.Rows.Count > 0)
                        //{
                        //    MailService(dtLogin, "BSMEA - Eclaim Account Activation for BSMEA Users", password);
                        //}
                        string userType = ddlUserType.SelectedItem.Text.ToString();
                        if (userType == "Depot Manager")
                        {


                            SaveDM();


                        }
                        if (userType == "Area Manager")
                        {


                            SaveDAM();

                        }
                        if (userType == "Sales Supervisor")
                        {


                            SaveDSAM();

                        }
                        if (userType == "Data Admin")
                        {


                            SaveAdmin();

                        }

                        if (userType == "Region Manager")
                        {


                            SaveSM();

                        }
                        SaveRoles();

                        SaveMapaccess();

                        SaveCCUser();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('"+ ResponseMessage + "');</script>", false);
                            return;
                        }
                    }
                }
                else
                {
                    if (CCUser == "Y")
                    {
                        string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                        string Platform = "CC";
                        string IsStatusChange = "N";
                        LicenseCounts(LicenseKey, Platform, IsStatusChange);

                        string ResponseMessage = ViewState["ResponseMessage"].ToString();

                        if (ResponseMessage == "Proceed")
                        {
                            Membership.UpdateUser(user);
                            userProfile.ModifiedDate = DateTime.Now;
                            userProfile.ModifiedBy = UICommon.GetCurrentUserID();
                            userProfile.UserId = new Guid(user.ProviderUserKey.ToString());
                            userProfile.FirstName = this.txtFirstName.Text;
                            userProfile.LastName = this.txtLastName.Text;
                            userProfile.Email = this.txtEmail.Text;
                            userProfile.ContacInfo = this.txtContactInfo.Text;
                            userProfile.CreatedDate = DateTime.Now;
                            userProfile.Active = this.chkActive.Checked;
                            userProfile.UserName = user.UserName;
                            int USTID = Int32.Parse(this.ddlUserType.SelectedValue.ToString());
                            userProfile.ust_ID = USTID;
                            // userProfile.UserType = ViewState["UserType"].ToString();
                            int Id = DALHelper.UpdateUserProfile(userProfile);
                            ViewState["userID"] = Id.ToString();

                            //ObjclsFrms.loadList("DeleteUserDivisionByUserID", "sp_Masters", Id.ToString());
                            //var SelectedDivision = ddlDivision.CheckedItems;
                            //string divi = "";
                            //string[] arr = { Id.ToString() };
                            //foreach (var item in SelectedDivision)
                            //{
                            //    divi = item.Value;
                            //    ObjclsFrms.SaveData("sp_Masters", "InsertUserDivision", divi.ToString(), arr);
                            //}

                            //string empCode;
                            //empCode = txtEmpCode.Text.ToString();
                            //string[] arrs = { empCode.ToString() };
                            //ObjclsFrms.SaveData("sp_Masters", "UpdateEmployeeCodeForUserProfile", Id.ToString(), arrs);

                            //DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForNAC", "sp_Masters");
                            //if (dtLogin.Rows.Count > 0)
                            //{
                            //    MailService(dtLogin, "BSMEA - Eclaim Account Activation for BSMEA Users", password);
                            //}
                            string userType = ddlUserType.SelectedItem.Text.ToString();
                            if (userType == "Depot Manager")
                            {


                                SaveDM();


                            }
                            if (userType == "Area Manager")
                            {


                                SaveDAM();

                            }
                            if (userType == "Sales Supervisor")
                            {


                                SaveDSAM();

                            }
                            if (userType == "Data Admin")
                            {


                                SaveAdmin();

                            }

                            if (userType == "Region Manager")
                            {


                                SaveSM();

                            }
                            SaveRoles();

                            SaveMapaccess();

                            SaveCCUser();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('"+ ResponseMessage + "');</script>", false);
                            return;

                        }
                    }
                    else
                    {
                        Membership.UpdateUser(user);
                        userProfile.ModifiedDate = DateTime.Now;
                        userProfile.ModifiedBy = UICommon.GetCurrentUserID();
                        userProfile.UserId = new Guid(user.ProviderUserKey.ToString());
                        userProfile.FirstName = this.txtFirstName.Text;
                        userProfile.LastName = this.txtLastName.Text;
                        userProfile.Email = this.txtEmail.Text;
                        userProfile.ContacInfo = this.txtContactInfo.Text;
                        userProfile.CreatedDate = DateTime.Now;
                        userProfile.Active = this.chkActive.Checked;
                        userProfile.UserName = user.UserName;
                        int USTID = Int32.Parse(this.ddlUserType.SelectedValue.ToString());
                        userProfile.ust_ID = USTID;
                        // userProfile.UserType = ViewState["UserType"].ToString();
                        int Id = DALHelper.UpdateUserProfile(userProfile);
                        ViewState["userID"] = Id.ToString();

                        //ObjclsFrms.loadList("DeleteUserDivisionByUserID", "sp_Masters", Id.ToString());
                        //var SelectedDivision = ddlDivision.CheckedItems;
                        //string divi = "";
                        //string[] arr = { Id.ToString() };
                        //foreach (var item in SelectedDivision)
                        //{
                        //    divi = item.Value;
                        //    ObjclsFrms.SaveData("sp_Masters", "InsertUserDivision", divi.ToString(), arr);
                        //}

                        //string empCode;
                        //empCode = txtEmpCode.Text.ToString();
                        //string[] arrs = { empCode.ToString() };
                        //ObjclsFrms.SaveData("sp_Masters", "UpdateEmployeeCodeForUserProfile", Id.ToString(), arrs);

                        //DataTable dtLogin = ObjclsFrms.loadList("SelLoginCredentailsForNAC", "sp_Masters");
                        //if (dtLogin.Rows.Count > 0)
                        //{
                        //    MailService(dtLogin, "BSMEA - Eclaim Account Activation for BSMEA Users", password);
                        //}
                        string userType = ddlUserType.SelectedItem.Text.ToString();
                        if (userType == "Depot Manager")
                        {


                            SaveDM();


                        }
                        if (userType == "Area Manager")
                        {


                            SaveDAM();

                        }
                        if (userType == "Sales Supervisor")
                        {


                            SaveDSAM();

                        }
                        if (userType == "Data Admin")
                        {


                            SaveAdmin();

                        }

                        if (userType == "Region Manager")
                        {


                            SaveSM();

                        }
                        SaveRoles();

                        SaveMapaccess();

                        SaveCCUser();
                    }
                }



            }
            catch (Exception ex)
            {
                UICommon.LogException(ex, "Add Edit User");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditUser.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);


            }
            Response.Redirect("Users.aspx");
        }
        public void SaveAdmin()
        {
            string usertype;
            string Roles = GetRolesFro();
            usertype = ddlUserType.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();




            string[] ar = { usertype,Roles };
            string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateUsertypeInUserProfile", user, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

       

        public void SaveSM()
        {
            string usertype;

            usertype = ddlUserType.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();
            string Depot = GetItemFromSM();
            string Roles = GetRolesFro();

            if (string.IsNullOrEmpty(Request.Params["Id"]))
            {

                string[] ar = { Depot , Roles };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string[] ar = { Depot };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateUserDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
        }
        public string GetItemFromSM()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = SMCheckBox.CheckedItems;

                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string user = ViewState["userID"].ToString();
                            string usertype = ddlUserType.SelectedValue.ToString();
                            createNode3(user, item.Value, usertype, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }


        public void SaveDM()
        {
            string usertype;

            usertype = ddlUserType.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();
            string Depot = GetItemFromDM();
            string Roles = GetRolesFro();

            if (string.IsNullOrEmpty(Request.Params["Id"]))
            {

                string[] ar = { Depot, Roles };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string[] ar = { Depot };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateUserDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
        }
        public string GetItemFromDM()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = cbDepot.CheckedItems;

                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string user = ViewState["userID"].ToString();
                            string usertype = ddlUserType.SelectedValue.ToString();
                            createNode3(user, item.Value, usertype, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }



        public string GetRolesFro()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");
                    int c = 0;

                    var ColelctionMarkets = rdRoles.CheckedItems;

                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            if (item.Checked == true)
                            {
                                //where 1 = 1
                                //string user = ViewState["userID"].ToString();
                                string RoleType = item.Value.ToString();
                                createNode7(RoleType, writer);
                                c++;
                            }

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode3(string userID, string DepotID, string usertype, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("usl_UserID");
            writer.WriteString(userID);
            writer.WriteEndElement();

            writer.WriteStartElement("usl_LevelID");
            writer.WriteString(DepotID);
            writer.WriteEndElement();

            writer.WriteStartElement("usl_ust_ID");
            writer.WriteString(usertype);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        private void createNode7( string RoleType, XmlWriter writer)
        {

            writer.WriteStartElement("Values");

            writer.WriteStartElement("Roles");
            writer.WriteString(RoleType);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void SaveDAM()
        {
            string usertype;
            string Roles = GetRolesFro();
            usertype = ddlUserType.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();
            string DepotArea = GetItemFromDAM();
            if (string.IsNullOrEmpty(Request.Params["Id"]))
            {
                string[] ar = { DepotArea,Roles };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string[] ar = { DepotArea };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateUserDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }


        }
        public string GetItemFromDAM()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = cbDepotAM.CheckedItems;

                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1


                            string user = ViewState["userID"].ToString();
                            string usertype = ddlUserType.SelectedValue.ToString();
                            createNode3(user, item.Value, usertype, writer);
                            c++;
                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }


        public void SaveDSAM()
        {
            string usertype;
            usertype = ddlUserType.SelectedValue.ToString();
            string Roles = GetRolesFro();

            string user = ViewState["userID"].ToString();
            string DepotSubArea = GetItemFromDSAM();
            if (string.IsNullOrEmpty(Request.Params["Id"]))
            {
                string[] ar = { DepotSubArea, Roles };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                string[] ar = { DepotSubArea};
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateUserDepot", user, ar);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Depot Area successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
        }
        public string GetItemFromDSAM()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = cbDepotSAM.CheckedItems;

                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1


                            string user = ViewState["userID"].ToString();
                            string usertype = ddlUserType.SelectedValue.ToString();
                            createNode3(user, item.Value, usertype, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }


        public void MailService(DataTable dx, string Subject, string password)
        {
            StringBuilder sb = new StringBuilder();
            string body = dx.Rows[0]["emb_Body"].ToString();

            body = body.Replace("{0}", this.txtFirstName.Text);
            body = body.Replace("{1}", txtUsername.Text.ToString());
            body = body.Replace("{2}", password);

            MailMessage message = new MailMessage();
            message.Body = body.ToString();
            message.IsBodyHtml = true;
            string email = ConfigurationManager.AppSettings.Get("NACEmail").ToString();
            message.From = new MailAddress(dx.Rows[0]["tcl_User"].ToString());

            message.To.Add(this.txtEmail.Text.ToString());
            message.To.Add(email);

            message.Subject = Subject;
            SmtpClient smtp = new SmtpClient(dx.Rows[0]["tcl_Client"].ToString());
            smtp.Credentials = new System.Net.NetworkCredential(dx.Rows[0]["tcl_User"].ToString(), dx.Rows[0]["tcl_Pass"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(message);

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Users.aspx");
        }

        public void UserTypes()
        {
            DataTable dt = ObjclsFrms.loadList("SelectUserTypeFromDrop", "sp_Masters");
            ddlUserType.DataSource = dt;
            ddlUserType.DataTextField = "ust_Name";
            ddlUserType.DataValueField = "ust_ID";
            ddlUserType.DataBind();
        }
       
        //Sales Manager
       
        public void SMCheckB()
        {
            DataTable dt = ObjclsFrms.loadList("SelSalesManager", "sp_Masters");
            SMCheckBox.DataSource = dt;
            SMCheckBox.DataTextField = "reg_Name";
            SMCheckBox.DataValueField = "reg_ID";
            SMCheckBox.DataBind();
        }

        //Depot Manager

      
        public void SMDropinDM()
        {
            DataTable dt = ObjclsFrms.loadList("SelSalesManager", "sp_Masters");
            ddlSMinDM.DataSource = dt;
            ddlSMinDM.DataTextField = "reg_Name";
            ddlSMinDM.DataValueField = "reg_ID";
            ddlSMinDM.DataBind();
        }
        public void DepotCheckB()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotDrop", "sp_Masters", ddlSMinDM.SelectedValue.ToString());
            cbDepot.DataSource = dt;
            cbDepot.DataTextField = "dep_Name";
            cbDepot.DataValueField = "dep_ID";
            cbDepot.DataBind();
        }

        //

      
        public void SMDropinAM()
        {
            DataTable dt = ObjclsFrms.loadList("SelSalesManager", "sp_Masters");
            ddlSMinAM.DataSource = dt;
            ddlSMinAM.DataTextField = "reg_Name";
            ddlSMinAM.DataValueField = "reg_ID";
            ddlSMinAM.DataBind();
        }
        public void DepotDropAM()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotDrop", "sp_Masters", ddlSMinAM.SelectedValue.ToString());
            ddlDepotAM.DataSource = dt;
            ddlDepotAM.DataTextField = "dep_Name";
            ddlDepotAM.DataValueField = "dep_ID";
            ddlDepotAM.DataBind();
        }
        public void DepotAMCheckB()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotAMDrop", "sp_Masters", ddlDepotAM.SelectedValue.ToString());
            cbDepotAM.DataSource = dt;
            cbDepotAM.DataTextField = "dpa_Name";
            cbDepotAM.DataValueField = "dpa_ID";
            cbDepotAM.DataBind();
        }


        public void Roles()
        {
            DataTable dt = ObjclsFrms.loadList("SelRolesDrop", "sp_Masters");
            rdRoles.DataSource = dt;
            rdRoles.DataTextField = "RoleName";
            rdRoles.DataValueField = "RoleId";
            rdRoles.DataBind();
        }




        public void SMDropinSS()
        {
            DataTable dt = ObjclsFrms.loadList("SelSalesManager", "sp_Masters");
            ddlSMinSS.DataSource = dt;
            ddlSMinSS.DataTextField = "reg_Name";
            ddlSMinSS.DataValueField = "reg_ID";
            ddlSMinSS.DataBind();
        }
        public void DepotDropSAM()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotDrop", "sp_Masters", ddlSMinSS.SelectedValue.ToString());
            ddlDepotSAM.DataSource = dt;
            ddlDepotSAM.DataTextField = "dep_Name";
            ddlDepotSAM.DataValueField = "dep_ID";
            ddlDepotSAM.DataBind();
        }
        public void DepotAMDropSAM()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotAMDrop", "sp_Masters", ddlDepotSAM.SelectedValue.ToString());
            ddlDepotAreaSAM.DataSource = dt;
            ddlDepotAreaSAM.DataTextField = "dpa_Name";
            ddlDepotAreaSAM.DataValueField = "dpa_ID";
            ddlDepotAreaSAM.DataBind();
        }
        public void DepotSAMCheckB()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotSAMDrop", "sp_Masters", ddlDepotAreaSAM.SelectedValue.ToString());
            cbDepotSAM.DataSource = dt;
            cbDepotSAM.DataTextField = "dsa_Name";
            cbDepotSAM.DataValueField = "dsa_ID";
            cbDepotSAM.DataBind();
        }
        //
        protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelUserTypeByID", "sp_Masters", ddlUserType.SelectedValue.ToString());
            string Usertype = lstDatas.Rows[0]["ust_Value"].ToString();
            ViewState["UserType"] = Usertype;
            
            if (Usertype == "SM")
            {
                DM.Visible = false;
                DSAM.Visible = false;
                DAM.Visible = false;
               
                SM.Visible = true;
                SMCheckB();

            }
            if (Usertype == "DM")
            {
                DM.Visible = true;
                DSAM.Visible = false;
                DAM.Visible = false;
                
                SM.Visible = false;
                SMDropinDM();

            }
            if (Usertype == "AM")
            {
                DAM.Visible = true;
                DM.Visible = false;
                DSAM.Visible = false;
               
                SM.Visible = false;
                SMDropinAM();
                //DepotDropAM();

            }
            if (Usertype == "SS")
            {
                DSAM.Visible = true;
                DM.Visible = false;
                DAM.Visible = false;
                
                SM.Visible = false;
                SMDropinSS();
                // DepotDropSAM();

            }
            
            if (Usertype == "SA")
            {
                DM.Visible = false;
                DSAM.Visible = false;
                DAM.Visible = false;
               
                SM.Visible = false;


            }

        }



        //Sales Manager
       
        //Depot Manager
      

        protected void ddlSMinDM_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            DepotCheckB();
        }
        //Area Manager
       
        protected void ddlSMinAM_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            DepotDropAM();
        }

        protected void ddlDepotAM_SelectedIndexChanged(object sender, EventArgs e)
        {
            DepotAMCheckB();
        }

        //Sales Supervisor

       

        protected void ddlSMinSS_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotDropSAM();
        }
        protected void ddlDepotSAM_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotAMDropSAM();
        }

        protected void ddlDepotAreaSAM_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotSAMCheckB();
        }

        protected void ddlSMinSS_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotDropSAM();
        }

       
        protected void ddlSMinDM_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotCheckB();
        }

       
        protected void ddlSMinAM_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DepotDropAM();
        }

        public void SaveRoles()
        {           
            string Roles = GetRolesFro();           
            string user = ViewState["userID"].ToString();
            string[] ar = { Roles };
            string Value = ObjclsFrms.SaveData("sp_Masters", "saveUserRoles", user, ar);
            //int res = Int32.Parse(Value.ToString());
         
        }
        public void SaveMapaccess()
        {
           
            string Access = this.ddlAccess.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();
            string[] ar = { Access };
            string Value = ObjclsFrms.SaveData("sp_Masters", "saveMapAccess", user, ar);
            //int res = Int32.Parse(Value.ToString());

        }
         public void SaveCCUser()
        {
           
            string EnableCCuser = this.ddlEnableCCUser.SelectedValue.ToString();
            string user = ViewState["userID"].ToString();
            string[] ar = { EnableCCuser };
            string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCCUser", user, ar);
            //int res = Int32.Parse(Value.ToString());

        }
        

    }
}