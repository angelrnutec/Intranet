go

set identity_insert reporte on
go
insert into reporte (id_reporte, nombre, descripcion, es_plan, tipo_reporte, es_activo) values (1015,'Cuadre Intercompañias v2','Cuadre Intercompañias v2',0,1,1)
go
set identity_insert reporte off
go

set identity_insert [concepto] on
go
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1610,'','Total',1015,NULL,100,0,0,NULL,0,0,0,0,0,0,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1611,'','Nutec Europe',1015,NULL,10,1610,0,NULL,1,0,0,1,0,7,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1612,'','Nutec Fibratec SA de CV',1015,NULL,20,1610,0,NULL,1,0,0,1,0,8,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1613,'','Nutec IBAR',1015,NULL,30,1610,0,NULL,1,0,0,1,0,9,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1614,'','Nutec Procal',1015,NULL,40,1610,0,NULL,1,0,0,1,0,10,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1615,'','Grupo Nutec S.A. de C.V.',1015,NULL,50,1610,0,NULL,1,0,0,0,0,11,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1616,'','Nutec Bickley SA de CV',1015,NULL,60,1610,0,NULL,1,0,0,0,1,3,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1617,'','Nutec Bickley Asia',1015,NULL,70,1610,0,NULL,1,0,0,0,1,4,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1618,'','Nutec Corporativo SA de CV',1015,NULL,80,1610,0,'',1,0,0,0,0,6,'',NULL,NULL,0,'','',NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1619,'','Ref. Balance General',1015,NULL,110,0,0,NULL,0,0,0,0,0,0,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
INSERT INTO [concepto] ([id_concepto],[clave],[descripcion],[id_reporte],[id_grupo],[orden],[id_padre],[resta],[formula_especial],[permite_captura],[es_separador],[es_plan],[es_fibras],[es_hornos],[id_empresa],[descripcion_2],[anio_baja],[periodo_baja],[es_borrado],[referencia],[referencia2],[referencia3],[anio_alta],[periodo_alta])VALUES(1620,'','Nutec USA',1015,NULL,90,1610,0,NULL,1,0,0,0,1,12,'',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL)
go
set identity_insert [concepto] off
go


go

go
CREATE function [dbo].[fn_cuadre_inter_reporte_operativas_fiscales](
											@tipo			varchar(3),
											@id_concepto	int,
											@id_empresa_1	int,
											@id_empresa_2	int,
											@anio			int,
											@periodo		int,
											@es_operativa bit,
											@es_fiscal bit
											)
returns int
as
  begin
	declare @resultado int
	
	if @tipo in ('COB', 'PAG')
	  begin
		select @resultado = case 
								when @tipo = 'COB' and @es_operativa=1 then isNull(monto1,0)
								when @tipo = 'COB' and @es_fiscal=1 then isNull(monto3,0)
								when @tipo = 'PAG' and @es_operativa=1 then isNull(monto2,0)
								when @tipo = 'PAG' and @es_fiscal=1 then isNull(monto4,0)
								else 0
							end
		from reporte_captura
		where id_reporte = 1015
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa_2
		and id_concepto = @id_concepto
	  end
	else
	  begin
		declare @id_concepto_valida int
		select @id_concepto_valida = id_concepto
		from concepto
		where id_reporte = 1015
		and id_empresa = @id_empresa_2
		
		select @resultado = dbo.fn_cuadre_inter_reporte_operativas_fiscales('COB',@id_concepto,@id_empresa_1,@id_empresa_2, @anio, @periodo, @es_operativa, @es_fiscal)
						  - dbo.fn_cuadre_inter_reporte_operativas_fiscales('PAG',@id_concepto_valida,@id_empresa_2,@id_empresa_1, @anio, @periodo, @es_operativa, @es_fiscal)
	  
	  end
  
	if @id_empresa_1 = @id_empresa_2
		select @resultado = -999999
  
	return isNull(@resultado,0)
  end

go




go
CREATE procedure [dbo].[recupera_reporte_cuadre_inter_matriz]
	@id_reporte int,
	@id_empresa int,
	@anio		int,
	@periodo	int,
	@operativa_fiscal varchar(16)
as


set nocount on

--declare	@id_reporte int,
--	@id_empresa int,
--	@anio		int,
--	@periodo	int,
--	@operativa_fiscal varchar(16)

--select 	@id_reporte = 10,
--	@id_empresa = -99,
--	@anio		= 2020,
--	@periodo	= 2,
--	@operativa_fiscal = 'operativa'



declare @es_operativa bit=0,
		@es_fiscal bit=0

if @operativa_fiscal = 'operativa'
	select @es_operativa=1
else
	select @es_fiscal=1

--select @operativa_fiscal, @es_operativa, @es_fiscal

	create table #tReporteSum
	(
		id int identity(1,1),
		id_concepto int,
		id_empresa	int,
		descripcion varchar(512),
		empresa_7 int,
		empresa_8 int,
		empresa_9 int,
		empresa_10 int,
		empresa_11 int,
		empresa_3 int,
		empresa_4 int,
		empresa_6 int,
		empresa_12 int,
		suma	int,
		tipo	varchar(3),
		separador	bit default(0)
	)
	
	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (0,0,'POR COBRAR','COB',1)

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
	select id_concepto, id_empresa, descripcion,'COB'
	from concepto
	where id_reporte = 1015
	and id_empresa > 0
	order by orden

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (1,1,'TOTALES','COB',1)

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (0,0,'POR PAGAR','PAG',1)

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
	select id_concepto, id_empresa, descripcion,'PAG'
	from concepto
	where id_reporte = 1015
	and id_empresa > 0
	order by orden

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (1,1,'TOTALES','PAG',1)

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (0,0,'VARIACIONES','VAR',1)

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
	select id_concepto, id_empresa, descripcion,'VAR'
	from concepto
	where id_reporte = 1015
	and id_empresa > 0
	order by orden

	insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
						values (1,1,'TOTALES','VAR',1)

	update #tReporteSum
	set empresa_7 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 7, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_8 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 8, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_9 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 9, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_10 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 10, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_11 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 11, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_3 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 3, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_4 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 4, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_6 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 6, @anio, @periodo, @es_operativa, @es_fiscal),
		empresa_12 = dbo.fn_cuadre_inter_reporte_operativas_fiscales(tipo,id_concepto, id_empresa, 12, @anio, @periodo, @es_operativa, @es_fiscal)
	where separador = 0


	update #tReporteSum set empresa_7=null  where empresa_7=-999999
	update #tReporteSum set empresa_8=null  where empresa_8=-999999
	update #tReporteSum set empresa_9=null  where empresa_9=-999999
	update #tReporteSum set empresa_10=null where empresa_10=-999999
	update #tReporteSum set empresa_11=null where empresa_11=-999999
	update #tReporteSum set empresa_3=null  where empresa_3=-999999
	update #tReporteSum set empresa_4=null  where empresa_4=-999999
	update #tReporteSum set empresa_6=null  where empresa_6=-999999
	update #tReporteSum set empresa_12=null  where empresa_12=-999999


	update #tReporteSum set suma=isNull(empresa_7,0) +
								isNull(empresa_8,0) +
								isNull(empresa_9,0) +
								isNull(empresa_10,0) +
								isNull(empresa_11,0) +
								isNull(empresa_3,0) +
								isNull(empresa_4,0) +
								isNull(empresa_6,0) +
								isNull(empresa_12,0)	


	update rs
	set empresa_7 = sum_empresa_7,
		empresa_8 = sum_empresa_8,
		empresa_9 = sum_empresa_9,
		empresa_10 = sum_empresa_10,
		empresa_11 = sum_empresa_11,
		empresa_3 = sum_empresa_3,
		empresa_4 = sum_empresa_4,
		empresa_6 = sum_empresa_6,
		empresa_12 = sum_empresa_12,
		suma = sum_suma
	from #tReporteSum rs
	join (
		select sum_empresa_7 = sum(empresa_7),
				sum_empresa_8 = sum(empresa_8),
				sum_empresa_9 = sum(empresa_9),
				sum_empresa_10 = sum(empresa_10),
				sum_empresa_11 = sum(empresa_11),
				sum_empresa_3 = sum(empresa_3),
				sum_empresa_4 = sum(empresa_4),
				sum_empresa_6 = sum(empresa_6),
				sum_empresa_12 = sum(empresa_12),
				sum_suma = sum(suma)
		from #tReporteSum
		where tipo = 'COB'
		and separador=0
		) x on 1=1
	where rs.descripcion = 'TOTALES'
	and tipo = 'COB'


	update rs
	set empresa_7 = sum_empresa_7,
		empresa_8 = sum_empresa_8,
		empresa_9 = sum_empresa_9,
		empresa_10 = sum_empresa_10,
		empresa_11 = sum_empresa_11,
		empresa_3 = sum_empresa_3,
		empresa_4 = sum_empresa_4,
		empresa_6 = sum_empresa_6,
		empresa_12 = sum_empresa_12,
		suma = sum_suma
	from #tReporteSum rs
	join (
		select sum_empresa_7 = sum(empresa_7),
				sum_empresa_8 = sum(empresa_8),
				sum_empresa_9 = sum(empresa_9),
				sum_empresa_10 = sum(empresa_10),
				sum_empresa_11 = sum(empresa_11),
				sum_empresa_3 = sum(empresa_3),
				sum_empresa_4 = sum(empresa_4),
				sum_empresa_6 = sum(empresa_6),
				sum_empresa_12 = sum(empresa_12),
				sum_suma = sum(suma)
		from #tReporteSum
		where tipo = 'PAG'
		and separador=0
		) x on 1=1
	where rs.descripcion = 'TOTALES'
	and tipo = 'PAG'



	update rs
	set empresa_7 = sum_empresa_7,
		empresa_8 = sum_empresa_8,
		empresa_9 = sum_empresa_9,
		empresa_10 = sum_empresa_10,
		empresa_11 = sum_empresa_11,
		empresa_3 = sum_empresa_3,
		empresa_4 = sum_empresa_4,
		empresa_6 = sum_empresa_6,
		empresa_12 = sum_empresa_12,
		suma = sum_suma
	from #tReporteSum rs
	join (
		select sum_empresa_7 = sum(empresa_7),
				sum_empresa_8 = sum(empresa_8),
				sum_empresa_9 = sum(empresa_9),
				sum_empresa_10 = sum(empresa_10),
				sum_empresa_11 = sum(empresa_11),
				sum_empresa_3 = sum(empresa_3),
				sum_empresa_4 = sum(empresa_4),
				sum_empresa_6 = sum(empresa_6),
				sum_empresa_12 = sum(empresa_12),
				sum_suma = sum(suma)
		from #tReporteSum
		where tipo = 'VAR'
		and separador=0
		) x on 1=1
	where rs.descripcion = 'TOTALES'
	and tipo = 'VAR'

	select *
	from #tReporteSum
	order by id

	drop table #tReporteSum



go

go
set identity_insert pagina on
go
insert into pagina (id_pagina, id_tipo_pagina, permiso, pagina, descripcion, orden, icono, visible) 
			values (91,2,'repfin','RepFinancieros.aspx?r=1015', 'Cuadre de Intercompañias v2',170,'icon-table icon-large',1)
go
set identity_insert pagina off

go
insert into perfil_pagina values (2,91)
go

go

go

go

go
set identity_insert configuracion on 
go
insert into configuracion (id, descripcion, llave, valor, id_empresa) values (5,'Inicio de Cuadre Intercompañias V2','inicio-cuadre-intercompanias-v2','20200601',0)
go
set identity_insert configuracion off
go

go


go
ALTER procedure [dbo].[recupera_reporte_datos]    
 @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
as    

/*
declare @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
    
select  @id_reporte =2,    
 @id_empresa =8,    
 @anio  =2017,    
 @periodo =10
*/    
    
create table #reporte_captura    
(    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 referencia2 varchar(32)
)    
    
create table #reporte_captura_fin    
(    
 id int identity(1,1),    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 autollenado bit default(0),
 referencia2 varchar(32)
)

if @id_reporte = 2 and @id_empresa = 12
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where (c.id_reporte = 2 or (c.id_reporte = 14 and c.id_concepto = 361))  --RM: 20160225 - Gastos Preoperativos NUSA
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden
end
else
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where c.id_reporte = @id_reporte    
		and (c.es_plan = 0 or @id_empresa = -1)    
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0    
		order by c.orden   
 end
    
    
    
    
    
 /* OBTENER PRONOSTICO DE FLUJO DE EFECTIVO DEL MES ANTERIOR */    
 if @id_reporte = 5    
   begin    
  declare @periodo_ant int,    
    @anio_periodo_ant int    
    
  if @periodo = 1    
   select @periodo_ant = 12, @anio_periodo_ant = @anio-1    
  else    
   select @periodo_ant = @periodo-1, @anio_periodo_ant = @anio    
    
    
  update trc    
  --set monto_pron_mes_ant = isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
  set monto_pron_mes_ant = (case when rc.id_concepto=94 then isnull(rc.monto1,0)    
          when rc.id_concepto=111 then isnull(rc.monto5,0)    
          else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
         end)    
  from #reporte_captura trc    
  join reporte_captura rc    
   on rc.id_concepto = trc.id_concepto    
  where rc.anio = @anio_periodo_ant    
  and rc.periodo = @periodo_ant    
  and rc.id_empresa = @id_empresa    
    
   end    
    
    
