using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListAppWebservices : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        public int SID
        {
            get
            {
                int SID;
                int.TryParse(Request.Params["SId"], out SID);

                return SID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rottype();
                try
                {
                    GetGridSession(grvRpt, "MaterialRequest");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                ViewState["DeleteID"] = null;
                ViewState["delcode"] = null;
            }
        }
        public void LoadData()
        {

            DataTable dt = obj.loadList("SelectAppWebservicesforweb", "sp_SFA_App");
            grvRpt.DataSource = dt;

        }
        public void rottype()
        {
            DataTable dt = obj.loadList("selectrottype", "sp_SFA_App");
            ddlrottype.DataSource = dt;
            ddlrottype.DataTextField = "rot_Type";
            ddlrottype.DataValueField = "rot_Type";
            ddlrottype.DataBind();
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void ddlrottype_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                RadGrid grd = (RadGrid)sender;
                SetGridSession(grd, "Appwebservices");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                ViewState["delcode"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("aws_ID").ToString();
                string code = dataItem["aws_Code"].Text;
                ViewState["DeleteID"] = ID;
                ViewState["delcode"] = code; 
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }
        public void SetGridSession(RadGrid grd, string SessionPrefix)
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
                Response.Redirect("~/SignIn.aspx");
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
                Response.Redirect("~/SignIn.aspx");
            }
        }
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    DataTable dsc = new DataTable();
                    var CollectionMarket1 = ddlrottype.CheckedItems;
                    
                    int MarCount = CollectionMarket1.Count;
                    if (CollectionMarket1.Count > 0)
                    {
                        foreach (var item in CollectionMarket1)
                        {
                            string rot_type = item.Value;

                            createNode(rot_type, writer);
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
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode(string rot_type, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("rot_type");
            writer.WriteString(rot_type);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {
            try
            {
                string rottype = GetItemFromGrid();
                string ws, user, status;
               
                user = UICommon.GetCurrentUserID().ToString();
                status = ddlStatus.SelectedValue.ToString();
                ws = txtWs.Text.ToString();

                string[] arr = { user.ToString(), status.ToString(), ws.ToString() };
                string Value = obj.SaveData("sp_SFA_App", "InsertAppWebservicesforweb", rottype, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
                

            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                obj.LogMessageToFile(UICommon.GetLogFileName(), "ListAppWebservices.aspx ", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
           // Response.Redirect("ListAppWebservices.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {

        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {
           string ID= ViewState["DeleteID"].ToString();
            string code = ViewState["delcode"].ToString();
            string[] arr = {code };

            string Value = obj.SaveData("sp_SFA_App", "deleteAppwebservice", ID, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Deleted Successfully..');</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);

            }

          //  Response.Redirect("ListAppWebservices.aspx");

        }
    }
}