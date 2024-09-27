<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="SalesInvoiceDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.SalesInvoiceDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
                        
    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../assets/media/icons/excel.png" Style="height: 50px;" ToolTip="Download" AlternateText="Xlsx" />
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="../assets/media/icons/file.png" Style="height: 40px; width: 33px;" ToolTip="Print"
                        AlternateText="pdf" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-xl-12 " style="background-color: white;">
        <div class="col-xl-12 row" style="background-color: white;">

            <div class="col-xl-8">
                <div class="card-header pt-5" style="background-color: white; padding: 20px;">
                    <!--begin::Title-->

                    <h3 class="card-title align-items-start flex-column">
                        <span class="card-label fw-bold text-dark"><asp:Label ID="lblSalno" runat="server"></asp:Label></span>
                        <br />

                        <span class="text-gray-400 mt-1 fw-semibold fs-6"><asp:Label ID="lblcusname" runat="server"></asp:Label></span>
                        <br />
                        <span class="text-gray-400 mt-1 fw-semibold fs-7"><asp:Label ID="lbldate" runat="server"></asp:Label></span>
                    </h3>


                    <!--end::Title-->

                </div>
            </div>
           
            <div class="col-sm-2">
                <div class="card-toolbar pt-5" style="text-align-last: center;">
                    
                </div>
            </div>
        </div>
        <div class="col-xl-12 row" style="background-color: white;">
            <div class="col-xl-6 " style="padding-left: 26px; padding-left: 26px; border-right-style: solid; border-right-width: 2px; border-right-color: gainsboro; padding-right: 26px;">
                <table class="table  align-middle gs-0 gy-4 my-0" style="border-bottom-style: solid; border-bottom-width: 1px;">
                    <!--begin::Table head-->
                    <thead style="border-bottom-style: solid; border-bottom-width: 1px; border-top-style: solid; border-top-width: 1px;">
                        <tr class="fs-7 fw-bold text-gray-500 border-bottom-0">
                            <th class="ps-0 w-42px">Type</th>

                            <th class="text-end min-w-140px">Value</th>
                            <th class="pe-0 text-end min-w-120px">Discounts</th>
                             <th class="pe-0 text-end min-w-120px">SubTotal</th>
                            <th class="pe-0 text-end min-w-120px">VAT</th>                           
                            <th class="pe-0 text-end min-w-120px">GrandTotal</th>
                        </tr>
                    </thead>
                    <!--end::Table head-->
                    <!--begin::Table body-->
                    <tbody>
                        <asp:Repeater runat="server" ID="rptsalesdet">
                        <ItemTemplate>
                        <tr>

                            <td class="ps-0">
                                <span class="text-gray-800 fw-bold text-hover-primary mb-1 fs-7 text-start pe-0"><asp:Label ID="lbltype" Text=' <%#  Eval("ind_TransType") %>'  runat="server"></asp:Label></span>
                            </td>

                            <td>
                                <span class="text-gray-800 fw-bold d-block fs-7 ps-0 text-end"><asp:Label ID="lblsalamnt" Text=' <%#  Eval("Total") %>' runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800 fw-bold d-block fs-7"><asp:Label ID="lblsaldiscount" Text=' <%#  Eval("Disocunt") %>' runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800 fw-bold d-block fs-7"><asp:Label ID="lblsalevat" Text=' <%#  Eval("VAT") %>' runat="server"></asp:Label></span>
                            </td>
                             <td class="text-end pe-0">
                                <span class="text-gray-800 fw-bold d-block fs-7"><asp:Label ID="lblsalsubtot" Text=' <%#  Eval("SubTotal") %>' runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800 fw-bold d-block fs-7"><asp:Label ID="lblsalgrandtot" Text=' <%#  Eval("GrandTotal") %>' runat="server"></asp:Label></span>
                            </td>
                        </tr>
                        </ItemTemplate>
                        </asp:Repeater>
                       


                    </tbody>
                    <!--end::Table body-->
                </table>
                <div class="card-body pt-5">
                    <!--begin::Item-->
                    <div class="d-flex flex-stack">
                        <!--begin::Section-->
                        <div class="text-gray-700 fw-semibold fs-6 me-2">Total Amount</div>
                        <!--end::Section-->
                        <!--begin::Statistics-->
                        <div class="d-flex align-items-senter">

                            <!--begin::Number-->
                            <span class="text-gray-900 fw-bolder fs-6">:</span>
                            <span class="text-gray-900 fw-bolder fs-6"><asp:Label ID="lbltotamnt" runat="server"></asp:Label></span>
                            <!--end::Number-->

                        </div>
                        <!--end::Statistics-->
                    </div>
                      <div class="d-flex flex-stack" style="padding-top: 8px;">
                        <!--begin::Section-->
                        <div class="text-gray-700 fw-semibold fs-6 me-2">Total Discount</div>
                        <!--end::Section-->
                        <!--begin::Statistics-->
                        <div class="d-flex align-items-senter">

                            <!--begin::Number-->
                            <span class="text-gray-900 fw-bolder fs-6">:</span>
                            <span class="text-gray-900 fw-bolder fs-6"><asp:Label ID="lbltotdisc" runat="server"></asp:Label></span>
                            <!--end::Number-->
                        </div>
                        <!--end::Statistics-->
                    </div>
                    <!--end::Item-->

                    <!--begin::Item-->
                    <div class="d-flex flex-stack" style="padding-top: 8px;">
                        <!--begin::Section-->
                        <div class="text-gray-700 fw-semibold fs-6 me-2">Total VAT</div>
                        <!--end::Section-->
                        <!--begin::Statistics-->
                        <div class="d-flex align-items-senter">

                            <!--begin::Number-->
                            <span class="text-gray-900 fw-bolder fs-6">:</span>
                            <span class="text-gray-900 fw-bolder fs-6"><asp:Label ID="lbltotvat" runat="server"></asp:Label></span>
                            <!--end::Number-->
                        </div>
                        <!--end::Statistics-->
                    </div>
                    <!--end::Item-->

                    <!--begin::Item-->
                  
                     <div class="d-flex flex-stack" style="padding-top: 8px;">
                        <!--begin::Section-->
                        <div class="text-gray-700 fw-semibold fs-6 me-2">Grand Total </div>
                        <!--end::Section-->
                        <!--begin::Statistics-->
                        <div class="d-flex align-items-senter">

                            <!--begin::Number-->
                            <span class="text-gray-900 fw-bolder fs-6">:</span>
                            <span class="text-gray-900 fw-bolder fs-6"><asp:Label ID="lblsalgrandtot" runat="server"></asp:Label></span>
                            <!--end::Number-->
                        </div>
                        <!--end::Statistics-->
                    </div>
                    <!--end::Item-->
                    <!--begin::Item-->
                    <div class="d-flex flex-stack" style="padding-top: 8px;">
                        <!--begin::Section-->
                        <div class="text-gray-700 fw-semibold fs-6 me-2">Payment Mode: <asp:Label ID="lbltranstype"  runat="server"></asp:Label></div>
                        <!--end::Section-->
                        <!--begin::Statistics-->
                       <asp:PlaceHolder runat="server" ID="img" Visible="false">
                        <div class="d-flex align-items-senter">

                            <!--begin::Number-->
                            
                            <asp:Repeater runat="server" ID="rptimage" >
                                <ItemTemplate>
                            <span class="text-gray-900 fw-bolder fs-6">
                                <asp:HyperLink ID="pp" runat="server" NavigateUrl=' <%#  Eval("sal_RecieptImg") %>' Target="_blank" >
                                <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%#  Eval("sal_RecieptImg") %>'  height="80px" Width="80px"/>
                                                                </asp:HyperLink>
                                </span>
                                    </ItemTemplate>
                                </asp:Repeater>
                            <!--end::Number-->
                        </div>
                        </asp:PlaceHolder>
                        <!--end::Statistics-->
                    </div>
                    <!--end::Item-->
                </div>
            </div>
            <div class="col-xl-6 table-responsive pb-10" style="height:400px;" >
                <table class="table  align-middle gs-0 gy-4 my-0" style="border-bottom-style: solid; border-bottom-width: 1px;">
                    <!--begin::Table head-->
                    <thead style="border-bottom-style: solid; border-bottom-width: 1px; border-top-style: solid; border-top-width: 1px;">
                        <tr class="fs-7 fw-bold text-gray-500 border-bottom-0">
                            <th class="ps-0 w-42px">Items</th>

                            <th class="text-end min-w-140px">Type</th>
                            <th class="pe-0 text-end min-w-120px">UOM</th>
                            <th class="pe-0 text-end min-w-120px">Price</th>
                            <th class="pe-0 text-end min-w-120px">Qty</th>                            
                            <th class="pe-0 text-end min-w-120px">Discount</th>
                            <th class="pe-0 text-end min-w-120px">Line Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptSalesInvoiceProducts">
                        <ItemTemplate>
                        <tr style="border-bottom-style: solid; border-bottom-width: 2px;">
                           
                            <td class="ps-0">
                                <span class="text-gray-800 fw-bold text-hover-primary mb-1 fs-6 text-start pe-0"><asp:Label ID="lblprdcode" Text='<%# Eval("prd_Code") %>'  runat="server"></asp:Label> </span>
                                <span class="text-gray-400 fw-semibold fs-7 d-block text-start ps-0"><asp:Label ID="lblprdname" Text='<%# Eval("prd_Name") %>'  runat="server"></asp:Label></span>
                            </td>
                            <td>
                                <span class="text-gray-800  d-block fs-7 ps-0 text-end"><asp:Label ID="lbltranstype" Text='<%# Eval("sld_TransType") %>'  runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lblhuom" Text='<%# Eval("sld_HigherUOM") %>'  runat="server"></asp:Label></span>
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lblluom" Text='<%# Eval("sld_LowerUOM") %>'  runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lblhprice" Text='<%# Eval("sld_HigherPrice") %>'  runat="server"></asp:Label></span>
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lbllprice" Text='<%# Eval("sld_LowerPrice") %>'  runat="server"></asp:Label></span>
                            </td>
                            <td class="text-end pe-0">
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lblhqty" Text='<%# Eval("sld_HigherQty") %>'  runat="server"></asp:Label></span>
                                <span class="text-gray-800  d-block fs-7"><asp:Label ID="lbllqty" Text='<%# Eval("sld_LowerQty") %>'  runat="server"></asp:Label></span>
                            </td>
                             <td>
                                <span class="text-gray-800  d-block fs-7 ps-0 text-end"><asp:Label ID="lblProDiscount" Text='<%# Eval("sld_Discount") %>'  runat="server"></asp:Label></span>
                            </td>
                             <td>
                                <span class="text-gray-800  d-block fs-7 ps-0 text-end"><asp:Label ID="lblLineTot" Text='<%# Eval("sld_LineTotal") %>'  runat="server"></asp:Label></span>
                            </td>
                            
                        </tr>
                        </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