update rc    
set tipo_distribucion = 'Manual'    
from #reporte_captura rc    
join reporte_plan_distribucion rpc on rpc.id_reporte=rc.id_reporte    
          and rpc.id_empresa=rc.id_empresa    
          and rpc.anio=rc.anio    
          and rpc.periodo=rc.periodo    
          and rpc.id_concepto=rc.id_concepto    
    
    
update rc    
set tipo_distribucion = 'Auto'    
from #reporte_captura rc    
where rc.tipo_distribucion is null    
    
    
    
    
    
if @id_reporte = 7 --PERFIL DE DEUDA    
  begin    
 update #reporte_captura_fin    
 set monto_total = monto_total - monto6    
    
insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,    
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion, referencia2)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion, referencia2
 from #reporte_captura    
 where id_empresa_concepto = @id_empresa    
 order by orden    
      
 select *    
 from #reporte_captura_fin    
 order by orden    
  end    
else if @id_reporte = 10 --CUADRE INTERCOMPANIES    
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 1015 --CUADRE INTERCOMPANIES V2
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 13 --CAPITAL DE TRABAJO  
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 order by orden    
    
  declare @monto_sugerido decimal(18,2)  
        
  select @monto_sugerido = monto   
  from reporte_captura where id_concepto in (41,45,281)
  and anio = @anio    
  and periodo = @periodo    
  and id_empresa = @id_empresa    
  
  select @monto_sugerido = isnull(@monto_sugerido,0)
    
  update #reporte_captura_fin  
  set monto_dec = @monto_sugerido,  
  monto = @monto_sugerido  
  where id_concepto = 348  
  and monto = 0  


    
 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end 
else    
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura
 order by orden    
    
    

/********************* INICIO DEL AUTOLLENADO *********************/
	if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1) and @periodo>0
	begin
			if dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa) = 'A' -- SI EL PERIODO ESTA ABIERO
			  begin
					if @id_reporte = 2 -- ESTADO DE RESULTADOS
					  begin
							declare @ventas_monto int, @ventas_fibra int, @ventas_fv int, @ventas_sat int, @ventas_comercial int

							select @ventas_monto = sum(monto),
									@ventas_fibra = sum(monto1),
									@ventas_fv = sum(monto2),
									@ventas_sat = sum(monto3),
									@ventas_comercial = sum(monto4)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 4
							and id_concepto in (86)



							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@ventas_monto,0),
								monto = isNull(@ventas_monto,0),
								monto1 = isNull(@ventas_fibra,0),
								monto2 = isNull(@ventas_fv,0),
								monto3 = isNull(@ventas_sat,0),
								monto4 = isNull(@ventas_comercial,0),
								autollenado = 1
							where id_concepto = 37

					  end


					else if @id_reporte in (3, 1014) -- FLUJO DE EFECTIVO
					  begin
							declare @fe_utilidad_neta int, @fe_depreciacion int

							select @fe_utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)

							select @fe_depreciacion = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (53)
				

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 55

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 56

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 1501

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 1502

					  end

					else if @id_reporte = 1 -- BALANCE GENERAL
					  begin
							--if exists(select 1 from #c where id_concepto = 37 and monto_total = 0) -- NO SE HA CAPTURADO ANTES
							declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

							select @utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@utilidad_neta,0),
								monto = isNull(@utilidad_neta,0),
								autollenado = 1
							where id_concepto = 34

							

							--RM:INICIO CUADRE INTERCOMPAÑIAS V2
							declare @FECHA_INICIO_CUADRE_V2 DATETIME,
									@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
							SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


							if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
							  begin
									select @cuadre1 = sum(monto1),
											@cuadre2 = sum(monto2),
											@cuadre3 = sum(monto3),
											@cuadre4 = sum(monto4)
									from reporte_captura
									where anio = @anio
									and periodo = @periodo
									and id_empresa = @id_empresa
									and id_reporte = 1015
									and id_concepto in (1610)
							  end
							else
							  begin
									select @cuadre1 = sum(monto1),
											@cuadre2 = sum(monto2),
											@cuadre3 = sum(monto3),
											@cuadre4 = sum(monto4)
									from reporte_captura
									where anio = @anio
									and periodo = @periodo
									and id_empresa = @id_empresa
									and id_reporte = 10
									and id_concepto in (266)
							  end

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@cuadre1,0),
								monto = isNull(@cuadre1,0),
								autollenado = 1
							where id_concepto = 3

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@cuadre2,0),
								monto = isNull(@cuadre2,0),
								autollenado = 1
							where id_concepto = 14

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@cuadre3,0),
								monto = isNull(@cuadre3,0),
								autollenado = 1
							where id_concepto = 20

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@cuadre4,0),
								monto = isNull(@cuadre4,0),
								autollenado = 1
							where id_concepto = 27


							select @proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (322,323)

							select @clientes = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (334,335,350,351)

							select @inventario = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (332)

							select @anticipo_proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (1420)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@proveedores,0),
								monto = isNull(@proveedores,0),
								autollenado = 1
							where id_concepto = 18

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@clientes,0),
								monto = isNull(@clientes,0),
								autollenado = 1
							where id_concepto = 2

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@inventario,0),
								monto = isNull(@inventario,0),
								autollenado = 1
							where id_concepto = 4

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@anticipo_proveedores,0),
								monto = isNull(@anticipo_proveedores,0),
								autollenado = 1
							where id_concepto = 8


					  end

			  end

	end



/********************* FIN DEL AUTOLLENADO *********************/
    
    
 select *    
 from #reporte_captura_fin    
 order by orden    
end    
    
 select comentarios    
 from reporte_captura_encabezado    
 where id_reporte = @id_reporte    
 and id_empresa = @id_empresa    
 and anio = @anio    
 and periodo = @periodo    
    
select estatus = dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa), alerta_actualizacion = dbo.fn_alerta_actualizacion_reporte(@anio,@periodo,@id_empresa,@id_reporte)
    
    
if @id_reporte in (3, 1014)    
  begin    
    
	 declare @valor_resultado int    
	 exec reporte_ejecutivo_7_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@valor_resultado=@valor_resultado output    
    
    
	 declare @resultado_x int    
     
	 if @id_empresa in (3,4,5,6,1014)    
	  --HORNOS (3,4,5,6)    
	  exec reporte_ejecutivo_4_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
	 else    
	  --FIBRAS (8,1,10,9,7,12)  --LB 20150805: Se agrego la empresa 12  
	  exec reporte_ejecutivo_5_fex @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
    
	 select saldo_caja=isNull(@valor_resultado,0),utilidad_neta=isNull(@resultado_x,0)    
      
  end    
    
if @id_reporte=10    
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
else if @id_reporte=1015
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
    
    
drop table #reporte_captura    
drop table #reporte_captura_fin    


go


go

ALTER procedure dbo.recalcula_balance_general
	@id_empresa int,
	@anio int,
	@periodo int
as
/*
select @id_empresa = 8,
		@anio = 2017,
		@periodo = 10
*/

declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

select @utilidad_neta = sum(monto)
from reporte_captura
where anio = @anio
and periodo <= @periodo
and id_empresa = @id_empresa
and id_reporte = 2
and id_concepto in (52)

UPDATE reporte_captura
set monto = isNull(@utilidad_neta,0)
where id_concepto = 34
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1




--RM:INICIO CUADRE INTERCOMPAÑIAS V2
declare @FECHA_INICIO_CUADRE_V2 DATETIME,
		@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1015
		and id_concepto in (1610)
	end
else
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 10
		and id_concepto in (266)
	end


UPDATE reporte_captura
set monto = isNull(@cuadre1,0)
where id_concepto = 3
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1



UPDATE reporte_captura
set monto = isNull(@cuadre2,0)
where id_concepto = 14
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@cuadre3,0)
where id_concepto = 20
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@cuadre4,0)
where id_concepto = 27
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


select @proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (322,323)

select @clientes = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (334,335,350,351)

select @inventario = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (332)

select @anticipo_proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (1420)


UPDATE reporte_captura
set monto = isNull(@proveedores,0)
where id_concepto = 18
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@clientes,0)
where id_concepto = 2
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@inventario,0)
where id_concepto = 4
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@anticipo_proveedores,0)
where id_concepto = 8
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


exec reporte_calculos_totales @id_empresa, 1, @anio, @periodo, 1



go





go


go


go

go
alter procedure [dbo].[recupera_reporte_final]
	@id_reporte int,
	@id_empresa int,
	@anio int
as
/*
declare 	@id_reporte int = 2,
	@id_empresa int = -13,
	@anio int = 2017
*/


set nocount on

create table #tEmpresas
(
	id_empresa int,
	es_fibras bit,
	es_hornos bit
)

insert into #tEmpresas (id_empresa, es_fibras, es_hornos)
select id_empresa, es_fibras, es_hornos
from empresa

if @id_empresa > 0
	delete from #tEmpresas where id_empresa <> @id_empresa
else if @id_empresa = -2
	delete from #tEmpresas where es_fibras <> 1
else if @id_empresa = -3
	delete from #tEmpresas where es_hornos <> 1

create table #tPeriodosSinDatos
(
	periodo int
)

insert into #tPeriodosSinDatos values (1)
insert into #tPeriodosSinDatos values (2)
insert into #tPeriodosSinDatos values (3)
insert into #tPeriodosSinDatos values (4)
insert into #tPeriodosSinDatos values (5)
insert into #tPeriodosSinDatos values (6)
insert into #tPeriodosSinDatos values (7)
insert into #tPeriodosSinDatos values (8)
insert into #tPeriodosSinDatos values (9)
insert into #tPeriodosSinDatos values (10)
insert into #tPeriodosSinDatos values (11)
insert into #tPeriodosSinDatos values (12)


