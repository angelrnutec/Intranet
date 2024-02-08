go


go
set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa,
						descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta)
select 1600, '10-V-05', 'Fletes', id_reporte, id_grupo, 392, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras, es_hornos, id_empresa,
						descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta
from concepto
where id_concepto = 39
go
set identity_insert concepto off
go


go



go

go

go

go

go

