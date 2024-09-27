<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddReturnRequest.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddReturnRequest" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
         }

         function NoProducts(a) {
             $('#modalConfirm').modal('hide');
             $('#kt_modal_1_20').modal('show');
             $('#failed').text(a);
         }
        function Failure(b) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
            $('#failure').text(b);
        }
        function RequiredModal() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_0').modal('show');
        }
        function failedModal() {
           
            $('#kt_modal_1_9').modal('show');

         }
         function CompareModel() {

             $('#kt_modal_1_10').modal('show');

         }
         function CompareModel1() {

             $('#kt_modal_1_11').modal('show');

         }
         function UOMValidation1() {

             $('#uomvalidation1').modal('show');

         }
         function UOMValidation2() {

             $('#uomvalidation2').modal('show');

         }
         function UOMValidation3() {

             $('#uomvalidation3').modal('show');

         }
         function CompareModel2() {

             $('#kt_modal_1_12').modal('show');

         }
         

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                 <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
                                    Text="Cancel"  
                                    CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="LinkButton2_Click" />
                          

                                <asp:LinkButton ID="LinkButton1" Width="100px" runat="server" ValidationGroup="frm" OnClick="LinkButton1_Click" UseSubmitBehavior="false" 
                                    Text='<i class="icon-ok"></i>Proceed' CssClass="btn btn-sm fw-bold btn-primary"   CausesValidation="true" />
                                 </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

      <script>
          function OnClientFileUploadRemoved1(sender, args) {
              $telerik.$("#img1").attr('src', "http://ctt.trains.com/sitefiles/images/no-preview-available.png");
          }

          function OnClientFileSelected1(sender, args) {
              var file = args.get_file();
              var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);

              if (file && fileExtention != 'pdf') {
                  // https://stackoverflow.com/a/4459419
                  var reader = new FileReader();
                  reader.onload = function (e) {

                      $telerik.$("#img1").attr('src', e.target.result);
                  }

                  reader.readAsDataURL(file);
              } else {
                  $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
              }
          }

      </script>

   
<script>
    // https://www.telerik.com/support/kb/aspnet-ajax/upload-(async)/details/access-selected-file-in-the-arguments-of-onclientfileselected-event-of-asyncupload
    Telerik.Web.UI.RadAsyncUpload.prototype._onFileSelected = function (row, fileInput, fileName, shouldAddNewInput, file) {
        var args = {
            row: row,
            fileInputField: fileInput,
            file: file
        };
        args.rowIndex = $telerik.$(row).index();
        args.fileName = fileName;
        this._selectedFilesCount++;
        shouldAddNewInput = shouldAddNewInput &&
            (this.get_maxFileCount() == 0 || this._selectedFilesCount < this.get_maxFileCount());
        this._marshalUpload(row, fileName, shouldAddNewInput);
        var labels = $telerik.$("label", row);
        if (labels.length > 0)
            labels.remove();
        $telerik.$.raiseControlEvent(this, "fileSelected", args);
    }
    function OnClientValidationFailed(sender, args) {
        var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
        if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
            if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                alert("File extension is wrong, Please choose mentioned file format !!");
            }
            else {
                //alert(sender.get_allowedFileExtensions().indexOf(fileExtention));
                alert("File too big to upload, Kindly choose the file with approriate size !!");
            }
        }
        else {
            alert("File extension is wrong, Please choose mentioned file format !!");
        }
    }

    function toProperCase(s) {
        return s.toLowerCase().replace(/^(.)|\s(.)/g,
            function ($1) { return $1.toUpperCase(); });
    }
    function OnClientFileUploadRemoved1(sender, args) {
        $telerik.$("#img1").attr('src', "http://ctt.trains.com/sitefiles/images/no-preview-available.png");
    }

    function OnClientFileSelected1(sender, args) {
        var fileInput = args.get_fileInputField(); // Get the file input field
        var file = fileInput.files[0]; // Get the first file from the input field

        if (file) {
            var fileExtension = file.name.substring(file.name.lastIndexOf('.') + 1);

            if (fileExtension !== 'pdf') {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $telerik.$("#img1").attr('src', e.target.result);
                };

                reader.readAsDataURL(file);
            } else {
                $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
            }
        } else {
            $telerik.$("#img1").attr('src', '../assets/media/svg/files/Folder-cloud.svg');
        }
    }

