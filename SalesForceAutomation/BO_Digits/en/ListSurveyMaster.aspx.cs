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
    public partial class ListSurveyMaster : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = Obj.loadList("ListSurveyMaster", "sp_Merchandising");
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }

        protected void lnkAddQuestions_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditSurveyMaster.aspx");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("srm_ID").ToString();
                Response.Redirect("AddEditSurveyMaster.aspx?Id=" + ID);
            }
            else if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("srm_ID").ToString();
                Response.Redirect("AddSurveyDetail.aspx?Id=" + ID);
            }
            else if (e.CommandName.Equals("Customer"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("srm_ID").ToString();
                Response.Redirect("AddSurveyCustomerRoute.aspx?Id=" + ID);
            }
        }
    }
}