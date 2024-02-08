/*
sp_helptext recupera_solicitud_reposicion_detalle
sp_helptext recupera_solicitud_gastos_detalle
sp_helptext guarda_solicitud_reposicion_detalle
sp_helptext guarda_solicitud_gastos_detalle
sp_helptext genera_poliza_contable_gastos
sp_helptext genera_poliza_contable_reposicion

*/



GO
alter table solicitud_gastos_detalle add retencion_resico decimal(18,2) not null default(0)
go
alter table solicitud_reposicion_detalle add retencion_resico decimal(18,2) not null default(0)
go

go

go


go

go

ALTER function [dbo].[fn_solicitud_gastos_total](@id_solicitud int)
returns decimal(18,2)
as
  begin
	declare @resultado decimal(18,2)

	select @resultado = convert(decimal(18,2),sum((subtotal + iva + otros_impuestos - retencion - retencion_resico + isNull(propina,0)) * tipo_cambio))
	from solicitud_gastos_detalle
	where id_solicitud = @id_solicitud

	return isNull(@resultado,0)	
  end



go

go

ALTER function [dbo].[fn_solicitud_reposicion_total](@id_solicitud int)
returns decimal(18,2)
as
  begin
	declare @resultado decimal(18,2)

	select @resultado = convert(decimal(18,2),sum((subtotal + iva + otros_impuestos - retencion - retencion_resico + isNull(propina,0)) * tipo_cambio))
	from solicitud_reposicion_detalle
	where id_solicitud = @id_solicitud

	return isNull(@resultado,0)	
  end





go

go

ALTER procedure dbo.recupera_solicitud_gastos_tabla_resumen
	@id_solicitud int
as


--declare @id_solicitud int = 23324

create table #tempTablaResumen
(
	id int,
	descripcion varchar(64),
	efectivo decimal(18,2) default(0),
	tc decimal(18,2) default(0),
	te decimal(18,2) default(0),
	cav decimal(18,2) default(0),
	pr decimal(18,2) default(0),
	subtotal decimal(18,2) default(0),
	iva decimal(18,2) default(0),
	total decimal(18,2) default(0)
)

insert into #tempTablaResumen (id, descripcion) values (1,'Anticipo')
insert into #tempTablaResumen (id, descripcion) values (2,'Total Gastos en MXN')
insert into #tempTablaResumen (id, descripcion) values (3,'Total Compra Material MXN')
insert into #tempTablaResumen (id, descripcion) values (4,'Saldo en Contra')
insert into #tempTablaResumen (id, descripcion) values (5,'Saldo a Favor')
insert into #tempTablaResumen (id, descripcion) values (6,'Total Gastos')


update #tempTablaResumen
set te = isNull((select monto_pesos + (monto_dolares*tipo_cambio_anticipo_usd) + (monto_euros*tipo_cambio_anticipo_eur) from solicitud_gastos where id_solicitud = @id_solicitud),0)
where id = 1

