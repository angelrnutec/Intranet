go

update concepto set descripcion = 'Dividendos pagados a Accionistas' where id_concepto = 1524

go
go
set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta, id_relacion_concepto)
select 1563, clave, 'Dividendos por pagar a Accionistas', id_reporte, id_grupo, orden+4, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta, id_relacion_concepto
from concepto
where id_concepto = 1524
go
set identity_insert concepto off
go
go

go

go

ALTER PROCEDURE [dbo].[reporte_ejecutivo_21_empresa]
	@tipo	varchar(1),
	@anio	int,
	@periodo int
as

/*
declare @anio int,
		@periodo int,
		@tipo	varchar(1)

select 	@anio = 2021,
		@periodo = 12,
		@tipo	= 'F'
		*/

set nocount on

declare @tEmpresasFiltro as table (id_empresa int)
insert into @tEmpresasFiltro (id_empresa)
select id_empresa from empresa
where ((@tipo='H' and es_hornos=1)
		or (@tipo='F' and es_fibras=1))
and id_empresa not in (6)

create table #tResumenOperativo
(
	id int identity(1,1),
	id_concepto int,
	id_concepto_plan int,
	descripcion varchar(152),
	monto_emp1 decimal(18,2),
	monto_emp2 decimal(18,2),
	monto_emp3 decimal(18,2),
	monto_emp4 decimal(18,2),
	monto_emp5 decimal(18,2),
	monto_emp6 decimal(18,2),
	monto_emp7 decimal(18,2),
	monto_emp8 decimal(18,2),
	monto_emp9 decimal(18,2),
	monto_emp10 decimal(18,2),
    monto_emp12 decimal(18,2),  --LB 20150805: Se agrego la empresa 12
    monto_emp13 decimal(18,2),  --RM 20220203: Se agrego la empresa 13
	monto_total decimal(18,2),
	es_porcentaje bit,
	es_multivalor bit,
	permite_captura bit,
	separador_despues	bit default(0),
	fondo_custom	varchar(32) default(''),
	bordes_1 bit default (0),
	bordes_2 bit default (0),
	solo_titulo bit default (0)
)

