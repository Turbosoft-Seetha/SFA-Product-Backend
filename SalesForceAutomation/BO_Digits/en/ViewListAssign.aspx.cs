using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Table = Telerik.Windows.Documents.Flow.Model.Table;
using TableCell = Telerik.Windows.Documents.Flow.Model.TableCell;
using TableRow = Telerik.Windows.Documents.Flow.Model.TableRow;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewListAssign : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                PMG();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public void PMG()
        {
            DataTable dt = obj.loadList("SelectPMGname", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string name = dt.Rows[0]["pmg_Name"].ToString();
                sp.Text = "Product Mapping Group  : " + name;
            }

        }
        public void Route()
        {
            DataTable dt = obj.loadList("SelRoute", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void List()
        {
            string rot = ddlRoute.SelectedValue.ToString();
            string[] arr = { ResponseID.ToString() };
            if (!rot.Equals(""))
            {
                DataTable lstdata = default(DataTable);
                lstdata = obj.loadList("AssignedCusPMG", "sp_Masters", rot, arr);
                if(lstdata.Rows.Count>=0)
                { 
                grvRpt.DataSource = lstdata;
                }

            }

        }
        public void Loaddata()
        {

            string rot = ddlRoute.SelectedValue.ToString();
            if (!rot.Equals(""))
            {
                DataTable lstuser = default(DataTable);
                lstuser = obj.loadList("UnAssignedCusPMG", "sp_Masters", rot);
                if (lstuser.Rows.Count >= 0)
                {
                    RadGrid1.DataSource = lstuser;
                }
                
            }
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }
    }
}