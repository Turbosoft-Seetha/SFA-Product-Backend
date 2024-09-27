using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditEmployeeRotApprl : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Process();

                DataTable lstEmp = ObjclsFrms.loadList("SelectEmployeeByID", "sp_Masters", ResponseID.ToString());
                if (lstEmp.Rows.Count > 0)
                {
                    string code, name;
                    code = lstEmp.Rows[0]["emp_Code"].ToString();
                    name = lstEmp.Rows[0]["emp_Name"].ToString();

                    lblName.Text = name + " - " + code;
                }
            }
        }
        public void Process()
        {
            DataTable dt = ObjclsFrms.loadList("SelProcess", "sp_Masters");
            ddlProcess.DataSource = dt;
            ddlProcess.DataTextField = "prc_Name";
            ddlProcess.DataValueField = "prc_ID";
            ddlProcess.DataBind();
        }
        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Process();
        }
        public void Route()
        {
            //ddlRoute.ClearSelection();
            string[] arrys = { ddlProcess.SelectedValue.ToString() };
            DataTable dts = ObjclsFrms.loadList("DropDownProcessForRouteAppr", "sp_Masters", ResponseID.ToString(), arrys);
            int x = dts.Rows.Count;
            ddlRoute.DataSource = dts;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public string Pros()
        {
            var CollectionMarket = ddlRoute.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "0";
            }

        }
        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddEditEmployeeRotApprl.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string route  = GetItemFromGrid();
            string emp, process, user;
            emp = ResponseID.ToString();
            process = ddlProcess.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = {process, route, user};
            
            string Value = ObjclsFrms.SaveData("sp_Masters","InsertIntoEmployeeRouteProcess", emp, arr);
            int res = Int32.Parse(Value.ToString());
            if (res >= 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }

            //DataTable lstClaim = ObjclsFrms.Loadlist("InsertIntoEmployeeRouteProcess", "sp_Masters", emp, arr);
            //if (lstClaim.Rows.Count > 0)
            //{
            //    string claimID = lstClaim.Rows[0]["sliderID"].ToString();
            //    ViewState["claimID"] = claimID.ToString();
            //}
            //string claim = ViewState["claimID"].ToString();

            //if (claim == "0")
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            //}
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeesAssignApproval.aspx?Id=" + ResponseID.ToString());
        }
        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = ddlRoute.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode(item.Value, writer);
                            c++;

                        }
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    if (c == 0)
                    {
                        return "";
                    }
                    else
                    {
                        string ss = sw.ToString();
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string rot_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");


            writer.WriteStartElement("erp_rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        protected void ddlProcess_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Route();
        }
    }
}