delete from #tPeriodosSinDatos
where periodo in (select distinct rc.periodo
					from reporte_captura rc 
					where rc.anio = @anio
					and rc.id_empresa in (select id_empresa from #tEmpresas)
					and rc.id_reporte = @id_reporte)


create table #tReporte
(
	id_empresa	int,
	id_concepto int,
	clave varchar(64),
	descripcion varchar(256),
	id_padre	int,
	orden		int,
	permite_captura bit,
	es_separador bit,
	monto1	int,
	monto2	int,
	monto3	int,
	monto4	int,
	monto5	int,
	monto6	int,
	monto7	int,
	monto8	int,
	monto9	int,
	monto10	int,
	monto11	int,
	monto12	int,
	monto_total int
)


create table #reporte_captura
(
	id_concepto int,
	monto	int,
	periodo int,
	id_empresa int,
	id_reporte int,
	anio int
)

if @id_reporte = 5
  begin

	insert into #reporte_captura (id_concepto, monto, periodo, id_empresa, id_reporte, anio)
	select id_concepto, monto_real_mes_ant, periodo-1, id_empresa, id_reporte, anio
	from reporte_captura rc 
	where rc.anio = @anio
	and rc.id_empresa in (select id_empresa from #tEmpresas)
	and rc.id_reporte = @id_reporte

	delete from #reporte_captura
	where periodo = 0
	
	
	insert into #reporte_captura (id_concepto, monto, periodo, id_empresa, id_reporte, anio)
	select id_concepto, monto_real_mes_ant, 12, id_empresa, id_reporte, anio
	from reporte_captura rc 
	where rc.anio = @anio+1
	and rc.periodo=1
	and rc.id_empresa in (select id_empresa from #tEmpresas)
	and rc.id_reporte = @id_reporte
	

  end
else
 begin
    if @id_empresa in (-11,-12,-13,-14)
	 begin
		insert into #reporte_captura (id_concepto, monto, periodo, id_empresa, id_reporte, anio)
		select id_concepto, 
				monto = (case 
							when @anio < 2017 then 0
							when @id_empresa = -11 then monto1
							when @id_empresa = -12 then monto2
							when @id_empresa = -13 then monto3
							when @id_empresa = -14 then monto4
							else 0
						 end), 
				periodo, 
				id_empresa, 
				id_reporte, 
				anio
		from reporte_captura rc
		where rc.anio = @anio
		and rc.id_empresa in (select id_empresa from #tEmpresas)
		and (rc.id_reporte = @id_reporte
			or (@id_reporte = 2 and rc.id_reporte = 14 and rc.id_concepto = 361))
		and rc.periodo > 0
	 end
	else
	 begin
		insert into #reporte_captura (id_concepto, monto, periodo, id_empresa, id_reporte, anio)
		select id_concepto, monto, periodo, id_empresa, id_reporte, anio
		from reporte_captura rc
		where rc.anio = @anio
		and rc.id_empresa in (select id_empresa from #tEmpresas)
		and (rc.id_reporte = @id_reporte
			or (@id_reporte = 2 and rc.id_reporte = 14 and rc.id_concepto = 361))
	 end
  end




			/* ACTUALIZAR SUMAS Y RESTAS POR INTERCOMPANIES */
			if @id_reporte = 4
	 		  begin

					if @anio < 2017
					 BEGIN
							update rc
							set monto = (case 
											 when e.tipo_intercompanies=1 and c.descripcion = 'Intercompanies NUSA NP NI NE' then rc.monto * -1  
											 when e.tipo_intercompanies=2 and c.descripcion = 'Intercompanies NB' then rc.monto * 1  
											 when e.tipo_intercompanies=3 and c.descripcion = 'Intercompanies NF' then rc.monto * 1  
											else monto
										 end)
							from #reporte_captura rc
							join concepto c on c.id_concepto = rc.id_concepto
							join empresa e on e.id_empresa = rc.id_empresa
							where rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio
							and c.descripcion like '%Intercompanies%'


					
							--PRIMER NETO
							update rc
							set monto = (case 
											 when e.tipo_intercompanies=1 then x.monto1+x.monto4-x.monto2
											 when e.tipo_intercompanies=2 then x.monto1+x.monto3
											 when e.tipo_intercompanies=3 then x.monto1+x.monto2-x.monto4
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto=79 then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto=78 then monto else 0 end),
										 monto3 = sum(case when rc.id_concepto=77 then monto else 0 end),  
										 monto4 = sum(case when rc.id_concepto=1367 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (79,78,77,1367)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 80
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio

							--SEGUNDO NETO
							update rc
							set monto = (case 
											 when e.tipo_intercompanies=1 then x.monto1+x.monto4-x.monto2
											 when e.tipo_intercompanies=2 then x.monto1+x.monto3
											 when e.tipo_intercompanies=3 then x.monto1+x.monto2-x.monto4
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto=86 then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto=85 then monto else 0 end),
										 monto3 = sum(case when rc.id_concepto=84 then monto else 0 end),  
										 monto4 = sum(case when rc.id_concepto=1368 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (86,85,84,1368)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 87
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio
					

							--TERCER NETO
							update rc
							set monto = (case 
											 when e.tipo_intercompanies=1 then x.monto1+x.monto4-x.monto2
											 when e.tipo_intercompanies=2 then x.monto1+x.monto3
											 when e.tipo_intercompanies=3 then x.monto1+x.monto2-x.monto4
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto=92 then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto=112 then monto else 0 end),
										 monto3 = sum(case when rc.id_concepto=91 then monto else 0 end),  
										 monto4 = sum(case when rc.id_concepto=1369 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (92,112,91,1369)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 93
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio

					 END
					ELSE
					 BEGIN

							update rc
							set monto = (case 
											 when e.es_fibras=1 and c.descripcion in ('Intercompanies NUSA','Intercompanies NP','Intercompanies NI','Intercompanies NE') then rc.monto * 1
											 when e.es_hornos=1 and c.descripcion = 'Intercompanies NB' then rc.monto * 1  
											else monto
										 end)
							from #reporte_captura rc
							join concepto c on c.id_concepto = rc.id_concepto
							join empresa e on e.id_empresa = rc.id_empresa
							where rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio
							and c.descripcion like '%Intercompanies%'

					
							--PRIMER NETO
							update rc
							set monto = (case 
											 when e.es_fibras=1 then x.monto1-x.monto2
											 when e.es_hornos=1 then x.monto1-x.monto3
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto in (79) then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto in (78,1387,1388,1389,1390) then monto else 0 end), 
										 monto3 = sum(case when rc.id_concepto=77 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (77,78,79,1387,1388,1389,1390)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 80
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio

							--SEGUNDO NETO
							update rc
							set monto = (case 
											 when e.es_fibras=1 then x.monto1-x.monto2
											 when e.es_hornos=1 then x.monto1-x.monto3
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto in (86) then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto in (85,1391,1392,1393,1394) then monto else 0 end), 
										 monto3 = sum(case when rc.id_concepto=84 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (84,86,1391,1392,1393,1394)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 87
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio
					

							--TERCER NETO
							update rc
							set monto = (case 
											 when e.es_fibras=1 then x.monto1-x.monto2
											 when e.es_hornos=1 then x.monto1-x.monto3
											else x.monto1
										 end)
							from #reporte_captura rc
							join empresa e on e.id_empresa = rc.id_empresa
							join (select rc.id_empresa,
										 periodo,
										 monto1 = sum(case when rc.id_concepto in (92) then monto else 0 end), 
										 monto2 = sum(case when rc.id_concepto in (112,1395,1396,1397,1398) then monto else 0 end), 
										 monto3 = sum(case when rc.id_concepto=91 then monto else 0 end)
									from #reporte_captura rc
									where rc.id_concepto in (92,112,1395,1396,1397,1398)
									and rc.id_empresa in (select id_empresa from #tEmpresas)
									and rc.id_reporte = @id_reporte
									--and rc.periodo = @periodo
									and rc.anio = @anio
									group by rc.id_empresa, rc.periodo) as x ON x.id_empresa = rc.id_empresa and x.periodo = rc.periodo
							where rc.id_concepto = 93
							and rc.id_empresa in (select id_empresa from #tEmpresas)
							and rc.id_reporte = @id_reporte
							--and rc.periodo = @periodo
							and rc.anio = @anio
					 END





			  end















insert into #tReporte (id_concepto, clave, descripcion, id_padre, orden, 
						permite_captura, es_separador,
						monto1, monto2, monto3, monto4, monto5, monto6, 
						monto7, monto8, monto9, monto10, monto11, monto12,
						monto_total)
select c.id_concepto, 
		c.clave,
		c.descripcion,
		c.id_padre,
		c.orden,
		c.permite_captura,
		c.es_separador,
		monto1 = sum((case when periodo=1 then isnull(rc.monto,0)
						else 0
					  end)),
		monto2 = sum((case when periodo=2 then isnull(rc.monto,0)
						else 0
					  end)),
		monto3 = sum((case when periodo=3 then isnull(rc.monto,0)
						else 0
					  end)),
		monto4 = sum((case when periodo=4 then isnull(rc.monto,0)
						else 0
					  end)),
		monto5 = sum((case when periodo=5 then isnull(rc.monto,0)
						else 0
					  end)),
		monto6 = sum((case when periodo=6 then isnull(rc.monto,0)
						else 0
					  end)),
		monto7 = sum((case when periodo=7 then isnull(rc.monto,0)
						else 0
					  end)),
		monto8 = sum((case when periodo=8 then isnull(rc.monto,0)
						else 0
					  end)),
		monto9 = sum((case when periodo=9 then isnull(rc.monto,0)
						else 0
					  end)),
		monto10 = sum((case when periodo=10 then isnull(rc.monto,0)
						else 0
					  end)),
		monto11 = sum((case when periodo=11 then isnull(rc.monto,0)
						else 0
					  end)),
		monto12 = sum((case when periodo=12 then isnull(rc.monto,0)
						else 0
					  end)),
		monto_total = sum(isnull(rc.monto,0))
from concepto c
join #reporte_captura rc 
		on rc.id_concepto = c.id_concepto
where (c.id_reporte = @id_reporte
		or (@id_reporte = 2 and c.id_reporte = 14 and c.id_concepto = 361))
group by c.id_concepto, c.clave, c.descripcion, c.id_padre, c.orden, c.permite_captura, c.es_separador
order by c.orden




select * 
from #tReporte
order by orden

select monto1 = sum(monto1),
		monto2 = sum(monto2),
		monto3 = sum(monto3),
		monto4 = sum(monto4),
		monto5 = sum(monto5),
		monto6 = sum(monto6),
		monto7 = sum(monto7),
		monto8 = sum(monto8),
		monto9 = sum(monto9),
		monto10 = sum(monto10),
		monto11 = sum(monto11),
		monto12 = sum(monto12),
		monto_total = sum(monto_total)
from #tReporte


declare @datos1 bit,
		@datos2 bit,
		@datos3 bit,
		@datos4 bit,
		@datos5 bit,
		@datos6 bit,
		@datos7 bit,
		@datos8 bit,
		@datos9 bit,
		@datos10 bit,
		@datos11 bit,
		@datos12 bit

select @datos1 = case when sum(monto1)>0 then 1 else 0 end,
		@datos2 = case when sum(monto2)>0 then 1 else 0 end,
		@datos3 = case when sum(monto3)>0 then 1 else 0 end,
		@datos4 = case when sum(monto4)>0 then 1 else 0 end,
		@datos5 = case when sum(monto5)>0 then 1 else 0 end,
		@datos6 = case when sum(monto6)>0 then 1 else 0 end,
		@datos7 = case when sum(monto7)>0 then 1 else 0 end,
		@datos8 = case when sum(monto8)>0 then 1 else 0 end,
		@datos9 = case when sum(monto9)>0 then 1 else 0 end,
		@datos10 = case when sum(monto10)>0 then 1 else 0 end,
		@datos11 = case when sum(monto11)>0 then 1 else 0 end,
		@datos12 = case when sum(monto12)>0 then 1 else 0 end
from #tReporte

select *
from #tPeriodosSinDatos

drop table #tReporte
drop table #tPeriodosSinDatos
drop table #reporte_captura
drop table #tEmpresas



if @id_reporte=3
  begin
	create table #tGraficaFlujoEfectivo
	(
		id	int identity(1,1),
		descripcion	varchar(256),
		valor int,
		valor1 int,
		valor2 int,
		valor3 int,
		valor4 int,
		valor5 int,
		valor6 int,
		valor7 int,
		valor8 int,
		valor9 int,
		valor10 int,
		valor11 int,
		valor12 int,
		orden int
	)
	exec recupera_flujo_efectivo_validacion @anio, 12, @id_empresa
	
	update #tGraficaFlujoEfectivo set valor1=0 where @datos1=0
	update #tGraficaFlujoEfectivo set valor2=0 where @datos2=0
	update #tGraficaFlujoEfectivo set valor3=0 where @datos3=0
	update #tGraficaFlujoEfectivo set valor4=0 where @datos4=0
	update #tGraficaFlujoEfectivo set valor5=0 where @datos5=0
	update #tGraficaFlujoEfectivo set valor6=0 where @datos6=0
	update #tGraficaFlujoEfectivo set valor7=0 where @datos7=0
	update #tGraficaFlujoEfectivo set valor8=0 where @datos8=0
	update #tGraficaFlujoEfectivo set valor9=0 where @datos9=0
	update #tGraficaFlujoEfectivo set valor10=0 where @datos10=0
	update #tGraficaFlujoEfectivo set valor11=0 where @datos11=0
	update #tGraficaFlujoEfectivo set valor12=0 where @datos12=0

	select descripcion, valor, valor1, valor2, valor3, valor4, valor5, valor6,
			valor7, valor8, valor9, valor10, valor11, valor12, orden 
	from #tGraficaFlujoEfectivo 
	where orden in (5)
	order by orden

	update #tGraficaFlujoEfectivo set descripcion='Capital de Trabajo Gráfica' where orden=12
	select descripcion, valor, valor1, valor2, valor3, valor4, valor5, valor6,
			valor7, valor8, valor9, valor10, valor11, valor12, orden 
	from #tGraficaFlujoEfectivo 
	where orden in (11,12)
	order by orden

	drop table #tGraficaFlujoEfectivo
  end


go


go

ALTER procedure [dbo].[recupera_reporte_datos]    
 @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
as    

/*
declare @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
    
select  @id_reporte =2,    
 @id_empresa =8,    
 @anio  =2017,    
 @periodo =10
*/    
    
create table #reporte_captura    
(    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 referencia2 varchar(32)
)    
    
create table #reporte_captura_fin    
(    
 id int identity(1,1),    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 autollenado bit default(0),
 referencia2 varchar(32)
)

if @id_reporte = 2 and @id_empresa = 12
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where (c.id_reporte = 2 or (c.id_reporte = 14 and c.id_concepto = 361))  --RM: 20160225 - Gastos Preoperativos NUSA
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden
end
else
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where c.id_reporte = @id_reporte    
		and (c.es_plan = 0 or @id_empresa = -1)    
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0    
		order by c.orden   
 end
    
    
    
    
    
 /* OBTENER PRONOSTICO DE FLUJO DE EFECTIVO DEL MES ANTERIOR */    
 if @id_reporte = 5    
   begin    
  declare @periodo_ant int,    
    @anio_periodo_ant int    
    
  if @periodo = 1    
   select @periodo_ant = 12, @anio_periodo_ant = @anio-1    
  else    
   select @periodo_ant = @periodo-1, @anio_periodo_ant = @anio    
    
    
  update trc    
  --set monto_pron_mes_ant = isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
  set monto_pron_mes_ant = (case when rc.id_concepto=94 then isnull(rc.monto1,0)    
          when rc.id_concepto=111 then isnull(rc.monto5,0)    
          else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
         end)    
  from #reporte_captura trc    
  join reporte_captura rc    
   on rc.id_concepto = trc.id_concepto    
  where rc.anio = @anio_periodo_ant    
  and rc.periodo = @periodo_ant    
  and rc.id_empresa = @id_empresa    
    
   end    
    
    
update rc    
set tipo_distribucion = 'Manual'    
from #reporte_captura rc    
join reporte_plan_distribucion rpc on rpc.id_reporte=rc.id_reporte    
          and rpc.id_empresa=rc.id_empresa    
          and rpc.anio=rc.anio    
          and rpc.periodo=rc.periodo    
          and rpc.id_concepto=rc.id_concepto    
    
    
update rc    
set tipo_distribucion = 'Auto'    
from #reporte_captura rc    
where rc.tipo_distribucion is null    
    
    
    
    
    
if @id_reporte = 7 --PERFIL DE DEUDA    
  begin    
 update #reporte_captura_fin    
 set monto_total = monto_total - monto6    
    
insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,    
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion, referencia2)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion, referencia2
 from #reporte_captura    
 where id_empresa_concepto = @id_empresa    
 order by orden    
      
 select *    
 from #reporte_captura_fin    
 order by orden    
  end    
else if @id_reporte = 10 --CUADRE INTERCOMPANIES    
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 1015 --CUADRE INTERCOMPANIES V2
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 13 --CAPITAL DE TRABAJO  
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 order by orden    
    
  declare @monto_sugerido decimal(18,2)  
        
  select @monto_sugerido = monto   
  from reporte_captura where id_concepto in (41,45,281)
  and anio = @anio    
  and periodo = @periodo    
  and id_empresa = @id_empresa    
  
  select @monto_sugerido = isnull(@monto_sugerido,0)
    
  update #reporte_captura_fin  
  set monto_dec = @monto_sugerido,  
  monto = @monto_sugerido  
  where id_concepto = 348  
  and monto = 0  


    
 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end 
else    
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura
 order by orden    
    
    

/********************* INICIO DEL AUTOLLENADO *********************/
	if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1) and @periodo>0
	begin
			if dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa) = 'A' -- SI EL PERIODO ESTA ABIERO
			  begin
					if @id_reporte = 2 -- ESTADO DE RESULTADOS
					  begin
							declare @ventas_monto int, @ventas_fibra int, @ventas_fv int, @ventas_sat int, @ventas_comercial int

							select @ventas_monto = sum(monto),
									@ventas_fibra = sum(monto1),
									@ventas_fv = sum(monto2),
									@ventas_sat = sum(monto3),
									@ventas_comercial = sum(monto4)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 4
							and id_concepto in (86)



							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@ventas_monto,0),
								monto = isNull(@ventas_monto,0),
								monto1 = isNull(@ventas_fibra,0),
								monto2 = isNull(@ventas_fv,0),
								monto3 = isNull(@ventas_sat,0),
								monto4 = isNull(@ventas_comercial,0),
								autollenado = 1
							where id_concepto = 37

					  end


					else if @id_reporte in (3, 1014) -- FLUJO DE EFECTIVO
					  begin
							declare @fe_utilidad_neta int, @fe_depreciacion int

							select @fe_utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)

							select @fe_depreciacion = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (53)
				

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 55

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 56

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 1501

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 1502

					  end

					else if @id_reporte = 1 -- BALANCE GENERAL
					  begin
							--if exists(select 1 from #c where id_concepto = 37 and monto_total = 0) -- NO SE HA CAPTURADO ANTES
							declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

							select @utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@utilidad_neta,0),
								monto = isNull(@utilidad_neta,0),
								autollenado = 1
							where id_concepto = 34

							

							--RM:INICIO CUADRE INTERCOMPAÑIAS V2
							declare @FECHA_INICIO_CUADRE_V2 DATETIME,
									@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
							SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')



							if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
							  begin

										select @cuadre1 = sum(monto1) + sum(monto3),
												@cuadre2 = sum(monto2) + sum(monto4),
												@cuadre3 = 0,
												@cuadre4 = 0
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 1015
										and id_concepto in (1610)

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 20
										
							  end
							else
							  begin


										select @cuadre1 = sum(monto1),
												@cuadre2 = sum(monto2),
												@cuadre3 = sum(monto3),
												@cuadre4 = sum(monto4)
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 10
										and id_concepto in (266)


										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 14

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre3,0),
											monto = isNull(@cuadre3,0),
											autollenado = 1
										where id_concepto = 20

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre4,0),
											monto = isNull(@cuadre4,0),
											autollenado = 1
										where id_concepto = 27
							  end



							select @proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (322,323)

							select @clientes = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (334,335,350,351)

							select @inventario = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (332)

							select @anticipo_proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (1420)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@proveedores,0),
								monto = isNull(@proveedores,0),
								autollenado = 1
							where id_concepto = 18

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@clientes,0),
								monto = isNull(@clientes,0),
								autollenado = 1
							where id_concepto = 2

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@inventario,0),
								monto = isNull(@inventario,0),
								autollenado = 1
							where id_concepto = 4

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@anticipo_proveedores,0),
								monto = isNull(@anticipo_proveedores,0),
								autollenado = 1
							where id_concepto = 8


					  end

			  end

	end



