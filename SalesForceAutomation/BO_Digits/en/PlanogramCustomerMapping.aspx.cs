﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Skins;
namespace SalesForceAutomation.BO_Digits.en
{
    public partial class PlanogramCustomerMapping : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["PID"], out ResponseID);

                return ResponseID;
            }
        }
        public int RouteID
        {
            get
            {
                int RouteID;
                int.TryParse(Request.Params["RID"], out RouteID);

                return RouteID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                Customers();


                LoadList();
            }
        }
        public void Customers()
        {
          
            DataTable dt = ObjclsFrms.loadList("SelCustomers", "sp_MerchandisingWebServices", RouteID.ToString());
            ddlCustomer.DataSource = dt;
            ddlCustomer.DataTextField = "cus_Name";
            ddlCustomer.DataValueField = "cus_ID";
            ddlCustomer.DataBind();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim1();</script>", false);

            LoadList();
        }


      
        public void SaveCustomers()
        {
            

            string cus = GetCusFromDropdown();

          
            string usr = UICommon.GetCurrentUserID().ToString();
            string[] arr = { ResponseID.ToString(), RouteID.ToString(), usr };
            string Value = ObjclsFrms.SaveData("sp_MerchandisingWebServices", "AddPlanogramCustomer", cus.ToString(), arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customers mapped successfully');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }

        }
        public string GetCusFromDropdown()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("cus"); 

                    foreach (RadComboBoxItem item in ddlCustomer.CheckedItems)
                    {
                        createNodeForComboBox1(item.Value, writer);
                    }

                    writer.WriteEndElement(); // Close root element
                    writer.WriteEndDocument();
                    writer.Close();

                    return sw.ToString();
                }
            }
        }
        private void createNodeForComboBox1(string value, XmlWriter writer)
        {
            writer.WriteStartElement("row"); // Each route ID under its own element
            writer.WriteElementString("cus_ID", value);
            writer.WriteEndElement();
        }
        public void LoadList()
        {
            string cusID = Cus();
            string mainCondition = "";
            mainCondition = mainConditions(cusID);

            DataTable lstUser = default(DataTable);
            //if (mode.Equals("F"))
            //{
            //    lstUser = ObjclsFrms.loadList("SelectUserDailyProcess", "sp_Merchandising", mainConditions(rotID, "C").ToString());
            //}
            //else
            //{
            lstUser = ObjclsFrms.loadList("PlanogramCustomerMapping", "sp_MerchandisingWebServices", ResponseID.ToString());
            //}

            grvRpt.DataSource = lstUser;

        }
        public string mainConditions(string cusID)
        {
            string mainCondition = " udp_rot_ID in (" + cusID + ")";

            return mainCondition;
        }
        public string Cus()
        {
            var ColelctionMarket = ddlCustomer.CheckedItems;
            string cusID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
                    if (j == 0)
                    {
                        cusID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        cusID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        cusID += item.Value;
                    }
                    j++;
                }
                return cusID;
            }
            else
            {
                return "0";
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        protected void SaveCus_Click(object sender, EventArgs e)
        {
            SaveCustomers();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            //LoadList();
            //grvRpt.Rebind();

            Response.Redirect("PlanogramCustomerMapping.aspx?PID=" + ResponseID.ToString() + "&RID=" + RouteID.ToString());
        }

   

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("plc_ID").ToString();
                ViewState["SelectedPlcID"] = ID;

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void btnDeleteOk_Click(object sender, EventArgs e)
        {
            Response.Redirect("PlanogramCustomerMapping.aspx?PID=" + ResponseID.ToString() + "&RID=" + RouteID.ToString());
            //LoadList();
            //grvRpt.Rebind();
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            string ID = ViewState["SelectedPlcID"] as string;
            string[] arr = { };
            string Value = ObjclsFrms.SaveData("sp_MerchandisingWebServices", "DelepePlcID", ID.ToString(),arr);
            int res = Int32.Parse(Value.ToString());

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess1('Deleted Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }

        }

 
    }
}