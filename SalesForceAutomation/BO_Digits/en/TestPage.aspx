<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.TestPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
            <div class="card-body" style="background-color: white; padding: 20px;">
        <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
            <div class="row">
                <div class="col-lg-12">
                    <!--begin::Portlet-->
                    <div class="kt-portlet">

                        <div class="kt-form kt-form--label-right">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                              <div class="col-lg-12 row">
                              <div class="col-lg-12 form-group d-flex">
                                  <label class="control-label"><span class="min-w-60px fw-semibold text-black-500 pt-5" style="font-size:15px;">Schedule Job  </span>
                                      <span class="min-w-40px fw-semibold text-gray-500 pt-5">( Customer Preffered Date & Time : </span>

                                  </label>
                                  <div class="col-lg-6 pt-5 pb-0" >

                                           <telerik:RadLabel ID="lblpreffered" Width="100%" Text="14 Jun 2024 |11:30"    runat="server"><span class="min-w-40px fw-semibold text-gray-500"> ) </span>
                                         </telerik:RadLabel>

                                  </div>
                              </div>

                          </div>

                                    <div class="col-lg-12 row">
                                        <div class="col-lg-6">
                                <div class="col-lg-12 form-group d-flex align-items-center" >
                                    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5">Expected Duration :  </span>
                                       

                                    </label>
                                    <div class="col-lg-4 pt-0 pl-0">

                                              <telerik:RadNumericTextBox ID="rdDuration" Width="65%" NumberFormat-DecimalDigits="0" runat="server"  RenderMode="Lightweight"  >
                                                 
                                              </telerik:RadNumericTextBox> <span class="min-w-40px fw-semibold text-black-600 pt-5">Hrs  </span>

                                    </div>

                                    <div class="col-lg-4 pt-0 pl-0">

                                <telerik:RadNumericTextBox ID="rdMinutes" NumberFormat-DecimalDigits="0" Width="65%" runat="server"  RenderMode="Lightweight"  ></telerik:RadNumericTextBox>
             
           <span class="min-w-60px fw-semibold text-black-600 pt-5">Mints  </span>

</div>
                                </div>

                                            </div>
                                         <div class="col-lg-3">
                                      <div class="col-lg-12 form-group d-flex">
                                    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5">Scheduled Date :  </span>
                                       

                                    </label>
                                    <div class="col-lg-6 pt-0 pl-3">

      <telerik:RadDatePicker  ID="SCHdate"   RenderMode="Lightweight" Width="100%"  DateInput-DateFormat="dd-MMM-yyyy" runat="server">
</telerik:RadDatePicker>                                                 
                                             

                                    </div>
                                </div>


                                             </div>
                                                                                 <div class="col-lg-3">
                                                                             <div class="col-lg-12 form-group d-flex">
                                    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5">Scheduled Time :  </span>
                                       

                                    </label>
                                    <div class="col-lg-6 pt-0 pl-3">

                 <telerik:RadTimePicker  ID="rdTimePicker" DateInput-DateFormat="HH:mm" Width="100%"   RenderMode="Lightweight"  runat="server">
</telerik:RadTimePicker>                

                                    </div>
                                </div>


                                             </div>


                            </div>


                                    <div class="col-lg-12 row" style="padding-top:15px;">
    <div class="col-lg-12 form-group d-flex">
        <label class="control-label"><span class="min-w-60px fw-semibold text-black-500 pt-5" style="font-size:15px;">Required Inventory & Tools </span>
           

        </label>
      
    </div>

