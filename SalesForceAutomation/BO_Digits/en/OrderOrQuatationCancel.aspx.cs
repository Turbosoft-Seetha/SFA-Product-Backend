using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OrderOrQuatationCancel : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {

                }
            }


            public void LoadList()
            {
                string type, Num;
                type = ddlTransType.SelectedValue.ToString();
                if (type == "O")
                {
                    pnlord.Visible = true;
                    Num = txtordnum.Text.ToString();
                    string maincondition =  Num ;
                    DataTable lstUser = default(DataTable);
                    lstUser = ObjclsFrms.loadList("ListOrdertocancel", "sp_Merchandising_UOM", maincondition);
                    ordgrvRpt.DataSource = lstUser;
                }
                else if (type == "Q")
                {
                    pnlquotation.Visible = true;
                    Num = txtquotanum.Text.ToString();
                    string maincondition =  Num ;
                    DataTable lstUser = default(DataTable);
                    lstUser = ObjclsFrms.loadList("QuotationOrdertocancel", "sp_Merchandising_UOM", maincondition);
                    QuotationgrvRpt.DataSource = lstUser;
                }
                else
                {
                    ordgrvRpt.Visible = false;
                    QuotationgrvRpt.Visible = false;
                }


            }

            protected void lnkGoBtn_Click(object sender, EventArgs e)
            {
                if (ddlTransType.SelectedValue.ToString() == "O")
                {
                    QuotationgrvRpt.Visible = false;
                    LoadList();
                    ordgrvRpt.Rebind();
                }
                else
                {
                    ordgrvRpt.Visible = false;
                    LoadList();
                    QuotationgrvRpt.Rebind();
                }

            }

           

            protected void ddlTransType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
            {
                string type = ddlTransType.SelectedValue.ToString();
                if (type == "O")
                {
                    pnlord.Visible = true;
                    ordgrvRpt.Visible = true;
                    ordgrvRpt.Rebind();
                    pnlquotation.Visible = false;
                    QuotationgrvRpt.Visible = false;
                }
                else
                {
                    pnlquotation.Visible = true;
                    QuotationgrvRpt.Visible = true;
                    QuotationgrvRpt.Rebind();
                    pnlord.Visible = false;
                    ordgrvRpt.Visible = false;
                }
            }

            protected void ok_Click(object sender, EventArgs e)
            {
                Response.Redirect("OrderOrQuatationCancel.aspx");
            }

          
          
        protected void ordgrvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void ordgrvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DoVoidOrd")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string ordID = dataItem.GetDataKeyValue("ord_ID").ToString();
                    string number = dataItem["OrderID"].Text.ToString();

                    hfordID.Value = ordID;
                    hfordNumber.Value = number;

                    ScriptManager.RegisterStartupScript(this, GetType(), "OrdModal", "$('#kt_modal_1_8').modal('show');", true);
                }
            }
        }

        protected void ordgrvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                LinkButton btnCancel = (LinkButton)dataItem.FindControl("DoVoidOrd");

                string status = dataItem["Status"].Text.ToString();
                if (status.Equals("Cancelled"))
                {
                    btnCancel.Enabled = false;
                    btnCancel.Text = "Cancelled";
                }
                else
                {
                    btnCancel.Enabled = true;
                    btnCancel.Text = "Cancel";
                }
            }
            catch(Exception ex) { }
         }

        protected void QuotationgrvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void QuotationgrvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DoVoidQuota")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string ordID = dataItem.GetDataKeyValue("ord_ID").ToString();
                    string number = dataItem["OrderID"].Text.ToString();

                    hfquoID.Value = ordID;
                    hfquoNum.Value = number;

                    ScriptManager.RegisterStartupScript(this, GetType(), "QOModal", "$('#kt_modal_1_9').modal('show');", true);
                }
            }
        }

        protected void OrdNoteOK_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string ordID = hfordID.Value;
            string number = hfordNumber.Value;
            string[] ar = { number, user };

            string Value = ObjclsFrms.SaveData("sp_Merchandising_UOM", "doCancelOrder", ordID, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Order Cancelled Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void QuotattionNoteOk_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string ordID = hfquoID.Value;
            string number = hfquoNum.Value;
            string[] ar = { number, user };

            string Value = ObjclsFrms.SaveData("sp_Merchandising_UOM", "doCancelOrder", ordID, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal2('Order Quotation Cancelled Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void QuotationgrvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                LinkButton btnCancel = (LinkButton)dataItem.FindControl("DoVoidQuota");

                string status = dataItem["Status"].Text.ToString();
                if (status.Equals("Cancelled"))
                {
                    btnCancel.Enabled = false;
                    btnCancel.Text = "Cancelled";
                }
                else
                {
                    btnCancel.Enabled = true;
                    btnCancel.Text = "Cancel";
                }
            }
            catch(Exception ex) { }
            
        }
    }
}