/********************* FIN DEL AUTOLLENADO *********************/
    
    
 select *    
 from #reporte_captura_fin    
 order by orden    
end    
    
 select comentarios    
 from reporte_captura_encabezado    
 where id_reporte = @id_reporte    
 and id_empresa = @id_empresa    
 and anio = @anio    
 and periodo = @periodo    
    
select estatus = dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa), alerta_actualizacion = dbo.fn_alerta_actualizacion_reporte(@anio,@periodo,@id_empresa,@id_reporte)
    
    
if @id_reporte in (3, 1014)    
  begin    
    
	 declare @valor_resultado int    
	 exec reporte_ejecutivo_7_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@valor_resultado=@valor_resultado output    
    
    
	 declare @resultado_x int    
     
	 if @id_empresa in (3,4,5,6,1014)    
	  --HORNOS (3,4,5,6)    
	  exec reporte_ejecutivo_4_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
	 else    
	  --FIBRAS (8,1,10,9,7,12)  --LB 20150805: Se agrego la empresa 12  
	  exec reporte_ejecutivo_5_fex @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
    
	 select saldo_caja=isNull(@valor_resultado,0),utilidad_neta=isNull(@resultado_x,0)    
      
  end    
    
if @id_reporte=10    
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
else if @id_reporte=1015
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
    
    
drop table #reporte_captura    
drop table #reporte_captura_fin    

go


go
alter procedure dbo.recalcula_balance_general
	@id_empresa int,
	@anio int,
	@periodo int
as
/*
select @id_empresa = 8,
		@anio = 2017,
		@periodo = 10
*/

declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

select @utilidad_neta = sum(monto)
from reporte_captura
where anio = @anio
and periodo <= @periodo
and id_empresa = @id_empresa
and id_reporte = 2
and id_concepto in (52)

UPDATE reporte_captura
set monto = isNull(@utilidad_neta,0)
where id_concepto = 34
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1




--RM:INICIO CUADRE INTERCOMPAÑIAS V2
declare @FECHA_INICIO_CUADRE_V2 DATETIME,
		@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1015
		and id_concepto in (1610)
	end
else
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 10
		and id_concepto in (266)
	end


UPDATE reporte_captura
set monto = isNull(@cuadre1,0)
where id_concepto = 3
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1



UPDATE reporte_captura
set monto = isNull(@cuadre2,0)
where id_concepto = 14
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@cuadre3,0)
where id_concepto = 20
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@cuadre4,0)
where id_concepto = 27
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


select @proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (322,323)

select @clientes = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (334,335,350,351)

select @inventario = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (332)

select @anticipo_proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (1420)


UPDATE reporte_captura
set monto = isNull(@proveedores,0)
where id_concepto = 18
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@clientes,0)
where id_concepto = 2
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@inventario,0)
where id_concepto = 4
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@anticipo_proveedores,0)
where id_concepto = 8
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


exec reporte_calculos_totales @id_empresa, 1, @anio, @periodo, 1





go


go


go
alter procedure dbo.recalcula_balance_general
	@id_empresa int,
	@anio int,
	@periodo int
as
/*
select @id_empresa = 8,
		@anio = 2017,
		@periodo = 10
*/

declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

select @utilidad_neta = sum(monto)
from reporte_captura
where anio = @anio
and periodo <= @periodo
and id_empresa = @id_empresa
and id_reporte = 2
and id_concepto in (52)

UPDATE reporte_captura
set monto = isNull(@utilidad_neta,0)
where id_concepto = 34
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1




--RM:INICIO CUADRE INTERCOMPAÑIAS V2
declare @FECHA_INICIO_CUADRE_V2 DATETIME,
		@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
	begin
			select @cuadre1 = sum(monto1) + sum(monto3),
					@cuadre2 = sum(monto2) + sum(monto4),
					@cuadre3 = 0,
					@cuadre4 = 0
			from reporte_captura
			where anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1015
			and id_concepto in (1610)


			UPDATE reporte_captura
			set monto = isNull(@cuadre1,0)
			where id_concepto = 3
			and anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1

		
			UPDATE reporte_captura
			set monto = isNull(@cuadre2,0)
			where id_concepto = 20
			and anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1
	end
else
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 10
		and id_concepto in (266)



		UPDATE reporte_captura
		set monto = isNull(@cuadre1,0)
		where id_concepto = 3
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1



		UPDATE reporte_captura
		set monto = isNull(@cuadre2,0)
		where id_concepto = 14
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

		UPDATE reporte_captura
		set monto = isNull(@cuadre3,0)
		where id_concepto = 20
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

		UPDATE reporte_captura
		set monto = isNull(@cuadre4,0)
		where id_concepto = 27
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

	end





select @proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (322,323)

select @clientes = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (334,335,350,351)

select @inventario = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (332)

select @anticipo_proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (1420)


UPDATE reporte_captura
set monto = isNull(@proveedores,0)
where id_concepto = 18
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@clientes,0)
where id_concepto = 2
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@inventario,0)
where id_concepto = 4
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@anticipo_proveedores,0)
where id_concepto = 8
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


exec reporte_calculos_totales @id_empresa, 1, @anio, @periodo, 1







go

ALTER procedure dbo.valida_permiso_para_capturar_reporte_financiero
	@id_reporte int,
	@id_empresa int,
	@anio int,
	@periodo int
as

declare @respuesta varchar(512) = ''

if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1)
begin

	if @id_reporte in (3,1014)  -- flujo de efectivo
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=1) < 5 -- balance general
			if @id_empresa <> 12
				select @respuesta='Para capturar "Flujo de Efectivo" se requiere capturar primero "Balance General"'
			else
				select @respuesta='In order to enter data for "Cash Flow" it is required to capture "Balance Sheet" first'
	  end
	else if @id_reporte = 1  -- balance general
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=13) < 5 -- Capital de Trabajo
			if @id_empresa <> 12
				select @respuesta='Para capturar "Balance General" se requiere capturar primero "Capital de Trabajo"'
			else
				select @respuesta='In order to enter data for "Balance Sheet" it is required to capture "Working Capital" first'
	  end
	else if @id_reporte = 13  -- Capital de Trabajo
	  begin

		--RM:INICIO CUADRE INTERCOMPAÑIAS V2
		declare @FECHA_INICIO_CUADRE_V2 DATETIME,
				@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
		SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


		if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
			begin
					if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=1015) < 5 -- Cuadre Intercompañias
						if @id_empresa <> 12
							select @respuesta='Para capturar "Capital de Trabajo" se requiere capturar primero "Cuadre Intercompañias v2"'
						else
							select @respuesta='In order to enter data for "Working Capital" it is required to capture "Intercompanies balance" first'
			end
		else
			begin
					if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=10) < 5 -- Cuadre Intercompañias
						if @id_empresa <> 12
							select @respuesta='Para capturar "Capital de Trabajo" se requiere capturar primero "Cuadre Intercompañias"'
						else
							select @respuesta='In order to enter data for "Working Capital" it is required to capture "Intercompanies balance" first'
			end

	  end
	else if @id_reporte in (10,1015)  -- Cuadre Intercompañias
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=2) < 5 -- Estado de Resultados
			if @id_empresa <> 12
				select @respuesta='Para capturar "Cuadre Intercompañias" se requiere capturar primero "Estado de Resultados"'
			else
				select @respuesta='In order to enter data for "Intercompanies balance" it is required to capture "Income Statement" first'
	  end
	else if @id_reporte = 2  -- Estado de Resultados
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=4) < 5 -- Estado de Resultados
			if @id_empresa <> 12
				select @respuesta='Para capturar "Estado de Resultados" se requiere capturar primero "Pedidos y Facturación"'
			else
				select @respuesta='In order to enter data for "Income Statement" it is required to capture "Orders and Invoices" first'
	  end

end

select @respuesta as respuesta



go


go

create procedure [dbo].[recupera_comparacion_cuadre_intercompanies_v2]
	@anio int,
	@periodo int,
	@id_empresa int
as

/*
select @anio=2013, 
		@periodo=9,
		@id_empresa=10
*/


create table #tReporte
(
	id_empresa int,
	empresa varchar(512),
	monto1	int,
	monto2	int,
	monto3	int,
	monto4	int
)

insert into #tReporte (id_empresa, empresa, monto1, monto2, monto3, monto4)
select e.id_empresa,
		empresa = e.nombre,
		monto3,
		monto4,
		monto1,
		monto2
from reporte_captura rc
join empresa e on e.id_empresa = rc.id_empresa
join concepto c on c.id_concepto = rc.id_concepto
where rc.id_reporte=1015
and rc.anio = @anio
and rc.periodo = @periodo
and c.id_empresa = @id_empresa

