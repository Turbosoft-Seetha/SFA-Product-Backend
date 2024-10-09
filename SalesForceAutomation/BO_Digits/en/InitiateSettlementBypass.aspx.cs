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
    public partial class InitiateSettlementBypass : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!Page.IsPostBack)
            {
                try
                {
                    GetGridSession(grvRpt, "ISB");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
            }

        }
        public void LoadList(string mode)
        {
           

           
            DataTable lstUser=default(DataTable);
           
            lstUser = ObjclsFrms.loadList("ListInitiateSettlement", "sp_Merchandising");
         

            grvRpt.DataSource = lstUser;

        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList("");
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

            try
            {
                RadGrid grd = (RadGrid)sender;

                SetGridSession(grd, "ISB");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/SignIn.aspx");
            }



            if (e.CommandName.Equals("Initiate"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("udp_ID").ToString();
                string rotCode = dataItem["rot_Code"].Text.ToString();
                string userID = dataItem["udp_usr_ID"].Text.ToString();
                string routeID = dataItem["udp_rot_ID"].Text.ToString(); 

                ViewState["SelectedUdpID"] = ID;
                ViewState["SelectedRouteCode"] = rotCode;
                ViewState["SelectedRouteID"] = routeID;
                ViewState["SelecteduserID"] = userID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confirm();</script>", false);

            }
           
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

       

        

     

        protected void insertRoute_Click(object sender, EventArgs e)
        {
            lblerror.Text = "";
            string selectedRouteCode="";
            string enteredRouteCode = txtConfirmRouteCode.Text.Trim();
            try 
            { 
             selectedRouteCode = ViewState["SelectedRouteCode"]?.ToString();
            }
            catch (Exception ex)
            {
                
            }
            int res = 0;

          
               if (!string.Equals(enteredRouteCode, selectedRouteCode, StringComparison.OrdinalIgnoreCase))
            {
                lblerror.Text = "The entered route code does not match the selected route code.";
                lblerror.ForeColor = System.Drawing.Color.Red;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "hideError", "<script type='text/javascript'>setTimeout(function(){ document.getElementById('" + lblerror.ClientID + "').style.display = 'none'; }, 3500);</script>", false);
                lblerror.Style["display"] = "block"; // Ensure the label is visible

                
            }
            else
            {
                lblerror.Text = "";
                try
                {
                    string user = UICommon.GetCurrentUserID().ToString();
                    string udpID = ViewState["SelectedUdpID"]?.ToString();
                    string userID = ViewState["SelecteduserID"]?.ToString();
                    string routeID = ViewState["SelectedRouteID"]?.ToString();
                   
                        
                        string[] arr = { userID, routeID, udpID };


                    string Resp = ObjclsFrms.SaveData("sp_Merchandising", "SettlementRequestInsertion", user, arr);
                    res = Int32.Parse(Resp.ToString());

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failure('" + ex.Message + "');</script>", false);
                }



                if (res > 0)
                {

                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Inserted successfully');</script>", false);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Success('Inserted successfully');</script>", false);
                }
                else
                {
                    //failedmodal
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something went wrong!!');</script>", false);
                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failure('Something went wrong!!');</script>", false);

                }
            }


        }
        public void SetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                foreach (Telerik.Web.UI.GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        string filterValue = column.CurrentFilterValue;

                        Session[SessionPrefix + columnName] = filterValue;

                    }

                }

            }

            catch (Exception ex)

            {

                Response.Redirect("~/SignIn.aspx");

            }



        }

        public void GetGridSession(RadGrid grd, string SessionPrefix)

        {

            try

            {

                string filterExpression = string.Empty;

                foreach (Telerik.Web.UI.GridColumn column in grd.MasterTableView.Columns)

                {

                    if (column is GridBoundColumn boundColumn)

                    {

                        string columnName = boundColumn.UniqueName;

                        if (Session[SessionPrefix + columnName] != null)

                        {

                            string filterValue = Session[SessionPrefix + columnName].ToString();



                            if (filterValue != "")
                            {

                                column.CurrentFilterValue = filterValue;



                                if (!string.IsNullOrEmpty(filterExpression))

                                {

                                    filterExpression += " AND ";

                                }

                                filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);

                            }

                        }

                    }

                }

                if (filterExpression != string.Empty)

                {

                    grvRpt.MasterTableView.FilterExpression = filterExpression;

                }



            }

            catch (Exception ex)

            {

                Response.Redirect("~/SignIn.aspx");

            }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("InitiateSettlementBypass.aspx");
        }
    }
}