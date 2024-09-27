using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditOrderDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            Product();
            user();
            FillForm();
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
        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["hid"], out HeaderID);
                return HeaderID;
            }
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("EditOrderDetail", "sp_Masters_Temp", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string item,user,caseqty,pieceqty,caseprice,pieceprice,price,dcasqty,dpieceqty,
                    dtotal,rcaseqty,returnpqty,totaqty,status;
                item = lstDatas.Rows[0]["odd_itm_ID"].ToString();
                user = lstDatas.Rows[0]["odd_usr_ID"].ToString();
                caseqty= lstDatas.Rows[0]["odd_CaseQty"].ToString();
                pieceqty = lstDatas.Rows[0]["odd_PieceQty"].ToString();
                caseprice = lstDatas.Rows[0]["odd_CasePrice"].ToString();
                pieceprice = lstDatas.Rows[0]["odd_PiecePrice"].ToString();
                price = lstDatas.Rows[0]["odd_Price"].ToString();
               dcasqty = lstDatas.Rows[0]["odd_DispatchedCaseQty"].ToString();
                dpieceqty = lstDatas.Rows[0]["odd_DispatchedPieceQty"].ToString();
                dtotal = lstDatas.Rows[0]["odd_DispTotalQty"].ToString();
                rcaseqty = lstDatas.Rows[0]["odd_ReturnCaseQty"].ToString();
                returnpqty= lstDatas.Rows[0]["odd_ReturnPieceQty"].ToString();
               totaqty = lstDatas.Rows[0]["odd_TotalQty"].ToString();

                status = lstDatas.Rows[0]["Status"].ToString();


                ddlitem.SelectedValue = item.ToString();
                ddluser.SelectedValue = user.ToString();
                txtdcase.Text = caseqty.ToString();
                txtdpiece.Text = pieceqty.ToString();
                txtcaseprice.Text = caseprice.ToString();
                txtpieceprice.Text = pieceprice.ToString();
                txtprice.Text = price.ToString();
                txtdcase.Text = dcasqty.ToString();
                txtdpiece.Text = dpieceqty.ToString();
                txttotal.Text = dtotal.ToString();
                txtrc.Text = rcaseqty.ToString();
                txtrp.Text = returnpqty.ToString();
                txttotal.Text = totaqty.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }
        protected void Save()
        {
            string item, userid, caseqty, pieceqty, caseprice, pieceprice, price, dcasqty, dpieceqty,
                    dtotal, rcaseqty, returnpqty, totaqty,  status,user;
            item = ddlitem.SelectedValue.ToString();
            userid= ddluser.SelectedValue.ToString();
            caseqty = txtcase.Text.ToString();
            pieceqty = txtpiece.Text.ToString();
            caseprice = txtcaseprice.Text.ToString();
            pieceprice = txtpieceprice.Text.ToString();
            price = txtprice.Text.ToString();
            dcasqty = txtdcase.Text.ToString();
            dpieceqty = txtdpiece.Text.ToString();
            dtotal = txttotal.Text.ToString();
            rcaseqty = txtrc.Text.ToString();
            returnpqty = txtrp.Text.ToString();
            totaqty = txttotal.Text.ToString();
   
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { item,userid, caseqty, pieceqty, caseprice, pieceprice, price, dcasqty, dpieceqty,
                    dtotal, rcaseqty, returnpqty, totaqty,  status};
                string Value = ObjclsFrms.SaveData("sp_Masters_Temp", "InsertOrderDetail", HeaderID.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Order Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { userid, caseqty, pieceqty, caseprice, pieceprice, price, dcasqty, dpieceqty,
                    dtotal, rcaseqty, returnpqty, totaqty,  status,id };
                string Value = ObjclsFrms.SaveData("sp_Masters_Temp", "UpdateOrderDetail", item.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Order Detail Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }
        public void Product()
        {
            DataTable dtt = ObjclsFrms.loadList("SelectFromDropProductID", "sp_Masters_Temp");
            ddlitem.DataSource = dtt;
            ddlitem.DataTextField = "prd_Name";
            ddlitem.DataValueField = "prd_ID";
            ddlitem.DataBind();
        }

        public void user()
        {
            DataTable dttt = ObjclsFrms.loadList("SelectFromDropUserID", "sp_Masters_Temp");
            ddluser.DataSource = dttt;
            ddluser.DataTextField = "usr_Name";
            ddluser.DataValueField = "usr_ID";
            ddluser.DataBind();
        }


        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/OrderDetail.aspx?id=" + HeaderID);
        }
    }
}