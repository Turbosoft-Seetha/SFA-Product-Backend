//using QRCoder;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using ZXing;
using ZXing.QrCode;
using ZXing.QrCode.Internal;
using static System.Net.WebRequestMethods;
using Image = System.Drawing.Image;

namespace SalesForceAutomation.BO_Digits.en
{
    public partial class ListAutoUpdate : System.Web.UI.Page
    {
        GeneralFunctions ObjclsFrms = new GeneralFunctions();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }
        public void LoadList()
        {
            DataTable lstUser = default(DataTable);
            lstUser = ObjclsFrms.loadList("ListAutoUpdate", "sp_Masters");
            grvRpt.DataSource = lstUser;
        }

        protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            LoadList();
        }

        protected void grvRpt_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("Edit"))
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string ID = dataItem.GetDataKeyValue("id").ToString();
                Response.Redirect("AddEditAutoUpdates.aspx?Id=" + ID);
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditAutoUpdates.aspx?Id=0");

        }
        public static void OpenNewBrowserWindow(string Url, Control control)
        {
            string script = "window.open('" + Url + "', '_blank');";
            ScriptManager.RegisterStartupScript(control, control.GetType(), "OpenWindow", script, true);

            // ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
        }

        protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                System.Web.UI.WebControls.Image imgQRCode = (System.Web.UI.WebControls.Image)dataItem.FindControl("QRCode");

                // Get the URL from the data source, assuming "redir_url" is a field in your data source.
                string url = DataBinder.Eval(dataItem.DataItem, "redir_url").ToString();
                string ID = DataBinder.Eval(dataItem.DataItem, "id").ToString();

                string domain = "QRCodeImages";

                // Create a folder using the domain name if it doesn't exist
                string folderPath = Server.MapPath("~/UploadFiles/" + domain);
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                // Create a BarcodeWriter instance and set its encoding and format
                BarcodeWriter barcodeWriter = new BarcodeWriter();
                barcodeWriter.Format = BarcodeFormat.QR_CODE;
                barcodeWriter.Options = new QrCodeEncodingOptions
                {
                    DisableECI = true,
                    CharacterSet = "UTF-8",
                    Width = 300, // Adjust the width and height as needed
                    Height = 300
                };
                try
                {
                    // Generate the QR code as a Bitmap
                    Bitmap qrCodeBitmap = barcodeWriter.Write(url);
                    // Save the QR code image to the folder
                    string fileName = "qr_code_" + ID + ".png";
                    string filePath = Path.Combine(folderPath, fileName);
                    qrCodeBitmap.Save(filePath, System.Drawing.Imaging.ImageFormat.Png);

                    string QRCodeURl = ConfigurationManager.AppSettings.Get("QRCodeImageUrl");
                    // Set the ImageUrl of the Image control to display the QR code
                    imgQRCode.ImageUrl = QRCodeURl + "/UploadFiles/" + domain + "/" + fileName;
                }
                catch (Exception ex)
                {

                }

                

            }

        }
    }
}