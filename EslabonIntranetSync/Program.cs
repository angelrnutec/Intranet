using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EslabonIntranetSync
{
    class Program
    {
        static StringBuilder _sbLog;
        static string connectionStringSource = System.Configuration.ConfigurationManager.AppSettings["DB_SOURCE"].ToString();
        static string connectionStringDestination = System.Configuration.ConfigurationManager.AppSettings["DB_DESTINATION"].ToString();

        static void Main(string[] args)
        {

            _sbLog = new StringBuilder("");
            EscribeEnLog("Iniciando proceso");

            if (args.Length > 0)
            {
                if (args[0] == "solo_tablas_eslabon")
                {
                    EscribeEnLog("solo_tablas_eslabon...");
                    TablasParaEslabonSync();
                    return;
                }
            }


            try
            {
                TablasVacacionesSync();
                //TablasDiasFestivosSync();
                PuestosSync();
                DepartamentoSync();

                EmpleadosSync();
                IncapacidadesSync();
                TablasParaEslabonSync();

                //GeneraPasswordsNuevosEmpleados();
            }
            catch (Exception ex)
            {
                _sbLog.AppendLine("------------------");
                _sbLog.AppendLine("-- ERROR --");
                _sbLog.AppendLine(ex.Message);
                _sbLog.AppendLine("-- FIN DEL ERROR --");
                _sbLog.AppendLine("");
                _sbLog.AppendLine("");
                _sbLog.AppendLine("");
                _sbLog.AppendLine("");
                //Enviar Email


                SendMail s = new SendMail(
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_HOST"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_USER"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_PASS"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_PORT"].ToString()
                    );

                s.Send(System.Configuration.ConfigurationManager.AppSettings["EMAIL_FROM"].ToString(), "rmartinez@develtec.mx;carmenacosta@nutec.com;franciscocavazos@nutec.com", "", "Descarga de empleados Intranet - Eslabon", _sbLog.Replace(Environment.NewLine, "<br />").ToString(), "", "");
                //s.Send(System.Configuration.ConfigurationManager.AppSettings["EMAIL_FROM"].ToString(), "rmartinez@develtec.mx;", "", "Descarga de empleados Intranet - Eslabon", _sbLog.Replace(Environment.NewLine, "<br />").ToString(), "", "");

            }

            EscribeEnLog("Fin...");
            //            Console.ReadKey();

        }


        static void EmpleadosSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando Empleados");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("SELECT * FROM vista_intranet_nutec_empleados", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros Empleados: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE empleado_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("fecha_consulta", "fecha_consulta");
                    bulkCopy.ColumnMappings.Add("numero_empleado", "numero_empleado");
                    bulkCopy.ColumnMappings.Add("nombre", "nombre");
                    bulkCopy.ColumnMappings.Add("fecha_alta", "fecha_alta");
                    bulkCopy.ColumnMappings.Add("fecha_antiguedad", "fecha_antiguedad");
                    bulkCopy.ColumnMappings.Add("Departamento", "Departamento");
                    bulkCopy.ColumnMappings.Add("categoria", "categoria");
                    bulkCopy.ColumnMappings.Add("Centro", "Centro");
                    bulkCopy.ColumnMappings.Add("Puesto", "Puesto");
                    bulkCopy.ColumnMappings.Add("localidad", "localidad");
                    bulkCopy.ColumnMappings.Add("estatus", "estatus");
                    bulkCopy.ColumnMappings.Add("fecha_nacmiento", "fecha_nacmiento");
                    bulkCopy.ColumnMappings.Add("empresa", "empresa");
                    bulkCopy.ColumnMappings.Add("num_deudor", "num_deudor");
                    bulkCopy.ColumnMappings.Add("email", "email");
                    bulkCopy.ColumnMappings.Add("id_tabla_vacaciones", "id_tabla_vacaciones");
                    bulkCopy.ColumnMappings.Add("fecha_efectividad_tabla_vacaciones", "fecha_efectividad_tabla_vacaciones");
                    bulkCopy.ColumnMappings.Add("imss", "imss");
                    bulkCopy.ColumnMappings.Add("rfc", "rfc");
                    bulkCopy.ColumnMappings.Add("curp", "curp");
                    bulkCopy.ColumnMappings.Add("sal_dia_base", "sal_dia_base");
                    bulkCopy.ColumnMappings.Add("sal_dia_int", "sal_dia_int");
                    bulkCopy.ColumnMappings.Add("sal_mensual", "sal_mensual");
                    bulkCopy.ColumnMappings.Add("jefe_numero_empleado", "jefe_numero_empleado");
                    bulkCopy.ColumnMappings.Add("jefe_empresa", "jefe_empresa");
                    bulkCopy.ColumnMappings.Add("Vacaciones_NUSA", "Vacaciones_NUSA");
                    

                    bulkCopy.DestinationTableName = "empleado_paso";
                    bulkCopy.WriteToServer(sourceData);
                }

                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_empleados";
                dbCommandFin.ExecuteNonQuery();

            }
        }


        static void TablasDiasFestivosSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando TablasDiasFestivos");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("select * from vista_intranet_nutec_tabla_dias_festivos where descripcion_nomina like '%Quincenal%'", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros TablasDiasFestivos: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE asueto_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("compania", "compania");
                    bulkCopy.ColumnMappings.Add("nomina", "nomina");
                    bulkCopy.ColumnMappings.Add("id_dia_festivo", "id_dia_festivo");
                    bulkCopy.ColumnMappings.Add("razon_social", "razon_social");
                    bulkCopy.ColumnMappings.Add("descripcion_nomina", "descripcion_nomina");
                    bulkCopy.ColumnMappings.Add("mes", "mes");
                    bulkCopy.ColumnMappings.Add("dia", "dia");
                    bulkCopy.ColumnMappings.Add("descripcion_dia_festivo", "descripcion_dia_festivo");
                    bulkCopy.ColumnMappings.Add("medio_dia", "medio_dia");

                    bulkCopy.DestinationTableName = "asueto_paso";
                    bulkCopy.WriteToServer(sourceData);
                }


                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_asueto";
                dbCommandFin.ExecuteNonQuery();


            }
        }

        static void TablasVacacionesSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando TablasVacaciones");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("SELECT * FROM vista_intranet_nutec_tabla_vacaciones", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros TablasVacaciones: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE vacaciones_tabulador_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("compania", "compania");
                    bulkCopy.ColumnMappings.Add("id_vacaciones", "id_vacaciones");
                    bulkCopy.ColumnMappings.Add("descripcion", "descripcion");
                    bulkCopy.ColumnMappings.Add("antiguedad_desde", "antiguedad_desde");
                    bulkCopy.ColumnMappings.Add("antiguedad_hasta", "antiguedad_hasta");
                    bulkCopy.ColumnMappings.Add("dias", "dias");

                    bulkCopy.DestinationTableName = "vacaciones_tabulador_paso";
                    bulkCopy.WriteToServer(sourceData);
                }


                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_vacaciones_tabulador";
                dbCommandFin.ExecuteNonQuery();


            }
        }

        static void DepartamentoSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando Centros de Costo");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("select clave_nodo, descripcion from oc_nodos_Estructuras where id_estructura = 3 order by clave_nodo", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros Centros de Costo: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE departamento_eslabon_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("clave_nodo", "clave_nodo");
                    bulkCopy.ColumnMappings.Add("descripcion", "descripcion");

                    bulkCopy.DestinationTableName = "departamento_eslabon_paso";
                    bulkCopy.WriteToServer(sourceData);
                }


                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_departamento";
                dbCommandFin.ExecuteNonQuery();


            }
        }

        
        static void PuestosSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando Puestos");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("select id_puesto, clave_puesto, descripcion from oc_puestos", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros TablasVacaciones: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE puesto_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("id_puesto", "id_puesto");
                    bulkCopy.ColumnMappings.Add("clave_puesto", "clave_puesto");
                    bulkCopy.ColumnMappings.Add("descripcion", "descripcion");

                    bulkCopy.DestinationTableName = "puesto_paso";
                    bulkCopy.WriteToServer(sourceData);
                }


                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_puesto";
                dbCommandFin.ExecuteNonQuery();


            }
        }

        static void IncapacidadesSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando Incapacidades");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringSource))
            {
                SqlCommand myCommand = new SqlCommand("SELECT * FROM vista_intranet_nutec_incapacidades_empleado", sourceConnection);
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros Incapacidades: " + sourceData.Rows.Count);

            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(connectionStringDestination))
            {
                // open the connection
                destinationConnection.Open();

                // Limpiar tabla de paso
                SqlCommand dbCommand = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0 };
                dbCommand.CommandText = "TRUNCATE TABLE incapacidad_paso";
                dbCommand.ExecuteNonQuery();


                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection.ConnectionString))
                {
                    bulkCopy.ColumnMappings.Add("empleado", "empleado");
                    bulkCopy.ColumnMappings.Add("compania", "compania");
                    bulkCopy.ColumnMappings.Add("fecha_incapacidad_desde", "fecha_incapacidad_desde");
                    bulkCopy.ColumnMappings.Add("fecha_incapacidad_hasta", "fecha_incapacidad_hasta");

                    bulkCopy.DestinationTableName = "incapacidad_paso";
                    bulkCopy.WriteToServer(sourceData);
                }


                // Fin del proceso
                SqlCommand dbCommandFin = new SqlCommand() { Connection = destinationConnection, CommandTimeout = 0, CommandType = CommandType.StoredProcedure };
                dbCommandFin.CommandText = "procesa_eslabon_incapacidades";
                dbCommandFin.ExecuteNonQuery();


            }
        }


        static void GeneraPasswordsNuevosEmpleados()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Consultando nuevos Empleados");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringDestination))
            {
                SqlCommand myCommand = new SqlCommand("genera_contrasenias_empleados_nuevos", sourceConnection) { CommandType = CommandType.StoredProcedure };
                sourceConnection.Open();

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = myCommand;
                dbAdapter.Fill(sourceData);

            }

            EscribeEnLog("Registros de nuevos empleados: " + sourceData.Rows.Count);

            foreach (DataRow dr in sourceData.Rows)
            {
                string email = dr["email"].ToString();
                string nombre = dr["nombre"].ToString();
                string password = dr["password"].ToString();

                StringBuilder sb = new StringBuilder("");
                sb.Append("Estimado " + nombre + ", <br><br>Se le ha generado la siguiente contraseña temporal: " + password + "<br><br>La URL de acceso es: http://intranet.nutec.com<br><br>Atentamente, <br>Soporte Nutec");

                SendMail s = new SendMail(
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_HOST"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_USER"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_PASS"].ToString(),
                    System.Configuration.ConfigurationManager.AppSettings["EMAIL_PORT"].ToString()
                    );

                string response = s.Send(System.Configuration.ConfigurationManager.AppSettings["EMAIL_FROM"].ToString(), email, "", "Bienvenido a la Intranet de Nutec", sb.ToString(), "", "");

                EscribeEnLog(response);
            }

        }


        static void TablasParaEslabonSync()
        {
            EscribeEnLog(".............................");
            EscribeEnLog("Proceso de Tablas para Eslabon");

            DataTable sourceData = new DataTable();
            using (SqlConnection sourceConnection = new SqlConnection(connectionStringDestination))
            {
                sourceConnection.Open();

                SqlCommand myCommand1 = new SqlCommand("eslabon_genera_vacaciones_autorizadas", sourceConnection) { CommandType = CommandType.StoredProcedure };
                myCommand1.ExecuteNonQuery();

                SqlCommand myCommand2 = new SqlCommand("eslabon_genera_vacaciones_canceladas", sourceConnection) { CommandType = CommandType.StoredProcedure };
                myCommand2.ExecuteNonQuery();

                SqlCommand myCommand3 = new SqlCommand("eslabon_genera_vacaciones_vencidas", sourceConnection) { CommandType = CommandType.StoredProcedure };
                myCommand3.ExecuteNonQuery();
            }

            EscribeEnLog("Proceso finalizado");

        }


        static void EscribeEnLog(string texto)
        {
            _sbLog.AppendLine(texto);
            Console.WriteLine(texto);

        }
    }
}
