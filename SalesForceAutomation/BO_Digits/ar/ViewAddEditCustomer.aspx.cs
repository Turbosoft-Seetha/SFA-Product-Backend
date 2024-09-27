using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ViewAddEditCustomer : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Area();
                Class();
                FillForm();

            }
        }
        public void Area()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromAreaByID", "sp_Masters");
            ddlarea.DataSource = dt;
            ddlarea.DataTextField = "are_Name";
            ddlarea.DataValueField = "are_ID";
            ddlarea.DataBind();
        }

        public void Class()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromClassByID", "sp_Masters");
            ddlcls.DataSource = dt;
            ddlcls.DataTextField = "cls_Name";
            ddlcls.DataValueField = "cls_ID";
            ddlcls.DataBind();
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelCustomerByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, code, shortname, total, used, creditdays, addres, watsap, contactperson, contactpersonAR,
                    vat, phe, email, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic, custype, recaptureGeo;
                name = lstDatas.Rows[0]["cus_Name"].ToString();
                nameArabic = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                shortnameArabic = lstDatas.Rows[0]["cus_ShortNameArabic"].ToString();

                addressArabic = lstDatas.Rows[0]["cus_AddressArabic"].ToString();
                code = lstDatas.Rows[0]["cus_Code"].ToString();
                shortname = lstDatas.Rows[0]["cus_ShortName"].ToString();
                //total = lstDatas.Rows[0]["cus_TotalCreditLimit"].ToString();
                //used = lstDatas.Rows[0]["cus_UsedCreditLimit"].ToString();
                //creditdays = lstDatas.Rows[0]["cus_CreditDays"].ToString();
                addres = lstDatas.Rows[0]["cus_Address"].ToString();
                email = lstDatas.Rows[0]["cus_Email"].ToString();
                //vat = lstDatas.Rows[0]["cus_IsVATEnabled"].ToString();
                phe = lstDatas.Rows[0]["cus_Phone"].ToString();
                geo = lstDatas.Rows[0]["cus_GeoCode"].ToString();
                area = lstDatas.Rows[0]["cus_are_ID"].ToString();
                cls = lstDatas.Rows[0]["cus_cls_ID"].ToString();
                recaptureGeo = lstDatas.Rows[0]["cus_RecaptureGeo"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                custype = lstDatas.Rows[0]["cus_Type"].ToString();
                watsap = lstDatas.Rows[0]["cus_WhatsappNumber"].ToString();
                contactperson = lstDatas.Rows[0]["cus_ContactPerson"].ToString();
                contactpersonAR = lstDatas.Rows[0]["cus_ContactPerson_ar"].ToString();
                txtName.Text = name.ToString();
                txtCode.Text = code.ToString();
                txtCode.Enabled = false;
                txtShortName.Text = shortname.ToString();
                //txtTotCrLimit.Text = total.ToString();
                //txtUsdCrdLimits.Text = used.ToString();
                //txtCrdDayy.Text = creditdays.ToString();
                txtad.Text = addres.ToString();
                txtEmail.Text = email.ToString();
                //ddlvat.SelectedValue = vat.ToString();
                txtPerson.Text = phe.ToString();
                txtGeoLoc.Text = geo.ToString();
                ddlarea.SelectedValue = area.ToString();
                ddlcls.SelectedValue = cls.ToString();
                ddlStatus.SelectedValue = status.ToString();
                ddlRecapture.SelectedValue = recaptureGeo.ToString();
                txtArabName.Text = nameArabic.ToString();
                //txtArabShortName.Text = shortnameArabic.ToString();
                txtArabAddress.Text = addressArabic.ToString();
                ddlcustype.SelectedValue = custype.ToString();
                txtwhatsNo.Text = watsap.ToString();
                txtContactPerson.Text = contactperson.ToString();
                txtARcontactPerson.Text = contactpersonAR.ToString();

            }
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCustomerCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";

                lblCodeDupli.Visible = true;
            }
            else
            {

                lblCodeDupli.Visible = false;
            }
        }
    }
}