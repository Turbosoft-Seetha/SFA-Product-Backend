using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditPromotionRange : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
       
        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["HID"], out HeaderID);

                return HeaderID;
            }
        }
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

                Titles();
                FillForm();
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectPromotionHeaderTitle", "sp_Web_Promotion", ResponseID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
           // lblTitle.Text = "for " + titles.ToString();
        }

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectPromotionRangeByID", "sp_Web_Promotion", HeaderID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string min, max, value, limit, status;
                min = lstDatas.Rows[0]["prr_MinValue"].ToString();
                max = lstDatas.Rows[0]["prr_MaxValue"].ToString();
                value = lstDatas.Rows[0]["prr_Value"].ToString();
                limit = lstDatas.Rows[0]["prr_LimitValue"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtMin.Text = min.ToString();
                txtMax.Text = max.ToString();
                txtValue.Text = value.ToString();
                txtLimit.Text = limit.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {                    
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);         
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListPromotionRange.aspx?Id=" + ResponseID.ToString());
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {

            string header, min, max, value, limit, user, status,rpttype,ofrvalinc,iterationcount;

            header = ResponseID.ToString();
            min = txtMin.Text.ToString();
            max = txtMax.Text.ToString();
            value = txtValue.Text.ToString();
            limit = txtLimit.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            rpttype=ddlrpttype.SelectedValue.ToString();
            ofrvalinc = txtofrvalInc.Text.ToString();
            iterationcount=txtitrcount.Text.ToString();
            string RepeatType = rpttype + ofrvalinc;
            if (HeaderID.Equals("") || HeaderID == 0)
            {

                //  string[] arr = { min.ToString(), max.ToString(), value.ToString(), limit.ToString(), user.ToString(), status.ToString(), };
                string[] arr = { min.ToString(), max.ToString(), value.ToString(), limit.ToString(), user.ToString(), status.ToString(), RepeatType, ofrvalinc, iterationcount };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertPromotionRange", header.ToString(), arr);
                try
                {
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Promotion Range Saved Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('The range already exisits');</script>", false);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('There is some technical exception, please try again later');</script>", false);
                }


            }
            else
            {
                string id = HeaderID.ToString();
                string[] arr = { min.ToString(), max.ToString(), value.ToString(), limit.ToString(), user.ToString(), status.ToString(), id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Backend", "UpdatePromotionRange", header.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Promotion Range Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListPromotionRange.aspx?Id=" + ResponseID.ToString());
        }

        protected void ddlrpttype_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string rpt = ddlrpttype.SelectedValue.ToString();
            if (rpt.Equals("C"))
            {
                pnlIteration.Visible= false;
            }
            else
            {
                pnlIteration.Visible= true;
            }
        }
    }
}