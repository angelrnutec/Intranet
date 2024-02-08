go

create table dbo.pais
(
	id_pais int identity(1,1) primary key,
	nombre varchar(256)
)
go
set identity_insert pais on
go
insert into pais (id_pais, nombre) values (1,'Mexico')
insert into pais (id_pais, nombre) values (2,'USA')
insert into pais (id_pais, nombre) values (3,'España')

go
set identity_insert pais off
go

go
alter table asueto add id_pais int
go
update asueto set id_pais=1
go

go
alter table empresa add id_pais int
go
update empresa set id_pais=1 where id_empresa in (-3,-2,-1,1,3,4,5,6,7,8,9,11)
update empresa set id_pais=2 where id_empresa in (12)
update empresa set id_pais=3 where id_empresa in (10)

go

go

go


go
alter procedure [dbo].[guarda_asueto]
	@fecha	datetime,
	@descripcion	varchar(256),
	@id_usuario		int,
	@medio_dia		bit,
	@id_pais		int
as

select @fecha = cast(floor(convert(float,@fecha)) as datetime)

if not exists(select 1 from asueto (NOLOCK) where fecha=@fecha and fecha_eliminado is null and id_pais=@id_pais)
	insert into asueto (fecha, descripcion, id_usuario, fecha_registro, medio_dia, id_pais)
				values (@fecha, @descripcion, @id_usuario, getdate(), @medio_dia, @id_pais)
else
	update asueto
	set descripcion=@descripcion,
		medio_dia=@medio_dia
	where fecha=@fecha
	and fecha_eliminado is null
	and id_pais=@id_pais

exec ajusta_vacaciones_por_dias_asueto @fecha


go
alter procedure dbo.recupera_solicitud_cancelacion_vacaciones_dias
	@id_solicitud int
as

--	declare @id_solicitud int = 11013

	create table #tempDias
	(
		id int identity(1,1),
		fecha datetime, 
		dias decimal(9,2)
	)

	DECLARE @fecha_ini datetime,
			@fecha_fin datetime,
			@fecha_act datetime,
			@dias decimal(9,2),
			@medio_dia bit,
			@medio_dia_asueto bit,
			@id_pais int

	SELECT @fecha_ini = fecha_ini,
			@fecha_fin = fecha_fin,
			@fecha_act = fecha_ini,
			@medio_dia = medio_dia,
			@medio_dia_asueto = medio_dia_asueto
	FROM solicitud_vacaciones sv (NOLOCK)
	WHERE sv.id_solicitud = @id_solicitud

	select @id_pais = id_pais
	from empresa e (NOLOCK)
	join solicitud_vacaciones sv (NOLOCK) on sv.id_empresa = e.id_empresa
	WHERE sv.id_solicitud = @id_solicitud

	WHILE @fecha_act <= @fecha_fin
	  BEGIN
		select @dias = 1

		if datepart(WEEKDAY,@fecha_act) in (1,7) -- sabados y domingos
			select @dias = 0
		else if exists (select 1 from asueto (NOLOCK) where fecha_eliminado is not null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=0)
			select @dias = 0
		else if exists (select 1 from asueto (NOLOCK) where fecha_eliminado is not null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=1)
			select @dias = 0.5
		else if @medio_dia = 1
			select @dias = 0.5, @medio_dia = 0

		insert into #tempDias (fecha, dias)
		values (@fecha_act, @dias)

		select @fecha_act = dateadd(dd,1,@fecha_act)
	  END


select *
from #tempDias
order by fecha

drop table #tempDias



go
alter function [dbo].[fn_dias_vacaciones_medio](@id_empresa int, @fecha_ini datetime, @fecha_fin datetime)
returns int
as

  begin
		declare @medios int, @id_pais int
		select @medios=0

		select @id_pais = id_pais
		from empresa e (NOLOCK)
		where e.id_empresa = @id_empresa

		if @fecha_fin >= @fecha_ini
		  begin
			while @fecha_ini<=@fecha_fin
			 begin
				if exists (select fecha from asueto (NOLOCK) where fecha=@fecha_ini and fecha_eliminado is null and id_pais=@id_pais and medio_dia=1)
					select @medios=@medios + 1
				
				select @fecha_ini=dateadd(dd,1,@fecha_ini)
			 end
		  end

		return isNull(@medios,0)
  end
  
