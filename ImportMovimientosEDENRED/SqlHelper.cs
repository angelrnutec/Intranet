using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
//using System.Threading.Tasks;

namespace ImportMovimientosEDENRED
{
    public sealed class SqlHelper
    {
        public SqlConnection dbConn = new SqlConnection();
        public SqlCommand dbCommand = new SqlCommand();
        public SqlDataAdapter dbAdapter = new SqlDataAdapter();

        private string _connection_string;
        public SqlHelper(string connection_string)
        {
            _connection_string = connection_string;
        }

        public DataSet ExecuteDataAdapter(string sql, SqlParameter[] @params)
        {
            DataSet functionReturnValue = null;
            try
            {
                dbCommand = new SqlCommand();
                functionReturnValue = new DataSet();

                if (dbConn == null | dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                string paramStr = "";
                SqlParameter p = null;
                foreach (SqlParameter p_loopVariable in @params)
                {
                    p = p_loopVariable;
                    if ((p != null))
                    {
                        //check for derived output value with no value assigned
                        if (p.Direction == ParameterDirection.InputOutput & p.Value == null)
                        {
                            p.Value = null;
                        }
                        else
                        {
                            //paramStr += p.ParameterName & "=" & p.Value
                        }
                        dbCommand.Parameters.Add(p);
                    }
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;
                //& paramStr
                dbCommand.CommandType = CommandType.StoredProcedure;

                functionReturnValue.Clear();
                dbAdapter.SelectCommand = dbCommand;
                dbAdapter.Fill(functionReturnValue);

                CloseConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return functionReturnValue;

        }

        public DataSet ExecuteDataAdapter(string sql)
        {
            DataSet functionReturnValue = null;
            try
            {
                dbCommand = new SqlCommand();
                functionReturnValue = new DataSet();

                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                dbCommand.CommandType = CommandType.StoredProcedure;
                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;
                functionReturnValue.Clear();
                dbAdapter.SelectCommand = dbCommand;
                dbAdapter.Fill(functionReturnValue);

                CloseConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return functionReturnValue;
        }

        public int ExecuteScalar(string sql)
        {
            try
            {
                dbCommand = new SqlCommand();
                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;

                int id = Convert.ToInt32(dbCommand.ExecuteScalar());

                CloseConnection();

                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int ExecuteScalar(string sql, SqlParameter[] @params)
        {
            try
            {
                dbCommand = new SqlCommand();

                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                string paramStr = "";

                SqlParameter p = null;
                foreach (SqlParameter p_loopVariable in @params)
                {
                    p = p_loopVariable;
                    if ((p != null))
                    {
                        //check for derived output value with no value assigned
                        if (p.Direction == ParameterDirection.InputOutput & p.Value == null)
                        {
                            p.Value = null;
                        }
                        else
                        {
                            //paramStr += p.ParameterName & "=" & p.Value
                        }
                        dbCommand.Parameters.Add(p);
                    }
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;
                //& paramStr
                dbCommand.CommandType = CommandType.StoredProcedure;

                int id = Convert.ToInt32(dbCommand.ExecuteScalar());

                CloseConnection();

                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string ExecuteScalarString(string sql, SqlParameter[] @params)
        {
            try
            {
                dbCommand = new SqlCommand();

                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                string paramStr = "";

                SqlParameter p = null;
                foreach (SqlParameter p_loopVariable in @params)
                {
                    p = p_loopVariable;
                    if ((p != null))
                    {
                        //check for derived output value with no value assigned
                        if (p.Direction == ParameterDirection.InputOutput & p.Value == null)
                        {
                            p.Value = null;
                        }
                        else
                        {
                            //paramStr += p.ParameterName & "=" & p.Value
                        }
                        dbCommand.Parameters.Add(p);
                    }
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;
                //& paramStr
                dbCommand.CommandType = CommandType.StoredProcedure;

                string id = dbCommand.ExecuteScalar().ToString();

                CloseConnection();

                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void ExecuteNonQuery(string sql)
        {
            try
            {
                dbCommand = new SqlCommand();

                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;

                dbCommand.ExecuteNonQuery();

                CloseConnection();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void ExecuteNonQuery(string sql, SqlParameter[] @params)
        {
            try
            {
                dbCommand = new SqlCommand();

                if (dbConn.State == ConnectionState.Closed)
                {
                    OpenConnection();
                }
                string paramStr = "";
                SqlParameter p = null;
                foreach (SqlParameter p_loopVariable in @params)
                {
                    p = p_loopVariable;
                    if ((p != null))
                    {
                        //check for derived output value with no value assigned
                        if (p.Direction == ParameterDirection.InputOutput & p.Value == null)
                        {
                            p.Value = null;
                        }
                        else
                        {
                            //paramStr += p.ParameterName & "=" & p.Value
                        }
                        dbCommand.Parameters.Add(p);
                    }
                }

                dbCommand.Connection = dbConn;
                dbCommand.CommandText = sql;
                dbCommand.CommandTimeout = 0;
                dbCommand.CommandType = CommandType.StoredProcedure;

                dbCommand.ExecuteNonQuery();

                CloseConnection();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            SqlParameter p = null;

            foreach (SqlParameter p_loopVariable in commandParameters)
            {
                p = p_loopVariable;
                if (p.Direction == ParameterDirection.InputOutput & p.Value == null)
                {
                    p.Value = null;
                }
                command.Parameters.Add(p);
            }
        }

        private void OpenConnection()
        {
            try
            {
                if (!(dbConn.State == ConnectionState.Open))
                {
                    dbConn.ConnectionString = _connection_string;
                    dbConn.Open();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void CloseConnection()
        {
            try
            {
                if (!(dbConn.State == ConnectionState.Closed))
                {
                    dbConn.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
