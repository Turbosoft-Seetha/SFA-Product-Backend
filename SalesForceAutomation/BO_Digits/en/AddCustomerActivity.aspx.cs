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
    public partial class AddCustomerActivity : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdFromDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                rdEndDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                Route();
                ViewState["RefImage"] = null;
                FillForm();

                ViewState["DataTable"] = null;
                try
                {


                    if (Mode == 1)
                    {
                        ViewState["DataTable"] = Session["DataTable"];



                        txtname.Text = Session["name"].ToString();
                        txtDesc.Text = Session["desc"].ToString();
                        rdFromDate.SelectedDate = DateTime.Parse(Session["startdate"].ToString());
                        rdEndDate.SelectedDate = DateTime.Parse(Session["enddate"].ToString());

                        
                        ddlrot.SelectedValue = Session["rot"].ToString();
                        Customer();
                        ddlCustomers.SelectedValue = Session["cus"].ToString();


                    }
                }
                catch (Exception ex)
                {
                    UICommon.LogException(ex, "Add Customer Activity");
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddCustomerActivity.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                }

            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

                return ResponseID;
            }
        }
        public int Mode
        {
            get
            {
                int Mode;
                int.TryParse(Request.Params["Mode"], out Mode);
                return Mode;
            }
        }
        public void Route()
        {
            ddlrot.DataSource = ObjclsFrms.loadList("SelRoute", "sp_Masters");
            ddlrot.DataTextField = "rot_Name";
            ddlrot.DataValueField = "rot_ID";
            ddlrot.DataBind();
        }
        public void Customer()
        {
            ddlCustomers.DataSource = ObjclsFrms.loadList("SelCustomerfordropdown", "sp_Masters", ddlrot.SelectedValue.ToString());
            ddlCustomers.DataTextField = "cus_Name";
            ddlCustomers.DataValueField = "cus_ID";
            ddlCustomers.DataBind();
        }
        public void FillForm()
        {
            DataTable lstDatas = ObjclsFrms.loadList("SelCusActivityByID", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, desc, startdate, enddate,  cus, rot;
                // code = lstDatas.Rows[0]["cah_Code"].ToString();
                name = lstDatas.Rows[0]["cah_Name"].ToString();
                desc = lstDatas.Rows[0]["cah_Description"].ToString();
                startdate = lstDatas.Rows[0]["cah_StartDate"].ToString();
                enddate = lstDatas.Rows[0]["cah_EndDate"].ToString();
                //status = lstDatas.Rows[0]["Status"].ToString();
                cus = lstDatas.Rows[0]["cah_cus_ID"].ToString();
                rot = lstDatas.Rows[0]["cah_rot_ID"].ToString();
                //txtcode.Text = code.ToString();
                txtname.Text = name.ToString();
                txtDesc.Text = desc.ToString();
                rdFromDate.SelectedDate = DateTime.Parse(startdate.ToString());
                rdEndDate.SelectedDate = DateTime.Parse(enddate.ToString());
               // ddlStatus.SelectedValue = status.ToString();
                ddlCustomers.SelectedValue = cus.ToString();
                ddlrot.SelectedValue = rot.ToString();

            }
        }

        protected void Save()
        {
            string name, desc, startdate, enddate, user,  cus, rot;

            name = txtname.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            desc = txtDesc.Text.ToString();
            startdate = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            enddate = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyyMMdd");
           // status = ddlStatus.SelectedValue.ToString();
            cus = ddlCustomers.SelectedValue.ToString();
            rot = ddlrot.SelectedValue.ToString();



            if (ResponseID.Equals("") || ResponseID == 0)
            {
                string detail = GetItemFromGrid();

                string[] arr = { desc, startdate, enddate, user,  cus, rot, detail };
                string Value = ObjclsFrms.SaveData("sp_Masters", "InsCusActivity", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { name, desc, startdate, enddate, user,  cus, rot };
                string Value = ObjclsFrms.SaveData("sp_Masters", "UpdateCusActivity", id, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer Activity Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivity.aspx");
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            DataTable dsc = (DataTable)ViewState["DataTable"];
            if (dsc == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('Add Atleast one Subactivity for Customer Activity" +
                    "');</script>", false);
                return;
            }
            else
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
        }

        protected void ddlrot_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
            
            Customer();
            ddlCustomers.Text = "";



        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }
        public void ListData()
        {

            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListCustomerActivity.aspx");
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {

            if ((upd1.UploadedFiles.Count == 0) && (ViewState["RefImage"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {



                string name, desc, startdate, enddate,  cus, rot;
                // code = lstDatas.Rows[0]["cah_Code"].ToString();
                name = txtname.Text.ToString();
                desc = txtDesc.Text.ToString();
                startdate = rdFromDate.SelectedDate.ToString();
                enddate = rdEndDate.SelectedDate.ToString();
               
                ViewState["cusid"] = ddlCustomers.SelectedValue.ToString();
                ViewState["rotid"] = ddlrot.SelectedValue.ToString();
                cus = ddlCustomers.SelectedValue.ToString();
                rot = ddlrot.SelectedValue.ToString();

                try
                {


                    Session["name"] = name;
                    Session["desc"] = desc;
                    Session["startdate"] = startdate;
                    Session["enddate"] = enddate;
                   
                    Session["cus"] = cus;
                    Session["rot"] = rot;

                }
                catch (Exception ex)
                {

                    UICommon.LogException(ex, "Add customer Activity");
                    String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                    ObjclsFrms.LogMessageToFile(UICommon.GetLogFileName(), "AddCustomerActivity.aspx Page_Load()", "Error : " + ex.Message.ToString() + " - " + innerMessage);

                }
                addTable();

                Response.Redirect("AddCustomerActivity.aspx?Mode=1");
            }
        }
        public void addTable()
        {

            


                string name, desc, duedate, user, SortOrder,  type, img;
                DataTable dts = default(DataTable);
                if (ViewState["DataTable"] == null)
                {
                    dts = new DataTable();

                    dts.Columns.Add("ID");
                    dts.Columns.Add("name");
                    dts.Columns.Add("desc");
                    dts.Columns.Add("type");
                    dts.Columns.Add("duedate");

                    dts.Columns.Add("SortOrder");
                   
                    dts.Columns.Add("img");








                }
                else
                {
                    dts = (DataTable)ViewState["DataTable"];
                }
                if (dts.Rows.Count > 0)
                {
                    int count = dts.Rows.Count + 1;
                    ID = "D" + (count++).ToString();

                    name = txtSname.Text.ToString();

                    // user = UICommon.GetCurrentUserID().ToString();
                    desc = txtSDesc.Text.ToString();
                    type = txttype.Text.ToString();
                    duedate = DateTime.Parse(rdDueDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
                
                    SortOrder = txtsortorder.Text.ToString();
                   

                    img = "";
                    int ImageID = 0;
                    foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                    {
                        ImageID += 1;
                        string csvPath = Server.MapPath(("..") + @"/../UploadFiles/CustomerActivity/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                        uploadedFile.SaveAs(csvPath);
                        img = @"UploadFiles/CustomerActivity/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                        ViewState["Image"] = img.ToString();
                    }
                    if (img == "")
                    {
                        img = ViewState["RefImage"].ToString();
                    }
                    else
                    {
                        img = ViewState["Image"].ToString();
                    }





                    dts.Rows.Add(ID, name, desc, type, duedate, SortOrder,  img);
                duedate = DateTime.Parse(rdDueDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            }
                else
                {

                    ID = "D1";
                    name = txtSname.Text.ToString();
                    // user = UICommon.GetCurrentUserID().ToString();
                    desc = txtSDesc.Text.ToString();
                    type = txttype.Text.ToString();
                    duedate = DateTime.Parse(rdDueDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");

                    SortOrder = txtsortorder.Text.ToString();
                  

                    img = "";
                    int ImageID = 0;
                    foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
                    {
                        ImageID += 1;
                        string csvPath = Server.MapPath(("..") + @"/../UploadFiles/CustomerActivity/") + ImageID.ToString() + "_" + uploadedFile.FileName;
                        uploadedFile.SaveAs(csvPath);
                        img = @"UploadFiles/CustomerActivity/" + ImageID.ToString() + "_" + uploadedFile.FileName.ToString();
                        ViewState["Image"] = img.ToString();
                    }
                    if (img == "")
                    {
                        img = ViewState["RefImage"].ToString();
                    }
                    else
                    {
                        img = ViewState["Image"].ToString();
                    }

                  

                        dts.Rows.Add(ID, name, desc, type, duedate, SortOrder,  img);
                duedate = DateTime.Parse(rdDueDate.SelectedDate.ToString()).ToString("yyyyMMdd");


            }

                ViewState["DataTable"] = dts;
                Session["DataTable"] = dts;
                grvRpt.DataSource = dts;
                grvRpt.DataBind();

                txtSname.Text = "";
                txtSDesc.Text = "";
                txtsortorder.Text = "";

            
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
                    DataTable dsc = (DataTable)ViewState["DataTable"];
                    foreach (DataRow row in dsc.Rows)
                    {

                        string name = row["name"].ToString();
                        string desc = row["desc"].ToString();
                        string type = row["type"].ToString();
                        string duedate = DateTime.Parse(row["duedate"].ToString()).ToString("yyyyMMdd");
                        string sortorder = row["sortorder"].ToString();
                      
                        string img = row["img"].ToString();
                        //string uom = row["uom"].ToString();

                        //if (Mode.Equals("0"))
                        //{
                        createNode(name, desc, type, duedate, sortorder,  img,writer);
                        //}
                        c++;
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

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
        }

        private void createNode(string name, string desc, string type, string duedate, string sortorder, string img, XmlWriter writer)
        {
            writer.WriteStartElement("Values");


            writer.WriteStartElement("name");
            writer.WriteString(name);
            writer.WriteEndElement();

            writer.WriteStartElement("desc");
            writer.WriteString(desc);
            writer.WriteEndElement();
            writer.WriteStartElement("type");
            writer.WriteString(type);
            writer.WriteEndElement();

            writer.WriteStartElement("duedate");
            writer.WriteString(duedate);
            writer.WriteEndElement();

            writer.WriteStartElement("sortorder");
            writer.WriteString(sortorder);
            writer.WriteEndElement();

            writer.WriteStartElement("img");
            writer.WriteString(img);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
          
        }
    }
}