go
alter function [dbo].[fn_dias_vacaciones](@id_empresa int, @fecha_ini datetime, @fecha_fin datetime) 
returns int
as

  begin
		declare @dias int, @id_pais int
		select @dias=0

		select @id_pais = id_pais
		from empresa e (NOLOCK)
		where e.id_empresa = @id_empresa

		if @fecha_fin >= @fecha_ini
		  begin
			while @fecha_ini<=@fecha_fin
			 begin
				if datepart(dw,@fecha_ini) not in (1,7) AND (not exists (select fecha from asueto (NOLOCK) where fecha=@fecha_ini and fecha_eliminado is null and id_pais=@id_pais and medio_dia=0))
					select @dias=@dias+1
				
				select @fecha_ini=dateadd(dd,1,@fecha_ini)
			 end
			 --select @dias=@dias+1
		  end

		return isNull(@dias,0)
  end

go
alter procedure [dbo].[recupera_asueto_futuros]
	@id_empresa int
as

select a.fecha, a.medio_dia
from asueto a (NOLOCK)
join empresa e (NOLOCK) on e.id_pais = a.id_pais
where a.fecha_eliminado is null
and e.id_empresa = @id_empresa


go
alter procedure [dbo].[recupera_asueto]
	@anio	int,
	@id_pais int
as

select id_asueto, fecha, descripcion, medio_dia = (case when medio_dia=0 then 'No' else 'Si' end)
from asueto (NOLOCK)
where year(fecha)=@anio
and fecha_eliminado is null
and id_pais=@id_pais
order by fecha


go
alter procedure dbo.eslabon_genera_vacaciones_autorizadas

as

set nocount on

CREATE TABLE #solicitudes
(
	id int identity(1,1),
	id_solicitud int,
	folio_txt varchar(32),
	id_empleado_solicita int,
	fecha_ini datetime,
	fecha_fin datetime,
	dias int,
	comentarios varchar(512),
	fecha_autoriza_jefe datetime,
	medio_dia bit,
	medio_dia_asueto int
)


declare @iniQincena datetime,
		@finQincena datetime,
		@fechaHoy datetime

select @fechaHoy = cast(getdate() as date)

if DATEPART(DAY,@fechaHoy) < 16
	begin
	-- Q1
	select @iniQincena = DATEADD(month, DATEDIFF(month, 0, @fechaHoy), 0)
	select @finQincena = DATEADD(dd,14,DATEADD(month, DATEDIFF(month, 0, @fechaHoy), 0))				
	end
else
	begin
	-- Q1
	select @iniQincena = DATEADD(dd,15,DATEADD(month, DATEDIFF(month, 0, @fechaHoy), 0))
	select @finQincena = DATEADD(dd,-1,DATEADD(mm, DATEDIFF(m,0,@fechaHoy)+1,0))
	end


INSERT INTO #solicitudes (id_solicitud, folio_txt, id_empleado_solicita, fecha_ini, fecha_fin, dias, comentarios, fecha_autoriza_jefe, medio_dia, medio_dia_asueto)
SELECT id_solicitud, folio_txt, id_empleado_solicita, fecha_ini, fecha_fin, dias, comentarios, fecha_autoriza_jefe, medio_dia, medio_dia_asueto
FROM solicitud_vacaciones sv (NOLOCK)
WHERE --sv.fecha_autoriza_jefe > dateadd(dd,-45,getdate())
--and sv.fecha_verificado is null
sv.cancelada is null
and sv.autoriza_jefe=1
and exists (select 1 from solicitud_vacaciones_verificacion svv (NOLOCK) where svv.id_solicitud = sv.id_solicitud and cast(svv.fecha_verificacion as date) >= @iniQincena and cast(svv.fecha_verificacion as date) <= @finQincena)
--		or (sv.fecha_verificado is not null and cast(sv.fecha_verificado as date) >= @iniQincena and cast(sv.fecha_verificado as date) <= @finQincena))