insert into #tResumenOperativo (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0
from concepto c
where id_reporte = 1014
and es_plan = 0
and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
and (c.anio_alta is null or (convert(varchar(8),c.anio_alta) + '-' + right('0' + convert(varchar(8),c.periodo_alta),2) <= convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
order by orden

update ro
set	monto_emp1 = x.monto_emp1,
	monto_emp3 = x.monto_emp3,
	monto_emp4 = x.monto_emp4,
	monto_emp7 = x.monto_emp7,
	monto_emp8 = x.monto_emp8,
	monto_emp9 = x.monto_emp9,
	monto_emp10 = x.monto_emp10,
	monto_emp12 = x.monto_emp12,
	monto_emp13 = x.monto_emp13
from #tResumenOperativo ro
join (
	select ro.id,
		monto_emp1  = sum((case when rc.anio=@anio and rc.id_empresa=1  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp3  = sum((case when rc.anio=@anio and rc.id_empresa=3  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp4  = sum((case when rc.anio=@anio and rc.id_empresa=4  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp7  = sum((case when rc.anio=@anio and rc.id_empresa=7  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp8  = sum((case when rc.anio=@anio and rc.id_empresa=8  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp9  = sum((case when rc.anio=@anio and rc.id_empresa=9  then isNull(rc.monto,0) else 0 end)),	--
		monto_emp10 = sum((case when rc.anio=@anio and rc.id_empresa=10 then isNull(rc.monto,0) else 0 end)),	--
		monto_emp12 = sum((case when rc.anio=@anio and rc.id_empresa=12 then isNull(rc.monto,0) else 0 end)),	--
		monto_emp13 = sum((case when rc.anio=@anio and rc.id_empresa=13 then isNull(rc.monto,0) else 0 end))	--
	from #tResumenOperativo ro
	join reporte_captura rc on rc.id_concepto = ro.id_concepto
	where rc.anio in (@anio)
	and rc.periodo = @periodo
	and rc.id_empresa in (select id_empresa from @tEmpresasFiltro)
	group by ro.id) as x on x.id = ro.id

update #tResumenOperativo
set monto_total = isNull(monto_emp1,0) + isNull(monto_emp3,0) + isNull(monto_emp4,0) +
					isNull(monto_emp7,0) + isNull(monto_emp8,0) + isNull(monto_emp9,0) +
					isNull(monto_emp10,0) + isNull(monto_emp12,0) + isNull(monto_emp13,0)



--update #tResumenOperativo set permite_captura=1 where id_concepto in (1370)

--update #tResumenOperativo set separador_despues=1 where id_concepto in (55,60,56,62,63,66,69,70,71,72,73,1371,1372,1373)  
--update #tResumenOperativo set bordes_1=1 where id_concepto in (1372,62,70)
--update #tResumenOperativo set bordes_2=1 where id_concepto in (73)


--update #tResumenOperativo set descripcion = '&nbsp;&nbsp;&nbsp;' + descripcion where id_concepto in (1364, 1371)
--update #tResumenOperativo set descripcion = '+ ' + descripcion where id_concepto in (56)
  
update #tResumenOperativo set descripcion = '&nbsp;&nbsp;&nbsp;' + descripcion where id_concepto in (1507,1508,1518,1526,1532)

update #tResumenOperativo set permite_captura=0 where id_concepto in (1501)  
update #tResumenOperativo set permite_captura=1 where id_concepto in (1504,1506,1535)  
update #tResumenOperativo set separador_despues=1 where id_concepto in (1500,1501,1503,1510,1511,1517,1518,1519,1520,1522,1525,1526,1527,1531,1532,1533,1534,1535,1536)  
update #tResumenOperativo set solo_titulo=1 where id_concepto in (1500,1504,1506,1520,1527)



delete from #tResumenOperativo where id_concepto in (1515,1524,1525) and isNull(monto_total,0) = 0


--if @anio >= 2016
--	delete from #tResumenOperativo where id_concepto = 61

--update #tResumenOperativo
--set permite_captura = 0
--where id_concepto = 55

--update #tResumenOperativo
--set fondo_custom = 'azul_1'
--where id_concepto in (73, 1437)

select id,
	id_concepto,
	descripcion,
	monto_emp1 = convert(int,round(isNull(monto_emp1,0),0)),
	monto_emp3 = convert(int,round(isNull(monto_emp3,0),0)),
	monto_emp4 = convert(int,round(isNull(monto_emp4,0),0)),
	monto_emp7 = convert(int,round(isNull(monto_emp7,0),0)),
	monto_emp8 = convert(int,round(isNull(monto_emp8,0),0)),
	monto_emp9 = convert(int,round(isNull(monto_emp9,0),0)),
	monto_emp10 = convert(int,round(isNull(monto_emp10,0),0)),
	monto_emp12 = convert(int,round(isNull(monto_emp12,0),0)),
	monto_emp13 = convert(int,round(isNull(monto_emp13,0),0)),
	monto_total = convert(int,round(isNull(monto_total,0),0)),
	es_porcentaje,
	es_multivalor,
	permite_captura,
	separador_despues,
	fondo_custom,
	bordes_1,
	bordes_2,
	solo_titulo
from #tResumenOperativo
order by id


create table #grafica_flujo_efectivo_nuevo
(
	id int,
	descripcion varchar(128),
	valor int,
	orden int
)

insert into #grafica_flujo_efectivo_nuevo values (1,'Caja Final Dic/{{anio_pasado}}',0,1)
insert into #grafica_flujo_efectivo_nuevo values (2,'Utilidad Neta',0,2)
insert into #grafica_flujo_efectivo_nuevo values (3,'Depreciación y Amortización',0,3)
insert into #grafica_flujo_efectivo_nuevo values (4,'Partidas Contables',0,4)
insert into #grafica_flujo_efectivo_nuevo values (5,'Capital de Trabajo',0,5)
insert into #grafica_flujo_efectivo_nuevo values (6,'Inversión',0,6)
insert into #grafica_flujo_efectivo_nuevo values (7,'Financiamiento',0,7)
insert into #grafica_flujo_efectivo_nuevo values (8,'Caja Final {{mes}}/{{anio}}',0,8)

UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{anio_pasado}}', (@anio-1)) where descripcion like '%{{anio_pasado}}%'
UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{anio}}', @anio) where descripcion like '%{{anio}}%'
UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{mes}}', left(dbo.fn_nombre_mes(@periodo),3)) where descripcion like '%{{mes}}%'


--update #grafica_flujo_efectivo_nuevo
--set valor = isNull((select top 1 
--						(case 
--							when @periodo=1 then monto2
--							when @periodo=2 then monto3
--							when @periodo=3 then monto4 
--							when @periodo=4 then monto5 
--							when @periodo=5 then monto6 
--							when @periodo=6 then monto7 
--							when @periodo=7 then monto8 
--							when @periodo=8 then monto9 
--							when @periodo=9 then monto10 
--							when @periodo=10 then monto11 
--							when @periodo=11 then monto12
--							when @periodo=12 then monto13
--						 end)
--					from #tBalanceGeneralDatosExtra 
--					where id=26),0)
--where id = 1

--update #grafica_flujo_efectivo_nuevo
--set valor = isNull((select top 1 monto1 from #tBalanceGeneralDatosExtra where id=26),0)
--where id = 8


update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1534)),0) where id=1
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1501)),0) where id=2
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1502,1503)),0) where id=3
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1505,1507,1508,1509,1510)),0) where id=4
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1512,1513,1514,1515,1516,1517)),0) where id=5
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1521,1522,1523,1524,1525,1563)),0) where id=6
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1528,1529,1530,1531,1644)),0) where id=7
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1535)),0) where id=8

