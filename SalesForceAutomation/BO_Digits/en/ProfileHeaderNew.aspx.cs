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
    public partial class ProfileHeaderNew : System.Web.UI.Page
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
                btnSave.Attributes.Add("Style", "font-weight:normal font-size:10px");
                btnCancel.Attributes.Add("Style", "font-weight:normal font-size:10px");
                Session["dt"] = null;
                ViewState["image"] = null;
                table();
                FillForm();
                if (!ResponseID.Equals("") || ResponseID != 0)
                {
                    LoadList();
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
                bool anySelected = false;
                foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                {
                    
                    RadCheckBoxList cbl = (RadCheckBoxList)item.FindControl("cbl");
                    RadRadioButtonList rbl = (RadRadioButtonList)item.FindControl("rbl");
                    RadNumericTextBox tn= (RadNumericTextBox)item.FindControl("txtN");
                    RadTextBox tt=(RadTextBox)item.FindControl("txtT");
                    string pfmType = item["pfm_type"].Text;

                    if (pfmType == "M")
                    {
                        if (cbl != null)
                        {
                            foreach (ButtonListItem li in cbl.Items)
                            {
                                if (li.Selected)
                                {
                                    anySelected = true;
                                    break; // Exit the loop if an item is selected
                                }
                            }
                        }
                    }
                    else if (pfmType == "S")
                    {
                        if (rbl != null && rbl.SelectedItem != null)
                        {
                            anySelected = true;
                        }
                    }
                    else if(pfmType == "T")
                    {
                        if (tt.Text != "")
                        {
                            anySelected = true;
                        }
                    }
                    else if (pfmType == "N")
                    {
                        if (tn.Text != "")
                        {
                            anySelected = true;
                        }
                    }


                    if (anySelected)
                    {
                        break;
                    }
                }

                if (anySelected)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureSave();</script>", false);
                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService("Profile Save Issue is : "+ex.Message.ToString());
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
            string prof = txtprofName.Text;
            string table = ddlTable.SelectedValue.ToString();
            string status;
            string user = UICommon.GetCurrentUserID().ToString();
            string code=txtcode.Text;
            if (chkActive.Checked == true)
            {
                status = "Y";
            }
            else
            {
                status = "N";
            }

            try
            {
                if (ResponseID.Equals("") || ResponseID == 0)
                {
                    prr = GetSelectedItemsFromGrid("");
                    string[] arr = { table, user, status,code,prr };
                    string Value = ObjclsFrms.SaveData("sp_ProfileSettings", "InsProfileHeader", prof, arr);
                    int res = Int32.Parse(Value.ToString());

                    if (res > 0)
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
                    string id = ResponseID.ToString();
                    prr = GetSelectedItemsFromGrid(id);
                    string[] ar = { id.ToString(), user };
                    string[] arr = { table, id, user, status, prr,code };
                    string Value = ObjclsFrms.SaveData("sp_ProfileSettings", "UpdateProfile", prof, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        try
                        {
                            
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
                            ObjclsFrms.TraceService("Profile Save Issue is : " + ex.Message.ToString());
                        }

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ObjclsFrms.TraceService("Profile Save Issue is : " + ex.Message.ToString());
            }

        }

        protected void table()
        {
            DataTable dt = ObjclsFrms.loadList("SelTableforDropdown", "sp_ProfileSettings");
            ddlTable.DataSource = dt;
            ddlTable.DataTextField = "pfm_Table";
            ddlTable.DataValueField = "pfm_tableName";
            ddlTable.DataBind();
        }


       






        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
           
            LoadList();
        }


        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            string id;
            if (ddlTable.SelectedValue.ToString() != "")
            {
                id= ddlTable.SelectedValue.ToString();
            }
            else
            {
                id = "0";
            }
            lstUser = ObjclsFrms.loadList("SelectSettingsfromMaster", "sp_ProfileSettings",id);
            DataTable lstSettings = default(DataTable);
            string hid;
            hid = ResponseID.ToString();
            lstSettings = ObjclsFrms.loadList("SelectProfileDetailsNew", "sp_ProfileSettings", hid);


            try
            {
                Session["lstSettings"] = lstSettings;
                grvRpt.DataSource = lstUser;

            }
            catch (Exception ex)
            {
            }

        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            
        }



        

              
        

        public string GetSelectedItemsFromGridOld(string id)
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
                        string pfd_SettingsName = item["pfm_Settingname"].Text;
                        string pfd_Columns = item["pfm_ColumnName"].Text;
                        string pfd_ValueText = item["pfm_ValueText"].Text;
                        string pfd_Values = item["pfm_ColumnValue"].Text;
                        string pfd_type = item["pfm_type"].Text;
                        string pfm_id = item.GetDataKeyValue("pfm_ID").ToString();
                        createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns, pfd_ValueText, pfd_Values, pfd_type,pfm_id, writer);
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


       

      

       

        

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectProfileHeaderByID", "sp_ProfileSettings", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                ddlTable.SelectedValue = lstDatas.Rows[0]["pfh_TableName"].ToString();
                txtprofName.Text = lstDatas.Rows[0]["pfh_ProfileName"].ToString();
                txtcode.Text= lstDatas.Rows[0]["pfh_Code"].ToString();
                string status = lstDatas.Rows[0]["Status"].ToString().Trim();
                if (status == "Y")
                {
                    chkActive.Checked = true;
                }
                else
                {
                    chkActive.Checked = false;
                }
            }
            if (ResponseID.ToString() != "0")
            {
                ddlTable.Enabled = false;
            }
        }
        


        protected void ddlTable_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox comboBox = (RadComboBox)sender;
            string ID = comboBox.SelectedValue;
            try
            {
                LoadList();
                grvRpt.Rebind();
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


       

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                RadCheckBoxList cbl = (RadCheckBoxList)dataItem.FindControl("cbl");
                RadRadioButtonList rbl = (RadRadioButtonList)dataItem.FindControl("rbl");
                RadNumericTextBox tn = (RadNumericTextBox)dataItem.FindControl("txtN");
                RadTextBox tt = (RadTextBox)dataItem.FindControl("txtT");


                string pfm_id = dataItem.GetDataKeyValue("pfm_ID").ToString();

                string pfmType = dataItem["pfm_type"].Text;
                string pfmValueText = dataItem["pfm_ValueText"].Text;
                string pfmColumn = dataItem["pfm_ColumnValue"].Text;

                string pfm_delimiter = dataItem["pfm_delimiter"].Text;

               



                string[] values = pfmValueText.Split('-');
                string[] columns = pfmColumn.Split('-');



                if (pfmType == "S")
                {
                    rbl.Visible = true;
                    for (int i = 0; i < values.Length; i++)
                    {
                        rbl.Items.Add(new ButtonListItem(values[i], columns[i]));
                    }
                }
                else if (pfmType == "M")
                {
                    cbl.Visible = true;
                    for (int i = 0; i < values.Length; i++)
                    {
                        cbl.Items.Add(new ButtonListItem(values[i], columns[i]));
                    }
                }
                else if(pfmType == "T")
                {
                    tt.Visible = true;
                    
                }
                else if( pfmType == "N")
                {
                    tn.Visible = true;
                    
                }
                else if( pfmType == "H")
                {
                    
                    dataItem.CssClass = "gridbold";
                }

                // Set selected items based on lstSettings
                try
                {
                    DataTable lstSettings = (DataTable)Session["lstSettings"];
                    if (lstSettings != null)
                    {
                        DataRow[] rows = lstSettings.Select("pfm_ID = '" + pfm_id + "'");
                        if (rows.Length > 0)
                        {
                            string savedValues = rows[0]["pfm_ColumnValue"].ToString();
                            string[] selectedValues;// = savedValues.Split('-');

                            if (pfm_delimiter == "-")
                            {
                                selectedValues = savedValues.Split('-');
                            }
                            else
                            {
                                selectedValues = savedValues.Split(',');
                            }

                            if (pfmType == "S" && rbl != null)
                            {
                                foreach (ButtonListItem item in rbl.Items)
                                {
                                    if (selectedValues.Contains(item.Value))
                                    {
                                        item.Selected = true;
                                    }
                                }
                            }
                            else if (pfmType == "M" && cbl != null)
                            {
                                foreach (ButtonListItem item in cbl.Items)
                                {
                                    if (selectedValues.Contains(item.Value))
                                    {
                                        item.Selected = true;
                                    }
                                }
                            }
                            else if (pfmType == "T")
                            {
                          
                                tt.Text = savedValues;
                            }
                            else if (pfmType == "N")
                            {
                               
                                tn.Text = savedValues;
                            }
                        }
                    }
                }
                catch(Exception ex)
                {

                }
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
                        string pfd_SettingsName = item["pfm_Settingname"].Text;
                        string pfd_Columns = item["pfm_ColumnName"].Text;
                        string pfm_type = item["pfm_type"].Text;
                        string pfm_delimiter = item["pfm_delimiter"].Text;
                        string pfm_id = item.GetDataKeyValue("pfm_ID").ToString();

                        string pfd_ValueText = "";
                        string pfd_Values = "";

                        RadCheckBoxList cbl = (RadCheckBoxList)item.FindControl("cbl");
                        RadRadioButtonList rbl = (RadRadioButtonList)item.FindControl("rbl");
                        RadNumericTextBox tn = (RadNumericTextBox)item.FindControl("txtN");
                        RadTextBox tt = (RadTextBox)item.FindControl("txtT");

                        if (pfm_type == "S" && rbl != null)
                        {
                            if (rbl.SelectedItem != null)
                            {
                                pfd_ValueText = rbl.SelectedItem.Text;
                                pfd_Values = rbl.SelectedItem.Value;
                                createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns, pfd_ValueText, pfd_Values, pfm_type, pfm_id, writer);
                                c++;
                            }
                        }
                        else if (pfm_type == "M" && cbl != null)
                        {
                            List<string> selectedTexts = new List<string>();
                            List<string> selectedValues = new List<string>();
                            foreach (ButtonListItem li in cbl.Items)
                            {
                                if (li.Selected)
                                {
                                    selectedTexts.Add(li.Text);
                                    selectedValues.Add(li.Value);
                                }
                            }
                            pfd_ValueText = string.Join(pfm_delimiter, selectedTexts);
                            pfd_Values = string.Join(pfm_delimiter, selectedValues);

                            //pfd_ValueText = string.Join("-", selectedTexts);
                            //pfd_Values = string.Join("-", selectedValues);

                            if (pfd_ValueText!= string.Empty)
                            {
                                createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns, pfd_ValueText, pfd_Values, pfm_type, pfm_id, writer);
                                c++;
                            }
                        }
                        else if (pfm_type == "T" && tt.Text != "")
                        {
                            pfd_ValueText = tt.Text;
                            pfd_Values = tt.Text;
                            createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns, pfd_ValueText, pfd_Values, pfm_type, pfm_id, writer);
                            c++;
                        }
                        else if (pfm_type == "N" && tn.Text != "")
                        {
                            pfd_ValueText = tn.Text;
                            pfd_Values = tn.Text;
                            createNode(pfd_pfh_ID, pfd_SettingsName, pfd_Columns, pfd_ValueText, pfd_Values, pfm_type, pfm_id, writer);
                            c++;
                        }


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



        private void createNode(string pfd_pfh_ID, string pfd_SettingsName, string pfd_Columns, string pfd_ValueText, string pfd_Values, string pfd_type, string pfm_id, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writeElement(writer, "pfd_pfh_ID", pfd_pfh_ID);
            writeElement(writer, "pfd_SettingsName", pfd_SettingsName);
            writeElement(writer, "pfd_Columns", pfd_Columns);
            writeElement(writer, "pfd_ValueText", pfd_ValueText);
            writeElement(writer, "pfd_Values", pfd_Values);
            writeElement(writer, "pfd_type", pfd_type);
            writeElement(writer, "pfm_Id", pfm_id);
            writer.WriteEndElement();
        }

        private void writeElement(XmlWriter writer, string elementName, string elementValue)
        {
            writer.WriteStartElement(elementName);
            writer.WriteString(elementValue);
            writer.WriteEndElement();
        }

        protected void rbl_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadRadioButtonList rbl = (RadRadioButtonList)sender;
            GridDataItem item = (GridDataItem)rbl.NamingContainer;

            string selectedValue = rbl.SelectedValue;
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckProfileName", "sp_ProfileSettings", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code  Already Exist";
                lblCodeDupli.Visible = true;
            }
            else
            {
                lblCodeDupli.Visible = false;
            }
        }
    }
}