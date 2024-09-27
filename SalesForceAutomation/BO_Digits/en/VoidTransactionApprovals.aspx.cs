using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VoidTransactionApprovals : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {


                    if (Session["VtaFromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["VtaFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    }
                    if (Session["VtaTODate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["VtaTODate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now; ;
                    }

                    Route();
                    RouteFromTransaction();
                }
                catch (Exception ex)
                {

                }
            }

        }

        public void RouteFromTransaction()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in rdRoute.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public void Route()
        {
            string[] arr = {  };
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforVoidTransactions", "sp_AppServices", UICommon.GetCurrentUserID().ToString(), arr);
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
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
                return "vta_rot_ID";
            }
        }

        public string mainConditions(string rotID)
        {
            string Statuses = ddlStatus.SelectedValue.ToString();
            string customerCondition = "";
            string dateCondition = "";
            string Statuscondition = "";
            string mainCondition = " and vta_rot_ID in (" + rotID + ")";
            string userID = UICommon.GetCurrentUserID().ToString();

            try
            {


                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                if (Statuses != "A")
                {
                    Statuscondition = " and vta_TYpe='"+ Statuses + "' ";
                }
                

                
                dateCondition = dateCondition +" and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";


                


            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += customerCondition;
            mainCondition += Statuscondition;
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
                string[] arr = { mainCondition };
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                lstUser = ObjclsFrms.loadList("SelVoidTransactions", "sp_AppServices", endDate, arr);
                grvRpt.DataSource = lstUser;
            }
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Approve"))
            {
                
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("vta_ID").ToString();
                ViewState["TRNNumber"] = dataItem["vta_trn_Number"].Text.Trim();
                string udpID = dataItem["vta_udp_id"].Text.Trim();
                ViewState["udpId"] = udpID;
                ViewState["VoidType"] = dataItem["vta_Type"].Text.Trim();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('" + ID + "');</script>", false);
            }
            else if (e.CommandName.Equals("Reject"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("vta_ID").ToString();
                ViewState["TRNNumber"] = dataItem["vta_trn_Number"].Text.Trim();
                ViewState["udpId"] = dataItem["vta_udp_id"].Text.Trim();
                ViewState["VoidType"] = dataItem["vta_Type"].Text.Trim();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ConfimReject('" + ID + "');</script>", false);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                
            }
        }



        protected void lnkFilter_Click(object sender, EventArgs e)
        {

            if (Session["VtaFromDate"] != null)
            {
                string fromdate = rdfromDate.SelectedDate.ToString();
                if (fromdate == Session["VtaFromDate"].ToString())
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["VtaFromDate"].ToString());
                }
                else
                {
                    Session["VtaFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
            }
            else
            {
                rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                Session["VtaFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

            }
            // rdfromDate.MaxDate = DateTime.Now;

            if (Session["VtaTODate"] != null)
            {
                string todate = rdendDate.SelectedDate.ToString();
                if (todate == Session["VtaTODate"].ToString())
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["VtaTODate"].ToString());
                }
                else
                {
                    Session["VtaTODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }

            }
            else
            {
                rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                Session["VtaTODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
            }
            LoadList();
            grvRpt.Rebind();
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

        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            string trnNumber = ViewState["TRNNumber"].ToString();
            string type = ViewState["VoidType"].ToString();
            string udpid, user;
            udpid = ViewState["udpId"].ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { udpid.ToString(), trnNumber,type };
            DataTable lstClaim = ObjclsFrms.loadList("InsVoidApproval", "sp_AppServices", user.ToString(), arr);
            if (lstClaim.Rows.Count > 0)
            {
                if (lstClaim.Rows[0]["res"].ToString() == "1")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SuccessModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }

            }
            
        }

        protected void lnkreject_Click(object sender, EventArgs e)
        {
            string trnNumber = ViewState["TRNNumber"].ToString();
            string type = ViewState["VoidType"].ToString();
            string udpid, user;
            udpid = ViewState["udpId"].ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { udpid.ToString(), trnNumber, type };
            DataTable lstClaim = ObjclsFrms.loadList("InsVoidReject", "sp_AppServices", user.ToString(), arr);
            if (lstClaim.Rows.Count > 0)
            {
                if (lstClaim.Rows[0]["res"].ToString() == "1")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>SuccessModalReject();</script>", false);

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("VoidTransactionApprovals.aspx");
        }
    }
}