insert into #tReporte (id_empresa, empresa, monto1, monto2, monto3, monto4)
select e.id_empresa, e.nombre, 0,0,0,0
from concepto c
join empresa e on e.id_empresa = c.id_empresa
where c.id_reporte=1015
and e.id_empresa not in (select id_empresa from #tReporte)


select id_empresa, empresa, monto1, monto2, monto3, monto4, permite_captura=0, es_separador=0
from #tReporte
where id_empresa <> @id_empresa

drop table #tReporte


go


go


go

alter procedure [dbo].[recupera_reporte_datos]    
 @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
as    

/*
declare @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
    
select  @id_reporte =2,    
 @id_empresa =8,    
 @anio  =2017,    
 @periodo =10
*/    
    
create table #reporte_captura    
(    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 referencia2 varchar(32)
)    
    
create table #reporte_captura_fin    
(    
 id int identity(1,1),    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 autollenado bit default(0),
 referencia2 varchar(32)
)

if @id_reporte = 2 and @id_empresa = 12
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where (c.id_reporte = 2 or (c.id_reporte = 14 and c.id_concepto = 361))  --RM: 20160225 - Gastos Preoperativos NUSA
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden
end
else
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where c.id_reporte = @id_reporte    
		and (c.es_plan = 0 or @id_empresa = -1)    
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0    
		order by c.orden   
 end
    
    
    
    
    
 /* OBTENER PRONOSTICO DE FLUJO DE EFECTIVO DEL MES ANTERIOR */    
 if @id_reporte = 5    
   begin    
  declare @periodo_ant int,    
    @anio_periodo_ant int    
    
  if @periodo = 1    
   select @periodo_ant = 12, @anio_periodo_ant = @anio-1    
  else    
   select @periodo_ant = @periodo-1, @anio_periodo_ant = @anio    
    
    
  update trc    
  --set monto_pron_mes_ant = isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
  set monto_pron_mes_ant = (case when rc.id_concepto=94 then isnull(rc.monto1,0)    
          when rc.id_concepto=111 then isnull(rc.monto5,0)    
          else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
         end)    
  from #reporte_captura trc    
  join reporte_captura rc    
   on rc.id_concepto = trc.id_concepto    
  where rc.anio = @anio_periodo_ant    
  and rc.periodo = @periodo_ant    
  and rc.id_empresa = @id_empresa    
    
   end    
    
    
update rc    
set tipo_distribucion = 'Manual'    
from #reporte_captura rc    
join reporte_plan_distribucion rpc on rpc.id_reporte=rc.id_reporte    
          and rpc.id_empresa=rc.id_empresa    
          and rpc.anio=rc.anio    
          and rpc.periodo=rc.periodo    
          and rpc.id_concepto=rc.id_concepto    
    
    
update rc    
set tipo_distribucion = 'Auto'    
from #reporte_captura rc    
where rc.tipo_distribucion is null    
    
    
    
    
    
if @id_reporte = 7 --PERFIL DE DEUDA    
  begin    
 update #reporte_captura_fin    
 set monto_total = monto_total - monto6    
    
insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,    
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion, referencia2)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion, referencia2
 from #reporte_captura    
 where id_empresa_concepto = @id_empresa    
 order by orden    
      
 select *    
 from #reporte_captura_fin    
 order by orden    
  end    
else if @id_reporte = 10 --CUADRE INTERCOMPANIES    
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 1015 --CUADRE INTERCOMPANIES V2
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 13 --CAPITAL DE TRABAJO  
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 order by orden    
    
  declare @monto_sugerido decimal(18,2)  
        
  select @monto_sugerido = monto   
  from reporte_captura where id_concepto in (41,45,281)
  and anio = @anio    
  and periodo = @periodo    
  and id_empresa = @id_empresa    
  
  select @monto_sugerido = isnull(@monto_sugerido,0)
    
  update #reporte_captura_fin  
  set monto_dec = @monto_sugerido,  
  monto = @monto_sugerido  
  where id_concepto = 348  
  and monto = 0  


    
 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end 
else    
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura
 order by orden    
    
    

/********************* INICIO DEL AUTOLLENADO *********************/
	if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1) and @periodo>0
	begin
			if dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa) = 'A' -- SI EL PERIODO ESTA ABIERO
			  begin
					if @id_reporte = 2 -- ESTADO DE RESULTADOS
					  begin
							declare @ventas_monto int, @ventas_fibra int, @ventas_fv int, @ventas_sat int, @ventas_comercial int

							select @ventas_monto = sum(monto),
									@ventas_fibra = sum(monto1),
									@ventas_fv = sum(monto2),
									@ventas_sat = sum(monto3),
									@ventas_comercial = sum(monto4)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 4
							and id_concepto in (86)



							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@ventas_monto,0),
								monto = isNull(@ventas_monto,0),
								monto1 = isNull(@ventas_fibra,0),
								monto2 = isNull(@ventas_fv,0),
								monto3 = isNull(@ventas_sat,0),
								monto4 = isNull(@ventas_comercial,0),
								autollenado = 1
							where id_concepto = 37

					  end


					else if @id_reporte in (3, 1014) -- FLUJO DE EFECTIVO
					  begin
							declare @fe_utilidad_neta int, @fe_depreciacion int

							select @fe_utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)

							select @fe_depreciacion = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (53)
				

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 55

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 56

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 1501

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 1502

					  end

					else if @id_reporte = 1 -- BALANCE GENERAL
					  begin
							--if exists(select 1 from #c where id_concepto = 37 and monto_total = 0) -- NO SE HA CAPTURADO ANTES
							declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

							select @utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@utilidad_neta,0),
								monto = isNull(@utilidad_neta,0),
								autollenado = 1
							where id_concepto = 34

							

							--RM:INICIO CUADRE INTERCOMPAÑIAS V2
							declare @FECHA_INICIO_CUADRE_V2 DATETIME,
									@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
							SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')



							if @FECHA_INICIO_CUADRE_V2 >= @FECHA_PERIODO_ACTUAL
							  begin

										select @cuadre1 = sum(monto1) + sum(monto3),
												@cuadre2 = sum(monto2) + sum(monto4),
												@cuadre3 = 0,
												@cuadre4 = 0
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 1015
										and id_concepto in (1610)

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 20
										
							  end
							else
							  begin


										select @cuadre1 = sum(monto1),
												@cuadre2 = sum(monto2),
												@cuadre3 = sum(monto3),
												@cuadre4 = sum(monto4)
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 10
										and id_concepto in (266)


										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 14

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre3,0),
											monto = isNull(@cuadre3,0),
											autollenado = 1
										where id_concepto = 20

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre4,0),
											monto = isNull(@cuadre4,0),
											autollenado = 1
										where id_concepto = 27
							  end



							select @proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (322,323)

							select @clientes = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (334,335,350,351)

							select @inventario = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (332)

							select @anticipo_proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (1420)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@proveedores,0),
								monto = isNull(@proveedores,0),
								autollenado = 1
							where id_concepto = 18

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@clientes,0),
								monto = isNull(@clientes,0),
								autollenado = 1
							where id_concepto = 2

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@inventario,0),
								monto = isNull(@inventario,0),
								autollenado = 1
							where id_concepto = 4

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@anticipo_proveedores,0),
								monto = isNull(@anticipo_proveedores,0),
								autollenado = 1
							where id_concepto = 8


					  end

			  end

	end



/********************* FIN DEL AUTOLLENADO *********************/
    
    
 select *    
 from #reporte_captura_fin    
 order by orden    
end    
    
 select comentarios    
 from reporte_captura_encabezado    
 where id_reporte = @id_reporte    
 and id_empresa = @id_empresa    
 and anio = @anio    
 and periodo = @periodo    
    
select estatus = dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa), alerta_actualizacion = dbo.fn_alerta_actualizacion_reporte(@anio,@periodo,@id_empresa,@id_reporte)
    
    
if @id_reporte in (3, 1014)    
  begin    
    
	 declare @valor_resultado int    
	 exec reporte_ejecutivo_7_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@valor_resultado=@valor_resultado output    
    
    
	 declare @resultado_x int    
     
	 if @id_empresa in (3,4,5,6,1014)    
	  --HORNOS (3,4,5,6)    
	  exec reporte_ejecutivo_4_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
	 else    
	  --FIBRAS (8,1,10,9,7,12)  --LB 20150805: Se agrego la empresa 12  
	  exec reporte_ejecutivo_5_fex @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
    
	 select saldo_caja=isNull(@valor_resultado,0),utilidad_neta=isNull(@resultado_x,0)    
      
  end    
    
if @id_reporte=10    
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
else if @id_reporte=1015
  exec recupera_comparacion_cuadre_intercompanies_v2 @anio, @periodo, @id_empresa    
    
    
drop table #reporte_captura    
drop table #reporte_captura_fin    



go


go

drop function fn_cuadre_inter_reporte
go
create function [dbo].[fn_cuadre_inter_reporte](
											@id_reporte		int,
											@tipo			varchar(3),
											@id_concepto	int,
											@id_empresa_1	int,
											@id_empresa_2	int,
											@anio			int,
											@periodo		int
											)
returns int
as
  begin
	declare @resultado int
	
	if @tipo in ('COB', 'PAG')
	  begin

		if @id_reporte = 1015
		   begin
				select @resultado = case 
										when @tipo = 'COB' then isNull(monto1,0) + isNull(monto3,0)
										else isNull(monto2,0) + isNull(monto4,0)
									end
				from reporte_captura
				where id_reporte = @id_reporte
				and anio = @anio
				and periodo = @periodo
				and id_empresa = @id_empresa_2
				and id_concepto = @id_concepto
		   end
		else 
		   begin
				select @resultado = case 
										when @tipo = 'COB' then isNull(monto1,0) + isNull(monto2,0)
										else isNull(monto3,0) + isNull(monto4,0)
									end
				from reporte_captura
				where id_reporte = @id_reporte
				and anio = @anio
				and periodo = @periodo
				and id_empresa = @id_empresa_2
				and id_concepto = @id_concepto
		   end
	  end
	else
	  begin
		declare @id_concepto_valida int
		select @id_concepto_valida = id_concepto
		from concepto
		where id_reporte = @id_reporte
		and id_empresa = @id_empresa_2
		
		select @resultado = dbo.fn_cuadre_inter_reporte(@id_reporte,'COB',@id_concepto,@id_empresa_1,@id_empresa_2, @anio, @periodo)
						  - dbo.fn_cuadre_inter_reporte(@id_reporte,'PAG',@id_concepto_valida,@id_empresa_2,@id_empresa_1, @anio, @periodo)
	  
	  end
  
	if @id_empresa_1 = @id_empresa_2
		select @resultado = -999999
  
	return isNull(@resultado,0)
  end

go
alter procedure [dbo].[recupera_reporte_cuadre_inter]
	@id_reporte int,
	@id_empresa int,
	@anio		int,
	@periodo	int
as


set nocount on
/*
declare	@id_reporte int,
	@id_empresa int,
	@anio		int,
	@periodo	int

select 	@id_reporte = 10,
	@id_empresa = -1,
	@anio		= 2015,
	@periodo	= 11
*/

