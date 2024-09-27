<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="MonthlyTargetDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.MonthlyTargetDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

     <span class="fw-bolder"> تاريخ : </span> 
    <asp:Label ID="lblDate" runat="server" ></asp:Label>
    <span class="mx-4 fw-bolder"> طريق :  </span>
    <asp:Label ID="lblRoute" runat="server" ></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="app-content flex-column-fluid">

        <div class="col-lg-12 row">



            <div class="col-lg-12">

                <div class="card card-flush mb-5">



                    <div class="card-header">
                        <h3 class="card-title text-gray-800">
                            <asp:Label ID="lblPackagenumber" runat="server" Text=""></asp:Label></span>
                      
                        </h3>
                    </div>
                    <div class="Card-body pb-0 m-5 row">
                        <div class="px-2 mb-5 col-sm-4">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ الإجمالي المستهدف </span>
                            <br />

                            <span class="fw-bold text-dark h4">
                                <asp:Label ID="lblOverTargetAmt" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="px-2 mb-5 col-sm-4" style="text-align: center;">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المحقق </span>
                            <br />

                            <span class="fw-bold text-success h4 text-success">
                                <asp:Label ID="lblAchievedAmt" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>
                        <div class="px-2 mb-5 col-sm-4" style="text-align: end;">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span>
                            <br />

                            <span class="fw-bold text-warning h4">
                                <asp:Label ID="lblRemainingAmt" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="separator separator-dashed my-1"></div>
                    </div>

                    <div class="Card-body pb-0 mx-5 row">
                        <div class="px-2 mb-5 col-sm-4">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية الإجمالية المستهدفة </span>
                            <br />

                            <span class="fw-bold text-dark h5">
                                <asp:Label ID="lblOverTargetQty" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>
                        <div class="px-2 mb-5 col-sm-4" style="text-align: center;">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المحققة </span>
                            <br />

                            <span class="fw-bold text-success h5">
                                <asp:Label ID="lblAchievedQty" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>
                        <div class="px-2 mb-5 col-sm-4" style="text-align: end;">
                            <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span>
                            <br />

                            <span class="fw-bold text-warning h5">
                                <asp:Label ID="lblRemainQty" runat="server" Text="0"></asp:Label></span>
                        </div>

                    </div>

                    <div class="card-body pt-1">


                        <div class="table-responsive pb-10" style="height: 630px;">

                            <!--begin::Table-->
                            <div class="separator separator-lined my-0" style="padding-top: 20px; border-width: 3px;">
                            </div>

                            <table id="kt_widget_table_3" class="table table-row-bordered align-middle fs-6 gy-4 my-0 pb-3" data-kt-table-widget-3="all">
                                <thead>
                                    <tr class="fs-7 fw-bold text-gray-500">
                                        <th class=" min-w-100px d-block pt-3">رمز الصنف</th>
                                        <th class=" min-w-100px pt-3">اسم العنصر</th>
                                        <th class="pe-0 text-center min-w-100px pt-3">ماركة</th>
                                        <th class=" text-end min-w-100px pt-3">فئة</th>
                                        <th class="pe-0 text-end min-w-100px pt-3">تصنيف فرعي</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <asp:Repeater runat="server" ID="rptProduct">
                                        <ItemTemplate>

                                            <tr runat="server">

                                                <td>
                                                    <span class="min-w-70px text-gray-700 pt-5">
                                                        <asp:Label ID="lblPCode" runat="server" Text='<%# Eval("prd_Code")%>'></asp:Label>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="min-w-70px fw-semibold text-gray-700 pt-5">
                                                        <asp:Label ID="lblPName" runat="server" Text='<%# Eval("prd_NameArabic") %>'></asp:Label>
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <span class="min-w-70px fw-semibold text-gray-700 pt-5">
                                                        <asp:Label ID="lblBrand" runat="server" Text='<%# Eval("brd_NameArabic") %>'></asp:Label>
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <span class="min-w-70px fw-semibold text-gray-700 pt-5">
                                                        <asp:Label ID="lblCat" runat="server" Text='<%# Eval("cat_NameArabic") %>'></asp:Label>
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <span class="min-w-70px fw-semibold text-gray-700 pt-5">
                                                        <asp:Label ID="lblSubCat" runat="server" Text='<%# Eval("sct_NameArabic") %>'></asp:Label>
                                                    </span>
                                                </td>




                                            </tr>
                                        </ItemTemplate>

                                    </asp:Repeater>




                                </tbody>
                            </table>

                        </div>





                    </div>



                </div>
            </div>
        </div>
    </div>


</asp:Content>