DECLARE @maxRow int, @currRow int
SELECT @maxRow = max(id),
		@currRow = 1
FROM #solicitudes

truncate table eslabon_vacaciones_autorizadas

WHILE @currRow <= @maxRow
  BEGIN
	DECLARE @folio varchar(32),
			@fecha_ini datetime,
			@fecha_fin datetime,
			@fecha_act datetime,
			@fecha_autorizacion datetime,
			@dias decimal(9,2),
			@medio_dia bit,
			@medio_dia_asueto bit,
			@empresa int,
			@numero_empleado varchar(32),
			@periodo_vacacional int,
			@fecha_alta datetime,
			@comentarios varchar(512),
			@id_pais int

	SELECT @folio = folio_txt,
			@fecha_ini = fecha_ini,
			@fecha_fin =  isNull((select max(fecha_fin) from solicitud_vacaciones_verificacion svv (NOLOCK) where svv.id_solicitud = s.id_solicitud), s.fecha_fin), --fecha_fin,
			@fecha_act = fecha_ini,
			@medio_dia = medio_dia,
			@medio_dia_asueto = medio_dia_asueto,
			@empresa = em.id_empresa_eslabon,
			@numero_empleado = e.numero,
			@fecha_alta = e.fecha_alta,
			@comentarios = s.comentarios,
			@fecha_autorizacion = isNull((select max(fecha_verificacion) from solicitud_vacaciones_verificacion svv (NOLOCK) where svv.id_solicitud = s.id_solicitud), s.fecha_autoriza_jefe),
			@id_pais = em.id_pais
	FROM #solicitudes s
	join empleado e on e.id_empleado = s.id_empleado_solicita
	join empresa em on em.id_empresa = e.id_empresa
	WHERE id = @currRow
	and isNull(e.es_externo,0) = 0


	WHILE @fecha_act <= @fecha_fin
	  BEGIN
		select @dias = 1

		select @periodo_vacacional = (SELECT DATEDIFF(YEAR, @fecha_alta, @fecha_act) + 
																				CASE 
																					WHEN MONTH(@fecha_act) < MONTH(@fecha_alta) THEN -1 
																					WHEN MONTH(@fecha_act) > MONTH(@fecha_alta) THEN 0 
																					ELSE 
																						CASE WHEN DAY(@fecha_act) < DAY(@fecha_alta) THEN -1 ELSE 0 END 
																				END)
		if datepart(WEEKDAY,@fecha_act) in (1,7) -- sabados y domingos
			select @dias = 0
		else if exists (select 1 from asueto where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=0)
			select @dias = 0
		else if exists (select 1 from asueto where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=1)
			select @dias = 0.5
		else if @medio_dia = 1
			select @dias = 0.5, @medio_dia = 0

		if @dias > 0
			insert into eslabon_vacaciones_autorizadas (folio, numero_empleado, empresa, periodo_vacacional, fecha, dias, comentarios, fecha_autorizacion)
			values (@folio, @numero_empleado, @empresa, @periodo_vacacional, @fecha_act, @dias, @comentarios, @fecha_autorizacion)
			--select @folio, @numero_empleado, @empresa, @periodo_vacacional, @fecha_act, @dias, @comentarios, @fecha_autorizacion

		select @fecha_act = dateadd(dd,1,@fecha_act)
	  END

	SELECT @currRow = @currRow + 1
  END



drop table #solicitudes



go
alter function dbo.vacaciones_split_dias(@id_solicitud int)
returns @resultado table (fecha datetime, dias decimal(9,2))
as
  begin

--		declare @resultado as table (fecha datetime, dias decimal(9,2))

		DECLARE --@folio varchar(32),
				@fecha_ini datetime,
				@fecha_fin datetime,
				@fecha_act datetime,
--				@fecha_autorizacion datetime,
				@dias decimal(9,2),
				@medio_dia bit,
				@medio_dia_asueto bit,
