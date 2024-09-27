using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class NewPasswordGeneration_a : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                Features();
                Time();

            }
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("rotfornewPassword", "sp_Masters_UOM");
            rdRoute.DataTextField = "rot";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();

        }
        public void Customers()
        {
            rdCus.DataSource = ObjclsFrms.loadList("CusfornewPassword", "sp_Masters_UOM", rdRoute.SelectedValue.ToString());
            rdCus.DataTextField = "cus";
            rdCus.DataValueField = "cus_ID";
            rdCus.DataBind();

        }
        public void Features()
        {
            rdFeature.DataSource = ObjclsFrms.loadList("FeaturefornewPassword", "sp_Masters_UOM");
            rdFeature.DataTextField = "otp_Name";
            rdFeature.DataValueField = "otp_Value";
            rdFeature.DataBind();
        }
        public void Time()
        {
            rdTimeZone.DataSource = ObjclsFrms.loadList("TimeZoneForPassword", "sp_Masters_UOM");
            rdTimeZone.DataTextField = "tmz_Name";
            rdTimeZone.DataValueField = "tmz_Code";
            rdTimeZone.DataBind();
        }

        protected void rdRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Customers();
        }
        public static string GeneratePassword(long RouteCode, long CustomerCode, long feature, int companyCode, int validityPeriod, string keys, string timezone)
        {
            GeneralFunctions ObjclsFrm = new GeneralFunctions();
            long CustomerVar = CustomerCode;
            if (CustomerVar == 0) CustomerVar = 1;
           
            CustomerVar *= (RouteCode * 33);
            string CustomerVariable = ((CustomerVar / long.Parse(keys))).ToString();
            string FeatureVariable = ((long)(long.Parse(keys) / (feature * 100 + companyCode))).ToString();
            CustomerVariable = CustomerVariable.Substring(CustomerVariable.Length - 1, 1);
            FeatureVariable = FeatureVariable.Substring(FeatureVariable.Length - 1, 1);

            Random rnd = new Random();
            int irnd = rnd.Next(2, 10);
            DateTime expirationTime;

            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(string));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("utc", typeof(string));

            foreach (TimeZoneInfo z in TimeZoneInfo.GetSystemTimeZones())
            {
                dt.Rows.Add(z.Id, z.StandardName, z.BaseUtcOffset);
            }

            int x = dt.Rows.Count;

            TimeZoneInfo tmZone = null;

            try
            {

                tmZone = TimeZoneInfo.FindSystemTimeZoneById(timezone);
            }
            catch
            {

                tmZone = TimeZoneInfo.Local;
            }
           
            DateTime utc = DateTime.UtcNow;
            
            DateTime Nowtm = TimeZoneInfo.ConvertTimeFromUtc(utc, tmZone);
            expirationTime = Nowtm.AddMinutes(validityPeriod);
            string expiration = ((expirationTime.Hour * 60 + expirationTime.Minute) / irnd).ToString();
            expiration = expiration.PadLeft(3, '0');
            string key = irnd.ToString() + "" + FeatureVariable + "" + expiration + "" + CustomerVariable;
            ObjclsFrm.TraceService("OverRide:- Nowtm:" + Nowtm + "||expirationTime:-" + expirationTime + "||expiration:-" + expiration + "||irnd:-" + irnd + "||FeatureVariable:-" + FeatureVariable + "||CustomerVariable:-" + CustomerVariable);
            return key;

        }

        protected void btn_Click(object sender, EventArgs e)
        {
            try
            {
                string test = rdTimeZone.SelectedValue.ToString();

                string key = GeneratePassword(Convert.ToInt64(rdRoute.SelectedValue.ToString()), Convert.ToInt64(rdCus.SelectedValue.ToString()),
                               Convert.ToInt64(rdFeature.SelectedValue.ToString()), 1, 10, txtKey.Text.ToString(), rdTimeZone.SelectedValue.ToString());
                txtPass.Text = key;
                Save();
            }
            catch (Exception ex)
            {
                StringBuilder ltrlSuccess = new StringBuilder();
                ltrlSuccess.Append("<div class=\"col-lg-12\">");
                ltrlSuccess.AppendFormat("<span>{0}.</span>", ex.Message.ToString());
                ltrlSuccess.Append("</div>");
                ltrSuccess.Text = ltrlSuccess.ToString();
            }
        }
        public void Save()
        {
            string rot, cus, feature, key, pass, user, timezone;
            rot = rdRoute.SelectedValue.ToString();
            cus = rdCus.SelectedValue.ToString();
            feature = rdFeature.SelectedValue.ToString();
            key = txtKey.Text.ToString();
            pass = txtPass.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            timezone = rdTimeZone.SelectedValue.ToString();


            string[] arr = { cus, feature, key, pass, user, timezone };
            string Value = ObjclsFrms.SaveData("sp_Masters_UOM", "InsOverrideReq", rot, arr);
            int res = Int32.Parse(Value.ToString());
            ViewState["id"] = res.ToString();
            StringBuilder ltrlSuccess = new StringBuilder();
            if (res > 0)
            {

                ltrlSuccess.Append("<div class=\"col-lg-12\">");
                ltrlSuccess.Append("<span style=\"color:green;\">Override Request has been saved successfully.</span>");
                ltrlSuccess.Append("</div>");

            }
            else
            {

                ltrlSuccess.Append("<div class=\"col-lg-12\">");
                ltrlSuccess.Append("<span>Something went wrong..Please try again.</span>");
                ltrlSuccess.Append("</div>");

                //Response.Redirect("NewPasswordGeneration.aspx");

            }

            ltrSuccess.Text = ltrlSuccess.ToString();

        }


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewPasswordGeneration.aspx");

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListNewPasswordGeneration.aspx");
        }

       
    }
}