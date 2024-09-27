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
    public partial class SpecialPriceAssign : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                pnlGrid.Visible = true;

                DateTime ds = DateTime.Now;
                //TimeSpan AddDay1 = new TimeSpan(8, 0, 0, 0);
                //ds = ds.Add(AddDay1);

                rdfromDate.SelectedDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);
                rdfromDate.MinDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);
                DateTime dt = DateTime.Now;
                TimeSpan AddDay = new TimeSpan(8, 0, 0, 0);
                dt = dt.Add(AddDay);
                rdendDate.SelectedDate = dt;
                // rdendDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 8);
                rdendDate.MinDate = ds;
                //new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day + 1);

                HeaderData();
               
                // SpecialPrice();


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

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = obj.loadList("SelPriceListByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar1.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");

                Label lblstatus = (Label)rp.FindControl("lblstatus");
                //Label lblPayMode = (Label)rp.FindControl("lblPayMode");

                rp.Text = "Special Price Code: " + lstDatas.Rows[0]["prh_Code"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["prh_Name"].ToString();

                lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
                //lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();
                ViewState["prhname"] = lblRoute.Text;
                //ViewState["paymode"] = lblPayMode.Text;
            }
        }

        //public void SpecialPrice()
        //{
        //    DataTable dt = obj.loadList("SpecialPriceName", "sp_Masters", ResponseID.ToString());
        //    if (dt.Rows.Count > 0)
        //    {
        //        string name = dt.Rows[0]["prh_Name"].ToString();
        //        sp.Text = "Special Price : " + name;
        //    }

        //}
       


        public void List()
        {

            DataTable lstdata = default(DataTable);
            string maincondition = mainConditions1();

            lstdata = obj.loadList("AssignedCusSpecialPrice", "sp_Masters", maincondition);
            if (lstdata.Rows.Count >= 0)
            {

                grvRpt.DataSource = lstdata;

            }
        }

        public void Loaddata()
        {
            string maincondition = mainConditions();
            DataTable lstuser = default(DataTable);
            string Route;
           
           
            string[] arr = {  };
            lstuser = obj.loadList("UnAssignedCustomerSpecialPrice", "sp_Masters", maincondition, arr);
            if (lstuser.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstuser;

            }


        }

        public string mainConditions()
        {
           // string RotID = Rot();
            string Paymode = payMode();
            string PaymodeCondition = "";
            //string RouteCondition = "";
            string mainCondition = "";
            string ID = ResponseID.ToString();
            string responsecondotion = "";

            try
            {


              

                if (Paymode.Equals("0"))
                {
                    PaymodeCondition = "";
                }
                else
                {
                    PaymodeCondition = "and crp_PayMode in (" + Paymode + ")";


                }

                if (ID.Equals("0"))
                {
                    responsecondotion = "";
                }
                else
                {
                    responsecondotion = "crp_prh_ID in (" + ID + ")";
                }

            }
            catch (Exception ex)
            {

            }
            mainCondition += responsecondotion;
           // mainCondition += RouteCondition;
            mainCondition += PaymodeCondition;


            return mainCondition;
        }

        public string mainConditions1()
        {
           // string RotID = Rot();
            string Paymode = payMode();
            string PaymodeCondition = "";
           // string RouteCondition = "";
            string mainCondition = "";
            string ID = ResponseID.ToString();
            string responsecondotion = "";

            try
            {


              

                if (Paymode.Equals("0"))
                {
                    PaymodeCondition = "";
                }
                else
                {
                    PaymodeCondition = "and crp_PayMode in (" + Paymode + ")";

                }

                if (ID.Equals("0"))
                {
                    responsecondotion = "";
                }
                else
                {
                    responsecondotion = " and crp_prh_ID in (" + ID + ")";
                }

            }
            catch (Exception ex)
            {

            }
            mainCondition += responsecondotion;
           // mainCondition += RouteCondition;
            mainCondition += PaymodeCondition;


            return mainCondition;
        }

        public string payMode()
        {
            var selectedValue = RdPayMode.CheckedItems;
            if (selectedValue != null && selectedValue.Any())
            {
                return string.Join(", ", selectedValue.Select(item => "'" + item.Value + "'"));
            }
            else
            {
                return "0";
            }
        }

        public void SaveData()
        {

            string user = UICommon.GetCurrentUserID().ToString();
            string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string Customer = GetItemFromGrid();
            string RdPayMode = payMode();
            string[] arr = { Customer, fromDate, endDate, user };
            string Value = obj.SaveData("sp_Masters", "InsSpclpriceCusAssign", ResponseID.ToString(), arr);
            int res;
            if (Int32.TryParse(Value.ToString(), out res))
            {
                // Parsing successful, use 'res' here
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Added successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
            else
            {
                // Handle parsing failure (e.g., log error, display user-friendly message)
                // For example:
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

                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();
                          //  string rot_ID = Rot();  // Assuming Rot() returns a string, split it into individual IDs
                           // string[] rotIDs = rot_ID.Split(','); // Assuming IDs are comma-separated

                            foreach (RadComboBoxItem item in RdPayMode.Items)
                            {
                                if (item.Checked) // Assuming RadComboBoxItem has a Checked property
                                {
                                    string selectedPayMode = item.Value; // Use the value directly



                                   

                                        // Create a new XML node for each combination of rot_ID and cus_ID
                                        createNode( cus_ID, selectedPayMode, writer);
                                        c++;
                                    
                                }
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

        private void createNode( string cus_ID, string selectedPayMode, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

          

            writer.WriteStartElement("rcs_cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("Paymodes");
            writer.WriteString(selectedPayMode);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }




        protected void Filter_Click(object sender, EventArgs e)
        {
            try
            {
                pnlGrid.Visible = true;
                Loaddata();
                grvRpt.Rebind();
                RadGrid1.Rebind();
            }
            catch (Exception ex)
            {
                obj.TraceService("Exception From Filter" + ex.Message.ToString());
            }

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
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

        protected void lnkAddQuestion_Click(object sender, EventArgs e)
        {
            string paymode = payMode();
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else if (paymode == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals2();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);

            }
        }
    }
}