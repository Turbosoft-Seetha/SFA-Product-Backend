<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="MerchandisingTransaction.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.MerchandisingTransaction" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
     
                                                 
   </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">                
                          
                                <div class="col-sm-6" style="margin-bottom:10px;">
                                 <h6 class="kt-portlet__head-title">عملية العميل- <asp:Label ID="lblType" runat="server" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                    </h6>
                                 </div>
                               
                     
                   

                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body pb-0" style="border-bottom-style:inset;border-bottom-width:thin; padding-top:10px; margin-bottom:10px;">


                             <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server" BorderStyle="None">
                                <Items>
                                    <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">
                                        <ContentTemplate>
                                            <div class="kt-portlet__body" style= "display: grid;">
                                                <table>
                                                    <td style="width: 56%; padding-left:40px;">
                                                      <div class="col-lg-12 mb-2 row">
                                                        <div class="col-lg-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">طريق:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblRoute" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">مستخدم:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblUser" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">إصدار:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblVersion" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                          <%-- <div class="col-lg-3">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Date:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblCreatedDate" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>--%>
                                                       </div>
                                                    </td>
                                                   <%-- <td>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">Start Time:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblStartTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        <div class="col-lg-12 mb-2">
                                                            <label class="col-lg-2 col-form-label" style="display: contents;">End Time:</label>
                                                            <label class="col-lg-4 col-form-label" style="display: contents;">
                                                                <asp:Label ID="lblEndTime" Font-Bold="true" runat="server"></asp:Label></label>
                                                        </div>
                                                        
                                                    </td>--%>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        
                          
                         </div>

                            
                            <!-- ---------------------------- -->
                           

                            <!-- ---------------------------- -->




                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                            <div class="kt-portlet__body">
                                <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                    ID="grvRpt" GridLines="None"
                                    ShowFooter="True" AllowSorting="True"
                                    OnNeedDataSource="grvRpt_NeedDataSource"
                                    OnItemDataBound="grvRpt_ItemDataBound"
                                    OnItemCommand="grvRpt_ItemCommand"
                                    OnPreRender="grvRpt_PreRender"                  
                                    AllowFilteringByColumn="false"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    AllowPaging="true" PageSize="50" CellSpacing="0">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="true" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false" DataKeyNames="id"
                                        EnableHeaderContextMenu="true">
                                        <Columns>

                                               <telerik:GridTemplateColumn HeaderStyle-Width="60px" UniqueName="detail" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" >
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Detail" ID="RadImageButton2" Visible="true" AlternateText="Detail" runat="server"
                                                        ImageUrl="../assets/media/svg/general/details.PNG"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>



                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Images" UniqueName="Images" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>



                                         <%--<telerik:GridTemplateColumn  UniqueName="Images"  AllowFiltering="false"  HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Image"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                  
                                                     <asp:HyperLink ID="Img" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("Image")%>' NavigateUrl='<%#"../" + Eval("Image")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>

                                             <telerik:GridTemplateColumn HeaderStyle-Width="73px" HeaderText="Reference Image" UniqueName="RefImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                 
                                                    <asp:HyperLink ID="RefImg" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("ReferenceImage")%>' NavigateUrl='<%#"../" + Eval("ReferenceImage")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                             <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Captured Image" UniqueName="CapImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                 
                                                    <asp:HyperLink ID="CapImg" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("CapturedImage")%>' NavigateUrl='<%#"../" + Eval("CapturedImage")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                             <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Request Image" UniqueName="ReqImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                 
                                                    <asp:HyperLink ID="ReqImg" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("RequestImage")%>' NavigateUrl='<%#"../" + Eval("RequestImage")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                              <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Response Image" UniqueName="RespImages" HeaderStyle-Font-Bold="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                 
                                                    <asp:HyperLink ID="RespImg" ImageHeight="20px" ImageWidth="20px" runat="server"
                                                        ImageUrl='<%# "../" +Eval("ResponseImage")%>' NavigateUrl='<%#"../" + Eval("RequestImage")%>' Height="20px" width="20px" Target="_blank">
                                                    </asp:HyperLink>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                             <telerik:GridTemplateColumn  AllowFiltering="false"
                                                HeaderStyle-Width="80px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="Attachment" UniqueName="Attachments"
                                                HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="pp" runat="server"
                                                        ImageUrl="../assets/media/svg/Files/File.svg" NavigateUrl='<%# "../" + Eval("Attachment")%>' Height="50" Width="50" Target="_blank">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

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
</asp:Content>