<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="DailyActivityReview.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.DailyActivityReview" %>

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
        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">



    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript"> 
            function grvRpt_RowDblClick(sender, args) {
                /*debugger;*/
                var ClickedIndex = args._itemIndexHierarchical;
                //changed code here 
                var grid = $find("<%=grvRpt.ClientID %>");
                if (grid) {
                    var MasterTable = grid.get_masterTableView();
                    var Rows = MasterTable.get_dataItems();
                    for (var i = 0; i < Rows.length; i++) {
                        var row = Rows[i];
                        if (ClickedIndex != null && ClickedIndex == i) { // newly added
                            MasterTable.fireCommand("CashInvClick", ClickedIndex); // newly added
                            MasterTable.fireCommand("CreditInvClick", ClickedIndex);
                            MasterTable.fireCommand("CashRtnClick", ClickedIndex);
                            MasterTable.fireCommand("CreditRtnClick", ClickedIndex);
                            MasterTable.fireCommand("CashARClick", ClickedIndex);
                            MasterTable.fireCommand("ChequeARClick", ClickedIndex);
                        } // newly added
                    }
                }
            }


        </script>

    </telerik:RadScriptBlock>

    <style>
        .card-body2 {
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .visits {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
            font-size: 18px;
            color: #555;
        }

            .visits span {
                display: flex;
                align-items: center;
                margin-left: 20px;
            }

                .visits span::before {
                    content: '';
                    display: inline-block;
                    width: 16px;
                    height: 7px;
                    margin-right: 8px;
                    border-radius: 35%;
                }

        .total-visits::before {
            background-color: #6c63ff;
        }

        .productive-visits::before {
            background-color: #28a745;
        }

        .divider {
            border-top: 2px dashed #808080;
            margin: 10px 0;
        }

        .visits .label {
            width: 200px;
        }

        .sales-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-left: 20px;
            padding-bottom: 10px;
        }

        .sales-amount {
            font-size: 28px;
        }

        .footer-border {
            border-top: 1px solid #ccc; /* Adjust the border style as needed */
            border-bottom: 1px solid #ccc;
            border-left: 1px solid #ccc;
            border-right: 1px solid #ccc;
        }
        .RadGrid .rgHeader {
        padding: 0 0 0 15px ;
        margin: 0 ;
        font-size: 12px; /* Adjust the font size if needed */
        }
            .RadGrid .rgHeader div {
                padding-left: 0 0 0 15px;
                margin: 0 ;
       
            }
    </style>



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
                        <div class="kt-portlet__head" style="border-bottom-style: ridge; border-bottom-width: thin; padding-bottom: 20px;">

                            <div class="kt-portlet__head-actions col-lg-12 row">
                                <div class="col-lg-6">
                                    <h3 class="card-title text-gray-800">
                                        <itemtemplate>
                                            Route &nbsp;  
                                                <span>
                                                    <asp:Label ID="lblrotname" Font-Bold="true" runat="server"></asp:Label></span>

                                        </itemtemplate>
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <!--begin::Form-->
                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                <div class="kt-portlet__body pb-0" style="border-bottom-style: inset; border-bottom-width: thin;">
                                    <!--begin::Mixed Widget 2-->
                                    <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                        <Items>
                                            <telerik:RadPanelItem Font-Bold="true" Expanded="true" BackColor="">
                                                <ContentTemplate>
                                                    <div class="col-lg-12 row mb-2 pt-2">

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
                                                    </div>
                                                </ContentTemplate>
                                            </telerik:RadPanelItem>
                                        </Items>
                                    </telerik:RadPanelBar>
                                    <!--begin::Mixed Widget 2-->
                                    <!--begin::Mixed Widget 3-->
                                    <div class="row g-5 g-xl-8 mt-0">
                                        <div class="col-xl-8">
                                            <div class="card card-flush h-xl-100 rounded" style="box-shadow: rgba(0, 0, 0, 0.15) 0px 2px 8px;">
                                                <div class="card-header rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center align-items-start h-150px " style="background-image: url('../assets/media/logos/bg_1.png');" data-theme="light">
                                                    <div class="col-lg-12 row text-white pt-5 ">
                                                        <div class="col-lg-4 fs-3" style="text-align: justify;">
                                                            <span class="opacity-80">
                                                                <asp:Label ID="lbltotaltarget" runat="server" class="fs-1"></asp:Label><br />
                                                                <span style="font-size: smaller;">Total Target</span>
                                                            </span>
                                                        </div>

                                                        <div class="col-lg-4 fs-3" style="text-align: justify;">
                                                            <span class="opacity-80 ">
                                                                <asp:Label ID="lblMTDWrkDays" runat="server" class="fs-1"></asp:Label><br />
                                                                <span style="font-size: smaller;">MTD Working Days</span>
                                                            </span>
                                                        </div>

                                                        <div class="col-lg-4 fs-3" style="text-align: justify;">
                                                            <span class="opacity-80" style="text-align: right;">
                                                                <asp:Label ID="lbltotWrkDays" runat="server" class="fs-1"></asp:Label><br />
                                                                <span style="font-size: smaller;">Total Working Days</span>
                                                            </span>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="card-body mt-n10">
                                                    <div class="mt-n20 position-relative">
                                                        <div class="row g-4 g-lg-6 pt-10">
                                                            <div class="col-3">
                                                                <div class="bg-gray-100 bg-opacity-70 rounded-2 px-8 py-5">
                                                                    <span class="opacity-90" style="text-align: right; color: darkslategrey;">
                                                                        <asp:Label ID="lblproratedTarget" runat="server" class=" fs-2"></asp:Label><br />
                                                                        Pro Rated Target
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-3">
                                                                <div class="bg-gray-100 bg-opacity-70 rounded-2 px-8 py-5">
                                                                    <span class="opacity-90" style="text-align: right; color: darkslategrey;">
                                                                        <asp:Label ID="lblMTDsales" runat="server" class=" fs-2 "></asp:Label><br />
                                                                        MTD Sales
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-3">
                                                                <div class="bg-gray-100 bg-opacity-70 rounded-2 px-8 py-5">
                                                                    <span class="opacity-90" style="text-align: right; color: darkslategrey;">
                                                                        <asp:Label ID="lblexcsorshort" runat="server" class=" fs-2"></asp:Label><br />
                                                                        Excess/Shortage
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-3">
                                                                <div class="bg-gray-100 bg-opacity-70 rounded-2 px-8 py-5">
                                                                    <span class="opacity-90" style="text-align: right; color: darkslategrey;">
                                                                        <asp:Label ID="lblMTDsaltoAchv" runat="server" class=" fs-2"></asp:Label><br />
                                                                        Exp Sales/Day
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-xl-4">
                                            <div class="card-body2 pt-10" style="height: 250px; background-image: url('../assets/media/logos/bg_2.png'); box-shadow: rgba(0, 0, 0, 0.15) 0px 2px 8px;">
                                                <div class="sales-header fw-bolder">
                                                    <span style="margin: 0; font-size: 18px; color: #333;">Today's Sales</span>
                                                    <span class="sales-amount">
                                                        <asp:Label ID="lbltodaysales" runat="server" class=" fs-1"></asp:Label></span>
                                                </div>
                                                <div class="visits">
                                                    <span class="total-visits label">Total Visits</span>
                                                    <span class="fw-bolder">
                                                        <asp:Label ID="lbltotvisit" runat="server" class=" fs-1"></asp:Label></span>
                                                </div>
                                                <div class="divider sales-header"></div>
                                                <div class="visits">
                                                    <span class="productive-visits label">Productive Visits</span>
                                                    <span class="fw-bolder">
                                                        <asp:Label ID="lblprovisit" runat="server" class=" fs-1"></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="post d-flex flex-column-fluid" id="kt_post"></div>
                                    </div>
                                    <!--begin::Mixed Widget 3-->

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

                                <div class="col-lg-12 row">
                                </div>
                            </div>
                        </div>

                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <div class="kt-portlet__body" style="margin-top: 20px;">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnItemDataBound="grvRpt_ItemDataBound"
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="10" CellSpacing="0" PagerStyle-AlwaysVisible="true" DataKeyNames="Seq">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" ShowFooter="True">
                                        <ColumnGroups>
                                            <telerik:GridColumnGroup Name="Sales" HeaderText=" Sales"
                                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true"/>
                                            <telerik:GridColumnGroup Name="Return" HeaderText=" Return"
                                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />
                                            <telerik:GridColumnGroup Name="Collection" HeaderText="Collection "
                                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true"/>
                                            <telerik:GridColumnGroup Name=" " HeaderText="  "
                                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />
                                        </ColumnGroups>
                                        <HeaderStyle Width="102px" />
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="Seq" HeaderStyle-Width="60px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Seq" FooterText=""
                                                UniqueName="seq" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("ID") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="cse_StartTime" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Start" FooterText=""
                                                UniqueName="cse_StartTime" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("cse_StartTime") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="cse_EndTime" HeaderStyle-Width="90px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="End"
                                                UniqueName="cse_EndTime" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("cse_EndTime") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Duration" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Duration"
                                                UniqueName="Duration" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("Duration") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="cus_Code" HeaderStyle-Width="120px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Code"
                                                UniqueName="cus_Code" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("cus_Code") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="cus_Name" HeaderStyle-Width="210px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Customer Name"
                                                UniqueName="cus_Name" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <%# Eval("cus_Name") %>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <div style="text-align: right;">
                                                        <h6>Total</h6>
                                                    </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>




                                            <telerik:GridTemplateColumn DataField="TotalSalCS" HeaderText="Cash" UniqueName="TotalSalCS"
                                                ColumnGroupName="Sales" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCashInvoice" runat="server" Text='<%# Eval("TotalSalCS") %>' CommandName="CashInvClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <div style="text-align: right;">
                                                        <h6>
                                                            <asp:Label runat="server" ID="finalTotalSal_CS"></asp:Label></h6>
                                                    </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="TotalSalCR" HeaderText="Credit" UniqueName="TotalSalCR"
                                                ColumnGroupName="Sales" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCreditInvoice" runat="server" Text='<%# Eval("TotalSalCR") %>' CommandName="CreditInvClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>                                                  
                                                        <div style="text-align: right;">
                                                            <h6>
                                                                <asp:Label runat="server" ID="finalTotalSal_CR"></asp:Label></h6>
                                                        </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="TotalrtnCS" HeaderText="Cash" UniqueName="TotalrtnCS"
                                                ColumnGroupName="Return" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCashRtn" runat="server" Text='<%# Eval("TotalrtnCS") %>' CommandName="CashRtnClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                            <div style="text-align: right;">
                                                                <h6>
                                                                    <asp:Label runat="server" ID="finalTotalrtn_CS"></asp:Label></h6>
                                                            </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn DataField="TotalrtnCR" HeaderText="Credit" UniqueName="TotalrtnCR"
                                                ColumnGroupName="Return" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCreditRtn" runat="server" Text='<%# Eval("TotalrtnCR") %>' CommandName="CreditRtnClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                            <div style="text-align: right;">
                                                                <h6>
                                                                    <asp:Label runat="server" ID="finalTotalrtn_CR"></asp:Label></h6>
                                                            </div>>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="TotalARCS" HeaderText="Cash" UniqueName="TotalARCS"
                                                ColumnGroupName="Collection" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCashAR" runat="server" Text='<%# Eval("TotalARCS") %>' CommandName="CashARClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                            <div style="text-align: right;">
                                                                <h6>
                                                                    <asp:Label runat="server" ID="finalTotalAR_CS"></asp:Label></h6>
                                                            </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="TotalARCH" HeaderText="Credit" UniqueName="TotalARCH"
                                                ColumnGroupName="Collection" FooterAggregateFormatString="Sum: {0}" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkChequeAR" runat="server" Text='<%# Eval("TotalARCH") %>' CommandName="ChequeARClick"></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                            <div style="text-align: right;">
                                                                <h6>
                                                                    <asp:Label runat="server" ID="finalTotalAR_CH"></asp:Label></h6>
                                                            </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridBoundColumn DataField="udp_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="udp_ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="udp_ID" Display="false">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="cse_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="cse_ID" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="cse_ID" Display="false">
                                            </telerik:GridBoundColumn>

                                        </Columns>

                                        <PagerStyle PageSizes="5,10" PagerTextFormat="{4}<strong>{5}</strong> items"
                                            PageSizeLabelText="Page size:" />
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





                        <div class="d-flex justify-content-end" style="padding-top: 15px; top: 10px;">
                            <div class="col-lg-1 text-center" style="margin-right: 5px;">
                                <asp:LinkButton ID="lnkback" runat="server" CssClass="btn btn-sm btn-primary " BackColor="LightGray" ForeColor="Black" CausesValidation="false" OnClick="lnkback_Click">
                                Back
                                </asp:LinkButton>
                            </div>

                            <div class="col-lg-1 text-center" style="width: auto; margin-left: 0;">
                                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                                    <asp:LinkButton ID="lnkcomplete" runat="server" CssClass="btn btn-sm btn-success" BackColor="ForestGreen" ForeColor="White" CausesValidation="false" OnClick="lnkcomplete_Click">
                                     Complete Review
                                    </asp:LinkButton>
                                </telerik:RadAjaxPanel>
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
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" style="height: auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
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
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
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
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
