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
    public partial class ListcustomerFOCDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);
                return ResponseID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();

            }
        }

        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListCustomerFOCHeaderByid", "sp_wb_merch_others", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblCreatedBy = (Label)rp.FindControl("lblCreatedBy");


                Label lblfromdate = (Label)rp.FindControl("lblfromdate");
                Label lbltodate = (Label)rp.FindControl("lbltodate");


                //  rp.Text = "Receipt No: " + lstDatas.Rows[0]["arh_ARNumber"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblCustomer.Text = lstDatas.Rows[0]["cus_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                //lblCreatedBy.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblfromdate.Text = lstDatas.Rows[0]["FromDate"].ToString();
                //  lblbalamnt.Text = lstDatas.Rows[0]["arh_BalanceAmount"].ToString();
                lbltodate.Text = lstDatas.Rows[0]["ToDate"].ToString();
                DateTime toDate;
                ViewState["todate"] = "";
                if (DateTime.TryParse(lstDatas.Rows[0]["ToDate"].ToString(), out toDate))
                {
                    // Set lbltodate.Text to the string representation of toDate
                    lbltodate.Text = toDate.ToString("dd-MMM-yy");
                    ViewState["todate"] = toDate.ToString("dd-MMM-yy");
                    // Set rdEndDate's minimum value to toDate
                    rdEndDate.MinDate = toDate;
                   
                }
                

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("ListCustomerFOCDetails", "sp_wb_merch_others", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                grvRpt.DataSource = lstDatas;

                
            }


        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void lnkproceed_Click(object sender, EventArgs e)
        {
            string falg = "";
            foreach (GridDataItem item in grvRpt.MasterTableView.Items)
            {

                RadNumericTextBox cfd_TotalQty = (RadNumericTextBox)item.FindControl("cfd_TotalQty");
                int cfd_TotalQtys = Int32.Parse(cfd_TotalQty.Text.ToString());
                int totalqty = Int32.Parse(item["cfdTotalQty"].Text.ToString());
                if (cfd_TotalQtys >= totalqty)
                {

                    falg = "Y";
                }
                else
                {
                    falg = "N";
                }
            } 
            if(falg.Equals("Y"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Total Qty should be greater than of previous value');</script>", false);

            }
        }

        protected void cfd_TotalQty_TextChanged(object sender, EventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem itm = (GridDataItem)e.Item;
                RadNumericTextBox txttotalqty = (RadNumericTextBox)itm.FindControl("cfd_TotalQty");

                if (txttotalqty != null)
                {


                    DataRowView dataItem = (DataRowView)itm.DataItem;
                    if (dataItem != null)
                    {
                        txttotalqty.Value = (double?)Convert.ToDecimal(dataItem["cfd_TotalQty"]);
                    }


                    // Retrieve the FOC given Qty value
                    string focGivenQtyStr = itm["cfd_soldQty"].Text;

                    if (!string.IsNullOrEmpty(focGivenQtyStr))
                    {
                        // If focGivenQtyStr is not null or empty, parse it to an int
                        int focGivenQty;
                        bool isFocGivenQtyParsed = int.TryParse(focGivenQtyStr, out focGivenQty);

                        if (isFocGivenQtyParsed)
                        {
                            // Hide the Total Qty RadNumericTextBox if FOC given Qty is greater than 0
                            if (focGivenQty > 0)
                            {
                                txttotalqty.Enabled = false;
                            }
                            else
                            {
                                txttotalqty.Enabled = true;
                            }

                            // Populate the Total Qty if it needs to be updated
                         
                        }
                    }
                }
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

                    var ColelctionMarkets = grvRpt.Items;

                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            Telerik.Web.UI.RadNumericTextBox txttotqty = (Telerik.Web.UI.RadNumericTextBox)dr.FindControl("cfd_TotalQty");

                            string cfd_ID = dr["cfd_ID"].Text.ToString();
                            
                            string totalqty = txttotqty.Text.ToString();  // Assuming Rot() returns a string, split it into individual IDs


                            createNode(cfd_ID, totalqty, writer);
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
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string cfd_ID, string totalqty, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("cfd_ID");
            writer.WriteString(cfd_ID);
            writer.WriteEndElement();

           

            writer.WriteStartElement("totalqty");
            writer.WriteString(totalqty);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string date, id, user;
            if(rdEndDate.SelectedDate.Equals("") || rdEndDate.SelectedDate.Equals(null))
            {
                date= DateTime.Parse(ViewState["todate"].ToString()).ToString("yyyy-MM-dd");
            }
            else
            {
                date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");

            }

            user = UICommon.GetCurrentUserID().ToString();
           
            string products = GetItemFromGrid();

            //string[] arrr = {  };
            //DataTable lstUserr = default(DataTable);
            //lstUserr = ObjclsFrms.loadList("selectCustomerAndRotID", "sp_Masters_UOM", rotid, arrr);
            //id = lstUserr.Rows[0]["rcs_ID"].ToString();



            
                string[] arr = { products, date, user, };
                string Value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdateFOC", ResponseID.ToString(), arr);

                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer FOC saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerFOC.aspx");
        }
    }
}