</script>
   
     <div class="card-body" style="background-color:white; padding:20px;">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <!--begin::Portlet-->
                <div class="kt-portlet">
                    <%--<div class="kt-portlet__head" style="padding-top: 20px">

                       
                    </div>--%>
                   

                    <div class="kt-portlet__body">
                         <telerik:RadAjaxPanel ID="cdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                           
                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>

                      <div class="col-lg-12 row">
                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Route <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlroute" runat="server" EmptyMessage="Select Route Name" RenderMode="Lightweight"  AutoPostBack="true" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged"
                                        CausesValidation="false" Width="100%" Filter="Contains">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="frm"  runat="server"
                                        ControlToValidate="ddlroute" ErrorMessage="Please select Route Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Customer <span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlCus" runat="server"  Width="100%" EmptyMessage="Select Customer" RenderMode="Lightweight" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="ddlCus_SelectedIndexChanged"
                                        CausesValidation="false"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="frm"  runat="server"
                                        ControlToValidate="ddlCus" ErrorMessage="Please Select Customer" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True" ></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Return Type <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlReturn" runat="server" Width="100%" DefaultMessage="Select Return Type" RenderMode="Lightweight" CausesValidation="false" AutoPostBack="true">
                                        <Items>
                                            <telerik:DropDownListItem Text="Good Return" Value="GR" />
                                            <telerik:DropDownListItem Text="Bad Return" Value="BR" />
                                           
                                        </Items>
                                    </telerik:RadDropDownList>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="frm"  runat="server"
     ControlToValidate="ddlReturn" ErrorMessage="Please select Return Type" ForeColor="Red" Display="Dynamic"
     SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                          

                      <div class="col-lg-3 form-group">
                                <label class="control-label col-lg-12">Type <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlType" runat="server" Width="100%" DefaultMessage="Select Type" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                        <Items>
                                            <telerik:DropDownListItem Text="With Invoice" Value="I" />
                                            <telerik:DropDownListItem Text="Without Invoice" Value="OI" />
                                           
                                        </Items>
                                    </telerik:RadDropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="frm"  runat="server"
