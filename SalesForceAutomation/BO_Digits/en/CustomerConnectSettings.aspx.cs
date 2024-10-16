using DocumentFormat.OpenXml.Wordprocessing;
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
using Telerik.Web.UI.Chat;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerConnectSettings : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int UID
        {
            get
            {
                int UID;
                int.TryParse(Request.Params["UID"], out UID);
                return UID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ListParentNodes();               
            }
        }
        public void ListParentNodes()
        {
            DataTable lstchild = ObjclsFrms.loadList("SelParentNodes", "sp_CusConSettings");
            if (lstchild.Rows.Count > 0)
            {
                ddlParNode.DataSource = lstchild;
                ddlParNode.DataValueField = "node";
                ddlParNode.DataTextField = "descr";
                ddlParNode.DataBind();
            }
        }
        public void ListChildNodes(List<string> parentNodes)
        {
            string parentNodesParam = string.Join(",", parentNodes.Select(p => $"'{p}'"));
            string user = Request.Params["UID"].ToString();
            string[] arr = { user.ToString() };

            DataTable lstchild = ObjclsFrms.loadList("SelChildNodesbyParent", "sp_CusConSettings", parentNodesParam, arr);
            if (lstchild.Rows.Count > 0)
            {
                ddlChiNode.DataSource = lstchild;
                ddlChiNode.DataValueField = "node";
                ddlChiNode.DataTextField = "descr";
                ddlChiNode.DataBind();
            }
            else
            {
                ddlChiNode.Items.Clear();
            }
        }
        protected void ddlParNode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            List<string> selectedParentNodes = new List<string>();
            foreach (RadComboBoxItem item in ddlParNode.CheckedItems)
            {
                selectedParentNodes.Add(item.Value);
            }
            if (selectedParentNodes.Count > 0)
            {
                ListChildNodes(selectedParentNodes);
            }
        }
        protected void Add_Click(object sender, EventArgs e)
        {
            addTable();
            LoadData();
            grvRpt.DataBind();

        }
        public void addTable()
        {
            string Nodes;
            Nodes = GetSelectedItemsFromDropdowns();
            string user = Request.Params["UID"].ToString();
            string createdby = UICommon.GetCurrentUserID().ToString();
            string[] arr = { Nodes, createdby };
            string Value = ObjclsFrms.SaveData("sp_CusConSettings", "InsCusConSettings", user.ToString(), arr);
            int LID = Int32.Parse(Value.ToString());
            if (LID > 0)
            {
                Response.Redirect("CustomerConnectSettings.aspx?UID=" + user);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
            }
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            string user = Request.Params["UID"].ToString();

            lstDatas = ObjclsFrms.loadList("ListCusConSettings", "sp_CusConSettings", user);
            if (lstDatas.Rows.Count > 0)
            {
                grvRpt.DataSource = lstDatas;
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
        }

        public string GetSelectedItemsFromDropdowns()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    var uniqueParentChildSet = new HashSet<string>();
                    var selectedParentItems = ddlParNode.CheckedItems;
                    var selectedChildItems = ddlChiNode.CheckedItems;

                    if (selectedParentItems.Count > 0)
                    {
                        if (selectedChildItems.Count == 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        }
                        else
                        {
                            foreach (var parentItem in selectedParentItems)
                            {
                                string selectedParentValue = parentItem.Value;
                                foreach (var childItem in selectedChildItems)
                                {
                                    string selectedChildValue = childItem.Value;
                                    string uniqueKey = $"{selectedParentValue}_{selectedChildValue}";
                                    if (!uniqueParentChildSet.Contains(uniqueKey))
                                    {
                                        uniqueParentChildSet.Add(uniqueKey);
                                        createDropdownNode(selectedParentValue, selectedChildValue, writer);
                                        c++;
                                    }
                                }
                            }
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
        private void createDropdownNode(string ParentNode, string ChildNode, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("ParentNode");
            writer.WriteString(ParentNode);
            writer.WriteEndElement();

            writer.WriteStartElement("ChildNode");
            writer.WriteString(ChildNode);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }
        protected void Remove_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            string user = Request.Params["UID"].ToString();           
            List<string> selectedIDs = new List<string>();
            foreach (GridDataItem item in grvRpt.SelectedItems)
            {
                string ID = item.GetDataKeyValue("ccs_ID").ToString();
                selectedIDs.Add(ID);
            }
            string selectedIDsString = string.Join(",", selectedIDs.ToArray());
            string[] arr = { user };
            string result = ObjclsFrms.SaveData("sp_CusConSettings", "DelCusConSettings", selectedIDsString, arr);

            int LID = Int32.Parse(result);
            if (LID > 0)
            {               
                Response.Redirect("CustomerConnectSettings.aspx?UID=" + user);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong, Try again later.');</script>", false);
            }
        }
    }
}