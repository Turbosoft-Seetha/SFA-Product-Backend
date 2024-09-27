using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Ecosoft.DAL;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Configuration;
using Telerik.Web.UI;
using System.Xml;
using System.IO;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteNotificationDetail : System.Web.UI.Page
    {
        
        GeneralFunctions objdel = new GeneralFunctions();
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
            HeaderData();
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = objdel.loadList("SelUserNotificationByID", "sp_Notifications", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];

                Label Mode = (Label)rp.FindControl("Mode");
                Label User = (Label)rp.FindControl("User");
                Label CreatedDate = (Label)rp.FindControl("CreatedDate");
                
               // rp.Text = "Delivery No: " + lstDatas.Rows[0]["dln_DeliveryNumber"].ToString();
                Mode.Text = lstDatas.Rows[0]["Mode"].ToString();
                User.Text = lstDatas.Rows[0]["User"].ToString();
                CreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();

                if (Mode.Text == "SFA")
                {
                    pnlUser.Visible = false;
                }
                else
                {
                    pnlUser.Visible = true;
                }
                                
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = objdel.loadList("SelUserNotificationDetail", "sp_Notifications", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
    }
}