ControlToValidate="ddlType" ErrorMessage="Please select Type" ForeColor="Red" Display="Dynamic"
SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                           <asp:PlaceHolder ID="ddlinv" runat="server" Visible="false">
                         <div class="col-lg-3 mt-3 form-group">
                                <label class="control-label col-lg-12">Invoice ID </label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlinvID" runat="server" EmptyMessage="Select Invoice ID" RenderMode="Lightweight" AutoPostBack="true" OnSelectedIndexChanged="ddlinvID_SelectedIndexChanged"
                                        CausesValidation="false" Width="100%" Filter="Contains">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="frm" 
                                        ControlToValidate="ddlinvID" ErrorMessage="Please select Invoice ID" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                                </asp:PlaceHolder>



                         

    </div>
                             <asp:PlaceHolder ID="pnlWOI" runat="server" Visible="false">
                               <div class="col-lg-12 row" style="padding-top:15px;">

       <div class="col-lg-3 form-group">
          <label class="control-label col-lg-12">Product <span class="required"> </span></label>
          <div class="col-lg-12">
              <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" EmptyMessage="Select Product" Filter="Contains" AutoPostBack="true" RenderMode="Lightweight" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"></telerik:RadComboBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="form"
                  ControlToValidate="ddlProduct" ErrorMessage="Please choose Product" Display="Dynamic" ForeColor="Red"
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </div>
      </div>
    

      <div class="col-lg-2 form-group">
          <label class="control-label col-lg-12">Higher UOM  <span class="required"> </span></label>
          <div class="col-lg-12">

              <telerik:RadComboBox ID="ddlHUom" runat="server" AutoPostBack="true" EmptyMessage="Select Higher UOM" Width="100%" Filter="Contains"
                  RenderMode="Lightweight" OnSelectedIndexChanged="ddlHUom_SelectedIndexChanged1">
              </telerik:RadComboBox>

              <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="form"
                  ControlToValidate="ddlHUom" ErrorMessage="Please choose Higher UOM" Display="Dynamic" ForeColor="Red"
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </div>
      </div>

      <div class="col-lg-2 form-group">
          <label class="control-label col-lg-12">Higher Qty<span class="required"> </span> </label>
          <div class="col-lg-12">
              <telerik:RadNumericTextBox ID="txtHQty" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadNumericTextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="form"
                  ControlToValidate="txtHQty" ErrorMessage="Please Enter Higher Qty" Display="Dynamic" ForeColor="Red"
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
             <div class="danger"><asp:Literal ID="qty" runat="server" Visible="false"></asp:Literal> </div>
          </div>
      </div>

      <div class="col-lg-2 form-group">
          <label class="control-label col-lg-12">Lower UOM </label>
          <div class="col-lg-12">
              <telerik:RadComboBox ID="ddlLUom" runat="server"  EmptyMessage="Select Lower UOM" Width="100%" Filter="Contains" OnSelectedIndexChanged="ddlLUom_SelectedIndexChanged" AutoPostBack="true" RenderMode="Lightweight"></telerik:RadComboBox>
             <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="form"
                  ControlToValidate="ddlLUom" Display="Dynamic" ForeColor="Red" ErrorMessage="Please choose Lower UOM"
                  SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
          </div>
      </div>
      <div class="col-lg-2 form-group">
          <label class="control-label col-lg-12">Lower Qty</label>
          <div class="col-lg-12">
              <telerik:RadNumericTextBox ID="txtLQty" NumberFormat-DecimalDigits="0" runat="server" CssClass="form-control" Width="100%" Enabled="false" RenderMode="Lightweight"></telerik:RadNumericTextBox>
             <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ValidationGroup="form"
                  ControlToValidate="txtLQty" ErrorMessage="Please Enter Lower Qty" Display="Dynamic" ForeColor="Red"
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
               <div class="danger"><asp:Literal ID="lq" runat="server" Visible="false"></asp:Literal> </div>--%>
      
          </div>
      </div>

      <div class="col-lg-12 row" style="padding-top:15px;">
        <div class="col-lg-3 form-group">
            <label class="control-label col-lg-12">Reason</label>
            <div class="col-lg-12">
                           <telerik:RadComboBox ID="ddlrsn" runat="server" EmptyMessage="Select Reason" Width="100%" 
                                        RenderMode="Lightweight">
                                    </telerik:RadComboBox>


                </div>
            </div>



                                                 <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Image</label>
                                    <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                    <label style="color: #464646; font-size: smaller; margin-left:11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                    <br />
                                    <div class="col-lg-12 row" style="margin-left:5px;">
                                        <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                            ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                            UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                            OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1" 
                                            Style="padding: 10px; text-align: center; padding-bottom: 5px;" >
                                            <Localization Select="Browse Image" />
                                            <FileFilters>
                                                <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
                                            </FileFilters>
                                        </telerik:RadAsyncUpload>
                                        <div class="col-lg-12 mt-2">
                                            <asp:HiddenField ID="hlval1" runat="server" />
                                            <asp:HyperLink ID="hpl1" runat="server" Target="_blank">
                                                <asp:Image ID="img1" runat="server" Style="margin-top: 10px" ImageUrl="../assets/media/icons/File-cloud.svg" Height="70px" />
                                            </asp:HyperLink>
                                        </div>
                                        <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                        <%--</asp:LinkButton>--%>
                                    </div>

                                    <%--<img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />--%>
                                </div>


                                 

       <div class="col-lg-2" style="text-align: center; padding-top: 20px;">
              <asp:LinkButton ID="AddItem" runat="server" CssClass="btn btn-sm btn-primary me-2" OnClick="AddItem_Click" ValidationGroup="form" CausesValidation="true"  BackColor="#DAE9F8" ForeColor="#009EF7">
                          ADD 
              </asp:LinkButton>
          </div>
          </div>

  </div>
                                 </asp:PlaceHolder>
                             <br>
                           
                             

                                      <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                             

                     <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />

                             <asp:PlaceHolder ID ="pnlwithInv" runat="server" Visible="false">
                     <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                         ID="grvRpt" GridLines="None" OnSelectedIndexChanged="grvRpt_SelectedIndexChanged"
                         ShowFooter="True" AllowSorting="True"
                         OnNeedDataSource="grvRpt_NeedDataSource"
                         OnItemDataBound="grvRpt_ItemDataBound1"
                         
                         AllowFilteringByColumn="true"
                         ClientSettings-Resizing-ClipCellContentOnResize="true"
                         EnableAjaxSkinRendering="true"
                         AllowPaging="true" PageSize="100" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                         <ClientSettings>
                             <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                         </ClientSettings>
                         <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                             ShowFooter="false" DataKeyNames="prd_ID"
                             EnableHeaderContextMenu="true">
                             <Columns>

                               

                                  <telerik:GridBoundColumn DataField="prd_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="prd_ID" Display="false">
                                 </telerik:GridBoundColumn>


                                 <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                     HeaderStyle-Font-Size="Smaller" HeaderText="Product Code" FilterControlWidth="100%"
                                     CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                     HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                 </telerik:GridBoundColumn>


                                     <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                    </telerik:GridBoundColumn>

                                 
                                  <telerik:GridBoundColumn DataField="ind_HigherUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_HigherUOM">
                                    </telerik:GridBoundColumn>
                                   <telerik:GridBoundColumn DataField="ind_HigherQty"  AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Eligible Higher Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_HigherQty">
                                    </telerik:GridBoundColumn>

                                   <telerik:GridTemplateColumn HeaderStyle-Width="140px" AllowFiltering="false" UniqueName="txteligible" HeaderText="Requested Return Higher Qty"   HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="txteligible" Width="100px"    runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>


                                   <telerik:GridBoundColumn DataField="ind_LowerUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_LowerUOM">
                                    </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="ind_LowerQty" AllowFiltering="true" HeaderStyle-Width="70px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="Eligible Lower Qty" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="ind_LowerQty">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" UniqueName="txtLqnty" HeaderText="Requested Return Lower Qty"   HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <telerik:RadNumericTextBox ID="txtLqnty" Width="100px"   runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                        </telerik:RadNumericTextBox>
     
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="HUOM" AllowFiltering="true" HeaderStyle-Width="80px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="H UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="HUOM">
                                    </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="LUOM" AllowFiltering="true" HeaderStyle-Width="70px"
                                        HeaderStyle-Font-Size="Smaller" HeaderText="L UOM" FilterControlWidth="100%"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" Display="false"
                                        HeaderStyle-Font-Bold="true" UniqueName="LUOM">
                                    </telerik:GridBoundColumn>

                                  

                                  <telerik:GridTemplateColumn  HeaderText="Higher UOM" UniqueName="HigherUOM" HeaderStyle-Width="120px" AllowFiltering="false"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                   <ItemTemplate>

                                 
                                        <telerik:RadComboBox ID="ddlHUom" runat="server" AutoPostBack="true" EmptyMessage="Select Higher UOM" Width="100%" 
                                            RenderMode="Lightweight" OnSelectedIndexChanged="ddlHUom_SelectedIndexChanged">
                                        </telerik:RadComboBox>

                                    </ItemTemplate>
                                  </telerik:GridTemplateColumn>

                                  <telerik:GridTemplateColumn HeaderStyle-Width="120px" AllowFiltering="false" HeaderText="Eligible Qty" UniqueName="txteHqty"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="txteHqty" Width="100px"    AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>
                                  <telerik:GridTemplateColumn  HeaderText="Lower UOM" UniqueName="LowerUOM" HeaderStyle-Width="120px" AllowFiltering="false"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                   <ItemTemplate>
                                 
                                        <telerik:RadComboBox ID="ddlLuom" runat="server"  EmptyMessage="Select Lower UOM" Width="100%" 
                                            RenderMode="Lightweight" CausesValidation="false">
                                        </telerik:RadComboBox>

                                    </ItemTemplate>
                                  </telerik:GridTemplateColumn>

                                 
                                   <telerik:GridTemplateColumn HeaderStyle-Width="120px"  HeaderText="Lower Qty"  UniqueName="ddlLqty" AllowFiltering="false"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                     <ItemTemplate>
                                         <telerik:RadNumericTextBox ID="ddlLqty" Width="100px"  AutoPostBack="true" runat="server" Enabled="true" NumberFormat-AllowRounding="false" DecimalDigits="0">
                                         </telerik:RadNumericTextBox>
                                      
                                     </ItemTemplate>
                                 </telerik:GridTemplateColumn>


                               
                                    <telerik:GridTemplateColumn  HeaderText="Reason" UniqueName="rsncode" HeaderStyle-Width="150px" AllowFiltering="false"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
  <ItemTemplate>

       <telerik:RadComboBox ID="ddlrsn" runat="server" EmptyMessage="Select Reason" Width="100%" 
           RenderMode="Lightweight">
       </telerik:RadComboBox>

   </ItemTemplate>
 </telerik:GridTemplateColumn>

  <telerik:GridTemplateColumn  HeaderText="Attach Image" UniqueName="attImage" HeaderStyle-Width="300px" AllowFiltering="false"  HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
 <ItemTemplate>

    

     <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
     ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
     UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
     OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1" 
     Style="padding: 10px; text-align: center; padding-bottom: 10px;" >
     <Localization Select="Browse Image" />
     <FileFilters>
         <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
     </FileFilters>
 </telerik:RadAsyncUpload>
                            

  </ItemTemplate>
