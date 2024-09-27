using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditCustomerBrochure : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtFrom.SelectedDate = DateTime.Now;
                Route();
            }
        }
        public void Route()
        {
            DataTable lstType = ObjclsFrms.loadList("DropDownRouteForBrochure", "sp_Merchandising");
            if (lstType.Rows.Count > 0)
            {
                ddlRoute.DataSource = lstType;
                ddlRoute.DataValueField = "id";
                ddlRoute.DataTextField = "name";
                ddlRoute.DataBind();
            }
        }

        public void Customer()
        {
            ddlCustomers.DataSource = ObjclsFrms.loadList("SelectCustomerForBrochure", "sp_Merchandising", ddlRoute.SelectedValue.ToString());
            ddlCustomers.DataTextField = "name";
            ddlCustomers.DataValueField = "id";
            ddlCustomers.DataBind();
        }

        protected void lnkSaves_Click(object sender, EventArgs e)
        {

            if ((upd1.UploadedFiles.Count == 0) && (ViewState["image"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                
            }
        }
        protected void Save()
        {
            string image = "";
            //int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                //ImageID += 1;

                string csvPath = Server.MapPath(("..") + @"/UploadFiles/Brochure/") + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                image = @"/UploadFiles/Brochure/" +  uploadedFile.FileName.ToString();
                ViewState["image"] = image.ToString();
            }

            string cust, name, from, to, path, user,route;
            name = txtName.Text.ToString();
            from = DateTime.Parse(txtFrom.SelectedDate.ToString()).ToString("yyyyMMdd");
            to = DateTime.Parse(txtToDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            path = ViewState["image"].ToString();
            user = UICommon.GetCurrentUserID().ToString();
            route = ddlRoute.SelectedValue.ToString();
            string Value = "";
            string[] arr = { name.ToString(), from.ToString(), to.ToString(), path.ToString(), user.ToString(),
            route.ToString()};
            var SelectedCustomers = ddlCustomers.CheckedItems;
            cust = "";
            foreach (var item in SelectedCustomers)
            {
                cust = item.Value;
                Value = ObjclsFrms.SaveData("sp_Masters", "InsertCustomerBrochure", cust.ToString(), arr);
            }

            int claim = Int32.Parse(Value.ToString());

            if (claim == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else if (claim < 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>existModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
        }

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {

            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditCustomerBrochure.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + 
                    innerMessage);
            }


        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerBrochure.aspx");
        }
    }
}