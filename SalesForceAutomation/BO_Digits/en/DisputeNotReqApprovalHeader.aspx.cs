using SalesForceAutomation.Admin;
using SalesForceAutomation.BO_Digits.ar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class DisputeNotReqApprovalHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["mode"], out Mode);

                return Mode;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                btnAll.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");                
                DateCheck.Checked = true;

                if (Session["DRStatus"] == null)
                {
                    Session["DRStatus"] = "";
                }
                else
                {
                    //rdStatus.SelectedValue = Session["DRStatus"].ToString();
                }
                if (Mode == 1) // While loading page from dashboard 
                {
                    rdRoute.Enabled = false;
                    rdCustomer.Enabled = false;
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;

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
                        Route();
                        Counts();
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");

                    }

                }
                else
                {
                    try
                    {


                        if (Session["DRFDate"] != null)
                        {

                            rdfromDate.SelectedDate = DateTime.Parse(Session["DRFDate"].ToString());
                        }
                        else
                        {
                            rdfromDate.SelectedDate = DateTime.Now.AddDays(-29);
                            // Session["FDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                        }
                        //rdfromDate.MaxDate = DateTime.Now;

                        if (Session["DRTDate"] != null)
                        {

                            rdendDate.SelectedDate = DateTime.Parse(Session["DRTDate"].ToString());
                        }
                        else
                        {
                            rdendDate.SelectedDate = DateTime.Now;
                            // Session["TDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                        }
                        rdendDate.MaxDate = DateTime.Now.AddDays(1);
                        Route();
                        Counts();
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }
                if (Mode == 1)
                {
                    if (Session["Route"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string rotID = Session["Route"].ToString();
                        string[] ar = rotID.Split(',');
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
                        string routeCondition = " drh_rot_ID in (" + rotID + ")";
                    }
                    else
                    {
                        string rotID = rot();
                        string routeCondition = " drh_rot_ID in (" + rotID + ")";

                    }
                    Customers();
                    int j = 1;
                    foreach (RadComboBoxItem itmss in rdCustomer.Items)
                    {
                        itmss.Checked = true;
                        j++;
                    }
                    string cusID = Cus();
                    string cusCondition = "D.drh_cus_ID in (" + cusID + ")";

                }
                else
                {
                    try
                    {
                        if (Session["DRrotid"] != null)
                        {
                            string routeID = Session["DRrotid"].ToString();
                            string[] ar = routeID.Split(',');
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
                            string rotid = rot();
                            string routecondition = " drh_rot_ID in (" + rotid + ")";
                        }
                        Customers();

                        if (Session["DRcusID"] != null)
                        {
                            int a = rdCustomer.Items.Count;
                            string cusID = Session["DRcusID"].ToString();
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
                            string cusCondition = "D.drh_cus_ID in (" + cusID + ")";
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");
                    }
                }                     


                   
               
                   
                    try
                {
                    GetGridSession(grvRpt, "DisputeReqApproval");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
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

                Response.Redirect("~/SignIn.aspx");

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
                Response.Redirect("~/SignIn.aspx");


            }

        }

        public void Customers()
        {
            
            string rotid = rot();
            string route = "Where rcs_rot_id in("+ rotid + ")";
            rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomers", "sp_DisputeNoteRequest", route.ToString());
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { toDate.ToString() };
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_DisputeNoteRequest", fromDate.ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
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
                return "drh_cus_ID";
            }

        }
        public string rot()
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
                return "drh_rot_ID";
            }

        }
        public string mainConditions()
        {
            //string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotid = rot();
            string customer = Cus();
            string status = Session["DRStatus"].ToString();

            string mainCondition = "";
            string customerCondition = "";
            string rotCondition = "";
            string statusCondition = "";


            string dateCondition = "";
            try
            {
                if (Session["DRStatus"].ToString() == "")
                {
                    statusCondition = " and isnull(A.Status,'P') in ('P', 'A', 'R', 'AT') ";
                }
                else if (Session["DRStatus"].ToString() == "P")
                {
                    statusCondition = " and isnull(A.Status,'P') in ('P') ";
                }
                else if (Session["DRStatus"].ToString() == "AT")
                {
                    statusCondition = " and isnull(A.Status,'P') in ('AT') ";
                }
                else if (Session["DRStatus"].ToString() == "A")
                {
                    statusCondition = " and isnull(A.Status,'P') in ('A') ";
                }
                else
                {
                    statusCondition = " and isnull(A.Status,'P') in ('R') ";
                }
                if (DateCheck.Checked == true)
                {
                    if (Mode == 1)
                    {
                        rdfromDate.Enabled = false;
                        rdendDate.Enabled = false;
                    }
                    else
                    {
                        rdfromDate.Enabled = true;
                        rdendDate.Enabled = true;
                    }
                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date))  ";
                }
                else
                {
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;

                }
                if (rotid.Equals("0"))
                {
                    rotCondition = "";
                }
                else
                {
                    rotCondition = " and drh_rot_ID in (" + rotid + ")";
                }

                if (customer.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and drh_cus_ID in (" + customer + ")";
                }
               
            }
            catch (Exception ex)
            {

            }
            mainCondition += customerCondition;
            mainCondition += rotCondition;
            mainCondition += dateCondition;
            mainCondition += statusCondition;

            return mainCondition;
        }

        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            string user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { user.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListDisputeNoteApprovalHeader", "sp_DisputeNoteRequest", mainCondition,arr);           
            grvRpt.DataSource = lstUser;
            //grvRpt.DataBind();
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                //Session["DRStatus"] = rdStatus.SelectedValue.ToString(); 

                if (Session["DRFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["DRFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["DRFDate"].ToString());
                    }
                    else
                    {
                        Session["DRFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["DRFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now.AddDays(-30);

                if (Session["DRTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["DRTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["DRTDate"].ToString());
                    }
                    else
                    {
                        Session["DRTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["DRTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now;

                if (Session["DRrotid"] != null)
                {
                    string routeID = rot();
                    if (routeID == Session["DRrotid"].ToString())
                    {
                        string rotid = rot();

                    }
                    else
                    {
                        string rotid = rot();
                        Session["DRrotid"] = rotid;
                    }


                }
                else
                {
                    string rotid = rot();
                    Session["DRrotid"] = rotid;
                }
                if (Session["DRcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["DRcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["DRcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["DRcusID"] = cusID;
                }

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
            Counts();
        }




        protected void save_Click(object sender, EventArgs e)
        {
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("DisputeNotReqApprovalHeader.aspx");
        }


        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("DisputeNotReqApprovalHeader.aspx");
        }




        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "DisputeReqApproval");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("drh_ID").ToString();

                Response.Redirect("DisputeNoteApprovalDetail.aspx?drhID=" + ID);



            }

        }


        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Route();
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
            Route();
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
        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customers();
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;



              


                GridDataItem dataItem = (GridDataItem)e.Item;
                ImageButton DetailBtn = (ImageButton)item.FindControl("Detail");
                string disptype = dataItem["drh_DisputeType"].ToString();
                if (disptype.Equals("Other"))
                {
                    DetailBtn.Visible = false;
                }
                else
                {
                    DetailBtn.Visible = true;
                }
                string imah = dataItem["drh_Image"].Text.Replace(" ", "");
               
                string[] values = imah.Split(',');
                imah = imah.Replace("&nbsp;", null);
                for (int i = 0; i < values.Length; i++)
                {
                    if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                    {

                        Image img = new Image();
                        img.ID = "Image1" + i.ToString();
                        img.ImageUrl = "../" + values[i].ToString();
                        img.Height = 20;
                        img.Width = 20;
                        img.BorderStyle = BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        if (values[i].Equals("../UploadFiles/NoImage/imagenotavailable.png"))
                        {
                            hl.NavigateUrl = "";
                        }
                        else
                        {
                            hl.NavigateUrl = "../" + values[i].ToString();
                        }
                       
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["Images"].Controls.Add(hl);
                    }
                }
            }
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            btnPending.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnAll.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["DRStatus"] = "";
            LoadList();
            grvRpt.DataBind();
            Counts();
        }

        protected void btnPending_Click(object sender, EventArgs e)
        {
            btnAll.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnPending.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["DRStatus"] = "P";
            LoadList();
            grvRpt.DataBind();
            Counts();
        }

        protected void btnApproved_Click(object sender, EventArgs e)
        {
            btnPending.Attributes.Remove("Style");
            btnAll.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnApproved.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["DRStatus"] = "A";
            LoadList();
            grvRpt.DataBind();
            Counts();
        }

        protected void btnRejected_Click(object sender, EventArgs e)
        {
            btnPending.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnAll.Attributes.Remove("Style");
            btnActionTaken.Attributes.Remove("Style");
            btnRejected.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["DRStatus"] = "R";
            LoadList();
            grvRpt.DataBind();
            Counts();
        }
        

        protected void Counts()
        {
            string cusID = Cus();
            string rotID = rot();
            string mainCondition = "";
            string customerCondition = "";
            string dateCondition = "";

            mainCondition = " drh_rot_ID in (" + rotID + ")";
            string userID = UICommon.GetCurrentUserID().ToString();
            string[] arr = { userID.ToString() };
            if (DateCheck.Checked == true)
            {
                if (Mode == 1)
                {
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                }
                else
                {
                    rdfromDate.Enabled = true;
                    rdendDate.Enabled = true;
                }
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))  ";
            }
            else
            {
                rdfromDate.Enabled = false;
                rdendDate.Enabled = false;

            }


            if (cusID.Equals("0"))
            {
                customerCondition = "";
            }
            else
            {
                customerCondition = " and drh_cus_ID in (" + cusID + ")";
            }



            mainCondition += dateCondition;
            mainCondition += customerCondition;

            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelDisputeNoteReqApprovalCount", "sp_DisputeNoteRequest", mainCondition.ToString(), arr);
            if (lstUser != null && lstUser.Rows.Count > 0)
            {
                btnAll.Text = "All(" + lstUser.Rows[0]["AllCount"].ToString() + ")";
                btnPending.Text = "Pending(" + lstUser.Rows[0]["PendingCount"].ToString() + ")";
                btnActionTaken.Text = "Action Taken(" + lstUser.Rows[0]["ActionTakenCount"].ToString() + ")";
                btnApproved.Text = "Approved(" + lstUser.Rows[0]["ApprovedCount"].ToString() + ")";
                btnRejected.Text = "Rejected(" + lstUser.Rows[0]["RejectedCount"].ToString() + ")";
            }
        }
        protected void DateCheck_CheckedChanged(object sender, EventArgs e)
        {           
            if (DateCheck.Checked)
            {
                if (Mode == 1)
                {
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                }
                else
                {
                    rdfromDate.Enabled = true;
                    rdendDate.Enabled = true;
                }
            }
            else
            {
                rdfromDate.Enabled = false;
                rdendDate.Enabled = false;
            }
            Counts();
            LoadList();
            grvRpt.DataBind();

        }

        protected void btnActionTaken_Click(object sender, EventArgs e)
        {
            btnAll.Attributes.Remove("Style");
            btnPending.Attributes.Remove("Style");
            btnApproved.Attributes.Remove("Style");
            btnRejected.Attributes.Remove("Style");
            btnActionTaken.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
            Session["DRStatus"] = "AT";
            LoadList();
            grvRpt.DataBind();
            Counts();
        }
    }
}