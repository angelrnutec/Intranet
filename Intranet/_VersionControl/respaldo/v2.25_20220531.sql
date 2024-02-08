go



go
set identity_insert reporte on
go
insert into reporte (id_reporte, nombre, descripcion, es_plan, tipo_reporte, es_activo) values (32, 'Estado de Resultados - Euros', 'Estado de Resultados - Euros', 0, 1, 1)
go
set identity_insert reporte off
go



go
set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras,
		es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta)
select id_concepto+100000, clave, descripcion, 32, id_grupo, orden, id_padre+100000, resta, formula_especial, permite_captura, es_separador, es_plan, es_fibras,
		es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta
from concepto
where id_reporte = 22
order by orden
go
set identity_insert concepto off
go




go