update #tempTablaResumen
set efectivo = isNull((select sum(total*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud and id_forma_pago=1),0),
	tc = isNull((select sum(total*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud and id_forma_pago=2),0),
	te = isNull((select sum(total*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud and id_forma_pago=3),0),
	cav = isNull((select sum(total*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud and id_forma_pago=8),0),
	pr = isNull((select sum(total*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud and id_forma_pago=7),0),
	iva = isNull((select sum(iva*tipo_cambio) from solicitud_gastos_detalle where id_solicitud = @id_solicitud),0)
where id = 2



declare @id_solicitud_reposicion int
select @id_solicitud_reposicion = id_solicitud_reposicion
from solicitud_gastos
where id_solicitud = @id_solicitud


update #tempTablaResumen
set efectivo = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion and id_forma_pago=1),0),
	tc = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion and id_forma_pago=2),0),
	te = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion and id_forma_pago=3),0),
	cav = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion and id_forma_pago=8),0),
	pr = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion and id_forma_pago=7),0),
	iva = isNull((select sum(iva*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud_reposicion),0)
where id = 3




update #tempTablaResumen
set efectivo = isNull((select sum(efectivo) from #tempTablaResumen where id=1),0) - isNull((select sum(efectivo) from #tempTablaResumen where id in (2,3)),0),
	tc = 0, --isNull((select sum(tc) from #tempTablaResumen where id=1),0) - isNull((select sum(tc) from #tempTablaResumen where id in (2,3)),0),
	te = isNull((select sum(te) from #tempTablaResumen where id=1),0) - isNull((select sum(te) from #tempTablaResumen where id in (2,3)),0),
	cav = isNull((select sum(cav) from #tempTablaResumen where id=1),0) - isNull((select sum(cav) from #tempTablaResumen where id in (2,3)),0),
	pr = isNull((select sum(pr) from #tempTablaResumen where id=1),0) - isNull((select sum(pr) from #tempTablaResumen where id in (2,3)),0)
where id = 4

--update #tempTablaResumen
--set total = efectivo + tc + te + cav + pr


update #tempTablaResumen
set efectivo = (case when isNull((select sum(efectivo) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(efectivo) from #tempTablaResumen where id=4),0)*-1 else 0 end),
	tc = 0, --(case when isNull((select sum(tc) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(tc) from #tempTablaResumen where id=4),0)*-1 else 0 end),
	te = (case when isNull((select sum(te) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(te) from #tempTablaResumen where id=4),0)*-1 else 0 end),
	cav = (case when isNull((select sum(cav) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(cav) from #tempTablaResumen where id=4),0)*-1 else 0 end),
	pr = (case when isNull((select sum(pr) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(pr) from #tempTablaResumen where id=4),0)*-1 else 0 end),
	total = (case when isNull((select sum(total) from #tempTablaResumen where id=4),0) < 0 then isNull((select sum(total) from #tempTablaResumen where id=4),0)*-1 else 0 end)
where id = 5


update #tempTablaResumen
set efectivo = (case when efectivo <0 then 0 else efectivo end),
	tc = (case when tc <0 then 0 else tc end),
	te = (case when te <0 then 0 else te end),
	cav = (case when cav <0 then 0 else cav end),
	pr = (case when pr <0 then 0 else pr end),
	total = (case when total <0 then 0 else total end)
where id = 4


update #tempTablaResumen
set total = efectivo + tc + te + cav + pr


update #tempTablaResumen
set subtotal = total - iva
where id in (2,3)

update #tempTablaResumen
set efectivo = isNull((select sum(efectivo) from #tempTablaResumen where id in (2,3)),0),
	tc = isNull((select sum(tc) from #tempTablaResumen where id in (2,3)),0),
	te = isNull((select sum(te) from #tempTablaResumen where id in (2,3)),0),
	cav = isNull((select sum(cav) from #tempTablaResumen where id in (2,3)),0),
	pr = isNull((select sum(pr) from #tempTablaResumen where id in (2,3)),0),
	subtotal = isNull((select sum(total-iva) from #tempTablaResumen where id in (2,3)),0),
	iva = isNull((select sum(iva) from #tempTablaResumen where id in (2,3)),0),
	total = isNull((select sum(total) from #tempTablaResumen where id in (2,3)),0)
where id = 6


--update #tempTablaResumen
--set total = efectivo + tc + te + cav + pr



select descripcion, efectivo, tc, te, cav, pr, subtotal, iva, total
from #tempTablaResumen
order by id


drop table #tempTablaResumen






go

go

ALTER procedure [dbo].[genera_poliza_contable_gastos_individual]      
 @id_solicitud int      
as      

set nocount on      
      
      
/*
declare @id_solicitud int      
select @id_solicitud = 28614      
*/      
  
      
declare @tipo_poliza varchar(3), @id_empresa int, @tiene_poliza_contable int, @folio_txt varchar(32)    

declare @locale varchar(2)='es'
if exists(select 1 from solicitud_gastos where id_solicitud=@id_solicitud and id_empresa=12)
	select @locale='en'
        
select @tipo_poliza = 'GV'      

declare @tax_label varchar(3) = 'IVA'
if @locale='en'
	select @tax_label='TAX'

declare @tip_label varchar(16) = 'Propinas'
if @locale='en'
	select @tip_label='Tips'

      
select @id_empresa = id_empresa, @folio_txt = folio_txt + '%'     
from solicitud_gastos      
where id_solicitud = @id_solicitud      
    
select @tiene_poliza_contable = COUNT(*)    
from poliza_contable    
where referencia like @folio_txt    
and fecha_envio_sap is not null    
and tipo = 'SV'     
    
create table #tblEncabezado      
(       
 id    int identity(1,1),      
 id_solicitud int,      
 empleado  varchar(512),      
 fecha_documento char(8),      
 sociedad  char(4),      
 deudor   char(17),      
 referencia  char(16),      
 asignacion  char(18),      
 total   char(16)      
)      
      
create table #tblDetalle      
(       
 id    int identity(1,1),      
 id_solicitud int,      
 id_concepto  int,      
 tipo_concepto varchar(3),      
 cuenta   char(17),      
 sociedad  char(4),      
 clave_iva  char(2),      
 proyecto  char(12),      
 asignacion  char(18),      
 importe_sin_iva char(16),      
 no_necesidad char(4),      
 descripcion  char(45),  
 iva decimal(18,2),
 propina decimal(18,2) default(0),
 es_custom bit default(0)
)      
      
      
create table #resultado      
(      
 id int identity(1,1),      
 concepto varchar(512),      
 cuenta  varchar(128),      
 debe  decimal(18,2),      
 haber  decimal(18,2)      
)          
    
if @tiene_poliza_contable = 0    
 begin    
     
  insert into #tblEncabezado (id_solicitud, empleado, fecha_documento, sociedad,      
      deudor, referencia, asignacion, total)      
  select sg.id_solicitud,      
    e.nombre,      
    fecha_documento = convert(varchar(8),sg.fecha_registro,112),      
    sociedad = (case      
     when sg.id_empresa = 3 then '0300'      
     when sg.id_empresa = 6 then '0600'      
     when sg.id_empresa = 8 then '0800'      
     when sg.id_empresa = 12 then '0850'      
     else '0000'      
    end),      
    num_deudor = e.num_deudor,      
    referencia  = left(ltrim(rtrim(sg.folio_txt)),16),      
    asignacion = left(ltrim(rtrim(sg.destino)),18), --right('                  ' + left(ltrim(rtrim(sg.motivo)),18),18),      
    total = convert(varchar(18),dbo.fn_solicitud_gastos_total(sg.id_solicitud))
  from solicitud_gastos sg      
  join empleado e on e.id_empleado = sg.id_empleado_viaja      
  where exists (select 1      
     from solicitud_gastos_detalle sgd      
     where sgd.tipo_concepto <> ''      
     and sgd.id_solicitud = sg.id_solicitud)      
  and sg.id_solicitud = @id_solicitud      
  order by sg.id_solicitud      
        
        
  insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
      asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva, propina)      
  select sgd.id_solicitud,      
    cuenta = (case       
    when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'      
    when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
    when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
    when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'      
    when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
    when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')      
    else ''      
    end),      
    sociedad = e.sociedad,      
    clave_iva = (case      
     when sgd.iva = 0 then 'W0'      
     else 'W6'      
     end),      
    proyecto = left((case      
    when tipo_concepto = 'CC' then isNull(cc.clave,'')      
    when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')   
    else ''      
    end),12),      
    e.asignacion,      
    importe = convert(varchar(18),convert(decimal(18,2),(subtotal * tipo_cambio))),      
    no_necesidad = isNull(n.clave,'0000'),      
    observaciones = (case
						when @locale='es' then left(cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left(cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					 end),
    sgd.id_concepto,      
    sgd.tipo_concepto,  
    sgd.iva,
	convert(decimal(18,2),(isNull(sgd.propina,0) * sgd.tipo_cambio))
  from solicitud_gastos_detalle sgd      
  join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
  left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
  join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
  left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
  order by sgd.id_solicitud, sgd.id_detalle      
        
        
  -- OTROS IMPUESTOS      
  insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
      asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva)      
  select sgd.id_solicitud,      
    cuenta = (case       
    when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'      
    when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
    when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
    when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'      
    when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
    when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')      
    else ''      
    end),      
    sociedad = e.sociedad,      
    clave_iva = 'W0',      
    proyecto = left((case      
    when tipo_concepto = 'CC' then isNull(cc.clave,'')      
    when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')      
    else ''      
    end),12),      
    e.asignacion,      
    importe = convert(varchar(18),convert(decimal(18,2),(otros_impuestos * tipo_cambio))),      
    no_necesidad = isNull(n.clave,'0000'),      
    observaciones = (case
						when @locale='es' then left('Otros Imp: ' + cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left('Other TAX: ' + cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					 end),
    sgd.id_concepto,      
    sgd.tipo_concepto,  
    sgd.iva      
  from solicitud_gastos_detalle sgd      
  join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
  left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
  join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
  left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
  where sgd.otros_impuestos > 0      
  order by sgd.id_solicitud, sgd.id_detalle      




	   
 --RETENCION RESICO     
 insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
     asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva)      
 select sgd.id_solicitud,      
   cuenta = '2130005003'/*(case      
   when sociedad = '0300' and tipo_concepto in ('OI','PP') then '2130005003'      
   when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
   when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
   when sociedad = '0800' and tipo_concepto in ('OI','PP') then '5120100001'      
   when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
   when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')      
   else ''      
   end)*/,      
   sociedad = e.sociedad,      
   clave_iva = 'W0',      
   proyecto = left((case      
		   when tipo_concepto = 'CC' then isNull(cc.clave,'')      
		   when tipo_concepto in ('OI','PP') then isNull(sgd.orden_interna,'')      
		   else ''      
		   end),12),      
   e.asignacion,      
   importe = convert(varchar(18),convert(decimal(18,2),(retencion_resico*-1))),      
   no_necesidad = isNull(n.clave,'0000'),      
   observaciones = (case
						when @locale='es' then left('RET. 1.25 ISR Reg Simp Conf: ' + cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left('RET. 1.25 ISR Reg Simp Conf: ' + cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					end),
   sgd.id_concepto,      
   sgd.tipo_concepto,     
   sgd.iva      
 from solicitud_gastos_detalle sgd      
 join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
 left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
 join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
 left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
 where sgd.retencion_resico <> 0      
 order by sgd.id_solicitud, sgd.id_detalle      
       
       
       
               
        
        
  insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
      asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva, es_custom)      
  select id_solicitud, 
--		'5200000280',
		(case
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 else '5200000280'
		   end), 
		sociedad, 
		'W0', 
		proyecto,       
		asignacion, convert(varchar(18), (case when clave_iva = 'W6' then convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915) + convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915 * 0.16)
												else convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915)
										end)), no_necesidad, descripcion, id_concepto, tipo_concepto, iva, es_custom = 1
  from #tblDetalle      
  where id_concepto in (2,65)
        
  update #tblDetalle      
  set importe_sin_iva = convert(varchar(18),convert(decimal(18,2),(convert(decimal(18,2),importe_sin_iva)*0.085)))       
  where id_concepto in (2,65)
  and es_custom = 0
--  and cuenta <> '5200000280'      
        
        
  insert into #resultado (concepto, cuenta, debe, haber)      
  select descripcion, cuenta, convert(decimal(18,2),importe_sin_iva), 0      
  from #tblDetalle      
  order by id      
        
  insert into #resultado (concepto, cuenta, debe, haber)      
  select @tax_label, '1160002008', sum((case when id_concepto not in (2,65) then iva else iva * 0.085 end)), 0      
  from #tblDetalle  
 where clave_iva = 'W6'      
  group by cuenta   


--INSERTAR PROPINAS
 insert into #resultado (concepto, cuenta, debe, haber)
select @tip_label, 
	(case         
			 when td.tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 when td.sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
			 when td.sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
			 when td.sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
			 when td.sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
			 else ''	       
		   end), sum(td.propina), 0    
from #tblDetalle td
join concepto_gasto cg on cg.id_concepto = 20
where td.propina > 0
group by td.sociedad, cg.nb_cuenta_clave, cg.ns_cuenta_clave, cg.nf_cuenta_clave, cg.nu_cuenta_clave, td.tipo_concepto
  
  
  if (select tipo_comprobantes from solicitud_gastos where id_solicitud = @id_solicitud) = 'RF'
	update #resultado set cuenta = '5700000031' where cuenta <> '1160002008'
  
     
        
  insert into #resultado (concepto, cuenta, debe, haber)      
  select empleado, deudor, 0, total      
  from #tblEncabezado      
      
  select concepto, cuenta, debe = sum(debe), haber = sum(haber),tiene_poliza_contable = @tiene_poliza_contable      
  from #resultado      
  group by concepto, cuenta    
      
 end     
else    
 begin    
      
  declare @count int, @row_max int    
  select @count = 1    
           
  create table #solicitudes     
  (      
   id int identity(1,1),      
   id_solicitud int    
  )     
        
  insert into #solicitudes (id_solicitud)    
  select id_solicitud    
  from poliza_contable    
  where referencia like @folio_txt    
  and fecha_envio_sap is not null    
  and tipo = 'SV'     
  order by referencia     
      
  select @row_max = max(id)    
  from #solicitudes    
      
  WHILE @count <= @row_max    
  BEGIN    
   declare @current_id_solicitud int    
       
   select @current_id_solicitud = id_solicitud    
   from #solicitudes    
   where id = @count    
       
   insert into #resultado (concepto, cuenta, debe, haber)           
   select (case when @tiene_poliza_contable > 1 then empleado + ' (' + referencia + ')' else empleado  end),    
     deudor,    
     0,    
     total    
   from poliza_contable    
   where referencia like @folio_txt    
   and fecha_envio_sap is not null    
   and tipo = 'SV'     
   and id_solicitud = @current_id_solicitud    
   order by referencia      
    
   insert into #resultado (concepto, cuenta, debe, haber)           
   select (case 
				when @locale='es' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion end)
				when @locale='en' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion_en end)
		   end), pcd.cuenta, debe = sum(pcd.importe_sin_iva), haber = 0       
   from poliza_contable pc      
   join poliza_contable_detalle pcd on pcd.id_solicitud = pc.id_solicitud    
            and pcd.tipo = pc.tipo    
   left outer join concepto_gasto c on c.id_concepto = pcd.id_concepto    
   where pc.referencia like @folio_txt    
   and pc.fecha_envio_sap is not null    
   and pc.tipo = 'SV'     
   and pcd.tipo = 'SV'      
   and pcd.id_solicitud = @current_id_solicitud     
   group by (case 
				when @locale='es' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion end)
				when @locale='en' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion_en end)
		   end), cuenta     
       
   select @count = @count+1     
  END    
      
  drop table #solicitudes      
      
  select concepto, cuenta, debe, haber, tiene_poliza_contable = @tiene_poliza_contable      
  from #resultado      
 end       
        
        
    
    
drop table #tblEncabezado      
drop table #tblDetalle      
drop table #resultado          






go

go

ALTER procedure [dbo].[recupera_solicitud_gastos_detalle_desc]
	@id_solicitud integer,
	@locale varchar(2) = 'es'
as

declare @label1 varchar(32)

select @label1 = (case when @locale='es' then '<br>Excedio limite por: ' when @locale='en' then '<br>Limit exceeded by: ' end)

select sgd.id_detalle,
		sgd.fecha_comprobante,
		concepto = cg.clave + '-' + (case when @locale='es' then cg.descripcion when @locale='en' then cg.descripcion_en end),
		sgd.moneda,
		sgd.subtotal,
		sgd.iva,
		sgd.total,
		orden_interna = (case when sgd.tipo_concepto in ('OI','PP') then sgd.orden_interna else cc.clave end),
		no_necesidad = (case when sgd.tipo_concepto in ('OI','PP') then n.clave else '' end),
		sgd.observaciones,
		sgd.tipo_cambio,
		sgd.otros_impuestos,
		sgd.propina,
		sgd.retencion,
		sgd.retencion_resico,
		forma_pago=(case when @locale='es' then fp.descripcion when @locale='en' then fp.descripcion_en end),
		total_pesos = convert(decimal(18,2), total*tipo_cambio),
		descripcion_nb = (case when sg.id_empresa=3 then '<br />- ' + cg.nb_cuenta_desc_reportes else '' end),
		num_personas = isNull(num_personas,1),
		excedio_limite = (case 
							when dbo.fn_solicitud_gastos_fuera_limite(sgd.id_detalle) > 0 
								then @label1 + convert(varchar(32),dbo.fn_solicitud_gastos_fuera_limite(sgd.id_detalle)) + ' MXN'
							else ''
						end)
from solicitud_gastos_detalle sgd
join solicitud_gastos sg on sg.id_solicitud=sgd.id_solicitud
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto
join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad
where sgd.id_solicitud = @id_solicitud
order by sgd.fecha_comprobante, sgd.id_detalle




select id_solicitud,
		total = convert(decimal(18,2), sum((total)*tipo_cambio)),
		total_tc = convert(decimal(18,2), sum(case 
											when id_forma_pago=2 then (total)*tipo_cambio
											else 0
										   end)),
		total_pes = convert(decimal(18,2), sum((total)*tipo_cambio))
from solicitud_gastos_detalle sgd
where id_solicitud = @id_solicitud
group by id_solicitud

select sgd.id_solicitud,
		forma_pago = (case when @locale='es' then fp.descripcion when @locale='en' then fp.descripcion_en end),
		total = convert(decimal(18,2), sum((sgd.total)*sgd.tipo_cambio))
from solicitud_gastos_detalle sgd
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.id_solicitud = @id_solicitud
group by sgd.id_solicitud, fp.descripcion, fp.descripcion_en




go

go

ALTER procedure [dbo].[genera_poliza_contable_reposicion_individual]      
 @id_solicitud int      
as      

set nocount on      
  
/*  
declare @id_solicitud int      
select @id_solicitud = 31987      
 */

declare @tipo_poliza varchar(3), @id_empresa int, @tiene_poliza_contable int, @folio_txt varchar(32)       
  
select @tipo_poliza = 'RG'      

declare @locale varchar(2)='es'
if exists(select 1 from solicitud_reposicion where id_solicitud=@id_solicitud and id_empresa=12)
	select @locale='en'

declare @tax_label varchar(3) = 'IVA'
if @locale='en'
	select @tax_label='TAX'

declare @tip_label varchar(16) = 'Propinas'
if @locale='en'
	select @tip_label='Tips'
      
select @id_empresa = id_empresa, @folio_txt = folio_txt + '%'       
from solicitud_reposicion      
where id_solicitud = @id_solicitud      
   
select @tiene_poliza_contable = COUNT(*)      
from poliza_contable      
where referencia like @folio_txt      
and fecha_envio_sap is not null      
and tipo = 'RG'       
      
create table #tblEncabezado      
(       
 id    int identity(1,1),      
 id_solicitud int,      
 empleado  varchar(512),      
 fecha_documento char(8),      
 sociedad  char(4),      
 deudor   char(17),      
 referencia  char(16),      
 asignacion  char(18),      
 total   char(16)      
)      
      
create table #tblDetalle      
(       
 id    int identity(1,1),      
 id_solicitud int,      
 id_concepto  int,      
 tipo_concepto varchar(3),      
 cuenta   char(17),      
 sociedad  char(4),      
 clave_iva  char(2),      
 proyecto  char(12),      
 asignacion  char(18),      
 importe_sin_iva char(16),      
 no_necesidad char(4),      
 descripcion  char(45),    
 iva decimal(18,2),
 propina decimal(18,2) default(0),
 es_custom bit default(0)
)      
   
       
create table #resultado      
(      
 id int identity(1,1),      
 concepto varchar(512),      
 cuenta  varchar(128),      
 debe  decimal(18,2),      
 haber  decimal(18,2)      
)      
       
if @tiene_poliza_contable = 0
 begin     
 insert into #tblEncabezado (id_solicitud, empleado, fecha_documento, sociedad,      
     deudor, referencia, asignacion, total)      
 select sg.id_solicitud,      
   e.nombre,      
   fecha_documento = convert(varchar(8),sg.fecha_registro,112),      
   sociedad = (case      
    when sg.id_empresa = 3 then '0300'      
    when sg.id_empresa = 6 then '0600'      
    when sg.id_empresa = 8 then '0800'      
    when sg.id_empresa = 12 then '0850'      
    else '0000'      
   end),      
   num_deudor = e.num_deudor,      
   referencia  = left(ltrim(rtrim(sg.folio_txt)),16),      
   asignacion = left(ltrim(rtrim(sg.comentarios)),18), --right('                  ' + left(ltrim(rtrim(sg.motivo)),18),18),      
   total = convert(varchar(18),dbo.fn_solicitud_reposicion_total(sg.id_solicitud))      
 from solicitud_reposicion sg      
 join empleado e on e.id_empleado = sg.id_empleado_solicita      
 where exists (select 1      
    from solicitud_reposicion_detalle sgd      
    where sgd.tipo_concepto <> ''      
    and sgd.id_solicitud = sg.id_solicitud)      
 and sg.id_solicitud = @id_solicitud      
 order by sg.id_solicitud      
       
       
       
 insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
     asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva, propina)      
 select sgd.id_solicitud,      
   cuenta = (case      
   when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'      
   when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
   when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
   when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'      
   when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
   when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'') 
   else ''      
   end),      
   sociedad = e.sociedad,      
   clave_iva = (case      
    when sgd.iva = 0 then 'W0'      
    else 'W6'      
    end),      
   proyecto = left((case      
   when tipo_concepto = 'CC' then isNull(cc.clave,'')      
   when tipo_concepto in ('OI','PP') then isNull(sgd.orden_interna,'')      
   else ''      
   end),12),      
   e.asignacion,      
   importe = convert(varchar(18),convert(decimal(18,2),(subtotal * tipo_cambio))),      
   no_necesidad = isNull(n.clave,'0000'),      
   observaciones = (case
						when @locale='es' then left(cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left(cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					end),      
   sgd.id_concepto,      
   sgd.tipo_concepto,     
   sgd.iva,
   convert(decimal(18,2),(isNull(sgd.propina,0) * sgd.tipo_cambio))
 from solicitud_reposicion_detalle sgd      
 join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
 left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
 join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
 left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
 order by sgd.id_solicitud, sgd.id_detalle      
       
 --OTROS IMPUESTOS      
 insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
     asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva)      
 select sgd.id_solicitud,      
   cuenta = (case      
   when sociedad = '0300' and tipo_concepto in ('OI','PP') then '5120100001'      
   when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
   when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
   when sociedad = '0800' and tipo_concepto in ('OI','PP') then '5120100001'      
   when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
   when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')      
   else ''      
   end),      
   sociedad = e.sociedad,      
   clave_iva = 'W0',      
   proyecto = left((case      
   when tipo_concepto = 'CC' then isNull(cc.clave,'')      
   when tipo_concepto in ('OI','PP') then isNull(sgd.orden_interna,'')      
   else ''      
   end),12),      
   e.asignacion,      
   importe = convert(varchar(18),convert(decimal(18,2),(otros_impuestos * tipo_cambio))),      
   no_necesidad = isNull(n.clave,'0000'),      
   observaciones = (case
						when @locale='es' then left('Otros Imp:' + cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left('Other TAX:' + cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					end),
   sgd.id_concepto,      
   sgd.tipo_concepto,     
   sgd.iva      
 from solicitud_reposicion_detalle sgd      
 join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
 left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
 join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
 left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
 where sgd.otros_impuestos > 0      
 order by sgd.id_solicitud, sgd.id_detalle      
       

	   
 --RETENCION RESICO     
 insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
     asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva)      
 select sgd.id_solicitud,      
   cuenta = '2130005003'/*(case      
   when sociedad = '0300' and tipo_concepto in ('OI','PP') then '2130005003'      
   when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')      
   when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')      
   when sociedad = '0800' and tipo_concepto in ('OI','PP') then '5120100001'      
   when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')      
   when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')      
   else ''      
   end)*/,      
   sociedad = e.sociedad,      
   clave_iva = 'W0',      
   proyecto = left((case      
		   when tipo_concepto = 'CC' then isNull(cc.clave,'')      
		   when tipo_concepto in ('OI','PP') then isNull(sgd.orden_interna,'')      
		   else ''      
		   end),12),      
   e.asignacion,      
   importe = convert(varchar(18),convert(decimal(18,2),(retencion_resico*-1))),      
   no_necesidad = isNull(n.clave,'0000'),      
   observaciones = (case
						when @locale='es' then left('RET. 1.25 ISR Reg Simp Conf: ' + cg.descripcion + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
						when @locale='en' then left('RET. 1.25 ISR Reg Simp Conf: ' + cg.descripcion_en + (case when @id_empresa=3 and tipo_concepto  in ('OI','PP') then ' - ' + e.empleado else '' end),45)
					end),
   sgd.id_concepto,      
   sgd.tipo_concepto,     
   sgd.iva      
 from solicitud_reposicion_detalle sgd      
 join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud      
 left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo      
 join concepto_gasto cg on cg.id_concepto = sgd.id_concepto      
 left outer join necesidad n on n.id_necesidad = sgd.id_necesidad      
 where sgd.retencion_resico <> 0      
 order by sgd.id_solicitud, sgd.id_detalle      
       
       
       
       
 insert into #tblDetalle (id_solicitud, cuenta, sociedad, clave_iva, proyecto,       
     asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, iva, es_custom)      
 select id_solicitud, 
--		'5200000280',
		(case
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 else '5200000280'
		   end), 
		sociedad, 
		'W0', 
		proyecto,       
		asignacion, 
		convert(varchar(18), (case when clave_iva = 'W6' then convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915) + convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915 * 0.16)
												else convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915)
										end)), 
		no_necesidad, 
		descripcion, 
		id_concepto, 
		tipo_concepto, 
		iva, 
		es_custom = 1
 from #tblDetalle      
 where id_concepto in (2,65)
       
 update #tblDetalle      
set importe_sin_iva = convert(varchar(18),convert(decimal(18,2),(convert(decimal(18,2),importe_sin_iva)*0.085)))       
 where id_concepto in (2,65)
 and es_custom = 0
 --and cuenta <> '5200000280'      
           
       
 insert into #resultado (concepto, cuenta, debe, haber)      
 select descripcion, cuenta, convert(decimal(18,2),importe_sin_iva), 0      
 from #tblDetalle      
 order by id      
       
 insert into #resultado (concepto, cuenta, debe, haber)      
 select @tax_label, '1160002008', sum((case when id_concepto not in (2,65) then iva else iva * 0.085 end)), 0    
 from #tblDetalle      
 where clave_iva = 'W6'      
 group by cuenta      


 --insert into #resultado (concepto, cuenta, debe, haber)      
 --select @tax_label, '1160002008', sum((case when id_concepto not in (2,65) then iva else iva * 0.085 end)), 0    
 --from #tblDetalle      
 --where clave_iva = 'W6'      
 --group by cuenta      


--INSERTAR PROPINAS
 insert into #resultado (concepto, cuenta, debe, haber)
select @tip_label, 
	(case         
			 when td.tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 when td.sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
			 when td.sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
			 when td.sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
			 when td.sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
			 else ''	       
		   end), sum(td.propina), 0    
from #tblDetalle td
join concepto_gasto cg on cg.id_concepto = 20
where td.propina > 0
group by td.sociedad, cg.nb_cuenta_clave, cg.ns_cuenta_clave, cg.nf_cuenta_clave, cg.nu_cuenta_clave, td.tipo_concepto


  if (select tipo_comprobantes from solicitud_reposicion where id_solicitud = @id_solicitud) = 'RF'
	update #resultado set cuenta = '5700000031' where cuenta <> '1160002008'

       
 insert into #resultado (concepto, cuenta, debe, haber)      
 select empleado, deudor, 0, total      
 from #tblEncabezado      
       
       
 select concepto, cuenta, debe = sum(debe), haber = sum(haber), tiene_poliza_contable = @tiene_poliza_contable      
 from #resultado      
 group by concepto, cuenta       
 end  
ELSE   
 begin     
  declare @count int, @row_max int      
  select @count = 1      
             
  create table #solicitudes       
  (        
   id int identity(1,1),        
   id_solicitud int      
  )       
          
  insert into #solicitudes (id_solicitud)      
  select id_solicitud      
  from poliza_contable      
  where referencia like @folio_txt      
  and fecha_envio_sap is not null      
  and tipo = 'RG'       
  order by referencia       
        
  select @row_max = max(id)      
  from #solicitudes      
        
  WHILE @count <= @row_max      
  BEGIN      
   declare @current_id_solicitud int      
         
   select @current_id_solicitud = id_solicitud      
   from #solicitudes      
   where id = @count      
         
   insert into #resultado (concepto, cuenta, debe, haber)             
   select (case when @tiene_poliza_contable > 1 then empleado + ' (' + referencia + ')' else empleado  end),      
     deudor,      
     0,      
     total      
   from poliza_contable      
   where referencia like @folio_txt      
   and fecha_envio_sap is not null      
   and tipo = 'RG'       
   and id_solicitud = @current_id_solicitud      
   order by referencia        
      
   insert into #resultado (concepto, cuenta, debe, haber)             
   select (case 
				when @locale='es' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion end)
				when @locale='en' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion_en end)
		   end), 
   pcd.cuenta, debe = sum(pcd.importe_sin_iva), haber = 0         
   from poliza_contable pc    
   join poliza_contable_detalle pcd on pcd.id_solicitud = pc.id_solicitud      
            and pcd.tipo = pc.tipo      
   left outer join concepto_gasto c on c.id_concepto = pcd.id_concepto      
   where pc.referencia like @folio_txt      
   and pc.fecha_envio_sap is not null      
   and pc.tipo = 'RG'       
   and pcd.tipo = 'RG'        
   and pcd.id_solicitud = @current_id_solicitud       
   group by (case 
				when @locale='es' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion end)
				when @locale='en' then (case when pcd.id_concepto = -1 then @tax_label else c.descripcion_en end)
		   end), cuenta       
         
   select @count = @count+1       
  END      
        
  drop table #solicitudes        
        
  select concepto, cuenta, debe, haber, tiene_poliza_contable = @tiene_poliza_contable        
  from #resultado   
 end       
      
  
      
drop table #tblEncabezado
drop table #tblDetalle
drop table #resultado







go

go

ALTER procedure dbo.recupera_solicitud_reposicion_tabla_resumen
	@id_solicitud int
as

--declare @id_solicitud int = 26591

create table #tempTablaResumen
(
	id int,
	descripcion varchar(64),
	efectivo decimal(18,2) default(0),
	tc decimal(18,2) default(0),
	te decimal(18,2) default(0),
	cav decimal(18,2) default(0),
	pr decimal(18,2) default(0),
	subtotal decimal(18,2) default(0),
	iva decimal(18,2) default(0),
	total decimal(18,2) default(0)
)

--insert into #tempTablaResumen (id, descripcion) values (1,'Anticipo')
insert into #tempTablaResumen (id, descripcion) values (2,'Total Gastos en MXN')
-- insert into #tempTablaResumen (id, descripcion) values (3,'Total de Gastos compra material a MXN')
--insert into #tempTablaResumen (id, descripcion) values (4,'Saldo en Contra')
--insert into #tempTablaResumen (id, descripcion) values (5,'Saldo a Favor')




update #tempTablaResumen
set efectivo = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud and id_forma_pago=1),0),
	tc = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud and id_forma_pago=2),0),
	te = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud and id_forma_pago=3),0),
	cav = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud and id_forma_pago=8),0),
	pr = isNull((select sum(total*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud and id_forma_pago=7),0),
	iva = isNull((select sum(iva*tipo_cambio) from solicitud_reposicion_detalle where id_solicitud = @id_solicitud),0)
where id = 2



update #tempTablaResumen
set total = efectivo + tc + te + cav + pr

update #tempTablaResumen
set subtotal = total - iva



select descripcion, efectivo, tc, te, cav, pr, subtotal, iva, total
from #tempTablaResumen
order by id


drop table #tempTablaResumen









go

go

ALTER procedure [dbo].[recupera_solicitud_reposicion_detalle_desc]
	@id_solicitud integer,
	@locale varchar(2) = 'es'
as


select sgd.id_detalle,
		sgd.fecha_comprobante,
		concepto = cg.clave + '-' + (case when @locale='es' then cg.descripcion when @locale='en' then cg.descripcion_en end),
		sgd.moneda,
		sgd.subtotal,
		sgd.iva,
		sgd.total,
		orden_interna = (case when sgd.tipo_concepto in ('OI','PP') then sgd.orden_interna else cc.clave end),
		no_necesidad = (case when sgd.tipo_concepto in ('OI','PP') then n.clave else '' end),
		sgd.observaciones,
		sgd.tipo_cambio,
		sgd.otros_impuestos,
		sgd.propina,
		sgd.retencion,
		sgd.retencion_resico,
		forma_pago=(case when @locale='es' then fp.descripcion when @locale='en' then fp.descripcion_en end),
		total_pesos = convert(decimal(18,2), total*tipo_cambio),
		descripcion_nb = (case when sg.id_empresa=3 then '<br />- ' + cg.nb_cuenta_desc_reportes else '' end)
from solicitud_reposicion_detalle sgd
join solicitud_reposicion sg on sg.id_solicitud=sgd.id_solicitud
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto
join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad
where sgd.id_solicitud = @id_solicitud
order by sgd.fecha_comprobante, sgd.id_detalle




select id_solicitud,
		total = convert(decimal(18,2), sum((total)*tipo_cambio)),
		total_tc = convert(decimal(18,2), sum(case 
											when id_forma_pago=2 then (total)*tipo_cambio
											else 0
										   end)),
		total_pes = convert(decimal(18,2), sum((total)*tipo_cambio))
from solicitud_reposicion_detalle sgd
where id_solicitud = @id_solicitud
group by id_solicitud



select sgd.id_solicitud,
		forma_pago = (case when @locale='es' then fp.descripcion when @locale='en' then fp.descripcion_en end),
		total = convert(decimal(18,2), sum((sgd.total)*sgd.tipo_cambio))
from solicitud_reposicion_detalle sgd
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.id_solicitud = @id_solicitud
group by sgd.id_solicitud, fp.descripcion, fp.descripcion_en








go

go

ALTER procedure [dbo].[genera_poliza_contable_reposicion]
 @id_empresa int,            
 @fecha_ini datetime,            
 @fecha_fin datetime,            
 @id_usuario int,            
 @tipo_comprobacion varchar(2),            
 @id_ref uniqueidentifier output            
as            
            
set nocount on            
            
/*            
declare  @id_empresa int,            
 @fecha_ini datetime,            
 @fecha_fin datetime,            
 @id_usuario int,            
 @tipo_comprobacion varchar(2),            
 @id_ref uniqueidentifier            
            
            
select @fecha_ini = '20150413',            
 @fecha_fin = '20150420',            
 @id_usuario = 1,            
 @tipo_comprobacion = 'CC',            
 @id_empresa = 6            
             
*/    

declare @locale varchar(2)='es'
if @id_empresa = 12
	select @locale='en'

declare @tax_label varchar(3) = 'IVA'
if @locale='es'
	select @tax_label='TAX'

        
declare @tipo_poliza varchar(3)            
              
select @tipo_poliza = 'RG',            
  @fecha_fin = dateadd(dd,1,@fecha_fin),            
  @id_ref = NEWID()            
            
create table #tblEncabezado            
(             
 id    int identity(1,1),            
 id_solicitud int,            
 empleado  varchar(512),            
 anio int,            
 periodo int,            
 fecha_documento datetime,            
 sociedad  varchar(4),            
 deudor   varchar(17),            
 referencia  varchar(16),            
 asignacion  varchar(64),            
 total   decimal(18,2),            
 tipo_comprobantes varchar(2),          
 id_empleado int,
 notas varchar(512)          
)            
            
create table #tblDetalle            
(             
 id    int identity(1,1),            
 id_solicitud int,            
 id_concepto  int,            
 tipo_concepto varchar(3),            
 anio int,            
 periodo int,            
 cuenta   varchar(17),            
 sociedad  varchar(4),            
 clave_iva  varchar(2),            
 proyecto  varchar(12),            
 asignacion  varchar(64),            
 importe_sin_iva decimal(18,2),            
 no_necesidad varchar(4),            
 descripcion  varchar(50),            
 orden_iva  int default(1),
 es_custom bit default(0)            
)            
            
            
            
insert into #tblEncabezado (id_solicitud, empleado, anio, periodo, fecha_documento, sociedad,            
       deudor, referencia, asignacion, total, tipo_comprobantes, id_empleado)            
select sg.id_solicitud,            
  e.nombre,            
  year(sg.fecha_comprobacion_conta),            
  month(sg.fecha_comprobacion_conta),            
  fecha_documento = convert(varchar(8),sg.fecha_comprobacion_conta,112),            
  sociedad = (case            
      when sg.id_empresa = 3 then '0300'            
      when sg.id_empresa = 6 then '0600'            
      when sg.id_empresa = 8 then '0800'            
      when sg.id_empresa = 12 then '0850'            
      else '0000'            
     end),            
  num_deudor = isNull(dbo.fn_poliza_contable_excepciones_deudor('RG', sg.id_solicitud), e.num_deudor),
  referencia  = left(ltrim(rtrim(sg.folio_txt)),16),            
  asignacion = dbo.fn_poliza_contable_formas_pago('RG',id_solicitud) + ' - ' + left(ltrim(rtrim(sg.comentarios)),18), --right('                  ' + left(ltrim(rtrim(sg.motivo)),18),18),            
  total = convert(varchar(18),dbo.fn_solicitud_reposicion_total(sg.id_solicitud)),            
  sg.tipo_comprobantes,
  e.id_empleado
from solicitud_reposicion sg
join empleado e on e.id_empleado = sg.id_empleado_viaja --sg.id_empleado_solicita
where sg.fecha_comprobacion_conta >= @fecha_ini            
and sg.fecha_comprobacion_conta < @fecha_fin            
and sg.comprobacion_conta = 1            
and exists (select 1            
 from solicitud_reposicion_detalle sgd            
 where sgd.tipo_concepto <> ''            
   and sgd.id_solicitud = sg.id_solicitud)            
and sg.id_empresa = @id_empresa   
and sg.tipo_comprobantes = @tipo_comprobacion                  
and sg.id_solicitud not in (select id_solicitud from poliza_contable where tipo=@tipo_poliza)            
order by sg.id_solicitud            
            
            
            
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = (case            
     when sociedad = '0300' and tipo_concepto in ('OI','PP') then '5120100001'            
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')            
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')            
     when sociedad = '0800' and tipo_concepto in ('OI','PP') then '5120100001'            
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')            
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')            
     else ''            
     end),            
  sociedad = e.sociedad,            
  clave_iva = (case            
      when sgd.iva = 0 then 'W0'            
      else 'W6'            
      end),            
  proyecto = left((case            
     when tipo_concepto = 'CC' then isNull(cc.clave,'')            
     when tipo_concepto in ('OI','PP') then isNull(sgd.orden_interna,'')            
     else ''            
     end),12),            
  --e.asignacion,            
  --asignacion = left(sgd.observaciones,50),            
  asignacion = left(isNull(fp.abreviatura,'') + ' - ' + isNull(sgd.observaciones,''),50),
  importe = convert(varchar(18),convert(decimal(18,2),(subtotal * tipo_cambio))),            
  no_necesidad = isNull(n.clave,'0000'),            
  observaciones = (case
						when @locale='es' then left(cg.descripcion,50)
						when @locale='en' then left(cg.descripcion_en,50)
					end),
  sgd.id_concepto,            
  sgd.tipo_concepto            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
order by sgd.id_solicitud, sgd.id_detalle            
            
            
-- OTROS IMPUESTOS            
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = (case            
     when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'            
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')            
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')            
     when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'            
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')            
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')            
     else ''            
     end),            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = left((case            
     when tipo_concepto = 'CC' then isNull(cc.clave,'')            
     when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')            
     else ''            
end),12),            
 --e.asignacion,            
--  asignacion = left(sgd.observaciones,50),            
  asignacion = left(isNull(fp.abreviatura,'') + ' - ' + isNull(sgd.observaciones,''),50),
  importe = otros_impuestos * tipo_cambio,            
  no_necesidad = isNull(n.clave,'0000'),  
  observaciones = (case
						when @locale='es' then left(cg.descripcion,50)
						when @locale='en' then left(cg.descripcion_en,50)
					end),            
  sgd.id_concepto,            
  sgd.tipo_concepto            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.otros_impuestos <> 0            
order by sgd.id_solicitud, sgd.id_detalle         
            
            
            
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto, es_custom)            
select id_solicitud, 
		anio, 
		periodo, 
--		'5200000280',
		(case
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 else '5200000280'
		   end), 
		sociedad, 
		'W0', 
		proyecto,             
		asignacion, 
		convert(varchar(18),        
							  (case when clave_iva = 'W6' then convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915) + convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915 * 0.16)        
								else convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915)        
							  end)), 
		no_necesidad, 
		descripcion, 
		id_concepto, 
		tipo_concepto, 
		es_custom = 1
from #tblDetalle            
where id_concepto in (2,65)
            
update #tblDetalle       
set importe_sin_iva = importe_sin_iva*0.085            
where id_concepto in (2,65)      
and es_custom = 0
--and cuenta <> '5200000280'            
            
            
            
-- INSERTAR CONCEPTO DE UTILIDAD O PERDIDA CAMBIARIA        
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto,        
       orden_iva)        
select e.id_solicitud,        
  e.anio,        
  e.periodo,        
  cuenta = (case         
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
     else ''        
     end),        
  sociedad = e.sociedad,        
  clave_iva = 'W0',        
  proyecto = '',        
  e.asignacion,        
  importe = abs(dbo.fn_utilidad_perdida_cambiaria_rg(e.id_solicitud)),      
  no_necesidad = '0000',        
  observaciones = (case
						when @locale='es' then left(cg.descripcion,50)
						when @locale='en' then left(cg.descripcion_en,50)
					end),
  -1,        
  e.tipo_comprobantes,
  99
from #tblEncabezado e
join concepto_gasto cg on cg.id_concepto = (case
												when dbo.fn_utilidad_perdida_cambiaria_rg(e.id_solicitud) > 0 then 59
												when dbo.fn_utilidad_perdida_cambiaria_rg(e.id_solicitud) < 0 then 60
											end)
where dbo.fn_utilidad_perdida_cambiaria_rg(e.id_solicitud) <> 0
order by e.id_solicitud
            
            
            
            
            
            
create table #tblPartir            
(            
 id int identity(1,1),            
 id_detalle int,     
 id_solicitud int,            
 referencia varchar(64)            
)            
            
insert into #tblPartir (id_detalle, id_solicitud, referencia)            
select td.id, td.id_solicitud, tde.referencia            
from #tblDetalle td  
join #tblEncabezado tde on tde.id_solicitud = td.id_solicitud            
where td.id_solicitud in (            
   select id_solicitud            
   from #tblDetalle            
   GROUP by id_solicitud            
   having count(*) > 999            
)            
order by id_solicitud, referencia            
            
declare @cur int,            
  @max int,            
  @contador int,            
  @folio_revision varchar(16),            
  @grupo int,            
  @folio_anterior varchar(16),            
  @id_detalle int,            
  @nuevo_id int,            
  @id_solicitud_original int            
            
select @cur = 1,            
  @max = max(id),            
  @contador = 1,            
  @grupo = 1,            
  @folio_anterior = '',            
  @id_solicitud_original = 0            
from #tblPartir            
            
select @nuevo_id = isNull((select min(id_solicitud) from poliza_contable), 0) - 1            
if @nuevo_id > 0            
 select @nuevo_id = -1            
            
while @cur <= @max            
  begin            
 select @folio_revision = referencia,            
   @id_detalle = id_detalle,            
   @id_solicitud_original = id_solicitud            
 from #tblPartir            
 where id = @cur            
             
 if @folio_anterior <> @folio_revision            
  begin            
   select @grupo = 1,            
     @contador = 1            
  end            
             
 if @grupo > 1            
  begin            
  update #tblDetalle            
  set id_solicitud = @nuevo_id,            
   asignacion = @folio_revision            
  where id = @id_detalle            
  end             
             
 if @contador > @grupo*999            
  begin                 
   select @grupo = @grupo + 1            
   select @nuevo_id = @nuevo_id - 1          
               
               
   insert into #tblEncabezado (id_solicitud, empleado, anio, periodo, fecha_documento,            
          sociedad, deudor, referencia, asignacion, total,            
          tipo_comprobantes, id_empleado)          
   select @nuevo_id, empleado, anio, periodo, fecha_documento, sociedad,             
     deudor, referencia +'-'+ convert(varchar,@grupo), asignacion, total, tipo_comprobantes, id_empleado            
   from #tblEncabezado            
   where id_solicitud = @id_solicitud_original            
               
  end            
            
 select @contador = @contador + 1            
 select @cur = @cur + 1            
 select @folio_anterior = @folio_revision            
  end            
            
            
            
            
     
--INSERTAR IVA            
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto,            
       orden_iva)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = '1160002008',            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = '',            
  e.asignacion,            
  importe = (case when cg.id_concepto not in (2,65) then iva * tipo_cambio          
   else iva * tipo_cambio * 0.085          
   end),          
  no_necesidad = isNull(n.clave,'0000'),            
  observaciones = @tax_label,            
  -1,            
  sgd.tipo_concepto,            
  99            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.iva <> 0          
--and sgd.cuenta <> '5200000280'          
order by sgd.id_solicitud, sgd.id_detalle            
            
            
            
--LB20150824: Se agrego la retencion para los fletes, se inserta en negativo          
--INSERTAR RETENCION FLETES         
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = '2130010003',            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = '',              
  asignacion = 'RET.4 %IVA (A) FLETE',            
  importe = sgd.retencion*-1,            
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'RET.4 %IVA (A) FLETE',            
  sgd.id_concepto,            
  sgd.tipo_concepto            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.retencion <> 0          
and sgd.id_concepto = 34            
order by sgd.id_solicitud, sgd.id_detalle                
            

--RM230222: Se agrego la retencion para RESICO
--INSERTAR RETENCION RESICO
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = '2130005003',            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = '',              
  asignacion = 'RET. 1.25 ISR Reg Simp Conf',            
  importe = sgd.retencion_resico*-1,            
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'RET. 1.25 ISR Reg Simp Conf',            
  sgd.id_concepto,            
  sgd.tipo_concepto            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.retencion_resico <> 0          
order by sgd.id_solicitud, sgd.id_detalle                
            

--INSERTAR PROPINAS
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = (case         
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
			 when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
			 when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
			 when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
			 else ''	       
		   end),            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = left((case        
     when tipo_concepto = 'CC' then isNull(cc.clave,'')        
     when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')        
     else ''        
     end),12),
  -- proyecto = '',
  asignacion = 'PROPINA',            
  importe = sgd.propina * sgd.tipo_cambio,            
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'PROPINA',            
  sgd.id_concepto,            
  sgd.tipo_concepto            
from solicitud_reposicion_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = 20
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.propina > 0          
order by sgd.id_solicitud, sgd.id_detalle         

        
if @tipo_comprobacion = 'RF'
  begin
	update #tblEncabezado
	set notas = (select top 1 e.nombre
					from solicitud_reposicion_detalle sgd
					join empresa e on e.id_empresa = sgd.id_empresa_reembolso
					where #tblEncabezado.id_solicitud = sgd.id_solicitud
					order by sgd.id_empresa_reembolso)

	update #tblDetalle set cuenta = '5700000031' where cuenta <> '1160002008'
  end        
            
  
insert into poliza_contable (tipo,id_empresa,id_solicitud,anio,periodo,fecha_documento,sociedad,            
        deudor,referencia,asignacion,total,id_usuario,fecha_registro,            
        id_usuario_modifica,fecha_modifica,id_ref,empleado,id_empleado,notas)            
select @tipo_poliza,@id_empresa,id_solicitud,anio,periodo,fecha_documento,sociedad,            
        deudor,referencia,asignacion,total,@id_usuario,getdate(),            
        @id_usuario,getdate(), @id_ref,empleado,id_empleado, notas
from #tblEncabezado            
order by id_solicitud            
            
            

            
insert into poliza_contable_detalle (tipo,id_empresa,id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,            
          proyecto,asignacion,importe_sin_iva,no_necesidad,descripcion,            
          tipo_comprobacion,id_ref,id_concepto)            
select @tipo_poliza,@id_empresa,id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,            
  proyecto,asignacion,importe_sin_iva=convert(varchar(18),sum(convert(decimal(18,2),importe_sin_iva))),            
  no_necesidad,descripcion,@tipo_comprobacion,@id_ref,id_concepto            
from #tblDetalle            
group by id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,            
  proyecto,asignacion,no_necesidad,descripcion, orden_iva,id_concepto            
order by id_solicitud, orden_iva            
            
            
            
delete from poliza_contable            
where id_solicitud not in (select pcd.id_solicitud from poliza_contable_detalle pcd where pcd.id_ref = @id_ref)            
and id_ref = @id_ref            
            
            
            
            
update pc            
set total = convert(decimal(18,2),x.total)            
from poliza_contable pc            
join (            
 select pc.id_solicitud, sum(cast(pcd.importe_sin_iva as decimal(18,2))) as total            
 from poliza_contable pc            
 join poliza_contable_detalle pcd on pcd.id_solicitud = pc.id_solicitud and pcd.id_ref = pc.id_ref        
 where pcd.id_ref = @id_ref          
 group by pc.id_solicitud, pc.total            
 having sum(cast(pcd.importe_sin_iva as decimal(18,2))) - pc.total <> 0       
  ) as x on x.id_solicitud = pc.id_solicitud            
where pc.id_ref = @id_ref            
            
            
            
drop table #tblEncabezado            
drop table #tblDetalle    
drop table #tblPartir            




go

go

ALTER procedure [dbo].[genera_poliza_contable_gastos]
 @id_empresa int,        
 @fecha_ini datetime,        
 @fecha_fin datetime,        
 @id_usuario int,        
 @tipo_comprobacion varchar(2),        
 @id_ref uniqueidentifier output        
as        
        
        
set nocount on        
/*        
declare @id_empresa int,
 @fecha_ini  datetime,
 @fecha_fin  datetime,
 @id_usuario  int,
 @tipo_comprobacion varchar(2),
 @id_ref varchar(64)

select @id_empresa = 8,
 @fecha_ini = '20140903',
 @fecha_fin = '20141110',        
 @id_usuario = 1,        
 @tipo_comprobacion = 'CC'        
*/        


declare @locale varchar(2)='es'
if @id_empresa = 12
	select @locale='en'

declare @tax_label varchar(3) = 'IVA'
if @locale='es'
	select @tax_label='TAX'

declare @tipo_poliza varchar(3)        
--  @id_ref uniqueidentifier        
          
select @tipo_poliza = 'SV',        
  @fecha_fin = dateadd(dd,1,@fecha_fin),        
  @id_ref = NEWID()        
        
create table #tblEncabezado        
(         
 id    int identity(1,1),        
 id_solicitud int,        
 empleado  varchar(512),        
 anio int,        
 periodo int,        
 fecha_documento datetime,        
 sociedad  varchar(4),        
 deudor   varchar(17),        
 referencia  varchar(16),        
 asignacion  varchar(64),        
 total   decimal(18,2),        
 tipo_comprobantes varchar(2),        
 id_solicitud_original int,      
 id_empleado int,
 notas varchar(512)
)        
        
create table #tblDetalle        
(         
 id    int identity(1,1),        
 id_solicitud int,        
 id_concepto  int,        
 tipo_concepto varchar(3),        
 anio int,        
 periodo int,        
 cuenta   varchar(17),        
 sociedad  varchar(4),        
 clave_iva  varchar(2),        
 proyecto  varchar(12),        
 asignacion  varchar(64),        
 importe_sin_iva decimal(18,2),        
 no_necesidad varchar(4),        
 descripcion  varchar(50),        
 orden_iva  int default(1),        
 id_solicitud_original int,
 es_custom bit default(0)
)        
        
insert into #tblEncabezado (id_solicitud, empleado, anio, periodo, fecha_documento, sociedad,        
       deudor, referencia, asignacion, total, tipo_comprobantes, id_solicitud_original, id_empleado)        
select sg.id_solicitud,        
  e.nombre,        
  year(sg.fecha_comprobacion_conta),        
  month(sg.fecha_comprobacion_conta),        
  fecha_documento = sg.fecha_comprobacion_conta,        
  sociedad = (case        
      when sg.id_empresa = 3 then '0300'        
      when sg.id_empresa = 6 then '0600'        
      when sg.id_empresa = 8 then '0800'        
      when sg.id_empresa = 12 then '0850'        
      else '0000'        
     end),        
  num_deudor = isNull(dbo.fn_poliza_contable_excepciones_deudor('SV', sg.id_solicitud), e.num_deudor),
  referencia  = left(ltrim(rtrim(sg.folio_txt)),16),        
  asignacion = dbo.fn_poliza_contable_formas_pago('SV',id_solicitud) + ' - ' + left(ltrim(rtrim(sg.destino)),18), --right('                  ' + left(ltrim(rtrim(sg.motivo)),18),18),        
  total = dbo.fn_solicitud_gastos_total(sg.id_solicitud),        
  sg.tipo_comprobantes,        
  sg.id_solicitud,      
  e.id_empleado        
from solicitud_gastos sg        
join empleado e on e.id_empleado = sg.id_empleado_viaja        
where sg.fecha_comprobacion_conta >= @fecha_ini        
and sg.fecha_comprobacion_conta < @fecha_fin        
and sg.comprobacion_conta = 1        
and exists (select 1        
   from solicitud_gastos_detalle sgd        
   where sgd.tipo_concepto <> ''        
   and sgd.id_solicitud = sg.id_solicitud)        
and sg.id_empresa = @id_empresa        
and sg.tipo_comprobantes = @tipo_comprobacion --20141020        
and sg.id_solicitud not in (select id_solicitud from poliza_contable where tipo=@tipo_poliza)        
order by sg.id_solicitud 
 
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto,        
       tipo_concepto, id_solicitud_original)        
select sgd.id_solicitud,    
  e.anio,        
  e.periodo,        
  cuenta = (case         
     when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'        
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
     when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'        
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
     else ''        
     end),        
  sociedad = e.sociedad,        
  clave_iva = (case        
      when sgd.iva = 0 then 'W0'        
      else 'W6'        
      end),        
  proyecto = left((case        
     when tipo_concepto = 'CC' then isNull(cc.clave,'')        
     when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')        
     else ''        
     end),12),
  --e.asignacion,        
  asignacion = left(isNull(fp.abreviatura,'') + ' - ' + isNull(sgd.observaciones,'') + isNull('(' + convert(varchar(10),sgd.num_personas) + ' Personas)',''),50),        
  importe = convert(decimal(18,2),(subtotal * tipo_cambio)),    no_necesidad = isNull(n.clave,'0000'),        
  observaciones = (case
						when @locale='es' then left(cg.descripcion,50)
						when @locale='en' then left(cg.descripcion_en,50)
					end),        
  sgd.id_concepto,        
  sgd.tipo_concepto,        
  sgd.id_solicitud        
from solicitud_gastos_detalle sgd        
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud        
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo        
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto        
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad        
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
order by sgd.id_solicitud, sgd.id_detalle        
        
--OTROS IMPUESTOS        
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto,        
       tipo_concepto, id_solicitud_original)        
select sgd.id_solicitud,        
  e.anio,        
  e.periodo,        
  cuenta = (case         
     when sociedad = '0300' and tipo_concepto  in ('OI','PP') then '5120100001'        
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
     when sociedad = '0800' and tipo_concepto  in ('OI','PP') then '5120100001'        
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
     else ''        
     end),        
  sociedad = e.sociedad,        
  clave_iva = 'W0',        
  proyecto = left((case        
     when tipo_concepto = 'CC' then isNull(cc.clave,'')        
     when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')        
     else ''        
     end),12),        
  --e.asignacion,        
  --asignacion = left(sgd.observaciones + '(' + convert(varchar(10),sgd.num_personas) + ' Personas)',50),        
  asignacion = left(isNull(fp.abreviatura,'') + ' - ' + isNull(sgd.observaciones,'') + isNull('(' + convert(varchar(10),sgd.num_personas) + ' Personas)',''),50),        
  importe = convert(decimal(18,2),(otros_impuestos * tipo_cambio)),        
  no_necesidad = isNull(n.clave,'0000'),        
  observaciones = (case
						when @locale='es' then left('Otros Imp: ' + cg.descripcion,50)
						when @locale='en' then left('Other TAX: ' + cg.descripcion_en,50)
					end),    
  sgd.id_concepto,        
  sgd.tipo_concepto,        
  sgd.id_solicitud        
from solicitud_gastos_detalle sgd        
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud        
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo        
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto        
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad        
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.otros_impuestos <> 0        
order by sgd.id_solicitud, sgd.id_detalle        
        
        
        
        
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto,         
       tipo_concepto, id_solicitud_original, es_custom)
select id_solicitud, 
		anio, 
		periodo, 
--		'5200000280',
		(case
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 else '5200000280'
		   end), 
		sociedad, 
		'W0', 
		proyecto,         
		asignacion, convert(decimal(18,2), (case 
												when clave_iva = 'W6' then convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915) + convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915 * 0.16)    
												else convert(decimal(18,2),convert(decimal(18,2),importe_sin_iva)*0.915)    
											  end)),
		no_necesidad, 
		descripcion, 
		id_concepto, 
		tipo_concepto, 
		id_solicitud,
		es_custom = 1
from #tblDetalle        
where id_concepto in (2,65)
        
update #tblDetalle        
set importe_sin_iva = importe_sin_iva*0.085        
where id_concepto in (2,65)
and es_custom = 0
--and cuenta <> '5200000280'


--select * from concepto_gasto where id_concepto in (2,65)



-- INSERTAR CONCEPTO DE UTILIDAD O PERDIDA CAMBIARIA        
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto,        
       orden_iva)        
select e.id_solicitud,        
  e.anio,        
  e.periodo,        
  cuenta = (case         
     when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
     when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
     when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
     when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
     else ''        
     end),        
  sociedad = e.sociedad,        
  clave_iva = 'W0',        
  proyecto = '',        
  e.asignacion,        
  importe = abs(dbo.fn_utilidad_perdida_cambiaria_sv(e.id_solicitud)),      
  no_necesidad = '0000',        
  observaciones = (case
						when @locale='es' then left(cg.descripcion,50)
						when @locale='en' then left(cg.descripcion_en,50)
					end),
  -1,        
  e.tipo_comprobantes,
  99
from #tblEncabezado e
join concepto_gasto cg on cg.id_concepto = (case
												when dbo.fn_utilidad_perdida_cambiaria_sv(e.id_solicitud) > 0 then 59
												when dbo.fn_utilidad_perdida_cambiaria_sv(e.id_solicitud) < 0 then 60
											end)
where dbo.fn_utilidad_perdida_cambiaria_sv(e.id_solicitud) <> 0
order by e.id_solicitud
-- FIN INSERTAR CONCEPTO DE UTILIDAD O PERDIDA CAMBIARIA        





create table #tblPartir        
(        
 id int identity(1,1),        
 id_detalle int,        
 id_solicitud int,        
 referencia varchar(64)        
)        
        
insert into #tblPartir (id_detalle, id_solicitud, referencia)        
select td.id, td.id_solicitud, tde.referencia        
from #tblDetalle td        
join #tblEncabezado tde on tde.id_solicitud = td.id_solicitud        
where td.id_solicitud in (        
   select id_solicitud        
   from #tblDetalle        
   GROUP by id_solicitud        
   having count(*) > 999        
)        
order by id_solicitud, referencia        
        
declare @cur int,        
  @max int,        
  @contador int,        
  @folio_revision varchar(16),        
  @grupo int,        
 @folio_anterior varchar(16), 
 @id_detalle int,  
  @nuevo_id int,        
  @id_solicitud_original int        
        
select @cur = 1,        
  @max = max(id),        
  @contador = 1,        
  @grupo = 1,        
  @folio_anterior = '',        
  @id_solicitud_original = 0        
from #tblPartir        
        
select @nuevo_id = isNull((select min(id_solicitud) from poliza_contable), 0) - 1 
if @nuevo_id > 0        
 select @nuevo_id = -1        
        
while @cur <= @max        
  begin        
 select @folio_revision = referencia,        
   @id_detalle = id_detalle,        
   @id_solicitud_original = id_solicitud        
 from #tblPartir        
 where id = @cur        
         
 if @folio_anterior <> @folio_revision        
  begin        
   select @grupo = 1,        
     @contador = 1        
  end        
         
 if @grupo > 1        
  begin        
  update #tblDetalle        
  set id_solicitud = @nuevo_id        
  where id = @id_detalle        
  end         
         
 if @contador > @grupo*999        
  begin             
   select @grupo = @grupo + 1        
   select @nuevo_id = @nuevo_id - 1        
           
           
   insert into #tblEncabezado (id_solicitud, empleado, anio, periodo, fecha_documento,        
          sociedad, deudor, referencia, asignacion, total,        
          tipo_comprobantes, id_solicitud_original, id_empleado)        
   select @nuevo_id, empleado, anio, periodo, fecha_documento, sociedad,         
     deudor, referencia +'-'+ convert(varchar,@grupo), asignacion, total,        
     tipo_comprobantes, id_solicitud_original, id_empleado        
   from #tblEncabezado        
   where id_solicitud = @id_solicitud_original        
           
  end        
        
 select @contador = @contador + 1        
 select @cur = @cur + 1        
 select @folio_anterior = @folio_revision        
  end        
        
 
        
        
--INSERTAR IVA        
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,         
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto,        
       orden_iva)        
select sgd.id_solicitud,        
  e.anio,        
  e.periodo,        
  cuenta = '1160002008',        
  sociedad = e.sociedad,        
  clave_iva = 'W0',        
  proyecto = '',        
  e.asignacion,        
  importe = (case when cg.id_concepto not in (2,65) then iva * tipo_cambio      
   else iva * tipo_cambio * 0.085      
   end),      
  no_necesidad = isNull(n.clave,'0000'),        
  observaciones = @tax_label,        
  -1,        
  sgd.tipo_concepto,        
  99        
from solicitud_gastos_detalle sgd        
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud        
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo        
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto        
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad        
where sgd.iva <> 0      
--and sgd.cuenta <> '5200000280'      
order by sgd.id_solicitud, sgd.id_detalle        
        
        
        
  
--RM20170209: Se agrego la retencion para los fletes, se inserta en negativo          
--INSERTAR RETENCION FLETES         
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = '2130010003',            
  sociedad = e.sociedad,    
  clave_iva = 'W0',            
  proyecto = '',              
  asignacion = 'RET.4 %IVA (A) FLETE',            
  importe = sgd.retencion*-1,            
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'RET.4 %IVA (A) FLETE',      
  sgd.id_concepto,       
sgd.tipo_concepto            
from solicitud_gastos_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.retencion <> 0          
and sgd.id_concepto = 34            
order by sgd.id_solicitud, sgd.id_detalle                


--RM20230222: Se agrego la retencion RESICO, se inserta en negativo
--INSERTAR RETENCION RESICO
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = '2130005003',
  sociedad = e.sociedad,       
  clave_iva = 'W0',            
  proyecto = '',              
  asignacion = 'RET. 1.25 ISR Reg Simp Conf',
  importe = sgd.retencion_resico*-1,            
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'RET. 1.25 ISR Reg Simp Conf',
  sgd.id_concepto,       
sgd.tipo_concepto            
from solicitud_gastos_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto            
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad            
where sgd.retencion_resico <> 0          
order by sgd.id_solicitud, sgd.id_detalle                


--INSERTAR PROPINAS
insert into #tblDetalle (id_solicitud, anio, periodo, cuenta, sociedad, clave_iva, proyecto,             
       asignacion, importe_sin_iva, no_necesidad, descripcion, id_concepto, tipo_concepto)            
select sgd.id_solicitud,            
  e.anio,            
  e.periodo,            
  cuenta = (case
			 when tipo_concepto = 'PP' then '5120100001'    -- cuando sea elemento PEP mandarlo a esta cuenta
			 when sociedad = '0300' then isNull(cg.nb_cuenta_clave,'')        
			 when sociedad = '0600' then isNull(cg.ns_cuenta_clave,'')        
			 when sociedad = '0800' then isNull(cg.nf_cuenta_clave,'')        
			 when sociedad = '0850' then isNull(cg.nu_cuenta_clave,'')        
			 else ''	       
		   end),            
  sociedad = e.sociedad,            
  clave_iva = 'W0',            
  proyecto = left((case        
     when tipo_concepto = 'CC' then isNull(cc.clave,'')        
     when tipo_concepto  in ('OI','PP') then isNull(sgd.orden_interna,'')        
     else ''        
     end),12),
  --proyecto = '',              
  asignacion = 'PROPINA',            
  importe = sgd.propina * sgd.tipo_cambio,
  no_necesidad = isNull(n.clave,'0000'),              
  observaciones = 'PROPINA',      
  sgd.id_concepto,            
sgd.tipo_concepto            
from solicitud_gastos_detalle sgd            
join #tblEncabezado e on e.id_solicitud = sgd.id_solicitud            
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo            
join concepto_gasto cg on cg.id_concepto = 20
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad
where sgd.propina > 0          
order by sgd.id_solicitud, sgd.id_detalle                
     

        
if @tipo_comprobacion = 'RF'
  begin

	update #tblEncabezado
	set notas = (select top 1 e.nombre
					from solicitud_gastos_detalle sgd
					join empresa e on e.id_empresa = sgd.id_empresa_reembolso
					where #tblEncabezado.id_solicitud = sgd.id_solicitud
					order by sgd.id_empresa_reembolso)

	update #tblDetalle set cuenta = '5700000031' where cuenta <> '1160002008'
  end        
        
        
        
insert into poliza_contable (tipo,id_empresa,id_solicitud,anio,periodo,fecha_documento,sociedad,        
        deudor,referencia,asignacion,total,id_usuario,fecha_registro,        
        id_usuario_modifica,fecha_modifica,id_ref,empleado,id_empleado, notas)      
select @tipo_poliza,@id_empresa,id_solicitud,anio,periodo,fecha_documento,sociedad,        
        deudor,referencia,asignacion,total,@id_usuario,getdate(),        
        @id_usuario,getdate(), @id_ref,empleado, id_empleado, notas
from #tblEncabezado        
order by id_solicitud        
        
        
        
        
insert into poliza_contable_detalle (tipo,id_empresa,id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,        
          proyecto,asignacion,importe_sin_iva,no_necesidad,descripcion,        
          tipo_comprobacion,id_ref,id_concepto)        
select @tipo_poliza,@id_empresa,id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,        
  proyecto,asignacion,importe_sin_iva=sum(importe_sin_iva),        
  no_necesidad,descripcion,@tipo_comprobacion,@id_ref,id_concepto        
from #tblDetalle        
group by id_solicitud,anio,periodo,cuenta,sociedad,clave_iva,proyecto,asignacion,no_necesidad,descripcion, orden_iva,id_concepto        
order by id_solicitud, orden_iva        
        
        
delete from poliza_contable        
where id_solicitud not in (select pcd.id_solicitud from poliza_contable_detalle pcd where pcd.id_ref = @id_ref)        
and id_ref = @id_ref  
        
        
update pc        
set total = convert(decimal(18,2),x.total) 
from poliza_contable pc        
join (        
 select pc.id_solicitud, sum(cast(pcd.importe_sin_iva as decimal(18,2))) as total        
 from poliza_contable pc        
 join poliza_contable_detalle pcd on pcd.id_solicitud = pc.id_solicitud and pcd.id_ref = pc.id_ref        
 where pcd.id_ref = @id_ref        
 group by pc.id_solicitud, pc.total        
 having sum(cast(pcd.importe_sin_iva as decimal(18,2))) - pc.total <> 0        
  ) as x on x.id_solicitud = pc.id_solicitud        
where pc.id_ref = @id_ref        
        
        
drop table #tblEncabezado        
drop table #tblDetalle        
drop table #tblPartir        




go

go

ALTER procedure [dbo].[guarda_solicitud_gastos_detalle]
	@id_detalle	int,
	@id_solicitud	int=0,
	@id_concepto	int=0,
	@subtotal	decimal(18,2)=0,
	@iva		decimal(18,2)=0,
	@moneda		varchar(3)='',
	@tipo_cambio	decimal(18,4)=1,
	@id_forma_pago	int=0,
	@orden_interna	varchar(256)='',
	@no_necesidad	varchar(256)='',
	@observaciones	varchar(1024)='',
	@fecha_comprobante	datetime=null,
	@id_centro_costo int=0,
	@id_necesidad	int=0,
	@tipo_concepto	varchar(2)='',
	@otros_impuestos	decimal(18,2)=0,
	@retencion decimal(18,2) = 0,
	@retencion_resico decimal(18,2) = 0,
	@id_empresa_reembolso int = 0,
	@num_personas	int,
	@id_movimiento_tarjeta int = 0,
	@propina decimal(18,2) = 0
as

if @id_detalle=0
  begin
	insert into solicitud_gastos_detalle (id_solicitud, id_concepto, subtotal, iva,
											total,moneda, tipo_cambio, id_forma_pago, 
											orden_interna, no_necesidad, observaciones,
											fecha_comprobante, fecha_registro,
											id_centro_costo, id_necesidad, tipo_concepto, otros_impuestos, retencion, retencion_resico,
											num_personas,id_empresa_reembolso,id_movimiento_tarjeta, propina)
							values (@id_solicitud, @id_concepto, @subtotal, @iva,
											(@subtotal+@iva+@otros_impuestos-@retencion+@propina-@retencion_resico),@moneda, @tipo_cambio, @id_forma_pago, 
											@orden_interna, @no_necesidad, @observaciones,
											@fecha_comprobante, getdate(),
											@id_centro_costo, @id_necesidad, @tipo_concepto, @otros_impuestos, @retencion, @retencion_resico,
											@num_personas,@id_empresa_reembolso,@id_movimiento_tarjeta, @propina)

	if @id_movimiento_tarjeta > 0
		update movimientos_tarjetas
		set id_solicitud = @id_solicitud,
			tipo_solicitud = 'SV'
		where id_movimiento = @id_movimiento_tarjeta
		

	select @id_detalle = @@IDENTITY
  end
else
  begin
	update solicitud_gastos_detalle
	set	subtotal=@subtotal,
		iva=@iva,
		moneda=@moneda,
		total=(@subtotal+@iva+@otros_impuestos-@retencion+@propina-@retencion_resico),  
		otros_impuestos = @otros_impuestos,
		retencion=@retencion,
		retencion_resico=@retencion_resico,
		num_personas = @num_personas,
		tipo_cambio = @tipo_cambio,
		id_forma_pago = @id_forma_pago,
		propina = @propina,
		id_concepto = (case when @id_concepto=0 then id_concepto else @id_concepto end),
		observaciones = @observaciones
		/*,
		observaciones = @observaciones,
		fecha_comprobante = @fecha_comprobante*/
	where id_detalle=@id_detalle
  end



select id_detalle = @id_detalle







go

go

ALTER procedure [dbo].[guarda_solicitud_reposicion_detalle]  
 @id_detalle int,  
 @id_solicitud int=0,  
 @id_concepto int=0,  
 @subtotal decimal(18,2)=0,  
 @iva  decimal(18,2)=0,  
 @moneda  varchar(3)='',  
 @tipo_cambio decimal(18,4)=1,  
 @id_forma_pago int=0,  
 @orden_interna varchar(256)='',  
 @no_necesidad varchar(256)='',  
 @observaciones varchar(1024)='',  
 @fecha_comprobante datetime=null,  
 @id_centro_costo int=0,  
 @id_necesidad int=0,  
 @tipo_concepto varchar(2)='',  
 @otros_impuestos decimal(18,2) = 0,  
 @retencion decimal(18,2) = 0,
 @retencion_resico decimal(18,2) = 0,
 @id_empresa_reembolso int = 0,
 @id_movimiento_tarjeta int = 0,
 @propina decimal(18,2) = 0,
 @id_detalle_nuevo int  = 0 output
as  
  
if @id_detalle=0  
  begin  
		 insert into solicitud_reposicion_detalle (id_solicitud, id_concepto, subtotal, iva,  
				   total,moneda, tipo_cambio, id_forma_pago,   
				   orden_interna, no_necesidad, observaciones,  
				   fecha_comprobante, fecha_registro,  
				   id_centro_costo, id_necesidad, tipo_concepto, otros_impuestos, retencion, retencion_resico,
				   id_empresa_reembolso, id_movimiento_tarjeta, propina)  
			   values (@id_solicitud, @id_concepto, @subtotal, @iva,  
				   (@subtotal+@iva+@otros_impuestos-@retencion+@propina-@retencion_resico),@moneda, @tipo_cambio, @id_forma_pago,   
				   @orden_interna, @no_necesidad, @observaciones,  
				   @fecha_comprobante, getdate(),  
				   @id_centro_costo, @id_necesidad, @tipo_concepto, @otros_impuestos, @retencion, @retencion_resico,
				   @id_empresa_reembolso, @id_movimiento_tarjeta, @propina)  



		if @id_movimiento_tarjeta > 0
			update movimientos_tarjetas
			set id_solicitud = @id_solicitud,
				tipo_solicitud = 'RG'
			where id_movimiento = @id_movimiento_tarjeta


		 select @id_detalle_nuevo = @@identity  
  end  
else  
  begin  
		 update solicitud_reposicion_detalle  
		 set subtotal=@subtotal,  
		  iva=@iva,  
		  moneda=@moneda,  
		--  tipo_cambio=@tipo_cambio,  
		  total=(@subtotal+@iva+@otros_impuestos-@retencion+@propina-@retencion_resico),  
		  otros_impuestos=@otros_impuestos,
		  retencion=@retencion,
		  retencion_resico=@retencion_resico,
		  id_forma_pago=@id_forma_pago,
		  propina = @propina,
		  id_concepto = (case when @id_concepto=0 then id_concepto else @id_concepto end)
		  /*,
		  observaciones = @observaciones,
		  fecha_comprobante = @fecha_comprobante*/
		 where id_detalle=@id_detalle  
   
		 select @id_detalle_nuevo = @id_detalle  
  end  


select id_detalle_nuevo = @id_detalle_nuevo





go

go

ALTER procedure [dbo].[recupera_solicitud_gastos_detalle]
	@id_solicitud integer,
	@locale varchar(2) = 'es'
as

declare @label1 varchar(32),
		@label2 varchar(32)

select @label1 = (case when @locale='es' then '<br>Excedio limite por: ' when @locale='en' then '<br>Limit exceeded by: ' end)
select @label2 = (case when @locale='es' then '<br>Necesidad: ' when @locale='en' then '<br>Need: ' end)

select sgd.id_detalle,
		sgd.fecha_comprobante,
		concepto = cg.clave + '-' + (case when @locale='es' then cg.descripcion when @locale='en' then cg.descripcion_en end),
		sgd.moneda,
		sgd.subtotal,
		sgd.iva,
		sgd.total,
		tipo_cambio = convert(decimal(18,4),sgd.tipo_cambio),
		total_mxp = convert(decimal(18,2), sgd.total * sgd.tipo_cambio),
		sgd.observaciones,
		otros_impuestos = isNull(sgd.otros_impuestos,0),
		descripcion_nb = (case when sg.id_empresa=3 then '<br />- ' + cg.nb_cuenta_desc_reportes else '' end),
		num_personas = isNull(num_personas,1),
		excedio_limite = (case 
							when dbo.fn_solicitud_gastos_fuera_limite(sgd.id_detalle) > 0
								then @label1 + convert(varchar(32),dbo.fn_solicitud_gastos_fuera_limite(sgd.id_detalle)) + ' MXN'
							else ''
						end),
		cg.es_no_deducible,
		cg.es_iva_editable,
		cg.permite_propina,
	sgd.retencion,
	sgd.retencion_resico,
	sgd.propina,
    cg.requiere_retencion,
    info_comprobantes = (case 
						when sgd.tipo_concepto = 'CC' then 'CC: ' + isnull(cc.clave,'')
						when sgd.tipo_concepto = 'OI' then 'OI: ' + isnull(sgd.orden_interna,'') + @label2 + isnull(n.clave,'')
						when sgd.tipo_concepto = 'PP' then 'E-PEP: ' + isnull(sgd.orden_interna,'') + @label2 + isnull(n.clave,'')
						when sgd.tipo_concepto = 'RF' then 'Reem. Fil: ' + isnull(ef.nombre,'')
						end),
	sgd.id_forma_pago,
	forma_pago = isnull(fp.abreviatura,''),
	forma_pago_editable = isNull(sgd.id_movimiento_tarjeta,0),
	sgd.id_concepto
from solicitud_gastos_detalle sgd
join solicitud_gastos sg on sg.id_solicitud=sgd.id_solicitud
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad
left outer join empresa ef on ef.id_empresa = sgd.id_empresa_reembolso
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.id_solicitud = @id_solicitud
order by sgd.fecha_comprobante, sgd.id_detalle


select total_mxp = isNull(sum(convert(decimal(18,2), isNull(sgd.total,0) * isNull(sgd.tipo_cambio,0))),0)
from solicitud_gastos_detalle sgd
where id_solicitud = @id_solicitud





go

go

ALTER procedure [dbo].[recupera_solicitud_reposicion_detalle]
	@id_solicitud integer,
	@locale varchar(2) = 'es'
as  
  
declare @label1 varchar(32),
		@label2 varchar(32)

select @label1 = (case when @locale='es' then '<br>Excedio limite por: ' when @locale='en' then '<br>Limit exceeded by: ' end)
select @label2 = (case when @locale='es' then '<br>Necesidad: ' when @locale='en' then '<br>Need: ' end)
  
select sgd.id_detalle,  
  sgd.fecha_comprobante,  
  concepto = cg.clave + '-' + (case when @locale='es' then cg.descripcion when @locale='en' then cg.descripcion_en end),  
  sgd.moneda,  
  sgd.subtotal,  
  sgd.iva,  
  sgd.total,  
  tipo_cambio = convert(decimal(18,4),sgd.tipo_cambio),  
  total_mxp = convert(decimal(18,2), sgd.total * sgd.tipo_cambio),  
  sgd.observaciones,  
  otros_impuestos = isNull(sgd.otros_impuestos,0),  
  descripcion_nb = (case when sg.id_empresa=3 then '<br />- ' + cg.nb_cuenta_desc_reportes else '' end),  
  cg.es_no_deducible,  
  cg.es_iva_editable,
  cg.permite_propina,
  sgd.retencion,
  sgd.retencion_resico,
  sgd.propina,
  cg.requiere_retencion,
    info_comprobantes = (case 
						when sgd.tipo_concepto = 'CC' then 'CC: ' + isnull(cc.clave,'')
						when sgd.tipo_concepto = 'OI' then 'OI: ' + isnull(sgd.orden_interna,'') + @label2 + isnull(n.clave,'')
						when sgd.tipo_concepto = 'PP' then 'E-PEP: ' + isnull(sgd.orden_interna,'') + @label2 + isnull(n.clave,'')
						when sgd.tipo_concepto = 'RF' then 'Reem. Fil: ' + isnull(ef.nombre,'')
						end),
	sgd.id_forma_pago,
	forma_pago = isnull(fp.abreviatura,''),
	forma_pago_editable = isNull(sgd.id_movimiento_tarjeta,0),
	sgd.id_concepto
from solicitud_reposicion_detalle sgd  
join solicitud_reposicion sg on sg.id_solicitud=sgd.id_solicitud  
join concepto_gasto cg on cg.id_concepto = sgd.id_concepto  
left outer join centro_costo cc on cc.id_centro_costo = sgd.id_centro_costo
left outer join necesidad n on n.id_necesidad = sgd.id_necesidad
left outer join empresa ef on ef.id_empresa = sgd.id_empresa_reembolso
left outer join forma_pago fp on fp.id_forma_pago = sgd.id_forma_pago
where sgd.id_solicitud = @id_solicitud  
order by sgd.fecha_comprobante, sgd.id_detalle  
  
  
select total_mxp = isNull(sum(convert(decimal(18,2), isNull(sgd.total,0) * isNull(sgd.tipo_cambio,0))),0)  
from solicitud_reposicion_detalle sgd  
where id_solicitud = @id_solicitud  



go

go

go

go

go

go

go


go

