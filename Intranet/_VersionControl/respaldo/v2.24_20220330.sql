go

set identity_insert reporte on
go
insert into reporte (id_reporte, nombre, descripcion, es_plan, tipo_reporte, es_activo)
				values (22, 'Estado de Resultados - Fibras', 'Estado de Resultados - Fibras', 0, 1, 1)
go
set identity_insert reporte off
go

go
set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, 
					formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa,
					descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, 
					anio_alta, periodo_alta) 
				values (2010, '', 'Gastos RDi + MD', 2, null, 411, 1550, 0, '', 1, 0, 0, 0, 0, null, '', 
						null, null, 1, null, null, null, null, null)
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, 
					formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa,
					descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, 
					anio_alta, periodo_alta) 
				values (2011, '', 'Gastos DF', 2, null, 432, 280, 1, '', 1, 0, 0, 0, 0, null, '', 
						null, null, 1, null, null, null, null, null)
go
set identity_insert concepto off
go

update concepto set orden = 419, id_padre=43, resta=1 where id_concepto=2010

go

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
declare 	@id_empresa int=12,
	@id_reporte int=22,
	@anio int=2022,
	@periodo int=1,
	@tipo int = 5
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
					where (id_reporte = @id_reporte or (@id_reporte=22 and id_reporte=2))
					)
and isNull(formula_especial,'') = ''
order by orden


insert into #tConceptosFormulas (id_concepto, orden, formula_especial)
select id_concepto, orden, formula_especial
from concepto
where (id_reporte = @id_reporte or (@id_reporte=22 and id_reporte=2))
and isNull(formula_especial,'') <> ''
order by orden


select 'xxxx', * from #tConceptos
select 'yyyy', * from #tConceptosFormulas

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




			----------------------------------------------------------------------------
			----------------------------------------------------------------------------monto11



			select @max_row = max(id),
					@curr_row = 1
			from #tConceptos

          
			while @curr_row <= @max_row
			  begin
				select @id_padre = id_concepto
				from #tConceptos
				where id = @curr_row

				
				select @importe = sum(case 
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
				set monto11 = isNull(@importe,0)
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
										when @formula_especial = 'fn_rep2_flujo_operacion' then dbo.fn_rep2_flujo_operacion2(@id_empresa, @anio, @periodo, 11)
										when @formula_especial = 'fn_rep3_caja_neta' then dbo.fn_rep3_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep3_free_cash_flow' then dbo.fn_rep3_free_cash_flow(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_caja_neta' then dbo.fn_rep1014_caja_neta(@id_empresa, @anio, @periodo)
										when @formula_especial = 'fn_rep1014_free_cash_flow' then dbo.fn_rep1014_free_cash_flow(@id_empresa, @anio, @periodo)
										else 0
									end)
				
				update reporte_captura
				set monto11 = isNull(@importe,0)
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
				and id_reporte = @id_reporte
				
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
					and rc.id_reporte = @id_reporte


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
					and id_reporte = @id_reporte
				 end
				
				
				select @curr_row = @curr_row + 1
			end




		
  end

drop table #tConceptos
drop table #tConceptosFormulas



