Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE procedure [dbo].[reporte_ejecutivo_7_empresa]
	@tipo varchar(1),
	@anio int,
	@periodo int,
	@id_empresa int = 0
as

/*
declare	@anio int,
	@periodo int,
	@tipo varchar(1),
	@id_empresa int

select  @anio = 2016,
		@periodo = 2,
		@tipo = 'F',
		@id_empresa = 0
*/

set nocount on

declare @tEmpresasFiltro as table (id_empresa int)

if @id_empresa <> 0
	insert into @tEmpresasFiltro (id_empresa)
	select id_empresa from empresa
	where id_empresa = @id_empresa
else
	insert into @tEmpresasFiltro (id_empresa)
	select id_empresa from empresa
	where ((@tipo='H' and es_hornos=1)
			or (@tipo='F' and es_fibras=1))
	and id_empresa not in (6)
--	and id_empresa not in (12)




declare @tablaMeses table 
(
	id	int identity(1,1),
	anio int,
	periodo	int
)

declare @i int,
		@anio_i int,
		@periodo_i int
		
select @i=1,
		@anio_i=@anio,
		@periodo_i=@periodo
		
while @i<=13
  begin
  
	if @periodo_i<1
		select @periodo_i=12, @anio_i=@anio_i-1
		
	insert into @tablaMeses values (@anio_i, @periodo_i)
  
	select @periodo_i = @periodo_i - 1
	select @i = @i + 1
  end


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------


create table #tResumenOperativo
(
	id int identity(1,1),
	id_concepto int,
	id_concepto_plan int,
	descripcion varchar(152),

	monto1 decimal(18,2),	--NBM	-Nutec Bickley SA de CV
	monto2 decimal(18,2),	--NE	-Nutec Europe
	monto3 decimal(18,2),	--NP	-Nutec Procal
	monto4 decimal(18,2),	--NE+NP -Espana
	monto5 decimal(18,2),	--NF	-Nutec Fibratec SA de CV
	monto5_2 decimal(18,2),	--NUSA	-Nutec USA
	monto6 decimal(18,2),	--NS
	monto7 decimal(18,2),	--Suma
	monto8 decimal(18,2),	--GNU	-Grupo Nutec
	monto9 decimal(18,2),	--Cargos
	monto10 decimal(18,2),	--Creditos
	monto11 decimal(18,2),	--Consolidado
	monto13 decimal(18,2),	--NPC

	monto_tot1 decimal(18,2),	--NBM	-Nutec Bickley SA de CV
	monto_tot2 decimal(18,2),	--NE	-Nutec Europe
	monto_tot3 decimal(18,2),	--NP	-Nutec Procal
	monto_tot4 decimal(18,2),	--NE+NP -Espana
	monto_tot5 decimal(18,2),	--NF	-Nutec Fibratec SA de CV
	monto_tot5_2 decimal(18,2),	--NUSA	-Nutec USA
	monto_tot6 decimal(18,2),	--NS
	monto_tot7 decimal(18,2),	--Suma
	monto_tot8 decimal(18,2),	--GNU	-Grupo Nutec
	monto_tot9 decimal(18,2),	--Cargos
	monto_tot10 decimal(18,2),	--Creditos
	monto_tot11 decimal(18,2),	--Consolidado
	monto_tot13 decimal(18,2),	--NPC

	es_porcentaje bit,
	es_multivalor bit,
	permite_captura bit,
	es_separador	bit
)



create table #tResumenOperativoFin
(
	id int identity(1,1),
	id_concepto int,
	id_concepto_plan int,
	descripcion varchar(152),

	monto1 decimal(18,2),
	monto2 decimal(18,2),
	monto3 decimal(18,2),
	monto4 decimal(18,2),
	monto5 decimal(18,2),
	monto6 decimal(18,2),
	monto7 decimal(18,2),
	monto8 decimal(18,2),
	monto9 decimal(18,2),
	monto10 decimal(18,2),
	monto11 decimal(18,2),
	monto12 decimal(18,2),
	monto13 decimal(18,2),

	monto_tot1 decimal(18,2),
	monto_tot2 decimal(18,2),
	monto_tot3 decimal(18,2),
	monto_tot4 decimal(18,2),
	monto_tot5 decimal(18,2),
	monto_tot6 decimal(18,2),
	monto_tot7 decimal(18,2),
	monto_tot8 decimal(18,2),
	monto_tot9 decimal(18,2),
	monto_tot10 decimal(18,2),
	monto_tot11 decimal(18,2),
	monto_tot12 decimal(18,2),
	monto_tot13 decimal(18,2),

	es_porcentaje bit,
	es_multivalor bit,
	permite_captura bit,
	separador_despues	bit default(0),
	orden int,
	plan1	int default(0),
	var1	int default(0),
	plan2	int default(0),
	var2	int default(0)
)

insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0
from concepto
where id_reporte = 1
and es_plan = 0
and es_borrado = 0
order by orden










declare @min int,
		@max int

select @min=1,
		@max=13

declare @anio_calc int,
		@periodo_calc int

while @min<=@max
  begin
	

			select @anio_calc=anio,
					@periodo_calc=periodo
			from @tablaMeses
			where id=@min
			
			exec reporte_balance_ajustes_ejecutivo_empresa @anio_calc, @periodo_calc, @id_empresa, @tipo



			update rof
			set monto1 = (case when @min=1 then x.monto else rof.monto1 end),
				monto2 = (case when @min=2 then x.monto else rof.monto2 end),
				monto3 = (case when @min=3 then x.monto else rof.monto3 end),
				monto4 = (case when @min=4 then x.monto else rof.monto4 end),
				monto5 = (case when @min=5 then x.monto else rof.monto5 end),
				monto6 = (case when @min=6 then x.monto else rof.monto6 end),
				monto7 = (case when @min=7 then x.monto else rof.monto7 end),
				monto8 = (case when @min=8 then x.monto else rof.monto8 end),
				monto9 = (case when @min=9 then x.monto else rof.monto9 end),
				monto10 = (case when @min=10 then x.monto else rof.monto10 end),
				monto11 = (case when @min=11 then x.monto else rof.monto11 end),
				monto12 = (case when @min=12 then x.monto else rof.monto12 end),
				monto13 = (case when @min=13 then x.monto else rof.monto13 end),
				monto_tot1 = (case when @min=1 then x.monto_tot else rof.monto_tot1 end),
				monto_tot2 = (case when @min=2 then x.monto_tot else rof.monto_tot2 end),
				monto_tot3 = (case when @min=3 then x.monto_tot else rof.monto_tot3 end),
				monto_tot4 = (case when @min=4 then x.monto_tot else rof.monto_tot4 end),
				monto_tot5 = (case when @min=5 then x.monto_tot else rof.monto_tot5 end),
				monto_tot6 = (case when @min=6 then x.monto_tot else rof.monto_tot6 end),
				monto_tot7 = (case when @min=7 then x.monto_tot else rof.monto_tot7 end),
				monto_tot8 = (case when @min=8 then x.monto_tot else rof.monto_tot8 end),
				monto_tot9 = (case when @min=9 then x.monto_tot else rof.monto_tot9 end),
				monto_tot10 = (case when @min=10 then x.monto_tot else rof.monto_tot10 end),
				monto_tot11 = (case when @min=11 then x.monto_tot else rof.monto_tot11 end),
				monto_tot12 = (case when @min=12 then x.monto_tot else rof.monto_tot12 end),
				monto_tot13 = (case when @min=13 then x.monto_tot else rof.monto_tot13 end)
			from #tResumenOperativoFin rof
			join (select 
						ro.id_concepto,
						monto=isNull(monto11,0),
						monto_tot=isNull(monto_tot11,0)
					from #tResumenOperativo ro) x on x.id_concepto = rof.id_concepto



			truncate table #tResumenOperativo

	select @min=@min+1
  end



--update #tResumenOperativoFin set separador_despues=1 where id in (4,10,13,16,25,30,36)
update #tResumenOperativoFin set separador_despues=1 where id_concepto in (4,10,13,16,25,29,35)



----
update #tResumenOperativoFin set orden=id*10


update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=10,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (1,2,3,4,9,1564,1565,7,8)) x on x.id_concepto=t.id_concepto


update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=5,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (5,6)) x on x.id_concepto=t.id_concepto

update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=7,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (7,8)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=24,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (21,24)) x on x.id_concepto=t.id_concepto



update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=18,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (18,23,1566,1567)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=25,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (17,18,19,20,24)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=26,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (22,26)) x on x.id_concepto=t.id_concepto






update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=29,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (25,26,27,28,1643)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=36,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (35,29)) x on x.id_concepto=t.id_concepto


insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, monto1, monto2, monto3, monto4, 
									monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto12, monto13,
									monto_tot1, monto_tot2, monto_tot3, monto_tot4, monto_tot5, monto_tot6,
									monto_tot7, monto_tot8, monto_tot9, monto_tot10, monto_tot11, monto_tot12,
									monto_tot13, es_porcentaje, es_multivalor, permite_captura, separador_despues,
									orden, plan1, var1, plan2, var2)
values (99,99,'Crédito Mercantil. España',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,136,0,0,0,0)

insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, monto1, monto2, monto3, monto4, 
									monto5, monto6, monto7, monto8, monto9, monto10, monto11, monto12, monto13,
									monto_tot1, monto_tot2, monto_tot3, monto_tot4, monto_tot5, monto_tot6,
									monto_tot7, monto_tot8, monto_tot9, monto_tot10, monto_tot11, monto_tot12,
									monto_tot13, es_porcentaje, es_multivalor, permite_captura, separador_despues,
									orden, plan1, var1, plan2, var2)
values (98,98,'Otros Pasivos LP. España',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,275,0,0,0,0)

update #tResumenOperativoFin set descripcion='Caja' where id_concepto=1
update #tResumenOperativoFin set descripcion='Cuentas por Cobrar' where id_concepto=2
update #tResumenOperativoFin set descripcion='Otros Activos Circulantes', orden=95 where id_concepto=7 --115
update #tResumenOperativoFin set descripcion='Inversión en Acciones', orden=135 where id_concepto=5 --155
--update #tResumenOperativoFin set descripcion='Crédito Mercantil. España', orden=146 where id_concepto=3
update #tResumenOperativoFin set descripcion='Cargos Diferidos y Activo Intangible' where id_concepto=15
update #tResumenOperativoFin set descripcion='Pasivo Bancario CP' where id_concepto=17
update #tResumenOperativoFin set descripcion='Cuentas por Pagar' where id_concepto=18
update #tResumenOperativoFin set descripcion='Anticipo de Clientes' where id_concepto=19
update #tResumenOperativoFin set descripcion='Otros Pasivos Circulantes' where id_concepto=24
update #tResumenOperativoFin set descripcion='Pasivo Bancario LP' where id_concepto=26
--update #tResumenOperativoFin set descripcion='Otros Pasivos LP. España' where id_concepto=27
update #tResumenOperativoFin set descripcion='Créditos Diferidos' where id_concepto=28
update #tResumenOperativoFin set descripcion='B-10' where id_concepto=32
update #tResumenOperativoFin set descripcion='Utilidades Retenidas' where id_concepto=33
update #tResumenOperativoFin set orden=orden-11 where id_concepto=20

--select * from #tResumenOperativoFin
delete from #tResumenOperativoFin where id_concepto in (6,8,11,12,14,21,22,23,1566,1567,31)
--3 reusado



