using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RouteCustomerSettings : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["RID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                Customer();
                //SettingsName();
                
            }
        }
        
        public void SettingsName()
        {
            string SettingsType = ddlSettingType.SelectedValue.ToString();
            if (ddlSettingType.SelectedValue.ToString() != "")
            {
                if (SettingsType == "S")
                {
                    lblPage.Visible = false;
                    lblPage.Text = "";
                    dllSettings.ClearSelection();
                    string page = "RouteCustomerSettings.aspx";
                    DataTable dts = ObjclsFrms.loadList("SelRotSettingsName", "sp_Masters", page);
                    dllSettings.DataSource = dts;
                    dllSettings.DataTextField = "set_SettingsName";
                    dllSettings.DataValueField = "set_ID";
                    dllSettings.DataBind();
                }
                else
                {
                    Single.Visible = false;
                    Multiple.Visible = false;
                    dllSettings.ClearSelection();
                    DataTable dts = ObjclsFrms.loadList("SelProfileHeaderforDropDownSettingsMaster", "sp_ProfileSettings", "tb_CustomerRoute");
                    dllSettings.DataSource = dts;
                    dllSettings.DataTextField = "pfh_ProfileName";
                    dllSettings.DataValueField = "pfh_ID";
                    dllSettings.DataBind();
                }
            }

           
        }
        public void Route()
        {
            DataTable dt =ObjclsFrms.loadList("SelectRouteName", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {

                string rotname = dt.Rows[0]["rot_Name"].ToString();
               // route.Text = "Route : " + rotname;


            }

        }
        public void SettingsAnswer(string Answers)
        {
            string ID = ViewState["ID"].ToString();
            DataTable dts = ObjclsFrms.loadList("SelRotSettingsText", "sp_Masters", ID);
            if (Answers == "S")
            {
                dllSettingsText.DataSource = dts;
                dllSettingsText.DataTextField = "SettingsText";
                dllSettingsText.DataValueField = "SettingsValue";
                dllSettingsText.DataBind();
            }
            else
            {
                dllmultisettings.DataSource = dts;
                dllmultisettings.DataTextField = "SettingsText";
                dllmultisettings.DataValueField = "SettingsValue";
                dllmultisettings.DataBind();
            }

        }
        public string MultipleSettings()
        {
            string retStr = "";
            var checkedItems = dllmultisettings.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Substring(0, retStr.Length - 1);
            return retStr;
        }

        public string Cus()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = grvRpt.SelectedItems;
                    // int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (GridDataItem dr in CollectionMarket)
                        {
                            string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();

                            createNode(cus_ID, writer);
                            c++;
                        }
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }
        private void createNode(string cusId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("cusID");
            writer.WriteString(cusId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void Save()
        {

            string Customer, Settings, SettingsText, user;
            string SettingsType = ddlSettingType.SelectedValue.ToString();

            Customer = Cus();
            Settings = dllSettings.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string Value;
            string CusCondition = Customer;

            if (SettingsType == "S")
            {
                if (ViewState["Answer"].ToString() == "S")
                {
                    SettingsText = dllSettingsText.SelectedValue.ToString();
                }
                else
                {
                    SettingsText = MultipleSettings();
                }
                string mainCondition = " '" + SettingsText + "' ";
                string[] arr = { Settings, mainCondition, ResponseID.ToString() };
                Value = ObjclsFrms.SaveData("sp_Masters", "UpdateRouteSettings", CusCondition, arr);
            }
            else
            {
                string[] Prof = { dllSettings.SelectedValue.ToString(), "tb_CustomerRoute", ResponseID.ToString() };
                Value = ObjclsFrms.SaveData("sp_ProfileSettings", "BulkUpdateSettingsProfile", CusCondition, Prof);
            }


            
           
            int res = Int32.Parse(Value.ToString());



            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route Customer Settings Saved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerRoute.aspx?RID=" + ResponseID.ToString());
        }

        protected void dllSettings_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string SettingsType = ddlSettingType.SelectedValue.ToString();
            if (SettingsType == "S")
            {
                RadComboBox comboBox = (RadComboBox)sender;
                string ID = comboBox.SelectedValue;
                ViewState["ID"] = ID.ToString();
                DataTable dts = ObjclsFrms.loadList("SelRotSettingsAnswerType", "sp_Masters", ID.ToString());
                string Answer = dts.Rows[0]["set_AnswerType"].ToString();
                ViewState["Answer"] = Answer.ToString();
                if (Answer == "S")
                {
                    Single.Visible = true;
                    Multiple.Visible = false;
                }
                else
                {
                    Multiple.Visible = true;
                    Single.Visible = false;

                }

                SettingsAnswer(Answer);
            }
            else if (SettingsType == "P")
            {
                if (dllSettings.SelectedValue.ToString() != "")
                {
                    lblPage.Visible = true;
                    lblPage.Text = "Show Settings of " + dllSettings.Text.ToString() + " >>";
                }
            }

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerRoute.aspx?RID=" + ResponseID.ToString());
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Customer();
        }

        public void Customer()
        {
            DataTable lstUser = ObjclsFrms.loadList("SelRotCustomerdropdown", "sp_Masters", ResponseID.ToString());
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }

        protected void ddlSettingType_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            SettingsName();
        }
        
        protected void lblPage_Click(object sender, EventArgs e)
        {
            string pfh_id = dllSettings.SelectedValue.ToString();
            string url = ConfigurationManager.AppSettings.Get("BackendURL");
            string s = "BO_Digits/en/ListSettingsProfiles.aspx?ID=" + pfh_id;
            url = url + s;

            OpenNewBrowserWindow(url, this);
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
    }
}