</telerik:GridTemplateColumn>

                                

                              

                             </Columns>
                         </MasterTableView>
                         <PagerStyle AlwaysVisible="true" />
                         <GroupingSettings CaseSensitive="false" />
                         <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                             <Resizing AllowColumnResize="true"></Resizing>
                             <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                         </ClientSettings>
                     </telerik:RadGrid>

                             </asp:PlaceHolder>
                             <asp:PlaceHolder ID="pnlwithoutInv" runat="server" Visible="false">

                                                                     <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="RadGrid1" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                         OnNeedDataSource="RadGrid1_NeedDataSource"
                                       
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                             

                                                <telerik:GridBoundColumn DataField="ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ID" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Item" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Product" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="HigherUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="HigherUom" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherUom">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="HigherQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="HigherQty" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_HigherQty">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="LowerUom" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="LowerUom" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerUom">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="LowerQty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="LowerQty" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="lid_LowerQty">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="higheruomID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="higheruomID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="higheruomID" Visible="false">
                                                </telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn DataField="loweruomID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="loweruomID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="loweruomID" Visible="false">
                                                </telerik:GridBoundColumn>

                                                   <telerik:GridBoundColumn DataField="Reason" AllowFiltering="true" HeaderStyle-Width="60px"
                                                      HeaderStyle-Font-Size="Smaller" HeaderText="Reason" FilterControlWidth="100%"
                                                      CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                      HeaderStyle-Font-Bold="true" UniqueName="Reason">
                                                  </telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn DataField="ReasonID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="ReasonID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="ReasonID" Visible="false">
                                            </telerik:GridBoundColumn>
                                                  <telerik:GridBoundColumn DataField="img" AllowFiltering="true" HeaderStyle-Width="120px"
                                                  HeaderStyle-Font-Size="Smaller" HeaderText="Return Image" FilterControlWidth="100%"
                                                  CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                  HeaderStyle-Font-Bold="true" UniqueName="img" Display="false">
                                              </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Reference Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                  <ItemTemplate>
                                                      <asp:HyperLink ID="salImg" runat="server" NavigateUrl=' <%# "../../"+ Eval("img") %>' Target="_blank" Visible="true">
                                                          <asp:Image ID="salImage" runat="server" ImageUrl=' <%# "../../"+ Eval("img") %>' Height="20px" Width="20px" Visible="true" />
                                                      </asp:HyperLink>
                                                  </ItemTemplate>
                                              </telerik:GridTemplateColumn>


                                              

                                            </Columns>
                                        </MasterTableView>
                                        <PagerStyle AlwaysVisible="true" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>

                             </asp:PlaceHolder>
                          
                        </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>


                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>
    

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height:auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" CssClass="btn btn-sm fw-bold btn-primary" OnClick="save_Click" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
     <div class="modal fade" id="kt_modal_1_20" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Oops...</h5>
             </div>
             <div class="modal-body">
                 <span id="failed"></span>
             </div>
             <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_20);">Cancel</button>
             </div>
         </div>
     </div>
 </div>

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failure"></span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="kt_modal_1_0" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Ooops..!</h5>
            </div>
            <div class="modal-body">
                <p>You must enter Quantity for all checked items.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_0);">OK</button>
            </div>
        </div>
    </div>
