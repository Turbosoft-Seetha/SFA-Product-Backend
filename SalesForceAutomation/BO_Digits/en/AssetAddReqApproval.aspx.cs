using DocumentFormat.OpenXml.Wordprocessing;
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
    public partial class AssetAddReqApproval : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void ListData()
        {
            DataTable lstuser = new DataTable();
            lstuser = obj.loadList("SelAssetAddRequest", "sp_AssetRemovalReq");
            grvRpt.DataSource = lstuser;
        }
        protected void lnkReject_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {

            }

        }

        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string code = this.txtSerialNo.Text.ToString();
            DataTable lstCodeChecker = obj.loadList("CheckCustomerAssetCode", "sp_CodeChecker", code);
            if (lstCodeChecker.Rows.Count > 0)
            {
                
               ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModall('Serial Number already exists. Try another..');</script>", false);

            }
            else
            {
                string user = UICommon.GetCurrentUserID().ToString();

                string Req = ViewState["aahID"].ToString();

                string serialNo = txtSerialNo.Text.ToString();
                string[] arr = { user, serialNo };
                string Value = obj.SaveData("sp_AssetRemovalReq", "ApproveAssetAddRequest", Req, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Approved Successfully');</script>", false);
                }

                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
                }
            }
                
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

                    var ColelctionMarkets = grvRpt.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string aah_ID = dr.GetDataKeyValue("aah_ID").ToString();
                            string ast_ID = dr["aah_ast_ID"].Text.ToString();
                            string cus_ID = dr["aah_cus_ID"].Text.ToString();
                            string astcode = dr["aah_slno"].Text.ToString();
                            string astname = dr["aah_Name"].Text.ToString();
                            string reason = dr["aah_rsn_ID"].Text.ToString();
                            string remarks = dr["aah_Remarks"].Text.ToString();
                            string img = dr["aah_img"].Text.ToString();
                            createNode(aah_ID, ast_ID, cus_ID, astcode, astname, reason, remarks, img, writer);
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
        private void createNode(string aah_ID, string ast_ID, string cus_ID, string astcode, string astname, string reason, string remarks, string img, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("aah_ID");
            writer.WriteString(aah_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("ast_ID");
            writer.WriteString(ast_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("astcode");
            writer.WriteString(astcode);
            writer.WriteEndElement();

            writer.WriteStartElement("astname");
            writer.WriteString(astname);
            writer.WriteEndElement();

            writer.WriteStartElement("reason");
            writer.WriteString(reason);
            writer.WriteEndElement();

            writer.WriteStartElement("remarks");
            writer.WriteString(remarks);
            writer.WriteEndElement();

            writer.WriteStartElement("img");
            writer.WriteString(img);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetAddReqApproval.aspx");

        }


        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;
                string imah = dataItem["aah_img"].Text.Replace(" ", "");
                string[] values = imah.Split(',');
                imah = imah.Replace("&nbsp;", null);
                for (int i = 0; i < values.Length; i++)
                {
                    if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                    {

                        Image img = new Image();
                        img.ID = "Image1" + i.ToString();
                        img.ImageUrl = "../" + values[i].ToString();
                        img.Height = 20;
                        img.Width = 20;
                        img.BorderStyle = BorderStyle.Groove;
                        img.BorderWidth = 2;
                        img.BorderColor = System.Drawing.Color.Black;
                        HyperLink hl = new HyperLink();
                        hl.NavigateUrl = "../" + values[i].ToString();
                        hl.ID = "hl" + i.ToString();
                        hl.Target = "_blank";
                        hl.Controls.Add(img);

                        dataItem["Images"].Controls.Add(hl);
                    }
                }

            }
        }

        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = ViewState["aahID"].ToString();


            string[] arr = { user };
            string Value = obj.SaveData("sp_AssetRemovalReq", "RejectAssetAddRequest", Req, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Approve"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("aah_ID").ToString();
                ViewState["aahID"] = ID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);


            }
           else  if (e.CommandName.Equals("Reject"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("aah_ID").ToString();
                ViewState["aahID"] = ID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);


            }
        }

     
    }
}