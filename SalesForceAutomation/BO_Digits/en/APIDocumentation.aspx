<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="APIDocumentation.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.APIDocumentation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class=" col-lg-12 docs-content d-flex flex-column flex-column-fluid" id="kt_docs_content">
						<!--begin::Container-->
						<div class="container d-flex flex-column flex-lg-row" id="kt_docs_content_container">
							
							<!--begin::Card-->
							<div class="card card-docs flex-row-fluid mb-2">
								<!--begin::Card Body-->
								<div class="card-body fs-6 py-15 px-10 py-lg-15 px-lg-15 text-gray-700">

								<asp:Repeater ID="apidoc" runat="server" OnItemDataBound="apidoc_ItemDataBound">
    <HeaderTemplate>
        <!-- Optional: Add any header content here -->
    </HeaderTemplate>
    <ItemTemplate>
        <!--begin::Section-->
        <div class="pb-10">
            <!--begin::Heading-->
            <h2 class="anchor fw-bold " id="add-rows" data-kt-scroll-offset="50">
                <%# Eval("apd_Heading") %> <!-- Dynamically bind heading -->
            </h2>
            <!--end::Heading-->
            <!--begin::Block-->
            <div class="py-5" id="subheaing">
                <%# Eval("apd_SubHeading") %> <!-- Dynamically bind subheading -->
            </div>
            <!--end::Block-->
            <!--begin::Block-->
            <!--end::Block-->
            <!--begin::Code-->
<%--            <h1 class="anchor fw-bold mb-5" data-kt-scroll-offset="50">Content</h1>--%>

            <div class="py-5">
                <!--begin::Highlight-->
                <div class="highlight" runat="server" id="highlightDiv">
                    <div class="tab-content">
                        <%# Eval("apd_Content") %> <!-- Dynamically bind content -->
                    </div>
                </div>
                <!--end::Highlight-->
            </div>
            <!--end::Code-->
        </div>
        <!--end::Section-->
    </ItemTemplate>
    <FooterTemplate>
        <!-- Optional: Add any footer content here -->
    </FooterTemplate>
</asp:Repeater>

									<!--end::Section-->
									<!--begin::Section-->
								
									<!--end::Section-->
								</div>
								<!--end::Card Body-->
							</div>
							<!--end::Card-->
							<!--begin::Sidebar wrapper-->
							
							<!--end::Sidebar wrapper-->
						</div>
						<!--end::Container-->
					</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
