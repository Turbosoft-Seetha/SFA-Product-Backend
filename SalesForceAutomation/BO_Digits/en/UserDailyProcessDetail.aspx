<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="UserDailyProcessDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.UserDailyProcessDetail" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function Succcess() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
        }
        function Failure(res) {
            $('#modalConfirm').modal('hide');
            $('#FailureAlert').modal('show');
            $('#failres').text(res);
            x++;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">




    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlEndorsement" />
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
                        <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin;">

                            <div class="kt-portlet__head-actions col-lg-12 row">
                                <div class="col-lg-6">
                                    <h3 class="card-title text-gray-800">
                                        <asp:Repeater runat="server" ID="rptRoute">
                                            <ItemTemplate>
                                                Route &nbsp;  
                                                <asp:Label ID="lblrot" runat="server" Text='<%# Eval("routeName") %>'> </asp:Label>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </h3>
                                </div>
                                <div class="col-lg-6 row" style="display: flex; justify-content: flex-end;">



                                    <div class="col-sm-1">
                                        <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                            <asp:PlaceHolder ID="pnlEndorsement" runat="server" Visible="false">
                                                <asp:ImageButton ID="Endorsement" Visible="false" ToolTip="Endorsement" AlternateText="Endorsement" Height="20" runat="server" OnClick="Endorsement_Click"
                                                    ImageUrl="../assets/media/UDP/endorsement.png"></asp:ImageButton>
                                            </asp:PlaceHolder>
                                        </telerik:RadAjaxPanel>
                                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                                            BackColor="Transparent"
                                            ForeColor="Blue">
                                            <div class="col-lg-12 text-center mt-5">
                                                <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                            </div>
                                        </telerik:RadAjaxLoadingPanel>

                                    </div>

                                    <asp:PlaceHolder ID="van" runat="server">
                                        <div class="col-sm-1">
                                            <asp:ImageButton ID="VanStock" Visible="true" ToolTip="Current VanStock" AlternateText="VanStock" Height="20" runat="server" OnClick="VanStock_Click"
                                                ImageUrl="../assets/media/svg/general/vanstock.png"></asp:ImageButton>

                                        </div>
                                    </asp:PlaceHolder>
                                    <div class="col-sm-1">
                                        <asp:ImageButton ID="LastRouteCom" Visible="true" ToolTip="LastRouteCommunication" AlternateText="LastRouteCommunication" Height="20" runat="server" OnClick="LastRouteCom_Click"
                                            ImageUrl="../assets/media/UDP/lastupdate.png"></asp:ImageButton>

                                    </div>
                                    <div class="col-sm-1">
                                        <asp:ImageButton ID="map" Visible="true" ToolTip="Map" AlternateText="Map" runat="server" Height="20" OnClick="map_Click"
                                            ImageUrl="../assets/media/UDP/tracking.png"></asp:ImageButton>
                                    </div>
                                    <%-- <div class="col-sm-1">
                                        <asp:ImageButton ID="Settlement" Visible="true" ToolTip="Chart" AlternateText="Chart" Height="20" runat="server" OnClick="Settlement_Click"
                                            ImageUrl="../assets/media/UDP/kpi.png"></asp:ImageButton>
                                    </div>--%>
                                    <asp:PlaceHolder ID="pnlSettlement" runat="server" Visible="true">
                                        <div class="col-sm-1">
                                            <asp:ImageButton ID="Imgsettlement" runat="server" ImageUrl="../assets/media/UDP/settlement.png" Height="20" ToolTip="Settlement" OnClick="Imgsettlement_Click" AlternateText="Xlsx" />
                                        </div>
                                    </asp:PlaceHolder>
                                    <div class="col-sm-1">
                                        <asp:ImageButton ID="Imgexcel" runat="server" ImageUrl="../assets/media/UDP/excel.png" Height="20" ToolTip="Download" OnClick="Imgexcel_Click" AlternateText="Xlsx" />
                                    </div>
                                     <asp:PlaceHolder ID="PdfClick" runat="server" Visible="false">
                                     <div class="col-sm-1">
                                              <asp:ImageButton ID="btnPDF" runat="server" ImageUrl="../assets/media/icons/file.png" Height="20" ToolTip="PDF" OnClick="btnPDF_Click" AlternateText="pdf" />
                                         </div>
                                         </asp:PlaceHolder>
                                    <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn" BackColor="#E2E5EE" OnClick="lnkCancel_Click" Visible="false">Cancel</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="kt-portlet__body pb-0" style="border-bottom-style: inset; border-bottom-width: thin;">


                                    <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                        <Items>
                                            <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                                <ContentTemplate>
                                                    <div class="col-lg-12 row mb-2 pt-4">

                                                        <div class="col-sm-4">
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

                                                        <div class="col-sm-4">
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

                                                        <div class="col-sm-4">
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
                                                    </div>
                                                    <div class="col-lg-12 row mb-4 py-4 " style="border-bottom-style: ridge; border-bottom-width: thin;">

                                                        <div class="col-sm-4">
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

                                                        <div class="col-sm-4">
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

                                                        <div class="col-sm-4">
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

                                                    </div>

                                                    <div class="col-lg-12 row mb-4 ps-2">

                                                        <div class="col-lg-4" style="font-size: large; opacity: 0.80">

                                                            <asp:Panel ID="code" runat="server" Visible="true">
                                                                <div class="m-2">
                                                                    <div class="" style="color: black; font-weight: bold;">
                                                                        <asp:Label ID="lblTotalVisits" runat="server"></asp:Label>
                                                                    </div>

                                                                    <div class="" style="color: black; font-weight: bold;">Customer visits</div>

                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                        <asp:Panel ID="cus" runat="server">
                                                            <div class="col-lg-12 row">
                                                                <div class="col-lg-4 mt-4">

                                                                    <div class="fs-2 fw-bold lh-1 pb-3" style="color: black; font-size: 17px;">
                                                                        <asp:Label ID="lblcode" runat="server"></asp:Label>

                                                                    </div>

                                                                    <div class="fs-3 fw-bold lh-1 pb-2" style="color: black; font-size: 17px;">

                                                                        <asp:Label ID="lblcusName" runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-8">
                                                                    <div class="col-lg-12 row" style="display: flex; justify-content: flex-end;">
                                                                        <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                            Start Time : 
                                                            <span class="">
                                                                <asp:Label ID="lblsTime" runat="server"></asp:Label>
                                                            </span>
                                                                        </div>

                                                                        <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                            End Time : 
                                                            <span class="">
                                                                <asp:Label ID="lbleTime" runat="server"></asp:Label>
                                                            </span>

                                                                        </div>

                                                                        <div class="col-sm-3 fs-7 mt-8" style="color: black; font-size: 13px; display: block;">
                                                                            Duration :
                                                                <span class="">
                                                                    <asp:Label ID="lbldurations" runat="server"></asp:Label>
                                                                </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </asp:Panel>




                                                    </div>

                                                    <div class="col-lg-12 row" style="margin-bottom: 15px;">


                                                        <div class="col-lg-12 mb-4">
                                                            <div class="card-body d-flex flex-column">
                                                                <!--begin::Row-->
                                                                <div class="row g-0">

                                                                    <!--begin::Col-->
                                                                    <asp:PlaceHolder ID="pnlInv" runat="server" Visible="false">
                                                                        <div class="col-4" style="border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin;border-left-style: dashed; border-left-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center mb-9 me-0">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="background-color: white; padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/udinvoice.png" alt="Invoice" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">


                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="lblTotalInvoice" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black; margin-right: 40px;"><asp:Label ID="lblInv" runat="server"></asp:Label></div>


                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkInvoices" runat="server" OnClick="lnkInvoices_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">

                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="RadImageButton3" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Col-->
                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlorders" runat="server" Visible="false">
                                                                        <div class="col-4" style="border-left-style: dashed; border-left-width: thin; border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center me-0">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/udorders.png" alt="Orders" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="lblTotalOrders" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"> <asp:Label ID="lblOrder" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkOrders" runat="server" OnClick="lnkOrders_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton2" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>


                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Col-->
                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlAR" runat="server" Visible="false">
                                                                        <!--begin::Col-->
                                                                        <div class="col-4" style="border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center mb-9 ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs022.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/udar.png" alt="AR" width="28" height="25" style="margin: 10px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="lblTotalAR" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black; margin-right: 40px;">  <asp:Label ID="lblAR" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkAr" runat="server" OnClick="lnkAr_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton3" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>


                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                        <!--end::Col-->
                                                                    </asp:PlaceHolder>
                                                                    <!--begin::Col-->
                                                                    <asp:PlaceHolder ID="pnladv" runat="server" Visible="false">
                                                                        <!--begin::Col-->
                                                                      <div class="col-4" style="border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">                                                                         
                                                                            <div class="d-flex align-items-center ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/udadvance.png" alt="AP" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="lblTotalAP" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"> <asp:Label ID="lblAdv" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkAp" runat="server" OnClick="lnkAp_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton5" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>


                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlInvMonit" runat="server" Visible="false">
                                                                        <div class="col-4" style="border-left-style: dashed; border-left-width: thin; border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center mb-9 ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/inventory.png" alt="merch" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"> <asp:Label ID="lblinvmonit" runat="server"></asp:Label> </div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkInvMonit" runat="server" OnClick="lnkInvMonit_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton1" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>

                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>

                                                                        <!--end::Col-->
                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlActMgmnt" runat="server" Visible="false">
                                                                        <!--begin::Col-->
                                                                        <div class="col-4" style="border-left-style: dashed; border-left-width: thin; border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center mb-9 ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs046.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/activity.png" alt="merch" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="Label3" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"> <asp:Label ID="lblActManag" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lblActMangmnt" runat="server" CssClass="d-flex justify-content-lg-end" OnClick="lblActMangmnt_Click">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton6" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>

                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>

                                                                        <!--end::Col-->
                                                                    </asp:PlaceHolder>
                                                                    <asp:PlaceHolder ID="pnlcussrvice" runat="server" Visible="false">
                                                                        <div class="col-4" style="border-left-style: dashed; border-left-width: thin; border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/cs.png" alt="others" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="Label4" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"><asp:Label ID="lblcusservice" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkCusService" runat="server" CssClass="d-flex justify-content-lg-end" OnClick="lnkCusService_Click">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton7" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>


                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                    <!--begin::Col-->
                                                                    
                                                                    
                                                                    <!--end::Col-->
                                                                    <!--begin::Col-->
                                                                    <asp:PlaceHolder ID="pnlFS" runat="server" Visible="false">
                                                                         <div class="col-4" style="border-left-style: dashed; border-left-width: thin; border-bottom-style: dashed; border-bottom-width: thin; border-right-style: dashed; border-right-width: thin; border-color: antiquewhite;">
                                                                            <div class="d-flex align-items-center ms-2">
                                                                                <!--begin::Symbol-->
                                                                                <div class="col-2">
                                                                                    <div class="symbol symbol-40px mx-3" style="padding-top: 20px;">
                                                                                        <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 10px;">
                                                                                            <!--begin::Svg Icon | path: icons/duotune/abstract/abs045.svg-->
                                                                                            <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                <img src="../assets/media/UDP/complaints.png" alt="others" width="28" height="25" style="margin: 10px; margin-left: 15px; margin-right: 15px;" />
                                                                                            </span>
                                                                                            <!--end::Svg Icon-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!--end::Symbol-->
                                                                                <!--begin::Title-->
                                                                                <div class="col-7">

                                                                                    <div class="fs-7 fw-bold pt-6" style="color: black;">

                                                                                        <span class="" style="font-size: 17px; font-weight: bold;">
                                                                                            <asp:Label ID="Label2" runat="server"></asp:Label>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="fs-7 fw-bold" style="color: black;"><asp:Label ID="lblFS" runat="server"></asp:Label></div>

                                                                                </div>
                                                                                <!--end::Title-->
                                                                                <asp:LinkButton ID="lnkFS" runat="server" OnClick="lnkFS_Click" CssClass="d-flex justify-content-lg-end">
                                                                                    <div class="col-4">


                                                                                        <div class="symbol symbol-40px me-3" style="background-color: white;">
                                                                                            <div class="symbol-label bg-secondary bg-opacity-0.85" style="border-radius: 7px; margin-top: 20px;">
                                                                                                <!--begin::Svg Icon | path: icons/duotune/abstract/abs043.svg-->
                                                                                                <span class="svg-icon svg-icon-1 svg-icon-dark">
                                                                                                    <asp:ImageButton ID="ImageButton4" Visible="true" AlternateText="arrow" runat="server" Height="15" Style="margin: 7px;"
                                                                                                        ImageUrl="../assets/media/svg/general/right-arrow.svg"></asp:ImageButton>
                                                                                                </span>
                                                                                                <!--end::Svg Icon-->
                                                                                            </div>
                                                                                        </div>


                                                                                    </div>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </asp:PlaceHolder>
                                                                    <!--end::Col-->


                                                                </div>
                                                                <!--end::Row-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ContentTemplate>
                                            </telerik:RadPanelItem>
                                        </Items>
                                    </telerik:RadPanelBar>


                                </div>




                                <div class="kt-portlet__body">
                                    <%--<h3 style="color: blue">Customer Visits </h3>--%>

                                    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                        <script type="text/javascript"> 
                                            function grvRpt_RowDblClick(sender, args) {
                                                debugger;
                                                var ClickedIndex = args._itemIndexHierarchical;
                                                //changed code here 
                                                var grid = $find("<%=grvRpt.ClientID %>");
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


                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None" BorderWidth="0"
                                        ShowFooter="True" AllowSorting="True"
                                        OnNeedDataSource="grvRpt_NeedDataSource"
                                        OnItemCommand="grvRpt_ItemCommand"
                                        OnItemDataBound="grvRpt_ItemDataBound"
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="50" CellSpacing="0">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                            <ClientEvents OnRowClick="grvRpt_RowDblClick" />
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="cse_ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>


                                                <telerik:GridBoundColumn DataField="cus_Code" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_Code">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="customer" AllowFiltering="true" HeaderStyle-Width="150px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Customer" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="customer">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cse_StartTime" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Start Time" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cse_StartTime">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="cse_Endime" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="End Time" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cse_Endime">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Duration" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Duration" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Duration">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cus_GeoCode" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Master Geo Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cus_GeoCode">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="cse_StartGeoCode" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Trans Geo Code" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cse_StartGeoCode">
                                                </telerik:GridBoundColumn>

                                                <%--<telerik:GridBoundColumn DataField="Difference" AllowFiltering="true" HeaderStyle-Width="120px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Difference" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Difference">
                                                </telerik:GridBoundColumn>--%>

                                                <telerik:GridBoundColumn DataField="cse_IsScheduled" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Scheduled" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="cse_IsScheduled">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="salecount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Invoices" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="salecount">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ordercount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Orders" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ordercount">
                                                </telerik:GridBoundColumn>


                                                <telerik:GridBoundColumn DataField="ARcount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="AR" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ARcount">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Adpaymentcount" AllowFiltering="true" HeaderStyle-Width="80px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Advance" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Adpaymentcount">
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
                            </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>

                            </telerik:RadAjaxLoadingPanel>
                        </div>

                        <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body pb-0">

                                <div class="col-lg-12 row" style="padding-bottom: 30px;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to update endorsement..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="lnkSave" runat="server" Text="Yes" OnClick="lnkSave_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span>You can proceed with settlement</span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_4);">Ok</button>

                        <%--<asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                        --%>
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
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="FailureAlert" tabindex="-1" role="dialog" style="height: auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Failure</h5>
                </div>
                <div class="modal-body">
                    <span><strong></strong>&nbsp;&nbsp; <span id="failres"></span></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(FailureAlert);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>