/* 
 select *
 from concepto
 where id_reporte=1014
 */

select *
from #grafica_flujo_efectivo_nuevo
order by orden


  
drop table #tResumenOperativo
drop table #grafica_flujo_efectivo_nuevo
go



go
ALTER procedure [dbo].[reporte_ejecutivo_21]  
 @anio int,  
 @periodo int  
as  
  
/*
exec reporte_ejecutivo_21 2018, 10

declare  @anio int,
 @periodo int

select  @anio = 2018,
		@periodo = 10
 */

set nocount on  
  
create table #tResumenOperativo  
(  
 id int identity(1,1),  
 id_concepto int,  
 id_concepto_plan int,  
 descripcion varchar(152),  
 monto_emp2 decimal(18,2),  
 monto_emp3 decimal(18,2),  
 monto_emp4 decimal(18,2),  
 monto_emp5 decimal(18,2),  
 monto_emp6 decimal(18,2),  
 monto_emp9 decimal(18,2),  
 monto_emp10 decimal(18,2),
 monto_emp12 decimal(18,2),  --LB 20150805: Se agrego la empresa 12
 monto_emp13 decimal(18,2), 
 monto_total decimal(18,2),  
 es_porcentaje bit,  
 es_multivalor bit,  
 permite_captura bit,  
 separador_despues bit default(0),
 solo_titulo bit default(0)
)  
  