declare @monto_espania decimal(18,2), @monto_espania2 decimal(18,2), @monto100porciento decimal(18,2)
select @min=1, @max=13
while @min<=@max
begin
		select @anio_calc=anio, @periodo_calc=periodo from @tablaMeses where id=@min
		select @monto_espania=dbo.fn_credito_mercantil_espania(@anio_calc,@periodo_calc)
		select @monto_espania2=dbo.fn_otros_pasivos_espania(@anio_calc,@periodo_calc)
		
		--print convert(varchar,@monto_espania) + '--->' + convert(varchar,@monto_espania2)
		
		update t
		set monto1=(case when @min=1 then @monto_espania else t.monto1 end),
			monto2=(case when @min=2 then @monto_espania else t.monto2 end),
			monto3=(case when @min=3 then @monto_espania else t.monto3 end),
			monto4=(case when @min=4 then @monto_espania else t.monto4 end),
			monto5=(case when @min=5 then @monto_espania else t.monto5 end),
			monto6=(case when @min=6 then @monto_espania else t.monto6 end),
			monto7=(case when @min=7 then @monto_espania else t.monto7 end),
			monto8=(case when @min=8 then @monto_espania else t.monto8 end),
			monto9=(case when @min=9 then @monto_espania else t.monto9 end),
			monto10=(case when @min=10 then @monto_espania else t.monto10 end),
			monto11=(case when @min=11 then @monto_espania else t.monto11 end),
			monto12=(case when @min=12 then @monto_espania else t.monto12 end),
			monto13=(case when @min=13 then @monto_espania else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=99
		
		update t
		set monto1=(case when @min=1 then t.monto1-@monto_espania else t.monto1 end),
			monto2=(case when @min=2 then t.monto2-@monto_espania else t.monto2 end),
			monto3=(case when @min=3 then t.monto3-@monto_espania else t.monto3 end),
			monto4=(case when @min=4 then t.monto4-@monto_espania else t.monto4 end),
			monto5=(case when @min=5 then t.monto5-@monto_espania else t.monto5 end),
			monto6=(case when @min=6 then t.monto6-@monto_espania else t.monto6 end),
			monto7=(case when @min=7 then t.monto7-@monto_espania else t.monto7 end),
			monto8=(case when @min=8 then t.monto8-@monto_espania else t.monto8 end),
			monto9=(case when @min=9 then t.monto9-@monto_espania else t.monto9 end),
			monto10=(case when @min=10 then t.monto10-@monto_espania else t.monto10 end),
			monto11=(case when @min=11 then t.monto11-@monto_espania else t.monto11 end),
			monto12=(case when @min=12 then t.monto12-@monto_espania else t.monto12 end),
			monto13=(case when @min=13 then t.monto13-@monto_espania else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=15
		


		update t
		set monto1 = (case when @min=1 then x.monto1 else t.monto1 end),
			monto2 = (case when @min=2 then x.monto2 else t.monto2 end),
			monto3 = (case when @min=3 then x.monto3 else t.monto3 end),
			monto4 = (case when @min=4 then x.monto4 else t.monto4 end),
			monto5 = (case when @min=5 then x.monto5 else t.monto5 end),
			monto6 = (case when @min=6 then x.monto6 else t.monto6 end),
			monto7 = (case when @min=7 then x.monto7 else t.monto7 end),
			monto8 = (case when @min=8 then x.monto8 else t.monto8 end),
			monto9 = (case when @min=9 then x.monto9 else t.monto9 end),
			monto10 = (case when @min=10 then x.monto10 else t.monto10 end),
			monto11 = (case when @min=11 then x.monto11 else t.monto11 end),
			monto12 = (case when @min=12 then x.monto12 else t.monto12 end),
			monto13 = (case when @min=13 then x.monto13 else t.monto13 end)
		from #tResumenOperativoFin t
		join (select 
					id_concepto=16,
					monto1=sum(monto1),
					monto2=sum(monto2),
					monto3=sum(monto3),
					monto4=sum(monto4),
					monto5=sum(monto5),
					monto6=sum(monto6),
					monto7=sum(monto7),
					monto8=sum(monto8),
					monto9=sum(monto9),
					monto10=sum(monto10),
					monto11=sum(monto11),
					monto12=sum(monto12),
					monto13=sum(monto13)
				from #tResumenOperativoFin t2
				where id_concepto in (10,13,5,99,15)) x on x.id_concepto=t.id_concepto



		update t
		set monto1=(case when @min=1 then @monto_espania2 else t.monto1 end),
			monto2=(case when @min=2 then @monto_espania2 else t.monto2 end),
			monto3=(case when @min=3 then @monto_espania2 else t.monto3 end),
			monto4=(case when @min=4 then @monto_espania2 else t.monto4 end),
			monto5=(case when @min=5 then @monto_espania2 else t.monto5 end),
			monto6=(case when @min=6 then @monto_espania2 else t.monto6 end),
			monto7=(case when @min=7 then @monto_espania2 else t.monto7 end),
			monto8=(case when @min=8 then @monto_espania2 else t.monto8 end),
			monto9=(case when @min=9 then @monto_espania2 else t.monto9 end),
			monto10=(case when @min=10 then @monto_espania2 else t.monto10 end),
			monto11=(case when @min=11 then @monto_espania2 else t.monto11 end),
			monto12=(case when @min=12 then @monto_espania2 else t.monto12 end),
			monto13=(case when @min=13 then @monto_espania2 else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=98
		
		update t
		set monto1=(case when @min=1 then t.monto1-@monto_espania2 else t.monto1 end),
			monto2=(case when @min=2 then t.monto2-@monto_espania2 else t.monto2 end),
			monto3=(case when @min=3 then t.monto3-@monto_espania2 else t.monto3 end),
			monto4=(case when @min=4 then t.monto4-@monto_espania2 else t.monto4 end),
			monto5=(case when @min=5 then t.monto5-@monto_espania2 else t.monto5 end),
			monto6=(case when @min=6 then t.monto6-@monto_espania2 else t.monto6 end),
			monto7=(case when @min=7 then t.monto7-@monto_espania2 else t.monto7 end),
			monto8=(case when @min=8 then t.monto8-@monto_espania2 else t.monto8 end),
			monto9=(case when @min=9 then t.monto9-@monto_espania2 else t.monto9 end),
			monto10=(case when @min=10 then t.monto10-@monto_espania2 else t.monto10 end),
			monto11=(case when @min=11 then t.monto11-@monto_espania2 else t.monto11 end),
			monto12=(case when @min=12 then t.monto12-@monto_espania2 else t.monto12 end),
			monto13=(case when @min=13 then t.monto13-@monto_espania2 else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=28


		select @monto100porciento = (case 
										when @min=1 then t.monto1 
										when @min=2 then t.monto2
										when @min=3 then t.monto3 
										when @min=4 then t.monto4 
										when @min=5 then t.monto5 
										when @min=6 then t.monto6 
										when @min=7 then t.monto7 
										when @min=8 then t.monto8 
										when @min=9 then t.monto9 
										when @min=10 then t.monto10 
										when @min=11 then t.monto11 
										when @min=12 then t.monto12 
										when @min=13 then t.monto13 
									else 0 end)
		from #tResumenOperativoFin t
		where id_concepto=16

		if @monto100porciento > 0
			update t
			set monto_tot1=(case when @min=1 then monto1/@monto100porciento*100.0 else t.monto_tot1 end),
				monto_tot2=(case when @min=2 then monto2/@monto100porciento*100.0 else t.monto_tot2 end),
				monto_tot3=(case when @min=3 then monto3/@monto100porciento*100.0 else t.monto_tot3 end),
				monto_tot4=(case when @min=4 then monto4/@monto100porciento*100.0 else t.monto_tot4 end),
				monto_tot5=(case when @min=5 then monto5/@monto100porciento*100.0 else t.monto_tot5 end),
				monto_tot6=(case when @min=6 then monto6/@monto100porciento*100.0 else t.monto_tot6 end),
				monto_tot7=(case when @min=7 then monto7/@monto100porciento*100.0 else t.monto_tot7 end),
				monto_tot8=(case when @min=8 then monto8/@monto100porciento*100.0 else t.monto_tot8 end),
				monto_tot9=(case when @min=9 then monto9/@monto100porciento*100.0 else t.monto_tot9 end),
				monto_tot10=(case when @min=10 then monto10/@monto100porciento*100.0 else t.monto_tot10 end),
				monto_tot11=(case when @min=11 then monto11/@monto100porciento*100.0 else t.monto_tot11 end),
				monto_tot12=(case when @min=12 then monto12/@monto100porciento*100.0 else t.monto_tot12 end),
				monto_tot13=(case when @min=13 then monto13/@monto100porciento*100.0 else t.monto_tot13 end)
			from #tResumenOperativoFin t


		IF OBJECT_ID('tempdb..#tBalanceGeneralDatosExtra') IS NOT NULL
		 BEGIN
			--CUENTAS POR COBRAR
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=7,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (2)) x on x.id=t.id

			--CUENTAS POR PAGAR
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=8,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (18)) x on x.id=t.id

			--ACTIVO CIRCULANTE
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=9,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (10)) x on x.id=t.id

			--PASIVO CIRCULANTE
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=10,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (25)) x on x.id=t.id

			--Pasivo Bancario CP
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=11,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (17)) x on x.id=t.id

			--Pasivo Bancario LP
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=12,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (26)) x on x.id=t.id

			--ACTIVO TOTAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=13,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (16)) x on x.id=t.id

			--PASIVO MAS CAPITAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=14,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (36)) x on x.id=t.id

			--PASIVO MAS CAPITAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=15,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (34)) x on x.id=t.id

			--INVENTARIO
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=24,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (4)) x on x.id=t.id
			
--  reporte_ejecutivo_7 2013,5
		 END


		select @min=@min+1
  end


select @periodo=@periodo-1
if @periodo=0
	select @periodo=12, @anio=@anio-1
else
	select @periodo=@periodo


update #tResumenOperativoFin
set plan1=(select sum(isNull(monto5,0)) 
			from reporte_captura 
			where id_reporte=5 and id_concepto=111
			and id_empresa in (select id_empresa from @tEmpresasFiltro)
			and anio=@anio and periodo=@periodo)
where id_concepto=1

if @periodo=12
	select @periodo=1,
			@anio=@anio+1
else
	select @periodo=@periodo+1

update #tResumenOperativoFin
set plan2=(select sum(isNull(monto5,0)) 
			from reporte_captura 
			where id_reporte=5 and id_concepto=111 
			and id_empresa in (select id_empresa from @tEmpresasFiltro)			
			and anio=@anio and periodo=@periodo)
where id_concepto=1

update #tResumenOperativoFin
set var1=abs(monto1-plan1),
	var2=abs(monto1-plan2)
where id_concepto=1

delete from #tResumenOperativoFin
where id_concepto = 32
and monto1 + monto2 + monto3 + monto4 + monto5 + monto6 + monto7 + monto8 + monto9 + monto10 + monto11 + monto12 + monto13 = 0


