<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListAssets.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListAssets" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script>
        function Question()
        {
            debugger;
            $('#kt_modal_1_8').modal('show');
        }
     </script>
</asp:Content>
<asp:Content ID="ContentAction" ContentPlaceHolderID="Actions" runat="server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        
     <asp:LinkButton ID="lnkAddUser" runat="server" CssClass="btn btn-sm fw-bold btn-primary" OnClick="lnkAddUser_Click">
                                                    Add
                            </asp:LinkButton>
     </telerik:RadAjaxPanel>
                         <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
   </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="grvRpt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ltTable" />
                    <telerik:AjaxUpdatedControl ControlID="RadPanelBar0" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>

    <div class="card-body" style="background-color:white; padding:20px;">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <!--begin::Portlet-->
                <div class="kt-portlet">                  
                        <div class="col-lg-10">


                            <h6 class="kt-portlet__head-title"><asp:Literal ID="ltrlCustomer" runat="server"></asp:Literal> 
                            </h6>
                           
                        </div>
                     <div class ="col-lg-6 row" style="padding-bottom:5px;">
       <div class="col-lg-6 row">
       <label class="control-label col-lg-12">Type</label>
       <div class="col-lg-12">
           <telerik:RadComboBox ID="ddlType"  runat="server" Width="100%" DefaultMessage="Select Status" OnSelectedIndexChanged="ddlType_SelectedIndexChanged"  RenderMode="Lightweight"  CausesValidation="false" AutoPostBack="true">
               <Items>
                   <telerik:RadComboBoxItem Text="All" Value="A" Selected="true" />
                   <telerik:RadComboBoxItem Text="Assigned" Value="AS" />
                   <telerik:RadComboBoxItem Text="Unassigned" Value="UAS" />
                  
               </Items>
           </telerik:RadComboBox>
          
       </div>
</div>
          </div>
                       
                    <!--begin::Form-->
                    <div class="kt-form kt-form--label-right">
                        <div class="kt-portlet__body">
                            <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                            <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        
                            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                            <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="60" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="atm_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                         <telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="30px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                        </telerik:GridButtonColumn>
                                         <telerik:GridBoundColumn DataField="atm_Code" AllowFiltering="true" HeaderStyle-Width="60px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Serial Number" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="atm_Code">
                                         </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="atm_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Reference Name" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="atm_Name">
                                             </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="ast_Name" AllowFiltering="true" HeaderStyle-Width="60px"
                                           HeaderStyle-Font-Size="Smaller" HeaderText="Type" FilterControlWidth="100%"
                                           CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                           HeaderStyle-Font-Bold="true" UniqueName="ast_Name">
                                       </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="AssStatus" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Assigned Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="AssStatus">
                                        </telerik:GridBoundColumn>                                       
                                                                             

                                        <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="60px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="Status">
                                        </telerik:GridBoundColumn>

                                          <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Customer" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
      <ItemTemplate>
          <asp:ImageButton CommandName="Customer" ID="RadImageButton4" Visible="true" AlternateText="Customer" runat="server"
              ImageUrl="../assets/media/svg/general/User.svg"></asp:ImageButton>
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
        </div>
    </div>
    </div>

     <!--begin::QuestionModal-->
    <div class="modal fade" id="kt_modal_1_8" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Questions assigned for Asset</h5>
                </div>
                <div class="modal-body">

                    <telerik:RadPanelBar RenderMode="Lightweight" CssClass="col-lg-12" Width="100%" ID="RadPanelBar0" runat="server">
                                <Items>
                                     <telerik:RadPanelItem Font-Bold="true" Expanded="false" BackColor="#F2F6F9">

                                        <ContentTemplate>
                   <div class="col-lg-6 mb-2">
                        <label class="col-lg-4 col-form-label" style="display: contents;">
                        <asp:Label ID="lblAsset" Font-Bold="true" runat="server"></asp:Label></label>
                  </div>    
                                            </ContentTemplate>
                                         </telerik:RadPanelItem>
                    </Items>
                    </telerik:RadPanelBar>
                    <asp:Literal ID="ltTable" runat="server" />
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-dismiss="modal">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::QuestionModal-->
</asp:Content>
