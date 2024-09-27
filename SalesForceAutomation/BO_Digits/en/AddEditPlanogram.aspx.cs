using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Interop;
using System.Xml;
using Telerik.Web.UI;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditPlanogram : System.Web.UI.Page
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
                Route();
                FillForm();
                company();

                //string rotID = rdRoute.SelectedValue.ToString();
                //if (rotID.Equals("ord_rot_ID"))
                //{
                //    rotID = "0";
                //}
                //string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                //Customers(routeCondition);

            }
        }
        //public string Rot()
        //{
        //    var CollectionMarket = rdRoute.CheckedItems;
        //    string rotID = "";
        //    int j = 0;
        //    int MarCount = CollectionMarket.Count;
        //    if (CollectionMarket.Count > 0)
        //    {
        //        foreach (var item in CollectionMarket)
        //        {
        //            if (j == 0)
        //            {
        //                rotID += item.Value + ",";
        //            }
        //            else if (j > 0)
        //            {
        //                rotID += item.Value + ",";
        //            }
        //            if (j == (MarCount - 1))
        //            {
        //                rotID += item.Value;
        //            }
        //            j++;
        //        }
        //        return rotID;
        //    }
        //    else
        //    {
        //        return "ord_rot_ID";
        //    }
        //}
        public void Route()
        {
            ddlRoute.DataSource = ObjclsFrms.loadList("SelectRotforPlanogram", "sp_MerchandisingWebServices");
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        //public void Customers(string routeCondition)
        //{

        //    rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerforPlanogram", "sp_MerchandisingWebServices", routeCondition);
        //    rdCustomer.DataTextField = "cus_Name";
        //    rdCustomer.DataValueField = "cus_ID";
        //    rdCustomer.DataBind();
        //}
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectPlanogramByID", "sp_MerchandisingWebServices", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, code,route, plgImage,company;
                
                code = lstDatas.Rows[0]["plg_Code"].ToString();
                name = lstDatas.Rows[0]["plg_Name"].ToString();
                //txtcode.Enabled = false;
                route= lstDatas.Rows[0]["plg_rot_ID"].ToString();
                plgImage = lstDatas.Rows[0]["plg_Image"].ToString();
                company = lstDatas.Rows[0]["plg_CompanyCode"].ToString();


                txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                ddlRoute.SelectedValue= route.ToString();
                hpl1.NavigateUrl = plgImage.ToString();
                hlval1.Value = ResponseID.ToString();
                img1.ImageUrl = plgImage.ToString();
                ViewState["plgImage"] = plgImage.ToString();
                ddlplgcompany.SelectedValue = company.ToString();

            }
        }
        public void company()
        {

            string userID = UICommon.GetCurrentUserID().ToString();
            DataTable dt = ObjclsFrms.loadList("selectCompanyForDropDown", "sp_Masters", userID);
            ddlplgcompany.DataSource = dt;
            ddlplgcompany.DataTextField = "com_Name";
            ddlplgcompany.DataValueField = "com_Code";
            ddlplgcompany.DataBind();
        }

        protected void Save()
        {
            string code, name, route, plgImage,company;
            name = txtname.Text.ToString();
            code = txtcode.Text.ToString();
            route = ddlRoute.SelectedValue.ToString();
            string user = UICommon.GetCurrentUserID().ToString();
            string plImage = "";
            company = ddlplgcompany.SelectedValue.ToString();


            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                //ImageID += 1;
                //string csvPath = Server.MapPath(("..") + @"/../UploadFiles/MerchPlanogram/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                //uploadedFile.SaveAs(csvPath);
                //plgImage = @"../../UploadFiles/MerchPlanogram/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                //ViewState["Image"] = plgImage.ToString();

                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/MerchPlanogram/") + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                plImage = @"../../UploadFiles/MerchPlanogram/" + uploadedFile.FileName.ToString();
                ViewState["image"] = plImage.ToString();


            }
             plgImage = "";
            if (ViewState["image"] != null)
            {
                plgImage = ViewState["image"].ToString();
            }
            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string[] arr = { name, route, user, plgImage,company };
                string Value = ObjclsFrms.SaveData("sp_MerchandisingWebServices", "InsertPlanogram", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res >= 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name, route, id, user, plgImage,company };
                string Value = ObjclsFrms.SaveData("sp_MerchandisingWebServices", "UpdatePlanogram", code, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        
        //protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
            //string rotID = rdRoute.SelectedValue.ToString();
            //if (rotID.Equals("ord_rot_ID"))
            //{
            //    rotID = "0";
            //}
            //string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            //Customers(routeCondition);

        //}

        protected void lnkCancel_Click(object sender, EventArgs e)
        {

        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListPlanogram.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            string code = this.txtcode.Text.ToString();
            DataTable lstCodeChecker = ObjclsFrms.loadList("CheckPlanogramCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                lblCodeDupli.Text = "Code Already Exist";
                lnkAdd.Enabled = false;
                lblCodeDupli.Visible = true;
            }
            else
            {
                lnkAdd.Enabled = true;
                lblCodeDupli.Visible = false;
            }
        }
    }
}