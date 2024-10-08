using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Configuration;
using ExcelLibrary.BinaryFileFormat;
using System.IO;
using System.Net;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using SalesForceAutomation.BO_Digits.ar;
using DocumentFormat.OpenXml.Math;
using static Stimulsoft.Base.Plans.StiCloudPlans;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class en_master : System.Web.UI.MasterPage
    {
        GeneralFunctions Obj = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["UserID"] != null)
                    {
                        string userID = Session["UserID"].ToString();
                        string UserName = Session["UserName"].ToString();
                        string name = Session["Name"].ToString();
                        this.lblName.Text = name;
                        this.lblEmail.Text = UserName;

                        LicenseNotification();

                        LoadMenu();
                        LoadLangs();

                        LoadBreadCrumb();

                       
                    }
                    else
                    {
                        Obj.TraceService("Exception from en page load:Session[UserID] is null ");
                        Response.Redirect("../../SignIn.aspx");
                    }
                }
                catch (Exception ex)
                {
                    Obj.TraceService("Exception from en page load: " + ex.Message.ToString());

                    Response.Redirect("../../SignIn.aspx");
                }

            }
        }

        public void LicenseNotification()
        {
            try
            {
                string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");               
                string Platform = "";
                string IsStatusChange = "N";
                Obj.TraceService(UICommon.GetLogFileName() + " en_master  , " + "LicenseKey : " + LicenseKey);
                LicenseCounts(LicenseKey, Platform, IsStatusChange);
            }
            catch (Exception ex)
            {
                Obj.TraceService(UICommon.GetLogFileName() + " en_master , " + "Page_Load() Error: " + ex);
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
                Obj.TraceService(UICommon.GetLogFileName() + " en_master  -  WebServiceCall() , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }

        public void LicenseCounts(string LicenseKey, string Platform, string IsStatusChange)
        {
            Obj.TraceService(UICommon.GetLogFileName() + " en_master-1 , " + "Inside LicenseCounts()");
            try
            {

                DataTable lstActive = Obj.loadList("LicenseMasterCounts", "sp_LicenseManagement");
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

                Obj.TraceService(UICommon.GetLogFileName() + "en_master-1 , " + "JSONStr : " + JSONStr);
                Obj.TraceService(UICommon.GetLogFileName() + "en_master-1 , " + "url : " + url);
                Obj.TraceService(UICommon.GetLogFileName() + "en_master-1 , " + "Json : " + Json);

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
                    string AlertMessage = result["AlertMessage"].ToString();

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
                        string BufferPeriodInDays = licenseData["BufferPeriodInDays"]?.ToString();
                        string Prior_Exp_Notfctn_Intrvl_InDays = licenseData["Prior_Exp_Notfctn_Intrvl_InDays"]?.ToString();
                        string NeedExpiryNotification = licenseData["NeedExpiryNotification"]?.ToString();

                        string RouteLimit = licenseData["UserLimit"]?.ToString();
                        string CusConnectLimit = licenseData["CusConnectLimit"]?.ToString();
                        string InvLimit = licenseData["InvLimit"]?.ToString();
                        string BOLimit = licenseData["BOLimit"]?.ToString();


                        int RotBal = Int32.Parse(RouteLimit.ToString()) - Int32.Parse(RouteCount.ToString());
                        int InvBal = Int32.Parse(InvLimit.ToString()) - Int32.Parse(InvUserCount.ToString());
                        int CCBal = Int32.Parse(CusConnectLimit.ToString()) - Int32.Parse(CCUserCount.ToString());
                        int BOBal = Int32.Parse(BOLimit.ToString()) - Int32.Parse(BOUserCount.ToString());


                        if (resCode == "200")
                        {
                            DateTime ExpiryDate = DateTime.Parse(ExpDate);

                            if (ExpiryDate < DateTime.Now) // Check if the expiry date is in the past
                            {                              
                                lblDangerAlertMessage.Text = AlertMessage;
                                DangerAlert.Visible = true;
                                WarningAlert.Visible = false;
                                PrimaryAlert.Visible = false;
                            }
                            else if (Status == "Cancelled")
                            {
                                lblDangerAlertMessage.Text = AlertMessage;
                                DangerAlert.Visible = true;
                                WarningAlert.Visible = false;
                                PrimaryAlert.Visible = false;
                            }
                            else
                            {
                                if (RotBal <= 0 || InvBal <= 0 || CCBal <= 0 || BOBal <= 0)
                                {
                                    
                                    if (NeedExpiryNotification == "Yes")
                                    {
                                        int PriorExpNotiDay = Int32.Parse(Prior_Exp_Notfctn_Intrvl_InDays);

                                        if (ExpiryDate.AddDays(-PriorExpNotiDay) <= DateTime.Now)
                                        {
                                            lblDangerAlertMessage.Text = AlertMessage;
                                            DangerAlert.Visible = true;
                                            WarningAlert.Visible = false;
                                            PrimaryAlert.Visible = false;
                                        }
                                        else
                                        {
                                            lblDangerAlertMessage.Text = AlertMessage;
                                            DangerAlert.Visible = true;
                                            WarningAlert.Visible = false;
                                            PrimaryAlert.Visible = false;
                                        }
                                    }
                                    else
                                    {
                                        lblDangerAlertMessage.Text = AlertMessage;
                                        DangerAlert.Visible = true;
                                        WarningAlert.Visible = false;
                                        PrimaryAlert.Visible = false;
                                    }
                                }
                                else
                                {
                                    if (NeedExpiryNotification == "Yes")
                                    {
                                        int PriorExpNotiDay = Int32.Parse(Prior_Exp_Notfctn_Intrvl_InDays);

                                        if (ExpiryDate.AddDays(-PriorExpNotiDay) <= DateTime.Now)
                                        {
                                            lblWarningAlertMessage.Text = AlertMessage;
                                            DangerAlert.Visible = false;
                                            WarningAlert.Visible = true;
                                            PrimaryAlert.Visible = false;
                                        }
                                        else
                                        {
                                            // No need to show any alert here...
                                        }
                                    }
                                    else
                                    {
                                        // No need to show any alert here...License Limit not exeeded
                                    }
                                   
                                }


                            }
                        }
                        else
                        {
                            Obj.TraceService(UICommon.GetLogFileName() + " en_master-1 , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        Obj.TraceService(UICommon.GetLogFileName() + "en_master-1 , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    Obj.TraceService(UICommon.GetLogFileName() + "en_master-1 , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch (Exception ex)
            {
                Obj.TraceService(UICommon.GetLogFileName() + " en_master-1 , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }

            Obj.TraceService(UICommon.GetLogFileName() + " en_master-1 , " + "LicenseCounts() ends here.");
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
            public string AlertMessage { get; set; }
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

        //public void LoadMenu()
        //{
        //    StringBuilder sb = new StringBuilder();
        //    string userID = UICommon.GetCurrentUserID().ToString();
        //    string lang = Session["lang"].ToString();
        //    string[] arr = { lang };
        //    lblActlang.Text = lang;
        //    if (Session["dtLeftNav"] == null)
        //    {
        //        DataSet dtLeft = Obj.loadList("SelLeftNavs", "sp_LeftNavigation", userID, arr, true);
        //        Session["dtLeftNav"] = dtLeft;
        //    }

        //    DataSet dtSet = (DataSet)Session["dtLeftNav"];
        //    DataTable dt = dtSet.Tables[0];
        //    DataTable dtDetail = dtSet.Tables[1];
        //    string URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + lang + "/";

        //    if (dt.Rows.Count > 0)
        //    {
        //        string facID = "";
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            string Name = dr["Name"].ToString();
        //            string Position = dr["Position"].ToString();
        //            string icon = dr["icon"].ToString();

        //            if (Position == "-1")
        //            {
        //                sb.AppendFormat("<div class=\"menu-item pt-5\">" +
        //                    "<div class=\"menu-content\">" +
        //                    "<span class=\"menu-heading fw-bold text-uppercase fs-7\" style=\"color:#080500 !important\">{0}</span>" +
        //                    "</div>" +
        //                    "</div>", Name);

        //            }
        //            else if (Position == "0")
        //            {
        //                string show = "";
        //                StringBuilder sbDetail = new StringBuilder();
        //                facID = dr["fac_ID"].ToString();
        //                var url = Request.Url.AbsolutePath.ToString().Substring(1);

        //                DataRow[] drDetail = dtDetail.Select("Parent_fac_ID = " + facID);
        //                foreach (DataRow drx in drDetail)
        //                {
        //                    string URL = "";
        //                    string active = "";

        //                    string NameDetail = drx["Name"].ToString();
        //                    URL = URLRoot + drx["URL"].ToString();
        //                    string Pos1_fac_ID = drx["fac_ID"].ToString();
        //                    string Pos = drx["Position"].ToString();

        //                    DataRow[] drPosition = dtDetail.Select("Parent_fac_ID = " + Pos1_fac_ID);

        //                    foreach (DataRow drxPos in drPosition)
        //                    {
        //                        string URLPos = URLRoot + drxPos["URL"].ToString();
        //                        if (URLPos == url)
        //                        {
        //                            active = "active";
        //                            show = "show";
        //                        }
        //                    }

        //                    if (URL == url)
        //                    {
        //                        active = "active";
        //                        show = "show";
        //                    }
        //                    if (Pos.Equals("1"))
        //                    {
        //                        sbDetail.AppendFormat("" +
        //                          "<div class=\"menu-item\">" +
        //                          "<a class=\"menu-link {2}\" href=\"{0}\">" +
        //                          "<span class=\"menu-bullet\">" +
        //                          "<span class=\"bullet bullet-dot\"></span>" +
        //                          "</span>" +
        //                          "<span class=\"menu-title\">{1}</span>" +
        //                          "</a>" +
        //                          "</div>", "../../" + URL, NameDetail, active);
        //                    }

        //                }




        //                sb.AppendFormat("<div data-kt-menu-trigger=\"click\" class=\"menu-item {0} menu-accordion\">", show);
        //                sb.AppendFormat("<span class=\"menu-link\">" +
        //                    "<span class=\"menu-icon\">" +
        //                    "<span class=\"svg-icon svg-icon-2\">{0}</span>" +
        //                    "</span>" +
        //                    "<span class=\"menu-title\">{1}</span>" +
        //                    "<span class=\"menu-arrow\"></span>" +
        //                    "</span> <div class=\"menu-sub menu-sub-accordion\">", icon, Name);

        //                sb.Append(sbDetail.ToString());

        //                sb.Append("</div>");
        //                sb.Append("</div>");


        //            }
        //        }
        //    }

        //    ltrlMenu.Text = sb.ToString();
        //}

        //New Leftnav 

        public void LoadMenu()
        {
            StringBuilder sb = new StringBuilder();
            string userID = UICommon.GetCurrentUserID().ToString();
            string lang = Session["lang"].ToString();
            string[] arr = { lang };
            lblActlang.Text = lang;
            //if (Session["dtLeftNav"] == null)
            //{
            DataSet dtLeft = Obj.loadList("SelLeftNavs", "sp_LeftNavigation", userID, arr, true);
            Session["dtLeftNav"] = dtLeft;
            //}

            DataSet dtSet = (DataSet)Session["dtLeftNav"];
            DataTable dt = dtSet.Tables[0];
            DataTable dtDetail = dtSet.Tables[1];
            string URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + lang + "/";

            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    string Name = dr["Name"].ToString();
                    string Position = dr["Position"].ToString();
                    string icon = dr["icon"].ToString();
                    string HasChild = dr["HasChild"].ToString();
                    string URL = URLRoot + dr["URL"].ToString();
                    string facID = dr["fac_ID"].ToString();
                    string active = "";
                    string show = "";
                    var url = Request.Url.AbsolutePath.ToString().Substring(1);
                    if (Position == "-1")
                    {
                        sb.AppendFormat("<div class=\"menu-item pt-5\">" +
                            "<div class=\"menu-content\">" +
                            "<span class=\"menu-heading fw-bold text-uppercase fs-7\" style=\"color:#080500 !important\">{0}</span>" +
                            "</div>" +
                            "</div>", Name);

                    }
                    else if (Position == "0" && HasChild == "1")
                    {

                        StringBuilder sbDetail = new StringBuilder();
                        facID = dr["fac_ID"].ToString();


                        DataRow[] drDetail = dtDetail.Select("Parent_fac_ID = " + facID);
                        foreach (DataRow drx in drDetail)
                        {
                            active = "";
                            active = "";

                            string NameDetail = drx["Name"].ToString();
                            URL = URLRoot + drx["URL"].ToString();
                            string Pos1_fac_ID = drx["fac_ID"].ToString();
                            string Pos = drx["Position"].ToString();

                            DataRow[] drPosition = dtDetail.Select("Parent_fac_ID = " + Pos1_fac_ID);

                            foreach (DataRow drxPos in drPosition)
                            {
                                string URLPos = URLRoot + drxPos["URL"].ToString();
                                if (URLPos == url)
                                {
                                    active = "active";
                                    show = "show";
                                }
                            }

                            if (URL == url)
                            {
                                active = "active";
                                show = "show";
                            }
                            if (Pos.Equals("1"))
                            {
                                sbDetail.AppendFormat("" +
                                  "<div class=\"menu-item\">" +
                                  "<a class=\"menu-link {2}\" href=\"{0}\">" +
                                  "<span class=\"menu-bullet\">" +
                                  "<span class=\"bullet bullet-dot\"></span>" +
                                  "</span>" +
                                  "<span class=\"menu-title\">{1}</span>" +
                                  "</a>" +
                                  "</div>", "../../" + URL, NameDetail, active);
                            }

                        }




                        sb.AppendFormat("<div data-kt-menu-trigger=\"click\" class=\"menu-item {0} menu-accordion\">", show);
                        sb.AppendFormat("<span class=\"menu-link\">" +
                            "<span class=\"menu-icon\">" +
                            "<span class=\"svg-icon svg-icon-2\">{0}</span>" +
                            "</span>" +
                            "<span class=\"menu-title\">{1}</span>" +
                            "<span class=\"menu-arrow\"></span>" +
                            "</span> <div class=\"menu-sub menu-sub-accordion\">", icon, Name);

                        sb.Append(sbDetail.ToString());

                        sb.Append("</div>");
                        sb.Append("</div>");


                    }
                    else if (Position == "0" && HasChild == "0")
                    {
                        DataRow[] drPosition = dtDetail.Select("Parent_fac_ID = " + facID);
                        foreach (DataRow drxPos in drPosition)
                        {
                            string URLPos = URLRoot + drxPos["URL"].ToString();
                            if (URLPos == url)
                            {
                                active = "active";
                                show = "show";
                            }
                        }

                        if (URL == url)
                        {
                            active = "active";
                            show = "show";
                        }

                        sb.AppendFormat("" +
                                       "<div class=\"menu-item\">" +
                                       "<a class=\"menu-link {2}\" href=\"{0}\">" +
                                       "<span class=\"menu-bullet\">" +
                                       "<span class=\"bullet bullet-dot\"></span>" +
                                       "</span>" +
                                       "<span class=\"menu-title\">{1}</span>" +
                                       "</a>" +
                                       "</div>", "../../" + URL, Name, active);
                    }
                }
            }

            ltrlMenu.Text = sb.ToString();
        }

        public void LoadLangs()
        {
            StringBuilder sb = new StringBuilder();
            if (Session["dtLanguages"] == null)
            {
                DataTable dtLeft = Obj.loadList("selLanguages", "sp_LeftNavigation");
                Session["dtLanguages"] = dtLeft;
            }

            DataTable dt = (DataTable)Session["dtLanguages"];

            rptLmags.DataSource = dt;
            rptLmags.DataBind();
            
        }

        public void LoadBreadCrumb()
        {
            StringBuilder sb = new StringBuilder();
            string URLRoot = "/" +  ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"].ToString() + "/";
            var url = Request.Url.AbsolutePath.ToString().Replace(URLRoot, "");
            string[] arr = { Session["lang"].ToString() };
            DataSet dxSet = Obj.loadList("SelbreadCrumbs", "sp_LeftNavigation" , url, arr, true);

            DataTable dx = dxSet.Tables[1];
            DataTable dxHeader = dxSet.Tables[0];

            if (dxHeader.Rows.Count > 0)
            {
                lblHeading.Text = dxHeader.Rows[0]["Heading"].ToString();
            }

            foreach (DataRow dr in dx.Rows)
            {
               
                string cr_url = dr["URL"].ToString();
                string cr_Name = dr["BreadCrumb"].ToString();
                string Params = dr["bcm_Params"].ToString();
                string appendParas = "";
                if (cr_url == "#")
                {
                    sb.AppendFormat("<li class=\"breadcrumb-item text-muted\">{0}</li>", cr_Name);
                }
                else
                {
                    try
                    {
                        if (!Params.Equals(""))
                        {
                            string[] paras = Params.Split(',');
                            for (int i = 0; i < paras.Length; i++)
                            {
                                if (i == 0)
                                {
                                    appendParas = "?";
                                }
                                appendParas += paras[i].ToString() + "=" + Request.Params[paras[i].ToString()].ToString() + "&";
                            }
                        }
                    }
                    catch
                    {

                    }
                    sb.AppendFormat("<li class=\"breadcrumb-item text-muted\"><a href = \"{0}\" class=\"text-muted text-hover-primary\">{1}</a>", URLRoot + cr_url+ appendParas, cr_Name);
                    sb.Append("</li><li class=\"breadcrumb-item\"><span class=\"bullet bg-gray-400 w-5px h-2px\"></span></li>");
                }
            }

            ltrlCrumbs.Text = sb.ToString();
        }

        protected void lnkLang_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            Label lblCode = (Label) lnk.FindControl("lblLngCode");
          
            string URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"].ToString() + "/";
            var url = Request.Url.ToString().Replace(URLRoot , "");
            var urll = Request.Url.GetLeftPart(UriPartial.Authority).ToString().Replace(URLRoot, "");
            url = url.Replace(urll, "");
            Session["lang"] = lblCode.Text.ToString();
            URLRoot = ConfigurationManager.AppSettings.Get("WebURL") + Session["lang"].ToString() +  url;
            Response.Redirect("../../" + URLRoot);

        }
    }
}