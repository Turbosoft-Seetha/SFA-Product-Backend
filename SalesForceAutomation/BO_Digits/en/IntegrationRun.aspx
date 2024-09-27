<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="IntegrationRun.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.IntegrationRun" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

     <telerik:RadAjaxPanel ID="RadAjaxPanel6" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
        <asp:LinkButton ID="lnkapiDoc" runat="server" CssClass="btn btn-sm fw-bold btn-success" Text="API Documentation" OnClick="lnkapiDoc_Click"></asp:LinkButton>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel4" EnableEmbeddedSkins="false"
        BackColor="Transparent"
        ForeColor="Blue">
        <div class="col-lg-12 text-center mt-5">
            <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
        </div>
    </telerik:RadAjaxLoadingPanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.13/ace.js" integrity="sha512-OMjy8oWtPbx9rJmoprdaQdS2rRovgTetHjiBf7RL7LvRSouoMLks5aIcgqHb6vGEAduuPdBTDCoztxLR+nv45g==" crossorigin="anonymous"></script>


    <style>
        @keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }IntegrationRun

        .blinking-note {
            animation: blink 1s infinite;
            color: red; /* You can change the color as per your requirement */
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
    <asp:PlaceHolder ID="phScript" runat="server">
      <script>
          document.addEventListener("DOMContentLoaded", function () {
              // Initialize Ace Editor for request
              var txtPayload = ace.edit("txtPayload");
              txtPayload.setTheme("ace/theme/monokai");
              txtPayload.session.setMode("ace/mode/json");

              // Initialize Ace Editor for response
              var txtResponse = ace.edit("txtResponse");
              txtResponse.setTheme("ace/theme/monokai");
              txtResponse.session.setMode("ace/mode/json");

              // Function to update hidden fields
              function updateHiddenFields() {
                  document.getElementById('<%= hfRequestJSON.ClientID %>').value = txtPayload.getValue();
            document.getElementById('<%= hfResponseJSON.ClientID %>').value = txtResponse.getValue();
        }

        // Call updateHiddenFields when needed, e.g., on button click
        document.getElementById('<%= lnkRun.ClientID %>').addEventListener('click', updateHiddenFields);
        
        // Function to set the values of Ace editors from hidden fields
        function setAceEditorValues() {
            txtPayload.setValue(document.getElementById('<%= hfRequestJSON.ClientID %>').value, 1);
        }

        // Call setAceEditorValues on page load and after updates
        setAceEditorValues();

        // Function to update the response editor directly
        window.updateResponseEditor = function (responseJson) {
            txtResponse.setValue(responseJson, 1);
              }



          });


       
          // Add event listener for the copy button
          document.getElementById('btnCopyPayload').addEventListener('click', function () {
              copyToClipboard(txtPayload);
          });

      

      </script>



    </asp:PlaceHolder>


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lnkRun">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtResponse" />
                    <telerik:AjaxUpdatedControl ControlID="pnlLogTable" />
                    <telerik:AjaxUpdatedControl ControlID="pnlLogFile" />
                    <telerik:AjaxUpdatedControl ControlID="lblRequestTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblResponseTime" />




                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkButton1">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="pnlLogFile" />

                </UpdatedControls>
            </telerik:AjaxSetting>

               <telerik:AjaxSetting AjaxControlID="rptAPI_ItemCommand">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="grvRpt" />
                                        <telerik:AjaxUpdatedControl ControlID="RadGrid2" />


                </UpdatedControls>
            </telerik:AjaxSetting>

            <%--  <telerik:AjaxSetting AjaxControlID="btnApi">
    <UpdatedControls>
       
       <telerik:AjaxUpdatedControl ControlID="pnlLogFile" />

    </UpdatedControls>
</telerik:AjaxSetting>--%>
        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>

    <div class="col-lg-12 row">





        <div class="col-lg-3">

            <div class="card card-flush mb-5">


                <asp:Label ID="lblTotCount" runat="server" Text="" Style="font-size: small; margin-block-start: 10px; margin-left: 120px;"></asp:Label>






                <div class="card-body pt-3">


                    <div class="table-responsive pb-10" style="height: 706px;">

                        <!--begin::Table-->
                        <table id="sa" class=" table-row-dashed align-middle fs-6 gy-4 my-0 pb-3">

                            <tbody>

                                <asp:Repeater runat="server" ID="rptAPI" OnItemCommand="rptAPI_ItemCommand">
                                    <ItemTemplate>


                                        <asp:LinkButton ID="btnApi" runat="server" CommandName="ApiClick" CommandArgument='<%# Eval("iws_ID")%>'>
                                            <asp:Panel runat="server" ID="rowpanel" Style="padding: 5px">

                                                <div class="position-relative ps-0 pe-3 py-2">
                                                    <span class="mb-1 text-dark  fw-bold">
                                                        <asp:Label ID="lblApiName" Text='<%# Eval("iws_Name")%>' runat="server"></asp:Label></span>
                                                    <span class="badge badge-light-primary" style="float: right;">
                                                        <asp:Label ID="Label1" Text='<%# Eval("Mode")%>' runat="server"></asp:Label></span><br />

                                                </div>

                                            </asp:Panel>
                                        </asp:LinkButton>


                                    </ItemTemplate>
                                </asp:Repeater>



                            </tbody>
                        </table>

                    </div>



                </div>


            </div>

        </div>

        <div class="col-lg-9 ">
            <asp:PlaceHolder ID="plhFilter" runat="server" Visible="false">

                <div class="blinking-note">Route Mapping is needed</div>
            </asp:PlaceHolder>

            <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" LoadingPanelID="RadAjaxLoadingPanel5">


                <div class="col-lg-12 row pt-5" style="background-color: white; height: 280px;">


                    <div class="col-lg-6 ">

                        <div class="card-body" style="background-color: #F8F7F5; padding: 20px; height: 250px;">

                            <div class="col-lg-12 row" style="padding-top: 5px; padding-bottom: 5px;">
                                <div class="col-lg-10">
                                    <h3 class="kt-portlet__head-title" style="font-size: 15px;">Request
                                    </h3>

                                    <%-- <button class="btn btn-outline-secondary" type="button" id="btnCopyPayload">
                        <i class="bi bi-clipboard" style="color: gray;"></i>
                    </button>--%>
                                </div>

                                
                                <div class="col-lg-2" style="text-align-last: end;">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" LoadingPanelID="RadAjaxLoadingPanel6">

                                        

                                        <asp:LinkButton ID="lnkRun" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Run" OnClick="lnkRun_Click"></asp:LinkButton>

                                       
                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel6" EnableEmbeddedSkins="false"
                                        BackColor="Transparent"
                                        ForeColor="Blue">
                                        <div class="col-lg-12 text-center">
                                            <img alt="Loading..." src="../assets/media/icons/loader.gif" style="border: 0px;" />
                                        </div>
                                    </telerik:RadAjaxLoadingPanel>
                                </div>
                            </div>

                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <%--     <telerik:RadTextBox ID="txtPayload" Rows="8" TextMode="MultiLine" Skin="Silk" runat="server" Width="100%" RenderMode="Lightweight" Style="border-radius: 10px;"></telerik:RadTextBox>--%>
                                    <div id="txtPayload" style="height: 200px; width: 100%; border-radius: 10px;"></div>


                                    <asp:HiddenField ID="hfRequestJSON" runat="server" />

                                </div>
                                <asp:Label ID="lblRequestTime" runat="server" Text="" Style="font-size: small; margin-top: 5px; color: gray;"></asp:Label>


                            </div>



                        </div>
                    </div>
                    <div class="col-lg-6 ">

                        <div class="card-body" style="background-color: #F8F7F5; padding: 20px; height: 250px;">

                            <div class="col-lg-12 row" style="padding-top: 5px; padding-bottom: 18px;">
                                <div class="col-lg-10">
                                    <h3 class="kt-portlet__head-title" style="font-size: 15px;">Response
                                    </h3>
                                </div>
                            </div>

                            <div class="kt-form kt-form--label-right">
                                <div class="kt-portlet__body">
                                    <%--     <telerik:RadTextBox ID="txtResponse" Rows="8" TextMode="MultiLine" Skin="Silk" runat="server" Width="100%" RenderMode="Lightweight" Style="border-radius: 10px;"></telerik:RadTextBox>--%>


                                    <div id="txtResponse" style="height: 200px; width: 100%; border-radius: 10px;"></div>
                                    <asp:HiddenField ID="hfResponseJSON" runat="server" />
                                    <asp:Label ID="lblResponseTime" runat="server" Text="" Style="font-size: small; color: gray;"></asp:Label>


                                </div>
                            </div>



                        </div>
                    </div>
                </div>

                <asp:PlaceHolder runat="server" ID="pnlLogTable" Visible="true">
                    <div class="col-lg-12 row pt-3">


                        <div class="card-body mt-5" style="background-color: white; padding: 20px;">
                            <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                                <div class="row">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>
                                        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Material" />
                                        <telerik:RadGrid
                                            ID="grvRpt"
                                            runat="server"
                                            AllorptCusVisitwPaging="true"
                                            AllowFilteringByColumn="false"
                                            AllowMultiRowSelection="false"
                                            AllowSorting="True"
                                            CellSpacing="0"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            EnableLinqExpressions="false"
                                            GridLines="None"
                                            OnItemCommand="grvRpt_ItemCommand"
                                            OnNeedDataSource="grvRpt_NeedDataSource"
                                            OnItemDataBound="grvRpt_ItemDataBound"
                                            PageSize="50"
                                            RenderMode="Lightweight"
                                            ShowFooter="True">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="320px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="iwsl_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>



                                                    <%-- <telerik:GridBoundColumn DataField="iws_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="iws_Name">
                                </telerik:GridBoundColumn>--%>
                                                    <telerik:GridBoundColumn DataField="CreatedDate" AllowFiltering="true" HeaderStyle-Width="100px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="CreatedDate" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="CreatedDate">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="RequestToERP" AllowFiltering="true" HeaderStyle-Width="300px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Request To ERP" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RequestToERP">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn UniqueName="ResponseFromERP" AllowFiltering="false" HeaderStyle-Width="300px"
                                                        HeaderText="Response From ERP" FilterControlWidth="100%" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <telerik:RadTextBox ID="txtResponseFromERP" Rows="4" TextMode="MultiLine" Skin="Silk" runat="server" Width="100%" RenderMode="Lightweight"
                                                                Style="border-radius: 10px;">
                                                            </telerik:RadTextBox>

                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="ResponseFromDigits" AllowFiltering="true" HeaderStyle-Width="300px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Response From Digits" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="ResponseFromDigits">
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
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Show LogFile" Style="margin-top: 10px;" OnClick="LinkButton1_Click"></asp:LinkButton>

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
                </asp:PlaceHolder>



                 <asp:PlaceHolder runat="server" ID="PlaceHolder1" Visible="false">
                    <div class="col-lg-12 row pt-3">


                        <div class="card-body mt-5" style="background-color: white; padding: 20px;">
                            <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                                <div class="row">
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">

                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                        <telerik:RadGrid
                                            ID="RadGrid2"
                                            runat="server"
                                            AllorptCusVisitwPaging="true"
                                            AllowFilteringByColumn="false"
                                            AllowMultiRowSelection="false"
                                            AllowSorting="True"
                                            CellSpacing="0"
                                            ClientSettings-Resizing-ClipCellContentOnResize="true"
                                            EnableAjaxSkinRendering="true"
                                            EnableLinqExpressions="false"
                                            GridLines="None"
                                            OnNeedDataSource="RadGrid2_NeedDataSource"
                                            OnItemDataBound="RadGrid2_ItemDataBound"
                                            PageSize="50"
                                            RenderMode="Lightweight"
                                            ShowFooter="True">
                                            <ClientSettings>
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="320px"></Scrolling>
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                                ShowFooter="false" DataKeyNames="iwsl_ID"
                                                EnableHeaderContextMenu="true">
                                                <Columns>



                                                    <%-- <telerik:GridBoundColumn DataField="iws_Name" AllowFiltering="true" HeaderStyle-Width="100px"
                                    HeaderStyle-Font-Size="Smaller" HeaderText="Name" FilterControlWidth="100%"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                    HeaderStyle-Font-Bold="true" UniqueName="iws_Name">
                                </telerik:GridBoundColumn>--%>
                                                   
                                                    <telerik:GridBoundColumn DataField="RequestToDigits" AllowFiltering="true" HeaderStyle-Width="300px"
                                                        HeaderStyle-Font-Size="Smaller" HeaderText="Request To Digits" FilterControlWidth="100%"
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                        HeaderStyle-Font-Bold="true" UniqueName="RequestToDigits">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn UniqueName="ResponseFromDigits" AllowFiltering="false" HeaderStyle-Width="300px"
                                                        HeaderText="Response From Digits" FilterControlWidth="100%" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <telerik:RadTextBox ID="TxtResponseFromDigits" Rows="4" TextMode="MultiLine" Skin="Silk" runat="server" Width="100%" RenderMode="Lightweight"
                                                                Style="border-radius: 10px;">
                                                            </telerik:RadTextBox>

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
                                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-sm fw-bold btn-primary" Text="Show LogFile" Style="margin-top: 10px;" OnClick="LinkButton1_Click"></asp:LinkButton>

                                    </telerik:RadAjaxPanel>
                                    <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
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
                </asp:PlaceHolder>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel5" EnableEmbeddedSkins="false"
                BackColor="Transparent"
                ForeColor="Blue">
                <div class="col-lg-12 text-center mt-5">
                    <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                </div>
            </telerik:RadAjaxLoadingPanel>
        </div>


    </div>
    <asp:PlaceHolder ID="pnlLogFile" runat="server" Visible="false">

        <div class="col-lg-12 row" style="padding-right: 10px;">
            <div class="col-lg-12">
                <div class="card-body" style="background-color: white; padding: 20px;">
                    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                        <div class="row">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

                                <telerik:RadGrid
                                    ID="RadGrid1"
                                    runat="server"
                                    AllorptCusVisitwPaging="true"
                                    AllowFilteringByColumn="false"
                                    AllowMultiRowSelection="false"
                                    AllowSorting="True"
                                    CellSpacing="0"
                                    ClientSettings-Resizing-ClipCellContentOnResize="true"
                                    EnableAjaxSkinRendering="true"
                                    EnableLinqExpressions="false"
                                    GridLines="None"
                                    PageSize="50"
                                    OnItemCommand="RadGrid1_ItemCommand"
                                    RenderMode="Lightweight"
                                    ShowFooter="True">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ScrollHeight="340px"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="False" FilterItemStyle-Font-Size="XX-Small" CanRetrieveAllData="false"
                                        ShowFooter="false"
                                        EnableHeaderContextMenu="true">
                                        <Columns>




                                            <telerik:GridBoundColumn DataField="FileName" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="File Name" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="FileName">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="CreationTime" AllowFiltering="true" HeaderStyle-Width="100px"
                                                HeaderStyle-Font-Size="Smaller" HeaderText="CreationTime" FilterControlWidth="100%"
                                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                HeaderStyle-Font-Bold="true" UniqueName="CreationTime">
                                            </telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn DataField="LastModifiedTime" AllowFiltering="true" HeaderStyle-Width="100px"
                                                 HeaderStyle-Font-Size="Smaller" HeaderText="Last ModifiedTime" FilterControlWidth="100%"
                                                 CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false"
                                                 HeaderStyle-Font-Bold="true" UniqueName="LastModifiedTime">
                                             </telerik:GridBoundColumn>
                                            

                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" AllowFiltering="false" HeaderText="LogFile" HeaderStyle-Font-Size="Smaller" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:ImageButton CommandName="LogFile" ID="RadImageButton3" Visible="true" Height="25" Width="25" ToolTip="LogFile" AlternateText="LogFile" runat="server"
                                                        ImageUrl="../assets/media/svg/files/File.svg"></asp:ImageButton>
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
                            <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false"
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
    </asp:PlaceHolder>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>



