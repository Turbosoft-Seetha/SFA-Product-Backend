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
    public partial class AddSurveyCustomerRoute : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Titles();
                Route();
                LoadQuestion();
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectSurveyMasterById", "sp_Merchandising", ResponseID.ToString());
            if (lstTitle.Rows.Count > 0)
            {
                string name = lstTitle.Rows[0]["srm_Name"].ToString();
                lblTitle.Text = " for " + name.ToString();
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForDropDown", "sp_Merchandising");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ListData();
            LoadData();
            grvRpt.Rebind();
            RadGrid1.Rebind();

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCusRotSeqForSurvey", "sp_Merchandising", ResponseID.ToString(),arr);
            if (lstUser.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstUser;
            }
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("crs_ID").ToString();
                ViewState["ID"] = ID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
        public void ListData()
        {
            string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerRouteSurvey", "sp_Merchandising", ResponseID.ToString(),arr);
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
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
                        string rotID = item["rot_ID"].Text.ToString();
                        string user = UICommon.GetCurrentUserID().ToString();
                        string[] arr = { ResponseID.ToString(), rotID.ToString(), user.ToString() };
                        string cusID = item["cus_ID"].Text.ToString();
                        string Value;
                        int res = 0;
                        Value = ObjclsFrms.SaveData("sp_Merchandising", "InsertCustomerRouteSurvey", cusID.ToString(), arr);
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

        protected void btnOK_Click(object sender, EventArgs e)
        {
            //Page.Response.Redirect(Page.Request.Url.ToString(), true);
            
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();


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
                        string ID = item.GetDataKeyValue("crs_ID").ToString();
                        ObjclsFrms.loadList("DeleteCustomerRouteSurvey", "sp_Merchandising", ID.ToString());
                        DataTable lstLatest = ObjclsFrms.loadList("SelectCustomerRouteSurveyByCheckID", "sp_Merchandising", ID.ToString());
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

        public void LoadQuestion()
        {
            DataTable lstDatas = default(DataTable);
            lstDatas = ObjclsFrms.loadList("SelectSurveyDetailsById", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
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
                    question = lstDatas.Rows[i]["surQuestion"].ToString();
                    isManditory = lstDatas.Rows[i]["Mandat"].ToString();
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
                ltTable.Text = sb.ToString();
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();

        }
    }
}