IF @id_empresa > 0
  BEGIN


		create table #reporte_captura
		(
			id_concepto int, 
			clave varchar(64),
			descripcion varchar(256),
			descripcion_2 varchar(256),
			id_padre int,
			permite_captura bit,
			monto_dec	decimal(18,2),
			monto	int,
			monto1	int,
			monto2	int,
			monto3	int,
			monto4	int,
			monto5	int,
			monto6	int,
			monto7	int,
			monto8	int,
			monto9	int,
			monto10	int,
			monto11	int,
			monto_real_mes_ant	int,
			monto_pron_mes_ant	int,
			monto_total	int,
			es_separador bit,
			orden		int,
			id_empresa	int,
			id_empresa_concepto int,
			id_reporte	int,
			periodo		int,
			anio		int,
			es_hornos	bit,
			es_fibras	bit,
			tipo_distribucion varchar(32)
		)

		create table #reporte_captura_fin
		(
			id	int identity(1,1),
			id_concepto int, 
			clave varchar(64),
			descripcion varchar(256),
			descripcion_2 varchar(256),
			id_padre int,
			permite_captura bit,
			monto_dec	decimal(18,2),
			monto	int,
			monto1	int,
			monto2	int,
			monto3	int,
			monto4	int,
			monto5	int,
			monto6	int,
			monto7	int,
			monto8	int,
			monto9	int,
			monto10	int,
			monto11	int,
			monto_real_mes_ant	int,
			monto_pron_mes_ant	int,
			monto_total	int,
			es_separador bit,
			orden		int,
			id_empresa	int,
			id_empresa_concepto int,
			id_reporte	int,
			periodo		int,
			anio		int,
			es_hornos	bit,
			es_fibras	bit,
			tipo_distribucion varchar(32)
		)

		insert into #reporte_captura
		select c.id_concepto, 
				c.clave,
				c.descripcion,
				c.descripcion_2,
				c.id_padre,
				c.permite_captura,
				monto_dec = isnull(rc.monto,0),
				monto = Convert(int,floor(isnull(rc.monto,0))),
				monto1 = isnull(rc.monto1,0),
				monto2 = isnull(rc.monto2,0),
				monto3 = isnull(rc.monto3,0),
				monto4 = isnull(rc.monto4,0),
				monto5 = isnull(rc.monto5,0),
				monto6 = isnull(rc.monto6,0),
				monto7 = isnull(rc.monto7,0),
				monto8 = isnull(rc.monto8,0),
				monto9 = isnull(rc.monto9,0),
				monto10 = isnull(rc.monto10,0),
				monto11 = isnull(rc.monto11,0),
				monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),
				0,
				monto_total = (case 
								when c.id_concepto = 94 then isnull(rc.monto1,0)
								when c.id_concepto = 111 then isnull(rc.monto5,0)
								else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)
							   end),
				c.es_separador,
				c.orden,
				rc.id_empresa,
				c.id_empresa,
				rc.id_reporte,
				rc.periodo,
				rc.anio,
				c.es_hornos,
				c.es_fibras,
				NULL
		from concepto c
		left outer join reporte_captura rc 
						on rc.id_concepto = c.id_concepto
						and rc.anio = @anio
						and rc.periodo = @periodo
						and rc.id_empresa = @id_empresa
		where c.id_reporte = @id_reporte
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden




			insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, 
											monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, 
											monto_real_mes_ant, monto_pron_mes_ant, 
											monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,
											es_hornos, es_fibras, tipo_distribucion)
			select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3, 
					monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant, 
					monto_total, es_separador, orden, id_empresa, 
					id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion
			from #reporte_captura
			where id_empresa_concepto <> @id_empresa
			order by orden


			update #reporte_captura_fin
			set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),
				monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),
				monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),
				monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)
			where descripcion='Ref. Balance General'


			select *
			from #reporte_captura_fin
			order by orden
			


			create table #tReporte
			(
				id_empresa int,
				empresa varchar(512),
				monto1	decimal(18,2),
				monto_dif1	decimal(18,2),
				monto2	decimal(18,2),
				monto_dif2	decimal(18,2),
				monto3	decimal(18,2),
				monto_dif3	decimal(18,2),
				monto4	decimal(18,2),
				monto_dif4	decimal(18,2)
			)

			insert into #tReporte (id_empresa, empresa, monto1, monto2, monto3, monto4)
			select e.id_empresa,
					empresa = e.nombre,
					monto3,
					monto4,
					monto1,
					monto2
			from reporte_captura rc
			join empresa e on e.id_empresa = rc.id_empresa
			join concepto c on c.id_concepto = rc.id_concepto
			where rc.id_reporte=10
			and rc.anio = @anio
			and rc.periodo = @periodo
			and c.id_empresa = @id_empresa

			insert into #tReporte (id_empresa, empresa, monto1, monto2, monto3, monto4)
			select e.id_empresa, e.nombre, 0,0,0,0
			from concepto c
			join empresa e on e.id_empresa = c.id_empresa
			where c.id_reporte=10
			and e.id_empresa not in (select id_empresa from #tReporte)


			update t
			set	monto_dif1 = tcf.monto1 - t.monto1,
				monto_dif2 = tcf.monto2 - t.monto2,
				monto_dif3 = tcf.monto3 - t.monto3,
				monto_dif4 = tcf.monto4 - t.monto4
			from #tReporte t
			join #reporte_captura_fin tcf on tcf.id_empresa_concepto = t.id_empresa


			select id_empresa, 
					empresa, 
					monto1, 
					monto_dif1, 
					monto2, 
					monto_dif2, 
					monto3, 
					monto_dif3, 
					monto4, 
					monto_dif4
			from #tReporte
			where id_empresa <> @id_empresa
			order by empresa


		drop table #tReporte
		drop table #reporte_captura
		drop table #reporte_captura_fin


  
  
  END
ELSE
  BEGIN

		create table #tReporteSum
		(
			id int identity(1,1),
			id_concepto int,
			id_empresa	int,
			descripcion varchar(512),
			empresa_7 int,
			empresa_8 int,
			empresa_9 int,
			empresa_10 int,
			empresa_11 int,
			empresa_3 int,
			empresa_4 int,
			empresa_6 int,
			empresa_12 int,
			suma	int,
			tipo	varchar(3),
			separador	bit default(0)
		)
	
		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (0,0,'POR COBRAR','COB',1)

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
		select id_concepto, id_empresa, descripcion,'COB'
		from concepto
		where id_reporte = 10
		and id_empresa > 0
		order by orden

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (1,1,'TOTALES','COB',1)

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (0,0,'POR PAGAR','PAG',1)

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
		select id_concepto, id_empresa, descripcion,'PAG'
		from concepto
		where id_reporte = 10
		and id_empresa > 0
		order by orden

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (1,1,'TOTALES','PAG',1)

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (0,0,'VARIACIONES','VAR',1)

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo)
		select id_concepto, id_empresa, descripcion,'VAR'
		from concepto
		where id_reporte = 10
		and id_empresa > 0
		order by orden

		insert into #tReporteSum (id_concepto, id_empresa, descripcion, tipo, separador)
							values (1,1,'TOTALES','VAR',1)

		update #tReporteSum
		set empresa_7 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 7, @anio, @periodo),
			empresa_8 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 8, @anio, @periodo),
			empresa_9 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 9, @anio, @periodo),
			empresa_10 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 10, @anio, @periodo),
			empresa_11 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 11, @anio, @periodo),
			empresa_3 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 3, @anio, @periodo),
			empresa_4 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 4, @anio, @periodo),
			empresa_6 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 6, @anio, @periodo),
			empresa_12 = dbo.fn_cuadre_inter_reporte(@id_reporte,tipo,id_concepto, id_empresa, 12, @anio, @periodo)
		where separador = 0


		update #tReporteSum set empresa_7=null  where empresa_7=-999999
		update #tReporteSum set empresa_8=null  where empresa_8=-999999
		update #tReporteSum set empresa_9=null  where empresa_9=-999999
		update #tReporteSum set empresa_10=null where empresa_10=-999999
		update #tReporteSum set empresa_11=null where empresa_11=-999999
		update #tReporteSum set empresa_3=null  where empresa_3=-999999
		update #tReporteSum set empresa_4=null  where empresa_4=-999999
		update #tReporteSum set empresa_6=null  where empresa_6=-999999
		update #tReporteSum set empresa_12=null  where empresa_12=-999999


		update #tReporteSum set suma=isNull(empresa_7,0) +
									isNull(empresa_8,0) +
									isNull(empresa_9,0) +
									isNull(empresa_10,0) +
									isNull(empresa_11,0) +
									isNull(empresa_3,0) +
									isNull(empresa_4,0) +
									isNull(empresa_6,0) +
									isNull(empresa_12,0)	


		update rs
		set empresa_7 = sum_empresa_7,
			empresa_8 = sum_empresa_8,
			empresa_9 = sum_empresa_9,
			empresa_10 = sum_empresa_10,
			empresa_11 = sum_empresa_11,
			empresa_3 = sum_empresa_3,
			empresa_4 = sum_empresa_4,
			empresa_6 = sum_empresa_6,
			empresa_12 = sum_empresa_12,
			suma = sum_suma
		from #tReporteSum rs
		join (
			select sum_empresa_7 = sum(empresa_7),
					sum_empresa_8 = sum(empresa_8),
					sum_empresa_9 = sum(empresa_9),
					sum_empresa_10 = sum(empresa_10),
					sum_empresa_11 = sum(empresa_11),
					sum_empresa_3 = sum(empresa_3),
					sum_empresa_4 = sum(empresa_4),
					sum_empresa_6 = sum(empresa_6),
					sum_empresa_12 = sum(empresa_12),
					sum_suma = sum(suma)
			from #tReporteSum
			where tipo = 'COB'
			and separador=0
			) x on 1=1
		where rs.descripcion = 'TOTALES'
		and tipo = 'COB'


		update rs
		set empresa_7 = sum_empresa_7,
			empresa_8 = sum_empresa_8,
			empresa_9 = sum_empresa_9,
			empresa_10 = sum_empresa_10,
			empresa_11 = sum_empresa_11,
			empresa_3 = sum_empresa_3,
			empresa_4 = sum_empresa_4,
			empresa_6 = sum_empresa_6,
			empresa_12 = sum_empresa_12,
			suma = sum_suma
		from #tReporteSum rs
		join (
			select sum_empresa_7 = sum(empresa_7),
					sum_empresa_8 = sum(empresa_8),
					sum_empresa_9 = sum(empresa_9),
					sum_empresa_10 = sum(empresa_10),
					sum_empresa_11 = sum(empresa_11),
					sum_empresa_3 = sum(empresa_3),
					sum_empresa_4 = sum(empresa_4),
					sum_empresa_6 = sum(empresa_6),
					sum_empresa_12 = sum(empresa_12),
					sum_suma = sum(suma)
			from #tReporteSum
			where tipo = 'PAG'
			and separador=0
			) x on 1=1
		where rs.descripcion = 'TOTALES'
		and tipo = 'PAG'



		update rs
		set empresa_7 = sum_empresa_7,
			empresa_8 = sum_empresa_8,
			empresa_9 = sum_empresa_9,
			empresa_10 = sum_empresa_10,
			empresa_11 = sum_empresa_11,
			empresa_3 = sum_empresa_3,
			empresa_4 = sum_empresa_4,
			empresa_6 = sum_empresa_6,
			empresa_12 = sum_empresa_12,
			suma = sum_suma
		from #tReporteSum rs
		join (
			select sum_empresa_7 = sum(empresa_7),
					sum_empresa_8 = sum(empresa_8),
					sum_empresa_9 = sum(empresa_9),
					sum_empresa_10 = sum(empresa_10),
					sum_empresa_11 = sum(empresa_11),
					sum_empresa_3 = sum(empresa_3),
					sum_empresa_4 = sum(empresa_4),
					sum_empresa_6 = sum(empresa_6),
					sum_empresa_12 = sum(empresa_12),
					sum_suma = sum(suma)
			from #tReporteSum
			where tipo = 'VAR'
			and separador=0
			) x on 1=1
		where rs.descripcion = 'TOTALES'
		and tipo = 'VAR'

		select *
		from #tReporteSum
		order by id

		drop table #tReporteSum

  END



go


go

ALTER procedure [dbo].[recupera_reporte_datos]    
 @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
as    

/*
declare @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
    
select  @id_reporte =2,    
 @id_empresa =8,    
 @anio  =2017,    
 @periodo =10
*/    
    
create table #reporte_captura    
(    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 referencia2 varchar(32)
)    
    
create table #reporte_captura_fin    
(    
 id int identity(1,1),    
 id_concepto int,     
 clave varchar(64),    
 descripcion varchar(256),    
 descripcion_2 varchar(256),    
 id_padre int,    
 permite_captura bit,    
 monto_dec decimal(18,2),    
 monto int,    
 monto1 int,    
 monto2 int,    
 monto3 int,    
 monto4 int,    
 monto5 int,    
 monto6 int,    
 monto7 int,    
 monto8 int,    
 monto9 int,    
 monto10 int,    
 monto11 int,    
 monto_real_mes_ant int,    
 monto_pron_mes_ant int,    
 monto_total int,    
 es_separador bit,    
 orden  int,    
 id_empresa int,    
 id_empresa_concepto int,    
 id_reporte int,    
 periodo  int,    
 anio  int,    
 es_hornos bit,    
 es_fibras bit,    
 tipo_distribucion varchar(32),
 autollenado bit default(0),
 referencia2 varchar(32)
)

if @id_reporte = 2 and @id_empresa = 12
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where (c.id_reporte = 2 or (c.id_reporte = 14 and c.id_concepto = 361))  --RM: 20160225 - Gastos Preoperativos NUSA
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden
end
else
 begin
		insert into #reporte_captura    
		select c.id_concepto,     
		  c.clave,    
		  c.descripcion,    
		  c.descripcion_2,    
		  c.id_padre,    
		  c.permite_captura,    
		  monto_dec = isnull(rc.monto,0),    
		  monto = Convert(int,floor(isnull(rc.monto,0))),    
		  monto1 = isnull(rc.monto1,0),    
		  monto2 = isnull(rc.monto2,0),    
		  monto3 = isnull(rc.monto3,0),    
		  monto4 = isnull(rc.monto4,0),    
		  monto5 = isnull(rc.monto5,0),    
		  monto6 = isnull(rc.monto6,0),    
		  monto7 = isnull(rc.monto7,0),    
		  monto8 = isnull(rc.monto8,0),    
		  monto9 = isnull(rc.monto9,0),    
		  monto10 = isnull(rc.monto10,0),    
		  monto11 = isnull(rc.monto11,0),    
		  monto_real_mes_ant = isnull(rc.monto_real_mes_ant,0),    
		  0,    
		  monto_total = (case     
			  when c.id_concepto = 94 then isnull(rc.monto1,0)    
			  when c.id_concepto = 111 then isnull(rc.monto5,0)    
			  when c.id_reporte = 2 and @periodo=0 then isnull(rc.monto1,0) + isnull(rc.monto2,0)    
			  else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0) + isnull(rc.monto7,0) + isnull(rc.monto8,0) + isnull(rc.monto9,0) + isnull(rc.monto10,0) + isnull(rc.monto11,0)    
				end),    
		  c.es_separador,    
		  c.orden,    
		  rc.id_empresa,    
		  c.id_empresa,    
		  rc.id_reporte,    
		  rc.periodo,    
		  rc.anio,    
		  c.es_hornos,    
		  c.es_fibras,    
		  NULL,
		  c.referencia2
		from concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
		where c.id_reporte = @id_reporte    
		and (c.es_plan = 0 or @id_empresa = -1)    
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0    
		order by c.orden   
 end
    
    
    
    
    
 /* OBTENER PRONOSTICO DE FLUJO DE EFECTIVO DEL MES ANTERIOR */    
 if @id_reporte = 5    
   begin    
  declare @periodo_ant int,    
    @anio_periodo_ant int    
    
  if @periodo = 1    
   select @periodo_ant = 12, @anio_periodo_ant = @anio-1    
  else    
   select @periodo_ant = @periodo-1, @anio_periodo_ant = @anio    
    
    
  update trc    
  --set monto_pron_mes_ant = isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
  set monto_pron_mes_ant = (case when rc.id_concepto=94 then isnull(rc.monto1,0)    
          when rc.id_concepto=111 then isnull(rc.monto5,0)    
          else isnull(rc.monto1,0) + isnull(rc.monto2,0) + isnull(rc.monto3,0) + isnull(rc.monto4,0) + isnull(rc.monto5,0)    
         end)    
  from #reporte_captura trc    
  join reporte_captura rc    
   on rc.id_concepto = trc.id_concepto    
  where rc.anio = @anio_periodo_ant    
  and rc.periodo = @periodo_ant    
  and rc.id_empresa = @id_empresa    
    
   end    
    
    
