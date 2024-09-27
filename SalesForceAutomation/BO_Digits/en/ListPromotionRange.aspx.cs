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
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListPromotionRange : System.Web.UI.Page
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
                Titles();
                HeaderData();
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectPromotionHeaderTitle", "sp_Web_Promotion", ResponseID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
           // lblTitle.Text = "for " + titles.ToString();
        }
        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPromotionRange.aspx?HId=0&Id=" + ResponseID.ToString());
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectPromotionRange", "sp_Web_Promotion", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelPromotionHeader", "sp_Web_Promotion", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblNum = (Label)rp.FindControl("lblNum");
                Label lblName = (Label)rp.FindControl("lblName");
                Label lblType = (Label)rp.FindControl("lblType");
                Label lblStatus = (Label)rp.FindControl("lblStatus");


                //rp.Text = "Promotion No: " + lstDatas.Rows[0]["lih_TransID"].ToString();
                lblNum.Text = lstDatas.Rows[0]["prm_Number"].ToString();
                lblName.Text = lstDatas.Rows[0]["prm_Name"].ToString();
                lblType.Text = lstDatas.Rows[0]["prt_Name"].ToString();
                lblStatus.Text = lstDatas.Rows[0]["Status"].ToString();
                
            }
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prr_ID").ToString();

                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        public string GetItemFromGrid()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw, new XmlWriterSettings { OmitXmlDeclaration = false }))
                {
                    writer.WriteStartElement("r");

                    var selectedItems = grvRpt.SelectedItems;

                    foreach (GridDataItem dr in selectedItems)
                    {
                        string prr_ID = dr.GetDataKeyValue("prr_ID").ToString();
                        createNode(prr_ID, writer);
                    }

                    writer.WriteEndElement();
                }

                string resultXml = sw.ToString();
                return resultXml;
            }
        }
        private void createNode(string prr_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("prr_ID");
            writer.WriteString(prr_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        protected void lnkAdds_Click(object sender, EventArgs e)
        {
            string id = GetItemFromGrid();
            GeneralFunctions.loadList_Static("DeleteProRange", "sp_Backend", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
    }
}