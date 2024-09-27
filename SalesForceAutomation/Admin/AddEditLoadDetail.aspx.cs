using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditLoadDetail : System.Web.UI.Page
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

               
                Product();
                FillForm();


            }

        }
        


        public void FillForm()
        {
            string Id = ResponseID.ToString();
            if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
            {

            }
            else                                                                        //If we are editing there will be a value and the following code will be executed.
            {


                DataTable lstDatas = ObjclsFrms.loadList("EditLoadInDetail", "sp_Masters", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    string item,caseqty,pieceqty, opncase, opnpiece, Fcase, Fpiece, status;                                          //Declare the variables
                   
                    item = lstDatas.Rows[0]["lid_prd_ID"].ToString();

                   
                    caseqty = lstDatas.Rows[0]["lid_CaseQty"].ToString();
                   pieceqty = lstDatas.Rows[0]["lid_PieceQty"].ToString();
                    opncase = lstDatas.Rows[0]["lid_OpenCaseQty"].ToString();
                    opnpiece= lstDatas.Rows[0]["lid_OpenPieceQty"].ToString();
                    Fcase= lstDatas.Rows[0]["lid_FreshCaseQty"].ToString();
                    Fpiece= lstDatas.Rows[0]["lid_FreshPieceQty"].ToString();
                    status = lstDatas.Rows[0]["Status"].ToString();

                    
                    ddlp.SelectedValue = item.ToString();
                    txtCaseQty.Text = caseqty.ToString();
                    txtPieceQty.Text =pieceqty.ToString();
                    txtopen.Text = opncase.ToString();
                    txtopnpiece.Text = opnpiece.ToString();
                    txtFcase.Text = Fcase.ToString();
                    txtFpiece.Text = Fpiece.ToString();
                    ddlstatuss.SelectedValue = status.ToString();



                }
                else                                                              //If there is no value you can leave it as it is.
                {

                }
            }
        }
        
       

       
        
        public void SaveData()


        {

            
            string   item, caseqty, pieceqty,opncase,opnpiece,Fcase,Fpiece, user, status;                                          //Declare the variables
           

          
            item = ddlp.SelectedValue.ToString();
            caseqty = txtCaseQty.Text.ToString();
            pieceqty = txtPieceQty.Text.ToString();
            opncase = txtopen.Text.ToString();
            opnpiece = txtopnpiece.Text.ToString();
            Fcase = txtFcase.Text.ToString();
            Fpiece = txtFpiece.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlstatuss.SelectedValue.ToString();
            // string[] arrr = { pname,  dates, date };




            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                
                string[] arr = { item, caseqty, pieceqty, opncase, opnpiece, Fcase, Fpiece, user, status };
                                                  //Declare the variables

            string Value = ObjclsFrms.SaveData("sp_Masters", "InsertLoadInDetail", HeaderID.ToString(), arr);

                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Load In Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = {  caseqty, pieceqty, opncase, opnpiece, Fcase, Fpiece, status, ID };
                string value = ObjclsFrms.SaveData("sp_Masters", "UpdateLoadInDetail", item, arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Load In Detail Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }
       
        public void Product()
        {
            DataTable dtt = ObjclsFrms.loadList("SelectFromDropProductID", "sp_Masters");
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
           
        }

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }


        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListLoadInDetail.aspx?id="+HeaderID);
        }

        protected void ddlids_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
          
        }
    }
}