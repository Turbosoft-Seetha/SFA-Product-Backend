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
    public partial class ListRouteProduct : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }

        public void SaveData()
        {
            string product = GetItemFromGrid();
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
                        string[] arr = { HighPerc, LowPerc, user };
                        string Value = obj.SaveData("sp_Merchandising", "AddRouteProduct", product, arr);
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

                }
                catch (Exception ex)
                {
                   
                }
            }
        }


        public void Route()
        {
            DataTable dt = obj.loadList("RotName", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string rotname = dt.Rows[0]["rot_Name"].ToString();
                Proroute.Text = "Route Name : " + rotname;
            }

        }
        public void List()
        {
            DataTable lstdata = obj.loadList("RouteProduct", "sp_Masters", ResponseID.ToString());
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
            DataTable lstdata = obj.loadList("RotProduct", "sp_Merchandising", ResponseID.ToString());
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
                            string rop_ID = dr.GetDataKeyValue("prd_ID").ToString();
                   
                            createNode(ResponseID.ToString(), rop_ID, writer);
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

        private void createNode(string RouteID, string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rop_rot_ID");
            writer.WriteString(RouteID);
            writer.WriteEndElement();

            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

           
            writer.WriteEndElement();
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRouteProduct.aspx?id=" + ResponseID.ToString());
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
            Response.Redirect("ListRouteProduct.aspx?id=" + ResponseID.ToString());
        }

        protected void failPerc_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}