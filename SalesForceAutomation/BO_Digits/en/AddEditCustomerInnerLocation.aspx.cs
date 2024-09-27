using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerInnerLocation : System.Web.UI.Page
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
        public int CustomerID
        {
            get
            {
                int CustomerID;
                int.TryParse(Request.Params["CId"], out CustomerID);

                return CustomerID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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


                DataTable lstDatas = ObjclsFrms.loadList("EditCustomerInnerLoaction", "sp_Masters", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    string loc, status;

                    loc = lstDatas.Rows[0]["cil_LocName"].ToString();
                    status = lstDatas.Rows[0]["Status"].ToString();


                    txtname.Text = loc.ToString();
                    ddlstatu.SelectedValue = status.ToString();



                }
                else                                                              //If there is no value you can leave it as it is.
                {

                }
            }
        }

        public void SaveData()
        {


            string loc, user, Status;


            loc = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            Status = ddlstatu.SelectedValue.ToString();
            // string[] arrr = { pname,  dates, date };




            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = { loc, user, Status };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCustomerInnerLocation", CustomerID.ToString(), arr);

                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Inner Location saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { loc, Status, ID };
                string value = ObjclsFrms.SaveData("sp_Masters", "UpdateCustomerInnerLocation", CustomerID.ToString(), arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Inner Location updated successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }
        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerInnerLocation.aspx?Id=" + CustomerID.ToString());
        }

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerInnerLocation.aspx?Id=" + CustomerID.ToString());
        }
    }
}