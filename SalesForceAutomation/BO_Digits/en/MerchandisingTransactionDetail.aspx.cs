using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Documents.SpreadsheetStreaming;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class MerchandisingTransactionDetail : System.Web.UI.Page
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
        public int HID
        {
            get
            {
                int HID;
                int.TryParse(Request.Params["HID"], out HID);
                return HID;
            }
        }
        public int cse
        {
            get
            {
                int cse;
                int.TryParse(Request.Params["CseID"], out cse);
                return cse;
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
            lstDatas = ObjclsFrms.loadList("SelUsrDlyPrcsHeaderByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblUser = (Label)rp.FindControl("lblUser");
                Label lblRoute = (Label)rp.FindControl("lblRoute");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblVersion = (Label)rp.FindControl("lblVersion");
                //rp.Text = "Order ID: " + lstDatas.Rows[0]["OrderID"].ToString();
                lblUser.Text = lstDatas.Rows[0]["userName"].ToString();
                lblRoute.Text = lstDatas.Rows[0]["routeName"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["CreatedDate"].ToString();
                //lblStartTime.Text = lstDatas.Rows[0]["StartTime"].ToString();
                //lblEndTime.Text = lstDatas.Rows[0]["EndTime"].ToString();
                lblVersion.Text = lstDatas.Rows[0]["udp_VersionNumber"].ToString();
            }
        }
        public void GetData()
        {
            string mode = Request.Params["Mode"].ToString();
           
            string proc = "";
            if (mode.Equals("IP"))
            {
                lblType.Text = "Item Pricing";
                proc = "SelUDItemPricingDetail";
               
            }
            else if (mode.Equals("IA"))
            {
                lblType.Text = "Item Availability";
                proc = "SelUDItemAvailabilityDetail";
               
            }
          
           

            else if (mode.Equals("AT"))
            {
                lblType.Text = "Asset Tracking";
                proc = "SelUDAssetTrackingDetail";
               
            }
            else if (mode.Equals("SR"))
            {
                lblType.Text = "Survey";
                proc = "SelUDSurveyDetail";
               
            }
          
            else if (mode.Equals("OS"))
            {
                lblType.Text = "OutofStock";
                proc = "SelUDOutofStockDetail";
               
            }

            else if (mode.Equals("CI"))
            {
                lblType.Text = "Customer Inventory";
                proc = "SelUDCustomerInventoryItem";
               
            }
            else if (mode.Equals("CSA"))
            {
                lblType.Text = "Customer Activities Detail";
                proc = "SelUDCustomerActivityDetail";

            }

            DataSet lstDatas = new DataSet();
            string[] arr = {  };
            lstDatas = ObjclsFrms.loadList(proc, "sp_Merchandising", HID.ToString(),arr,true);
            
            grvheader.DataSource = lstDatas.Tables[0];
            grvheader.DataBind();
            if (lstDatas.Tables.Count > 0)
            {
                grvRpt.DataSource = lstDatas.Tables[1];
            }
        }

        protected void grvheader_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            GetData();
        }

        protected void grvRpt_PreRender(object sender, EventArgs e)
        {
            RadGrid radgrid2 = (RadGrid)sender;

            radgrid2.MasterTableView.GetColumnSafe("id").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("Type").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("InitialImage").Visible = false;
            radgrid2.MasterTableView.GetColumnSafe("FinalImage").Visible = false;

            if (Request.Params["Mode"].ToString().Equals("IP"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images1").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images2").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("IA"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images1").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images2").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("AT"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Answer").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images1").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images2").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("SR"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Answer").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images1").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images2").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
            if (Request.Params["Mode"].ToString().Equals("OS"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
               
            }
            if (Request.Params["Mode"].ToString().Equals("CI"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images1").Visible = false;
                radgrid2.MasterTableView.GetColumnSafe("Images2").Visible = false;
               
            }
            if (Request.Params["Mode"].ToString().Equals("CSA"))
            {
                radgrid2.MasterTableView.GetColumnSafe("Images").Visible = false;
               
                radgrid2.MasterTableView.GetColumnSafe("detail").Visible = false;
            }
        }
        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Detail"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string id = dataItem.GetDataKeyValue("id").ToString();

                 Response.Redirect("MerchOthersTransactionDetails.aspx?id=" + ResponseID.ToString() + "&&Mode=" + Request.Params["Mode"].ToString() + "&&DID=" + id +"&&HID="+HID +"&&CseID="+ cse);
            }
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if ((Request.Params["Mode"].ToString().Equals("SR")) || (Request.Params["Mode"].ToString().Equals("AT")))
            {
                if (e.Item is GridDataItem)
                {

                    GridDataItem dataItem = (GridDataItem)e.Item;

                    if (dataItem["Type"].Text == "Image")
                    {
                        string imah = dataItem["Answer"].Text.ToString();
                        string[] values = imah.Split(',');
                        imah = imah.Replace("&nbsp;", null);
                        for (int i = 0; i < values.Length; i++)
                        {
                            if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                            {
                                Image img = new Image();
                                img.ID = "Image3" + i.ToString();
                                img.ImageUrl = "../" + values[i].ToString();
                                img.Height = 50;
                                img.Width = 50;
                                img.BorderStyle = BorderStyle.Groove;
                                img.BorderWidth = 2;
                                img.BorderColor = System.Drawing.Color.Black;
                                HyperLink hl = new HyperLink();
                                hl.NavigateUrl = "../" + values[i].ToString();
                                hl.ID = "hl" + i.ToString();
                                hl.Target = "_blank";
                                hl.Controls.Add(img);

                                dataItem["Images"].Controls.Add(hl);

                            }
                        }
                    }
                    else
                    {

                        dataItem["Images"].Text = dataItem["Answer"].Text.ToString();

                    }
                }
            }
            else if ((Request.Params["Mode"].ToString().Equals("OS")) || (Request.Params["Mode"].ToString().Equals("CSA")))
            {
                if (e.Item is GridDataItem)
                {

                    GridDataItem dataItem = (GridDataItem)e.Item;
                    string imah1 = dataItem["InitialImage"].Text.ToString();
                    string imah2 = dataItem["FinalImage"].Text.ToString();

                    string[] values = imah1.Split(',');
                    string[] values2 = imah2.Split(',');

                    imah1 = imah1.Replace("&nbsp;", null);
                    imah2 = imah2.Replace("&nbsp;", null);
                    for (int i = 0; i < values.Length; i++)
                    {
                        if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                        {
                            Image img1 = new Image();
                            img1.ID = "Image1" + i.ToString();
                            img1.ImageUrl = "../" + values[i].ToString();
                            img1.Height = 20;
                            img1.Width = 20;
                            img1.BorderStyle = BorderStyle.Groove;
                            img1.BorderWidth = 2;
                            img1.BorderColor = System.Drawing.Color.Black;
                            HyperLink hl = new HyperLink();
                            hl.NavigateUrl = "../" + values[i].ToString();
                            hl.ID = "hl" + i.ToString();
                            hl.Target = "_blank";
                            hl.Controls.Add(img1);

                            dataItem["Images1"].Controls.Add(hl);
                        }
                    }
                    for (int i = 0; i < values2.Length; i++)
                    {
                        if (!values2[i].Equals("&nbsp;") && !values2[i].Equals(""))
                        {
                            Image img2 = new Image();
                            img2.ID = "Image2" + i.ToString();
                            img2.ImageUrl = "../" + values2[i].ToString();
                            img2.Height = 20;
                            img2.Width = 20;
                            img2.BorderStyle = BorderStyle.Groove;
                            img2.BorderWidth = 2;
                            img2.BorderColor = System.Drawing.Color.Black;
                            HyperLink hll = new HyperLink();
                            hll.NavigateUrl = "../" + values2[i].ToString();
                            hll.ID = "hll" + i.ToString();
                            hll.Target = "_blank";
                            hll.Controls.Add(img2);

                            dataItem["Images2"].Controls.Add(hll);
                        }
                    }
                    //dataItem["mei_Images"].Text = imah.Replace("../", "http://93.177.125.68/");
                }
            }
        }
    }
}