select id,
	id_concepto,
	descripcion,
	orden,
	monto1 = convert(int,round(isNull(monto1,0),0)),
	monto2 = convert(int,round(isNull(monto2,0),0)),
	monto3 = convert(int,round(isNull(monto3,0),0)),
	monto4 = convert(int,round(isNull(monto4,0),0)),
	monto5 = convert(int,round(isNull(monto5,0),0)),
	monto6 = convert(int,round(isNull(monto6,0),0)),
	monto7 = convert(int,round(isNull(monto7,0),0)),
	monto8 = convert(int,round(isNull(monto8,0),0)),
	monto9 = convert(int,round(isNull(monto9,0),0)),
	monto10 = convert(int,round(isNull(monto10,0),0)),
	monto11 = convert(int,round(isNull(monto11,0),0)),
	monto12 = convert(int,round(isNull(monto12,0),0)),
	monto13 = convert(int,round(isNull(monto13,0),0)),
	monto_tot1 = convert(int,round(isNull(monto_tot1,0),0)),
	monto_tot2 = convert(int,round(isNull(monto_tot2,0),0)),
	monto_tot3 = convert(int,round(isNull(monto_tot3,0),0)),
	monto_tot4 = convert(int,round(isNull(monto_tot4,0),0)),
	monto_tot5 = convert(int,round(isNull(monto_tot5,0),0)),
	monto_tot6 = convert(int,round(isNull(monto_tot6,0),0)),
	monto_tot7 = convert(int,round(isNull(monto_tot7,0),0)),
	monto_tot8 = convert(int,round(isNull(monto_tot8,0),0)),
	monto_tot9 = convert(int,round(isNull(monto_tot9,0),0)),
	monto_tot10 = convert(int,round(isNull(monto_tot10,0),0)),
	monto_tot11 = convert(int,round(isNull(monto_tot11,0),0)),
	monto_tot12 = convert(int,round(isNull(monto_tot12,0),0)),
	monto_tot13 = convert(int,round(isNull(monto_tot13,0),0)),
	
	es_porcentaje,
	es_multivalor,
	permite_captura,
	separador_despues,
	plan1=isnull(plan1,0),
	var1=isnull(var1,0),
	plan2=isnull(plan2,0),
	var2=isnull(var2,0),
	diciembre = (select id from @tablaMeses where anio=@anio-1 and periodo=12)
from #tResumenOperativoFin
order by orden


drop table #tResumenOperativo
drop table #tResumenOperativoFin


Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE procedure [dbo].[rpt_max_min_calculos_balance]
	@anio int,
	@periodo int,
	@id_empresa	int
as
/*
declare @anio int,
	@periodo int,
	@id_empresa	int

select @anio=2013,
		@periodo=12,
		@id_empresa	=8
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




declare @tablaMeses table 
(
	id	int identity(1,1),
	anio int,
	periodo	int
)

declare @i int,
		@anio_i int,
		@periodo_i int
		
select @i=1,
		@anio_i=@anio,
		@periodo_i=1
		
while @i<=12
  begin		
	insert into @tablaMeses values (@anio_i, @periodo_i)
  
	select @periodo_i = @periodo_i + 1
	select @i = @i + 1
  end

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------


create table #tResumenOperativo
(
	id int identity(1,1),
	id_concepto int,
	id_concepto_plan int,
	descripcion varchar(152),

	monto1 decimal(18,2),	--NBM	-Nutec Bickley SA de CV
	monto2 decimal(18,2),	--NE	-Nutec Europe
	monto3 decimal(18,2),	--NP	-Nutec Procal
	monto4 decimal(18,2),	--NE+NP -Espana
	monto5 decimal(18,2),	--NF	-Nutec Fibratec SA de CV
	monto6 decimal(18,2),	--NS
	monto7 decimal(18,2),	--Suma
	monto8 decimal(18,2),	--GNU	-Grupo Nutec
	monto9 decimal(18,2),	--Cargos
	monto10 decimal(18,2),	--Creditos
	monto11 decimal(18,2),	--Consolidado

	monto_tot1 decimal(18,2),	--NBM	-Nutec Bickley SA de CV
	monto_tot2 decimal(18,2),	--NE	-Nutec Europe
	monto_tot3 decimal(18,2),	--NP	-Nutec Procal
	monto_tot4 decimal(18,2),	--NE+NP -Espana
	monto_tot5 decimal(18,2),	--NF	-Nutec Fibratec SA de CV
	monto_tot6 decimal(18,2),	--NS
	monto_tot7 decimal(18,2),	--Suma
	monto_tot8 decimal(18,2),	--GNU	-Grupo Nutec
	monto_tot9 decimal(18,2),	--Cargos
	monto_tot10 decimal(18,2),	--Creditos
	monto_tot11 decimal(18,2),	--Consolidado

	es_porcentaje bit,
	es_multivalor bit,
	permite_captura bit,
	es_separador	bit
)



create table #tResumenOperativoFin
(
	id int identity(1,1),
	id_concepto int,
	id_concepto_plan int,
	descripcion varchar(152),

	monto1 decimal(18,2),
	monto2 decimal(18,2),
	monto3 decimal(18,2),
	monto4 decimal(18,2),
	monto5 decimal(18,2),
	monto6 decimal(18,2),
	monto7 decimal(18,2),
	monto8 decimal(18,2),
	monto9 decimal(18,2),
	monto10 decimal(18,2),
	monto11 decimal(18,2),
	monto12 decimal(18,2),
	monto13 decimal(18,2),

	monto_tot1 decimal(18,2),
	monto_tot2 decimal(18,2),
	monto_tot3 decimal(18,2),
	monto_tot4 decimal(18,2),
	monto_tot5 decimal(18,2),
	monto_tot6 decimal(18,2),
	monto_tot7 decimal(18,2),
	monto_tot8 decimal(18,2),
	monto_tot9 decimal(18,2),
	monto_tot10 decimal(18,2),
	monto_tot11 decimal(18,2),
	monto_tot12 decimal(18,2),
	monto_tot13 decimal(18,2),

	es_porcentaje bit,
	es_multivalor bit,
	permite_captura bit,
	separador_despues	bit default(0),
	orden int,
	plan1	int default(0),
	var1	int default(0),
	plan2	int default(0),
	var2	int default(0)
)

insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0
from concepto
where id_reporte = 1
and es_plan = 0
and id_concepto = 1
and es_borrado = 0
order by orden










declare @min int,
		@max int

select @min=1,
		@max=13

declare @anio_calc int,
		@periodo_calc int

while @min<=@max
  begin
	

			select @anio_calc=anio,
					@periodo_calc=periodo
			from @tablaMeses
			where id=@min
			
			exec reporte_balance_ajustes_ejecutivo_maxmin @anio_calc, @periodo_calc, @id_empresa



			update rof
			set monto1 = (case when @min=1 then x.monto else rof.monto1 end),
				monto2 = (case when @min=2 then x.monto else rof.monto2 end),
				monto3 = (case when @min=3 then x.monto else rof.monto3 end),
				monto4 = (case when @min=4 then x.monto else rof.monto4 end),
				monto5 = (case when @min=5 then x.monto else rof.monto5 end),
				monto6 = (case when @min=6 then x.monto else rof.monto6 end),
				monto7 = (case when @min=7 then x.monto else rof.monto7 end),
				monto8 = (case when @min=8 then x.monto else rof.monto8 end),
				monto9 = (case when @min=9 then x.monto else rof.monto9 end),
				monto10 = (case when @min=10 then x.monto else rof.monto10 end),
				monto11 = (case when @min=11 then x.monto else rof.monto11 end),
				monto12 = (case when @min=12 then x.monto else rof.monto12 end),
				monto13 = (case when @min=13 then x.monto else rof.monto13 end),
				monto_tot1 = (case when @min=1 then x.monto_tot else rof.monto_tot1 end),
				monto_tot2 = (case when @min=2 then x.monto_tot else rof.monto_tot2 end),
				monto_tot3 = (case when @min=3 then x.monto_tot else rof.monto_tot3 end),
				monto_tot4 = (case when @min=4 then x.monto_tot else rof.monto_tot4 end),
				monto_tot5 = (case when @min=5 then x.monto_tot else rof.monto_tot5 end),
				monto_tot6 = (case when @min=6 then x.monto_tot else rof.monto_tot6 end),
				monto_tot7 = (case when @min=7 then x.monto_tot else rof.monto_tot7 end),
				monto_tot8 = (case when @min=8 then x.monto_tot else rof.monto_tot8 end),
				monto_tot9 = (case when @min=9 then x.monto_tot else rof.monto_tot9 end),
				monto_tot10 = (case when @min=10 then x.monto_tot else rof.monto_tot10 end),
				monto_tot11 = (case when @min=11 then x.monto_tot else rof.monto_tot11 end),
				monto_tot12 = (case when @min=12 then x.monto_tot else rof.monto_tot12 end),
				monto_tot13 = (case when @min=13 then x.monto_tot else rof.monto_tot13 end)
			from #tResumenOperativoFin rof
			join (select 
						ro.id_concepto,
						monto=isNull(monto11,0),
						monto_tot=isNull(monto_tot11,0)
					from #tResumenOperativo ro) x on x.id_concepto = rof.id_concepto



			truncate table #tResumenOperativo

	select @min=@min+1
  end


--update #tResumenOperativoFin set separador_despues=1 where id in (4,10,13,16,25,30,36)
update #tResumenOperativoFin set separador_despues=1 where id_concepto in (4,10,13,16,25,29,35)



----
update #tResumenOperativoFin set orden=id*10


update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=10,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (1,2,3,4,9,1564,1565,7)) x on x.id_concepto=t.id_concepto


update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=5,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (5,6)) x on x.id_concepto=t.id_concepto


update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=24,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (21,24)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=25,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (17,18,19,24)) x on x.id_concepto=t.id_concepto




update t
set monto1 = x.monto1,
	monto2 = x.monto2,
	monto3 = x.monto3,
	monto4 = x.monto4,
	monto5 = x.monto5,
	monto6 = x.monto6,
	monto7 = x.monto7,
	monto8 = x.monto8,
	monto9 = x.monto9,
	monto10 = x.monto10,
	monto11 = x.monto11,
	monto12 = x.monto12,
	monto13 = x.monto13
from #tResumenOperativoFin t
join (select 
			id_concepto=26,
			monto1=sum(monto1),
			monto2=sum(monto2),
			monto3=sum(monto3),
			monto4=sum(monto4),
			monto5=sum(monto5),
			monto6=sum(monto6),
			monto7=sum(monto7),
			monto8=sum(monto8),
			monto9=sum(monto9),
			monto10=sum(monto10),
			monto11=sum(monto11),
			monto12=sum(monto12),
			monto13=sum(monto13)
		from #tResumenOperativoFin t2
		where id_concepto in (22,26)) x on x.id_concepto=t.id_concepto



update #tResumenOperativoFin set descripcion='Caja' where id_concepto=1
/*update #tResumenOperativoFin set descripcion='Cuentas por Cobrar' where id_concepto=2
update #tResumenOperativoFin set descripcion='Otros Activos Circulantes', orden=105 where id_concepto=7
update #tResumenOperativoFin set descripcion='Inversión en Acciones', orden=145 where id_concepto=5
update #tResumenOperativoFin set descripcion='Crédito Mercantil. España', orden=146 where id_concepto=3
update #tResumenOperativoFin set descripcion='Cargos Diferidos y Activo Intangible' where id_concepto=15
update #tResumenOperativoFin set descripcion='Pasivo Bancario CP' where id_concepto=17
update #tResumenOperativoFin set descripcion='Cuentas por Pagar' where id_concepto=18
update #tResumenOperativoFin set descripcion='Anticipo de Clientes' where id_concepto=19
update #tResumenOperativoFin set descripcion='Otros Pasivos Circulantes' where id_concepto=24
update #tResumenOperativoFin set descripcion='Pasivo Bancario LP' where id_concepto=26
update #tResumenOperativoFin set descripcion='Otros Pasivos LP. España' where id_concepto=27
update #tResumenOperativoFin set descripcion='Créditos Diferidos' where id_concepto=28
update #tResumenOperativoFin set descripcion='B-10' where id_concepto=32
update #tResumenOperativoFin set descripcion='Utilidades Retenidas' where id_concepto=33
*/

delete from #tResumenOperativoFin where id_concepto in (6,8,11,12,14,20,21,22,23,1566,1567,31)
--3 reusado

