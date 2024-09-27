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
using Table = Telerik.Windows.Documents.Flow.Model.Table;
using TableCell = Telerik.Windows.Documents.Flow.Model.TableCell;
using TableRow = Telerik.Windows.Documents.Flow.Model.TableRow;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListAssign : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                PMG();
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
        public void PMG()
        {
            DataTable dt = obj.loadList("SelectPMGname", "sp_Masters", ResponseID.ToString());
            if (dt.Rows.Count > 0)
            {
                string name = dt.Rows[0]["pmg_Name"].ToString();
                sp.Text = "Product Mapping Group  : " + name;
            }

        }
        public void Route()
        {
            DataTable dt = obj.loadList("SelRoute", "sp_Masters");
            ddlRoute.DataSource = dt;
            ddlRoute.DataTextField = "rot_Name";
            ddlRoute.DataValueField = "rot_ID";
            ddlRoute.DataBind();
        }
        public void List()
        {
            string rot = ddlRoute.SelectedValue.ToString();
            string[] arr = { ResponseID.ToString() };
            if (!rot.Equals(""))
            {                
                 DataTable lstdata = default(DataTable);            
                 lstdata = obj.loadList("AssignedCusPMG", "sp_Masters", rot, arr);                            
                 grvRpt.DataSource = lstdata;
                
            }
            
        }

        public void Loaddata()
        {
            
            string rot = ddlRoute.SelectedValue.ToString();
            if (!rot.Equals(""))
            {
                DataTable lstuser = default(DataTable);
                lstuser = obj.loadList("UnAssignedCusPMG", "sp_Masters", rot);                            
                RadGrid1.DataSource = lstuser;              
            }
        }

        public void SaveData()
        {

            string user = UICommon.GetCurrentUserID().ToString();
            string Customer = GetItemFromGrid();
            string route = ddlRoute.SelectedValue.ToString();
            string[] arr = { Customer, route , user };
            string Value = obj.SaveData("sp_Masters", "InsPMGCusAssign", ResponseID.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Customer Added successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }


        }


        public void Delete()
        {
            try
            {
                string id = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = obj.SaveData("sp_Masters", "DeleteCPM", id.ToString(), arr);

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

                        string cpm_ID = dr.GetDataKeyValue("cpm_ID").ToString();

                        createNode2(cpm_ID, writer);
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
        private void createNode2(string cpm_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cpm_ID");
            writer.WriteString(cpm_ID);
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
                            string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();
                            //string rot_ID = ddlRoute.SelectedValue.ToString();
                            createNode(cus_ID, writer);
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

        private void createNode(string cus_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
         
            writer.WriteStartElement("cpm_cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                SaveData();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                Delete();
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

       
    }
}