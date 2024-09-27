using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;
using DocumentFormat.OpenXml.Drawing.Charts;
using DocumentFormat.OpenXml.Drawing.Wordprocessing;
using System.Net;
using System.IO;
using System.Text;
using SalesForceAutomation.Admin;
using Newtonsoft.Json;
using System.Configuration;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class IntegrationRun : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["URL"] = "";
                initialClick();
                TotalWS();
                RegisterAceEditorScript();


                pnlLogFile.Visible = false;
            }
        }



        private void RegisterAceEditorScript()
        {
            string script = $@"
        document.addEventListener('DOMContentLoaded', function () {{
            // Initialize Ace Editor for request
            var txtPayload = ace.edit('txtPayload');
            txtPayload.setTheme('ace/theme/monokai');
            txtPayload.session.setMode('ace/mode/json');

            // Initialize Ace Editor for response
            var txtResponse = ace.edit('txtResponse');
            txtResponse.setTheme('ace/theme/monokai');
            txtResponse.session.setMode('ace/mode/json');

            // Set initial content if needed
            txtPayload.setValue(document.getElementById('{hfRequestJSON.ClientID}').value, 1);
            txtResponse.setValue(document.getElementById('{hfResponseJSON.ClientID}').value, 1);

            // Function to update hidden fields
            function updateHiddenFields() {{
                document.getElementById('{hfRequestJSON.ClientID}').value = txtPayload.getValue();
                document.getElementById('{hfResponseJSON.ClientID}').value = txtResponse.getValue();
            }}

            // Update hidden fields when the 'Run' button is clicked
            document.getElementById('{lnkRun.ClientID}').addEventListener('click', updateHiddenFields);
        }});";

            ScriptManager.RegisterStartupScript(this, GetType(), "AceEditorScript", script, true);
        }

        public void LoadLogFile()
        {

            ObjclsFrms.TraceService("jsonFilePath create");

            string jsonFilePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, ViewState["LogFilepath"].ToString());
            ObjclsFrms.TraceService("jsonFilePath:"+ jsonFilePath);
                if (Directory.Exists(jsonFilePath))
                {
                ObjclsFrms.TraceService("jsonFilePath exists");
                string[] files = Directory.GetFiles(jsonFilePath);
                System.Data.DataTable fileTable = new System.Data.DataTable();
                fileTable.Columns.Add("FileName", typeof(string));
                fileTable.Columns.Add("CreationTime", typeof(string));
                fileTable.Columns.Add("LastModifiedTime", typeof(DateTime));
                fileTable.Columns.Add("FilePath", typeof(string));
                DateTime thresholdDate = DateTime.Now.AddDays(-10);
                foreach (string file in files)
                {
                    DateTime creationTime = File.GetCreationTime(file);
                    DateTime lastModifiedTime = File.GetLastWriteTime(file);
                    if (creationTime >= thresholdDate)
                    {
                        ObjclsFrms.TraceService("File created in last 10 days: " + file);
                        DataRow row = fileTable.NewRow();
                        row["FileName"] = Path.GetFileName(file);
                        row["CreationTime"] = creationTime.ToString();
                        row["LastModifiedTime"] = lastModifiedTime;
                        row["FilePath"] = file.ToString();
                        fileTable.Rows.Add(row);

                    }
                }


                if(fileTable.Rows.Count >= 0) 
                {
                   

                    RadGrid1.DataSource = fileTable;
                    RadGrid1.DataBind();
                    RadGrid1.Rebind();

                }

            }


        }
        public void initialClick()
        {
          
                System.Data.DataTable lstDatas = new System.Data.DataTable();
              
                lstDatas = ObjclsFrms.loadList("SelectIntegrationInfo", "sp_Transaction");
                if (lstDatas.Rows.Count > 0)
                {
                rptAPI.DataSource = lstDatas;
                rptAPI.DataBind();

                if (rptAPI.Items.Count > 0)
                    {
                        // int c = rpt.Items.Count;

                        foreach (RepeaterItem ri in rptAPI.Items)
                        {
                            LinkButton btnAll = ri.FindControl("btnApi") as LinkButton;
                            Panel rowPanelAll = (Panel)btnAll.FindControl("rowpanel");
                            rowPanelAll.BackColor = Color.AliceBlue;

                            string iwsID = btnAll.CommandArgument.ToString();
                            ViewState["iwsID"] = iwsID.ToString();
                        System.Data.DataTable lstUser = default(System.Data.DataTable);
                        lstUser = ObjclsFrms.loadList("SelectPayloadForAPI", "sp_Transaction", iwsID.ToString());
                        if (lstUser.Rows.Count > 0)
                        {
                            hfRequestJSON.Value = lstUser.Rows[0]["iws_Request"].ToString();
                            ViewState["URL"] = lstUser.Rows[0]["iws_URL"].ToString();
                            ViewState["Method"] = lstUser.Rows[0]["iws_Method"].ToString();
                            ViewState["LogFilepath"]= lstUser.Rows[0]["DefaultLogPath"].ToString();
                        }
                        break;
                        }
                    }
                }
            grvRpt.Rebind();
            
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void rptAPI_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ApiClick")
            {
                hfRequestJSON.Value = "";
                hfResponseJSON.Value = "";
                pnlLogTable.Visible = true;
                pnlLogFile.Visible = false;
                foreach (RepeaterItem ri in rptAPI.Items)
                {
                    LinkButton btnAll = ri.FindControl("btnApi") as LinkButton;
                    Panel rowPanelAll = (Panel)btnAll.FindControl("rowpanel");
                    rowPanelAll.BackColor = Color.White;
                }

                LinkButton btn = e.CommandSource as LinkButton;
                Panel rowPanel = (Panel)btn.FindControl("rowpanel");

                string iwsID = btn.CommandArgument.ToString();
                ViewState["iwsID"] = iwsID.ToString();

                rowPanel.BackColor = Color.AliceBlue;
                System.Data.DataTable lstUser = default(System.Data.DataTable);
                lstUser = ObjclsFrms.loadList("SelectPayloadForAPI", "sp_Transaction", iwsID.ToString());
                if (lstUser.Rows.Count > 0)
                {
                    hfRequestJSON.Value = lstUser.Rows[0]["iws_Request"].ToString();
                    ViewState["URL"] = lstUser.Rows[0]["iws_URL"].ToString();
                    ViewState["Method"] = lstUser.Rows[0]["iws_Method"].ToString();
                    ViewState["LogFilepath"] = lstUser.Rows[0]["DefaultLogPath"].ToString();
                    ViewState["InitiatedFrom"] = lstUser.Rows[0]["InitiatedFrom"].ToString();

                }

                string APIName = lstUser.Rows[0]["iws_Name"].ToString();

                string Initiated = lstUser.Rows[0]["InitiatedFrom"].ToString();

                if (Initiated == "ERP")

                {
                    pnlLogTable.Visible = false;
                    PlaceHolder1.Visible = true;
                    RadGrid2.Rebind();

                }
                else {


                    grvRpt.Rebind();


                }

                //if (APIName == "Customer Special Price" || APIName == "Outstanding Invoices")
                //{
                //    plhFilter.Visible = true;
                //    hfRequestJSON.Visible = true;
                //}
                //else
                //{
                //    hfRequestJSON.Visible = true;
                //    plhFilter.Visible = false;
                //}

                //if (APIName == "Outstanding Invoices" || APIName == "Load Request")
                //{
                //    hfRequestJSON.Visible = false;
                //}
                //else
                //{
                //    hfRequestJSON.Visible = true;
                //}
                grvRpt.Rebind();

                // Register script to set the values of Ace editors
                string script = $@"
            <script>
                document.addEventListener('DOMContentLoaded', function () {{
                    var txtPayload = ace.edit('txtPayload');
                    var txtResponse = ace.edit('txtResponse');
                    txtPayload.setValue(document.getElementById('{hfRequestJSON.ClientID}').value, 1);
                    txtResponse.setValue(document.getElementById('{hfResponseJSON.ClientID}').value, 1);
                }});
            </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "SetAceEditorValues", script, false);
            }
        }

        public void LoadList()
        {
            System.Data.DataTable lstUser = default(System.Data.DataTable);
            lstUser = ObjclsFrms.loadList("SelectLogHeader", "sp_Transaction", ViewState["iwsID"].ToString());
            grvRpt.DataSource = lstUser;

        }


        public void LoadList1()
        {
            System.Data.DataTable lstUser = default(System.Data.DataTable);
            lstUser = ObjclsFrms.loadList("SelectHeaderform", "sp_Transaction", ViewState["iwsID"].ToString());
            RadGrid2.DataSource = lstUser;

        }

        public void TotalWS()
        {
            System.Data.DataTable lstUser = default(System.Data.DataTable);
            lstUser = ObjclsFrms.loadList("SelectTotalCountOfWS", "sp_Transaction");


            if (lstUser.Rows.Count > 0)
            {

                string totcount = lstUser.Rows[0]["numberofWS"].ToString();

                lblTotCount.Text = "Number of APIs : " + totcount;

            }
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
        public string WebServiceCal(string URL, string jsonData)
        {

            try
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
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "IntegrationRun.aspx", "WebserviceCall-Success-" + responseFromServer);
                    response.Close();
                    return responseFromServer;
                }



            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "UndoPickingPicklist.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }

        protected void lnkRun_Click(object sender, EventArgs e)
        {
            string url = ViewState["URL"].ToString();
            string payload = hfRequestJSON.Value;

            // Get the current time for the request
            string requestTime = DateTime.Now.ToString("HH:mm:ss");
            lblRequestTime.Text = "Request Time: " + requestTime;

            // Make the web service call
            string responseJson = WebServiceCal(url, payload);

            // Format the response JSON
            string formattedResponseJson = FormatJson(responseJson);

            // Get the current time for the response
            string responseTime = DateTime.Now.ToString("HH:mm:ss");
            lblResponseTime.Text = "Response Time: " + responseTime;

            // Update the hidden field with the response JSON
            hfResponseJSON.Value = formattedResponseJson;

            // Optionally, update the response in the Ace editor directly (if using AJAX postback)
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateAceEditorResponse",
                $"updateResponseEditor('{formattedResponseJson.Replace("'", "\\'").Replace(Environment.NewLine, "\\n")}');", true);

            // Refresh the grid or perform other actions as needed
            grvRpt.Rebind();
            pnlLogTable.Visible = true;

            // Load log file if needed
            LoadLogFile();
        }

        private string FormatJson(string json)
        {
            if (string.IsNullOrEmpty(json))
                return string.Empty;

            try
            {
                var parsedJson = Newtonsoft.Json.Linq.JToken.Parse(json);
                return parsedJson.ToString(Newtonsoft.Json.Formatting.Indented);
            }
            catch (Exception)
            {
                // Handle the case where the JSON is invalid or cannot be parsed
                return json;
            }
        }




        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
                RadTextBox ResponseFromERP = (RadTextBox)itm.FindControl("txtResponseFromERP");
                DataRowView dataItem = (DataRowView)itm.DataItem;
                ResponseFromERP.Text = dataItem["ResponseFromERP"].ToString();

            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("LogFile"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string Filepath = dataItem["FileName"].Text.ToString();

               string URL = ConfigurationManager.AppSettings.Get("BackendURL");
                URL = URL + ( ViewState["LogFilepath"].ToString().Replace("\\","/")) + "/"+Filepath;
                ObjclsFrms.TraceService("URL:"+URL);
                OpenNewBrowserWindow(URL , this);
            }

        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            pnlLogFile.Visible = true;
            LoadLogFile();
        }

        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
       {
            LoadList1();
        }

        protected void RadGrid2_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
                RadTextBox ResponseFromDigits = (RadTextBox)itm.FindControl("TxtResponseFromDigits");
                DataRowView dataItem = (DataRowView)itm.DataItem;
                ResponseFromDigits.Text = dataItem["ResponseFromDigits"].ToString();

            }
        }

        protected void lnkapiDoc_Click(object sender, EventArgs e)
        {

            string ID = ViewState["iwsID"].ToString();
            Response.Redirect("APIDocumentation.aspx?Id=" + ID);
        }
    }
}