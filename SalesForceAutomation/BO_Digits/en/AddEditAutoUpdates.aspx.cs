using SalesForceAutomation.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
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
    public partial class AddEditAutoUpdates : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["DataTable"] = null;
                FillForm();
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
            DataTable lstDatas = Obj.loadList("SelectAutoUpdateByID", "sp_AutoUpdate", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, url, code, releasenote,Route,Type,Platform;
                name = lstDatas.Rows[0]["ver_name"].ToString();
                code = lstDatas.Rows[0]["ver_code"].ToString();
               // url = lstDatas.Rows[0]["redir_url"].ToString();
                releasenote = lstDatas.Rows[0]["ReleaseNote"].ToString();
                Route = lstDatas.Rows[0]["ApplicableTo"].ToString();
                Type = lstDatas.Rows[0]["Type"].ToString();
                Platform = lstDatas.Rows[0]["Platform"].ToString();
                txtcode.Text = code.ToString();
                txtName.Text = name.ToString();
              //  txtURL.Text = url.ToString();
                txtReleaseNote.Text = releasenote.ToString();
                ddlroute.SelectedValue = Route.ToString();
                ddltype.SelectedValue = Type.ToString();
                ddlApp.SelectedValue = Platform.ToString();
                DataTable lstuser = default(DataTable);
                ddlroute.Enabled= true;
                if (Route.Equals("S"))
                {
                    //typepanel.Visible = false;
                    gridpanel.Visible = true;
                    gridPanelAll.Visible = false;
                    Loaddata();
                    RadGrid1.Rebind();                      
                     
                    lstuser = Obj.loadList("Selassignedroutes", "sp_AutoUpdate", ResponseID.ToString());
                    ViewState["DataTable"] = lstuser;
                }
                else
                {
                    // typepanel.Visible = true;
                    gridPanelAll.Visible = true;
                    gridpanel.Visible = false;
                    lstuser = Obj.loadList("Selassignedroutes", "sp_AutoUpdate", ResponseID.ToString());
                    ViewState["DataTable"] = lstuser;
                }

            }
            else
            {
                gridPanelAll.Visible = false;
                gridpanel.Visible = false;
               
            }
        }
        public void List()
        {
            if (ViewState["DataTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["DataTable"];
                grvRpt.DataSource = dt;
            }
            else
            {
                grvRpt.DataSource = new DataTable();
            }
            
        }
        public void Loaddata()
        {

            string mainCondition = "";
            mainCondition = RouteCondition();
            DataTable lstuser = default(DataTable);
            string[] arr = { mainCondition };
            lstuser = Obj.loadList("SelUnassignedroutes", "sp_AutoUpdate", ResponseID.ToString(), arr);         
            RadGrid1.DataSource = lstuser;

        }

        //public void Loaddata2()
        //{

        //    string mainCondition = "";
        //    mainCondition = RouteCondition();
        //    DataTable lstuser = default(DataTable);
        //    string[] arr = { mainCondition };
        //    lstuser = Obj.loadList("SelAllUnassignedroutes", "sp_AutoUpdate", ResponseID.ToString(), arr);
        //    RadGrid2.DataSource = lstuser;

        //}
        public void List2()
        {
            if(ViewState["DataTable"]!=null)
            {
                DataTable dt = (DataTable)ViewState["DataTable"];
                RadGrid3.DataSource = dt;
            }
            else
            {
                RadGrid3.DataSource =new DataTable();
            }
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }
        protected void Save()
        {
            try
            {
                string name, code, url, releasenote, Route, Platform,applicableto;
                name = txtName.Text.ToString();
                code = txtcode.Text.ToString();
                //  url = txtURL.Text.ToString();
                releasenote = txtReleaseNote.Text.ToString();
                Route = ddlroute.SelectedValue.ToString();
                string type = ddltype.SelectedValue.ToString();
                string user = UICommon.GetCurrentUserID().ToString();
                Platform = ddlApp.SelectedValue.ToString();
                
                string Value, detail;
                int res;

                url = "";
                int ImageID = 0;

                foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                {
                    ImageID += 1;
                    string csvPath = Server.MapPath(("..") + @"/../UploadFiles/AppRelease/") + uploadedFile.FileName;
                    uploadedFile.SaveAs(csvPath);
                    string BackendURL = ConfigurationManager.AppSettings.Get("BackendURL");
                    url = BackendURL + @"UploadFiles/AppRelease/" + uploadedFile.FileName.ToString();
                }

                DataTable dsc = (DataTable)ViewState["DataTable"];
                if (ResponseID.Equals("") || ResponseID == 0)
                {

                    if (ddlroute.SelectedValue.ToString().Equals("A"))
                    {
                        string[] array = { name.ToString(), url.ToString(), releasenote.ToString(), Route, type, user, Platform };
                        Value = Obj.SaveData("sp_AutoUpdate", "InsertAutoUpdate", code.ToString(), array);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);

                        }
                    }
                    else
                    {

                        if (dsc == null)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                                "tmp", "<script type='text/javascript'>failedModal('For this Assignment, Items are mandatory');</script>", false);
                            return;
                        }
                        detail = GetItemFromGrid();
                        string rottype = ddlSprotType.SelectedValue.ToString();
                        string[] ar = { name.ToString(), url.ToString(), releasenote.ToString(), Route, detail, user, Platform };
                        Value = Obj.SaveData("sp_AutoUpdate", "InsertAutoUpdatewithSpecificRot", code.ToString(), ar);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);

                        }
                    }
                }

                else
                {
                    if (ddlroute.SelectedValue.ToString().Equals("A"))
                    {
                        string[] array = { name.ToString(), url.ToString(), releasenote.ToString(), Route, type, ResponseID.ToString(), user };
                        Value = Obj.SaveData("sp_AutoUpdate", "UpdateAutoUpdate", code.ToString(), array);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);

                        }
                    }
                    else
                    {

                        if (dsc == null)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                                "tmp", "<script type='text/javascript'>failedModal('For this Assignment, Items are mandatory');</script>", false);
                            return;
                        }
                        detail = GetItemFromGrid();
                        string rottype = ddlSprotType.SelectedValue.ToString();
                        string[] ar = { name.ToString(), url.ToString(), releasenote.ToString(), user, ResponseID.ToString(), detail ,Route};
                        Value = Obj.SaveData("sp_AutoUpdate", "UpdateAutoUpdateforspecificrot", code.ToString(), ar);
                        res = Int32.Parse(Value.ToString());
                        if (res > 0)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);

                        }
                    }
                }
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('"+ex.Message.ToString()+"');</script>", false);
            }
        }
        public void addTable()
        {

            var ColelctionMarkets = RadGrid1.SelectedItems;
            int MarCount = ColelctionMarkets.Count;
            if(ResponseID==0)
            {
                if (ColelctionMarkets.Count > 0)
                {
                    foreach (GridDataItem dr in ColelctionMarkets)
                    {

                        string rot_ID = dr.GetDataKeyValue("rot_ID").ToString();
                        string routecode = dr["rot_Code"].Text;
                        string routename = dr["rot_Name"].Text;
                        //string typeid = ddlSprotType.SelectedValue.ToString();
                        //string typename = ddlSprotType.SelectedItem.Text;
                        //DataTable lstuser = default(DataTable);
                        //lstuser = Obj.loadList("SelProductname", "sp_Web_Promotion", rot_ID);
                        //string rot_Name = lstuser.Rows[0]["rot_Name"].ToString(); ;
                        //string rot_Code = lstuser.Rows[0]["rot_Code"].ToString();

                        string ID, Code, Route, Type, Typeval;
                        DataTable dts = default(DataTable);

                        if (ViewState["DataTable"] == null)
                        {
                            dts = new DataTable();
                            dts.Columns.Add("ID");
                            dts.Columns.Add("Code");
                            dts.Columns.Add("Route");
                            //dts.Columns.Add("Type");
                            //dts.Columns.Add("Typeval");
                        }
                        else
                        {
                            dts = (DataTable)ViewState["DataTable"];

                        }

                        if (dts.Rows.Count > 0)
                        {

                            ID = rot_ID.ToString();
                            Code = routecode.ToString();
                            Route = routename.ToString();
                            //Typeval = typeid.ToString();
                            //Type = typename.ToString();
                           // dts.Rows.Add(ID, Code, Route, Type, Typeval);
                            dts.Rows.Add(ID, Code, Route);

                        }
                        else
                        {

                            ID = rot_ID.ToString();
                            Route = routename.ToString();
                            Code = routecode.ToString();
                            //Typeval = typeid.ToString();
                            //Type = typename.ToString();
                            //dts.Rows.Add(ID, Code, Route, Type, Typeval);
                            dts.Rows.Add(ID, Code, Route);

                        }
                        ViewState["DataTable"] = dts;
                    }
                }
            }
            else
            {
                string user = UICommon.GetCurrentUserID().ToString();
                string detail = GetItemFromGrid3();
                DataTable lstData = new DataTable();
                string[] arr = { user, ResponseID.ToString() };
                string resp = Obj.SaveData("sp_AutoUpdate", "Addrotversionfromedit", detail.ToString(), arr);
                int res = Int32.Parse(resp);
                if (res > 0)
                {
                    DataTable lstuser = new DataTable();
                    lstuser = Obj.loadList("Selassignedroutes", "sp_AutoUpdate", ResponseID.ToString());
                    ViewState["DataTable"] = lstuser;
                }

            }

            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;
            grvRpt.DataBind();
            //RowDelete();
            Loaddata();
            RadGrid1.DataBind();
        }
        public string ItemfromAssgn()
        {
            var ColelctionMarkets = grvRpt.Items;
            int MarCount = ColelctionMarkets.Count;
            string RID = "";
            int j = 0;

            if (ColelctionMarkets.Count > 0)
            {
                foreach (GridDataItem dr in ColelctionMarkets)
                {

                    string rot_ID = dr.GetDataKeyValue("ID").ToString();
                    //ID = prd_ID.ToString();
                    if (j == 0)
                    {
                        RID += rot_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        RID += rot_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        RID += rot_ID.ToString();
                    }
                    j++;
                }
                return RID;
            }
            else
            {
                return "0";
            }


        }
        public string Item()
        {
            var ColelctionMarkets = RadGrid1.SelectedItems;
            int MarCount = ColelctionMarkets.Count;
            string RID = "";
            int j = 0;

            if (ColelctionMarkets.Count > 0)
            {
                foreach (GridDataItem dr in ColelctionMarkets)
                {

                    string rot_ID = dr.GetDataKeyValue("rot_ID").ToString();
                    //ID = prd_ID.ToString();
                    if (j == 0)
                    {
                        RID += rot_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        RID += rot_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        RID += rot_ID.ToString();
                    }
                    j++;
                }
                return RID;
            }
            else
            {
                return "0";
            }


        }
        public string RouteCondition()
        {
            string RID = Item();
            string ID = ItemfromAssgn();
            string routeCondition = "";
            string itemCondition = "";
            try
            {
                if (RID.Equals("0") && ID.Equals("0"))
                {
                    routeCondition = " rot_ID not in (" + RID + ")";
                }
                else
                {
                    routeCondition = " rot_ID not in (" + RID + ")";
                    itemCondition = " and rot_ID not in (" + ID + ")";
                }
            }
            catch (Exception ex)
            {

            }

            routeCondition += itemCondition;
            return routeCondition;
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

                    var ColelctionMarkets = grvRpt.Items;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string rot_ID = dr.GetDataKeyValue("ID").ToString();
                            //string type = dr["Typeval"].Text.ToString();
                            //if(type.Equals("&amp;nbsp;"))
                            //{
                            //    type = "";
                            //}
                           // createNode(rot_ID, type, writer);
                            createNode(rot_ID, writer);
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
        //private void createNode(string rot_ID, string type, XmlWriter writer)
        private void createNode(string rot_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();

            //writer.WriteStartElement("type");
            //writer.WriteString(type);
            //writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public void Delete()
        {
            try
            {
                var ColelctionMarkets = grvRpt.SelectedItems;
                int MarCount = ColelctionMarkets.Count;
                if (ResponseID==0)
                {
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {

                            string ID = dr.GetDataKeyValue("ID").ToString();


                            DataTable dts = (DataTable)ViewState["DataTable"];
                            for (int i = dts.Rows.Count - 1; i >= 0; i--)
                            {
                                DataRow drs = dts.Rows[i];
                                string dd = dr["ID"].ToString();
                                if (drs["ID"].Equals(ID))
                                    drs.Delete();
                            }
                            dts.AcceptChanges();
                            ViewState["DTable"] = dts;
                            int x = dts.Rows.Count;


                        }
                    }
                }
                else
                {
                    string id = GetItemFromGrid2();
                    DataTable lstData = new DataTable();
                    string[] arr = {ResponseID.ToString() };
                    string resp = Obj.SaveData("sp_AutoUpdate", "Deleterotversion", id.ToString(), arr);
                    int res = Int32.Parse(resp);
                    if(res>0)
                    {
                        DataTable lstversion = default(DataTable);
                        lstversion = Obj.loadList("Selassignedroutes", "sp_AutoUpdate", ResponseID.ToString());
                        ViewState["DTable"] = lstversion;
                    }
                }

               
                
                DataTable dt = (DataTable)ViewState["DTable"];
                grvRpt.DataSource = dt;
                grvRpt.DataBind();
                Loaddata();
                RadGrid1.DataBind();
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);

            }
            catch (Exception ex)
            {

            }


        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            //int addcount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            //if(addcount==0)
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>TypeSelect();</script>", false);
            //}
            addTable();
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

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            if (ddlroute.SelectedValue.ToString().Equals("A"))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
            else
            {
                int removeCount = Int32.Parse(grvRpt.Items.Count.ToString());
                if (removeCount == 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                }
            }

            
        }

        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAutoUpdate.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddEditAutoUpdates.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAutoUpdate.aspx");
        }

        protected void ddlroute_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            if (ddlroute.SelectedValue.ToString().Equals("S"))
            {
                //typepanel.Visible = false;
                gridpanel.Visible = true;
                gridPanelAll.Visible = false;
                Loaddata();
                RadGrid1.Rebind();
                List();
                grvRpt.Rebind();

            }
            else
            {
               // typepanel.Visible = true;
                gridpanel.Visible = false;
                gridPanelAll.Visible = false;
            }
        }

        protected void lnkTypeSelect_Click(object sender, EventArgs e)
        {
            addTable();
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

                        string rotID = dr.GetDataKeyValue("ID").ToString();

                        createNode2(rotID, writer);
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
        private void createNode2(string rotID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("rotID");
            writer.WriteString(rotID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
        public string GetItemFromGrid3()
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
                            string rot_ID = dr.GetDataKeyValue("rot_ID").ToString();
                            //string type = ddlSprotType.SelectedValue.ToString();
                          //  dr["Typeval"].Text.ToString();
                             
                            //createNode3(rot_ID, type, writer);
                            createNode3(rot_ID, writer);
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

        //private void createNode3(string rot_ID, string type, XmlWriter writer)
        private void createNode3(string rot_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rot_ID");
            writer.WriteString(rot_ID);
            writer.WriteEndElement();

            //writer.WriteStartElement("type");
            //writer.WriteString(type);
            //writer.WriteEndElement();

            writer.WriteEndElement();
        }

        //protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        //{
        //    Loaddata2();
        //}

        protected void RadGrid3_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            List2();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            //int addcount = Int32.Parse(RadGrid2.SelectedItems.Count.ToString());
            //if (addcount == 0)
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>TypeSelect();</script>", false);            
            //}
            addTable();
        }
    }
}