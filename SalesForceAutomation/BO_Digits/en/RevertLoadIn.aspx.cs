using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class RevertLoadIn : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Filter"] = "";
                grvRpt.DataSource = null;
                grvRpt.DataBind();
            }
        }

        protected void Filter_Click(object sender, EventArgs e)
        {

        }
        public void LoadData()
        {


           DataTable lstDatas = new DataTable();

            string Lid = rdLoadinNum.SelectedValue.ToString();
            Session["LihID"] = Lid;

            lstDatas = ObjclsFrms.loadList("ListCompletedLoadIn", "sp_Backend", Lid);
            grvRpt.DataSource = lstDatas;
            Session["lstLih"] = lstDatas;


        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LoadData();
            grvRpt.Rebind();
        }

        protected void btnRevert_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            FillLoadInNum();
        }

        public void FillLoadInNum()
        {
            rdLoadinNum.DataSource = ObjclsFrms.loadList("selLoadInIdforRevertLoadIn", "sp_Masters", LoadTxtBOX.Text.ToString());
            rdLoadinNum.DataTextField = "lih_TransID";
            rdLoadinNum.DataValueField = "lih_ID";
            rdLoadinNum.DataBind();

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (ViewState["Filter"].ToString().Equals("Yes"))
            {
                grvRpt.DataSource = Session["lstLih"] as DataTable;
            }
            else
            {
                grvRpt.DataSource = new DataTable(); // Ensure no data is bound initially
            }
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

                    var ColelctionMarkets = grvRpt.SelectedItems;
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string uva_ID = dr.GetDataKeyValue("lih_ID").ToString();

                            createNode(uva_ID, writer);
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
        private void createNode(string uva_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("lih_ID");
            writer.WriteString(uva_ID);
            writer.WriteEndElement();




            writer.WriteEndElement();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string RStatus = GetItemFromGrid();


            string[] arr = { user };
            string resp = ObjclsFrms.SaveData("sp_Backend","RevertLoadInHeaderStatus", RStatus, arr);
            int res = Int32.Parse(resp);

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Reverted Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }

        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("RevertLoadIn.aspx");

        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }
    }
}