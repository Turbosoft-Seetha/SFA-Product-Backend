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
    public partial class ListProductMappingDetail : System.Web.UI.Page
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
                HeaderData();
                Products();
            }
        }
        public void Products()
        {
            DataTable dt = ObjclsFrms.loadList("SelProductforMappingDetail", "sp_Merchandising", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                ddlItems.DataSource = dt;
                ddlItems.DataTextField = "prd_Name";
                ddlItems.DataValueField = "prd_ID";
                ddlItems.DataBind();
            }
        }
        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelProductMappingDetail", "sp_Merchandising", ResponseID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelProductMappingGroupByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblpmgCode = (Label)rp.FindControl("lblpmgCode");
                Label lblpmg_Name = (Label)rp.FindControl("lblpmg_Name");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");

                lblpmgCode.Text = lstDatas.Rows[0]["pmg_Code"].ToString();
                lblpmg_Name.Text = lstDatas.Rows[0]["pmg_Name"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                
            }
        }
        protected void lnkAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditProductMappingDetail.aspx?Id=" + ResponseID.ToString());
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("pmd_ID").ToString();
                Response.Redirect("AddEditProductMappingDetail.aspx?Id=" + ID);
            }
           
        }
        protected void Save()
        {
            string pro, code, user;
            pro = GetItemFromGrid();


            user = UICommon.GetCurrentUserID().ToString();
            string[] arr = { pro.ToString(), user.ToString() };
            string Value = ObjclsFrms.SaveData("sp_Merchandising", "InsertProductMappingDetail", ResponseID.ToString(), arr);
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
        protected void LinkButton1Save_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkButton2cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProductMappingGroup.aspx");
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

                    var ColelctionMarkets = ddlItems.CheckedItems;
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

        private void createNode(string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");


            writer.WriteStartElement("pmd_prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();



            writer.WriteEndElement();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListProductMappingDetail.aspx?Id=" + ResponseID.ToString());
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }
        public string GetItemFromGrid2()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");
                    
                    DataTable dsc = new DataTable();
                    foreach (GridDataItem dr in grvRpt.SelectedItems)
                    {

                        string pmd_ID = dr.GetDataKeyValue("pmd_ID").ToString();
                       
                        createNode2(pmd_ID, writer);
                        c++;
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

                }
                if (c == 0)
                {

                    return null;
                }
                else
                {
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode2(string pmd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("pmd_ID");
            writer.WriteString(pmd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void Delete()
        {
            try
            {
                string proid = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ObjclsFrms.SaveData("sp_Merchandising","Deletepmd", proid.ToString(), arr);

                int res = Int32.Parse(resp);
               

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
            catch(Exception ex)
            {

            }
          
            
        }

        protected void LinkDelete_Click(object sender, EventArgs e)
        {
            Delete();
        }
    }

   
}
