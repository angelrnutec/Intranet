go
set identity_insert concepto on
go
insert into concepto (id_concepto, clave, descripcion, id_reporte, id_grupo, orden, 
						id_padre, resta, formula_especial, permite_captura, es_separador, es_plan, 
						es_fibras, es_hornos, id_empresa, descripcion_2, anio_baja, periodo_baja, 
						es_borrado, referencia, referencia2, referencia3, anio_alta, periodo_alta)
values (202021, '35-PD-05','Leasings',1,null,288,29,0,null,1,0,0,0,0,null,'',null,null,0,null,null,null,null,null)
go
set identity_insert concepto off
go



update concepto set descripcion = 'Pasivo Diferido (D3 y D5)' where id_concepto=28
go



