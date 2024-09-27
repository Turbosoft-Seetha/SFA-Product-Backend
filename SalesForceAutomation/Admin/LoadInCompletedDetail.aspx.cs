using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using System.Xml;


namespace SalesForceAutomation.Admin
{
    public partial class LoadInCompletedDetail : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();

        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["LIH"], out LIH);

                return LIH;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            { 

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            //string[] arr = { ddlHUom.SelectedValue.ToString(), ddlLUom.SelectedValue.ToString() };

            lstDatas = Obj.loadList("ListLoadInDetail", "sp_Backend", LIH.ToString());
           
            

                grvRpt.DataSource = lstDatas;
               
           

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }
    }
}