/* REPORTE DE ESTADO DE RESULTADOS FIBRAS DEBE LLENAR EN AUTOMATICO EL ORIGINAL */
if @id_reporte = 22
	BEGIN
		if exists (select 1 
					from reporte_captura rc (nolock) 
					where rc.id_reporte=2 
					AND rc.anio=@anio 
					AND rc.periodo=@periodo 
					AND rc.id_empresa=@id_empresa)
			BEGIN
					update rc 
						set monto=rc22.monto,
							monto1=rc22.monto1,
							monto2=rc22.monto2,
							monto3=rc22.monto3,
							monto4=rc22.monto4,
							monto5=rc22.monto5,
							monto_real_mes_ant=rc22.monto_real_mes_ant,
							monto6=rc22.monto6,
							monto7=rc22.monto7,
							monto8=rc22.monto8,
							monto9=rc22.monto9,
							monto10=rc22.monto10,
							monto11=rc22.monto11
					from reporte_captura rc
					join reporte_captura rc22 on rc22.id_concepto=rc.id_concepto
					where rc.id_reporte=2 
					AND rc.anio=@anio 
					AND rc.periodo=@periodo 
					AND rc.id_empresa=@id_empresa
					AND rc22.id_reporte=22
					AND rc22.anio=@anio 
					AND rc22.periodo=@periodo 
					AND rc22.id_empresa=@id_empresa
					AND rc22.id_concepto not in (2010, 2011)

			END
		ELSE
			BEGIN
				insert into reporte_captura (id_empresa, id_reporte, anio, periodo, id_concepto, monto, monto1, monto2, monto3, 
						monto4, monto5, monto_real_mes_ant, monto6, monto7, monto8, monto9, monto10, monto11)
				select id_empresa, 2, anio, periodo, id_concepto, monto, monto1, monto2, monto3, 
						monto4, monto5, monto_real_mes_ant, monto6, monto7, monto8, monto9, monto10, monto11
					from reporte_captura rc (nolock) 
					where rc.id_reporte=22
					AND rc.anio=@anio 
					AND rc.periodo=@periodo 
					AND rc.id_empresa=@id_empresa
					AND rc.id_concepto not in (2010, 2011)
			END

		-- sumar los 2 conceptos al gastos de operacion
		update rc 
			set monto=rc.monto+rc22.monto,
				monto1=rc.monto1+rc22.monto1,
				monto2=rc.monto2+rc22.monto2,
				monto3=rc.monto3+rc22.monto3,
				monto4=rc.monto4+rc22.monto4,
				monto5=rc.monto5+rc22.monto5,
				monto_real_mes_ant=rc.monto_real_mes_ant+rc22.monto_real_mes_ant,
				monto6=rc.monto6+rc22.monto6,
				monto7=rc.monto7+rc22.monto7,
				monto8=rc.monto8+rc22.monto8,
				monto9=rc.monto9+rc22.monto9,
				monto10=rc.monto10+rc22.monto10,
				monto11=rc.monto11+rc22.monto11
		from reporte_captura rc
		join (select id_concepto=1552,
					monto=sum(x.monto),
					monto1=sum(x.monto1),
					monto2=sum(x.monto2),
					monto3=sum(x.monto3),
					monto4=sum(x.monto4),
					monto5=sum(x.monto5),
					monto_real_mes_ant=sum(x.monto_real_mes_ant),
					monto6=sum(x.monto6),
					monto7=sum(x.monto7),
					monto8=sum(x.monto8),
					monto9=sum(x.monto9),
					monto10=sum(x.monto10),
					monto11=sum(x.monto11)					
				from reporte_captura x
				WHERE x.id_reporte=22
					AND x.anio=@anio 
					AND x.periodo=@periodo 
					AND x.id_empresa=@id_empresa
					AND x.id_concepto in (2010, 2011)
				) as rc22 on rc22.id_concepto=rc.id_concepto
		where rc.id_reporte=2 
		AND rc.anio=@anio 
		AND rc.periodo=@periodo 
		AND rc.id_empresa=@id_empresa
		AND rc.id_concepto=1552
		--select * from concepto where id_reporte=2 order by orden

		--por ultimo calcular los totales
		exec reporte_calculos_totales @id_empresa, 2, @anio, @periodo, @tipo
	END


-- Corre los recalculos de autollenado
if exists (select 1 from empresa where id_empresa = @id_empresa and (aplica_validacion_captura_reportes=1 or (@id_empresa in (11) and @id_reporte = 1014))) and @periodo > 0
begin
	if @id_reporte=4
		exec recalcula_estado_resultados @id_empresa, @anio, @periodo
	if @id_reporte in (2,22,10,1015,13)
		exec recalcula_balance_general @id_empresa, @anio, @periodo
	if @id_reporte in (2,22,1015)
		exec recalcula_flujo_efectivo @id_empresa, @anio, @periodo
end

if @id_reporte = 2 AND @periodo=0 AND @id_empresa>0
	exec actualiza_pronostico_estado_resultado_global @anio


go






go
ALTER procedure [dbo].[recupera_reporte_datos]
	@id_reporte int,    
	@id_empresa int,    
	@anio  int,    
	@periodo int    
as    

