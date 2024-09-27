using DocumentFormat.OpenXml.Drawing.Spreadsheet;
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

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AssignRoutesForProduct : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ProductName();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);

                return ResponseID;
            }
        }
        public void SaveData()
        {
            string Routes = GetItemFromGrid();
            string product = ResponseID.ToString();
            RadNumericTextBox Highperc = (RadNumericTextBox)RadAjaxPanel3.FindControl("higherLimit");
            RadNumericTextBox Lowperc = (RadNumericTextBox)RadAjaxPanel3.FindControl("lowerLimit");
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(Highperc.Text) || string.IsNullOrWhiteSpace(Lowperc.Text))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailModal('Both High and Low percentages are mandatory');</script>", false);
                    }
                    else
                    {
                        string HighPerc = Highperc.Text.ToString();
                        string LowPerc = Lowperc.Text.ToString();
                        string user = UICommon.GetCurrentUserID().ToString();
                        string[] arr = { product, HighPerc, LowPerc, user };
                        string Value = obj.SaveData("sp_Merchandising", "AssignRoutesForProduct", Routes, arr);
                        int res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Route Added successfully');</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                        }
                    }

                }
                catch (Exception ex)
                {

                }
            }
        }
        public void ProductName()
        {
            DataTable dt = obj.loadList("GetProductName", "sp_Merchandising", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string rotname = dt.Rows[0]["prd_Name"].ToString();
                Proroute.Text = "Product : " + rotname;
            }            

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("AssignedRoutes", "sp_Merchandising", ResponseID.ToString());
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
        public void Loaddata()
        {
            DataTable lstdata = obj.loadList("UnAssignedRoutes", "sp_Merchandising", ResponseID.ToString());
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
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = RadGrid1.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string rot_ID = dr.GetDataKeyValue("rot_ID").ToString();

                            createNode(ResponseID.ToString(), rot_ID, writer);
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
        private void createNode(string Product, string rot_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssignRoutesForProduct.aspx?id=" + ResponseID.ToString());
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
            Response.Redirect("AssignRoutesForProduct.aspx?id=" + ResponseID.ToString());
        }
        protected void failPerc_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}