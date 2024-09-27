using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class CustomerSpecialPriceDetail : System.Web.UI.Page
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
            HeaderData();
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("SelPriceListHeader", "sp_Masters", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRoute = (Label)rp.FindControl("lblRoute");

                Label lblstatus = (Label)rp.FindControl("lblstatus");
                Label lblPayMode = (Label)rp.FindControl("lblPayMode");

                rp.Text = "Special Price Code: " + lstDatas.Rows[0]["prh_Code"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["prh_Name"].ToString();

                lblstatus.Text = lstDatas.Rows[0]["Status"].ToString();
                lblPayMode.Text = lstDatas.Rows[0]["prh_PayMode"].ToString();
                ViewState["prhname"] = lblRoute.Text;
                ViewState["paymode"] = lblPayMode.Text;
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPriceListDetail", "sp_Masters", ResponseID.ToString());
            grvRpt.DataSource = lstUser;
        }

       
       

     


        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
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
                    int p = grvRpt.PageCount;
                    var ColelctionMarkets = grvRpt.SelectedItems;

                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {

                            string pldID = dr.GetDataKeyValue("pld_ID").ToString();
                            createNode(pldID, writer);
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

        private void createNode(string pldID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("pldID");
            writer.WriteString(pldID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }
    }
}