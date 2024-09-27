<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="MaterialReqApprovalHeader.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.MaterialReqApprovalHeader" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
     <script type="text/javascript">
        function Confim() {
            $('#modalConfirm').modal('show');
        }
        function successModal(a) {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_4').modal('show');
            $('#success').text(a);
        }
        function failedModal(b) {
            $('#kt_modal_1_5').modal('show');
            $('#failtext').text(b);
        }
        function Delete() {
             $('#kt_modal_1_7').modal('show');
        }
        function deleteSucces(c) {
             $('#kt_modal_1_7').modal('hide');
            $('#kt_modal_1_8').modal('show');
            $('#delsuccess').text(c);
         }
        
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
       <div class="card-body p-8" style="background-color:white;">
           <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
           
                         <%-- Filter starts --%>

                           <div class="col-lg-12 row mb-4">
                                 <div class="col-lg-2">
                    <label class="control-label col-lg-12">From Date</label>
                    <div class="col-lg-12">
                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdfromDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" OnSelectedDateChanged="rdfromDate_SelectedDateChanged" AutoPostBack="true">
                        </telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="From Date is mandatory" ForeColor="Red" ControlToValidate="rdfromDate"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="col-lg-2">
                    <label class="control-label col-lg-12">To Date</label>
                    <div class="col-lg-12">
                        <telerik:RadDatePicker RenderMode="Lightweight" ID="rdendDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server" Width="100%" OnSelectedDateChanged="rdendDate_SelectedDateChanged" AutoPostBack="true">
                        </telerik:RadDatePicker>
                        <asp:CompareValidator ID="dd" runat="server" ControlToValidate="rdendDate" ControlToCompare="rdfromDate" ErrorMessage="End date must be greater"
                            Display="Dynamic" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="l" runat="server" Display="Dynamic" ErrorMessage="To Date is mandatory" ForeColor="Red" ControlToValidate="rdendDate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                                  <%--<div class="col-lg-3">
                <label class="control-label col-lg-12">Route</label>
                <div class="col-lg-12">
                    <telerik:RadComboBox ID="rdRoute" runat="server" EmptyMessage="Select Route" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true"></telerik:RadComboBox>
                  
                </div>
            </div>
                                 <div class="col-lg-3">
                                        <label class="control-label col-lg-12">Customer</label>
                                                       <div class="col-lg-12">
                                            <telerik:RadComboBox ID="rdCustomer" runat="server" EmptyMessage="Select Customer" Filter="Contains" Width="100%" RenderMode="Lightweight" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"  OnSelectedIndexChanged="rdCustomer_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                 
                                        </div>

                                    </div>--%>



                                  <div class="col-lg-2">
                                <label class="control-label col-lg-12 ">Status </label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStatus" RenderMode="Lightweight" runat="server" Width="100%" DefaultMessage="Select Route Type">
                                        <Items>
                                            <telerik:DropDownListItem Text="Approved" Value="A" />
                                            <telerik:DropDownListItem Text="Approved and Hold" Value="AH" />
                                            <telerik:DropDownListItem Text="Pending" Value="P" Selected ="true" />

                                             <telerik:DropDownListItem Text="Rejected" Value="R" />
                                            


                                        </Items>
                                    </telerik:RadDropDownList>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="form"
                         ControlToValidate="ddlStatus" ErrorMessage="<br/>Please Select Status" ForeColor="Red" Display="Dynamic"
                         SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
          
         
            <div class="col-lg-2 pt-5 mt-2" style="text-align: center; ">
                <asp:LinkButton ID="lnkFilter" runat="server" CssClass="btn btn-sm btn-primary me-2" BackColor="#DAE9F8" ForeColor="#009EF7" OnClick="lnkFilter_Click">
                                                    Apply Filter
                </asp:LinkButton>
            </div>

        </div>

                         <%-- Filter ends --%>

                         <%-- Grid starts --%>
                <div class="kt-form kt-form--label-right">
                            <div class="kt-portlet__body">
                           <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                           <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="true"
                                ID="grvRpt" GridLines="None"
                                ShowFooter="True" AllowSorting="True"
                                OnNeedDataSource="grvRpt_NeedDataSource"
                                OnItemCommand="grvRpt_ItemCommand"                               
                                AllowFilteringByColumn="true"
                                ClientSettings-Resizing-ClipCellContentOnResize="true"
                                EnableAjaxSkinRendering="true"
                                AllowPaging="true" PageSize="50" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                    ShowFooter="false" DataKeyNames="mrh_ID"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        
                                         <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="Detail" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Detail">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Detail" ID="Detail" Visible="true" AlternateText="Detail" runat="server"
                                                    ImageUrl="../assets/media/icons/details.png"></asp:ImageButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                       
                                         <telerik:GridBoundColumn DataField="mrh_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_ID" Display="false">
                                        </telerik:GridBoundColumn>
                                       
                                        <telerik:GridBoundColumn DataField="mrh_Number" AllowFiltering="true" HeaderStyle-Width="200px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Request ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_Number">
                                        </telerik:GridBoundColumn>
                                        
                                         <telerik:GridBoundColumn DataField="mrh_str_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_str_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_str_ID" Display="false">
                                        </telerik:GridBoundColumn>

                                         <telerik:GridBoundColumn DataField="str_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                             HeaderStyle-Font-Size="Smaller" HeaderText="Receiving Location" FilterControlWidth="100%"
                                             CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                             HeaderStyle-Font-Bold="true" UniqueName="str_Name">
                                         </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="mrh_war_ID" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="mrh_war_ID" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_war_ID" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="war_Name" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Picking Location" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="war_Name">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="mrh_ExpDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Exp. Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_ExpDate">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Created Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="mrh_Status" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Status" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_Status">
                                        </telerik:GridBoundColumn>
                                      
                                         <telerik:GridBoundColumn DataField="mrh_Remarks" AllowFiltering="true" HeaderStyle-Width="150px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Remarks" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="mrh_Remarks">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ModifiedBy" AllowFiltering="true" HeaderStyle-Width="100px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText="Approved By" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ModifiedBy">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="ModifiedDate" AllowFiltering="true" HeaderStyle-Width="120px"
                                            HeaderStyle-Font-Size="Smaller" HeaderText=" Approved Date" FilterControlWidth="100%"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                            HeaderStyle-Font-Bold="true" UniqueName="ModifiedDate">
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
                        </div>

                         <%-- Grid ends --%>

                         <%-- Dispatch button starts --%>
                
                           <div class="col-lg-12 pt-4" style="display:flex;justify-content:flex-end;">

                          
                            <div class="col-lg-1 pt-4">
                 </div>
                           
           <div class="col-lg-2 ps-12">
                                </div>
                     <div class="col-lg-2">
                          </div>      
                           
               </div>

                         <%-- Dispatch button ends --%>

           </telerik:RadAjaxPanel>
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
                                BackColor="Transparent"
                                ForeColor="Blue">
                                <div class="col-lg-12 text-center mt-5">
                                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                                </div>
                            </telerik:RadAjaxLoadingPanel>
     </div>


      <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" style="height:auto;" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" OnClick="save_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
    <div class="modal fade" id="kt_modal_1_4" style="height:auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-sm fw-bold btn-secondary">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->

    <!--begin::FailedModal-->
    <div class="modal fade" id="kt_modal_1_5" style="height:auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Oops..!</h5>
                </div>
                <div class="modal-body">
                    <span id="failtext"></span>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_5);">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <!--end::FailedModal-->
     <!--begin::DeleteValidationModal-->
    

    <!--begin::SuccessModal-->
    <div class="modal fade" id="kt_modal_1_8" style="height:auto;"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="delsuccess"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn btn-sm fw-bold btn-secondary">Ok</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!--end::SuccessModal-->
   
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>