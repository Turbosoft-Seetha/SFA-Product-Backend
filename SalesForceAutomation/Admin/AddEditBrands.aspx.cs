using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditBrands : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();
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
            if (!Page.IsPostBack)
            {

                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = ob.loadList("EditBrand", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {

                        string brdname, brdcode,Arabic, Status;                                          //Declare the variables

                        Arabic = lstDatas.Rows[0]["brd_NameArabic"].ToString();
                        brdname = lstDatas.Rows[0]["brd_Name"].ToString();                         //Set the value to the variables
                        brdcode = lstDatas.Rows[0]["brd_Code"].ToString();
                        Status = lstDatas.Rows[0]["Status"].ToString();

                        txtarabic.Text = Arabic.ToString();
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
        public void SaveData()
        {
            string brdname, brdcode, Status,Arabic, User;
            Arabic = txtarabic.Text.ToString();
            brdname = txtName.Text.ToString();
            brdcode = txtCode.Text.ToString();
            Status = ddlStat.SelectedValue.ToString();
            User = UICommon.GetCurrentUserID().ToString();

            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = { brdcode, User, Status ,Arabic};
                string Value = ob.SaveData("sp_Masters", "AddBrand", brdname, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Brand has been saved sucessfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { brdcode, User, Status,Arabic, ID };
                string value = ob.SaveData("sp_Masters", "UpdateBrand", brdname, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Brand has been updated sucessfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListBrand.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListBrand.aspx");
        }
    }
}