using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditProductMappingGroup : System.Web.UI.Page
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


                        txtCode.Enabled = false;

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
    }
}