using DocumentFormat.OpenXml.Math;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class InventoryDashboard : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string fromDate, ToDate;
                rdfromDate.SelectedDate = DateTime.Now;
                rdendDate.SelectedDate = DateTime.Now;
                fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
                Session["InvToDate"] = rdendDate.SelectedDate.ToString();

                Picking();
                PickingChecking();
                GoodsReceiving();
                GRNChecking();
                StockCounting();
                StockCountChecking();
                Warehouse();
                WarehousePicking();
                WarehouseGoodsReceiving();
                TransferOut();
                TransferIn();
            }
        }
        public DataTable LoadData(string mode)
        {
            Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
            Session["InvToDate"] = rdendDate.SelectedDate.ToString();
            string[] arr = new string[] { DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyy-MM-dd") };
            DataTable dt = ObjclsFrms.loadList(mode, "sp_InventoryDashboard", DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyy-MM-dd"), arr);
            return dt;

        }
        public void Picking()
        {
            DataTable dt = LoadData("SelPickingCount");
            if (dt.Rows.Count > 0)
            {
                string Pending, Ongoing, Parked, Completed, TotalPicking;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();
                TotalPicking = dt.Rows[0]["TotalPicking"].ToString();

                lblPickPending.Text = Pending.ToString();
                lblPickOngoing.Text = Ongoing.ToString();
                lblPickParked.Text = Parked.ToString();
                //lblPickCompleted.Text = Completed.ToString();
                lblTotalPicking.Text = TotalPicking.ToString();
            }
           
        }
        public void GoodsReceiving()
        {
            DataTable dt = LoadData("SelGoodsReceivingCount");
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing, Completed, TotalGoodsReceiving;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();
                TotalGoodsReceiving = dt.Rows[0]["TotalGoodsReceiving"].ToString();

                lblGRPending.Text = Pending.ToString();
                lblGROngoing.Text = Ongoing.ToString();
                //lblGRCompleted.Text = Completed.ToString();
                lblGRTotal.Text = TotalGoodsReceiving.ToString();
                lblGRParked.Text = Parked.ToString();
            }
        }
        public void StockCounting()
        {
            DataTable dt = LoadData("SelStockCountingCount");
            if (dt.Rows.Count > 0)
            {
                string Pending, Ongoing, Parked, Completed, Scheduled, Instant;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();

                Scheduled = dt.Rows[0]["Scheduled"].ToString();
                Instant = dt.Rows[0]["Instant"].ToString();

                lblSCPending.Text = Pending.ToString();
                lblSCOngoing.Text = Ongoing.ToString();
                lblSCParked.Text = Parked.ToString();
                //lblSCCompleted.Text = Completed.ToString();

                lblScheduled.Text = Scheduled.ToString();
                lblInstant.Text = Instant.ToString();
            }
        }
        public void Warehouse()
        {
            DataTable dt = LoadData("SelWarehouseCount");
            string Pending,Completed, Total;
            Pending = dt.Rows[0]["Pending"].ToString();
            Completed = dt.Rows[0]["Completed"].ToString();
            Total = dt.Rows[0]["Total"].ToString();

            //lblWTPending.Text = Pending.ToString();
            //lblWTCompleted.Text = Completed.ToString();
            //lblWTTotal.Text = Total.ToString();
        }
        public void WarehousePicking()
        {
            DataTable dt = LoadData("SelWarehousePicking");
            string Pending, Ongoing, Parked, Completed, TotalPicking;
            Pending = dt.Rows[0]["Pending"].ToString();
            Ongoing = dt.Rows[0]["Ongoing"].ToString();
            Parked = dt.Rows[0]["Parked"].ToString();
            Completed = dt.Rows[0]["Completed"].ToString();
            TotalPicking = dt.Rows[0]["TotalPicking"].ToString();

            //lblWTPickPending.Text = Pending.ToString();
            //lblWTPickOngoing.Text = Ongoing.ToString();
            //lblWTPickParked.Text = Parked.ToString();
            //lblWTPickCompleted.Text = Completed.ToString();
            //lblWTPickTotal.Text = TotalPicking.ToString();
        }
        public void WarehouseGoodsReceiving()
        {
            DataTable dt = LoadData("SelWarehouseGoodsReceiving");
            string Pending, Ongoing, Parked, Completed, TotalGR;
            Pending = dt.Rows[0]["Pending"].ToString();
            Ongoing = dt.Rows[0]["Ongoing"].ToString();
            Parked = dt.Rows[0]["Parked"].ToString();
            Completed = dt.Rows[0]["Completed"].ToString();
            TotalGR = dt.Rows[0]["TotalGoodsReceiving"].ToString();

            //lblWT_GRPending.Text = Pending.ToString();
            //lblWT_GROngoing.Text = Ongoing.ToString();
            //lblWT_GRParked.Text = Parked.ToString();
            //lblWT_GRCompleted.Text = Completed.ToString();
            //lblWT_GRTotal.Text = TotalGR.ToString();
        }

        public void TransferOut()
        {
            DataTable dt = LoadData("SelTransferOut");
            string TransferOutCount, TotalTransferOut;
            TransferOutCount = dt.Rows[0]["Count"].ToString();
            TotalTransferOut = dt.Rows[0]["TotalCount"].ToString();

            //lblTransferOutCount.Text = TransferOutCount.ToString();
            //lblTotalTransferOut.Text = TotalTransferOut.ToString();
           
        }
        public void TransferIn()
        {
            DataTable dt = LoadData("SelTransferIn");
            string TransferInCount, TotalTransferIn;
            TransferInCount = dt.Rows[0]["Count"].ToString();
            TotalTransferIn = dt.Rows[0]["TotalCount"].ToString();

            //lblTransferInCount.Text = TransferInCount.ToString();
            //lblTotalTransferIn.Text = TotalTransferIn.ToString();
        }
        public void PickingChecking()
        {
            DataTable dt = LoadData("SelPickingCheckingCount");
            if(dt.Rows.Count>0)
            {
                string Pending, Parked, Ongoing, Completed;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();


                lblchkpickpending.Text = Pending.ToString();
                lblchkpickongoing.Text = Ongoing.ToString();
                lblchkpickpark.Text = Parked.ToString();
                lblchkpickcomplete.Text = Completed.ToString();
            }
           
        }
        public void GRNChecking()
        {
            DataTable dt = LoadData("SelGoodsReceivingCheckingCount");
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing, Completed;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();


                lblchkreceivpending.Text = Pending.ToString();
                lblchkreveivOngoing.Text = Ongoing.ToString();
                lblchkreceivpark.Text = Parked.ToString();
                lblchkreceivcomplete.Text = Completed.ToString();
            }
           
        }
        public void StockCountChecking()
        {
            DataTable dt = LoadData("SelStockCountCheckingCount");
            if (dt.Rows.Count > 0)
            {
                string Pending, Parked, Ongoing, Completed;
                Pending = dt.Rows[0]["Pending"].ToString();
                Ongoing = dt.Rows[0]["Ongoing"].ToString();
                Completed = dt.Rows[0]["Completed"].ToString();
                Parked = dt.Rows[0]["Parked"].ToString();


                lblchkcountingpending.Text = Pending.ToString();
                lblchkcountingongoing.Text = Ongoing.ToString();
                lblchkcountingpark.Text = Parked.ToString();
                lblchkcountingcomplt.Text = Completed.ToString();
            }
        }
       

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            string fromDate, ToDate;
            //rdfromDate.SelectedDate = DateTime.Now;
            //rdendDate.SelectedDate = DateTime.Now;
            fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            ToDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
            Session["InvToDate"] = rdendDate.SelectedDate.ToString();

            Picking();
            PickingChecking();
            GoodsReceiving();
            GRNChecking();
            StockCounting();
            StockCountChecking();
            Warehouse();
            WarehousePicking();
            WarehouseGoodsReceiving();
            TransferOut();
            TransferIn();
        }

        protected void lblpicking_Click(object sender, EventArgs e)
        {
            Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
            Session["InvToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("PickingHeader.aspx?mode=1");
        }

        protected void lblReceiving_Click(object sender, EventArgs e)
        {
            Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
            Session["InvToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("GRNHeader.aspx?mode=1");
        }

        protected void lblStockCount_Click(object sender, EventArgs e)
        {
            Session["InvFromDate"] = rdfromDate.SelectedDate.ToString();
            Session["InvToDate"] = rdendDate.SelectedDate.ToString();
            Response.Redirect("StockCountingHeader.aspx?mode=1");
        }

        
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {

                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);

                if (difference.Days > 31)
                {

                    rdfromDate.SelectedDate = startdate;

                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {

                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);

                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;

                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }
    }
}