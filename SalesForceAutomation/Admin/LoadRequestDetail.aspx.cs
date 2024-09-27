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
    public partial class LoadRequestDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["id"], out ResponseID);
                return ResponseID;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                HeaderData();
            }
        }
        public void HeaderData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("selLoadRequestHeaderById", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblRot = (Label)rp.FindControl("lblRot");
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRQDate = (Label)rp.FindControl("lblRQDate");



                rp.Text = "Request No: " + lstDatas.Rows[0]["lrh_Number"].ToString();
                lblRot.Text = lstDatas.Rows[0]["rot_Name"].ToString();
                lblUser.Text = lstDatas.Rows[0]["usr_Name"].ToString();
                lblRQDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                ViewState["rotid"] = lstDatas.Rows[0]["lrh_rot_ID"].ToString();
                ViewState["usr"] = lstDatas.Rows[0]["lrh_usr_ID"].ToString();



            }
        }
        public void LoadData()
        {
            DataTable lstDatas = new DataTable();
            lstDatas = ObjclsFrms.loadList("selLoadRequestDetail", "sp_InventoryTransaction", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                ViewState["prdid"] = lstDatas.Rows[0]["lrd_prd_ID"].ToString();
                ViewState["Hqty"] = lstDatas.Rows[0]["lrd_HQty"].ToString();
                ViewState["Lqty"] = lstDatas.Rows[0]["lrd_LQty"].ToString();
                ViewState["LUOM"] = lstDatas.Rows[0]["lrd_LUOM"].ToString();
                ViewState["HUOM"] = lstDatas.Rows[0]["lrd_HUOM"].ToString();
                ViewState["totalQty"] = lstDatas.Rows[0]["lrd_totalQty"].ToString();
                ViewState["apv_HQty"] = lstDatas.Rows[0]["lrd_apv_HQty"].ToString();
                ViewState["apv_LQty"] = lstDatas.Rows[0]["lrd_apv_LQty"].ToString();
                ViewState["apv_HUOM"] = lstDatas.Rows[0]["lrd_apv_HUOM"].ToString();
                ViewState["apv_LUOM"] = lstDatas.Rows[0]["lrd_apv_LUOM"].ToString();
                ViewState["apv_totalQty"] = lstDatas.Rows[0]["lrd_apv_totalQty"].ToString();

            }
            grvRpt.DataSource = lstDatas;


        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

       

        protected void lnkReject_Click(object sender, EventArgs e)
        {

        }
        public void Approve()
        {
            DataTable lstData = new DataTable();
            string rtid = ViewState["rotid"].ToString();
            string user = ViewState["usr"].ToString();
            string prdid = ViewState["prdid"].ToString();
            string Hqty = ViewState["Hqty"].ToString();
            string Lqty = ViewState["Lqty"].ToString();
            string LUOM = ViewState["LUOM"].ToString();
            string HUOM = ViewState["HUOM"].ToString();
            string totqty = ViewState["totalQty"].ToString();
            string apvHqty = ViewState["apv_HQty"].ToString();
            string apvLQty = ViewState["apv_LQty"].ToString();
            string apvHUOM = ViewState["apv_HUOM"].ToString();
            string apvLUOM = ViewState["apv_LUOM"].ToString();
            string apvtotQty = ViewState["apv_totalQty"].ToString();


            string[] arr = { rtid, user, prdid, Hqty, Lqty,LUOM,HUOM,totqty,apvHqty,apvLQty,apvHUOM,apvLUOM,apvtotQty };
            lstData = ObjclsFrms.loadList("UpdateLoadReqDetail", "sp_InventoryTransaction", ResponseID.ToString(), arr);
            int res = Int32.Parse(lstData.Rows[0]["Res"].ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Succcess();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Failure();</script>", false);
            }
            
        }

        protected void Approvenow_Click(object sender, EventArgs e)
        {
            Approve();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/LoadRequestHeader.aspx");
        }

        protected void lnkApprove_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
            //Approve();

        }
        //public string GetItemFromGrid()
        //{
        //    using (var sw = new StringWriter())
        //    {
        //        using (var writer = XmlWriter.Create(sw))
        //        {

        //            writer.WriteStartDocument(true);
        //            writer.WriteStartElement("r");
        //            int c = 0;
        //            DataTable dsc = new DataTable();
        //            foreach (GridDataItem dr in grvRpt.SelectedItems)
        //            {

        //                string oddID = dr.GetDataKeyValue("odd_ID").ToString();
        //                string remarks = rdRemarks.Text.Trim().ToString();
        //                if (qty > 0)
        //                {
        //                    ViewState["RemarsCount"] = 1;
        //                }
        //                createNode(oddID, qtyVal, remarks, writer);
        //                c++;
        //            }
        //            writer.WriteEndElement();
        //            writer.WriteEndDocument();
        //            writer.Close();

        //        }



        //        if (c == 0)
        //            {

        //                return null;
        //            }
        //            else
        //            {
        //                string ss = sw.ToString();
        //                return sw.ToString();
        //            }
        //        }
        //    }
        //}

        //private void createNode(string Answer, string Order, string Status, XmlWriter writer)
        //{
        //    writer.WriteStartElement("Values");
        //    writer.WriteStartElement("Answer");
        //    writer.WriteString(Answer);
        //    writer.WriteEndElement();
        //    writer.WriteStartElement("Order");
        //    writer.WriteString(Order);
        //    writer.WriteEndElement();
        //    writer.WriteStartElement("Status");
        //    writer.WriteString(Status);
        //    writer.WriteEndElement();
        //    writer.WriteEndElement();
        //}

    }
}