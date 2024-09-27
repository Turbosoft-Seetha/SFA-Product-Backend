using Stimulsoft.Report.Dictionary;
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
    public partial class CustomerReAssignment : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FromRoute();
                RouteCustomers();

            }
        }
        public void FromRoute()
        {
            DataTable dts = ObjclsFrms.loadList("SelRoute", "sp_ReAssignment");
            ddlFRoute.DataSource = dts;
            ddlFRoute.DataTextField = "rot_Name";
            ddlFRoute.DataValueField = "rot_ID";
            ddlFRoute.DataBind();
        }
        public void ToRoute()
        {
            string FromRoute = ddlFRoute.SelectedValue.ToString();
            DataTable dts = ObjclsFrms.loadList("SelToRoute", "sp_ReAssignment", FromRoute);
            ddlTRoute.DataSource = dts;
            ddlTRoute.DataTextField = "rot_Name";
            ddlTRoute.DataValueField = "rot_ID";
            ddlTRoute.DataBind();
        }
        public void RouteCustomers()
        {
            string FromRoute = ddlFRoute.SelectedValue.ToString();
            string ToRoute = ddlTRoute.SelectedValue.ToString();
            string[] arr = { ToRoute };
            DataTable dts = ObjclsFrms.loadList("SelCusRoute", "sp_ReAssignment", FromRoute,arr);
            if (dts.Rows.Count >= 0)
            {

                grvRpt.DataSource = dts;
            }
        }
        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRoute.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
        public string Cus()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = grvRpt.SelectedItems;
                   // int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (GridDataItem dr in CollectionMarket)
                        {
                            string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();

                            createNode(cus_ID, writer);
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

        private void createNode(string cusId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("cusID");
            writer.WriteString(cusId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void Save()
        {

            string FRoute,TRoute, Customer, user;

            FRoute = ddlFRoute.SelectedValue.ToString();
            TRoute = ddlTRoute.SelectedValue.ToString();
            Customer = Cus();
            user = UICommon.GetCurrentUserID().ToString();

           
            
            string[] arr = { TRoute , Customer , user };
            string Value = ObjclsFrms.SaveData("sp_ReAssignment", "UpdateRouteCusReAssignment", FRoute, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Re-Assignment Saved Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRoute.aspx");
        }

        protected void ddlFRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ToRoute();
            ddlTRoute.Text = "";
           // ddlCustomers.Text = "";
        }

        protected void ddlTRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RouteCustomers();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RouteCustomers();
        }
    }
}