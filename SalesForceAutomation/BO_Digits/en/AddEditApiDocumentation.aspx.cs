using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditApiDocumentation : System.Web.UI.Page
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
                API();

                FillForm();

            }
        }

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectAPIByID", "sp_Transaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string api = lstDatas.Rows[0]["apd_iws_ID"].ToString();
                string heading = lstDatas.Rows[0]["apd_Heading"].ToString();
                string type = lstDatas.Rows[0]["apd_Type"].ToString();
                string order = lstDatas.Rows[0]["apd_Order"].ToString();
                string subheading = lstDatas.Rows[0]["apd_SubHeading"].ToString();
                string content = lstDatas.Rows[0]["apd_Content"].ToString();

                rdapiname.SelectedValue = api;
                txtHeading.Text = heading;
                ddlType.SelectedValue = type;
                txtorder.Text = order;
                txtsub.InnerText = subheading;

                if (type == "HTML")
                {
                    PlaceHolder1.Visible = true;
                    plhFilter.Visible = false;
                    RadEditor1.Content = content;
                }
                else if (type == "C")
                {
                    PlaceHolder1.Visible = false;
                    plhFilter.Visible = true;
                    txtContent.InnerText = content;
                }
            }
        }


        public void API()
        {
            rdapiname.DataSource = ObjclsFrms.loadList("selectAPINamefromdrop", "sp_Transaction");
            rdapiname.DataTextField = "iws_Name";
            rdapiname.DataValueField = "iws_ID";
            rdapiname.DataBind();
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();

        }

        protected void Save()
        {
            try
            {


                string api, heading, type, order,subheading,content,user;

                api = rdapiname.SelectedValue.ToString();
                heading = txtHeading.Text.ToString();
                type = ddlType.SelectedValue.ToString();
                order = txtorder.Text.ToString();
                subheading = txtsub.InnerText.ToString();

                if (PlaceHolder1.Visible)
                {
                    content = RadEditor1.Content.ToString();
                }
                else if (plhFilter.Visible)
                {
                    content = txtContent.Value.ToString();
                }
                else
                {
                    content = string.Empty;
                }

                user = UICommon.GetCurrentUserID().ToString();



                if (ResponseID.Equals("") || ResponseID == 0)
                {


                    string[] arr = { heading, type, order, subheading, content, user };
                    string Value = ObjclsFrms.SaveData("sp_Transaction", "AddApiDocumentation", api, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Documentation Saved Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }

                else
                {
                    string id = ResponseID.ToString();
                    string[] arr = { heading, type, order, subheading, content, user,id };
                    string Value = ObjclsFrms.SaveData("sp_Transaction", "updateApiDocumentation", api, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)

                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Documentation Updated Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService("Exception from AddEdit Bank Save(): " + ex.Message.ToString());
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListApiDocumentation.aspx");
        }

        protected void ddlType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            string selectedValue = ddlType.SelectedValue;

            switch (selectedValue)
            {
                case "HTML":
                    PlaceHolder1.Visible = true;
                    plhFilter.Visible = false;
                    break;
                case "T":
                case "PT":
                case "C":
                    PlaceHolder1.Visible = false;
                    plhFilter.Visible = true;
                    break;
                default:
                    PlaceHolder1.Visible = true;
                    plhFilter.Visible = false;
                    break;
            }
        }
    }
}