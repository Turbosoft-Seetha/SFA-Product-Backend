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
    public partial class SpecialPriceBulkDelete : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SpecialPrice();
                PayMode();
            }
        }
        public void SpecialPrice()
        {
            DataTable dt = obj.loadList("SpecialPriceNameforDropDown", "sp_Backend");
            ddlSP.DataSource = dt;
            ddlSP.DataTextField = "prh_Name";
            ddlSP.DataValueField = "prh_ID";
            ddlSP.DataBind();
        }

        public void PayMode()
        {
            DataTable dt = obj.loadList("PayModeforDropDown", "sp_Backend");
            ddlPayMode.DataSource = dt;
            ddlPayMode.DataTextField = "PayMode";
            ddlPayMode.DataValueField = "crp_PayMode";
            ddlPayMode.DataBind();
        }
        public void Route()
        {
            string[] arr = { ddlPayMode.SelectedValue.ToString()};
            DataTable dt = obj.loadList("SpecialPriceRouteforDropDown", "sp_Backend",ddlSP.SelectedValue.ToString(),arr);
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        protected void Delete_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(ddlRoute.CheckedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void ddlPayMode_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Route();
        }

        protected void ddlSP_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Route();
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
                    

                    var ColelctionMarkets = ddlRoute.CheckedItems;

                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var itm in ColelctionMarkets)
                        {

                            string rotid = itm.Value;
                            createNode(rotid, writer);
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

        private void createNode(string rotid, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("rotid");
            writer.WriteString(rotid);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void Save()
        {

            string rotid = GetItemFromGrid();
            string user = UICommon.GetCurrentUserID().ToString();
            string[] ar = { rotid,ddlPayMode.SelectedValue.ToString(),user };
            string Value = obj.SaveData("sp_Backend", "SpecialPriceInactive", ddlSP.SelectedValue.ToString(), ar);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Special Price Removed Successfully');</script>", false);
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
            Response.Redirect("ListPriceListHeader.aspx");
        }
    }
}