insert into #tResumenOperativo (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)  
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0  
from concepto c
where id_reporte = 1014
and es_plan = 0
and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
and (c.anio_alta is null or (convert(varchar(8),c.anio_alta) + '-' + right('0' + convert(varchar(8),c.periodo_alta),2) <= convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
order by orden  



  
--LB 20150805: Se agrego la empresa 12  
update ro  
set monto_emp2 = x.monto_emp2,   
 monto_emp3 = x.monto_emp3,   
 monto_emp4 = x.monto_emp4,   
 monto_emp5 = x.monto_emp5,   
 monto_emp6 = x.monto_emp6,   
 monto_emp9 = x.monto_emp9,   
 monto_emp10 = x.monto_emp10,
 monto_emp12 = x.monto_emp12,
 monto_emp13 = x.monto_emp13
from #tResumenOperativo ro  
join (  
 select ro.id,  
  monto_emp2 = sum((case when rc.anio=@anio and rc.id_empresa=7 then isNull(rc.monto,0) else 0 end)), --Nutec Europe  
  monto_emp3 = sum((case when rc.anio=@anio and rc.id_empresa in (1,8) then isNull(rc.monto,0) else 0 end)), --Nutec Fibratec SA de CV   + Formado al Vacio  
  monto_emp4 = sum((case when rc.anio=@anio and rc.id_empresa=9 then isNull(rc.monto,0) else 0 end)), --Nutec IBAR  
  monto_emp5 = sum((case when rc.anio=@anio and rc.id_empresa=10 then isNull(rc.monto,0) else 0 end)), --Nutec Procal  
  monto_emp6 = sum((case when rc.anio=@anio and rc.id_empresa in (3,4) then isNull(rc.monto,0) else 0 end)), --Nutec Bickley SA de CV y Nutec Bickley Asia  
  monto_emp9 = sum((case when rc.anio=@anio and rc.id_empresa=6 then isNull(rc.monto,0) else 0 end)), --Nutec Corporativo SA de CV  
  monto_emp10 = sum((case when rc.anio=@anio and rc.id_empresa=11 then isNull(rc.monto,0) else 0 end)), --Grupo Nutec  
  monto_emp12 = sum((case when rc.anio=@anio and rc.id_empresa=12 then isNull(rc.monto,0) else 0 end)), --Nutec USA  
  monto_emp13 = sum((case when rc.anio=@anio and rc.id_empresa=13 then isNull(rc.monto,0) else 0 end)) --NPC
 from #tResumenOperativo ro  
 join reporte_captura rc on rc.id_concepto = ro.id_concepto  
 where rc.anio in (@anio)  
 and rc.periodo = @periodo  
 group by ro.id) as x on x.id = ro.id  
  



--update t
--set monto_emp2 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=7 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp3 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa in (1,8) and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp4 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=9 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp5 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=10 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp6 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa in (3,4) and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp9 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=6 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp10 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=11 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp12 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (1364,1371) and t2.id_empresa=12 and t2.periodo=@periodo and t2.anio=@anio)
--from #tResumenOperativo t
--where id_concepto = 1370

--update t
--set monto_emp2 = (select sum(monto_emp2) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp3 = (select sum(monto_emp3) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp4 = (select sum(monto_emp4) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp5 = (select sum(monto_emp5) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp6 = (select sum(monto_emp6) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp9 = (select sum(monto_emp9) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp10 = (select sum(monto_emp10) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386)),
--	monto_emp12 = (select sum(monto_emp12) from #tResumenOperativo t2 where t2.id_concepto in (55,56,1370,61,60,1386))
--from #tResumenOperativo t
--where id_concepto = 1372

--update t
--set monto_emp2 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=7 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp3 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa in (1,8) and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp4 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=9 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp5 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=10 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp6 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa in (3,4) and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp9 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=6 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp10 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=11 and t2.periodo=@periodo and t2.anio=@anio),
--	monto_emp12 = (select sum(monto) from reporte_captura t2 where t2.id_concepto in (57,58,59) and t2.id_empresa=12 and t2.periodo=@periodo and t2.anio=@anio)
--from #tResumenOperativo t
--where id_concepto = 1373

--update t
--set monto_emp2 = (select sum(monto_emp2) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp3 = (select sum(monto_emp3) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp4 = (select sum(monto_emp4) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp5 = (select sum(monto_emp5) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp6 = (select sum(monto_emp6) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp9 = (select sum(monto_emp9) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp10 = (select sum(monto_emp10) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373)),
--	monto_emp12 = (select sum(monto_emp12) from #tResumenOperativo t2 where t2.id_concepto in (1372,1373))
--from #tResumenOperativo t
--where id_concepto = 62


--update t
--set monto_emp2 = (select sum(monto_emp2) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp3 = (select sum(monto_emp3) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp4 = (select sum(monto_emp4) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp5 = (select sum(monto_emp5) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp6 = (select sum(monto_emp6) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp9 = (select sum(monto_emp9) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp10 = (select sum(monto_emp10) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71)),
--	monto_emp12 = (select sum(monto_emp12) from #tResumenOperativo t2 where t2.id_concepto in (62,70,71))
--from #tResumenOperativo t
--where id_concepto = 72


--update t
--set monto_emp2 = (select sum(monto_emp2) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp2) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp3 = (select sum(monto_emp3) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp3) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp4 = (select sum(monto_emp4) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp4) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp5 = (select sum(monto_emp5) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp5) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp6 = (select sum(monto_emp6) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp6) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp9 = (select sum(monto_emp9) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp9) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp10 = (select sum(monto_emp10) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp10) from #tResumenOperativo t2 where t2.id_concepto in (71)),
--	monto_emp12 = (select sum(monto_emp12) from #tResumenOperativo t2 where t2.id_concepto in (72))-(select sum(monto_emp12) from #tResumenOperativo t2 where t2.id_concepto in (71))
--from #tResumenOperativo t
--where id_concepto = 73




update #tResumenOperativo set descripcion = '&nbsp;&nbsp;&nbsp;' + descripcion where id_concepto in (1507,1508,1518,1526,1532)
  
  
update #tResumenOperativo  
set monto_total = isNull(monto_emp2,0) + isNull(monto_emp3,0) + isNull(monto_emp4,0) +   
      isNull(monto_emp5,0) + isNull(monto_emp6,0) + isNull(monto_emp9,0) +  
      isNull(monto_emp10,0) + isNull(monto_emp12,0) + isNull(monto_emp13,0)
  
  
  
--GRAFICA DE FLUJO DE EFECTIVO -- UFAIR  
--IF OBJECT_ID('tempdb..#tGraficaFlujoEfectivo') IS NOT NULL  
-- BEGIN  
-- update #tGraficaFlujoEfectivo   
-- set valor = (SELECT isNull(monto_total,0)  
--     FROM #tResumenOperativo WHERE id_concepto=63)  
-- where orden=8  
  
-- update #tGraficaFlujoEfectivo   
-- set valor = (SELECT sum(isNull(monto_total,0))  
--     FROM #tResumenOperativo WHERE id_concepto in (67,68,69))  
-- where orden=9  
  
-- update #tGraficaFlujoEfectivo   
-- set valor = valor + (SELECT sum(isNull(valor,0))*-1  
--     FROM #tGraficaFlujoEfectivo WHERE orden in (3))  
-- where orden=9  
  
-- update #tGraficaFlujoEfectivo   
-- set valor = (SELECT sum(isNull(monto_total,0))  
--     FROM #tResumenOperativo WHERE id_concepto in (64,65,66))  
-- where orden=7  
  
-- update #tGraficaFlujoEfectivo   
-- set valor = (SELECT sum(isNull(monto_total,0))  
--       FROM #tResumenOperativo WHERE id_concepto in (72))  
-- where orden=10  
  
-- update #tGraficaFlujoEfectivo   
-- set valor = valor + (SELECT sum(isNull(monto_total,0))  
--       FROM #tResumenOperativo WHERE id_concepto in (57,58,59,60,61,1386)) --RM:20130811--,60))   --RM:20160202--,61))  
-- where orden=5  
-- END


update #tResumenOperativo set permite_captura=0 where id_concepto in (1501)  
update #tResumenOperativo set permite_captura=1 where id_concepto in (1504,1506,1535)  
update #tResumenOperativo set separador_despues=1 where id_concepto in (1500,1501,1503,1510,1511,1517,1518,1519,1520,1522,1525,1526,1527,1531,1532,1533,1534,1535,1536)  
update #tResumenOperativo set solo_titulo=1 where id_concepto in (1500,1504,1506,1520,1527)

 -- IF OBJECT_ID('tempdb..#tBalanceGeneralDatosExtra') IS NOT NULL  
 --  BEGIN  
	---- cnt
	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((
	--					select sum(isNull(monto_total,0))
	--					from #tResumenOperativo  
	--					where id_concepto in (57,58,59,60,61)
	--					),0)
	--where orden = 8




	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((select sum(isNull(monto_total,0))*-1
	--					from #tResumenOperativo where id_concepto in (58)),0)*-1 where orden = 25

	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((select sum(isNull(monto_total,0))*-1
	--					from #tResumenOperativo where id_concepto in (59)),0)*-1 where orden = 26

	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((select sum(isNull(monto_total,0))*-1
	--					from #tResumenOperativo where id_concepto in (60)),0)*-1 where orden = 27

	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((select sum(isNull(monto_total,0))*-1
	--					from #tResumenOperativo where id_concepto in (61)),0)*-1 where orden = 28

	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((select sum(isNull(monto_total,0))*-1
	--					from #tResumenOperativo where id_concepto in (57)),0)*-1 where orden = 29





	---- capex
	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((
	--					select sum(isNull(monto_total,0))
	--					from #tResumenOperativo  
	--					where id_concepto in (63)
	--					),0)
	--where orden = 9
	

	---- pago de deuda
	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((
	--					select sum(isNull(monto_total,0))
	--					from #tResumenOperativo  
	--					where id_concepto in (67,68)
	--					),0)
	--where orden = 10

	---- pago de deuda
	--update #tGraficaFlujoEfectivoNuevo
	--set valor = isNull((
	--					select sum(isNull(monto_total,0))
	--					from #tResumenOperativo  
	--					where id_concepto in (64)
	--					),0)
	--where orden = 11
	

 --  END

delete from #tResumenOperativo where id_concepto in (1515,1524,1525) and isNull(monto_total,0) = 0
  
--LB 20150805: Se agrego la empresa 12  
select id,  
 id_concepto,  
 descripcion,  
 monto_emp2 = convert(int,round(isNull(monto_emp2,0),0)),  
 monto_emp3 = convert(int,round(isNull(monto_emp3,0),0)),  
 monto_emp4 = convert(int,round(isNull(monto_emp4,0),0)),  
 monto_emp5 = convert(int,round(isNull(monto_emp5,0),0)),  
 monto_emp6 = convert(int,round(isNull(monto_emp6,0),0)),  
 monto_emp9 = convert(int,round(isNull(monto_emp9,0),0)),  
 monto_emp10 = convert(int,round(isNull(monto_emp10,0),0)),  
 monto_emp12 = convert(int,round(isNull(monto_emp12,0),0)),  
 monto_emp13 = convert(int,round(isNull(monto_emp13,0),0)),  
 monto_total = convert(int,round(isNull(monto_total,0),0)),  
 es_porcentaje,  
 es_multivalor,  
 permite_captura,  
 separador_despues,
 solo_titulo
from #tResumenOperativo  
order by id  



create table #grafica_flujo_efectivo_nuevo
(
	id int,
	descripcion varchar(128),
	valor int,
	orden int
)

insert into #grafica_flujo_efectivo_nuevo values (1,'Caja Final Dic/{{anio_pasado}}',0,1)
insert into #grafica_flujo_efectivo_nuevo values (2,'Utilidad Neta',0,2)
insert into #grafica_flujo_efectivo_nuevo values (3,'Depreciación y Amortización',0,3)
insert into #grafica_flujo_efectivo_nuevo values (4,'Partidas Contables',0,4)
insert into #grafica_flujo_efectivo_nuevo values (5,'Capital de Trabajo',0,5)
insert into #grafica_flujo_efectivo_nuevo values (6,'Inversión',0,6)
insert into #grafica_flujo_efectivo_nuevo values (7,'Financiamiento',0,7)
insert into #grafica_flujo_efectivo_nuevo values (8,'Caja Final {{mes}}/{{anio}}',0,8)

UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{anio_pasado}}', (@anio-1)) where descripcion like '%{{anio_pasado}}%'
UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{anio}}', @anio) where descripcion like '%{{anio}}%'
UPDATE #grafica_flujo_efectivo_nuevo SET descripcion = replace(descripcion, '{{mes}}', left(dbo.fn_nombre_mes(@periodo),3)) where descripcion like '%{{mes}}%'


--update #grafica_flujo_efectivo_nuevo
--set valor = isNull((select top 1 
--						(case 
--							when @periodo=1 then monto2
--							when @periodo=2 then monto3
--							when @periodo=3 then monto4 
--							when @periodo=4 then monto5 
--							when @periodo=5 then monto6 
--							when @periodo=6 then monto7 
--							when @periodo=7 then monto8 
--							when @periodo=8 then monto9 
--							when @periodo=9 then monto10 
--							when @periodo=10 then monto11 
--							when @periodo=11 then monto12
--							when @periodo=12 then monto13
--						 end)
--					from #tBalanceGeneralDatosExtra 
--					where id=26),0)
--where id = 1

--update #grafica_flujo_efectivo_nuevo
--set valor = isNull((select top 1 monto1 from #tBalanceGeneralDatosExtra where id=26),0)
--where id = 8


update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1534)),0) where id=1
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1501)),0) where id=2
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1502,1503)),0) where id=3
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1505,1507,1508,1509,1510)),0) where id=4
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1518)),0) where id=5
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1521,1522,1523,1524,1525,1563)),0) where id=6
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1528,1529,1530,1531,1644)),0) where id=7
update #grafica_flujo_efectivo_nuevo set valor = isnull((select sum(monto_total) from #tResumenOperativo where id_concepto in (1535)),0) where id=8

/* 
 select *
 from concepto
 where id_reporte=1014
 */

select *
from #grafica_flujo_efectivo_nuevo
order by orden

  
drop table #tResumenOperativo  
drop table #grafica_flujo_efectivo_nuevo



go

go

go