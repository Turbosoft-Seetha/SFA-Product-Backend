using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Telerik.Web.UI;
using Telerik.Web.UI.Chat;
using Telerik.Windows.Documents.Spreadsheet.Expressions.Functions;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class ReturnReqApprovalHeader : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				
				// rdfromDate.SelectedDate = DateTime.Now;
				// rdendDate.SelectedDate = DateTime.Now.AddDays(1);
				Customers();
				//Route();

				try
				{
                    if (Session["RRPStatus"] == null)
                    {
                        Session["RRPStatus"] = "";
                    }
					else
					{
						rdStatus.SelectedValue = Session["RRPStatus"].ToString();
					}
                    

                    if (Session["RRPFDate"] != null)
					{

						rdfromDate.SelectedDate = DateTime.Parse(Session["RRPFDate"].ToString());
					}
					else
					{
						rdfromDate.SelectedDate = DateTime.Now;
						// Session["FDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

					}
					rdfromDate.MaxDate = DateTime.Now;

					if (Session["RRPTDate"] != null)
					{

						rdendDate.SelectedDate = DateTime.Parse(Session["RRPTDate"].ToString());
					}
					else
					{
						rdendDate.SelectedDate = DateTime.Now.AddDays(1);
						// Session["TDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
					}
					rdendDate.MaxDate = DateTime.Now.AddDays(1);
				}
				catch (Exception ex)
				{
                    Response.Redirect("~/SignIn.aspx");
                }
				try
				{
					Customers();
                    if (Session["RRPcusID"] != null)
                    {
                        int a = rdCustomer.Items.Count;
                        string cusID = Session["RRPcusID"].ToString();
                        string[] ar = cusID.Split(',');
                        for (int i = 0; i < ar.Length; i++)
                        {
                            foreach (RadComboBoxItem items in rdCustomer.Items)
                            {


                                if (items.Value == ar[i])
                                {
                                    items.Checked = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        string cusID = Cus();
                        string cusCondition = " rrh_cus_ID in (" + cusID + ")";
                    }


                }
				catch
				{
                    Response.Redirect("~/SignIn.aspx");
                }
                try
                {
                    GetGridSession(grvRpt, "ReturnReqApproval");

                    grvRpt.Rebind();
                }

                catch (Exception ex)
                {
                    Response.Redirect("~/SignIn.aspx");
                }
                

            }
		}

		public void SetGridSession(RadGrid grd, string SessionPrefix)

		{

			try

			{

				foreach (GridColumn column in grd.MasterTableView.Columns)

				{

					if (column is GridBoundColumn boundColumn)

					{

						string columnName = boundColumn.UniqueName;

						string filterValue = column.CurrentFilterValue;

						Session[SessionPrefix + columnName] = filterValue;

					}

				}

			}

			catch (Exception ex)

			{

                Response.Redirect("~/SignIn.aspx");

            }



		}
		public void GetGridSession(RadGrid grd, string SessionPrefix)

		{

			try

			{

				string filterExpression = string.Empty;

				foreach (GridColumn column in grd.MasterTableView.Columns)

				{

					if (column is GridBoundColumn boundColumn)

					{

						string columnName = boundColumn.UniqueName;

						if (Session[SessionPrefix + columnName] != null)

						{

							string filterValue = Session[SessionPrefix + columnName].ToString();



							if (filterValue != "")
							{

								column.CurrentFilterValue = filterValue;



								if (!string.IsNullOrEmpty(filterExpression))

								{

									filterExpression += " AND ";

								}

								filterExpression += string.Format("{0} LIKE '%{1}%'", column.UniqueName, column.CurrentFilterValue);

							}

						}

					}

				}

				if (filterExpression != string.Empty)

				{

					grvRpt.MasterTableView.FilterExpression = filterExpression;

				}



			}

			catch (Exception ex)

			{

                Response.Redirect("~/SignIn.aspx");

            }

		}

		public void Customers()
		{
			//string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			//string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			//string[] arr = { fromDate.ToString(), toDate.ToString() };
			//string rotid = rot();

			rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomersForReturnRequest", "sp_ReturnRequest");
			rdCustomer.DataTextField = "cus_Name";
			rdCustomer.DataValueField = "cus_ID";
			rdCustomer.DataBind();
		}
		//public void Route()
		//{

		//	string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
		//	string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
		//	string[] arr = { toDate.ToString() };
		//	rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_ReturnRequest", fromDate.ToString(), arr);
		//	rdRoute.DataTextField = "rot_Name";
		//	rdRoute.DataValueField = "rot_ID";
		//	rdRoute.DataBind();
		//}





		public string Cus()
		{
			var CollectionMarket = rdCustomer.CheckedItems;
			string cusID = "";
			int j = 0;
			int MarCount = CollectionMarket.Count;
			if (CollectionMarket.Count > 0)
			{
				foreach (var item in CollectionMarket)
				{
					if (j == 0)
					{
						cusID += item.Value + ",";
					}
					else if (j > 0)
					{
						cusID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						cusID += item.Value;
					}
					j++;
				}
				return cusID;
			}
			else
			{
				return "rrh_cus_ID";
			}

		}
        //public string rot()
        //{
        //	var CollectionMarket = rdRoute.CheckedItems;
        //	string rotID = "";
        //	int j = 0;
        //	int MarCount = CollectionMarket.Count;
        //	if (CollectionMarket.Count > 0)
        //	{
        //		foreach (var item in CollectionMarket)
        //		{
        //			if (j == 0)
        //			{
        //				rotID += item.Value + ",";
        //			}
        //			else if (j > 0)
        //			{
        //				rotID += item.Value + ",";
        //			}
        //			if (j == (MarCount - 1))
        //			{
        //				rotID += item.Value;
        //			}
        //			j++;
        //		}
        //		return rotID;
        //	}
        //	else
        //	{
        //		return "rah_rot_ID";
        //	}

        //}


        public string mainConditions()
		{
			string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			//string rotid = rot();
			string customer = Cus();
            string status = Session["RRPStatus"].ToString();
            string statusCondition = "";

            string mainCondition = "";
			string customerCondition = "";
			//string rotCondition = "";


			string dateCondition = "";
			try
			{
                if (status.Equals(""))
                {
                    statusCondition = "and isnull(A.Status,'P') in ('P') ";
                }
                else
                {
                    statusCondition = " and isnull(A.Status,'P') in ('" + status + "')";
                }

                dateCondition = " and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";

				//if (rotid.Equals("0"))
				//{
				//	rotCondition = "";
				//}
				//else
				//{
				//	rotCondition = " and rah_rot_ID in (" + rotid + ")";
				//}

				if (customer.Equals("0"))
				{
					customerCondition = "";
				}
				else
				{
					customerCondition = " rrh_cus_ID in (" + customer + ")";
				}
				//if (OrdID.Equals("0"))
				//{
				//    OrderCondition = "";
				//}
				//else
				//{
				//    OrderCondition = " and ord_ID in (" + OrdID + ")";
				//}
			}
			catch (Exception ex)
			{

			}
			mainCondition += customerCondition;
			//mainCondition += rotCondition;
			mainCondition += dateCondition;
            mainCondition += statusCondition;

            // mainCondition += OrderCondition;
            return mainCondition;
		}

		public void LoadList()
		{
			string mainCondition = "";
			mainCondition = mainConditions();
			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("ListReturnReqApprovalHeader", "sp_ReturnRequest", mainCondition);
			grvRpt.DataSource = lstUser;
		}
		protected void grvRpt_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
		{
			LoadList();
		}
		protected void lnkFilter_Click(object sender, EventArgs e)
		{
			try
			{
                Session["RRPStatus"] = rdStatus.SelectedValue.ToString();

                if (Session["RRPFDate"] != null)
				{
					string fromdate = rdfromDate.SelectedDate.ToString();
					if (fromdate == Session["RRPFDate"].ToString())
					{
						rdfromDate.SelectedDate = DateTime.Parse(Session["RRPFDate"].ToString());
					}
					else
					{
						Session["RRPFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					}
				}
				else
				{
					rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					Session["RRPFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());

				}
				rdfromDate.MaxDate = DateTime.Now;

				if (Session["RRPTDate"] != null)
				{
					string todate = rdendDate.SelectedDate.ToString();
					if (todate == Session["RRPTDate"].ToString())
					{
						rdendDate.SelectedDate = DateTime.Parse(Session["RRPTDate"].ToString());
					}
					else
					{
						Session["RRPTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
					}

				}
				else
				{
					rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
					Session["RRPTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
				}
				rdendDate.MaxDate = DateTime.Now.AddDays(1);

                if (Session["RRPcusID"] != null)
                {
                    string customer = Cus();
                    if (customer == Session["RRPcusID"].ToString())
                    {
                        string cusID = Cus();

                    }
                    else
                    {
                        string cusID = Cus();
                        Session["RRPcusID"] = cusID;
                    }

                }
                else
                {
                    string cusID = Cus();
                    Session["RRPcusID"] = cusID;
                }


            }
			catch (Exception ex)
			{
                Response.Redirect("~/SignIn.aspx");
            }
			LoadList();
			grvRpt.Rebind();
		}




		protected void save_Click(object sender, EventArgs e)
		{
		}

		protected void btnOK_Click(object sender, EventArgs e)
		{
			Response.Redirect("ReturnReqApprovalHeader.aspx");
		}


		protected void LinkButton3_Click(object sender, EventArgs e)
		{
			Response.Redirect("ReturnReqApprovalHeader.aspx");
		}




		protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
		{
			try
			{
				RadGrid grd = (RadGrid)sender;

				SetGridSession(grd, "ReturnReqApproval");
			}
			catch (Exception ex)
			{
                Response.Redirect("~/SignIn.aspx");
            }

			if (e.CommandName.Equals("Detail"))
			{
				GridDataItem dataItem = e.Item as GridDataItem;
				string ID = dataItem.GetDataKeyValue("rrh_ID").ToString();

				Response.Redirect("ReturnReqApprovalDetail.aspx?HID=" + ID);



			}

		}

		protected void grvRpt_ItemDataBound(object sender, GridItemEventArgs e)
		{
           
        }

        protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime endDate = rdfromDate.SelectedDate.Value.AddDays(31);
                if (difference.Days > 31)
                {
                    rdendDate.MaxDate = DateTime.Today;
                    rdendDate.SelectedDate = endDate;
                }
                else
                {
                    rdendDate.MaxDate = DateTime.Today;
                }
            }
        }
        protected void rdendDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (rdfromDate.SelectedDate != null && rdendDate.SelectedDate != null)
            {
                TimeSpan difference = rdendDate.SelectedDate.Value - rdfromDate.SelectedDate.Value;
                DateTime startdate = rdendDate.SelectedDate.Value.AddDays(-31);
                if (difference.Days > 31)
                {
                    rdfromDate.SelectedDate = startdate;
                }
                else
                {
                    rdfromDate.MaxDate = DateTime.Today;
                }
            }
        }


        protected void Rdcushead_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			Customers();
		}

		protected void rdCustomer_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{

		}

	}
}