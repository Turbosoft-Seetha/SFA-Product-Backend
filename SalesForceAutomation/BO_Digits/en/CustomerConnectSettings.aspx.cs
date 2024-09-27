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
                //ListChildNodes();
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
            // Join the selected parent nodes into a comma-separated string for your stored procedure
            string parentNodesParam = string.Join(",", parentNodes);

            // Fetch the child nodes based on selected parent nodes
            DataTable lstchild = ObjclsFrms.loadList("SelChildNodesbyParent", "sp_CusConSettings", parentNodesParam);

            if (lstchild.Rows.Count > 0)
            {
                ddlChiNode.DataSource = lstchild;
                ddlChiNode.DataValueField = "node";
                ddlChiNode.DataTextField = "descr";
                ddlChiNode.DataBind();
            }
            else
            {
                ddlChiNode.Items.Clear();  // Clear child nodes if no data is found
            }
        }


        protected void ddlParNode_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            // Create a list to store selected parent node values
            List<string> selectedParentNodes = new List<string>();

            // Iterate over the checked items in the RadComboBox
            foreach (RadComboBoxItem item in ddlParNode.CheckedItems)
            {
                selectedParentNodes.Add(item.Value);  // Get the value of each selected parent node
            }

            // Call ListChildNodes and pass the selected parent nodes
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

            string[] arr = { Nodes, UICommon.GetCurrentUserID().ToString() };
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

                    string selectedParentValue = ddlParNode.SelectedValue;
                    string selectedChildValue = ddlChiNode.SelectedValue;

                    if (!string.IsNullOrEmpty(selectedParentValue))
                    {
                        if (string.IsNullOrEmpty(selectedChildValue))
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);
                        }
                        else
                        {                           
                            createDropdownNode(selectedParentValue, selectedChildValue, writer);
                            c++;
                        }
                    }

                    writer.WriteEndElement(); // End 'r' element
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

        
    }
}