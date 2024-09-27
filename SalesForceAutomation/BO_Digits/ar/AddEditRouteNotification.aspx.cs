using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class AddEditRouteNotification : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // FillForm();
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

        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelectRouteNotifications", "sp_Masters_UOM", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string route, header, desc, status;
                route = lstDatas.Rows[0]["rnt_rot_ID"].ToString();
                header = lstDatas.Rows[0]["rnt_Header"].ToString();
                desc = lstDatas.Rows[0]["rnt_Desc"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();


                ddlRoute.SelectedValue = route.ToString();
                txtheader.Text = header.ToString();
                txtdesc.Text = desc.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelRouteFromDrop", "sp_Masters_UOM");
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
            writer.WriteStartElement("rnt_rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        protected void Save()
        {
            string route, header, desc, user, status;
            route = GetItemFromGrid();
            header = txtheader.Text.ToString();
            desc = txtdesc.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { header, desc, user, status };
                string Value = ObjclsFrms.SaveData("sp_Masters_UOM", "InsertRouteNotifications", route, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('تم حفظ إعلام الطريق بنجاح');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                //string id = ResponseID.ToString();
                //string[] arr = { header.ToString(), desc.ToString(), status.ToString(), id.ToString() };
                //string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateRouteNotifications", route.ToString(), arr);
                //int res = Int32.Parse(Value.ToString());
                //if (res > 0)

                //{
                //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Route Notification Updated Successfully');</script>", false);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                //}
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/ar/RouteNotification.aspx");

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/ar/RouteNotification.aspx");

        }
    }
}