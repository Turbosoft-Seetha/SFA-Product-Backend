using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MerchandisingDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                RegionMaster();
                int s = 1;
                foreach (RadComboBoxItem itmss in ddlRegion.Items)
                {
                    itmss.Checked = true;
                    s++;
                }
                string region = Region();
                Session["Region"] = region;
                string regionCondition = " dep_reg_ID in (" + region + ")";



                Depot(regionCondition);
                int p = 1;
                foreach (RadComboBoxItem itmss in ddldepot.Items)
                {
                    itmss.Checked = true;
                    p++;
                }
                string depo = DPO();
                Session["Depo"] = depo;
                string dpocondition = " dpa_dep_ID in (" + depo + ")";
                DpoArea(dpocondition);
                int q = 1;
                foreach (RadComboBoxItem itmss in ddldpoArea.Items)
                {
                    itmss.Checked = true;
                    q++;
                }
                string depoarea = DPOarea();
                Session["DepoArea"] = depoarea;
                string dpoareacondition = " dsa_dpa_ID in (" + depoarea + ")";
                DpoSubArea(dpoareacondition);
                int R = 1;
                foreach (RadComboBoxItem itmss in ddldpoSubArea.Items)
                {
                    itmss.Checked = true;
                    R++;
                }
                string deposubarea = DPOsubarea();
                Session["DepoSubArea"] = deposubarea;
                string dposubareacondition = " rot_dsa_ID in (" + deposubarea + ")";
                Route(dposubareacondition);

                string rotID;

                RouteFromTransaction();
                rotID = Rot();
                lnkToday.Attributes.Add("Style", "background-color:#dae9f8; color:#60acf9");
                DatePick();
                pnlTimeline.Visible = true;
                RouteSummary(rotID);
                OutOfStock(rotID);
                ItemAvailability(rotID);
                Survey(rotID);
                AssetTracking(rotID);
                DispAgreements(rotID);
                Task(rotID);
                General(rotID);
                //TotalCustomerVisit(rotID);
                CustomerActivities(rotID);
                Requests(rotID);
                LoadVisits(rotID);
            }
        }
        public void Route(string DposubAreaCondition)
        {
            string[] arr = { DposubAreaCondition };
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForDropDowns", "sp_Merch_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void RegionMaster()
        {

            ddlRegion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlRegion.DataTextField = "reg_Name";
            ddlRegion.DataValueField = "reg_ID";
            ddlRegion.DataBind();
        }
        public void Depot(string regionCondition)
        {
            string[] arr = { regionCondition };
            ddldepot.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Merch_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            ddldepot.DataTextField = "dep_Name";
            ddldepot.DataValueField = "dep_ID";
            ddldepot.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
            string u = UICommon.GetCurrentUserID().ToString();
            string[] arr = { DpoCondition };
            ddldpoArea.DataSource = ObjclsFrms.loadList("SelectDepotAreaTransaction", "sp_Merch_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            ddldpoArea.DataTextField = "dpa_Name";
            ddldpoArea.DataValueField = "dpa_ID";
            ddldpoArea.DataBind();
        }
        public void DpoSubArea(string DpoAreaCondition)
        {
            string[] arr = { DpoAreaCondition };
            ddldpoSubArea.DataSource = ObjclsFrms.loadList("SelectDepotSubAreaTransaction", "sp_Merch_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
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
        public string Region()
        {
            var CollectionMarket4 = ddlRegion.CheckedItems;
            string regionID = "";
            int j = 0;
            int MarCount = CollectionMarket4.Count;
            if (CollectionMarket4.Count > 0)
            {
                foreach (var item in CollectionMarket4)
                {
                    if (j == 0)
                    {
                        regionID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        regionID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        regionID += item.Value;
                    }
                    j++;
                }
                return regionID;
            }
            else
            {
                return "0";
            }
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
        public string Rotids()
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

        public void RouteSummary(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            if (fromDate.Equals(toDate))
            {
                pnlTimeline.Visible = true;
                string[] arr = { fromDate, toDate };
                DataTable lstActive = ObjclsFrms.loadList("SelectActiveRouteStatus", "sp_Merch_Dashboard", route, arr);
                int active = Int32.Parse(lstActive.Rows[0]["active"].ToString());
                lblActiveRoute.Text = active.ToString();
                DataTable lstProductive = ObjclsFrms.loadList("SelectProductiveRouteStatus", "sp_Merch_Dashboard", route, arr);
                int productive = Int32.Parse(lstProductive.Rows[0]["productive"].ToString());
                lblProductiveRoute.Text = productive.ToString();
                int nonprod = active - productive;
                lblNonProductiveRoute.Text = nonprod.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }

        public void DatePick()
        {
            string fromDate, ToDate;
            rdfromDate.SelectedDate = DateTime.Now;
            rdfromDate.MaxDate = DateTime.Now;
            rdendDate.SelectedDate = DateTime.Now;
            rdendDate.MaxDate = DateTime.Now;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
        }

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void lnkToday_Click(object sender, EventArgs e)
        {

            string rotID, region, depo, depoArea, depoSubArea;

            // RouteFromTransaction();
            rotID = Rot();
            Route(rotID);
            region = Region();
            depo = DPO();
            depoArea = DPOarea();
            depoSubArea = DPOsubarea();
            Session["Region"] = region;
            Session["Depo"] = depo;
            Session["DepoArea"] = depoArea;
            Session["DepoSubArea"] = depoSubArea;

            ViewState["Chart"] = null;
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
            pnlTimeline.Visible = true;
            RouteSummary(rotID);
            LoadVisits(rotID);
            OutOfStock(rotID);
            ItemAvailability(rotID);
            Survey(rotID);
            AssetTracking(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
           // TotalCustomerVisit(rotID);
            CustomerActivities(rotID);
            Requests(rotID);
        }

        protected void lnkMonth_Click(object sender, EventArgs e)
        {
            string rotID, region, depo, depoArea, depoSubArea;

            // RouteFromTransaction();
            rotID = Rot();
            Route(rotID);
            region = Region();
            depo = DPO();
            depoArea = DPOarea();
            depoSubArea = DPOsubarea();
            Session["Region"] = region;
            Session["Depo"] = depo;
            Session["DepoArea"] = depoArea;
            Session["DepoSubArea"] = depoSubArea;
            ViewState["Chart"] = null;
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
            pnlTimeline.Visible = false;
            RouteSummary(rotID);
            LoadVisits(rotID);
            OutOfStock(rotID);
            ItemAvailability(rotID);
            Survey(rotID);
            AssetTracking(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            //TotalCustomerVisit(rotID);
            CustomerActivities(rotID);
            Requests(rotID);
        }

        protected void lnkYear_Click(object sender, EventArgs e)
        {
            string rotID, region, depo, depoArea, depoSubArea;

            // RouteFromTransaction();
            rotID = Rot();
            Route(rotID);
            region = Region();
            depo = DPO();
            depoArea = DPOarea();
            depoSubArea = DPOsubarea();
            Session["Region"] = region;
            Session["Depo"] = depo;
            Session["DepoArea"] = depoArea;
            Session["DepoSubArea"] = depoSubArea;
            ViewState["Chart"] = null;
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
            pnlTimeline.Visible = false;
            RouteSummary(rotID);
            LoadVisits(rotID);
            OutOfStock(rotID);
            ItemAvailability(rotID);
            Survey(rotID);
            AssetTracking(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            //TotalCustomerVisit(rotID);
            CustomerActivities(rotID);
            Requests(rotID);
        }

        protected void ddlRegion_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string RegionID = Region();
            string RegionCondition = " reg_ID in (" + RegionID + ")";
            Depot(RegionCondition);
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void ddldepot_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void ddldpoArea_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void ddldpoSubArea_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            Route(DposubAreaCondition);
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            rdendDate.MinDate = (DateTime)rdfromDate.SelectedDate;
            rdendDate.MaxDate = DateTime.Now;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string rotID, region, depo, depoArea, depoSubArea;
            //Route();
            //RouteFromTransaction();
            rotID = Rot();
            region = Region();
            depo = DPO();
            depoArea = DPOarea();
            depoSubArea = DPOsubarea();
            Session["Region"] = region;
            Session["Depo"] = depo;
            Session["DepoArea"] = depoArea;
            Session["DepoSubArea"] = depoSubArea;
            ViewState["Chart"] = null;
            lnkToday.Attributes.Remove("Style");
            lnkMonth.Attributes.Remove("Style");
            lnkYear.Attributes.Remove("Style");
            string fromDate, ToDate;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            if (fromDate.Equals(ToDate))
            {
                pnlTimeline.Visible = true;
            }
            else
            {
                pnlTimeline.Visible = false;
            }
            RouteSummary(rotID);
            LoadVisits(rotID);
            OutOfStock(rotID);
            ItemAvailability(rotID);
            Survey(rotID);
            AssetTracking(rotID);
            DispAgreements(rotID);
            Task(rotID);
            General(rotID);
            //TotalCustomerVisit(rotID);
            CustomerActivities(rotID);
            Requests(rotID);
        }

        protected void btnAdvancedFilter_Click(object sender, EventArgs e)
        {
            if (advancedFilter.Visible == true)
            {
                advancedFilter.Visible = false;
            }
            else
            {
                advancedFilter.Visible = true;
            }

        }

        protected void lnkProductive_Click(object sender, EventArgs e)
        {

            Session["FrmDat"] = rdfromDate.SelectedDate.ToString();
            Session["ToDat"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("RouteTypes.aspx");
        }

        protected void lnkMap_Click(object sender, EventArgs e)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string url = ConfigurationManager.AppSettings.Get("TrackingUrl");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "openlink", "window.open('" + url + "&&date=" + fromDate + "');", true);
        }

        protected void buttonOutofStock_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("OutOfStock.aspx?mode=1");
        }

        protected void lnkOosItems_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerOutStockHeader.aspx?mode=1");
        }

        protected void lnkOosCustomers_Click(object sender, EventArgs e)
        {

            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerOutStockHeader.aspx?mode=0");
        }

        protected void ButtonItemAvailability_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ItemAvailability.aspx?mode=1");
        }

        protected void lnkNotAvailableItem_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ItemNotAvailable.aspx");
        }

        protected void lnkNotAvailableCustomers_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerNotAvailable.aspx");
        }

        protected void lnkDeliveryCheck_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("DeliveryCheck.aspx?mode=1");
        }

        protected void lnkItemPricing_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerRetailPrice.aspx?mode=1");
        }

        protected void lnkCompetitorActivities_Click(object sender, EventArgs e)
        {

            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCompetitorActivities.aspx?mode=1");
        }

        protected void lnkCustomerInventory_Click(object sender, EventArgs e)
        {

            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("InventoryHeader.aspx?mode=1");
        }

        protected void lnkComplaints_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListProductComplaints.aspx?mode=1");

        }

        protected void ButtonGComplaints_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListGeneralComplaints.aspx?mode=1");
        }

        protected void lnkImageCapture_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ImageCapture.aspx?mode=1");
        }

        protected void ButtonSurvey_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyHeader.aspx?mode=1");
        }

        protected void lnkAssignedSurveys_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListAssignedSurvey.aspx?mode=1");
        }

        protected void lnkCompletedSurveys_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListSurveyHeader.aspx?mode=1");
        }

        protected void ButtonAssetTracking_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerAssetTracking.aspx?mode=1");
        }

        protected void lnkAssignedAssets_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListAssetMaster.aspx?mode=1");
        }

        protected void lnkTrackedAssets_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerAssetTracking.aspx?mode=1");
        }

        protected void ButtonDisplayAgreement_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=1");
        }

        protected void lnkNewAgreements_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=1&&type=NA");
        }

        protected void lnkActiveAgreements_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListDisplayAgreements.aspx?mode=1&&type=AA");
        }

        protected void ButtonTasks_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTask.aspx?mode=1");
        }

        protected void lnkAssignedTask_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTask.aspx?mode=1&&type=AT");
        }

        protected void lnkCompletedTasks_Click(object sender, EventArgs e)
        {
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("CustomerTask.aspx?mode=1&&type=CT");
        }

        protected void ButtonCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=1&&type=PR");
        }

        protected void lnkOpenCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=1&&type=OP");
        }

        protected void lnkCompletedCusAct_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListCustomerActivity.aspx?Mode=1&&type=CC");
        }

        protected void ButtonRequest_Click(object sender, EventArgs e)
        {

            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListNewRequest.aspx?Mode=1&&type=PR");
        }

        protected void lnkNewRequest_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListNewRequest.aspx?Mode=1&&type=NR");
        }

        protected void lnkRepondedRequest_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            Session["ToDate"] = rdendDate.SelectedDate.ToString();
            string rot = Rotids();
            Session["Route"] = rot;
            Response.Redirect("ListNewRequest.aspx?Mode=1&&type=RR");
        }
        public void OutOfStock(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstOutOfStockItem = ObjclsFrms.loadList("OOSItemCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstOutOfStockCustomer = ObjclsFrms.loadList("OOSCustomerCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstOutOfStockPerformed = ObjclsFrms.loadList("OOSPerformed", "sp_Merch_Dashboard", route, arr);
            lblTotalOosItems.Text = lstOutOfStockItem.Rows[0]["number"].ToString();
            lblOosCustomers.Text = lstOutOfStockCustomer.Rows[0]["number"].ToString();
            lblTotalOutOfStock.Text = lstOutOfStockPerformed.Rows[0]["number"].ToString();
        }

        public void ItemAvailability(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNotAvailableItem = ObjclsFrms.loadList("ItemAvailabilityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstNotAvailableCustomer = ObjclsFrms.loadList("CustomerAvailabilityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstNotAvailablePerformed = ObjclsFrms.loadList("ItemAvailbilityPerformed", "sp_Merch_Dashboard", route, arr);
            lblNotAvailableItems.Text = lstNotAvailableItem.Rows[0]["number"].ToString();
            lblNotAvailableCustomers.Text = lstNotAvailableCustomer.Rows[0]["number"].ToString();
            lblTotalItemAvailability.Text = lstNotAvailablePerformed.Rows[0]["number"].ToString();
        }

        public void Survey(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedSurvey = ObjclsFrms.loadList("AssignedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedSurvey = ObjclsFrms.loadList("CompletedSurveysCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstSurveyPerformed = ObjclsFrms.loadList("SurveyPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedSurveys.Text = lstAssignedSurvey.Rows[0]["number"].ToString();
            lblCompletedSurveys.Text = lstCompletedSurvey.Rows[0]["number"].ToString();
            lblTotalSurvey.Text = lstSurveyPerformed.Rows[0]["number"].ToString();
        }

        public void AssetTracking(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedAsset = ObjclsFrms.loadList("AssignedAssetTrackingCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstTrackedAsset = ObjclsFrms.loadList("TrackedAssetTrackingCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstAssetTrackingPerformed = ObjclsFrms.loadList("AssetTrackingPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedAssets.Text = lstAssignedAsset.Rows[0]["number"].ToString();
            lblTrackedAssets.Text = lstTrackedAsset.Rows[0]["number"].ToString();
            lblTotalAssetTracking.Text = lstAssetTrackingPerformed.Rows[0]["number"].ToString();
        }

        public void DispAgreements(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNewAgreements = ObjclsFrms.loadList("NewDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstActiveAgreements = ObjclsFrms.loadList("ActiveDisplayAgreementsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstAgreementsPerformed = ObjclsFrms.loadList("DisplayAgreementsPerformed", "sp_Merch_Dashboard", route, arr);
            lblNewAgreements.Text = lstNewAgreements.Rows[0]["number"].ToString();
            lblActiveAgreements.Text = lstActiveAgreements.Rows[0]["number"].ToString();
            lblTotalDispAgreement.Text = lstAgreementsPerformed.Rows[0]["number"].ToString();
        }

        public void Task(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstAssignedTask = ObjclsFrms.loadList("AssignedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedTask = ObjclsFrms.loadList("CompletedTaskCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstTaskPerformed = ObjclsFrms.loadList("CustomerTaskPerformed", "sp_Merch_Dashboard", route, arr);
            lblAssignedTask.Text = lstAssignedTask.Rows[0]["number"].ToString();
            lblCompletedTasks.Text = lstCompletedTask.Rows[0]["number"].ToString();
            lblTotalTasks.Text = lstTaskPerformed.Rows[0]["number"].ToString();
        }
        public void CustomerActivities(string route)
        {

            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstOpenCusAct = ObjclsFrms.loadList("OpenCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompletedCusAct = ObjclsFrms.loadList("CompletedCustomerActivityCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCusActPerformed = ObjclsFrms.loadList("CustomerActivityPerformed", "sp_Merch_Dashboard", route, arr);
            lblOpenCusAct.Text = lstOpenCusAct.Rows[0]["number"].ToString();
            lblCompletedCusAct.Text = lstCompletedCusAct.Rows[0]["number"].ToString();
            lblCusActPerformed.Text = lstCusActPerformed.Rows[0]["number"].ToString();
        }
        public void Requests(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            DataTable lstNewRequest = ObjclsFrms.loadList("NewRequestCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstRepondedRequest = ObjclsFrms.loadList("RepondedRequestCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstReqPerformed = ObjclsFrms.loadList("ReqPerformed", "sp_Merch_Dashboard", route, arr);
            lblNewRequest.Text = lstNewRequest.Rows[0]["number"].ToString();
            lblRepondedRequest.Text = lstRepondedRequest.Rows[0]["number"].ToString();
            lblReqPerformed.Text = lstReqPerformed.Rows[0]["number"].ToString();
        }
        public void General(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { fromDate, toDate };
            //DataTable lstDeliveryCheck = ObjclsFrms.loadList("DeliveryCheckCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstItemPricing = ObjclsFrms.loadList("ItemPricingCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCompetitorActivities = ObjclsFrms.loadList("CompetitorActivitiesCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstCustomerInventory = ObjclsFrms.loadList("InventoryCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstComplaints = ObjclsFrms.loadList("ComplaintsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstGComplaints = ObjclsFrms.loadList("GComplaintsCount", "sp_Merch_Dashboard", route, arr);
            DataTable lstImageCapture = ObjclsFrms.loadList("ImageCaptureCount", "sp_Merch_Dashboard", route, arr);
            //lblDeliveryCheck.Text = lstDeliveryCheck.Rows[0]["number"].ToString();
            lblItemPricing.Text = lstItemPricing.Rows[0]["number"].ToString();
            lblCompetitorActivities.Text = lstCompetitorActivities.Rows[0]["number"].ToString();
            lblCustomerInventory.Text = lstCustomerInventory.Rows[0]["number"].ToString();
            lblComplaints.Text = lstComplaints.Rows[0]["number"].ToString();
            lblGComplaints.Text = lstGComplaints.Rows[0]["number"].ToString();
            lblImageCapture.Text = lstImageCapture.Rows[0]["number"].ToString();
        }

        //public void TotalCustomerVisit(string route)
        //{
        //    string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
        //    string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
        //    string[] arr = { fromDate, toDate };
        //    DataTable lstCustomerVisit = ObjclsFrms.loadList("SelectTotalCustomerVisited", "sp_Merch_Dashboard", route, arr);
        //    lblVisitedCustomers.Text = lstCustomerVisit.Rows[0]["number"].ToString();
        //}
        public void LoadVisits(string route)
        {
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

            if (fromDate.Equals(toDate))
            {
                pnlTimeline.Visible = true;
                DataTable dtPlannedVisit = new DataTable();
                DataTable dtActualVisit = new DataTable();
                DataTable dtProductiveVisit = new DataTable();
                DataTable dtNonProductiveVisit = new DataTable();
                string[] arr = { fromDate };
                dtPlannedVisit = ObjclsFrms.loadList("SelPlannedVisits", "sp_Merch_Dashboard", route, arr);
                dtActualVisit = ObjclsFrms.loadList("SelActualVisitSplit", "sp_Merch_Dashboard", route, arr);
                dtProductiveVisit = ObjclsFrms.loadList("SelProductiveVisitSplit", "sp_Merch_Dashboard", route, arr);
                dtNonProductiveVisit = ObjclsFrms.loadList("SelNonProdVisSplit", "sp_Merch_Dashboard", route, arr);
                int proPlanned, proUnplanned, proTotal, nonProPlanned, nonProUnplanned, nonProTotal, pendingPlanned, visitedPlanned, totalPlanned,
                    plannedActual, unplannedActual, totalActual;

                visitedPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["visited"].ToString());
                pendingPlanned = Int32.Parse(dtPlannedVisit.Rows[0]["pending"].ToString());
                totalPlanned = visitedPlanned + pendingPlanned;

                plannedActual = Int32.Parse(dtActualVisit.Rows[0]["Planned"].ToString());
                unplannedActual = Int32.Parse(dtActualVisit.Rows[0]["Unplanned"].ToString());
                totalActual = plannedActual + unplannedActual;

                proPlanned = Int32.Parse(dtProductiveVisit.Rows[0]["ScheduledProdVisits"].ToString());
                proUnplanned = Int32.Parse(dtProductiveVisit.Rows[0]["UnscheduledProdVisits"].ToString());
                proTotal = proPlanned + proUnplanned;

                nonProPlanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["ScheduledNonProdVisits"].ToString());
                nonProUnplanned = Int32.Parse(dtNonProductiveVisit.Rows[0]["UnscheduledNonProdVisits"].ToString());
                nonProTotal = nonProPlanned + nonProUnplanned;


                lblTotalPlannedVisit.Text = totalPlanned.ToString();
                lblVisitedPlanned.Text = visitedPlanned.ToString();
                lblPendingPlanned.Text = pendingPlanned.ToString();
                lblTotalActualVisit.Text = totalActual.ToString();
                lblPlannedActual.Text = plannedActual.ToString();
                lblUnplannedActual.Text = unplannedActual.ToString();
                lblTotalProductiveVisit.Text = proTotal.ToString();
                lblPlannedProductive.Text = proPlanned.ToString();
                lblUnplannedProductive.Text = proUnplanned.ToString();
                lblTotalNonProductiveVisit.Text = nonProTotal.ToString();
                lblPlannedNonProd.Text = nonProPlanned.ToString();
                lblUnplannedNonProd.Text = nonProUnplanned.ToString();
            }
            else
            {
                pnlTimeline.Visible = false;
            }
        }
    }
}