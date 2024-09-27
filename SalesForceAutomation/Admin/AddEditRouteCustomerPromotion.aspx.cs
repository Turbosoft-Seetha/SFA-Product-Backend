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

namespace SalesForceAutomation.Admin
{
    public partial class AddEditRouteCustomerPromotion : System.Web.UI.Page
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

                if (Session["FromDate"] == null)
                {
                    rdFromData.SelectedDate = DateTime.Now;
                }
                else
                {
                    string fdate = Session["FromDate"].ToString();
                    rdFromData.SelectedDate = DateTime.Parse(fdate);
                }
                if (Session["ToDate"] == null)
                {
                    
                    rdEndDate.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1);

                }
                else
                {
                    string tdate = Session["ToDate"].ToString();
                    rdEndDate.SelectedDate = DateTime.Parse(tdate);
                }
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

          
            string cus, rot, fdate, edate;
            cus = ddlCus.SelectedValue.ToString();
            rot = ddlp.SelectedValue.ToString();
            fdate = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd");
            edate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = {rot,fdate,edate};
            DataTable dtp = ObjclsFrms.loadList("SelectPromotionDrop", "sp_Web_Promotion", cus, arr);
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

        protected void lnkAssign_Click(object sender, EventArgs e)
        {
            Assignment();
        }

        public void Assignment()
        {
            Response.Redirect("/Admin/ListAssignmentHeader.aspx");
        }

        protected void lnkQuali_Click(object sender, EventArgs e)
        {
            Qualification();
        }

        public void Qualification()
        {
            Response.Redirect("/Admin/ListQualificationHeader.aspx");
        }

        protected void lnkPromo_Click(object sender, EventArgs e)
        {
            Promotion();
        }

        public void Promotion()
        {
            Response.Redirect("/Admin/ListPromotionHeader.aspx");
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customer();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            Session["FromDate"] = rdFromData.SelectedDate.ToString();
            Session["ToDate"] = rdEndDate.SelectedDate.ToString();
            Save();
        }

        public void Save()
        {
            string rotname, user, promot, from, to,cus;

            rotname = ddlp.SelectedValue.ToString();
            promot = ddlPromo.SelectedValue.ToString();
            from = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyyMMdd"); ;
            to = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            user = UICommon.GetCurrentUserID().ToString();
            cus = ddlCus.SelectedValue.ToString();
            //string items = Condition();

            //if (items == null)
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>FailureAlert('Atleast one item check box should be selected');</script>", false);
            //    return;
            //}
            string[] arr = { cus, promot, from, to, user };
            string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertRouteCustomerPromo", rotname, arr);
            try
            {
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route customer promotion saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('This Promotion is already Assigned for this Date Range');</script>", false);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('There is some technical exception, please try again later');</script>", false);
            }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListRouteCustomerPromotion.aspx");
        }

        protected void grvRpt1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadPromotion();
        }

        protected void grvRpt1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prm_ID").ToString();
                //Response.Redirect("AddEditPromotionHeader.aspx?Id=" + ID);
                OpenNewBrowserWindow("AddEditPromotionHeader.aspx?Id=" + ID, this);
            }
        }
        
        protected void grvRpt2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadRange();
        }

        protected void grvRpt2_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prr_ID").ToString();
                string HID = ddlPromo.SelectedValue.ToString();
                //Response.Redirect("AddEditPromotionRange.aspx?Id=" + ID + "&HID=" + HID);
                OpenNewBrowserWindow("AddEditPromotionRange.aspx?Id=" + ID + "&HID=" + HID, this);
            }
        }
       
        protected void grvRpt3_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadQualification();
        }

        protected void grvRpt3_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("qld_ID").ToString();
                DataTable lstHID = ObjclsFrms.loadList("SelectQalificationDetailByID", "sp_Web_Promotion", ID);
                string HID = lstHID.Rows[0]["qld_qlh_ID"].ToString();
                // Response.Redirect("AddEditQualificationDetail.aspx?Id=" + ID + "&HID=" + HID);
                OpenNewBrowserWindow("AddEditQualificationDetail.aspx?Id=" + ID + "&HID=" + HID, this);
            }
        }
       
        protected void grvRpt4_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadAssignment();
        }

        protected void grvRpt4_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("asd_ID").ToString();
                DataTable lstHID = ObjclsFrms.loadList("SelectAssignmentDetailByID", "sp_Web_Promotion", ID);
                string HID = lstHID.Rows[0]["asd_ash_ID"].ToString();
                //Response.Redirect("AddEditAssignmentDetail.aspx?Id=" + ID + "&HID=" + HID);
                OpenNewBrowserWindow("AddEditAssignmentDetail.aspx?Id=" + ID + "&HID=" + HID, this);
            }
        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }
        public void LoadPromotion()
        {
            DataTable lstPromotion = default(DataTable);
            lstPromotion = ObjclsFrms.loadList("SelectPromotionHeaderByPromoID", "sp_Web_Promotion", ddlPromo.SelectedValue.ToString());
            grvRpt1.DataSource = lstPromotion;
        }

        public void LoadRange()
        {
            DataTable lstRange = default(DataTable);
            lstRange = ObjclsFrms.loadList("SelectPromotionRange", "sp_Web_Promotion", ddlPromo.SelectedValue.ToString());
            grvRpt2.DataSource = lstRange;
        }

        public void LoadQualification()
        {
            DataTable lstQualification = default(DataTable);
            lstQualification = ObjclsFrms.loadList("SelectQualifDetailByPromoID", "sp_Web_Promotion", ddlPromo.SelectedValue.ToString());
            grvRpt3.DataSource = lstQualification;
        }

        public void LoadAssignment()
        {
            DataTable lstAssignment = default(DataTable);
            lstAssignment = ObjclsFrms.loadList("SelectAssignDetailByPromoID", "sp_Web_Promotion", ddlPromo.SelectedValue.ToString());
            grvRpt4.DataSource = lstAssignment;
        }

        protected void ddlPromo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadPromotion();
            grvRpt1.Rebind();
            LoadRange();
            grvRpt2.Rebind();
            LoadQualification();
            grvRpt3.Rebind();
            LoadAssignment();
            grvRpt4.Rebind();
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

        protected void rdEndDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            Promo();
        }
    }
}