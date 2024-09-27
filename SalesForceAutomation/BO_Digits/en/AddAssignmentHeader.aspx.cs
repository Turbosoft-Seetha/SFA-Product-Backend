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
    public partial class AddAssignmentHeader : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["DataTable"] = null;

            }
        }
        public void List()
        {
            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;
        }
        public void Loaddata()
        {
           
            //if (ViewState["DataTable"] == null)
            // {
                string mainCondition = "";
                mainCondition = productCondition();
                DataTable lstuser = default(DataTable);
                lstuser = Obj.loadList("SelProduct", "sp_Web_Promotion", mainCondition);
           
                RadGrid1.DataSource = lstuser;
                

            //}
            //else
            //{
            //    DataTable dt = (DataTable)ViewState["DTable"];
            //    RadGrid1.DataSource = dt;
            //}


        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddAssignmentHeader.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string user, Name, Status;
            Name = txtName.Text.ToString();
            Status = ddlStatus.SelectedValue.ToString();
            

            DataTable dsc = (DataTable)ViewState["DataTable"];
            if (dsc == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('For this Assignment, Items are mandatory');</script>", false);
                return;
            }
            string detail = GetItemFromGrid();
            user = UICommon.GetCurrentUserID().ToString();


           

                string[] arr = { user, Status, detail };
                string Value = Obj.SaveData("sp_Web_Promotion", "InsertAssignment", Name, arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
           
        }
        public void addTable()
        {
            
            var ColelctionMarkets = RadGrid1.SelectedItems;           
            int MarCount = ColelctionMarkets.Count;
            if (ColelctionMarkets.Count > 0)
            {
                foreach (GridDataItem dr in ColelctionMarkets)
                {
                   
                    string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                    DataTable lstuser = default(DataTable);
                    lstuser = Obj.loadList("SelProductname", "sp_Web_Promotion", prd_ID);                  
                    string prd_Name = lstuser.Rows[0]["prd_Name"].ToString();
                    string prd_Code = lstuser.Rows[0]["prd_Code"].ToString();

                    string ID,Item,Code;
                    DataTable dts = default(DataTable);
                   
                    if (ViewState["DataTable"] == null)
                    {
                        dts = new DataTable();
                        dts.Columns.Add("ID");
                        dts.Columns.Add("Code");
                        dts.Columns.Add("Item");
                        
                    }
                    else
                    {
                        dts = (DataTable)ViewState["DataTable"];
                        
                    }
            
                    if (dts.Rows.Count > 0)
                    {

                        ID = prd_ID.ToString();
                        Code = prd_Code.ToString();
                        Item = prd_Name.ToString();
                       
                        dts.Rows.Add(ID, Code,Item);
                   
                    }
                    else
                    {

                        ID = prd_ID.ToString();
                        Code = prd_Code.ToString();
                        Item = prd_Name.ToString();

                        dts.Rows.Add(ID,Code, Item);
                       
                    }
                    
                   
                    ViewState["DataTable"] = dts;
                    

                }
            }
            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;           
            grvRpt.DataBind();
            //RowDelete();
            Loaddata();
            RadGrid1.DataBind();
        }
        public string ItemfromAssgn()
        {
            var ColelctionMarkets = grvRpt.Items;
            int MarCount = ColelctionMarkets.Count;
            string PID = "";
            int j = 0;

            if (ColelctionMarkets.Count > 0)
            {
                foreach (GridDataItem dr in ColelctionMarkets)
                {

                    string prd_ID = dr.GetDataKeyValue("ID").ToString();
                    //ID = prd_ID.ToString();
                    if (j == 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        PID += prd_ID.ToString();
                    }
                    j++;
                }
                return PID;
            }
            else
            {
                return "0";
            }


        }
        public string Item()
        {
            var ColelctionMarkets = RadGrid1.SelectedItems;
            int MarCount = ColelctionMarkets.Count;
            string PID = "";
            int j = 0;

            if (ColelctionMarkets.Count > 0)
            {
                foreach (GridDataItem dr in ColelctionMarkets)
                {

                    string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                    //ID = prd_ID.ToString();
                    if (j == 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    else if (j > 0)
                    {
                        PID += prd_ID.ToString() + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        PID += prd_ID.ToString();
                    }
                    j++;
                }
                return PID;
            }
            else
            {
                return "0";
            }
           

        }
        public string productCondition()
        {
            string PID = Item();
            string ID = ItemfromAssgn();
            string productCondition = "";
            string itemCondition = "";
            try
            {
               if (PID.Equals("0") && ID.Equals("0"))
                {
                    productCondition = "0";
                }
                else
                {
                    productCondition = " prd_ID not in (" + PID + ")";
                    itemCondition = " and prd_ID not in (" + ID + ")";
                }
            }
            catch (Exception ex)
            {

            }

            productCondition += itemCondition;
            return productCondition;
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

                    var ColelctionMarkets = grvRpt.Items;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string prd_ID = dr.GetDataKeyValue("ID").ToString();
                            
                            createNode(prd_ID, writer);
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

            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("ListAssignmentHeader.aspx");
        }

        public void Delete()
        {
            try
            {

                var ColelctionMarkets = grvRpt.SelectedItems;
                int MarCount = ColelctionMarkets.Count;
                if (ColelctionMarkets.Count > 0)
                {
                    foreach (GridDataItem dr in ColelctionMarkets)
                    {

                        string ID = dr.GetDataKeyValue("ID").ToString();

                      
                        DataTable dts = (DataTable)ViewState["DataTable"];
                        for (int i = dts.Rows.Count - 1; i >= 0; i--)
                        {
                            DataRow drs = dts.Rows[i];
                            string dd = dr["ID"].ToString();
                            if (drs["ID"].Equals(ID))
                                drs.Delete();
                        }
                        dts.AcceptChanges();
                        ViewState["DTable"] = dts;
                        int x = dts.Rows.Count;
                       

                    }
                }
                DataTable dt = (DataTable)ViewState["DTable"];
                grvRpt.DataSource = dt;
                grvRpt.DataBind();
                Loaddata();
                RadGrid1.DataBind();
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);

            }
            catch (Exception ex)
            {

            }


        }
       
        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }

        protected void LinkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void LinkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListAssignmentDetail.aspx");
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            addTable();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                Delete();
            }
        }
    }
}