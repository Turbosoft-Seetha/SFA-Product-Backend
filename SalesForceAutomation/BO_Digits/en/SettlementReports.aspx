﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SettlementReports.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SettlementReports" EnableViewState="true" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function AprvConfirm() {
            $('#modalAprvConfirm').modal('show');

        }
        function RejectConfim() {
            $('#modalrjctConfirm').modal('show');

        }
        function Confirm() {
            $('#modalConfirm2').modal('show');
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
            $('#kt_modal_1_6').modal('show');
            $('#failres').text(res);
        }
        function loadOutModal(ress) {
            $('#kt_modal_1_7').modal('show');
            $('#loadOut').text(ress);
        }
        function Payment() {
            $('#kt_modal_1_8').modal('show');
        }
        function showPreviousVariances() {
            $('#Variance').modal('show');
        }

        function UpdateStatus() {
            $('#modalConfirm1').modal('show');
        }


        function showpettycash() {
            $('#pettycash').modal('show');
        }
        function BankSucccess() {
            $('#kt_modal_1_44').modal('show');
            $('#modalConfirm1').modal('hide');
        }

        function pettycashsuccess(ab) {
            $('#kt_modal').modal('show');
            $('#pettycash').modal('hide');
            $('#succeses').text(ab);
        }
        function showCoupon() {
            $('#Coupon').modal('show');
        }
        function hideCoupon() {
            $('#Coupon').modal('hide');
        }



        function refreshModal() {
            // Refresh the modal by reloading its content
            $('#pettycash').find('.modal-content').load(location.href + ' #pettycash > .modal-dialog > .modal-content', function () {
                // Once the content is loaded, show the modal
                $('#pettycash').modal('show');
            });
        }

        function showSuccessToast(message) {
            toastr.success(message);
            // Set flag in session storage
            //sessionStorage.setItem('pettycash', 'true');
            //setTimeout(function () {
            //    window.location.reload();
            //}, 2000);
        }

        function Fail(msg) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_2').modal('show');
            $('#failmsg').text(msg);
        }

        function OnClientFileUploadRemoved1(sender, args) {
            $telerik.$("#img1").attr('src', "http://ctt.trains.com/sitefiles/images/no-preview-available.png");
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript"> 
            function OnRowClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=grvPayment.ClientID %>");
                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();
                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // newly added
                            MasterTable.fireCommand("MyClick1", ClickedIndex); // newly added
                        } // newly added
                    }
                }
            }







        </script>
    </telerik:RadScriptBlock>



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
    </script>





    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtHardCash">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblHardCashVariance" />

                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtPos">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblPOSVariance" />

                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtOnlinePayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblOnlinePaymentVariance" />

                    <telerik:AjaxUpdatedControl ControlID="RadWizard1" />
                    <telerik:AjaxUpdatedControl ControlID="lblTotalVariance" />

                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtOnlinePayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblOnlinePaymentVariance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="Button1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Variance" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="grvPayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddltext" />
                    <telerik:AjaxUpdatedControl ControlID="RDbank" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePicker1" />

                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="lnkCollectCoupon">
     <UpdatedControls>
         <telerik:AjaxUpdatedControl ControlID="Coupon" />
         <telerik:AjaxUpdatedControl ControlID="RadGrid3" />
     </UpdatedControls>
 </telerik:AjaxSetting>

                        <telerik:AjaxSetting AjaxControlID="CouponOK">
    <UpdatedControls>
        <telerik:AjaxUpdatedControl ControlID="lblCollectedCoupon" />
    </UpdatedControls>
