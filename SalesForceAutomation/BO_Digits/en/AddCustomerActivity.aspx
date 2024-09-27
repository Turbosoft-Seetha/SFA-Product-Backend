<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="AddCustomerActivity.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.AddCustomerActivity" %>
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
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
        function failedModal(res) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#failres').text(res);
        }
        function failModal() {
            $('#kt_modal_1_3').modal('hide');
            $('#kt_modal').modal('show');
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
                $telerik.$("#img1").attr('src', '../assets/media/icons/File-cloud.svg');
            }
        }



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                               
                                <asp:LinkButton ID="lnkCancel" runat="server"
                                    Text="Cancel" CssClass="btn btn-sm fw-bold btn-secondary"
                                    CausesValidation="False" OnClick="lnkCancel_Click" />
          <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="form" OnClick="lnkSave_Click" UseSubmitBehavior="false" Text="Proceed"
                                    CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
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
                   $telerik.$("#img1").attr('src', '../assets/media/icons/File-cloud.svg');
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
    </script>

  




                    <div class="card-body row p-8" style="background-color:white;">
                          <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <div class="col-lg-12 row">

                               <div class="col-lg-4 form-group pb-4">
                                    <label class="control-label col-lg-12">Route<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlrot" EmptyMessage="Select Route" runat="server" Width="100%" Filter="Contains"   AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlrot_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlrot" ErrorMessage="Please Select Cusomer" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>


                             <div class="col-lg-4 form-group pb-4">
                                    <label class="control-label col-lg-12">Customer<span class="required"> </span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadComboBox ID="ddlCustomers" EmptyMessage="Select Customer" runat="server" Width="100%" Filter="Contains"  >
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="ddlCustomers" ErrorMessage="Please Select Cusomer" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                          <%--  <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Code<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ValidationGroup="form" 
                                        ControlToValidate="txtcode" ErrorMessage="Please Enter Code" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>--%>
                            <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Name<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtname" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"  ValidationGroup="form" 
                                        ControlToValidate="txtname" ErrorMessage="Please Enter Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Description<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtDesc" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ValidationGroup="form" 
                                        ControlToValidate="txtDesc" ErrorMessage="Please Enter Description" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                           
                              

                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">StartDate<span class="required"> </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadDatePicker ID="rdFromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" ></telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ErrorMessage="StartDate is mandatory"  ValidationGroup="form" 
                                                ForeColor="Red" ControlToValidate="rdFromDate"></asp:RequiredFieldValidator> <br />                                                          
                                </div>
                            </div>

                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">EndDate<span class="required"> </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadDatePicker ID="rdEndDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" ></telerik:RadDatePicker>
                                            <asp:CompareValidator ID="cmp" runat="server" ControlToCompare="rdFromDate" ControlToValidate="rdEndDate" Operator="GreaterThanEqual"
                                                ErrorMessage="To data must be greater" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="EndDate is mandatory"  ValidationGroup="form" 
                                                ForeColor="Red" ControlToValidate="rdEndDate"></asp:RequiredFieldValidator> <br />         
                                </div>
                            </div>
                         <%--   <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Status<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" runat="server" Width="100%" >
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>--%>
                        </div>
                     </telerik:RadAjaxPanel>
                         
      <!--Uom header-->
                                <div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 10px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Add SubActivity
                                        </h3>
                                    </div>
                                </div>
                                <!--End Uom header-->
                                <div class="kt-portlet__body">
                                   
                                   <div class="col-lg-12 row">

                           <%-- <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Code<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%" RenderMode="Lightweight"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ValidationGroup="form"
                                        ControlToValidate="txtcode" ErrorMessage="Please Enter Code" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>--%>
                            <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Name<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtSname" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"  ValidationGroup="frm"
                                        ControlToValidate="txtSname" ErrorMessage="Please Enter Name" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Description<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtSDesc" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"  ValidationGroup="frm"
                                        ControlToValidate="txtSDesc" ErrorMessage="Please Enter Description" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                           
                              <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Type<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txttype" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"  ValidationGroup="frm"
                                        ControlToValidate="txttype" ErrorMessage="Please Enter Type" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">DueDate<span class="required"> </span></label>
                                <div class="col-lg-12">
                                     <telerik:RadDatePicker ID="rdDueDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" ></telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ErrorMessage="Date is mandatory"  ValidationGroup="frm"
                                                ForeColor="Red" ControlToValidate="rdDueDate"></asp:RequiredFieldValidator> <br />                                                          
                                </div>
                            </div>
                             <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">SortOrder<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtsortorder" runat="server" CssClass="form-control" Width="100%" ></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"  ValidationGroup="frm"
                                        ControlToValidate="txtsortorder" ErrorMessage="Please Enter SortOrder" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                                <div class="col-lg-4 form-group pb-4">
                                <label class="control-label col-lg-12">Status<span class="required"> </span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlSubStatus" runat="server" Width="100%" >
                                        <Items>
                                            <telerik:DropDownListItem Text="Active" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="Inactive" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                                       <div class="col-lg-4">
                                    <label class="control-label col-lg-12">Reference Image<span class="required"> </span></label>
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



                            <div class="col-lg-8 form-group" style="padding-top: 85px; padding-bottom: 20px;text-align-last:end">
                                            <div class="col-lg-12">
                                                  <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                                               
                                                    <asp:LinkButton ID="BtnAdd" runat="server" ValidationGroup="frm" OnClick="BtnAdd_Click" Style="display: inline-grid;" UseSubmitBehavior="false" Text='<i class="icon-ok"></i> Add Sub Activity'
                                                        CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
                                                       </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                                                    BackColor="Transparent"
                                                    ForeColor="Blue">
                                                    <div class="col-lg-12 text-center mt-5">
                                                        <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                                    </div>
                                                </telerik:RadAjaxLoadingPanel>
                                               
                                              
                                            </div>
                                        </div>
                    

                        
                        </div>
                                        


                                </div>
                                <!--Uom Detail header-->
                                <div class="kt-portlet__head" style="padding-top: 10px; padding-bottom: 20px;">
                                    <div class="kt-portlet__head-label">
                                        <h3 class="kt-portlet__head-title">Customer Activity Detail
                                        </h3>
                                    </div>
                                </div>
                                <!--End Uom Detail header-->
                                <!--Detail Body-->
                                <div class="kt-portlet__body">
                             

                                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                         OnItemDataBound="grvRpt_ItemDataBound"                                                                                                                                                                                                              
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0"        PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                               
                                              <%--  <telerik:GridBoundColumn DataField="uom_Code" AllowFiltering="true" HeaderStyle-Width="130px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uom_Code">
                                                </telerik:GridBoundColumn>--%>
                                                 <telerik:GridBoundColumn DataField="ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ID" Visible="false">
                                                </telerik:GridBoundColumn>
                                               <%-- <telerik:GridBoundColumn DataField="cad_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cad_Code">
                                            </telerik:GridBoundColumn>--%>

                                            <telerik:GridBoundColumn DataField="name" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="name">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="desc" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="desc">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="type" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="type">
                                            </telerik:GridBoundColumn>
                                             <%--<telerik:GridBoundColumn DataField="TransDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Trans Date" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="TransDate">
                                            </telerik:GridBoundColumn>--%>
                                            <telerik:GridBoundColumn DataField="duedate" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="DueDate" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="duedate">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="img" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Reference Image" FilterControlWidth="100%"
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

                                            <%-- <telerik:GridBoundColumn DataField="cad_Remarks" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Merchandiser Remarks" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cad_Remarks">
                                            </telerik:GridBoundColumn>--%>
                                            
                                             <%-- <telerik:GridTemplateColumn HeaderStyle-Width="150px" HeaderText="CaptureImage" UniqueName="CaptureImage" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%--<telerik:RadImageGallery RenderMode="Lightweight" ID="rdImages" runat="server" DisplayAreaMode="ToolTip"  Visible="false" DataImageField="odi_Image"   Width="300px" Height="60px"  LoopItems="false">
                                                        <ImageAreaSettings Height="100px" Width="100px"  />
                                                </telerik:RadImageGallery>--%>
                                               <%-- </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="cai_CaptureImage" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cai_CaptureImage">
                                            </telerik:GridBoundColumn>--%>
                                             <telerik:GridBoundColumn DataField="sortorder" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="SortOrder" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="sortorder">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="status" AllowFiltering="true" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="status">
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
                                
                                </div>
                           
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                  </div> 



     <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm);">Cancel</button>

                </div>
            </div>
        </div>
    </div>
    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Something went wrong, please try again later.</span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>

     <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failres"></span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
                </div>
            </div>
        </div>
    </div>


    
     <div class="modal fade" id="kt_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>File missing..please upload file</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal);">Ok</button>
                </div>
            </div>
        </div>
    </div>




    <!--end::FailedModal-->


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
