using ClosedXML.Excel;
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
using System.Configuration;


namespace SalesForceAutomation.BO_Digits.en
{
    public partial class InvVerificationHeader : System.Web.UI.Page
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
                if (Mode == 1)
                {
                    plhFilter.Visible = false;
                    rdRoute.Enabled = false;
                    rdfromDate.Enabled = false;
                    rdendDate.Enabled = false;
                    Filter.Enabled = false;
                    lnkAdvFilter.Enabled = false;
                }
                else
                {
                    plhFilter.Visible = true;
                    rdRoute.Enabled = true;
                    rdfromDate.Enabled = true;
                    rdendDate.Enabled = true;
                    Filter.Enabled = true;
                    lnkAdvFilter.Enabled = true;
                }
                   
                try
                {                   
                    if (Session["IVHFDate"] != null)
                    {

                        rdfromDate.SelectedDate = DateTime.Parse(Session["IVHFDate"].ToString());
                    }
                    else
                    {                       
                        rdfromDate.SelectedDate = DateTime.Now;

                    }
                    rdfromDate.MaxDate = DateTime.Now;

                    if (Session["IVHTDate"] != null)
                    {

                        rdendDate.SelectedDate = DateTime.Parse(Session["IVHTDate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now;

                    }
                    rdendDate.MaxDate = DateTime.Now;
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
                Route(dposubareacondition);
                try
                {
                    
                    if (Session["IVHrotID"] != null)
                    {
                        int a = rdRoute.Items.Count;
                        string route = Session["IVHrotID"].ToString();
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

                        int j = 1;
                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            itmss.Checked = true;
                            j++;
                        }


                        string rotID = Rot();
                        string routeCondition = " rcs_rot_ID in (" + rotID + ")";

                    }
                }
                catch (Exception ex)
                {

                    Response.Redirect("~/SignIn.aspx");
                }
                
                try
                {
                    GetGridSession(grvRpt, "IVH");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

            }
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["IVHFDate"] != null)
                {
                    string fromdate = rdfromDate.SelectedDate.ToString();
                    if (fromdate == Session["IVHFDate"].ToString())
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["IVHFDate"].ToString());
                    }
                    else
                    {
                        Session["IVHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                    }
                }
                else
                {
                    rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    Session["IVHFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

                }
                rdfromDate.MaxDate = DateTime.Now;

                if (Session["IVHTDate"] != null)
                {
                    string todate = rdendDate.SelectedDate.ToString();
                    if (todate == Session["IVHTDate"].ToString())
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["IVHTDate"].ToString());
                    }
                    else
                    {
                        Session["IVHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    }

                }
                else
                {
                    rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                    Session["IVHTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }
                rdendDate.MaxDate = DateTime.Now.AddDays(1);



                if (Session["IVHrotID"] != null)
                {
                    string route = Rot();
                    if (route == Session["IVHrotID"].ToString())
                    {
                        string rotID = Rot();

                    }
                    else
                    {
                        string rotID = Rot();
                        Session["IVHrotID"] = rotID;
                    }


                }
                else
                {
                    string rotID = Rot();
                    Session["IVHrotID"] = rotID;
                }


            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            LoadData();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("InvReconfirmHeader", "sp_Transaction", mainCondition);
                grvRpt.DataSource = lstDatas;
            }

        }

      

        public string Rot()
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
                return "0";
            }
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "IVH");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("irh_ID").ToString();
                Response.Redirect("InvVerificationDetail.aspx?ID=" + ID);
            }
        }
       

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            //string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            //Customers(routeCondition);
        }
        public string mainConditions(string rotID)
        {
            //string cusID = Cus();
            //string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " irh_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                //if(cusID.Equals("0"))
                //{
                //    customerCondition = "";
                //}
                //else
                //{
                //    customerCondition = " and udp_cus_ID in (" + cusID +")";
                //}
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            // mainCondition += customerCondition;
            return mainCondition;
        }
        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
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
            Route(DposubAreaCondition);
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

        protected void imgExcel_Click1(object sender, ImageClickEventArgs e)
        {
            string fileName = "InvReconfirm";
            string dataQuery = "InvReconfirmExcel";
            string reportName = "(Inventory Reconfirmation)";
            string reportSubName = "";
            GenerateExcel1(fileName, dataQuery, reportName, reportSubName);
        }
        public void GenerateExcel1(string fileName, string dataQuery, string reportName, string reportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string rotID =Rot();
                   string  mainCondition = mainConditions(rotID);

                    string fromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                    string[] ar = { };

                    DataSet dxd = ObjclsFrms.loadList(dataQuery, "sp_Transaction", mainCondition, ar, true);

                    if (dxd.Tables[0].Rows.Count > 1)
                    {
                        IXLWorksheet worksheet = wb.AddWorksheet();
                        worksheet.Name = fileName;
                        DataTable dx1 = dxd.Tables[0];
                        IXLCell Cell0;

                        int ColLength = dxd.Tables[0].Columns.Count / 2;

                        ExcelHeader(worksheet, ColLength, reportName, reportSubName);
                        int p = 0;
                        int r = 5;

                        ViewState["FirstColVal"] = null;

                        foreach (DataColumn dc in dxd.Tables[0].Columns)
                        {
                            Cell0 = worksheet.Cell(r + 1, p + 1);

                            if (dc.ColumnName.ToString().Contains("_"))
                            {
                                string[] ColVal = dc.ColumnName.Split('_');
                                string firstColVal = ColVal[0].ToString();
                                string secondColVal = ColVal[1].ToString();
                                Cell0.SetValue(firstColVal.ToString());
                                Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                if (ViewState["FirstColVal"] == null)
                                {
                                    ViewState["FirstColVal"] = firstColVal.ToString();
                                }
                                else
                                {
                                    if (ViewState["FirstColVal"].Equals(firstColVal))
                                    {
                                        var mergeCells = Cell0.Worksheet.Range(worksheet.Cell(r + 1, p), worksheet.Cell(r + 1, p + 1)).Merge();
                                        Cell0.SetValue(dc.ColumnName.ToString());
                                        mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                        Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                        Cell0.Worksheet.Range(worksheet.Cell(r + 1, p), worksheet.Cell(r + 1, p + 1)).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                    }
                                    else
                                    {
                                        ViewState["FirstColVal"] = firstColVal.ToString();
                                    }
                                }

                                Cell0 = worksheet.Cell(r + 2, p + 1);
                                Cell0.SetValue(secondColVal.ToString());
                                Cell0.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.LightGoldenrodYellow);
                            }
                            else
                            {
                                var mergeCells = Cell0.Worksheet.Range(worksheet.Cell(6, p + 1), worksheet.Cell(7, p + 1)).Merge();
                                Cell0.SetValue(dc.ColumnName.ToString());
                                mergeCells.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                                Cell0.Style.Fill.SetBackgroundColor(XLColor.Orange);
                                var col2 = worksheet.Column(p + 1);

                                if (col2.Width < Cell0.GetString().Length)
                                {
                                    col2.Width = Cell0.GetString().Length + 3;
                                }
                            }
                            p = p + 1;
                        }

                        int j = 7;
                        int k = 0;
                        string mode;

                        foreach (DataRow dr in dx1.Rows)
                        {

                            PrintRow(dr, dx1, worksheet, j, k);
                            j = j + 1;
                        }

                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= " + fileName.ToString() + "_" + DateTime.Parse(DateTime.Now.ToString()).ToString("yyyyMMdd") + ".xlsx");

                        using (MemoryStream MyMemoryStream = new MemoryStream())
                        {
                            wb.SaveAs(MyMemoryStream);
                            MyMemoryStream.WriteTo(Response.OutputStream);
                            Response.Flush();
                            Response.End();
                        }
                    }

                    else
                    {

                        //lblMessage.Text = "No daily count statistics found for selected customer in selected date period";
                    }
                }
                catch (Exception ex)
                {
                    //lblMessage.Text = "There is an issue in getting data for this customer, please contact service provider";
                }
            }
        }

        public void PrintRow(DataRow dr, DataTable dx, IXLWorksheet worksheet, int j, int k)
        {
            IXLCell Cell1;
            foreach (DataColumn data in dx.Columns)
            {
                Cell1 = worksheet.Cell(j + 1, k + 1);
                string name = dr[data.ColumnName].ToString();
                try
                {
                    if (k > 2)
                    {
                        Cell1.SetValue(decimal.Parse(dr[data.ColumnName].ToString()));
                    }
                    else
                    {
                        Cell1.SetValue(dr[data.ColumnName].ToString());
                    }
                }
                catch
                {
                    Cell1.SetValue(dr[data.ColumnName].ToString());
                }
                Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                k = k + 1;
            }
        }


        public void ExcelHeader(IXLWorksheet worksheet, int ColLength, string ReportName, string ReportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string title = ConfigurationManager.AppSettings.Get("ProjectName"); ;
                    IXLCell Cell0;

                    int beforeCol = ColLength - 2;
                    if (beforeCol < 1)
                    {
                        beforeCol = 2;
                    }
                    int afterCol = ColLength + 2;
                    Cell0 = worksheet.Cell(1, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(1, beforeCol), worksheet.Cell(1, afterCol)).Merge();
                    Cell0.SetValue(title.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();
                    Cell0.Style.Font.FontSize = 13;

                    beforeCol = ColLength - 1;
                    afterCol = ColLength + 1;
                    Cell0 = worksheet.Cell(2, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(2, beforeCol), worksheet.Cell(2, afterCol)).Merge();
                    Cell0.SetValue(ReportName.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();

                    Cell0 = worksheet.Cell(3, beforeCol);
                    Cell0.Worksheet.Range(worksheet.Cell(3, beforeCol), worksheet.Cell(3, afterCol)).Merge();
                    Cell0.SetValue(ReportSubName.ToString());
                    Cell0.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell0.Style.Font.SetBold();



                }
                catch (Exception ex)
                {

                }
            }
        }

        public void ExcelHeaders(IXLWorksheet worksheet, int ColLength, string ReportName, string ReportSubName)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                try
                {
                    string title = ConfigurationManager.AppSettings.Get("ProjectName"); ;
                    IXLCell Cell1;

                    int beforeCol = ColLength - 2;
                    if (beforeCol < 1)
                    {
                        beforeCol = 2;
                    }
                    int afterCol = ColLength + 2;
                    Cell1 = worksheet.Cell(1, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(1, beforeCol), worksheet.Cell(1, afterCol)).Merge();
                    Cell1.SetValue(title.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Font.FontSize = 13;

                    beforeCol = ColLength - 1;
                    afterCol = ColLength + 1;
                    Cell1 = worksheet.Cell(2, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(2, beforeCol), worksheet.Cell(2, afterCol)).Merge();
                    Cell1.SetValue(ReportName.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();

                    Cell1 = worksheet.Cell(3, beforeCol);
                    Cell1.Worksheet.Range(worksheet.Cell(3, beforeCol), worksheet.Cell(3, afterCol)).Merge();
                    Cell1.SetValue(ReportSubName.ToString());
                    Cell1.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    Cell1.Style.Font.SetBold();

                    Cell1 = worksheet.Cell(5, 5);
                    Cell1.SetValue("Route");
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell1 = worksheet.Cell(5, 6);
                    Cell1.SetValue(rdRoute.Text);
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col3 = worksheet.Column(6);
                    col3.Width = Cell1.GetString().Length + 3;

                    Cell1 = worksheet.Cell(5, 7);
                    Cell1.SetValue("Date");
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    Cell1 = worksheet.Cell(5, 8);
                    Cell1.SetValue(rdfromDate.SelectedDate.ToString());
                    Cell1.Style.Font.SetBold();
                    Cell1.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    var col4 = worksheet.Column(8);
                    col4.Width = Cell1.GetString().Length + 3;

                }
                catch (Exception ex)
                {

                }
            }
        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
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
    }
}