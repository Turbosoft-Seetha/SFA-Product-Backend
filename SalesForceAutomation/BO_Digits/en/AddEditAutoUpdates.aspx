<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddEditAutoUpdates.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddEditAutoUpdates" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script>
        function Confim() {
            $('#kt_modal_1_3').modal('show');
        }
        function successModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function Delete() {
            $('#kt_modal_1_6').modal('show');
        }
        function TypeSelect() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
        }
        function DeleteFailed() {
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failedModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal_1_4').modal('hide');
            $('#kt_modal_1_5').modal('hide');
            $('#kt_modal_1_6').modal('hide');
            $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_9').modal('show');

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
                $telerik.$("#img1").attr('src', 'assets/media/icons/svg/Files/Folder-cloud.svg');
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

      

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

        <asp:LinkButton ID="LinkCancel" runat="server" OnClick="LinkCancel_Click"
            Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
            CausesValidation="False" />
        <asp:LinkButton ID="LinkSave" runat="server" ValidationGroup="form" OnClick="LinkSave_Click"
            UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Proceed'
            CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <style>
   
    .browse-file-text {
     
        font-weight: bold;
        color: blue;
    }
</style>

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

         </script>
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
                 $telerik.$("#img1").attr('src', 'assets/media/icons/svg/Files/Folder-cloud.svg');
             }
         }

     </script>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="lnkAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="lnkDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-portlet__body">
                            <%--<div><h3 class="kt-portlet__head-title">Add Qualification Header 
                                        </h3> </div> <br />--%>

                            <div class="col-lg-12 row">

                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Code</label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                            ControlToValidate="txtcode" ErrorMessage="Please Enter Version code" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>

                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Name</label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                            ControlToValidate="txtName" ErrorMessage="Please Enter Version Name" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                             <%--   <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Url</label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtURL" runat="server" TextMode="MultiLine" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="txtURL" ErrorMessage="Please Enter url" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>--%>

                                   <div class="col-lg-3 form-group">
                <label class="control-label col-lg-12">Platform<span class="required"></span></label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="ddlApp" runat="server" Width="100%" Filter="Contains" EmptyMessage="Select platform" RenderMode="Lightweight" Skin="Silk">
                        <Items>
                            <telerik:RadComboBoxItem Text="Inventory" Value="I" />
                            <telerik:RadComboBoxItem Text="SFA" Value="S" />
                            <telerik:RadComboBoxItem Text="Customer Connect" Value="C" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                        ControlToValidate="ddlApp" ErrorMessage="Please select platform" ForeColor="Red" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                </div>
            </div>


                                <div class="col-lg-3 form-group">
                                    <label class="control-label col-lg-12">Applicable to</label>
                                    <div class="col-lg-12">
                                        <telerik:RadDropDownList ID="ddlroute" RenderMode="Lightweight" Filter="Contains" runat="server" Width="100%" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged" AutoPostBack="true" Skin="Silk">
                                            <Items>
                                                <telerik:DropDownListItem Text="All" Value="A" selected="true"/>
                                                <telerik:DropDownListItem Text="Specific" Value="S" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </div>
                                </div>
                                   

                                


                            </div>

                            <div class="col-lg-12 row">

                                  <div class="col-lg-4 pt-4 w-5">
                <label class="control-label col-lg-12">File upload<span class="required"> </span></label>
                <asp:HiddenField ID="txtimage" runat="server" Value="Overall claim picture" />
                <label style="color: #464646; font-size: smaller; margin-left: 0px;">Only .apk , .APK files are allowed with maximum size 60 MB</label>
                <br />
                <div class="col-lg-12 row" style="margin-left: 0px;"    >
                    <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                        ID="upd1" AllowedFileExtensions=".apk,.APK" MultipleFileSelection="Disabled" MaxFileSize="62914560"
                        UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                        OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                         Style="padding: 10px; text-align:end; padding-bottom: 10px; height:100px;" >

                        <Localization    Select="Browse file" />
                        <FileFilters>
                            <telerik:FileFilter Description="" Extensions=".apk,.APK" />
                        </FileFilters>
                    </telerik:RadAsyncUpload>
                     <div class="demo-container size-narrow">
                         <telerik:RadProgressManager runat="server" ID="RadProgressManager1"/>
                         <telerik:RadProgressArea RenderMode="Lightweight" runat="server" ID="RadProgressArea1"  />
                     </div>
                </div>

            </div>
                             <div class="col-lg-8 form-group">
                                    <label class="control-label col-lg-12">Release Note</label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtReleaseNote" runat="server" TextMode="MultiLine" CssClass="form-control" Width="100%"></telerik:RadTextBox>
                                     <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                            ControlToValidate="txtReleaseNote" ErrorMessage="Please Enter " ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                    </div>
                                </div>

                         

                                
                                <div class="col-lg-3 form-group  ">
                                    <asp:Panel ID="typepanel" runat="server" Visible="false">
                                        <label class="control-label col-lg-12">Type <span class="required"></span></label>
                                        <div class="col-lg-12">
                                            <telerik:RadDropDownList ID="ddltype" RenderMode="Lightweight" runat="server" Width="100%" Filter="Contains" DefaultMessage="Please Select" Skin="Silk">
                                                <Items>
                                                    <telerik:DropDownListItem Text="Mandatory" Value="M" />
                                                    <telerik:DropDownListItem Text="Optional" Value="O" />
                                                    <telerik:DropDownListItem Text="Non Visible" Value="N" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </div>
                                    </asp:Panel>

                                </div>

                            </div>
                        </div>


                        <%-- strat form --%>
                        <asp:Panel ID="gridpanel" runat="server" Visible="false">
                            <div class="col-lg-12 row pt-4">


                                <div class="col-lg-6">

                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">

                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">Uninstalled Routes
                                                </h3>
                                            </div>
                                            <div class="col-lg-2" style="text-align-last: end;">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                                    <asp:LinkButton ID="lnkAdd" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="lnkAdd_Click">
                                                    Add
                                                    </asp:LinkButton>
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>

                                        <!--begin::Form-->
                                        <div class="kt-form kt-form--label-right">
                                            <div class="kt-portlet__body">
                                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                                <telerik:RadSkinManager ID="RadSkinManager2" runat="server" Skin="Material" />
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">

                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                        ID="RadGrid1" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="RadGrid1_NeedDataSource"
                                                        AllowFilteringByColumn="true"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="rot_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                                </telerik:GridClientSelectColumn>

                                                                <telerik:GridBoundColumn DataField="rot_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="rot_ID" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_ID" Display="false">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <PagerStyle AlwaysVisible="true" />
                                                        <GroupingSettings CaseSensitive="false" />
                                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                            <Resizing AllowColumnResize="true"></Resizing>
                                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">Installed Routes
                                                </h3>
                                            </div>
                                            <div class="col-lg-2">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                                    <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove" OnClick="lnkDelete_Click"></asp:LinkButton>
                                                </telerik:RadAjaxPanel>

                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-form kt-form--label-right">
                                            <div class="kt-portlet__body">
                                                <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                                                <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                        ID="grvRpt" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                                        AllowFilteringByColumn="true"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll">
                                                                </telerik:GridClientSelectColumn>

                                                                <telerik:GridBoundColumn DataField="ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ID" Display="false">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Route">
                                                                </telerik:GridBoundColumn>                                                                
                                                                <telerik:GridBoundColumn DataField="Type" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Type" Display="false">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Typeval" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Typeval" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Typeval" Display="false">
                                                                </telerik:GridBoundColumn>
                                                              
                                                                 <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                </telerik:GridBoundColumn>
                                                                   <telerik:GridBoundColumn DataField="rva_IsUpdated" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Is Updated" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rva_IsUpdated">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Modified Date" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <PagerStyle AlwaysVisible="true" />
                                                        <GroupingSettings CaseSensitive="false" />
                                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                            <Resizing AllowColumnResize="true"></Resizing>
                                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>

                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
                        </asp:Panel>
                        <asp:Panel ID="gridPanelAll" runat="server" Visible="true">
                            <div class="col-lg-12 row pt-4">


                                <%--<div class="col-lg-6">

                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">

                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">Uninstalled Routes
                                                </h3>
                                            </div>
                                            <div class="col-lg-2" style="text-align-last: end;">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                                                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-sm fw-bold btn-success" OnClick="LinkButton3_Click">
                                                    Add
                                                    </asp:LinkButton>
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>

                                        <!--begin::Form-->
                                        <div class="kt-form kt-form--label-right">
                                            <div class="kt-portlet__body">
                                                <asp:Literal ID="Literal2" runat="server"></asp:Literal>                                                
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">

                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                        ID="RadGrid2" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="RadGrid2_NeedDataSource"
                                                        AllowFilteringByColumn="true"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                            ShowFooter="false" DataKeyNames="rot_ID"
                                                            EnableHeaderContextMenu="true">
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="rot_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="rot_ID" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_ID" Display="false">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="rot_Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="rot_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rot_Name">
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <PagerStyle AlwaysVisible="true" />
                                                        <GroupingSettings CaseSensitive="false" />
                                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                            <Resizing AllowColumnResize="true"></Resizing>
                                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>

                                    </div>
                                </div>--%>
                                <div class="col-lg-12">
                                    <!--begin::Portlet-->
                                    <div class="kt-portlet">
                                        <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                            <div class="col-lg-10">
                                                <h3 class="kt-portlet__head-title">Installed Routes
                                                </h3>
                                            </div>
                                            <div class="col-lg-2">
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-sm fw-bold btn-danger" Text="Remove" OnClick="lnkDelete_Click" Visible="false"></asp:LinkButton>
                                                </telerik:RadAjaxPanel>

                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center">
                                                        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                            </div>
                                        </div>
                                        <!--begin::Form-->
                                        <div class="kt-form kt-form--label-right">
                                            <div class="kt-portlet__body">
                                                <asp:Literal ID="Literal3" runat="server"></asp:Literal>


                                                <telerik:RadAjaxPanel ID="RadAjaxPanel10" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                        ID="RadGrid3" GridLines="None"
                                                        ShowFooter="True" AllowSorting="True"
                                                        OnNeedDataSource="RadGrid3_NeedDataSource"
                                                        AllowFilteringByColumn="true"
                                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                        EnableAjaxSkinRendering="true"
                                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
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
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ID" Display="false">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Code" AllowFiltering="true" HeaderStyle-Width="80px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Code">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Route" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Route">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Type" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Type"  Display="false">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Typeval" AllowFiltering="true" HeaderStyle-Width="150px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Typeval" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="Typeval" Display="false">
                                                                </telerik:GridBoundColumn>                                                                
                                                                 <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                                </telerik:GridBoundColumn>
                                                                  <telerik:GridBoundColumn DataField="rva_IsUpdated" AllowFiltering="true" HeaderStyle-Width="100px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Is Updated" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="rva_IsUpdated">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Modified Date" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="120px"
                                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Modified By" FilterControlWidth="100%"
                                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                    HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <PagerStyle AlwaysVisible="true" />
                                                        <GroupingSettings CaseSensitive="false" />
                                                        <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                            <Resizing AllowColumnResize="true"></Resizing>
                                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>

                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel11" EnableEmbeddedSkins="false"
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
                        </asp:Panel>
                        <%-- End form --%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- modal start --%>

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_3" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to add ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel9">
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    Add
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_3);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success">Version added successfully.</span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailureModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailureModal-->

    <!--begin::ValidationModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are you sure you want to delete ?</h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="lnkRemove" runat="server" OnClick="lnkDelete_Click" CssClass="btn btn-sm fw-bold btn-primary">
                                                    Yes
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_6);">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::ValidationModal-->

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Choose Type</h5>
                </div>
                <div class="modal-body">
                    <label class="control-label col-lg-12">Type <span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadDropDownList ID="ddlSprotType" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Please Select">
                            <Items>
                                <telerik:DropDownListItem Text="Mandatory" Value="M" />
                                <telerik:DropDownListItem Text="Optional" Value="O" />
                                <telerik:DropDownListItem Text="Non Visible" Value="N" />
                            </Items>
                        </telerik:RadDropDownList>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lnkTypeSelect" runat="server" OnClick="lnkTypeSelect_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_9" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">No selection found..!</h5>
                </div>
                <div class="modal-body">
                    <p>Please make selection and try again.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_9);">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->


    <%-- modal end --%>



     <style>
     .RadUpload_Silk .ruSelectWrap .ruButton{
padding-top:0px;
}
 </style>
 
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
