using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using ProcessExcel;
using System.Web.Routing;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class Reports : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdfromDate.MaxDate = DateTime.Now;
                rdendDate.MaxDate = DateTime.Now;
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;

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
                int j = 1;
                foreach (RadComboBoxItem itms in ddlRoute.Items)
                {
                    itms.Checked = true;
                    j++;
                }
                string route = Rot();
                TotalNoTransactionCustomer(route);
                TotalScheduled(route);
                ScheduledVisited(route);
                ScheduledProductive(route);
                ScheduledNotProductive(route);
                ScheduledNotVisited(route);
                TotalUnscheduled(route);
                UnscheduledProd(route);
                UnscheduledNonProd(route);
                NoSaleItem(route);
                ItemWiseSale(route);
            }
        }



        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string route = Rot();
            TotalNoTransactionCustomer(route);
            TotalScheduled(route);
            ScheduledVisited(route);
            ScheduledProductive(route);
            ScheduledNotProductive(route);
            ScheduledNotVisited(route);
            TotalUnscheduled(route);
            UnscheduledProd(route);
            UnscheduledNonProd(route);
            NoSaleItem(route);
            ItemWiseSale(route);
        }

        protected void lnkSchVisNoTrans_Click(object sender, EventArgs e)
        {
            string mode = "Sch_vis_NoTrans";
            string name = "Scheduled-Visited-NoTrans";
            LoadList(mode, name);
        }

        protected void lnkUnSchVisNoTrans_Click(object sender, EventArgs e)
        {
            string mode = "NoSch_vis_NoTrans";
            string name = "Unscheduled-Visited-NoTrans";
            LoadList(mode, name);
        }

        protected void lnkSchNotVis_Click(object sender, EventArgs e)
        {
            string mode = "Sch_vs_NotVisited";
            string name = "Scheduled-NotVisited";
            LoadList(mode, name);
        }

        protected void lnkNoSaleCustom_Click(object sender, EventArgs e)
        {
            string mode = "NoSaleCustomers";
            string name = "NoSaleCustomers";
            LoadList(mode, name);
        }

        protected void lnkNoSaleItem_Click(object sender, EventArgs e)
        {
            string mode = "NoSaleItems";
            string name = "NoSaleItems";
            LoadList(mode, name);
        }

        protected void lnkItemWiseSale_Click(object sender, EventArgs e)
        {
            string mode = "ItemWiseSale";
            string name = "ItemWiseSale";
            LoadList(mode, name);
        }

        protected void lnkNotVisited_Click(object sender, EventArgs e)
        {
            string mode = "NotVisitedCustomers";
            string name = "NotVisitedCustomers";
            LoadList(mode, name);
        }

        public void LoadList(string mode, string name)
        {
            string route = Rot();
            if (!route.Equals("0"))
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] arr = { fromDate.ToString(), toDate.ToString() };
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList(mode, "sp_VisitReports", route, arr);

                BuildExcel excel = new BuildExcel();
                byte[] output = excel.SpreadSheetProcess(lstDatas, name.ToString());
                Response.ContentType = ContentType;
                Response.Headers.Remove("Content-Disposition");
                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}.{1}", name.ToString(), "Xlsx"));
                Response.BinaryWrite(output);
                Response.End();
            }
        }

        public string Rot()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = ddlRoute.CheckedItems;
                    int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (var item in CollectionMarket)
                        {
                            string rotId = item.Value;
                            createNode(rotId, writer);
                            c++;
                        }
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void SchVisNoTrans(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstSchVisNoTrans = ObjclsFrms.loadList("Sch_vis_NoTransCount", "sp_VisitReports", rotId, arr);
            string schVisNoTransCount = lstSchVisNoTrans.Rows[0]["totalCount"].ToString();
            lblSchVisNoTrans.Text = schVisNoTransCount.ToString();
        }

        public void UnSchVisNoTrans(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstUnSchVisNoTrans = ObjclsFrms.loadList("NoSch_vis_NoTransCount", "sp_VisitReports", rotId, arr);
            string unSchVisNoTransCount = lstUnSchVisNoTrans.Rows[0]["totalCount"].ToString();
            lblUnSchVisNoTrans.Text = unSchVisNoTransCount.ToString();
        }

        public void SchNotVis(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstSchNotVis = ObjclsFrms.loadList("Sch_vs_NotVisitedCount", "sp_VisitReports", rotId, arr);
            string schNotVisCount = lstSchNotVis.Rows[0]["totalCount"].ToString();
            lblSchNotVis.Text = schNotVisCount.ToString();
        }

        public void NoSaleCustom(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstNoSaleCustom = ObjclsFrms.loadList("NoSaleCustomersCount", "sp_VisitReports", rotId, arr);
            string noSaleCustomCount = lstNoSaleCustom.Rows[0]["totalCount"].ToString();
            lblNoSaleCustom.Text = noSaleCustomCount.ToString();
        }

        public void NoSaleItem(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstNoSaleItem = ObjclsFrms.loadList("NoSaleItemsCount", "sp_VisitReports", rotId, arr);
            string noSaleItemCount = lstNoSaleItem.Rows[0]["totalCount"].ToString();
            lblNoSaleItem.Text = noSaleItemCount.ToString();
        }

        public void ItemWiseSale(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstItemWiseSale = ObjclsFrms.loadList("ItemWiseSaleCount", "sp_VisitReports", rotId, arr);
            string itemWiseSaleCount = lstItemWiseSale.Rows[0]["totalCount"].ToString();
            lblItemWiseSale.Text = itemWiseSaleCount.ToString();
        }

        public void NotVisited(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstNotVisited = ObjclsFrms.loadList("NotVisitedCustomersCount", "sp_VisitReports", rotId, arr);
            string notVisitedCount = lstNotVisited.Rows[0]["totalCount"].ToString();
            lblNotVisited.Text = notVisitedCount.ToString();
        }

        protected void lnkTotalScheduled_Click(object sender, EventArgs e)
        {
            string mode = "SelectTotalScheduledCustomerExcel";
            string name = "TotalScheduledCustomers";
            LoadList(mode, name);
        }

        protected void lnkTotalUnscheduledVisit_Click(object sender, EventArgs e)
        {
            string mode = "SelectTotalUnScheduledVisitExcel";
            string name = "TotalUnScheduledVisit";
            LoadList(mode, name);
        }

        protected void lnkTotalNonProdCustomer_Click(object sender, EventArgs e)
        {

            string mode = "SelectTotalNonProductiveCustomerExcel";
            string name = "TotalNonProductiveCustomers";
            LoadList(mode, name);
        }

        public void TotalScheduled(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstTotalScheduled = ObjclsFrms.loadList("SelectTotalScheduledCustomer", "sp_VisitReports", rotId, arr);
            string totalScheduled = lstTotalScheduled.Rows[0]["totalCount"].ToString();
            lblTotalScheduled.Text = totalScheduled.ToString();
        }

        public void ScheduledVisited(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstScheduledVisited = ObjclsFrms.loadList("SelectScheduledVisitedCustomer", "sp_VisitReports", rotId, arr);
            string totalScheduledVisited = lstScheduledVisited.Rows[0]["totalCount"].ToString();
            lblScheduledVisited.Text = totalScheduledVisited.ToString();
        }

        public void ScheduledProductive(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstScheduledProductive = ObjclsFrms.loadList("SelectScheduledVisitedProdCustomer", "sp_VisitReports", rotId, arr);
            string scheduledProductive = lstScheduledProductive.Rows[0]["totalCount"].ToString();
            lblScheduledProd.Text = scheduledProductive.ToString();
        }

        public void ScheduledNotProductive(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstScheduledNonProd = ObjclsFrms.loadList("SelectScheduledVisitedNonProdCustomer", "sp_VisitReports", rotId, arr);
            string scheduledNonProd = lstScheduledNonProd.Rows[0]["totalCount"].ToString();
            lblScheduledNonProd.Text = scheduledNonProd.ToString();
        }

        public void ScheduledNotVisited(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstScheduledNotVisited = ObjclsFrms.loadList("SelectScheduledNotVisitedCustomer", "sp_VisitReports", rotId, arr);
            string scheduledNotVisited = lstScheduledNotVisited.Rows[0]["totalCount"].ToString();
            lblScheduledNotVisited.Text = scheduledNotVisited.ToString();
        }

        public void TotalUnscheduled(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstTotalUnScheduled = ObjclsFrms.loadList("SelectTotalUnScheduledVisit", "sp_VisitReports", rotId, arr);
            string totalUnscheduled = lstTotalUnScheduled.Rows[0]["totalCount"].ToString();
            lblTotalUnScheduled.Text = totalUnscheduled.ToString();
        }

        public void UnscheduledProd(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstUnscheduledProd = ObjclsFrms.loadList("SelectUnScheduledVisitProd", "sp_VisitReports", rotId, arr);
            string unscheduledProd = lstUnscheduledProd.Rows[0]["totalCount"].ToString();
            lblUnscheduledProd.Text = unscheduledProd.ToString();
        }

        public void UnscheduledNonProd(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstUnscheduledNonProd = ObjclsFrms.loadList("SelectUnScheduledVisitNonProd", "sp_VisitReports", rotId, arr);
            string unscheduledNonProd = lstUnscheduledNonProd.Rows[0]["totalCount"].ToString();
            lblUnscheduledNonProd.Text = unscheduledNonProd.ToString();
        }

        public void TotalNoTransactionCustomer(string rotId)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate.ToString(), toDate.ToString() };
            DataTable lstTotalNoTransCustomers = ObjclsFrms.loadList("SelectCustomerCount", "sp_VisitReports", rotId, arr);
            DataTable lstNoTransCustomers = ObjclsFrms.loadList("SelectNoTransactionCustCount", "sp_VisitReports", rotId, arr);
            string totalNoTransCustomers = lstTotalNoTransCustomers.Rows[0]["totalCustomers"].ToString();
            string totalNoSchTransCustomers = lstTotalNoTransCustomers.Rows[0]["totalScheduleCustomer"].ToString();
            string totalNoUnSchTransCustomers = lstTotalNoTransCustomers.Rows[0]["totalUnSchCustomer"].ToString();

            string totalNonProdCustomers = lstNoTransCustomers.Rows[0]["NoTransAllCus"].ToString();
            string scheduledNonProdCust = lstNoTransCustomers.Rows[0]["NoTransSchCus"].ToString();
            string unscheduledNonProd = lstNoTransCustomers.Rows[0]["NoTransUnSchCus"].ToString();
            lblTotlaNonProdCustomers.Text = totalNonProdCustomers.ToString() + " / " + totalNoTransCustomers.ToString();
            lblScheduledNonProdCust.Text = scheduledNonProdCust.ToString() + " / " + totalNoSchTransCustomers.ToString();
            lblUnscheduledNonProdCust.Text = unscheduledNonProd.ToString() + " / " + totalNoUnSchTransCustomers.ToString();
        }

        protected void lnkScheduledVisited_Click(object sender, EventArgs e)
        {
            string mode = "SelectScheduledVisitedCustomerExcel";
            string name = "ScheduledVisitedCustomers";
            LoadList(mode, name);
        }

        protected void lnkScheduledProd_Click(object sender, EventArgs e)
        {
            string mode = "SelectScheduledVisitedProdCustomerExcel";
            string name = "ScheduledProductiveCustomers";
            LoadList(mode, name);
        }

        protected void lnkScheduledNonProd_Click(object sender, EventArgs e)
        {
            string mode = "SelectScheduledVisitedNonProdCustomerExcel";
            string name = "ScheduledNonProductiveCustomer";
            LoadList(mode, name);
        }

        protected void lnkScheduledNotVisited_Click(object sender, EventArgs e)
        {
            string mode = "SelectScheduledNotVisitedCustomerExcel";
            string name = "ScheduledNotVisitedCustomers";
            LoadList(mode, name);
        }

        protected void lnkUnscheduledProd_Click(object sender, EventArgs e)
        {
            string mode = "SelectUnScheduledVisitProdExcel";
            string name = "UnScheduledProductiveVisits";
            LoadList(mode, name);
        }

        protected void lnkUnscheduledNonProd_Click(object sender, EventArgs e)
        {
            string mode = "SelectUnScheduledVisitNonProdExcel";
            string name = "UnScheduledNonProductiveVisits";
            LoadList(mode, name);
        }

        protected void lnkNonProdCustScheduled_Click(object sender, EventArgs e)
        {
            string mode = "SelectScheduledVisitedNonProdCustomerExcel";
            string name = "NoTransCust-Scheduled";
            LoadList(mode, name);
        }

        protected void lnkNonProdCustUnscheduled_Click(object sender, EventArgs e)
        {
            string mode = "SelectUnScheduledVisitNonProdExcel";
            string name = "NoTransCust-Unscheduled";
            LoadList(mode, name);
        }
        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransactions", "sp_Masters", UICommon.GetCurrentUserID().ToString(), arr);
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
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

    }
}