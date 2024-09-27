using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentFormat.OpenXml.Presentation;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public string ResponseType
        {
            get
            {
                string ResponseType = Request.Params["Type"];

                return ResponseType;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lnkAdvFilter.Visible= false;
                rdfromDate.MaxDate = DateTime.Now;
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
                foreach (RadComboBoxItem itmss in ddldepots.Items)
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
                
               
                

                if (ResponseType == null)
                    {
                        try
                        {


                            if (Session["KPIDate"] != null)
                            {
                                rdfromDate.SelectedDate = DateTime.Parse(Session["KPIDate"].ToString());
                            }
                            else
                            {
                                rdfromDate.SelectedDate = DateTime.Now;
                            }
                            RouteType();
                            if (Session["KPIType"] != null)
                            {
                                ddlRotType.SelectedValue = Session["KPIType"].ToString();
                            }
                            else
                            {
                               
                            }
                            Route("");
                            if (Session["KPIRoute"] != null)
                            {
                                rdRoute.SelectedValue = Session["KPIRoute"].ToString();
                            }
                            else
                            {

                            }
                        }
                        catch(Exception ex)
                        {
                        Response.Redirect("~/SignIn.aspx");
                        }
                }
                else if (ResponseType.Equals("udp"))
                {
                    try
                    {


                            rdfromDate.SelectedDate = DateTime.Parse(Session["UdpDate"].ToString());
                        ddlRotType.SelectedValue = Session["UdpType"].ToString();
                        rdRoute.SelectedValue = Session["UdpRoute"].ToString();
                    }
                    catch(Exception ex)
                    {
                    Response.Redirect("~/SignIn.aspx");
                    }
                }
                

                    Session["KPIRoute"] = null;
                    Session["KPIDate"] = null;
                    Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
                    Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
                    Session["KPIType"] = ddlRotType.SelectedValue.ToString();
                    ViewState["Chart"] = null;
                    
                try
                {
                    if ((Session["KPIRoute"] != null) && (Session["KPIRoute"].ToString() != ""))
                    {
                        string Route = rdRoute.SelectedValue.ToString();
                        DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
                        string Type = dt.Rows[0]["RouteType"].ToString();

                        if (Type == "SL")
                        {
                            //Sales
                            Response.Redirect("RouteSalesDashboard.aspx");
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = true;
                            pnlDel.Visible = true;
                            pnlSale.Visible = true;
                            pnlAR.Visible = true;
                            pnlAdv.Visible = true;
                            pnlOrder.Visible = true;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = true;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlinventoryReconfirmation.Visible = true;
                            pnlAssetTrackingandServiceReq.Visible = false;

                        }
                        else if (Type == "AR")
                        {
                            //AR
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = false;
                            pnlDel.Visible = false;
                            pnlSale.Visible = false;
                            pnlAR.Visible = true;
                            pnlAdv.Visible = true;
                            pnlOrder.Visible = false;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = false;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlinventoryReconfirmation.Visible = false;
                            pnlAssetTrackingandServiceReq.Visible = false;
                            pnlloadTime.Visible = false;
                        }
                        else if (Type == "MER")
                        {
                            Response.Redirect("RouteMerchDashboard.aspx");


                        }
                        else if (Type == "DL")
                        {
                            //Delivery
                            Response.Redirect("DeliveryRouteDashboard.aspx");
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = false;
                            pnlDel.Visible = true;
                            pnlSale.Visible = true;
                            pnlAR.Visible = false;
                            pnlAdv.Visible = false;
                            pnlOrder.Visible = false;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = true;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlinventoryReconfirmation.Visible = true;
                            pnlAssetTrackingandServiceReq.Visible = false;
                        }
                        else if (Type == "OR")
                        {
                            //Order
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = true;
                            pnlDel.Visible = false;
                            pnlSale.Visible = false;
                            pnlAR.Visible = false;
                            pnlAdv.Visible = false;
                            pnlOrder.Visible = true;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = false;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = false;
                            pnlinventoryReconfirmation.Visible = false;
                            pnlAssetTrackingandServiceReq.Visible = false;
                            pnlloadTime.Visible = true;
                        }
                        else if (Type == "OA")
                        {
                            //Order & AR
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = true;
                            pnlDel.Visible = false;
                            pnlSale.Visible = false;
                            pnlAR.Visible = true;
                            pnlAdv.Visible = true;
                            pnlOrder.Visible = false;
                            pnlAROrder.Visible = true;
                            pnlload.Visible = false;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlinventoryReconfirmation.Visible = false;
                            pnlAssetTrackingandServiceReq.Visible = false;
                            pnlloadTime.Visible = false;
                        }
                        else if (Type == "FS")
                        {
                            
                            Response.Redirect("RouteFieldServiceDashboard.aspx");
                            //Field Service
                            pnlstartmessage.Visible = false;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = false;
                            pnlDel.Visible = false;
                            pnlSale.Visible = true;
                            pnlAR.Visible = false;
                            pnlAdv.Visible = false;
                            pnlOrder.Visible = false;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = true;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlsalechart.Visible= false;
                            pnlInvoices.Visible = false;
                            pnlinventoryReconfirmation.Visible = true;
                            pnlAssetTrackingandServiceReq.Visible = true;
                        }
                        else
                        {
                            //Normal Route
                            pnlstartmessage.Visible = false;
                            pnlsalechart.Visible = true;
                            pnlInvoices.Visible = true;
                            pnlVisit.Visible = true;
                            pnlTarget.Visible = true;
                            pnlDel.Visible = true;
                            pnlSale.Visible = true;
                            pnlAR.Visible = true;
                            pnlAdv.Visible = true;
                            pnlOrder.Visible = true;
                            pnlAROrder.Visible = false;
                            pnlload.Visible = true;
                            pnlTimeline.Visible = true;
                            pnlSettlement.Visible = true;
                            pnlinventoryReconfirmation.Visible = false;
                            pnlAssetTrackingandServiceReq.Visible = false;
                            pnlloadTime.Visible = true;

                        }

                    }
                    else
                    {
                        pnlstartmessage.Visible = true;
                        pnlVisit.Visible = false;
                        pnlTarget.Visible = false;
                        pnlDel.Visible = false;
                        pnlSale.Visible = false;
                        pnlAR.Visible = false;
                        pnlAdv.Visible = false;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = false;
                        pnlTimeline.Visible = false;
                        pnlSettlement.Visible = false;
                        pnlsalechart.Visible = false;
                        pnlInvoices.Visible = false;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;

                    }
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteDAshboard.aspx", " Error : " + ex.Message.ToString() + " - " + innerMessage);

                }

                SelCusVisits();
                SelCusSchVisits();
                SelCollectionReport();
                if (pnlload.Visible == true)
                {
                    SelLoads();
                }
                if (pnlSale.Visible == true)
                {
                    SelSalesReport();

                }
                Settlement();
                TimeSetReport();
                SelOrders();
                SelQuotations();
                SelProdVisits();
                LoadTransfer();
                LoadOut();
                TotalInvoices();
                MonthlyTarget();
                DailyTarget();
                TotalInvoiceAmount();
                ARCollection();
                AdvanceCollection();
                if(pnlDel.Visible==true)
                {
                    SelDeliveries();

                }
                SelOutstanding();
                SelARCollection();

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
               
            }

        }
        public void Region()
        {
            ddlregion.DataSource = ObjclsFrms.loadList("SelectRegionTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlregion.DataTextField = "reg_Name";
            ddlregion.DataValueField = "reg_ID";
            ddlregion.DataBind();
        }

        public void RouteType()
        {
            ddlRotType.DataSource = ObjclsFrms.loadList("SelectRouteTypeforDropdown", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            ddlRotType.DataTextField = "Type";
            ddlRotType.DataValueField = "rot_Type";
            ddlRotType.DataBind();
        }
        public void Route(string DposubAreaCondition)
        {
            //string[] arr = { DposubAreaCondition };
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), ddlRotType.SelectedValue.ToString() };
            DataTable dt = ObjclsFrms.loadList("SelectRouteforRotDashboardDropDown", "sp_KPI_Dashboard", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public DataTable LoadData(string mode)
        {

                string route;
                if(rdRoute.SelectedValue.ToString().Equals(""))
                {
                route = "0";
                }
                else
                {
                route = rdRoute.SelectedValue.ToString();
                }
                Session["rdRoute"] = rdRoute.SelectedValue.ToString();
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
                DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", route.ToString(), arr);
                return dt;
          
        }

        public void SelCusVisits()
        {
          
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
            string route;
            if (rdRoute.SelectedValue.ToString().Equals(""))
            {
                route = "0";
            }
            else
            {
                route = rdRoute.SelectedValue.ToString();
            }
            string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

                DataTable dt1 = LoadData("TotalCusVisits");
                DataTable dtCustomerVisit = ObjclsFrms.loadList("SelCusVisits", "sp_KPI_Dashboard", route.ToString(), arr);

                string para1 = dt1.Rows[0][0].ToString();
                int i = 0;
                string XAxis = "";
                string YAxis = "";

                foreach (DataColumn dcCustomerVisit in dtCustomerVisit.Columns)
                {
                    if (i < dtCustomerVisit.Columns.Count - 1)
                    {
                        XAxis += dcCustomerVisit.ColumnName.ToString() + "-";
                        YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString() + "-";
                    }
                    else
                    {
                        XAxis += dcCustomerVisit.ColumnName.ToString();
                        YAxis += dtCustomerVisit.Rows[0][dcCustomerVisit.ColumnName].ToString();
                    }
                    i++;
                }
                lblPlannedVisit.Text = para1.ToString();
                string CuVisits = "ApplyPlannedDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
                ViewState["Chart"] += CuVisits;
           
        }

        public void SelCusSchVisits()
        {
           
                Session["FromDate"] = rdfromDate.SelectedDate.ToString();
                string route = rdRoute.SelectedValue.ToString();
                string[] arr = new string[] { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };

                DataTable dt1 = LoadData("SelCusSchVisitsTotal");
                DataTable dtActualVisit = ObjclsFrms.loadList("SelCusSchVisSplit", "sp_KPI_Dashboard", route.ToString(), arr);

                string para1 = dt1.Rows[0][0].ToString();
                int i = 0;
                string XAxis = "";
                string YAxis = ""; 


                foreach (DataColumn dcActualVisit in dtActualVisit.Columns)
                {
                    if (i < dtActualVisit.Columns.Count - 1)
                    {
                        XAxis += dcActualVisit.ColumnName.ToString() + "-";
                        YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString() + "-";
                    }
                    else
                    {
                        XAxis += dcActualVisit.ColumnName.ToString();
                        YAxis += dtActualVisit.Rows[0][dcActualVisit.ColumnName].ToString();
                    }
                    i++;
                }
            //lblActualVisit.Text = para1.ToString();
            int tot= Int32.Parse(dtActualVisit.Rows[0]["Planned"].ToString()) + Int32.Parse(dtActualVisit.Rows[0]["Unplanned"].ToString());
            lblActualVisit.Text = tot.ToString();
            string CuVisits = "ApplyActualDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "');";
                ViewState["Chart"] += CuVisits;
          
        }

        public void SelCollectionReport()
        {
            lblTotalCheque.Text = String.Empty;
            DataTable dtCheque = LoadData("SelCollChequeReport");
            DataTable dtChequeCount = LoadData("SelCollChequeCount");
            DataTable dtChequeDetail = LoadData("SelChequeDetail");
            rptCheque.DataSource = dtChequeDetail;
            rptCheque.DataBind();
            string totalCheque = dtCheque.Rows[0]["total"].ToString();
            string chequeCount = dtChequeCount.Rows[0]["total"].ToString();
            lblTotalCheque.Text = chequeCount + " / " + totalCheque;
        }

        public void SelLoads()
        {
            DataTable dt = LoadData("SelLICountSplit");
            DataTable dt1 = LoadData("SelLiCount");
            DataTable dts = LoadData("SelLICountSplits");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            lblLoadIn.Text = para1.ToString();
            lblLICompleted.Text = dts.Rows[0]["LICompleted"].ToString();
            lblLIPending.Text = dts.Rows[0]["LIPending"].ToString();
            lblLINotProcss.Text = dts.Rows[0]["LINotProcessed"].ToString();
            lblLIRejected.Text = dts.Rows[0]["LIRejected"].ToString();
            string CuVisits = "ApplyLoadsDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }

        public void SelSalesReport()
        {
            DataTable dt = LoadData("SelAllSalesSplit");
            DataTable dt1 = LoadData("SelAllSales");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }

            string CuVisits = "ApplyBarCharts('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , 'salesReport' , 'Total Invoices' ,'" + para1 + "', 'bar', '3');";
            ViewState["Chart"] += CuVisits;
        }

        public void Settlement()
        {
            TotalCash();
            TotalCollected();
        }

        public void TotalCash()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelTotalWithMode", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, amount;
                double sum = 0;
                string hardCash, pos, onlinePay;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    amount = lstCashReceived.Rows[i]["Amount"].ToString();
                    sum += double.Parse(amount);
                    if (mode.Equals("HC"))
                    {
                        hardCash = amount.ToString();
                        ViewState["HardCash"] = hardCash.ToString();
                        lblHardCash.Text = hardCash;
                    }
                    else if (mode.Equals("POS"))
                    {
                        pos = amount.ToString();
                        ViewState["POS"] = pos.ToString();
                        lblPOS.Text = pos;
                    }
                    else if (mode.Equals("OP"))
                    {
                        onlinePay = amount.ToString();
                        ViewState["Online"] = onlinePay.ToString();
                        lblOnlinePayment.Text = onlinePay;
                    }
                }
                lblCashTotal.Text = sum.ToString("#,##0.00");
            }
            else
            {
                lblCashTotal.Text = "0";
                lblHardCash.Text = "0";
                lblOnlinePayment.Text = "0";
                lblPOS.Text = "0";
            }
        }

        public void TotalCollected()
        {
            UserDailyID();
            string udpId = ViewState["ID"].ToString();
            DataTable lstCashReceived = ObjclsFrms.loadList("SelectUserSettlementPayModes", "sp_KPI_Dashboard", udpId.ToString());
            if (lstCashReceived.Rows.Count > 0)
            {
                string mode, hcCollected, hcVariance, posCollected, posVariance, opVariance, opCollected;
                double sumCollected = 0, sumVariance = 0;
                for (int i = 0; i < lstCashReceived.Rows.Count; i++)
                {
                    mode = lstCashReceived.Rows[i]["Mode"].ToString();
                    sumCollected += double.Parse(lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString());
                    sumVariance += double.Parse(lstCashReceived.Rows[i]["usp_Variance"].ToString());
                    if (mode.Equals("HC"))
                    {
                        hcCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        hcVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarianceHard.Text = hcVariance.ToString();
                        lblCollectedHard.Text = hcCollected.ToString();
                    }
                    else if (mode.Equals("POS"))
                    {
                        posCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        posVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVariancePos.Text = posVariance.ToString();
                        lblCollectedPos.Text = posCollected.ToString();
                    }
                    else if (mode.Equals("OP"))
                    {
                        opCollected = lstCashReceived.Rows[i]["usp_CollectedAmount"].ToString();
                        opVariance = lstCashReceived.Rows[i]["usp_Variance"].ToString();
                        lblVarainceOnline.Text = opVariance.ToString();
                        lblCollectedOnline.Text = opCollected.ToString();
                    }
                }
                lblCollectedTotal.Text = sumCollected.ToString("#,##0.00");
                lblTotalVariance.Text = sumVariance.ToString("#,##0.00");
            }
            else
            {
                lblCollectedTotal.Text = "0.00";
                lblCollectedHard.Text = "0.00";
                lblCollectedOnline.Text = "0.00";
                lblCollectedPos.Text = "0.00";
                lblTotalVariance.Text = "0.00";
                lblVarianceHard.Text = "0.00";
                lblVarainceOnline.Text = "0.00";
                lblVariancePos.Text = "0.00";
            }
        }


        public void UserDailyID()
        {
            string date = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MM-yyyy");
            string route = rdRoute.SelectedValue.ToString();
            string[] arr = { date.ToString() };
            DataTable lstID = ObjclsFrms.loadList("SelectUserDailyProcessID", "sp_KPI_Dashboard", route, arr);
            if (lstID.Rows.Count > 0)
            {
                string Id = lstID.Rows[0]["udp_ID"].ToString();
                ViewState["ID"] = Id.ToString();
            }
            else
            {
                ViewState["ID"] = "0";
            }
        }

        public void TimeSetReport()
        {
            lblHours.Text = String.Empty;
            lblStartTime.Text = String.Empty;
            lblSpendWithCus.Text = "00 Hrs  00 Mins";

            DataTable dt = LoadData("SelTimeReport");
            if (dt.Rows.Count > 0)
            {
                lblHours.Text = dt.Rows[0]["Duration"].ToString();
                lblStartTime.Text = dt.Rows[0]["StartTime"].ToString();
                lblSpendWithCus.Text = dt.Rows[0]["CusTime"].ToString();
                lblEndDay.Text = dt.Rows[0]["EndDayStatus"].ToString();
                lblSettlement.Text = dt.Rows[0]["udp_SettlementStatus"].ToString();
                lblAppProcess.Text = dt.Rows[0]["udp_IsAppProcessComplete"].ToString();
                lblLoadout.Text = dt.Rows[0]["udp_LoadOutStatus"].ToString();
                if (lblHours.Text.Equals(""))
                {
                    lblHours.Text = "00:00:00";
                }
            }
        }

        public void SelOrders()
        {
            lblTotOrdCount.Text = String.Empty;
            lblTotOrdCounts.Text = String.Empty;
            DataTable dtOrders = LoadData("SelOrderCount");
            lblTotOrdCount.Text = dtOrders.Rows[0][0].ToString();
            lblTotOrdCounts.Text = dtOrders.Rows[0][0].ToString();
        }

        public void SelProdVisits()
        {
            DataTable dtProductive = LoadData("SelProdVisSplit");
            int proPlanned, proUnplanned, proTotal;
            proPlanned = Int32.Parse(dtProductive.Rows[0]["ScheduledProdVisits"].ToString());
            proUnplanned = Int32.Parse(dtProductive.Rows[0]["UnscheduledProdVisits"].ToString());
            proTotal = proPlanned + proUnplanned;
            lblProductivePlanned.Text = proPlanned.ToString();
            lblProductiveUnplanned.Text = proUnplanned.ToString();
            lblTotalProductive.Text = proTotal.ToString();

            DataTable dtNonProductive = LoadData("SelNonProdVisSplit");
            int nonProPlanned, nonProUnplanned, nonProTotal;
            nonProPlanned = Int32.Parse(dtNonProductive.Rows[0]["ScheduledNonProdVisits"].ToString());
            nonProUnplanned = Int32.Parse(dtNonProductive.Rows[0]["UnscheduledNonProdVisits"].ToString());
            nonProTotal = nonProPlanned + nonProUnplanned;
            lblNonProductivePlanned.Text = nonProPlanned.ToString();
            lblNonProductiveUnplanned.Text = nonProUnplanned.ToString();
            lblTotalNonProductive.Text = nonProTotal.ToString();

        }

        public void ARCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAr = LoadData("SelectARCount");
            if (lstAr.Rows.Count > 0)
            {
                totalCount = lstAr.Rows[0]["TotalArCount"].ToString();
                totalAmount = lstAr.Rows[0]["TotalARAmount"].ToString();
                hcCount = lstAr.Rows[0]["AR_HC_Count"].ToString();
                hcAmount = lstAr.Rows[0]["AR_HC_Amount"].ToString();
                posCount = lstAr.Rows[0]["AR_POS_Count"].ToString();
                posAmount = lstAr.Rows[0]["AR_POS_Amount"].ToString();
                opCount = lstAr.Rows[0]["AR_OP_Count"].ToString();
                opAmount = lstAr.Rows[0]["AR_OP_Amount"].ToString();
                chequeCount = lstAr.Rows[0]["AR_Chq_Count"].ToString();
                chequeAmount = lstAr.Rows[0]["AR_Chq_Amount"].ToString();

                lblTotalArAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblArHcAmt.Text = hcAmount.ToString();
                lblArHcCount.Text = hcCount.ToString();
                lblArPosAmt.Text = posAmount.ToString();
                lblArPosCount.Text = posCount.ToString();
                lblArOpAmt.Text = opAmount.ToString();
                lblArOpCount.Text = opCount.ToString();
                lblArChequeAmt.Text = chequeAmount.ToString();
                lblArChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalArAmt.Text = "0 / 0.00";
                lblArHcAmt.Text = "0.00";
                lblArHcCount.Text = "0";
                lblArPosAmt.Text = "0.00";
                lblArPosCount.Text = "0";
                lblArOpAmt.Text = "0.00";
                lblArOpCount.Text = "0";
                lblArChequeAmt.Text = "0.00";
                lblArChequeCount.Text = "0";
            }
        }

        public void AdvanceCollection()
        {
            string totalCount, totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, chequeCount, chequeAmount;
            DataTable lstAdvance = LoadData("SelectAdvanceCount");
            if (lstAdvance.Rows.Count > 0)
            {
                totalCount = lstAdvance.Rows[0]["TotalApCount"].ToString();
                totalAmount = lstAdvance.Rows[0]["TotalAPAmount"].ToString();
                hcCount = lstAdvance.Rows[0]["AP_HC_Count"].ToString();
                hcAmount = lstAdvance.Rows[0]["AP_HC_Amount"].ToString();
                posCount = lstAdvance.Rows[0]["AP_POS_Count"].ToString();
                posAmount = lstAdvance.Rows[0]["AP_POS_Amount"].ToString();
                opCount = lstAdvance.Rows[0]["AP_OP_Count"].ToString();
                opAmount = lstAdvance.Rows[0]["AP_OP_Amount"].ToString();
                chequeCount = lstAdvance.Rows[0]["AP_Chq_Count"].ToString();
                chequeAmount = lstAdvance.Rows[0]["AP_Chq_Amount"].ToString();

                lblTotalAdvAmt.Text = totalCount.ToString() + " / " + totalAmount.ToString();
                lblAdvHcAmt.Text = hcAmount.ToString();
                lblAdvHcCount.Text = hcCount.ToString();
                lblAdvPosAmt.Text = posAmount.ToString();
                lblAdvPosCount.Text = posCount.ToString();
                lblAdvOpAmt.Text = opAmount.ToString();
                lblAdvOpCount.Text = opCount.ToString();
                lblAdvChequeAmt.Text = chequeAmount.ToString();
                lblAdvChequeCount.Text = chequeCount.ToString();
            }
            else
            {
                lblTotalAdvAmt.Text = "0 / 0.00";
                lblAdvHcAmt.Text = "0.00";
                lblAdvHcCount.Text = "0";
                lblAdvPosAmt.Text = "0.00";
                lblAdvPosCount.Text = "0";
                lblAdvOpAmt.Text = "0.00";
                lblAdvOpCount.Text = "0";
                lblAdvChequeAmt.Text = "0.00";
                lblAdvChequeCount.Text = "0";
            }
        }

        public void TotalInvoiceAmount()
        {
            string totalAmount, hcCount, hcAmount, posCount, posAmount, opCount, opAmount, creditCount, creditAmount;
            DataTable lstInvoice = LoadData("SelectTotalInvoiceCollection");
            if (lstInvoice.Rows.Count > 0)
            {
                totalAmount = lstInvoice.Rows[0]["TotalInvAmount"].ToString();
                hcCount = lstInvoice.Rows[0]["HC_Count"].ToString();
                hcAmount = lstInvoice.Rows[0]["HC_Amount"].ToString();
                posCount = lstInvoice.Rows[0]["POS_Count"].ToString();
                posAmount = lstInvoice.Rows[0]["POS_Amount"].ToString();
                opCount = lstInvoice.Rows[0]["OP_Count"].ToString();
                opAmount = lstInvoice.Rows[0]["OP_Amount"].ToString();
                creditCount = lstInvoice.Rows[0]["CR_Count"].ToString();
                creditAmount = lstInvoice.Rows[0]["CR_Amount"].ToString();

                lblTotalInvAmt.Text = totalAmount.ToString();
                lblInvHcAmt.Text = hcAmount.ToString();
                lblInvHcCount.Text = hcCount.ToString();
                lblInvPosAmt.Text = posAmount.ToString();
                lblInvPosCount.Text = posCount.ToString();
                lblInvOpAmt.Text = opAmount.ToString();
                lblInvOpCount.Text = opCount.ToString();
                lblInvCreditAmt.Text = creditAmount.ToString();
                lblInvCreditCount.Text = creditCount.ToString();
            }
            else
            {
                lblTotalInvAmt.Text = "0 / 0.00";
                lblInvHcAmt.Text = "0.00";
                lblInvHcCount.Text = "0";
                lblInvPosAmt.Text = "0.00";
                lblInvPosCount.Text = "0";
                lblInvOpAmt.Text = "0.00";
                lblInvOpCount.Text = "0";
                lblInvCreditAmt.Text = "0.00";
                lblInvCreditCount.Text = "0";
            }
        }

        public void TotalInvoices()
        {
            DataTable dtInvoices = LoadData("SelectTotalInvoice");
            int sales, gr, br, foc, invoices;
            sales = Int32.Parse(dtInvoices.Rows[0]["Sales"].ToString());
            gr = Int32.Parse(dtInvoices.Rows[0]["GoodReturn"].ToString());
            br = Int32.Parse(dtInvoices.Rows[0]["BadReturn"].ToString());
            foc = Int32.Parse(dtInvoices.Rows[0]["FreeCost"].ToString());
            invoices = Int32.Parse(dtInvoices.Rows[0]["Invoices"].ToString());
            lblSales.Text = sales.ToString();
            lblGoodReturn.Text = gr.ToString();
            lblBadReturn.Text = br.ToString();
            lblFoc.Text = foc.ToString();
            lblTotalInvoices.Text = invoices.ToString();
        }

        public void LoadTransfer()
        {
            DataTable lstLTCount = LoadData("SelLTGDCount");
            string good, bad;
            good = lstLTCount.Rows[0]["GDLoadTransfer"].ToString();
            bad = lstLTCount.Rows[0]["BDLoadTransfer"].ToString();
            lblLTGoodStock.Text = good.ToString();
            lblLTBadStock.Text = bad.ToString();
        }

        public void LoadOut()
        {
            DataTable lstGoodLoadOut = LoadData("SelLOGDCount");
            DataTable lstBadLoadOut = LoadData("SelLOBDCount");
            int good, gEnd, gOffLoad, gAdj, bad, bOffLoad, bAdj;
            good = Int32.Parse(lstGoodLoadOut.Rows[0]["LoadOutCount"].ToString());
            if (good == 0)
            {
                pnlGDgreen.Visible = false;
                pnlGDred.Visible = true;
            }
            else
            {
                pnlGDgreen.Visible = true;
                pnlGDred.Visible = false;
            }
            gEnd = Int32.Parse(lstGoodLoadOut.Rows[0]["EndStockCount"].ToString());
            if (gEnd == 0)
            {
                pnlGDEndGreen.Visible = false;
                pnlGDEndRed.Visible = true;
            }
            else
            {
                pnlGDEndGreen.Visible = true;
                pnlGDEndRed.Visible = false;
            }
            gOffLoad = Int32.Parse(lstGoodLoadOut.Rows[0]["OffloadCount"].ToString());
            if (gOffLoad == 0)
            {
                pnlGDOffGreen.Visible = false;
                pnlGDOffRed.Visible = true;
            }
            else
            {
                pnlGDOffGreen.Visible = true;
                pnlGDOffRed.Visible = false;
            }
            gAdj = Int32.Parse(lstGoodLoadOut.Rows[0]["AdjCount"].ToString());
            if (gAdj == 0)
            {
                pnlGDAdjGreen.Visible = false;
                pnlGDAdjRed.Visible = true;
            }
            else
            {
                pnlGDAdjGreen.Visible = true;
                pnlGDAdjRed.Visible = false;
            }
            bad = Int32.Parse(lstBadLoadOut.Rows[0]["LoadOutCount"].ToString());
            if (bad == 0)
            {
                pnlBDgreen.Visible = false;
                pnlBDred.Visible = true;
            }
            else
            {
                pnlBDgreen.Visible = true;
                pnlBDred.Visible = false;
            }
            bOffLoad = Int32.Parse(lstBadLoadOut.Rows[0]["OffloadCount"].ToString());
            if (bOffLoad == 0)
            {
                pnlBDOffGreen.Visible = false;
                pnlBDOffRed.Visible = true;
            }
            else
            {
                pnlBDOffGreen.Visible = true;
                pnlBDOffRed.Visible = false;
            }
            bAdj = Int32.Parse(lstBadLoadOut.Rows[0]["AdjCount"].ToString());
            if (bAdj == 0)
            {
                pnlBDAdjGreen.Visible = false;
                pnlBDAdjRed.Visible = true;
            }
            else
            {
                pnlBDAdjGreen.Visible = true;
                pnlBDAdjRed.Visible = false;
            }
        }

        public void MonthlyTarget()
        {
            DataTable dtMonthlyTarget = new DataTable();
            dtMonthlyTarget = ObjclsFrms.loadList("SelectMonthlyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtMonthlyTarget.Rows.Count; i++)
            {
                if (i < dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtMonthlyTarget.Rows.Count - 1)
                {
                    XAxis += dtMonthlyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtMonthlyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtMonthlyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string MonthlyTargetChart = "ApplyMonthlyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += MonthlyTargetChart;
        }

        public void DailyTarget()
        {
            DataTable dtDailyTarget = new DataTable();
            dtDailyTarget = ObjclsFrms.loadList("SelectDailyTarget", "sp_KPI_Dashboard", rdRoute.SelectedValue.ToString());
            string XAxis = "";
            string YAxis = "";
            string ZAxis = "";
            for (int i = 0; i < dtDailyTarget.Rows.Count; i++)
            {
                if (i < dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString() + "-";
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString() + "-";
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString() + "-";
                }
                else if (i == dtDailyTarget.Rows.Count - 1)
                {
                    XAxis += dtDailyTarget.Rows[i]["rtp_Month"].ToString();
                    YAxis += dtDailyTarget.Rows[i]["TargetAmount"].ToString();
                    ZAxis += dtDailyTarget.Rows[i]["AchievedAmount"].ToString();
                }
            }
            string DailyTargetChart = "ApplyDailyTargetChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "' , '" + ZAxis.ToString() + "');";
            ViewState["Chart"] += DailyTargetChart;
        }


        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            
                Session["KPIRoute"] = null;
                Session["KPIDate"] = null;
                Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
                Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
                ViewState["Chart"] = null;
                
            try
            {
                if (Session["KPIRoute"] != null)
                {
                    string Route = rdRoute.SelectedValue.ToString();
                    DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
                    string Type = dt.Rows[0]["RouteType"].ToString();

                    if (Type == "SL")
                    {
                        //Sales
                        Response.Redirect("RouteSalesDashboard.aspx");
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = true;
                        pnlDel.Visible = true;
                        pnlSale.Visible = true;
                        pnlAR.Visible = true;
                        pnlAdv.Visible = true;
                        pnlOrder.Visible = true;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = true;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlinventoryReconfirmation.Visible = true;
                        pnlAssetTrackingandServiceReq.Visible = false;


                    }
                    else if (Type == "AR")
                    {
                        //AR
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = false;
                        pnlDel.Visible = false;
                        pnlSale.Visible = false;
                        pnlAR.Visible = true;
                        pnlAdv.Visible = true;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = false;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = false;
                    }
                    else if (Type == "MER")
                    {
                        //Merchandising
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = false;
                        pnlDel.Visible = false;
                        pnlSale.Visible = false;
                        pnlAR.Visible = false;
                        pnlAdv.Visible = false;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = false;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = false;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = true;

                    }
                    else if (Type == "DL")
                    {
                        Response.Redirect("DeliveryRouteDashboard.aspx");
                        //Delivery
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = false;
                        pnlDel.Visible = true;
                        pnlSale.Visible = true;
                        pnlAR.Visible = false;
                        pnlAdv.Visible = false;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = true;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlinventoryReconfirmation.Visible = true;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = true;
                    }
                    else if (Type == "OR")
                    {
                        //Order
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = true;
                        pnlDel.Visible = false;
                        pnlSale.Visible = false;
                        pnlAR.Visible = false;
                        pnlAdv.Visible = false;
                        pnlOrder.Visible = true;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = false;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = false;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = true;
                    }
                    else if (Type == "OA")
                    {
                        //Order & AR
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = true;
                        pnlDel.Visible = false;
                        pnlSale.Visible = false;
                        pnlAR.Visible = true;
                        pnlAdv.Visible = true;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = true;
                        pnlload.Visible = false;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = false;
                    }
                    else if (Type == "FS")
                    {
                        Response.Redirect("RouteFieldServiceDashboard.aspx");
                        //Field Service
                        pnlstartmessage.Visible = false;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = false;
                        pnlDel.Visible = false;
                        pnlSale.Visible = true;
                        pnlAR.Visible = false;
                        pnlAdv.Visible = false;
                        pnlOrder.Visible = false;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = true;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlsalechart.Visible = false;
                        pnlInvoices.Visible = false;
                        pnlinventoryReconfirmation.Visible = true;
                        pnlAssetTrackingandServiceReq.Visible = true;
                        pnlloadTime.Visible = true;
                    }
                    else
                    {
                        //Normal Route
                        pnlstartmessage.Visible = false;
                        pnlsalechart.Visible = true;
                        pnlInvoices.Visible = true;
                        pnlVisit.Visible = true;
                        pnlTarget.Visible = true;
                        pnlDel.Visible = true;
                        pnlSale.Visible = true;
                        pnlAR.Visible = true;
                        pnlAdv.Visible = true;
                        pnlOrder.Visible = true;
                        pnlAROrder.Visible = false;
                        pnlload.Visible = true;
                        pnlTimeline.Visible = true;
                        pnlSettlement.Visible = true;
                        pnlinventoryReconfirmation.Visible = false;
                        pnlAssetTrackingandServiceReq.Visible = false;
                        pnlloadTime.Visible = true;

                    }

                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "RouteDAshboard.aspx", " Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
            SelCusVisits();
            SelCusSchVisits();
            SelCollectionReport();
            if (pnlload.Visible == true)
            {
                SelLoads();
            }
            if(pnlSale.Visible==true)
            {
                SelSalesReport();

            }
            Settlement();
            TimeSetReport();
            SelOrders();
            SelQuotations();
            SelProdVisits();
            LoadTransfer();
            LoadOut();
            TotalInvoices();
            MonthlyTarget();
            DailyTarget();
            TotalInvoiceAmount();
            ARCollection();
            AdvanceCollection();
            if (pnlDel.Visible == true)
            {
                SelDeliveries();

            }
            SelOutstanding();
            SelARCollection();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);
           
        }
        public static void OpenNewBrowserWindow(string Url, System.Web.UI.Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        protected void lnkTimeline_Click(object sender, EventArgs e)
        {
            UserDailyID();
            string Id = "232";
            string url = ConfigurationManager.AppSettings.Get("TrackingUrlID");
            OpenNewBrowserWindow(url + ViewState["ID"] + "&&mode=DIGITS-SFA", this);

        }

        protected void lnkTarget_Click(object sender, EventArgs e)
        {
            Response.Redirect("TargetDashboardDetail.aspx");
        }

        protected void inkAR_Click(object sender, EventArgs e)
        {
            Response.Redirect("CollectionDetails.aspx");
        }

        protected void lnkLT_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadOutDashboardDetail.aspx");
        }

        protected void PlannedVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
        }

        protected void ActualVisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
        }

        protected void Productivevisits_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerVisitsDetail.aspx");
        }

        protected void salessummary_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadInAndSalesDetail.aspx");
        }

        protected void LoadIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoadInAndSalesDetail.aspx");
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
           
                Session["KPIRoute"] = null;
                Session["KPIDate"] = null;
                Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
                Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
                Session["KPIType"] = ddlRotType.SelectedValue.ToString();
                ViewState["Chart"] = null;
                

            string Route = rdRoute.SelectedValue.ToString();
            DataTable dt = ObjclsFrms.loadList("SelRouteType", "sp_KPI_Dashboard", Route.ToString());
            string Type = dt.Rows[0]["RouteType"].ToString();

            if (Type == "SL")
            {
                //Sales
                Response.Redirect("RouteSalesDashboard.aspx");
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = true;
                pnlDel.Visible = true;
                pnlSale.Visible = true;
                pnlAR.Visible = true;
                pnlAdv.Visible = true;
                pnlOrder.Visible = true;
                pnlAROrder.Visible = false;
                pnlload.Visible = true;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlinventoryReconfirmation.Visible = true;
                pnlAssetTrackingandServiceReq.Visible = false;

            }
            else if (Type == "AR")
            {
                //AR
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = false;
                pnlDel.Visible = false;
                pnlSale.Visible = false;
                pnlAR.Visible = true;
                pnlAdv.Visible = true;
                pnlOrder.Visible = false;
                pnlAROrder.Visible = false;
                pnlload.Visible = false;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlinventoryReconfirmation.Visible = false;
                pnlAssetTrackingandServiceReq.Visible = false;
                pnlloadTime.Visible = false;
            }
            else if (Type == "MER")
            {
                Response.Redirect("RouteMerchDashboard.aspx");

            }
            else if (Type == "DL")
            {
                //Delivery
                Response.Redirect("DeliveryRouteDashboard.aspx");
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = false;
                pnlDel.Visible = true;
                pnlSale.Visible = true;
                pnlAR.Visible = false;
                pnlAdv.Visible = false;
                pnlOrder.Visible = false;
                pnlAROrder.Visible = false;
                pnlload.Visible = true;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlinventoryReconfirmation.Visible = true;
                pnlAssetTrackingandServiceReq.Visible = false;
            }
            else if (Type == "OR")
            {
                //Order
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = true;
                pnlDel.Visible = false; 
                pnlSale.Visible = false;
                pnlAR.Visible = false;
                pnlAdv.Visible = false;
                pnlOrder.Visible = true;
                pnlAROrder.Visible = false;
                pnlload.Visible = false;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = false;
                pnlinventoryReconfirmation.Visible = true;
                pnlAssetTrackingandServiceReq.Visible = false;
                pnlloadTime.Visible = true;
            }
            else if (Type == "OA")
            {
                //Order & AR
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = true;
                pnlDel.Visible = false; 
                pnlSale.Visible = false;
                pnlAR.Visible = true;
                pnlAdv.Visible = true;
                pnlOrder.Visible = false;
                pnlAROrder.Visible = true;
                pnlload.Visible = false;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlinventoryReconfirmation.Visible = false;
                pnlAssetTrackingandServiceReq.Visible = false;
                pnlloadTime.Visible = false;
            }
            else if (Type == "FS")
            {
                Response.Redirect("RouteFieldServiceDashboard.aspx");
                //Field Service
                pnlstartmessage.Visible = false;
                pnlVisit.Visible = true;
                pnlTarget.Visible = false;
                pnlDel.Visible = false;
                pnlSale.Visible = true;
                pnlAR.Visible = false;
                pnlAdv.Visible = false;
                pnlOrder.Visible = false;
                pnlAROrder.Visible = false;
                pnlload.Visible = true;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlsalechart.Visible = false;
                pnlInvoices.Visible = false;
                pnlinventoryReconfirmation.Visible = true;
                pnlAssetTrackingandServiceReq.Visible = true;
            }
            else
            {
                //Normal Route
                pnlstartmessage.Visible = false;
                pnlsalechart.Visible = true;
                pnlInvoices.Visible = true;
                pnlVisit.Visible = true;
                pnlTarget.Visible = true;
                pnlDel.Visible = true;
                pnlSale.Visible = true;
                pnlAR.Visible = true;
                pnlAdv.Visible = true;
                pnlOrder.Visible = true;
                pnlAROrder.Visible = false;
                pnlload.Visible = true;
                pnlTimeline.Visible = true;
                pnlSettlement.Visible = true;
                pnlinventoryReconfirmation.Visible = false;
                pnlAssetTrackingandServiceReq.Visible= false;
                pnlloadTime.Visible = true;

            }
            SelCusVisits();
            SelCusSchVisits();
            SelCollectionReport();
            if (pnlload.Visible == true)
            {
                SelLoads();
            }
            if (pnlSale.Visible == true)
            {
                SelSalesReport();

            }
            Settlement();
            TimeSetReport();
            SelOrders();
            SelQuotations();
            SelProdVisits();
            LoadTransfer();
            LoadOut();
            TotalInvoices();
            MonthlyTarget();
            DailyTarget();
            TotalInvoiceAmount();
            ARCollection();
            AdvanceCollection();
            if (pnlDel.Visible == true)
            {
                SelDeliveries();

            }
            SelOutstanding();
            SelARCollection();
            InventoryReconfirmation();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'> " + ViewState["Chart"].ToString() + " </script>", false);

           
        }

        protected void btnVanStock_Click(object sender, EventArgs e)
        {
             UserDailyID();
                string ID = ViewState["ID"].ToString();
              Session["rdRoute"] = rdRoute.SelectedValue.ToString();
              Session["fDate"] = rdfromDate.SelectedDate.ToString();
              Session["TDate"] = rdfromDate.SelectedDate.ToString();

            //   Response.Redirect("CurrentVanStock.aspx?Id=" + ID);
            string url = ConfigurationManager.AppSettings.Get("BackendURL");
            string s = "BO_Digits/en/CurrentVanStock.aspx?ID=" + ID;
            url = url + s;

            OpenNewBrowserWindow(url, this);
        }

        protected void TotalOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListOrders.aspx?mode=2");
        }
        public void Depot( string Regcondition)
        {
            string[] arr = { Regcondition };
            ddldepots.DataSource = ObjclsFrms.loadList("SelectDepotTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString(),arr);
            ddldepots.DataTextField = "dep_Name";
            ddldepots.DataValueField = "dep_ID";
            ddldepots.DataBind();
        }
        public void DpoArea(string DpoCondition)
        {
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
        public string DPO()
        {
            var CollectionMarket1 = ddldepots.CheckedItems;
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

        protected void ddldepot_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
            DpoArea(DpoCondition);
        }

        protected void ddldpoArea_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dpoareaID = DPOarea();
            string DpoAreaCondition = " dsa_dpa_ID in (" + dpoareaID + ")";
            DpoSubArea(DpoAreaCondition);
        }

        protected void ddldpoSubArea_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string dposubareaID = DPOsubarea();
            string DposubAreaCondition = " rot_dsa_ID in (" + dposubareaID + ")";
            //Route("");
        }

        protected void ddldepots_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            string dpoID = DPO();
            string DpoCondition = " dpa_dep_ID in (" + dpoID + ")";
           
           
            DpoArea(DpoCondition);

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

        protected void Quotations_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuotationOrderHeader.aspx?mode=2");
        }
        public void SelQuotations()
        {
            lblQuotationCount.Text = String.Empty;
            lblQuotationCounts.Text = String.Empty;
            DataTable dtOrders = LoadData("SelQuotationCount");
            lblQuotationCount.Text = dtOrders.Rows[0][0].ToString();
            lblQuotationCounts.Text = dtOrders.Rows[0][0].ToString();
        }

        public void SelDeliveries()
        {
            DataTable dt = LoadData("SelDeliveryCountSplit");
            DataTable dt1 = LoadData("SelDeliveryCount");
            DataTable dts = LoadData("SelDeliveryCountSplits");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            lblDelivery.Text = para1.ToString();
            lblDelivered.Text = dts.Rows[0]["Delivered"].ToString();
            lblPD.Text = dts.Rows[0]["PD"].ToString();
            lblNotDelivered.Text = dts.Rows[0]["ND"].ToString();
            string CuVisits = "ApplyDeliveryDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }
        public void SelOutstanding()
        {
            DataTable dt = LoadData("SelOutstandingCountSplit");
            DataTable dt1 = LoadData("SelOutstandingCount");
            DataTable dts = LoadData("SelOutstandingCountSplits");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            lblOutstanding.Text = para1.ToString();
            lblDue.Text = dts.Rows[0]["Due"].ToString();
            lblOverdue.Text = dts.Rows[0]["OverDue"].ToString();
            lblOutstandingAmt.Text = dts.Rows[0]["OutstandingAmt"].ToString();
            lblDueAmt.Text = dts.Rows[0]["DueAmt"].ToString();
            lblOverdueAmt.Text = dts.Rows[0]["OverdueAmt"].ToString();

            string CuVisits = "ApplyOutstandingDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }
        public void SelARCollection()
        {
            DataTable dt = LoadData("SelARCountSplit");
            DataTable dt1 = LoadData("SelARCount");
            DataTable dts = LoadData("SelARCountSplits");

            string para1 = dt1.Rows[0][0].ToString();
            int i = 0;
            string XAxis = "";
            string YAxis = "";

            foreach (DataColumn dc in dt.Columns)
            {
                if (i < dt.Columns.Count - 1)
                {
                    XAxis += dc.ColumnName.ToString() + "-";
                    YAxis += dt.Rows[0][dc.ColumnName].ToString() + "-";
                }
                else
                {
                    XAxis += dc.ColumnName.ToString();
                    YAxis += dt.Rows[0][dc.ColumnName].ToString();
                }
                i++;
            }
            lblARCount.Text = para1.ToString();
            lblARAmount.Text = dts.Rows[0]["TotalARAmount"].ToString();
            lblHCCount.Text = dts.Rows[0]["AR_HC_Count"].ToString();
            lblHCAmount.Text = dts.Rows[0]["AR_HC_Amount"].ToString();
            lblOPCount.Text = dts.Rows[0]["AR_OP_Count"].ToString();
            lblOPAmount.Text = dts.Rows[0]["AR_OP_Amount"].ToString();
            lblPOSCount.Text = dts.Rows[0]["AR_POS_Count"].ToString();
            lblPOSAmount.Text = dts.Rows[0]["AR_POS_Amount"].ToString();
            lblChequeCount.Text = dts.Rows[0]["AR_Chq_Count"].ToString();
            lblChequeAmount.Text = dts.Rows[0]["AR_Chq_Amount"].ToString();
            string CuVisits = "ApplyARDoughnutChart('" + XAxis.ToString() + "' , '" + YAxis.ToString() + "'); ";
            ViewState["Chart"] += CuVisits;
        }
        public void InventoryReconfirmation()
        {
            DataTable dt=new DataTable();
            dt = LoadData("SelInventoryandVantoVan");
            lblreconfirmation.Text= dt.Rows[0]["InvRecCount"].ToString();
            lbltrnIn.Text= dt.Rows[0]["TransIn"].ToString();
            lbltrnIn.Text = dt.Rows[0]["TransOut"].ToString();
        }
        public void AssetRemovalRequest()
        {
            try
            {
                //DataTable lstAssetRemoval = ObjclsFrms.loadList("SelectAssetRemovingRequestCount", "sp_ServiceDashboard");
                DataTable lstAssetRemoval = new DataTable();
                lstAssetRemoval=  LoadData("SelectAssetRemovingRequestCount");
                string AssetsRemovalReq = lstAssetRemoval.Rows[0]["number"].ToString();
                lblAssetRemovalRequest.Text = AssetsRemovalReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void AssetAddingRequest()
        {
            try
            {
                //DataTable lstAssetAdding = ObjclsFrms.loadList("SelectAssetAddingRequestCount", "sp_ServiceDashboard");
                DataTable lstAssetAdding = new DataTable();
                lstAssetAdding = LoadData("SelectAssetAddingRequestCount");
                string AssetsAddingReq = lstAssetAdding.Rows[0]["number"].ToString();
                lblAssetAddingRequest.Text = AssetsAddingReq.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void AssetTrackingCount(string fromDate)
        {
            try
            {
                //DataTable lstAssetTracking = ObjclsFrms.loadList("SelectTotalAssetCount", "sp_ServiceDashboard", fromDate);
                DataTable lstAssetTracking = new DataTable();
                lstAssetTracking = LoadData("SelectTotalAssetCount");
                string Visited = lstAssetTracking.Rows[0]["TotalVisited"].ToString();
                string Tracked = lstAssetTracking.Rows[0]["Tracked"].ToString();
                string NotTracked = lstAssetTracking.Rows[0]["NotTracked"].ToString();

                
                lblAssetVisited.Text = Visited.ToString();
                lblAssetTracked.Text = Tracked.ToString();
                lblAssetNotTracked.Text = NotTracked.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void ServiceRequestCount()
        {
            try
            {
                //DataTable lstServiceRequest = ObjclsFrms.loadList("SelectServiceRequestCount", "sp_ServiceDashboard");
                DataTable lstServiceRequest = new DataTable();
                lstServiceRequest = LoadData("SelectServiceRequestCount");
                string TotalServiceReq = lstServiceRequest.Rows[0]["CreatedServiceRequest"].ToString();
                string Created = lstServiceRequest.Rows[0]["ActionTakenServiceRequest"].ToString();

                lblOpenServiceReqCount.Text = TotalServiceReq.ToString();
                lblCompReqCount.Text = Created.ToString();
            }
            catch (Exception ex)
            {

            }
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Session["KPIRoute"] = null;
            Session["KPIDate"] = null;
            Session["KPIDate"] = rdfromDate.SelectedDate.ToString();
            ViewState["Chart"] = null;
            rdRoute.Text = "";
            rdRoute.SelectedValue = "";
            Route("");
            pnlstartmessage.Visible = true;
            pnlVisit.Visible = false;
            pnlTarget.Visible = false;
            pnlDel.Visible = false;
            pnlSale.Visible = false;
            pnlAR.Visible = false;
            pnlAdv.Visible = false;
            pnlOrder.Visible = false;
            pnlAROrder.Visible = false;
            pnlload.Visible = false;
            pnlTimeline.Visible = false;
            pnlSettlement.Visible = false;
            pnlsalechart.Visible = false;
            pnlInvoices.Visible = false;
            pnlinventoryReconfirmation.Visible = false;
            pnlAssetTrackingandServiceReq.Visible = false;
            ddlRotType.ClearSelection();
        }

        protected void ddlRotType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rdRoute.ClearSelection();
            Route("");
        }

        protected void lnkOutstanding_Click(object sender, EventArgs e)
        {
            Session["KPIRoute"] = rdRoute.SelectedValue.ToString();
            Response.Redirect("OutstandingDashboard.aspx");
        }

        protected void lnkAR_Click(object sender, EventArgs e)
        {

        }
    }

}
