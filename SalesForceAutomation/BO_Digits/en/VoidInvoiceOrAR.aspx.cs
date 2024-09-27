using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VoidInvoiceOrAR : System.Web.UI.Page
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
            if (type == "I")
            {
                pnlInvNo.Visible = true;
                Num = txtInvoiceNo.Text.ToString();
                string[] ar = { Num };
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("ShowInvoicetoVoid", "sp_ITOperations", type.ToString(), ar);
                InvoiceGrid.DataSource = lstUser;
            }
            else if (type == "A")
            {
                pnlARNo.Visible = true;
                Num = txtARNo.Text.ToString();
                string[] ar = { Num };
                DataTable lstUser = default(DataTable);
                lstUser = ObjclsFrms.loadList("ShowARtoVoid", "sp_ITOperations", type.ToString(), ar);
                ARGrid.DataSource = lstUser;
            }
            else
            {
                InvoiceGrid.Visible = false;
                ARGrid.Visible = false;               
            }


        }

        protected void lnkGoBtn_Click(object sender, EventArgs e)
        {           
            if (ddlTransType.SelectedValue.ToString() == "I")
            {
                ARGrid.Visible = false;
                LoadList();
                InvoiceGrid.Rebind();
            }
            else
            {
                InvoiceGrid.Visible = false;
                LoadList();
                ARGrid.Rebind();
            }

        }

        protected void InvoiceGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void ARGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }        

        protected void ddlTransType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            string type = ddlTransType.SelectedValue.ToString();
            if (type == "I")
            {
                pnlInvNo.Visible = true;
                InvoiceGrid.Visible=true;
                InvoiceGrid.Rebind();
                pnlARNo.Visible = false;
                ARGrid.Visible=false;
            }
            else
            {
                pnlARNo.Visible = true;
                ARGrid.Visible = true;
                ARGrid.Rebind();
                pnlInvNo.Visible = false;
                InvoiceGrid.Visible=false;
            }
        }

        protected void ok_Click(object sender, EventArgs e)
        {
            Response.Redirect("VoidInvoiceOrAR.aspx");
        }

        protected void InvoiceGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DoVoidInv")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string salID = dataItem.GetDataKeyValue("sal_ID").ToString();
                    string number = dataItem["Number"].Text.ToString();

                    hfSalID.Value = salID;
                    hfNumber.Value = number;

                    ScriptManager.RegisterStartupScript(this, GetType(), "InvModal", "$('#kt_modal_1_8').modal('show');", true);
                }
            }
        }

        protected void InvNoteOK_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string salID = hfSalID.Value;
            string number = hfNumber.Value;
            string[] ar = { number, user };

            string Value = ObjclsFrms.SaveData("sp_ITOperations", "doVoidinvoice", salID, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Invoice Voided Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void ARGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DoVoidAR")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem != null)
                {
                    string arhID = dataItem.GetDataKeyValue("arh_ID").ToString();
                    string number = dataItem["arh_ARNumber"].Text.ToString();

                    hfArhID.Value = arhID;
                    hfARNum.Value = number;

                    ScriptManager.RegisterStartupScript(this, GetType(), "ARModal", "$('#kt_modal_1_9').modal('show');", true);
                }
            }

        }

        protected void ARNoteOk_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string arhID = hfArhID.Value;
            string number = hfARNum.Value;
            string[] ar = { number, user };

            string Value = ObjclsFrms.SaveData("sp_ITOperations", "doVoidAR", arhID, ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal2('AR Voided Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
           
        }
    }
}