declare @monto_espania decimal(18,2), @monto_espania2 decimal(18,2), @monto100porciento decimal(18,2)
select @min=1, @max=13
while @min<=@max
begin
		select @anio_calc=anio, @periodo_calc=periodo from @tablaMeses where id=@min
		select @monto_espania=dbo.fn_credito_mercantil_espania(@anio_calc,@periodo_calc)
		select @monto_espania2=dbo.fn_otros_pasivos_espania(@anio_calc,@periodo_calc)
		
		update t
		set monto1=(case when @min=1 then @monto_espania else t.monto1 end),
			monto2=(case when @min=2 then @monto_espania else t.monto2 end),
			monto3=(case when @min=3 then @monto_espania else t.monto3 end),
			monto4=(case when @min=4 then @monto_espania else t.monto4 end),
			monto5=(case when @min=5 then @monto_espania else t.monto5 end),
			monto6=(case when @min=6 then @monto_espania else t.monto6 end),
			monto7=(case when @min=7 then @monto_espania else t.monto7 end),
			monto8=(case when @min=8 then @monto_espania else t.monto8 end),
			monto9=(case when @min=9 then @monto_espania else t.monto9 end),
			monto10=(case when @min=10 then @monto_espania else t.monto10 end),
			monto11=(case when @min=11 then @monto_espania else t.monto11 end),
			monto12=(case when @min=12 then @monto_espania else t.monto12 end),
			monto13=(case when @min=13 then @monto_espania else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=3 --concepto reusado
		
		update t
		set monto1=(case when @min=1 then t.monto1-@monto_espania else t.monto1 end),
			monto2=(case when @min=2 then t.monto2-@monto_espania else t.monto2 end),
			monto3=(case when @min=3 then t.monto3-@monto_espania else t.monto3 end),
			monto4=(case when @min=4 then t.monto4-@monto_espania else t.monto4 end),
			monto5=(case when @min=5 then t.monto5-@monto_espania else t.monto5 end),
			monto6=(case when @min=6 then t.monto6-@monto_espania else t.monto6 end),
			monto7=(case when @min=7 then t.monto7-@monto_espania else t.monto7 end),
			monto8=(case when @min=8 then t.monto8-@monto_espania else t.monto8 end),
			monto9=(case when @min=9 then t.monto9-@monto_espania else t.monto9 end),
			monto10=(case when @min=10 then t.monto10-@monto_espania else t.monto10 end),
			monto11=(case when @min=11 then t.monto11-@monto_espania else t.monto11 end),
			monto12=(case when @min=12 then t.monto12-@monto_espania else t.monto12 end),
			monto13=(case when @min=13 then t.monto13-@monto_espania else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=15
		

		update t
		set monto1=(case when @min=1 then @monto_espania2 else t.monto1 end),
			monto2=(case when @min=2 then @monto_espania2 else t.monto2 end),
			monto3=(case when @min=3 then @monto_espania2 else t.monto3 end),
			monto4=(case when @min=4 then @monto_espania2 else t.monto4 end),
			monto5=(case when @min=5 then @monto_espania2 else t.monto5 end),
			monto6=(case when @min=6 then @monto_espania2 else t.monto6 end),
			monto7=(case when @min=7 then @monto_espania2 else t.monto7 end),
			monto8=(case when @min=8 then @monto_espania2 else t.monto8 end),
			monto9=(case when @min=9 then @monto_espania2 else t.monto9 end),
			monto10=(case when @min=10 then @monto_espania2 else t.monto10 end),
			monto11=(case when @min=11 then @monto_espania2 else t.monto11 end),
			monto12=(case when @min=12 then @monto_espania2 else t.monto12 end),
			monto13=(case when @min=13 then @monto_espania2 else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=27
		
		update t
		set monto1=(case when @min=1 then t.monto1-@monto_espania2 else t.monto1 end),
			monto2=(case when @min=2 then t.monto2-@monto_espania2 else t.monto2 end),
			monto3=(case when @min=3 then t.monto3-@monto_espania2 else t.monto3 end),
			monto4=(case when @min=4 then t.monto4-@monto_espania2 else t.monto4 end),
			monto5=(case when @min=5 then t.monto5-@monto_espania2 else t.monto5 end),
			monto6=(case when @min=6 then t.monto6-@monto_espania2 else t.monto6 end),
			monto7=(case when @min=7 then t.monto7-@monto_espania2 else t.monto7 end),
			monto8=(case when @min=8 then t.monto8-@monto_espania2 else t.monto8 end),
			monto9=(case when @min=9 then t.monto9-@monto_espania2 else t.monto9 end),
			monto10=(case when @min=10 then t.monto10-@monto_espania2 else t.monto10 end),
			monto11=(case when @min=11 then t.monto11-@monto_espania2 else t.monto11 end),
			monto12=(case when @min=12 then t.monto12-@monto_espania2 else t.monto12 end),
			monto13=(case when @min=13 then t.monto13-@monto_espania2 else t.monto13 end)
		from #tResumenOperativoFin t
		where id_concepto=28


		select @monto100porciento = (case 
										when @min=1 then t.monto1 
										when @min=2 then t.monto2
										when @min=3 then t.monto3 
										when @min=4 then t.monto4 
										when @min=5 then t.monto5 
										when @min=6 then t.monto6 
										when @min=7 then t.monto7 
										when @min=8 then t.monto8 
										when @min=9 then t.monto9 
										when @min=10 then t.monto10 
										when @min=11 then t.monto11 
										when @min=12 then t.monto12 
										when @min=13 then t.monto13 
									else 0 end)
		from #tResumenOperativoFin t
		where id_concepto=16

		if @monto100porciento > 0
			update t
			set monto_tot1=(case when @min=1 then monto1/@monto100porciento*100.0 else t.monto_tot1 end),
				monto_tot2=(case when @min=2 then monto2/@monto100porciento*100.0 else t.monto_tot2 end),
				monto_tot3=(case when @min=3 then monto3/@monto100porciento*100.0 else t.monto_tot3 end),
				monto_tot4=(case when @min=4 then monto4/@monto100porciento*100.0 else t.monto_tot4 end),
				monto_tot5=(case when @min=5 then monto5/@monto100porciento*100.0 else t.monto_tot5 end),
				monto_tot6=(case when @min=6 then monto6/@monto100porciento*100.0 else t.monto_tot6 end),
				monto_tot7=(case when @min=7 then monto7/@monto100porciento*100.0 else t.monto_tot7 end),
				monto_tot8=(case when @min=8 then monto8/@monto100porciento*100.0 else t.monto_tot8 end),
				monto_tot9=(case when @min=9 then monto9/@monto100porciento*100.0 else t.monto_tot9 end),
				monto_tot10=(case when @min=10 then monto10/@monto100porciento*100.0 else t.monto_tot10 end),
				monto_tot11=(case when @min=11 then monto11/@monto100porciento*100.0 else t.monto_tot11 end),
				monto_tot12=(case when @min=12 then monto12/@monto100porciento*100.0 else t.monto_tot12 end),
				monto_tot13=(case when @min=13 then monto13/@monto100porciento*100.0 else t.monto_tot13 end)
			from #tResumenOperativoFin t


		IF OBJECT_ID('tempdb..#tBalanceGeneralDatosExtra') IS NOT NULL
		 BEGIN
			--CUENTAS POR COBRAR
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=7,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (2)) x on x.id=t.id

			--CUENTAS POR PAGAR
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=8,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (18)) x on x.id=t.id

			--ACTIVO CIRCULANTE
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=9,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (10)) x on x.id=t.id

			--PASIVO CIRCULANTE
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=10,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (25)) x on x.id=t.id

			--Pasivo Bancario CP
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=11,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (17)) x on x.id=t.id

			--Pasivo Bancario LP
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=12,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (26)) x on x.id=t.id

			--ACTIVO TOTAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=13,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (16)) x on x.id=t.id

			--PASIVO MAS CAPITAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=14,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (36)) x on x.id=t.id

			--PASIVO MAS CAPITAL
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=15,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (34)) x on x.id=t.id

			--INVENTARIO
			update t
			set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5, 
				monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,
				monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13
			from #tBalanceGeneralDatosExtra t
			join (select id=24,
						monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),
						monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),
						monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),
						monto13=sum(monto13)
					from #tResumenOperativoFin t2
					where id_concepto in (4)) x on x.id=t.id
			
--  reporte_ejecutivo_7 2013,5
		 END


		select @min=@min+1
  end


select @periodo=@periodo-1
if @periodo=0
	select @periodo=12, @anio=@anio-1
else
	select @periodo=@periodo


update #tResumenOperativoFin
set plan1=(select sum(isNull(monto5,0)) 
			from reporte_captura 
			where id_reporte=5 and id_concepto=111 
			and anio=@anio and periodo=@periodo)
where id_concepto=1

if @periodo=12
	select @periodo=1,
			@anio=@anio+1
else
	select @periodo=@periodo+1

update #tResumenOperativoFin
set plan2=(select sum(isNull(monto5,0)) 
			from reporte_captura 
			where id_reporte=5 and id_concepto=111 
			and anio=@anio and periodo=@periodo)
where id_concepto=1

update #tResumenOperativoFin
set var1=abs(monto1-plan1),
	var2=abs(monto1-plan2)
where id_concepto=1


insert into #tReporteCalculos (id, descripcion, monto_mes1, monto_mes2, monto_mes3, monto_mes4, monto_mes5,
								monto_mes6, monto_mes7, monto_mes8, monto_mes9, monto_mes10, monto_mes11, monto_mes12)
select id,
	descripcion,
	monto1 = convert(int,round(isNull(monto1,0),0)),
	monto2 = convert(int,round(isNull(monto2,0),0)),
	monto3 = convert(int,round(isNull(monto3,0),0)),
	monto4 = convert(int,round(isNull(monto4,0),0)),
	monto5 = convert(int,round(isNull(monto5,0),0)),
	monto6 = convert(int,round(isNull(monto6,0),0)),
	monto7 = convert(int,round(isNull(monto7,0),0)),
	monto8 = convert(int,round(isNull(monto8,0),0)),
	monto9 = convert(int,round(isNull(monto9,0),0)),
	monto10 = convert(int,round(isNull(monto10,0),0)),
	monto11 = convert(int,round(isNull(monto11,0),0)),
	monto12 = convert(int,round(isNull(monto12,0),0))
from #tResumenOperativoFin
order by orden


drop table #tResumenOperativo
drop table #tResumenOperativoFin
drop table #tEmpresas


Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE procedure [dbo].[reporte_ejecutivo_7_fe]  
 @anio int,  
 @periodo int,  
 @id_empresa int,  
 @valor_resultado int output  
as  
  
/*  
declare @anio int,  
 @periodo int  
  
select @anio=2013,  
  @periodo=6  
*/  
  
set nocount on  
  
declare @tablaMeses table   
(  
 id int identity(1,1),  
 anio int,  
 periodo int  
)  
  
declare @i int,  
  @anio_i int,  
  @periodo_i int  
    
select @i=1,  
  @anio_i=@anio,  
  @periodo_i=@periodo  
    
while @i<=13  
  begin  
    
 if @periodo_i<1  
  select @periodo_i=12, @anio_i=@anio_i-1  
    
 insert into @tablaMeses values (@anio_i, @periodo_i)  
    
 select @periodo_i = @periodo_i - 1  
 select @i = @i + 1  
  end  
  
/*  
delete from @tablaMeses where anio=@anio and @periodo in (5,6,7,8,9,10,11,12) and periodo in (1,2)  
delete from @tablaMeses where anio=@anio and @periodo in (7,8,9,10,11,12) and periodo in (4,5)  
delete from @tablaMeses where anio=@anio and @periodo in (9,10,11,12) and periodo in (7,8)  
delete from @tablaMeses where anio=@anio and @periodo in (12) and periodo in (10,11)  
  
delete from @tablaMeses where anio=@anio-1 and periodo<12  
  
*/  
  
