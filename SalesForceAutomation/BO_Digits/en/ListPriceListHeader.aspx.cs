using ExcelLibrary.BinaryFileFormat;
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
    public partial class ListPriceListHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListPriceListHeader", "sp_Masters");
            grvRpt.DataSource = lstUser;
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditPriceListHeader.aspx?Id=0");

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("AddEditPriceListHeader.aspx?Id=" + ID);
            }

            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("ListPriceListDetail.aspx?hid=" + ID);
            }
            if (e.CommandName.Equals("CusAssign"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("prh_ID").ToString();
                Response.Redirect("SpecialPriceAssign.aspx?Id=" + ID);
                //Response.Redirect("ListSpecialPriceAssign.aspx?Id=" + ID);
            }
        
    }

        protected void lnkCusReAssign_Click(object sender, EventArgs e)
        {
            Response.Redirect("SpecialPriceBulkDelete.aspx");
        }

        protected void lnkAssgnCus_Click(object sender, EventArgs e)
        {
            Response.Redirect("SpecialPriceAssignedCustomers.aspx");

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
                            string prh_ID = dr.GetDataKeyValue("prh_ID").ToString();
                          

                            createNode(prh_ID, writer);
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

        private void createNode(string prh_ID,  XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("prh_ID");
            writer.WriteString(prh_ID);
            writer.WriteEndElement();

           

            writer.WriteEndElement();
        }

        protected void btnActions_Click(object sender, EventArgs e)
        {
            if(grvRpt.SelectedItems.Count>0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);

            }

        }

        protected void Activate_Click(object sender, EventArgs e)
        {
            ActivateSPCl();
        }

        protected void Deactivate_Click(object sender, EventArgs e)
        {
            DeactivateSPCl();
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            DeleteSPCl();
        }

        public void ActivateSPCl()
        {
            try
            {
                string id = GetItemFromGrid();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ObjclsFrms.SaveData("sp_Masters", "ActivateSpclPrices", id.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Activated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            catch (Exception ex)
            {

            }
        }
        public void DeleteSPCl()
        {

            try
            {
                string id = GetItemFromGrid();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ObjclsFrms.SaveData("sp_Masters", "DeleteSpclPrices", id.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Deleted Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            catch (Exception ex)
            {

            }
        }
        public void DeactivateSPCl()
        {
            try
            {
                string id = GetItemFromGrid();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ObjclsFrms.SaveData("sp_Masters", "DeactivateSpclPrices", id.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Deactivated Successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListPriceListHeader.aspx");
        }
    }
}