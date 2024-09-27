<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/en/en_master.Master" AutoEventWireup="true" CodeBehind="LicenseManagement.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.en.LicenseManagement" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
         <div class="col-lg-12 row">
          
             <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
                 <div class="col-lg-12 row">
                     <div class="col-lg-12 row">
                         <!--begin::Charts Widget 3-->
                         <div class="card custom-small-card" style="background-color: white;">
                             <div class="col-xl-12 row" style="padding-top: 1rem; padding-left: 1rem;">
                                 <div class="col-xl-12 mb-4">
                                     <div class="col-lg-12 row">
                                         <!-- License Start Date Section -->
                                         <div class="d-flex align-items-center mb-3">
                                             <div class="col-lg-6">
                                                 <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">License Number:</span>
                                                 <asp:Label ID="lblLicNum" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                             </div>
                                             <div class="col-lg-6">
                                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">License Key:</span>
                                                <asp:Label ID="lblLicKey" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                            </div>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-xl-4" style="padding-bottom: 1rem;">
                                     <div class="col-lg-12">
                                         <!-- License Start Date Section -->
                                         <div class="d-flex align-items-center mb-3">
                                             <div class="col-lg-2">
                                                 <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                             </div>
                                             <div class="col-lg-10">
                                                 <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">License Start Date:</span>
                                                 <asp:Label ID="lblLicStDate" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                             </div>
                                         </div>
                                         <!-- Contact Person Section -->
                                         <div class="d-flex align-items-center">
                                             <div class="col-lg-2">
                                                 <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                             </div>
                                             <div class="col-lg-10">
                                                 <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">Contact Person:</span>
                                                 <asp:Label ID="lblConPer" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-xl-4" style="padding-bottom: 1rem;">
                                     <div class="col-lg-12">
                                         <!-- Expiry On Section -->
                                         <div class="d-flex align-items-center mb-3">
                                             <div class="col-lg-2">
                                                 <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                             </div>
                                             <div class="col-lg-10">
                                                 <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">Expiry On:</span>
                                                 <asp:Label ID="lblExpOn" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                             </div>
                                         </div>
                                         <!-- Contact Number Section -->
                                         <div class="d-flex align-items-center">
                                             <div class="col-lg-2">
                                                 <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                             </div>
                                             <div class="col-lg-10">
                                                 <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">Contact Number:</span>
                                                 <asp:Label ID="lblConNum" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-xl-4" style="padding-bottom: 1rem;">
                                    <div class="col-lg-12">
                                        <!-- Expiry On Section -->
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                            </div>
                                            <div class="col-lg-10">
                                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">License Type:</span>
                                                <asp:Label ID="lblType" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                            </div>
                                        </div>
                                        <!-- Contact Number Section -->
                                        <div class="d-flex align-items-center">
                                            <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/Rectangle 1212.png" height="20" />
                                            </div>
                                            <div class="col-lg-10">
                                                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">License Status:</span>
                                                <asp:Label ID="lblStatus" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                             </div>
                         </div>
                         <!--end::Charts Widget 3-->
                     </div>

                     <%--<div class="col-lg-4 row" style="padding-left:3rem;">
                         <!--begin::Charts Widget 3-->
                         <div class="card custom-small-card" style="background-color: white;">
                             <div class="col-lg-12 row" style="padding-top: 1rem; padding-left: 1rem;">
                                 <div class="col-lg-6" style="padding-bottom: 1rem;">
                                     <div class="col-lg-12">
                                         <div class="d-flex align-items-center mb-3">                                             
                                             <div class="col-lg-2">
                                                <img src="../assets/media/dashboard/Group 1940@2x.png" height="20" width="20">
                                             </div>
                                         </div>

                                     </div>
                                 </div>
                             </div>
                             <div class="col-xl-12 row" style="padding-top: 1rem; padding-left: 1rem;">
                                 <div class="col-lg-8" style="padding-bottom: 1rem;">
                                     <div class="d-flex justify-content-between align-items-center">
                                         <div class="col-lg-6" style="padding-bottom: 1rem;">
                                             <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: black;">App Users</span>
                                         </div>
                                         
                                     </div>
                                 </div>
                                  <div class="col-lg-4" style="padding-bottom: 1rem; text-align:end;" >
                                     <div class="d-flex align-content-end">                                        
                                          <div class="col-lg-6" style="padding-bottom: 1rem;">
                                             <asp:Label ID="lblAppUsr" runat="server" Style="font-family: 'Segoe UI'; font-size: medium; font-weight: bold;" Text="10"></asp:Label>
                                         </div>
                                     </div>
                                 </div>
                             </div>


                         </div>
                         <!--end::Charts Widget 3-->
                     </div>--%>

                 </div>
             </div>


             <div class="col-xl-6 pt-10">
    <!--begin::Mixed Widget 14-->
    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#F35D82, #CC4868); background-size: 100%;">
        <!--begin::Head-->
        <div class="card-header pt-2 d-flex justify-content-between align-items-center" style="border-bottom: 0px;">
            <!--begin::Title-->
            <h3 class="card-title align-items-start flex-column">
                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Consumed Active Routes from License</span>
            </h3>
            <!--end::Title-->
            <!--begin::Toolbar-->
            <div class="card-toolbar">
                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                    <span class="" style="font-size: 17px;">
                        <asp:Label ID="lblRoute" runat="server" Text="0"></asp:Label>
                    </span>
                </p>
            </div>
            <!--end::Toolbar-->
        </div>
        <!--end::Head-->
        <!--begin::Body-->
        <div class="card-body d-flex flex-column" style="padding-top: 20px;">
            <!--begin::Row-->
            <div class="row g-0">
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center me-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="lnkAssignedTask" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblRotLimit" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Route License Limit</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center ms-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="lnkCompletedTasks" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblRotBal" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Balance License Limits</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
            </div>
            <!--end::Row-->
        </div>
        <!--end::Body-->
    </div>
    <!--end::Mixed Widget 14-->
                 </div>
               <div class="col-xl-6 pt-10">
                  <!--begin::Mixed Widget 14-->
    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#47C581, #2DA566); background-size: 100%;">
        <!--begin::Head-->
        <div class="card-header pt-2 d-flex justify-content-between align-items-center" style="border-bottom: 0px;">
            <!--begin::Title-->
            <h3 class="card-title align-items-start flex-column">
                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Consumed Active Inventory App Users from License</span>
            </h3>
            <!--end::Title-->
            <!--begin::Toolbar-->
            <div class="card-toolbar">
                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                    <span class="" style="font-size: 17px;">
                        <asp:Label ID="lblInvAppUsr" runat="server" Text="0"></asp:Label>
                    </span>
                </p>
            </div>
            <!--end::Toolbar-->
        </div>
        <!--end::Head-->
        <!--begin::Body-->
        <div class="card-body d-flex flex-column" style="padding-top: 20px;">
            <!--begin::Row-->
            <div class="row g-0">
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center me-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton1" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblInvAppUsrLmt" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Users License Limit</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center ms-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton2" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblInvBal" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Balance License Limits</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
            </div>
            <!--end::Row-->
        </div>
        <!--end::Body-->
    </div>
    <!--end::Mixed Widget 14-->
                  <!--end::Mixed Widget 14-->
                   </div>
               <div class="col-xl-6">
                  <!--begin::Mixed Widget 14-->
    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#AB73C2, #814698); background-size: 100%;">
        <!--begin::Head-->
        <div class="card-header pt-2 d-flex justify-content-between align-items-center" style="border-bottom: 0px;">
            <!--begin::Title-->
            <h3 class="card-title align-items-start flex-column">
                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Consumed Active Backend Users from License</span>
            </h3>
            <!--end::Title-->
            <!--begin::Toolbar-->
            <div class="card-toolbar">
                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                    <span class="" style="font-size: 17px;">
                        <asp:Label ID="lblBOUsr" runat="server" Text="0"></asp:Label>
                    </span>
                </p>
            </div>
            <!--end::Toolbar-->
        </div>
        <!--end::Head-->
        <!--begin::Body-->
        <div class="card-body d-flex flex-column" style="padding-top: 20px;">
            <!--begin::Row-->
            <div class="row g-0">
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center me-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton3" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblBOUsrlmt" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Users License Limit</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center ms-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton4" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblBOBal" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Balance License Limits</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
            </div>
            <!--end::Row-->
        </div>
        <!--end::Body-->
    </div>
    <!--end::Mixed Widget 14-->
                  <!--end::Mixed Widget 14-->
                   </div>
               <div class="col-xl-6">
                  <!--begin::Mixed Widget 14-->
    <div class="card bgi-no-repeat card-xl-stretch mb-xl-8" style="background-image: url(../assets/media/dashboard/bg.png), linear-gradient(#BCBF52, #B5A11F); background-size: 100%;">
        <!--begin::Head-->
        <div class="card-header pt-2 d-flex justify-content-between align-items-center" style="border-bottom: 0px;">
            <!--begin::Title-->
            <h3 class="card-title align-items-start flex-column">
                <span class="text-grey-400 mt-1 fw-semibold fs-4" style="color: white;">Consumed Active Customer Connect Users from License</span>
            </h3>
            <!--end::Title-->
            <!--begin::Toolbar-->
            <div class="card-toolbar">
                <p class="" style="color: white; margin-bottom: 0.5rem !important; text-align: center;">
                    <span class="" style="font-size: 17px;">
                        <asp:Label ID="lblCC" runat="server" Text="0"></asp:Label>
                    </span>
                </p>
            </div>
            <!--end::Toolbar-->
        </div>
        <!--end::Head-->
        <!--begin::Body-->
        <div class="card-body d-flex flex-column" style="padding-top: 20px;">
            <!--begin::Row-->
            <div class="row g-0">
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center me-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton5" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblCCUsrlmt" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Users License Limit</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
                <!--begin::Col-->
                <div class="col-6">
                    <div class="d-flex align-items-center ms-2">
                        <!--begin::Symbol-->
                        <div class="symbol symbol-40px me-3">
                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-white" style="width: 6px;"></span>
                        </div>
                        <!--end::Symbol-->
                        <!--begin::Title-->
                        <div>
                            <asp:LinkButton ID="LinkButton6" runat="server">
                                <div class="fs-7 fw-bold" style="color: whitesmoke;">
                                    <span class="" style="font-size: 17px;">
                                        <asp:Label ID="lblCCBal" runat="server" Text="0"></asp:Label>
                                    </span>
                                </div>
                                <div class="fs-8 fw-bold" style="color: whitesmoke;">Balance License Limits</div>
                            </asp:LinkButton>
                        </div>
                        <!--end::Title-->
                    </div>
                </div>
                <!--end::Col-->
            </div>
            <!--end::Row-->
        </div>
        <!--end::Body-->
    </div>
    <!--end::Mixed Widget 14-->
                   </div>
</div>

    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footerScripts" runat="server">
</asp:Content>
