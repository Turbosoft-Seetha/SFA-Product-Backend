using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditRoutePrinter : System.Web.UI.Page
    {

        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable lstRoute = ObjclsFrms.loadList("SelectRouteByID", "sp_Masters", RouteID.ToString());
                cusroute.Text = "Route  :" + lstRoute.Rows[0]["rot_Name"].ToString();
                ViewState["rotcode"] = lstRoute.Rows[0]["rot_Name"].ToString();
                FillForm();
                PrinterType();
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["RPID"], out ResponseID);
                return ResponseID;
            }
        }
        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RID"], out RouteID);
                return RouteID;
            }
        }
        public void PrinterType()
        {
            DataTable dt = ObjclsFrms.loadList("SelectPrinterType", "sp_Masters", RouteID.ToString());
            ddlPType.DataSource = dt;
            ddlPType.DataTextField = "ptt_Value";
            ddlPType.DataValueField = "ptt_ID";
            ddlPType.DataBind();
        }
        public void PrinterModel( string ddlPType)
        {
            DataTable dt = ObjclsFrms.loadList("SelectPrinterModel", "sp_Masters", ddlPType);
            ddlPModel.DataSource = dt;
            ddlPModel.DataTextField = "ptr_Name";
            ddlPModel.DataValueField = "ptr_ID";
            ddlPModel.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRoutePrinterByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string PType, PModel, Pmacid;
                PType = lstDatas.Rows[0]["rpr_ptt_ID"].ToString();
                Pmacid = lstDatas.Rows[0]["rpr_MacID"].ToString();
                PModel = lstDatas.Rows[0]["rpr_ptr_ID"].ToString();
                ddlPType.SelectedValue = PType.ToString();
                PrinterModel(PType);
                ddlPModel.SelectedValue = PModel.ToString();
                txtmacid.Text = Pmacid.ToString();


            }
        }
        protected void Save()
        {
            string PType, PModel, Pmacid, user;
            PType = ddlPType.SelectedValue.ToString();
            Pmacid = txtmacid.Text.ToString();
            PModel = ddlPModel.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();



            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { PType, PModel, user, RouteID.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertRoutePrinter", Pmacid, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Printer Details Added Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { PType, PModel, id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateRoutePrinter", Pmacid, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Printer Details Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            string[] arr = { RouteID.ToString() };
            DataTable lstDatas = ObjclsFrms.loadList("SelectPrinterMacID", "sp_Masters", txtmacid.Text,arr);
            if (lstDatas.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>MAC();</script>", false);

            } 
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("ListRoutePrinter.aspx?RID=" + ID);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string ID = RouteID.ToString();
            Response.Redirect("ListRoutePrinter.aspx?RID=" + ID);
        }

        protected void ddlPType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            PrinterModel(ddlPType.SelectedValue.ToString());
        }
    }
}