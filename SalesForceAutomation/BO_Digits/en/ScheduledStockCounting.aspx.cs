using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Metadata.Edm;
using System.IO;
using System.Linq;
using System.Runtime.Remoting;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ScheduledStockCounting : System.Web.UI.Page
    {
        GeneralFunctions objreq = new GeneralFunctions();        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Warehouse();
                ddlExpDate.MinDate = DateTime.Now;
                
            }

        }
        public void Warehouse()
        {
            ddlWarehouse.DataSource = objreq.loadList("SelWarehouse", "sp_Transaction");
            ddlWarehouse.DataTextField = "war_Name";
            ddlWarehouse.DataValueField = "war_ID";
            ddlWarehouse.DataBind();
        }

        public void LoadData()
        {
            string mainCondition = "";
            mainCondition = mainConditions();
            DataTable warehouseItems = objreq.loadList("SelectWareHouseItems", "sp_Transaction", mainCondition);
            grvRpt.DataSource = warehouseItems;            

        }
        public string mainConditions()
        {

            string warehouse = war();            
            string mainCondition = "";
            string Condition = "";

            try
            {                

                if (warehouse.Equals("0"))
                {
                    Condition = "";
                }
                else
                {
                    Condition = " wim_war_ID in (" + warehouse + ")";
                }

            }
            catch (Exception ex)
            {

            }
            
            mainCondition += Condition;
            return mainCondition;
        }

        public string war()
        {
            var CollectionMarket = ddlWarehouse.CheckedItems;
            string warID = " ";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        warID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        warID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        warID += item.Value;
                    }
                    j++;
                }
                return warID;
            }
            else
            {
                return "wim_war_ID";
            }

        }
        protected void Save()
        {
            try
            {
                string prd = GetItemFromGrid();
                string ExpectedDate, user;
                ExpectedDate = DateTime.Parse(ddlExpDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                user = UICommon.GetCurrentUserID().ToString();               
                
              
                string[] arr = { user.ToString(), prd.ToString() };
                string Value = objreq.SaveData("sp_Transaction", "InsertScheduledSC", ExpectedDate.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Stock counting has been saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                objreq.LogMessageToFile(UICommon.GetLogFileName(), "ScheduledStockCounting.aspx ", "Error : " + ex.Message.ToString() + " - " + innerMessage);

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

                    var selectedItems = grvRpt.SelectedItems;

                    if (selectedItems.Count > 0)
                    {
                        foreach (GridDataItem item in selectedItems)
                        {
                            string warID = item["wim_war_ID"].Text;
                            string prdID = item["wim_prd_ID"].Text;

                            createNode(warID, prdID, writer);
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
                        return sw.ToString();
                    }
                }
            }
        }

        private void createNode(string war_ID, string prd_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteElementString("war_ID", war_ID); 
            writer.WriteElementString("prd_ID", prd_ID);
            writer.WriteEndElement();
        }
        protected void btnProceed_Click(object sender, EventArgs e)
        {
            bool anyRowChecked = grvRpt.SelectedItems.Count > 0;

            if (anyRowChecked)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>CompareModel('No items selected');</script>", false);

            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("StockCountingHeader.aspx");
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("StockCountingHeader.aspx");
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();

        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
           
        }
     
        protected void ddlWarehouse_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadData();
            grvRpt.Rebind();
        }        
        protected void norowslected_Click(object sender, EventArgs e)
        {

        }
       
    }
}