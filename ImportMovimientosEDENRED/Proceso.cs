using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace TicketEmpresarialReporteMovimientos
{
    public static class Proceso
    {

        //public static ProcesoRespuesta ImportarArchivo(string archivo)
        //{
        //    Console.WriteLine("Nombre del archivo: " + archivo);


        //    try
        //    {
        //        List<Movimiento> movimientos = new List<Movimiento>();
        //        XmlDocument doc = new XmlDocument();
        //        doc.Load(archivo);

        //        string xmlns = doc.DocumentElement.Attributes["xmlns"].Value;
        //        XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
        //        nsmgr.AddNamespace("TE", xmlns);


        //        XmlNodeList nodeList = doc.SelectNodes("/TE:Report/TE:table1/TE:Detail_Collection/*", nsmgr);

        //        for (int i = 0; i < nodeList.Count; i++)
        //        {
        //            movimientos.Add(new Movimiento()
        //            {
        //                Autorizacion1 = (nodeList[i].Attributes["Autorizacion1"] != null ? nodeList[i].Attributes["Autorizacion1"].InnerText : ""),
        //                Concepto = (nodeList[i].Attributes["Concepto"] != null ? nodeList[i].Attributes["Concepto"].InnerText : ""),
        //                DescMonedaExtranjera = (nodeList[i].Attributes["DescMonedaExtranjera"] != null ? nodeList[i].Attributes["DescMonedaExtranjera"].InnerText : ""),
        //                Descripcion = (nodeList[i].Attributes["Descripcion"] != null ? nodeList[i].Attributes["Descripcion"].InnerText : ""),
        //                EstadoCuenta = (nodeList[i].Attributes["EstadoCuenta"] != null ? nodeList[i].Attributes["EstadoCuenta"].InnerText : ""),
        //                FechaMovimiento = (nodeList[i].Attributes["FechaMovimiento"] != null ? Convert.ToDateTime(nodeList[i].Attributes["FechaMovimiento"].InnerText) : new DateTime(1900, 1, 1)),
        //                MonedaExtranjera = (nodeList[i].Attributes["MonedaExtranjera"] != null ? Convert.ToDecimal(nodeList[i].Attributes["MonedaExtranjera"].InnerText) : 0),
        //                NumeroTarjeta = (nodeList[i].Attributes["NumeroTarjeta"] != null ? nodeList[i].Attributes["NumeroTarjeta"].InnerText : ""),
        //                Pesos = (nodeList[i].Attributes["Pesos"] != null ? Convert.ToDecimal(nodeList[i].Attributes["Pesos"].InnerText) : 0),
        //                StatusTarjeta = (nodeList[i].Attributes["StatusTarjeta"] != null ? nodeList[i].Attributes["StatusTarjeta"].InnerText : ""),
        //                TipoComercio = (nodeList[i].Attributes["TipoComercio"] != null ? nodeList[i].Attributes["TipoComercio"].InnerText : ""),
        //                TipoValorPesos = (nodeList[i].Attributes["TipoValorPesos"] != null ? Convert.ToDecimal(nodeList[i].Attributes["TipoValorPesos"].InnerText) : 0)
        //            });

        //        }

        //        doc = null;

        //        return new ProcesoRespuesta()
        //        {
        //            codigo = "00",
        //            mensajes = new List<string> { "OK" },
        //            movimientos = movimientos
        //        };

        //    }
        //    catch (Exception ex)
        //    {
        //        return new ProcesoRespuesta()
        //        {
        //            codigo = "01",
        //            mensajes = new List<string> { ex.Message },
        //            movimientos = null
        //        };

        //    }

        //}




        public static ProcesoRespuesta ImportarArchivoCSV(string archivo)
        {
            Console.WriteLine("Nombre del archivo: " + archivo);
            CultureInfo provider = CultureInfo.InvariantCulture;

            try
            {
                List<Movimiento> movimientos = new List<Movimiento>();



                Regex CSVParser = new Regex(",(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))");

                using (var fs = File.OpenRead(archivo))
                using (var reader = new StreamReader(fs))
                {
                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();

                        if (line.Length > 50)
                        {
                            String[] values = CSVParser.Split(line);

                            for (int i = 0; i < values.Length; i++)
                            {
                                values[i] = values[i].TrimStart(' ', '"');
                                values[i] = values[i].TrimEnd('"');
                            }

                            //var values = line.Split(',');
                            //var valuesList = SplitSeeingQuotes(line);


                            string FechaMovimiento = values[1].Replace("a. m.", "AM").Replace("p. m.", "PM");
                            FechaMovimiento = FechaMovimiento.Replace("a.m.", "AM").Replace("p.m.", "PM");
                            //DateTime fecha = DateTime.ParseExact(FechaMovimiento, "dd/MM/yyyy hh:mm:ss tt", provider);
                            DateTime fecha;
                            //                        Console.WriteLine()
                            if (DateTime.TryParseExact(FechaMovimiento, "dd/MM/yyyy hh:mm:ss tt", provider, DateTimeStyles.AssumeLocal, out fecha) == false)
                            {
                                if (DateTime.TryParseExact(FechaMovimiento, "dd/MM/yyyy", provider, DateTimeStyles.AssumeLocal, out fecha) == false)
                                {
                                    if (DateTime.TryParseExact(FechaMovimiento, "dd/MM/yyyy HH:mm", provider, DateTimeStyles.AssumeLocal, out fecha) == false)
                                    {
                                        DateTime.TryParseExact(FechaMovimiento, "dd/MM/yyyy hh:mm:ss tt", provider, DateTimeStyles.AssumeLocal, out fecha);
                                    }
                                }
                            }



                            //Console.WriteLine("values[1]: " + values[1]);
                            //Console.WriteLine("FechaMovimiento: " + FechaMovimiento);
                            //Console.WriteLine("***********************************");

                            movimientos.Add(new Movimiento()
                            {
                                FechaMovimiento = fecha, //DateTime.Parse(FechaMovimiento),
                                NumeroTarjeta = values[4],
                                EstatusTarjeta = values[5],
                                Concepto = values[6],
                                Descripcion = values[7],
                                TipoComercio = values[8],
                                RFCComercio = values[9],
                                IdMovimiento = values[10],
                                Autorizacion = values[11],
                                NoControlEdoCuenta = values[12],
                                Abono = decimal.Parse(values[13]),
                                ValorPesos = decimal.Parse(values[14]),
                                ComisionIva = decimal.Parse(values[15]),
                                ValorMonedaExtranjera = decimal.Parse(values[16]),
                                DescMonedaExtranjera = values[17],
                                TipoCambio = decimal.Parse(values[18])
                            });
                        }
                    }
                }


                return new ProcesoRespuesta()
                {
                    codigo = "00",
                    mensajes = new List<string> { "OK" },
                    movimientos = movimientos
                };

            }
            catch (Exception ex)
            {
                return new ProcesoRespuesta()
                {
                    codigo = "01",
                    mensajes = new List<string> { ex.Message },
                    movimientos = null
                };

            }

        }



        public static Queue<string> SplitSeeingQuotes(this string valToSplit, char splittingChar = ',', char escapeChar = '"', bool strictEscapeToSplitEvaluation = true, bool captureEndingNull = false)
        {
            Queue<string> qReturn = new Queue<string>();
            StringBuilder stringBuilder = new StringBuilder();

            bool bInEscapeVal = false;

            for (int i = 0; i < valToSplit.Length; i++)
            {
                if (!bInEscapeVal)
                {
                    // Escape values must come immediately after a split.
                    // abc,"b,ca",cab has an escaped comma.
                    // abc,b"ca,c"ab does not.
                    if (escapeChar == valToSplit[i] && (!strictEscapeToSplitEvaluation || (i == 0 || (i != 0 && splittingChar == valToSplit[i - 1]))))
                    {
                        bInEscapeVal = true;    // not capturing escapeChar as part of value; easy enough to change if need be.
                    }
                    else if (splittingChar == valToSplit[i])
                    {
                        qReturn.Enqueue(stringBuilder.ToString());
                        stringBuilder = new StringBuilder();
                    }
                    else
                    {
                        stringBuilder.Append(valToSplit[i]);
                    }
                }
                else
                {
                    // Can't use switch b/c we're comparing to a variable, I believe.
                    if (escapeChar == valToSplit[i])
                    {
                        // Repeated escape always reduces to one escape char in this logic.
                        // So if you wanted "I'm ""double quote"" crazy!" to come out with 
                        // the double double quotes, you're toast.
                        if (i + 1 < valToSplit.Length && escapeChar == valToSplit[i + 1])
                        {
                            i++;
                            stringBuilder.Append(escapeChar);
                        }
                        else if (!strictEscapeToSplitEvaluation)
                        {
                            bInEscapeVal = false;
                        }
                        // *** STINKY CONDITION ***  
                        // Kinda defense, since only `", ` really makes sense.
                        else if ('"' == escapeChar && i + 2 < valToSplit.Length &&
                            valToSplit[i + 1] == ',' && valToSplit[i + 2] == ' ')
                        {
                            i = i + 2;
                            stringBuilder.Append("\", ");
                        }
                        // *** EO STINKY CONDITION ***  
                        else if (i + 1 == valToSplit.Length || (i + 1 < valToSplit.Length && valToSplit[i + 1] == splittingChar))
                        {
                            bInEscapeVal = false;
                        }
                        else
                        {
                            stringBuilder.Append(escapeChar);
                        }
                    }
                    else
                    {
                        stringBuilder.Append(valToSplit[i]);
                    }
                }
            }

            // NOTE: The `captureEndingNull` flag is not tested.
            // Catch null final entry?  "abc,cab,bca," could be four entries, with the last an empty string.
            if ((captureEndingNull && splittingChar == valToSplit[valToSplit.Length - 1]) || (stringBuilder.Length > 0))
            {
                qReturn.Enqueue(stringBuilder.ToString());
            }

            return qReturn;
        }


    }




    public class Movimiento
    {
        public Movimiento()
        {

        }
        public string CuentaRegion { get; set; }
        public DateTime FechaMovimiento { get; set; }
        public string NumeroTarjeta { get; set; }
        public string EstatusTarjeta { get; set; }
        public string Concepto { get; set; }
        public string Descripcion { get; set; }
        public string TipoComercio { get; set; }
        public string RFCComercio { get; set; }
        public string IdMovimiento { get; set; }
        public string Autorizacion { get; set; }
        public string NoControlEdoCuenta { get; set; }
        public decimal Abono { get; set; }
        public decimal ValorPesos { get; set; }
        public decimal ComisionIva { get; set; }
        public decimal ValorMonedaExtranjera { get; set; }
        public string DescMonedaExtranjera { get; set; }
        public decimal TipoCambio { get; set; }
        public string Observaciones { get; set; }
        public string StatusTarjeta { get; set; }
    }

    public class ProcesoRespuesta
    {
        public ProcesoRespuesta()
        {

        }
        public string codigo { get; set; }
        public List<string> mensajes { get; set; }
        public List<Movimiento> movimientos { get; set; }
    }


}
