<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LastRouteCommunicationReport.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LastRouteCommunicationReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

		<div class="col-lg-12" style="background-color:white;">

					<div class="mb-4 ps-10" style="border-bottom-style:groove; border-bottom-width:1px;">					
					    <div class="card-header pt-10 ms-4 mb-6">
                            <h3 class="card-title text-gray-800">
                           Route &nbsp;   <asp:Label ID="lblrot" runat="server"></asp:Label>  
                            </h3>
                        </div>
					</div>	

			  <!--begin::Body-->
				<div class="card-body pt-6 p-20" style="height:500px; overflow:scroll;" >
													<!--begin::Timeline-->
													<div class="timeline-label mt-4">
														 <asp:Repeater runat="server" ID="rptRouteHistory">
                                                                 <ItemTemplate>
														<!--begin::Item-->
															<div class="timeline-item">
															<!--begin::Label-->
															<div class="timeline-label fw-bold text-gray-800 fs-6">
																<asp:Label ID="lbldate" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
																

															</div>
															<!--end::Label-->
															<!--begin::Badge-->
															<div class="timeline-badge">
																<i class="fa fa-genderless text-warning fs-1"></i>
															</div>
															<!--end::Badge-->
															<!--begin::Desc-->
															<div class="timeline-content fw-bold text-gray-800 ps-6">
																<asp:Label ID="lblprocess" runat="server" Text='<%# Eval("TransactionName") %>'></asp:Label>
																 <br />
																<div class="fw-semibold text-gray-700 fs-7">
																	<asp:Label ID="lblTransID" runat="server" Text='<%# Eval("TransactionID") %>'></asp:Label>
																	</div>
															
															<!--end::Desc-->
														</div>
														<!--end::Item-->
													</div>
														<!--end::Item-->
																	   </ItemTemplate>
                                                               </asp:Repeater>
														
													<!--end::Timeline-->
												</div>
			  <!--end: Card Body-->

		</div>
	</div>


	<style>
	 .timeline-label .timeline-label {
  width: 200px;
  flex-shrink: 0;
  position: relative;
  color: var(--kt-gray-800);
}
	 .timeline-label {
  position: relative;
}
.timeline-label:before {
  content: "";
  position: absolute;
  left: 200px;
  width: 3px;
  top: 0;
  bottom: 0;
  background-color: var(--kt-gray-200);
}
	</style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
