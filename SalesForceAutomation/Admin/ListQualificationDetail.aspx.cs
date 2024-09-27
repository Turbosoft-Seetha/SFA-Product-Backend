using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class ListQualificationDetail : System.Web.UI.Page
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
                //Titles();
                FillForm();
                Products();
            }
        }

        public void FillForm()
        {
            if (ResponseID.Equals("") || ResponseID == 0)
            {
                Num.Visible = false;
                product.Visible = false;
            }
            DataTable lstDatas = ObjclsFrms.loadList("SelectQalificationHeaderByID", "sp_Web_Promotion", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                string name, status, code;
                name = lstDatas.Rows[0]["qlh_Name"].ToString();
                status = lstDatas.Rows[0]["Status"].ToString();
                code = lstDatas.Rows[0]["qlh_Number"].ToString();
                txtNumber.Text = code.ToString();
                txtName.Text = name.ToString();
                ddlStatus.SelectedValue = status.ToString();
            }
        }
        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectQalificationHeaderTitle", "sp_Web_Promotion", ResponseID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
            lblTitle.Text = "for " + titles.ToString();
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }
        public void LoadList()
        {
            string id = ResponseID.ToString();
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectQalificationDetailByHead", "sp_Web_Promotion", id);
            grvRpt.DataSource = lstUser;
        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("qld_ID").ToString();

                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }
        protected void Save()
        {
            string name, user, status;

            name = txtName.Text.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();


            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { user, status };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertQualificationHeader", name, arr);
                int res = Int32.Parse(Value.ToString());
                ViewState["id"] = res.ToString();
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Header Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { user, status, id };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "UpdateQualificationHeader", name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Header Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }
        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListQualificationHeader.aspx");
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Save();
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            string ID;
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                ID = ViewState["id"].ToString();
            }
            else
            {
                ID = ResponseID.ToString();
            }

            Response.Redirect("/Admin/ListQualificationDetail.aspx?Id=" + ID);
            product.Visible = true;
        }

        public void Products()
        {
            DataTable dtp = ObjclsFrms.loadList("SelPrdDropdownforQualification", "sp_Web_Promotion", ResponseID.ToString());
            ddlProduct.DataSource = dtp;
            ddlProduct.DataTextField = "name";
            ddlProduct.DataValueField = "id";
            ddlProduct.DataBind();
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

                    var ColelctionMarkets = ddlProduct.CheckedItems;

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
            writer.WriteStartElement("qld_prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }
        protected void SaveProducts()
        {
            string product, header, user, status;

            product = GetItemFromGrid();
            header = ResponseID.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStat.SelectedValue.ToString();

                string[] arr = { product, user, status };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertQualificationDetail", header, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcesss('Qualification Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failures();</script>", false);
                }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confims();</script>", false);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            SaveProducts();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string ID;
            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                ID = ViewState["id"].ToString();
            }
            else
            {
                ID = ResponseID.ToString();
            }

            Response.Redirect("/Admin/ListQualificationDetail.aspx?Id=" + ID);
        }

        protected void lnkdelete_Click(object sender, EventArgs e)
        {
            string id = ViewState["delID"].ToString();
            GeneralFunctions.loadList_Static("DeleteQualificationDetail", "sp_Web_Promotion", id);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delsuccessModal();</script>", false);
        }

        protected void deleteOk_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}