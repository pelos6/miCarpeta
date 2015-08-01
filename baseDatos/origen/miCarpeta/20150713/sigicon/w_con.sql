prompt PL/SQL Developer import file
prompt Created on lunes, 13 de julio de 2015 by jiranzo
set feedback off
set define off
prompt Loading W_TIP_CON...
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('L', 'Convocatoria listas especificas logistica');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('O', 'Oposición');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('C', 'Convocatoria de Procedimiento Especial');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('R', 'Nueva Baremación (Rebaremación)');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('V', 'Ver méritos');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('A', 'Actos de Elección');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('P', 'Procedimiento conjunto de tipo O y R');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('T', 'Concurso de Traslados');
insert into W_TIP_CON (COD_TIP_CON, DES_TIP_CON)
values ('F', 'Acto de Elección de Funcionarios');
commit;
prompt 9 records loaded
prompt Loading W_CON...
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (206, 'NUEVA BAREMACIÓN 2011', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('27-01-2011', 'dd-mm-yyyy'), to_date('08-02-2011', 'dd-mm-yyyy'), to_date('28-02-2011 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-01-2011', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('08-02-2011 23:59:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (1, 'CONVOCATORIA LISTAS DE LOGISTICA DE CALATAYUD', '0', 'CUERPOS CONVOCADOS', '0 ', 'ESPECIALIDADES CONVOCADOS', 'L', '17', 3, to_date('16-11-2011', 'dd-mm-yyyy'), to_date('16-11-2011', 'dd-mm-yyyy'), to_date('24-11-2011 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-04-2011', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('15-11-2011', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (314, '0593 078 VIOLIN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('14-11-2014', 'dd-mm-yyyy'), to_date('14-11-2014', 'dd-mm-yyyy'), to_date('05-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('14-11-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('02-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (301, '0593 001 ACORDEÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('17-09-2014', 'dd-mm-yyyy'), to_date('17-09-2014', 'dd-mm-yyyy'), to_date('02-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('29-09-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (302, '0593 010 COMPOSICION E INSTRUMENTACION', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('23-09-2014', 'dd-mm-yyyy'), to_date('23-09-2014', 'dd-mm-yyyy'), to_date('09-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('24-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('07-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (297, '0593 072 TROMBON', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('07-08-2014', 'dd-mm-yyyy'), to_date('07-08-2014', 'dd-mm-yyyy'), to_date('11-09-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-08-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-09-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (316, '0590 011 INGLES', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('01-12-2014', 'dd-mm-yyyy'), to_date('01-12-2014', 'dd-mm-yyyy'), to_date('19-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('17-12-2014 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (321, '0590 002 GRIEGO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('22-12-2014', 'dd-mm-yyyy'), to_date('22-12-2014', 'dd-mm-yyyy'), to_date('22-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('20-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (104, 'SECUNDARIA SEMANA 24 1 08/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('08-06-2015', 'dd-mm-yyyy'), to_date('08-06-2015', 'dd-mm-yyyy'), to_date('24-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('09-06-2015 12:42:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (52, 'PRIMARIA ACTO SEMANAL JUEVES 28/05/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('28-05-2015', 'dd-mm-yyyy'), to_date('28-05-2015', 'dd-mm-yyyy'), to_date('13-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-05-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('29-05-2015 12:54:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (328, '0591 216 OP. DE PRODUCCIÓN AGRARIA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('20-01-2015', 'dd-mm-yyyy'), to_date('20-01-2015', 'dd-mm-yyyy'), to_date('03-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('20-01-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('31-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (18, 'NUEVA BAREMACION 2015', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('18-02-2015', 'dd-mm-yyyy'), to_date('23-02-2015', 'dd-mm-yyyy'), to_date('16-03-2015 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('24-02-2015 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (343, '0590 016 PES MUSICA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('20-05-2015', 'dd-mm-yyyy'), to_date('20-05-2015', 'dd-mm-yyyy'), to_date('06-06-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('20-05-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('04-06-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (344, '0596 612 TALLA EN PIEDRA Y MADERA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('22-05-2015', 'dd-mm-yyyy'), to_date('22-05-2015', 'dd-mm-yyyy'), to_date('11-06-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-05-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-06-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (299, '0593 030 FAGOT', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('11-08-2014', 'dd-mm-yyyy'), to_date('11-08-2014', 'dd-mm-yyyy'), to_date('11-09-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-08-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-09-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (300, '0595 511 DISEÑO DE PRODUCTO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('12-08-2014', 'dd-mm-yyyy'), to_date('12-08-2014', 'dd-mm-yyyy'), to_date('11-09-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('12-08-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-09-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (326, '0593 009 CATEDRÁTICOS CLAVE', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('30-12-2014', 'dd-mm-yyyy'), to_date('30-12-2014', 'dd-mm-yyyy'), to_date('20-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('17-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (341, '0594 411 PMAE PLAUTA PICO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('12-05-2015', 'dd-mm-yyyy'), to_date('12-05-2015', 'dd-mm-yyyy'), to_date('23-05-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('12-05-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('21-05-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (313, '0593 079 VIOLONCELLO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('13-11-2014', 'dd-mm-yyyy'), to_date('13-11-2014', 'dd-mm-yyyy'), to_date('29-11-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-11-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('27-11-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (319, '0590 003 LATIN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('09-12-2014', 'dd-mm-yyyy'), to_date('09-12-2014', 'dd-mm-yyyy'), to_date('23-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('20-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (3, 'CONVOCATORIA LISTAS DE LOGISTICA DE CALATAYUD', '0', 'CUERPOS CONVOCADOS', '0 ', 'ESPECIALIDADES CONVOCADOS', 'L', '17', 3, to_date('30-11-2011', 'dd-mm-yyyy'), to_date('13-12-2012', 'dd-mm-yyyy'), to_date('19-12-2012 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-12-2012', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('13-12-2012 09:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (311, '0590 119 PROCESOS Y MEDIOS DE COMUNICACIÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('09-10-2014', 'dd-mm-yyyy'), to_date('09-10-2014', 'dd-mm-yyyy'), to_date('27-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('24-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (102, 'SECUNDARIA SEMANA 23 1 01/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('01-06-2015', 'dd-mm-yyyy'), to_date('01-06-2015', 'dd-mm-yyyy'), to_date('17-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('02-06-2015 13:45:29', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (101, 'SECUNDARIA SEMANA 24 2 11/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('11-06-2015', 'dd-mm-yyyy'), to_date('11-06-2015', 'dd-mm-yyyy'), to_date('27-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('12-06-2015 12:30:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (312, '0591 229 TÉCNICAS Y PROCEDIMIENTOS DE IMAGEN Y SONIDO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('10-10-2014', 'dd-mm-yyyy'), to_date('10-10-2014', 'dd-mm-yyyy'), to_date('31-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('10-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('29-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (207, 'CONCURSO DE TRASLADOS SECUNDARIA', '0', 'CUERPOS CONVOCADOS', '0 ', 'ESPECIALIDADES CONVOCADOS', 'T', '15', 3, to_date('07-05-2014', 'dd-mm-yyyy'), to_date('14-05-2014', 'dd-mm-yyyy'), to_date('15-03-2016', 'dd-mm-yyyy'), to_date('04-04-2012', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('15-03-2013', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (298, '0593 002 ARMONIA Y MELODIA ACOMPAÑADA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('08-08-2014', 'dd-mm-yyyy'), to_date('08-08-2014', 'dd-mm-yyyy'), to_date('11-09-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-08-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-09-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (200, 'OPOSICIÓN MEDIAS 2010', '0', '0', '0', '0', 'O', '1', 1, to_date('28-04-2010', 'dd-mm-yyyy'), to_date('08-04-2010', 'dd-mm-yyyy'), to_date('10-09-2014 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-01-2011', 'dd-mm-yyyy'), 'N', 'N', '0', 'N', 'N', to_date('21-08-2011 23:59:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (100, 'SECUNDARIA INICIO DE CURSO. FUNCIONARIOS EN PRÁCTICAS. 25/08/14', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'F', '15', 1, to_date('25-08-2014', 'dd-mm-yyyy'), to_date('25-08-2014', 'dd-mm-yyyy'), to_date('26-09-2014 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('25-08-2014', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('28-08-2014 13:01:25', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (2, 'CONVOCATORIA LISTAS DE LOGISTICA DE CALATAYUD', '0', 'CUERPOS CONVOCADOS', '0 ', 'ESPECIALIDADES CONVOCADOS', 'L', '17', 3, to_date('30-11-2011', 'dd-mm-yyyy'), to_date('30-11-2011', 'dd-mm-yyyy'), to_date('12-12-2011 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-04-2011', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('30-11-2011 12:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (12, 'CONCURSO DE TRASLADOS PRIMARIA', '0', 'CUERPOS CONVOCADOS', '0 ', 'ESPECIALIDADES CONVOCADOS', 'T', '15', 3, to_date('07-05-2014', 'dd-mm-yyyy'), to_date('14-05-2014', 'dd-mm-yyyy'), to_date('15-03-2016', 'dd-mm-yyyy'), to_date('04-04-2012', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('15-03-2013', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (309, '0591 201 COCINA Y PASTELERÍA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('06-10-2014', 'dd-mm-yyyy'), to_date('06-10-2014', 'dd-mm-yyyy'), to_date('27-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('24-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (303, '0593 059 PIANO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('25-09-2014', 'dd-mm-yyyy'), to_date('25-09-2014', 'dd-mm-yyyy'), to_date('11-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('25-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (322, '0591 215 OPERACIONES DE PROCESOS', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('22-12-2014', 'dd-mm-yyyy'), to_date('22-12-2014', 'dd-mm-yyyy'), to_date('22-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('20-01-2015 09:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (336, '0594 401 PMAE ACORDEÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('11-03-2015', 'dd-mm-yyyy'), to_date('11-03-2015', 'dd-mm-yyyy'), to_date('27-03-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-03-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('25-03-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (337, '0594 426 TROMBÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('23-03-2015', 'dd-mm-yyyy'), to_date('23-03-2015', 'dd-mm-yyyy'), to_date('17-04-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-03-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('15-04-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (329, '0594 431 PMAE VIOLA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('02-02-2015', 'dd-mm-yyyy'), to_date('02-02-2015', 'dd-mm-yyyy'), to_date('19-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('17-02-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (318, '0590 106 HOSTELERÍA Y TURISMO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('05-12-2014', 'dd-mm-yyyy'), to_date('05-12-2014', 'dd-mm-yyyy'), to_date('27-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('24-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (331, '0590 124 SISTEMAS ELECTRÓNICOS', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('03-02-2015', 'dd-mm-yyyy'), to_date('03-02-2015', 'dd-mm-yyyy'), to_date('20-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('03-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('18-02-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (339, 'PMAE ORQUESTA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('15-04-2015', 'dd-mm-yyyy'), to_date('15-04-2015', 'dd-mm-yyyy'), to_date('05-05-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('15-04-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('01-05-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (338, '0595 512 DISEÑO GRÁFICO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('26-03-2015', 'dd-mm-yyyy'), to_date('26-03-2015', 'dd-mm-yyyy'), to_date('05-05-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-03-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('01-05-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (103, 'SECUNDARIA SEMANA 23 2 04/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('04-06-2015', 'dd-mm-yyyy'), to_date('04-06-2015', 'dd-mm-yyyy'), to_date('20-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('05-06-2015 13:30:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (340, '0590 019 TECNOLOGIA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('30-04-2015', 'dd-mm-yyyy'), to_date('30-04-2015', 'dd-mm-yyyy'), to_date('21-05-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-04-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('15-05-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (51, 'PRIMARIA ACTO SEMANAL LUNES 01/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('01-06-2015', 'dd-mm-yyyy'), to_date('01-06-2015', 'dd-mm-yyyy'), to_date('17-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('02-06-2015 13:01:33', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (238, 'NUEVA BAREMACIÓN 2012', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('30-12-2011', 'dd-mm-yyyy'), to_date('16-01-2012', 'dd-mm-yyyy'), to_date('06-02-2012 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-12-2011', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('18-01-2012 12:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (315, 'NUEVA BAREMACION 2014 2015', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('19-11-2014', 'dd-mm-yyyy'), to_date('01-12-2014', 'dd-mm-yyyy'), to_date('23-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('02-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (327, '0591 223  PRODUCCIÓN EN ARTES GRÁFICAS', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('07-01-2015', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'), to_date('31-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-01-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('28-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (306, '0592 001 ALEMAN EOI', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('30-09-2014', 'dd-mm-yyyy'), to_date('30-09-2014', 'dd-mm-yyyy'), to_date('21-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('16-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (324, '0590 111 ORGANIZACIÓN Y PROCESOS DE MANTENIMIENTO DE VEHÍCUL', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('29-12-2014', 'dd-mm-yyyy'), to_date('29-12-2014', 'dd-mm-yyyy'), to_date('22-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('20-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (14, 'OPOSICIÓN MAESTROS 2013.', '0', '-', '0', '-', 'O', '14', 1, to_date('30-04-2013', 'dd-mm-yyyy'), to_date('10-04-2013', 'dd-mm-yyyy'), to_date('30-04-2014 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-04-2013', 'dd-mm-yyyy'), 'S', 'N', '0', 'N', 'S', to_date('11-04-2013 00:01:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (257, 'NUEVA BAREMACIÓN CURSO 2012 2013', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('30-11-2012', 'dd-mm-yyyy'), to_date('11-12-2012', 'dd-mm-yyyy'), to_date('02-01-2013 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-11-2012', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('14-12-2012 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (317, '0590 118 PROCESOS SANITARIOS', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('04-12-2014', 'dd-mm-yyyy'), to_date('04-12-2014', 'dd-mm-yyyy'), to_date('22-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('19-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (330, '0594 419 PMAE OBOE', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('02-02-2015', 'dd-mm-yyyy'), to_date('02-02-2015', 'dd-mm-yyyy'), to_date('19-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('17-02-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (335, '0591 203 ESTÉTICA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('09-02-2015', 'dd-mm-yyyy'), to_date('09-02-2015', 'dd-mm-yyyy'), to_date('24-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('21-02-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (342, '0596 610 MOLDES Y REPRODUCCIONES', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('21-05-2015', 'dd-mm-yyyy'), to_date('21-05-2015', 'dd-mm-yyyy'), to_date('11-06-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-05-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-06-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (53, 'PRIMARIA ACTO SEMANAL JUEVES 04/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('04-06-2015', 'dd-mm-yyyy'), to_date('04-06-2015', 'dd-mm-yyyy'), to_date('20-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('05-06-2015 12:46:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (286, 'NUEVA BAREMACIÓN 2013 2014', 'CNB', 'CUERPOS CONVOCADOS', 'SEC', 'ESPECIALIDADES CONVOCADAS', 'R', '1', 1, to_date('29-11-2013', 'dd-mm-yyyy'), to_date('02-12-2013', 'dd-mm-yyyy'), to_date('23-12-2013 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-11-2013', 'dd-mm-yyyy'), 'S', 'S', '0', 'S', 'N', to_date('04-12-2013', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (292, 'INSTANCIA CONVOCATORIA 2014  CONCURSO-OPOSICIÓN', '0', '-', '0', '-', 'O', '14', 1, to_date('05-05-2014', 'dd-mm-yyyy'), to_date('14-04-2014', 'dd-mm-yyyy'), to_date('05-05-2015 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2014 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), 'S', 'N', '0', 'N', 'S', to_date('11-04-2014 09:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (332, '0591 208 LABORATORIO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '4', 1, to_date('03-02-2015', 'dd-mm-yyyy'), to_date('03-02-2015', 'dd-mm-yyyy'), to_date('06-03-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('03-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('03-03-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (304, '0592 004 CHINO', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('26-09-2014', 'dd-mm-yyyy'), to_date('26-09-2014', 'dd-mm-yyyy'), to_date('06-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('03-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (334, '0594 433 PMAE VIOLIN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('06-02-2015', 'dd-mm-yyyy'), to_date('06-02-2015', 'dd-mm-yyyy'), to_date('21-02-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-02-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('19-02-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (310, '0592 017 RUSO EOI', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('07-10-2014', 'dd-mm-yyyy'), to_date('07-10-2014', 'dd-mm-yyyy'), to_date('30-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('28-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (305, '0590 012 ALEMAN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('29-09-2014', 'dd-mm-yyyy'), to_date('29-09-2014', 'dd-mm-yyyy'), to_date('15-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-09-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('11-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (320, '0591 226 SERVICIOS DE RESTAURACIÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('10-12-2014', 'dd-mm-yyyy'), to_date('10-12-2014', 'dd-mm-yyyy'), to_date('27-12-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('10-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('24-12-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (307, '0590 107 INFORMÁTICA', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('02-10-2014', 'dd-mm-yyyy'), to_date('02-10-2014', 'dd-mm-yyyy'), to_date('21-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('16-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (308, '0594 405 CLAVE', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('03-10-2014', 'dd-mm-yyyy'), to_date('03-10-2014', 'dd-mm-yyyy'), to_date('20-10-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('03-10-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('17-10-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (50, 'PRIMARIA ACTO SEMANAL LUNES 08/06/15', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'A', '15', 1, to_date('08-06-2015', 'dd-mm-yyyy'), to_date('08-06-2015', 'dd-mm-yyyy'), to_date('24-07-2015 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-06-2015', 'dd-mm-yyyy'), 'S', 'S', 'N', 'N', 'N', to_date('09-06-2015 13:07:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (333, 'OPOSICIÓN MEDIAS 2015.', '0', '-', '0', '-', 'O', '14', 1, to_date('10-04-2015', 'dd-mm-yyyy'), to_date('17-03-2015', 'dd-mm-yyyy'), to_date('10-04-2016 23:59:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-04-2015', 'dd-mm-yyyy'), 'S', 'N', '0', 'N', 'S', to_date('18-03-2015 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (325, '0590 102 ANÁLISIS Y QUÍMICA INDUSTRIAL', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('29-12-2014', 'dd-mm-yyyy'), to_date('29-12-2014', 'dd-mm-yyyy'), to_date('26-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('23-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (323, '0590 125 SISTEMAS ELECTROTECNICOS Y AUTOMATICOS', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('26-12-2014', 'dd-mm-yyyy'), to_date('26-12-2014', 'dd-mm-yyyy'), to_date('26-01-2015 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('23-01-2015', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (296, '0594 422 PERCUSIÓN', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('22-04-2014', 'dd-mm-yyyy'), to_date('22-04-2014', 'dd-mm-yyyy'), to_date('09-05-2014 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-04-2014', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('07-05-2014', 'dd-mm-yyyy'));
insert into W_CON (COD_CON, DES_CON, COD_CUE, DES_CUE, COD_ESP, DES_ESP, COD_TIP_CON, FAS_CON, ORDEN, F_RES, F_PUB, F_FIN_SOL, F_FIN_MER, ACT_CON_SN, L_CAS, L_ACC, L_NUE_PRO, L_TIT_ACC, F_INI_SOL)
values (346, '0596 618 TÉCNICAS DEL METAL', '0', 'CUERPOS CONVOCADOS', '0', 'ESPECIALIDADES CONVOCADAS', 'C', '1', 1, to_date('25-05-2015', 'dd-mm-yyyy'), to_date('25-05-2015', 'dd-mm-yyyy'), to_date('11-06-2015', 'dd-mm-yyyy'), to_date('25-05-2015', 'dd-mm-yyyy'), 'S', 'S', '0', 'N', 'N', to_date('09-06-2015', 'dd-mm-yyyy'));
commit;
prompt 72 records loaded
prompt Loading W_FAS_CON...
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('18', ' Grabación de solicitud (solo solicitud)', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('1', 'Grabación de solicitudes', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('2', 'Provisional de admitidos / excluidos', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('3', 'Definitivo de admitidos / excluidos', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('4', 'Realización de pruebas / examenes 1', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('5', 'Realización de pruebas / examenes 2', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('6', 'Realización de pruebas / examenes 3', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('7', 'Realización de pruebas / examenes 4', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('8', 'Baremación provisional fase concurso', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('9', 'Baremación definitiva fase concurso', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('10', 'Baremación provisional fase oposición', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('11', 'Baremación definitiva fase oposición', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('12', 'Baremación provisional fase concurso / oposición', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('13', 'Baremación definitiva fase concurso / oposición', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('14', 'Publicación de notas', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('0', 'Sin fase', null);
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('15', 'Obtención de documentación', 'S');
insert into W_FAS_CON (COD_FAS, DES_FAS, L_ACT)
values ('16', 'Petición de documentación', 'S');
commit;
prompt 18 records loaded
set feedback on
set define on
prompt Done.
