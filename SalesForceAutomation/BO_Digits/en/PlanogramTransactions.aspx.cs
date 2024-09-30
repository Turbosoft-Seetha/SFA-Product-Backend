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
    public partial class PlanogramTransactions : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                // rdfromDate.SelectedDate = DateTime.Now;
                // rdendDate.SelectedDate = DateTime.Now.AddDays(1);
                //Customers();
                //Route();

                try
                {
                   


                    if (Session["RFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["RFDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        // Session["FDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["RTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["RTDate"].ToString());
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
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    Route();


                    if (Session["RTrotid"] != null)
                    {
                        string routeID = Session["RTrotid"].ToString();
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
                        string routecondition = " plt_rot_ID in (" + rotid + ")";
                    }

                    Customers();

                    if (Session["RTcusID"] != null)
                    {
                        int a = rdCustomer.Items.Count;
                        string cusID = Session["RTcusID"].ToString();
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


                }
                catch
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    GetGridSession(grvRpt, "ReturnApproval");

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
            //string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            //string[] arr = { fromDate.ToString(), toDate.ToString() };
            string rotid = rot();
            string routeCondition = " rcs_rot_ID in (" + rotid + ")";
            rdCustomer.DataSource = ObjclsFrms.loadList("PlanogramCustomers", "sp_Masters", routeCondition.ToString());
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        public void Route()
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { toDate.ToString() };
            rdRoute.DataSource = ObjclsFrms.loadList("PlanogramRoute", "sp_Masters", fromDate.ToString(), arr);
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
                return "plt_cus_ID";
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
                return "plt_rot_ID";
            }

        }
        public string mainConditions()
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rotid = rot();
            string customer = Cus();


            string mainCondition = "";
            string customerCondition = "";
            string rotCondition = "";


            string dateCondition = "";
            try
            {
                

                dateCondition = "  and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";

                if (rotid.Equals("0"))
                {
                    rotCondition = "";
                }
                else
                {
                    rotCondition = " and plt_rot_ID in (" + rotid + ")";
                }

                if (customer.Equals("0"))
                {
                    customerCondition = "";
                }
                else
                {
                    customerCondition = " plt_cus_ID in (" + customer + ")";
                }
                //if (OrdID.Equals("0"))
                //{
                //    OrderCondition = "";
                //}
                //else
                //{
                //    OrderCondition = " and ord_ID in (" + OrdID + ")";
                //}
            }
            catch (Exception ex)
            {

            }

            mainCondition += customerCondition;
            mainCondition += rotCondition;
            mainCondition += dateCondition;

            // mainCondition += OrderCondition;
            return mainCondition;
        }

        public void LoadList()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPlanogramTransaction", "sp_Masters", mainCondition);
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void rdfromDate_SelectedDateChanged1(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
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



        protected void rdendDate_SelectedDateChanged1(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
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

        


        protected void rdCustomer_SelectedIndexChanged1(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

       

        protected void lnkFilter_Click1(object sender, EventArgs e)
        {
            try
            {

                if (Session["RFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["RFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["RFDate"].ToString());
                    }
                    else
                    {
                        Session["RFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    Session["RFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["RTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["RTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["RTDate"].ToString());
                    }
                    else
                    {
                        Session["RTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["RTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);

                if (Session["RTrotid"] != null)
                {
                    string routeID = rot();
                    if (routeID == Session["RTrotid"].ToString())
                    {
                        string rotid = rot();

                    }
                    else
                    {
                        string rotid = rot();
                        Session["RTrotid"] = rotid;
                    }


                }
                else
                {
                    string rotid = rot();
                    Session["RTrotid"] = rotid;
                }
                if (Session["RTcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["RTcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["RTcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["RTcusID"] = cusID;
                }

            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();

        }


        protected void save_Click1(object sender, EventArgs e)
        {

        }

        //protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        //{
        //    if (e.Item is GridDataItem)
        //    {
        //        GridDataItem item = (GridDataItem)e.Item;


        //        HyperLink imgg1 = (HyperLink)item.FindControl("img");
        //        string att1 = imgg1.NavigateUrl.ToString();


        //        Image itmImage = (Image)item.FindControl("itmImage");
        //        string url1 = itmImage.ImageUrl.ToString();

        //        //Image salRecieptImage = (Image)item.FindControl("salRecieptImage");
        //        //string url2 = salRecieptImage.ImageUrl.ToString();



        //        if (att1.Equals("../"))
        //        {

        //            imgg1.NavigateUrl = "";
        //            itmImage.ImageUrl = "../assets/media/icons/imagenotavailable.png";


        //        }


        //    }

        //}



        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;
                string imah = dataItem["plg_Image"].Text.ToString();
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
                        hl.NavigateUrl = "../" + values[i].ToString();
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["Images"].Controls.Add(hl);
                    }
                }
                //dataItem["mei_Images"].Text = imah.Replace("../", "http://93.177.125.68/");
            }
        }

       

        protected void btnOK_Click1(object sender, EventArgs e)
        {

        }
    }
}