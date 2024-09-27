using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListNewRequest : System.Web.UI.Page
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
                Route();
                if (Mode == 3 || Mode == 2 || Mode == 1)
                {
                    try
                    {

                        ViewState["fromdate"] = Session["FromDate"];
                        ViewState["todate"] = Session["ToDate"];
                        ViewState["route"] = Session["Route"];
                        string r = Session["Route"].ToString();
                        //string ed = Session["tDate"].ToString();

                        if (Session["FromDate"] != null)
                        {
                            rdFromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                        }
                        if (Session["ToDate"] != null)
                        {
                            rdEndDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                        }
                        Route();
                        RouteFromDashboard();

                    }
                    catch (Exception ex)
                    {
                        UICommon.LogException(ex, "List Request");
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "ListNewRequest.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        Response.Redirect("~/SignIn.aspx");

                    }
                }
                else // While loading page from transaction menu
                {
                    //  rdFromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    rdFromDate.SelectedDate= DateTime.Now;
                    rdEndDate.SelectedDate = DateTime.Now;

                    Route();
                    int j = 1;
                    foreach (RadComboBoxItem itmss in rdRoute.Items)
                    {
                        itmss.Checked = true;
                        j++;
                    }
                }




                string rotID = Rot();
                string routeCondition = " rcs_rot_ID in (" + rotID + ")";

                Customers(routeCondition);
                CustomerFilter();
            }
        }
        public void RouteFromDashboard()
        {
            try
            {


                if (Session["Route"] != null)
                {
                    string ids = Session["Route"].ToString();
                    string[] words = ids.Split(',');

                    foreach (var word in words)
                    {
                        foreach (RadComboBoxItem rd in rdRoute.Items)
                        {
                            if (rd.Value.Equals(word))
                            {
                                rd.Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

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

        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforNewRequests", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public void Customers(string routeCondition)
        {
            rdCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerGeoLocDropdown", "sp_Masters", routeCondition);
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in rdCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }
        public string Cus()
        {
            var ColelctionMarkets = rdCustomer.CheckedItems;
            string cusID = "";
            int k = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (k == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (k > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (k == (MarCounts - 1))
                    {
                        cusID += item.Value;
                    }
                    k++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }
        public string mainConditions(string rotID)
        {
            string CusID = Cus();
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " and udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                //string CusID = rdCustomer.SelectedValue.ToString();
                if (CusID.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " and req_cus_ID in (" + CusID + ")";
                }


            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            return mainCondition;
        }

        public void ListData()
        {

            DataTable lstUser = default(DataTable);
            if (Mode == 1)
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";
                    try
                    {
                        mainCondition = mainConditions(Session["Route"].ToString());
                        string type = Request.Params["type"].ToString();
                        if (type.Equals("RR"))
                        {
                            mainCondition += " and A.Status = 'Responded'";
                        }
                        else if (type.Equals("NR"))
                        {
                            mainCondition += " and A.Status = 'Open'";
                        }

                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("~/SignIn.aspx");

                    }
                    lstUser = ObjclsFrms.loadList("SelectNewRequestPerformedfromDashboard", "sp_Merch_Dashboard", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
            else
            {
                string rotID = Rot();
                if (!rotID.Equals("0"))
                {
                    string mainCondition = "";
                    mainCondition = mainConditions(rotID);
                    lstUser = ObjclsFrms.loadList("SelectNewRequest", "sp_Masters", mainCondition);
                    grvRpt.DataSource = lstUser;
                }
            }
        }
     
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("req_ID").ToString();
                Response.Redirect("AddEditNewRequest.aspx?Id=" + ID);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string img1 = dataItem["rei_Image"].Text.ToString();
                string[] arrImg = img1.Split(',');
                for (int i = 0; i < arrImg.Length; i++)
                {
                    Image img = new Image();
                    img.ID = "Image1" + i.ToString();
                    img.ImageUrl = "../" + arrImg[i].ToString();
                    img.Height = 20;
                    img.Width = 20;
                    img.BorderStyle = BorderStyle.Groove;
                    img.BorderWidth = 2;
                    img.BorderColor = System.Drawing.Color.Black;
                    HyperLink hl = new HyperLink();
                    hl.NavigateUrl = "../" + arrImg[i].ToString();
                    hl.ID = "hl" + i.ToString();
                    hl.Target = "_blank";
                    hl.Controls.Add(img);
                    dataItem["Images"].Controls.Add(hl);
                }

                string img2 = dataItem["req_ResponseImage"].Text.ToString();
                string[] arrImg2 = img2.Split(',');
                for (int i = 0; i < arrImg2.Length; i++)
                {
                    Image img = new Image();
                    img.ID = "Image1" + i.ToString();
                    img.ImageUrl = "../" + arrImg2[i].ToString();
                    img.Height = 20;
                    img.Width = 20;
                    img.BorderStyle = BorderStyle.Groove;
                    img.BorderWidth = 2;
                    img.BorderColor = System.Drawing.Color.Black;
                    HyperLink hl = new HyperLink();
                    hl.NavigateUrl = "../" + arrImg2[i].ToString();
                    hl.ID = "hl" + i.ToString();
                    hl.Target = "_blank";
                    hl.Controls.Add(img);
                    dataItem["Image"].Controls.Add(hl);
                }
            }
        }

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            string routeCondition = " udp_rot_ID in (" + rotID + ")";
            Customers(routeCondition);
        }

        protected void lnkfilter_Click(object sender, EventArgs e)
        {
            ListData();
            grvRpt.Rebind();
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
    }
}