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
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AssignProducts : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            { 
                try
                {
                    GetGridSession1(ProductGrid, "AssProd");
                    GetGridSession2(RadGrid1, "AssProd");
                    GetGridSession3(grvRpt, "AssProd");

                    ProductGrid.Rebind();
                    RadGrid1.Rebind();
                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

            }
        }
        
        public void SaveData()
        {
            string route = GetItemFromGrid();
            string product = GetProductFromGrid();
            RadNumericTextBox Highperc = (RadNumericTextBox)RadAjaxPanel3.FindControl("higherLimit");
            RadNumericTextBox Lowperc = (RadNumericTextBox)RadAjaxPanel3.FindControl("lowerLimit");


            if (string.IsNullOrWhiteSpace(Highperc.Text) || string.IsNullOrWhiteSpace(Lowperc.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailModal('Both High and Low percentages are mandatory');</script>", false);
            }
            else
            {
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    try
                    {

                        string HighPerc = Highperc.Text.ToString();
                        string LowPerc = Lowperc.Text.ToString();
                        string user = UICommon.GetCurrentUserID().ToString();
                        string[] arr = { HighPerc, LowPerc , user, product.ToString()};
                        string Value = obj.SaveData("sp_Merchandising", "AssignRouteProduct", route, arr);
                        int res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Product Added successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                        }


                    }
                    catch (Exception ex)
                    {

                    }
                }
            }
            
        }
        
        public void List()
        {
            string routesSelected = "";
            routesSelected = GetProductFromGrid();
           
            if (routesSelected== null)
            {
                DataTable emptyTable = new DataTable();
                grvRpt.DataSource = emptyTable;
            }
            else
            {
                DataTable lstdata = obj.loadList("AssignedProducts", "sp_Merchandising", routesSelected.ToString());
                if (lstdata.Rows.Count > 0)
                {
                    grvRpt.DataSource = lstdata;
                }
                else
                {
                    DataTable emptyTable = new DataTable();
                    grvRpt.DataSource = emptyTable;
                }
            }
            
        }
        public void Loaddata()
        {
            string prodSelected = "";
            prodSelected = GetProductFromGrid();
           
            if (prodSelected == null)
            {                
                DataTable emptyTable = new DataTable();
                RadGrid1.DataSource = emptyTable;
            }
            else
            {
                DataTable lstdata = obj.loadList("UnAssignedRoutesperProduct", "sp_Merchandising", prodSelected.ToString());
                if (lstdata.Rows.Count > 0)
                {
                    RadGrid1.DataSource = lstdata;
                }
                else
                {
                    DataTable emptyTable = new DataTable();
                    RadGrid1.DataSource = emptyTable;
                }
            }
            
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        public void Delete()
        {
            try
            {
                string ropid = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = obj.SaveData("sp_Merchandising", "DeletePro", ropid.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteFailed('Some fields are missing ');</script>", false);
                }
            }
            catch (Exception ex)
            {

            }


        }
        public string GetItemFromGrid2()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");

                    DataTable dsc = new DataTable();
                    foreach (GridDataItem dr in grvRpt.SelectedItems)
                    {

                        string rop_ID = dr.GetDataKeyValue("rop_ID").ToString();

                        createNode2(rop_ID, writer);
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
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode2(string rop_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("rop_ID");
            writer.WriteString(rop_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw, new XmlWriterSettings { OmitXmlDeclaration = false }))
                {
                    writer.WriteStartElement("r");

                    var selectedItems = RadGrid1.SelectedItems;

                    foreach (GridDataItem dr in selectedItems)
                    {
                        string rot_ID = dr.GetDataKeyValue("rot_ID").ToString();
                        createNode(rot_ID, writer);
                    }

                    writer.WriteEndElement();
                }

                string resultXml = sw.ToString();
                return resultXml;
            }
        }

        private void createNode(string rot_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        public string GetProductFromGrid()
        {
            var selectedItems = ProductGrid.SelectedItems;
            
            if (selectedItems == null || selectedItems.Count == 0)
            {
                return null;
            }
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw, new XmlWriterSettings { OmitXmlDeclaration = false }))
                {
                    writer.WriteStartElement("r");

                    foreach (GridDataItem dr in selectedItems)
                    {
                        string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                        createNodeRot(prd_ID, writer);
                    }

                    writer.WriteEndElement(); 
                }
                string resultXml = sw.ToString();
                return resultXml;
            }
        }

        private void createNodeRot(string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void LinkButton2Delete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            Delete();
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {           
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.ToString(), true);
        }


        protected void failPerc_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            List();
            Loaddata();
        }
        
        protected void ProductGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable lstdata = obj.loadList("SelectProducts", "sp_Merchandising");
            if (lstdata.Rows.Count > 0)
            {
                ProductGrid.DataSource = lstdata;
            }
            else
            {
                ProductGrid.DataSource = null;
            }
        }

        protected void Search_Click(object sender, EventArgs e)
        {            
            List();
            grvRpt.Rebind();
            Loaddata();
            RadGrid1.Rebind();
        }

        public void SetGridSession1(RadGrid grd, string SessionPrefix)
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
        public void GetGridSession1(RadGrid grd, string SessionPrefix)
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
                    ProductGrid.MasterTableView.FilterExpression = filterExpression;
                }
            }
            catch (Exception ex)
            {

            }
        }
        public void SetGridSession2(RadGrid grd, string SessionPrefix)
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
        public void GetGridSession2(RadGrid grd, string SessionPrefix)
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
                    RadGrid1.MasterTableView.FilterExpression = filterExpression;
                }
            }
            catch (Exception ex)
            {

            }
        }
        public void SetGridSession3(RadGrid grd, string SessionPrefix)
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
        public void GetGridSession3(RadGrid grd, string SessionPrefix)
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
    }
}