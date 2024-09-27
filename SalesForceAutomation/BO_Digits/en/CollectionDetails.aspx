<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="CollectionDetails.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.CollectionDetails" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <span class="fw-bolder"> Date : </span> 
    <asp:Label runat="server" ID="lbldat"></asp:Label>
    <span class="mx-4 fw-bolder"> Route :  </span>
    <asp:Label runat="server" ID="lblroute"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <div class="app-content flex-column-fluid">
         
            <div class="col-lg-12 row">

                 <%-- card-1--%>
                <div class="col-lg-6">
                    
                    <div class="card card-flush mb-5">
                     
                        <div class="card-header pt-5 ms-4">
                            <h3 class="card-title text-gray-800">
                                Account Recievables Collections
                            </h3>
                        </div>
                        <div class="Card-body pb-0 mx-4 mt-2 row">
                           <div class="px-0 mb-0 col-sm-6 fw-bold fs-5">
                             <span>
                                Total Collection
                             </span>
                           </div>
                            <h4 class="px-0 mb-0 col-sm-6" style="text-align-last:end;"><asp:Label ID="lblTotalArAmt" runat="server"></asp:Label></h4>
                        </div>
                    
                          <!--begin::Body-->
                                <div class="col-lg-12 row ps-8">
                                    <!--begin::Item-->
                                    <div class="row col-lg-12">
                                        <div class="row col-xl-6">
                                        <asp:LinkButton ID="lnkHC" runat="server" OnClick="lnkHC_Click" CssClass="hover-effect" ForeColor="Black">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="24" width="24" />
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Hard Cash</span>
                                            <h4 class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArHcAmt" Text="2000.00" runat="server"></asp:Label></h4>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArHcCount" Text="4" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                            
                                    </div>
                                    </asp:LinkButton>
                                    <!--end::Item-->
                                    </div>
                                    <!--begin::Item-->
                                        <div class="row col-xl-6">
                                    <asp:LinkButton ID="lnkPOS" runat="server" OnClick="lnkPOS_Click" CssClass="hover-effect" ForeColor="Black">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">POS</span>
                                            <h4 class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArPosAmt" Text="1500.00" runat="server"></asp:Label></h4>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArPosCount" Text="2" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                            
                                    </div>
                                    </asp:LinkButton>
                                     <!--end::Item-->
                                    </div>
                                    </div>



                                    <div class="row col-lg-12">
                                        <div class="row col-xl-6">
                                    <!--begin::Item-->
                                    <asp:LinkButton ID="LnkOnline" runat="server" OnClick="LnkOnline_Click" CssClass="hover-effect" ForeColor="Black">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2  col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Online Payment</span>
                                            <h4 class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArOpAmt" Text="500.00" runat="server"></asp:Label></h4>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArOpCount" Text="1" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                            
                                    </div>
                                    <!--end::Item-->
                                    </asp:LinkButton>
                                    </div>

                                        <div class="row col-xl-6">
                                    <!--begin::Item-->
                                    <asp:LinkButton ID="LnkCheque" runat="server" OnClick="LnkCheque_Click" CssClass="hover-effect" ForeColor="Black" >
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/cheque@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            
                                            <span class="text-muted fw-semibold d-block">Cheque</span>
                                            <h4 class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblArChequeAmt" Text="1500.00" runat="server"></asp:Label></h4>
                                            
                                         </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblArChequeCount" Text="1" runat="server" ></asp:Label></span>
                                        <!--end::Lable-->
                                            
                                    </div>
                         </asp:LinkButton>
                                    <!--end::Item-->
                                   </div>
                                        </div>
                                </div>
                           <!--end::Body-->
                        <!--begin::Card body-->
						  <div class="card-body pb-10 table-responsive" style="height:400px;">
                             
                                    
                        <!--begin::Table-->
                             
						<table class="table align-middle table-row-dashed fs-6 gy-3">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															  <asp:Repeater runat="server" ID="rptARCollection">
                                                                 <ItemTemplate>
															        <tr>
																<!--begin::Item-->
																<td colspan="3">
																	<a class="text-dark text-hover-primary" href="ARCollectionDetail.aspx?ID=<%# Eval("arh_ID") %>"><asp:Label ID="lblARNumber" Text='<%# Eval("arh_ARNumber") %>' runat="server"></asp:Label></a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"><asp:Label ID="lblCust" Text='<%# Eval("customer") %>' runat="server"></asp:Label>  </p>
																</td>
																<!--end::Item-->
																<td class="text-end">
																	<span class="text-dark py-2 px-3 fs-7"><asp:Label ID="lblamount" Text='<%# Eval("arh_CollectedAmount") %>' runat="server"></asp:Label></span>
																</td>
																<!--begin::Status-->
																<td class="text-end">
																	<span class="badge py-2 px-3 fs-7 <%# Eval("Status").ToString() == "Active" ? "badge-light-success" : "badge-light-warning" %> "><asp:Label ID="lblStat" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
																</td>
																<!--end::Status-->
                                                                <!--begin::Date added-->
																<td class="text-end" style="font-size: 10px;"><asp:Label ID="lblDate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                      
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"><asp:Label ID="lblPay" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Date added-->
																
															</tr>
															      </ItemTemplate>
                                                               </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->
                           
                              
                          </div>
                        <!--end::Card body-->
                        </div>
                    </div>

                <%-- card-2 --%>
                 <div class="col-lg-6">
                    
                    <div class="card card-flush mb-5">
                     
                        <div class="card-header pt-5 ms-4">
                            <h3 class="card-title text-gray-800">
                               Advance Collections
                            </h3>
                        </div>

                         <div class="Card-body pb-0 mx-4 mt-2 row">
                           <div class="px-0 mb-0 col-sm-6 fw-bold fs-5">
                             <span>
                                Total Collection
                             </span>
                           </div>
                            <h4 class="px-0 mb-0 col-sm-6" style="text-align-last:end;"><asp:Label ID="lblTotalAdvAmt" runat="server"></asp:Label></h4>
                        </div>
                    
                          <!--begin::Body-->
                                <div class="col-lg-12 row ps-8">
                                    <!--begin::Item-->
                                    <div class="row col-lg-12">
                                        <div class="row col-xl-6">
                                        <asp:LinkButton ID="LnkADHC" runat="server" CssClass="hover-effect" ForeColor="Black">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-success">
                                                <img src="../assets/media/dashboard/KPI/hc@2x.png" height="24" width="24" />
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Hard Cash</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblAdvHcAmt" Text="2000.00" runat="server"></asp:Label></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblAdvHcCount" Text="4" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                </asp:LinkButton>
                                            </div>
                                        <div class="row col-xl-6">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/pos@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">POS</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblAdvPosAmt" Text="1500.00" runat="server"></asp:Label></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblAdvPosCount" Text="2" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                     <!--end::Item-->
                                    </div>

                                    </div>

                                    <div class="row col-lg-12">
                                    <!--begin::Item-->
                                    <div class="row col-xl-6">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2  col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-warning">
                                                <!--begin::Svg Icon | path: icons/duotune/art/art005.svg-->
                                                <img src="../assets/media/dashboard/KPI/op@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Online Payment</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblAdvOpAmt" Text="500.00" runat="server"></asp:Label></a>

                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblAdvOpCount" Text="1" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                    </div>
                                    <!--begin::Item-->
                                        <div class="row col-xl-6">
                                    <div class="d-flex align-items-center border-1 rounded p-1 mb-2 col-md-12" style="border-style: groove; border-width: 2px !important;">
                                        <!--begin::Svg Icon | path: icons/duotune/abstract/abs027.svg-->
                                        <div class="symbol symbol-50px me-5">
                                            <span class="symbol-label bg-light-primary">
                                                <!--begin::Svg Icon | path: icons/duotune/communication/com012.svg-->
                                                <img src="../assets/media/dashboard/KPI/cheque@2x.png" height="24" width="24" />
                                                <!--end::Svg Icon-->
                                            </span>
                                        </div>
                                        <!--end::Svg Icon-->
                                        <!--begin::Title-->
                                        <div class="flex-grow-1 me-2">
                                            <span class="text-muted fw-semibold d-block">Cheque</span>
                                            <a href="#" class="fw-bold text-gray-800 text-hover-primary fs-6"><asp:Label ID="lblAdvChequeAmt" Text="1500.00" runat="server"></asp:Label></a>
                                        </div>
                                        <!--end::Title-->
                                        <!--begin::Lable-->
                                        <span class="fw-bold py-1 me-3"><asp:Label ID="lblAdvChequeCount" Text="1" runat="server"></asp:Label></span>
                                        <!--end::Lable-->
                                    </div>
                                    <!--end::Item-->
                                        </div>
                                    </div>
                                </div>
                           <!--end::Body-->

                         <!--begin::Card body-->
						  <div class="card-body table-responsive" style="height:400px;">
                        <!--begin::Table-->
						<table class="table align-middle table-row-dashed fs-6 gy-3" id="kt_table_widget_5_table">
														
														<!--begin::Table body-->
														<tbody class="fw-bold text-gray-600">
															
														<asp:Repeater runat="server" ID="rptAdvCollection">
                                                            <ItemTemplate>
															
															    <tr>
																<!--begin::Item-->
																<td colspan="3">
																	<a class="text-dark text-hover-primary" href="APCollectionDetail.aspx?ID=<%# Eval("adp_ID") %>"> <asp:Label ID="lbladpNumber" Text='<%# Eval("adp_Number") %>' runat="server"></asp:Label></a>
                                                                   <p style="font-size: 11px; margin-bottom:auto;"> <asp:Label ID="lblCus" Text='<%# Eval("customer") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Item-->
																<td class="text-end">
																	<span class="text-dark py-2 px-3 fs-7"><asp:Label ID="lbladpamount" Text='<%# Eval("adp_Amount") %>' runat="server"></asp:Label></span>
																</td>
																<!--begin::Status-->
																<td class="text-end">
																	<span class="badge py-2 px-3 fs-7 <%# Eval("Status").ToString() == "Active" ? "badge-light-success" : "badge-light-warning" %> "> <asp:Label ID="lblstatus" Text='<%# Eval("Status") %>' runat="server"></asp:Label></span>
																</td>
																<!--end::Status-->
                                                                <!--begin::Date added-->
																<td class="text-end" style="font-size: 10px;"> <asp:Label ID="lblcreateddate" Text='<%# Eval("CreatedDate") %>' runat="server"></asp:Label>
                                                                    <p style="font-size: 12px; margin-top:5px; margin-bottom:-4px;"> <asp:Label ID="lblPaymode" Text='<%# Eval("Pay") %>' runat="server"></asp:Label></p>
																</td>
																<!--end::Date added-->
																
															</tr>
															
                                                            </ItemTemplate>
                                                        </asp:Repeater>

														</tbody>
														<!--end::Table body-->
													</table>
					    <!--end::Table-->

                              
                          </div>
                        <!--end::Card body-->
                        </div>
                    </div>
                </div>
        
        </div>

    <style>
        .card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: stretch;
  flex-wrap: wrap;
  min-height: 70px;
  padding-left:2px;
  /*padding: 0 2.25rem;*/
  color: var(--kt-card-cap-color);
  background-color: var(--kt-card-cap-bg);
  border-bottom: 1px solid var(--kt-card-border-color);
}
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