update rc    
set tipo_distribucion = 'Manual'    
from #reporte_captura rc    
join reporte_plan_distribucion rpc on rpc.id_reporte=rc.id_reporte    
          and rpc.id_empresa=rc.id_empresa    
          and rpc.anio=rc.anio    
          and rpc.periodo=rc.periodo    
          and rpc.id_concepto=rc.id_concepto    
    
    
update rc    
set tipo_distribucion = 'Auto'    
from #reporte_captura rc    
where rc.tipo_distribucion is null    
    
    
    
    
    
if @id_reporte = 7 --PERFIL DE DEUDA    
  begin    
 update #reporte_captura_fin    
 set monto_total = monto_total - monto6    
    
insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,    
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion, referencia2)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion, referencia2
 from #reporte_captura    
 where id_empresa_concepto = @id_empresa    
 order by orden    
      
 select *    
 from #reporte_captura_fin    
 order by orden    
  end    
else if @id_reporte = 10 --CUADRE INTERCOMPANIES    
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 1015 --CUADRE INTERCOMPANIES V2
  begin    
    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto_real_mes_ant, monto_pron_mes_ant,     
   monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 where id_empresa_concepto <> @id_empresa    
 order by orden    
    
    
 update #reporte_captura_fin    
 set monto1=dbo.fn_afiliadas_balance('AC_CP', @anio, @periodo, @id_empresa),    
  monto2=dbo.fn_afiliadas_balance('AC_LP', @anio, @periodo, @id_empresa),    
  monto3=dbo.fn_afiliadas_balance('AP_CP', @anio, @periodo, @id_empresa),    
  monto4=dbo.fn_afiliadas_balance('AP_LP', @anio, @periodo, @id_empresa)    
 where descripcion='Ref. Balance General'    


 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end    
else if @id_reporte = 13 --CAPITAL DE TRABAJO  
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura    
 order by orden    
    
  declare @monto_sugerido decimal(18,2)  
        
  select @monto_sugerido = monto   
  from reporte_captura where id_concepto in (41,45,281)
  and anio = @anio    
  and periodo = @periodo    
  and id_empresa = @id_empresa    
  
  select @monto_sugerido = isnull(@monto_sugerido,0)
    
  update #reporte_captura_fin  
  set monto_dec = @monto_sugerido,  
  monto = @monto_sugerido  
  where id_concepto = 348  
  and monto = 0  


    
 select *    
 from #reporte_captura_fin    
 order by orden    
     
  end 
else    
  begin    
 insert into #reporte_captura_fin (id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec,     
         monto, monto1, monto2, monto3, monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
         monto_real_mes_ant, monto_pron_mes_ant,     
         monto_total, es_separador, orden, id_empresa, id_empresa_concepto, id_reporte, periodo, anio,    
         es_hornos, es_fibras, tipo_distribucion)    
 select id_concepto, clave, descripcion, descripcion_2, id_padre, permite_captura, monto_dec, monto, monto1, monto2, monto3,     
   monto4, monto5, monto6, monto7, monto8, monto9, monto10, monto11,     
   monto_real_mes_ant, monto_pron_mes_ant, monto_total, es_separador, orden, id_empresa,     
   id_empresa_concepto, id_reporte, periodo, anio, es_hornos, es_fibras, tipo_distribucion    
 from #reporte_captura
 order by orden    
    
    

/********************* INICIO DEL AUTOLLENADO *********************/
	if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1) and @periodo>0
	begin
			if dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa) = 'A' -- SI EL PERIODO ESTA ABIERO
			  begin
					if @id_reporte = 2 -- ESTADO DE RESULTADOS
					  begin
							declare @ventas_monto int, @ventas_fibra int, @ventas_fv int, @ventas_sat int, @ventas_comercial int

							select @ventas_monto = sum(monto),
									@ventas_fibra = sum(monto1),
									@ventas_fv = sum(monto2),
									@ventas_sat = sum(monto3),
									@ventas_comercial = sum(monto4)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 4
							and id_concepto in (86)



							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@ventas_monto,0),
								monto = isNull(@ventas_monto,0),
								monto1 = isNull(@ventas_fibra,0),
								monto2 = isNull(@ventas_fv,0),
								monto3 = isNull(@ventas_sat,0),
								monto4 = isNull(@ventas_comercial,0),
								autollenado = 1
							where id_concepto = 37

					  end


					else if @id_reporte in (3, 1014) -- FLUJO DE EFECTIVO
					  begin
							declare @fe_utilidad_neta int, @fe_depreciacion int

							select @fe_utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)

							select @fe_depreciacion = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (53)
				

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 55

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 56

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_utilidad_neta,0),
								monto = isNull(@fe_utilidad_neta,0),
								autollenado = 1
							where id_concepto = 1501

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@fe_depreciacion,0),
								monto = isNull(@fe_depreciacion,0),
								autollenado = 1
							where id_concepto = 1502

					  end

					else if @id_reporte = 1 -- BALANCE GENERAL
					  begin
							--if exists(select 1 from #c where id_concepto = 37 and monto_total = 0) -- NO SE HA CAPTURADO ANTES
							declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

							select @utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo
							and id_empresa = @id_empresa
							and id_reporte = 2
							and id_concepto in (52)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@utilidad_neta,0),
								monto = isNull(@utilidad_neta,0),
								autollenado = 1
							where id_concepto = 34

							

							--RM:INICIO CUADRE INTERCOMPAÑIAS V2
							declare @FECHA_INICIO_CUADRE_V2 DATETIME,
									@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
							SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')



							if @FECHA_PERIODO_ACTUAL >= @FECHA_INICIO_CUADRE_V2
							  begin

										select @cuadre1 = sum(monto1) + sum(monto3),
												@cuadre2 = sum(monto2) + sum(monto4),
												@cuadre3 = 0,
												@cuadre4 = 0
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 1015
										and id_concepto in (1610)

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 20
										
							  end
							else
							  begin


										select @cuadre1 = sum(monto1),
												@cuadre2 = sum(monto2),
												@cuadre3 = sum(monto3),
												@cuadre4 = sum(monto4)
										from reporte_captura
										where anio = @anio
										and periodo = @periodo
										and id_empresa = @id_empresa
										and id_reporte = 10
										and id_concepto in (266)


										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre1,0),
											monto = isNull(@cuadre1,0),
											autollenado = 1
										where id_concepto = 3

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre2,0),
											monto = isNull(@cuadre2,0),
											autollenado = 1
										where id_concepto = 14

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre3,0),
											monto = isNull(@cuadre3,0),
											autollenado = 1
										where id_concepto = 20

										UPDATE #reporte_captura_fin
										set monto_dec = isNull(@cuadre4,0),
											monto = isNull(@cuadre4,0),
											autollenado = 1
										where id_concepto = 27
							  end



							select @proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (322,323)

							select @clientes = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (334,335,350,351)

							select @inventario = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (332)

							select @anticipo_proveedores = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo = @periodo
							and id_empresa = @id_empresa
							and id_reporte = 13
							and id_concepto in (1420)


							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@proveedores,0),
								monto = isNull(@proveedores,0),
								autollenado = 1
							where id_concepto = 18

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@clientes,0),
								monto = isNull(@clientes,0),
								autollenado = 1
							where id_concepto = 2

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@inventario,0),
								monto = isNull(@inventario,0),
								autollenado = 1
							where id_concepto = 4

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@anticipo_proveedores,0),
								monto = isNull(@anticipo_proveedores,0),
								autollenado = 1
							where id_concepto = 8


					  end

			  end

	end



/********************* FIN DEL AUTOLLENADO *********************/
    
    
 select *    
 from #reporte_captura_fin    
 order by orden    
end    
    
 select comentarios    
 from reporte_captura_encabezado    
 where id_reporte = @id_reporte    
 and id_empresa = @id_empresa    
 and anio = @anio    
 and periodo = @periodo    
    
select estatus = dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa), alerta_actualizacion = dbo.fn_alerta_actualizacion_reporte(@anio,@periodo,@id_empresa,@id_reporte)
    
    
if @id_reporte in (3, 1014)    
  begin    
    
	 declare @valor_resultado int    
	 exec reporte_ejecutivo_7_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@valor_resultado=@valor_resultado output    
    
    
	 declare @resultado_x int    
     
	 if @id_empresa in (3,4,5,6,1014)    
	  --HORNOS (3,4,5,6)    
	  exec reporte_ejecutivo_4_fe @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
	 else    
	  --FIBRAS (8,1,10,9,7,12)  --LB 20150805: Se agrego la empresa 12  
	  exec reporte_ejecutivo_5_fex @anio=@anio,@periodo=@periodo,@id_empresa=@id_empresa,@resultado=@resultado_x output    
    
	 select saldo_caja=isNull(@valor_resultado,0),utilidad_neta=isNull(@resultado_x,0)    
      
  end    
    
if @id_reporte=10    
  exec recupera_comparacion_cuadre_intercompanies @anio, @periodo, @id_empresa    
else if @id_reporte=1015
  exec recupera_comparacion_cuadre_intercompanies_v2 @anio, @periodo, @id_empresa    
    
    
drop table #reporte_captura    
drop table #reporte_captura_fin    
go



go
alter procedure dbo.recalcula_balance_general
	@id_empresa int,
	@anio int,
	@periodo int
as
/*
select @id_empresa = 8,
		@anio = 2017,
		@periodo = 10
*/

declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

select @utilidad_neta = sum(monto)
from reporte_captura
where anio = @anio
and periodo <= @periodo
and id_empresa = @id_empresa
and id_reporte = 2
and id_concepto in (52)

UPDATE reporte_captura
set monto = isNull(@utilidad_neta,0)
where id_concepto = 34
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1




--RM:INICIO CUADRE INTERCOMPAÑIAS V2
declare @FECHA_INICIO_CUADRE_V2 DATETIME,
		@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


if @FECHA_PERIODO_ACTUAL >= @FECHA_INICIO_CUADRE_V2
	begin
			select @cuadre1 = sum(monto1) + sum(monto3),
					@cuadre2 = sum(monto2) + sum(monto4),
					@cuadre3 = 0,
					@cuadre4 = 0
			from reporte_captura
			where anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1015
			and id_concepto in (1610)


			UPDATE reporte_captura
			set monto = isNull(@cuadre1,0)
			where id_concepto = 3
			and anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1

		
			UPDATE reporte_captura
			set monto = isNull(@cuadre2,0)
			where id_concepto = 20
			and anio = @anio
			and periodo = @periodo
			and id_empresa = @id_empresa
			and id_reporte = 1
	end
else
	begin
		select @cuadre1 = sum(monto1),
				@cuadre2 = sum(monto2),
				@cuadre3 = sum(monto3),
				@cuadre4 = sum(monto4)
		from reporte_captura
		where anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 10
		and id_concepto in (266)



		UPDATE reporte_captura
		set monto = isNull(@cuadre1,0)
		where id_concepto = 3
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1



		UPDATE reporte_captura
		set monto = isNull(@cuadre2,0)
		where id_concepto = 14
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

		UPDATE reporte_captura
		set monto = isNull(@cuadre3,0)
		where id_concepto = 20
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

		UPDATE reporte_captura
		set monto = isNull(@cuadre4,0)
		where id_concepto = 27
		and anio = @anio
		and periodo = @periodo
		and id_empresa = @id_empresa
		and id_reporte = 1

	end





select @proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (322,323)

select @clientes = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (334,335,350,351)

select @inventario = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (332)

select @anticipo_proveedores = sum(monto)
from reporte_captura
where anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 13
and id_concepto in (1420)


UPDATE reporte_captura
set monto = isNull(@proveedores,0)
where id_concepto = 18
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@clientes,0)
where id_concepto = 2
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@inventario,0)
where id_concepto = 4
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1

UPDATE reporte_captura
set monto = isNull(@anticipo_proveedores,0)
where id_concepto = 8
and anio = @anio
and periodo = @periodo
and id_empresa = @id_empresa
and id_reporte = 1


exec reporte_calculos_totales @id_empresa, 1, @anio, @periodo, 1

go



go
alter procedure dbo.valida_permiso_para_capturar_reporte_financiero
	@id_reporte int,
	@id_empresa int,
	@anio int,
	@periodo int
as

declare @respuesta varchar(512) = ''

