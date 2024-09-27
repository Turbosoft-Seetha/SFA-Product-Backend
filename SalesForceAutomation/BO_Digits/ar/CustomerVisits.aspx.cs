using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class CustomerVisits : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();


        public string Mode
        {
            get
            {
                string Mode;
                Mode = (Request.Params["mode"]);


                return Mode;
            }
        }
        public int CusID
        {
            get
            {
                int CusID;
                int.TryParse(Request.Params["cusID"], out CusID);

                return CusID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                if (Session["FromDate"] != null)
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["FromDate"].ToString());
                }
                if (Session["rdRoute"] != null)
                {
                    rdRoute.SelectedValue = Session["rdRoute"].ToString();
                }


                rdfromDate.MaxDate = DateTime.Now;

                if (Mode == "pl")
                {
                    PlannedVisitData();
                    PlannedCount();
                }
                if (Mode == "act")
                {
                    ActualVisitData();
                    ActualCount();
                }
                if (Mode == "prd")
                {
                    ProductiveVisitData();
                    ProductiveCount();
                }
                if (Mode == "nprd")
                {
                    NonProductiveVisitData();
                    NonProductiveCount();
                }
                initialClick();
            }
        }
        public void initialClick()
        {
            if (ViewState["rowID"] != null)
            {
                DataTable lstDatas = new DataTable();
                string rowid = ViewState["rowID"].ToString();
                lstDatas = ObjclsFrms.loadList("SelCusStartExitTime", "sp_CusVisit_Detail", rowid);
                if (lstDatas.Rows.Count > 0)
                {
                    lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                    lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();

                    if (rptCusVisit.Items.Count > 0)
                    {
                        // int c = rpt.Items.Count;

                        foreach (RepeaterItem ri in rptCusVisit.Items)
                        {
                            LinkButton btnAll = ri.FindControl("btncusvisit") as LinkButton;
                            Panel rowPanelAll = (Panel)btnAll.FindControl("rowpanel");
                            rowPanelAll.BackColor = Color.AliceBlue;
                            break;
                        }
                    }
                }
            }
        }
        public void PlannedVisitData()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelPlannedDetail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {
                lblCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                lblgridCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblGridCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                //lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                ViewState["rowID"] = lstDatas.Rows[0]["cse_ID"].ToString();
                //lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                //lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                rptCusVisit.DataSource = lstDatas;
                rptCusVisit.DataBind();
            }
        }
        public void ActualVisitData()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelActualDetail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {


                lblCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                lblgridCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblGridCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                // lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                ViewState["rowID"] = lstDatas.Rows[0]["cse_ID"].ToString();
                //lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                //lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                rptCusVisit.DataSource = lstDatas;
                rptCusVisit.DataBind();
            }
        }
        public void ProductiveVisitData()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelProductiveDetail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);

            if (lstDatas.Rows.Count > 0)
            {

                lblCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                lblgridCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblGridCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                ViewState["rowID"] = lstDatas.Rows[0]["cse_ID"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                //lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                //lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                rptCusVisit.DataSource = lstDatas;
                rptCusVisit.DataBind();
            }
        }
        public void NonProductiveVisitData()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelNonProductiveDetail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {

                lblCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                lblgridCusCode.Text = lstDatas.Rows[0]["cus_Code"].ToString();
                lblGridCusName.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                ViewState["rowID"] = lstDatas.Rows[0]["cse_ID"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                //lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                //lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                rptCusVisit.DataSource = lstDatas;
                rptCusVisit.DataBind();
            }
        }
        public void PlannedCount()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("PlannedCount", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {

                lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
            }
        }
        public void ActualCount()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ActualCount", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {

                lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
            }
        }
        public void ProductiveCount()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ProductiveCount", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {

                lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
            }

        }
        public void NonProductiveCount()
        {
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString() };
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("NonProductiveCount", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {

                lblCusVisitCount.Text = lstDatas.Rows[0]["visits"].ToString();
            }

        }

        public void Route()
        {
            string user = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("SelRoutes", "sp_KPI_Dashboard", user);
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "RouteName";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {


            if (Mode == "pl")
            {
                PlannedVisitData();
                PlannedCount();
            }
            if (Mode == "act")
            {
                ActualVisitData();
                ActualCount();
            }
            if (Mode == "prd")
            {
                ProductiveVisitData();
                ProductiveCount();
            }
            if (Mode == "nprd")
            {
                NonProductiveVisitData();
                NonProductiveCount();
            }
            grvRptAdvance.Rebind();
            grvRptAR.Rebind();
            grvRptOrder.Rebind();
            grvRptSales.Rebind();

            foreach (RepeaterItem ri in rptCusVisit.Items)
            {
                LinkButton btnAll = ri.FindControl("btncusvisit") as LinkButton;
                Panel rowPanelAll = (Panel)btnAll.FindControl("rowpanel");
                rowPanelAll.BackColor = Color.White;
            }


            initialClick();

        }
        protected void rptCusVisit_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "itemClick")
            {


                foreach (RepeaterItem ri in rptCusVisit.Items)
                {
                    LinkButton btnAll = ri.FindControl("btncusvisit") as LinkButton;
                    Panel rowPanelAll = (Panel)btnAll.FindControl("rowpanel");
                    rowPanelAll.BackColor = Color.White;
                }

                LinkButton btn = e.CommandSource as LinkButton;
                Panel rowPanel = (Panel)btn.FindControl("rowpanel");


                string cseID = btn.CommandArgument.ToString();
                ViewState["cseID"] = cseID.ToString();

                string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString(), cseID.ToString() };

                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("SelHeaderStartExitTime", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
                if (lstDatas.Rows.Count > 0)
                {
                    lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                    lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                    lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();

                }

                rowPanel.BackColor = Color.AliceBlue;

                grvRptAdvance.Rebind();
                grvRptAR.Rebind();
                grvRptOrder.Rebind();
                grvRptSales.Rebind();

            }

        }
        public void LoadListSales()

        {
            string cseID;
            if (ViewState["cseID"] != null)
            {
                cseID = ViewState["cseID"].ToString();

            }
            else
            {
                cseID = ViewState["rowID"].ToString();
            }
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string[] ar = { fromDate, CusID.ToString(), cseID };

            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectSales_Detail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            grvRptSales.DataSource = lstUser;
        }
        public void LoadListAR()
        {
            string cseID;
            if (ViewState["cseID"] != null)
            {
                cseID = ViewState["cseID"].ToString();

            }
            else
            {
                cseID = ViewState["rowID"].ToString();
            }
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString(), cseID };

            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectAR_Detail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            grvRptAR.DataSource = lstUser;
        }

        public void LoadListAdvance()
        {
            string cseID;
            if (ViewState["cseID"] != null)
            {
                cseID = ViewState["cseID"].ToString();

            }
            else
            {
                cseID = ViewState["rowID"].ToString();
            }
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString(), cseID };

            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectAdvPayment_Detail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            grvRptAdvance.DataSource = lstUser;
        }
        public void LoadListOrder()
        {

            string cseID;
            if (ViewState["cseID"] != null)
            {
                cseID = ViewState["cseID"].ToString();

            }
            else
            {
                cseID = ViewState["rowID"].ToString();
            }
            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString(), cseID };

            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectOrder_Detail", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            grvRptOrder.DataSource = lstUser;
        }

        protected void grvRptSales_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadListSales();
        }

        protected void grvRptOrder_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadListOrder();
        }

        protected void grvRptAR_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadListAR();
        }

        protected void grvRptAdvance_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadListAdvance();
        }

        protected void rptCusVisit_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            //HtmlTableCell cell = e.Item.FindControl("selectedrow") as HtmlTableCell;
            //cell.BgColor = "Red";
        }

        protected void btncusvisit_Click(object sender, EventArgs e)
        {

            //HtmlTableRow row = ((sender as LinkButton).NamingContainer.FindControl("row") as HtmlTableRow);
            //row.Attributes["style"] = "background-color:red";
            LinkButton btn = (LinkButton)sender;
            Panel rowPanel = (Panel)btn.FindControl("rowpanel");
            Label lblTime = (Label)btn.FindControl("lblVisitTime");

            lblTime.Text = "Changed";

            //rowPanel.BackColor = Color.AliceBlue;
            rowPanel.Style.Add("background-color", "Red");

            rowPanel.Visible = false;

            string cseID = btn.CommandArgument.ToString();
            ViewState["cseID"] = cseID.ToString();
            // btn.Attributes.Add("BackColor", "AliceBlue");

            string[] ar = { DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), CusID.ToString(), cseID.ToString() };

            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelHeaderStartExitTime", "sp_CusVisit_Detail", rdRoute.SelectedValue.ToString(), ar);
            if (lstDatas.Rows.Count > 0)
            {
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblCusStart.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                lblCusExit.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
            }
            if (Mode == "pl")
            {
                PlannedVisitData();
                PlannedCount();
            }
            if (Mode == "act")
            {
                ActualVisitData();
                ActualCount();
            }
            if (Mode == "prd")
            {
                ProductiveVisitData();
                ProductiveCount();
            }
            if (Mode == "nprd")
            {
                NonProductiveVisitData();
                NonProductiveCount();
            }

            grvRptAdvance.Rebind();
            grvRptAR.Rebind();
            grvRptOrder.Rebind();
            grvRptSales.Rebind();
        }


    }
}