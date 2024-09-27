<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivateAccount.aspx.cs" Inherits="SalesForceAutomation.ActivateAccount" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html lang="en">

	<!-- begin::Head -->
	<head>

		<!--begin::Base Path (base relative path for assets of this page) -->
		<base href="../../../../">

		<!--end::Base Path -->
		<meta charset="utf-8" />
		<title>DigiTS | Activate Account </title>
		<meta name="description" content="Activate Account - IssueTracker"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<!--begin::Fonts -->
		<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
		<script>
			WebFont.load({
				google: {
					"families": ["Poppins:300,400,500,600,700", "Roboto:300,400,500,600,700"]
				},
				active: function() {
					sessionStorage.fonts = true;
				}
			});
		</script>

		<!--end::Fonts -->

		<!--begin::Page Custom Styles(used by this page) -->
		<link href="assets/css/demo1/pages/login/login-2.css" rel="stylesheet" type="text/css" />

		<!--end::Page Custom Styles -->

		<!--begin:: Global Mandatory Vendors -->
		<link href="assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<link href="assets/vendors/general/tether/dist/css/tether.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-datetime-picker/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-timepicker/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-switch/dist/css/bootstrap3/bootstrap-switch.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/select2/dist/css/select2.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/ion-rangeslider/css/ion.rangeSlider.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/nouislider/distribute/nouislider.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/dropzone/dist/dropzone.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/summernote/dist/summernote.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/bootstrap-markdown/css/bootstrap-markdown.min.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/animate.css/animate.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/toastr/build/toastr.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/morris.js/morris.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="assets/vendors/general/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Styles(used by all pages) -->
		<link href="assets/css/demo1/style.bundle.css" rel="stylesheet" type="text/css" />

		<!--end::Global Theme Styles -->

		<!--begin::Layout Skins(used by all pages) -->
		<link href="assets/css/demo1/skins/header/base/light.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/demo1/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/demo1/skins/brand/dark.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/demo1/skins/aside/dark.css" rel="stylesheet" type="text/css" />

		<!--end::Layout Skins -->
		<link rel="shortcut icon" href="assets/images/favicon.png" />

		<script>
            function Confirm() {
                if (Page_ClientValidate("claim")) {

                    return;
                }

            }
          
            function SuccessModal(res) {

                $('#spnMsgs').text(res);
                $('#kt_modal_1_8').modal('show');
            }
            function ErrorModal(res) {

                $('#spnMsgsx').text(res);
                $('#kt_modal_1_9').modal('show');
            }
		</script>

	</head>

	<!-- end::Head -->

	<!-- begin::Body -->
	<body class="kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--enabled kt-subheader--fixed kt-subheader--solid kt-aside--enabled kt-aside--fixed kt-page--loading">
        <form runat="server" id="frmLogin">
            <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
		<!-- begin:: Page -->
		<div class="kt-grid kt-grid--ver kt-grid--root" style="height: 100vh">
			<div class="kt-grid kt-grid--hor kt-grid--root kt-login kt-login--v2 kt-login--signin" id="kt_login">
				<div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" style="background-image: url(assets/media//bg/bg-1.jpg);">
					<div class="kt-grid__item kt-grid__item--fluid kt-login__wrapper">
						<div class="kt-login__container">
							<div class="kt-login__logo">
								<a href="#">
									<img src="assets/images/logo_100.png" style="max-width: 85%;">
								</a>
							</div>

                                    
							            <div class="kt-login__account">
								            <div class="kt-form">
												
                                                <div style="color: red;"><asp:Literal ID="FailureText" runat="server"></asp:Literal></div>
									            <div class="input-group">
                                                    <asp:TextBox ID="oldPassword"  runat="server" CssClass="form-control" placeholder="Enter Old Password" TextMode="Password"></asp:TextBox>
													</div>
												 <div class="input-group">
													 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="claim"
                                        ControlToValidate="oldPassword" ErrorMessage="<br/>Please Enter Old Password" ForeColor="Red"></asp:RequiredFieldValidator>
													 </div>
												<div class="input-group">
                                                    <asp:TextBox ID="newPass"  runat="server" CssClass="form-control" placeholder="Enter New Password" TextMode="Password"></asp:TextBox>
													
													</div>
												 <div class="input-group">
													 <small>Password Must contain lower, upper cases , special charecters and numbers and between 8-15</small>
													  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="claim"
                                        ControlToValidate="newPass" ErrorMessage="<br/>Please Enter New Password" ForeColor="Red"></asp:RequiredFieldValidator>
													 <asp:RegularExpressionValidator ID="reg1" runat="server" ControlToValidate="newPass" 
														 ValidationExpression="(?=^.{8,15}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{:;'?/>.<,])(?!.*\s).*$" 
														 ErrorMessage="Password Must contain lower, upper cases , special charecters and numbers and between 8-15" Font-Size="Smaller" Display="Dynamic" ForeColor="Red"> 
													 </asp:RegularExpressionValidator>
									            </div>
									            <div class="input-group">
                                                    <asp:TextBox ID="ConPass" runat="server" placeholder="Confirm New Password" CssClass="form-control" TextMode="Password"></asp:TextBox>
													</div>
												 <div class="input-group">
													  <asp:RequiredFieldValidator ID="requiredfieldvalidator1as" runat="server" Display="dynamic" ValidationGroup="claim"
                                        ControlToValidate="ConPass" ErrorMessage="<br/>please enter confirm password" ForeColor="red"
                                        SetFocusOnError="true"></asp:RequiredFieldValidator>
													 <asp:CompareValidator ID="clp" runat="server" ValidationGroup="claim" ErrorMessage="Password Mismatch" ControlToCompare="newPass" 
														 ControlToValidate="ConPass"
														 Display="Dynamic" ForeColor="Red" Operator="Equal"></asp:CompareValidator>
									            </div>
												<telerik:RadAjaxPanel ID="pnl" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
									            <div class="kt-login__actions">
                                                    <asp:LinkButton ID="LoginButton" runat="server" CommandName="Login" OnClick="LoginButton_Click" OnClientClick="Confirm()" CssClass="btn btn-pill kt-login__btn-primary" Text="Sign In" />
									            </div>
													</telerik:RadAjaxPanel>
													<telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel1" EnableEmbeddedSkins="false" BackColor="Transparent" ForeColor="Blue">
                                                <div class="col-lg-12 text-center mt-5">
                                                    <img alt="Loading..." src="/Media/loader.gif" style="border: 0px;" />
                                                </div>  
                                            </telerik:RadAjaxLoadingPanel>
								            </div>
							            </div>
							            
                               
							     
						</div>
					</div>
				</div>
			</div>
		</div>

        <div class="modal fade" id="kt_modal_1_8" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"> <span id="spnMsgs"></span> </h5>
                    </div>
                                        
                    <div class="modal-footer">
                        <asp:LinkButton ID="lnkbtnSucc" runat="server" OnClick="lnkbtnSucc_Click" class="btn btn-secondary" > OK</asp:LinkButton>
                    </div>
                </div>
            </div>
         </div>

			
        <div class="modal fade" id="kt_modal_1_9" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"> <span id="spnMsgsx"></span> </h5>
                    </div>
                                        
                    <div class="modal-footer">
						<button class="btn btn-secondary" data-modal="dismiss" >Try Again after some time</button>
                        
                    </div>
                </div>
            </div>
         </div>


		<!-- end:: Page -->
        </form>
		<!-- begin::Global Config(global config for global JS sciprts) -->
		<script>
			var KTAppOptions = {
				"colors": {
					"state": {
						"brand": "#5d78ff",
						"dark": "#282a3c",
						"light": "#ffffff",
						"primary": "#5867dd",
						"success": "#34bfa3",
						"info": "#36a3f7",
						"warning": "#ffb822",
						"danger": "#fd3995"
					},
					"base": {
						"label": ["#c5cbe3", "#a1a8c3", "#3d4465", "#3e4466"],
						"shape": ["#f0f3ff", "#d9dffa", "#afb4d4", "#646c9a"]
					}
				}
			};
		</script>

		<!-- end::Global Config -->

		<!--begin:: Global Mandatory Vendors -->
		<script src="assets/vendors/general/jquery/dist/jquery.js" type="text/javascript"></script>
		<script src="assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
		<script src="assets/vendors/general/moment/min/moment.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
		<script src="assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/wnumb/wNumb.js" type="text/javascript"></script>

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<script src="assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/block-ui/jquery.blockUI.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/bootstrap-datepicker.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-datetime-picker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/bootstrap-timepicker.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-maxlength/src/bootstrap-maxlength.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/vendors/bootstrap-multiselectsplitter/bootstrap-multiselectsplitter.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-switch/dist/js/bootstrap-switch.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/bootstrap-switch.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/select2/dist/js/select2.full.js" type="text/javascript"></script>
		<script src="assets/vendors/general/ion-rangeslider/js/ion.rangeSlider.js" type="text/javascript"></script>
		<script src="assets/vendors/general/typeahead.js/dist/typeahead.bundle.js" type="text/javascript"></script>
		<script src="assets/vendors/general/handlebars/dist/handlebars.js" type="text/javascript"></script>
		<script src="assets/vendors/general/inputmask/dist/jquery.inputmask.bundle.js" type="text/javascript"></script>
		<script src="assets/vendors/general/inputmask/dist/inputmask/inputmask.date.extensions.js" type="text/javascript"></script>
		<script src="assets/vendors/general/inputmask/dist/inputmask/inputmask.numeric.extensions.js" type="text/javascript"></script>
		<script src="assets/vendors/general/nouislider/distribute/nouislider.js" type="text/javascript"></script>
		<script src="assets/vendors/general/owl.carousel/dist/owl.carousel.js" type="text/javascript"></script>
		<script src="assets/vendors/general/autosize/dist/autosize.js" type="text/javascript"></script>
		<script src="assets/vendors/general/clipboard/dist/clipboard.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
		<script src="assets/vendors/general/summernote/dist/summernote.js" type="text/javascript"></script>
		<script src="assets/vendors/general/markdown/lib/markdown.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-markdown/js/bootstrap-markdown.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/bootstrap-markdown.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/bootstrap-notify/bootstrap-notify.min.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/bootstrap-notify.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
		<script src="assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/jquery-validation.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/toastr/build/toastr.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/raphael/raphael.js" type="text/javascript"></script>
		<script src="assets/vendors/general/morris.js/morris.js" type="text/javascript"></script>
		<script src="assets/vendors/general/chart.js/dist/Chart.bundle.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/vendors/bootstrap-session-timeout/dist/bootstrap-session-timeout.min.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/vendors/jquery-idletimer/idle-timer.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/waypoints/lib/jquery.waypoints.js" type="text/javascript"></script>
		<script src="assets/vendors/general/counterup/jquery.counterup.js" type="text/javascript"></script>
		<script src="assets/vendors/general/es6-promise-polyfill/promise.min.js" type="text/javascript"></script>
		<script src="assets/vendors/general/sweetalert2/dist/sweetalert2.min.js" type="text/javascript"></script>
		<script src="assets/vendors/custom/js/vendors/sweetalert2.init.js" type="text/javascript"></script>
		<script src="assets/vendors/general/jquery.repeater/src/lib.js" type="text/javascript"></script>
		<script src="assets/vendors/general/jquery.repeater/src/jquery.input.js" type="text/javascript"></script>
		<script src="assets/vendors/general/jquery.repeater/src/repeater.js" type="text/javascript"></script>
		<script src="assets/vendors/general/dompurify/dist/purify.js" type="text/javascript"></script>

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Bundle(used by all pages) -->
		<script src="assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>

		<!--end::Global Theme Bundle -->

		<!--begin::Page Scripts(used by this page) -->
		<script src="assets/js/demo1/pages/login/login-general.js" type="text/javascript"></script>

		<!--end::Page Scripts -->
	</body>

	<!-- end::Body -->
</html>
