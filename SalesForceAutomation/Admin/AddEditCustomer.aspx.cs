using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditCustomer : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillForm();
                Area();
                Class();
            }

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
                string name,code,shortname,total,used,creditdays,addres,
                    vat,phe,email,geo, area,cls,status,nameArabic,shortnameArabic,addressArabic;
                 name = lstDatas.Rows[0]["cus_Name"].ToString();
                nameArabic = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                shortnameArabic = lstDatas.Rows[0]["cus_ShortNameArabic"].ToString();

                addressArabic = lstDatas.Rows[0]["cus_AddressArabic"].ToString();
                code = lstDatas.Rows[0]["cus_Code"].ToString();
                shortname = lstDatas.Rows[0]["cus_ShortName"].ToString();
                total= lstDatas.Rows[0]["cus_TotalCreditLimit"].ToString();
                used= lstDatas.Rows[0]["cus_UsedCreditLimit"].ToString();
                creditdays= lstDatas.Rows[0]["cus_CreditDays"].ToString();               
                addres = lstDatas.Rows[0]["cus_Address"].ToString();
                email = lstDatas.Rows[0]["cus_Email"].ToString();
                vat = lstDatas.Rows[0]["cus_IsVATEnabled"].ToString();
                phe = lstDatas.Rows[0]["cus_Phone"].ToString();
                geo = lstDatas.Rows[0]["cus_GeoCode"].ToString();          
                area = lstDatas.Rows[0]["cus_are_ID"].ToString();
                cls = lstDatas.Rows[0]["cus_cls_ID"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();

                txtName.Text = name.ToString();
                txtCode.Text = code.ToString();
                txtShortName.Text = shortname.ToString();
                txtTotCrLimit.Text = total.ToString();
                txtUsdCrdLimits.Text = used.ToString();
                txtCrdDayy.Text = creditdays.ToString();
                txtad.Text = addres.ToString();
                txtEmail.Text = email.ToString();            
                ddlvat.SelectedValue = vat.ToString();
                txtPerson.Text = phe.ToString();
                txtGeoLoc.Text = geo.ToString();             
                ddlarea.SelectedValue = area.ToString();
                ddlcls.SelectedValue = cls.ToString();
                ddlStatus.SelectedValue = status.ToString();
                txtArabName. Text = nameArabic.ToString();
                txtArabShortName. Text = shortnameArabic.ToString();
                txtArabAddress. Text = addressArabic. ToString();


            }
        }










        protected void Save()
        
        {
            string name, code, shortname, total, used, creditdays,
                addres, vat, phe, email, geo,area,cls, status,nameArabic,addressArabic,shortnameArabic;


            name = txtName.Text.ToString();
            code = txtCode.Text.ToString();
            shortname = txtShortName.Text.ToString();
            if(txtTotCrLimit.Text == "")
            {
                total = "0.00";
            }
            else
            {
                total = txtTotCrLimit.Text.ToString();
            }
            if(txtUsdCrdLimits.Text == "")
            {
                used = "0.00";
            }
            else
            {
                used = txtUsdCrdLimits.Text.ToString();
            }
            creditdays = txtCrdDayy.Text.ToString();
         
            addres = txtad.Text.ToString();
            email = txtEmail.Text.ToString();
            vat = ddlvat.SelectedValue.ToString();
            phe = txtPerson.Text.ToString();
            geo = txtGeoLoc.Text.ToString();        
            area = ddlarea.SelectedValue.ToString();
            cls = ddlcls.SelectedValue.ToString();
            status = ddlStatus.SelectedValue.ToString();
            nameArabic = txtArabName.Text.ToString();
            shortnameArabic = txtArabShortName.Text.ToString();
            addressArabic = txtArabAddress.Text.ToString();



            string id = ResponseID.ToString();
            string[] arr = { code, shortname, total, used,creditdays, addres,email, vat,phe,  geo,area,cls,status,nameArabic,shortnameArabic,addressArabic,id };
            string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCustomer", name, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Updated Successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
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








        protected void lnkAdds_Click(object sender, EventArgs e)
        {

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomer.aspx");
        }

        protected void btnOK_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomer.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomer.aspx");
        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click1(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomer.aspx");
        }

        protected void btnOK_Click2(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomer.aspx");
        }

        protected void save_Click1(object sender, EventArgs e)
        {
            Save();
        }
    }
}