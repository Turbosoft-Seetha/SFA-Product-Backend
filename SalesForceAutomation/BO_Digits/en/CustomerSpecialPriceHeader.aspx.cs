using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using DataTable = System.Data.DataTable;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerSpecialPriceHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }

        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["cid"], out ResponseID);

                return ResponseID;
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("CusSpecialPriceHeader", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
            DataTable lst = default(DataTable);
            lst = ObjclsFrms.loadList("CustomerBYid", "sp_Masters", ResponseID.ToString());
            lblcuscode.Text = lst.Rows[0]["cus_Code"].ToString();
            lblcustomer.Text = lst.Rows[0]["cus_Name"].ToString();
            
           
        }


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void Save()
        {
          
            string prhID = ViewState["delID"].ToString();
            ObjclsFrms.TraceService("special price ID to remove=" + prhID);
            string rot = ViewState["rot_ID"].ToString();
            string[] ar = {prhID,rot };
            string value = ObjclsFrms.SaveData("sp_Masters", "RemovePricingFromCus",  ResponseID.ToString(), ar);
            int res = Int32.Parse(value.ToString());
           
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong..Please try again ');</script>", false);
            }

        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
          
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("CustomerSpecialPriceDetail.aspx?Id=" + ID + "&cid=" + ResponseID.ToString());
            }

            else if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                ViewState["rot_ID"] = "";
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem["prh_ID"].Text.ToString();
                ObjclsFrms.TraceService("special price ID to remove=" + ID);
                ViewState["delID"] = ID;
                string rot = dataItem["rot_ID"].Text.ToString();
                ViewState["rot_ID"] = rot.ToString();
                string pricing = dataItem["pricing"].Text.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim('While removing, the entire products belongs to " + pricing + " will be removed from this customer..Are you sure want to continue..?');</script>", false);
            }

        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerSpecialPriceHeader.aspx?cid=" + ResponseID);
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCustomerPriceList.aspx?cid="+ResponseID);
            
        }
    }
}