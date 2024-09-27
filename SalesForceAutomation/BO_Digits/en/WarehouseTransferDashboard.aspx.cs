using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class WarehouseTransferDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["ReqStore"] = "";
                MRLocations();
                int o = 1;
                foreach (RadComboBoxItem itmss in ddlMRLocation.Items)
                {
                    itmss.Checked = true;
                    o++;
                }
                MRL();
                selMRCreatedCounts();
                selWTPickingCounts();
                SelWTPickingCheckingCount();
                selWTReceivingCounts();
                selWTReceiveCheckCounts();
                selWTTransferOut();
                selWTTransferIn();

            }
        }
        public string MRL()
        {
            var CollectionMarket1 = ddlMRLocation.CheckedItems;
            string MRLID = "";
            int j = 0;
            int MarCount = CollectionMarket1.Count;
            if (CollectionMarket1.Count > 0)
            {
                foreach (var item in CollectionMarket1)
                {
                    if (j == 0)
                    {
                        MRLID += item.Value + ",";
                    }
                    else if (j > 0)
                    {
                        MRLID += item.Value + ",";
                    }
                    if (j == (MarCount - 1))
                    {
                        MRLID += item.Value;
                    }
                    j++;
                }
                return MRLID;
            }
            else
            {
                return "0";
            }
        }
        public DataTable LoadData(string mode, string store)
        {

            string maincondition = "";
            maincondition = store;
            DataTable dt = ObjclsFrms.loadList(mode, "sp_WTDashboard", maincondition);
            return dt;

        }
        public void selMRCreatedCounts()
        {   string mrl = MRL();
            string store;
            if(mrl.Equals("0"))
            {
                store = "'mrh_str_ID in(mrh_str_ID)'";
            }
            else
            {
                store = " mrh_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelMRCreatedCount", store);
            if(dt.Rows.Count>=0)
            {
                string MRCCount;
                MRCCount = dt.Rows[0]["MRCreated"].ToString();

                lblMRCreated.Text = MRCCount.ToString();
            }
            
           
        }
        public void selWTPickingCounts()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wph_str_ID in(wph_str_ID)'";
            }
            else
            {
                store = " wph_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelWTPickingCount",store);
            if (dt.Rows.Count > 0)
            { 
                string Pending, Parked, Ongoing;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();

                lblPickpending.Text = Pending.ToString();
                lblPickOngoing.Text = Ongoing.ToString();
                lblPickParked.Text = Parked.ToString();
        }
        }
        public void SelWTPickingCheckingCount()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wph_str_ID in(wph_str_ID)'";
            }
            else
            {
                store = " wph_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelWTPickingCheckingCount",store);
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();

                lblpickcheckpending.Text = Pending.ToString();
                lblpickcheckOngoing.Text = Ongoing.ToString();
                lblpickcheckpark.Text = Parked.ToString();
            }
        }
        public void selWTReceivingCounts()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wrh_str_ID in(wrh_str_ID)'";
            }
            else
            {
                store = " wrh_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelWTReceiving",store);
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();

                lblrcvpending.Text = Pending.ToString();
                lblrcvOngoing.Text = Ongoing.ToString();
                lblrcvparked.Text = Parked.ToString();
            }
        }
        public void selWTReceiveCheckCounts()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wrh_str_ID in(wrh_str_ID)'";
            }
            else
            {
                store = " wrh_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelWTReceivingCheckingCount",store);
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing, Completed;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();

                lblrcvcheckpending.Text = Pending.ToString();
                lblrcvcheckongoing.Text = Ongoing.ToString();
                lblrcvcheckparked.Text = Parked.ToString();
                lblrcvchkcompleted.Text = Completed.ToString(); 
            }
        }
        public void selWTTransferOut()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wtt_str_ID in(wtt_str_ID)'";
            }
            else
            {
                store = " wtt_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelTransferOutPendingCount", store);
            if (dt.Rows.Count > 0)
            {
                string Pending;
                Pending = dt.Rows[0]["pending"].ToString();
                lblTransOutPending.Text = Pending.ToString();
                
            }
        }
        public void selWTTransferIn()
        {
            string mrl = MRL();
            string store;
            if (mrl.Equals("0"))
            {
                store = "'wti_str_ID in(wti_str_ID)'";
            }
            else
            {
                store = " wti_str_ID in (" + mrl + ")";
            }
            DataTable dt = LoadData("SelTransferInPendingCount", store);
            if (dt.Rows.Count > 0)
            {
                string Pending;
                Pending = dt.Rows[0]["pending"].ToString();
                lblTransInPending.Text = Pending.ToString();

            }
        }

        public void MRLocations()
        {
            DataTable dt = ObjclsFrms.loadList("SelMRLocations", "sp_WTDashboard");
            ddlMRLocation.DataSource = dt;
            ddlMRLocation.DataTextField = "str_Name";
            ddlMRLocation.DataValueField = "mrh_str_ID";
            ddlMRLocation.DataBind();
        }
        protected void ddlMRLocation_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["ReqStore"] = MRL();
            selMRCreatedCounts();
            selWTPickingCounts();
            SelWTPickingCheckingCount();
            selWTReceivingCounts();
            selWTReceiveCheckCounts();
            selWTTransferOut();
            selWTTransferIn();
        }

        protected void lnkMRCreated_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListMaterialReq.aspx?Mode=DB");
        }

        //protected void lblPicking_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("WarehousePickingHeader.aspx");
        //}

        protected void lblTransferIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("WHTransferInApproval.aspx?Mode=DB");
        }

        protected void lblTransferOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("WHTransferOutApproval.aspx?Mode=DB");
        }

        //protected void lblWTReceiving_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("WarehouseReceivingHeader.aspx");
        //}

        protected void lblrcvchkcomplete_Click(object sender, EventArgs e)
        {
            Response.Redirect("WarehouseReceivingHeader.aspx?Mode=DBRC");
        }
    }
}