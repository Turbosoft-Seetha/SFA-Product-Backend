using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ViewAddEditRoute : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                user();
                DepotSubArea();
                FillForm();

            }

        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }


        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelRouteByID", "sp_Backend", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, username, code, status, pass, unload, deviceid, stlmnt, enforcejp, odometer, rottype, promode, rtntype, lodRej, VantoVan,
                    arabic, rotcheck, loadinSign, loadTransferSign, LoadoutSign, LoadReq, LoadTransfer, LoadInEdit, LoadOutEdit, LoadOutExcessAllow, Depot, paymode, suglodreq;


                name = lstDatas.Rows[0]["rot_Name"].ToString();
                username = lstDatas.Rows[0]["usr_ID"].ToString();
                code = lstDatas.Rows[0]["rot_Code"].ToString();
                pass = lstDatas.Rows[0]["rot_Pass"].ToString();
                unload = lstDatas.Rows[0]["rot_IsUnload"].ToString();
                deviceid = lstDatas.Rows[0]["rot_DeviceID"].ToString();
                stlmnt = lstDatas.Rows[0]["rot_AllowSetlmntDiscrepancy"].ToString();
                enforcejp = lstDatas.Rows[0]["EnforceJP"].ToString();
                odometer = lstDatas.Rows[0]["rot_EnableOdometer"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                rottype = lstDatas.Rows[0]["rot_Type"].ToString();
                promode = lstDatas.Rows[0]["rot_ProductiveModes"].ToString();

                arabic = lstDatas.Rows[0]["rot_ArabicName"].ToString();
                rotcheck = lstDatas.Rows[0]["IsRoutineCheck"].ToString();
                loadinSign = lstDatas.Rows[0]["EnableloadinSign"].ToString();
                loadTransferSign = lstDatas.Rows[0]["EnableloadTransferSign"].ToString();
                LoadoutSign = lstDatas.Rows[0]["EnableLoadOutSign"].ToString();
                LoadReq = lstDatas.Rows[0]["rot_isLoadReq"].ToString();
                LoadTransfer = lstDatas.Rows[0]["rot_isLoadTransfer"].ToString();
                LoadInEdit = lstDatas.Rows[0]["rot_isLoadInEdit"].ToString();
                LoadOutEdit = lstDatas.Rows[0]["rot_isLoadOutEdit"].ToString();
                LoadOutExcessAllow = lstDatas.Rows[0]["isLoadOutExcessAllow"].ToString();
                Depot = lstDatas.Rows[0]["dsa_ID"].ToString();
                paymode = lstDatas.Rows[0]["rot_settlement"].ToString();
                suglodreq = lstDatas.Rows[0]["EnableSuggestedLODReq"].ToString();
                rtntype = lstDatas.Rows[0]["rot_ReturnType"].ToString();
                lodRej = lstDatas.Rows[0]["rot_EnableLoadRejection"].ToString();
                VantoVan = lstDatas.Rows[0]["rot_EnableVantoVan"].ToString();
                string[] ar = paymode.Split('-');

                txtname.Text = name.ToString();
                txtcode.Text = code.ToString();
                txtcode.Enabled = false;
                ddlname.SelectedValue = username.ToString();
                txtpass.Text = pass.ToString();
                ddlis.SelectedValue = unload.ToString();
                txtdeviceid.Text = deviceid.ToString();
                ddlstlmnt.SelectedValue = stlmnt.ToString();
                ddlenforcejp.SelectedValue = enforcejp.ToString();
                ddlodometer.SelectedValue = odometer.ToString();
                ddlStats.SelectedValue = status.ToString();
                txtcode.Enabled = false;
                ddlrotType.SelectedValue = rottype.ToString();
                ddlpromodes.SelectedValue = promode.ToString();

                txtArabicname.Text = arabic.ToString();
                ddlRC.SelectedValue = rotcheck.ToString();
                ddlLIS.SelectedValue = loadinSign.ToString();
                ddlLTS.SelectedValue = loadTransferSign.ToString();
                ddlLOS.SelectedValue = LoadoutSign.ToString();
                ddlLR.SelectedValue = LoadReq.ToString();
                ddlLT.SelectedValue = LoadTransfer.ToString();
                ddlLEdit.SelectedValue = LoadInEdit.ToString();
                ddlLOEdit.SelectedValue = LoadOutEdit.ToString();
                ddlLOExcess.SelectedValue = LoadOutExcessAllow.ToString();
                ddlDepot.SelectedValue = Depot.ToString();
                rcbsugloreq.SelectedValue = suglodreq.ToString();
                rcbreturnType.SelectedValue = rtntype.ToString();
                rcbLodRej.SelectedValue = lodRej.ToString();
                rcbVantoVan.SelectedValue = VantoVan.ToString();
                for (int i = 0; i < ar.Length; i++)
                {
                    foreach (RadComboBoxItem items in ddlpaymode.Items)
                    {
                        if (items.Value == ar[i])
                        {
                            items.Checked = true;
                        }
                    }
                }
            }
        }
        public void user()
        {
            DataTable dt = ObjclsFrms.loadList("SelUserFromDrop", "sp_Backend", ResponseID.ToString());
            ddlname.DataSource = dt;
            ddlname.DataTextField = "usr_Name";
            ddlname.DataValueField = "usr_ID";
            ddlname.DataBind();
        }
        public void DepotSubArea()
        {
            DataTable dt = ObjclsFrms.loadList("SelDepotSubAreaFromDrop", "sp_Backend");
            ddlDepot.DataSource = dt;
            ddlDepot.DataTextField = "dsa_Name";
            ddlDepot.DataValueField = "dsa_ID";
            ddlDepot.DataBind();
        }
        public string paytmodecolumns()
        {
            string retStr = "";
            var checkedItems = ddlpaymode.CheckedItems;
            foreach (var item in checkedItems)
            {
                retStr += item.Value.ToString() + "-";
            }
            retStr = retStr.Remove(retStr.Length - 1, 1);
            return retStr;
        }
    }
}