</div>

                                   <div class="col-lg-12 row" style="padding-top:10px;">
                                        <div class="col-lg-8">

                                            <div class="col-lg-12 row">
                                                                                         <div class="col-lg-6">
                                      <div class="col-lg-12 form-group d-flex">
                                    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5">Select Product :  </span>
                                       

                                    </label>
                                    <div class="col-lg-6 pt-0 pl-3">
                                <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" EmptyMessage="Select Product" Filter="Contains"  RenderMode="Lightweight"></telerik:RadComboBox>
                                              
                                             

                                    </div>
                                </div>


                                             </div>

                                                        <div class="col-lg-4">
                                      <div class="col-lg-12 form-group d-flex">
                                    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5">Quantity :  </span>
                                       

                                    </label>
                                    <div class="col-lg-6 pt-0 pl-3">
                                <telerik:RadNumericTextBox ID="txtQty" NumberFormat-DecimalDigits="0" runat="server" RenderMode="Lightweight" Width="100%" ></telerik:RadNumericTextBox>
                                              
                                             

                                    </div>
                                </div>


                                             </div>

                               <div class="col-lg-2" style="text-align: center; margin-top: -8px;">
                                      <div class="col-lg-12 form-group d-flex">
                                  
                                    <div class="col-lg-12 pt-0 pl-3">
 <asp:LinkButton ID="AddItem" runat="server" CssClass="btn btn-sm btn-primary me-2" ValidationGroup="form" CausesValidation="true"  BackColor="#DAE9F8" ForeColor="#009EF7">
             ADD 
 </asp:LinkButton>                                              
                                             

                                    </div>
                                </div>


                                             </div>

                                            </div>

                                            <div class="col-lg-12 row" style="padding-top:10px;">
                                                
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                    <telerik:RadGrid RenderMode="Lightweight" runat="server" EnableLinqExpressions="false" AllowMultiRowSelection="false"
                                        ID="grvRpt" GridLines="None"
                                        ShowFooter="True" AllowSorting="True"
                                        
                                        AllowFilteringByColumn="true"
                                        ClientSettings-Resizing-ClipCellContentOnResize="true"
                                        EnableAjaxSkinRendering="true"
                                        AllowPaging="true" PageSize="200" CellSpacing="0" PagerStyle-AlwaysVisible="true">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="500px"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                            ShowFooter="false" DataKeyNames="ID"
                                            EnableHeaderContextMenu="true">
                                            <Columns>

                                                                                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" AllowFiltering="false" HeaderText="Delete" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="Delete" ID="Deletebtn" Visible="true" AlternateText="Delete" runat="server"
                                                        ImageUrl="../assets/media/svg/general/Trash.svg"></asp:ImageButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            
                                                <telerik:GridBoundColumn DataField="ID" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="ID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="ID" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Item" AllowFiltering="true" HeaderStyle-Width="100px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Item" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="prd_Code">
                                                </telerik:GridBoundColumn>





                                                <telerik:GridBoundColumn DataField="UOM" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="UOM" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="UOM">
                                                </telerik:GridBoundColumn>

                                                  <telerik:GridBoundColumn DataField="Qty" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="Qty" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="Qty">
                                                </telerik:GridBoundColumn>



                                                <telerik:GridBoundColumn DataField="uomID" AllowFiltering="true" HeaderStyle-Width="60px"
                                                    HeaderStyle-Font-Size="Smaller" HeaderText="uomID" FilterControlWidth="100%"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                    HeaderStyle-Font-Bold="true" UniqueName="uomID" Visible="false">
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

                                        <div class="col-lg-4">
                                            <div class="col-lg-12 row">
                                                  <div class="col-lg-12 form-group d-flex">
    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5"> Select Tools :  </span>
       

    </label>
    <div class="col-lg-6 pt-0 pl-3">
        <telerik:RadComboBox ID="ddlTool" runat="server" Width="100%" EmptyMessage="Select Tool" Filter="Contains"  RenderMode="Lightweight"></telerik:RadComboBox>
              
             

    </div>
</div>
                                                </div>
                                                                                        <div class="col-lg-12 row">
                                                  <div class="col-lg-12 form-group d-flex">
    <label class="control-label"><span class="min-w-60px fw-semibold text-gray-600 pt-5"> Instuctions :  </span>
       

    </label> 
                                                      </div>
                                                                                            <div class="col-lg-12 form-group d-flex">
    <div class="col-lg-12 pt-3 pl-0">
        <telerik:RadTextBox ID="txtRemarks"  Rows="4" TextMode="MultiLine" Skin="Silk" runat="server" Width="100%"   RenderMode="Lightweight" style="border-radius: 10px;"></telerik:RadTextBox>
              
             

    </div>
