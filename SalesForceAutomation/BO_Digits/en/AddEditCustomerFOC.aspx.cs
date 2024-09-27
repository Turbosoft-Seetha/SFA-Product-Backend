using DocumentFormat.OpenXml.Wordprocessing;
using ExcelLibrary.BinaryFileFormat;
using SalesForceAutomation.Admin;
using Stimulsoft.Base;
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
using Telerik.Web.UI.Chat;
using Telerik.Web.UI.Skins;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddEditCustomerFOC : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                rdFromDate.SelectedDate = DateTime.Now;
                DateTime dt = DateTime.Now;
                TimeSpan oneday = new TimeSpan(1, 0, 0, 0);
                dt = dt.Add(oneday);
                rdEndDate.SelectedDate = dt;
                Route();
                FillForm();

            }
        }


        public void List()
        {
            if ((DataTable)ViewState["DataTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["DataTable"];
                grvptassigncus.DataSource = dt;
                //grvptassigncus.DataBind();
            }
            else
            {
                grvptassigncus.DataSource = new DataTable();
            }
          
        }


        public void ListData()
        {
            if ((DataTable)ViewState["DataTables"] != null)
            {
                DataTable dt = (DataTable)ViewState["DataTables"];
                grvptassignpro.DataSource = dt;
                //grvptassigncus.DataBind();
            }
            else
            {
                grvptassignpro.DataSource = new DataTable();
            }

        }

        public void FillForm()
        {
            string Id = ResponseID.ToString();
            if (Id.Equals("") || Id == "0")                                //To check whether there is a value for ResponseID or not. For adding there won't be a value.
            {
                rdFromDate.MinDate = DateTime.Now;
                DateTime dt = DateTime.Now;
                TimeSpan oneday = new TimeSpan(1, 0, 0, 0);
                dt = dt.Add(oneday);

                rdEndDate.MinDate = dt;
            }
            else                                                                        //If we are editing there will be a value and the following code will be executed.
            {


                DataTable lstDatas = ObjclsFrms.loadList("SelectFOCByID", "sp_Masters_UOM", ResponseID.ToString());
                if (lstDatas.Rows.Count > 0)
                {

                    string name, rotid, cusid, pname, eligible, fromdate, todate, huom, hqty, luom, lqty;                                          //Declare the variables
                    name = lstDatas.Rows[0]["rcs_ID"].ToString();
                    rotid = lstDatas.Rows[0]["rcs_rot_ID"].ToString();
                    string routeCondition1 = " rcs_rot_ID in (" + rotid + ")";
                    string routeCondition2 = " rop_rot_ID in (" + rotid + ")";
                    Customer(routeCondition1);
                    cusid = lstDatas.Rows[0]["rcs_cus_ID"].ToString();
                    Product(routeCondition2);
                    pname = lstDatas.Rows[0]["crf_prd_ID"].ToString();
                    eligible = lstDatas.Rows[0]["crf_EligibleQty"].ToString();
                    fromdate = lstDatas.Rows[0]["crf_FromDate"].ToString();
                    todate = lstDatas.Rows[0]["crf_ToDate"].ToString();


                    ddlids.SelectedValue = rotid.ToString();
                   

                    rdFromDate.SelectedDate = DateTime.Parse(fromdate.ToString());
                    rdEndDate.SelectedDate = DateTime.Parse(todate.ToString());
                    rdFromDate.Enabled = false;
                    rdEndDate.Enabled = false;

                  


                }
                else                                                           
                {

                }
            }
        }
        public string GetItemFromGrid2()
        {
            using (var sw = new StringWriter())
            {
                int c = 0;
                using (var writer = XmlWriter.Create(sw))
                {

                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");

                    DataTable dsc = new DataTable();
                    foreach (GridDataItem dr in grvcustomer.SelectedItems)
                    {

                        string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();

                        createNode2(cus_ID, writer);
                        c++;
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

                }
                if (c == 0)
                {

                    return null;
                }
                else
                {
                    string ss = sw.ToString();
                    return sw.ToString();
                }
            }
        }
        private void createNode2(string cus_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("cus_ID");
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
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

                    var ColelctionMarkets = grvproduct.SelectedItems;

                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            Telerik.Web.UI.RadNumericTextBox txttotqty = (Telerik.Web.UI.RadNumericTextBox)dr.FindControl("txttotalQty");
                            

                            string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                            string totalqty = txttotqty.Text.ToString();  // Assuming Rot() returns a string, split it into individual IDs
                            

                                        createNode(prd_ID, totalqty, writer);
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

        private void createNode(string prd_ID, string totalqty, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("totalqty");
            writer.WriteString(totalqty);
            writer.WriteEndElement();

           

            writer.WriteEndElement();
        }

        public void SaveData()
            {

            string rotid, id,user;
           // rotid = GetItemRot();
            string dates = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            string date = DateTime.Parse(rdEndDate.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            user = UICommon.GetCurrentUserID().ToString();
            string customers = GetItemFromGrid3();
            string products = GetItemFromGrid4();

            //string[] arrr = {  };
            //DataTable lstUserr = default(DataTable);
            //lstUserr = ObjclsFrms.loadList("selectCustomerAndRotID", "sp_Masters_UOM", rotid, arrr);
            //id = lstUserr.Rows[0]["rcs_ID"].ToString();



            if (ResponseID.Equals("0") || ResponseID == 0)
            {
                string[] arr = {  products, dates, date, user };
                string Value = ObjclsFrms.SaveData("sp_Masters_UOM", "InsertFOC", customers, arr);

                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer FOC saved successfully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Something Went Wrong');</script>", false);
                }
            }
            else
            {
                string ID = ResponseID.ToString();
                string[] arr = {  dates, date, user, ResponseID.ToString() };
                string value = ObjclsFrms.SaveData("sp_Masters_UOM", "UpdateFOC", customers,  arr);
                int res = Int32.Parse(value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess('Customer FOC updated successFully');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
                }


            }

        }
        public void Route()
        {
            DataTable dt = ObjclsFrms.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlids.DataSource = dt;
            ddlids.DataTextField = "rot_Name";
            ddlids.DataValueField = "rot_ID";
            ddlids.DataBind();
        }
        public void Customer(string route)
        {
            DataTable dts = ObjclsFrms.loadList("DropDownCustomerForRoute", "sp_Masters_UOM", route);
            if (dts.Rows.Count >= 0)
            {
                grvcustomer.DataSource = dts;
            }
            else
            {
                grvcustomer.DataSource = new DataTable();
            }


        }
        
        public void Product(string rot)
        {
            string[] arr = { };
            DataTable dtt = ObjclsFrms.loadList("SelFromDropProductID", "sp_Masters_UOM", rot);
            if(dtt.Rows.Count>=0)
            {
                grvproduct.DataSource = dtt;

            }
            else
            {
                grvproduct.DataSource = new DataTable();
            }
        }


     


        protected void LinkButton1_Click(object sender, EventArgs e)
        {


            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);


            //if (grvptassigncus.SelectedItems.Count>0 && grvptassignpro.SelectedItems.Count>0)
            //{

           
            //        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

                

            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Please make selection');</script>", false);

            //}

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerFOC.aspx");

        }

        protected void ddlids_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //string rot = ddlids.SelectedValue.ToString();
            //Customer(rot);
            //Product(rot);
            //grvcustomer.Rebind();
            //grvproduct.Rebind();
            string rot = Rot();
            if (rot.Equals("rcs_rot_ID"))
            {
                rot = "0";
            }
            string routeCondition1 = " rcs_rot_ID in (" + rot + ")";
            string routeCondition2 = " rop_rot_ID in (" + rot + ")";
            Customer(routeCondition1);
            Product(routeCondition2);
            grvcustomer.Rebind();
            grvproduct.Rebind();
            
        }
        public string Rot()
        {
            var CollectionMarket = ddlids.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = CollectionMarket.Count;
            if (CollectionMarket.Count > 0)
            {
                foreach (var item in CollectionMarket)
                {
                    if (j == 0)
                    {
                        rotID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        rotID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        rotID += item.Value;
                    }
                    j++;
                }
                return rotID;
            }
            else
            {
                return "rcs_rot_ID";
            }
        }

        protected void ddlCus_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rot = Rot();
            if (rot.Equals("rcs_rot_ID"))
            {
                rot = "0";
            }


        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

       

        protected void save_Click(object sender, EventArgs e)
        {
            SaveData();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/BO_Digits/en/ListCustomerFOC.aspx");

        }

        protected void lnkAddCus_Click(object sender, EventArgs e)
        {

        }

        protected void lnkaddProduct_Click(object sender, EventArgs e)
        {

        }



        protected void grvproduct_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            string rot = Rot();
            if (rot.Equals("rcs_rot_ID"))
            {
                rot = "0";
            }
            string routeCondition = " rop_rot_ID in (" + rot + ")";

            Product(routeCondition);
        }
        protected void grvcustomer_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            string rot = Rot();
            if (rot.Equals("rcs_rot_ID"))
            {
                rot = "0";
            }
            string routeCondition = " rcs_rot_ID in (" + rot + ")";;
            Customer(routeCondition);
        }




        protected void grvptassigncus_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            List();
        }

      

        protected void grvptassignpro_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            ListData();
        
        }


        public void AssignedCustomer(string route)
        {
            string cusID = GetItemFromGrid3();
            string[] arr = { cusID };
            DataTable dts = ObjclsFrms.loadList("DropDownAssignCustomerForRoute", "sp_Masters_UOM", route.ToString(), arr);
            if (dts.Rows.Count >= 0) // Check for rows greater than 0, not >= 0
            {
                grvptassigncus.DataSource = dts;

                Session["AssignedCus"] = dts;
                //RadGrid1.DataSource = dts;





            }


        }

        public void AssignedProduct(string rot)
        {
            string proID = GetItemFromGrid6();
            string[] arr = { proID };
            DataTable dtt = ObjclsFrms.loadList("SelFromDropAssignProductID", "sp_Masters_UOM", rot.ToString(),arr);
            if (dtt.Rows.Count >= 0)
            {
                grvptassignpro.DataSource = dtt;
                Session["AssignedPro"] = dtt;
                // RadGrid2.DataSource = dtt;
            }
        }




        public string GetItemFromGrid3()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("q");
                    int c = 0;

                    var ColelctionMarkets = grvptassigncus.Items;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string cus_ID = dr.GetDataKeyValue("ID").ToString();
                           // string RotId = dr.GetDataKeyValue("Rotid").ToString();
                            string rotID = dr["rotID"].Text.ToString();

                            createNode1(cus_ID, rotID, writer);
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
        private void createNode1( string cus_ID, string rotID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            
            writer.WriteStartElement("cus_ID");          
            writer.WriteString(cus_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("rotID");
            writer.WriteString(rotID);
            writer.WriteEndElement();

            writer.WriteEndElement();

        }

        public string GetItemFromGrid4()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = grvptassignpro.Items;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                           

                            //where 1 = 1
                            string prd_ID = dr.GetDataKeyValue("ID").ToString();
                            string totalqty = dr["Qty"].Text;
                            createNode5(prd_ID, totalqty, writer);
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
        private void createNode5(string prd_ID,string totalqty,  XmlWriter writer)
        {
            writer.WriteStartElement("Values");



            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();


            writer.WriteStartElement("totalqty");
            writer.WriteString(totalqty);
            writer.WriteEndElement();




            writer.WriteEndElement();
        }

        public string GetItemRot()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var CollectionMarket = ddlids.CheckedItems;
                    int MarCount = CollectionMarket.Count;
                    if (CollectionMarket.Count > 0)
                    {
                        foreach (var item in CollectionMarket)
                        {
                            string rotId = item.Value;
                            createNode(rotId, writer);
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

        private void createNode(string rotId, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("rotID");
            writer.WriteString(rotId);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        protected void lnkAddQuestion_Click(object sender, EventArgs e)
        {
            //string rot = ddlids.SelectedValue.ToString();
            //AssignedCustomer(rot);
            //grvptassigncus.Rebind();



            addTable();

        }

        public void addTable()
        {
            var selectedCustomers = grvcustomer.SelectedItems;
            int MarCount = selectedCustomers.Count;

            if (MarCount > 0)
            {
                //string rot = ddlids.SelectedValue.ToString();
                string rot = Rot();
                if (rot.Equals("rcs_rot_ID"))
                {
                    rot = "0";
                }
                string routeCondition = " rcs_rot_ID in (" + rot + ")";
                DataTable dt;

                if (ViewState["DataTable"] == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("ID");
                    dt.Columns.Add("rotID");
                    dt.Columns.Add("Code");
                    dt.Columns.Add("Name");
                    dt.Columns.Add("Route");
                }
                else
                {
                    dt = (DataTable)ViewState["DataTable"];
                }

                foreach (GridDataItem dr in selectedCustomers)
                {
                    string cus_ID = dr.GetDataKeyValue("cus_ID").ToString();
                    //string Rotid = dr.GetDataKeyValue("rcs_rot_id").ToString();
                    bool itemExists = false;
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["ID"].ToString() == cus_ID)
                        {
                            itemExists = true;
                            break;
                        }
                    }

                    if (!itemExists)
                    {
                         
                        DataTable lstuser = ObjclsFrms.loadList("DropDownAssignCustomerForRoute", "sp_Masters_UOM", routeCondition, new string[] { cus_ID });
                        if (lstuser.Rows.Count > 0)
                        {
                            string cus_Name = lstuser.Rows[0]["cus_Name"].ToString();
                            string cus_Code = lstuser.Rows[0]["cus_Code"].ToString();
                            string Route = lstuser.Rows[0]["Route"].ToString();
                            string rotID = lstuser.Rows[0]["rotID"].ToString();

                            dt.Rows.Add(cus_ID, rotID, cus_Code, cus_Name,Route);

                        }
                    }
                }

                ViewState["DataTable"] = dt;
                grvptassigncus.DataSource = dt;
                grvptassigncus.DataBind();          
                Customer(routeCondition);
                grvcustomer.DataBind();
            }
        }



        protected void Addpro_Click(object sender, EventArgs e)
        {
            addTable1();
        }



        public void addTable1()
        {
            var selectedProducts = grvproduct.SelectedItems;
            int productCount = selectedProducts.Count;

            if (productCount > 0)
            {
                // string rot = ddlids.SelectedValue.ToString();
                string rot = Rot();
                if (rot.Equals("rcs_rot_ID"))
                {
                    rot = "0";
                }
                string routeCondition = " rop_rot_ID in (" + rot + ")";
                DataTable dt;

                if (ViewState["DataTables"] == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("ID");
                    dt.Columns.Add("Code");
                    dt.Columns.Add("Name");
                    dt.Columns.Add("Qty");
                }
                else
                {
                    dt = (DataTable)ViewState["DataTables"];
                }

                foreach (GridDataItem dr in selectedProducts)
                {
                    RadNumericTextBox txttotQty = (RadNumericTextBox)dr.FindControl("txttotalQty");
                    if (txttotQty == null || string.IsNullOrWhiteSpace(txttotQty.Text))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure('Total quantity Missing for some products');</script>", false);
                        continue;
                    }

                    string Qunatity = txttotQty.Text.ToString();
                    string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();

                    // Check if the item already exists in the DataTable
                    bool itemExists = false;
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["ID"].ToString() == prd_ID)
                        {
                            itemExists = true;
                            break;
                        }
                    }

                    // If the item doesn't exist, add it to the DataTable
                    if (!itemExists)
                    {
                        DataTable lstuser = ObjclsFrms.loadList("SelFromDropAssignProductID", "sp_Masters_UOM", routeCondition, new string[] { prd_ID });
                        if (lstuser.Rows.Count > 0)
                        {
                            string prd_Name = lstuser.Rows[0]["prd_Name"].ToString();
                            string prd_Code = lstuser.Rows[0]["prd_Code"].ToString();

                            dt.Rows.Add(prd_ID, prd_Code, prd_Name, Qunatity);

                        }
                    }
                }

                // Update ViewState with the modified DataTable
                ViewState["DataTables"] = dt;

                // Bind the DataTable to grvptassignpro
                grvptassignpro.DataSource = dt;
                grvptassignpro.DataBind();

                // Optionally, update the product grid based on the route
                Product(routeCondition);
                grvproduct.DataBind();
            }
        }





        public string GetItemFromGrid6()
        {
            using (var sw = new StringWriter())
            {
                using (var writer = XmlWriter.Create(sw))
                {
                    writer.WriteStartDocument(true);
                    writer.WriteStartElement("r");
                    int c = 0;

                    var ColelctionMarkets = grvproduct.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {

                            //where 1 = 1
                            string prd_ID = dr.GetDataKeyValue("prd_ID").ToString();
                            createNode6(prd_ID ,writer);
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
        private void createNode6(string prd_ID,  XmlWriter writer)
        {
            writer.WriteStartElement("Values");



            writer.WriteStartElement("prd_ID");
            writer.WriteString(prd_ID);
            writer.WriteEndElement();


          



            writer.WriteEndElement();
        }

    


     
       
        protected void DelCustomer_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvptassigncus.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                Delete();
            }
        }

        public void Delete()
        {
            try
            {

                var ColelctionMarkets = grvptassigncus.SelectedItems;
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
                grvptassigncus.DataSource = dt;
                grvptassigncus.DataBind();
                List();
               // grvcustomer.DataBind();
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);

            }
            catch (Exception ex)
            {

            }


        }

        protected void DelProduct_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvptassignpro.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                Delete1();
            }
        }


        public void Delete1()
        {
            try
            {

                var ColelctionMarkets = grvptassignpro.SelectedItems;
                int MarCount = ColelctionMarkets.Count;
                if (ColelctionMarkets.Count > 0)
                {
                    foreach (GridDataItem dr in ColelctionMarkets)
                    {

                        string ID = dr.GetDataKeyValue("ID").ToString();


                        DataTable dts = (DataTable)ViewState["DataTables"];
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
                grvptassignpro.DataSource = dt;
                grvptassignpro.DataBind();
                ListData();
                // grvcustomer.DataBind();
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);

            }
            catch (Exception ex)
            {

            }


        }

      
    }
}