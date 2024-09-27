using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditBrand : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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

                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = Obj.loadList("EditBrand", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {
                        string brdname, brdcode, Status;                                          //Declare the variables
                       
                        brdname = lstDatas.Rows[0]["brd_Name"].ToString();                         //Set the value to the variables
                        brdcode = lstDatas.Rows[0]["brd_Code"].ToString();
                        Status = lstDatas.Rows[0]["Status"].ToString();

                        txtName.Text = brdname.ToString();                                     //Here the binding is done. "txtName" is the ID of the textBox in ASPX
                        txtCode.Text = brdcode.ToString();
                        ddlStat.SelectedValue = Status.ToString();
                    }
                    else                                                              //If there is no value you can leave it as it is.
                    {

                    }
                }

            }
        }
        protected void SaveData()
        {
            string brdname, brdcode, Status, User;
            brdname = txtName.Text.ToString();
            brdcode = txtCode.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            User = UICommon.GetCurrentUserID().ToString();

            if (ResponseID == 0)
            {

                string[] arr = { brdcode.ToString(), User.ToString(), Status.ToString() };
                string value = Obj.SaveData("AddBrand", "sp_Masters", brdname.ToString(), arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { brdcode, User, Status, ID };
                string value = Obj.SaveData("sp_Masters", "UpdateBrand", brdname, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal(Brands Has been updated successfully);</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
        }

            protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
           
                try
                {
                    SaveData();
                }
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddEditQuestions.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }
            
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListBrand.aspx");
        }
    }
}