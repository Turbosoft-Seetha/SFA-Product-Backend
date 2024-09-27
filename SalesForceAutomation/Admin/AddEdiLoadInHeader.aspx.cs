using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEdiLoadInHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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

                Route();
                FillForm();



            }
        }

        public void FillForm()
        {
            string Id = ResponseID.ToString();
            if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
            {
                
            }
            else                                                                        //If we are editing there will be a value and the following code will be executed.
            {


                DataTable lstDatas = ObjclsFrms.loadList("SelectLoadinHeader", "sp_Masters", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    string rotname,  Status;
                    rotname = lstDatas.Rows[0]["lih_rot_ID"].ToString();
                    Status = lstDatas.Rows[0]["Status"].ToString();
                    ddlp.SelectedValue = rotname.ToString();
                    ddlstatus.SelectedValue = Status.ToString();
                }
                else                                                              //If there is no value you can leave it as it is.
                {

                }
            }
        }

        public void SaveData()


        {

            string rotname, user, status;
            rotname = ddlp.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlstatus.SelectedValue.ToString();
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = { user, status };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertLoadInHeader", rotname, arr);
                //new
                int res = Int32.Parse(Value.ToString());
                // venda
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess(' Load In Header saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { status, ID };
                string value = ObjclsFrms.SaveData("sp_Masters", "UpdateLoadInHeader", rotname, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess(' Load In Header updated successully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }

        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromDropRouteID", "sp_Masters");
            ddlp.DataSource = dt;
            ddlp.DataTextField = "rot_Name";
            ddlp.DataValueField = "rot_ID";
            ddlp.DataBind();
        }



        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListLoadInHeader.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListLoadInHeader.aspx");
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void ddlp_SelectedIndexChanged1(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //string rot = ddlemp.SelectedValue.ToString();
            //Employee(rot);
        }
    }
}

















