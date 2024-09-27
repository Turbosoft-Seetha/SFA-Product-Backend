using DocumentFormat.OpenXml.Office2013.Excel;
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
    public partial class AddEditAutoUpdate : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillForm();
                LoadUnassignedrot();
                
                if (ResponseID == 0)
                {
                    ViewState["DataTable"] = null;
                    
                }
                else
                {
                    ViewState["DataTable"] = Session["DataTable"];
                }
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
            DataTable lstDatas = ObjclsFrms.loadList("SelectAutoUpdateByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, url, code,releasenote;
                name = lstDatas.Rows[0]["ver_name"].ToString();
                code = lstDatas.Rows[0]["ver_code"].ToString();
                url = lstDatas.Rows[0]["redir_url"].ToString();
                releasenote = lstDatas.Rows[0]["ReleaseNote"].ToString();

                txtcode.Text = code.ToString();
                txtName.Text = name.ToString();
                txtURL.Text = url.ToString();
                txtReleaseNote.Text = releasenote.ToString();
            }
        }
            protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListAutoUpdate.aspx");

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListAutoUpdate.aspx");

        }
        protected void Save()
        {
            string name, code, url,releasenote,Route;
            name = txtName.Text.ToString();
            code = txtcode.Text.ToString();
            url = txtURL.Text.ToString();
            releasenote = txtReleaseNote.Text.ToString();
            Route = ddlroute.SelectedValue.ToString();
            string type = ddltype.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {

                if(ddlroute.SelectedValue.ToString().Equals("A"))
                {
                    string[] arr = { name.ToString(), url.ToString(), releasenote.ToString(), Route,type};
                    string Value = ObjclsFrms.SaveData("sp_AutoUpdate", "InsertAutoUpdate", code.ToString(), arr);
                    int res = Int32.Parse(Value.ToString());
                    if (res > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Auto Update Saved Successfully');</script>", false);
                    }
                    else if (res == 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                    }
                }
               
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name.ToString(), url.ToString(), id.ToString(), releasenote.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateAutoUpdate", code.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Updated Successfully');</script>", false);
                }
                else if (res == 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        
        public void LoadUnassignedrot()
        {
            DataTable lstuser = default(DataTable);
            lstuser = ObjclsFrms.loadList("SelUnassignedroutes", "sp_AutoUpdate", ResponseID.ToString());
            if (lstuser.Rows.Count > 0)
            {
                RadGrid1.DataSource = lstuser;
            }
           
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadUnassignedrot();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }
        public void LoadData()
        {
            GetItemFromGrid();
           


        }
        protected void lnkadd_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Please Select Atleast one route');</script>", false);
            }
            else
            {
                //GetItemFromGrid();
                LoadData();
                grvRpt.Rebind();
            }
        }
        public void addTable(string rid, string rcode, string rname)
        {
            
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("routecode");
                dts.Columns.Add("route");
               
            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }
            
            dts.Rows.Add(rid, rcode, rname);


            ViewState["DataTable"] = dts;
            Session["DataTable"] = dts;
           // Session["Date"] = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            grvRpt.DataSource = dts;
           // grvRpt.DataBind();

           // Response.Redirect("AddLoadIn.aspx?RId=" + ddlp.SelectedValue.ToString() + "&LIH=1" + "&" + Session["DataTable"] + "&" + Session["Date"]);


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
                            string rotID = dr.GetDataKeyValue("rot_ID").ToString();
                            string routecode = dr["rot_Code"].Text;
                            string routename = dr["rot_Name"].Text;
                            addTable(rotID, routecode, routename);
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

       

        protected void ddlroute_SelectedIndexChanged2(object sender, DropDownListEventArgs e)
        {
            if (ddlroute.SelectedValue.ToString().Equals("S"))
            {
                typepanel.Visible = false;
                gridpanel.Visible = true;
                LoadUnassignedrot();
                RadGrid1.Rebind();
            }
            else
            {
                typepanel.Visible = true;
                gridpanel.Visible = false;
            }
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            //ViewState["DeleteID"] = null;
            //var ColelctionMarkets = grvRpt.SelectedItems;
            
            //int i = 0;
            //int MarCount = ColelctionMarkets.Count;
            //if (ColelctionMarkets.Count > 0)
            //{
            //    foreach (GridDataItem dr in ColelctionMarkets)
            //    {
            //        //where 1 = 1
            //        string rotID = dr.GetDataKeyValue("rot_ID").ToString();
            //        ViewState["delID"] = rotID;
            //    }
            //}
            //string ID = ViewState["delID"].ToString();
            //DataTable dts = (DataTable)ViewState["DataTable"];
            //for (int i = dts.Rows.Count - 1; i >= 0; i--)
            //{
            //    DataRow dr = dts.Rows[i];
            //    string dd = dr["ID"].ToString();
            //    if (dr["ID"].Equals(ID))
            //        dr.Delete();
            //}
            //dts.AcceptChanges();
            //ViewState["DataTable"] = dts;
            //int x = dts.Rows.Count;
            //grvRpt.DataSource = dts;
            //grvRpt.DataBind();
        }
    }
}