using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class AddEditRouteCustomerPromotions : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);
                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdFromData.MinDate = DateTime.Now.AddDays(1);
                rdEndDate.MinDate = DateTime.Now.AddDays(1);
                rdFromData.SelectedDate = DateTime.Now.AddDays(1);
                rdEndDate.SelectedDate = DateTime.Now.AddDays(10);
                Route();
                // Promo();
            }
        }
        public void Route()
        {
            DataTable dtr = ObjclsFrms.loadList("SelectRouteDrop", "sp_Web_Promotion");
            ddlp.DataSource = dtr;
            ddlp.DataTextField = "name";
            ddlp.DataValueField = "id";
            ddlp.DataBind();
        }
        public void Promo()
        {
            string rot;

            rot = ddlp.SelectedValue.ToString();


            DataTable dtp = ObjclsFrms.loadList("SelectPromotionDropdown", "sp_Web_Promotion", rot);
            ddlPromo.DataSource = dtp;
            ddlPromo.DataTextField = "name";
            ddlPromo.DataValueField = "id";
            ddlPromo.DataBind();
        }
        public void Customer()
        {
            string rotID = ddlp.SelectedValue.ToString();
            ddlCus.DataSource = ObjclsFrms.loadList("SelectCustomerByRouteDrop", "sp_Web_Promotion", rotID);
            ddlCus.DataTextField = "name";
            ddlCus.DataValueField = "id";
            ddlCus.DataBind();
        }


        protected void lnkAssign_Click(object sender, EventArgs e)
        {
            string startdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            string enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            if (ddlp.SelectedValue.ToString() == "" || ddlPromo.SelectedValue.ToString() == "" || startdate.ToString() == "" || enddate.ToString() == "")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

            }
            else
            {
                Assignedcustomer();
                grvRpt.DataBind();

                UnAssignedcustomer();
                RadGrid1.DataBind();


            }
        }
        public void Assignedcustomer()
        {
            string prmid, rotid, startdate, enddate;
            prmid = ddlPromo.SelectedValue.ToString();
            rotid = ddlp.SelectedValue.ToString();
            startdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { rotid, startdate, enddate };
            DataTable dtp = new DataTable();
            dtp = ObjclsFrms.loadList("SelPromoAssignedCus", "sp_Web_Promotion", prmid, arr);
            try
            {
                grvRpt.DataSource = dtp;
            }
            catch (Exception ex)
            {

            }

        }
        public void UnAssignedcustomer()
        {
            string prmid, rotid, startdate, enddate;
            prmid = ddlPromo.SelectedValue.ToString();
            rotid = ddlp.SelectedValue.ToString();
            startdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { rotid, startdate, enddate };
            DataTable dtpp = new DataTable();
            dtpp = ObjclsFrms.loadList("SelPromoUnAssignedCus", "sp_Web_Promotion", prmid, arr);
            try
            {
                RadGrid1.DataSource = dtpp;
            }
            catch (Exception ex)
            {

            }

        }


        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Promo();
        }

        protected void rdEndDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {

        }
        public string Cus()
        {
            var ColelctionMarket = ddlCus.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }
        public string Condition()
        {
            var cusID = ddlCus.CheckedItems;
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;
                    foreach (var item in cusID)
                    {
                        string customer = item.Value;
                        createNode(customer, writer);
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

        private void createNode(string customer, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cusID");
            writer.WriteString(customer);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        protected void ddlPromo_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Assignedcustomer();
            grvRpt.DataBind();

            UnAssignedcustomer();
            RadGrid1.DataBind();
            //grvRpt.DataSource = "";
            //grvRpt.Rebind();
            //RadGrid1.DataSource = "";
            //RadGrid1.Rebind();
        }
        protected void grvRpt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            string startdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            string enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            if (ddlp.SelectedValue.ToString() == "" || ddlPromo.SelectedValue.ToString() == "" || startdate.ToString() == "" || enddate.ToString() == "")
            {

            }
            else
            {
                Assignedcustomer();

            }

        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            string startdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            string enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            if (ddlp.SelectedValue.ToString() == "" || ddlPromo.SelectedValue.ToString() == "" || startdate.ToString() == "" || enddate.ToString() == "")
            {

            }
            else
            {
                UnAssignedcustomer();

            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                foreach (GridDataItem item in RadGrid1.SelectedItems)
                {
                    try
                    {
                        string cusID = item["rcs_cus_ID"].Text.ToString();
                        string rot = ddlp.SelectedValue.ToString();
                        string prmid = ddlPromo.SelectedValue.ToString();
                        string rdfromdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string rdenddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                        string[] arr = { rot, prmid, rdfromdate, rdenddate };
                        string Value;
                        int res = 0;
                        Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsCustopromo", cusID, arr);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('بعض الحقول مفقودة ');</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "CustomerRoute.aspx Delete()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ErrorModal();</script>", false);
                    }
                }
            }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            //Page.Response.Redirect(Page.Request.Url.ToString(), true);

            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();


        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                foreach (GridDataItem item in grvRpt.SelectedItems)
                {
                    try
                    {
                        string ID = item.GetDataKeyValue("rcp_ID").ToString();
                        ObjclsFrms.loadList("Deletecusfrompromo", "sp_Web_Promotion", ID.ToString());
                        DataTable lstLatest = ObjclsFrms.loadList("Deletecusfrompromocheck", "sp_Web_Promotion", ID.ToString());
                        if (lstLatest.Rows.Count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteFailed();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                        ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddSurveyCustomerRoute.aspx Delete()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>ErrorModal();</script>", false);
                    }
                }

            }
        }


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            DataBind();
            grvRpt.Rebind();
            RadGrid1.Rebind();

        }

        protected void lnkPromo_Click(object sender, EventArgs e)

        {
            if (ddlPromo.SelectedValue.ToString().Equals(""))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

            }
            else
            {
                OpenNewBrowserWindow("ListPromotionDetail.aspx?prmID=" + ddlPromo.SelectedValue.ToString(), this);



            }
        }

        protected void lnkAddQuestion_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
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
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);

            }
        }
    }
}