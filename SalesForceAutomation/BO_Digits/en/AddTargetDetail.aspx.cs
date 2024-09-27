using SalesForceAutomation.Admin;
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

                DataTable lstUsers = default(DataTable);
                lstUsers = Obj.loadList("SelectTargetPackageHeaderById", "sp_Target", ResponseID.ToString());
                if (lstUsers.Rows.Count > 0)
                {
                    string target = lstUsers.Rows[0]["tph_Name"].ToString();
                    lbltarget.Text = "Target Header : " + target;
                }
                category();               
                int i = 1;
                foreach (RadComboBoxItem catitms in ddlcatid.Items)
                {
                    catitms.Checked = true;
                    i++;
                }
                string cat = Cat();
                string catcondition = " sct_cat_ID in (" + cat + ")";
                subcategory(catcondition);
                int j = 1;
                foreach (RadComboBoxItem subcatitms in ddlsubcatid.Items)
                {
                    subcatitms.Checked = true;
                    j++;
                }
                Brands();
                int k = 1;
                foreach (RadComboBoxItem brd in ddlBrand.Items)
                {
                    brd.Checked = true;
                    k++;
                }

            }
        }
        public string mainConditions(string cat)
        {
            string subID = SubCat();
            string subCondition = "";
            string brdID = Brd();
            string brandCondition = "";
            string mainCondition = "tpd_tph_ID in (" + ResponseID.ToString() + ")) and";
             mainCondition += " prd_cat_ID in (" + cat + ")";
            try
            {
                
                if (subID.Equals("0"))
                {
                    subCondition = "";
                }
                else
                {
                    
                    subCondition = " and prd_sct_ID in (" + subID + ")";
                }
                if (brdID.Equals("0"))
                {
                    brandCondition = "";
                }
                else
                {

                    brandCondition = " and prd_brd_ID in (" + brdID + ")";
                }

            }
            catch (Exception ex)
            {

            }
            
            mainCondition += subCondition;
            mainCondition += brandCondition;
            return mainCondition;
        }
        public string MainCondition(string cat)
        {
            string subID = SubCat();
            string subCondition = "";
            string brdID = Brd();
            string brandCondition = "";
            string mainCondition = "tpd_tph_ID in (" + ResponseID.ToString() + ") and";
            mainCondition += " prd_cat_ID in (" + cat + ")";
            try
            {

                if (subID.Equals("0"))
                {
                    subCondition = "";
                }
                else
                {

                    subCondition = " and prd_sct_ID in (" + subID + ")";
                }
                if (brdID.Equals("0"))
                {
                    brandCondition = "";
                }
                else
                {

                    brandCondition = " and prd_brd_ID in (" + brdID + ")";
                }
            }
            catch (Exception ex)
            {

            }

            mainCondition += subCondition;
            mainCondition += brandCondition;
            return mainCondition;
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
            string cat = Cat();
            string mainCondition = "";
            mainCondition = MainCondition(cat);

            //string subcat = SubCat();
            //string maincondition = "tpd_tph_ID in (" + ResponseID.ToString() + ")" +" and prd_cat_ID in ("+ cat+")"+ " and prd_sct_ID in ("+ subcat+")";
            
            DataTable lstDatas = default(DataTable);
            
            lstDatas = Obj.loadList("SelectTargetPackageDetailsById", "sp_Target", mainCondition);
            try
            {
                grvRpt.DataSource = lstDatas;
                
            }
            catch(Exception ex)
            {

            }           
        }

        public void LoadData1()
        {
            string cat = Cat();

            //string subcat = SubCat();
            //string maincondition =  " and prd_cat_ID in (" + cat + ")" + " and prd_sct_ID in (" + subcat + ")";
            string mainCondition = "";
            mainCondition = mainConditions(cat);

            DataTable lstUser = default(DataTable);
            string[] arr = { mainCondition };
            lstUser = Obj.loadList("SelectProductUnassigned", "sp_Target", mainCondition);
            try
            {
                RadGrid1.DataSource = lstUser;

            }
            catch (Exception ex)
            {

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
                string resp = Obj.SaveData("sp_Target", "DeleteTargetPackageDetail", prodct.ToString(), arr);

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

        protected void lnkAdd_Click1(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);

            }
        }
        public void category()
        {
            DataTable dt = Obj.loadList("SelectCatFromDrop", "sp_Masters");
            ddlcatid.DataSource = dt;
            ddlcatid.DataTextField = "cat_Name";
            ddlcatid.DataValueField = "cat_ID";
            ddlcatid.DataBind();
        }
        public void subcategory(string cat)
        {

            DataTable ds = Obj.loadList("SelectcatforCheckbox", "sp_Masters", cat);
            ddlsubcatid.DataSource = ds;
            ddlsubcatid.DataTextField = "sct_Name";
            ddlsubcatid.DataValueField = "sct_ID";
            ddlsubcatid.DataBind();
            ViewState["dd"] = ds;
        }

        public void Brands()
        {
            DataTable dt = Obj.loadList("SelectBrandFromDrop", "sp_Target");
            ddlBrand.DataSource = dt;
            ddlBrand.DataTextField = "brd_Name";
            ddlBrand.DataValueField = "brd_ID";
            ddlBrand.DataBind();
        }
        protected void Filter_Click(object sender, EventArgs e)
        {
            LoadData();
            LoadData1();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void ddlcatid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
            string catID = Cat();
            string catCondition = " sct_cat_ID in (" + catID + ")";
            subcategory(catCondition);
            

        }
        public string Cat()
        {
            var CollectionMarket1 = ddlcatid.CheckedItems;
            string catID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        catID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        catID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        catID += item.Value;
                    }
                    j++;
                }
                return catID;
            }
            else
            {
                return "0";
            }
        }
        public string SubCat()
        {
            var CollectionMarket1 = ddlsubcatid.CheckedItems;
            string subcatID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        subcatID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        subcatID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        subcatID += item.Value;
                    }
                    j++;
                }
                return subcatID;
            }
            else
            {
                return "0";
            }
        }

        public string Brd()
        {
            var CollectionMarket1 = ddlBrand.CheckedItems;
            string brdID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        brdID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        brdID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        brdID += item.Value;
                    }
                    j++;
                }
                return brdID;
            }
            else
            {
                return "0";
            }
        }
        protected void ddlsubcatid_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}