--				@empresa int,
--				@numero_empleado varchar(32),
--				@periodo_vacacional int,
				@fecha_alta datetime,
				@id_pais int
--				@comentarios varchar(512)

		SELECT @fecha_ini = fecha_ini,
				@fecha_fin = fecha_fin,
				@fecha_act = fecha_ini,
				@medio_dia = medio_dia,
				@medio_dia_asueto = medio_dia_asueto,
--				@empresa = em.id_empresa_eslabon,
--				@numero_empleado = e.numero,
				@fecha_alta = e.fecha_alta,
				@id_pais = em.id_pais
--				@comentarios = s.comentarios,
--				@fecha_autorizacion = s.fecha_autoriza_jefe
		FROM solicitud_vacaciones s
		join empleado e on e.id_empleado = s.id_empleado_solicita
		join empresa em on em.id_empresa = e.id_empresa
		WHERE id_solicitud = @id_solicitud

		WHILE @fecha_act <= @fecha_fin
		 BEGIN
			select @dias = 1

			--select @periodo_vacacional = (SELECT DATEDIFF(YEAR, @fecha_alta, @fecha_act) +
			--																		CASE
			--																			WHEN MONTH(@fecha_act) < MONTH(@fecha_alta) THEN -1
			--																			WHEN MONTH(@fecha_act) > MONTH(@fecha_alta) THEN 0
			--																			ELSE
			--																				CASE WHEN DAY(@fecha_act) < DAY(@fecha_alta) THEN -1 ELSE 0 END
			--																		END)
			if datepart(WEEKDAY,@fecha_act) in (1,7) -- sabados y domingos
				select @dias = 0
			else if exists (select 1 from asueto (NOLOCK) where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=0)
				select @dias = 0
			else if exists (select 1 from asueto (NOLOCK) where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=1)
				select @dias = 0.5
			else if @medio_dia = 1
				select @dias = 0.5, @medio_dia = 0

			if @dias > 0
				insert into @resultado (fecha, dias)
				values (@fecha_act, @dias)

			select @fecha_act = dateadd(dd,1,@fecha_act)
		 END

	return

  end


go
alter function dbo.fn_dias_verificados_por_solicitud_vacaciones(@id_solicitud int)
returns decimal(18,1)
as
begin
	declare @resultado decimal(18,1)=0

	if not exists(select 1 from solicitud_vacaciones_verificacion (nolock) where id_solicitud = @id_solicitud)
		select @resultado=0
	else if not exists(select 1 from solicitud_vacaciones (nolock) where fecha_verificado is null)
		select @resultado=0
	else
	  begin

			DECLARE @folio varchar(32),
					@fecha_ini datetime,
					@fecha_fin datetime,
					@fecha_act datetime,
					@dias decimal(9,2),
					@medio_dia bit,
					@medio_dia_asueto bit,
					@id_pais int

			SELECT @folio = folio_txt,
					@fecha_ini = fecha_ini,
					@fecha_fin =  isNull((select max(fecha_fin) from solicitud_vacaciones_verificacion svv (NOLOCK) where svv.id_solicitud = s.id_solicitud), s.fecha_fin), --fecha_fin,
					@fecha_act = fecha_ini,
					@medio_dia = medio_dia,
					@medio_dia_asueto = medio_dia_asueto,
					@id_pais = em.id_pais
			FROM solicitud_vacaciones s (nolock)
			join empleado e (nolock) on e.id_empleado = s.id_empleado_solicita
			join empresa em (nolock) on em.id_empresa = e.id_empresa
			WHERE id_solicitud = @id_solicitud

			WHILE @fecha_act <= @fecha_fin
			  BEGIN
				select @dias = 1

				if datepart(WEEKDAY,@fecha_act) in (1,7) -- sabados y domingos
					select @dias = 0
				else if exists (select 1 from asueto (nolock) where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=0)
					select @dias = 0
				else if exists (select 1 from asueto (nolock) where fecha_eliminado is null and fecha=@fecha_act and id_pais=@id_pais and medio_dia=1)
					select @dias = 0.5
				else if @medio_dia = 1
					select @dias = 0.5, @medio_dia = 0

				if @dias > 0
					select @resultado = @resultado + @dias

				select @fecha_act = dateadd(dd,1,@fecha_act)
			  END

	  
	  end

	return isNull(@resultado,0)

