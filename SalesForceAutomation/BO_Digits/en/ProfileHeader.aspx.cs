using GoogleApi.Entities.Common.Enums;
using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ProfileHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
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
                Session["dt"] = null;
                ViewState["image"] = null;
                table();
                FillForm();
                if (!ResponseID.Equals("") || ResponseID != 0)
                {
                    LoadList();
                    column(" where pfm_tableName='" + ddlTable.SelectedValue.ToString() + "'");
                }

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProfileSettings.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["dt"] == null)
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureSave();</script>", false);
                }
                else
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)Session["dt"];
                    if (dt.Rows.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureSave();</script>", false);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void BtnCnfrmSave_Click(object sender, EventArgs e)
        {
            Save();

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProfileSettings.aspx");
        }

        protected void Save()
        {

            string prr;
            string prof=txtprofName.Text;
            string table = ddlTable.SelectedValue.ToString();
            string status;
            string user = UICommon.GetCurrentUserID().ToString();
            if (chkActive.Checked == true)
            {
                status = "Y";
            }
            else
            {
                status="N";
            }

            try
            {
                if (ResponseID.Equals("") || ResponseID == 0)
                {

                    string[] arr = { table, user, status };
                    string Value = ObjclsFrms.SaveData("sp_ProfileSettings", "InsProfileHeader", prof, arr);
                    int res = Int32.Parse(Value.ToString());

                    if (res > 0)
                    {
                        prr = GetSelectedItemsFromGrid(res.ToString());
                        string[] ar = { res.ToString(), user };

                        string DValue = ObjclsFrms.SaveData("sp_ProfileSettings", "InsProfDetail", prr, ar);
                        int Dres = Int32.Parse(DValue.ToString());
                        if (Dres > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Profile Setting Saved Successfully');</script>", false);
                            Session["dt"] = null;
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);

                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }

                else
                {
                    string id = ResponseID.ToString();
                    prr = GetSelectedItemsFromGrid(id);
                    string[] ar = { id.ToString(), user };
                    string[] arr = { table, id, user, status, prr };
                    string Value = ObjclsFrms.SaveData("sp_ProfileSettings", "UpdateProfile", prof, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        try
                        {
                            DataTable delData = ObjclsFrms.loadList("deletedetail", "sp_ProfileSettings", id.ToString());
                            string DValue = ObjclsFrms.SaveData("sp_ProfileSettings", "InsProfDetail", prr, ar);

                            int Dres = Int32.Parse(DValue.ToString());
                            if (Dres > 0)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Profile Updated Successfully');</script>", false);
                                Session["dt"] = null;

                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);

                            }
                        }
                        catch (Exception ex)
                        {

                        }

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
            }
            catch(Exception ex)
            {

            }
            
        }

        protected void table()
        {
            DataTable dt = ObjclsFrms.loadList( "SelTableforDropdown", "sp_ProfileSettings");
            ddlTable.DataSource = dt;
            ddlTable.DataTextField = "pfm_Table";
            ddlTable.DataValueField = "pfm_tableName";
            ddlTable.DataBind();
        }


        protected void column(string tablecondition)
        {
            string notin = "";
            if (ddlTable.SelectedValue.ToString() == "")
            {
                tablecondition = "";
            }

            try
            {
                if (Session["dt"] != null && ((DataTable)Session["dt"]).Rows.Count > 0)
                {
                    DataTable sessionTable = (DataTable)Session["dt"];
                    List<string> columnValues = sessionTable.AsEnumerable().Select(row => row["pfd_Columns"].ToString()).ToList();
                    notin = string.Join(",", columnValues.Select(value => $"'{value}'"));
                    notin = " and pfm_ColumnName not in(" + notin + ")";
                }
            }
            catch(Exception ex)
            {

            }
            string[] ar = { notin };
            DataTable dt = ObjclsFrms.loadList("SelColumforDropdown", "sp_ProfileSettings",tablecondition,ar);
            rdColumnName.DataSource = dt;
            rdColumnName.DataTextField = "pfm_Settingname";
            rdColumnName.DataValueField = "pfm_ColumnName";
            rdColumnName.DataBind();
        }

        
        
        


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }


        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectProfileDetails", "sp_ProfileSettings", ResponseID.ToString());
            try
            {
                if (Session["dt"] == null)
                {
                    if(lstUser.Rows.Count > 0)
                    {
                        Session["dt"] = lstUser;
                    }
                    grvRpt.DataSource = lstUser;

                }
                else
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)Session["dt"];
                    grvRpt.DataSource = lstUser;

                }
            }
            catch (Exception ex)
            {
            }

        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pfd_ID").ToString();

                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DelConfim();</script>", false);
            }
        }



        protected void AddRange_Click(object sender, EventArgs e)
        {

            if ((rdColumnName.SelectedValue.ToString() == ""))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureRange();</script>", false);

            }
            else if ((dllmultisettings.CheckedItems.Count==0) && (dllmultisettings.Visible == true))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureRange();</script>", false);

            }
            else if((dllSettingsText.SelectedValue.ToString() == "") && (dllSettingsText.Visible == true))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureRange();</script>", false);
            }

            else { 


                // Get values from textboxes and dropdowns
                string table = ddlTable.SelectedValue.ToString();
                string colum = rdColumnName.SelectedValue.ToString();
                string columtext = rdColumnName.Text;
                string value = "";
                string valuetext = "";
                if (ViewState["Answer"].ToString() == "S")
                {
                    value = dllSettingsText.SelectedValue.ToString();
                    valuetext = dllSettingsText.Text;
                }
                else
                {
                    value = ConcatColumns();
                    valuetext = ConcatColumnstext();
                }
                bool isValid = true;

                // Get the existing DataTable from RadGrid or create a new one
                DataTable dt = new DataTable();
                try
                {
                    if (Session["dt"] != null)
                    {
                        dt = (DataTable)Session["dt"];
                    }
                    else
                    {
                        dt.Columns.Add("pfd_ID", typeof(string));
                        dt.Columns.Add("pfd_SettingsName", typeof(string));
                        dt.Columns.Add("pfd_Columns", typeof(string));
                        dt.Columns.Add("pfd_ValueText", typeof(string));
                        dt.Columns.Add("pfd_Values", typeof(string));
                        dt.Columns.Add("pfd_type", typeof(string));



                    }



                    // If the condition is met for all rows, add the new row
                    
                        DataRow newRow = dt.NewRow();
                        if (dt.Rows.Count > 0)
                        {
                            DataRow lastRow = dt.Rows[dt.Rows.Count - 1];
                            int lastID = Convert.ToInt32(lastRow["pfd_ID"]);
                            newRow["pfd_ID"] = (lastID + 1).ToString();
                        }
                        else
                        {
                            newRow["pfd_ID"] = "1";
                        }
                        newRow["pfd_SettingsName"] = columtext;
                        newRow["pfd_Columns"] = colum;
                        newRow["pfd_ValueText"] = valuetext;
                        newRow["pfd_Values"] = value;
                        newRow["pfd_type"] = ViewState["Answer"].ToString();




                        dt.Rows.Add(newRow);
                        Session["dt"] = dt;

                        DataTable dtt = (DataTable)Session["dt"];
                        grvRpt.DataSource = dtt;
                        grvRpt.Rebind();
                    
                    
                }
                catch (Exception ex)
                {

                }



                rdColumnName.ClearSelection();

                dllSettingsText.ClearSelection();

                dllmultisettings.ClearCheckedItems();
                dllmultisettings.Items.Clear();
                dllmultisettings.ClearCheckedItems();
                dllmultisettings.DataSource = null;
                dllmultisettings.DataBind();


                column(" where pfm_tableName='" + table + "'");
                Session["Master"] = ddlTable.SelectedValue;
            }
        }

        public string ConcatColumns()
        {
            string retStr = "";
            var checkedItems = dllmultisettings.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }
        public string ConcatColumnstext()
        {
            string retStr = "";
            var checkedItems = dllmultisettings.CheckedItems;
            if (checkedItems.Count == 0)
            {
                return "";
            }

            foreach (var item in checkedItems)
            {
                retStr += item.Text.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1); // Remove the trailing '-'
            return retStr;
        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            try
            {
                if (Session["dt"] != null)
                {
                    DataTable dt = (DataTable)Session["dt"];
                    DataRow rowToDelete = dt.Select("pfd_ID = '" + id + "'").FirstOrDefault();
                    if (rowToDelete != null)
                    {
                        dt.Rows.Remove(rowToDelete);
                        Session["dt"] = dt;


                        DataTable dtt = (DataTable)Session["dt"];
                        grvRpt.DataSource = dtt;
                        grvRpt.Rebind();
                    }
                    column(" where pfm_tableName='" + ddlTable.SelectedValue.ToString() + "'");

                }

            }
            catch (Exception ex)
            {

            }


        }
        protected void btndeletecancel_click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            try
            {
                if (Session["dt"] != null)
                {
                    DataTable dt = (DataTable)Session["dt"];
                    DataTable dtt = (DataTable)Session["dt"];
                    grvRpt.DataSource = dtt;
                    grvRpt.Rebind();

                }

            }
            catch (Exception ex)
            {

            }


        }

        public string GetSelectedItemsFromGrid(string id)
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("Rows");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {

                        
                        string pfd_pfh_ID = id.ToString();
                        string pfd_SettingsName = item["pfd_SettingsName"].Text;
                        string pfd_Columns = item["pfd_Columns"].Text;
                        string pfd_ValueText = item["pfd_ValueText"].Text;
                        string pfd_Values = item["pfd_Values"].Text;
                        string pfd_type = item["pfd_type"].Text;
                        createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns,  pfd_ValueText, pfd_Values, pfd_type,writer);
                        c++;
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                }

                if (c == 0)
                {
                    return null;
                }
                else
                {
                    return sw.ToString();
                }
            }
        }

        private void createNode(string pfd_pfh_ID, string pfd_SettingsName, string pfd_Columns,  string pfd_ValueText, string pfd_Values,string pfd_type, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writeElement(writer, "pfd_pfh_ID", pfd_pfh_ID);
            writeElement(writer, "pfd_SettingsName", pfd_SettingsName);
            writeElement(writer, "pfd_Columns", pfd_Columns);
            writeElement(writer, "pfd_ValueText", pfd_ValueText);
            writeElement(writer, "pfd_Values", pfd_Values);
            writeElement(writer, "pfd_type", pfd_type);
            writer.WriteEndElement();
        }

        private void writeElement(XmlWriter writer, string elementName, string elementValue)
        {
            writer.WriteStartElement(elementName);
            writer.WriteString(elementValue);
            writer.WriteEndElement();
        }

        protected void rdColumnValue_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        

        protected void rdColumnName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox comboBox = (RadComboBox)sender;
            string ID = comboBox.SelectedValue;
            ViewState["ID"] = ID.ToString();
            DataTable dts = ObjclsFrms.loadList("SelSettingsAnswerType", "sp_ProfileSettings", ID.ToString());
            string Answer = dts.Rows[0]["pfm_Type"].ToString();
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

            Values(Answer);
        }

        protected void Values(string Column)
        {
            DataTable dts = ObjclsFrms.loadList("SelValuesDropdown", "sp_ProfileSettings", ViewState["ID"].ToString());
            if (Column == "S")
            {
                dllSettingsText.DataSource = dts;
                dllSettingsText.DataTextField = "pfm_ValueText";
                dllSettingsText.DataValueField = "pfm_ColumnValue";
                dllSettingsText.DataBind();
            }
            else
            {
                dllmultisettings.DataSource = dts;
                dllmultisettings.DataTextField = "pfm_ValueText";
                dllmultisettings.DataValueField = "pfm_ColumnValue";
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

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectProfileHeaderByID", "sp_ProfileSettings", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            { 
                ddlTable.SelectedValue= lstDatas.Rows[0]["pfh_TableName"].ToString();
                txtprofName.Text= lstDatas.Rows[0]["pfh_ProfileName"].ToString();
                string status = lstDatas.Rows[0]["Status"].ToString().Trim();
                if (status=="Y")
                {
                    chkActive.Checked = true;
                }
                else
                {
                    chkActive.Checked= false;
                }
            }
            if (ResponseID.ToString() != "0")
            {
                ddlTable.Enabled = false;
            }
        }
        public void LoadLists()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectProfileHeaderByID", "sp_ProfileSettings", ResponseID.ToString());
            try
            {
                if (Session["dt"] == null)
                {
                    Session["dt"] = lstUser;
                    grvRpt.DataSource = lstUser;

                }
                else
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)Session["dt"];
                    grvRpt.DataSource = lstUser;

                }
            }
            catch (Exception ex)
            {
            }

        }

        protected void txtprofName_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtprofName.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckProfileName", "sp_ProfileSettings", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "ProfileName  Already Exist";
                lblCodeDupli.Visible = true;
            }
            else
            {
                lblCodeDupli.Visible = false;
            }
        }

        protected void ddlTable_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox comboBox = (RadComboBox)sender;
            string ID = comboBox.SelectedValue;
            try
            {
                if (Session["dt"] != null && ((DataTable)Session["dt"]).Rows.Count > 0)
                {
                    if (Session["Master"]!=null)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ChangeConfirm();</script>", false);
                    }
                    else
                    {
                        string condition = " where pfm_tableName='" + ID + "'";
                        rdColumnName.ClearSelection();
                        column(condition);
                    }
                }
                else
                {
                    string condition = " where pfm_tableName='" + ID + "'";
                    rdColumnName.ClearSelection();
                    column(condition);

                }
            }
            catch (Exception ex)
            {

            }


        }
        protected void ChangeMasterCancel_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModalChange();</script>", false);
            ddlTable.SelectedValue = Session["Master"].ToString();


        }

        protected void ChangeMasterProceed_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModalChange();</script>", false);
            Session["dt"] = null;
            grvRpt.DataSource = null;
            grvRpt.DataBind();
            rdColumnName.ClearSelection();
            string condition = " where pfm_tableName='" + ddlTable.SelectedValue.ToString() + "'";
            column(condition);
        }
    }
}