using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class CustomerSpecialPriceAssignment : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
            }

        }
        public void LoadList()
        {
            
        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRoute", "sp_Masters");
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
       

        public void Customer()
        {
           
            
            DataTable dts = ObjclsFrms.loadList("selcustomerforspAssign", "sp_Masters", rdRoute.SelectedValue.ToString());
           
            rdCustomer.DataSource = dts;
            rdCustomer.DataTextField = "cus_Name";
            rdCustomer.DataValueField = "cus_ID";
            rdCustomer.DataBind();
        }
        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            try
            {
                //Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditEmployeeRotApprl.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
       

        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("EmployeesAssignApproval.aspx?Id=");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            AssignedSp();
        }
       public void AssignedSp()
        {
            string[] arrs = { rdCustomer.SelectedValue.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("AssignedSP", "sp_Masters_UOM", rdRoute.SelectedValue.ToString(), arrs);
            grvRpt.DataSource = lstUser;
        }
        public void UnassignedSp()
        {
            string[] arr = { rdCustomer.SelectedValue.ToString() };
            DataTable lstUsers = default(DataTable);
            lstUsers = ObjclsFrms.loadList("UnassignedSp", "sp_Masters_UOM",rdRoute.SelectedValue.ToString(),arr);
            RadGrid1.DataSource = lstUsers;
        }
        protected void rdCustomer_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            AssignedSp();
            UnassignedSp();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    try
                    {
                        string prhID = item["prh_ID"].Text.ToString();
                        string user = UICommon.GetCurrentUserID().ToString();
                        string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string[] arr = { rdCustomer.SelectedValue.ToString(),rdRoute.SelectedValue.ToString(),fromDate,endDate, user.ToString() };

                        string Value;
                        int res = 0;
                        Value = ObjclsFrms.SaveData("sp_Masters_UOM", "InsSPtocustomer", prhID, arr);
                        res = Int32.Parse(Value.ToString());

                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerRoute.aspx Delete()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ErrorModal();</script>", false);
                    }
                }
            }

        }


        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                foreach (GridDataItem item in grvRpt.SelectedItems)
                {
                    try
                    {
                        string ID = item.GetDataKeyValue("prh_ID").ToString();
                        ObjclsFrms.loadList("DelSPofcustomer", "sp_Masters_UOM", ID.ToString());
                        DataTable lstLatest = ObjclsFrms.loadList("DeleteCheck", "sp_Merchandising", ID.ToString());
                        if (lstLatest.Rows.Count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteFailed();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddSurveyCustomerRoute.aspx Delete()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ErrorModal();</script>", false);
                    }
                }

            }
        }


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void rdRoute_SelectedIndexChanged1(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }

        protected void RadGrid1_NeedDataSource1(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            UnassignedSp();
        }
    }
}
