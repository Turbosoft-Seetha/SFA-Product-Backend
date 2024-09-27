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

namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class AddLoadIn : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
        public int RID
        {
            get
            {
                int RID;
                int.TryParse(Request.Params["RId"], out RID);

                return RID;
            }
        }
        public int LIH
        {
            get
            {
                int LIH;
                int.TryParse(Request.Params["LIH"], out LIH);

                return LIH;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Route();
                if (LIH == 0)
                {
                    ViewState["DataTable"] = null;
                    rdDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                    Product();
                }
                else
                {
                    ViewState["DataTable"] = Session["DataTable"];
                    ddlp.SelectedValue = RID.ToString();
                    rdDate.SelectedDate = DateTime.Parse(Session["Date"].ToString());
                    ddlp.Enabled = false;
                    rdDate.Enabled = false;
                    Product();
                }

            }
        }
        public void Route()
        {
            DataTable dt = Obj.loadList("SelectFromDropRouteID", "sp_Masters_UOM");
            ddlp.DataSource = dt;
            ddlp.DataTextField = "rot_Name";
            ddlp.DataValueField = "rot_ID";
            ddlp.DataBind();
        }

        public void Product()
        {
            string mainCondition = "";
            mainCondition = productCondition();

            DataTable dts = Obj.loadList("SelProductsFornewheader", "sp_Masters_UOM", mainCondition);
            ddlProduct.DataSource = dts;
            ddlProduct.DataTextField = "prd_Name";
            ddlProduct.DataValueField = "prd_ID";
            ddlProduct.DataBind();

        }
        public void HUOM(string prdct)
        {
            DataTable dq = Obj.loadList("SelectHighUomFromDrop", "sp_Masters_UOM", prdct);
            ddlHUom.DataSource = dq;
            ddlHUom.DataTextField = "uom_Name";
            ddlHUom.DataValueField = "uom_ID";
            ddlHUom.DataBind();
        }
        public void LUOM(string upc)
        {
            //string cat = ddlcatid.SelectedValue.ToString();
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable ds = Obj.loadList("SelectLowUomFromDrop", "sp_Masters_UOM", upc, arr);
            ddlLUom.DataSource = ds;
            if (ds.Rows.Count > 0)
            {
                ddlLUom.DataTextField = "uom_Name";
                ddlLUom.DataValueField = "uom_ID";
                ddlLUom.DataBind();
                ddlLUom.Enabled = true;
                txtLQty.Enabled = true;
            }
            else
            {
                ddlLUom.ClearSelection();
                ddlLUom.SelectedValue = "";
                txtLQty.Text = "";
                ddlLUom.Enabled = false;
                txtLQty.Enabled = false;
                lq.Visible = false;
            }
            ViewState["dd"] = ds;
        }
        public void UPCC()
        {
            string upc;
            string[] arr = { ddlProduct.SelectedValue.ToString() };
            DataTable dt2 = Obj.loadList("selectUPCforHUOM", "sp_Masters_UOM", ddlHUom.SelectedValue.ToString(), arr);
            if (dt2.Rows.Count > 0)
            {

                upc = dt2.Rows[0]["pru_UPC"].ToString();

                LUOM(upc);
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();

        }
        public void LoadData()
        {

            DataTable dt = (DataTable)ViewState["DataTable"];
            grvRpt.DataSource = dt;


        }
        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("ID").ToString();
                ViewState["delID"] = ID;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delConfim();</script>", false);
            }
        }

        protected void AddItem_Click(object sender, EventArgs e)
        {

            rdDate.Enabled = false;
            ddlp.Enabled = false;
            string hqty = txtHQty.Text.ToString();
            string luom = ddlLUom.SelectedValue.ToString();
            string Lqty = txtLQty.Text.ToString();
            if (hqty == "0")
            {
                qty.Visible = true;

                qty.Text = "<span style='color:red'>يجب أن تكون الكمية الأعلى أكبر من الصفر</span>";
                if (Lqty == "0")
                {
                    lq.Visible = true;
                }
                else
                {
                    lq.Visible = false;
                }
            }
            else
            {
                qty.Visible = false;
                if (luom == "")
                {
                    addTable();
                }
                else if (Lqty == "" || Lqty == "0")
                {
                    lq.Visible = true;

                    lq.Text = "<span style='color:red'>الرجاء إدخال كمية أقل</span>";

                }
                else
                {
                    addTable();
                }
            }


        }
        public void addTable()
        {
            string Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID;
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("Item");
                dts.Columns.Add("HigherQty");
                dts.Columns.Add("LowerQty");
                dts.Columns.Add("HigherUom");
                dts.Columns.Add("LowerUom");
                dts.Columns.Add("higheruomID");
                dts.Columns.Add("loweruomID");
            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }
            string ID;

            if (dts.Rows.Count > 0)
            {
                LowerUom = ddlLUom.SelectedValue.ToString();
                if (LowerUom == "")
                {
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = "-";
                    higheruomID = ddlHUom.SelectedValue.ToString();
                    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                    LowerUom = "-";
                    //higheruomID = ddlHUom.SelectedValue.ToString();
                    loweruomID = "-";

                }
                else
                {
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = txtLQty.Text.ToString();
                    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                    LowerUom = ddlLUom.SelectedItem.Text.ToString();
                    higheruomID = ddlHUom.SelectedValue.ToString();
                    loweruomID = ddlLUom.SelectedValue.ToString();

                }

                dts.Rows.Add(ID, Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID);
            }
            else
            {
                LowerUom = ddlLUom.SelectedValue.ToString();
                if (LowerUom == "")
                {
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = "-";
                    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                    LowerUom = "-";
                    higheruomID = ddlHUom.SelectedValue.ToString();
                    loweruomID = "-";

                }
                else
                {
                    ID = ddlProduct.SelectedValue.ToString();
                    Item = ddlProduct.SelectedItem.Text.ToString();
                    HigherQty = txtHQty.Text.ToString();
                    LowerQty = txtLQty.Text.ToString();
                    HigherUom = ddlHUom.SelectedItem.Text.ToString();
                    LowerUom = ddlLUom.SelectedItem.Text.ToString();
                    higheruomID = ddlHUom.SelectedValue.ToString();
                    loweruomID = ddlLUom.SelectedValue.ToString();
                }
                dts.Rows.Add(ID, Item, HigherQty, LowerQty, HigherUom, LowerUom, higheruomID, loweruomID);
            }
            ViewState["DataTable"] = dts;
            Session["DataTable"] = dts;
            Session["Date"] = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");
            grvRpt.DataSource = dts;
            grvRpt.DataBind();

            Response.Redirect("AddLoadIn.aspx?RId=" + ddlp.SelectedValue.ToString() + "&LIH=1" + "&" + Session["DataTable"] + "&" + Session["Date"]);


        }
        public string Item()
        {

            string PID = "";
            int j = 0;

            DataTable dsc = (DataTable)ViewState["DataTable"];

            if (dsc != null)
            {
                foreach (DataRow row in dsc.Rows)
                {
                    int MarCount = (dsc.Rows.Count);

                    string prd_ID = row["ID"].ToString();

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

            string ID = Item();
            string productCondition = "";
            string routeCondition = "";
            string rot = ddlp.SelectedValue.ToString();

            try
            {
                if (ID.Equals("0"))
                {
                    routeCondition = "and rop_rot_ID = (" + rot + ") ";
                    productCondition = " prd_ID not in (0)";
                }
                else
                {
                    routeCondition = "  and rop_rot_ID = (" + rot + ") ";
                    productCondition = " prd_ID not in (" + ID + ")";
                }
            }
            catch (Exception ex)
            {

            }

            productCondition += routeCondition;
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
                    DataTable dsc = (DataTable)ViewState["DataTable"];
                    foreach (DataRow row in dsc.Rows)
                    {
                        string ID = row["ID"].ToString();
                        string HigherQty = row["HigherQty"].ToString();
                        string LowerQty = row["LowerQty"].ToString();
                        string higheruomID = row["higheruomID"].ToString();
                        string loweruomID = row["loweruomID"].ToString();

                        //if (Mode.Equals("0"))
                        //{
                        createNode(ID, HigherQty, LowerQty, higheruomID, loweruomID, writer);
                        //}
                        c++;
                    }

                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();

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
        }

        private void createNode(string ID, string HigherQty, string LowerQty, string higheruomID, string loweruomID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("ID");
            writer.WriteString(ID);
            writer.WriteEndElement();
            writer.WriteStartElement("HigherQty");
            writer.WriteString(HigherQty);
            writer.WriteEndElement();
            writer.WriteStartElement("LowerQty");
            writer.WriteString(LowerQty);
            writer.WriteEndElement();
            writer.WriteStartElement("higheruomID");
            writer.WriteString(higheruomID);
            writer.WriteEndElement();
            writer.WriteStartElement("loweruomID");
            writer.WriteString(loweruomID);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        protected void lnkcancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListLoadInHeader.aspx");
        }

        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
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
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddLoadIn.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string user, Route, Date;
            Route = ddlp.SelectedValue.ToString();
            Date = DateTime.Parse(rdDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy");

            DataTable dsc = (DataTable)ViewState["DataTable"];
            if (dsc == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                    "tmp", "<script type='text/javascript'>failedModal('بالنسبة لهذا التحميل ، تعتبر العناصر إلزامية');</script>", false);
                return;
            }
            string detail = GetItemFromGrid();
            user = UICommon.GetCurrentUserID().ToString();


            //if (LIH == 0)
            //{

            string[] arr = { user, Date, detail };
            string Value = Obj.SaveData("sp_Masters_UOM", "InsertLoadInheader", Route, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('بعض الحقول مفقودة ');</script>", false);
            }
            //}
            //else
            //{

            //}
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListLoadInHeader.aspx");
        }

        protected void ddlp_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            Product();
            ddlProduct.Focus();

        }

        protected void ddlProduct_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            HUOM(ddlProduct.SelectedValue.ToString());
            ddlHUom.Focus();
        }

        protected void ddlHUom_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            UPCC();
            txtHQty.Focus();
        }

        protected void BtnConfrmDelete_Click(object sender, EventArgs e)
        {


            string ID = ViewState["delID"].ToString();
            DataTable dts = (DataTable)ViewState["DataTable"];
            for (int i = dts.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dts.Rows[i];
                string dd = dr["ID"].ToString();
                if (dr["ID"].Equals(ID))
                    dr.Delete();
            }
            dts.AcceptChanges();
            ViewState["DataTable"] = dts;
            int x = dts.Rows.Count;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();
            Product();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>delsuccessModal();</script>", false);
        }

        protected void delOk_Click(object sender, EventArgs e)
        {

            LoadData();
        }

        protected void txtHQty_TextChanged(object sender, EventArgs e)
        {
            ddlLUom.Focus();
        }

        protected void ddlLUom_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            txtLQty.Focus();
        }

        protected void rdDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            ddlp.Focus();
        }
    }
}