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
    public partial class AddEditAssignmentDetail : System.Web.UI.Page
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
            DataTable lstTitle = ObjclsFrms.loadList("SelectAssignmentHeaderTitle", "sp_Web_Promotion", HeaderID.ToString());
            string titles = lstTitle.Rows[0]["title"].ToString();
            lblTitle.Text = "for " + titles.ToString();
        }

        //public void FillForm()
        //{
        //    DataTable lstDatas = ObjclsFrms.loadList("SelectAssignmentDetailByID", "sp_Web_Promotion", ResponseID.ToString());
        //    if (lstDatas.Rows.Count > 0)
        //    {
        //        string product,status;
        //        product = lstDatas.Rows[0]["asd_prd_ID"].ToString();
        //        status = lstDatas.Rows[0]["Status"].ToString();

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
            Response.Redirect("/Admin/ListAssignmentDetail.aspx?Id="+ HeaderID.ToString());
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ListAssignmentDetail.aspx?Id=" + HeaderID.ToString());
        }

       
        public void Products()
        {
            DataTable dtp = ObjclsFrms.loadList("SelectProductDropdown", "sp_Web_Promotion", HeaderID.ToString());
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
            writer.WriteStartElement("asd_prd_ID");
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


                string[] arr = { header, user, status};
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "InsertAssignmentDetail", product, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Assignment Detail Saved Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }

            else
            {
                string id = ResponseID.ToString();
                string[] arr = { product, user, status, id};
                string Value = ObjclsFrms.SaveData("sp_Web_Promotion", "UpdateAssignmentDetail", header, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)

                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Assignment Detail Updated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
        }
    }
}