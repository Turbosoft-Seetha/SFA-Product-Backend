<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="APCollectionDetail.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.APCollectionDetail" %>
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
       
    <div class="col-lg-12" style="height:1000px;">

            <div class="card-header pt-5 ms-4 pb-4" style="border-bottom-style:groove; border-bottom-width:2px;">
                            <h3 class="card-title text-gray-800">
                               <asp:Label runat="server" ID="lblNumber">  M1234564  </asp:Label>                               
                            </h3>
                             <div class="my-2 text-gray-600 fw-semibold fs-6">  <asp:Label runat="server" ID="lblCus">  A029004 - JW Marriot Marquise Hotel  </asp:Label> </div>
                             <div class="my-2 text-gray-600 fw-semibold fs-6">   <asp:Label runat="server" ID="lblDate">  21 Feb 2022 | 10.30  </asp:Label> </div>
             </div>

            <div class="card-body m-2 pt-5 col-lg-12 row">
                <div class="col-lg-6">

                     <table class="table align-middle gs-0 gy-2">
                    <tr>
                            <td>
                              <h4>  Total Collection Amount </h4>
                            </td>
                           
                            <td>
                              <h4>:<asp:Label runat="server" ID="lblTotalcollection">  </asp:Label></h4>
                            </td>
                    </tr>
                     <tr>
                            <td>
                             <h4>   Mode </h4>
                            </td>
                          
                            <td>
                             <h4>  :<asp:Label runat="server" ID="lblmode">  </asp:Label>  </h4>
                            </td>
                    </tr>
                     <tr>
                            <td>
                               <h4> Remarks  </h4>
                            </td>
                         
                            <td>
                             <h4> : <asp:Label runat="server" ID="lblremarks">  </asp:Label>  </h4>
                            </td>
                    </tr>
                </table>

                </div>
                <div class="col-lg-6">

                    <asp:PlaceHolder runat="server" ID="Img">

                   <div class="symbol symbol-65px symbol-rounded me-10 py-2" style="display:flex; justify-content:flex-end;">
                       <asp:Repeater runat="server" ID="rptAPCollection">
                             <ItemTemplate>
                              
                                  <asp:HyperLink ID="ap" runat="server" NavigateUrl=' <%#  Eval("adp_Image") %>' Target="_blank" >
                                        <asp:Image  ID="itmImage" runat="server" ImageUrl=' <%#  Eval("adp_Image") %>'  Height="100px" width="100px"  />
                                  </asp:HyperLink>
                              </ItemTemplate>
                         </asp:Repeater>
                   </div>

                </asp:PlaceHolder>

                </div>
            </div>

            

    </div>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
    
</asp:Content>
