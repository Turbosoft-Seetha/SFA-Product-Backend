<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="UpdatePassword.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.UpdatePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
		<div class="row">
			<div class="col-lg-12">
				<!--begin::Portlet-->
				<div class="kt-portlet" style="background-color:white; padding:20px;">
					<div class="kt-portlet__head" style="padding-top: 20px; padding-bottom: 20px;">
						<div class="kt-portlet__head-label">
							<h3 class="kt-portlet__head-title">User Password Update
							</h3>
						</div>

					</div>
					<div class="kt-portlet__body">
						<asp:Label ID="ltrlMessage" runat="server"></asp:Label>
						<div class="col-lg-12 row">
							<div class="col-lg-6 form-group">
								<label class="control-label col-lg-12">User Name</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtEmail" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
										ControlToValidate="txtEmail" ErrorMessage="Please Enter UserName" ForeColor="Red"
										SetFocusOnError="True"></asp:RequiredFieldValidator>
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="control-label col-lg-12">First Name</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtFirstName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
										ControlToValidate="txtFirstName" ErrorMessage="Please Enter First Name" ForeColor="Red"
										SetFocusOnError="True"></asp:RequiredFieldValidator>
								</div>
							</div>
						</div>
						<div class="col-lg-12 row">
							<div class="col-lg-6 form-group">
								<label class="control-label col-lg-12">Last Name</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtLastName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="control-label col-lg-12">Contact No</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtContactInfo" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
								</div>
							</div>
						</div>
						<div class="col-lg-12 row">
							<div class="col-lg-4 form-group">
								<label class="control-label col-lg-12">Old Password</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtOldPassword" runat="server" MaxLength="100" CssClass="form-control" TextMode="Password"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
										ControlToValidate="txtOldPassword" ErrorMessage="Please Enter Old Password" ForeColor="Red"
										SetFocusOnError="True"></asp:RequiredFieldValidator>
								</div>
							</div>
							<div class="col-lg-4 form-group">
								<label class="control-label col-lg-12">New Password</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtNewPassword" runat="server" MaxLength="100" CssClass="form-control" TextMode="Password"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
										ControlToValidate="txtNewPassword" ErrorMessage="Please Enter New Password" ForeColor="Red"
										SetFocusOnError="True"></asp:RequiredFieldValidator>
									<small>Password Must contain lower, upper cases , special charecters and numbers and between 8-15</small>
									<%--<asp:CustomValidator ID="CustomValidator1" ClientValidationFunction="ClientValidate"
										ControlToValidate="txtNewPassword" runat="server" ErrorMessage="The password must be more than 6 characters."
										Display="Dynamic"></asp:CustomValidator>--%>
										 <asp:RegularExpressionValidator ID="reg1" runat="server" ControlToValidate="txtNewPassword"  
														 ValidationExpression="(?=^.{8,15}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{:;'?/>.<,])(?!.*\s).*$" 
														 ErrorMessage="Password Must contain lower, upper cases , special charecters and numbers and 8-15 letters" Display="Dynamic" ForeColor="Red"> 
													 </asp:RegularExpressionValidator>
								</div>

							</div>
							<div class="col-lg-4 form-group">
								<label class="control-label col-lg-12">Retype Password</label>
								<div class="col-lg-12">
									<asp:TextBox ID="txtRetypePassword" runat="server" MaxLength="100" CssClass="form-control" TextMode="Password"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic"
										ControlToValidate="txtRetypePassword" ErrorMessage="*" ForeColor="Red"
										SetFocusOnError="True"></asp:RequiredFieldValidator>
									<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNewPassword"
										ControlToValidate="txtRetypePassword" Display="Dynamic" ErrorMessage="Password don't match."
										ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
								</div>
							</div>
						</div>
						<div class="col-lg-12 form-actions">
							<div class="col-lg-12 row">
								<div class="col-md-9">
									<asp:LinkButton ID="btnSave" Width="100px" runat="server" OnClick="btnSave_Click" Text='Proceed' CssClass="btn btn-primary" />
									<asp:LinkButton ID="btnCancel" runat="server"
										OnClick="btnCancel_Click" Width="100px" Text="Cancel" CssClass="btn btn-secondary"
										CausesValidation="False" />

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div class="clearfix"></div>
	<a href="javascript:;" class="page-quick-sidebar-toggler">
		<i class="icon-login"></i>
	</a>
	<script type="text/javascript">

		function ClientValidate(source, clientside_arguments) {

			//Test whether the length of the value is more than 6 characters

			if (clientside_arguments.Value.length >= 6) {

				clientside_arguments.IsValid = true;

			}

			else { clientside_arguments.IsValid = false };

		}

    </script>

</asp:Content>
