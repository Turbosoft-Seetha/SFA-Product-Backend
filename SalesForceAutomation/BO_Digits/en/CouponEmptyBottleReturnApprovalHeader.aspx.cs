using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SalesForceAutomation.BO_Digits.ar;
using Telerik.Web.UI;

namespace SalesForceAutomation.BO_Digits.en
{
	public partial class CouponEmptyBottleReturnApprovalHeader : System.Web.UI.Page
	{
		GeneralFunctions ObjclsFrms = new GeneralFunctions();
	
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				try
				{
					if (Session["CpnBtlStatus"] == null)
					{
						Session["CpnBtlStatus"] = "";
					}
					else
					{
						rdStatus.SelectedValue = Session["CpnBtlStatus"].ToString();
					}

					if (Session["CpnBtlFDate"] != null)
					{
						rdfromDate.SelectedDate = DateTime.Parse(Session["CpnBtlFDate"].ToString());
					}
					else
					{
						rdfromDate.SelectedDate = DateTime.Now;
					}
					rdfromDate.MaxDate = DateTime.Now;

					if (Session["CpnBtlTDate"] != null)
					{
						rdendDate.SelectedDate = DateTime.Parse(Session["CpnBtlTDate"].ToString());
					}
					else
					{
						rdendDate.SelectedDate = DateTime.Now.AddDays(1);
					}
					rdendDate.MaxDate = DateTime.Now.AddDays(1);
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}
				try
				{
					Route();
					if (Session["CpnBtlrotid"] != null)
					{
						string routeID = Session["CpnBtlrotid"].ToString();
						string[] ar = routeID.Split(',');
						for (int i = 0; i < ar.Length; i++)
						{
							foreach (RadComboBoxItem items in rdRoute.Items)
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
						string rotid = curot();
						string routecondition = " cra_rot_ID  in (" + rotid + ")";
					}
					Customers();
					if (Session["CpnBtlcusID"] != null)
					{
						int a = rdCustomer.Items.Count;
						string cusID = Session["CpnBtlcusID"].ToString();
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
						string cusID = Cu_Cus();
						string cusCondition = "A.cus_ID in (" + cusID + ")";
					}
				}
				catch
				{
					Response.Redirect("~/SignIn.aspx");
				}
				try
				{
					GetGridSession(grvRpt, "CouponEmptyBottleReturnApprovalHeader");
					grvRpt.Rebind();
				}
				catch (Exception ex)
				{
					Response.Redirect("~/SignIn.aspx");
				}
			}
		}
		protected void rdStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
		{
			// Update the session value when selection changes
			Session["CpnBtlStatus"] = rdStatus.SelectedValue;

			// Rebind or refresh data if necessary
			grvRpt.Rebind();
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

			string rotid = curot();
			string routeCondition = " cra_rot_ID in (" + rotid + ")";
			rdCustomer.DataSource = ObjclsFrms.loadList("SelCustomers", "sp_CouponCollection", routeCondition.ToString());
			rdCustomer.DataTextField = "cus_Name";
			rdCustomer.DataValueField = "cus_ID";
			rdCustomer.DataBind();
		}
		public void Route()
		{

			string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string[] arr = { toDate.ToString() };
			rdRoute.DataSource = ObjclsFrms.loadList("SelRoute", "sp_CouponCollection", fromDate.ToString(), arr);
			rdRoute.DataTextField = "rot_Name";
			rdRoute.DataValueField = "rot_ID";
			rdRoute.DataBind();
		}
		public string Cu_Cus()
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
				return "cra_cus_ID";
			}
			//var selectedItems = rdCustomer.CheckedItems;
			//if (selectedItems.Count > 0)
			//{
			//	return string.Join(",", selectedItems.Select(item => item.Value));
			//}
			//else
			//{
			//	return "cra_cus_ID";
			//}




		}
		public string curot()
		{
			var CollectionMarket = rdRoute.CheckedItems;
			string rotID = "";
			int j = 0;
			int MarCount = CollectionMarket.Count;
			if (CollectionMarket.Count > 0)
			{
				foreach (var item in CollectionMarket)
				{
					if (j == 0)
					{
						rotID += item.Value + ",";
					}
					else if (j > 0)
					{
						rotID += item.Value + ",";
					}
					if (j == (MarCount - 1))
					{
						rotID += item.Value;
					}
					j++;
				}
				return rotID;
			}
			else
			{
				return "cra_rot_ID";
			}
			//var selectedItems = rdRoute.CheckedItems;
			//if (selectedItems.Count > 0)
			//{
			//	return string.Join(",", selectedItems.Select(item => item.Value));
			//}
			//else
			//{
			//	return "cra_rot_ID";
			//}
		}
		public string mainConditions()
		{
			string fromDate = DateTime.Parse(rdfromDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string toDate = DateTime.Parse(rdendDate.SelectedDate.ToString()).ToString("yyyyMMdd");
			string rotid =curot();
			string customer = Cu_Cus();
			string status = Session["CpnBtlStatus"].ToString();
			string mainCondition = "";
			string customerCondition = "";
			string rotCondition = "";
			string statusCondition = "";
			string dateCondition = "";
			try
			{
				if (status.Equals(""))
				{
					statusCondition = "and isnull(A.Status,'P') in ('P')";
				}
				else
				{
					statusCondition = " and isnull(A.Status,'P')  in ('" + status + "')";
				}
				dateCondition = "  and (cast(A.CreatedDate as date) between cast('" + fromDate + "' as date) and cast('" + toDate + "' as date)) ";
				if (rotid.Equals("0"))
				{
					rotCondition = "";
				}
				else
				{
					rotCondition = " and cra_rot_ID in (" + rotid + ")";
				}
				if (customer.Equals("0"))
				{
					customerCondition = "";
				}
				else
				{
					customerCondition = " cra_cus_ID in (" + customer + ")";
				}
			}
			catch (Exception ex)
			{

			}
			mainCondition += customerCondition;
			mainCondition += rotCondition;
			mainCondition += dateCondition;
			mainCondition += statusCondition;
			return mainCondition;
		}
		public void LoadList()
		{
			string mainCondition = "";
			mainCondition = mainConditions();
			DataTable lstUser = default(DataTable);
			lstUser = ObjclsFrms.loadList("ListReturnEmptyBottleApprovalHeader", "sp_CouponCollection", mainCondition);
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
				Session["CpnBtlStatus"] = rdStatus.SelectedValue.ToString();

				if (Session["CpnBtlFDate"] != null)
				{
					string fromdate = rdfromDate.SelectedDate.ToString();
					if (fromdate == Session["CpnBtlFDate"].ToString())
					{
						rdfromDate.SelectedDate = DateTime.Parse(Session["CpnBtlFDate"].ToString());
					}
					else
					{
						Session["CpnBtlFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					}
				}
				else
				{
					rdfromDate.SelectedDate = DateTime.Parse(rdfromDate.SelectedDate.ToString());
					Session["CpnBtlFDate"] = DateTime.Parse(rdfromDate.SelectedDate.ToString());
				}
				rdfromDate.MaxDate = DateTime.Now;

				if (Session["CpnBtlTDate"] != null)
				{
					string todate = rdendDate.SelectedDate.ToString();
					if (todate == Session["CpnBtlTDate"].ToString())
					{
						rdendDate.SelectedDate = DateTime.Parse(Session["CpnBtlTDate"].ToString());
					}
					else
					{
						Session["CpnBtlTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
					}
				}
				else
				{
					rdendDate.SelectedDate = DateTime.Parse(rdendDate.SelectedDate.ToString());
					Session["CpnBtlTDate"] = DateTime.Parse(rdendDate.SelectedDate.ToString());
				}
				rdendDate.MaxDate = DateTime.Now.AddDays(1);
				if (Session["CpnBtlrotid"] != null)
				{
					string routeID = curot();
					if (routeID == Session["CpnBtlrotid"].ToString())
					{
						string rotid = curot();
					}
					else
					{
						string rotid = curot();
						Session["CpnBtlrotid"] = rotid;
					}
				}
				else
				{
					string rotid = curot();
					Session["CpnBtlrotid"] = rotid;
				}
				if (Session["CpnBtlcusID"] != null)
				{
					string customer = Cu_Cus();
					if (customer == Session["CpnBtlcusID"].ToString())
					{
						string cusID = Cu_Cus();

					}
					else
					{
						string cusID = Cu_Cus();
						Session["CpnBtlcusID"] = cusID;
					}
				}
				else
				{
					string cusID = Cu_Cus();
					Session["CpnBtlcusID"] = cusID;
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
			//Response.Redirect("ApprovalHeader.aspx");
		}
		protected void LinkButton3_Click(object sender, EventArgs e)
		{
			//Response.Redirect("ApprovalHeader.aspx");
		}
	
		protected void rdfromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
		{
			Route();
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
			Route();
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

		protected void grvRpt_ItemCommand(object sender, GridCommandEventArgs e)
		{
			try
			{
				RadGrid grd = (RadGrid)sender;

				SetGridSession(grd, "ReturnEmptyBottleReturnApprovalHeader");
			}
			catch (Exception ex)
			{
				Response.Redirect("~/SignIn.aspx");
			}

			if (e.CommandName.Equals("Details"))
			{
				GridDataItem dataItem = e.Item as GridDataItem;
				if (dataItem != null)
				{
					string ID = dataItem.GetDataKeyValue("cra_ID").ToString();
					Console.WriteLine("ID", ID);
					//string Mode = dataItem["Mode"].Text.ToString();

					Response.Redirect("CouponEmptyBottleReturnApprovalDetail.aspx?CPBID=" + ID);

				}
			}
		}
	}
}