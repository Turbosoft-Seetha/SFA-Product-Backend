using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditCustomerFOC : System.Web.UI.Page
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
                
                rdFromData.SelectedDate = DateTime.Now;
                DateTime dt= DateTime.Now;
                TimeSpan oneday = new TimeSpan(1, 0, 0, 0);
                dt = dt.Add(oneday);
                rdEndDate.SelectedDate = dt;
                Route();
                FillForm();
                ViewState["Hupc"] = "";
                ViewState["Lupc"] = "";
            }
        }
        public void FillForm()
        {
            string Id = ResponseID.ToString();
            if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
            {
                rdFromData.MinDate = DateTime.Now;
                DateTime dt = DateTime.Now;
                TimeSpan oneday = new TimeSpan(1, 0, 0, 0);
                dt = dt.Add(oneday);

                rdEndDate.MinDate = dt;
            }
            else                                                                        //If we are editing there will be a value and the following code will be executed.
            {


                DataTable lstDatas = ObjclsFrms.loadList("SelectFOCByID", "sp_Masters_UOM", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    string name, rotid, cusid, pname, eligible, fromdate, todate, huom, hqty, luom, lqty;                                          //Declare the variables
                    name = lstDatas.Rows[0]["rcs_ID"].ToString();
                    rotid = lstDatas.Rows[0]["rcs_rot_ID"].ToString();

                    Customer(rotid);
                    cusid = lstDatas.Rows[0]["rcs_cus_ID"].ToString();
                    Product(rotid, cusid);
                    pname = lstDatas.Rows[0]["crf_prd_ID"].ToString();
                    eligible = lstDatas.Rows[0]["crf_EligibleQty"].ToString();
                    fromdate = lstDatas.Rows[0]["crf_FromDate"].ToString();
                    todate = lstDatas.Rows[0]["crf_ToDate"].ToString();
                    

                    ddlids.SelectedValue = rotid.ToString();
                    ddlCus.SelectedValue = cusid.ToString();
                    ddlp.SelectedValue = pname.ToString();
                    txteligible.Text = eligible.ToString();

                    rdFromData.SelectedDate = DateTime.Parse(fromdate.ToString());
                    rdEndDate.SelectedDate = DateTime.Parse(todate.ToString());
                    rdFromData.Enabled = false;
                    rdEndDate.Enabled=false;

                    string[] arr = { eligible };
                    DataTable lst = ObjclsFrms.loadList("SelectHuomLuomfromtotqty", "sp_Masters_UOM", pname,arr);
                    huom = lst.Rows[0]["HUom"].ToString();
                    hqty = lst.Rows[0]["HQty"].ToString();
                    luom = lst.Rows[0]["LUOM"].ToString();
                    lqty = lst.Rows[0]["Lqty"].ToString();
                    
                    txtHUom.Text = huom.ToString();
                    txtHQty.Text = hqty.ToString();
                    txtLUom.Text = luom.ToString();
                    txtLQty.Text = lqty.ToString();
                    


                }
                else                                                              //If there is no value you can leave it as it is.
                {

                }
            }
        }


        public void SaveData()
        {

            string rotid, cusid, id,eligible;

            rotid = ddlids.SelectedValue.ToString();
            cusid = ddlCus.SelectedValue.ToString();
            eligible = txteligible.Text.ToString();
            string[] arrr = { cusid };
            DataTable lstUserr = default(DataTable);
            lstUserr = ObjclsFrms.loadList("selectCustomerAndRotID", "sp_Masters_UOM", rotid, arrr);
             id = lstUserr.Rows[0]["rcs_ID"].ToString();
           
            string dates = DateTime.Parse(rdFromData.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");

            string pname, user;
                  
            pname = ddlp.SelectedValue.ToString();
            
            user = UICommon.GetCurrentUserID().ToString();
           
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = { pname, dates, date, user,eligible };
                string Value = ObjclsFrms.SaveData("sp_Masters_UOM", "InsertFOC", id, arr);

                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer FOC saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = { pname, dates, date,user, ID, eligible};
                string value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdateFOC", id, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer FOC updated successFully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlids.DataSource = dt;
            ddlids.DataTextField = "rot_Name";
            ddlids.DataValueField = "rot_ID";
            ddlids.DataBind();
        }
        public void Customer(string route)
        {
            DataTable dts = ObjclsFrms.loadList("DropDownCustomerForRoute", "sp_Masters_UOM", route.ToString());
            int x = dts.Rows.Count;
            ddlCus.DataSource = dts;
            ddlCus.DataTextField = "cus_Name";
            ddlCus.DataValueField = "cus_ID";
            ddlCus.DataBind();
        }

        public void Product(string rot,string cus)
        {
            string[] arr = {cus.ToString() };
            DataTable dtt = ObjclsFrms.loadList("SelFromDropProductID", "sp_Masters_UOM", rot.ToString(),arr);
            ddlp.DataSource = dtt;
            ddlp.DataTextField = "prd_Name";
            ddlp.DataValueField = "prd_ID";
            ddlp.DataBind();
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomerFOC.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListCustomerFOC.aspx");
        }



        protected void ddlids_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = ddlids.SelectedValue.ToString();
            Customer(rot);
        }


       
        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //HUOM(ddlp.SelectedValue.ToString());
        }
       
       
       

        protected void ddlCus_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = ddlids.SelectedValue.ToString();
            string cus = ddlCus.SelectedValue.ToString();
            Product(rot,cus);
        }

        protected void txteligible_TextChanged(object sender, EventArgs e)
        {
            if (!(ddlp.SelectedValue =="" || txteligible.Text.Equals("0")))
            {
                string huom, hqty, luom, lqty, eligible, pname;
                eligible = txteligible.Text;
                string[] arr = { eligible };
                pname = ddlp.SelectedValue.ToString();
                DataTable lst = ObjclsFrms.loadList("SelectHuomLuomfromtotqty", "sp_Masters_UOM", pname, arr);
                huom = lst.Rows[0]["HUom"].ToString();
                hqty = lst.Rows[0]["HQty"].ToString();
                luom = lst.Rows[0]["LUOM"].ToString();
                lqty = lst.Rows[0]["Lqty"].ToString();

                txtHUom.Text = huom.ToString();
                txtHQty.Text = hqty.ToString();
                txtLUom.Text = luom.ToString();
                txtLQty.Text = lqty.ToString();
            }
        }
    }
}