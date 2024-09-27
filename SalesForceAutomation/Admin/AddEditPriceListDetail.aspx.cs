using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditPriceListDetail : System.Web.UI.Page
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
       

        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["hid"], out HeaderID);
                return HeaderID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HeaderData();
                
                product();
                

                string Id = ResponseID.ToString();
                if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
                {

                }
                else                                                                        //If we are editing there will be a value and the following code will be executed.
                {
                    DataTable lstDatas = ObjclsFrms.loadList("EditPriceListDetail", "sp_Masters_UOM", ResponseID.ToString());
                    if (lstDatas.Rows.Count > 0)
                    {

                        string  pname, vat , Status,fromdate, todate;                                          //Declare the variables
                        pname = lstDatas.Rows[0]["pld_prd_ID"].ToString();
                        //caseprice = lstDatas.Rows[0]["pld_CasePrice"].ToString();
                        //  piece = lstDatas.Rows[0]["pld_PiecePrice"].ToString();

                        
                        Status = lstDatas.Rows[0]["Status"].ToString();
                        
                        

                        
                        ddlp.SelectedValue = pname.ToString();
                        //txtcase.Text = caseprice.ToString();
                        //txtPiece.Text = piece.ToString();
                        
                        ddlstatus.SelectedValue = Status.ToString();
                       



                    }
                    else {                                                            

                    }
                }
            }

        }

        public void HeaderData()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelPriceListHeader", "sp_Masters", HeaderID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                lblprh.Text = lstDatas.Rows[0]["prh_Name"].ToString();
                lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();



            }
        }
        public void Uom()
        {
            string product, header;
            product = ddlp.SelectedValue.ToString();
            header = HeaderID.ToString();
            string[] arr = { header };
            DataTable ds = ObjclsFrms.loadList("SelectUomForDrop", "sp_Masters",product,arr);
            ddlUom.DataSource = ds;
            ddlUom.DataTextField = "uom_Name";
            ddlUom.DataValueField = "uom_ID";
            ddlUom.DataBind();
        }


        public void product()
        {
            DataTable dt = ObjclsFrms.loadList("SelFromDropProductID", "sp_Masters", ResponseID.ToString());
            ddlp.DataSource = dt;
            ddlp.DataTextField = "prd_Name";
            ddlp.DataValueField = "prd_ID";
            ddlp.DataBind();
        }

        public void StdUomProductPrice()
        {
            string prd, uom;
            prd = ddlp.SelectedValue.ToString();
            uom = ddlUom.SelectedValue.ToString();
            string[] arr = { uom };
            DataTable lstDatas = ObjclsFrms.loadList("StdUomProductPrice", "sp_Masters",prd,arr);
            if (lstDatas.Rows.Count > 0)
            {
                string price;
                price = lstDatas.Rows[0]["pru_Price"].ToString();                
                txtstdprice.Text = price.ToString();              
            }
        }

       
        public void SaveData()
        {
            
            string  pname,user, Status,uom,price,rtnprice;                                          //Declare the variables

            
            pname = ddlp.SelectedValue.ToString();
            uom = ddlUom.SelectedValue.ToString();
            price = txtprice.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            Status = ddlstatus.SelectedValue.ToString();
            rtnprice = txtRtnPrice.Text.ToString();
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = { pname,  user, Status,uom,price, rtnprice };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertPriceListDetail",HeaderID.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Price List Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            //else
            //{


            //    string ID = ResponseID.ToString();
            //    string[] arr = {   vat, Status,ID,uom,price };
            //    string value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdatePriceListDetail", pname, arr);
            //    int res = Int32.Parse(value.ToString());
            //    if (res > 0)
            //    {
            //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Price List Detail Updated Successfully');</script>", false);
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            //    }


            //}
        }
            protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListPriceListDetail.aspx?id="+HeaderID);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim('');</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListPriceListDetail.aspx?id=" + HeaderID);
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Uom();

        }

        protected void ddlUom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            StdUomProductPrice();
        }
    }
}