end

go




























go
alter procedure [dbo].[guarda_solicitud_vacaciones]
	@id_solicitud	int,
	@id_empleado_solicita	int,
	@id_autoriza_jefe	int,
	@id_empleado_nomina	int,
	@fecha_ini	datetime,
	@fecha_fin	datetime,
	@comentarios	varchar(1024),
	@id_empresa		int,
	@id_empleado_registro	int,
	@medio_dia	bit
as


declare @folio	varchar(32),
		@folio_num	int

if @id_solicitud=0
 begin

	declare @validacion_solicitudes varchar(512)
	select @validacion_solicitudes = dbo.fn_conflicto_solicitudes_vacaciones(@id_empleado_solicita)
	if @validacion_solicitudes <> ''
	  begin
		select @validacion_solicitudes = 'Tiene otra solicitud en proceso de autorizacion, y por este motivo no puede agregar nuevas solicitudes: ' + @validacion_solicitudes
		 RAISERROR (@validacion_solicitudes, 16, 1);
		 return
	  end

	declare @validacion_fechas varchar(512)
	select @validacion_fechas = dbo.fn_conflicto_fechas_vacaciones(@fecha_ini, @fecha_fin, @id_empleado_solicita)
	if @validacion_fechas <> ''
	  begin
		select @validacion_fechas = 'Hay un conflicto en tus fechas con otra solicitud: ' + @validacion_fechas
		 RAISERROR (@validacion_fechas, 16, 1);
		 return
	  end


 
	select @folio_num = isNull(max(folio),0)+1 from solicitud_vacaciones where anio = year(getdate())
	select @folio = 'VAC' + convert(varchar,(year(getdate())-2000)) + right('0000' + convert(varchar,(@folio_num)),4)

	insert into solicitud_vacaciones (anio,folio,folio_txt,id_empleado_solicita,id_autoriza_jefe,
									id_empleado_nomina,fecha_ini,fecha_fin,dias,comentarios,fecha_registro,
									id_estatus,estatus_comentarios,id_empresa,id_empleado_registro,
									medio_dia, medio_dia_asueto)
						values (year(getdate()), @folio_num, @folio,@id_empleado_solicita,@id_autoriza_jefe,
									@id_empleado_nomina,@fecha_ini,@fecha_fin,dbo.fn_dias_vacaciones(@id_empresa,@fecha_ini,@fecha_fin),
									@comentarios,getdate(),1,'',@id_empresa,@id_empleado_registro,
									@medio_dia, dbo.fn_dias_vacaciones_medio(@id_empresa,@fecha_ini,@fecha_fin))
	
	select id=@@identity, folio_num=@folio_num, folio=@folio

 end
else
 begin

	select @folio_num=folio, @folio=folio_txt
	from solicitud_vacaciones
	where id_solicitud = @id_solicitud

	update solicitud_vacaciones
	set id_empleado_solicita=@id_empleado_solicita,
		id_autoriza_jefe=@id_autoriza_jefe,
		id_empleado_nomina=@id_empleado_nomina,
		fecha_ini=@fecha_ini,
		fecha_fin=@fecha_fin,
		dias=dbo.fn_dias_vacaciones(@id_empresa,@fecha_ini,@fecha_fin),
		comentarios=@comentarios,
		id_empresa=@id_empresa,
		medio_dia=@medio_dia,
		medio_dia_asueto=dbo.fn_dias_vacaciones_medio(@id_empresa,@fecha_ini,@fecha_fin)
	where id_solicitud = @id_solicitud

 
	select id=@id_solicitud, folio_num=@folio_num, folio=@folio
 end

go

alter procedure [dbo].[ajusta_vacaciones_por_dias_asueto]
	@fecha	datetime
as

