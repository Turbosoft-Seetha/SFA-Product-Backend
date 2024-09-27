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
    public partial class CustomerPromotionAssignments : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Set "from" date to today's date
                rdfromDate.SelectedDate = DateTime.Now;
                rdfromDate.MinDate = DateTime.Now;

                // Set "to" date to 8 days from today
                DateTime dt = DateTime.Now;
                TimeSpan AddDay = new TimeSpan(8, 0, 0, 0);
                dt = dt.Add(AddDay);
                rdendDate.SelectedDate = dt;
                rdendDate.MinDate = DateTime.Now;

                // Call other methods like Area() and Promotion()
                Area();
                Promotion();
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListRouteCustomerPromotion.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string Area = cmbArea.SelectedValue.ToString();
            string SubArea = cmbsubArea.SelectedValue.ToString();
            string Rot = Condition();
            string promo = rcmPromo.SelectedValue.ToString();
            string rdfromdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string rdenddate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { SubArea, Rot, promo, rdfromdate, rdenddate  };
            string Value;
            int res = 0;
            Value = ObjclsFrms.SaveData("sp_Masters", "AssignPromotoCustomers", Area, arr);
            res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Promotion Assigned Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        public void Area()
        {
            DataTable dt = ObjclsFrms.loadList("selectAreaForDropDown", "sp_Masters");
            cmbArea.DataSource = dt;
            cmbArea.DataTextField = "dpa_Name";
            cmbArea.DataValueField = "dpa_ID";
            cmbArea.DataBind();
        }
        public void SubArea()
        {
            DataTable dt = ObjclsFrms.loadList("selectSubAreaForDropDown", "sp_Masters",cmbArea.SelectedValue.ToString());
            cmbsubArea.DataSource = dt;
            cmbsubArea.DataTextField = "dsa_Name";
            cmbsubArea.DataValueField = "dsa_ID";
            cmbsubArea.DataBind();
        }
        public void Route()
        {
            string maincondition = mainConditions();
            DataTable dt = ObjclsFrms.loadList("selectRouteForPromo", "sp_Masters", maincondition);
            rdRoute.DataSource = dt;
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }

        public string mainConditions()
        {
            string subID = Subarea();
            string subareaCondition = "";
            string mainCondition = "";


            try
            {
               
                if (subID.Equals("0"))
                {
                    subareaCondition = "";
                }
                else
                {
                    subareaCondition = " dsa_ID in (" + subID + ")";
                }
            }
            catch (Exception ex)
            {

            }
            mainCondition += subareaCondition;
            return mainCondition;
        }

        public string Subarea()
        {
            var CollectionMarket = cmbsubArea.CheckedItems;
            string SubID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        SubID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        SubID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        SubID += item.Value;
                    }
                    j++;
                }
                return SubID;
            }
            else
            {
                return "0";
            }
        }

      

        public void Promotion()
        {
            DataTable dt = ObjclsFrms.loadList("selectPromoforCustomer", "sp_Masters");
            rcmPromo.DataSource = dt;
            rcmPromo.DataTextField = "prm_Name";
            rcmPromo.DataValueField = "prm_ID";
            rcmPromo.DataBind();
        }

        public string Rot()
        {
            var ColelctionMarket = rdRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "0";
            }
        }
        public string Condition()
        {
            var rotID = rdRoute.CheckedItems;
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;
                    foreach (var item in rotID)
                    {
                        string Rot = item.Value;
                        createNode(Rot, writer);
                        c++;
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
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
        }

        private void createNode(string Rot, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("rotID");
            writer.WriteString(Rot);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }


        protected void Apply_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

           


        }

        protected void cmbArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            SubArea();
        }

        protected void cmbsubArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Route();
        }

        protected void rcmPromo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}