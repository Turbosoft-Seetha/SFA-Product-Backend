using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditProductMappingGroup : System.Web.UI.Page
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
                    DataTable lstDatas = ob.loadList("EditProductMappingGroup", "sp_Masters", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {

                        string name, code, Status;                                          //Declare the variables
                        name = lstDatas.Rows[0]["pmg_Name"].ToString();
                        code = lstDatas.Rows[0]["pmg_Code"].ToString();
                        Status = lstDatas.Rows[0]["Status"].ToString();


                       

                        txtName.Text = name.ToString();
                        txtCode.Text = code.ToString();
                        
                        ddlStat.SelectedValue = Status.ToString();
                        txtCode.Enabled = false;
                    }
                    else
                    {

                    }
                }
            }
        }
        public void SaveData()
        {
            string name, code,User,Status;
            name = txtName.Text.ToString();
            code = txtCode.Text.ToString();
           
            User = UICommon.GetCurrentUserID().ToString();
            Status = ddlStat.SelectedValue.ToString();


            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                
                    string[] arr = { code, User, Status };
                    string Value = ob.SaveData("sp_Merchandising", "InsertProductMappingGroup", name, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess(' saved sucessfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                
            }
            else
            {
               
                    string ID = ResponseID.ToString();
                    string[] arr = { code, User, Status, ID };
                    string value = ob.SaveData("sp_Merchandising", "UpdateProductMappingGroup", name, arr);
                    int res = Int32.Parse(value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Updated sucessfully');</script>", false);
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
            Response.Redirect("/Admin/ListProductMappingGroup.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListProductMappingGroup.aspx");
        }
    }
}