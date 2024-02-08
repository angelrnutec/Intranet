using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
//using System.Threading.Tasks;

namespace ImportMovimientosEDENRED
{
    class MovimientosTarjeta
    {
        string _connString = "";

        public MovimientosTarjeta(string connString)
        {
            _connString = connString;
        }

        public void Guarda(string tipo, DateTime fecha_movimiento, string numero_tarjeta, string estatus_tarjeta, string concepto, string descripcion, string tipo_comercio, string rfc_comercio, string id_movimiento, string num_autorizacion, string no_control_edo_cuenta, decimal abono, decimal valor_pesos, decimal comision_iva, decimal valor_moneda_extranjera, string desc_moneda_extranjera, decimal tipo_cambio, int id_usuario_registro, string archivo_origen)
        {

            try
            {
                string sql = "guarda_movimientos_tarjetas";

                SqlParameter[] @params = new SqlParameter[19];
                @params[0] = new SqlParameter("tipo", tipo);
                @params[1] = new SqlParameter("fecha_movimiento", fecha_movimiento);
                @params[2] = new SqlParameter("numero_tarjeta", numero_tarjeta);
                @params[3] = new SqlParameter("estatus_tarjeta", estatus_tarjeta);
                @params[4] = new SqlParameter("concepto", concepto);
                @params[5] = new SqlParameter("descripcion", descripcion);
                @params[6] = new SqlParameter("tipo_comercio", tipo_comercio);
                @params[7] = new SqlParameter("rfc_comercio", rfc_comercio);
                @params[8] = new SqlParameter("id_movimiento_tarjeta", id_movimiento);
                @params[9] = new SqlParameter("num_autorizacion", num_autorizacion);
                @params[10] = new SqlParameter("no_control_edo_cuenta", no_control_edo_cuenta);
                @params[11] = new SqlParameter("abono", abono);
                @params[12] = new SqlParameter("pesos", valor_pesos);
                @params[13] = new SqlParameter("comision_iva", comision_iva);
                @params[14] = new SqlParameter("moneda_extranjera", valor_moneda_extranjera);
                @params[15] = new SqlParameter("moneda", desc_moneda_extranjera);
                @params[16] = new SqlParameter("tipo_cambio", tipo_cambio);
                @params[17] = new SqlParameter("id_usuario_registro", id_usuario_registro);
                @params[18] = new SqlParameter("archivo_origen", archivo_origen);


                SqlHelper sqlHelp = new SqlHelper(_connString);

                sqlHelp.ExecuteNonQuery(sql, @params);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public void GuardaDatosArchivo(string tipo, string nombre_archivo, int registros_procesados)
        {
            try
            {
                string sql = string.Format("insert into movimientos_tarjetas_archivos (tipo, nombre_archivo,fecha_procesamiento,registros_procesados) values ('{0}','{1}','{2}',{3})",
                    tipo,
                    nombre_archivo,
                    DateTime.Now.ToString("yyyyMMdd HH:mm"),
                    registros_procesados);

                SqlHelper sqlHelp = new SqlHelper(_connString);
                sqlHelp.ExecuteNonQuery(sql);

                Console.WriteLine(sql);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool ExisteArchivo(string nombre_archivo)
        {
            try
            {
                string sql = string.Format("select count(*) as contador from movimientos_tarjetas_archivos where tipo='TE' and nombre_archivo = '{0}'",
                    nombre_archivo);

                SqlHelper sqlHelp = new SqlHelper(_connString);
                if (sqlHelp.ExecuteScalar(sql) > 0)
                    return true;
                else
                    return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}

