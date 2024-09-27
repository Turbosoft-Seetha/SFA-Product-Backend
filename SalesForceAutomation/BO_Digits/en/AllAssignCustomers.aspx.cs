using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AllAssignCustomers : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            string condition = mainConditions();
            string[] arr = { condition.ToString() };

            lstUser = ObjclsFrms.loadList("SelectAllAssignedCustomer", "sp_Merchandising", ResponseID.ToString(), arr);
            grvRpt.DataSource = lstUser;

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForFiltering", "sp_Merchandising");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
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
                return "crs_rot_ID";
            }
        }
        protected void Apply_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.DataBind();
        }
        public string mainConditions()
        {
            string mainCondition = "";
            string rotID = Rot();
            mainCondition = " crs_rot_ID in (" + rotID + ")";
            
            return mainCondition;
        }
    }
}