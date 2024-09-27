using Stimulsoft.Base.Serializing;
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
    public partial class ListRouteOfCustomer : System.Web.UI.Page
    {
       
            GeneralFunctions obj = new GeneralFunctions();


            public int ResponseID
            {
                get
                {
                    int ResponseID;
                    int.TryParse(Request.Params["cid"], out ResponseID);

                    return ResponseID;
                }
            }
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {

                }
            }
            public void List()
            {
                DataTable lstUser = default(DataTable);
                lstUser = obj.loadList("ListRouteOfCustomer", "sp_Masters",ResponseID.ToString());
                grvRpt.DataSource = lstUser;
                DataTable lst = default(DataTable);
                lst = obj.loadList("CustomerBYid", "sp_Masters", ResponseID.ToString());
                lblcuscode.Text = lst.Rows[0]["cus_Code"].ToString();
                lblcustomer.Text = lst.Rows[0]["cus_Name"].ToString();
            }
        
           

            protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
            {
                List();
            }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edits"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string RotID = dataItem.GetDataKeyValue("rot_ID").ToString();
                string CusID = dataItem["rcs_ID"].Text;
                Response.Redirect("AddEditCusRoute.aspx?cid=" +CusID+ "&RID=" +RotID);                
            }
        }
    }

 }