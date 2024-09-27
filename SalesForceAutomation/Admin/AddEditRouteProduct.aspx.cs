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
    public partial class AddEditRouteProduct : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Product();
                Route();
            }
        }

        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RID"], out RouteID);

                return RouteID;
            }
        }
        public void Product()
        {
            DataTable dt = ObjclsFrms.loadList("ProductwithoutRoute", "sp_Masters", RouteID.ToString());
            ddlItems.DataSource = dt;
            ddlItems.DataTextField = "prd_Name";
            ddlItems.DataValueField = "prd_ID";
            ddlItems.DataBind();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("ListRouteProduct.aspx?ID=" + ID);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRouteProduct.aspx?id=" + RouteID.ToString());
        }
        public void SaveData()
        {
            string product, code;
            product = GetItemFromGrid();
            //code = txtCode.Text.ToString();
            string[] arr = {  };
            string Value = ObjclsFrms.SaveData("sp_Merchandising", "AddRouteProduct", product ,arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Product Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }


        }

        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("Route", "sp_Masters", RouteID.ToString());
            if (dt.Rows.Count > 0)
            {

                string rotname = dt.Rows[0]["rot_Name"].ToString();
                Proroute.Text = "Route Name : " + rotname;


            }

        }

        //protected void ddlproduct_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        //{
        //    DataTable dt = ObjclsFrms.loadList("Productcode", "sp_Masters", ddlproduct.SelectedValue.ToString());
        //    if (dt.Rows.Count > 0)
        //    {
        //        txtCode.Text = dt.Rows[0]["prd_Code"].ToString();
        //    }
        //}
        
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = ddlItems.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode(RouteID.ToString(), item.Value, writer);
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

            writer.WriteStartElement("rop_prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

           

            writer.WriteEndElement();
        }

        protected void ddlItems_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}