</div>
                                                </div>


                                       </div>

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


                    </div>
                </div>
            </div>
        </div>
    </div>
   
      <style>
        .control-label {
            display: flex;
            align-items: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
                                             <%--<div class="modal fade" id="kt_modal_1_7" style="height: auto;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:900px;">
                <div class="modal-header">
                    <h5 class="modal-title">Manage Job</h5>
                </div>
                                                <div class="modal-body">
                    <span></span>
                          <div class="col-lg-12 row" style="padding-top: 10px;">
                          <div class="col-lg-6 form-group">
                <label class="control-label col-lg-12" ><span class="min-w-50px fw-semibold text-gray-500 pt-5">Preferred Date & Time</span></label>
                <div class="col-lg-12">
                       <telerik:RadLabel ID="lblpreffered" Width="100%"   runat="server">
                 </telerik:RadLabel>
                
                    
                    </div>
                         </div>
                                                        <div class="col-lg-6 form-group">
                <label class="control-label col-lg-12" ><span class="min-w-50px fw-semibold text-gray-500 pt-5">Remarks</span></label>
                <div class="col-lg-12">
                       <telerik:RadTextBox ID="txtRemarks" Width="100%"  TextMode="MultiLine"  runat="server">
                 </telerik:RadTextBox>
                
                    
                    </div>
                         </div>

                              </div>
                                                     
                         <div class="col-lg-12 row">
                             <div class="col-lg-6">
                                  <div class="col-lg-12" style="padding-top: 10px;">
                        <span class="min-w-50px fw-semibold text-gray-500 pt-5">Duration</span></div>
                                                  <div class="col-lg-12 row" style="padding-top: 10px;">


                                                   <div class="col-lg-6 form-group">
                             <label class="control-label col-lg-12"> Hours</label>
                             <div class="col-lg-12">
                                 <telerik:RadNumericTextBox ID="rdDuration" NumberFormat-DecimalDigits="0" runat="server"  RenderMode="Lightweight"  ></telerik:RadNumericTextBox>
        
                             </div>
                         </div>

                                                                                <div class="col-lg-6 form-group">
                            <label class="control-label col-lg-12"> Minutes</label>
                            <div class="col-lg-12">
                                <telerik:RadNumericTextBox ID="rdMinutes" NumberFormat-DecimalDigits="0" runat="server"  RenderMode="Lightweight"  ></telerik:RadNumericTextBox>
        
                            </div>
                        </div>


                                                          </div>

                                                  
                                                         <div class="col-lg-12 row" style="padding-top: 10px;">
                                                             <asp:Label ID="lblerrmsg" runat="server" Text="Note : Duration should not be zero or blank. Please fill it properly " ForeColor="Blue">

                                                             </asp:Label>
                                                             </div>
         </div>
     
                                                 <div class="col-lg-6">
                                                     <div class="col-lg-12" style="padding-top: 10px;" >
<span class="min-w-50px fw-semibold text-gray-500 pt-5"> Schedule Time</span></div>
                    <div class="col-lg-12 row" style="padding-top: 10px;">
                                          <div class="col-lg-6 form-group">
                <label class="control-label col-lg-12" >Schedule To<span class="required"></span></label>
                <div class="col-lg-12">
                       <telerik:RadDatePicker  ID="SCHdate"   RenderMode="Lightweight" DateInput-DateFormat="dd-MMM-yyyy" runat="server">
                 </telerik:RadDatePicker>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"  ValidationGroup="frm" ErrorMessage="Date is mandatory" ForeColor="Red" ControlToValidate="SCHdate"></asp:RequiredFieldValidator>
                                                   <br />
                    
                    </div>
                         </div>
                       
                                                  <div class="col-lg-6 form-group">
<label class="control-label col-lg-12" >Start Time<span class="required"></span></label>
<div class="col-lg-12">
       <telerik:RadTimePicker  ID="rdTimePicker" DateInput-DateFormat="HH:mm" RenderMode="Lightweight"  runat="server">
 </telerik:RadTimePicker>
 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"  ValidationGroup="frm" ErrorMessage="Time is mandatory" ForeColor="Red" ControlToValidate="rdTimePicker"></asp:RequiredFieldValidator>
                                   <br />
    
    </div>
         </div>
                          
                        </div>
                                                    
</div>
     </div>

                                                    <div class="col-lg-12 row" style="padding-top:10px;">
                                                        <div class="col-lg-8 row" >
                                                                      <div class="col-lg-12" style="padding-top: 10px;padding-bottom:10px;">
<span class="min-w-50px fw-semibold text-gray-500 pt-5">Required Inventory</span></div>
                                                             <div class="col-lg-4 form-group">
                            <label class="control-label col-lg-12">Product </label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlProduct" runat="server" Width="100%" EmptyMessage="Select Product" Filter="Contains"  RenderMode="Lightweight"></telerik:RadComboBox>
       
                            </div>
                        </div>
                              

                        <div class="col-lg-4 form-group">
                            <label class="control-label col-lg-12"> UOM  </label>
                            <div class="col-lg-12">
                                <telerik:RadComboBox ID="ddlUom" runat="server"  EmptyMessage="Select Higher UOM" Width="100%" Filter="Contains"
                                    RenderMode="Lightweight" >
                                </telerik:RadComboBox>
                             </div>
                        </div>


                        <div class="col-lg-4 form-group">
                            <label class="control-label col-lg-12">Qty</label>
                            <div class="col-lg-12">
                                <telerik:RadNumericTextBox ID="txtQty" NumberFormat-DecimalDigits="0" runat="server" RenderMode="Lightweight" EmptyMessage="Type here" Width="100%" ></telerik:RadNumericTextBox>
                               
   
                            </div>
                        </div>


                                                        </div>
                                                        <div class="col-lg-4">
                                                          
                                                                      <div class="col-lg-12" style="padding-top: 10px;padding-bottom:10px;">
<span class="min-w-50px fw-semibold text-gray-500 pt-5">Required Tools</span></div>
                                                                                                 <div class="col-lg-12 form-group">
    <label class="control-label col-lg-12">Tools </label>
    <div class="col-lg-12">
        <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="100%" EmptyMessage="Select Tool" Filter="Contains"  RenderMode="Lightweight"></telerik:RadComboBox>
       
    </div>
</div>
                              

</div>
                                                        </div>
                        
                   <div class="col-lg-12 row" style="width:max-content" >
                           <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel4">

      
  <asp:LinkButton ID="btnViewReqst" runat="server" CssClass="btn btn-sm fw-bold btn-primary"  Visible="false" ValidationGroup="frm" CausesValidation="true" OnClick="btnViewReqst_Click">
                      View Jobs        
      </asp:LinkButton>
    </telerik:RadAjaxPanel>
<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
BackColor="Transparent"
ForeColor="Blue">
    <div class="col-lg-12 text-center mt-5">
        <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
    </div>
</telerik:RadAjaxLoadingPanel>

                   </div>               
                </div>

                <div class="modal-footer">
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        
                        <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-sm fw-bold btn-success" ValidationGroup="frm" CausesValidation="true" OnClick="lnkSubmit_Click">
                                                    Submit
                        </asp:LinkButton>
                    </telerik:RadAjaxPanel>
                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
                        BackColor="Transparent"
                        ForeColor="Blue">
                        <div class="col-lg-12 text-center mt-5">
                            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                        </div>
                    </telerik:RadAjaxLoadingPanel>
                    <br />
                    <button type="button" class="btn btn-sm fw-bold btn-secondary" onclick="cancelModal(kt_modal_1_7);">Cancel</button>
                </div>
            </div>
        </div>
    </div>--%>

</asp:Content>
