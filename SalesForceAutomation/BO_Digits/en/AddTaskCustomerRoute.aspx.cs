using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddTaskCustomerRoute : System.Web.UI.Page
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
                rdfromDate.MinDate = DateTime.Today;
                rdfromDate.SelectedDate = DateTime.Today;

                rdendDate.MinDate = DateTime.Today.AddDays(1);
                rdendDate.SelectedDate = DateTime.Today.AddDays(1);

                Titles();
                Route();
                if (Session["route"]!=null)
                {
                    ddlRoute.SelectedValue = Session["route"].ToString();
                }
               
               
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelTaskById", "sp_Merchandising", ResponseID.ToString());
            if (lstTitle.Rows.Count > 0)
            {
                string name = lstTitle.Rows[0]["tsk_Name"].ToString();
                lblTitle.Text =  name.ToString();
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteForMasters", "sp_Merchandising");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ListData();
            LoadData();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCusRotforTask", "sp_Merchandising", ResponseID.ToString(), arr);
            if (lstUser.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstUser;
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
        public void ListData()
        {
            string[] arr = { ddlRoute.SelectedValue.ToString() };
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectCustomerTask", "sp_Merchandising", ResponseID.ToString(), arr);
            if (lstUser.Rows.Count >= 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }
        public void SaveData()
        {

            string user = UICommon.GetCurrentUserID().ToString();
          
            string Customer = GetItemFromGrid();
            string madatory = ddlmdr.SelectedValue.ToString();
            string startdate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string enddate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            string[] arr = { Customer,  user, madatory, startdate.ToString(), enddate.ToString() };
            string Value = ObjclsFrms.SaveData("sp_Merchandising", "InsCustomerTask", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Assigned successfully');</script>", false);
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
                string resp = ObjclsFrms.SaveData("sp_Merchandising", "DeleteCustomerTask", id.ToString(), arr);

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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            SaveData();
          
            
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

                        string cst_ID = dr.GetDataKeyValue("cst_ID").ToString();

                        createNode2(cst_ID, writer);
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
        private void createNode2(string cst_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cst_ID");
            writer.WriteString(cst_ID);
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
                    int i = 0;
                    var ColelctionMarkets = RadGrid1.SelectedItems;
                    string cusIDs = "";

                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string cus_ID = dr["cus_ID"].Text.ToString();
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
        protected void btnOK_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();
            Session["route"] = ddlRoute.SelectedValue.ToString();
            Response.Redirect("AddTaskCustomerRoute.aspx?Id=" + ResponseID.ToString());
          
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {

            Delete();
            

        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();
            Session["route"] = ddlRoute.SelectedValue.ToString();
            Response.Redirect("AddTaskCustomerRoute.aspx?Id=" + ResponseID.ToString());

        }

        protected void lnkAddQuestion_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
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