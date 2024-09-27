using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Remoting;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class INVStampedCopyUpload1 : System.Web.UI.Page
    {

        GeneralFunctions obj = new GeneralFunctions();

        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }


        public string Type
        {
            get
            {
                string Type;
                Type = (Request.Params["type"]);

                return Type;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (!Page.IsPostBack)
                {



                    if (Mode == 1) // While loading page from dashboard 
                    {
                        try
                        {
                            if (Session["FromDate"] != null)
                            {
                                rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                            }
                            if (Session["ToDate"] != null)
                            {
                                rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Redirect("~/SignIn.aspx");
                        }
                    }
                    else // While loading page from transaction menu
                    {
                        try
                        {
                            if (Session["SHFDate"] != null)
                            {

                                rdfromDate.SelectedDate = DateTime.Parse(Session["SHFDate"].ToString());
                            }
                            else
                            {
                                rdfromDate.SelectedDate = DateTime.Now;


                            }
                            rdfromDate.MaxDate = DateTime.Now;

                            if (Session["SHTDate"] != null)
                            {

                                rdendDate.SelectedDate = DateTime.Parse(Session["SHTDate"].ToString());
                            }
                            else
                            {
                                rdendDate.SelectedDate = DateTime.Now;

                            }
                            rdendDate.MaxDate = DateTime.Now;
                        }
                        catch (Exception ex)
                        {
                            Response.Redirect("~/SignIn.aspx");
                        }
                    }


                    //Filter Session
                    try
                    {
                        if (Session["SHAdvFilter"] != null)
                        {
                            if (Session["SHAdvFilter"].ToString() == "true")
                            {
                                plhFilter.Visible = true;
                            }
                            else
                            {
                                plhFilter.Visible = false;
                            }
                        }
                        else
                        {
                            plhFilter.Visible = false;
                        }

                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }

                    //DropDown 

                    Region();
                    int o = 1;
                    foreach (RadComboBoxItem itmss in ddlregion.Items)
                    {
                        itmss.Checked = true;
                        o++;
                    }
                    string Reg = REG();
                    string regcondition = " dep_reg_ID in (" + Reg + ")";
                    Depot(regcondition);

                    int p = 1;
                    foreach (RadComboBoxItem itmss in ddldepot.Items)
                    {
                        itmss.Checked = true;
                        p++;
                    }
                    string depo = DPO();
                    string dpocondition = " dpa_dep_ID in (" + depo + ")";
                    DpoArea(dpocondition);
                    int q = 1;
                    foreach (RadComboBoxItem itmss in ddldpoArea.Items)
                    {
                        itmss.Checked = true;
                        q++;
                    }
                    string depoarea = DPOarea();
                    string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
                    DpoSubArea(dpoareacondition);
                    int R = 1;
                    foreach (RadComboBoxItem itmss in ddldpoSubArea.Items)
                    {
                        itmss.Checked = true;
                        R++;
                    }
                    string deposubarea = DPOsubarea();
                    string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
                    Route(dposubareacondition);

                    //Session Route and Customer
                    try
                    {
                        if (Session["SHrotID"] != null)
                        {
                            int a = rdRoute.Items.Count;
                            string route = Session["SHrotID"].ToString();
                            string[] ar = route.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdRoute.Items)
                                {
                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                            string routeCondition = " rcs_rot_ID in (" + route + ")";
                            Customers(routeCondition);

                        }
                        else
                        {
                            string rotID = Rot();
                            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                            Customers(routeCondition);


                        }
                        if (Session["SHcusID"] != null)
                        {

                            string cusID = Session["SHcusID"].ToString();
                            string[] ar = cusID.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdCustomer.Items)
                                {


                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                        }
                        else
                        {
                            string cusID = Cus();
                            string cusCondition = "A.cus_ID in (" + cusID + ")";
                        }
                        //invType
                        if (Session["SHInvID"] != null)
                        {
                            string cusID = Session["SHInvID"].ToString();
                            string[] ar = cusID.Split(',');
                            for (int i = 0; i < ar.Length; i++)
                            {
                                foreach (RadComboBoxItem items in rdInvType.Items)
                                {


                                    if (items.Value == ar[i])
                                    {
                                        items.Checked = true;
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                    try
                    {
                        GetGridSession(grvRpt, "SalesH");

                        grvRpt.Rebind();
                    }

                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }


                }

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }


        public void LoadList()
        {
            try
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";
                    mainCondition = mainConditions(rotID);


                    if (Mode == 1)
                    {
                        string type = Request.Params["type"].ToString();
                        if (type.Equals("SL"))
                        {
                            mainCondition += " and sal_SalesAmount <> 0.00";
                        }
                        else if (type.Equals("GR"))
                        {
                            mainCondition += " and sal_GoodRtnAmount <> 0.00";
                        }
                        else if (type.Equals("BR"))
                        {
                            mainCondition += " and sal_BadRtnAmount <> 0.00";
                        }
                        else if (type.Equals("FG"))
                        {
                            mainCondition += " and sal_FreeGoodAmount <> 0.00";
                        }
                        else if (type.Equals("INV"))
                        {
                            mainCondition += " and (sal_SalesAmount = 0.00 or sal_SalesAmount <> 0.00)";
                        }
                    }


                    DataTable lstDatas = new DataTable();
                    string[] ar = { mainCondition };
                    lstDatas = obj.loadList("SelINVUploadStampCopy", "sp_Transaction", UICommon.GetCurrentUserID().ToString(),ar);
                    grvRpt.DataSource = lstDatas;

                }

            }
            catch (Exception ex)
            {

            }
        }


        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " and sal_rot_ID in (" + rotID + ")";
            string jobcondition = "";
            try
            {

                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date)) and isnull(A.Void,'N')='N'";
                if (cusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and sal_cus_ID in (" + cusID + ")";
                }

            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            mainCondition += jobcondition;
            string InvType = rdInvType.Text;
            if (InvType.Equals("Order Basis"))
            {
                mainCondition += " and isnull(sal_ord_ID,0)>0";
            }
            else if (InvType.Equals("Direct"))
            {
                mainCondition += " and isnull(sal_ord_ID,0)=0";
            }
            return mainCondition;
        }

        public void Customers(string routeCondition)
        {

            rdCustomer.DataSource = obj.loadList("SelCustomerforTransaction", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public string Cus()
        {
            var CollectionMarket = rdCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }

        }
        public string Rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "sal_rot_ID";
            }
        }
        public string InvType()
        {
            var CollectionMarket = rdInvType.CheckedItems;
            string invType = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        invType += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        invType += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        invType += item.Value;
                    }
                    j++;
                }
                return invType;
            }
            else
            {
                return "";
            }
        }


        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;
                SetGridSession(grd, "SalesH");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            if (e.CommandName.Equals("btnStampUploadClick"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("inv_ID").ToString();
                string invoiceID = dataItem["inv_InvoiceID"].Text;
                ViewState["inv_InvoiceID"] = invoiceID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UploadImage();</script>", false);

            }
        }

        protected void btnStampUpload_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>UploadImage();</script>", false);

        }

        protected void SaveStamped_Click(object sender, EventArgs e)
        {
            if ((upd1.UploadedFiles.Count == 0) && (ViewState["Stamp"] == null))
            {
                lblmsg.Text = "File missing..please upload file";

            }
            else
            {
                Save();

            }
        }

        public class UploadErr
        {
            public string result { get; set; }
        }
        public class Result
        {
            public string Res { get; set; }
            public string Title { get; set; }
            public string Descr { get; set; }

        }
        public class Uploadstatus
        {
            public List<Result> result { get; set; }
        }
        protected void Save()
        {
            try
            {
                // Assuming upd1 is your RadAsyncUpload control
                UploadedFile uploadedFile = upd1.UploadedFiles[0];

                // You can access the file properties like this:
                string fileName = uploadedFile.GetName();
                Stream fileStream = uploadedFile.InputStream;

                // Now you can use fileName and fileStream in your WebServiceCall method
                string apiUrl = ConfigurationManager.AppSettings.Get("PDF_API");
                string inv_ID = ViewState["inv_InvoiceID"].ToString();

                string response = WebServiceCall(apiUrl, fileName, fileStream, inv_ID.ToString());
                if (response != null)
                {
                    try
                    {
                        Uploadstatus stat = JsonConvert.DeserializeObject<Uploadstatus>(response);
                        List<Result> result = stat.result;
                        string Res, Title, Descr;
                        Res = "";
                        Descr = "";
                        foreach (var item in result)
                        {
                            Res = item.Res;
                            Title = item.Title;
                            Descr = item.Descr;
                        }
                        if (Res == "1")
                        {
                            lblmsg.Text = Descr.ToString();
                            lblmsg.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblmsg.Text = Descr.ToString();
                            lblmsg.ForeColor = System.Drawing.Color.Red;

                        }


                    }
                    catch (Exception ex)
                    {

                        UploadErr order = JsonConvert.DeserializeObject<UploadErr>(response);

                        lblmsg.Text = order.result.ToString();

                    }


                    // Now you can work with the response data
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                // ...
            }

        }

        public string WebServiceCall(string url, string fileName, Stream fileStream, string inv_ID)
        {
            try
            {
                // Create a request using the specified URL.
                WebRequest request = WebRequest.Create(url);
                // Set the Method property of the request to POST.
                request.Method = "POST";

                // Set the Content-Type to "multipart/form-data" for file upload.
                string boundary = "---------------------------" + DateTime.Now.Ticks.ToString("x");
                request.ContentType = "multipart/form-data; boundary=" + boundary;


                using (Stream requestStream = request.GetRequestStream())
                {
                    // Write the file data as part of the request.
                    string inv_IDFormField = $"--{boundary}\r\nContent-Disposition: form-data; name=\"inv_ID\"\r\n\r\n{inv_ID}\r\n";
                    byte[] inv_IDBytes = Encoding.UTF8.GetBytes(inv_IDFormField);
                    requestStream.Write(inv_IDBytes, 0, inv_IDBytes.Length);

                    string header = $"--{boundary}\r\nContent-Disposition: form-data; name=\"file\"; filename=\"{fileName}\"\r\nContent-Type: application/pdf\r\n\r\n";
                    byte[] headerBytes = Encoding.UTF8.GetBytes(header);
                    requestStream.Write(headerBytes, 0, headerBytes.Length);

                    // Read the PDF file data from the provided stream.
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = fileStream.Read(buffer, 0, buffer.Length)) > 0)
                    {
                        requestStream.Write(buffer, 0, bytesRead);
                    }

                    // Add the closing boundary.
                    byte[] boundaryBytes = Encoding.ASCII.GetBytes("\r\n--" + boundary + "--\r\n");
                    requestStream.Write(boundaryBytes, 0, boundaryBytes.Length);
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
                    response.Close();
                    return responseFromServer;
                }
            }
            catch (Exception ex)
            {
                string innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                obj.LogMessageToFile(UICommon.GetLogFileName(), "INVStampedCopyUpload.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }

        protected void buttonOK_Click(object sender, EventArgs e)
        {

            Response.Redirect("INVStampedCopyUpload.aspx");
        }

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

        protected void ddldepot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        public string DPOarea()
        {
            var CollectionMarket2 = ddldpoArea.CheckedItems;
            string dpoareID = "";
            int j = 0;
            int MarCount = CollectionMarket2.Count;
            if (CollectionMarket2.Count > 0)
            {
                foreach (var item in CollectionMarket2)
                {
                    if (j == 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoareID += item.Value;
                    }
                    j++;
                }
                return dpoareID;
            }
            else
            {
                return "0";
            }
        }
        protected void ddldpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);

        }

        protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        public string DPOsubarea()
        {
            var CollectionMarket3 = ddldpoSubArea.CheckedItems;
            string dposubareID = "";
            int j = 0;
            int MarCount = CollectionMarket3.Count;
            if (CollectionMarket3.Count > 0)
            {
                foreach (var item in CollectionMarket3)
                {
                    if (j == 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dposubareID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dposubareID += item.Value;
                    }
                    j++;
                }
                return dposubareID;
            }
            else
            {
                return "0";
            }
        }
        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            if (rotID.Equals("sal_rot_ID"))
            {
                rotID = "0";
            }
            string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SHFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["SHFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["SHFDate"].ToString());
                    }
                    else
                    {
                        Session["SHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["SHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["SHTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["SHTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["SHTDate"].ToString());
                    }
                    else
                    {
                        Session["SHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["SHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["SHrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["SHrotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["SHrotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["SHrotID"] = rotID;
                }

                if (Session["SHcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["SHcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["SHcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["SHcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
        }


        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            rdRoute.DataSource = obj.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public void Region()
        {
            ddlregion.DataSource = obj.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            ddldepot.DataSource = obj.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepot.DataTextField = "dep_Name";
            ddldepot.DataValueField = "dep_ID";
            ddldepot.DataBind();
        }

        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            ddldpoArea.DataSource = obj.loadList("SelectDepotAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoArea.DataTextField = "dpa_Name";
            ddldpoArea.DataValueField = "dpa_ID";
            ddldpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            ddldpoSubArea.DataSource = obj.loadList("SelectDepotSubAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoSubArea.DataTextField = "dsa_Name";
            ddldpoSubArea.DataValueField = "dsa_ID";
            ddldpoSubArea.DataBind();
        }
        public string REG()
        {
            var CollectionMarket1 = ddlregion.CheckedItems;
            string regID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        regID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        regID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        regID += item.Value;
                    }
                    j++;
                }
                return regID;
            }
            else
            {
                return "0";
            }
        }
        public string DPO()
        {
            var CollectionMarket1 = ddldepot.CheckedItems;
            string dpoID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        dpoID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        dpoID += item.Value;
                    }
                    j++;
                }
                return dpoID;
            }
            else
            {
                return "0";
            }
        }
        protected void lnkAdvFilter_Click(object sender, EventArgs e)
        {
            if (plhFilter.Visible == true)
            {
                plhFilter.Visible = false;
            }
            else
            {
                plhFilter.Visible = true;
            }
        }

        protected void rdInvType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void lnkSearch_Click(object sender, EventArgs e)
        {

            try
            {
                if (Session["SHInvID"] != null)
                {
                    string InvoiceType = InvType();
                    if (InvoiceType == Session["SHrotID"].ToString())
                    {
                        string InvoiceTypeID = InvType();

                    }
                    else
                    {
                        string InvoiceTypeID = InvType();
                        Session["SHInvID"] = InvoiceTypeID;
                    }


                }
                else
                {
                    string InvoiceTypeID = InvType();
                    Session["SHInvID"] = InvoiceTypeID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.DataBind();
        }



        public void SetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        string filterValue = column.CurrentFilterValue;

                        Session[SessionPrefix + columnName] = filterValue;

                    }

                }

            }

            catch (Exception ex)

            {




            }



        }
        public void GetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                string filterExpression = string.Empty;

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        if (Session[SessionPrefix + columnName] != null)

                        {

                            string filterValue = Session[SessionPrefix + columnName].ToString();



                            if (filterValue != "")
                            {

                                column.CurrentFilterValue = filterValue;



                                if (!string.IsNullOrEmpty(filterExpression))

                                {

                                    filterExpression += " AND ";

                                }

                                filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);

                            }

                        }

                    }

                }

                if (filterExpression != string.Empty)

                {

                    grvRpt.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {



            }

        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;
                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }

        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdfromDate.SelectedDate = startdate;
                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }
    }
}