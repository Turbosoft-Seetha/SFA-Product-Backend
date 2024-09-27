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
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ApprovalHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    GetGridSession(grvRpt, "Approval");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                }

                try
                {
                    if (Session["AprFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["AprFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        // Session["FDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["AprTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["AprTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now.AddDays(1);
                        // Session["TDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }
                    rdendDate.MaxDate = DateTime.Now.AddDays(1);
                }
                catch (Exception ex)
                {

                }
                //rdfromDate.SelectedDate = DateTime.Now;
                //rdendDate.SelectedDate = DateTime.Now.AddDays(1);

                try
                {
                    Route();
                    string rotID = Rot();
                    string routeCondition = " dah_rot_ID in (" + rotID + ")";
                    Customers(routeCondition);
                    // CusHead();

                    if (Session["Route"] != null)
                    {
                        string routeID = Session["Route"].ToString();
                        string[] ar = routeID.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in rot.Items)
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
                        string Route = Rot();
                        string RouteCondition = " dah_rot_ID in (" + Route + ")";
                    }
                    if (Session["CusHead"] != null)
                    {

                        string cshID = Session["CusHead"].ToString();
                        string[] ar = cshID.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in Rdcushead.Items)
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
                        string CusHead = Cus();
                        string cusheadcondition = "cus_ID in (" + CusHead + ")";
                        //Custmr(cshCondition);
                    }

                }
                catch
                {

                }

            }
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
        public void Route()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { toDate.ToString() };
            rot.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_DeliveryApproval", fromDate.ToString(),arr);
            rot.DataTextField = "rot_Name";
            rot.DataValueField = "rot_ID";
            rot.DataBind();
        }
       

        public void Customers(string routeCondition)
        {

            Rdcushead.DataSource = ObjclsFrms.loadList("SelCustomerforTransaction", "sp_DeliveryApproval", routeCondition);
            Rdcushead.DataTextField = "cus_Name";
            Rdcushead.DataValueField = "cus_ID";
            Rdcushead.DataBind();
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
            var CollectionMarket = rot.CheckedItems;
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
                return "dah_rot_ID";
            }
        }
       
        public string mainConditions()
        {
            string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string todate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

           // string order = ordernum();
            //string customer = Cus();
            string Route = Rot();
            string CusHead = Cus();
            string RouteCondition = "";
            string CusHeadCondition = "";
            string mainCondition = "";
           // string customerCondition = "";
            string dateCondition = "";
            //string orderCondition = "";
            try
            {
                dateCondition = " (cast(A.CreatedDate as date) between cast('" + fromdate + "' as date) and cast('" + todate + "' as date)) ";
                if (Route.Equals("0"))
                {
                    RouteCondition = "";
                }
                else
                {
                    RouteCondition = " and dah_rot_ID in (" + Route + ")";
                }
                if (CusHead.Equals("0"))
                {
                    CusHeadCondition = "";
                }
                else
                {
                    CusHeadCondition = " and ord_cus_ID in (" + CusHead + ")";
                }
                //if (customer.Equals("0"))
                //{
                //    customerCondition = "";
                //}
                //else
                //{
                //    customerCondition = " and ord_cus_ID in (" + customer + ")";
                //}
                //if (order.Equals("0"))
                //{
                //    orderCondition = "";
                //}
                //else
                //{
                //    orderCondition = " and dsp_ord_ID in (" + order + ")";
                //}
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
           // mainCondition += customerCondition;
           // mainCondition += orderCondition;
            mainCondition += RouteCondition;
            mainCondition += CusHeadCondition;
            return mainCondition;
        }

        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListApprovalHeader", "sp_DeliveryApproval", mainCondition);
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["AprFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["AprFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["AprFDate"].ToString());
                    }
                    else
                    {
                        Session["AprFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["AprFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["AprTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["AprTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["AprTDate"].ToString());
                    }
                    else
                    {
                        Session["AprTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["AprTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);

                if (Session["Route"] != null)
                {
                    string routeID = Rot();
                    if (routeID == Session["Route"].ToString())
                    {
                        string Route = Rot();

                    }
                    else
                    {
                        string Route = Rot();
                        Session["Route"] = Route;
                    }


                }
                else
                {
                    string Route = Rot();
                    Session["Route"] = Route;
                }
                if (Session["CusHead"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["CusHead"].ToString())
                    {
                        string CusHead = Cus();

                    }
                    else
                    {
                        string CusHead = Cus();
                        Session["CusHead"] = CusHead;
                    }

                }
                else
                {
                    string CusHead = Cus();
                    Session["CusHead"] = CusHead;
                }



            }
            catch (Exception ex)
            {

            }
            LoadList();
            grvRpt.Rebind();
        }
        public string GetSelectedItemsFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {
                        RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");

                        string selectedValue = rbActions.SelectedValue;
                        string dah_ID = item.GetDataKeyValue("dah_ID").ToString();
                        if (!string.IsNullOrEmpty(selectedValue))
                        {
                            // Do something with the selected value
                            if (selectedValue == "A")
                            {
                                string Status = "A";

                                createNode(dah_ID, Status, writer);
                                c++;
                            }
                            else if (selectedValue == "R")
                            {
                                string Status = "R";

                                createNode(dah_ID, Status, writer);
                                c++;
                            }
                        }


                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                }

                if (c == 0)
                {
                    return null;
                }
                else
                {
                    return sw.ToString();
                }
            }
        }
        private void createNode(string dah_ID, string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("dah_ID");
            writer.WriteString(dah_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        public void Save()
        {
            string dahID = GetSelectedItemsFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable lstData = new DataTable();
            string[] arr = { user };
            string resp = ObjclsFrms.SaveData("sp_PartialDeliveryForApproval", "TemporaryCreditApproval", dahID.ToString(), arr);
            int res = Int32.Parse(resp);

            string url = ConfigurationManager.AppSettings.Get("DelFinalURL");
            string json = "";
            if (res > 0)
            {
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ApprovalHeader.aspx", "WebserviceCall-Starts-" +DateTime.Now.ToString());

                WebServiceCal(url,json);
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ApprovalHeader.aspx", "WebserviceCall-Ends-" + DateTime.Now.ToString());

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Temporary Credit Updated successfully');</script>", false);
               
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
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
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ApprovalHeader.aspx", "WebserviceCall-Success-"+ responseFromServer);
                    response.Close();
                    return responseFromServer;
                }



            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ApprovalHeader.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }
        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApprovalHeader.aspx");
        }


        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApprovalHeader.aspx");
        }


      

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "Approval");
            }
            catch (Exception ex)
            {
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("dah_ID").ToString();
                string type = dataItem["Type"].Text.ToString();
                if (type == "PD" || type == "TC")
                {
                    Response.Redirect("PartialDeliveryDetailApproval.aspx?HID=" + ID + "&&Mode=" + type);
                }


            }

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                RadioButtonList actionBtn = (RadioButtonList)item.FindControl("rbActions");
                ImageButton detailButton = (ImageButton)item.FindControl("Detail");

                if ((item["Type"].Text == "PD"))
                {
                    actionBtn.Visible = false;

                }
                else
                {
                    actionBtn.Visible = true;
                    actionBtn.Enabled = true;
                   
                    detailButton.Visible = false;
                }
            }
        }

        protected void lnkConfirm_Click(object sender, EventArgs e)
        {
            if (grvRpt.MasterTableView.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

            }
            else
            {

                string selectedValue;
                foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                {
                    RadioButtonList rbActions = (RadioButtonList)item.FindControl("rbActions");

                    selectedValue = rbActions.SelectedValue;
                    //if (string.IsNullOrEmpty(selectedValue))
                    //{
                    //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);

                    //}
                    //else
                    //{
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                   // }
                }
            }

        }
       
       

        protected void Rdcushead_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string cus = Cus();
            string cuscondition = " ord_cus_ID in (" + cus + ")";
           
        }

       
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
            string rot = Rot();
            string rotcondition = "dah_rot_ID in (" + rot + ")";
            Customers(rotcondition);

        }

        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
            string rot = Rot();
            string rotcondition = "dah_rot_ID in (" + rot + ")";
            Customers(rotcondition);

        }

        protected void rot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = Rot();
            string rotcondition = "dah_rot_ID in (" + rot + ")";
            Customers(rotcondition);

        }
    }
}