if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1)
begin

	if @id_reporte in (3,1014)  -- flujo de efectivo
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=1) < 5 -- balance general
			if @id_empresa <> 12
				select @respuesta='Para capturar "Flujo de Efectivo" se requiere capturar primero "Balance General"'
			else
				select @respuesta='In order to enter data for "Cash Flow" it is required to capture "Balance Sheet" first'
	  end
	else if @id_reporte = 1  -- balance general
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=13) < 5 -- Capital de Trabajo
			if @id_empresa <> 12
				select @respuesta='Para capturar "Balance General" se requiere capturar primero "Capital de Trabajo"'
			else
				select @respuesta='In order to enter data for "Balance Sheet" it is required to capture "Working Capital" first'
	  end
	else if @id_reporte = 13  -- Capital de Trabajo
	  begin

		--RM:INICIO CUADRE INTERCOMPAÑIAS V2
		declare @FECHA_INICIO_CUADRE_V2 DATETIME,
				@FECHA_PERIODO_ACTUAL DATETIME = convert(varchar(4),@anio) + right('00' + convert(varchar(2),@periodo),2) + '01'
		SELECT @FECHA_INICIO_CUADRE_V2 = isNull((select valor from configuracion where id=5), '20990101')


		if @FECHA_PERIODO_ACTUAL >= @FECHA_INICIO_CUADRE_V2
			begin
					if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=1015) < 5 -- Cuadre Intercompañias
						if @id_empresa <> 12
							select @respuesta='Para capturar "Capital de Trabajo" se requiere capturar primero "Cuadre Intercompañias v2"'
						else
							select @respuesta='In order to enter data for "Working Capital" it is required to capture "Intercompanies balance" first'
			end
		else
			begin
					if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=10) < 5 -- Cuadre Intercompañias
						if @id_empresa <> 12
							select @respuesta='Para capturar "Capital de Trabajo" se requiere capturar primero "Cuadre Intercompañias"'
						else
							select @respuesta='In order to enter data for "Working Capital" it is required to capture "Intercompanies balance" first'
			end

	  end
	else if @id_reporte in (10,1015)  -- Cuadre Intercompañias
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=2) < 5 -- Estado de Resultados
			if @id_empresa <> 12
				select @respuesta='Para capturar "Cuadre Intercompañias" se requiere capturar primero "Estado de Resultados"'
			else
				select @respuesta='In order to enter data for "Intercompanies balance" it is required to capture "Income Statement" first'
	  end
	else if @id_reporte = 2  -- Estado de Resultados
	  begin
		if (select count(*) from reporte_captura where anio=@anio and periodo=@periodo and id_empresa=@id_empresa and id_reporte=4) < 5 -- Estado de Resultados
			if @id_empresa <> 12
				select @respuesta='Para capturar "Estado de Resultados" se requiere capturar primero "Pedidos y Facturación"'
			else
				select @respuesta='In order to enter data for "Income Statement" it is required to capture "Orders and Invoices" first'
	  end

end

select @respuesta as respuesta




go


go

ALTER procedure [dbo].[reporte_calculos_totales]
	@id_empresa int,
	@id_reporte int,
	@anio int,
	@periodo int,
	@tipo int = 0
as
/*
declare 	@id_empresa int=8,
	@id_reporte int=3,
	@anio int=2016,
	@periodo int=4,
	@tipo int = 1
*/


set nocount on

declare @id_padre int,
		@formula_especial varchar(256)

create table #tConceptos
(
	id	int identity(1,1),
	id_concepto int,
	orden int
)

create table #tConceptosFormulas
(
	id	int identity(1,1),
	id_concepto int,
	orden int,
	formula_especial varchar(512)
)

insert into #tConceptos (id_concepto, orden)
select id_concepto, orden
from concepto
where id_concepto in (
					select id_padre
					from concepto
					where id_reporte = @id_reporte
					)
and isNull(formula_especial,'') = ''
order by orden


insert into #tConceptosFormulas (id_concepto, orden, formula_especial)
select id_concepto, orden, formula_especial
from concepto
where id_reporte = @id_reporte
and isNull(formula_especial,'') <> ''
order by orden




declare @max_row int,
		@curr_row int,
		@importe int,
		@importe0 int,
		@importe1 int,
		@importe2 int,
		@importe3 int,
		@importe4 int,
		@importe5 int,
		@importe7 int,
		@importe8 int,
		@importe9 int,
		@importe10 int,
		@importe11 int


if @tipo = 1
 begin


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

			--select * from #tConceptos
          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto*-1
										else monto
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end




		
  end
else if @tipo = 2
  begin
  

			declare @saldo_inicial int,
					@saldo_cobranza int,
					@saldo_pagos int,
					@exceso int,
					@saldo_semanal int
			select @saldo_semanal = 0,
					@saldo_inicial = 0

			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

			select @exceso = 0

			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto_real_mes_ant*-1
										else monto_real_mes_ant
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto_real_mes_ant = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

								
				select @curr_row = @curr_row + 1
			end



			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto_real_mes_ant,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto_real_mes_ant,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto_real_mes_ant,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x
			
			update rc
			set monto_real_mes_ant = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  
  

			----------------------------------------------------------------------------
			----------------------------------------------------------------------------

  
			update rc
			set monto1 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 94 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row
				
				select @importe = sum(case 
										when resta = 1 then monto1*-1
										else monto1
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto1 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

				if @id_padre = 111
					select @saldo_semanal = isNull(@importe,0)
				
				if @id_padre = 94
					select @saldo_inicial = isNull(@importe,0)
				
				select @curr_row = @curr_row + 1
			end



			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto1,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto1,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto1,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x
			
			update rc
			set monto1 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  


  
			----------------------------------------------------------------------------
			----------------------------------------------------------------------------
			update rc
			set monto2 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 94 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto2*-1
										else monto2
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto2 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

				if @id_padre = 111
					select @saldo_semanal = isNull(@importe,0)
				
				if @id_padre = 94
					select @saldo_inicial = isNull(@importe,0)
				
				select @curr_row = @curr_row + 1
			end





			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto2,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto2,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto2,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x
			
			update rc
			--set monto2 = @exceso
			set monto2 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  



----------------------------------------------------------------------------
----------------------------------------------------------------------------
			update rc
			set monto3 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 94 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto3*-1
										else monto3
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto3 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

				if @id_padre = 111
					select @saldo_semanal = isNull(@importe,0)
				
				if @id_padre = 94
					select @saldo_inicial = isNull(@importe,0)
				
				select @curr_row = @curr_row + 1
			end




			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto3,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto3,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto3,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x
			
			update rc
			--set monto3 = @exceso
			set monto3 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  




			----------------------------------------------------------------------------
			----------------------------------------------------------------------------
			update rc
			set monto4 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 94 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto4*-1
										else monto4
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto4 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

				if @id_padre = 111
					select @saldo_semanal = isNull(@importe,0)
				
				if @id_padre = 94
					select @saldo_inicial = isNull(@importe,0)
				
				select @curr_row = @curr_row + 1
			end




			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto4,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto4,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto4,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x

			
			update rc
			--set monto4 = @exceso
			set monto4 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  




			----------------------------------------------------------------------------
			----------------------------------------------------------------------------
			update rc
			set monto5 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 94 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto5*-1
										else monto5
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto5 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio

				if @id_padre = 111
					select @saldo_semanal = isNull(@importe,0)
				
				if @id_padre = 94
					select @saldo_inicial = isNull(@importe,0)
				
				select @curr_row = @curr_row + 1
			end
  
  
  
  
			select @saldo_inicial = monto1,
					@saldo_cobranza = monto2,
					@saldo_pagos = monto3					
			from (
				select monto1 = sum((case
										when id_concepto = 94 then isNull(monto5,0)
										else 0
									 end)),
						monto2 = sum((case
										when id_concepto = 99 then isNull(monto5,0)
										else 0
									 end)),
						monto3 = sum((case
										when id_concepto = 109 then isNull(monto5,0)
										else 0
									 end))
				from reporte_captura
				where id_concepto in (94,99,109)
				and id_reporte = @id_reporte
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
			) as x

			
			update rc
			--set monto5 = @exceso
			set monto5 = @saldo_inicial + @saldo_cobranza - @saldo_pagos
			from reporte_captura rc
			where rc.id_concepto = 111 and rc.id_empresa = @id_empresa and rc.periodo = @periodo
			and rc.id_reporte = @id_reporte and rc.anio = @anio
  



			----------------------------------------------------------------------------
			----------------------------------------------------------------------------
  end
else if @tipo = 3
  begin


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto1*-1
										else monto1
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto1 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 1)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto1 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto2*-1
										else monto2
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto2 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 2)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto2 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto3*-1
										else monto3
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto3 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 3)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto3 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto4*-1
										else monto4
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto4 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 4)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto4 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto5*-1
										else monto5
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto5 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 5)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto5 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto6*-1
										else monto6
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto6 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 6)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto6 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto7*-1
										else monto7
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto7 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 7)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto7 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto8*-1
										else monto8
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto8 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 8)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto8 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto9*-1
										else monto9
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto9 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 9)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto9 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			----------------------------------------------------------------------------
			----------------------------------------------------------------------------



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto10*-1
										else monto10
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto10 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				
				select @importe = (case 
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 10)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto10 = isNull(@importe,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end

		
  end
else if @tipo = 4
  begin
			
			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe1 = sum(case 
										when resta = 1 then monto1*-1
										else monto1
									end),
						@importe2 = sum(case 
										when resta = 1 then monto2*-1
										else monto2
									end),
						@importe3 = sum(case 
										when resta = 1 then monto3*-1
										else monto3
									end),
						@importe4 = sum(case 
										when resta = 1 then monto4*-1
										else monto4
									end),
						@importe5 = sum(case 
										when resta = 1 then monto5*-1
										else monto5
									end),
						@importe7 = sum(case 
										when resta = 1 then monto7*-1
										else monto7
									end),
						@importe8 = sum(case 
										when resta = 1 then monto8*-1
										else monto8
									end),
						@importe9 = sum(case 
										when resta = 1 then monto9*-1
										else monto9
									end),
						@importe10 = sum(case 
										when resta = 1 then monto10*-1
										else monto10
									end),
						@importe11 = sum(case 
										when resta = 1 then monto11*-1
										else monto11
									end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto1 = isNull(@importe1,0),
					monto2 = isNull(@importe2,0),
					monto3 = isNull(@importe3,0),
					monto4 = isNull(@importe4,0),
					monto5 = isNull(@importe5,0),
					monto7 = isNull(@importe7,0),
					monto8 = isNull(@importe8,0),
					monto9 = isNull(@importe9,0),
					monto10 = isNull(@importe10,0),
					monto11 = isNull(@importe11,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end

		
  end
else if @tipo = 5
 begin


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

			--select * from #tConceptos
          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
										when resta = 1 then monto*-1
										else monto
									end),
						@importe1 = sum(case 
							when resta = 1 then monto1*-1
							else monto1
						end),
						@importe2 = sum(case 
							when resta = 1 then monto2*-1
							else monto2
						end),
						@importe3 = sum(case 
							when resta = 1 then monto3*-1
							else monto3
						end),
						@importe4 = sum(case 
							when resta = 1 then monto4*-1
							else monto4
						end)
				from reporte_captura rc
				join concepto c on c.id_concepto = rc.id_concepto
				where c.id_padre = @id_padre
				and rc.id_empresa = @id_empresa
				and rc.periodo = @periodo
				and rc.id_reporte = @id_reporte
				and rc.anio = @anio
				
				update reporte_captura
				set monto = isNull(@importe,0),
					monto1 = isNull(@importe1,0),
					monto2 = isNull(@importe2,0),
					monto3 = isNull(@importe3,0),
					monto4 = isNull(@importe4,0)
				where id_concepto = @id_padre
				and id_empresa = @id_empresa
				and periodo = @periodo
				and anio = @anio
				
				select @curr_row = @curr_row + 1
			end


			select @max_row = max(id),
					@curr_row = 1
			from #tConceptosFormulas


			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto,
						@formula_especial = formula_especial
				from #tConceptosFormulas
				where id = @curr_row

				if @formula_especial = 'fn_rep2_flujo_operacion'
				 begin
				 	select @importe = sum(case 
									when resta = 1 then monto*-1
									else monto
								end),
							@importe1 = sum(case 
									when resta = 1 then monto1*-1
									else monto1
								end),
							@importe2 = sum(case 
									when resta = 1 then monto2*-1
									else monto2
								end),
							@importe3 = sum(case 
									when resta = 1 then monto3*-1
									else monto3
								end),
							@importe4 = sum(case 
									when resta = 1 then monto4*-1
									else monto4
								end)
					from reporte_captura rc
					join concepto c on c.id_concepto = rc.id_concepto
					where c.id_concepto in (280,281,53)
					and rc.id_empresa = @id_empresa
					and rc.periodo = @periodo
					and rc.anio = @anio


					update reporte_captura
					set monto = isNull(@importe,0),
						monto1 = isNull(@importe1,0),
						monto2 = isNull(@importe2,0),
						monto3 = isNull(@importe3,0),
						monto4 = isNull(@importe4,0)
					where id_concepto = @id_padre
					and id_empresa = @id_empresa
					and periodo = @periodo
					and anio = @anio
				 end
				
				
				select @curr_row = @curr_row + 1
			end




		
  end

drop table #tConceptos
drop table #tConceptosFormulas


-- Corre los recalculos de autollenado
if exists (select 1 from empresa where id_empresa = @id_empresa and aplica_validacion_captura_reportes=1) and @periodo > 0
begin
	if @id_reporte=4
		exec recalcula_estado_resultados @id_empresa, @anio, @periodo
	if @id_reporte in (2,10,1015,13)
		exec recalcula_balance_general @id_empresa, @anio, @periodo
	if @id_reporte in (2)
		exec recalcula_flujo_efectivo @id_empresa, @anio, @periodo
end


go


go


go


go


go

