using DocumentFormat.OpenXml.Office2013.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using static Stimulsoft.Report.Func;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using SalesForceAutomation.Admin;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using GoogleApi.Entities.Common.Enums;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                try
                {
                    string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                    string Platform = "USER";
                    string IsStatusChange = "N";
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + " ListRoute.aspx  , " + "LicenseKey : " + LicenseKey);
                    LicenseCounts(LicenseKey, Platform, IsStatusChange);
                }
                catch (Exception ex)
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + " LicenseManagement.aspx-1 , " + "Page_Load() Error: " + ex.Message.ToString());
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }

                user();
                DepotSubArea();
                Vehicles();
                HelperinOne();
                HelperinTwo();
                FillForm();
                Profile();
                Users();
                //  txtTransName.Text = "Merchandising";
                ViewState["rotusr"] = "";
                rdeffectivedate.MinDate = DateTime.Now.AddDays(1);
                rdeffectivedatetodel.MinDate = DateTime.Now.AddDays(1);
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
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "  ListRoute.aspx - WebServiceCall()  , " + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }
        public void LicenseCounts(string LicenseKey, string Platform, string IsStatusChange)
        {
            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Inside LicenseCounts()");

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

                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditRoute.aspx  , " + "JSONStr : " + JSONStr);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditRoute.aspx  , " + "url : " + url);
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditRoute.aspx  , " + "Json : " + Json);

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
                            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Error: " + message);
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
                        }
                    }
                    else
                    {
                        ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditRoute.aspx  , " + "Error: licenseDataArray count 0.");
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    }
                }
                else
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + "AddEditRoute.aspx  , " + "Error: Json Null.");
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Error: " + ex);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }

            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "LicenseCounts() ends here.");
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


        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectRoutesByID", "sp_Backend", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, username, code, status, pass, unload, deviceid, stlmnt, enforcejp, odometer, rottype, promode, rtntype, lodRej, VantoVan, EnOptCreation,
                    arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit, LoadOutEdit, LoadOutExcessAllow, Depot, paymode, suglodreq, endorsement,
                    InventoryOutMode, CusTransOutMode, AltRotCode, EnableHelper, Helper1, Helper2, Vehicle, TransName, VanStockAllow, NonVanStockAllow,
                    RtnAplAttribute, OpnRtnImg, ResRtnImg, SchRtnImg, OptRtnApl, ResRtnApl, SysStock, GRImag, LTApprvl, JPSeq, SchVisit, WeekEndDays, GRImgMand, BRImgMand, pettycash, AssetTracking, ServiceReq,
                    IsVehicleNoMand, EnbVehicle, AdvPay, VanApproval, SettleFrom, pettyLimit, InvTrans, FenceRadius, CusTrans, MerchTrans, FSTrans, ARManAlloc, ERP_Inventory_Req_Location, ERP_Inventory_Location,
                    InvReconfAppr, varlimit, FutExpDel, logoutafter, HelperMand, EnforceNotification, EnableCoupon, IsBankUpdate, EnableCouponLeaf, LoadIn, LoadOut, Inventory;

                AssetTracking = lstDatas.Rows[0]["rot_EnableKPIAstTracking"].ToString();
                ServiceReq = lstDatas.Rows[0]["rot_EnableKPIServReq"].ToString();

                name = lstDatas.Rows[0]["rot_Name"].ToString();
                username = lstDatas.Rows[0]["usr_ID"].ToString();
                code = lstDatas.Rows[0]["rot_Code"].ToString();
                pass = lstDatas.Rows[0]["rot_Pass"].ToString();
                unload = lstDatas.Rows[0]["rot_IsUnload"].ToString();
                deviceid = lstDatas.Rows[0]["rot_DeviceID"].ToString();
                stlmnt = lstDatas.Rows[0]["rot_AllowSetlmntDiscrepancy"].ToString();
                enforcejp = lstDatas.Rows[0]["EnforceJP"].ToString();
                odometer = lstDatas.Rows[0]["rot_EnableOdometer"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                ViewState["CurrentStatus"] = status;

                rottype = lstDatas.Rows[0]["rot_Type"].ToString();
                promode = lstDatas.Rows[0]["rot_ProductiveVisit"].ToString();

                arabic = lstDatas.Rows[0]["rot_ArabicName"].ToString();
                rotcheck = lstDatas.Rows[0]["IsRoutineCheck"].ToString();
                loadinSign = lstDatas.Rows[0]["EnableloadinSign"].ToString();
                loadTransferSign = lstDatas.Rows[0]["EnableloadTransferSign"].ToString();
                LoadoutSign = lstDatas.Rows[0]["EnableLoadOutSign"].ToString();
                LoadReq = lstDatas.Rows[0]["rot_isLoadReq"].ToString();
                LoadTransfer = lstDatas.Rows[0]["rot_isLoadTransfer"].ToString();
                LoadInEdit = lstDatas.Rows[0]["rot_isLoadInEdit"].ToString();
                LoadOutEdit = lstDatas.Rows[0]["rot_isLoadOutEdit"].ToString();
                LoadOutExcessAllow = lstDatas.Rows[0]["isLoadOutExcessAllow"].ToString();
                Depot = lstDatas.Rows[0]["dsa_ID"].ToString();
                paymode = lstDatas.Rows[0]["rot_settlement"].ToString();
                suglodreq = lstDatas.Rows[0]["EnableSuggestedLODReq"].ToString();
                rtntype = lstDatas.Rows[0]["rot_ReturnType"].ToString();
                lodRej = lstDatas.Rows[0]["rot_EnableLoadRejection"].ToString();
                VantoVan = lstDatas.Rows[0]["rot_EnableVantoVan"].ToString();
                EnOptCreation = lstDatas.Rows[0]["rot_EnableOptCreation"].ToString();
                endorsement = lstDatas.Rows[0]["rot_IsEndorsementEnabled"].ToString();
                InventoryOutMode = lstDatas.Rows[0]["InventoryOutMode"].ToString();
                CusTransOutMode = lstDatas.Rows[0]["CusTransOutMode"].ToString();
                AltRotCode = lstDatas.Rows[0]["rot_AltRotCode"].ToString();

                EnableHelper = lstDatas.Rows[0]["rot_EnableHelper"].ToString();
                Helper1 = lstDatas.Rows[0]["rot_Helper1_ID"].ToString();
                Helper2 = lstDatas.Rows[0]["rot_Helper2_ID"].ToString();
                Vehicle = lstDatas.Rows[0]["rot_veh_ID"].ToString();
                TransName = lstDatas.Rows[0]["rot_TransName"].ToString();
                VanStockAllow = lstDatas.Rows[0]["rot_VanstockExcessAllow"].ToString();
                NonVanStockAllow = lstDatas.Rows[0]["rot_NonvanstockAllow"].ToString();
                RtnAplAttribute = lstDatas.Rows[0]["rot_BadReturnUnload"].ToString();
                OpnRtnImg = lstDatas.Rows[0]["rot_OpnRtnImg"].ToString();
                ResRtnImg = lstDatas.Rows[0]["rot_RestrictedRtnImg"].ToString();
                SchRtnImg = lstDatas.Rows[0]["rot_ScheduledRtnImg"].ToString();
                //OptRtnApl,ResRtnApl,SysStock
                OptRtnApl = lstDatas.Rows[0]["rot_OpenRtnApproval"].ToString();
                ResRtnApl = lstDatas.Rows[0]["rot_RestrictedRtnApproval"].ToString();
                SysStock = lstDatas.Rows[0]["rot_IsSystemStkEnable"].ToString();
                GRImag = lstDatas.Rows[0]["rot_GRImage"].ToString();
                LTApprvl = lstDatas.Rows[0]["rot_IsLoadTransApprvlEnable"].ToString();
                JPSeq = lstDatas.Rows[0]["rot_EnforceJrnyplanSeq"].ToString();
                SchVisit = lstDatas.Rows[0]["rot_EnforceSchVisit"].ToString();
                WeekEndDays = lstDatas.Rows[0]["rot_Weekend_Days"].ToString();
                GRImgMand = lstDatas.Rows[0]["rot_GRImg_IsMandatory"].ToString();
                BRImgMand = lstDatas.Rows[0]["rot_BRImg_IsMandatory"].ToString();
                pettycash = lstDatas.Rows[0]["rot_EnablePettyCash"].ToString();
                string[] ar = paymode.Split('-');
                string[] arrOpnRtnApl = OptRtnApl.Split('-');
                string[] arrResRtnApl = ResRtnApl.Split('-');
                string[] arrGRImg = GRImag.Split('-');
                string[] arrGRImgmand = GRImgMand.Split('-');
                string[] arrBRImgmand = BRImgMand.Split('-');
                IsVehicleNoMand = lstDatas.Rows[0]["rot_IsVehicleNo_Mand"].ToString();
                EnbVehicle = lstDatas.Rows[0]["rot_EnableVehicle"].ToString();
                AdvPay = lstDatas.Rows[0]["rot_IsAdvPayment"].ToString();
                VanApproval = lstDatas.Rows[0]["rot_VanToVan_Approval"].ToString();
                SettleFrom = lstDatas.Rows[0]["rot_SettlementFrom"].ToString();
                pettyLimit = lstDatas.Rows[0]["rot_PettyCash_Limit"].ToString();
                InvTrans = lstDatas.Rows[0]["rot_InvTrans"].ToString();
                string[] it = InvTrans.Split('-');
                FenceRadius = lstDatas.Rows[0]["rot_FencingRadius"].ToString();
                CusTrans = lstDatas.Rows[0]["rot_CusTrans"].ToString();
                string[] ct = CusTrans.Split('-');
                MerchTrans = lstDatas.Rows[0]["rot_MerchTrans"].ToString();
                string[] mt = MerchTrans.Split('-');
                FSTrans = lstDatas.Rows[0]["rot_FieldServiceTrans"].ToString();
                string[] ft = FSTrans.Split('-');
                ARManAlloc = lstDatas.Rows[0]["rot_ARManualAlloc"].ToString();
                ERP_Inventory_Req_Location = lstDatas.Rows[0]["ERP_Inventory_Req_Location"].ToString();
                ERP_Inventory_Location = lstDatas.Rows[0]["ERP_Inventory_Location"].ToString();
                InvReconfAppr = lstDatas.Rows[0]["rot_EnableInvReconfApproval"].ToString();
                varlimit = lstDatas.Rows[0]["rot_SetlmntVarLimit"].ToString();
                FutExpDel = lstDatas.Rows[0]["rot_EnableFutureExpDel"].ToString();
                logoutafter = lstDatas.Rows[0]["rot_EnableLogoutafterendday"].ToString();

                HelperMand = lstDatas.Rows[0]["rot_HelperMand"].ToString();
                EnforceNotification = lstDatas.Rows[0]["rot_EnforceNotification"].ToString();
                EnableCoupon = lstDatas.Rows[0]["rot_EnableCoupon"].ToString();
                IsBankUpdate = lstDatas.Rows[0]["rot_IsBankUpdate"].ToString();
                EnableCouponLeaf = lstDatas.Rows[0]["rot_EnableCouponLeaf"].ToString();
                LoadIn = lstDatas.Rows[0]["rot_IsLoadIn"].ToString();
                LoadOut = lstDatas.Rows[0]["rot_IsLoadOut"].ToString();
                Inventory = lstDatas.Rows[0]["rot_IsInventory"].ToString();



                ViewState["rotusr"] = username.ToString();
                ddlAssetTracking.SelectedValue = AssetTracking.ToString();
                ddlServiceReq.SelectedValue = ServiceReq.ToString();
                ddlPettycash.SelectedValue = pettycash.ToString();
                txtname.Text = name.ToString();
                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                ddlname.SelectedValue = username.ToString();
                txtpass.Text = pass.ToString();
                ddlis.SelectedValue = unload.ToString();
                txtdeviceid.Text = deviceid.ToString();
                ddlstlmnt.SelectedValue = stlmnt.ToString();
                ddlenforcejp.SelectedValue = enforcejp.ToString();
                ddlodometer.SelectedValue = odometer.ToString();
                ddlStats.SelectedValue = status.ToString();
                txtcode.Enabled = false;
                ddlrotType.SelectedValue = rottype.ToString();
                txtvarlimit.Text = varlimit.ToString();

                txtArabicname.Text = arabic.ToString();
                ddlRC.SelectedValue = rotcheck.ToString();
                ddlLIS.SelectedValue = loadinSign.ToString();
                ddlLTS.SelectedValue = loadTransferSign.ToString();
                ddlLOS.SelectedValue = LoadoutSign.ToString();
                ddlLR.SelectedValue = LoadReq.ToString();
                ddlLT.SelectedValue = LoadTransfer.ToString();
                ddlLEdit.SelectedValue = LoadInEdit.ToString();
                ddlLOEdit.SelectedValue = LoadOutEdit.ToString();
                ddlLOExcess.SelectedValue = LoadOutExcessAllow.ToString();
                ddlDepot.SelectedValue = Depot.ToString();
                rcbsugloreq.SelectedValue = suglodreq.ToString();
                rcbreturnType.SelectedValue = rtntype.ToString();
                rcbLodRej.SelectedValue = lodRej.ToString();
                rcbVantoVan.SelectedValue = VantoVan.ToString();
                ddlEnOpt.SelectedValue = EnOptCreation.ToString();
                ddlEndorsement.SelectedValue = endorsement.ToString();
                rdCusOutMode.SelectedValue = CusTransOutMode.ToString();
                rdInvOutMode.SelectedValue = InventoryOutMode.ToString();
                txtAltRotCode.Text = AltRotCode.ToString();

                ddEnableHelper.SelectedValue = EnableHelper.ToString();
                ddlHelper1.SelectedValue = Helper1.ToString();
                ddlHelper2.SelectedValue = Helper2.ToString();
                ddlVehicleID.SelectedValue = Vehicle.ToString();
                // txtTransName.Text = TransName.ToString();
                ddlVanstockexcessallow.SelectedValue = VanStockAllow.ToString();
                ddlNonvanstockallow.SelectedValue = NonVanStockAllow.ToString();
                ddlattribute.SelectedValue = RtnAplAttribute.ToString();
                ddlOpnRtnImg.SelectedValue = OpnRtnImg.ToString();
                ddlResRtnImg.SelectedValue = ResRtnImg.ToString();
                ddlSchRtnImg.SelectedValue = SchRtnImg.ToString();
                ddlLTApproval.SelectedValue = LTApprvl.ToString();
                ddlJPlanSeq.SelectedValue = JPSeq.ToString();
                ddlSchVisit.SelectedValue = SchVisit.ToString();
                ddlWeekendDays.SelectedValue = WeekEndDays.ToString();
                ddlIsVehicleNo.SelectedValue = IsVehicleNoMand.ToString();
                ddlEnbVehicle.SelectedValue = EnbVehicle.ToString();
                rdAdvPay.SelectedValue = rdAdvPay.ToString();
                ddlVavApproval.SelectedValue = VanApproval.ToString();
                ddlSettlefrom.SelectedValue = SettleFrom.ToString();
                txtPettyLimit.Text = pettyLimit.ToString();
                rdFence.Text = FenceRadius.ToString();
                ddlARManAalloc.SelectedValue = ARManAlloc.ToString();
                txtInvReqLoc.Text = ERP_Inventory_Req_Location.ToString();
                txtInvLoc.Text = ERP_Inventory_Location.ToString();
                ddlInvReconfAppr.SelectedValue = InvReconfAppr.ToString();
                ddlFutExpDel.SelectedValue = FutExpDel.ToString();
                ddllogoutaftr.SelectedValue = logoutafter.ToString();

                ddlHelperMand.SelectedValue = HelperMand.ToString();
                ddlEnforceNotification.SelectedValue = EnforceNotification.ToString();
                ddlEnableCoupon.SelectedValue = EnableCoupon.ToString();
                ddlIsBankUpdate.SelectedValue = IsBankUpdate.ToString();
                ddlEnableCouponLeaf.SelectedValue = EnableCouponLeaf.ToString();
                ddlIsLoadIn.SelectedValue = LoadIn.ToString();
                ddlIsLoadOut.SelectedValue = LoadOut.ToString();
                ddlIsInventory.SelectedValue = Inventory.ToString();

                ddlname.Enabled = false;
                lblcurrentusr.Text = ddlname.SelectedItem.Text.ToString();


                if ((rottype == "OR") || (rottype == "DL") || (rottype == "AR") || (rottype == "SL"))
                {
                    pnlProdVisits.Visible = false;
                    pnlOA.Visible = false;
                    pnlMerch.Visible = false;
                    pnlFS.Visible = false;
                }
                else if (rottype == "OA")
                {
                    pnlProdVisits.Visible = true;
                    pnlOA.Visible = true;
                    pnlMerch.Visible = false;
                    pnlFS.Visible = false;
                    ddlProdVisitsOA.SelectedValue = promode.ToString();

                }
                else if (rottype == "MER")
                {
                    pnlProdVisits.Visible = true;
                    pnlOA.Visible = false;
                    pnlMerch.Visible = true;
                    pnlFS.Visible = false;
                    ddlProdVisitsMerch.SelectedValue = promode.ToString();
                }
                else if (rottype == "FS")
                {
                    pnlProdVisits.Visible = true;
                    pnlOA.Visible = false;
                    pnlMerch.Visible = false;
                    pnlFS.Visible = true;
                    ddlProdVisitsFS.SelectedValue = promode.ToString();
                }
                else
                {
                    pnlProdVisits.Visible = false;
                    pnlOA.Visible = false;
                    pnlMerch.Visible = false;
                    pnlFS.Visible = false;
                }

                if (EnableHelper == "Y")
                {
                    aspHelper1.Visible = true;
                    aspHelper2.Visible = true;

                }
                if (pettycash == "Y")
                {
                    pnlPettyLimit.Visible = true;

                }

                if ((rottype == "OR") || (rottype == "SL") || (rottype == "OA") || (rottype == "DL"))
                {
                    phERPlocs.Visible = true;
                }
                else
                {
                    phERPlocs.Visible = false;
                }


                for (int i = 0; i < ar.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlpaymode.Items)
                    {
                        if (items.Value == ar[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < it.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlInvTrans.Items)
                    {
                        if (items.Value == it[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < ct.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlCusTrans.Items)
                    {
                        if (items.Value == ct[i])
                        {
                            items.Checked = true;
                        }
                    }

                }
                for (int i = 0; i < mt.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlMerchTrans.Items)
                    {
                        if (items.Value == mt[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < ft.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlFSTrans.Items)
                    {
                        if (items.Value == ft[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < arrOpnRtnApl.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlOpnRtnApl.Items)
                    {
                        if (items.Value == arrOpnRtnApl[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < arrResRtnApl.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlResRtnApl.Items)
                    {
                        if (items.Value == arrResRtnApl[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < arrGRImg.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlGRImage.Items)
                    {
                        if (items.Value == arrGRImg[i])
                        {
                            items.Checked = true;
                        }
                    }
                }

                for (int i = 0; i < arrGRImgmand.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlGRImgMand.Items)
                    {
                        if (items.Value == arrGRImgmand[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
                for (int i = 0; i < arrBRImgmand.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlBRimgMand.Items)
                    {
                        if (items.Value == arrBRImgmand[i])
                        {
                            items.Checked = true;
                        }
                    }
                }

            }
        }
        protected void Save()
        {
            string name, username, code, user, status, pass, unload, deviceid, enforcejp, stlmnt, odometer, rottype, promode, VantoVan, Lodrej, Rtntype, EnOpt,
                arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit, LoadOutEdit, LoadOutExcessAllow, Depot, paymode,
                suglodreq, endorsement, InventoryOutMode, CusTransOutMode, AltRotCode, EnableHelper, Helper1, Helper2, Vehicle, TransName, VanStockAllow, NonVanStockAllow,
                RtnAplAttribute, OpnRtnImg, ResRtnImg, SchRtnImg, OptRtnApl, ResRtnApl, SysStock, GRImg, LTApprvl, JPSeq, SchVisit, WeekendDys, GRImgMand, BRImgMand, pettycash, AssetTracking, ServiceReq,
                IsVehicleNo, EnbVehicle, AdvPay, VanApproval, SettleFrom, pettyLimit, InvTrans, fence, CusTrans, MerchTrans, FSTrans, ARManAlloc, ERPInvReqLoc, ERPInvLoc, InvReconfAppr, varlimit, FutExpDel,
                logoutafter, HelperMand, EnforceNotification, EnableCoupon, IsBankUpdate, EnableCouponLeaf, LoadIn, LoadOut, Inventory;
            AssetTracking = ddlAssetTracking.SelectedValue.ToString();
            ServiceReq = ddlServiceReq.SelectedValue.ToString();
            name = txtname.Text.ToString();
            username = ddlname.SelectedValue.ToString();
            code = txtcode.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            pass = txtpass.Text.ToString();
            unload = ddlis.SelectedValue.ToString();
            status = ddlStats.SelectedValue.ToString();
            deviceid = txtdeviceid.Text.ToString();
            enforcejp = ddlenforcejp.SelectedValue.ToString();
            stlmnt = ddlstlmnt.SelectedValue.ToString();
            odometer = ddlodometer.SelectedValue.ToString();
            rottype = ddlrotType.SelectedValue.ToString();

            ERPInvReqLoc = txtInvReqLoc.Text.ToString();
            ERPInvLoc = txtInvLoc.Text.ToString();

            arabic = txtArabicname.Text.ToString();
            rotcheck = ddlRC.SelectedValue.ToString();
            loadinSign = ddlLIS.SelectedValue.ToString();
            loadTransferSign = ddlLTS.SelectedValue.ToString();
            LoadoutSign = ddlLOS.SelectedValue.ToString();
            LoadReq = ddlLR.SelectedValue.ToString();
            LoadTransfer = ddlLT.SelectedValue.ToString();
            LoadInEdit = ddlLEdit.SelectedValue.ToString();
            LoadOutEdit = ddlLOEdit.SelectedValue.ToString();
            LoadOutExcessAllow = ddlLOExcess.SelectedValue.ToString();
            Depot = ddlDepot.SelectedValue.ToString();
            paymode = paytmodecolumns();
            suglodreq = rcbsugloreq.SelectedValue.ToString();
            Rtntype = rcbreturnType.SelectedValue.ToString();
            Lodrej = rcbLodRej.SelectedValue.ToString();
            VantoVan = rcbVantoVan.SelectedValue.ToString();
            EnOpt = ddlEnOpt.SelectedValue.ToString();
            endorsement = ddlEndorsement.SelectedValue.ToString();
            InventoryOutMode = rdInvOutMode.SelectedValue.ToString();
            CusTransOutMode = rdCusOutMode.SelectedValue.ToString();
            AltRotCode = txtAltRotCode.Text.ToString();

            EnableHelper = ddEnableHelper.SelectedValue.ToString();
            if (EnableHelper == "Y")
            {
                Helper1 = ddlHelper1.SelectedValue.ToString();
                Helper2 = ddlHelper2.SelectedValue.ToString();
            }
            else
            {
                Helper1 = "0";
                Helper2 = "0";
            }
            Vehicle = ddlVehicleID.SelectedValue.ToString();
            TransName = "Invoice,Order Request,AR Collection,Advance Payment,Merchandising,Field Service,Customer Insights,Customer Profile,KPI";
            RtnAplAttribute = ddlattribute.SelectedValue.ToString();
            VanStockAllow = ddlVanstockexcessallow.SelectedValue.ToString();
            NonVanStockAllow = ddlNonvanstockallow.SelectedValue.ToString();
            OpnRtnImg = ddlOpnRtnImg.SelectedValue.ToString();
            ResRtnImg = ddlResRtnImg.SelectedValue.ToString();
            SchRtnImg = ddlSchRtnImg.SelectedValue.ToString();
            OptRtnApl = OpnRetncolumns();
            ResRtnApl = ResRetncolumns();
            SysStock = ddlsysstkenable.SelectedValue.ToString();
            GRImg = GRImages();
            GRImgMand = GRImagesMnad();
            BRImgMand = BRImagesMnad();
            LTApprvl = ddlLTApproval.SelectedValue.ToString();
            JPSeq = ddlJPlanSeq.SelectedValue.ToString();
            SchVisit = ddlSchVisit.SelectedValue.ToString();
            WeekendDys = ddlWeekendDays.SelectedValue.ToString();
            pettycash = ddlPettycash.SelectedValue.ToString();
            IsVehicleNo = ddlIsVehicleNo.SelectedValue.ToString();
            EnbVehicle = ddlEnbVehicle.SelectedValue.ToString();
            AdvPay = rdAdvPay.SelectedValue.ToString();
            VanApproval = ddlVavApproval.SelectedValue.ToString();
            SettleFrom = ddlSettlefrom.SelectedValue.ToString();
            pettyLimit = txtPettyLimit.Text.ToString();
            varlimit = txtvarlimit.Text.ToString();
            if (varlimit == "")
            {
                varlimit = "0";
            }
            if (pettyLimit == "")
            {
                pettyLimit = "0";
            }
            InvTrans = invTranscolumns();
            fence = rdFence.Text.ToString();
            if (fence == "")
            {
                fence = "0";
            }
            CusTrans = CusTranscolumns();
            MerchTrans = MerchTranscolumns();
            FSTrans = FSTranscolumns();
            ARManAlloc = ddlARManAalloc.SelectedValue.ToString();
            InvReconfAppr = ddlInvReconfAppr.SelectedValue.ToString();
            FutExpDel = ddlFutExpDel.SelectedValue.ToString();
            logoutafter = ddllogoutaftr.SelectedValue.ToString();

            HelperMand = ddlHelperMand.SelectedValue.ToString();
            EnforceNotification = ddlEnforceNotification.SelectedValue.ToString();
            EnableCoupon = ddlEnableCoupon.SelectedValue.ToString();
            IsBankUpdate = ddlIsBankUpdate.SelectedValue.ToString();
            EnableCouponLeaf = ddlEnableCouponLeaf.SelectedValue.ToString();
            LoadIn = ddlIsLoadIn.SelectedValue.ToString();
            LoadOut = ddlIsLoadOut.SelectedValue.ToString();
            Inventory = ddlIsInventory.SelectedValue.ToString();


            if (rottype == "OA")
            {
                promode = ddlProdVisitsOA.SelectedValue.ToString();
            }
            else if (rottype == "MER")
            {
                promode = ddlProdVisitsMerch.SelectedValue.ToString();
            }
            else if (rottype == "FS")
            {
                promode = ddlProdVisitsFS.SelectedValue.ToString();
            }
            else if (rottype == "AR")
            {
                promode = "AR";
            }
            else if (rottype == "OR")
            {
                promode = "OR";
            }
            else if (rottype == "SL" || rottype == "DL")
            {
                promode = "SL";
            }
            else
            {
                promode = "SL";
            }

            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string ResponseMessage = ViewState["ResponseMessage"].ToString();

                if (ResponseMessage == "Proceed")
                {
                    string[] arr = { code, username, pass, unload, user, deviceid, stlmnt, enforcejp, odometer, status,
                    rottype, promode,   arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit,
                    LoadOutEdit, LoadOutExcessAllow, Depot,paymode,suglodreq,VantoVan,Lodrej,Rtntype,EnOpt, endorsement,
                    InventoryOutMode, CusTransOutMode,AltRotCode ,EnableHelper,  Helper1, Helper2,Vehicle,TransName,VanStockAllow, NonVanStockAllow,
                    RtnAplAttribute,OpnRtnImg,ResRtnImg,SchRtnImg,  OptRtnApl,ResRtnApl,SysStock,GRImg,LTApprvl,JPSeq,
                    SchVisit,  WeekendDys,GRImgMand,BRImgMand,pettycash,AssetTracking, ServiceReq,IsVehicleNo,EnbVehicle,AdvPay,
                    SettleFrom, InvTrans,pettyLimit,fence,CusTrans,MerchTrans,FSTrans,VanApproval,ARManAlloc, ERPInvReqLoc, ERPInvLoc, InvReconfAppr,varlimit,FutExpDel,logoutafter,
                     HelperMand, EnforceNotification, EnableCoupon, IsBankUpdate, EnableCouponLeaf, LoadIn, LoadOut, Inventory
                };

                    string Value = ObjclsFrms.SaveData("sp_Backend", "InsertRoutes", name, arr);

                    try
                    {
                        int res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route saved Successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('The Device ID or Route Code already Exisits');</script>", false);

                        }
                    }
                    catch (Exception ex)
                    {
                        ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Error: " + ex.Message.ToString());
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('" + ResponseMessage + "');</script>", false);
                }

            }
            else
            {

                try
                {
                    string CurrentStatus = ViewState["CurrentStatus"].ToString();
                    string ChangedStatus = ddlStats.SelectedValue.ToString();

                    if (CurrentStatus == "N" && ChangedStatus == "Y")
                    {
                        string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                        string Platform = "USER";
                        string IsStatusChange = "Y";
                        ObjclsFrms.TraceService(UICommon.GetLogFileName() + " ListRoute.aspx  , " + "LicenseKey : " + LicenseKey);
                        LicenseCounts(LicenseKey, Platform, IsStatusChange);

                        string ResponseMessage = ViewState["ResponseMessage"].ToString();

                        if (ResponseMessage == "Proceed")
                        {
                            string id = ResponseID.ToString();
                            string[] arr = { code, username, pass, unload, deviceid, stlmnt, enforcejp, odometer, status, id, //11
                            rottype, promode ,  arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit, //21
                            LoadOutEdit, LoadOutExcessAllow, Depot,paymode,suglodreq,VantoVan,Lodrej,Rtntype,EnOpt, endorsement, //31
                            InventoryOutMode, CusTransOutMode,AltRotCode, EnableHelper, Helper1, Helper2,Vehicle,TransName,VanStockAllow, NonVanStockAllow, //41
                            RtnAplAttribute,OpnRtnImg,ResRtnImg,SchRtnImg, OptRtnApl,ResRtnApl,SysStock,GRImg,LTApprvl,JPSeq, //51
                            SchVisit,WeekendDys,GRImgMand,BRImgMand,pettycash,AssetTracking, ServiceReq,IsVehicleNo,EnbVehicle,AdvPay, //61
                            SettleFrom, InvTrans,pettyLimit,fence,CusTrans,MerchTrans,FSTrans,VanApproval,ARManAlloc, ERPInvReqLoc, ERPInvLoc, InvReconfAppr,varlimit,FutExpDel, user,logoutafter,
                            HelperMand, EnforceNotification, EnableCoupon, IsBankUpdate, EnableCouponLeaf, LoadIn, LoadOut, Inventory};
                            string Value = ObjclsFrms.SaveData("sp_Backend", "UpdateRoutes", name, arr);
                            int res = Int32.Parse(Value.ToString());
                            try
                            {
                                if (res > 0)
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route Updated Successfully');</script>", false);
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('The Device ID already Exisits');</script>", false);
                                }
                            }
                            catch (Exception ex)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('" + ResponseMessage + "');</script>", false);
                        }
                    }
                    else
                    {
                        string id = ResponseID.ToString();
                        string[] arr = { code, username, pass, unload, deviceid, stlmnt, enforcejp, odometer, status, id, //11
                        rottype, promode ,  arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit, //21
                        LoadOutEdit, LoadOutExcessAllow, Depot,paymode,suglodreq,VantoVan,Lodrej,Rtntype,EnOpt, endorsement, //31
                        InventoryOutMode, CusTransOutMode,AltRotCode, EnableHelper, Helper1, Helper2,Vehicle,TransName,VanStockAllow, NonVanStockAllow, //41
                        RtnAplAttribute,OpnRtnImg,ResRtnImg,SchRtnImg, OptRtnApl,ResRtnApl,SysStock,GRImg,LTApprvl,JPSeq, //51
                        SchVisit,WeekendDys,GRImgMand,BRImgMand,pettycash,AssetTracking, ServiceReq,IsVehicleNo,EnbVehicle,AdvPay, //61
                        SettleFrom, InvTrans,pettyLimit,fence,CusTrans,MerchTrans,FSTrans,VanApproval,ARManAlloc, ERPInvReqLoc, ERPInvLoc, InvReconfAppr,varlimit,FutExpDel, user,logoutafter,
                        HelperMand, EnforceNotification, EnableCoupon, IsBankUpdate, EnableCouponLeaf, LoadIn, LoadOut, Inventory};
                        string Value = ObjclsFrms.SaveData("sp_Backend", "UpdateRoutes", name, arr);
                        int res = Int32.Parse(Value.ToString());
                        try
                        {
                            if (res > 0)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route Updated Successfully');</script>", false);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('The Device ID already Exisits');</script>", false);
                            }
                        }
                        catch (Exception ex)
                        {
                            ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Error: " + ex.Message.ToString());
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                        }
                    }

                }
                catch (Exception ex)
                {
                    ObjclsFrms.TraceService(UICommon.GetLogFileName() + " AddEditRoute.aspx  , " + "Error: " + ex.Message.ToString());
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }
        }
        public void user()
        {
            DataTable dt = ObjclsFrms.loadList("SelUserFromDrop", "sp_Backend", ResponseID.ToString());
            ddlname.DataSource = dt;
            ddlname.DataTextField = "usr_Name";
            ddlname.DataValueField = "usr_ID";
            ddlname.DataBind();
        }
        public void DepotSubArea()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotSubAreaFromDrop", "sp_Backend");
            ddlDepot.DataSource = dt;
            ddlDepot.DataTextField = "dsa_Name";
            ddlDepot.DataValueField = "dsa_ID";
            ddlDepot.DataBind();
        }
        public string paytmodecolumns()
        {
            string retStr = "";
            var checkedItems = ddlpaymode.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }
        public string invTranscolumns()
        {
            string retStr = "";
            var checkedItems = ddlInvTrans.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }
        public string CusTranscolumns()
        {
            string retStr = "";
            var checkedItems = ddlCusTrans.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }

        public string MerchTranscolumns()
        {
            string retStr = "";
            var checkedItems = ddlMerchTrans.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }
        public string FSTranscolumns()
        {
            string retStr = "";
            var checkedItems = ddlFSTrans.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }

        public string OpnRetncolumns()
        {
            string retStr = "";
            var checkedItems = ddlOpnRtnApl.CheckedItems;

            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }

            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }

        public string ResRetncolumns()
        {
            string retStr = "";
            var checkedItems = ddlResRtnApl.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }

        public string GRImages()
        {
            string retStr = "";
            var checkedItems = ddlGRImage.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }
        public string GRImagesMnad()
        {
            string retStr = "";
            var checkedItems = ddlGRImgMand.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }

        public string BRImagesMnad()
        {
            string retStr = "";
            var checkedItems = ddlBRimgMand.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            if (retStr != "")
            {
                retStr = retStr.Remove(retStr.Length - 1, 1);

            }
            return retStr;
        }

        public void HelperinOne()
        {

            DataTable lstHelpers = ObjclsFrms.loadList("SelHelper1FromDropdown", "sp_Backend", ResponseID.ToString());
            if (lstHelpers.Rows.Count > 0)
            {
                ddlHelper1.DataSource = lstHelpers;
                ddlHelper1.DataValueField = "id";
                ddlHelper1.DataTextField = "name";
                ddlHelper1.DataBind();
            }
        }

        public void HelperinTwo()
        {
            string[] arr = { ddlHelper1.SelectedValue.ToString() };
            DataTable lstHelpers = ObjclsFrms.loadList("SelHelper2FromDropdown", "sp_Backend", ResponseID.ToString(), arr);
            if (lstHelpers.Rows.Count > 0)
            {
                ddlHelper2.DataSource = lstHelpers;
                ddlHelper2.DataValueField = "id";
                ddlHelper2.DataTextField = "name";
                ddlHelper2.DataBind();

            }
        }
        public void Vehicles()
        {

            DataTable lstVehicle = ObjclsFrms.loadList("SelVehicleID", "sp_Backend", ResponseID.ToString());
            if (lstVehicle.Rows.Count > 0)
            {
                ddlVehicleID.DataSource = lstVehicle;
                ddlVehicleID.DataValueField = "id";
                ddlVehicleID.DataTextField = "name";
                ddlVehicleID.DataBind();

            }
        }

        protected void cancel1_Click(object sender, EventArgs e)
        {

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRoute.aspx");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRoute.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckRouteCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                LinkButton1.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                LinkButton1.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }

        protected void SelectedIndexChanged_EnableHelper(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string EnableHelper = e.Value;

            if (EnableHelper == "Y")
            {
                aspHelper1.Visible = true;
                ddlHelper1.Visible = true;

                if (ddlHelper1.SelectedItem != null)
                {
                    aspHelper2.Visible = true;
                    ddlHelper2.Visible = true;
                }
                else
                {
                    aspHelper2.Visible = false;
                    ddlHelper2.Visible = false;
                }
            }
            else
            {
                aspHelper1.Visible = false;
                ddlHelper1.Visible = false;
                aspHelper2.Visible = false;
                ddlHelper2.Visible = false;
            }
        }



        protected void ddlHelper1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            aspHelper2.Visible = true;
            ddlHelper2.Visible = true;
            ddlHelper2.ClearSelection();
            HelperinTwo();
        }


        protected void ddlJPlanSeq_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (ddlJPlanSeq.SelectedValue.ToString() == "Y")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>JPSeq();</script>", false);

            }
        }

        protected void ddlrotType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string type = ddlrotType.SelectedValue.ToString();

            if ((type == "OR") || (type == "DL") || (type == "AR") || (type == "SL"))
            {
                pnlProdVisits.Visible = false;
                pnlOA.Visible = false;
                pnlMerch.Visible = false;
                pnlFS.Visible = false;
            }
            else if ((type == "OA"))
            {
                pnlProdVisits.Visible = true;
                pnlOA.Visible = true;
                pnlMerch.Visible = false;
                pnlFS.Visible = false;
            }
            else if (type == "MER")
            {
                pnlProdVisits.Visible = true;
                pnlOA.Visible = false;
                pnlMerch.Visible = true;
                pnlFS.Visible = false;
            }
            else if (type == "FS")
            {
                pnlProdVisits.Visible = true;
                pnlOA.Visible = false;
                pnlMerch.Visible = false;
                pnlFS.Visible = true;
            }
            else
            {
                pnlProdVisits.Visible = false;
                pnlOA.Visible = false;
                pnlMerch.Visible = false;
                pnlFS.Visible = false;
            }
        }

        protected void ddlPettycash_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string type = ddlPettycash.SelectedValue.ToString();
            if ((type == "Y"))
            {
                pnlPettyLimit.Visible = true;
            }
            else
            {
                pnlPettyLimit.Visible = false;
            }
        }
        protected void ApplyProfile_Click(object sender, EventArgs e)
        {
            try
            {
                string pfh_Id = rdProfile.SelectedValue.ToString();
                if (!string.IsNullOrEmpty(pfh_Id))
                {
                    DataTable dt = ObjclsFrms.loadList("ProdileDetailforMasterForms", "sp_ProfileSettings", pfh_Id);
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            string controlId = dr["pfd_ControlId"].ToString();
                            string controlValues = dr["pfd_Values"].ToString();
                            string controlType = dr["pfd_Type"].ToString();
                            SetControlValues(controlId, controlValues, controlType);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }

        private void SetControlValues(string controlId, string controlValues, string controlType)
        {
            System.Web.UI.Control control = FindControlRecursive(Page, controlId);
            if (control != null)
            {
                if (controlType == "S")
                {
                    if (control is RadDropDownList radDropDownList)
                    {
                        SetRadDropDownListSingleValue(radDropDownList, controlValues);
                    }
                }
                else if (controlType == "M")
                {
                    if (control is RadComboBox radComboBox)
                    {
                        SetRadComboBoxMultipleValues(radComboBox, controlValues);
                    }
                }
                else if (controlType == "T")
                {
                    if (control is RadTextBox radTextBox)
                    {
                        radTextBox.Text = controlValues;
                    }
                }
                else if (controlType == "N")
                {
                    if (control is RadNumericTextBox radTextBox)
                    {
                        radTextBox.Text = controlValues;
                    }
                }
            }
        }

        private void SetRadDropDownListSingleValue(RadDropDownList rd, string controlValue)
        {
            rd.ClearSelection();
            rd.SelectedValue = controlValue.ToString();

            //TriggerSelectedIndexChanged(rd);


        }

        private void SetRadComboBoxMultipleValues(RadComboBox radComboBox, string controlValues)
        {
            radComboBox.ClearSelection();
            string[] values = controlValues.Split('-');

            foreach (RadComboBoxItem items in radComboBox.Items)
            {
                items.Checked = false;
            }

            foreach (string value in values)
            {
                RadComboBoxItem item = radComboBox.Items.FindItemByValue(value);
                if (item != null)
                {
                    item.Checked = true;
                }
            }
        }

        private System.Web.UI.Control FindControlRecursive(System.Web.UI.Control root, string id)
        {
            if (root.ID == id)
            {
                return root;
            }

            foreach (System.Web.UI.Control child in root.Controls)
            {
                System.Web.UI.Control found = FindControlRecursive(child, id);
                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
        public void Profile()
        {

            DataTable lstVehicle = ObjclsFrms.loadList("SelProfileHeaderforDropDown", "sp_ProfileSettings", "tb_Route");
            if (lstVehicle.Rows.Count > 0)
            {
                rdProfile.DataSource = lstVehicle;
                rdProfile.DataValueField = "pfh_ID";
                rdProfile.DataTextField = "pfh_ProfileName";
                rdProfile.DataBind();

            }
        }

        protected void Edits_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Assign();</script>", false);
            Users();

        }

        protected void lnkChange_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>usrConfim();</script>", false);

        }
        public void Users()
        {
            try
            {


                DataTable lstuser = ObjclsFrms.loadList("SelectUserswithoutRoute", "sp_Backend");
                if (lstuser.Rows.Count > 0)
                {
                    ddluser.DataSource = lstuser;
                    ddluser.DataValueField = "usr_ID";
                    ddluser.DataTextField = "Usr_Name";
                    ddluser.DataBind();

                }
            }
            catch (Exception ex) { }
        }

        protected void lnkusrchange_Click(object sender, EventArgs e)
        {
            string rot, chngeusr, effectivedate, user, prevusr;
            rot = ResponseID.ToString();
            chngeusr = ddluser.SelectedValue.ToString();
            prevusr = ViewState["rotusr"].ToString();
            effectivedate = DateTime.Parse(rdeffectivedate.SelectedDate.ToString()).ToString("yyyyMMdd");
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { chngeusr, effectivedate, user, prevusr };
            string Value = ObjclsFrms.SaveData("sp_Backend", "InsertRouteUserChange", rot, arr);

            try
            {
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route user change has been scheduled Successfully.');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('Something went wrong....!');</script>", false);

                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }

        protected void lnkdeleteusr_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>usrremoveConfim();</script>", false);

        }

        protected void lnkusrremove_Click(object sender, EventArgs e)
        {
            string rot, effectivedate, user, prevusr;
            rot = ResponseID.ToString();
            prevusr = ViewState["rotusr"].ToString();
            effectivedate = DateTime.Parse(rdeffectivedate.SelectedDate.ToString()).ToString("yyyyMMdd");
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { prevusr, effectivedate, user };
            string Value = ObjclsFrms.SaveData("sp_Backend", "RemoveRouteUser", rot, arr);

            try
            {
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route user removal has been scheduled Successfully.');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail('Something went wrong....!');</script>", false);

                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
        }

        protected void Delete_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void ddlStats_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string Status = ddlStats.SelectedValue.ToString();

            if (Status == "Y")
            {
                ViewState["StatusMode"] = "Active";

                string LicenseKey = ConfigurationManager.AppSettings.Get("LicenseKey");
                string Platform = "USER";
                string IsStatusChange = "Y";
                ObjclsFrms.TraceService(UICommon.GetLogFileName() + " ListRoute.aspx  , " + "LicenseKey : " + LicenseKey);
                LicenseCounts(LicenseKey, Platform, IsStatusChange);

                string ResponseMessage = ViewState["ResponseMessage"].ToString();

                if (ResponseMessage == "Proceed")
                {

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureLicense('"+ ResponseMessage + "');</script>", false);
                }
                
            }

        }
    }


}