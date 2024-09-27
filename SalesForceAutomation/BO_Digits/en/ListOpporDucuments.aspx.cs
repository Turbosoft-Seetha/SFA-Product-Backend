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
    public partial class ListOpporDucuments : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int OppID
        {
            get
            {
                int OppID;
                int.TryParse(Request.Params["Id"], out OppID);

                return OppID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //OppID();
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListCusDocumentsHeaderByID", "sp_Masters_UOM", OppID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblDate = (Label)rp.FindControl("lblDate");
                Label lblOpp = (Label)rp.FindControl("lblOpp");

                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                lblOpp.Text = lstDatas.Rows[0]["opt_Name"].ToString();
               
            }
        }
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("CusDocuments", "sp_Masters_UOM", OppID.ToString());

            grvRpt.DataSource = lstUser;

        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
    }
}