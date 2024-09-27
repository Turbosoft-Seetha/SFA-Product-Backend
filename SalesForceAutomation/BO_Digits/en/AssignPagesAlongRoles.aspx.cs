using Ecosoft.DAL;
using OfficeOpenXml.Packaging.Ionic.Zlib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;
using Telerik.Pdf;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AssignPagesAlongRoles : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SelRoleName();
                this.LoadRoles();
                this.LoadSecurity();
                this.LoadAssigned();
            }
        }       

        public string ResponseID
        {
            get
            {
                return Request.Params["ID"] ?? string.Empty;
            }
        }

        private string SelRoleName()
        {
            DataTable lstRole = ObjclsFrms.loadList("SelRoleName", "sp_LeftNavigation", ResponseID.ToString());
            if (lstRole.Rows.Count > 0)
            {
                string RoleName = lstRole.Rows[0]["RoleName"].ToString(); 
                return RoleName;
            }
            return null; 
        }

        protected void treeSecurity_NodeClick(object sender, RadTreeNodeEventArgs e)
        {
            string facID = e.Node.Value;

            foreach (ListItem role in this.chkRoles.Items)
            {
                role.Selected = false;
            }

            DataTable dt = ObjclsFrms.loadList("SelPageRoles", "sp_LeftNavigation", facID);
            string roleName = dt.Rows[0]["Roles"].ToString();
            foreach (string role in roleName.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
            {
                if (chkRoles.Items.FindByText(role) != null)
                {
                    chkRoles.Items.FindByText(role).Selected = true;
                }
            }
        }

        protected void chkRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int facID = int.Parse(treeSecurity.SelectedNode.Value);
                var selectedRoles = new List<string>();
                var removedRoles = new List<string>();

                foreach (ListItem listItem in chkRoles.Items)
                {
                    if (listItem.Selected)
                    {
                        selectedRoles.Add(listItem.Text);
                    }
                    else
                    {
                        removedRoles.Add(listItem.Text); 
                    }
                }
                if (selectedRoles.Any())
                {
                    string[] arr = { string.Join(",", selectedRoles) };
                    ObjclsFrms.loadList("updNavigationFromAssignPage", "sp_LeftNavigation", facID.ToString(), arr);
                }
                if (removedRoles.Any())
                {
                    string[] arrRemoved = { string.Join(",", removedRoles) };
                    ObjclsFrms.loadList("removeRolesFromPage", "sp_LeftNavigation", facID.ToString(), arrRemoved);
                }

                this.LoadAssigned();
                pnlAssigned.Update();
            }
            catch (Exception ex)
            {
                
            }
        }


        private void LoadRoles()
        {
            DataTable dt = ObjclsFrms.loadList("SelRoleName", "sp_LeftNavigation", ResponseID.ToString());
            foreach (DataRow dr in dt.Rows)
            {
                this.chkRoles.Items.Add(dr["RoleName"].ToString());
            }
        }

        private void LoadSecurity()
        {            
            DataTable dt = ObjclsFrms.loadList("SelMainPages", "sp_LeftNavigation");
            this.treeSecurity.Nodes.Clear();

            foreach (DataRow dr in dt.Rows)
            {
                RadTreeNode treeNode = this.GetTreeNode(dr["Name"].ToString(), dr["fac_ID"].ToString());

                if (dr["Position"].ToString() == "-1")
                {
                    treeNode.ImageUrl = "../assets/media/Security/section.png";
                }
                else
                {
                    treeNode.ImageUrl = "../assets/media/Security/folder.png";
                }


                this.treeSecurity.Nodes.Add(treeNode);

                this.AddTreeNode(treeNode, dr["fac_ID"].ToString());
            }


        }

        private RadTreeNode GetTreeNode(string title, string value)
        {
            RadTreeNode treeNode = new Telerik.Web.UI.RadTreeNode();

            treeNode.Text = title;
            treeNode.Value = value;

            return treeNode;
        }
        private void AddTreeNode(RadTreeNode parentTreeNode, string facID)
        {
            DataTable dt = ObjclsFrms.loadList("SelChildNodes", "sp_LeftNavigation", facID);
            try
            {
                if (dt.Rows.Count == 0)
                {
                    return;
                }
            }
            catch (Exception ex)
            {
                return;
            }

            foreach (DataRow dr in dt.Rows)
            {
                RadTreeNode treeNode = this.GetTreeNode(dr["Name"].ToString(), dr["fac_ID"].ToString());
                if (dr["Position"].ToString() == "1")
                {
                    treeNode.ImageUrl = "../assets/media/Security/subFolder.png";
                }
                else
                {
                    treeNode.ImageUrl = "../assets/media/Security/file.png";
                }
                parentTreeNode.Nodes.Add(treeNode);

                this.AddTreeNode(treeNode, dr["fac_ID"].ToString());
            }
        }

        protected void treeAssigned_NodeClick(object sender, RadTreeNodeEventArgs e)
        {

        }
        private void LoadAssigned()
        {
            string Roleid = SelRoleName();
            DataTable dt = ObjclsFrms.loadList("SelMainPagesAssigned", "sp_LeftNavigation", Roleid.ToString());
            treeAssigned.Nodes.Clear();

            foreach (DataRow dr in dt.Rows)
            {
                RadTreeNode treeNode = this.GetTreeNode(dr["Name"].ToString(), dr["fac_ID"].ToString());
                treeNode.ImageUrl = dr["Position"].ToString() == "-1" ? "../assets/media/Security/section.png" : "../assets/media/Security/folder.png";
                treeAssigned.Nodes.Add(treeNode);
                AddTreeNodeAssigend(treeNode, dr["fac_ID"].ToString());
            }
            treeAssigned.DataBind(); 
        }

        private void AddTreeNodeAssigend(RadTreeNode parentTreeNode, string facID)
        {
            string Roleid = SelRoleName();
            string[] arr = { Roleid.ToString() };
            DataTable dt = ObjclsFrms.loadList("SelChildNodesAssigned", "sp_LeftNavigation", facID, arr);
            try
            {
                if (dt.Rows.Count == 0)
                {
                    return;
                }
            }
            catch (Exception ex)
            {
                return;
            }

            foreach (DataRow dr in dt.Rows)
            {
                RadTreeNode treeNode = this.GetTreeNode(dr["Name"].ToString(), dr["fac_ID"].ToString());
                if (dr["Position"].ToString() == "1")
                {
                    treeNode.ImageUrl = "../assets/media/Security/subFolder.png";
                }
                else
                {
                    treeNode.ImageUrl = "../assets/media/Security/file.png";
                }
                parentTreeNode.Nodes.Add(treeNode);

                this.AddTreeNode(treeNode, dr["fac_ID"].ToString());
            }
        }

    }
}