-- select * from reporte
-- select * from empresa
/*

select top 100 *
from reporte_captura
order by id_captura desc

select *
from reporte_captura
where id_reporte=22 and id_empresa=12 and anio=2022 and periodo=1
order by id_captura

select *
from reporte_captura
where id_reporte=2 and id_empresa=12 and anio=2022 and periodo=1
order by id_captura

declare @id_reporte int,    
 @id_empresa int,    
 @anio  int,    
 @periodo int    
    
select @id_reporte = 2,
		@id_empresa = 8,
		@anio  = 3022,
		@periodo = 0
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


create table #concepto
(
	id_concepto	int,
	clave	varchar(64),
	descripcion	varchar(256),
	id_reporte	int,
	id_grupo	int,
	orden	int,
	id_padre	int,
	resta	bit,
	formula_especial	varchar(256),
	permite_captura	bit,
	es_separador	bit,
	es_plan	bit,
	es_fibras	bit,
	es_hornos	bit,
	id_empresa	int,
	descripcion_2	varchar(256),
	anio_baja	int,
	periodo_baja	int,
	es_borrado	bit,
	referencia	varchar(32),
	referencia2	varchar(32),
	referencia3	varchar(32),
	anio_alta	int,
	periodo_alta	int
)

insert into #concepto (id_concepto, clave,descripcion,id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,es_borrado,referencia,referencia2,referencia3,
							anio_alta,periodo_alta)
select id_concepto, clave,descripcion,id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,es_borrado,referencia,referencia2,referencia3,
							anio_alta,periodo_alta
from concepto
where id_reporte = @id_reporte

if @id_reporte = 2 and @periodo = 0 and @id_empresa in (1,7,8,9,10,12,13)
	begin
		insert into #concepto (id_concepto, clave,descripcion,id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,es_borrado,referencia,referencia2,referencia3,
							anio_alta,periodo_alta)
		select id_concepto,clave,descripcion,@id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,es_borrado,referencia,referencia2,referencia3,
							anio_alta,periodo_alta
		from concepto
		where id_reporte = 1016
	end


if @id_reporte = 22
  begin
		insert into #concepto (id_concepto, clave,descripcion,id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,es_borrado,referencia,referencia2,referencia3,
							anio_alta,periodo_alta)
		select id_concepto,clave,descripcion,@id_reporte,id_grupo,orden,
							id_padre,resta,formula_especial,permite_captura,es_separador,
							es_plan,es_fibras,es_hornos,id_empresa,descripcion_2,anio_baja,
							periodo_baja,
							es_borrado = (case when id_concepto in (2010,2011) then 0 else es_borrado end),
							referencia,referencia2,referencia3,
							anio_alta,periodo_alta
		from concepto
		where id_reporte = 2

  end



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
		from #concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa
			and rc.id_reporte <> 22
		where (c.id_reporte = 2 or (c.id_reporte = 14 and c.id_concepto = 361))  --RM: 20160225 - Gastos Preoperativos NUSA
		and (c.es_plan = 0 or @id_empresa = -1)
		and (c.anio_baja is null or (convert(varchar(8),c.anio_baja) + '-' + right('0' + convert(varchar(8),c.periodo_baja),2) > convert(varchar(8),@anio) + '-' + right('0' + convert(varchar(8),@periodo),2)))
		and c.es_borrado=0
		order by c.orden
end
else if @id_reporte = 22
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
		from #concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
			and rc.id_reporte = @id_reporte
		where c.id_reporte = @id_reporte    
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
		from #concepto c    
		left outer join reporte_captura rc     
			on rc.id_concepto = c.id_concepto    
			and rc.anio = @anio    
			and rc.periodo = @periodo    
			and rc.id_empresa = @id_empresa    
			and rc.id_reporte <> 22
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
	if exists (select 1 from empresa where id_empresa = @id_empresa and (aplica_validacion_captura_reportes=1 or (@id_empresa in (11,6) and @id_reporte = 1014))) and @periodo>0
	begin
			if dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa) = 'A' -- SI EL PERIODO ESTA ABIERO
			  begin
					if @id_reporte in (2,22) -- ESTADO DE RESULTADOS
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


					ELSE IF @id_reporte IN (3, 1014) -- FLUJO DE EFECTIVO
					  BEGIN

						IF @id_empresa NOT IN (11,6)
							BEGIN
									DECLARE @fe_utilidad_neta int, @fe_depreciacion int

									select @fe_utilidad_neta = sum(monto)
									from reporte_captura
									where anio = @anio
									and periodo <= @periodo and periodo > 0
									and id_empresa = @id_empresa
									and id_reporte = 2
									and id_concepto in (52)

									select @fe_depreciacion = sum(monto)
									from reporte_captura
									where anio = @anio
									and periodo <= @periodo and periodo > 0
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

							END


							declare @id_empresa_unir INT = -99
							if @id_empresa = 11
								select @id_empresa_unir = 6


							-- CUADRE INTERCOMPANIES 1
							declare @extCI_por_cobrar_mes_actual decimal(18,2), @extCI_por_cobrar_dic_anterior decimal(18,2), @extCI_por_pagar_mes_actual decimal(18,2), @extCI_por_pagar_mes_anterior decimal(18,2), @extCI1_final decimal(18,2)

							select @extCI_por_cobrar_mes_actual=sum(monto1), @extCI_por_pagar_mes_actual=sum(monto2) from reporte_captura where id_concepto = 1610 and id_empresa in (@id_empresa,@id_empresa_unir) and anio=@anio and periodo=@periodo
							select @extCI_por_cobrar_dic_anterior=sum(monto1), @extCI_por_pagar_mes_anterior=sum(monto2) from reporte_captura where id_concepto = 1610 and id_empresa in (@id_empresa,@id_empresa_unir) and anio=(@anio-1) and periodo=12

							select @extCI1_final = (isnull(@extCI_por_cobrar_dic_anterior,0)-isnull(@extCI_por_cobrar_mes_actual,0)) - (isnull(@extCI_por_pagar_mes_anterior,0)-isnull(@extCI_por_pagar_mes_actual,0))

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@extCI1_final,0),
								monto = isNull(@extCI1_final,0),
								autollenado = 1
							where id_concepto = 1512 



							-- CUADRE INTERCOMPANIES 2
							select @extCI_por_cobrar_mes_actual=sum(monto3), @extCI_por_pagar_mes_actual=sum(monto4) from reporte_captura where id_concepto = 1610 and id_empresa in (@id_empresa,@id_empresa_unir) and anio=@anio and periodo=@periodo
							select @extCI_por_cobrar_dic_anterior=sum(monto3), @extCI_por_pagar_mes_anterior=sum(monto4) from reporte_captura where id_concepto = 1610 and id_empresa in (@id_empresa,@id_empresa_unir) and anio=(@anio-1) and periodo=12

							select @extCI1_final = (isnull(@extCI_por_cobrar_dic_anterior,0)-isnull(@extCI_por_cobrar_mes_actual,0)) - (isnull(@extCI_por_pagar_mes_anterior,0)-isnull(@extCI_por_pagar_mes_actual,0))

							UPDATE #reporte_captura_fin
							set monto_dec = isNull(@extCI1_final,0),
								monto = isNull(@extCI1_final,0),
								autollenado = 1
							where id_concepto = 1531 

					  end

					else if @id_reporte = 1 -- BALANCE GENERAL
					  begin
							--if exists(select 1 from #c where id_concepto = 37 and monto_total = 0) -- NO SE HA CAPTURADO ANTES
							declare @utilidad_neta int, @cuadre1 int, @cuadre2 int, @cuadre3 int, @cuadre4 int, @proveedores int, @clientes int, @inventario int, @anticipo_proveedores int

							select @utilidad_neta = sum(monto)
							from reporte_captura
							where anio = @anio
							and periodo <= @periodo and periodo > 0
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

							--if @id_empresa not in (9)
							  begin
								UPDATE #reporte_captura_fin
								set monto_dec = isNull(@clientes,0),
									monto = isNull(@clientes,0),
									autollenado = 1
								where id_concepto = 2
							  end

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


declare @estatus varchar(8) = dbo.fn_estatus_periodo(@anio,@periodo,@id_empresa)
if @estatus='A' and @anio >=2022 and @periodo=0 and @id_empresa=-1 and @id_reporte=2
	select @estatus='C'
    
select estatus = @estatus, alerta_actualizacion = dbo.fn_alerta_actualizacion_reporte(@anio,@periodo,@id_empresa,@id_reporte)
    
    
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
drop table #concepto



go






go
ALTER procedure [dbo].[guarda_reporte_captura]
	@id_empresa int,
	@id_reporte int,
	@anio		int,
	@periodo	int,
	@id_concepto int,
	@monto		decimal(18,2) = 0,
	@monto1		int = 0,
	@monto2		int = 0,
	@monto3		int = 0,
	@monto4		int = 0,
	@monto5		int = 0,
	@monto6		int = 0,
	@monto7		int = 0,
	@monto8		int = 0,
	@monto9		int = 0,
	@monto10		int = 0,
	@monto11		int = 0,
	@monto_real_mes_ant	int = 0
as

if @id_reporte not in (8,11)
	select @monto = round(@monto,0)
	
if (@id_reporte = 2 OR @id_reporte = 22 OR @id_reporte = 4) and @id_empresa in (select id_empresa from empresa where es_fibras=1)
	select @monto = isNull(@monto1,0) + isNull(@monto2,0) + isNull(@monto3,0) + isNull(@monto4,0)

insert into reporte_captura (id_empresa, id_reporte, anio, periodo, id_concepto, monto,
							 monto1, monto2, monto3, monto4, monto5, monto6, monto_real_mes_ant,
							 monto7, monto8, monto9, monto10, monto11)
				values (@id_empresa, @id_reporte, @anio, @periodo, @id_concepto, @monto,
							 @monto1, @monto2, @monto3, @monto4, @monto5, @monto6, @monto_real_mes_ant,
							 @monto7, @monto8, @monto9, @monto10, @monto11)




go