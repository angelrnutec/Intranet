using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ImportMovimientosAMEX
{
    public class Proceso
    {

        public static ProcesoRespuesta ImportarArchivo(string archivo)
        {
            Console.WriteLine("Nombre del archivo: " + archivo);
            CultureInfo provider = CultureInfo.InvariantCulture;

            try
            {
                List<Movimiento> movimientos = new List<Movimiento>();



                using (var fs = File.OpenRead(archivo))
                using (var reader = new StreamReader(fs))
                {
                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();

                        string[] values = ParseDataLineFromString(line);

                        if (values != null)
                        {
                            //int posicion = 0;
                            //foreach (string value in values)
                            //{
                            //    Console.WriteLine("Value[" + posicion + "]: " + value);
                            //    posicion++;
                            //}





                            DateTime fecha = DateTime.Parse(values[34]);

                            decimal importe = decimal.Parse(values[47] + long.Parse(values[48]).ToString());
                            decimal impuesto = decimal.Parse(values[47] + long.Parse(values[50]).ToString());
                            decimal tipo_cambio = decimal.Parse(values[64]);

                            decimal importe_moneda_extrangera = decimal.Parse(values[47] + long.Parse(values[60]).ToString());

                            switch (values[51])         // Cantidad de decimales
                            {
                                case "1":
                                    importe = importe / 10;
                                    impuesto = impuesto / 10;
                                    break;
                                case "2":
                                    importe = importe / 100;
                                    impuesto = impuesto / 100;
                                    break;
                                case "3":
                                    importe = importe / 1000;
                                    impuesto = impuesto / 1000;
                                    break;
                                case "4":
                                    importe = importe / 10000;
                                    impuesto = impuesto / 10000;
                                    break;
                            }

                            switch (values[63])         // Cantidad de decimales local
                            {
                                case "1":
                                    importe_moneda_extrangera = importe_moneda_extrangera / 10;
                                    break;
                                case "2":
                                    importe_moneda_extrangera = importe_moneda_extrangera / 100;
                                    break;
                                case "3":
                                    importe_moneda_extrangera = importe_moneda_extrangera / 1000;
                                    break;
                                case "4":
                                    importe_moneda_extrangera = importe_moneda_extrangera / 10000;
                                    break;
                            }


                            movimientos.Add(new Movimiento()
                            {
                                NumeroTarjeta = values[17],
                                FechaMovimiento = fecha,
                                EstatusTarjeta = "OK",
                                IdMovimiento = values[42],
                                Concepto = TransactionType.Find(values[71]),
                                ValorPesos = importe,
                                TipoCambio = tipo_cambio,
                                Abono = 0,
                                ComisionIva = impuesto,

                                ValorMonedaExtranjera = importe_moneda_extrangera,
                                DescMonedaExtranjera = CurrencyType.Find(values[65]),

                                Descripcion = values[85],
                                TipoComercio = IndustryCode.Find(values[82]),
                                RFCComercio = "",
                                Autorizacion = "",
                                NoControlEdoCuenta = "",
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




        private static string[] ParseDataLineFromString(string line)
        {
            if (line.Substring(0, 1) == "1")
            {
                //line = line.PadRight(167, ' ');
                //int[] cols = new int[] { 1, 3, 15, 5, 19, 5, 40, 5, 19, 40, 6, 19, 5, 20, 1, 3, 1, 20, 30, 20, 20, 30, 15, 40, 50, 40, 50, 13, 5, 25, 5, 3, 8, 7, 10, 1, 10, 1, 5, 1, 10, 5, 50, 20, 20, 2, 13, 1, 15, 1, 15, 1, 3, 3, 15, 1, 15, 1, 3, 1, 15, 1, 15, 1, 15, 3, 3, 15, 1, 3, 15, 2, 2, 2, 3, 6, 3, 1, 4, 1, 2, 1, 3, 15, 3, 45, 45, 45, 45, 45 };
                int[] cols = new int[] { 1, 3, 15, 5, 19, 5, 40, 5, 19, 40, 6, 19, 5, 20, 1, 3, 1, 20, 30, 20, 20, 30, 15, 40, 50, 40, 50, 13, 5, 25, 5, 3, 8, 7, 10, 1, 10, 1, 5, 1, 10, 5, 50, 20, 20, 2, 13, 1, 15, 1, 15, 1, 3, 3, 15, 1, 15, 1, 3, 1, 15, 1, 15, 1, 15, 3, 3, 15, 1, 3, 15, 2, 2, 2, 3, 6, 3, 1, 4, 1, 2, 1, 3, 15, 3, 45, 45, 45, 45, 45, 500, 6, 4, 30, 22, 10, 8, 10, 40, 6, 5, 15, 10, 30, 30, 16, 40, 40, 4, 38, 38, 38, 38, 38, 3, 6, 15, 40, 3, 1, 2, 1, 10, 20, 35, 20, 3, 6, 10, 1, 15, 15, 2 };
                string[] values = new string[cols.Length + 1];
                int ofs = 0;
                for (int j = 0; j < cols.Length; j++)
                {
                    values[j] = line.Substring(ofs, cols[j]);
                    ofs += cols[j];
                };
                values[cols.Length] = ""; //line.Substring(ofs);
                return values;
            }
            return null;
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


    public static class IndustryCode
    {
        public static string Find(string ic)
        {
            switch (ic)
            {
                case "001": return "TRAVEL AGENTS            ";
                case "002": return "CAR WASHES               ";
                case "003": return "DINERS                   ";
                case "004": return "FAST FOOD OUTLETS        ";
                case "005": return "GARAGES                  ";
                case "006": return "GROCERY STORES           ";
                case "007": return "AIRPORT AUTHORITIES      ";
                case "008": return "CASINO                   ";
                case "009": return "COACH - COMMUTER/LOCAL   ";
                case "010": return "EATING PLACES/RESTAURANTS";
                case "011": return "FUNCTION CENTRE          ";
                case "012": return "CONCRETE WORK CONTRACTORS";
                case "013": return "CABCHARGE                ";
                case "014": return "SECURITY SERVICES        ";
                case "015": return "CAR/VALET                ";
                case "016": return "MOTOR RELATED SERVICES   ";
                case "017": return "TYRE AND EXHAUST CENTRE  ";
                case "018": return "WINDSCREEN/SHIELD REPLCMN";
                case "019": return "SUPERMARKET              ";
                case "020": return "UNIVERSITIES             ";
                case "021": return "TRAVEL CONSULTANT        ";
                case "022": return "WINERY/RESTAURANT/TAVERN ";
                case "023": return "AMUSEMENT/THEME PARK     ";
                case "024": return "TELEVISION SHOPPING      ";
                case "025": return "MASS MERCHANDISER        ";
                case "026": return "WAREHOUSE                ";
                case "027": return "MANUFACTURER OUTLET      ";
                case "028": return "PERFORMING ARTS ORGANISTN";
                case "029": return "NON S/E TAKE ONES        ";
                case "030": return "BANKS                    ";
                case "031": return "CREDIT UNIONS            ";
                case "032": return "GOLD BANKS               ";
                case "033": return "SAVINGS & LOANS          ";
                case "034": return "INSURANCE RELATED SERVCS ";
                case "035": return "PROP/CASUALTY UNDRWRTRS  ";
                case "036": return "LIFE INS UNDERWRITERS    ";
                case "038": return "CP PRICE MAIL ORD VOL    ";
                case "039": return "OTHER FIN INSTITUTION    ";
                case "040": return "MULTI-VENUE              ";
                case "041": return "ASSOCIATIONS             ";
                case "042": return "TRAVEL EMPLOYEES         ";
                case "043": return "SHOPS-DISC BEER/BEVERAGE ";
                case "044": return "MISC FOOD STORES - CONV  ";
                case "045": return "OFF PRICE APPAREL-MEN    ";
                case "046": return "OFF PRICE APPAREL-WOMEN  ";
                case "047": return "OFF PRICE APPAREL-CHILDRN";
                case "048": return "OFF PRICE APPAREL-FAMILY ";
                case "049": return "MISCELLANEOUS TAKE ONES  ";
                case "050": return "EXPRESS DEPOSIT BANK     ";
                case "051": return "EXPRESS PAY BANK         ";
                case "052": return "AMEX HQ & OPERATING CNTRE";
                case "053": return "AMEX SALES OFFICE        ";
                case "054": return "FSI ACCOUNT BANK         ";
                case "055": return "PAYING MANAGER           ";
                case "056": return "REP AGENT                ";
                case "057": return "TRAVEL SERVICE OFFICE    ";
                case "058": return "TERRITORY MANAGER        ";
                case "059": return "FSI ACCOUNT BANK         ";
                case "060": return "THIRD PARTY PROCESSOR    ";
                case "061": return "EDC TERMINAL PROVIDER    ";
                case "062": return "EDC SOFTWARE VENDOR      ";
                case "063": return "BUILDING SOCIETY         ";
                case "064": return "NEWSAGENTS               ";
                case "065": return "TAXIS                    ";
                case "066": return "POST OFFICE              ";
                case "067": return "UTILITIES                ";
                case "068": return "RECORD/TAPE/CD           ";
                case "069": return "VIDEO SALES              ";
                case "070": return "LEISURE                  ";
                case "071": return "MISCELLANEOUS            ";
                case "072": return "FINE DINING              ";
                case "073": return "CASUAL DINING            ";
                case "074": return "BUYING/SHOPPING CLUBS    ";
                case "075": return "MEETINGS/CONVENTIONS     ";
                case "076": return "DISCOUNT DINING PROGRAM  ";
                case "077": return "BUSINESS LICENCES        ";
                case "078": return "INDIVIDUAL INCOME TAX    ";
                case "079": return "E/S MERCH PROD/SCVS      ";
                case "080": return "FOREIGN EXCHANGE SVCS    ";
                case "081": return "CP PRICE INTRNT VOL      ";
                case "082": return "INTERNET CDS,BOOKS,VIDEO ";
                case "083": return "INTERNET COMPUTERS & ELEC";
                case "084": return "INTERNET HOME IMPROVEMENT";
                case "085": return "INTERNET SERVICES        ";
                case "086": return "INTERNET SHOPPING        ";
                case "087": return "INTERNET TRAVEL          ";
                case "088": return "INTERNET AIRLINE         ";
                case "089": return "TAKE ONE CONTRACTORS     ";
                case "090": return "HARDWARE MOBILE TELECOM  ";
                case "091": return "ACCESSORIES MOB TELECOM  ";
                case "092": return "CALL CHARGES MOB TELECOM ";
                case "093": return "RENTAL CHARGES MOB TELECM";
                case "094": return "CONNECT CHARGES MOB TELE ";
                case "095": return "SERVICE REQUESTS MOB TELE";
                case "096": return "INTERNET LODGING         ";
                case "097": return "INTERNET TRANSPORTATION  ";
                case "098": return "INTERNET ENTERTAINMENT   ";
                case "099": return "OTHER NON S/E TAKE ONES  ";
                case "100": return "REST AMERICAN            ";
                case "101": return "COMMERCIAL CLOTHING      ";
                case "102": return "LOCAL TRANSPORTATION     ";
                case "103": return "FLORISTS SUPPLIES        ";
                case "104": return "AIRCONDIT/REFRIGEREPAIR  ";
                case "105": return "AUTO&HOME SUPPLY STORES  ";
                case "106": return "REST SEAFOOD             ";
                case "107": return "REUPHOLSTERREPAIRREFINISH";
                case "108": return "REST STEAK               ";
                case "109": return "REST STEAK & SEAFOOD     ";
                case "110": return "WATCH/JEWELRY REPAIR     ";
                case "111": return "OSTEOPATHS               ";
                case "112": return "REST AUSTRIAN            ";
                case "113": return "ANTIQUE REPRODUCTION STOR";
                case "114": return "REST CONTINENTAL (EUR)   ";
                case "115": return "MISCELLGENMERCHANDISE    ";
                case "116": return "REST ENGLISH             ";
                case "117": return "SECURITIESBROKERS&DEALERS";
                case "118": return "REST FRENCH              ";
                case "119": return "REST GERMAN              ";
                case "120": return "REST GREEK               ";
                case "121": return "COPY REPRODUCTN & B/PRINT";
                case "122": return "RELIGIOUS ORGANIZATIONS  ";
                case "123": return "REST ITALIAN             ";
                case "124": return "PAINTS SUPPLIES&VARNISHES";
                case "125": return "VIDEOAMUSEMENTGAMESUPPLY ";
                case "126": return "GEMS WATCHES & JEWELRY   ";
                case "127": return "TIRE RE-TREADING & REPAIR";
                case "128": return "REST SCANDINAVIAN/SWEDISH";
                case "129": return "SPECIAL TRADE CONTRACTORS";
                case "130": return "FININSTIT-MANUALCASH DISB";
                case "131": return "REST SPANISH             ";
                case "132": return "RECREATION CAMP          ";
                case "133": return "COURT COSTS              ";
                case "134": return "USED CAR & TRUCK DEALERS ";
                case "135": return "MOBILE HOME DEALERS      ";
                case "136": return "REST CHINESE             ";
                case "137": return "REST INDIAN              ";
                case "138": return "TESTINGLABORATORY-NONMED ";
                case "139": return "SNOWMOBILE DEALERS       ";
                case "140": return "REST JAPANESE            ";
                case "141": return "REST KOREAN              ";
                case "142": return "POLITICAL ORGANIZATIONS  ";
                case "143": return "TYPEWRITER STORE         ";
                case "144": return "WIG AND TOUPEE STORES    ";
                case "145": return "WIRETRFS & MONEYORDERS   ";
                case "146": return "REST THAI                ";
                case "147": return "REST VIETNAMESE          ";
                case "148": return "ORTHOPAEDIC PROSTHETICS  ";
                case "149": return "ELECTRIC RAZOR SALE SVC  ";
                case "150": return "REST MEXICAN             ";
                case "151": return "METALSERVICECENTER/OFFICE";
                case "152": return "VIDEO GAME ARCADES       ";
                case "153": return "TELEGRAPH SERVICES       ";
                case "154": return "RAILROADS - FREIGHT      ";
                case "155": return "REST INTERNATIONAL       ";
                case "156": return "NOTIONS&PIECE/DRY GOODS  ";
                case "157": return "BARS, TAVERNS & NIGHTCLUB";
                case "158": return "STORAGE - FARM PRODUCTS  ";
                case "159": return "REST JAPANESE-SEAFOOD    ";
                case "160": return "DINING CLUBS             ";
                case "161": return "REST ARABIAN             ";
                case "162": return "ARABIAN REST & SHOW      ";
                case "163": return "REST BRAZILIAN           ";
                case "164": return "BRAZILIAN REST & SHOW    ";
                case "165": return "BUSINESS&SECRETARYSCHOOL ";
                case "166": return "REST BARBEQUE            ";
                case "167": return "WHOLESALE ALCOHOL        ";
                case "168": return "WELDING SERVICES         ";
                case "169": return "INFO RETRIEVAL SERVICE   ";
                case "170": return "FAST FOOD RESTAURANT     ";
                case "171": return "REST DUTCH               ";
                case "172": return "REST FRENCH/ENGLISH      ";
                case "173": return "REST AUSTRALIAN          ";
                case "174": return "REST PANCAKES            ";
                case "175": return "MONTHLY TELEPHONE        ";
                case "176": return "REST CATAL/BALEAR/VALENC ";
                case "177": return "HEARING AID SALES/SVC/SUP";
                case "178": return "DIRECT MKTING INSURANCE  ";
                case "179": return "REST MEDITERRANEAN       ";
                case "180": return "REST PIZZERIA            ";
                case "181": return "COMPHOTOGRAPHYARTGRAPHICS";
                case "182": return "ROADSIDE RESTAURANT      ";
                case "183": return "TAKE OUT ONLY RESTAURANT ";
                case "184": return "WINE BAR / BISTRO        ";
                case "185": return "CLUB RESTAURANT          ";
                case "186": return "COCKTAIL BAR             ";
                case "187": return "NON FINANCIAL INST       ";
                case "188": return "BAR / RESTAURANT         ";
                case "189": return "DISCO / RESTAURANT       ";
                case "190": return "REST CANTONESE           ";
                case "191": return "ROOFING                  ";
                case "192": return "CHEMICALS&ALLIED PRODUCTS";
                case "193": return "NIGHT CLUB / RESTAURANT  ";
                case "194": return "HOTEL RESTAURANT         ";
                case "195": return "LOUNGE / COFFEE HOUSE    ";
                case "196": return "NIGHT CLUB / HOSTESS     ";
                case "197": return "GIRLIE BAR               ";
                case "198": return "PUBLIC HOUSE             ";
                case "199": return "OTHER RESTAURANT         ";
                case "200": return "CATERING - FOOD          ";
                case "201": return "REST ANDALUCIAN          ";
                case "202": return "REST BASQUE/NAVARRA      ";
                case "203": return "REST CASTILLIAN          ";
                case "204": return "MOTION PIC&VIDEOPROD&DIST";
                case "205": return "REST GALICIAN/ASTUR/CANTA";
                case "206": return "AUTOMOTIVE PAINT SHOPS   ";
                case "207": return "WINE PRODUCERS           ";
                case "208": return "ELECT/SMALL APP REPAIR   ";
                case "209": return "BOWLING ALLEYS           ";
                case "210": return "DISCO / HOTEL            ";
                case "211": return "REST REGIONAL CUISINE    ";
                case "212": return "HOTEL WITH RESTAURANT    ";
                case "213": return "REST JAPANESE NOODLE     ";
                case "214": return "CAR/VALET                ";
                case "215": return "MOTOR RELATED SERVICES   ";
                case "216": return "COMPUTER SALES           ";
                case "217": return "CAFE                     ";
                case "218": return "TYPESETTING SERVICE      ";
                case "219": return "FININSTIT-AUTO CASH DISB ";
                case "220": return "HOTEL                    ";
                case "221": return "HOTEL / APARTMENT        ";
                case "222": return "HOSTEL                   ";
                case "223": return "SMALL LUXURY HOTEL       ";
                case "224": return "SMALL COUNTRY HOTEL      ";
                case "225": return "HOTEL ECONOMY            ";
                case "226": return "HOTEL MID-PRICED         ";
                case "227": return "HOTEL EXPENSIVE          ";
                case "228": return "HOTEL DELUXE             ";
                case "229": return "MOTEL                    ";
                case "230": return "LAUNDRYSVC-FAMILY&COMMERC";
                case "231": return "DEBT COLLECTION          ";
                case "232": return "CORRESPONDENCE SCHOOLS   ";
                case "233": return "MOTOR HOME DEALERS       ";
                case "234": return "DRUG/DRUGPROP&DRUGGISTS  ";
                case "235": return "DOOR-TO-DOOR SALES       ";
                case "236": return "MASONARY/PLASTERING CONTR";
                case "237": return "CARPENTRY CONTRACTORS    ";
                case "238": return "CHAMPAGNE PRODUCERS      ";
                case "239": return "GLASSPAINT&WALLPAPERSTORE";
                case "240": return "COMMERCIAL FOOTWEAR      ";
                case "241": return "RESORT                   ";
                case "242": return "BED & BREAKFAST          ";
                case "243": return "HEALTH CLUB WITH ACCOMM  ";
                case "244": return "INN / PUB WITH ACCOMM    ";
                case "245": return "GUEST HOUSE              ";
                case "246": return "COUNTRY HOUSE HOTEL      ";
                case "247": return "LUXURY CNTRY HSE/CASTLE  ";
                case "248": return "CAMPING/CARAVAN PARK     ";
                case "249": return "LODGING MILITARY         ";
                case "250": return "SKI AREA AND LODGE       ";
                case "251": return "DAIRY PRODUCTS STORE     ";
                case "252": return "JAPANESE LOUNGE          ";
                case "253": return "SPORTS CLOTHING          ";
                case "254": return "HOTEL INTERNATIONAL      ";
                case "255": return "CIGAR STORES AND STANDS  ";
                case "256": return "KARAOKE / RESTAURANT     ";
                case "257": return "WATER TAXIS              ";
                case "258": return "RAIL - COMMUTER/LOCAL    ";
                case "259": return "DEPT STORE - DISCOUNT    ";
                case "260": return "INSURANCE POLICIES       ";
                case "261": return "RELIGIOUS ITEMS          ";
                case "262": return "SOUVENIRS                ";
                case "263": return "TICKET BOOKINGS          ";
                case "264": return "RECREATIONAL VEHICLE SALE";
                case "265": return "CLUBS - PRIVATE          ";
                case "266": return "CLUBS - RSL & SERVICE ORG";
                case "267": return "HOT WATER SYSTEMS        ";
                case "268": return "POOL CLEANING SERVICE    ";
                case "269": return "CLUBS - FLYING           ";
                case "270": return "PROFESSIONAL EQUIP SUPPLY";
                case "271": return "SPECIAL EVENTS-NON PROFIT";
                case "272": return "SPECIAL EVENTS-PROFIT    ";
                case "273": return "RECREATION SERVICES      ";
                case "274": return "CLOTHING - T-SHIRTS      ";
                case "275": return "GOLDSMITH                ";
                case "276": return "CARPETS - HANDMADE       ";
                case "277": return "CARPETS - MACHINE MADE   ";
                case "278": return "LEATHER/SADDLERY         ";
                case "279": return "DIVING EQUIPMENT         ";
                case "280": return "PAWN BROKERS             ";
                case "281": return "SUNGLASSES               ";
                case "282": return "SHOPS-PUB/LIQUOR SALES   ";
                case "283": return "AIR CONDITIONER          ";
                case "284": return "AUTO ALARMS              ";
                case "285": return "AUTO ELECTRICIAN         ";
                case "286": return "AUTO SOUND SYSTEMS       ";
                case "287": return "AUTO UPHOLSTERY          ";
                case "288": return "AUTO WRECKERS            ";
                case "289": return "BATTERY SALES/SERVICE    ";
                case "290": return "ADVANCE DEPOSIT          ";
                case "291": return "CONDOMINIUM/SELF CATERING";
                case "292": return "DIAGNOSTIC/TUNE UP       ";
                case "293": return "GAS CONVERSIONS          ";
                case "294": return "MECHANICS/MOBILE MECHANIC";
                case "295": return "PANEL BEATERS            ";
                case "296": return "TOWBAR SUPPLIES & FIT    ";
                case "297": return "BOAT DEALERS             ";
                case "298": return "FREQUENT FLYER CLUB      ";
                case "299": return "OTHER LODGING            ";
                case "300": return "AIRLINES AND AIR CARRIERS";
                case "301": return "FASHION HOUSE            ";
                case "302": return "KNITWEAR                 ";
                case "303": return "AIR CARGO                ";
                case "304": return "SUPPLEMENTAL CARRIER     ";
                case "305": return "HELICOPTER               ";
                case "306": return "SPECIAL AIR SERVICE      ";
                case "307": return "INTERLINE AIR SERVICE    ";
                case "308": return "TICKET SALES - AGENT     ";
                case "309": return "COMMUTER SERVICE         ";
                case "310": return "DIRECT TICKET SALES-OTHER";
                case "311": return "DOMESTIC/LOCAL AIR SRVC  ";
                case "312": return "RELIGIOUS ARTICLES       ";
                case "313": return "IMPORTED GOODS           ";
                case "314": return "TIES/GLOVES/ACCESSORIES  ";
                case "315": return "AGRICULTURAL MACH & EQUIP";
                case "316": return "IN FLIGHT TAX FREE SALES ";
                case "317": return "AIRLINE FBO              ";
                case "318": return "ENTERTAINMENT            ";
                case "319": return "PACKAGE HOLIDAYS         ";
                case "320": return "FOUR WHEEL DRIVE RENTAL  ";
                case "321": return "MOTORCYCLE RENTAL        ";
                case "322": return "INSURANCE - AMEX PLANS   ";
                case "323": return "CONSULTANT - INDEPENDENT ";
                case "324": return "UTILITIES -GAS/ELEC/WATER";
                case "325": return "UTILITIES - GOVERNMENT   ";
                case "326": return "CHARITY                  ";
                case "327": return "FLEET MANAGEMENT         ";
                case "328": return "TC ADVANCES - CORP CARD  ";
                case "329": return "TC ADVANCES - OTHER      ";
                case "330": return "OTHER NON REVENUE        ";
                case "331": return "MEMBERSHIP MILES         ";
                case "332": return "MEMBERSHIP REWARDS       ";
                case "333": return "PEWTERWARE               ";
                case "334": return "FEDERAL DEPARTMENT       ";
                case "335": return "GOVERNMENT SERVICES      ";
                case "336": return "STATE DEPARTMENT         ";
                case "337": return "LOCAL COUNCIL            ";
                case "338": return "LOCAL GOVERNMENT         ";
                case "339": return "AQUATIC INSTRUCTION      ";
                case "340": return "AIRPORT SERVICES         ";
                case "341": return "BANK SERVICE             ";
                case "342": return "BUILDING SOC/CREDIT UNION";
                case "343": return "MISC PERSONAL SERVICES   ";
                case "344": return "RAILWAY STATION          ";
                case "345": return "GENERAL CONTRACTORS      ";
                case "346": return "DIR TKT SALES-PHONE/MAIL ";
                case "347": return "DIR TKT SALES-UNATTENDED ";
                case "348": return "DIR TKT SALES-AIRPORT DSK";
                case "349": return "TRAVEL SHOP              ";
                case "350": return "TRAVEL CLINIC            ";
                case "351": return "PASSENGER DESK SERVICE   ";
                case "352": return "AIR MILES                ";
                case "353": return "AIR TERMINAL TAX FREE SLS";
                case "354": return "CAR RENTAL               ";
                case "355": return "TRUCK & TRAILER RENTALS  ";
                case "356": return "AUTOMATED FUEL DISPENSERS";
                case "357": return "UNATTENDED CINEMA TICKETS";
                case "358": return "CAR LEASING              ";
                case "359": return "TRUCK LEASING            ";
                case "360": return "TOLLS AND BRIDGE FEES    ";
                case "361": return "MISC CLEANING PRODUCT    ";
                case "362": return "INTERNET SUPERMARKETS    ";
                case "363": return "INTERNET AUTO RENTAL     ";
                case "364": return "INTERNET AUTO RELATED    ";
                case "365": return "INTERNET UTILITIES       ";
                case "366": return "INTERNET GOVERNMENT RELAT";
                case "367": return "INTERNET INSURANCE       ";
                case "368": return "INTERNET PROFESSIONAL & F";
                case "369": return "INTERNET INFORMATION SERV";
                case "370": return "CROSS-BORDER CAR RENTAL  ";
                case "371": return "X-BORDER CAR LEASING     ";
                case "372": return "CROSS-BORDER TRUCK RENTAL";
                case "373": return "X-BORDER TRUCK LEASING   ";
                case "374": return "HEARSE                   ";
                case "375": return "MOTOR HOME/RV RENTAL     ";
                case "376": return "AUTO RENTAL - ALL TYPES  ";
                case "377": return "INTERNET TELECOMS        ";
                case "378": return "INTERNET DEPARTMENT STORE";
                case "379": return "INTERNET SUBSCRIPTIONS   ";
                case "380": return "X-BORDER DEALER CAR RENT ";
                case "381": return "X-BORDER DEALER CAR LEASE";
                case "382": return "X-BORDER DEALER TRUCK REN";
                case "383": return "X-BORDER DEALER TRUCK LEA";
                case "384": return "WHOLESALE MAIL ORDER     ";
                case "385": return "HELICOPTER - CHARTER     ";
                case "386": return "HELICOPTER - SIGHTSEEING ";
                case "387": return "UNATTENDED ROAD TOLLS    ";
                case "388": return "PLANE CHARTER            ";
                case "389": return "PARKING LOTS AND GARAGES ";
                case "390": return "MOTOR COACH-INTERCITY    ";
                case "391": return "AIRPORTS & TERMINALS     ";
                case "392": return "CLUBS - SHOOTING         ";
                case "393": return "PASSENGER RAILWAYS       ";
                case "394": return "AIR TAXIS                ";
                case "395": return "BOAT - SIGHTSEEING       ";
                case "396": return "BOAT - CHARTERS          ";
                case "397": return "TAXICABS AND LIMOUSINES  ";
                case "398": return "LIMO-AIRPORT & SPEC HIRE ";
                case "399": return "TRANSPORTATION SERVICES  ";
                case "400": return "AUTO PARTS/ACCESSORIES   ";
                case "401": return "TYRE AND EXHAUST CENTRE  ";
                case "402": return "CLOTHING- CHILDRENS ONY  ";
                case "403": return "MOTORCYCLE SALES & SVC   ";
                case "404": return "CAR & TRUCK SALES/SVCS   ";
                case "405": return "BOUTIQUES                ";
                case "406": return "WINDSCREEN/SHIELD REPLCMN";
                case "407": return "CLOTHING-FAMILY          ";
                case "408": return "CLOTHING-FORMAL WEAR RENT";
                case "409": return "CLOTHING-FUR             ";
                case "410": return "CLOTHING-ADULT CLTHG     ";
                case "411": return "CLOTHING-MEN'S & BOY'S   ";
                case "412": return "CLOTHING-MEN&WOMEN       ";
                case "413": return "MISC APPAREL & ACCESSRS  ";
                case "414": return "CLOTHING-WOMEN'S CLTHG   ";
                case "415": return "DEPARTMENT STORES        ";
                case "416": return "DEPT STORE - SPECIALITY  ";
                case "417": return "SHOPS-CONFECTIONER/SWEETS";
                case "418": return "SHOPS-FOOD/FRUIT/GOURMET ";
                case "419": return "ANTIQUES                 ";
                case "420": return "MAJOR APPLIANCES - ALL   ";
                case "421": return "BED & BATHROOM BOUTIQUES ";
                case "422": return "BEDDING & SLEEP/LINEN    ";
                case "423": return "BEDSPREADS & DRAPES      ";
                case "424": return "CHINA/CRYSTAL/SILVERWARE ";
                case "425": return "FIREPLACE & ACCESS       ";
                case "426": return "FLOOR COVERINGS          ";
                case "427": return "HARDWARE/DO-IT-YOURSELF  ";
                case "428": return "HOME FURNISHINGS/ACCSR   ";
                case "429": return "HOME SUPP WAREHSE STORES ";
                case "430": return "HOUSEWARES/CUTLERY       ";
                case "431": return "LAMP & LIGHTING          ";
                case "432": return "SEWING MACHINES          ";
                case "433": return "STEREO/SOUND EQUIPMNT    ";
                case "434": return "TELEVISION/VCR           ";
                case "435": return "BICYCLES/MOPEDS          ";
                case "436": return "ARTS & CRAFTS            ";
                case "437": return "BOOK STORES              ";
                case "438": return "STAMP AND COIN STORES    ";
                case "439": return "HANDICRAFTS              ";
                case "440": return "FABRICS & YARNS          ";
                case "441": return "GARDEN SUPPLIES          ";
                case "442": return "MUSICAL INSTR/SHEET/RETLD";
                case "443": return "SPORTING GOODS           ";
                case "444": return "CAMPING EQUIPMENT        ";
                case "445": return "TOY, HOBBY & GAMES STORES";
                case "446": return "SHOES - CHILDREN ONLY    ";
                case "447": return "SHOE STORES              ";
                case "448": return "SHOES - MEN ONLY         ";
                case "449": return "SHOES - MEN/WOMEN        ";
                case "450": return "SHOES - WOMEN ONLY       ";
                case "451": return "AIRCRAFT - PILOT SUPPLY  ";
                case "452": return "AUDIO VISUAL             ";
                case "453": return "ART DEALERS              ";
                case "454": return "ART SUPPLIES             ";
                case "455": return "CHARITY SHOPS            ";
                case "456": return "SHOPS-COSMETICS/PERFUMES ";
                case "457": return "SHOPS-CHEMISTS/PHRMSTS   ";
                case "458": return "FLORISTS                 ";
                case "459": return "FRAMING                  ";
                case "460": return "GIFTS/CARDS/STATIONARY   ";
                case "461": return "HANDBAGS                 ";
                case "462": return "HARDWARE EQUIP & SUPPLIES";
                case "463": return "JEWELLERY/WATCHES/SILVER ";
                case "464": return "LEATHER GOODS/LUGGAGE    ";
                case "465": return "SHOPS-LIQUOR STORES      ";
                case "466": return "MARINE PRODUCTS          ";
                case "467": return "OFFICE EQUIP/SUPP/CALCUL ";
                case "468": return "STATIONERY               ";
                case "469": return "TELEPHONE EQUIP SALES    ";
                case "470": return "SHOPS-CONFECT/TOBC/NEWS  ";
                case "471": return "PARTY SUPPLIES           ";
                case "472": return "AQUARIUM SUPPLIES        ";
                case "473": return "PHOTOGRAPHIC EQUIP/SUPPLY";
                case "474": return "ARTS - HANDICRAFTS       ";
                case "475": return "PLANTS & NURSERIES       ";
                case "476": return "AUCTION HOUSES           ";
                case "477": return "DEPARTMENT STORE         ";
                case "478": return "DIRECT MARKETING- CATALOG";
                case "479": return "RECORD STORES            ";
                case "480": return "BARBEQUES                ";
                case "481": return "DISPOSAL STORES          ";
                case "482": return "GEM MERCHANTS            ";
                case "483": return "INDUSTRIAL CLOTHING/UNF  ";
                case "484": return "SAILBOARDS               ";
                case "485": return "SHOPS-WINERIES           ";
                case "486": return "SHOPS-WINE MERCHANTS     ";
                case "487": return "CANE WARE                ";
                case "488": return "COMPUTER EQUIP/SOFTWARE  ";
                case "489": return "BOUTIQUES - MEN          ";
                case "490": return "WOMENS ACC & SPEC STORES ";
                case "491": return "BOUTIQUES - CHILDREN     ";
                case "492": return "BOUTIQUES - WEDDING RELAT";
                case "493": return "GUNSHOP                  ";
                case "494": return "VIDEO RENTAL STORES      ";
                case "495": return "WOOD PRODUCTS            ";
                case "496": return "TELECOMMUNICATIONS EQUIP ";
                case "497": return "OPTICAL                  ";
                case "498": return "LUMBER/BUILDING STORES   ";
                case "499": return "OTH MISC RETAIL SHOPS    ";
                case "500": return "OPTICIAN                 ";
                case "501": return "TAILOR WOMEN             ";
                case "502": return "DUTY FREE                ";
                case "503": return "TAILOR MEN               ";
                case "504": return "ELECTRONIC GOODS         ";
                case "505": return "SWIMMING POOLS/EQUIP/SUPP";
                case "506": return "PET SHOPS / PET CARE     ";
                case "507": return "MILLINERS HATS           ";
                case "508": return "SHOPS-CHOCOLATIER        ";
                case "509": return "BEDROOM FURNITURE        ";
                case "510": return "TV/VCR/AUDIO RENTAL      ";
                case "511": return "SHOPS-BUTCHER            ";
                case "512": return "SHOPS-SPICES             ";
                case "513": return "BATHROOM FURNITURE       ";
                case "514": return "SHOPS-ICE CREAM SHP/PRLR ";
                case "515": return "WATCH JEWELLERY          ";
                case "516": return "BAKERIES                 ";
                case "517": return "SHOPS-FISH MARKET        ";
                case "518": return "SHOPS-SUPERMARKET        ";
                case "519": return "SHOPS-DELICATESSEN       ";
                case "520": return "SHOPS-HEALTH PRODUCTS    ";
                case "521": return "SHOPS-FREEZER CENTRE     ";
                case "522": return "FURNITURE STORES         ";
                case "523": return "SPECIALITY               ";
                case "524": return "SOUVENIRS                ";
                case "525": return "ELCTR EQUIPMNT RNTL      ";
                case "526": return "KITCHEN FURNITURE        ";
                case "527": return "SHOPS - HYPERMARKET      ";
                case "528": return "ETHNIC SHOPS             ";
                case "529": return "BOOKS                    ";
                case "530": return "PHOTOGRAPHIC EQUIP/SUPP  ";
                case "531": return "MAJOR APPLIANCES - GAS   ";
                case "532": return "MAJOR APPLIANCES - ELECT ";
                case "533": return "SHOPS - GROCERS          ";
                case "534": return "COSTUME JEWELLERY        ";
                case "535": return "SKI EQUIPMENT HIRE       ";
                case "536": return "CLEANING MATERIALS       ";
                case "537": return "CLOTHING - BABY WEAR     ";
                case "538": return "CLOTHING - LINGERIE      ";
                case "539": return "DEPART STORE - MAIL ORDER";
                case "540": return "PHONE RENTAL             ";
                case "541": return "CLOTHES RENTAL           ";
                case "542": return "BICYCLE RENTAL           ";
                case "543": return "HOUSE RENTAL             ";
                case "544": return "OTHER RENTAL             ";
                case "545": return "FLORIST                  ";
                case "546": return "SUPERMARKET/GENERAL GOODS";
                case "547": return "CLOTHING - KIMONO        ";
                case "548": return "GOLF SHOP                ";
                case "549": return "SHOES - OTHER            ";
                case "550": return "READY TO WEAR APPAREL    ";
                case "551": return "ART/SCULPTURE/GRAPHICS   ";
                case "552": return "ASSRTD MERCHANDISE GIFTS ";
                case "553": return "AUTO ARTS & ACCESSORIES  ";
                case "554": return "SELF IMPROV/ BUS SEMINAR ";
                case "555": return "ELECTRONIC GOODS         ";
                case "556": return "FOOD AND GOURMET ITEMS   ";
                case "557": return "HOME FURN/ACCESS/COOKING ";
                case "558": return "CRAFTS / HOBBIES         ";
                case "559": return "JEWELLERY                ";
                case "560": return "OFFICE SUPPLIES / EQUIP  ";
                case "561": return "DIRECT MARKTNG-SUBSCRPTN ";
                case "562": return "SPORTING APPAREL & EQUIP ";
                case "563": return "COLLECTABLES             ";
                case "564": return "TOYS                     ";
                case "565": return "HORTICULTURE             ";
                case "566": return "RECORD/VIDEO CLUBS       ";
                case "567": return "CHARITY MAIL ORDER       ";
                case "568": return "GOLF COURSE MEMBERSHIP   ";
                case "569": return "RYOKAN RESORT            ";
                case "570": return "WOMEN'S CLOTHING         ";
                case "571": return "MEN'S CLOTHING           ";
                case "572": return "CHILDREN'S CLOTHING      ";
                case "573": return "FAMILY CLOTHING          ";
                case "574": return "HANDBAGS & LUGGAGE       ";
                case "575": return "CHEMISTS/PHARMACISTS     ";
                case "576": return "HEALTH PRODUCTS          ";
                case "577": return "SHOES                    ";
                case "578": return "DO-IT-YOURSELF           ";
                case "579": return "ANTIQUES                 ";
                case "580": return "INSURANCE PREMIUMS       ";
                case "581": return "UNATTENDED RAIL TICKETS  ";
                case "582": return "REST JAPANESE MEAT DISH  ";
                case "583": return "DRIVING RANGE            ";
                case "584": return "RETAIL MILITARY          ";
                case "585": return "IN-FLIGHT DUTY FREE      ";
                case "586": return "CRUISE DUTY FREE         ";
                case "587": return "GINSENG/CHINESE MEDICINE ";
                case "588": return "BILLIARD & POOL EST      ";
                case "589": return "FIRE EXTINGUISHERS       ";
                case "590": return "LOTTERY                  ";
                case "591": return "LOTTERY                  ";
                case "592": return "FUNERAL DIRECTORS        ";
                case "593": return "CLUBS - FISHING          ";
                case "594": return "FISHING FEES             ";
                case "595": return "BESPOKE TAILORS          ";
                case "596": return "PLANT HIRE               ";
                case "597": return "FISHING EQUIPMENT        ";
                case "598": return "PACKAGING                ";
                case "599": return "ALL OTHER MAIL ORDER     ";
                case "600": return "MISC AUTO/AIR/FARM EQIUP ";
                case "601": return "AUCTION HOUSE OPERATORS  ";
                case "602": return "BARBER SHOPS             ";
                case "603": return "BEAUTY/BARBER SHOPS      ";
                case "604": return "CATERING EQUIPMENT       ";
                case "605": return "CONSULTANT BUSINESS      ";
                case "606": return "DRIVING SCHOOLS          ";
                case "607": return "SAUNA                    ";
                case "608": return "EXHIBIT SERVICES         ";
                case "609": return "INTERIOR DECORATORS      ";
                case "610": return "MAIL ORDER               ";
                case "611": return "NON-PROFIT ASSOCIATIONS  ";
                case "612": return "TELEPHONE SVC/PAGING/ANSW";
                case "613": return "PROFESSIONAL SERVICES    ";
                case "614": return "INFO. SERVICES/VIDEOTEXT ";
                case "615": return "LONG DIST PHONE/CARDRDR  ";
                case "616": return "CABLE & OTHER PAY TV SVCS";
                case "617": return "TELECOM SERVICES         ";
                case "618": return "INSURANCE OTHER          ";
                case "619": return "HELICOPTER SCHOOL        ";
                case "620": return "AIRCRAFT SCHOOL          ";
                case "621": return "DETECTIVE/SECURITY SVS   ";
                case "622": return "DRESSMAKER               ";
                case "623": return "DATING/ESCORT SERVICES   ";
                case "624": return "INTRODUCTION SERVICE     ";
                case "625": return "MASSAGE PARLOUR          ";
                case "626": return "HERALDRY                 ";
                case "627": return "PEST CONTRL              ";
                case "628": return "CAR PARKING - LONG TERM  ";
                case "629": return "ZOO/SANCTUARY/ANIMAL PARK";
                case "630": return "HELICOPTER SALES & SVC   ";
                case "631": return "LAUNDRY/GARMENT SERVICES ";
                case "632": return "SIGN MAKER               ";
                case "633": return "USED MERCHANDIZE         ";
                case "634": return "COMMUNICATIONS/UTILITIES ";
                case "635": return "BANK - EMERGENCY CHQ CASH";
                case "636": return "COMPUTER PROGRAMMING     ";
                case "637": return "HAIRDRESSERS             ";
                case "638": return "NON-ENROLLED TELECOMM SVC";
                case "639": return "CAR PARKING - SHORT TERM ";
                case "640": return "AGRICULTURAL COOPERATIVES";
                case "641": return "EDUCATION/TRAINING       ";
                case "642": return "EQUIPMENT LEASING        ";
                case "643": return "OTHER BUSINESS SUPPORT   ";
                case "644": return "FOOD SERVICE             ";
                case "645": return "FACILITIES/GROUNDS MAINT ";
                case "646": return "EQUPIMENT REPAIR         ";
                case "647": return "FLEET MAINT/REPAIR       ";
                case "648": return "COURIER/EXPRESS DELIVERY ";
                case "649": return "COURIER SVCS - AIR & GRND";
                case "650": return "FLEET/TRUCK LEASING      ";
                case "651": return "TEMP HELP/PLACEMENT      ";
                case "652": return "PRINTING/REPRODUCTION    ";
                case "653": return "LABORATORY               ";
                case "654": return "DATA PROCESSING          ";
                case "655": return "GRAPHIC DESIGN/ADVERTISE ";
                case "656": return "MEDICAL                  ";
                case "657": return "OTHER PROFESSIONAL SERVIC";
                case "658": return "COMPUTER STORE           ";
                case "659": return "COMPUTER SOFTWARE        ";
                case "660": return "INDUSTRIAL EQUIP & SUPP  ";
                case "661": return "ELECTRONIC EQUIP & SUPP  ";
                case "662": return "PLUMBING/HVAC            ";
                case "663": return "ELECTRONIC PARTS/EQUIP   ";
                case "664": return "CONSTRUCTION PRODUCTS/EQP";
                case "665": return "OTHER INDUSTRIAL PRODUCTS";
                case "666": return "OFFICE SUPPLIES          ";
                case "667": return "OFFICE & COMM FURNITURE  ";
                case "668": return "OFFICE EQIUP/MACHINES    ";
                case "669": return "PUBLICATIONS/PERIODICALS ";
                case "670": return "HARDWARE/SOFTWARE SERVICE";
                case "671": return "MEDICAL EQUIPMENT        ";
                case "672": return "MEDICAL SUPPLIES         ";
                case "673": return "LAB EQUIPMENT/INSTRUMENTS";
                case "674": return "INTERNET AGGREGATORS     ";
                case "675": return "INTERNET ADULT ELECTRONIC";
                case "676": return "INTERNET DRUG STORES     ";
                case "677": return "INTERNET P2P CONS PMT    ";
                case "678": return "JANITORIAL SERVICES      ";
                case "679": return "SHOE REPAIR/SHINE        ";
                case "680": return "COMPUTER HARDWARE        ";
                case "681": return "COMPUTER SOFTWARE        ";
                case "682": return "COMMERICAL EQUIPMENT     ";
                case "683": return "OFFICE FURNITURE         ";
                case "684": return "OFFICE EQUIPMENT/MACHINE ";
                case "685": return "NEWSPAPERS/PERIODICALS   ";
                case "686": return "DIRECT MKTG OUTBOUND     ";
                case "687": return "HOME REPAIR SERVICE      ";
                case "688": return "DUPLICATING SERVICES     ";
                case "689": return "CONSUMER CREDIT REPORTING";
                case "690": return "CUSTOM MACHINERY SERVICES";
                case "691": return "REPAIR SERVICES          ";
                case "692": return "HERBALIST                ";
                case "693": return "RAIL/AIR/LAND/SEA CARGO  ";
                case "694": return "OVERNIGHT/EXPRESS DELIVER";
                case "695": return "COUNSELING SERVICES      ";
                case "696": return "VARIETY STORE            ";
                case "697": return "CUSTOMS DUTIES           ";
                case "698": return "RECORDING SERVICES       ";
                case "699": return "OTHER SERVICE INDUSTRIES ";
                case "700": return "AQUARIUMS                ";
                case "701": return "ARTS & CRAFTS            ";
                case "702": return "ART GALLERIES            ";
                case "703": return "ART HANDICRAFT           ";
                case "704": return "MARTIAL ARTS             ";
                case "705": return "ART SCULPTURES           ";
                case "706": return "CLUBS - ATHLETIC ASSOC   ";
                case "707": return "AUTOMOBILE ASSOC         ";
                case "708": return "CLUBS - BEACH            ";
                case "709": return "MEMBERSHIP CLUBS         ";
                case "710": return "CLUBS - DINING           ";
                case "711": return "CIVIC & SOCIAL ASSOC     ";
                case "712": return "CLUBS - GOLF COURSE      ";
                case "713": return "MEMBERSHIP ORGS          ";
                case "714": return "CLUBS - TENNIS           ";
                case "715": return "CLUBS - RACQUET          ";
                case "716": return "CLUBS - TRAVEL           ";
                case "717": return "CLUBS - YACHT            ";
                case "718": return "OTHER MISCELLANEOUS S/ES ";
                case "719": return "CEMETARY                 ";
                case "720": return "CLUBS - SQUASH           ";
                case "721": return "FUNICULAR RIDES/LIFTS    ";
                case "722": return "CLUBS - HEALTH SPAS      ";
                case "723": return "MARINAS, SVCS & SUPP     ";
                case "724": return "MARINE ATTRACTIONS       ";
                case "725": return "MARINE INSTRUCTION       ";
                case "726": return "BOAT RENTALS AND LEASING ";
                case "727": return "TOURIST ATTRACTIONS      ";
                case "728": return "SERVICE STATIONS         ";
                case "729": return "OIL & GAS STATIONS - IND ";
                case "730": return "AIR FIELD FUEL           ";
                case "731": return "TYRE AND EXHAUST CENTRES ";
                case "732": return "PARKS - THEME            ";
                case "733": return "PARKS - TRAVEL           ";
                case "734": return "ATHLETIC SKILLS          ";
                case "735": return "SECRETARIAL SERVICES     ";
                case "736": return "RIDING SCHOOLS           ";
                case "737": return "PARKS - AMUSEMENT        ";
                case "738": return "MARINA FUEL              ";
                case "739": return "PARKS - HISTORICAL       ";
                case "740": return "DINNER SHOWS             ";
                case "741": return "THEATRE-COMMERCIAL/NONPRF";
                case "742": return "ORCHESTRAS               ";
                case "743": return "OPERA COMPANIES          ";
                case "744": return "DANCE COMPANIES          ";
                case "745": return "ART EVENTS/FESTIVALS     ";
                case "746": return "OTHER ENTERTAINMENT ORGS ";
                case "747": return "GYMNASIUM                ";
                case "748": return "CHARITY SERVICES         ";
                case "749": return "PETROLEUM PRODUCTS       ";
                case "750": return "RIDING STABLES           ";
                case "751": return "THEATRE/SPORTS TKT AGCY  ";
                case "752": return "TOWING SERVICES          ";
                case "753": return "ARENAS / STADIUM         ";
                case "754": return "AUDITORIUM/PERF ARTS CNTR";
                case "755": return "COL/UNIV PER. ART BOX OF ";
                case "756": return "CINEMAS                  ";
                case "757": return "TICKET AGENTS - COMPUTER ";
                case "758": return "TICKET AGENTS - INDEPEND ";
                case "759": return "INTER-COLLEGIATE SPORTS  ";
                case "760": return "PROFESSIONAL LEAGUE/TEAMS";
                case "761": return "PROFESSIONAL TOURS EVENTS";
                case "762": return "AMATEUR NON-PROFT EVNTS  ";
                case "763": return "PRIVATE CLUB MEMBERSHIP  ";
                case "764": return "CONTINUING ED.-COL/UNIV  ";
                case "765": return "EDUCATIONAL SERVICES     ";
                case "766": return "LEARNING CTR/SKILL INSTIT";
                case "767": return "LANGUAGE SCHOOLS         ";
                case "768": return "TOUR OP - ACTIVITY       ";
                case "769": return "DANCING SCHOOLS          ";
                case "770": return "BUSINESS/PROFESS.SEMINAR ";
                case "771": return "UNIVERISTY/COLLEGE       ";
                case "772": return "UNIV/COLLEGE - PRIVATE   ";
                case "773": return "JUNIOR/COMMUNITY COLLEGE ";
                case "774": return "TRAVEL AGENTS - AMEX REP ";
                case "775": return "SCHOOLS - PRIM/SEC       ";
                case "776": return "NURSERIES/DAY CARE       ";
                case "777": return "TOUR OP - SHORT HAUL     ";
                case "778": return "TOUR OP - SIGHTSEEING    ";
                case "779": return "STEAMSHIP/CRUISE LINES   ";
                case "780": return "TRAVEL AGENTS - RETAIL   ";
                case "781": return "TOUR OP - SKIING         ";
                case "782": return "TRAVEL AGENCIES & TOUR OP";
                case "783": return "TOUR OP - LONG HAUL      ";
                case "784": return "TRAVEL STORES            ";
                case "785": return "SIGN & TRAVEL            ";
                case "786": return "CRUISE LINE SHOPS        ";
                case "787": return "TRAVEL RELATED SERVICES  ";
                case "788": return "TRAVEL AGENT AMEX MAIL   ";
                case "789": return "OTHER TRAVEL             ";
                case "790": return "AMEX PUBLISHING-DISC BUS ";
                case "791": return "AMEX MERCHANDISE DISC BUS";
                case "792": return "FERRIES                  ";
                case "793": return "TOUR OP - GENERAL        ";
                case "794": return "GENERAL SPORTING EVENTS  ";
                case "795": return "FAMILY ENTERTAINMENT     ";
                case "796": return "TSO FOREIGN EXCH SVCS    ";
                case "797": return "FLAMENCO SHOW            ";
                case "798": return "TOUR OP - HOT AIR BALLOON";
                case "799": return "TRAVEL DEVELOPMENT       ";
                case "800": return "CORPORATE CASHIERS       ";
                case "801": return "AMEX LIFE ASSURANCE      ";
                case "802": return "AMERICAN CENTURION LIFE  ";
                case "803": return "FIREMANS FUND LIFE       ";
                case "804": return "NON-AMEX INSURANCE       ";
                case "805": return "TAX AUDIT PROTECTION     ";
                case "806": return "OTHER FINANCIAL          ";
                case "807": return "EXPRESS PHONE            ";
                case "808": return "STAMP COLLECTING         ";
                case "809": return "SKI SCHOOL               ";
                case "810": return "AIRPLANE TELEPHONES      ";
                case "811": return "STAFF SAVINGS            ";
                case "812": return "GOLD CARD SERVICES       ";
                case "813": return "DIVISION SALES PROGRAMS  ";
                case "814": return "CARD SERVICES            ";
                case "815": return "PROOF UNIT SOC'S         ";
                case "816": return "CAMPUS BOOKSTORES        ";
                case "817": return "TAX DEDUCTIBLE           ";
                case "818": return "NON-TAX DEDUCTIBLE       ";
                case "819": return "BEEPER                   ";
                case "820": return "GENERAL ACCIDENT INSURAN ";
                case "821": return "GENERAL TRAVEL INSURANCE ";
                case "822": return "GENERAL HOME INSURANCE   ";
                case "823": return "GENERAL HEALTH INSURANCE ";
                case "824": return "GENERAL AUTO INSURANCE   ";
                case "825": return "GENERAL OTHER INSURANCE  ";
                case "826": return "LIFE INS - LIFE PROTECT  ";
                case "827": return "LIFE INS - LIFE SAVINGS  ";
                case "828": return "LIFE INS - LIFE INVESTMNT";
                case "829": return "LIFE INS - OTHER INSURANC";
                case "830": return "FINANCIAL FRAMEWORK      ";
                case "831": return "INSURANCE                ";
                case "832": return "TRAVEL                   ";
                case "833": return "MEDICAL                  ";
                case "834": return "INFORMATION              ";
                case "835": return "COMMUNICATION            ";
                case "836": return "IDENTIFICATION           ";
                case "837": return "LEISURE ACTIVITY         ";
                case "838": return "ASSOCIATE CLUB           ";
                case "839": return "CENTURION CLUB           ";
                case "840": return "CREDIT CARD REGISTRY     ";
                case "841": return "DRIVER SECURITY          ";
                case "842": return "EMPRESS CLUB             ";
                case "843": return "FEE SERVICES             ";
                case "844": return "GLOBAL ASSIST            ";
                case "845": return "GOLD CARD EVENTS         ";
                case "846": return "RACECOURSES              ";
                case "847": return "WHSL PLUMB/HEAT/REF HVAC ";
                case "848": return "WHSL COMP SOFTWR/HARDWR  ";
                case "849": return "WHSL OFC SUPP/EQUIP      ";
                case "850": return "MAGAZINES                ";
                case "851": return "ELECTRONICS              ";
                case "852": return "JEWELLERY                ";
                case "853": return "CLOTHING                 ";
                case "854": return "HOUSEWARES               ";
                case "855": return "STRATEGIUM               ";
                case "856": return "WINE/SPIRITS             ";
                case "857": return "STRATEGIUM & CONTRACT    ";
                case "858": return "LUGGAGE TAGS             ";
                case "859": return "OTHER BRANDED MERCHANDISE";
                case "860": return "MAGAZINES                ";
                case "861": return "ELECTRONICS              ";
                case "862": return "JEWELLERY                ";
                case "863": return "CLOTHING                 ";
                case "864": return "HOUSEWARES               ";
                case "865": return "LEGAL SERVICES           ";
                case "866": return "WINE/SPIRITS             ";
                case "867": return "SKY GUIDE                ";
                case "868": return "EXTERNAL SALES AGENT     ";
                case "869": return "OTHER THIRD PARTY MERCHAN";
                case "870": return "CAR WASHES               ";
                case "871": return "OTHER CONTRACT SERVICES  ";
                case "872": return "TIMESHARE                ";
                case "873": return "OPTOMETRIST              ";
                case "874": return "CONSUMER ELECTRONICS     ";
                case "875": return "GYNECOLOGIST             ";
                case "876": return "PRIVILEGED ASSETS        ";
                case "877": return "AIR FLIGHT INSURANCE     ";
                case "878": return "MONEY ORDER DIVISION     ";
                case "879": return "CORPORATE TRAVEL CHEQUES ";
                case "880": return "CASH ADVANCE DRAFTS      ";
                case "881": return "CORPORATE PURCHASE DRAFTS";
                case "882": return "CORPORATE EXPRESS CASH   ";
                case "883": return "COUNTER CHEQUES          ";
                case "884": return "LOAN ACTIVATORS          ";
                case "885": return "SIGHT DRAFTS             ";
                case "886": return "WIRE TRANSFERS           ";
                case "887": return "PLATINUM CARD EVENTS     ";
                case "888": return "MOTOR VECHICLE SUPPLIES  ";
                case "889": return "WHSL FOOD/AGRCL PROD     ";
                case "890": return "WHSL HOME FURN/PRODS     ";
                case "891": return "WHSL RAW MATERIALS       ";
                case "892": return "CONSTRUCTION MATERIALS   ";
                case "893": return "WHSL COMM/INDSTRL S/S    ";
                case "894": return "WHSL COMM/INDSTRL EQ     ";
                case "895": return "WHSL DRBL CONSMR GDS     ";
                case "896": return "WHSL NONDRBL CONSMR GD   ";
                case "897": return "OTHER S/E # USERS        ";
                case "898": return "OTHER S/E # USERS        ";
                case "899": return "OTHER S/E # USERS        ";
                case "900": return "ADVERTISING              ";
                case "901": return "AMBULANCE SERVICES       ";
                case "902": return "ATTORNEYS/LAWYERS        ";
                case "903": return "CHIROPRACTORS            ";
                case "904": return "PHYSIOTHERAPISTS         ";
                case "905": return "MEDICAL CONSULTANT       ";
                case "906": return "FUEL/DEALER/COAL         ";
                case "907": return "DENTISTS                 ";
                case "908": return "VETERINARY SERVICES      ";
                case "909": return "DOMESTIC SERVICES        ";
                case "910": return "DRY CLEANERS             ";
                case "911": return "EMPLOYMENT AGENCIES      ";
                case "912": return "FINANCIAL SERVICES       ";
                case "913": return "FUNERAL SERVICES         ";
                case "914": return "GENEALOGY                ";
                case "915": return "HOSPITALS                ";
                case "916": return "MEDICAL SUPPLY/EQUIP     ";
                case "917": return "DOG GROOMING/BOARDING    ";
                case "918": return "LOCKSMITHS               ";
                case "919": return "CLINICS                  ";
                case "920": return "FREIGHT CARRIER & TRUCKNG";
                case "921": return "OPTHALMOLOGISTS          ";
                case "922": return "PHOTO FINISHING          ";
                case "923": return "PHOTOGRAPHIC STUDIOS     ";
                case "924": return "PHYSICIANS               ";
                case "925": return "LANDSCP & HORTICULTRL SVS";
                case "926": return "HEATING/PLUMBING/AC      ";
                case "927": return "BUILDER                  ";
                case "928": return "PSYCHOLOGIST/PSYCHIATRIST";
                case "929": return "ELECTRICAL CONTRACTOR    ";
                case "930": return "REAL ESTATE              ";
                case "931": return "RENT - ALL               ";
                case "932": return "SECURITY SYSTEMS         ";
                case "933": return "MISC REPAIR SHOP         ";
                case "934": return "CENTRAL HEATING          ";
                case "935": return "ARCHITECT & ENGINEER     ";
                case "936": return "SURVEYOR                 ";
                case "937": return "INSURANCE BROKERS        ";
                case "938": return "INSURANCE AGENTS         ";
                case "939": return "ACCOUNTANTS              ";
                case "940": return "GROUP PRACTICE           ";
                case "941": return "VETERINARY HOSPITALS     ";
                case "942": return "LICENSED SPECIALISTS     ";
                case "943": return "NURSING/PERSONAL CARE    ";
                case "944": return "MEDICAL LABS             ";
                case "945": return "HOME FOR THE ELDERLY     ";
                case "946": return "HOMEOPATHY               ";
                case "947": return "ACUPUNCTURE              ";
                case "948": return "CHIROPODIST/PODIATRIST   ";
                case "949": return "RELIGIOUS GOODS STORES   ";
                case "950": return "FREE STANDING DISPLAY    ";
                case "951": return "TICKETMATE               ";
                case "952": return "RAILWAY STATION          ";
                case "953": return "TRAVEL CONSULATE         ";
                case "954": return "SOLICITOR                ";
                case "955": return "TAX AGENT                ";
                case "956": return "CLUBS - HIST RESTOR SOC  ";
                case "957": return "GRADUATE CONTRACTOR      ";
                case "958": return "INTERNET SERVICES        ";
                case "959": return "CLUBS - FITNESS CENTRE   ";
                case "960": return "ELECTRONIC EQUIP REPAIR  ";
                case "961": return "POSTER SITES             ";
                case "962": return "CLASSIFIED ADVERTISING   ";
                case "963": return "FINES /DUTIES            ";
                case "964": return "HAIRDRESSERS SUPPLIES    ";
                case "965": return "PRINTING/PUBLISHING      ";
                case "966": return "PAINTER/DECORATOR        ";
                case "967": return "MISCELLANEOUS MED SERV   ";
                case "968": return "DOUBLE GLAZING/WINDOWS   ";
                case "969": return "TAILORS & SEAMSTRESSES   ";
                case "970": return "TRADE ASSOCIATION        ";
                case "971": return "COURIER SERVICE          ";
                case "972": return "MESSAGE SVC/ELECTR MAIL  ";
                case "973": return "PARCEL DELIVERY          ";
                case "974": return "DRAINAGE CONSULTANTS     ";
                case "975": return "POSTAL SERVICES          ";
                case "976": return "INTERNET - ELEC DELIVERY ";
                case "977": return "STATIC LINE              ";
                case "978": return "AIRPLANE INTERACTIVE TV  ";
                case "979": return "INTERACTIVE TV           ";
                case "980": return "HOSPITAL - PRIVATE       ";
                case "981": return "NATUROPATH               ";
                case "982": return "THERAPEUTIC MASSAGE      ";
                case "983": return "EMERGENCY MEDICAL CENTRE ";
                case "984": return "CALLING CARDS            ";
                case "985": return "TELECOMM SERVICE         ";
                case "986": return "DIRECT MARKETING-INTERNET";
                case "987": return "CPC INTERNET PRODUCTS    ";
                case "988": return "CPC INTERNET SERVICES    ";
                case "989": return "BAIL BONDSMAN            ";
                case "990": return "OTHER COMMUNICATIONS     ";
                case "991": return "INTERNET SVCS PROVIDER   ";
                case "992": return "BETTING & GAMING SVS     ";
                case "993": return "WHSL CNSMR ELEC/APPL     ";
                case "994": return "ELECTRICAL PARTS & EQUIP ";
                case "995": return "WAREHOUSE CLUBS          ";
                case "996": return "WAREHOUSE CLUBS-GAS      ";
                case "997": return "SHOPPING MALLS           ";
                case "998": return "INTERNET MASTER MERCHANT ";
                case "999": return "MULTIPLE INDUSTRY PARENT ";
            }
            return "";
        }
    }

    public static class TransactionType
    {

        public static string Find(string tt)
        {

            switch (tt)
            {
                case "01":
                    return "ADJUSTMENT";
                case "02":
                    return "REMITTANCE ATTENTION";
                case "03":
                    return "REMITTANCE REGULAR";
                case "04":
                    return "LIFE INSURANCE PREMIUM";
                case "05":
                    return "RETURNED CHECK";
                case "06":
                    return "ANNUAL FEE";
                case "07":
                    return "DEFERRED";
                case "08":
                    return "REGULAR CHARGES";
                case "09":
                    return "FEE REVERSAL";
                case "10":
                    return "CHARGE WRITE-OFF";
                case "11":
                    return "DELINQUENCY CHARGE ADJUSTMENT";
                case "12":
                    return "DELINQUENCY CHARGE";
                case "13":
                    return "AIR INSURANCE CHARGE";
                case "14":
                    return "OPEN BALANCE CORRECTION";
            }

            return "";
        }
    }

    public static class CurrencyType
    {
        public static string Find(string tt)
        {

            switch (tt)
            {
                case "971": return "AFN";
                case "008": return "ALL";
                case "012": return "DZD";
                case "840": return "USD";
                case "978": return "EUR";
                case "973": return "AOA";
                case "951": return "XCD";
                case "032": return "ARS";
                case "051": return "AMD";
                case "533": return "AWG";
                case "036": return "AUD";
                case "944": return "AZN";
                case "044": return "BSD";
                case "048": return "BHD";
                case "050": return "BDT";
                case "052": return "BBD";
                case "974": return "BYR";
                case "084": return "BZD";
                case "952": return "XOF";
                case "060": return "BMD";
                case "064": return "BTN";
                case "356": return "INR";
                case "068": return "BOB";
                case "984": return "BOV";
                case "977": return "BAM";
                case "072": return "BWP";
                case "578": return "NOK";
                case "986": return "BRL";
                case "096": return "BND";
                case "975": return "BGN";
                case "108": return "BIF";
                case "132": return "CVE";
                case "116": return "KHR";
                case "950": return "XAF";
                case "124": return "CAD";
                case "136": return "KYD";
                case "990": return "CLF";
                case "152": return "CLP";
                case "156": return "CNY";
                case "170": return "COP";
                case "970": return "COU";
                case "174": return "KMF";
                case "976": return "CDF";
                case "554": return "NZD";
                case "188": return "CRC";
                case "191": return "HRK";
                case "931": return "CUC";
                case "192": return "CUP";
                case "532": return "ANG";
                case "203": return "CZK";
                case "208": return "DKK";
                case "262": return "DJF";
                case "214": return "DOP";
                case "818": return "EGP";
                case "222": return "SVC";
                case "232": return "ERN";
                case "230": return "ETB";
                case "238": return "FKP";
                case "242": return "FJD";
                case "953": return "XPF";
                case "270": return "GMD";
                case "981": return "GEL";
                case "936": return "GHS";
                case "292": return "GIP";
                case "320": return "GTQ";
                case "826": return "GBP";
                case "324": return "GNF";
                case "328": return "GYD";
                case "332": return "HTG";
                case "340": return "HNL";
                case "344": return "HKD";
                case "348": return "HUF";
                case "352": return "ISK";
                case "360": return "IDR";
                case "960": return "XDR";
                case "364": return "IRR";
                case "368": return "IQD";
                case "376": return "ILS";
                case "388": return "JMD";
                case "392": return "JPY";
                case "400": return "JOD";
                case "398": return "KZT";
                case "404": return "KES";
                case "408": return "KPW";
                case "410": return "KRW";
                case "414": return "KWD";
                case "417": return "KGS";
                case "418": return "LAK";
                case "422": return "LBP";
                case "426": return "LSL";
                case "710": return "ZAR";
                case "430": return "LRD";
                case "434": return "LYD";
                case "756": return "CHF";
                case "446": return "MOP";
                case "807": return "MKD";
                case "969": return "MGA";
                case "454": return "MWK";
                case "458": return "MYR";
                case "462": return "MVR";
                case "478": return "MRO";
                case "480": return "MUR";
                case "965": return "XUA";
                case "484": return "MXN";
                case "979": return "MXV";
                case "498": return "MDL";
                case "496": return "MNT";
                case "504": return "MAD";
                case "943": return "MZN";
                case "104": return "MMK";
                case "516": return "NAD";
                case "524": return "NPR";
                case "558": return "NIO";
                case "566": return "NGN";
                case "512": return "OMR";
                case "586": return "PKR";

                case "590": return "PAB";
                case "598": return "PGK";
                case "600": return "PYG";
                case "604": return "PEN";
                case "608": return "PHP";
                case "985": return "PLN";
                case "634": return "QAR";
                case "946": return "RON";
                case "643": return "RUB";
                case "646": return "RWF";
                case "654": return "SHP";
                case "882": return "WST";
                case "678": return "STD";
                case "682": return "SAR";
                case "941": return "RSD";
                case "690": return "SCR";
                case "694": return "SLL";
                case "702": return "SGD";
                case "994": return "XSU";
                case "090": return "SBD";
                case "706": return "SOS";
                case "728": return "SSP";
                case "144": return "LKR";
                case "938": return "SDG";
                case "968": return "SRD";
                case "748": return "SZL";
                case "752": return "SEK";
                case "947": return "CHE";
                case "948": return "CHW";
                case "760": return "SYP";
                case "901": return "TWD";
                case "972": return "TJS";
                case "834": return "TZS";
                case "764": return "THB";
                case "776": return "TOP";
                case "780": return "TTD";
                case "788": return "TND";
                case "949": return "TRY";
                case "934": return "TMT";
                case "800": return "UGX";
                case "980": return "UAH";
                case "784": return "AED";
                case "997": return "USN";
                case "940": return "UYI";
                case "858": return "UYU";
                case "860": return "UZS";
                case "548": return "VUV";
                case "937": return "VEF";
                case "704": return "VND";
                case "886": return "YER";
                case "967": return "ZMW";
                case "932": return "ZWL";
            }

            return "";
        }
    }

}
