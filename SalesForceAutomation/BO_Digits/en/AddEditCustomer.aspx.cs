using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomer : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (ResponseID.ToString() == "" || ResponseID.ToString() == "0")
                {
                    pnlRotMapping.Visible = false;
                }
                else
                {
                    pnlRotMapping.Visible = true;
                }    

                Area();
                Class();
                Route();
                CusHeader();
                RouteEdit();
                FillForm();
                Profile();
            }
        }
        public void Profile()
        {

            DataTable lstVehicle = ObjclsFrms.loadList("SelProfileHeaderforDropDown", "sp_ProfileSettings", "tb_Route");
            if (lstVehicle.Rows.Count > 0)
            {
                rdProfile.DataSource = lstVehicle;
                rdProfile.DataValueField = "pfh_ID";
                rdProfile.DataTextField = "pfh_ProfileName";
                rdProfile.DataBind();

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
                string name, code, shortname, total, used, creditdays, addres,watsap,contactperson, contactpersonAR,
                    vat, phe, email, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic,custype,recaptureGeo,AltHOCode, EnableInvoiceApproval,TRN, cusHead;
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
                recaptureGeo= lstDatas.Rows[0]["cus_RecaptureGeo"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                custype = lstDatas.Rows[0]["cus_Type"].ToString();
                watsap= lstDatas.Rows[0]["cus_WhatsappNumber"].ToString();
                contactperson = lstDatas.Rows[0]["cus_ContactPerson"].ToString();
                contactpersonAR = lstDatas.Rows[0]["cus_ContactPerson_ar"].ToString();
                AltHOCode = lstDatas.Rows[0]["cus_AltHOCode"].ToString();

				EnableInvoiceApproval = lstDatas.Rows[0]["cus_EnableInvoiceApproval"].ToString();
                cusHead = lstDatas.Rows[0]["cus_csh_ID"].ToString();
                TRN = lstDatas.Rows[0]["TRN_Number"].ToString();

                txtName.Text = name.ToString();
                txtCode.Text = code.ToString();
                txtCode.Enabled = false;
                txtShortName.Text = shortname.ToString();
                txtAltHOCode.Text = AltHOCode.ToString();
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

				EnableInvAppr.SelectedValue = EnableInvoiceApproval.ToString();
                ddlCusHeader.SelectedValue = cusHead.ToString();
                txtTRN.Text = TRN.ToString();

                if (custype == "NC")
                {
                   
                    pnlCusHead.Visible = false;
                }
                else
                {
                   
                    pnlCusHead.Visible = true;
                }

            }
        }
        protected void Save()

        {
            string name, code, shortname, total, used, creditdays, addres, vat, phe, email, geo, area, cls, status, nameArabic, addressArabic, shortnameArabic,
            custype,whatsapp,cntctperson,cntctpersonAR,recaptureGeo,AltHOCOde, EnableInvoiceApproval, TRN, cusHead;


            name = txtName.Text.ToString();
            code = txtCode.Text.ToString();
            shortname = txtShortName.Text.ToString();
            total = "0.00";
            used = "0.00";
            creditdays = "";
            whatsapp = txtwhatsNo.Text.ToString();
            cntctperson = txtContactPerson.Text.ToString();
            cntctpersonAR = txtARcontactPerson.Text.ToString();
            recaptureGeo = ddlRecapture.SelectedValue.ToString();
            AltHOCOde = txtAltHOCode.Text.ToString();
			EnableInvoiceApproval= EnableInvAppr.SelectedValue.ToString();

			//if (txtTotCrLimit.Text == "")
			//{
			//    total = "0.00";
			//}
			//else
			//{
			//    total = txtTotCrLimit.Text.ToString();
			//}
			//if (txtUsdCrdLimits.Text == "")
			//{
			//    used = "0.00";
			//}
			//else
			//{
			//    used = txtUsdCrdLimits.Text.ToString();
			//}
			//creditdays = txtCrdDayy.Text.ToString();
			vat = "";
            addres = txtad.Text.ToString();
            email = txtEmail.Text.ToString();
            //vat = ddlvat.SelectedValue.ToString();
            phe = txtPerson.Text.ToString();
            geo = txtGeoLoc.Text.ToString();
            area = ddlarea.SelectedValue.ToString();
            cls = ddlcls.SelectedValue.ToString();
            status = ddlStatus.SelectedValue.ToString();
            nameArabic = txtArabName.Text.ToString();
            //shortnameArabic = txtArabShortName.Text.ToString();
            shortnameArabic = "";
            addressArabic = txtArabAddress.Text.ToString();
            custype = ddlcustype.SelectedValue.ToString();
            TRN = txtTRN.Text.ToString();
            string user = UICommon.GetCurrentUserID().ToString();

            if (custype == "NC")
            {
                
                cusHead = "0";
            }
            else
            {
               
                cusHead = ddlCusHeader.SelectedValue.ToString();
            }

            if (ResponseID == 0)
            {
                try
                {
                    ViewState["Value"] = "";
                    string[] arr = { code, shortname, total, used, creditdays, addres, email, vat, phe, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic ,
                    custype ,whatsapp,cntctperson,cntctpersonAR,recaptureGeo,AltHOCOde,EnableInvoiceApproval, cusHead ,TRN , user};

                    string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCustomer", name, arr);
                    ViewState["Value"]= Value.ToString();

                    int res = Int32.Parse(Value.ToString());
                    Session["CusID"] = res;
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Inserted Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
                catch(Exception ex) 
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditCustomer.aspx Save()", "Error : " + ex.Message.ToString() + " - " + innerMessage+"Value:"+ ViewState["Value"].ToString());

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('"+ ViewState["Value"].ToString()+"');</script>", false);
                }
               
            }
            else
            {
                try
                {
                    string id = ResponseID.ToString();
                    string[] arr = { code, shortname, total, used, creditdays, addres, email, vat, phe, geo, area, cls, status, nameArabic, shortnameArabic, addressArabic, id,
                    custype, whatsapp, cntctperson, cntctpersonAR,recaptureGeo,AltHOCOde,EnableInvoiceApproval , cusHead ,TRN, user};
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
                catch (Exception ex)
                {
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditCustomer.aspx Save()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
               
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
        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");
            // Response.Redirect("AddEditCustomer.aspx?Id=" + ID);
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtCode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckCustomerCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                LinkSave.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                LinkSave.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }

        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRouteforMappping", "sp_Masters");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void RouteEdit()
        {
            ddlRoutes.DataSource = ObjclsFrms.loadList("SelectRouteforMappping", "sp_Masters");
            ddlRoutes.DataTextField = "rot_Name";
            ddlRoutes.DataValueField = "rot_ID";
            ddlRoutes.DataBind();
        }
        public void CusHeader()
        {
            ddlCusHeader.DataSource = ObjclsFrms.loadList("SelectCusHeaderfordropdown", "sp_Masters");
            ddlCusHeader.DataTextField = "csh_Name";
            ddlCusHeader.DataValueField = "csh_ID";
            ddlCusHeader.DataBind();
        }

        protected void Routemap_Click(object sender, EventArgs e)
        {
            RouteEdit();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Routemapping();</script>", false);
        }

        protected void Proceedmap_Click(object sender, EventArgs e)
        {
            string RouteID = ddlRoute.SelectedValue.ToString();
            string CusID = Session["CusID"].ToString();
            Response.Redirect("AddEditCusRoute.aspx?RID=" + RouteID + "&Mode=1&CusID=" + CusID);
        }

        protected void ddlcustype_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string cusType = ddlcustype.SelectedValue.ToString();
            if(cusType == "NC")
            {
                
                pnlCusHead.Visible = false;
            }
            else
            {
               
                pnlCusHead.Visible = true;
            }
           
        }

        protected void lnkProceedmapEdit_Click(object sender, EventArgs e)
        {
            string RouteID = ddlRoutes.SelectedValue.ToString();
            string CusID = ResponseID.ToString();
            Response.Redirect("AddEditCusRoute.aspx?RID=" + RouteID + "&Mode=1&CusID=" + CusID);
        }

        protected void lnkProceedwithoutEdit_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomer.aspx");
        }
        protected void ApplyProfile_Click(object sender, EventArgs e)
        {
            try
            {
                string pfh_Id = rdProfile.SelectedValue.ToString();
                if (!string.IsNullOrEmpty(pfh_Id))
                {
                    DataTable dt = ObjclsFrms.loadList("ProdileDetailforMasterForms", "sp_ProfileSettings", pfh_Id);
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            string controlId = dr["pfd_ControlId"].ToString();
                            string controlValues = dr["pfd_Values"].ToString();
                            string controlType = dr["pfd_Type"].ToString();
                            SetControlValues(controlId, controlValues, controlType);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }

        private void SetControlValues(string controlId, string controlValues, string controlType)
        {
            System.Web.UI.Control control = FindControlRecursive(Page, controlId);
            if (control != null)
            {
                if (controlType == "S")
                {
                    if (control is RadDropDownList radDropDownList)
                    {
                        SetRadDropDownListSingleValue(radDropDownList, controlValues);
                    }
                }
                else if (controlType == "M")
                {
                    if (control is RadComboBox radComboBox)
                    {
                        SetRadComboBoxMultipleValues(radComboBox, controlValues);
                    }
                }
                // Handle other control types similarly...
            }
        }

        private void SetRadDropDownListSingleValue(RadDropDownList rd, string controlValue)
        {
            rd.ClearSelection();
            rd.SelectedValue = controlValue;

        }

        private void SetRadComboBoxMultipleValues(RadComboBox radComboBox, string controlValues)
        {
            radComboBox.ClearSelection();
            string[] values = controlValues.Split('-');
            foreach (string value in values)
            {
                RadComboBoxItem item = radComboBox.Items.FindItemByValue(value);
                if (item != null)
                {
                    item.Checked = true;
                }
            }
        }

        private System.Web.UI.Control FindControlRecursive(System.Web.UI.Control root, string id)
        {
            if (root.ID == id)
            {
                return root;
            }

            foreach (System.Web.UI.Control child in root.Controls)
            {
                System.Web.UI.Control found = FindControlRecursive(child, id);
                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
    }
}