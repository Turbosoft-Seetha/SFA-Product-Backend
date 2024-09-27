using DocumentFormat.OpenXml.Drawing.Charts;
using GoogleApi.Entities.Maps.StaticMaps.Request;
using GoogleApi.Entities.Search.Video.Common.Enums;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class AddCusProfileDOC : System.Web.UI.Page
    {
        GeneralFunctions obj = new GeneralFunctions();


        public int ReturnID
        {
            get
            {
                int ReturnID;
                int.TryParse(Request.Params["Id"], out ReturnID);

                return ReturnID;
            }
        }
        public int ResponseID
        {
            get
            {
                int ResponseID;
                int.TryParse(Request.Params["IDH"], out ResponseID);

                return ResponseID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                txtFrom.SelectedDate = DateTime.Now;



            }
        }

        protected void lnkSaves_Click(object sender, EventArgs e)
        {
            if ((upd1.UploadedFiles.Count == 0) && (ViewState["image"] == null) && (udp2.UploadedFiles.Count == 0) && (ViewState["image1"] == null) && (udp3.UploadedFiles.Count == 0) && (ViewState["image3"] == null))
            {


                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>Confim();</script>", false);


            }
        }
        protected void Save()
        {
            string image = "";
            string Image1 = "";
            string Image2 = "";
            //int ImageID = 0;
            foreach (UploadedFile uploadedFile in upd1.UploadedFiles)
            {
                //ImageID += 1;

                string csvPath = Server.MapPath(("..") + @"/../UploadFiles/CusDocuments/") + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath);
                image = @"../../UploadFiles/CusDocuments/" + uploadedFile.FileName.ToString();
                ViewState["image"] = image.ToString();
            }
            foreach (UploadedFile uploadedFile in udp2.UploadedFiles)
            {
                //ImageID += 1;

                string csvPath1 = Server.MapPath(("..") + @"/../UploadFiles/CusDocuments/") + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath1);
                Image1 = @"../../UploadFiles/CusDocuments/" + uploadedFile.FileName.ToString();
                ViewState["image1"] = Image1.ToString();
            }
            foreach (UploadedFile uploadedFile in udp3.UploadedFiles)
            {
                //ImageID += 1;

                string csvPath2 = Server.MapPath(("..") + @"/../UploadFiles/CusDocuments/") + uploadedFile.FileName;
                uploadedFile.SaveAs(csvPath2);
                Image2 = @"../../UploadFiles/CusDocuments/" + uploadedFile.FileName.ToString();
                ViewState["image2"] = Image2.ToString();
            }
           // string cusDoc = GetItemFromGrid();
            string   from, to,  user,cus;
            string txttrade = "Trade License";
            string txtvat = "Vat Certificate";
            string txtOther = "Others";
            txtFrom.SelectedDate = DateTime.Now;
            txtToDate.SelectedDate= DateTime.Now;
            from = DateTime.Parse(txtFrom.SelectedDate.ToString()).ToString("yyyyMMdd");
            to = DateTime.Parse(txtToDate.SelectedDate.ToString()).ToString("yyyyMMdd");
            string tradepath = "";
            string vatpath = "";
            string otherpath = "";

            if (ViewState["image"] != null)
            {
                tradepath = ViewState["image"].ToString();
            }

            if (ViewState["image1"] != null)
            {
                vatpath = ViewState["image1"].ToString();
            }
            if (ViewState["image2"] != null)
            {
                otherpath = ViewState["image2"].ToString();
            }



           
            user = UICommon.GetCurrentUserID().ToString();
            cus = ResponseID.ToString();
            string Value = "";
            string[] arr = {  from.ToString(), to.ToString(),  user.ToString() , txttrade.ToString(), tradepath.ToString(), txtvat.ToString(), vatpath.ToString(), txtOther.ToString(), otherpath.ToString() };
           
                Value = obj.SaveData("sp_Masters", "InsertCustomerDOC", cus.ToString(), arr);
                int res = Int32.Parse(Value.ToString());

            if (res == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>failedModal();</script>", false);
            }
            else if (res < 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>existModal();</script>", false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>successModal();</script>", false);
            }
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


        //          string  txttrade = "Trade License";
        //          string  txtvat = "Vat Certificate";
        //          string  txtOther = "Others";


        //            if(ViewState["image"]!=null)
        //            {
        //                string tradepath = ViewState["image"].ToString();
        //                createNode(txttrade, tradepath, txtvat, writer);
        //                c++;


        //                writer.WriteEndElement();
        //                writer.WriteEndDocument();
        //                writer.Close();
        //                if (c == 0)
        //                {
        //                    return "";
        //                }
        //                else
        //                {
        //                    string ss = sw.ToString();
        //                    return sw.ToString();
        //                }


        //            }
                    
                    
        //            string vatpath = ViewState["image1"].ToString();
        //            string otherpath = ViewState["image2"].ToString();

                   
        //            createNode(txttrade, tradepath, txtvat, vatpath, txtOther,  otherpath, writer);
        //                    c++;


        //            writer.WriteEndElement();
        //            writer.WriteEndDocument();
        //            writer.Close();
        //            if (c == 0)
        //            {
        //                return "";
        //            }
        //            else
        //            {
        //                string ss = sw.ToString();
        //                return sw.ToString();
        //            }
        //        }
        //    }
        //}

      

        //private void createNode(string docname, string docpath, XmlWriter writer)
        //{
        //    writer.WriteStartElement("Values");

        //    writer.WriteStartElement("Doctrade");
        //    writer.WriteString(docname);
        //    writer.WriteEndElement();

        //    writer.WriteStartElement("tradepath");
        //    writer.WriteString(docpath);
        //    writer.WriteEndElement();

            



        //    writer.WriteEndElement();
        //}


        protected void lnkSave_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                obj.LogMessageToFile(UICommon.GetLogFileName(), "AddCusProfileDOC.aspx PageLoad()", "Error : " + ex.Message.ToString() + " - " +
                    innerMessage);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {

            string ID = ResponseID.ToString();
            Response.Redirect("ListDocuments.aspx?Id=" + ID);

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListDocuments.aspx?Id=" + ResponseID.ToString());
        }
    }
}