-------------------------------------------------------------------------  
-------------------------------------------------------------------------  
-------------------------------------------------------------------------  
  
--LB 20150805: Se agrego la empresa 12  
create table #tResumenOperativo  
(  
 id int identity(1,1),  
 id_concepto int,  
 id_concepto_plan int,  
 descripcion varchar(152),  
  
 monto1 decimal(18,2), --NBM -Nutec Bickley SA de CV  
 monto2 decimal(18,2), --NE -Nutec Europe  
 monto3 decimal(18,2), --NP -Nutec Procal  
 monto4 decimal(18,2), --NE+NP -Espana  
 monto5 decimal(18,2), --NF -Nutec Fibratec SA de CV  
 monto5_2 decimal(18,2), --NF -Nutec Fibratec SA de CV  
 monto6 decimal(18,2), --NS  
 monto7 decimal(18,2), --Suma  
 monto8 decimal(18,2), --GNU -Grupo Nutec  
 monto9 decimal(18,2), --Cargos  
 monto10 decimal(18,2), --Creditos  
 monto11 decimal(18,2), --Consolidado  
 monto12 decimal(18,2), --NUSA     
 monto13 decimal(18,2), --NPC
  
 monto_tot1 decimal(18,2), --NBM -Nutec Bickley SA de CV  
 monto_tot2 decimal(18,2), --NE -Nutec Europe  
 monto_tot3 decimal(18,2), --NP -Nutec Procal  
 monto_tot4 decimal(18,2), --NE+NP -Espana  
 monto_tot5 decimal(18,2), --NF -Nutec Fibratec SA de CV  
 monto_tot5_2 decimal(18,2), --NUSA
 monto_tot6 decimal(18,2), --NS  
 monto_tot7 decimal(18,2), --Suma  
 monto_tot8 decimal(18,2), --GNU -Grupo Nutec  
 monto_tot9 decimal(18,2), --Cargos  
 monto_tot10 decimal(18,2), --Creditos  
 monto_tot11 decimal(18,2), --Consolidado  
 monto_tot12 decimal(18,2), --NUSA
 monto_tot13 decimal(18,2), --NPC
  
 es_porcentaje bit,  
 es_multivalor bit,  
 permite_captura bit,  
 es_separador bit  
)  
  
  
  
create table #tResumenOperativoFin  
(  
 id int identity(1,1),  
 id_concepto int,  
 id_concepto_plan int,  
 descripcion varchar(152),  
  
 monto1 decimal(18,2),  
 monto2 decimal(18,2),  
 monto3 decimal(18,2),  
 monto4 decimal(18,2),  
 monto5 decimal(18,2),  
 monto6 decimal(18,2),  
 monto7 decimal(18,2),  
 monto8 decimal(18,2),  
 monto9 decimal(18,2),  
 monto10 decimal(18,2),  
 monto11 decimal(18,2),  
 monto12 decimal(18,2),  
 monto13 decimal(18,2),   
  
 monto_tot1 decimal(18,2),  
 monto_tot2 decimal(18,2),  
 monto_tot3 decimal(18,2),  
 monto_tot4 decimal(18,2),  
 monto_tot5 decimal(18,2),  
 monto_tot6 decimal(18,2),  
 monto_tot7 decimal(18,2),  
 monto_tot8 decimal(18,2),  
 monto_tot9 decimal(18,2),  
 monto_tot10 decimal(18,2),  
 monto_tot11 decimal(18,2),  
 monto_tot12 decimal(18,2),  
 monto_tot13 decimal(18,2),  
  
 es_porcentaje bit,  
 es_multivalor bit,  
 permite_captura bit,  
 separador_despues bit default(0),  
 orden int,  
 plan1 int default(0),  
 var1 int default(0),  
 plan2 int default(0),  
 var2 int default(0)  
)  
  
insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)  
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0  
from concepto  
where id_reporte = 1  
and es_plan = 0  
and es_borrado = 0
order by orden  
  
  
  
  
  
  
  
  
  
  
declare @min int,  
  @max int  
  
select @min=1,  
  @max=13  
  
declare @anio_calc int,  
  @periodo_calc int  
  
while @min<=@max  
  begin  
   
  
   select @anio_calc=anio,  
     @periodo_calc=periodo  
   from @tablaMeses  
   where id=@min  
     
   exec reporte_balance_ajustes_ejecutivo @anio_calc, @periodo_calc, @id_empresa  
  
  
  
   update rof  
   set monto1 = (case when @min=1 then x.monto else rof.monto1 end),  
    monto2 = (case when @min=2 then x.monto else rof.monto2 end),  
    monto3 = (case when @min=3 then x.monto else rof.monto3 end),  
    monto4 = (case when @min=4 then x.monto else rof.monto4 end),  
    monto5 = (case when @min=5 then x.monto else rof.monto5 end),  
    monto6 = (case when @min=6 then x.monto else rof.monto6 end),  
    monto7 = (case when @min=7 then x.monto else rof.monto7 end),  
    monto8 = (case when @min=8 then x.monto else rof.monto8 end),  
    monto9 = (case when @min=9 then x.monto else rof.monto9 end),  
    monto10 = (case when @min=10 then x.monto else rof.monto10 end),  
    monto11 = (case when @min=11 then x.monto else rof.monto11 end),  
    monto12 = (case when @min=12 then x.monto else rof.monto12 end),  
    monto13 = (case when @min=13 then x.monto else rof.monto13 end),  
    monto_tot1 = (case when @min=1 then x.monto_tot else rof.monto_tot1 end),  
    monto_tot2 = (case when @min=2 then x.monto_tot else rof.monto_tot2 end),  
    monto_tot3 = (case when @min=3 then x.monto_tot else rof.monto_tot3 end),  
    monto_tot4 = (case when @min=4 then x.monto_tot else rof.monto_tot4 end),  
    monto_tot5 = (case when @min=5 then x.monto_tot else rof.monto_tot5 end),  
    monto_tot6 = (case when @min=6 then x.monto_tot else rof.monto_tot6 end),  
    monto_tot7 = (case when @min=7 then x.monto_tot else rof.monto_tot7 end),  
    monto_tot8 = (case when @min=8 then x.monto_tot else rof.monto_tot8 end),  
    monto_tot9 = (case when @min=9 then x.monto_tot else rof.monto_tot9 end),  
    monto_tot10 = (case when @min=10 then x.monto_tot else rof.monto_tot10 end),  
    monto_tot11 = (case when @min=11 then x.monto_tot else rof.monto_tot11 end),  
    monto_tot12 = (case when @min=12 then x.monto_tot else rof.monto_tot12 end),  
    monto_tot13 = (case when @min=13 then x.monto_tot else rof.monto_tot13 end)  
   from #tResumenOperativoFin rof  
   join (select   
      ro.id_concepto,  
      monto=isNull(monto11,0),  
      monto_tot=isNull(monto_tot11,0)  
     from #tResumenOperativo ro) x on x.id_concepto = rof.id_concepto  
  
  
  
   truncate table #tResumenOperativo  
  
 select @min=@min+1  
  end  
  
  
--update #tResumenOperativoFin set separador_despues=1 where id in (4,10,13,16,25,30,36)  
update #tResumenOperativoFin set separador_despues=1 where id_concepto in (4,10,13,16,25,29,35)  
  
  
  
----  
update #tResumenOperativoFin set orden=id*10  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=10,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (1,2,3,4,9,1564,1565,7)) x on x.id_concepto=t.id_concepto  
  
  
update t  
set monto1 = x.monto1,  
monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=5,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (5,6)) x on x.id_concepto=t.id_concepto  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=24,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (21,24)) x on x.id_concepto=t.id_concepto  
  
  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=25,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (17,18,19,24)) x on x.id_concepto=t.id_concepto  
  
  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=26,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (22,26)) x on x.id_concepto=t.id_concepto  
  
  
  
update #tResumenOperativoFin set descripcion='Caja' where id_concepto=1  
update #tResumenOperativoFin set descripcion='Cuentas por Cobrar' where id_concepto=2  
update #tResumenOperativoFin set descripcion='Otros Activos Circulantes', orden=95 where id_concepto=7  --115
update #tResumenOperativoFin set descripcion='Inversión en Acciones', orden=135 where id_concepto=5  --155
update #tResumenOperativoFin set descripcion='Crédito Mercantil. España', orden=136 where id_concepto=3  --156
update #tResumenOperativoFin set descripcion='Cargos Diferidos y Activo Intangible' where id_concepto=15  
update #tResumenOperativoFin set descripcion='Pasivo Bancario CP' where id_concepto=17  
update #tResumenOperativoFin set descripcion='Cuentas por Pagar' where id_concepto=18  
update #tResumenOperativoFin set descripcion='Anticipo de Clientes' where id_concepto=19  
update #tResumenOperativoFin set descripcion='Otros Pasivos Circulantes' where id_concepto=24  
update #tResumenOperativoFin set descripcion='Pasivo Bancario LP' where id_concepto=26  
update #tResumenOperativoFin set descripcion='Otros Pasivos LP. España' where id_concepto=27  
update #tResumenOperativoFin set descripcion='Créditos Diferidos' where id_concepto=28  
update #tResumenOperativoFin set descripcion='B-10' where id_concepto=32  
update #tResumenOperativoFin set descripcion='Utilidades Retenidas' where id_concepto=33  
  
  
delete from #tResumenOperativoFin where id_concepto in (6,8,11,12,14,20,21,22,23,1566,1567,31)  
--3 reusado  
  
