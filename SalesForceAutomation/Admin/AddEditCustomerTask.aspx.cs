using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditCustomerTask : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["taskimage"] = null;
                Route();
                Brand();
                
            }
        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectRoute", "sp_wb_merch_others");
            ddlroute.DataSource = dt;
            ddlroute.DataTextField = "rot_Name";
            ddlroute.DataValueField = "rot_ID";
            ddlroute.DataBind();
        }
        public void Customer()
        {
            DataTable dtc = ObjclsFrms.loadList("SelectCustomerforRoute", "sp_wb_merch_others", ddlroute.SelectedValue.ToString());
            ddlCus.DataSource = dtc;
            ddlCus.DataTextField = "cus_Name";
            ddlCus.DataValueField = "cus_ID";
            ddlCus.DataBind();
        }
        public void Brand()
        {
            DataTable dt = ObjclsFrms.loadList("SelectBrand", "sp_wb_merch_others");
            ddlBrd.DataSource = dt;
            ddlBrd.DataTextField = "brd_Name";
            ddlBrd.DataValueField = "brd_ID";
            ddlBrd.DataBind();
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerTasks.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {
            string user, name, desc, taskimg,rot,cus,brd,date;
            name = txtCTName.Text.ToString();
            taskimg = "";
            desc = txtDesc.Text.ToString();
            rot = ddlroute.SelectedValue.ToString();
            cus = ddlCus.SelectedValue.ToString();
            brd = ddlBrd.SelectedValue.ToString();
            date = DateTime.Parse(duedate.SelectedDate.ToString()).ToString("yyyyMMdd");
            user = UICommon.GetCurrentUserID().ToString();
            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;
                string csvPath = Server.MapPath(("..") + @"/UploadFiles/Task/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                taskimg = @"/UploadFiles/Task/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                ViewState["Image"] = taskimg.ToString();
            }
            if (taskimg == "")
            {
                taskimg = ViewState["taskimage"].ToString();
            }
            else
            {
                taskimg = ViewState["Image"].ToString();
            }

            if (taskimg != null)
            {
               
                 string[] arr = { taskimg,  desc,rot,cus,brd,date };
                string Value = ObjclsFrms.SaveData( "sp_wb_merch_others", "InsertCusTaskfromweb", name, arr);
                int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                     
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Task has been inserted successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                    }
               

                //else
                //{
                //    string id = ResponseID.ToString();
                //    string[] arr = { name.ToString(), planogram.ToString(), user.ToString(), status.ToString() };
                //    string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateAssetType", id.ToString(), arr);
                //    int res = Int32.Parse(Value.ToString());
                //    if (res > 0)
                //    {
                //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Asset type has been updated');</script>", false);
                //    }
                //    else
                //    {
                //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                //    }
                //}
            }
            
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            if ((upd1.UploadedFiles.Count == 0) && (ViewState["taskimage"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void ddlroute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }

        protected void ddlCus_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void ddlBrd_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}