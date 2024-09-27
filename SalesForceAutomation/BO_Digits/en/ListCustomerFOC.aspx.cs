using SalesForceAutomation.BO_Digits.ar;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListCustomerFOC : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // lnkFilter.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                Route();

                string routeCondition = "";
                string cusCondition = "";
                //rdFromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                //rdEndDate.SelectedDate = DateTime.Now;
                try
                {
                    if (Session["FOCFromDate"] != null)
                    {

                        rdFromDate.SelectedDate = DateTime.Parse(Session["FOCFromDate"].ToString());
                    }
                    else
                    {
                        rdFromDate.SelectedDate = DateTime.Now;


                    }
                    rdFromDate.MaxDate = DateTime.Now;

                    if (Session["FOCToDate"] != null)
                    {

                        rdEndDate.SelectedDate = DateTime.Parse(Session["FOCToDate"].ToString());
                    }
                    else
                    {
                        rdEndDate.SelectedDate = DateTime.Now;

                    }
                    rdEndDate.MaxDate = DateTime.Now;
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }               

                try
                {
                    if (Session["FOCrotID"] != null)
                    {
                        int a = ddlRoute.Items.Count;
                        string route = Session["FOCrotID"].ToString();
                        string[] ar = route.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in ddlRoute.Items)
                            {
                                if (items.Value == ar[i])
                                {
                                    items.Checked = true;
                                }
                            }
                        }
                        routeCondition = " rcs_rot_ID in (" + route + ")";
                        Customer(routeCondition);

                    }
                    else
                    {
                        RouteFromTransaction();
                        string rotID = Rot();
                        routeCondition = " rcs_rot_ID in (" + rotID + ")";
                        Customer(routeCondition);                       

                    }
                    
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                
                try
                {
                    if (Session["FOCcusID"] != null)
                    {
                        int a = ddlCustomer.Items.Count;
                        string cusID = Session["FOCcusID"].ToString();
                        string[] ar = cusID.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in ddlCustomer.Items)
                            {


                                if (items.Value == ar[i])
                                {
                                    items.Checked = true;
                                }
                            }
                        }
                        cusCondition = " rcs_cus_ID in (" + cusID + ")";
                    }
                    else
                    {
                        CustomerFilter();
                        string cusID = Cus();
                        cusCondition = " rcs_cus_ID in (" + cusID + ")";                        
                    }

                } 
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }               
                Product(routeCondition, cusCondition);
                ProductFilter();

                //string rotID = Rot();
                //string routeCondition = "rcs_rot_ID in (" + rotID + ")";
                //string routecond= "rcs_rot_ID in (" + rotID + ")";
                //Customer(routeCondition);

                //string cusID = Cus();
                //string cusCondition = " and rcs_cus_ID in (" + cusID + ")";

            }
        }
        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRoute", "sp_wb_merch_others");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        public void Customer(string routeCondition)
        {
            ddlCustomer.DataSource = ObjclsFrms.loadList("SelectCustomerByRout", "sp_wb_merch_others", routeCondition);
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }
        public void Product(string routeCondition, string cusCondition)
        {
            string prdCondition = routeCondition + cusCondition;
            ddlprd.DataSource = ObjclsFrms.loadList("SelectProductByCusRot", "sp_wb_merch_others", prdCondition);
            ddlprd.DataTextField = "prd_Name";
            ddlprd.DataValueField = "prd_ID";
            ddlprd.DataBind();
        }


        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in ddlRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }


        public void CustomerFilter()
        {
            int k = 1;
            foreach (RadComboBoxItem itme in ddlCustomer.Items)
            {
                itme.Checked = true;
                k++;
            }
        }
        public void ProductFilter()
        {
            int i = 1;
            foreach (RadComboBoxItem itme in ddlprd.Items)
            {
                itme.Checked = true;
                i++;
            }
        }

        public string Rot()
        {
            var ColelctionMarket = ddlRoute.CheckedItems;
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

        public string Cus()
        {
            var ColelctionMarkets = ddlCustomer.CheckedItems;
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
        public string Prd()
        {
            var ColelctionMarkets = ddlprd.CheckedItems;
            string prdID = "";
            int i = 0;
            int MarCounts = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (var item in ColelctionMarkets)
                {
                    //where 1 = 1 
                    if (i == 0)
                    {
                        prdID += item.Value + ",";
                    }
                    else if (i > 0)
                    {
                        prdID += item.Value + ",";
                    }
                    if (i == (MarCounts - 1))
                    {
                        prdID += item.Value;
                    }
                    i++;
                }
                return prdID;
            }
            else
            {
                return "0";
            }
        }

        public string mainConditions(string rotID)
        {
            string cusID = Cus();
            string productCondition = "";
            string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " crf_rot_ID in (" + rotID + ")";
            string prdID;

            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                
                dateCondition = " AND (cast(B.crf_FromDate as date) <= cast('" + fromDate + "' as date) " +
                       " AND cast(B.crf_ToDate as date) >= cast('" + endDate + "' as date))";
                if (cusID.Equals("0"))

                {
                    customerCondition = " ";
                }
                else
                {
                    customerCondition = " and crf_cus_ID in (" + cusID + ")";
                    prdID = Prd();
                    if (prdID.Equals("0"))
                    {
                        productCondition = "";
                    }
                    else
                    {
                        productCondition = " and crf_prd_ID in (" + prdID + ")";
                    }

                }




            }
            catch (Exception ex)
            {

            }

            //}
            mainCondition += dateCondition;
            mainCondition += customerCondition;
           // mainCondition += productCondition;

            return mainCondition;

        }

        public void LoadList()

        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("ListCustomerFOC", "sp_wb_merch_others", mainCondition);
                grvRpt.DataSource = lstUser;

            }
        }
        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditCustomerFOC.aspx?Id=0");
        }

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";
            Customer(routeCondition);
            string cusID = Cus();
            string customerCondition = " and rcs_cus_ID in (" + cusID + ")";
            Product(routeCondition, customerCondition);
        }

        protected void ddlCustomer_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            string routeCondition = "rcs_rot_ID in (" + rotID + ")";

            string cusID = Cus();
            string customerCondition = " and rcs_cus_ID in (" + cusID + ")";
            Product(routeCondition, customerCondition);
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["FOCFromDate"] != null)
                {
                    string fromdate = rdFromDate.SelectedDate.ToString();
                    if (fromdate == Session["FOCFromDate"].ToString())
                    {
                        rdFromDate.SelectedDate = DateTime.Parse(Session["FOCFromDate"].ToString());
                    }
                    else
                    {
                        Session["FOCFromDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdFromDate.SelectedDate = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                    Session["FOCFromDate"] = DateTime.Parse(rdFromDate.SelectedDate.ToString());
                }
                rdFromDate.MaxDate = DateTime.Now;

                if (Session["FOCToDate"] != null)
                {
                    string todate = rdEndDate.SelectedDate.ToString();
                    if (todate == Session["FOCToDate"].ToString())
                    {
                        rdEndDate.SelectedDate = DateTime.Parse(Session["FOCToDate"].ToString());
                    }
                    else
                    {
                        Session["FOCToDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdEndDate.SelectedDate = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                    Session["FOCToDate"] = DateTime.Parse(rdEndDate.SelectedDate.ToString());
                }
                rdEndDate.MaxDate = DateTime.Now.AddDays(1);
                if (Session["FOCrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["FOCrotID"].ToString())
                    {
                        string rotID = Rot();
                    }
                    else
                    {
                        string rotID = Rot();
                        Session["FOCrotID"] = rotID;
                    }
                }
                else
                {
                    string rotID = Rot();
                    Session["FOCrotID"] = rotID;
                }

                if (Session["FOCcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["FOCcusID"].ToString())
                    {
                        string cusID = Cus();
                    }
                    else
                    {
                        string cusID = Cus();
                        Session["FOCcusID"] = cusID;
                    }
                }
                else
                {
                    string cusID = Cus();
                    Session["FOCcusID"] = cusID;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadList();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
          
           

                string id = ViewState["delID"].ToString();
                GeneralFunctions.loadList_Static("DelCustomerFOC", "sp_wb_merch_others", id);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crf_ID").ToString();
                Response.Redirect("AddEditCustomerFOC.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crf_ID").ToString();
                Response.Redirect("ListcustomerFOCDetail.aspx?Id=" + ID);

            }
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crf_ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            DataTable dt = new DataTable();

            int columncount = 0;

            foreach (GridColumn column in grvRpt.MasterTableView.Columns)
            {
                if (!string.IsNullOrEmpty(column.UniqueName) && !string.IsNullOrEmpty(column.HeaderText) && !column.HeaderText.Equals("Detail")
                    && !column.HeaderText.Equals("Image")
                    )
                {

                    if (column.Display == true)
                    {
                        columncount++;
                        dt.Columns.Add(column.HeaderText.Replace("<br>", " "), typeof(string));
                    }

                }
            }

            DataRow dr;
            grvRpt.MasterTableView.AllowPaging = false;

            RadGrid dd = grvRpt;
            dd.AllowPaging = false;
            dd.Rebind();
            int x = grvRpt.MasterTableView.Items.Count;
            foreach (GridDataItem item in dd.MasterTableView.Items)
            {
                dr = dt.NewRow();
                int j = 0;
                for (int i = 1; i < grvRpt.MasterTableView.Columns.Count; i++)
                {
                    if (grvRpt.MasterTableView.Columns[i].Display == true)
                    {
                        //if (i == 0)
                        //{
                        //    i++;


                        //}
                        //else
                        //{

                        //    dr[i] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                        //}


                        if (!item[grvRpt.MasterTableView.Columns[i].UniqueName].Text.Contains("Detail"))
                        {
                            if (!grvRpt.MasterTableView.Columns[i].HeaderText.Equals("Image"))
                            {
                                dr[j] = item[grvRpt.MasterTableView.Columns[i].UniqueName].Text;
                                j++;
                            }

                        }
                    }
                }
                dt.Rows.Add(dr);
            }
            SpreadStreamProcessingForXLSXAndCSV(dt);
        }
        private void SpreadStreamProcessingForXLSXAndCSV(DataTable dt, SpreadDocumentFormat docFormat = SpreadDocumentFormat.Xlsx, string sheetName = "AR")
        {
            using (MemoryStream stream = new MemoryStream())
            {
                using (IWorkbookExporter workbook = SpreadExporter.CreateWorkbookExporter(docFormat, stream))
                {
                    using (IWorksheetExporter worksheetExporter = workbook.CreateWorksheetExporter(sheetName))
                    {
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            using (IColumnExporter columnExporter = worksheetExporter.CreateColumnExporter())
                            {
                                //make sure the width of the columns is not excessively large
                                //I reduced it to 100 in this iteration
                                columnExporter.SetWidthInPixels(100);
                            }
                        }

                        ExportHeaderRows(worksheetExporter, dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    SpreadCellFormat normalFormat = new SpreadCellFormat();
                                    normalFormat.FontSize = 10;

                                    normalFormat.VerticalAlignment = SpreadVerticalAlignment.Center;
                                    normalFormat.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                                    {

                                        cellExporter.SetValue(item.ToString());
                                        cellExporter.SetFormat(normalFormat);
                                    }
                                }

                            }
                        }

                    }
                }

                byte[] output = stream.ToArray();


                Response.ContentType = ContentType;
                Response.Headers.Remove("Content-Disposition");
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", "CustomerFOC", "Xlsx"));
                Response.BinaryWrite(output);
                Response.End();
            }
        }
        private void ExportHeaderRows(IWorksheetExporter worksheetExporter, DataTable dt)
        {
            using (IRowExporter rowExporter = worksheetExporter.CreateRowExporter())
            {
                double HeaderRowHeight = 30;
                rowExporter.SetHeightInPoints(HeaderRowHeight);

                SpreadCellFormat format = new SpreadCellFormat();
                format.IsBold = true;
                format.Fill = SpreadPatternFill.CreateSolidFill(new SpreadColor(128, 128, 128));
                format.ForeColor = new SpreadThemableColor(new SpreadColor(255, 255, 255));
                format.HorizontalAlignment = SpreadHorizontalAlignment.Center;
                format.VerticalAlignment = SpreadVerticalAlignment.Center;

                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    using (ICellExporter cellExporter = rowExporter.CreateCellExporter())
                    {
                        cellExporter.SetFormat(format);
                        cellExporter.SetValue(dt.Columns[i].ColumnName);
                    }
                }
            }
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
        protected void BtnDeleteOK_Click(object sender, EventArgs e)
        {
            //Page.Response.Redirect(Page.Request.Url.ToString(), true);
            Response.Redirect("ListCustomerFOC.aspx");
        }
    }

}