declare @monto_espania decimal(18,2), @monto_espania2 decimal(18,2), @monto100porciento decimal(18,2)  
select @min=1, @max=13  
while @min<=@max  
begin  
  select @anio_calc=anio, @periodo_calc=periodo from @tablaMeses where id=@min  
  select @monto_espania=dbo.fn_credito_mercantil_espania(@anio_calc,@periodo_calc)  
  select @monto_espania2=dbo.fn_otros_pasivos_espania(@anio_calc,@periodo_calc)  
    
  update t  
  set monto1=(case when @min=1 then @monto_espania else t.monto1 end),  
   monto2=(case when @min=2 then @monto_espania else t.monto2 end),  
   monto3=(case when @min=3 then @monto_espania else t.monto3 end),  
   monto4=(case when @min=4 then @monto_espania else t.monto4 end),  
   monto5=(case when @min=5 then @monto_espania else t.monto5 end),  
   monto6=(case when @min=6 then @monto_espania else t.monto6 end),  
   monto7=(case when @min=7 then @monto_espania else t.monto7 end),  
   monto8=(case when @min=8 then @monto_espania else t.monto8 end),  
   monto9=(case when @min=9 then @monto_espania else t.monto9 end),  
   monto10=(case when @min=10 then @monto_espania else t.monto10 end),  
   monto11=(case when @min=11 then @monto_espania else t.monto11 end),  
   monto12=(case when @min=12 then @monto_espania else t.monto12 end),  
   monto13=(case when @min=13 then @monto_espania else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=3 --concepto reusado  
    
  update t  
  set monto1=(case when @min=1 then t.monto1-@monto_espania else t.monto1 end),  
   monto2=(case when @min=2 then t.monto2-@monto_espania else t.monto2 end),  
   monto3=(case when @min=3 then t.monto3-@monto_espania else t.monto3 end),  
   monto4=(case when @min=4 then t.monto4-@monto_espania else t.monto4 end),  
   monto5=(case when @min=5 then t.monto5-@monto_espania else t.monto5 end),  
   monto6=(case when @min=6 then t.monto6-@monto_espania else t.monto6 end),  
   monto7=(case when @min=7 then t.monto7-@monto_espania else t.monto7 end),  
   monto8=(case when @min=8 then t.monto8-@monto_espania else t.monto8 end),  
   monto9=(case when @min=9 then t.monto9-@monto_espania else t.monto9 end),  
   monto10=(case when @min=10 then t.monto10-@monto_espania else t.monto10 end),  
   monto11=(case when @min=11 then t.monto11-@monto_espania else t.monto11 end),  
   monto12=(case when @min=12 then t.monto12-@monto_espania else t.monto12 end),  
   monto13=(case when @min=13 then t.monto13-@monto_espania else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=15  
    
  
  update t  
  set monto1=(case when @min=1 then @monto_espania2 else t.monto1 end),  
   monto2=(case when @min=2 then @monto_espania2 else t.monto2 end),  
   monto3=(case when @min=3 then @monto_espania2 else t.monto3 end),  
   monto4=(case when @min=4 then @monto_espania2 else t.monto4 end),  
   monto5=(case when @min=5 then @monto_espania2 else t.monto5 end),  
   monto6=(case when @min=6 then @monto_espania2 else t.monto6 end),  
   monto7=(case when @min=7 then @monto_espania2 else t.monto7 end),  
   monto8=(case when @min=8 then @monto_espania2 else t.monto8 end),  
   monto9=(case when @min=9 then @monto_espania2 else t.monto9 end),  
   monto10=(case when @min=10 then @monto_espania2 else t.monto10 end),  
   monto11=(case when @min=11 then @monto_espania2 else t.monto11 end),  
   monto12=(case when @min=12 then @monto_espania2 else t.monto12 end),  
   monto13=(case when @min=13 then @monto_espania2 else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=27  
    
  update t  
  set monto1=(case when @min=1 then t.monto1-@monto_espania2 else t.monto1 end),  
   monto2=(case when @min=2 then t.monto2-@monto_espania2 else t.monto2 end),  
   monto3=(case when @min=3 then t.monto3-@monto_espania2 else t.monto3 end),  
   monto4=(case when @min=4 then t.monto4-@monto_espania2 else t.monto4 end),  
   monto5=(case when @min=5 then t.monto5-@monto_espania2 else t.monto5 end),  
   monto6=(case when @min=6 then t.monto6-@monto_espania2 else t.monto6 end),  
   monto7=(case when @min=7 then t.monto7-@monto_espania2 else t.monto7 end),  
   monto8=(case when @min=8 then t.monto8-@monto_espania2 else t.monto8 end),  
   monto9=(case when @min=9 then t.monto9-@monto_espania2 else t.monto9 end),  
   monto10=(case when @min=10 then t.monto10-@monto_espania2 else t.monto10 end),  
   monto11=(case when @min=11 then t.monto11-@monto_espania2 else t.monto11 end),  
   monto12=(case when @min=12 then t.monto12-@monto_espania2 else t.monto12 end),  
   monto13=(case when @min=13 then t.monto13-@monto_espania2 else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=28  
  
  
  select @monto100porciento = (case   
          when @min=1 then t.monto1   
          when @min=2 then t.monto2  
          when @min=3 then t.monto3   
          when @min=4 then t.monto4   
          when @min=5 then t.monto5   
          when @min=6 then t.monto6   
          when @min=7 then t.monto7   
          when @min=8 then t.monto8   
          when @min=9 then t.monto9   
          when @min=10 then t.monto10   
          when @min=11 then t.monto11   
          when @min=12 then t.monto12   
          when @min=13 then t.monto13   
         else 0 end)  
  from #tResumenOperativoFin t  
  where id_concepto=16  
  
  if @monto100porciento > 0  
   update t  
   set monto_tot1=(case when @min=1 then monto1/@monto100porciento*100.0 else t.monto_tot1 end),  
    monto_tot2=(case when @min=2 then monto2/@monto100porciento*100.0 else t.monto_tot2 end),  
    monto_tot3=(case when @min=3 then monto3/@monto100porciento*100.0 else t.monto_tot3 end),  
    monto_tot4=(case when @min=4 then monto4/@monto100porciento*100.0 else t.monto_tot4 end),  
    monto_tot5=(case when @min=5 then monto5/@monto100porciento*100.0 else t.monto_tot5 end),  
    monto_tot6=(case when @min=6 then monto6/@monto100porciento*100.0 else t.monto_tot6 end),  
    monto_tot7=(case when @min=7 then monto7/@monto100porciento*100.0 else t.monto_tot7 end),  
    monto_tot8=(case when @min=8 then monto8/@monto100porciento*100.0 else t.monto_tot8 end),  
    monto_tot9=(case when @min=9 then monto9/@monto100porciento*100.0 else t.monto_tot9 end),  
    monto_tot10=(case when @min=10 then monto10/@monto100porciento*100.0 else t.monto_tot10 end),  
    monto_tot11=(case when @min=11 then monto11/@monto100porciento*100.0 else t.monto_tot11 end),  
    monto_tot12=(case when @min=12 then monto12/@monto100porciento*100.0 else t.monto_tot12 end),  
    monto_tot13=(case when @min=13 then monto13/@monto100porciento*100.0 else t.monto_tot13 end)  
   from #tResumenOperativoFin t  
 
  
  IF OBJECT_ID('tempdb..#tBalanceGeneralDatosExtra') IS NOT NULL  
   BEGIN  
   --CUENTAS POR COBRAR  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=7,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (2)) x on x.id=t.id  
  
   --CUENTAS POR PAGAR  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=8,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (18)) x on x.id=t.id  
  
   --ACTIVO CIRCULANTE  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=9,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (10)) x on x.id=t.id  
  
   --PASIVO CIRCULANTE  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=10,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (25)) x on x.id=t.id  
  
   --Pasivo Bancario CP  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=11,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (17)) x on x.id=t.id  
  
   --Pasivo Bancario LP  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=12,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (26)) x on x.id=t.id  
  
   --ACTIVO TOTAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=13,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (16)) x on x.id=t.id  
  
   --PASIVO MAS CAPITAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=14,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (36)) x on x.id=t.id  
  
   --PASIVO MAS CAPITAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=15,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (34)) x on x.id=t.id  
  
   --INVENTARIO  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=24,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (4)) x on x.id=t.id  
     
--  reporte_ejecutivo_7 2013,5  
   END  
  
  
  select @min=@min+1  
  end  
  
  
select @periodo=@periodo-1  
if @periodo=0  
 select @periodo=12, @anio=@anio-1  
else  
 select @periodo=@periodo  
  
  
update #tResumenOperativoFin  
set plan1=(select sum(isNull(monto5,0))   
   from reporte_captura   
   where id_reporte=5 and id_concepto=111   
   and anio=@anio and periodo=@periodo)  
where id_concepto=1  
  
if @periodo=12  
 select @periodo=1,  
   @anio=@anio+1  
else  
 select @periodo=@periodo+1  
  
update #tResumenOperativoFin  
set plan2=(select sum(isNull(monto5,0))   
   from reporte_captura   
   where id_reporte=5 and id_concepto=111   
   and anio=@anio and periodo=@periodo)  
where id_concepto=1  
  
update #tResumenOperativoFin  
set var1=abs(monto1-plan1),  
 var2=abs(monto1-plan2)  
where id_concepto=1  
  
select @valor_resultado = convert(int,round(isNull(monto1,0),0))  
from #tResumenOperativoFin  
where id_concepto=1  
  
/*  
select id,  
 id_concepto,  
 descripcion,  
 orden,  
 monto1 = convert(int,round(isNull(monto1,0),0)),  
 monto2 = convert(int,round(isNull(monto2,0),0)),  
 monto3 = convert(int,round(isNull(monto3,0),0)),  
 monto4 = convert(int,round(isNull(monto4,0),0)),  
 monto5 = convert(int,round(isNull(monto5,0),0)),  
 monto6 = convert(int,round(isNull(monto6,0),0)),  
 monto7 = convert(int,round(isNull(monto7,0),0)),  
 monto8 = convert(int,round(isNull(monto8,0),0)),  
 monto9 = convert(int,round(isNull(monto9,0),0)),  
 monto10 = convert(int,round(isNull(monto10,0),0)),  
 monto11 = convert(int,round(isNull(monto11,0),0)),  
 monto12 = convert(int,round(isNull(monto12,0),0)),  
 monto13 = convert(int,round(isNull(monto13,0),0)),  
 monto_tot1 = convert(int,round(isNull(monto_tot1,0),0)),  
 monto_tot2 = convert(int,round(isNull(monto_tot2,0),0)),  
 monto_tot3 = convert(int,round(isNull(monto_tot3,0),0)),  
 monto_tot4 = convert(int,round(isNull(monto_tot4,0),0)),  
 monto_tot5 = convert(int,round(isNull(monto_tot5,0),0)),  
 monto_tot6 = convert(int,round(isNull(monto_tot6,0),0)),  
 monto_tot7 = convert(int,round(isNull(monto_tot7,0),0)),  
 monto_tot8 = convert(int,round(isNull(monto_tot8,0),0)),  
 monto_tot9 = convert(int,round(isNull(monto_tot9,0),0)),  
 monto_tot10 = convert(int,round(isNull(monto_tot10,0),0)),  
 monto_tot11 = convert(int,round(isNull(monto_tot11,0),0)),  
 monto_tot12 = convert(int,round(isNull(monto_tot12,0),0)),  
 monto_tot13 = convert(int,round(isNull(monto_tot13,0),0)),  
   
 es_porcentaje,  
 es_multivalor,  
 permite_captura,  
 separador_despues,  
 plan1,  
 var1,  
 plan2,  
 var2,  
 diciembre = (select id from @tablaMeses where anio=@anio-1 and periodo=12)  
from #tResumenOperativoFin  
order by orden  
*/  
  
drop table #tResumenOperativo  
drop table #tResumenOperativoFin  


Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE procedure [dbo].[reporte_ejecutivo_7]  
 @anio int,  
 @periodo int  
as  
  
  

/*
declare @anio int,
		@periodo int

select @anio=2022,
		@periodo=1
*/
  
set nocount on  


  
declare @tablaMeses table   
(  
 id int identity(1,1),  
 anio int,  
 periodo int  
)  
  
declare @i int,  
  @anio_i int,  
  @periodo_i int  
    
select @i=1,  
  @anio_i=@anio,  
  @periodo_i=@periodo  
    
while @i<=13  
  begin  
    
 if @periodo_i<1  
  select @periodo_i=12, @anio_i=@anio_i-1  
    
 insert into @tablaMeses values (@anio_i, @periodo_i)  
    
 select @periodo_i = @periodo_i - 1  
 select @i = @i + 1  
  end  
  
/*  
delete from @tablaMeses where anio=@anio and @periodo in (5,6,7,8,9,10,11,12) and periodo in (1,2)  
delete from @tablaMeses where anio=@anio and @periodo in (7,8,9,10,11,12) and periodo in (4,5)  
delete from @tablaMeses where anio=@anio and @periodo in (9,10,11,12) and periodo in (7,8)  
delete from @tablaMeses where anio=@anio and @periodo in (12) and periodo in (10,11)  
delete from @tablaMeses where anio=@anio-1 and periodo<12  
*/  
  
-------------------------------------------------------------------------  
-------------------------------------------------------------------------  
-------------------------------------------------------------------------  
  
