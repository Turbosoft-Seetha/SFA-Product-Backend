<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="ListAppWebservices.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.ListAppWebservices" %>

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
        function delConfim() {
            $('#modaldelConfirm').modal('show');

        }
        function successModal() {
            $('#modaldelConfirm').modal('hide');
            $('#kt_modal_1_7').modal('show');
        }

        function Failure() {
            $('#modalConfirm').modal('hide');
            $('#kt_modal_1_5').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
    <telerik:RadAjaxPanel ID="rdd" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:LinkButton ID="LinkButton2" Width="100px" runat="server"
            Text="Cancel"
            CausesValidation="False" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="LinkButton2_Click" />


        <asp:LinkButton ID="lnkAdd" Width="100px" runat="server" ValidationGroup="form" OnClick="lnkAdd_Click" UseSubmitBehavior="false"
            Text='<i class="icon-ok"></i>Add' CssClass="btn btn-sm fw-bold btn-primary" CausesValidation="true" />
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card-body p-8" style="background-color: white;">
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

            <%-- Filter starts --%>

            <div class="col-lg-12 row mb-4">

                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Name of WS<span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadTextBox RenderMode="Lightweight" ID="txtWs" runat="server" Width="100%" AutoPostBack="true">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                            ControlToValidate="txtWs" ErrorMessage="Please Enter" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                    </div>
                </div>



                <div class="col-lg-2">
                    <label class="control-label col-lg-12">Route Type <span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="ddlrottype" runat="server" Width="100%" EmptyMessage="Select Route Type" RenderMode="Lightweight" Filter="Contains" CheckBoxes="true"
                            CausesValidation="false">
                        </telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="form" runat="server"
                            ControlToValidate="ddlrottype" ErrorMessage="Please Select Route Type" ForeColor="Red" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                    </div>
                </div>

                <div class="col-lg-2 ">
                    <label class="control-label col-lg-12">Is Enable<span class="required"></span></label>
                    <div class="col-lg-12">
                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" RenderMode="Lightweight" SelectionMode="Single" EmptyMessage="Please Select">
                            <Items>
                                <telerik:RadComboBoxItem Text="Yes" Value="Y" />
                                <telerik:RadComboBoxItem Text="No" Value="N" />
                            </Items>
                        </telerik:RadComboBox>
                    </div>
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
                        AllowPaging="true" PageSize="100" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                            ShowFooter="false" DataKeyNames="aws_ID"
                            EnableHeaderContextMenu="true">
                            <Columns>


                                <%--<telerik:GridButtonColumn CommandName="Edit" Text='<i class="fa fa-edit"></i>' HeaderStyle-Width="30px" EditFormColumnIndex="0" UniqueName="EditColumn">
                                </telerik:GridButtonColumn>--%>
                                <telerik:GridTemplateColumn HeaderStyle-Width="40px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true" UniqueName="Delete">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Delete" ID="Delete" Visible="true" AlternateText="Delete" runat="server"
                                            SetFocusOnError="false"
                                            ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="aws_ID" AllowFiltering="true" HeaderStyle-Width="50px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="aws_ID" Display="false">
                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="aws_Code" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Code" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="aws_Code">
                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="aws_Name" AllowFiltering="true" HeaderStyle-Width="140px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="WS/PHP" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="aws_Name">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="aws_rotType" AllowFiltering="true" HeaderStyle-Width="140px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Route Type" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="aws_rotType">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Status" AllowFiltering="true" HeaderStyle-Width="140px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Is Enable" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="Status">
                                </telerik:GridBoundColumn>




                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </div>
            </div>

            <%-- Grid ends --%>
        </telerik:RadAjaxPanel>
    </div>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel2" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>



    <div class="clearfix"></div>
    <div class="modal fade modal-center" id="modalConfirm" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Confirm">Are you sure you want to save..??
                    </h5>
                </div>
                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                        <asp:LinkButton ID="save" runat="server" Text="Yes" ValidationGroup="form" CssClass="btn btn-sm fw-bold btn-primary" OnClick="save_Click" />
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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

    <div class="modal fade" id="kt_modal_1_4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="height: auto;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                </div>
                <div class="modal-body">
                    <span id="success"></span>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnOK" runat="server" CssClass="btn btn-sm fw-bold btn-secondary" OnClick="btnOK_Click">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
     <%--delete--%>
 <div class="modal fade modal-center" id="modaldelConfirm" tabindex="-1" role="dialog" style="height:auto" data-backdrop="static" data-keyboard="false" aria-labelledby="exampleModalLabels" aria-hidden="true">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title">Are you sure you want to delete..??
                 </h5>
             </div>
             <div class="modal-footer">
                 <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                     <asp:LinkButton ID="BtnConfrmDelete" runat="server" Text="Yes" OnClick="BtnConfrmDelete_Click" CssClass="btn btn-sm fw-bold btn-primary" />
                 </telerik:RadAjaxPanel>
                 <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
                     BackColor="Transparent"
                     ForeColor="Blue">
                     <div class="col-lg-12 text-center mt-5">
                         <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                     </div>
                 </telerik:RadAjaxLoadingPanel>
                 <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(modaldelConfirm);">Cancel</button>
             </div>
         </div>
     </div>
 </div>


     <!--begin::FailedModal-->
 <div class="modal fade" id="kt_modal_1_5" tabindex="-1" role="dialog" style="height:auto" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
