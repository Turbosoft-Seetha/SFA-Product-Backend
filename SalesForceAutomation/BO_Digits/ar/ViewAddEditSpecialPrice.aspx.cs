using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ViewAddEditSpecialPrice : System.Web.UI.Page
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

                FillForm();
            }
        }
        public void FillForm()
        {
            if (ResponseID.Equals("") || ResponseID == 0)
            {
                divcode.Visible = false;
            }
            else
            {
                DataTable lstDatas = ObjclsFrms.loadList("editPriceListHeader", "sp_Masters", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {
                    string name, status, code, PM;
                    name = lstDatas.Rows[0]["prh_Name"].ToString();
                    status = lstDatas.Rows[0]["Status"].ToString();
                    code = lstDatas.Rows[0]["prh_Code"].ToString();
                    PM = lstDatas.Rows[0]["prh_PayMode"].ToString();
                    txtname.Text = name.ToString();
                    txtcode.Text = code.ToString();
                    ddlStatus.SelectedValue = status.ToString();
                    // ddlPayMode.SelectedValue = PM.ToString();
                }
            }
        }







        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListPriceListHeader.aspx");

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListPriceListHeader.aspx");

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }
    }
}