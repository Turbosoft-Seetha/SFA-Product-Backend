using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListQualificationHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListQualificationDetail.aspx?Id=0");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectQalificationHeader", "sp_Web_Promotion");
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("qlh_ID").ToString();
                Response.Redirect("ListQualificationDetail.aspx?Id=" + ID);
            }
            //if (e.CommandName.Equals("Edit"))
            //{
            //    GridDataItem dataItem = e.Item as GridDataItem;
            //    string ID = dataItem.GetDataKeyValue("qlh_ID").ToString();
            //    Response.Redirect("AddEditQualificationHeader.aspx?Id=" + ID);
            //}
        }
    }
}