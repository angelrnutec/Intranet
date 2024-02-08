go

go

ALTER procedure [dbo].[rpt_solicitud_permisos]
	@id_empresa	int,
	@fecha_ini	datetime,
	@fecha_fin	datetime,
	@id_estatus int,
	@id_empleado int,
	@canceladas int=0,
	@id_empleado_usuario int,
	@locale varchar(8) = ''
as

if @locale = '' 
	select @locale='es'

declare @ver_todo bit
select @ver_todo = 0

if exists(select pp.permiso
			from perfil_permiso pp
			join empleado_perfil ep on ep.id_perfil = pp.id_perfil
			join empleado e on e.id_empleado = ep.id_empleado
			where e.id_empleado = @id_empleado_usuario
			and pp.permiso = 'rep_sol_per')
	select @ver_todo = 1


/*
declare
	@id_empresa	int,
	@fecha_ini	datetime,
	@fecha_fin	datetime,
	@id_estatus int


select	@id_empresa	=0,
	@fecha_ini	= '20130101',
	@fecha_fin	= '20150101',
	@id_estatus	= 0
*/

select @fecha_fin = dateadd(dd,1,cast(floor(convert(float,@fecha_fin)) as datetime))

select folio = sv.folio_txt, 
	fecha_solicitud = sv.fecha_registro,
	solicitante = es.nombre,
	empresa = em.nombre,
	comentarios = sv.comentarios,
	estatus = sve.clave + '-' + sve.descripcion,
	autorizacion_jefe = ej.nombre,
	autorizacion_director = isNull(ex.nombre,''),
	empleado_nomina = ec.nombre,
	dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0),
	fecha_ini = sv.fecha_ini,
	fecha_fin = sv.fecha_fin,
	solicitud_autorizada_jefe = (case
									when sv.autoriza_jefe = 1 then (case when @locale='en' then 'Authorized' else 'Autorizado' end)
									when sv.autoriza_jefe = 0 then (case when @locale='en' then 'Declined' else 'Rechazado' end)
									else (case when @locale='en' then 'Pending' else 'Pendiente' end)
								 end),
	solicitud_autorizada_director = (case
									when sv.autoriza_director = 1 then (case when @locale='en' then 'Authorized' else 'Autorizado' end)
									when sv.autoriza_director = 0 then (case when @locale='en' then 'Declined' else 'Rechazado' end)
									else (case when @locale='en' then 'Pending' else 'Pendiente' end)
								 end),
	fecha_autoriza_jefe = sv.fecha_autoriza_jefe,
	fecha_autoriza_director = sv.fecha_autoriza_director,
	cancelada = (case 
					when sv.cancelada is null then ''
					else (case when @locale='en' then 'CANCELLED' else 'CANCELADA' end)
				 end),
	sv.fecha_verificado,
	tipo_permiso = spt.descripcion + ' (' + (case when sv.con_goce=1 then 'Con Goce de Sueldo' else 'Sin Goce de Sueldo' end) + ')'
from solicitud_permisos sv
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
join solicitud_permisos_tipo spt on spt.id_tipo_permiso = sv.id_tipo_permiso
join empleado es on es.id_empleado = sv.id_empleado_solicita
join empleado ej on ej.id_empleado = sv.id_autoriza_jefe
join empleado ec on ec.id_empleado = sv.id_empleado_nomina
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
join empresa em on em.id_empresa = sv.id_empresa
where (@id_empresa=0 or sv.id_empresa=@id_empresa)
and (@id_estatus=0 or sv.id_estatus=@id_estatus)
and sv.fecha_registro >= @fecha_ini
and sv.fecha_registro < @fecha_fin
and (@id_empleado=0 or sv.id_empleado_solicita=@id_empleado)
and (@canceladas=0 or (@canceladas=1 and sv.cancelada is null)
					or (@canceladas=2 and sv.cancelada is not null))
and (@ver_todo=1 or (sv.id_empleado_solicita in (select id_empleado 
												from dbo.fn_empleados_dependientes(@id_empleado_usuario))))
order by sv.folio_txt
go


go
ALTER procedure [dbo].[recupera_solicitud_permisos_email]
	@id_solicitud	int
as

