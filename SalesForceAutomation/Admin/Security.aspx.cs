using Ecosoft.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class Security : System.Web.UI.Page
    {
        List<LeftNav> navigations;

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LoadRoles();
                    this.LoadSecurity();
                }
            }
            catch (Exception ex)
            {
                //UICommon.LogException(ex, "Security");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Security.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        private void GetNavigation()
        {
            if (Session["Security_Navigation"] == null)
            {
                navigations = DALHelper.GetLeftNavigation();
                Session["Security_Navigation"] = navigations;
            }
            else
            {
                navigations = Session["Security_Navigation"] as List<LeftNav>;
            }
        }

        private void LoadRoles()
        {
            foreach (var role in Roles.GetAllRoles())
            {
                this.chkRoles.Items.Add(role);
            }
        }

        private void LoadSecurity()
        {
            this.GetNavigation();
            this.treeSecurity.Nodes.Clear();

            foreach (LeftNav leftNav in navigations.Where(nav => nav.Parent == 0).OrderBy(nav => nav.SortOrder))
            {
                RadTreeNode treeNode = this.GetTreeNode(leftNav.Title, leftNav.ID.ToString());

                this.treeSecurity.Nodes.Add(treeNode);

                this.AddTreeNode(treeNode, leftNav);
            }
        }

        private RadTreeNode GetTreeNode(string title, string value)
        {
            RadTreeNode treeNode = new Telerik.Web.UI.RadTreeNode();

            treeNode.Text = title;
            treeNode.Value = value;

            return treeNode;
        }

        private void AddTreeNode(RadTreeNode parentTreeNode, LeftNav currentNavigation)
        {
            var children = navigations.Where(nav => nav.Parent == currentNavigation.ID);

            if (children == null)
            {
                return;
            }

            foreach (LeftNav childNavigation in children.OrderBy(nav => nav.SortOrder))
            {
                var treeNode = this.GetTreeNode(childNavigation.Title, childNavigation.ID.ToString());

                parentTreeNode.Nodes.Add(treeNode);
                this.AddTreeNode(treeNode, childNavigation);
            }
        }


        protected void radSiteMap_NodeDrop(object sender, RadTreeNodeDragDropEventArgs e)
        {
            RadTreeNode sourceNode = e.SourceDragNode;
            RadTreeNode destNode = e.DestDragNode;
            RadTreeViewDropPosition dropPosition = e.DropPosition;

            if (destNode != null) //drag&drop is performed between trees
            {
                if (sourceNode.TreeView.SelectedNodes.Count <= 1)
                {
                    PerformDragAndDrop(dropPosition, sourceNode, destNode);
                }
                else if (sourceNode.TreeView.SelectedNodes.Count > 1)
                {
                    if (dropPosition == RadTreeViewDropPosition.Below) //Needed to preserve the order of the dragged items
                    {
                        for (int i = sourceNode.TreeView.SelectedNodes.Count - 1; i >= 0; i--)
                        {
                            PerformDragAndDrop(dropPosition, sourceNode.TreeView.SelectedNodes[i], destNode);
                        }
                    }
                    else
                    {
                        foreach (RadTreeNode node in sourceNode.TreeView.SelectedNodes)
                        {
                            PerformDragAndDrop(dropPosition, node, destNode);
                        }
                    }
                }

                destNode.Expanded = true;
                sourceNode.TreeView.UnselectAllNodes();
            }
        }

        private static void PerformDragAndDrop(RadTreeViewDropPosition dropPosition, RadTreeNode sourceNode, RadTreeNode destNode)
        {
            if (sourceNode.Equals(destNode) || sourceNode.IsAncestorOf(destNode))
            {
                return;
            }

            if (destNode.ParentNode == null)
            {
                return;
            }

            sourceNode.Owner.Nodes.Remove(sourceNode);

            switch (dropPosition)
            {
                case RadTreeViewDropPosition.Over:
                    // child
                    if (!sourceNode.IsAncestorOf(destNode))
                    {
                        destNode.Nodes.Add(sourceNode);
                    }
                    break;

                case RadTreeViewDropPosition.Above:
                    // sibling - above                         
                    destNode.InsertBefore(sourceNode);
                    break;

                case RadTreeViewDropPosition.Below:
                    // sibling - below
                    destNode.InsertAfter(sourceNode);
                    break;
            }
        }

        protected void treeSecurity_NodeClick(object sender, RadTreeNodeEventArgs e)
        {
            this.GetNavigation();
            var navigation = this.navigations.FirstOrDefault(nav => nav.ID == int.Parse(e.Node.Value));

            foreach (ListItem role in this.chkRoles.Items)
            {
                role.Selected = false;
            }

            foreach (string role in navigation.Roles.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
            {
                if (chkRoles.Items.FindByText(role) != null)
                {
                    chkRoles.Items.FindByText(role).Selected = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception ex)
            {
                // UICommon.LogException(ex, "Security");
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "Security.aspx btnSave_Click()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }

        //Role update module
        protected void chkRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Select current nav node
            this.GetNavigation();
            var navigation = this.navigations.FirstOrDefault(nav => nav.ID == int.Parse(treeSecurity.SelectedNode.Value));

            var selectedRoles = string.Empty;
            //Roles concat logic
            foreach (ListItem listItem in chkRoles.Items)
            {
                if (listItem.Selected)
                {
                    if (string.IsNullOrEmpty(selectedRoles))
                    {
                        selectedRoles = listItem.Text;
                    }
                    else
                    {
                        selectedRoles = selectedRoles + "," + listItem.Text;
                    }
                }
            }

            //Check if roles assigned to the node changed.
            if (navigation != null && selectedRoles != navigation.Roles)
            {
                //Update roles of the selected node
                navigation.Roles = selectedRoles;
                //TODO:Uncomment once the DAL Updated.
                DALHelper.UpdateLeftNav(navigation);
            }
        }
    }
}