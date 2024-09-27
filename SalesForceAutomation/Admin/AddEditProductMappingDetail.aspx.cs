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

namespace SalesForceAutomation.Admin
{
    public partial class AddEditProductMappingDetail : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                fillForm();
                Products();
            }
        }
        protected void fillForm()
        {

            DataTable lstData = default(DataTable);
            lstData = Obj.loadList("SelProductMappingGroupByID", "sp_Merchandising", ResponseID.ToString());
            if (lstData.Rows.Count > 0)
            {
                string Pro, Code;

                Pro = lstData.Rows[0]["pmg_Name"].ToString();

                Code = lstData.Rows[0]["pmg_Code"].ToString();

                labelqno.Text = "/" + Code + "/" + Pro;
            }


        }
        public void Products()
        {
            DataTable dt = Obj.loadList("SelProductforMappingDetail", "sp_Merchandising", ResponseID.ToString());
            if(dt.Rows.Count>0)
            { 
            ddlPro.DataSource = dt;
            ddlPro.DataTextField = "prd_Name";
            ddlPro.DataValueField = "prd_ID";
            ddlPro.DataBind();
            }
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            lstDatas = Obj.loadList("SelProductMappingDetail", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                grvRpt.DataSource = lstDatas;
                pnls.Visible = true;
            }
            else
            {
                pnls.Visible = false;
            }
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string delID = dataItem.GetDataKeyValue("pmd_ID").ToString();
                ViewState["DeleteID"] = delID.ToString();

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
        }
        public void Delete()
        {
            string dID = ViewState["DeleteID"].ToString();
            Obj.loadList("Deletepmd", "sp_Merchandising", dID.ToString());
            grvRpt.DataBind();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void Save()
        {
            string pro, code, user;
            pro = GetItemFromGrid();

           
            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { pro.ToString(),  user.ToString() };
            string Value = Obj.SaveData("sp_Merchandising", "InsertProductMappingDetail", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
            }
            //grvRpt.DataSource = lstClaim;
            //grvRpt.DataBind();
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

                    var ColelctionMarkets = ddlPro.CheckedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (var item in ColelctionMarkets)
                        {
                            //where 1 = 1
                            createNode( item.Value, writer);
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

        private void createNode( string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

           
            writer.WriteStartElement("pmd_prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditProductMappingDetail.aspx?Id=" + ResponseID.ToString());
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Delete();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void ddlPro_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}