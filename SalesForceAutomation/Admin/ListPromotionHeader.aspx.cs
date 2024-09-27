using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListPromotionHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
             
            }
        }

       
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectPromotionHeader", "sp_Web_Promotion");
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prm_ID").ToString();
                Response.Redirect("ListPromotionRange.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prm_ID").ToString();
                Response.Redirect("AddEditPromotionHeader.aspx?Id=" + ID);
               
            }
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPromotionHeader.aspx?Id=0");
        }
    }
}