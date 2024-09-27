<%@ Page Title="" Language="C#" MasterPageFile="~/BO_Digits/ar/ar_master.Master" AutoEventWireup="true" CodeBehind="ViewAddEditRoute.aspx.cs" Inherits="SalesForceAutomation.BO_Digits.ar.ViewAddEditRoute" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Actions" runat="server">
  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <!--begin::Portlet-->
                <div class="kt-portlet" style="background-color: white; padding: 20px;">



                    <div class="kt-portlet__body">

                        <asp:Literal ID="ltrlMessage" runat="server"></asp:Literal>


                        <div class="col-lg-12 row"><b>معلومات أساسية </b></div>
                        <br />
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel3">
                            <div class="col-lg-12 row">

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">كود الطريق <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtcode" runat="server" CssClass="form-control" Width="100%"  AutoPostBack="true"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtcode" ErrorMessage="Please Enter  Code" ForeColor="Red" Display="Dynamic"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblCodeDupli" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">اسم الطريق <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtname" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtname" ErrorMessage="Please Enter   Name" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="col-lg-4 form-group">
                                    <label class="control-label col-lg-12">الاسم العربي <span class="required"></span></label>
                                    <div class="col-lg-12">
                                        <telerik:RadTextBox ID="txtArabicname" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                            ControlToValidate="txtArabicname" ErrorMessage="Please Enter Arabic Name" Display="Dynamic" ForeColor="Red"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                            </div>

                        </telerik:RadAjaxPanel>
                        <telerik:RadAjaxLoadingPanel runat="server" Skin="Sunset" ID="RadAjaxLoadingPanel3" EnableEmbeddedSkins="false"
                            BackColor="Transparent"
                            ForeColor="Blue">
                            <div class="col-lg-12 text-center mt-5">
                                <img alt="Loading..." src="../assets/media/bg/loader.gif" style="border: 0px;" />
                            </div>
                        </telerik:RadAjaxLoadingPanel>
                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">نوع الطريق <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlrotType" runat="server" Width="100%" DefaultMessage="Select Route Type" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="الحسابات المستحقة" Value="AR" />
                                            <telerik:DropDownListItem Text="تجارة" Value="MER" />
                                            <telerik:DropDownListItem Text="طبيعي" Value="NR" />
                                            <telerik:DropDownListItem Text="طلب" Value="OR" />
                                            <telerik:DropDownListItem Text="مبيعات" Value="SL" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">كلمة مرور الطريق <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadTextBox ID="txtpass" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtpass" ErrorMessage="<br/>Please Enter password" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">طرق إنتاجية <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlpromodes" runat="server" Width="100%" DefaultMessage="Select  Productive Modes" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="الحسابات المستحقة" Value="AR" />
                                            <telerik:DropDownListItem Text="تجارة" Value="MER" />
                                            <telerik:DropDownListItem Text="طلب" Value="OR" />
                                            <telerik:DropDownListItem Text="مبيعات" Value="SL" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">اسم المستخدم <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlname" runat="server" EmptyMessage="Select User Name" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlname" ErrorMessage="الرجاء تحديد اسم المستخدم" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">معرف الجهاز<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <%--<telerik:RadNumericTextBox ID="txtdevid" runat="server" CssClass="form-control" Width="90%"></telerik:RadNumericTextBox>--%>

                                    <telerik:RadTextBox ID="txtdeviceid" runat="server" CssClass="form-control" Width="100%" Enabled="false"></telerik:RadTextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="form"
                                        ControlToValidate="txtdeviceid" ErrorMessage="<br/>Please Enter Device Id" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />--%>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">منطقة المستودع الفرعية<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlDepot" runat="server" EmptyMessage="Select Depot SubArea" CausesValidation="false" Width="100%" Filter="Contains" Enabled="false"></telerik:RadComboBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlDepot" ErrorMessage="يرجى تحديد منطقة المستودع الفرعية" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-12 row" style="padding-top: 9px;">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">حالة <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlStats" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="نشيط" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="غير نشط" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>


                            </div>

                        </div>

                        <br />

                        <div class="col-lg-12 row"><b>إعدادات </b></div>
                        <br />

                        <div class="col-lg-12 row">

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">السماح بالتباين في التسوية<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlstlmnt" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group" hidden="hidden">
                                <label class="control-label col-lg-12">فرض خطة الرحلة <span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlenforcejp" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="لا" Value="N" Selected="true" />
                                            <telerik:DropDownListItem Text="نعم" Value="Y" />

                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تفعيل عداد المسافات<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlodometer" runat="server" Width="100%" Enabled="false">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">هو تفريغ<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlis" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select UnLoad">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">فحص روتيني<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlRC" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Routine Check">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">قم بتمكين تحميل التوقيع<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLIS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable LoadIn Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تفعيل توقيع نقل الحمولة<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLTS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable Load Transfer Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تفعيل تسجيل التحميل<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOS" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Enable LoadOut Sign">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">طلب تحميل<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLR" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Load Request">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">نقل الحمولة<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLT" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select Load Transfer">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تحرير التحميل<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLEdit" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadIn Edit">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تحميل تحرير<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOEdit" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadOut Edit">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تحميل السماح الزائد<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="ddlLOExcess" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="Select LoadOut Excess Allow">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-12 row" style="padding-top: 9px;">



                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">طريقة الدفع</label>
                                <div class="col-lg-12">
                                    <telerik:RadComboBox ID="ddlpaymode" runat="server" Width="100%" CheckBoxes="true" EnaeckAllItemsCheckBox="true" EmptyMessage="Select Payment Mode" Enabled="false">
                                        <Items>

                                            <telerik:RadComboBoxItem Text="الدفع الالكتروني" Value="OP" />
                                            <telerik:RadComboBoxItem Text="نقاط البيع" Value="POS" />
                                            <telerik:RadComboBoxItem Text="مال صعب" Value="HC" />

                                        </Items>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ValidationGroup="form"
                                        ControlToValidate="ddlpaymode" ErrorMessage="يرجى تحديد طريقة الدفع" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator><br />

                                </div>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تمكين طلب التحميل المقترح<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbsugloreq" runat="server" Width="100%" Enabled="false"
                                        EmptyMessage="الرجاء التحديد ">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" Selected="true" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">نوع الإرجاع<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbreturnType" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="الرجاء التحديد ">
                                        <Items>
                                            <telerik:DropDownListItem Text="طبيعي" Value="NR"  />
                                            <telerik:DropDownListItem Text="خاضع للسيطرة" Value="CR" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تمكين رفض التحميل<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbLodRej" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="الرجاء التحديد ">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y"  />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="control-label col-lg-12">تمكين فان للشاحنة<span class="required"></span></label>
                                <div class="col-lg-12">
                                    <telerik:RadDropDownList ID="rcbVantoVan" runat="server" Width="100%" Enabled="false"
                                        DefaultMessage="الرجاء التحديد ">
                                        <Items>
                                            <telerik:DropDownListItem Text="نعم" Value="Y" />
                                            <telerik:DropDownListItem Text="لا" Value="N" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

   
</asp:Content>