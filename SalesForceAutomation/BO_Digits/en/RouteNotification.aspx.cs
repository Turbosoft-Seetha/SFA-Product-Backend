using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Text;
using Newtonsoft.Json;



namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteNotification : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();

                try
                {
                    if (Session["RNFDate"] != null)
                    {

                        rdFromDate.SelectedDate = DateTime.Parse(Session["RNFDate"].ToString());
                    }
                    else
                    {
                        rdFromDate.SelectedDate = DateTime.Now;


                    }
                    //rdFromDate.MaxDate = DateTime.Now;

                    if (Session["RNTDate"] != null)
                    {

                        rdEndDate.SelectedDate = DateTime.Parse(Session["RNTDate"].ToString());
                    }
                    else
                    {
                        rdEndDate.SelectedDate = DateTime.Now;

                    }
                    
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    if (Session["RNrotID"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string route = Session["RNrotID"].ToString();
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


                    }
                    else
                    {
                        RouteFromTransaction();

                    }

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

                plhFilter.Visible = false;
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
                //Route(dposubareacondition);
                //rdFromDate.SelectedDate = DateTime.Now;
                //rdEndDate.SelectedDate = DateTime.Now;
                //RouteFromTransaction();
                //string rotID = Rot();
                //string routeCondition = "rnt_rot_ID in (" + rotID + ")";

                


            }
        }

       


        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }



        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "0";
            }
        }

        public string mainConditions(string rotID)
        {
            string dateCondition = "";
            string rotCondition = "";
            string modeCondition = "";
            string mainCondition = "";
            string flag = "";
            string mode = "";
            try 
            {


                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(N.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";


                if (ddlreadflag.SelectedValue.ToString() == "R")
            {
                flag = " (rnt_ReadFlag='y' and rnt_ReplyMessage is null) ";
            }
            else if (ddlreadflag.SelectedValue.ToString() == "RP")
            {
                flag = " (rnt_ReadFlag='y' and rnt_ReplyMessage is not null) ";
            }
            else if (ddlreadflag.SelectedValue.ToString() == "S")
            {
                flag = " (rnt_ReadFlag='N' and rnt_ReplyMessage is null) ";
            }
            else { flag = " (rnt_ReadFlag='y' or rnt_ReadFlag='N') "; }

                if (ddlmode.SelectedValue.ToString() == "S")
                { rotCondition = " rnt_rot_ID in (" + rotID + ") and ";
                }
           
                rotCondition += flag;

                if (ddlmode.SelectedValue.ToString() == "S")
                {
                    mode = " and isnull(rnt_Mode,'S')='S'";
                }
                else if (ddlmode.SelectedValue.ToString() == "C")
                {
                    mode = " and isnull(rnt_Mode,'S')='C'";
                }
                //else { mode = " and (rnt_Mode in ('S','C') or rnt_Mode is null) "; }
                else
                { mode = " and isnull(rnt_Mode,'S') in ('S','C') ";
                }

                modeCondition += mode;

            

            }
            catch (Exception ex)
            {

            }
            mainCondition += rotCondition;
            mainCondition += modeCondition;
            mainCondition += dateCondition;

            return mainCondition;

        }
        public void LoadList()
        {
            string rotID = Rot();

            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);

                DataTable lstUser = ObjclsFrms.loadList("ListRouteNotifications", "sp_Notifications", mainCondition.ToString());

                grvRpt.DataSource = lstUser;

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rnt_ID").ToString();
                ViewState["delID"] = ID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rnt_ID").ToString();
                Response.Redirect("RouteNotificationDetail.aspx?ID=" + ID);
            }
            if (e.CommandName.Equals("PushNot"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rnt_ID").ToString();
                ViewState["rnt_ID"] = ID.ToString();
                string mode = dataItem["rnt_Mode"].ToString();
                string[] ar = {mode};
                DataTable dt = new DataTable();
                dt= ObjclsFrms.loadList("SelToken", "sp_Notifications", ID,ar);
                if(dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Token"].ToString() == "N")
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>TokenModal();</script>", false); 
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>PushConfim();</script>", false);
                    }
                }
                
                
            }
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton DelBtn = (ImageButton)item.FindControl("Deletebtn");
                ImageButton DetailB = (ImageButton)item.FindControl("DetailBtn");


                if ((item["rnt_ReadFlag"].Text == "Read") || (item["rnt_ReadFlag"].Text == "Replied"))
                {
                    DelBtn.Visible = false;
                }
                else
                {
                    DelBtn.Visible = true;
                }
                if ((item["rnt_IsDetail"].Text == "N"))
                {
                    DetailB.Visible = false;
                }
                else
                {
                    DetailB.Visible = true;
                }

                


            }



        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteRouteNotification", "sp_Masters_UOM", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);

        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditRouteNotification.aspx?Id=0");

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["RNFDate"] != null)
                {
                    string fromdate = rdFromDate.SelectedDate.ToString();
                    if (fromdate == Session["RNFDate"].ToString())
                    {
                        rdFromDate.SelectedDate = DateTime.Parse(Session["RNFDate"].ToString());
                    }
                    else
                    {
                        Session["RNFDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdFromDate.SelectedDate = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    Session["RNFDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());

                }
                //rdFromDate.MaxDate = DateTime.Now;

                if (Session["RNTDate"] != null)
                {
                    string todate = rdEndDate.SelectedDate.ToString();
                    if (todate == Session["RNTDate"].ToString())
                    {
                        rdEndDate.SelectedDate = DateTime.Parse(Session["RNTDate"].ToString());
                    }
                    else
                    {
                        Session["RNTDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdEndDate.SelectedDate = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    Session["RNTDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                }
                //rdEndDate.MaxDate = DateTime.Now.AddDays(1);

                if (Session["RNrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["RNrotID"].ToString())
                    {
                        string rotID = Rot();
                    }
                    else
                    {
                        string rotID = Rot();
                        Session["RNrotID"] = rotID;
                    }
                }
                else
                {
                    string rotID = Rot();
                    Session["RNrotID"] = rotID;
                }

               





                
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }



            LoadList();
            grvRpt.Rebind();
        }
        public void Route()
        {
           
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_Notifications");
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Region()
        {
            ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }
        public void Depot(string RegCondition)
        {
            string[] arr = { RegCondition };
            ddldepot.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepot.DataTextField = "dep_Name";
            ddldepot.DataValueField = "dep_ID";
            ddldepot.DataBind();
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
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            ddldpoArea.DataSource = ObjclsFrms.loadList("SelectDepotAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoArea.DataTextField = "dpa_Name";
            ddldpoArea.DataValueField = "dpa_ID";
            ddldpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            ddldpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubAreaTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoSubArea.DataTextField = "dsa_Name";
            ddldpoSubArea.DataValueField = "dsa_ID";
            ddldpoSubArea.DataBind();
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
        protected void ddldepot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void ddldpoArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
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
        protected void ddldpoSubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            //Route(DposubAreaCondition);
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

        protected void ddlregion_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string regID = REG();
            string RegCondition = " dep_reg_ID in (" + regID + ")";
            Depot(RegCondition);
        }

       

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdFromDate.SelectedDate != null && rdEndDate.SelectedDate != null)
            {
                TimeSpan difference = rdEndDate.SelectedDate.Value - rdFromDate.SelectedDate.Value;
                DateTime endDate = rdFromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdEndDate.MaxDate = DateTime.Today;
                    rdEndDate.SelectedDate = endDate;
                }
                else
                {
                    rdEndDate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdFromDate.SelectedDate != null && rdEndDate.SelectedDate != null)
            {
                TimeSpan difference = rdEndDate.SelectedDate.Value - rdFromDate.SelectedDate.Value;
                DateTime startdate = rdEndDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdFromDate.SelectedDate = startdate;
                }
                else
                {
                    rdFromDate.MaxDate = DateTime.Today;
                }
            }
        }

        protected void ddlmode_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            if (ddlmode.SelectedValue == "S")
            {
                pnlRoute.Visible = true;
            }
            else
            {
                pnlRoute.Visible = false;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            rdFromDate.SelectedDate = DateTime.Now;
            rdEndDate.SelectedDate = DateTime.Now;
            //Route();
            RouteFromTransaction();
            ddlmode.SelectedValue = "A";
            ddlreadflag.SelectedValue = "A";
        }

       

        protected void Run_Click(object sender, EventArgs e)
        {

            string rnt_ID = ViewState["rnt_ID"].ToString();
            var jsonObject = new { rnt_ID = rnt_ID };  // Anonymous object
            string json = JsonConvert.SerializeObject(jsonObject);
            string url = ConfigurationManager.AppSettings.Get("PushNotification");
            // Make the web service call
            string responseJson = WebServiceCal(url,json);
            string Response = responseJson.Trim();

            string successMessage = "Response: " + responseJson;


            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successPushModal('" + successMessage + "');</script>", false);

        }

        protected void lnkOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("RouteNotification.aspx");
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
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteNotification.aspx", "WebserviceCall-Success-" + responseFromServer);
                    response.Close();
                    return responseFromServer;
                }



            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteNotification.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString();
            }
        }


        

    }
}