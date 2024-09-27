using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Xml;
using Telerik.Web.UI;
namespace SalesForceAutomation.Admin
{
    public partial class AddTargetDetail : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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
               
            }
        }

        public void SaveData()
        {
            string prodct = GetItemFromGrid();
            string[] arr = { };
            string Value = Obj.SaveData("sp_Target", "AddTargetPackageDetail", prodct, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
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
            lstDatas = Obj.loadList("SelectTargetPackageDetailsById", "sp_Target", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {

                grvRpt.DataSource = lstDatas;
               // pnls.Visible = true;
            }
            else
            {
               // pnls.Visible = false;
            }
        }

        public void LoadData1()
        {
            
            DataTable lstUser = default(DataTable);
            lstUser = Obj.loadList("SelectProductUnassigned", "sp_Target", ResponseID.ToString());
            if (lstUser.Rows.Count >= 0)
            {
                RadGrid1.DataSource = lstUser;
            }
        }

      
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            LoadData1();
        }

      
       

       

       

        protected void LinkButton2Add_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void LinkButton3Sok_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTargetDetail.aspx?id=" + ResponseID.ToString());

        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            Delete();
        }

        protected void LinkButton4Dok_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);

        }

        public void Delete()
        {
            try
            {
                string prodct = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = Obj.SaveData("sp_Target", "DeleteTargetPackageDetail",prodct.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteFailed('Some fields are missing ');</script>", false);
                }
            }
            catch (Exception ex)
            {

            }


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

                        string tpd_ID = dr.GetDataKeyValue("tpd_ID").ToString();

                        createNode2(tpd_ID, writer);
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
        private void createNode2(string tpd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("tpd_ID");
            writer.WriteString(tpd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
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

                    var ColelctionMarkets = RadGrid1.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                            createNode(ResponseID.ToString(), prd_ID, writer);
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

        private void createNode(string HeaderID, string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("tpd_tph_ID");
            writer.WriteString(HeaderID);
            writer.WriteEndElement();

            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
    }
}