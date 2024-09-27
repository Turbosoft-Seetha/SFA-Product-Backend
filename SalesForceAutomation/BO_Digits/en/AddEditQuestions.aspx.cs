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
    public partial class AddEditQuestions : System.Web.UI.Page
    {
        GeneralFunctions Obj = new GeneralFunctions();
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
                ViewState["DataTable"] = null;

                //Session["Count"] = 0;
                Route();
                fillForm();
                PanelVisibility();
                if(ResponseID == 0 )
                {
                    qtn.Visible = false;
                }
                else
                {
                    qtn.Visible = true;
                }
            }
        }
        protected void fillForm()
        {


            if (ResponseID == 0)
            {
                Route();
                txtType.Enabled = true;
                labelqno.Text = "";
            }
            else
            {
                DataTable lstData = default(DataTable);
                lstData = Obj.loadList("SelectQuestionsByID", "sp_Merchandising", ResponseID.ToString());
                if (lstData.Rows.Count > 0)
                {
                    string Question, Comments, Type, Number;

                    Question = lstData.Rows[0]["aqm_Questions"].ToString();
                    Comments = lstData.Rows[0]["aqm_IsCommentsNeeded"].ToString();
                    Type = lstData.Rows[0]["qst_id"].ToString();
                    Number = lstData.Rows[0]["aqm_Number"].ToString();
                    txtQuestion.Text = Question;
                    txtType.SelectedValue = Type.ToString(); //now irs correct ok
                    ddlComments.SelectedValue = Comments.ToString();
                    txtType.Enabled = false;
                    labelqno.Text = Number;
                }

            }
        }
        public void LoadData()
        {
            DataTable lstDatas = default(DataTable);
            lstDatas = Obj.loadList("SelectQuestionsDetailsByID", "sp_Merchandising", ResponseID.ToString());
            if (lstDatas.Rows.Count > 0)
            {
                ViewState["DataTable"] = lstDatas;
                grvRpt.DataSource = lstDatas;
            }
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);
        }

        protected void ADD_Click(object sender, EventArgs e)
        {
            addTable();
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadData();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                ViewState["DeleteID"] = null;
                GridDataItem dataItem = e.Item as GridDataItem;
                string delID = dataItem.GetDataKeyValue("ID").ToString();
                ViewState["DeleteID"] = delID.ToString();
                ViewState["DelMode"] = dataItem["Mode"].Text.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Delete();</script>", false);
            }
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
                Obj.LogMessageToFile(UICommon.GetLogFileName(), "AddEditQuestions.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " + innerMessage);
            }
        }
        protected void Save()
        {
            string Question, Comment, user, type;
            Question = txtQuestion.Text.ToString();
            Comment = ddlComments.SelectedValue.ToString();
            string detail = "";
            if (ViewState["IsDetail"].ToString().Equals("Y"))
            {

                DataTable dsc = (DataTable)ViewState["DataTable"];
                if (dsc == null)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(),
                        "tmp", "<script type='text/javascript'>failedModal('For this question type, answers are mandatory');</script>", false);
                    return;
                }
                detail = GetItemFromGrid();
            }
            else
            {
                detail = "";
            }

            user = UICommon.GetCurrentUserID().ToString();
            type = txtType.SelectedValue.ToString();

            if (ResponseID == 0)
            {

                string[] arr = { type.ToString(), Comment.ToString(), user.ToString(), detail };
                DataTable lstClaim = Obj.loadList("AddQuestion", "sp_Merchandising", Question.ToString(), arr);

                if (lstClaim.Rows.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
            else
            {
                string id = ResponseID.ToString();
                string[] arr = { Question.ToString(), Comment.ToString(), user.ToString(), detail };
                string Value = Obj.SaveData("sp_Merchandising", "updateQuestions", id.ToString(), arr);
                int res = Int32.Parse(Value.ToString());
                if (res > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal('Some fields are missing ');</script>", false);
                }
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListQuestionMaster.aspx");
        }
        public void addTable()
        {
            string answer, order, status, mode;
            DataTable dts = default(DataTable);
            if (ViewState["DataTable"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("ID");
                dts.Columns.Add("Answer");
                dts.Columns.Add("Order");
                dts.Columns.Add("Status");
                dts.Columns.Add("Mode");
            }
            else
            {
                dts = (DataTable)ViewState["DataTable"];
            }
            string ID;
            if (dts.Rows.Count > 0)
            {
                int count = dts.Rows.Count + 1;
                ID = "D" + (count++).ToString();
                mode = "0";
                answer = txtAnswer.Text.ToString();
                order = txtOrder.Text.ToString();
                status = ddlStatuss.SelectedValue.ToString();

                dts.Rows.Add(ID, answer.ToString(), order.ToString(), status.ToString(), mode);
            }
            else
            {



                ID = "D1";
                mode = "0";
                answer = txtAnswer.Text.ToString();
                order = txtOrder.Text.ToString();
                status = ddlStatuss.SelectedValue.ToString();

                dts.Rows.Add(ID, answer, order, status, mode);
            }
            ViewState["DataTable"] = dts;
            grvRpt.DataSource = dts;
            grvRpt.DataBind();
            txtAnswer.Text = "";
            txtOrder.Text = "";

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
                        string Answer = row["Answer"].ToString();
                        string Mode = row["Mode"].ToString();
                        string Order = row["Order"].ToString();
                        string Status = row["Status"].ToString();
                        if (Mode.Equals("0"))
                        {
                            createNode(Answer, Order, Status, writer);
                        }
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

        private void createNode(string Answer, string Order, string Status, XmlWriter writer)
        {
            writer.WriteStartElement("Values");
            writer.WriteStartElement("Answer");
            writer.WriteString(Answer);
            writer.WriteEndElement();
            writer.WriteStartElement("Order");
            writer.WriteString(Order);
            writer.WriteEndElement();
            writer.WriteStartElement("Status");
            writer.WriteString(Status);
            writer.WriteEndElement();
            writer.WriteEndElement();
        }

        public void Delete(string Mode)
        {
            if (Mode.Equals("1"))
            {
                string Ids = ViewState["DeleteID"].ToString();
                DataTable del = Obj.loadList("DeleteQD", "sp_Merchandising", Ids.ToString());

            }

            string ID = ViewState["DeleteID"].ToString();
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

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>deleteSucces();</script>", false);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string mode = ViewState["DelMode"].ToString();
            Delete(mode);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        public void PanelVisibility()
        {
            DataTable lstType = Obj.loadList("selectTypeByID", "sp_Merchandising", txtType.SelectedValue.ToString());
            if (lstType.Rows.Count > 0)
            {
                string tpe = lstType.Rows[0]["qst_IsAnswer"].ToString();
                if (tpe.Equals("Y"))
                {
                    pnls.Visible = true;
                    ViewState["IsDetail"] = "Y";
                }
                else
                {
                    pnls.Visible = false;
                    ViewState["IsDetail"] = "N";
                }
            }
        }
        public void Route()
        {
            DataTable dt = Obj.loadList("selectType", "sp_Merchandising");
            txtType.DataSource = dt;
            txtType.DataTextField = "qst_Name";
            txtType.DataValueField = "qst_ID";
            txtType.DataBind();
        }

        protected void txtType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            PanelVisibility();
        }
    }
}