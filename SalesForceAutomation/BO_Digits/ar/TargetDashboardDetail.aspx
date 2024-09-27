<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="TargetDashboardDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.TargetDashboardDetail" %>
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

               

                <div class="col-lg-6">
                    
                    <div class="card card-flush mb-5">
                      
 

                        <div class="card-header pt-5 ms-4">
                            <h3 class="card-title text-gray-800">
                               الهدف اليومي
                            </h3>
                        </div>
                        <div class="Card-body pb-0 m-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ الإجمالي المستهدف </span><br />
                         
                          <span class="fw-bold text-dark h4"> 
                              <asp:Label ID="lblOverTargetAmt" runat="server" Text="0"></asp:Label></span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المحقق </span><br />
                           
                          <span class="fw-bold text-success h4 text-success">
                              <asp:Label ID="lblAchievedAmt" runat="server" Text="0"></asp:Label>  </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية</span><br />
                           
                          <span class="fw-bold text-warning h4">
                              <asp:Label ID="lblRemainingAmt" runat="server" Text="0"></asp:Label></span>
                      </div>
                            <div class="separator separator-dashed my-1"></div>
                            </div>

                       <div class="Card-body pb-0 mx-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية الإجمالية المستهدفة </span><br />
                         
                          <span class="fw-bold text-dark h5">
                              <asp:Label ID="lblOverTargetQty" runat="server" Text="0"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المحققة </span><br />
                         
                          <span class="fw-bold text-success h5">
                              <asp:Label ID="lblAchievedQty" runat="server" Text="0"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                           
                          <span class="fw-bold text-warning h5">
                              <asp:Label ID="lblRemainQty" runat="server" Text="0"></asp:Label></span>
                      </div>
                           
                            </div>
                         <div class="table-responsive pb-10" style="height:400px;">
                       <%-- border1--%>
                       <%-- border1--%>
                              <asp:Repeater runat="server" ID="rptpackage">
                                 <ItemTemplate>
                       <div class="mx-6 m-2 rounded" style="border-style:solid; border-width:thin; border-color:gainsboro;">
                            <div class="card-header pt-4" style="border:none;">
                            <h3 class="card-title text-gray-800 ms-4">
                               
                                <asp:Label ID="lblPackageNo" Text='<%# Eval("tph_Number")%>' runat="server"></asp:Label>
                            </h3>
                                <div class="card-title text-primary fs-4"><asp:Label ID="lblitemcount" Text='<%# Eval("itmCount")+" items" %>' runat="server"></asp:Label>
                                      <asp:ImageButton ID="btnItemDetail"  runat="server" Height="10" CausesValidation="False" style="margin:7px;" OnClick="btnItemDetail_Click"  CommandArgument='<%# Eval("tph_ID") %>'
                                                                                          ImageUrl="../assets/media/svg/general/greater.svg"></asp:ImageButton>
                               
                                        </div> 
                        </div>

                        <div class="Card-body pb-0 m-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المستهدف </span><br />
                          <span class="fw-bold text-dark h4">
                              <asp:Label ID="lblDailyTargetAmount" Text='<%# Eval("TargetAmount") %>' runat="server"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المحقق </span><br />
                          <span class="fw-bold text-success h4 text-success">
                              <asp:Label ID="lblDailyAchievedAmount" Text='<%# Eval("AchievedAmount")+"/"+Eval("AmountPerc")+"%" %>' runat="server"></asp:Label>
                          </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                          <span class="fw-bold text-warning h4">
                              <asp:Label ID="lblDailyRemainingAmount" Text='<%# Eval("RemAmount")+"/"+Eval("RemAmountPerc")+"%" %>' runat="server"></asp:Label></span>
                      </div>
                            <div class="separator separator-dashed my-1"></div>
                            </div>

                       <div class="Card-body pb-0 mx-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المستهدفة</span><br />
                            
                          <span class="fw-bold text-dark h5">
                              <asp:Label ID="lblDailyTargetQty" Text='<%# Eval("TargetQty") %>' runat="server"></asp:Label>  </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المحققة </span><br />
                          <span class="fw-bold text-success h5"> 
                              <asp:Label ID="lblDailyAchievedQty" Text='<%# Eval("AchievedQty")+"/"+Eval("QtyPerc")+"%" %>' runat="server"></asp:Label>  </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                          <span class="fw-bold text-warning h5"> 
                              <asp:Label ID="lblDailyRemainingQty" Text='<%# Eval("RemQty")+"/"+Eval("RemQtyPerc")+"%" %>' runat="server"></asp:Label> </span>
                      </div>
                           
                            </div>
                        
                           </div>
                                     </ItemTemplate>
                                  </asp:Repeater>
                         <%--end border1--%>
                       
                         <%-- border2--%>
                      
                         <%--end border2--%>
                       
                          </div>

                    </div>
                        
                </div>

                <div class="col-lg-6">
                    <div class="card card-flush mb-5">
                          <div class="card-header pt-5 ms-4">
                            <h3 class="card-title text-gray-800">
                                الهدف الشهري
                            </h3>
                        </div>
                          <div class="Card-body pb-0 m-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ الإجمالي المستهدف </span><br />
                          
                          <span class="fw-bold text-dark h4">
                              <asp:Label ID="lblMonthTargetAmt" runat="server" Text="0"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المحقق </span><br />
                             
                          <span class="fw-bold text-success h4 text-success"> 
                              <asp:Label ID="lblMonthAchievedAmt" runat="server" Text="0"></asp:Label></span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                            
                          <span class="fw-bold text-warning h4">
                              <asp:Label ID="lblMonthRemainAmt" runat="server" Text="0"></asp:Label></span>
                      </div>
                            <div class="separator separator-dashed my-1"></div>
                            </div>

                       <div class="Card-body pb-0 mx-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية الإجمالية المستهدفة </span><br />
                        
                          <span class="fw-bold text-dark h5">
                              <asp:Label ID="lblMonthTargetQty" runat="server" Text="0"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المحققة </span><br />
                           
                          <span class="fw-bold text-success h5">
                              <asp:Label ID="lblMonthAchievedQty" runat="server" Text="0"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                           
                          <span class="fw-bold text-warning h5">
                              <asp:Label ID="lblMonthRemainQty" runat="server" Text="0"></asp:Label></span>
                      </div>
                           
                            </div>
                        <div class="table-responsive pb-10" style="height:400px;">
                       <%-- border1--%>
                       
                        <asp:Repeater runat="server" ID="rptMonthPackage">
                                 <ItemTemplate>
                       <div class="mx-6 m-2 rounded" style="border-style:solid; border-width:thin; border-color:gainsboro;">
                            <div class="card-header pt-4" style="border:none;">
                            <h3 class="card-title text-gray-800 ms-4">
                               
                                <asp:Label ID="lblMPackageNo" Text='<%# Eval("tph_Number") %>' runat="server"></asp:Label>
                            </h3>
                                <div class="card-title text-primary fs-4"><asp:Label ID="lblMitemcount" Text='<%# Eval("itmCount")+" items" %>' runat="server"></asp:Label>

                                      <asp:ImageButton ID="btnMonthlyProduct" Visible="true" CausesValidation="False" runat="server" Height="10" style="margin:7px;" CommandArgument='<%# Eval("tph_ID") %>' OnClick="btnMonthlyProduct_Click"
                                                                                          ImageUrl="../assets/media/svg/general/greater.svg"></asp:ImageButton>
                          
                                   </div> 
                        </div>

                        <div class="Card-body pb-0 m-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المستهدف </span><br />
                          <span class="fw-bold text-dark h4">
                              <asp:Label ID="lblMonthlyTargetAmount" Text='<%# Eval("TargetAmount") %>' runat="server"></asp:Label> </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">المبلغ المحقق </span><br />
                          <span class="fw-bold text-success h4 text-success">
                              <asp:Label ID="lblMonthlyAchievedAmount" Text='<%# Eval("AchievedAmount")+"/"+Eval("AmountPerc")+"%" %>' runat="server"></asp:Label>
                          </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                          <span class="fw-bold text-warning h4">
                              <asp:Label ID="lblMonthlyRemainingAmount" Text='<%# Eval("RemAmount")+"/"+Eval("RemAmountPerc")+"%" %>' runat="server"></asp:Label></span>
                      </div>
                            <div class="separator separator-dashed my-1"></div>
                            </div>

                       <div class="Card-body pb-0 mx-5 row">
                      <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المستهدفة</span><br />
                            
                          <span class="fw-bold text-dark h5">
                              <asp:Label ID="lblMonthlyTargetQty" Text='<%# Eval("TargetQty") %>' runat="server"></asp:Label>  </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المحققة </span><br />
                          <span class="fw-bold text-success h5"> 
                              <asp:Label ID="lblMonthlyAchievedQty" Text='<%# Eval("AchievedQty")+"/"+Eval("QtyPerc")+"%" %>' runat="server"></asp:Label>  </span>
                      </div>
                        <div class="px-2 mb-5 col-sm-4">
                          <span class="fs-8 fw-semibold text-gray-700 pt-5">الكمية المتبقية </span><br />
                          <span class="fw-bold text-warning h5"> 
                              <asp:Label ID="lblMonthlyRemainingQty" Text='<%# Eval("RemQty")+"/"+Eval("RemQtyPerc")+"%" %>' runat="server"></asp:Label> </span>
                      </div>
                           
                            </div>
                        
                           </div>
                                     </ItemTemplate>
                                  </asp:Repeater>
                         <%--end border1--%>
                       
                         <%-- border2--%>
                       
                       
                         <%--end border2--%>
                       </div>
                    </div>
                </div>


            </div>
      
    </div>
    <style>
       .rounded {
        border-radius: 1.475rem !important;
}
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