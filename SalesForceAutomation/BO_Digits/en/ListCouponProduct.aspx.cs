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
    public partial class ListCouponProduct : System.Web.UI.Page
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

        public void List()
        {
            DataTable lstdata = obj.loadList("CouponAssignProduct", "sp_CouponCollection", ResponseID.ToString());
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
            DataTable lstdata = obj.loadList("CouponUnAssignProduct", "sp_CouponCollection", ResponseID.ToString());
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

        public void Route()
        {
            DataTable dt = obj.loadList("SelectCopName", "sp_CouponCollection", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string Copname = dt.Rows[0]["cpm_Name"].ToString();
                ProCop.Text = "Coupon Name : " + Copname;
            }

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
                            string Cop_ID = dr.GetDataKeyValue("prd_ID").ToString();

                            createNode(ResponseID.ToString(), Cop_ID, writer);
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

        private void createNode(string CopID, string Cop_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("cpt_cpm_ID");
            writer.WriteString(CopID);
            writer.WriteEndElement();

            writer.WriteStartElement("prd_ID");
            writer.WriteString(Cop_ID);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }

        public void SaveData()
        {
            string product = GetItemFromGrid();
          
            foreach (GridDataItem item in RadGrid1.SelectedItems)
            {
                try
                {
                   
                   
                    
                        string user = UICommon.GetCurrentUserID().ToString();
                        string[] arr = {  user };
                        string Value = obj.SaveData("sp_CouponCollection", "AddCouponProduct", product, arr);
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


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCouponProduct.aspx?ID=" + ResponseID.ToString());

        }

        public void Delete()
        {
            try
            {
                string ropid = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = obj.SaveData("sp_CouponCollection", "DeleteProduct", ropid.ToString(), arr);

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

                        string cpt_ID = dr.GetDataKeyValue("cpt_ID").ToString();

                        createNode2(cpt_ID, writer);
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
        private void createNode2(string cpt_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cpt_ID");
            writer.WriteString(cpt_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            Delete();
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCouponProduct.aspx?ID=" + ResponseID.ToString());

        }
    }
}