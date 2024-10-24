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

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class VanToVanHeader : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    if (Session["VanDate"] != null)
                    {
                        rdFromDate.SelectedDate = DateTime.Parse(Session["VanDate"].ToString());
                       
                    }
                    else
                    {
                        rdFromDate.SelectedDate = DateTime.Now;
                       
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }

                rdFromDate.MaxDate = DateTime.Now;

                TransOutRoute();
               // TransOutRouteFilter();
                TransInRoute();
               // TransInRouteFilter();
            }
        }
        public void TransOutRouteFilter()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in TrnsOutRot.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public void TransInRouteFilter()
        {
            int j = 1;
            foreach (RadComboBoxItem itmss in TrnsInRot.Items)
            {
                itmss.Checked = true;
                j++;
            }
        }
        public string OutRot()
        {
            var ColelctionMarket = TrnsOutRot.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "vvh_FromRot";
            }
        }
        public string InRot()
        {
            var ColelctionMarket = TrnsInRot.CheckedItems;
            string rotID = "";
            int j = 0;
            int MarCount = ColelctionMarket.Count;
            if (ColelctionMarket.Count > 0)
            {
                foreach (var item in ColelctionMarket)
                {
                    //where 1 = 1 
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
                return "vvh_ToRot";
            }
        }

        public void TransOutRoute()
        {
            
            TrnsOutRot.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            TrnsOutRot.DataTextField = "rot_Name";
            TrnsOutRot.DataValueField = "rot_ID";
            TrnsOutRot.DataBind();
        }

        public void TransInRoute()
        {
            
            TrnsInRot.DataSource = ObjclsFrms.loadList("SelectRouteforTransaction", "sp_Masters", UICommon.GetCurrentUserID().ToString());
            TrnsInRot.DataTextField = "rot_Name";
            TrnsInRot.DataValueField = "rot_ID";
            TrnsInRot.DataBind();
        }
        public void LoadList()
        {
            string dat, trnsoutRot, trnsinRot;
            DataTable lstUser = default(DataTable);
            dat = DateTime.Parse(rdFromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            trnsoutRot = OutRot();
            trnsinRot = InRot();
            string Datecondition = " (format( A.CreatedDate,'yyyyMMdd')=cast('" + dat + "' as date))";
            string RouteCondition = " and vvh_FromRot in(" + trnsoutRot + ") and vvh_ToRot in(" + trnsinRot + ")";
            string mainCondition = Datecondition + RouteCondition;
            string[] ar = { mainCondition };
            lstUser = ObjclsFrms.loadList("SelVanToVanHeader", "sp_Transaction",  mainCondition);
            
            grvRpt.DataSource = lstUser;


        }
        protected void Filter_Click(object sender, EventArgs e)
        {
            LoadList();
            grvRpt.Rebind();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("vvh_ID").ToString();
                Response.Redirect("VanToVanDetail.aspx?VVH=" + ID );
            }
            if (e.CommandName.Equals("WorkFlow"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("vvh_ID").ToString();
                Response.Redirect("VanToVanWorkFlow.aspx?ID=" + ID );
            }
        }

        protected void TrnsOutRot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void TrnsInRot_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
    }
}