--LB 20150805: Se agrego la empresa 12  
create table #tResumenOperativo  
(  
 id int identity(1,1),  
 id_concepto int,  
 id_concepto_plan int,  
 descripcion varchar(152),  
  
 monto1 decimal(18,2), --NBM -Nutec Bickley SA de CV  
 monto2 decimal(18,2), --NE -Nutec Europe  
 monto3 decimal(18,2), --NP -Nutec Procal  
 monto4 decimal(18,2), --NE+NP -Espana  
 monto5 decimal(18,2), --NF -Nutec Fibratec SA de CV  
 monto5_2 decimal(18,2), --NUSA
 monto6 decimal(18,2), --NS  
 monto7 decimal(18,2), --Suma  
 monto8 decimal(18,2), --GNU -Grupo Nutec  
 monto9 decimal(18,2), --Cargos  
 monto10 decimal(18,2), --Creditos  
 monto11 decimal(18,2), --Consolidado  
 monto12 decimal(18,2), --NUSA  
 monto13 decimal(18,2), --NPC
  
 monto_tot1 decimal(18,2), --NBM -Nutec Bickley SA de CV  
 monto_tot2 decimal(18,2), --NE -Nutec Europe  
 monto_tot3 decimal(18,2), --NP -Nutec Procal  
 monto_tot4 decimal(18,2), --NE+NP -Espana  
 monto_tot5 decimal(18,2), --NF -Nutec Fibratec SA de CV  
 monto_tot5_2 decimal(18,2), --NUSA
 monto_tot6 decimal(18,2), --NS  
 monto_tot7 decimal(18,2), --Suma  
 monto_tot8 decimal(18,2), --GNU -Grupo Nutec  
 monto_tot9 decimal(18,2), --Cargos  
 monto_tot10 decimal(18,2), --Creditos  
 monto_tot11 decimal(18,2), --Consolidado  
 monto_tot12 decimal(18,2), --NUSA  
 monto_tot13 decimal(18,2), --NPC
 
 es_porcentaje bit,  
 es_multivalor bit,  
 permite_captura bit,  
 es_separador bit  
)  
  
  
  
create table #tResumenOperativoFin  
(  
 id int identity(1,1),  
 id_concepto int,  
 id_concepto_plan int,  
 descripcion varchar(152),  
  
 monto1 decimal(18,2),  
 monto2 decimal(18,2),  
 monto3 decimal(18,2),  
 monto4 decimal(18,2),  
 monto5 decimal(18,2),  
 monto6 decimal(18,2),  
 monto7 decimal(18,2),  
 monto8 decimal(18,2),  
 monto9 decimal(18,2),  
 monto10 decimal(18,2),  
 monto11 decimal(18,2),  
 monto12 decimal(18,2),  
 monto13 decimal(18,2),  
  
 monto_tot1 decimal(18,2),  
 monto_tot2 decimal(18,2),  
 monto_tot3 decimal(18,2),  
 monto_tot4 decimal(18,2),  
 monto_tot5 decimal(18,2),  
 monto_tot6 decimal(18,2),  
 monto_tot7 decimal(18,2),  
 monto_tot8 decimal(18,2),  
 monto_tot9 decimal(18,2),  
 monto_tot10 decimal(18,2),  
 monto_tot11 decimal(18,2),  
 monto_tot12 decimal(18,2),  
 monto_tot13 decimal(18,2),  
  
 es_porcentaje bit,  
 es_multivalor bit,  
 permite_captura bit,  
 separador_despues bit default(0),  
 orden int,  
 plan1 int default(0),  
 var1 int default(0),  
 plan2 int default(0),  
 var2 int default(0)  
)  
  
insert into #tResumenOperativoFin (id_concepto, id_concepto_plan, descripcion, permite_captura, es_porcentaje, es_multivalor)  
select id_concepto, id_concepto, descripcion, permite_captura, 0, 0  
from concepto  
where id_reporte = 1  
and es_plan = 0  
and es_borrado = 0
order by orden  
  
  
  
  
  
  
  
  
  
  
declare @min int,  
  @max int  
  
select @min=1,  
  @max=13  
  
declare @anio_calc int,  
  @periodo_calc int  
  
while @min<=@max  
  begin  
   
  
   select @anio_calc=anio,  
     @periodo_calc=periodo  
   from @tablaMeses  
   where id=@min  
        exec reporte_balance_ajustes_ejecutivo @anio_calc, @periodo_calc  
  
  
  
   update rof  
   set monto1 = (case when @min=1 then x.monto else rof.monto1 end),  
    monto2 = (case when @min=2 then x.monto else rof.monto2 end),  
    monto3 = (case when @min=3 then x.monto else rof.monto3 end),  
    monto4 = (case when @min=4 then x.monto else rof.monto4 end),  
    monto5 = (case when @min=5 then x.monto else rof.monto5 end),  
    monto6 = (case when @min=6 then x.monto else rof.monto6 end),  
    monto7 = (case when @min=7 then x.monto else rof.monto7 end),  
    monto8 = (case when @min=8 then x.monto else rof.monto8 end),  
    monto9 = (case when @min=9 then x.monto else rof.monto9 end),  
    monto10 = (case when @min=10 then x.monto else rof.monto10 end),  
    monto11 = (case when @min=11 then x.monto else rof.monto11 end),  
    monto12 = (case when @min=12 then x.monto else rof.monto12 end),  
    monto13 = (case when @min=13 then x.monto else rof.monto13 end),  
    monto_tot1 = (case when @min=1 then x.monto_tot else rof.monto_tot1 end),  
    monto_tot2 = (case when @min=2 then x.monto_tot else rof.monto_tot2 end),  
    monto_tot3 = (case when @min=3 then x.monto_tot else rof.monto_tot3 end),  
    monto_tot4 = (case when @min=4 then x.monto_tot else rof.monto_tot4 end),  
    monto_tot5 = (case when @min=5 then x.monto_tot else rof.monto_tot5 end),  
    monto_tot6 = (case when @min=6 then x.monto_tot else rof.monto_tot6 end),  
    monto_tot7 = (case when @min=7 then x.monto_tot else rof.monto_tot7 end),  
    monto_tot8 = (case when @min=8 then x.monto_tot else rof.monto_tot8 end),  
    monto_tot9 = (case when @min=9 then x.monto_tot else rof.monto_tot9 end),  
    monto_tot10 = (case when @min=10 then x.monto_tot else rof.monto_tot10 end),  
    monto_tot11 = (case when @min=11 then x.monto_tot else rof.monto_tot11 end),  
    monto_tot12 = (case when @min=12 then x.monto_tot else rof.monto_tot12 end),  
    monto_tot13 = (case when @min=13 then x.monto_tot else rof.monto_tot13 end)  
   from #tResumenOperativoFin rof  
   join (select   
      ro.id_concepto,  
      monto=isNull(monto11,0),  
      monto_tot=isNull(monto_tot11,0)  
     from #tResumenOperativo ro) x on x.id_concepto = rof.id_concepto  
  
  
  
   truncate table #tResumenOperativo  
  
 select @min=@min+1  
  end  
  
  
--update #tResumenOperativoFin set separador_despues=1 where id in (4,10,13,16,25,30,36)  
update #tResumenOperativoFin set separador_despues=1 where id_concepto in (4,10,13,16,25,29,35)  
  
  
  
----  
update #tResumenOperativoFin set orden=id*10  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=10,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (1,2,3,4,9,1564,1565,7)) x on x.id_concepto=t.id_concepto  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=5,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (5,6)) x on x.id_concepto=t.id_concepto  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=24,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (21,24)) x on x.id_concepto=t.id_concepto  
  
  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=25,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (17,18,19,23,1566,1567,24)) x on x.id_concepto=t.id_concepto  
  
  
  
  
update t  
set monto1 = x.monto1,  
 monto2 = x.monto2,  
 monto3 = x.monto3,  
 monto4 = x.monto4,  
 monto5 = x.monto5,  
 monto6 = x.monto6,  
 monto7 = x.monto7,  
 monto8 = x.monto8,  
 monto9 = x.monto9,  
 monto10 = x.monto10,  
 monto11 = x.monto11,  
 monto12 = x.monto12,  
 monto13 = x.monto13  
from #tResumenOperativoFin t  
join (select   
   id_concepto=26,  
   monto1=sum(monto1),  
   monto2=sum(monto2),  
   monto3=sum(monto3),  
   monto4=sum(monto4),  
   monto5=sum(monto5),  
   monto6=sum(monto6),  
   monto7=sum(monto7),  
   monto8=sum(monto8),  
   monto9=sum(monto9),  
   monto10=sum(monto10),  
   monto11=sum(monto11),  
   monto12=sum(monto12),  
   monto13=sum(monto13)  
  from #tResumenOperativoFin t2  
  where id_concepto in (22,26)) x on x.id_concepto=t.id_concepto  
  
  
  
update #tResumenOperativoFin set descripcion='Caja' where id_concepto=1  
update #tResumenOperativoFin set descripcion='Cuentas por Cobrar' where id_concepto=2  
update #tResumenOperativoFin set descripcion='Otros Activos Circulantes', orden=95 where id_concepto=7  --115
update #tResumenOperativoFin set descripcion='Inversión en Acciones', orden=135 where id_concepto=5  --155
update #tResumenOperativoFin set descripcion='Crédito Mercantil. España', orden=136 where id_concepto=3  --156
update #tResumenOperativoFin set descripcion='Cargos Diferidos y Activo Intangible' where id_concepto=15  
update #tResumenOperativoFin set descripcion='Pasivo Bancario CP' where id_concepto=17  
update #tResumenOperativoFin set descripcion='Cuentas por Pagar' where id_concepto=18  
update #tResumenOperativoFin set descripcion='Anticipo de Clientes' where id_concepto=19  
update #tResumenOperativoFin set descripcion='Otros Pasivos Circulantes' where id_concepto=24  
update #tResumenOperativoFin set descripcion='Pasivo Bancario LP' where id_concepto=26  
update #tResumenOperativoFin set descripcion='Otros Pasivos LP. España' where id_concepto=27  
update #tResumenOperativoFin set descripcion='Créditos Diferidos' where id_concepto=28  
update #tResumenOperativoFin set descripcion='B-10' where id_concepto=32  
update #tResumenOperativoFin set descripcion='Utilidades Retenidas' where id_concepto=33  
  
  
--delete from #tResumenOperativoFin where id_concepto in (6,8,11,12,14,20,21,22,23,31)  
delete from #tResumenOperativoFin where id_concepto in (6,8,11,12,14,20,21,22,31)  
--3 reusado  
  
