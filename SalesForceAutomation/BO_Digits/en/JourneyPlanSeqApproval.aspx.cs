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
    public partial class JourneyPlanSeqApproval : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["JPStatus"] == null)
                {
                    Session["JPStatus"] = "";
                }
                else
                {
                    rdStatus.SelectedValue = Session["JPStatus"].ToString();
                }
               
            }
        }
        public void ListData()
        {
            string status = Session["JPStatus"].ToString();
            string statusCondition = "";
            if (status.Equals(""))
            {
                statusCondition = " isnull(A.Status,'P') in ('P') ";
            }
            else
            {
                statusCondition = " A.Status in ('" + status + "')";
            }

            DataTable lstuser = new DataTable();
            lstuser = obj.loadList("SelJPSeqApprovalRequests", "sp_JourneyPlanRequest", statusCondition);
            grvRpt.DataSource = lstuser;
        }
        protected void lnkReject_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Reject();</script>", false);

            }

        }

        protected void lnkApprove_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);

            }
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            ListData();
        }

        protected void save_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = obj.SaveData("sp_JourneyPlanRequest", "ApproveJPSeqRequest", Req, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Approved Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
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

                    var ColelctionMarkets = grvRpt.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string jps_ID = dr.GetDataKeyValue("jps_ID").ToString();
                          
                            createNode(jps_ID,  writer);
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

        private void createNode(string jps_ID,  XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("jps_ID");
            writer.WriteString(jps_ID);
            writer.WriteEndElement();

          


            writer.WriteEndElement();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("JourneyPlanSeqApproval.aspx");

        }



        protected void btnRejectSave_Click(object sender, EventArgs e)
        {
            string user = UICommon.GetCurrentUserID().ToString();

            string Req = GetItemFromGrid();


            string[] arr = { user };
            string Value = obj.SaveData("sp_JourneyPlanRequest", "RejectJPSeqRequest", Req, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('Rejected Successfully');</script>", false);
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            Session["JPStatus"] = rdStatus.SelectedValue.ToString();
            ListData();
            grvRpt.Rebind();
        }

        protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    string status = item["Status"].Text;
                                    
                    Telerik.Web.UI.GridClientSelectColumn chkAllColumn = (Telerik.Web.UI.GridClientSelectColumn)item.OwnerTableView.GetColumn("chkAll");
                    LinkButton lnkApprove = (LinkButton)rdd.FindControl("lnkApprove");
                    LinkButton lnkReject = (LinkButton)rdd.FindControl("lnkReject");

                    if (status == "Pending")
                    {
                        chkAllColumn.Visible = true;
                        lnkApprove.Visible = true;
                        lnkReject.Visible= true;
                    }
                    else
                    {
                        chkAllColumn.Visible = false;
                        lnkApprove.Visible = false;
                        lnkReject.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                
            }

        }

        protected void rdStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (rdStatus.SelectedValue == "P")
            {
                lnkApprove.Visible = true;
                lnkReject.Visible = true;
            }
            else
            {
                lnkApprove.Visible = false;
                lnkReject.Visible = false;
            }
        }
    }
}