using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SalesForceAutomation.Admin
{
    public partial class LoadRequestHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rdfromDate.SelectedDate = DateTime.Parse(DateTime.Now.ToString("MMM-yyyy"));
                rdendDate.SelectedDate = DateTime.Now;
                Route();
                int j = 1;
                foreach (RadComboBoxItem itmss in rdRoute.Items)
                {
                    itmss.Checked = true;
                    j++;
                }
                string rotID = Rot();
                //string routeCondition = " rcs_rot_ID in (" + rotID + ")";
                //Customers(routeCondition);
                //int i = 1;
                //foreach (RadComboBoxItem cusitmss in rdCustomer.Items)
                //{
                //    cusitmss.Checked = true;
                //    i++;
                //}
            }
        }
       
        public void LoadData()
        {
            string rotID = Rot();
            if (!rotID.Equals("0"))
            {
                string mainCondition = "";
                mainCondition = mainConditions(rotID);
                DataTable lstDatas = new DataTable();
                lstDatas = ObjclsFrms.loadList("selLoadRequestHeader", "sp_Merchandising", mainCondition);
                grvRpt.DataSource = lstDatas;
            }

        }
        public string mainConditions(string rotID)
        {
            //string cusID = Cus();
            //string customerCondition = "";
            string dateCondition = "";
            string mainCondition = " and udp_rot_ID in (" + rotID + ")";
            try
            {
                string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                string endDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
                dateCondition = " and (cast(L.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + endDate + "' as date))";
                //if (cusID.Equals("0"))
                //{
                //    customerCondition = "";
                //}
                //else
                //{
                //    customerCondition = " and udp_cus_ID in (" + cusID + ")";
                //}
            }
            catch (Exception ex)
            {

            }
            mainCondition += dateCondition;
            //mainCondition += customerCondition;
            return mainCondition;
        }
        public void Route()
        {
            rdRoute.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters");
            rdRoute.DataTextField = "rot_Name";
            rdRoute.DataValueField = "rot_ID";
            rdRoute.DataBind();
        }
        //public void Customers(string routeCondition)
        //{

        //    rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomerforTransaction", "sp_Masters", routeCondition);
        //    rdCustomer.DataTextField = "cus_Name";
        //    rdCustomer.DataValueField = "cus_ID";
        //    rdCustomer.DataBind();
        //}
        //public string Cus()
        //{
        //    var CollectionMarket = rdCustomer.CheckedItems;
        //    string cusID = "";
        //    int j = 0;
        //    int MarCount = CollectionMarket.Count;
        //    if (CollectionMarket.Count > 0)
        //    {
        //        foreach (var item in CollectionMarket)
        //        {
        //            if (j == 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            else if (j > 0)
        //            {
        //                cusID += item.Value + ",";
        //            }
        //            if (j == (MarCount - 1))
        //            {
        //                cusID += item.Value;
        //            }
        //            j++;
        //        }
        //        return cusID;
        //    }
        //    else
        //    {
        //        return "0";
        //    }

        //}
        public string Rot()
        {
            var CollectionMarket = rdRoute.CheckedItems;
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
                return "0";
            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("lrh_ID").ToString();
                Response.Redirect("LoadRequestDetail.aspx?Id=" + ID);
            }
        }

        protected void rdRoute_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string rotID = Rot();
            //string routeCondition = " rcs_rot_ID in (" + rotID + ")";
            //Customers(routeCondition);
        }

       

        protected void Filter_Click(object sender, EventArgs e)
        {
            LoadData();
            grvRpt.Rebind();
        }
    }
}