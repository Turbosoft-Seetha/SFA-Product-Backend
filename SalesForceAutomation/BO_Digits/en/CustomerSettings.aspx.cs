using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerSettings : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Customer();
                //SettingsName();
                
                try
                {
                    GetGridSession(grvRpt, "CusSettings");
                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerSettings.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                }

            }
        }
        public void Customer()
        {
            DataTable lstUser = ObjclsFrms.loadList("SelCustomer", "sp_SettingsMaster");
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
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
                    string page = "CustomerSettings.aspx";
                    DataTable dts = ObjclsFrms.loadList("SelectSettingsName", "sp_SettingsMaster", page);
                    dllSettings.DataSource = dts;
                    dllSettings.DataTextField = "set_SettingsName";
                    dllSettings.DataValueField = "set_ID";
                }
                else
                {
                    Single.Visible = false;
                    Multiple.Visible = false;
                    dllSettings.ClearSelection();
                    DataTable dts = ObjclsFrms.loadList("SelProfileHeaderforDropDownSettingsMaster", "sp_ProfileSettings", "tb_Customer");
                    dllSettings.DataSource = dts;
                    dllSettings.DataTextField = "pfh_ProfileName";
                    dllSettings.DataValueField = "pfh_ID";
                }
            }

            
            dllSettings.DataBind();

        }
        public void SettingsAnswer(string Answers)
        {

            DataTable dts = ObjclsFrms.loadList("SelectSettingsText", "sp_SettingsMaster", ViewState["ID"].ToString());
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

            string Cust, Settings, SettingsText, user;
            string SettingsType = ddlSettingType.SelectedValue.ToString();

            Cust = Cus();
            Settings = dllSettings.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string Value;

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
                string mainCondition = " '" + SettingsText + "' , ModifiedBy = '" + user + "' , ModifiedDate = getdate() ";
                string[] arr = { Settings, mainCondition };
                Value = ObjclsFrms.SaveData("sp_SettingsMaster", "UpdateSettings", Cust, arr);
            }
            else
            {
                string[] Prof = { dllSettings.SelectedValue.ToString(), "tb_Customer" };
                Value = ObjclsFrms.SaveData("sp_ProfileSettings", "BulkUpdateSettingsProfile", Cust, Prof);
            }

           
            
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Settings Saved Successfully');</script>", false);
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
            Response.Redirect("ListCustomer.aspx");
        }

        protected void dllSettings_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string SettingsType = ddlSettingType.SelectedValue.ToString();
            if (SettingsType == "S")
            {
                RadComboBox comboBox = (RadComboBox)sender;
                string ID = comboBox.SelectedValue;
                ViewState["ID"] = ID.ToString();
                DataTable dts = ObjclsFrms.loadList("SelectSettingsAnswerType", "sp_SettingsMaster", ID.ToString());
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
            Response.Redirect("ListCustomer.aspx");
        }



        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Customer();
        }

        public void SetGridSession(Telerik.Web.UI.RadGrid grd, string SessionPrefix)

        {

            try

            {

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        string filterValue = column.CurrentFilterValue;

                        Session[SessionPrefix + columnName] = filterValue;

                    }

                }

            }

            catch (Exception ex)

            {




            }



        }
        public void GetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                string filterExpression = string.Empty;

                foreach (GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        if (Session[SessionPrefix + columnName] != null)

                        {

                            string filterValue = Session[SessionPrefix + columnName].ToString();



                            if (filterValue != "")
                            {

                                column.CurrentFilterValue = filterValue;



                                if (!string.IsNullOrEmpty(filterExpression))

                                {

                                    filterExpression += " AND ";

                                }

                                filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);

                            }

                        }

                    }

                }

                if (filterExpression != string.Empty)

                {

                    grvRpt.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {



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