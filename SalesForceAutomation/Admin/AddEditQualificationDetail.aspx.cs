using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SalesForceAutomation.Admin
{
    public partial class AddEditQualificationDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["ID"], out ResponseID);

                return ResponseID;
            }
        }
        public int HeaderID
        {
            get
            {
                int HeaderID;
                int.TryParse(Request.Params["HID"], out HeaderID);

                return HeaderID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Titles();
                Products();
                //FillForm();
            }
        }

        public void Titles()
        {
            DataTable lstTitle = ObjclsFrms.loadList("SelectQalificationHeaderTitle", "sp_Web_Promotion", HeaderID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
            lblTitle.Text = "for " + titles.ToString();
        }

        //public void FillForm()
        //{
        //    DataTable lstDatas = ObjclsFrms.loadList("SelectQalificationDetailByID", "sp_Web_Promotion", ResponseID.ToString());
        //    if (lstDatas.Rows.Count > 0)
        //    {
        //        string product, category, subcategory, status;
        //        category = lstDatas.Rows[0]["prd_cat_ID"].ToString();
        //        subcategory = lstDatas.Rows[0]["prd_sct_ID"].ToString();
        //        product = lstDatas.Rows[0]["qld_prd_ID"].ToString();
        //        status = lstDatas.Rows[0]["Status"].ToString();

        //        ddlCat.SelectedValue = category.ToString();
        //        SubCat(category);
        //        ddlSubCat.SelectedValue = subcategory.ToString();
        //        Products(category, subcategory);
        //        ddlProduct.SelectedValue = product.ToString();
        //        ddlStatus.SelectedValue = status.ToString();
        //    }
        //}

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListQualificationDetail.aspx?Id=" + HeaderID.ToString());
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListQualificationDetail.aspx?Id=" + HeaderID.ToString());
        }


        public void Products()
        {
            DataTable dtp = ObjclsFrms.loadList("SelPrdDropdownforQualification", "sp_Web_Promotion", HeaderID.ToString());
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

        protected void Save()
        {
            string product, header, user, status;

            product = GetItemFromGrid();
            header = HeaderID.ToString();
            user = UICommon.GetCurrentUserID().ToString();
            status = ddlStatus.SelectedValue.ToString();

            if (ResponseID.Equals("") || ResponseID == 0)
            {


                string[] arr = { product, user, status };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertQualificationDetail", header, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { product.ToString(), user.ToString(), status.ToString(), id.ToString() };
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "UpdateQualificationDetail", header.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Qualification Detail Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }


    }
}