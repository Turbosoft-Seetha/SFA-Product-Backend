using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


namespace SalesForceAutomation.BO_Digits.ar
{
    public partial class ListSurveyDetail : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["Id"], out ResponseID);

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
            lstDatas = ObjclsFrms.loadList("SelectSurveyHeader", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                RadPanelItem rp = RadPanelBar0.Items[0];
                Label lblCustomer = (Label)rp.FindControl("lblCustomer");
                Label lblAppUser = (Label)rp.FindControl("lblAppUser");
                Label lblCreatedDate = (Label)rp.FindControl("lblCreatedDate");
                Label lblTime = (Label)rp.FindControl("lblTime");
                Label lblStartTime = (Label)rp.FindControl("lblStartTime");
                Label lblEndTime = (Label)rp.FindControl("lblEndTime");
                Label lblSGeoLoc = (Label)rp.FindControl("lblSGeoLoc");
                Label lblEndGeoLoc = (Label)rp.FindControl("lblEndGeoLoc");

                lblCustomer.Text = lstDatas.Rows[0]["cus_NameArabic"].ToString();
                lblAppUser.Text = lstDatas.Rows[0]["usr_ArabicName"].ToString();
                lblCreatedDate.Text = lstDatas.Rows[0]["dph_Date"].ToString();
                lblTime.Text = lstDatas.Rows[0]["dph_Time"].ToString();
                //lblStartTime.Text = lstDatas.Rows[0]["cse_StartTime"].ToString();
                //lblEndTime.Text = lstDatas.Rows[0]["cse_EndTime"].ToString();
                //lblSGeoLoc.Text = lstDatas.Rows[0]["cse_StartGeoCode"].ToString();
                //lblEndGeoLoc.Text = lstDatas.Rows[0]["cse_EndGeoCode"].ToString();
            }
        }

        public void ListData()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("SelectSurveyDetail", "sp_Merchandising", ResponseID.ToString());
            if (lstUser.Rows.Count > 0)
            {
                grvRpt.DataSource = lstUser;

            }
        }
        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void grvRpt_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem dataItem = (GridDataItem)e.Item;

                if (dataItem["qst_Name"].Text == "Image")
                {
                    string imah = dataItem["srd_Answer"].Text.ToString();
                    string[] values = imah.Split(',');
                    imah = imah.Replace("&nbsp;", null);
                    for (int i = 0; i < values.Length; i++)
                    {
                        if (!values[i].Equals("&nbsp;") && !values[i].Equals(""))
                        {
                            Image img = new Image();
                            img.ID = "Image1" + i.ToString();
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

                    dataItem["Images"].Text = dataItem["srd_Answer"].Text.ToString();

                }
            }
        }
    }
}