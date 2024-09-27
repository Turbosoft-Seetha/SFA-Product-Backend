using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListAssetMaster : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int CustomerID
        {
            get
            {
                int CustomerID;
                int.TryParse(Request.Params["Id"], out CustomerID);

                return CustomerID;
            }
        }
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
                Customer();
            }
        }
        public void Customer()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerName", "sp_Merchandising", CustomerID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                string name = lstUser.Rows[0]["cus_Name"].ToString();
                ltrlCustomer.Text = name.ToString();
            }
        }
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("CustAsset", "sp_Merchandising", CustomerID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
            }

        }
        protected void lnkAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AddEditAssetMaster.aspx?CId=" + CustomerID.ToString());
        }

       
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("asc_ID").ToString();

                Response.Redirect("AddEditAssetMaster.aspx?CId=" + CustomerID.ToString() + "&Id=" + ID);
            }
            if (e.CommandName.Equals("Question"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("asc_ID").ToString();

                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("SelAssetName", "sp_Merchandising", ID.ToString());
                if (lstUser.Rows.Count > 0)
                {
                    //string name = lstUser.Rows[0]["asc_Name"].ToString();
                    //ltrAsset.Text = name.ToString();
                    RadPanelItem rp = RadPanelBar0.Items[0];
                    Label lblAsset = (Label)rp.FindControl("lblAsset");
                    rp.Text = "Asset : " + lstUser.Rows[0]["asc_Name"].ToString();
                   

                }


                StringBuilder sb = new StringBuilder();
                DataTable lstDatas = ObjclsFrms.loadList("SelectcustomerAssetQuestion", "sp_Merchandising", ID.ToString());
                if (lstDatas.Rows.Count > 0)
                {
                    
                    //Table start.
                    sb.Append("<table cellpadding='8' cellspacing='0' style='border: 1px solid #ccc;font-size: 9pt;font-family:Arial;width:100%'>");

                    //Adding HeaderRow.
                    sb.Append("<tr>");
                    sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Questions</th>");
                    sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Type</th>");
                    sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Is Mandatory</th>");
                    sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>Order</th>");
                    sb.Append("</tr>");


                    //Adding DataRow.
                    for (int i = 0; i < lstDatas.Rows.Count; i++)
                    {
                        string question, isManditory, order, type;
                        question = lstDatas.Rows[i]["Question"].ToString();
                        isManditory = lstDatas.Rows[i]["asq_IsMandatory"].ToString().Replace(" ", "");
                        order = lstDatas.Rows[i]["Orders"].ToString();
                        type = lstDatas.Rows[i]["qst_Name"].ToString();
                        sb.Append("<tr>");
                        sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", question.ToString());
                        sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", type.ToString());
                        sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", isManditory.ToString());
                        sb.AppendFormat("<td style='width:100px;border: 1px solid #ccc'>{0}</td>", order.ToString());
                        sb.Append("</tr>");
                    }

                    //Table end.
                    sb.Append("</table>");
                    
                }
                ltTable.Text = sb.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Question();</script>", false);
            }
        }

    }

}
