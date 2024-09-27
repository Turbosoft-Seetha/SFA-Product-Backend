using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListCustomerSplPriceData : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();


        public int CustomerID
        {
            get
            {
                int CustomerID;
                int.TryParse(Request.Params["CUID"], out CustomerID);

                return CustomerID;
            }
        }



        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RTID"], out RouteID);

                return RouteID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
            }
        }

        public void List()
        {
            string[] arr = { RouteID.ToString() };
            DataTable lstdata = obj.loadList("SelectPriceListData", "sp_Masters_UOM", CustomerID.ToString(),arr);
            if (lstdata.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstdata;
            }
        }

      
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void lnksplPriceAssign_Click(object sender, EventArgs e)
        {
            try
            {
                string user = UICommon.GetCurrentUserID().ToString();
                string CusID = CustomerID.ToString();
                string wttID = GetSelectedItemsFromGrid();
                DataTable lstData = new DataTable();
                string[] arr = { user,wttID };
                string resp = obj.SaveData("sp_Masters_UOM", "insertcusRouteProductSpl", CusID, arr);
                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Special Price Assigned Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
                }
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                obj.LogMessageToFile(UICommon.GetLogFileName(), "TimeSheetRequest.aspx", "Error : " + ex.Message.ToString() + " - " + innerMessage);

            }
        }


        public string GetSelectedItemsFromGrid()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");

                    foreach (GridDataItem item in grvRpt.MasterTableView.Items)
                    {
                        // Check if the checkbox in the current row is checked
                        CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect"); // Replace "chkSelect" with the actual ID or UniqueName of your checkbox column
                        if (chkSelect != null && chkSelect.Checked)
                        {
                            // Retrieve values from the grid columns
                            string crp_ID = item.GetDataKeyValue("crp_ID").ToString();
                            string prh_Name = item["crp_prh_ID"].Text;
                            string prh_PayMode = item["paymode"].Text;
                            string crp_StartDateText = item["crp_StartDate"].Text; // Retrieve the date string from the grid column
                            string crp_EndDateText = item["crp_EndDate"].Text;     // Retrieve the date string from the grid column

                            // Parse the date strings into DateTime objects
                            DateTime crp_StartDate, crp_EndDate;
                            if (DateTime.TryParse(crp_StartDateText, out crp_StartDate) && DateTime.TryParse(crp_EndDateText, out crp_EndDate))
                            {
                                // Successfully parsed the dates, you can use crp_StartDate and crp_EndDate here
                                // Now you can create the XML node or perform other operations

                                // Create XML nodes for the dates
                                createNode(crp_ID, prh_Name, prh_PayMode, crp_StartDate.ToString("yyyy-MM-dd"), crp_EndDate.ToString("yyyy-MM-dd"), writer);
                                c++;
                            }
                            else
                            {
                                // Handle the case where parsing the dates fails
                                // For example, log an error or perform alternative action
                                Console.WriteLine("Failed to parse date for crp_ID: " + crp_ID);
                            }
                        }
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
                    return sw.ToString();
                }
            }
        }

        private void createNode(string crp_ID, string prh_Name, string prh_PayMode, string crp_StartDate, string crp_EndDate ,XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("crp_ID");
            writer.WriteString(crp_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("prh_Name");
            writer.WriteString(prh_Name);
            writer.WriteEndElement();

            writer.WriteStartElement("prh_PayMode");
            writer.WriteString(prh_PayMode);
            writer.WriteEndElement();

            writer.WriteStartElement("crp_StartDate");
            writer.WriteString(crp_StartDate);
            writer.WriteEndElement();

            writer.WriteStartElement("crp_EndDate");
            writer.WriteString(crp_EndDate);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string CUID = CustomerID.ToString();
            string RTID = RouteID.ToString();


                Response.Redirect("ListCusRouteProducts.aspx?CID=" + CUID + "&RID=" + RTID);
        }
    }
}