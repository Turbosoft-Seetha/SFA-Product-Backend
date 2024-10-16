using EnvDTE;
using SalesForceAutomation.Admin;
using Stimulsoft.Report.Dictionary;
using System;
using System.Collections;
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
using Telerik.Windows.Documents.Fixed.Model.Editing;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ItemWiseDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                try
                {
                    ViewState["ItemGrid"] = null;
                    ViewState["CustomerGrid"] = null;

                    lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");

                    if (Session["FromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Now;
                        Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                    }

                    if (Session["ToDate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["ToDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;
                        Session["ToDate"] = rdendDate.SelectedDate.ToString();
                    }

                    rdfromDate.MaxDate = DateTime.Now;

                    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                    LoadItems();
                    ItemGrid.Rebind();

                    LoadCustomers("");
                    CustGrid.Rebind();
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }
        }

        public void LoadItems()
        {
            DataTable lstItem = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = {  ToDate.ToString() };

            lstItem = ObjclsFrms.loadList("ListItems", "sp_ItemwiseDashboard", fromDate.ToString(), arr);
            if (lstItem.Rows.Count > 0)
            {
                ItemGrid.DataSource = lstItem;
                ViewState["ItemGrid"] = lstItem;
            }
            else
            {
                ItemGrid.DataSource = new DataTable();
            }

        }

        public void LoadCustomers(string itm_ID = "")
        {
            DataTable lstItem = default(DataTable);
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), ToDate.ToString() };

            lstItem = ObjclsFrms.loadList("ListCustomers", "sp_ItemwiseDashboard", itm_ID, arr);
            if (lstItem.Rows.Count > 0)
            {
                CustGrid.DataSource = lstItem;
                ViewState["CustomerGrid"] = lstItem;
            }
            else
            {
                CustGrid.DataSource = new DataTable();
            }

        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();

            Session["ItemGrid"] = null;
            Session["CustomerGrid"] = null;

            LoadItems();
            ItemGrid.Rebind();

            LoadCustomers("");
            CustGrid.Rebind();
        }
        protected void lnkToday_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                lnkYear.Attributes.Remove("Style");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();

            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            try
            {
                lnkToday.Attributes.Remove("Style");
                lnkMonth.Attributes.Remove("Style");
                lnkYear.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                rdfromDate.SelectedDate = new DateTime(DateTime.Now.Year, 1, 1);
                rdendDate.SelectedDate = DateTime.Now;
                string fromDate, ToDate;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                Session["ToDate"] = rdendDate.SelectedDate.ToString();

                LoadItems();
                ItemGrid.Rebind();

                LoadCustomers("");
                CustGrid.Rebind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ItemGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadItems();            
        }
        protected void CustGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadCustomers("");
        }


        protected void ItemGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("ItemClick"))
            {


                int itemIndex = System.Convert.ToInt32(e.CommandArgument);
                GridDataItem item = ItemGrid.MasterTableView.Items[itemIndex] as GridDataItem;

                if (item != null)
                {
                    foreach (GridDataItem di in ItemGrid.MasterTableView.Items)
                    {
                        di.BackColor = Color.Transparent;
                    }

                    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                    string prd_ID = item.GetDataKeyValue("prd_ID").ToString();
                    Session["SelectedPrdID"] = prd_ID;
                    Session["SelectedCusID"] = null;

                    LoadCustomers(prd_ID);
                    CustGrid.Rebind();
                   
                }

            }
        }
        protected void CustGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("CustomerClick"))
            {
                foreach (GridDataItem di in CustGrid.MasterTableView.Items)
                {
                    di.BackColor = Color.Transparent;
                }

                GridDataItem item = CustGrid.MasterTableView.Items[System.Convert.ToInt32(e.CommandArgument)];

                item.BackColor = System.Drawing.ColorTranslator.FromHtml("#eaf8fb");

                string cus_ID = item.GetDataKeyValue("cus_ID").ToString();
                string cus_csh_ID = item["cus_csh_ID"].Text.ToString();
                Session["SelectedCusID"] = cus_ID;             

            }
        }


        protected void InvoiceGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void InvoiceGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }       
        protected void InvoiceReset_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void OutletReset_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void ItemReset_Click(object sender, ImageClickEventArgs e)
        {

        }

    }
}