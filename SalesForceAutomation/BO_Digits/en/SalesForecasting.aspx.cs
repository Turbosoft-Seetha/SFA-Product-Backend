using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Licensing;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SalesForecasting : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    Session["RouteCode"] = "";
                    Session["CustomerCode"] = "";
                    Session["ProductCode"] = "";
                    Session["Mode"] = "";

                    if (Session["SalesForeCastDate"] != null)
                    {
                        rdDate.SelectedDate = DateTime.Parse(Session["SalesForeCastDate"].ToString());
                    }
                    else
                    {
                        rdDate.SelectedDate = DateTime.Now;
                    }

                    LoadData();

                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                LoadDataFilter();

                if (Session["SalesForeCastDate"] != null)
                {
                    string fromdate = rdDate.SelectedDate.ToString();
                    if (fromdate == Session["SalesForeCastDate"].ToString())
                    {
                        rdDate.SelectedDate = DateTime.Parse(Session["SalesForeCastDate"].ToString());
                    }
                    else
                    {
                        Session["SalesForeCastDate"] = DateTime.Parse(rdDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdDate.SelectedDate = DateTime.Parse(rdDate.SelectedDate.ToString());
                    Session["SalesForeCastDate"] = DateTime.Parse(rdDate.SelectedDate.ToString());

                }
            }   
            catch(Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "Filter_Click() Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
          
        }

        protected void grvRptRoutes_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick1"))
            {
                    try
                    {
                        foreach (GridDataItem di in grvRptRoutes.MasterTableView.Items)
                        {
                            di.BackColor = Color.Transparent;
                        }

                        GridDataItem item = grvRptRoutes.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                        string RouteCode = item["RouteCode"].Text.ToString();

                        Session["RouteCode"] = RouteCode.ToString();
                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    Session["Mode"] = "";
                    DataTable dt = (DataTable)Session["lstData"];
                        CustomerData(dt);
                        ItemsData(dt);
                    }
                    catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Saleforecasting.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }
        }
        protected void grvRptCustomers_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick2"))
            {
                try
                {
                    foreach (GridDataItem di in grvRptCustomers.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = grvRptCustomers.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                    string CustomerCode = item["CustomerCode"].Text.ToString();

                    Session["CustomerCode"] = CustomerCode.ToString();
                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    Session["Mode"] = "";
                    DataTable dt = (DataTable)Session["lstData"];

                    RoutesData(dt);
                    ItemsData(dt);

                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Saleforecasting.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }
        }

        protected void grvRptItems_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick3"))
            {
                try
                {
                    foreach (GridDataItem di in grvRptItems.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = grvRptItems.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                    string ProductCode = item["ProductCode"].Text.ToString();

                    Session["ProductCode"] = ProductCode.ToString();
                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    Session["Mode"] = "";
                    DataTable dt = (DataTable)Session["lstData"];

                    CustomerData(dt);
                    RoutesData(dt);

                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Saleforecasting.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            }
        }

        protected void grvRptRoutes_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }
        protected void grvRptCustomers_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
           
        }
        protected void grvRptItems_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
           
        }
        public void LoadData()
        {
            try
            {

                if (Session["lstData"] == null)
                {                   
                    string Date = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                    DataTable lstData = ObjclsFrms.loadList("SelSalesForecastingReport", "sp_ForecastingReport", Date);
                    Session["lstData"] = lstData;
                                   
                    if (lstData.Rows.Count > 0)
                    {
                        RouteCount(lstData);
                        CustomerCount(lstData);
                        ItemCount(lstData);


                        RoutesData(lstData);
                        CustomerData(lstData);
                        ItemsData(lstData);
                       
                    }
                    else
                    {
                        lblRouteCount.Text = "0";
                        lblCustomerCount.Text = "0";
                        lblItemCount.Text = "0";


                        grvRptRoutes.DataSource = null;
                        grvRptCustomers.DataSource = null;
                        grvRptItems.DataSource = null;

                        grvRptRoutes.DataBind();
                        grvRptCustomers.DataBind();
                        grvRptItems.DataBind();
                    }
                }
                else
                {
                    DataTable dt = (DataTable)Session["lstData"];
                    if (dt.Rows.Count > 0)
                    {
                        RouteCount(dt);
                        CustomerCount(dt);
                        ItemCount(dt);


                        RoutesData(dt);
                        CustomerData(dt);
                        ItemsData(dt);
                        
                    }
                    else
                    {
                        lblRouteCount.Text = "0";
                        lblCustomerCount.Text = "0";
                        lblItemCount.Text = "0";


                        grvRptRoutes.DataSource = null;
                        grvRptCustomers.DataSource = null;
                        grvRptItems.DataSource = null;
                      

                        grvRptRoutes.DataBind();
                        grvRptCustomers.DataBind();
                        grvRptItems.DataBind();
                    }


                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }


        }
        public void LoadDataFilter()
        {
            try
            {
                string Date = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                DataTable lstData = ObjclsFrms.loadList("SelSalesForecastingReport", "sp_ForecastingReport", Date);
                Session["lstData"] = null;
                Session["lstData"] = lstData;
                DateTime endDateTime = DateTime.Now;
                Session["ReloadTime"] = endDateTime.ToString("dd-MMM-yyyy h:mm tt");
                //lblReloadTime.Text = Session["ReloadTime"].ToString();

                if (lstData.Rows.Count > 0)
                {
                    RouteCount(lstData);
                    CustomerCount(lstData);
                    ItemCount(lstData);


                    RoutesData(lstData);
                    CustomerData(lstData);
                    ItemsData(lstData);

                }
                else
                {
                    lblRouteCount.Text = "0";
                    lblCustomerCount.Text = "0";
                    lblItemCount.Text = "0";

                    grvRptRoutes.DataSource = null;
                    grvRptCustomers.DataSource = null;
                    grvRptItems.DataSource = null;


                    grvRptRoutes.DataBind();
                    grvRptCustomers.DataBind();
                    grvRptItems.DataBind();
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "LoadDataFilter() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }
        public void RouteCount(DataTable dataTable)
        {
            try
            {
                var distinctRotCodeCount = dataTable.AsEnumerable()
                .GroupBy(row => row.Field<string>("RouteCode"))
                .Count();

                lblRouteCount.Text = distinctRotCodeCount.ToString();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "RouteCount() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        public void CustomerCount(DataTable dataTable)
        {
            try
            {
                var distinctCusCodeCount = dataTable.AsEnumerable()
                .GroupBy(row => row.Field<string>("CustomerCode"))
                .Count();

                lblCustomerCount.Text = distinctCusCodeCount.ToString();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "ItemCount() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        public void ItemCount(DataTable dataTable)
        {
            try
            {
                var distinctItemCodeCount = dataTable.AsEnumerable()
                .GroupBy(row => row.Field<string>("ProductCode"))
                .Count();

                lblItemCount.Text = distinctItemCodeCount.ToString();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecasting.aspx", "ItemCount() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }


        public void RoutesData(DataTable dataTable)
        {
            try
            {
                string RouteCode = "";
                string CustomerCode = "";
                string ProductCode = "";
                string Mode = "";

                
                if (Session["RouteCode"].ToString() == "")
                {
                    RouteCode = "";
                }
                else
                {
                    RouteCode = Session["RouteCode"].ToString();
                }

                if (Session["CustomerCode"].ToString() == "")
                {
                    CustomerCode = "";
                }
                else
                {
                    CustomerCode = Session["CustomerCode"].ToString();
                }

                if (Session["ProductCode"].ToString() == "")
                {
                    ProductCode = "";
                }
                else
                {
                    ProductCode = Session["ProductCode"].ToString();
                }

                if (Session["Mode"].ToString() == "")
                {
                    Mode = "";
                }
                else
                {
                    Mode = Session["Mode"].ToString();
                }

                if (Mode == "RR")
                {
                    DataTable lstForecastRoute = new DataTable();
                    lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                    lstForecastRoute.Columns.Add("RouteName", typeof(string));
                    lstForecastRoute.Columns.Add("CustomerCount", typeof(int));

                    var groupedData = dataTable.AsEnumerable()
                    .GroupBy(row => row.Field<string>("RouteCode"))
                    .Select(group => new
                    {
                        RouteCode = group.First().Field<string>("RouteCode"),
                        RouteName = group.First().Field<string>("RouteName"),
                        CustomerCount = group.Select(row => row.Field<string>("CustomerCode")).Distinct().Count()

                    })
                    .OrderByDescending(groupData => groupData.RouteCode);

                    foreach (var groupData in groupedData)
                    {
                        lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCount);
                    }

                    ViewState["lstForecastRoute"] = lstForecastRoute;
                    grvRptRoutes.DataSource = lstForecastRoute;
                    grvRptRoutes.DataBind();
                }
                else
                {
                    if ((!string.IsNullOrEmpty(CustomerCode)) && (!string.IsNullOrEmpty(ProductCode)))

                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerCount", typeof(int));


                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("CustomerCode") == CustomerCode && row.Field<string>("ProductCode") == ProductCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCount = group.Select(row => row.Field<string>("CustomerCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCount);
                        }



                        ViewState["lstRouteCusItems"] = lstForecastRoute;
                        grvRptRoutes.DataSource = lstForecastRoute;
                        grvRptRoutes.DataBind();
                    }
                    else if (!string.IsNullOrEmpty(CustomerCode))
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerCount", typeof(int));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("CustomerCode") == CustomerCode);

                        var groupedData = filteredData
                        .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCount = group.Select(row => row.Field<string>("CustomerCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptRoutes.DataSource = lstForecastRoute;
                        grvRptRoutes.DataBind();
                    }
                    else if (!string.IsNullOrEmpty(ProductCode))
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerCount", typeof(int));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("ProductCode") == ProductCode);

                        var groupedData = filteredData
                        .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCount = group.Select(row => row.Field<string>("CustomerCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptRoutes.DataSource = lstForecastRoute;
                        grvRptRoutes.DataBind();
                    }
                    else
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerCount", typeof(int));

                        var groupedData = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCount = group.Select(row => row.Field<string>("CustomerCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptRoutes.DataSource = lstForecastRoute;
                        grvRptRoutes.DataBind();
                    }

                }

                if (!string.IsNullOrEmpty(RouteCode))
                {
                    foreach (GridDataItem item in grvRptRoutes.Items)
                    {
                        // Assuming you have a column named "ProductCode" in your RadGrid
                        string gridRouteCode = item["RouteCode"].Text;

                        if (RouteCode.Equals(gridRouteCode))
                        {
                            item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Salesforecasting.aspx", "RoutesData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        public void CustomerData(DataTable dataTable)
        {
            try
            {
                string RouteCode = "";
                string CustomerCode = "";
                string ProductCode = "";
                string Mode = "";


                if (Session["RouteCode"].ToString() == "")
                {
                    RouteCode = "";
                }
                else
                {
                    RouteCode = Session["RouteCode"].ToString();
                }

                if (Session["CustomerCode"].ToString() == "")
                {
                    CustomerCode = "";
                }
                else
                {
                    CustomerCode = Session["CustomerCode"].ToString();
                }

                if (Session["ProductCode"].ToString() == "")
                {
                    ProductCode = "";
                }
                else
                {
                    ProductCode = Session["ProductCode"].ToString();
                }

                if (Session["Mode"].ToString() == "")
                {
                    Mode = "";
                }
                else
                {
                    Mode = Session["Mode"].ToString();
                }

                if (Mode == "RR")
                {
                    DataTable lstForecastRoute = new DataTable();
                    lstForecastRoute.Columns.Add("CustomerCode", typeof(string));
                    lstForecastRoute.Columns.Add("CustomerName", typeof(string));
                    lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                    var groupedData = dataTable.AsEnumerable()
                    .GroupBy(row => row.Field<string>("CustomerCode"))
                    .Select(group => new
                    {
                        CustomerCode = group.Key,
                        CustomerName = group.First().Field<string>("CustomerName"),
                        ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                    })
                    .OrderByDescending(groupData => groupData.CustomerCode);

                    foreach (var groupData in groupedData)
                    {
                        lstForecastRoute.Rows.Add(groupData.CustomerCode, groupData.CustomerName, groupData.ItemCount);
                    }

                    ViewState["lstForecastRoute"] = lstForecastRoute;
                    grvRptCustomers.DataSource = lstForecastRoute;
                    grvRptCustomers.DataBind();
                }
                else
                {
                    if ((!string.IsNullOrEmpty(RouteCode)) && (!string.IsNullOrEmpty(ProductCode)))

                    {
                        DataTable lstRouteCusItems = new DataTable();                       
                        lstRouteCusItems.Columns.Add("CustomerCode", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerName", typeof(string));                
                        lstRouteCusItems.Columns.Add("ItemCount", typeof(string));
                       

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("RouteCode") == RouteCode && row.Field<string>("ProductCode") == ProductCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("CustomerCode"))
                        .Select(group => new
                        {                           
                            CustomerCode = group.First().Field<string>("CustomerCode"),
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.CustomerCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteCusItems.Rows.Add(groupData.CustomerCode, groupData.CustomerName, groupData.ItemCount);
                        }



                        ViewState["lstRouteCusItems"] = lstRouteCusItems;
                        grvRptCustomers.DataSource = lstRouteCusItems;
                        grvRptCustomers.DataBind();
                    }
                    else if (!string.IsNullOrEmpty(RouteCode))
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("CustomerCode", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerName", typeof(string));
                        lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("RouteCode") == RouteCode);

                        var groupedData = filteredData
                        .GroupBy(row => row.Field<string>("CustomerCode"))
                        .Select(group => new
                        {
                            CustomerCode = group.Key,
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.CustomerCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.CustomerCode, groupData.CustomerName, groupData.ItemCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptCustomers.DataSource = lstForecastRoute;
                        grvRptCustomers.DataBind();
                    }
                    else if (!string.IsNullOrEmpty(ProductCode))
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("CustomerCode", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerName", typeof(string));
                        lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("ProductCode") == ProductCode);

                        var groupedData = filteredData
                        .GroupBy(row => row.Field<string>("CustomerCode"))
                        .Select(group => new
                        {
                            CustomerCode = group.Key,
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.CustomerCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.CustomerCode, groupData.CustomerName, groupData.ItemCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptCustomers.DataSource = lstForecastRoute;
                        grvRptCustomers.DataBind();
                    }
                    else
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("CustomerCode", typeof(string));
                        lstForecastRoute.Columns.Add("CustomerName", typeof(string));
                        lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                        var groupedData = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("CustomerCode"))
                        .Select(group => new
                        {
                            CustomerCode = group.Key,
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.CustomerCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.CustomerCode, groupData.CustomerName, groupData.ItemCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        grvRptCustomers.DataSource = lstForecastRoute;
                        grvRptCustomers.DataBind();
                    }

                }

                if (!string.IsNullOrEmpty(CustomerCode))
                {
                    foreach (GridDataItem item in grvRptCustomers.Items)
                    {
                        // Assuming you have a column named "ProductCode" in your RadGrid
                        string gridCustomerCode = item["CustomerCode"].Text;

                        if (CustomerCode.Equals(gridCustomerCode))
                        {
                            item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Salesforecasting.aspx", "RoutesData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }
        public void ItemsData(DataTable dataTable)
        
        {
            try
            {
                string RouteCode = "";
                string CustomerCode = "";
                string ProductCode = "";
                string Mode = "";

                if (Session["RouteCode"].ToString() == "")
                {
                    RouteCode = "";
                }
                else
                {
                    RouteCode = Session["RouteCode"].ToString();
                }

                if (Session["CustomerCode"].ToString() == "")
                {
                    CustomerCode = "";
                }
                else
                {
                    CustomerCode = Session["CustomerCode"].ToString();
                }

                if (Session["ProductCode"].ToString() == "")
                {
                    ProductCode = "";
                }
                else
                {
                    ProductCode = Session["ProductCode"].ToString();
                }

                if (Session["Mode"].ToString() == "")
                {
                    Mode = "";
                }
                else
                {
                    Mode = Session["Mode"].ToString();
                }

                if (Mode == "RR")
                {
                    DataTable lstForecastRoute = new DataTable();
                    lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                    lstForecastRoute.Columns.Add("RouteName", typeof(string));
                    lstForecastRoute.Columns.Add("CustomerCode", typeof(string));
                    lstForecastRoute.Columns.Add("CustomerName", typeof(string));
                    lstForecastRoute.Columns.Add("ProductCode", typeof(string));
                    lstForecastRoute.Columns.Add("ProductName", typeof(string));
                    lstForecastRoute.Columns.Add("BaseUOM", typeof(string));
                    lstForecastRoute.Columns.Add("Qty", typeof(decimal));

                    var groupedData = dataTable.AsEnumerable()
                    .GroupBy(row => row.Field<string>("ProductCode"))
                    .Select(group => new
                    {
                        RouteCode = group.First().Field<string>("RouteCode"),
                        RouteName = group.First().Field<string>("RouteName"),
                        CustomerCode = group.First().Field<string>("CustomerCode"),
                        CustomerName = group.First().Field<string>("CustomerName"),
                        ProductCode = group.First().Field<string>("ProductCode"),
                        ProductName = group.First().Field<string>("ProductName"),
                        BaseUOM = group.First().Field<string>("BaseUOM"),
                        Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                    })
                    .OrderByDescending(groupData => groupData.ProductCode);

                    foreach (var groupData in groupedData)
                    {
                        lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCode, groupData.CustomerName,
                            groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                    }

                    ViewState["lstForecastRoute"] = lstForecastRoute;
                    grvRptItems.DataSource = lstForecastRoute;
                    grvRptItems.DataBind();
                }
                else
                {
                    if ((!string.IsNullOrEmpty(RouteCode)) && (!string.IsNullOrEmpty(CustomerCode)))
                        
                     {
                        DataTable lstRouteCusItems = new DataTable();
                        lstRouteCusItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteCusItems.Columns.Add("RouteName", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerCode", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerName", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductName", typeof(string));
                        lstRouteCusItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteCusItems.Columns.Add("Qty", typeof(decimal));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("RouteCode") == RouteCode && row.Field<string>("CustomerCode") == CustomerCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCode = group.First().Field<string>("CustomerCode"),
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteCusItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCode, groupData.CustomerName,
                            groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                        }



                        ViewState["lstRouteCusItems"] = lstRouteCusItems;
                        grvRptItems.DataSource = lstRouteCusItems;
                        grvRptItems.DataBind();
                    }

                    else if (!string.IsNullOrEmpty(RouteCode))
                    {
                        DataTable lstRouteCusItems = new DataTable();
                        lstRouteCusItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteCusItems.Columns.Add("RouteName", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerCode", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerName", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductName", typeof(string));
                        lstRouteCusItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteCusItems.Columns.Add("Qty", typeof(decimal));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("RouteCode") == RouteCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCode = group.First().Field<string>("CustomerCode"),
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteCusItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCode, groupData.CustomerName,
                            groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                        }



                        ViewState["lstRouteCusItems"] = lstRouteCusItems;
                        grvRptItems.DataSource = lstRouteCusItems;
                        grvRptItems.DataBind();
                    }
                    else if (!string.IsNullOrEmpty(CustomerCode))
                    {
                        DataTable lstRouteCusItems = new DataTable();
                        lstRouteCusItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteCusItems.Columns.Add("RouteName", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerCode", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerName", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductName", typeof(string));
                        lstRouteCusItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteCusItems.Columns.Add("Qty", typeof(decimal));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("CustomerCode") == CustomerCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCode = group.First().Field<string>("CustomerCode"),
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteCusItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCode, groupData.CustomerName,
                            groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                        }



                        ViewState["lstRouteCusItems"] = lstRouteCusItems;
                        grvRptItems.DataSource = lstRouteCusItems;
                        grvRptItems.DataBind();
                    }
                    else
                    {
                        DataTable lstRouteCusItems = new DataTable();
                        lstRouteCusItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteCusItems.Columns.Add("RouteName", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerCode", typeof(string));
                        lstRouteCusItems.Columns.Add("CustomerName", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteCusItems.Columns.Add("ProductName", typeof(string));
                        lstRouteCusItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteCusItems.Columns.Add("Qty", typeof(decimal));

                        var groupedData = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            CustomerCode = group.First().Field<string>("CustomerCode"),
                            CustomerName = group.First().Field<string>("CustomerName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.ProductCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteCusItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.CustomerCode, groupData.CustomerName,
                            groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);

                        }



                        ViewState["lstRouteCusItems"] = lstRouteCusItems;
                        grvRptItems.DataSource = lstRouteCusItems;
                        grvRptItems.DataBind();

                    }
                }

                if (!string.IsNullOrEmpty(ProductCode))
                {
                    foreach (GridDataItem item in grvRptItems.Items)
                    {
                        // Assuming you have a column named "ProductCode" in your RadGrid
                        string gridItemCode = item["ProductCode"].Text;

                        if (ProductCode.Equals(gridItemCode))
                        {
                            item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecating.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        protected void lnkReset_Click(object sender, EventArgs e)
        {
            try
            {                
                Session["SalesForeCastDate"] = null;

                rdDate.SelectedDate = DateTime.Now;
                Session["RouteCode"] = "";
                Session["CustomerCode"] = "";
                Session["ProductCode"] = "";
                Session["lstData"] = null;
                LoadData();
              

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecating.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }

        

        protected void RouteReset_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                Session["RouteCode"] = "";                
                Session["Mode"] = "RR";
                DataTable dt = (DataTable)Session["lstData"];
                if (dt.Rows.Count > 0)
                {
                    RoutesData(dt);
                    CustomerData(dt);
                    ItemsData(dt);
                }
                else
                {
                    grvRptRoutes.DataSource = null;
                    grvRptCustomers.DataSource = null;
                    grvRptItems.DataSource = null;

                    grvRptRoutes.DataBind();
                    grvRptCustomers.DataBind();
                    grvRptItems.DataBind();

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecating.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        protected void CustomerReset_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
               
                Session["CustomerCode"] = "";               
                Session["Mode"] = "RR";
                DataTable dt = (DataTable)Session["lstData"];
                if (dt.Rows.Count > 0)
                {
                    RoutesData(dt);
                    CustomerData(dt);
                    ItemsData(dt);
                }
                else
                {
                    grvRptRoutes.DataSource = null;
                    grvRptCustomers.DataSource = null;
                    grvRptItems.DataSource = null;

                    grvRptRoutes.DataBind();
                    grvRptCustomers.DataBind();
                    grvRptItems.DataBind();

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecating.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        protected void ItemReset_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                
                Session["ProductCode"] = "";
                Session["Mode"] = "RR";
                DataTable dt = (DataTable)Session["lstData"];
                if (dt.Rows.Count > 0)
                {
                    RoutesData(dt);
                    CustomerData(dt);
                    ItemsData(dt);
                }
                else
                {
                    grvRptRoutes.DataSource = null;
                    grvRptCustomers.DataSource = null;
                    grvRptItems.DataSource = null;

                    grvRptRoutes.DataBind();
                    grvRptCustomers.DataBind();
                    grvRptItems.DataBind();

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "SalesForecating.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
    }
}