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
    public partial class AddCustomerPriceList : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();

        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["cid"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                //Route();
                PriceList();
            }

        }        
        public void Route()
        {

            string type = ddlRotType.SelectedValue.ToString();
            string[] arr = { type.ToString() };
            DataTable dt = obj.loadList("SelRouteForCustomerPriceList", "sp_Backend", ResponseID.ToString(), arr);
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Code";
            ddlRoute.DataValueField = "rcs_ID";
            ddlRoute.DataBind();
        }

        public void PriceList()
        {
            DataTable dt = obj.loadList("SelPriceList", "sp_Backend", ResponseID.ToString());
            ddlSp.DataSource = dt;
            ddlSp.DataTextField = "prh_Name";
            ddlSp.DataValueField = "prh_ID";
            ddlSp.DataBind();
        }

        protected void Add_Click(object sender, EventArgs e)
        {

        }

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            
        }

        protected void lnkcancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerSpecialPriceHeader.aspx?cid=" + ResponseID);
        }

        protected void LnkaddConfirm_Click(object sender, EventArgs e)
        {
            Save();
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
                        foreach (var item in ColelctionMarkets)
                        {
                            var selectedPayModes = ddlPayMode.CheckedItems;

                            foreach (var payModeItem in selectedPayModes)
                            {
                                createNode(item.Value, payModeItem.Value.ToString(), writer); // Pass each pay mode to createNode
                                c++;
                            }
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
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rcs_ID, string paymode, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rcs_ID");
            writer.WriteString(rcs_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("paymode");
            writer.WriteString(paymode); // Include pay mode value in XML
            writer.WriteEndElement();

            writer.WriteEndElement();
        }


        public string payMode()
        {
            var selectedValue = ddlPayMode.CheckedItems;
            if (selectedValue != null && selectedValue.Any())
            {
                return string.Join("-", selectedValue.Select(item => item.Value));
            }
            else
            {
                return "0";
            }
        }

        protected void Save()
        {
            string user = UICommon.GetCurrentUserID().ToString();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string ddlPayMode = payMode();
            int res=0;
            string rcs_ID = GetItemFromGrid();
            
          
                    string routeValue = rcs_ID;
                    string spValue = ddlSp.SelectedValue;
                    string[] arr = { routeValue, fromDate, endDate, user };
                    string Value = obj.SaveData("sp_Backend", "InsSPtocustomer", spValue, arr);
                    res = Int32.Parse(Value.ToString());
              
            
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void SuccessOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerSpecialPriceHeader.aspx?cid=" + ResponseID);
        }

        protected void ddlRotType_SelectedIndexChanged (object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Route();
        }
    }
}