</div>
      <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
             
              <div class="modal-body">
                  <span>Invoice Is Already Exist !!!</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
              </div>
          </div>
      </div>
  </div>

     <div class="modal fade" id="kt_modal_1_10" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return higher qty is greater than the eligible higher qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_10);">OK</button>
              </div>
          </div>
      </div>
  </div>

     <div class="modal fade" id="kt_modal_1_11" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return lower qty is greater than the eligible lower qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_11);">OK</button>
              </div>
          </div>
      </div>
  </div>

      <div class="modal fade" id="kt_modal_1_12" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span>Entered requested return  qty is greater than the eligible  qty. Kindly enter equal or lesser value ..</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_12);">OK</button>
              </div>
          </div>
      </div>
  </div>

    <%--uomvalidation1--%>
    <div class="modal fade" id="uomvalidation1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add atleast one uom for each item</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation1);">OK</button>
              </div>
          </div>
      </div>
  </div>
    <%--uomvalidation2--%>
    <div class="modal fade" id="uomvalidation2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Oops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add quanity for the uom</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation2);">OK</button>
              </div>
          </div>
      </div>
  </div>
     <%--uomvalidation3--%>
    <div class="modal fade" id="uomvalidation3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height:auto;">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Ooops..!</h5>
              </div>
              <div class="modal-body">
                  <span> Please add any quantity</span>

              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(uomvalidation3);">OK</button>
              </div>
          </div>
      </div>
  </div>

     <style>
     .RadUpload_Silk .ruButton {
         padding-bottom: 0px !important;
         color: black !important;
         width: 122px !important;
        
      
         margin-left: 0px !important;
         padding-top:0px;
         display: flex ;
     }
</style>
    <style>
    .RadUpload_Silk .ruButton.ruRemove {
       order: -1;
        padding-bottom: 0px !important;
        color: black !important;
        width: 122px !important;
        margin-left: 0px !important;
        padding-top: 0px !important;
    }
</style>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