select sv.id_solicitud, 
		sv.anio, 
		sv.folio, 
		sv.folio_txt,
		empleado_solicita = es.nombre,
		director = isNull(ex.nombre,''),
		gerente = isNull(eg.nombre,0),
		empresa = em.nombre,
		autoriza_jefe = aj.nombre, 
		nomina = nom.nombre,
		sv.fecha_ini, 
		sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0),
		sv.comentarios, 
		sv.fecha_registro,
		sv.fecha_autoriza_jefe, 
		sv.estatus_comentarios, 
		estatus = (case 
					when sv.cancelada is not null then 'SOLICITUD CANCELADA'
					when sv.id_estatus=1 and sv.autoriza_jefe=0 then 'SOLICITUD RECHAZADA'
					when sv.id_estatus=2 and sv.autoriza_jefe=1 then 'SOLICITUD AUTORIZADA'
					else sve.clave + '-' +  sve.descripcion
				   end),
		autoriza_jefe,
		sv.id_autoriza_jefe,
		sv.id_empleado_director,
		sv.id_empleado_gerente,
		sv.con_goce,
		tipo_permiso = spt.descripcion,
		sv.fecha_viaje_prolongado_ini,
		sv.fecha_viaje_prolongado_fin,
		sv.id_tipo_permiso,
		sv.id_empresa
from solicitud_permisos sv
join empleado es on es.id_empleado = sv.id_empleado_solicita
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
join empleado aj on aj.id_empleado = sv.id_autoriza_jefe
join empleado nom on nom.id_empleado = sv.id_empleado_nomina
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
left outer join empleado eg on eg.id_empleado = sv.id_empleado_gerente
join solicitud_permisos_tipo spt on spt.id_tipo_permiso = sv.id_tipo_permiso
where sv.id_solicitud = @id_solicitud

go





go
alter procedure [dbo].[recupera_solicitud_permisos_email_autoriza]
	@id_solicitud	int
as

select sv.id_solicitud, sv.id_autoriza_jefe, email_jefe = ISNULL(aj.email, ''), 
		sv.folio_txt,
		email_solicita = ISNULL(es.email, ''),
		email_nominas = ISNULL(en.email, ''),
		email_director = ISNULL(ex.email, ''),
		email_gerente = ISNULL(eg.email, ''),
		autoriza_jefe = aj.nombre,
		empleado_solicita = es.nombre,
		empleado_nominas = en.nombre,
		empleado_director = ex.nombre,
		empleado_gerente = ISNULL(eg.nombre,''),
		email_sistema_nominas = (select top 1 email_nominas from parametros),
		es.id_empresa
from solicitud_permisos sv
join empleado aj on aj.id_empleado = sv.id_autoriza_jefe
join empleado es on es.id_empleado = sv.id_empleado_solicita
join empleado en on en.id_empleado = sv.id_empleado_nomina
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
left outer join empleado eg on eg.id_empleado = sv.id_empleado_gerente
where sv.id_solicitud = @id_solicitud

go





go
alter procedure [dbo].[recupera_autoriza_direccion]
	@id_empleado int
as

declare @centro_costo varchar(32),
		@id_empresa int,
		@id_empleado_director int

select @centro_costo = d.centro_costo,
		@id_empresa = e.id_empresa
from empleado e
join departamento d on d.id_departamento = e.id_departamento
where e.id_empleado = @id_empleado


select @id_empleado_director = isNull((select top 1 id_empleado_director from excepciones_empleado_director where centro_costo = @centro_costo and id_empleado_director <> @id_empleado),0)

if @id_empleado_director = 0
	select @id_empleado_director = (select (case
												when @id_empresa=3 then id_director_nb
												when @id_empresa=6 then id_director_ns
												when @id_empresa=8 then id_director_nf
												when @id_empresa=10 then id_director_ne
												when @id_empresa=12 then id_director_nu
												else 0
											end)
									from parametros)




select id_empleado=0, nombre='--Seleccione--'
union
select id_empleado=e.id_empleado, e.nombre
from empleado e 
where e.id_empleado = @id_empleado_director
go


go
alter procedure [dbo].[recupera_solicitud_permisos_auth1]
	@id_usuario	int
as

select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita, 
		solicitante = ev.nombre, sv.id_empresa, empresa = em.nombre,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, sv.id_estatus, 
		sv.estatus_comentarios, estatus = sve.clave + '-' +  sve.descripcion,
		empleado_director = isNull(ex.nombre,''),
		empleado_gerente = isNull(eg.nombre,''),
		tipo_auth=1
from solicitud_permisos sv
join empleado ev on ev.id_empleado = sv.id_empleado_solicita
join empleado en on en.id_empleado = sv.id_empleado_nomina
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
left outer join empleado eg on eg.id_empleado = sv.id_empleado_gerente
where sv.id_autoriza_jefe = @id_usuario
and sv.id_estatus=1
and sv.autoriza_jefe is null
and sv.cancelada is null
union
select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita, 
		solicitante = ev.nombre, sv.id_empresa, empresa = em.nombre,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, sv.id_estatus, 
		sv.estatus_comentarios, estatus = sve.clave + '-' +  sve.descripcion,
		empleado_director = isNull(ex.nombre,''),
		empleado_gerente = isNull(eg.nombre,''),
		tipo_auth=2