declare @monto_espania decimal(18,2), @monto_espania2 decimal(18,2), @monto100porciento decimal(18,2)  
select @min=1, @max=13  
while @min<=@max  
begin  
  select @anio_calc=anio, @periodo_calc=periodo from @tablaMeses where id=@min  
  select @monto_espania=dbo.fn_credito_mercantil_espania(@anio_calc,@periodo_calc)  
  select @monto_espania2=dbo.fn_otros_pasivos_espania(@anio_calc,@periodo_calc)  
    
  update t  
  set monto1=(case when @min=1 then @monto_espania else t.monto1 end),  
   monto2=(case when @min=2 then @monto_espania else t.monto2 end),  
   monto3=(case when @min=3 then @monto_espania else t.monto3 end),  
   monto4=(case when @min=4 then @monto_espania else t.monto4 end),  
   monto5=(case when @min=5 then @monto_espania else t.monto5 end),  
   monto6=(case when @min=6 then @monto_espania else t.monto6 end),  
   monto7=(case when @min=7 then @monto_espania else t.monto7 end),  
   monto8=(case when @min=8 then @monto_espania else t.monto8 end),  
   monto9=(case when @min=9 then @monto_espania else t.monto9 end),  
   monto10=(case when @min=10 then @monto_espania else t.monto10 end),  
   monto11=(case when @min=11 then @monto_espania else t.monto11 end),  
   monto12=(case when @min=12 then @monto_espania else t.monto12 end),  
   monto13=(case when @min=13 then @monto_espania else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=3 --concepto reusado  
    
  update t  
  set monto1=(case when @min=1 then t.monto1-@monto_espania else t.monto1 end),  
   monto2=(case when @min=2 then t.monto2-@monto_espania else t.monto2 end),  
   monto3=(case when @min=3 then t.monto3-@monto_espania else t.monto3 end),  
   monto4=(case when @min=4 then t.monto4-@monto_espania else t.monto4 end),  
   monto5=(case when @min=5 then t.monto5-@monto_espania else t.monto5 end),  
   monto6=(case when @min=6 then t.monto6-@monto_espania else t.monto6 end),  
   monto7=(case when @min=7 then t.monto7-@monto_espania else t.monto7 end),  
   monto8=(case when @min=8 then t.monto8-@monto_espania else t.monto8 end),  
   monto9=(case when @min=9 then t.monto9-@monto_espania else t.monto9 end),  
   monto10=(case when @min=10 then t.monto10-@monto_espania else t.monto10 end),  
   monto11=(case when @min=11 then t.monto11-@monto_espania else t.monto11 end),  
   monto12=(case when @min=12 then t.monto12-@monto_espania else t.monto12 end),  
   monto13=(case when @min=13 then t.monto13-@monto_espania else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=15  
    
  
  update t  
  set monto1=(case when @min=1 then @monto_espania2 else t.monto1 end),  
   monto2=(case when @min=2 then @monto_espania2 else t.monto2 end),  
   monto3=(case when @min=3 then @monto_espania2 else t.monto3 end),  
   monto4=(case when @min=4 then @monto_espania2 else t.monto4 end),  
   monto5=(case when @min=5 then @monto_espania2 else t.monto5 end), 
   monto6=(case when @min=6 then @monto_espania2 else t.monto6 end),  
   monto7=(case when @min=7 then @monto_espania2 else t.monto7 end),  
 monto8=(case when @min=8 then @monto_espania2 else t.monto8 end),  
   monto9=(case when @min=9 then @monto_espania2 else t.monto9 end),  
   monto10=(case when @min=10 then @monto_espania2 else t.monto10 end),  
   monto11=(case when @min=11 then @monto_espania2 else t.monto11 end),  
   monto12=(case when @min=12 then @monto_espania2 else t.monto12 end),  
   monto13=(case when @min=13 then @monto_espania2 else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=27  
    
  update t  
  set monto1=(case when @min=1 then t.monto1-@monto_espania2 else t.monto1 end),  
   monto2=(case when @min=2 then t.monto2-@monto_espania2 else t.monto2 end),  
   monto3=(case when @min=3 then t.monto3-@monto_espania2 else t.monto3 end),  
   monto4=(case when @min=4 then t.monto4-@monto_espania2 else t.monto4 end),  
   monto5=(case when @min=5 then t.monto5-@monto_espania2 else t.monto5 end),  
   monto6=(case when @min=6 then t.monto6-@monto_espania2 else t.monto6 end),  
   monto7=(case when @min=7 then t.monto7-@monto_espania2 else t.monto7 end),  
   monto8=(case when @min=8 then t.monto8-@monto_espania2 else t.monto8 end),  
   monto9=(case when @min=9 then t.monto9-@monto_espania2 else t.monto9 end),  
   monto10=(case when @min=10 then t.monto10-@monto_espania2 else t.monto10 end),  
   monto11=(case when @min=11 then t.monto11-@monto_espania2 else t.monto11 end),  
   monto12=(case when @min=12 then t.monto12-@monto_espania2 else t.monto12 end),  
   monto13=(case when @min=13 then t.monto13-@monto_espania2 else t.monto13 end)  
  from #tResumenOperativoFin t  
  where id_concepto=28  
  
  
  select @monto100porciento = (case   
          when @min=1 then t.monto1   
          when @min=2 then t.monto2  
          when @min=3 then t.monto3   
          when @min=4 then t.monto4   
          when @min=5 then t.monto5   
          when @min=6 then t.monto6   
          when @min=7 then t.monto7   
          when @min=8 then t.monto8   
          when @min=9 then t.monto9   
          when @min=10 then t.monto10   
          when @min=11 then t.monto11   
          when @min=12 then t.monto12   
          when @min=13 then t.monto13   
         else 0 end)  
  from #tResumenOperativoFin t  
  where id_concepto=16  
  
  if @monto100porciento > 0  
   update t  
   set monto_tot1=(case when @min=1 then monto1/@monto100porciento*100.0 else t.monto_tot1 end),  
    monto_tot2=(case when @min=2 then monto2/@monto100porciento*100.0 else t.monto_tot2 end),  
    monto_tot3=(case when @min=3 then monto3/@monto100porciento*100.0 else t.monto_tot3 end),  
    monto_tot4=(case when @min=4 then monto4/@monto100porciento*100.0 else t.monto_tot4 end),  
    monto_tot5=(case when @min=5 then monto5/@monto100porciento*100.0 else t.monto_tot5 end),  
    monto_tot6=(case when @min=6 then monto6/@monto100porciento*100.0 else t.monto_tot6 end),  
    monto_tot7=(case when @min=7 then monto7/@monto100porciento*100.0 else t.monto_tot7 end),  
    monto_tot8=(case when @min=8 then monto8/@monto100porciento*100.0 else t.monto_tot8 end),  
    monto_tot9=(case when @min=9 then monto9/@monto100porciento*100.0 else t.monto_tot9 end),  
    monto_tot10=(case when @min=10 then monto10/@monto100porciento*100.0 else t.monto_tot10 end),  
    monto_tot11=(case when @min=11 then monto11/@monto100porciento*100.0 else t.monto_tot11 end),  
    monto_tot12=(case when @min=12 then monto12/@monto100porciento*100.0 else t.monto_tot12 end),  
    monto_tot13=(case when @min=13 then monto13/@monto100porciento*100.0 else t.monto_tot13 end)  
   from #tResumenOperativoFin t  
  
  
  IF OBJECT_ID('tempdb..#tBalanceGeneralDatosExtra') IS NOT NULL  
  BEGIN  
   --CUENTAS POR COBRAR  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
 monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=7,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (2)) x on x.id=t.id  
  
   --CUENTAS POR PAGAR  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=8,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (18)) x on x.id=t.id  
  
   --ACTIVO CIRCULANTE  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=9,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (10)) x on x.id=t.id  
  
   --PASIVO CIRCULANTE  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=10,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (25)) x on x.id=t.id  
  
   --Pasivo Bancario CP  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=11,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (17)) x on x.id=t.id  
  
   --Pasivo Bancario LP  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
 monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=12,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (26)) x on x.id=t.id  
  
   --ACTIVO TOTAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=13,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (16)) x on x.id=t.id  
  
   --PASIVO MAS CAPITAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=14,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (36)) x on x.id=t.id  
  
   --PASIVO MAS CAPITAL  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=15,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (34)) x on x.id=t.id  
  
   --INVENTARIO  
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=24,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (4)) x on x.id=t.id  
     
--  reporte_ejecutivo_7 2013,5  


   --CAJA
   update t  
   set monto1 = x.monto1, monto2 = x.monto2, monto3 = x.monto3, monto4 = x.monto4, monto5 = x.monto5,   
    monto6 = x.monto6, monto7 = x.monto7, monto8 = x.monto8, monto9 = x.monto9, monto10 = x.monto10,  
    monto11 = x.monto11, monto12 = x.monto12, monto13 = x.monto13  
   from #tBalanceGeneralDatosExtra t  
   join (select id=26,  
      monto1=sum(monto1), monto2=sum(monto2), monto3=sum(monto3), monto4=sum(monto4),  
      monto5=sum(monto5), monto6=sum(monto6), monto7=sum(monto7), monto8=sum(monto8),  
      monto9=sum(monto9), monto10=sum(monto10), monto11=sum(monto11), monto12=sum(monto12),  
      monto13=sum(monto13)  
     from #tResumenOperativoFin t2  
     where id_concepto in (1)) x on x.id=t.id  
   END  
  
  
  select @min=@min+1  
  end  
  
  
select @periodo=@periodo-1  
if @periodo=0  
 select @periodo=12, @anio=@anio-1  
else  
 select @periodo=@periodo  
  
  
update #tResumenOperativoFin  
set plan1=(select sum(isNull(monto5,0))   
   from reporte_captura   
   where id_reporte=5 and id_concepto=111   
   and anio=@anio and periodo=@periodo)  
where id_concepto=1  
  
if @periodo=12  
 select @periodo=1,  
   @anio=@anio+1  
else  
 select @periodo=@periodo+1  
  
update #tResumenOperativoFin  
set plan2=(select sum(isNull(monto5,0))   
   from reporte_captura   
   where id_reporte=5 and id_concepto=111   
   and anio=@anio and periodo=@periodo)  
where id_concepto=1  
  
update #tResumenOperativoFin  
set var1=abs(monto1-plan1),  
 var2=abs(monto1-plan2)  
where id_concepto=1  

delete from #tResumenOperativoFin
where id_concepto = 32
and monto1 + monto2 + monto3 + monto4 + monto5 + monto6 + monto7 + monto8 + monto9 + monto10 + monto11 + monto12 + monto13 = 0











select id,  
 id_concepto,  
 descripcion,  
 orden,  
 monto1 = convert(int,round(isNull(monto1,0),0)),  
 monto2 = convert(int,round(isNull(monto2,0),0)),  
 monto3 = convert(int,round(isNull(monto3,0),0)),  
 monto4 = convert(int,round(isNull(monto4,0),0)),  
 monto5 = convert(int,round(isNull(monto5,0),0)),  
 monto6 = convert(int,round(isNull(monto6,0),0)),  
 monto7 = convert(int,round(isNull(monto7,0),0)),  
 monto8 = convert(int,round(isNull(monto8,0),0)),  
 monto9 = convert(int,round(isNull(monto9,0),0)),  
 monto10 = convert(int,round(isNull(monto10,0),0)),  
 monto11 = convert(int,round(isNull(monto11,0),0)),  
 monto12 = convert(int,round(isNull(monto12,0),0)),  
 monto13 = convert(int,round(isNull(monto13,0),0)),  
 monto_tot1 = convert(int,round(isNull(monto_tot1,0),0)),  
 monto_tot2 = convert(int,round(isNull(monto_tot2,0),0)),  
 monto_tot3 = convert(int,round(isNull(monto_tot3,0),0)),  
 monto_tot4 = convert(int,round(isNull(monto_tot4,0),0)),  
 monto_tot5 = convert(int,round(isNull(monto_tot5,0),0)),  
 monto_tot6 = convert(int,round(isNull(monto_tot6,0),0)),  
 monto_tot7 = convert(int,round(isNull(monto_tot7,0),0)),  
 monto_tot8 = convert(int,round(isNull(monto_tot8,0),0)),  
 monto_tot9 = convert(int,round(isNull(monto_tot9,0),0)),  
 monto_tot10 = convert(int,round(isNull(monto_tot10,0),0)),  
 monto_tot11 = convert(int,round(isNull(monto_tot11,0),0)),  
 monto_tot12 = convert(int,round(isNull(monto_tot12,0),0)),  
 monto_tot13 = convert(int,round(isNull(monto_tot13,0),0)),  
   
 es_porcentaje,  
 es_multivalor,  
 permite_captura,  
 separador_despues,  
 plan1=isNull(plan1,0),  
 var1=isNull(var1,0),  
 plan2=isNull(plan2,0),  
 var2=isNull(var2,0),  
 diciembre = (select id from @tablaMeses where anio=@anio-1 and periodo=12)  
from #tResumenOperativoFin  
order by orden  







  
drop table #tResumenOperativo  
drop table #tResumenOperativoFin  





