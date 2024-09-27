using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Xml;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditMasterDataNotifications : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
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
      
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRouteFromDrop", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
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
                    //string cusIDs = "";
                    //int i = 0;
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
            writer.WriteStartElement("mdn_rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        protected void Save()
        {
            string route, Remarks, user, status,vanstock;
            route = GetItemFromGrid();
            Remarks = txtRemarks.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();
            vanstock = ddlVanStock.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { Remarks, status, user, vanstock };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsertMasterDataNotifications", route, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Data Notification Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }


        }

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListMasterDataNotifications.aspx");

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListMasterDataNotifications.aspx");

        }
    }
}