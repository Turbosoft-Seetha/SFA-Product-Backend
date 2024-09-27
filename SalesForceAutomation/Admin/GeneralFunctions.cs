using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;


namespace SalesForceAutomation.Admin
{
    public class GeneralFunctions
    {
       General ObjGeneral = new General();
        public DataTable loadList(string sp)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);
                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    
                    cmd.CommandType = CommandType.StoredProcedure;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp +  "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                //
                if ((cn != null))
                {
                    cn.Close();
                }

            }
        }

        public DataTable loadListUsingQuery(string Qry)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);
                {
                    cmd.Connection = cn;
                    cmd.CommandText = Qry;

                    cmd.CommandType = CommandType.Text;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                //
                if ((cn != null))
                {
                    cn.Close();
                }

            }
        }

        public string SaveData(string ProcedureName, string Mode, string Para1, string[] Paras)
        {
            //
            SqlConnection cn = null;
            SqlCommand cmd = null;

            try
            {
                //
                cmd = new SqlCommand();
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = ProcedureName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    for (int i = 0; i < Paras.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@Para" + (i + 2).ToString(), Paras[i].ToString());

                    }



                    cmd.ExecuteNonQuery();

                    return cmd.Parameters["@Res"].Value.ToString();
                }

            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            finally
            {

                cn.Close();
                cmd.Dispose();

            }

        }

        public string ImportData(string ProcedureName, string Mode, string Para1, string[] Paras)
        {
            //
            SqlConnection cn = null;
            SqlCommand cmd = null;

            try
            {
                //
                cmd = new SqlCommand();
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = ProcedureName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 10800; 
                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    for (int i = 0; i < Paras.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@Para" + (i + 2).ToString(), Paras[i].ToString());

                    }



                    cmd.ExecuteNonQuery();

                    return cmd.Parameters["@Res"].Value.ToString();
                }

            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            finally
            {

                cn.Close();
                cmd.Dispose();

            }

        }

        public static DataTable loadList_Static(string Mode, string sp, string Where)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = General.FunMyCon_Static(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para2", Where);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }

        public DataTable loadList(string Mode, string sp)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }

        public void LogMessageToFile(string LOG_FILENAME, string funct, string msg)
        {
            msg = string.Format("{0:G}: {1} :- {2}{3}", DateTime.Now, funct, msg, Environment.NewLine);
            File.AppendAllText(LOG_FILENAME, msg);
        }
        
        public DataTable loadList(string Mode, string sp, string Para1, string[] Paras)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;
            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);
                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandTimeout = 3000;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    for (int i = 0; i < Paras.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@Para" + (i + 2).ToString(), Paras[i].ToString());

                    }

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }

        public DataTable loadList(string Mode, string sp, string Where)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para2", Where);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }

        public DataTable loadListX(string Mode, string sp, string Where)
        {

            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            DataTable dt = new DataTable("TT");
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Where);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                    dt.Load(rdr);

                    if (!rdr.IsClosed)
                        rdr.Close();

                    return dt;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }


        public DataSet loadList(string Mode, string sp, string Para1, string[] Paras, Boolean isDataSet)
        {

            SqlCommand cmd = null;
            SqlConnection cn = null;

            try
            {
                //
                cmd = new SqlCommand();
                //
                cn = ObjGeneral.FunMyCon(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    for (int i = 0; i < Paras.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@Para" + (i + 2).ToString(), Paras[i].ToString());

                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    DataSet ds = new DataSet();
                    adapter.Fill(ds);

                     
                    return ds;

                }
            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Source: " & MyExp.Source & ControlChars.Cr & ControlChars.Cr & "State: " & MyExp.State.ToString() & ControlChars.Cr & "Class: " & MyExp.Class.ToString() & ControlChars.Cr & "Server: " & MyExp.Server & ControlChars.Cr & "Message: " & MyExp.Message.ToString() & ControlChars.Cr & "Line: " & MyExp.LineNumber.ToString())
                return null;
                //
            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                //MessageBox.Show("Message : " & Exp.Message)
                return null;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                if ((cn != null))
                {
                    cn.Close();
                }
                //
            }
        }
        public static string SaveData_Static(string ProcedureName, string Mode, string Para1)
        {
            //
            SqlConnection cn = null;
            SqlCommand cmd = null;

            try
            {
                //
                cmd = new SqlCommand();
                cn = General.FunMyCon_Static(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = ProcedureName;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para2", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;
                    int retValue = cmd.ExecuteNonQuery();

                    return cmd.Parameters["@Res"].Value.ToString();
                }

            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            finally
            {

                cn.Close();
                cmd.Dispose();

            }

        }

        public string Bulk_ExcelUpdate(DataTable dt, string sp, string UserID)
        {
            SqlCommand cmd = null;
            SqlDataReader rdr = default(SqlDataReader);
            SqlConnection cn = null;
            try
            {
                cmd = new SqlCommand();
                cn = ObjGeneral.FunMyCon(ref cn);
                {
                    cmd.Connection = cn;
                    cmd.CommandText = sp;
                    cmd.CommandTimeout = 0;

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tbl", dt);
                    cmd.Parameters.AddWithValue("@UserID", UserID);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 1000));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    int retValue = cmd.ExecuteNonQuery();

                    return cmd.Parameters["@Res"].Value.ToString();
                }
            }
            catch (SqlException ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString() + " - " + innerMessage;
                //
            }
            catch (Exception ex)
            {
                String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                LogMessageToFile(UICommon.GetLogFileName(), "General Functions ", sp + "Error : " + ex.Message.ToString() + " - " + innerMessage);
                return ex.Message.ToString() + " - " + innerMessage;
                //
            }
            finally
            {
                //
                cmd.Dispose();
                //
                if ((cn != null))
                {
                    cn.Close();
                }

            }
        }

        public static string SaveData_Static(string ProcedureName, string Mode, string Para1, string[] Paras)
        {
            //
            SqlConnection cn = null;
            SqlCommand cmd = null;

            try
            {
                //
                cmd = new SqlCommand();
                cn = General.FunMyCon_Static(ref cn);

                {
                    cmd.Connection = cn;
                    cmd.CommandText = ProcedureName;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Mode", Mode);
                    cmd.Parameters.AddWithValue("@Para1", Para1);
                    cmd.Parameters.Add(new SqlParameter("@Res", SqlDbType.NVarChar, 50));
                    cmd.Parameters["@Res"].Direction = ParameterDirection.Output;

                    for (int i = 0; i < Paras.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@Para" + (i + 2).ToString(), Paras[i].ToString());

                    }



                    int retValue = cmd.ExecuteNonQuery();

                    return cmd.Parameters["@Res"].Value.ToString();
                }

            }
            catch (SqlException ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            catch (Exception ex)
            {
                 String innerMessage = (ex.InnerException != null) ? ex.InnerException.Message : "";
                return ex.Message.ToString();

            }
            finally
            {

                cn.Close();
                cmd.Dispose();

            }

        }

      

    }
}