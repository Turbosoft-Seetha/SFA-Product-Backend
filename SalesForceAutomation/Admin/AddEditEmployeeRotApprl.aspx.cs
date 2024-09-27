using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Xml;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditEmployeeRotApprl : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Eid"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();

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
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRoute", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }

        protected void ddlRoute_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Process();
        }

        public void Process()
        {
            ddlProcess.ClearSelection();
            string[] arrys = { ddlRoute.SelectedValue.ToString() };
            DataTable dts = ObjclsFrms.loadList("DropDownProcessForRouteAppr", "sp_Masters", ResponseID.ToString(), arrys);
            int x = dts.Rows.Count;
            ddlProcess.DataSource = dts;
            ddlProcess.DataTextField = "prc_Name";
            ddlProcess.DataValueField = "prc_ID";
            ddlProcess.DataBind();
        }
        public string Pros()
        {
            var CollectionMarket = ddlProcess.CheckedItems;
            string prosID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        prosID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        prosID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        prosID += item.Value;
                    }
                    j++;
                }
                return prosID;
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
            string process = GetItemFromGrid();
            string emp, route, user;
            emp = ResponseID.ToString();
            route = ddlRoute.SelectedValue.ToString();
            // process = ddlProcess.SelectedValue.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { route.ToString(), process, user.ToString() };
            DataTable lstClaim = ObjclsFrms.loadList("InsertIntoEmployeeRouteProcess", "sp_Masters", emp.ToString(), arr);
            if (lstClaim.Rows.Count > 0)
            {
                string claimID = lstClaim.Rows[0]["sliderID"].ToString();
                ViewState["claimID"] = claimID.ToString();
            }
            string claim = ViewState["claimID"].ToString();

            if (claim == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
        }


        protected void btnOK_Click1(object sender, EventArgs e)
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

                    var ColelctionMarkets = ddlProcess.CheckedItems;
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

        private void createNode(string prc_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");


            writer.WriteStartElement("erp_prc_ID");
            writer.WriteString(prc_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }


    }
}