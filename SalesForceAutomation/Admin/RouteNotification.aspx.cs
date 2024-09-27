using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class RouteNotification : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                rdFromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                rdEndDate.SelectedDate = DateTime.Now;
                RouteFromTransaction();
                string rotID = Rot();
                string routeCondition = "rnt_rot_ID in (" + rotID + ")";
               
                
               
               
            }
        }
        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
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
        
        public string mainConditions(string rotID)
        {                        
            string dateCondition = "";
            String flag="";
            if(ddlreadflag.SelectedValue.ToString()=="R")
            {
                flag = " (rnt_ReadFlag='y' and rnt_ReplyMessage is null) ";
            }
            else if (ddlreadflag.SelectedValue.ToString()=="RP")
            {
                flag = " (rnt_ReadFlag='y' and rnt_ReplyMessage is not null) ";
            }
            else if(ddlreadflag.SelectedValue.ToString()=="S")
            {
                flag = " (rnt_ReadFlag='N' and rnt_ReplyMessage is null) ";
            }
            else { flag = " (rnt_ReadFlag='y' or rnt_ReadFlag='N') "; }
            string mainCondition = " rnt_rot_ID in (" + rotID + ") and ";
            mainCondition += flag;
           
            try
            {
                string fromDate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(N.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
               
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            
            return mainCondition;
        }
        public void LoadList()
        {
            string rotID = Rot();
            
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);

                DataTable lstUser = ObjclsFrms.loadList("ListRouteNotifications", "sp_Merchandising", mainCondition.ToString());
                
                    grvRpt.DataSource = lstUser;
                
            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            //if (e.CommandName.Equals("Edit"))
            //{
            //    GridDataItem dataItem = e.Item as GridDataItem;
            //    string ID = dataItem.GetDataKeyValue("rnt_ID").ToString();
            //    Response.Redirect("AddEditRouteNotification.aspx?Id=" + ID);
            //}
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("rnt_ID").ToString();
                ViewState["delID"] = ID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditRouteNotification.aspx?Id=0");
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteRouteNotification", "sp_Masters_UOM", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                ImageButton DelBtn = (ImageButton)item.FindControl("Deletebtn");
                if ((item["rnt_ReadFlag"].Text == "Read") || (item["rnt_ReadFlag"].Text == "Replied"))
                {
                    DelBtn.Visible = false;
                }
                else
                {
                    DelBtn.Visible = true;
                }
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.Rebind();
        }
    }
}