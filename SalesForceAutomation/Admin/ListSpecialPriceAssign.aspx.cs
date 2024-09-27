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

namespace SalesForceAutomation.Admin
{
    public partial class ListSpecialPriceAssign : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                rdendDate.SelectedDate = DateTime.Now;
                Route();
                SpecialPrice();
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

       
        public void SpecialPrice()
        {
            DataTable dt = obj.loadList("SpecialPriceName", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string name = dt.Rows[0]["prh_Name"].ToString();
                sp.Text = "Special Price : " + name;
            }

        }
        public void Route()
        {
            DataTable dt = obj.loadList("SelRoute", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

      
        public void List()
        {
            string[] arr = { ResponseID.ToString() };
            DataTable lstdata = default(DataTable);
            lstdata = obj.loadList("AssignedCusSpecialPrice", "sp_Masters", ddlRoute.SelectedValue.ToString(),arr);
            //if (lstdata.Rows.Count > 0)
            //{
            grvRpt.DataSource = lstdata;
            
            //}
        }

        public void Loaddata()
        {
            string[] arr = { ResponseID.ToString() };
            DataTable lstuser = default(DataTable);
            lstuser = obj.loadList("UnAssignedCusSpecialPrice", "sp_Masters", ddlRoute.SelectedValue.ToString(),arr);
            //if (lstdata.Rows.Count > 0)
            //{
                RadGrid1.DataSource = lstuser;

            //}

           
        }

        public void SaveData()
        {

            string user = UICommon.GetCurrentUserID().ToString();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string Customer = GetItemFromGrid();
            string[] arr = { Customer,fromDate,endDate, user };
            string Value = obj.SaveData("sp_Masters", "InsSPCusAssign", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }


        }


        public void Delete()
        {
            try
            {
                string id = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = obj.SaveData("sp_Masters", "DeleteCRP", id.ToString(), arr);

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

                        string crp_ID = dr.GetDataKeyValue("crp_ID").ToString();

                        createNode2(crp_ID, writer);
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
        private void createNode2(string crp_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("crp_ID");
            writer.WriteString(crp_ID);
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
                            string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();
                            string rot_ID = ddlRoute.SelectedValue.ToString();
                            createNode(rot_ID, cus_ID, writer);
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

        private void createNode(string RouteID, string cus_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rcs_rot_ID");
            writer.WriteString(RouteID);
            writer.WriteEndElement();

            writer.WriteStartElement("rcs_cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

       
        protected void Filter_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            Delete();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }
    }
}