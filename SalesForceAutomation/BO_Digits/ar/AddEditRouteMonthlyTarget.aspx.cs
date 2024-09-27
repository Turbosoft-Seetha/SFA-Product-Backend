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
    public partial class AddEditRouteMonthlyTarget : System.Web.UI.Page
    {
        GeneralFunctions ob = new GeneralFunctions();

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
                Route();


                var dt = DateTime.Parse(DateTime.Now.ToString("01-MM-yyyy"));
                var aPlusMonth = dt.AddMonths(1);
                radmonth.MinDate = aPlusMonth;




            }
        }

        public void Loaddata()
        {
            if (radmonth.SelectedDate != null && ddlrot.SelectedValue != null)
            {
                string mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] ar = { mnth };
                DataTable lstuser = default(DataTable);
                lstuser = ob.loadList("UnAssignedPackages", "sp_Target", ddlrot.SelectedValue.ToString(), ar);
                //if (lstdata.Rows.Count > 0)
                //{
                RadGrid1.DataSource = lstuser;


            }

        }
        public void List()
        {
            if (radmonth.SelectedDate != null && ddlrot.SelectedValue != null)
            {
                string mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
                string[] ar = { mnth };
                DataTable lstdata = default(DataTable);
                lstdata = ob.loadList("AssignedPackages", "sp_Target", ddlrot.SelectedValue.ToString(), ar);
                //if (lstdata.Rows.Count > 0)
                //{
                grvRpt.DataSource = lstdata;

                //}
            }
        }


        public void SaveData()
        {
            string Route, mnth;

            Route = ddlrot.SelectedValue.ToString();

            mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");


            // Status = ddlStat.SelectedValue.ToString();


            string Package = GetItemFromGrid();

            // string[] arr = { Target, StartDate, EndDate, Status };
            string[] arr = { mnth, Package };
            string Value = ob.SaveData("sp_Target", "InsertMonthlyTargets", Route, arr);
            int res = Int32.Parse(Value.ToString());
            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal('تم حفظ الهدف الشهري بنجاح');</script>", false);
            }
            else if (res == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Fail();</script>", false);

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

                    var ColelctionMarkets = RadGrid1.SelectedItems;
                    string cusIDs = "";
                    int i = 0;
                    int MarCount = ColelctionMarkets.Count;
                    if (ColelctionMarkets.Count > 0)
                    {
                        foreach (GridDataItem dr in ColelctionMarkets)
                        {
                            //where 1 = 1
                            string tph_ID = dr.GetDataKeyValue("tph_ID").ToString();
                            //string rot_ID = ddlrot.SelectedValue.ToString();
                            RadNumericTextBox Amnt = (RadNumericTextBox)dr.FindControl("txtAmount");
                            RadNumericTextBox Qty = (RadNumericTextBox)dr.FindControl("txtQty");
                            string Amount = Amnt.Text.ToString();
                            String Quantity = Qty.Text.ToString();
                            if (Amount.Equals("") || Quantity.Equals(""))
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>RequiredModal();</script>", false);

                            }
                            createNode(tph_ID, Amount, Quantity, writer);
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

        private void createNode(string tph_ID, string Amount, string Quantity, XmlWriter writer)
        {
            writer.WriteStartElement("Values");

            writer.WriteStartElement("tph_ID");
            writer.WriteString(tph_ID);
            writer.WriteEndElement();

            writer.WriteStartElement("Amount");
            writer.WriteString(Amount);
            writer.WriteEndElement();

            writer.WriteStartElement("Quantity");
            writer.WriteString(Quantity);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void Delete()
        {
            try
            {
                string rtpid = GetItemFromGrid2();
                DataTable lstData = new DataTable();
                string[] arr = { };
                string resp = ob.SaveData("sp_Target", "DeletePackage", rtpid.ToString(), arr);

                int res = Int32.Parse(resp);

                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteSuccess();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>DeleteFailed('بعض الحقول مفقودة ');</script>", false);
                }
            }
            catch (Exception ex)
            {

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
                    foreach (GridDataItem dr in grvRpt.SelectedItems)
                    {

                        string utp_ID = dr.GetDataKeyValue("utp_ID").ToString();

                        createNode2(utp_ID, writer);
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
        private void createNode2(string utp_ID, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("utp_ID");
            writer.WriteString(utp_ID);
            writer.WriteEndElement();

            writer.WriteEndElement();
        }

        public void Route()
        {
            DataTable dt = ob.loadList("SelectRouteForTarget", "sp_Target");
            ddlrot.DataSource = dt;
            ddlrot.DataTextField = "rot_Name";
            ddlrot.DataValueField = "rot_ID";
            ddlrot.DataBind();
        }
        //public void Target()
        //{
        //    DataTable dt = ob.loadList("SelectTarget", "sp_Target");
        //    ddlTarget.DataSource = dt;
        //    ddlTarget.DataTextField = "tph_Name";
        //    ddlTarget.DataValueField = "tph_ID";
        //    ddlTarget.DataBind();
        //}

        protected void radmonth_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            string mnth = DateTime.Parse(radmonth.SelectedDate.ToString()).ToString("yyyyMMdd");
            string[] arr = { mnth };
            DataTable lstdata = ob.loadList("selPackageWorkingDays", "sp_Target", ddlrot.SelectedValue.ToString(), arr);
            try
            {

                if (lstdata.Rows.Count > 0)
                {
                    string Route = lstdata.Rows[0]["rmd_WorkingDays"].ToString();
                    txtworkdays.Text = Route.ToString();
                }
                else
                {
                    txtworkdays.Text = "";
                    Loaddata();
                    List();


                }
            }
            catch (Exception ex)
            {


            }
        }

        protected void ViewPackageFilter_Click(object sender, EventArgs e)
        {
            if (txtworkdays.Text.Equals(""))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals('لم يتم تحديد أيام عمل لهذا الشهر.');</script>", false);

            }
            else
            {
                UnassignedPackage.Visible = true;
                AssignedPackage.Visible = true;

                List();
                Loaddata();
                grvRpt.Rebind();
                RadGrid1.Rebind();
            }

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Loaddata();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            List();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {

                SaveData();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else
            {
                Delete();
            }

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            List();
            Loaddata();
            grvRpt.Rebind();
            RadGrid1.Rebind();
        }

        protected void lnkAddQuestion_Click(object sender, EventArgs e)
        {
            int addCount = Int32.Parse(RadGrid1.SelectedItems.Count.ToString());
            if (addCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals('يرجى التحديد والمحاولة مرة أخرى.');</script>", false);
            }
            else
            {
                if (txtworkdays.Text.Equals(""))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals('لم يتم تحديد أيام عمل لهذا الشهر.');</script>", false);

                }
                else
                {
                    GetItemFromGrid();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
                }
            }

        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            int removeCount = Int32.Parse(grvRpt.SelectedItems.Count.ToString());
            if (removeCount == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModals('يرجى التحديد والمحاولة مرة أخرى.');</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);

            }

        }
    }
}