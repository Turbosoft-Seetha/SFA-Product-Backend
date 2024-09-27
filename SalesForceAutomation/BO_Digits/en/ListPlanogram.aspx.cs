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
    public partial class ListPlanogram : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPlanogram", "sp_MerchandisingWebServices");
            grvRpt.DataSource = lstUser;
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPlanogram.aspx?Id=0");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("plg_ID").ToString();
                Response.Redirect("AddEditPlanogram.aspx?Id=" + ID);
            }
            if (e.CommandName.Equals("CusAssigned"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string PID = dataItem.GetDataKeyValue("plg_ID").ToString();
                //string ID = dataItem["plg_rot_ID"].Text.ToString();
                //string ID = dataItem.GetDataKeyValue("plg_rot_ID").ToString();
                string ID = dataItem["plg_rot_ID"].Text.ToString();
                Response.Redirect("PlanogramCustomerMapping.aspx?PID=" + PID + "&RID=" + ID);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            //if (e.Item is GridDataItem)
            //{
            //    GridDataItem item = (GridDataItem)e.Item;


            //    HyperLink imgg1 = (HyperLink)item.FindControl("img");
            //    string att1 = imgg1.NavigateUrl.ToString();


            //    Image itmImage = (Image)item.FindControl("itmImage");
            //    string url1 = itmImage.ImageUrl.ToString();

            //    //Image salRecieptImage = (Image)item.FindControl("salRecieptImage");
            //    //string url2 = salRecieptImage.ImageUrl.ToString();



            //    if (att1.Equals("../"))
            //    {

            //        imgg1.NavigateUrl = "";
            //        itmImage.ImageUrl = "../assets/media/icons/imagenotavailable.png";


            //    }


            //}
        }
    }
}