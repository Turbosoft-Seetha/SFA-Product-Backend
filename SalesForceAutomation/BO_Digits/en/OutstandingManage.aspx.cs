using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Telerik.Web.Apoc.Render.Pdf.PdfRendererOptions;
using Telerik.Web.UI;
using System.IO;
using System.Xml;
using SalesForceAutomation.Admin;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class OutstandingManage : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Filter"] = "";
                ViewState["table"] = "";
              //  Customers();
                AssignRoute();

                grvRpt.DataSource = null;
                grvRpt.DataBind();
            }
        }

        //protected void Filter_Click(object sender, EventArgs e)
        //{
        //    ViewState["Filter"] = "Yes";
        //    LoadData();
        //    grvRpt.Rebind();
        //}




        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
           // LoadData();


            if (ViewState["Filter"].ToString().Equals("Yes"))
            {
                grvRpt.DataSource = Session["lstTracker"] as DataTable;
            }
            else
            {
                grvRpt.DataSource = new DataTable(); // Ensure no data is bound initially
            }
        }

        //public string mainConditions()
        //{
        //    string cusID = Cus();
        //    string customerCondition = "";
        //    string mainCondition = "";


        //    try
        //    {
              
        //        if (cusID.Equals("0"))
        //        {
        //            customerCondition = "";
        //        }
        //        else
        //        {
        //            customerCondition = "oid_cus_ID in (" + cusID + ")";
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    mainCondition += customerCondition;
        //    return mainCondition;
        //}

        //public void Customers()
        //{

        //    rdCustomer.DataSource = ObjclsFrms.loadList("selectOutstandingCustomer", "sp_Transaction");
        //    rdCustomer.DataTextField = "cus_Name";
        //    rdCustomer.DataValueField = "cus_ID";
        //    rdCustomer.DataBind();
        //}


        //public string Cus()
        //{
        //    var CollectionMarket = rdCustomer.CheckedItems;
        //    string cusID = "";
        //    int j = 0;
        //    int MarCount = CollectionMarket.Count;
        //    if (CollectionMarket.Count > 0)
        //    {
        //        foreach (var item in CollectionMarket)
        //        {
        //            if (j == 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            else if (j > 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            if (j == (MarCount - 1))
        //            {
        //                cusID += item.Value;
        //            }
        //            j++;
        //        }
        //        return cusID;
        //    }
        //    else
        //    {
        //        return "oid_cus_ID";
        //    }

        //}


        public void LoadData()
        {
          
                string mainCondition = "";
              //  mainCondition = mainConditions();
                DataTable lstDatas = new DataTable();

              string Customer = CusTxtBOX.Text.ToString();
            lstDatas = ObjclsFrms.loadList("selectOutstandingHeader", "sp_Transaction", Customer);
                grvRpt.DataSource = lstDatas;
            Session["lstTracker"] = lstDatas;


        }

        public void AssignRoute()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForOutstangingInv", "sp_Transaction");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }


        protected void btnChngRoute_Click(object sender, EventArgs e)
        {
            bool isAnyChecked = false;

            foreach (GridDataItem item in grvRpt.Items)
            {
                CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    isAnyChecked = true;
                    break;
                }
            }

            if (!isAnyChecked)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Assign();</script>", false);
            }
        }


        protected void lnkSubmit_Click(object sender, EventArgs e)
        {

           // string user = UICommon.GetCurrentUserID().ToString();

            string wttID = GetSelectedItemsFromGrid();
            string RouteID = ddlRoute.SelectedValue.ToString();
            DataTable lstData = new DataTable();
            string[] arr = { RouteID};
            string resp = ObjclsFrms.SaveData("sp_Transaction", "UpdateOutstandingInvoicesRoute", wttID, arr);
            int res = Int32.Parse(resp);

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Route Changed Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Something went wrong, please try again later.');</script>", false);
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
                            string oid_ID = item.GetDataKeyValue("oid_ID").ToString();
                            createNode(oid_ID, writer);
                            c++;
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

        private void createNode(string oid_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("oid_ID");
            writer.WriteString(oid_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("OutstandingManage.aspx");
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            ViewState["Filter"] = "Yes";
               LoadData();
              grvRpt.Rebind();
        }
    }
}