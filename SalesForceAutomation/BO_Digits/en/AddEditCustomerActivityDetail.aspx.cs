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
    public partial class AddEditCustomerActivityDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdDueDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                ViewState["RefImage"] = null;
                FillForm();
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
        public int HID
        {
            get
            {
                int HID;
                int.TryParse(Request.Params["HID"], out HID);

                return HID;
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelCusActivityDetailByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, desc, duedate, SortOrder,  type, img;
                //code = lstDatas.Rows[0]["cad_Code"].ToString();
                name = lstDatas.Rows[0]["cad_Name"].ToString();
                desc = lstDatas.Rows[0]["cad_Description"].ToString();
                duedate = lstDatas.Rows[0]["cad_DueDate"].ToString();
                SortOrder = lstDatas.Rows[0]["cad_SortOrder"].ToString();
               // status = lstDatas.Rows[0]["Status"].ToString();
                type = lstDatas.Rows[0]["cad_Type"].ToString();
                img = lstDatas.Rows[0]["cad_ReferenceImage"].ToString();

                //txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                txtDesc.Text = desc.ToString();
                rdDueDate.SelectedDate = DateTime.Parse(duedate.ToString());
                txtsortorder.Text = SortOrder.ToString();
               // ddlStatus.SelectedValue = status.ToString();
                txttype.Text = type.ToString();

                hpl1.NavigateUrl = img.ToString();
                hlval1.Value = ResponseID.ToString();
                img1.ImageUrl = img.ToString();
                ViewState["RefImage"] = img.ToString();

            }
        }

        protected void Save()
        {
            string name, desc, duedate, user, SortOrder,  type, img;

            name = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            desc = txtDesc.Text.ToString();
            duedate = DateTime.Parse(rdDueDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            SortOrder = txtsortorder.Text.ToString();
            //status = ddlStatus.SelectedValue.ToString();
            type = txttype.Text.ToString();
            img = "";
            int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                ImageID += 1;
                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/CustomerActivity/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                img = @"UploadFiles/CustomerActivity/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                ViewState["Image"] = img.ToString();
            }
            if (img == "")
            {
                img = ViewState["RefImage"].ToString();
            }
            else
            {
                img = ViewState["Image"].ToString();
            }
            if (img != null)
            {
                if (ResponseID.Equals("") || ResponseID == 0)
                {

                    string[] arr = { desc, duedate, SortOrder, user,  HID.ToString(), type, img };
                    string Value = ObjclsFrms.SaveData("sp_Masters", "InsertCusActivityDetail", name, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Detail Saved Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }

                }

                else
                {
                    string id = ResponseID.ToString();
                    string[] arr = { name, desc, duedate, SortOrder, user,  type, img };
                    string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCusActivityDetail", id, arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)

                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Detail Updated Successfully');</script>", false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivityDetail.aspx?HID=" + HID.ToString());
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivityDetail.aspx?HID=" + HID.ToString());
        }
    }
}