from solicitud_permisos sv
join empleado ev on ev.id_empleado = sv.id_empleado_solicita
join empleado en on en.id_empleado = sv.id_empleado_nomina
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
left outer join empleado eg on eg.id_empleado = sv.id_empleado_gerente
where sv.id_empleado_director = @id_usuario
and sv.autoriza_director is null
and sv.cancelada is null
and ((sv.id_empleado_gerente is null and sv.id_estatus=2)
	or (sv.autoriza_gerente is not null and sv.id_estatus=3))
union
select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita, 
		solicitante = ev.nombre, sv.id_empresa, empresa = em.nombre,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, sv.id_estatus, 
		sv.estatus_comentarios, estatus = sve.clave + '-' +  sve.descripcion,
		empleado_director = isNull(ex.nombre,''),
		empleado_gerente = isNull(eg.nombre,''),
		tipo_auth=3
from solicitud_permisos sv
join empleado ev on ev.id_empleado = sv.id_empleado_solicita
join empleado en on en.id_empleado = sv.id_empleado_nomina
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
left outer join empleado ex on ex.id_empleado = sv.id_empleado_director
left outer join empleado eg on eg.id_empleado = sv.id_empleado_gerente
where sv.id_empleado_gerente = @id_usuario
and sv.id_estatus=2
and sv.autoriza_gerente is null
and sv.cancelada is null

go




go
alter procedure [dbo].[recupera_solicitud_permisos_realizado]
	@id_usuario	int
as

select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita, 
		solicitante = ev.nombre, sv.id_empresa, empresa = em.nombre,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, sv.id_estatus, 
		sv.estatus_comentarios, 
		estatus = (case	
					when sv.cancelada is not null then 'SOLICITUD CANCELADA'
					when sv.autoriza_jefe=1 then 'AUTORIZO SOLICITUD (JEFE)'
					when sv.autoriza_jefe=0 then 'RECHAZO SOLICITUD (JEFE)'
					end),
		fecha=fecha_autoriza_jefe
from solicitud_permisos sv
join empleado ev on ev.id_empleado = sv.id_empleado_solicita
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
where sv.id_autoriza_jefe = @id_usuario
and sv.autoriza_jefe is not null
--order by fecha desc
union
select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita, 
		solicitante = ev.nombre, sv.id_empresa, empresa = em.nombre,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin, 
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, sv.id_estatus, 
		sv.estatus_comentarios, 
		estatus = (case	
					when sv.cancelada is not null then 'SOLICITUD CANCELADA'
					when sv.autoriza_director=1 then 'AUTORIZO SOLICITUD (DIRECTOR)'
					when sv.autoriza_director=0 then 'RECHAZO SOLICITUD (DIRECTOR)'
					end),
		fecha=fecha_autoriza_director
from solicitud_permisos sv
join empleado ev on ev.id_empleado = sv.id_empleado_solicita
join empresa em on em.id_empresa = sv.id_empresa
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
where sv.id_empleado_director = @id_usuario
and sv.autoriza_director is not null
order by fecha desc

go



go
alter procedure [dbo].[recupera_solicitud_permisos_x_id]	
	@id_solicitud	int
as

select sv.id_solicitud, sv.anio, sv.folio, sv.folio_txt, sv.id_empleado_solicita,sv.id_empleado_director,
		sv.id_autoriza_jefe, sv.id_empleado_nomina, sv.fecha_ini, sv.fecha_fin,
		dias = convert(decimal(18,1),sv.dias) - (case when sv.medio_dia=1 then 0.5 else 0 end) - isNull((medio_dia_asueto*0.5),0), 
		sv.comentarios, sv.fecha_registro, sv.fecha_autoriza_jefe, 
		sv.id_estatus, sv.estatus_comentarios, sv.id_empresa, sv.autoriza_jefe,
		sv.id_empleado_registro,
		estatus = (case 
					when sv.cancelada is not null then 'SOLICITUD CANCELADA'
					when sv.id_estatus=1 and sv.autoriza_jefe=0 then 'SOLICITUD RECHAZADA'
					when sv.id_estatus=2 and sv.autoriza_jefe=1 then 'SOLICITUD AUTORIZADA'
					else sve.clave + '-' +  sve.descripcion
				   end),
		sv.medio_dia,
		permitir_cancelar = (case
								when sv.fecha_autoriza_jefe is null
									 then 1
								else 0
							 end),
		solicitud_cancelada = (case	
								when sv.cancelada is null then 0
								else 1
							   end),
		sv.id_tipo_permiso,
		sv.con_goce,
		sv.fecha_viaje_prolongado_ini,
		sv.fecha_viaje_prolongado_fin
from solicitud_permisos sv
join solicitud_permisos_estatus sve on sve.id_estatus = sv.id_estatus
where sv.id_solicitud = @id_solicitud

go

go
update solicitud_permisos_estatus set descripcion = 'AUTORIZADO' where id_estatus = 4
go

go

go

go

go

go

go

go