</telerik:AjaxSetting>



        </AjaxSettings>
    </telerik:RadAjaxManager>




    <div class="card-body" style="padding: 20px; background-color: white;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">
                        <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin;">

                            <div class="kt-portlet__head-actions col-lg-12 row">
                                <div class="col-lg-12 row" style="font-size: 15px; margin-bottom: 20px;">
                                    <div class="col-lg-3 " style="padding-left: 25px;">

                                        <label style="padding-top: 5px;">Route : </label>

                                        <asp:Label ID="lblRoute" runat="server" Style="font-weight: 600; padding-top: 5px;"></asp:Label>

                                    </div>
                                    <div class="col-lg-3 ">

                                        <label style="padding-top: 5px;">Serial No : </label>


                                        <asp:Label ID="lblProcessID" runat="server" Style="font-weight: 600; padding-top: 5px;"></asp:Label>

                                    </div>

                                    <div class="col-lg-3 " style="padding-left: 25px;">

                                        <label style="padding-top: 5px;">Date: </label>


                                        <asp:Label ID="lblDate" runat="server" Style="font-weight: 600; padding-top: 5px;"></asp:Label>

                                    </div>

                                    <div class="col-lg-3 " style="padding-left: 25px;">

                                        <label style="padding-top: 5px;">Settlement: </label>

                                        <asp:Label ID="lblSettlemetStatus" runat="server" Style="font-weight: 600; padding-top: 5px;"></asp:Label>
                                        <br>
                                        <asp:Label ID="lblsettlementInfo" runat="server" Style="font-weight: 200; padding-top: 5px;"></asp:Label>

                                    </div>


                                </div>

                            </div>
                        </div>
                        <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                            <Items>
                                <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                    <ContentTemplate>
                                        <div class="col-lg-12 row mb-2 pt-4" style="margin-left: 10px;">

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg id="Group_1833" data-name="Group 1833" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <path id="Path_1746" data-name="Path 1746" d="M0,0H17V17H0Z" fill="none" fill-rule="evenodd" />
                                                        <path id="Path_1747" data-name="Path 1747" d="M10.833,8.667a2.833,2.833,0,1,1,2.833-2.833A2.833,2.833,0,0,1,10.833,8.667Z" transform="translate(-2.333 -0.875)" fill="#6092aa" opacity="0.3" />
                                                        <path id="Path_1748" data-name="Path 1748" d="M3,18.1C3.275,14.719,6.019,13,9.363,13c3.391,0,6.178,1.624,6.385,5.1a.487.487,0,0,1-.532.567H3.515A.784.784,0,0,1,3,18.1Z" transform="translate(-0.875 -3.792)" fill="#6092aa" />
                                                    </svg>

                                                </span>
                                                <%--<img src="../assets/media/UDP/User.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">User:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                            <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                            <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--  <img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                            <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                            <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Process Complete:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblProcess" Font-Bold="true" runat="server">  </asp:Label></label>
                                            </div>
                                            <asp:PlaceHolder runat="server" ID="pnlaprv" Visible="false">
                                                <div class="col-sm-3">
                                                    <asp:LinkButton ID="btnapprv" runat="server" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Approve' OnClick="btnapprv_Click"
                                                        CssClass="btn btn-sm fw-bold btn-success" />

                                                </div>
                                            </asp:PlaceHolder>

                                        </div>
                                        <div class="col-lg-12 row mb-4 py-4 " style="border-bottom-style: ridge; border-bottom-width: thin; margin-left: 10px;">

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg id="Group_1825" data-name="Group 1825" xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <rect id="Rectangle_959" data-name="Rectangle 959" width="17" height="17" fill="none" />
                                                        <path id="Path_1738" data-name="Path 1738" d="M15.11,13.72,11,9.61V3.742a.742.742,0,1,1,1.483,0V9l3.676,3.676,1.623-1.623a.371.371,0,0,1,.633.262v3.925a.371.371,0,0,1-.371.371H14.12a.371.371,0,0,1-.262-.633Z" transform="translate(-2.395 -1.255)" fill="#6092aa" />
                                                        <path id="Path_1739" data-name="Path 1739" d="M6.155,16.116,7.639,17.6a.371.371,0,0,1-.262.633H3.4a.371.371,0,0,1-.371-.371V13.885a.371.371,0,0,1,.633-.262L5.1,15.063l2.246-1.9L8.306,14.3Z" transform="translate(-0.335 -3.882)" fill="#6092aa" opacity="0.3" />
                                                    </svg>

                                                </span>
                                                <%-- <img src="../assets/media/UDP/version.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Version:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1826" data-name="Group 1826" transform="translate(0.062)">
                                                            <rect id="Rectangle_960" data-name="Rectangle 960" width="17" height="17" transform="translate(-0.062)" fill="none" />
                                                            <path id="Path_1740" data-name="Path 1740" d="M9.375,16.75a6.375,6.375,0,1,1,6.375-6.375A6.375,6.375,0,0,1,9.375,16.75Z" transform="translate(-0.756 -1.167)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1741" data-name="Path 1741" d="M11.691,7.5h.06a.354.354,0,0,1,.352.319l.322,3.223,2.3,1.315a.354.354,0,0,1,.178.308v.149a.27.27,0,0,1-.342.261l-3.272-.892a.354.354,0,0,1-.26-.369l.307-3.985A.354.354,0,0,1,11.691,7.5Z" transform="translate(-3.098 -2.188)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>

                                            <div class="col-sm-3">
                                                <span class="svg-icon svg-icon-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
                                                        <g id="Group_1828" data-name="Group 1828" transform="translate(-0.305)">
                                                            <rect id="Rectangle_961" data-name="Rectangle 961" width="17" height="17" transform="translate(0.305)" fill="none" />
                                                            <path id="Path_1742" data-name="Path 1742" d="M9.667,16.333a5.667,5.667,0,1,1,5.667-5.667A5.667,5.667,0,0,1,9.667,16.333Z" transform="translate(-1.167 -1.458)" fill="#6092aa" fill-rule="evenodd" opacity="0.3" />
                                                            <path id="Path_1743" data-name="Path 1743" d="M11.833,4.169a5.744,5.744,0,0,0-1.417,0V3.417H9.708A.708.708,0,0,1,9.708,2h2.833a.708.708,0,1,1,0,1.417h-.708Z" transform="translate(-2.625 -0.583)" fill="#6092aa" fill-rule="evenodd" />
                                                            <path id="Path_1744" data-name="Path 1744" d="M16.71,6.206l.585-.585a.708.708,0,1,1,1,1l-.554.554A5.7,5.7,0,0,0,16.71,6.206Z" transform="translate(-4.874 -1.579)" fill="#6092aa" fill-rule="evenodd" />
                                                            <path id="Path_1745" data-name="Path 1745" d="M11.694,7.5h.052a.354.354,0,0,1,.353.327l.3,3.9a.354.354,0,0,1-.326.38h-.679a.354.354,0,0,1-.354-.354c0-.009,0-.018,0-.027l.3-3.9A.354.354,0,0,1,11.694,7.5Z" transform="translate(-3.22 -2.187)" fill="#6092aa" fill-rule="evenodd" />
                                                        </g>
                                                    </svg>

                                                </span>
                                                <%--<img src="../assets/media/UDP/duration.png" class="img-responsive" style="height: 20px;" alt="Image">--%>
                                                <label class="col-lg-2 col-form-label" style="display: contents;">Duration:</label>
                                                <label class="col-lg-4 col-form-label" style="display: contents;">
                                                    <asp:Label ID="lblDuration" Font-Bold="true" runat="server"></asp:Label></label>
                                            </div>
                                            <asp:PlaceHolder runat="server" ID="pnlrjct" Visible="false">
                                                <div class="col-sm-3">
                                                    <asp:LinkButton ID="lnkreject" runat="server" UseSubmitBehavior="false" Text='<i class="icon-ok"></i>Reject' OnClick="lnkreject_Click"
                                                        CssClass="btn btn-sm fw-bold btn-secondary" />

                                                </div>
                                            </asp:PlaceHolder>


                                        </div>

                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>


                        <div class="kt-portlet__body">
                            <div class="col-lg-12 row">

                                <div class="demo-container size-medium">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                        <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server" Height="700px" OnFinishButtonClick="RadWizard1_FinishButtonClick">


                                            <Localization Finish="Settle" />

                                            <WizardSteps>
                                                <telerik:RadWizardStep Title="Orders Report">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title" style="font-size: larger;">Order Report</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total Orders :
                                                            <asp:Label ID="lblOrderCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">Total Amount :
                                                                <asp:Label ID="lblOrderAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvOrders" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvOrders_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="ord_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="OrderID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Order#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="OrderID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="ord_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="ord_GrandTotal">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="Credit Invoices">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title" style="font-size: larger;">Credit Invoices</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total Credit :
                                                            <asp:Label ID="lblCreditCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">Total Credit Amount :
                                                                <asp:Label ID="lblCreditAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvCredit" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvCredit_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="inv_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void" Display="false">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="Cash Invoices">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title" style="font-size: larger;">Cash Invoices</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total Cash :
                                                            <asp:Label ID="lblCashCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">Total Cash Amount :
                                                                <asp:Label ID="lblCashAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvCash" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvCash_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="inv_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="inv_InvoiceID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Invoice#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_InvoiceID">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_PayMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_PayMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="inv_GrandTotal" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="inv_GrandTotal">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void" Display="false">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="AR Collections">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title" style="font-size: larger;">AR Collection</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total AR :
                                                            <asp:Label ID="lblARCount" runat="server"></asp:Label></span>
                                                            </div>

                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">Total AR Amount :
                                                                <asp:Label ID="lblARAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvAR" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvAR_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="arh_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="arh_ARNumber" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="AR#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_ARNumber">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="arh_PayType" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_PayType">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="arh_CollectedAmount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="arh_CollectedAmount">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void" Display="false">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="Advance Collections">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">Advance Collections</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total Advance :
                                                            <asp:Label ID="lblAdvanceCount" runat="server"></asp:Label></span>
                                                            </div>
                                                            <div class="col-lg-6" style="padding-left: 165px;">

                                                                <span style="padding-top: 18px;">Total Advance Amount :
                                                                <asp:Label ID="lblAdvanceAmount" runat="server"></asp:Label></span>

                                                            </div>
                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvAdvance" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvAdvance_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="adp_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="adp_Number" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Advance#" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_Number">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="cus_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="cus_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="dateTim" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Date & Time" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="dateTim">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="adp_PaymentMode" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Pay Mode" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_PaymentMode">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="adp_Amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="adp_Amount">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Void" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Void" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Void" Display="false">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <%--<telerik:RadWizardStep Title="Debit Note">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title">Debit Note</h6>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 row" style="margin-top: -30px; padding-top: 20px; margin-bottom: 20px;">
                                                            <div class="col-lg-6">
                                                                <span style="padding-top: 18px;">Total Debit Note Count :
                                                                <asp:Label ID="lblTotalDebitNoteCount" runat="server"></asp:Label></span>
                                                            </div>
                                                            <div class="col-lg-6" style="padding-left: 165px;">
                                                                <span style="padding-top: 18px;">Total Debit Note Amount :
                                                                <asp:Label ID="lblTotalDebitNoteAmount" runat="server"></asp:Label></span>
                                                            </div>

                                                        </div>
                                                        <div class="kt-portlet__body">
                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="grvDebitNote" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="grvDebitNote_NeedDataSource"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="sdd_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="prd_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="prd_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="80%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="prd_Name">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_HigherUOM" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Higher UOM" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherUOM">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_LowerUOM" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Lower UOM" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerUOM">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_HigherQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Higher Qty" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherQty">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_LowerQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Lower Qty" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerQty">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_HigherPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Higher Price" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_HigherPrice">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_LowerPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Lower Price" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_LowerPrice">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_TotalQty" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Qty" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_TotalQty">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="sdd_TotalPrice" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Total Price" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="sdd_TotalPrice">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>--%>

                                                <telerik:RadWizardStep Title="Initiation">
                                                    <div class="kt-portlet">
                                                        <div class="kt-portlet__head" style="border-bottom: 0px; margin-bottom: 15px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h6 class="kt-portlet__head-title" style="font-size: larger;">Initiation</h6>
                                                            </div>
                                                        </div>

                                                        <div class="kt-portlet__body">

                                                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                                                ID="RadGrid1" GridLines="None"
                                                                ShowFooter="True" AllowSorting="True"
                                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                                OnItemDataBound="RadGrid1_ItemDataBound"
                                                                AllowFilteringByColumn="false"
                                                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                EnableAjaxSkinRendering="true"
                                                                AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                    ShowFooter="false" DataKeyNames="str_ID"
                                                                    EnableHeaderContextMenu="true">
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="Remarks" AllowFiltering="true" HeaderStyle-Width="50px"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remark" FilterControlWidth="40%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Remarks">
                                                                        </telerik:GridBoundColumn>


                                                                        <telerik:GridBoundColumn DataField="Image" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                                            HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                            HeaderStyle-Font-Bold="true" UniqueName="Image">
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Attached Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>


                                                                        <%--<telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>

                                                    <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("Image") %>' Target="_blank">
                                                        <asp:Image ID="satImage" runat="server" ImageUrl=' <%# "../" + Eval("Image") %>' Height="20px" Width="20px" />
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                                                                    </Columns>
                                                                </MasterTableView>
                                                                <PagerStyle AlwaysVisible="true" />
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                    <Resizing AllowColumnResize="true"></Resizing>
                                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                                <telerik:RadWizardStep Title="Payment" CssClass="loginStep" Selected="true">
                                                    <div class="kt-portlet">




                                                        <div class="kt-portlet__head" style="border-bottom: 0px;">
                                                            <div class="kt-portlet__head-label">
                                                                <h3 class="kt-portlet__head-title">Payment</h3>
                                                            </div>
                                                        </div>
                                                        <div class="kt-portlet__body" style="padding-top: 0px;">
                                                            <div class="col-lg-12 row">
                                                                <div class="col-lg-12 row" style="border-bottom: 1px solid darkgrey; padding-bottom: 10px;">
                                                                    <div class="col-lg-5" style="border-right: 1px solid darkgrey;">
                                                                        <table class="col-lg-12">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 600;">Cash</th>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 600;">:</th>
                                                                                    <th style="padding-bottom: 10px; color: green; font-weight: 600; text-align: right">
                                                                                        <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblPCash" runat="server"></asp:Label>
                                                                                    </th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Cash Invoices</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="Label2" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblPCashInvoices" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">AR Collection Cash</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="Label3" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblPArCollectionCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Advance Collection Cash</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="Label4" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblPAdvanceCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Inventory Variance - Debit Note</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="Label7" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblDebitNote" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Cumulative Variance</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="Label8" runat="server" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lblPendingBalance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>

                                                                                <tr class="mt-2">
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Petty Cash</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblpettycash1" runat="server"></asp:Label>
                                                                                    </td>



                                                                                </tr>
                                                                                <asp:PlaceHolder ID="ddlPettycash" runat="server" Visible="false">
                                                                                    <tr>
                                                                                        <td style="padding-bottom: 5px; font-size: 14px;">

                                                                                            <asp:Button ID="btnpettycash" runat="server" Text="Add Petty Cash" OnClick="btnpettycash_Click" CssClass="btn btn-sm " Style="background-color: #cda866; color: white; padding: 10px 10px; font-size: 11px; border-radius: 5px;" />
                                                                                    </tr>
                                                                                </asp:PlaceHolder>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="col-lg-7">

                                                                        <table class="col-lg-12">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th style="padding-bottom: 10px;">Total Cash</th>
                                                                                    <th></th>
                                                                                    <th></th>
                                                                                    <th style="padding-bottom: 10px;">Received Amount</th>
                                                                                    <th style="padding-bottom: 10px;">Variance 
                                                                                         
                                                                                   <%--  <asp:Button ID="btnPreviousVariances" runat="server" Text="History" OnClick="btnPreviousVariances_Click" CssClass="btn btn-sm btn-success" style="padding: 5px 5px; font-size: 10px; border-radius: 5px;"/>
                                                                                   --%>     
                                                                                    </th>

                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Hard Cash</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblHardCash" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapHardCash" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtHardCash" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true"
                                                                                                EmptyMessage="0.00" OnTextChanged="txtHardCash_TextChanged" Skin="Silk" Style="text-align: right;">
                                                                                                <NumberFormat AllowRounding="true" DecimalDigits="2" />
                                                                                            </telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblHardCashVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">POS</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblPOS" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapPos" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtPos" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true" 
                                                                                                EmptyMessage="0.00" OnTextChanged="txtPos_TextChanged" Skin="Silk" Style="text-align: right;">
                                                                                                <NumberFormat AllowRounding="true" DecimalDigits="2" />
                                                                                            </telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblPOSVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Online Payment</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblOnlinePayment" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <telerik:RadAjaxPanel ID="rapOnlinePay" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                                                                                            <telerik:RadNumericTextBox ID="txtOnlinePayment" runat="server" CssClass="form-control" Width="80%" AutoPostBack="true"
                                                                                                EmptyMessage="0.00" Skin="Silk" OnTextChanged="txtOnlinePayment_TextChanged" Style="text-align: right;">
                                                                                                <NumberFormat AllowRounding="true" DecimalDigits="2" />
                                                                                            </telerik:RadNumericTextBox>
                                                                                        </telerik:RadAjaxPanel>
                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblOnlinePaymentVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <%--</tr>

                                                                             
                                                                                   <tr class="mt-2">
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Petty Cash</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">:</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400;">
                                                                                        <asp:Label ID="lblpettycash" runat="server"></asp:Label>
                                                                                    </td>
                                 

                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">
                                                                                        <asp:Label ID="Label10" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>--%>


                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;"></td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;"></td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;"></td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Total Variance :</td>
                                                                                     <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblTotalVariance" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">

                                                                                        <asp:Button ID="Button1" runat="server" Text="Previous Variances" OnClick="btnPreviousVariances_Click" CssClass="btn btn-sm" Style="background-color: #6796b8; color: white; padding: 10px 10px; font-size: 11px; border-radius: 5px;" />

                                                                                    </td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;"></td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;"></td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px;">Variance Limit :</td>
                                                                                    <td style="padding-bottom: 5px; font-size: 14px; font-weight: 400; text-align: right">
                                                                                        <asp:Label ID="lblvarlimit" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>


                                                                            </tbody>

                                                                        </table>

                                                                        <asp:Label ID="lblsuc" Style="font-family: 'Segoe UI'; color: green;" runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                 <asp:Panel ID="pnlcoupen" runat="server">
                                                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px; border-bottom: 1px solid darkgrey;">
     <div class="col-lg-5">
         <div class="col-lg-12 row" style="padding-left: 0px;">
             <div class="col-lg-5" style="padding-left: 10px; padding-right: 0px;">
                 <span style="font-size: 14px; color: green; font-weight: 500;">Total Coupon Redeemed </span>
             </div>
             <div class="col-lg-1">
                 <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
             </div>
             <div class="col-lg-6">
                 <span style="font-size: 14px; color: green; font-weight: 500;">
                     <asp:Label ID="Label9" runat="server" Visible="false"></asp:Label>
                     <asp:Label ID="lblRedeemedCoupon" runat="server" Text="0"></asp:Label></span>
             </div>
         </div>
     </div>
     <div class="col-lg-3">
         <div class="col-lg-12 row" style="padding-left: 0px;">
             <div class="col-lg-6" style="padding-left: 0px; padding-right: 0px;">
                 <span style="font-size: 14px; color: green; font-weight: 500;"> Coupon Collected </span>
             </div>
             <div class="col-lg-1">
                 <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
             </div>
             <div class="col-lg-5">
                 <span style="font-size: 14px; color: green; font-weight: 500;">
                     <asp:Label ID="Label11" runat="server" Visible="false"></asp:Label>
                     <asp:Label ID="lblCollectedCoupon" runat="server" Text="0"></asp:Label></span>
             </div>
         </div>
     </div>
    <div class="col-lg-2">
         <asp:LinkButton runat="server" ID="lnkCollectCoupon" CssClass="btn btn-sm col-lg-12" ForeColor="White" BackColor="YellowGreen" OnClick="lnkCollectCoupon_Click">
     <div class="col-lg-12 row">
         <div class="col-lg-12">
            <span style="font-size: 14px; color: white; font-weight: 500;">Collect Coupon</span>
         </div>
     </div>
          </asp:LinkButton>
 </div>

 </div>
        </asp:Panel>
                                                                <div class="col-lg-12 row" style="padding-top: 20px; padding-bottom: 20px;">
                                                                    <div class="col-lg-6">
                                                                        <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                            <div class="col-lg-5" style="padding-left: 10px; padding-right: 0px;">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">AR Collection Cheque</span>
                                                                            </div>
                                                                            <div class="col-lg-1">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">
                                                                                    <asp:Label ID="Label5" runat="server" Visible="false"></asp:Label>
                                                                                    <asp:Label ID="lblARCollCheque" runat="server"></asp:Label></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <div class="col-lg-12 row" style="padding-left: 0px;">
                                                                            <div class="col-lg-6" style="padding-left: 0px; padding-right: 0px;">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">Advance Collection Cheque</span>
                                                                            </div>
                                                                            <div class="col-lg-1">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">:</span>
                                                                            </div>
                                                                            <div class="col-lg-5">
                                                                                <span style="font-size: 14px; color: green; font-weight: 500;">
                                                                                    <asp:Label ID="Label6" runat="server" Visible="false"></asp:Label>
                                                                                    <asp:Label ID="lblAdvCollCheque" runat="server"></asp:Label></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                                                    ID="grvPayment" GridLines="None"
                                                                    ShowFooter="True" AllowSorting="True"
                                                                    OnNeedDataSource="grvPayment_NeedDataSource"
                                                                    OnItemCommand="grvPayment_ItemCommand"
                                                                    OnItemDataBound="grvPayment_ItemDataBound"
                                                                    AllowFilteringByColumn="false"
                                                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                                                    EnableAjaxSkinRendering="true"
                                                                    AllowPaging="true" PageSize="10" CellSpacing="0">
                                                                    <ClientSettings>
                                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                        <ClientEvents OnRowClick="OnRowClick" />
                                                                    </ClientSettings>
                                                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                                        ShowFooter="false" DataKeyNames="id"
                                                                        EnableHeaderContextMenu="true">
                                                                        <Columns>

                                                                            <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="name" AllowFiltering="true" HeaderStyle-Width="30px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="name">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="type" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="type">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="bnk_Name" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Bank" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="bnk_Name">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="bnk_ID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Bank" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="bnk_ID" Display="false">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="chequeNo" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Cheque#" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="chequeNo">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="chequeDate" AllowFiltering="true" HeaderStyle-Width="20px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Cheque Date" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="chequeDate">
                                                                            </telerik:GridBoundColumn>


                                                                            <telerik:GridBoundColumn DataField="image" AllowFiltering="true" HeaderStyle-Width="100px" Display="false"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="" FilterControlWidth="100%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="image">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridTemplateColumn HeaderStyle-Width="10px" HeaderText="Cheque Image" UniqueName="ImagesCheque" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                                                <ItemTemplate>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>


                                                                            <%--<telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" HeaderText="Image" HeaderStyle-Width="10px" HeaderStyle-Font-Size="Smaller"
                                                                                HeaderStyle-Font-Bold="true">
                                                                                <ItemTemplate>
                                                                                    <asp:HyperLink ID="Img" runat="server" NavigateUrl=' <%#  Eval("image") %>' Target="_blank">
                                                                                        <asp:Image ID="Image" runat="server" ImageUrl=' <%#  Eval("image") %>' Height="65px" />
                                                                                    </asp:HyperLink>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>--%>

                                                                            <telerik:GridBoundColumn DataField="amount" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="amount">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="colID" AllowFiltering="true" HeaderStyle-Width="10px"
                                                                                HeaderStyle-Font-Size="Smaller" HeaderText="id" FilterControlWidth="40%"
                                                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                                                HeaderStyle-Font-Bold="true" UniqueName="colID" Display="false">
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridClientSelectColumn HeaderStyle-Width="10px" UniqueName="chkAll">
                                                                            </telerik:GridClientSelectColumn>

                                                                        </Columns>
                                                                    </MasterTableView>
                                                                    <PagerStyle AlwaysVisible="true" />
                                                                    <GroupingSettings CaseSensitive="false" />
                                                                    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                                                        <Resizing AllowColumnResize="true"></Resizing>
                                                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                                                    </ClientSettings>
                                                                </telerik:RadGrid>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </telerik:RadWizardStep>
                                            </WizardSteps>
                                        </telerik:RadWizard>
                                    </telerik:RadAjaxPanel>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to update..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="btnSave" runat="server" Text="Yes" OnClick="btnSave_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm btn-primary" />

                        <button class="btn btn-secondary" onclick="cancelModal(modalConfirm);">
                            Cancel
                        </button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
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
    <div class="modal fade modal-center" id="modalAprvConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="AprvConfirm">Are you sure you want to approve..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel12" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkAprvConfirm" runat="server" Text="Yes" OnClick="lnkAprvConfirm_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />

                        <button class="btn btn-secondary" onclick="cancelModal(modalAprvConfirm);">
                            Cancel
                        </button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel11" EnableEmbeddedSkins="false"
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
    <div class="modal fade modal-center" id="modalrjctConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="RjctConfirm">Are you sure you want to Reject..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel13" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkrjectaprv" runat="server" Text="Yes" OnClick="lnkrjectaprv_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm" />

                        <button class="btn btn-secondary" onclick="cancelModal(modalrjctConfirm);">
                            Cancel
                        </button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel12" EnableEmbeddedSkins="false"
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


    <div class="modal fade modal-center" id="modalConfirm2" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm2">Do you want to continue settlement here..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel10">
                        <asp:LinkButton ID="btnsttl" runat="server" Text="Yes" OnClick="btnSave_Click" CssClass="btn btn-brand btn-elevate btn-icon-sm btn-primary" />

                        <button class="btn btn-secondary" onclick="cancelModal(modalConfirm2);">
                            Cancel
                        </button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel10" EnableEmbeddedSkins="false"
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
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>




    <div class="modal fade" id="kt_modal_1_44" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    Bank Details Updated Successfully
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="btnOK_Click" CssClass="btn btn-secondary">OK</asp:LinkButton>
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
                    <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
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
    <!--end::FailedModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_6" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span>Received cash cannot be greater than </span><span id="failres"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_6);">Ok</button>
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
    <!--end::FailedModal-->
    <div class="modal fade" id="kt_modal_1_2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failmsg"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel9" runat="server" LoadingPanelID="RadAjaxLoadingPanel8">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_2);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel8" EnableEmbeddedSkins="false"
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

    <!--begin::LoadOutNotDoneModal-->
    <div class="modal fade" id="kt_modal_1_7" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Process not complete..!</h5>
                </div>
                <div class="modal-body">
                    <span><span id="loadOut"></span></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_7);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
    <!--end::FailedModal-->

    <!--begin::LoadOutNotDoneModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cheque count missmatch</h5>
                </div>
                <div class="modal-body">
                    <span>Please select all the cheque and try again.</span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <button class="btn btn-secondary" onclick="cancelModal(kt_modal_1_8);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

    <div class="modal fade" id="Variance" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 800px">
                <div class="modal-header">
                    <h5 class="modal-title">Previous Variances</h5>
                </div>
                <div class="modal-body">
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel8" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                    <div class="col-lg-4" style="padding-bottom: 10px">
                                        <label class="control-label col-lg-12">From Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" Skin="Silk">
                                            </telerik:RadDatePicker>

                                            <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                                            --%>
                                        </div>
                                    </div>

                                    <div class="col-lg-4" style="padding-bottom: 10px">
                                        <label class="control-label col-lg-12">To Date</label>
                                        <div class="col-lg-12">
                                            <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" Skin="Silk">
                                            </telerik:RadDatePicker>
                                            <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                                                Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                                            <%--     <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                                            --%>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 pt-2" style="text-align: center;">
                                        <asp:LinkButton ID="Filtr" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" CausesValidation="false" OnClick="Filtr_Click">
                                            Apply Filter
                                        </asp:LinkButton>
                                    </div>

                                </div>
                                <div class="col-lg-12 pt-3">

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="RadGridSuccess" GridLines="None"
                                        AllowSorting="True"
                                        OnNeedDataSource="RadGridSuccess_NeedDataSource"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="udp_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>



                                                <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Date&Time" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="sda_Variance" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Variance" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="sda_Variance">
                                                </telerik:GridBoundColumn>



                                            </Columns>
                                        </MasterTableView>
                                        <PagerStyle AlwaysVisible="true" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel7" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel7" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">
                        <button class="btn btn-secondary" onclick="cancelModal(Variance);">Ok</button>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
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


    <div class="modal fade" id="pettycash" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 800px">
                <div class="modal-header">
                    <h5 class="modal-title">Petty Cash</h5>


                    <asp:LinkButton ID="btnDone" type="button" runat="server" class="btn btn-sm fw-bold btn-success align-content-end" OnClick="btnDone_Click">Done</asp:LinkButton>





                </div>
                <div class="modal-body">
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                        <div class="col-lg-12 form-group">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel10" runat="server" LoadingPanelID="RadAjaxLoadingPanel7">
                                <div class=" col-lg-12 row" style="padding-bottom: 10px">

                                    <div class="col-lg-12 row">






                                        <div class="col-lg-6">
                                            <label class="control-label col-lg-12">Description</label>
                                            <div class="col-lg-12">
                                                <textarea id="txtDEC" runat="server" rows="4" cols="70" class="form-control" causesvalidation="false"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">

                                            <div class="col-lg-12 row form-group" style="padding-bottom: 15px;">
                                                <label class="control-label col-lg-12">Image</label>
                                                <asp:HiddenField ID="txt1" runat="server" Value="Overall claim picture" />
                                                <label style="color: #464646; font-size: smaller; margin-left: 11px;">Only .jpeg / jpg files are allowed with maximum size 6MB</label>
                                                <br />
                                                <div class="col-lg-12 row" style="margin-left: 5px;">
                                                    <telerik:RadAsyncUpload RenderMode="Lightweight" runat="server" MaxFileInputsCount="1"
                                                        ID="upd1" AllowedFileExtensions=".jpeg,.jpg,.JPEG,.JPG" MultipleFileSelection="Disabled" MaxFileSize="6242880"
                                                        UploadedFilesRendering="BelowFileInput" HideFileInput="true" Width="100px" Skin="Silk" OnClientValidationFailed="OnClientValidationFailed"
                                                        OnClientFileUploadRemoved="OnClientFileUploadRemoved1" OnClientFileSelected="OnClientFileSelected1"
                                                        Style="padding: 10px; text-align: center; padding-bottom: 10px;">
                                                        <Localization Select="Browse Image" />
                                                        <FileFilters>
                                                            <telerik:FileFilter Description="" Extensions=".jpeg,.jpg,.JPEG,.JPG" />
                                                        </FileFilters>
                                                    </telerik:RadAsyncUpload>
                                                    <div class="col-lg-12 mt-2">
                                                        <asp:HiddenField ID="hlval1" runat="server" />

                                                    </div>
                                                    <%--<i class="fas fa-upload " style="color: black; height: 10px; padding-top: 15px; margin-left: 30px; margin-top: 1px"></i>--%>
                                                    <%--</asp:LinkButton>--%>
                                                </div>

                                                <%--<img src="http://ctt.trains.com/sitefiles/images/no-preview-available.png" id="img1" height="100" width="100" style="margin-top: 10px" alt="Preview image here" />--%>
                                            </div>


                                            <div class="col-lg-12 row ">
                                                <div class="col-lg-10 mb-5 ">
                                                    <label class="control-label col-lg-12">Amount</label>
                                                    <div class="col-lg-12 ">
                                                        <telerik:RadNumericTextBox ID="txtamount" runat="server" CssClass="form-control" NumberFormat-AllowRounding="false" Width="70%" RenderMode="Lightweight" Skin="Silk"></telerik:RadNumericTextBox>

                                                    </div>
                                                </div>
                                                <div class="col-lg-2 mt-2">
                                                    <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-sm fw-bold btn-primary align-content-end" OnClick="lnkSave_Click">
                                                  Add
                                                    </asp:LinkButton>
                                                </div>


                                            </div>
                                        </div>



                                    </div>



                                </div>










                                <div class="col-lg-12 pt-3">

                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                        ID="RadGrid2" GridLines="None"
                                        AllowSorting="True"
                                        OnNeedDataSource="RadGrid2_NeedDataSource"
                                        OnItemCommand="RadGrid2_ItemCommand"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="pcs_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>



                                                <telerik:GridBoundColumn DataField="pcs_Desc" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Description" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pcs_Desc">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="pcs_AmountFromApp" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Amount" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="pcs_AmountFromApp">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="Image" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                    <ItemTemplate>

                                                        <asp:HyperLink ID="img1" runat="server" NavigateUrl=' <%#"../" +  Eval("pcs_Image") %>' Target="_blank">
                                                            <asp:Image ID="salImage" runat="server" ImageUrl=' <%# "../" + Eval("pcs_Image") %>' Height="20px" Width="20px" />
                                                        </asp:HyperLink>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridButtonColumn CommandName="Delete" Text='<i class="fa fa-close"></i>' Visible="true" runat="server" HeaderStyle-Width="50px" EditFormColumnIndex="0" UniqueName="Delete" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                </telerik:GridButtonColumn>


                                            </Columns>
                                        </MasterTableView>
                                        <PagerStyle AlwaysVisible="true" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                            <Resizing AllowColumnResize="true"></Resizing>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel9" EnableEmbeddedSkins="false"
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

        </div>
    </div>


    <div class="modal fade" id="kt_modal" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="succeses"></span>

                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="modalConfirm1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 700px">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Cheque </h5>
                </div>

                <div class="modal-body">

                    <div class="col-lg-12 row">

                        <div class="col-lg-4 pt-4">
                            <label class="control-label col-lg-12">Cheque</label>
                            <div class="col-lg-12 ">
                                <asp:TextBox ID="ddltext" runat="server" Skin="Silk" CssClass="form-control" Width="100%"></asp:TextBox>
                            </div>
                        </div>




                        <div class="col-lg-4  pt-4 mt-2">
                            <label class="control-label col-lg-12">Bank Name</label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="RDbank" runat="server" EmptyMessage="Select Bank" Filter="Contains" RenderMode="Lightweight" Skin="Silk" Width="100%"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="form"
                                    ControlToValidate="RDbank" ErrorMessage="Please select Bank" ForeColor="Red" Display="Dynamic"
                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="col-lg-4 pt-4 mt-3">
                            <label class="control-label col-lg-12">Cheque Date</label>
                            <div class="col-lg-12">
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="RadDatePicker1" Skin="Silk" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%">
                                </telerik:RadDatePicker>


                            </div>
                        </div>


                        <%--   <div class="col-lg-4 pt-4">
                            <label class="control-label col-lg-12">Amount<span class="required"></span></label>
                            <div class="col-lg-12 ">
                                 <telerik:RadNumericTextBox  ID="ddlamt" runat="server" CssClass="form-control" NumberFormat-AllowRounding="false"  DecimalDigits="0" Width="70%" RenderMode="Lightweight" Skin="Silk"></telerik:RadNumericTextBox>
                            
                            </div>
                        </div>--%>
                    </div>





                </div>
                <div class="modal-footer">

                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-sm fw-bold btn-primary" ValidationGroup="form" CausesValidation="true" OnClick="LinkButton2_Click">
                                                  Save
                    </asp:LinkButton>
                    <br />
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modalConfirm1);">Cancel</button>

                </div>



            </div>






        </div>
    </div>

     <div class="modal fade" id="Coupon" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content" style="width: 800px">
             <div class="modal-header">
                 <h5 class="modal-title">Coupon</h5>
             </div>
             <div class="modal-body">
                 <div class="col-lg-12 row" style="padding-top: 10px;">
                     <div class="col-lg-12 form-group">
                         <telerik:RadAjaxPanel ID="RadAjaxPanel14" runat="server" LoadingPanelID="RadAjaxLoadingPanel13">
                           
                             <div class="col-lg-12 pt-3">

                                 <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                     ID="RadGrid3" GridLines="None"
                                     AllowSorting="True"
                                     OnNeedDataSource="RadGrid3_NeedDataSource"
                                     ClientSettings-Resizing-ClipCellContentOnResize="true"
                                     EnableAjaxSkinRendering="true"
                                     AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                     <ClientSettings>
                                         <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="200px"></Scrolling>
                                     </ClientSettings>
                                     <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                         ShowFooter="false" DataKeyNames="csi_ID"
                                         EnableHeaderContextMenu="true">
                                         <Columns>

                                             <telerik:GridBoundColumn DataField="cbl_LeafNumber" AllowFiltering="true" HeaderStyle-Width="100px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Leaf Number" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="cbl_LeafNumber">
                                             </telerik:GridBoundColumn>
                                              
                                             <telerik:GridBoundColumn DataField="csi_cpb_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="csi_cpb_ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csi_cpb_ID" Display="false">
                                            </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="csi_cpl_ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="csi_cpl_ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="csi_cpl_ID" Display="false">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridClientSelectColumn HeaderStyle-Width="40px" UniqueName="chkAll"></telerik:GridClientSelectColumn>

                                         </Columns>
                                     </MasterTableView>
                                     <PagerStyle AlwaysVisible="true" />
                                     <GroupingSettings CaseSensitive="false" />
                                     <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="True">
                                         <Resizing AllowColumnResize="true"></Resizing>
                                         <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"></Selecting>
                                     </ClientSettings>
                                 </telerik:RadGrid>
                             </div>
                         </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel13" EnableEmbeddedSkins="false"
                             BackColor="Transparent"
                             ForeColor="Blue">
                             <div class="col-lg-12 text-center mt-5">
                                 <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                             </div>
                         </telerik:RadAjaxLoadingPanel>
                     </div>
                 </div>
             </div>
             <div class="modal-footer">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel15" runat="server" LoadingPanelID="RadAjaxLoadingPanel14">
                     <asp:LinkButton runat="server" class="btn btn-primary" id="CouponOK" onclick="CouponOK_Click">Ok</asp:LinkButton>
                 </telerik:RadAjaxPanel>
                 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel14" EnableEmbeddedSkins="false"
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
    <!--end::FailedModal-->
</asp:Content>
