using ExcelLibrary.BinaryFileFormat;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class APIDocumentation : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ListData();

            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }


        public void ListData()
        {
            try
            {
                DataTable lstUser = ObjclsFrms.loadList("ListapiDoc", "sp_Transaction", ResponseID.ToString());
                apidoc.DataSource = lstUser;
                apidoc.DataBind();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "TrackerLifeCycle.aspx ListData()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }

        }

        protected void apidoc_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string content = rowView["apd_Content"].ToString();

                HtmlGenericControl highlightDiv = (HtmlGenericControl)e.Item.FindControl("highlightDiv");

                if (string.IsNullOrEmpty(content))
                {
                    highlightDiv.Visible = false;
                }
            }
        }
    }
}