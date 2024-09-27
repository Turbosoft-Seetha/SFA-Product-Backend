using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class SalesInvoiceDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["FromDate"] = DateTime.Parse(Session["FromDate"].ToString());
                ViewState["route"] = Session["rdRoute"].ToString();
                Session["UdpDate"] = ViewState["FromDate"].ToString();
                Session["UdpRoute"] = ViewState["route"].ToString();
                SelSalesAndInvoiceDetailHeader();
                SalesInvoiceProducts();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["salID"], out ResponseID);

                return ResponseID;
            }
        }
        public DataTable LoadData(string mode)
        {

            string[] arr = new string[] {  DateTime.Parse(ViewState["FromDate"].ToString()).ToString("yyyy-MM-dd"), ResponseID.ToString() };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_KPI_Dashboard", ViewState["route"].ToString(), arr);

            return dt;
        }
        public void SelSalesAndInvoiceDetailHeader()
        {
            DataTable dt6 = LoadData("SelSalesAndInvoiceDetailHeader");
            lblSalno.Text = dt6.Rows[0]["sal_number"].ToString();
            lblcusname.Text = dt6.Rows[0]["customer"].ToString();
            lbldate.Text = dt6.Rows[0]["CreatedDate"].ToString();
            rptsalesdet.DataSource = dt6;
            rptsalesdet.DataBind();
            DataTable dt7 = LoadData("SelSalesAndInvoiceTotalDetail");
            lbltotamnt.Text = dt7.Rows[0]["T"].ToString();
            lbltotvat.Text = dt7.Rows[0]["V"].ToString();
            lbltotdisc.Text = dt7.Rows[0]["D"].ToString();
            lblsalgrandtot.Text = dt7.Rows[0]["G"].ToString();

            
            lbltranstype.Text = dt6.Rows[0]["Pay"].ToString();
            string mode = dt6.Rows[0]["inv_PayMode"].ToString();
            rptimage.DataSource = dt6;
           // rptimage.DataSource = new int[1];
            rptimage.DataBind();
            if (mode.Equals("OP") || mode.Equals("POS"))
             {
                img.Visible = true;
             }
            

        }
        public void SalesInvoiceProducts()
        {
            DataTable dt1 =  ObjclsFrms.loadList("SelSalesAndInvoiceDetailProducts", "sp_KPI_Dashboard", ResponseID.ToString()); 
            rptSalesInvoiceProducts.DataSource = dt1;
            rptSalesInvoiceProducts.DataBind();
            
           
        }
    }
}