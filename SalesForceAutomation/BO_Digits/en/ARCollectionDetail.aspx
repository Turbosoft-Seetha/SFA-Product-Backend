<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ARCollectionDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ARCollectionDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
     <span class="fw-bolder"> Date : </span> 
    <asp:Label runat="server" ID="lbldat"></asp:Label>
    <span class="mx-4 fw-bolder"> Route :  </span>
    <asp:Label runat="server" ID="lblroute"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="card-body" style="background-color:white; padding:20px;">
       
    <div class="col-lg-12">

            <div class="card-header pt-5 ms-4 pb-4" style="border-bottom-style:groove; border-bottom-width:2px;">
                            <h3 class="card-title text-gray-800">
                               <asp:Label runat="server" ID="lblNumber">    </asp:Label>                               
                            </h3>
                             <div class="my-2 text-gray-600 fw-semibold fs-6">  <asp:Label runat="server" ID="lblCus">    </asp:Label> </div>
                             <div class="my-2 text-gray-600 fw-semibold fs-6">   <asp:Label runat="server" ID="lblDate">    </asp:Label> </div>
             </div>

            <div class="card-body m-2 pt-5 col-lg-12 row" style="border-bottom-style:groove; border-bottom-width:2px;">
                <div class="col-lg-6">

                     <table class="table align-middle gs-0 gy-2">
                    <tr>
                            <td>
                              <h4>  Total Collection Amount </h4>
                            </td>
                           
                            <td>
                              <h4>: <asp:Label runat="server" ID="lblTotalcollection"> </asp:Label> </h4>
                            </td>
                    </tr>
                     <tr>
                            <td>
                             <h4>   Mode </h4>
                            </td>
                          
                            <td>
                             <h4>  : <asp:Label runat="server" ID="lblmode">  </asp:Label> </h4>
                            </td>
                    </tr>
                     <tr>
                            <td>
                               <h4> Remarks  </h4>
                            </td>
                         
                            <td>
                             <h4> : <asp:Label runat="server" ID="lblremarks"> </asp:Label> </h4>
                            </td>
                    </tr>
                </table>

                </div>
                <div class="col-lg-6">

                 <asp:PlaceHolder runat="server" ID="Img">
                   <div class="symbol symbol-65px symbol-rounded me-10 py-2" style="display:flex; justify-content:flex-end;">
                       <asp:Repeater runat="server" ID="rptArImg">
                             <ItemTemplate>
                              
                                  <asp:HyperLink ID="ar" runat="server" NavigateUrl=' <%#  Eval("arp_Image1") %>' Target="_blank" >
                                        <asp:Image  ID="itmImg" runat="server" ImageUrl=' <%#  Eval("arp_Image1") %>'  Height="100px" width="100px" />
                                  </asp:HyperLink>
                              </ItemTemplate>
                         </asp:Repeater>
                   </div>
                </asp:PlaceHolder>

                </div>
            </div>

            <div class="card-body col-lg-12 ms-4 pt-5 pe-0">
                <div class="table-responsive pe-2" style="height:400px;">
                     <table class="table table-row-dashed align-middle gs-0 gy-6 my-0 pe-1 table-responsive">
                    <thead>
                        <tr class="fs-5 fw-bold text-gray-500 border-bottom-1">
                            <th colspan="4">Invoice Number</th>
                            <th class="text-end pe-16">Date</th>
                            <th class="text-end">Inv Amount</th>
                            <th class="text-end">Alct Amount</th>
                        </tr>
                    </thead>
                    <tbody>

                         <asp:Repeater runat="server" ID="rptARCollection">
                             <ItemTemplate>
															
                                <tr class="fs-6 fw-bold text-gray-800 border-bottom-1">
                                    <td colspan="4"> <asp:Label runat="server" Text='<%# Eval("inv_InvoiceID") %>'>  </asp:Label> </td>
                                    <td class="text-end"> <asp:Label runat="server" Text='<%# Eval("CreatedDate") %>'>   </asp:Label> </td>
                                    <td class="text-end"> <asp:Label runat="server" Text='<%# Eval("inv_InitialPaidAmount") %>'>  </asp:Label>  </td>
                                    <td class="text-end"> <asp:Label runat="server" Text='<%# Eval("ard_Amount") %>'>  </asp:Label>  </td>
                                </tr>

                             </ItemTemplate>
                         </asp:Repeater>
                   </tbody>
                </table>
                </div>
            </div>
            

    </div>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