update solicitud_vacaciones
set dias = dbo.fn_dias_vacaciones(id_empresa,fecha_ini, fecha_fin),
	medio_dia_asueto=dbo.fn_dias_vacaciones_medio(id_empresa,fecha_ini,fecha_fin)
where fecha_ini<=@fecha
and fecha_fin>=@fecha
and cancelada is null
and fecha_verificado is null

go
alter procedure [dbo].[guarda_solicitud_permisos]
	@id_solicitud	int,
	@id_empleado_solicita	int,
	@id_autoriza_jefe	int,
	@id_empleado_nomina	int,
	@fecha_ini	datetime,
	@fecha_fin	datetime,
	@comentarios	varchar(1024),
	@id_empresa		int,
	@id_empleado_registro	int,
	@medio_dia	bit,
	@id_empleado_director	int,
	@id_tipo_permiso	int,
	@con_goce	int,
	@fecha_viaje_prolongado_ini datetime,
	@fecha_viaje_prolongado_fin datetime
as


declare @folio	varchar(32),
		@folio_num	int

if @id_solicitud=0
 begin
 
	declare @id_empleado_gerente int
	select @id_empleado_gerente = (select id_empleado_gerente from empleado where id_empleado = @id_empleado_solicita)
 
	select @folio_num = isNull(max(folio),0)+1 from solicitud_permisos where anio = year(getdate())
	select @folio = 'PER' + convert(varchar,(year(getdate())-2000)) + right('0000' + convert(varchar,(@folio_num)),4)

	insert into solicitud_permisos (anio,folio,folio_txt,id_empleado_solicita,id_autoriza_jefe,
									id_empleado_nomina,fecha_ini,fecha_fin,dias,comentarios,fecha_registro,
									id_estatus,estatus_comentarios,id_empresa,id_empleado_registro,
									medio_dia, medio_dia_asueto, id_empleado_director, id_tipo_permiso,
									con_goce, id_empleado_gerente, fecha_viaje_prolongado_ini, fecha_viaje_prolongado_fin)
						values (year(getdate()), @folio_num, @folio,@id_empleado_solicita,@id_autoriza_jefe,
									@id_empleado_nomina,@fecha_ini,@fecha_fin,dbo.fn_dias_vacaciones(@id_empresa,@fecha_ini,@fecha_fin),
									@comentarios,getdate(),1,'',@id_empresa,@id_empleado_registro,
									@medio_dia, dbo.fn_dias_vacaciones_medio(@id_empresa,@fecha_ini,@fecha_fin), @id_empleado_director, 
									@id_tipo_permiso, @con_goce, @id_empleado_gerente, @fecha_viaje_prolongado_ini,
									@fecha_viaje_prolongado_fin)
	
	select id=@@identity, folio_num=@folio_num, folio=@folio

 end
else
 begin

	select @folio_num=folio, @folio=folio_txt
	from solicitud_permisos
	where id_solicitud = @id_solicitud

	update solicitud_permisos
	set id_empleado_solicita=@id_empleado_solicita,
		id_autoriza_jefe=@id_autoriza_jefe,
		id_empleado_nomina=@id_empleado_nomina,
		fecha_ini=@fecha_ini,
		fecha_fin=@fecha_fin,
		dias=dbo.fn_dias_vacaciones(@id_empresa,@fecha_ini,@fecha_fin),
		comentarios=@comentarios,
		id_empresa=@id_empresa,
		medio_dia=@medio_dia,
		medio_dia_asueto=dbo.fn_dias_vacaciones_medio(@id_empresa,@fecha_ini,@fecha_fin),
		id_empleado_director=@id_empleado_director,
		id_tipo_permiso=@id_tipo_permiso,
		con_goce=@con_goce,
		fecha_viaje_prolongado_ini=@fecha_viaje_prolongado_ini,
		fecha_viaje_prolongado_fin=@fecha_viaje_prolongado_fin
	where id_solicitud = @id_solicitud

 
	select id=@id_solicitud, folio_num=@folio_num, folio=@folio
 end


go



go

go

go

go

go

