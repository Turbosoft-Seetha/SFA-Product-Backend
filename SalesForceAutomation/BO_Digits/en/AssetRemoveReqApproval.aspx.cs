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
    public partial class AssetRemoveReqApproval : System.Web.UI.Page
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
            lstuser = obj.loadList("SelAssetRemoveRequest", "sp_AssetRemovalReq");
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
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

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
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = obj.SaveData("sp_AssetRemovalReq", "ApproveAssetRemoveRequest", Req, arr);
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
                            string arq_ID = dr.GetDataKeyValue("arq_ID").ToString();
                            string asc_ID = dr["arq_asc_ID"].Text.ToString();
                            string cus_ID = dr["arq_cus_ID"].Text.ToString();

                            createNode(arq_ID, asc_ID,cus_ID, writer);
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

        private void createNode(string arq_ID,string asc_ID,string cus_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("arq_ID");
            writer.WriteString(arq_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("asc_ID");
            writer.WriteString(asc_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();


            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssetRemoveReqApproval.aspx");

        }

      

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;
                string imah = dataItem["arq_img"].Text.Replace(" ", "");
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

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = obj.SaveData("sp_AssetRemovalReq", "RejectAssetRemoveRequest", Req, arr);
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
    }
}