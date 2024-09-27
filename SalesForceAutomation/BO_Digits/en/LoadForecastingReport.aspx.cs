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
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class LoadForecastingReport : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                try
                {
                    Session["RouteCode"] = "";
                    Session["ItemCode"] = "";
                    Session["Mode"] = "";

                    if (Session["LoadForeCastDate"] != null)
                    {
                        rdDate.SelectedDate = DateTime.Parse(Session["LoadForeCastDate"].ToString());
                    }
                    else
                    {
                        rdDate.SelectedDate = DateTime.Now;
                    }

                    LoadData();
                    lblReloadTime.Text = Session["ReloadTime"].ToString();
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
        }
        public void LoadData()
        {
            try
            {

                if (Session["lstData"] == null)
                {
                    string fromDate = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    DataTable lstData = ObjclsFrms.loadList("SelLoadForecastingReport", "sp_ForecastingReport", fromDate);
                    Session["lstData"] = lstData;
                    DateTime endDateTime = DateTime.Now;
                    Session["ReloadTime"] = endDateTime.ToString("dd-MMM-yyyy h:mm tt");
                    if (lstData.Rows.Count > 0)
                    {
                        RouteCount(lstData);
                        ItemCount(lstData);

                        RoutesData(lstData);
                        ItemsData(lstData);
                        
                    }
                    else
                    {
                        lblRouteCount.Text = "0";
                        lblProductCode.Text = "0";
                      
                        RadGrid1.DataSource = null;
                        RadGrid2.DataSource = null;
                      
                        RadGrid1.DataBind();
                        RadGrid2.DataBind();
                     
                    }
                }
                else
                {
                    DataTable dt = (DataTable)Session["lstData"];
                    if (dt.Rows.Count > 0)
                    {
                        RouteCount(dt);
                        ItemCount(dt);

                        RoutesData(dt);
                        ItemsData(dt);
                    }
                    else
                    {
                        lblRouteCount.Text = "0";
                        lblProductCode.Text = "0";

                        RadGrid1.DataSource = null;
                        RadGrid2.DataSource = null;

                        RadGrid1.DataBind();
                        RadGrid2.DataBind();

                    }


                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "NewDashboard.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }


        }
        public void LoadDataFilter()
        {
            try
            {
                string fromDate = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                DataTable lstData = ObjclsFrms.loadList("SelLoadForecastingReport", "sp_ForecastingReport", fromDate);
                Session["lstData"] = null;
                Session["lstData"] = lstData;
                DateTime endDateTime = DateTime.Now;
                Session["ReloadTime"] = endDateTime.ToString("dd-MMM-yyyy h:mm tt");
                lblReloadTime.Text = Session["ReloadTime"].ToString();

                if (lstData.Rows.Count > 0)
                {
                    RouteCount(lstData);
                    ItemCount(lstData);

                    RoutesData(lstData);
                    ItemsData(lstData);

                }
                else
                {
                    lblRouteCount.Text = "0";
                    lblProductCode.Text = "0";

                    RadGrid1.DataSource = null;
                    RadGrid2.DataSource = null;

                    RadGrid1.DataBind();
                    RadGrid2.DataBind();
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "LoadDataFilter() Error : " + ex.Message.ToString() + " - " + innerMessage);

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
            catch(Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "RouteCount() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        public void ItemCount(DataTable dataTable)
        {
            try
            {
               var distinctItemCodeCount = dataTable.AsEnumerable()
               .GroupBy(row => row.Field<string>("ProductCode"))
               .Count();

                lblProductCode.Text = distinctItemCodeCount.ToString();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "ItemCount() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }


        //Grids 
        public void RoutesData(DataTable dataTable)
        {
            try
            {
                string RouteCode = "";
                string ItemCode = "";
                string Mode = "";

                if (Session["ItemCode"].ToString() == "")
                {
                    ItemCode = "";
                }
                else
                {
                    ItemCode = Session["ItemCode"].ToString();
                }


                if (Session["RouteCode"].ToString() == "")
                {
                    RouteCode = "";
                }
                else
                {
                    RouteCode = Session["RouteCode"].ToString();
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
                    lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                    var groupedData = dataTable.AsEnumerable()
                    .GroupBy(row => row.Field<string>("RouteCode"))
                    .Select(group => new
                    {
                        RouteCode = group.Key,
                        RouteName = group.First().Field<string>("RouteName"),
                        ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                    })
                    .OrderByDescending(groupData => groupData.RouteCode);

                    foreach (var groupData in groupedData)
                    {
                        lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ItemCount);
                    }

                    ViewState["lstForecastRoute"] = lstForecastRoute;
                    RadGrid1.DataSource = lstForecastRoute;
                    RadGrid1.DataBind();
                }
                else
                {
                    if (!string.IsNullOrEmpty(ItemCode))
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("ProductCode") == ItemCode);

                        var groupedData = filteredData
                        .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.Key,
                            RouteName = group.First().Field<string>("RouteName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ItemCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        RadGrid1.DataSource = lstForecastRoute;
                        RadGrid1.DataBind();
                    }
                    else
                    {
                        DataTable lstForecastRoute = new DataTable();
                        lstForecastRoute.Columns.Add("RouteCode", typeof(string));
                        lstForecastRoute.Columns.Add("RouteName", typeof(string));
                        lstForecastRoute.Columns.Add("ItemCount", typeof(int));

                        var groupedData = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("RouteCode"))
                        .Select(group => new
                        {
                            RouteCode = group.Key,
                            RouteName = group.First().Field<string>("RouteName"),
                            ItemCount = group.Select(row => row.Field<string>("ProductCode")).Distinct().Count()

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstForecastRoute.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ItemCount);
                        }

                        ViewState["lstForecastRoute"] = lstForecastRoute;
                        RadGrid1.DataSource = lstForecastRoute;
                        RadGrid1.DataBind();
                    }

                }

                if (!string.IsNullOrEmpty(RouteCode))
                {
                    foreach (GridDataItem item in RadGrid1.Items)
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
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "RoutesData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        public void ItemsData(DataTable dataTable)
        {
            try
            {
                string RouteCode = "";
                string ItemCode = "";

                if (Session["RouteCode"].ToString() == "")
                {
                    RouteCode = "";
                }
                else
                {
                    RouteCode = Session["RouteCode"].ToString();
                }

                if (Session["ItemCode"].ToString() == "")
                {
                    ItemCode = "";
                }
                else
                {
                    ItemCode = Session["ItemCode"].ToString();
                }


                if (!string.IsNullOrEmpty(ItemCode))
                {
                    DataTable lstRouteWiseItems = new DataTable();
                    lstRouteWiseItems.Columns.Add("RouteCode", typeof(string));
                    lstRouteWiseItems.Columns.Add("RouteName", typeof(string));
                    lstRouteWiseItems.Columns.Add("ProductCode", typeof(string));
                    lstRouteWiseItems.Columns.Add("ProductName", typeof(string));
                    lstRouteWiseItems.Columns.Add("BaseUOM", typeof(string));
                    lstRouteWiseItems.Columns.Add("Qty", typeof(decimal));

                    var filteredData = dataTable.AsEnumerable()
                       .Where(row => row.Field<string>("ProductCode") == ItemCode);

                    var groupedData = filteredData
                   .GroupBy(row => row.Field<string>("RouteCode"))
                    .Select(group => new
                    {
                        RouteCode = group.First().Field<string>("RouteCode"),
                        RouteName = group.First().Field<string>("RouteName"),
                        ProductCode = group.First().Field<string>("ProductCode"),
                        ProductName = group.First().Field<string>("ProductName"),
                        BaseUOM = group.First().Field<string>("BaseUOM"),
                        Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                    })
                    .OrderByDescending(groupData => groupData.RouteCode);

                    foreach (var groupData in groupedData)
                    {
                        lstRouteWiseItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                    }



                    ViewState["lstRouteWiseItems"] = lstRouteWiseItems;
                    RadGrid2.DataSource = lstRouteWiseItems;
                    RadGrid2.DataBind();
                }
                else
                {
                    if (!string.IsNullOrEmpty(RouteCode))
                    {
                        DataTable lstRouteWiseItems = new DataTable();
                        lstRouteWiseItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteWiseItems.Columns.Add("RouteName", typeof(string));
                        lstRouteWiseItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteWiseItems.Columns.Add("ProductName", typeof(string));
                        lstRouteWiseItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteWiseItems.Columns.Add("Qty", typeof(decimal));

                        var filteredData = dataTable.AsEnumerable()
                           .Where(row => row.Field<string>("RouteCode") == RouteCode);

                        var groupedData = filteredData
                       .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteWiseItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                        }



                        ViewState["lstRouteWiseItems"] = lstRouteWiseItems;
                        RadGrid2.DataSource = lstRouteWiseItems;
                        RadGrid2.DataBind();
                    }
                    else
                    {
                        DataTable lstRouteWiseItems = new DataTable();
                        lstRouteWiseItems.Columns.Add("RouteCode", typeof(string));
                        lstRouteWiseItems.Columns.Add("RouteName", typeof(string));
                        lstRouteWiseItems.Columns.Add("ProductCode", typeof(string));
                        lstRouteWiseItems.Columns.Add("ProductName", typeof(string));
                        lstRouteWiseItems.Columns.Add("BaseUOM", typeof(string));
                        lstRouteWiseItems.Columns.Add("Qty", typeof(decimal));

                        var groupedData = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("ProductCode"))
                        .Select(group => new
                        {
                            RouteCode = group.First().Field<string>("RouteCode"),
                            RouteName = group.First().Field<string>("RouteName"),
                            ProductCode = group.First().Field<string>("ProductCode"),
                            ProductName = group.First().Field<string>("ProductName"),
                            BaseUOM = group.First().Field<string>("BaseUOM"),
                            Qty = string.Format("{0:N2}", group.Sum(row => row.Field<decimal>("Qty")))

                        })
                        .OrderByDescending(groupData => groupData.RouteCode);

                        foreach (var groupData in groupedData)
                        {
                            lstRouteWiseItems.Rows.Add(groupData.RouteCode, groupData.RouteName, groupData.ProductCode, groupData.ProductName, groupData.BaseUOM, groupData.Qty);
                        }



                        ViewState["lstRouteWiseItems"] = lstRouteWiseItems;
                        RadGrid2.DataSource = lstRouteWiseItems;
                        RadGrid2.DataBind();

                    }
                }

                if (!string.IsNullOrEmpty(ItemCode))
                {
                    foreach (GridDataItem item in RadGrid2.Items)
                    {
                        // Assuming you have a column named "ProductCode" in your RadGrid
                        string gridItemCode = item["ProductCode"].Text;

                        if (ItemCode.Equals(gridItemCode))
                        {
                            item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "ItemsData() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            
        }
        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            try
            {
                LoadDataFilter();

                if (Session["LoadForeCastDate"] != null)
                {
                    string fromdate = rdDate.SelectedDate.ToString();
                    if (fromdate == Session["LoadForeCastDate"].ToString())
                    {
                        rdDate.SelectedDate = DateTime.Parse(Session["LoadForeCastDate"].ToString());
                    }
                    else
                    {
                        Session["LoadForeCastDate"] = DateTime.Parse(rdDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdDate.SelectedDate = DateTime.Parse(rdDate.SelectedDate.ToString());
                    Session["LoadForeCastDate"] = DateTime.Parse(rdDate.SelectedDate.ToString());

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "Filter_Click() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }
       

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick1"))
            {
                try
                {
                    foreach (GridDataItem di in RadGrid1.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = RadGrid1.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                    string RouteCode = item["RouteCode"].Text.ToString();

                    Session["RouteCode"] = RouteCode.ToString();
                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    Session["Mode"] = "";
                    DataTable dt = (DataTable)Session["lstData"];                  
                    ItemsData(dt);
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "NewDashboard.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
        }

        protected void RadGrid2_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("MyClick2"))
            {
                try
                {
                    foreach (GridDataItem di in RadGrid2.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    GridDataItem item = RadGrid2.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];
                    string ItemCode = item["ProductCode"].Text.ToString();

                    Session["ItemCode"] = ItemCode.ToString();
                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    Session["Mode"] = "";
                    DataTable dt = (DataTable)Session["lstData"];
                   
                    RoutesData(dt);
                    ItemsData(dt);
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "NewDashboard.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
        }

        protected void lnkRouteReset_Click1(object sender, ImageClickEventArgs e)
        {
            try
            {
                Session["RouteCode"] = "";
                Session["ItemCode"] = "";
                Session["Mode"] = "RR";
                DataTable dt = (DataTable)Session["lstData"];
                if (dt.Rows.Count > 0)
                {
                    RoutesData(dt);
                    ItemsData(dt);
                }
                else
                {
                    RadGrid1.DataSource = null;
                    RadGrid2.DataSource = null;

                    RadGrid1.DataBind();
                    RadGrid2.DataBind();

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "Filter_Click() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        protected void lnkItemReset_Click1(object sender, ImageClickEventArgs e)
        {
            try
            {
                Session["ItemCode"] = "";
                DataTable dt = (DataTable)Session["lstData"];
                if (dt.Rows.Count > 0)
                {
                    RoutesData(dt);
                    ItemsData(dt);
                }
                else
                {
                    RadGrid1.DataSource = null;
                    RadGrid2.DataSource = null;

                    RadGrid1.DataBind();
                    RadGrid2.DataBind();
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "LoadForecatingReport.aspx", "lnkItemReset_Click() Error : " + ex.Message.ToString() + " - " + innerMessage);

            }

        }
    }
}