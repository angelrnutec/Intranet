go

set identity_insert reporte on
go
insert into reporte (id_reporte, nombre, descripcion, es_plan, tipo_reporte, es_activo) values (1016, 'Pronostico Intercompañias Ventas ER','Pronostico Intercompañias Ventas ER',1,1,0)
go
set identity_insert reporte off
go

go


go

set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2000, '', 'INTERCOMPANIES VENTAS', 1016, null, 99990, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2001, '', 'Intercompanies NUSA', 1016, null, 99991, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2002, '', 'Intercompanies NP', 1016, null, 99992, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2003, '', 'Intercompanies NI', 1016, null, 99993, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2004, '', 'Intercompanies NE', 1016, null, 99994, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2005, '', 'Intercompanies NB', 1016, null, 99995, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, id_padre, resta, formula_especial, permite_captura, 
						es_separador, es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, es_borrado, 
						referencia, referencia2, referencia3 ,anio_alta, periodo_alta) 
				values (2006, '', 'Intercompanies NF', 1016, null, 99996, 0, 0, null, 1, 0, 0, 0, 0, null, '', null, null, 0, null, null, null, null, null)

go
set identity_insert concepto off
go


update concepto set permite_captura=0, es_separador=1 where id_concepto=2000


go

go

go

go

