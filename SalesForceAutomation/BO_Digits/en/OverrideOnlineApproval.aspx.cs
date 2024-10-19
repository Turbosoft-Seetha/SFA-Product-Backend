using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.PivotGrid.Core.Filtering;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OverrideOnlineApproval : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {


                    if (Session["OOAFromDate"] != null)
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(Session["OOAFromDate"].ToString());
                    }
                    else
                    {
                        rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                    }
                    if (Session["OOATODate"] != null)
                    {
                        rdendDate.SelectedDate = DateTime.Parse(Session["OOATODate"].ToString());
                    }
                    else
                    {
                        rdendDate.SelectedDate = DateTime.Now; ;
                    }

                    Route();
                    if (Session["OOARoute"] != null)
                    {
                        string rout = Session["OOARoute"].ToString();
                        string[] routes = rout.Split(',');

                        foreach (RadComboBoxItem itmss in rdRoute.Items)
                        {
                            if (routes.Contains(itmss.Value))
                            {
                                itmss.Checked = true;
                            }
                            else
                            {
                                itmss.Checked = false;
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
                    }

                    if (Session["OOAType"] != null)
                    {
                        ddlType.SelectedValue = Session["OOAType"].ToString();
                    }
                    else
                    {
                        ddlType.SelectedValue = "AL";
                    }

                    if (Session["OOAStatus"] != null)
                    {
                        ddlStatus.SelectedValue = Session["OOAStatus"].ToString();
                    }
                    else
                    {
                        ddlStatus.SelectedValue = "P";
                    }

                }
                catch (Exception ex)
                {

                }
            }

        }
        public void Route()
        {
            string[] arr = { rdendDate.SelectedDate.ToString()};
            rdRoute.DataSource = ObjclsFrms.loadList("SelRoutes", "sp_OverrideOnline", rdfromDate.SelectedDate.ToString(), arr);
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
                return "ooa_rot_ID";
            }
        }

        public string mainConditions(string rotID)
        {
            string Status = ddlStatus.SelectedValue.ToString();
            string Type = ddlType.SelectedValue.ToString();            
            string dateCondition = "";
            string Statuscondition = "";
            string Typecondition = "";
            string usercondition = "";
            string mainCondition = " and ooa_rot_ID in (" + rotID + ")";
            string userID = UICommon.GetCurrentUserID().ToString();

            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");

                if (Status == "P")
                {
                    Statuscondition = " and isnull(ooa_ApprovalStatus,'P') = 'P'";
                }
                else if (Status == "A")
                {
                    Statuscondition = " and isnull(ooa_ApprovalStatus,'P') = 'A' ";
                }
                else if (Status == "R")
                {
                    Statuscondition = " and isnull(ooa_ApprovalStatus,'P') = 'R' ";
                }
                else
                {
                    Statuscondition = "";
                }

                if (Type == "GF")
                {
                    Typecondition = " and ooa_Type = 'Geo Fencing'";
                }
                else if (Type == "BS")
                {
                    Typecondition = " and ooa_Type = 'Barcode Scanning' ";
                }
                else if (Type == "MS")
                {
                    Typecondition = " and ooa_Type = 'Manual Selection' ";
                }
                else if (Type == "CL")
                {
                    Typecondition = " and ooa_Type = 'Credit Limit Amount' ";
                }
                else if (Type == "CD")
                {
                    Typecondition = " and ooa_Type = 'Credit Days' ";
                }
                else if (Type == "VO")
                {
                    Typecondition = " and ooa_Type = 'Void' ";
                }
                else if (Type == "UN")
                {
                    Typecondition = " and ooa_Type = 'UnSchedule' ";
                }
                else
                {
                    Typecondition = "";
                }

                dateCondition = dateCondition + " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                usercondition = " and isnull(A.ModifiedBy,'') <> " + userID;
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            mainCondition += Statuscondition;
            mainCondition += Typecondition;
            mainCondition += usercondition;
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
                lstUser = ObjclsFrms.loadList("ListOverrideOnlineHeader", "sp_OverrideOnline", mainCondition);
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
                string ID = dataItem.GetDataKeyValue("ooa_ID").ToString();
                ViewState["ooa_TransID"] = dataItem["ooa_TransID"].Text.Trim();
                ViewState["ooa_Type"] = dataItem["ooa_Type"].Text.Trim();
                DataTable lstApprovalLevel = ObjclsFrms.loadList("SelectUserLevel", "sp_OverrideOnline", UICommon.GetCurrentUserID().ToString());
                if (lstApprovalLevel.Rows.Count > 0)
                {
                    int currentLevel, nextLevel;
                    currentLevel = Int32.Parse(lstApprovalLevel.Rows[0]["CurrentLevel"].ToString());
                    nextLevel = Int32.Parse(lstApprovalLevel.Rows[0]["NextLevel"].ToString());
                    ViewState["currentLevel"] = currentLevel.ToString();
                    ViewState["nextLevel"] = nextLevel.ToString();

                    DataTable lstDetail = ObjclsFrms.loadList("SelectTypeDetail", "sp_OverrideOnline", ViewState["ooa_TransID"].ToString());
                    string details = string.Empty;
                    string transIDHeading = "<h5>Trans. ID: <b>" + lstDetail.Rows[0]["ooa_TransID"].ToString() + "</b></h5>";

                    if (ViewState["ooa_Type"].ToString() == "Credit Limit Amount")
                    {
                        details = transIDHeading +
                                  "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                                  "Total Inv. Amount: <b>" + lstDetail.Rows[0]["TotInvAmt"].ToString() + "</b><br/>" +
                                  "Available CR Limit: <b>" + lstDetail.Rows[0]["AvlCrLimit"].ToString() + "</b><br/>" +
                                  "Total CR Limit: <b>" + lstDetail.Rows[0]["TotCrLimit"].ToString() + "</b><br/>" +
                                  "Total Outstanding: <b>" + lstDetail.Rows[0]["TotOutstnd"].ToString() + "</b><br/>" +
                                  "Total CR Days: <b>" + lstDetail.Rows[0]["TotCrDays"].ToString() + "</b>";
                     
                    }
                    else if (ViewState["ooa_Type"].ToString() == "Credit Days")
                    {
                        details = transIDHeading +
                                  "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                                  "Total Inv. Amount: <b>" + lstDetail.Rows[0]["TotInvAmt"].ToString() + "</b><br/>" +
                                  "Available CR Limit: <b>" + lstDetail.Rows[0]["AvlCrLimit"].ToString() + "</b><br/>" +
                                  "Total CR Limit: <b>" + lstDetail.Rows[0]["TotCrLimit"].ToString() + "</b><br/>" +
                                  "Total Outstanding: <b>" + lstDetail.Rows[0]["TotOutstnd"].ToString() + "</b><br/>" +
                                  "Total CR Days: <b>" + lstDetail.Rows[0]["TotCrDays"].ToString() + "</b>";
                    }
                    else if (ViewState["ooa_Type"].ToString() == "Fencing Radius")
                    {
                        details = transIDHeading +
                                  "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                                  "Fencing Radius: <b>" + lstDetail.Rows[0]["FencingRadius"].ToString() + "</b><br/>" +
                                  "Difference to Fencing Area: <b>" + lstDetail.Rows[0]["Difference"].ToString() + "</b>";
                    }
                    else
                    {
                        details = "";
                    }

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showDetails", $"showDetailsModal('{details}');", true);

                    if (nextLevel == 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "Confim2('You are the final approver, Do you want to continue?');", true);
                    }
                    else if (nextLevel > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "Confim2('The Approval request will go to the next level user, Do you want to continue?');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "failedModal();", true);
                    }
                }
            }

            else if (e.CommandName.Equals("Reject"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ooa_ID").ToString();
                ViewState["ooa_TransID"] = dataItem["ooa_TransID"].Text.Trim();
                ViewState["ooa_Type"] = dataItem["ooa_Type"].Text.Trim();

                DataTable lstDetail = ObjclsFrms.loadList("SelectTypeDetail", "sp_OverrideOnline", ViewState["ooa_TransID"].ToString());
                string details = string.Empty;
                string transIDHeading = "<h5>Trans. ID: <b>" + lstDetail.Rows[0]["ooa_TransID"].ToString() + "</b></h5>";

                if (ViewState["ooa_Type"].ToString() == "Credit Limit Amount")
                {
                    details = transIDHeading +
                              "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                              "Credit Limit: <b>" + lstDetail.Rows[0]["CreditLimit"].ToString() + "</b><br/>" +
                              "Available Limit: <b>" + lstDetail.Rows[0]["AvailableLimit"].ToString() + "</b><br/>" +
                              "Total Limit: <b>" + lstDetail.Rows[0]["TotalLimit"].ToString() + "</b>";
                }
                else if (ViewState["ooa_Type"].ToString() == "Credit Days")
                {
                    details = transIDHeading +
                              "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                              "Credit Days: <b>" + lstDetail.Rows[0]["CreditDays"].ToString() + "</b><br/>" +
                              "Available Days: <b>" + lstDetail.Rows[0]["AvailableDays"].ToString() + "</b>";
                }
                else if (ViewState["ooa_Type"].ToString() == "Fencing Radius")
                {
                    details = transIDHeading +
                              "Override Type: <b>" + lstDetail.Rows[0]["Type"].ToString() + "</b><br/>" +
                              "Fencing Radius: <b>" + lstDetail.Rows[0]["FencingRadius"].ToString() + "</b><br/>" +
                              "Difference to Fencing Area: <b>" + lstDetail.Rows[0]["Difference"].ToString() + "</b>";
                }
                else
                {
                    details = "";
                }

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showDetails", $"showDetailsModalRej('{details}');", true);                
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "Confim3('Selected Request will be rejected, do you want to continue?');", true);
                
            }
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string approvalStatus = item["ooa_ApprovalStatus"].Text.Trim();

                LinkButton btnApprove = (LinkButton)item.FindControl("lnkApprove");
                LinkButton btnReject = (LinkButton)item.FindControl("lnkReject");

                if (approvalStatus == "Pending")
                {
                    btnApprove.Visible = true;
                    btnReject.Visible = true;
                }
                else
                {
                    btnApprove.Visible = false;
                    btnReject.Visible = false;
                }
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {

            if (Session["OOAFromDate"] != null)
            {
                string fromdate = rdfromDate.SelectedDate.ToString();
                if (fromdate == Session["OOAFromDate"].ToString())
                {
                    rdfromDate.SelectedDate = DateTime.Parse(Session["OOAFromDate"].ToString());
                }
                else
                {
                    Session["OOAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                }
            }
            else
            {
                rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
                Session["OOAFromDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

            }           

            if (Session["OOATODate"] != null)
            {
                string todate = rdendDate.SelectedDate.ToString();
                if (todate == Session["OOATODate"].ToString())
                {
                    rdendDate.SelectedDate = DateTime.Parse(Session["OOATODate"].ToString());
                }
                else
                {
                    Session["OOATODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
                }

            }
            else
            {
                rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
                Session["OOATODate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
            }

            if (Session["OOARoute"] != null)
            {
                string route = Rot();
                if (route == Session["OOARoute"].ToString())
                {
                    string rotID = Rot();

                }
                else
                {
                    string rotID = Rot();
                    Session["OOARoute"] = rotID;
                }

            }
            else
            {
                string rotID = Rot();
                Session["OOARoute"] = rotID;
            }

            Session["OOAType"]=ddlType.SelectedValue;
            Session["OOAStatus"] = ddlStatus.SelectedValue;

            LoadList();
            grvRpt.Rebind();
        }     
       
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("OverrideOnlineApproval.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {            
            string trnNumber = ViewState["ooa_TransID"].ToString(); 
            string user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { user, ViewState["nextLevel"].ToString() };
            DataTable lstClaim = ObjclsFrms.loadList("ApproveOverride", "sp_OverrideOnline", trnNumber, arr);
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

        protected void RejectSave_Click(object sender, EventArgs e)
        {
            string trnNumber = ViewState["ooa_TransID"].ToString();
            string user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { user };
            DataTable lstClaim = ObjclsFrms.loadList("RejectOverride", "sp_OverrideOnline", trnNumber, arr);
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
    }
}