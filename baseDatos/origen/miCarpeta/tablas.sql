------------------------------------------------
-- Export file for user EDUSIGIPREP           --
-- Created by jiranzo on 30/06/2015, 14:37:40 --
------------------------------------------------

spool tablas.log

prompt
prompt Creating table SIGI_AUD
prompt =======================
prompt
create table SIGI_AUD
(
  TIPO_ID VARCHAR2(1),
  DNI     VARCHAR2(15),
  COD_SES VARCHAR2(100),
  IP      VARCHAR2(40),
  VAL_1   VARCHAR2(4000),
  VAL_2   VARCHAR2(4000),
  NUM_AUD NUMBER not null,
  F_INS   DATE
)
;
comment on table SIGI_AUD
  is 'Tabla para la auditoria de sigi web';
comment on column SIGI_AUD.TIPO_ID
  is 'Tido de identificador del participante';
comment on column SIGI_AUD.DNI
  is 'Dni del del participante';
comment on column SIGI_AUD.NUM_AUD
  is 'número del registro';
create index IX_SIGI_AUD_NUM_AUD on SIGI_AUD (NUM_AUD);

prompt
prompt Creating table SIGI_CAN_PRE_AE
prompt ==============================
prompt
create table SIGI_CAN_PRE_AE
(
  TIPO_ID VARCHAR2(1) not null,
  DNI     VARCHAR2(15) not null,
  COD_OPC VARCHAR2(7) not null,
  COD_COL VARCHAR2(1),
  L_MED   VARCHAR2(1),
  COD_MUN VARCHAR2(9)
)
;
comment on table SIGI_CAN_PRE_AE
  is ' Candidatos preseleccionados para el AE. ';
comment on column SIGI_CAN_PRE_AE.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_CAN_PRE_AE.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_CAN_PRE_AE.COD_OPC
  is 'Código de la opción para la que la persona esta preseleccionada o puede consultar su situación en lsitas';
comment on column SIGI_CAN_PRE_AE.COD_COL
  is ' Código del colectivo al que pertenece. ';
comment on column SIGI_CAN_PRE_AE.L_MED
  is ' Si el candidato esta o no en situación de no decaido en listas de interinos de Enseñanzas Medias.. ';
comment on column SIGI_CAN_PRE_AE.COD_MUN
  is '  is ''Municipio / Localidad (a partir de 2012) en el que ha estado ocupando plaza el participante. '';';
alter table SIGI_CAN_PRE_AE
  add constraint SIGI_CAN_PRE_AE_PK primary key (TIPO_ID, DNI, COD_OPC);

prompt
prompt Creating table SIGI_CON_PRE
prompt ===========================
prompt
create table SIGI_CON_PRE
(
  DNI      VARCHAR2(15) not null,
  COD_CUE  VARCHAR2(4) not null,
  COD_ESP  VARCHAR2(3) not null,
  FEC_OPO1 VARCHAR2(10),
  NOT1     VARCHAR2(10),
  FEC_OPO2 VARCHAR2(10),
  NOT2     VARCHAR2(10),
  FEC_OPO3 VARCHAR2(10),
  NOT3     VARCHAR2(10),
  L_CON    VARCHAR2(1)
)
;
comment on table SIGI_CON_PRE
  is 'Indica si un participantes cumple la condición de lista preferente y porque oposición';
comment on column SIGI_CON_PRE.DNI
  is 'Dni del participante en listas';
comment on column SIGI_CON_PRE.COD_CUE
  is 'Código de cuerpo';
comment on column SIGI_CON_PRE.COD_ESP
  is 'Código de especialidad';
comment on column SIGI_CON_PRE.FEC_OPO1
  is 'Fecha del primer proceso selectivo';
comment on column SIGI_CON_PRE.NOT1
  is 'Nota del primer proceso selectivo';
comment on column SIGI_CON_PRE.FEC_OPO2
  is 'Fecha del segundo proceso selectivo';
comment on column SIGI_CON_PRE.NOT2
  is 'Nota del segundo proceso selectivo';
comment on column SIGI_CON_PRE.FEC_OPO3
  is 'Fecha del tercer proceso selectivo';
comment on column SIGI_CON_PRE.NOT3
  is 'Nota del tercer proceso selectivo';
comment on column SIGI_CON_PRE.L_CON
  is 'Cumple la condición para lista preferente';
alter table SIGI_CON_PRE
  add constraint PK_SIGI_CON_PRE primary key (DNI, COD_CUE, COD_ESP);

prompt
prompt Creating table SIGI_ERR
prompt =======================
prompt
create table SIGI_ERR
(
  NUM_ERR INTEGER not null,
  USE     VARCHAR2(30),
  TIPO_ID VARCHAR2(1),
  DNI     VARCHAR2(15),
  RET     VARCHAR2(4000),
  ERR_COD INTEGER,
  ERR_MEN VARCHAR2(4000),
  FEC_CRE DATE
)
;
comment on table SIGI_ERR
  is 'Tabla de errores producidos en SIGI';
comment on column SIGI_ERR.NUM_ERR
  is 'Clave primaria generada por trigger';
comment on column SIGI_ERR.USE
  is 'Usuario ';
comment on column SIGI_ERR.RET
  is 'retorno con la traza del error ordenada y el código de error de aplicación';
comment on column SIGI_ERR.ERR_COD
  is 'Código de error';
comment on column SIGI_ERR.ERR_MEN
  is 'Mensaje de error';
comment on column SIGI_ERR.FEC_CRE
  is 'Fecha de creación del registro';
create index IX_SIGI_ERR_NUM_ERR on SIGI_ERR (NUM_ERR);

prompt
prompt Creating table SIGI_ESP_CAN_PRE_AE
prompt ==================================
prompt
create table SIGI_ESP_CAN_PRE_AE
(
  TIPO_ID       VARCHAR2(1) not null,
  DNI           VARCHAR2(15) not null,
  COD_OPC       VARCHAR2(7) not null,
  COD_CUE       VARCHAR2(4) not null,
  COD_ESP       VARCHAR2(3) not null,
  COD_PRO_1_SUS VARCHAR2(2),
  COD_PRO_2_SUS VARCHAR2(2),
  L_LIS_SUS     VARCHAR2(1)
)
;
comment on table SIGI_ESP_CAN_PRE_AE
  is 'Especialidades de los candidatos preseleccionados para el AE. ';
comment on column SIGI_ESP_CAN_PRE_AE.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_ESP_CAN_PRE_AE.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_ESP_CAN_PRE_AE.COD_OPC
  is 'Código de la opción para la que la persona esta preseleccionada o puede consultar su situación en lsitas';
comment on column SIGI_ESP_CAN_PRE_AE.COD_CUE
  is 'Cuerpo por el que esta preseleccionado';
comment on column SIGI_ESP_CAN_PRE_AE.COD_ESP
  is 'Especialidad por la que esta preseleccionado';
comment on column SIGI_ESP_CAN_PRE_AE.COD_PRO_1_SUS
  is 'Primera provincia en la que esta suspendido';
comment on column SIGI_ESP_CAN_PRE_AE.COD_PRO_2_SUS
  is 'Segunda provincia en la que esta suspendido';
comment on column SIGI_ESP_CAN_PRE_AE.L_LIS_SUS
  is 'Sí está, o no, suspendido en la lista . ';
alter table SIGI_ESP_CAN_PRE_AE
  add constraint SIGI_ESP_CAN_PRE_AE_PK primary key (TIPO_ID, DNI, COD_OPC, COD_CUE, COD_ESP);

prompt
prompt Creating table SIGI_EST_PET
prompt ===========================
prompt
create table SIGI_EST_PET
(
  COD_EST_PET VARCHAR2(1) not null,
  DES_EST_PET VARCHAR2(210) not null
)
;
comment on table SIGI_EST_PET
  is ' Estados posibles de una petición de vacante concreta. ';
comment on column SIGI_EST_PET.COD_EST_PET
  is ' Código del estado de la petición de vacante. ';
comment on column SIGI_EST_PET.DES_EST_PET
  is ' Descripción del estado de la petición de vacante. ';
alter table SIGI_EST_PET
  add constraint PK_EST_PET primary key (COD_EST_PET);

prompt
prompt Creating table SIGI_LIS
prompt =======================
prompt
create table SIGI_LIS
(
  COD_OPC       VARCHAR2(7) not null,
  TIPO_ID       VARCHAR2(1) not null,
  DNI           VARCHAR2(15) not null,
  COD_CUE       VARCHAR2(4) not null,
  COD_ESP       VARCHAR2(3) not null,
  TIP_LIS       VARCHAR2(10) not null,
  FEC_ORI_BLO   VARCHAR2(8) not null,
  COD_BLO       VARCHAR2(400) not null,
  NUM_ORD       NUMBER(4) not null,
  RES_TOT       NUMBER(6,4) not null,
  COD_EST       VARCHAR2(10) not null,
  DES_CAU_EST   VARCHAR2(150),
  FEC_INI_EST   DATE,
  DES_PRO_1_SUS VARCHAR2(8),
  FEC_PRO_1_SUS DATE,
  DES_PRO_2_SUS VARCHAR2(8),
  FEC_PRO_2_SUS DATE,
  ORD_DIS_ZA    VARCHAR2(4),
  ORD_DIS_HU    VARCHAR2(4),
  ORD_DIS_TE    VARCHAR2(4),
  ORD_CCAO      VARCHAR2(4),
  DES_PRO_REF   VARCHAR2(8),
  L_RES         VARCHAR2(2)
)
;
comment on table SIGI_LIS
  is 'Situación del Participante a nivel de listas';
comment on column SIGI_LIS.COD_OPC
  is 'Opción de sigi a la que pertenece la lista sigissp o sisipsp';
comment on column SIGI_LIS.COD_CUE
  is 'Cuerpo de la lista';
comment on column SIGI_LIS.COD_ESP
  is 'Especialidad de la lista';
comment on column SIGI_LIS.TIP_LIS
  is 'Tipo lista';
comment on column SIGI_LIS.FEC_ORI_BLO
  is 'Fecha de origen del bloque de la lista';
comment on column SIGI_LIS.COD_BLO
  is 'Secuencia bloque y descripción de bloque de la lsita ';
comment on column SIGI_LIS.NUM_ORD
  is 'Numero de orden en el bloque';
comment on column SIGI_LIS.COD_EST
  is 'Estado a nivel de lista';
comment on column SIGI_LIS.DES_CAU_EST
  is 'Descripción causa estado lista';
comment on column SIGI_LIS.FEC_INI_EST
  is 'Fecha inicio de estado en lista';
comment on column SIGI_LIS.DES_PRO_1_SUS
  is 'Descripción provincia suspensión 1';
comment on column SIGI_LIS.FEC_PRO_1_SUS
  is 'Fecha suspensión provincia 1';
comment on column SIGI_LIS.DES_PRO_2_SUS
  is 'Descripción provincia suspensión 2';
comment on column SIGI_LIS.FEC_PRO_2_SUS
  is 'Fecha suspensión provincia 1';
comment on column SIGI_LIS.ORD_DIS_ZA
  is 'Número de orden de disponibilidad para vacantes en Zaragoza';
comment on column SIGI_LIS.ORD_DIS_HU
  is 'Número de orden de disponibilidad para vacantes en Huesca';
comment on column SIGI_LIS.ORD_DIS_TE
  is 'Número de orden de disponibilidad para vacantes en Teruel';
comment on column SIGI_LIS.ORD_CCAO
  is 'Número de orden de disponibilidad para vacantes de Curso Completo de AceptaciÃ³n Obligatoria';
comment on column SIGI_LIS.DES_PRO_REF
  is 'Descripción provincia de refenencia';
comment on column SIGI_LIS.L_RES
  is 'Si se reserva o no ';
alter table SIGI_LIS
  add constraint SIGI_LIS_PK primary key (COD_OPC, TIPO_ID, DNI, COD_CUE, COD_ESP, TIP_LIS, FEC_ORI_BLO, COD_BLO, COD_EST);

prompt
prompt Creating table SIGI_OPC
prompt =======================
prompt
create table SIGI_OPC
(
  COD_OPC       VARCHAR2(7) not null,
  F_CON_AE      DATE,
  COD_TIP_AE    VARCHAR2(1),
  TEX_OPC       VARCHAR2(200) not null,
  TEX_OPC_CAB   VARCHAR2(200) not null,
  TEX_OPC_PDF   VARCHAR2(200),
  FEC_CUR_COM   VARCHAR2(10),
  L_VIS         VARCHAR2(1) not null,
  L_ACT         VARCHAR2(1) not null,
  L_PET_MAS     VARCHAR2(1),
  L_RES_VIS     VARCHAR2(1),
  L_RES_ACT     VARCHAR2(1),
  F_INI_OPC     DATE not null,
  F_FIN_OPC     DATE not null,
  C_USU_ULT_MOD VARCHAR2(8) not null,
  F_ULT_MOD     DATE not null
)
;
comment on table SIGI_OPC
  is 'Opciones existentes para gestión de interinos ';
comment on column SIGI_OPC.COD_OPC
  is 'Código de la opción sigissp, sigipsp, sigisae, sigipae';
comment on column SIGI_OPC.TEX_OPC
  is 'Texto de la opción ';
comment on column SIGI_OPC.TEX_OPC_CAB
  is 'Texto de la opción en la cabecera de la página web ';
comment on column SIGI_OPC.TEX_OPC_PDF
  is 'Texto de la opción en el pdf a imprimir';
comment on column SIGI_OPC.FEC_CUR_COM
  is 'Fecha hasta la que se consideran vacantes de curso completo';
comment on column SIGI_OPC.L_VIS
  is 'Si la opción esta visible';
comment on column SIGI_OPC.L_ACT
  is 'Si la opción esta activa';
comment on column SIGI_OPC.L_PET_MAS
  is 'Si la opción soporta petición masiva de vacantes';
comment on column SIGI_OPC.L_RES_VIS
  is 'Si la opción soporta reserva';
comment on column SIGI_OPC.L_RES_ACT
  is 'Si la opción tiene la opción de reserva activa';
comment on column SIGI_OPC.F_INI_OPC
  is 'Fecha inicio de la opción';
comment on column SIGI_OPC.F_FIN_OPC
  is 'Fecha fin de la opción';
comment on column SIGI_OPC.C_USU_ULT_MOD
  is 'Usuario que realiza la última modificación';
comment on column SIGI_OPC.F_ULT_MOD
  is 'Fecha de la última modificación';
alter table SIGI_OPC
  add constraint PK_SIGI_OPC primary key (COD_OPC);

prompt
prompt Creating table SIGI_PAR
prompt =======================
prompt
create table SIGI_PAR
(
  TIPO_ID         VARCHAR2(1) not null,
  DNI             VARCHAR2(15) not null,
  COD_OPC         VARCHAR2(7) not null,
  EST_PER         VARCHAR2(10),
  DES_CAU_EST_PER VARCHAR2(177),
  F_INI_PER       DATE
)
;
comment on table SIGI_PAR
  is ' Situación de los interinos a nivel de participante ';
comment on column SIGI_PAR.TIPO_ID
  is ' Tipo de Identificador del participante. ';
comment on column SIGI_PAR.DNI
  is ' Dni del participante. ';
comment on column SIGI_PAR.COD_OPC
  is 'Código de la opción para la que  puede consultar su situación en lsitas';
comment on column SIGI_PAR.EST_PER
  is 'Estado de la persona';
comment on column SIGI_PAR.DES_CAU_EST_PER
  is 'Descripción de la causa de estado de la persona';
comment on column SIGI_PAR.F_INI_PER
  is 'Fecha de inicio del estado';
alter table SIGI_PAR
  add constraint PK_SIGI_PAR primary key (TIPO_ID, DNI, COD_OPC);

prompt
prompt Creating table SIGI_PAR_APL
prompt ===========================
prompt
create table SIGI_PAR_APL
(
  NOM_PAR VARCHAR2(25 BYTE) not null,
  VAL_PAR VARCHAR2(60 BYTE) not null,
  FOR_PAR VARCHAR2(20),
  DES_PAR VARCHAR2(200)
)
;
comment on table SIGI_PAR_APL
  is 'Parametros de la aplicación SIGI';
comment on column SIGI_PAR_APL.NOM_PAR
  is 'Nombre del parámetro';
comment on column SIGI_PAR_APL.VAL_PAR
  is 'Valor del parámetro';
comment on column SIGI_PAR_APL.FOR_PAR
  is 'Formato del parámetro';
comment on column SIGI_PAR_APL.DES_PAR
  is 'Descripción del parámetro';
alter table SIGI_PAR_APL
  add constraint SIGI_PARAM_AP_PK primary key (NOM_PAR);

prompt
prompt Creating table SIGI_PER
prompt =======================
prompt
create table SIGI_PER
(
  DNI     VARCHAR2(15) not null,
  TIPO_ID VARCHAR2(1) not null,
  F_NAC   DATE not null,
  NOM     VARCHAR2(14),
  APE_1   VARCHAR2(22),
  APE_2   VARCHAR2(22)
)
;
comment on table SIGI_PER
  is ' Persona que esta preseleccionada ';
comment on column SIGI_PER.DNI
  is ' DNI de la persona';
comment on column SIGI_PER.TIPO_ID
  is ' Tipo de identificador de la persona';
comment on column SIGI_PER.F_NAC
  is ' Fecha de nacimiento de la persona';
comment on column SIGI_PER.NOM
  is ' Nombre de la persona';
comment on column SIGI_PER.APE_1
  is ' Primer apellido de la persona';
comment on column SIGI_PER.APE_2
  is ' Segundo apellido de la persona';
alter table SIGI_PER
  add constraint SIGI_PAR_PK primary key (DNI, TIPO_ID);

prompt
prompt Creating table SIGI_SOL
prompt =======================
prompt
create table SIGI_SOL
(
  TIPO_ID     VARCHAR2(1) not null,
  DNI         VARCHAR2(15) not null,
  COD_OPC     VARCHAR2(7) not null,
  COD_SOL     VARCHAR2(4) not null,
  F_HOR_ENT   DATE not null,
  COD_EST_SOL VARCHAR2(1) not null,
  COD_USU     VARCHAR2(8) not null,
  F_HOR_PRE   DATE,
  L_PRE       VARCHAR2(1)
)
;
comment on table SIGI_SOL
  is ' Solicitudes de vacantes realizadas por candidatos preseleccionados. ';
comment on column SIGI_SOL.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_SOL.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_SOL.COD_SOL
  is ' Código de solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL.F_HOR_ENT
  is ' Fecha y Hora en que el preseleccionado entrega la Solicitud. ';
comment on column SIGI_SOL.COD_EST_SOL
  is ' Estado en el que se encuentra la Solicitud (A - Admitida, E - Excluida, P - Presentada).';
comment on column SIGI_SOL.COD_USU
  is ' Usuario que ha realizado la última modificación del registro. ';
comment on column SIGI_SOL.F_HOR_PRE
  is 'Fecha y hora en la que se presenta la solicitud con contraseña al acto de elección ';
comment on column SIGI_SOL.L_PRE
  is 'Indicador de solicitud presentada con contraseña al acto de elección (N- no presentada, S - si presentada)';
alter table SIGI_SOL
  add constraint PK_SIGI_SOL primary key (TIPO_ID, DNI, COD_OPC, COD_SOL);
alter table SIGI_SOL
  add constraint CK_SOLAE_EST_SOL
  check (COD_EST_SOL IN ('A','E'));

prompt
prompt Creating table SIGI_PET
prompt =======================
prompt
create table SIGI_PET
(
  TIPO_ID     VARCHAR2(1) not null,
  DNI         VARCHAR2(15) not null,
  COD_OPC     VARCHAR2(7) not null,
  COD_SOL     VARCHAR2(4) not null,
  NUM_VAC     NUMBER(4) not null,
  ORD_PRE     NUMBER(4) not null,
  COD_EST_PET VARCHAR2(1) not null
)
;
comment on table SIGI_PET
  is ' Peticiones de vacantes incluidas en cada solicitud. ';
comment on column SIGI_PET.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_PET.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_PET.COD_SOL
  is ' Código de solicitud de ese candidato para este Acto de Elección. ';
comment on column SIGI_PET.NUM_VAC
  is ' Número identificativo de la vacante dentro del curso academico. ';
comment on column SIGI_PET.ORD_PRE
  is ' Número de orden de preferencia con el que pide la vacante del AE. ';
comment on column SIGI_PET.COD_EST_PET
  is ' Código de estado de la petición de vacante concreta .';
alter table SIGI_PET
  add constraint PK_PET primary key (TIPO_ID, DNI, COD_OPC, NUM_VAC, COD_SOL);
alter table SIGI_PET
  add constraint FK_SP_SOAEI foreign key (TIPO_ID, DNI, COD_OPC, COD_SOL)
  references SIGI_SOL (TIPO_ID, DNI, COD_OPC, COD_SOL);

prompt
prompt Creating table SIGI_PET_ESP
prompt ===========================
prompt
create table SIGI_PET_ESP
(
  TIPO_ID VARCHAR2(1) not null,
  DNI     VARCHAR2(15) not null,
  COD_OPC VARCHAR2(7) not null,
  COD_SOL VARCHAR2(4) not null,
  COD_CUE VARCHAR2(4) not null,
  COD_ESP VARCHAR2(3) not null,
  ORD_ESP NUMBER not null
)
;
comment on table SIGI_PET_ESP
  is 'Peticiones de vacantes por especialidad.';
comment on column SIGI_PET_ESP.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_PET_ESP.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_PET_ESP.COD_SOL
  is 'Código de solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_PET_ESP.COD_CUE
  is ' Código del cuerpo por la que se piden todas las vacantes obligatorias. ';
comment on column SIGI_PET_ESP.COD_ESP
  is ' Código de la especialidad por la que se piden todas las vacantes obligatorias. ';
comment on column SIGI_PET_ESP.ORD_ESP
  is 'Número de preferencia de la especialidad.';
alter table SIGI_PET_ESP
  add constraint PK_SIGI_PET_ESP primary key (TIPO_ID, DNI, COD_OPC, COD_CUE, COD_ESP, COD_SOL);

prompt
prompt Creating table SIGI_PET_PRO
prompt ===========================
prompt
create table SIGI_PET_PRO
(
  TIPO_ID VARCHAR2(1) not null,
  DNI     VARCHAR2(15) not null,
  COD_OPC VARCHAR2(7) not null,
  COD_SOL VARCHAR2(4) not null,
  COD_PRO VARCHAR2(2) not null,
  ORD_PRO NUMBER(1) not null
)
;
comment on table SIGI_PET_PRO
  is 'Peticiones de vacantes por provincia.';
comment on column SIGI_PET_PRO.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_PET_PRO.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_PET_PRO.COD_SOL
  is 'Código de solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_PET_PRO.COD_PRO
  is ' Código de la provincia por la que se piden todas las vacantes obligatorias. ';
comment on column SIGI_PET_PRO.ORD_PRO
  is ' Número de preferencia de la provincia. ';
alter table SIGI_PET_PRO
  add constraint PK_SIGI_PET_PRO primary key (TIPO_ID, DNI, COD_OPC, COD_PRO, COD_SOL);

prompt
prompt Creating table SIGI_RES
prompt =======================
prompt
create table SIGI_RES
(
  TIPO_ID     VARCHAR2(1) not null,
  DNI         VARCHAR2(15) not null,
  COD_OPC     VARCHAR2(7) not null,
  COD_SOL     VARCHAR2(4) not null,
  COD_EST_RES VARCHAR2(1) not null
)
;
comment on table SIGI_RES
  is 'Reservas ejercidas en solicitudes de AE de Inicio de Curso.';
comment on column SIGI_RES.TIPO_ID
  is ' Tipo de identificador del candidato preseleccionado. ';
comment on column SIGI_RES.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_RES.COD_SOL
  is 'Código de solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_RES.COD_EST_RES
  is ' Código de estado de la reserva. ';
alter table SIGI_RES
  add constraint PK_RES primary key (TIPO_ID, DNI, COD_OPC, COD_SOL);

prompt
prompt Creating table SIGI_SOL_REG
prompt ===========================
prompt
create table SIGI_SOL_REG
(
  TIPO_ID   VARCHAR2(1) not null,
  DNI       VARCHAR2(15) not null,
  COD_OPC   VARCHAR2(7) not null,
  COD_SOL   VARCHAR2(4) not null,
  COD_ASI   VARCHAR2(200),
  REC       CLOB,
  DET_FIR   CLOB,
  FOR_FIR   VARCHAR2(200),
  MIME_TIP  VARCHAR2(200),
  F_HOR_ENT DATE,
  CSV       VARCHAR2(200),
  COD_USU   VARCHAR2(8) not null,
  F_ULT_MOD DATE not null
)
;
comment on table SIGI_SOL_REG
  is ' Solicitudes en e-registro realizadas por candidatos preseleccionados. ';
comment on column SIGI_SOL_REG.TIPO_ID
  is ' Tipo de Identificador del candidato preseleccionado. ';
comment on column SIGI_SOL_REG.DNI
  is ' Dni del candidato preseleccionado. ';
comment on column SIGI_SOL_REG.COD_SOL
  is ' Código de solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.COD_ASI
  is ' Código del asiento del e-registro de la solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.REC
  is ' Recibo del e-registro de la solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.DET_FIR
  is ' Detached_signature devuelto por el e-registro de la solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.FOR_FIR
  is ' Format_signature devuelto por el e-registro de la solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.MIME_TIP
  is ' Mime_Type devuelto por el e-registro de la solicitud de ese candidato para este Acto de Elección.';
comment on column SIGI_SOL_REG.F_HOR_ENT
  is ' Fecha y Hora en que el preseleccionado registra la Solicitud en e-registro ';
comment on column SIGI_SOL_REG.CSV
  is ' Código Seguro de Verificaciónn devuelto por el e-registro de la solicitud de ese candidato para este Acto de Elección';
comment on column SIGI_SOL_REG.COD_USU
  is ' Usuario que ha realizado la última modificación del registro. ';
comment on column SIGI_SOL_REG.F_ULT_MOD
  is ' Fecha en que se ha realizado la última modificación del registro. ';
alter table SIGI_SOL_REG
  add constraint PK_SIGI_SOL_REG primary key (COD_OPC, TIPO_ID, DNI, COD_SOL);
alter table SIGI_SOL_REG
  add constraint FK_SOL_REG_CAN_PRE foreign key (TIPO_ID, DNI, COD_OPC)
  references SIGI_CAN_PRE_AE (TIPO_ID, DNI, COD_OPC);

prompt
prompt Creating table SIGI_VAC
prompt =======================
prompt
create table SIGI_VAC
(
  COD_OPC     VARCHAR2(7) not null,
  NUM_VAC     NUMBER(4) not null,
  COD_CUE     VARCHAR2(4) not null,
  COD_ESP     VARCHAR2(3) not null,
  COD_MUN_VAC VARCHAR2(9) not null,
  COD_TIP_DUR VARCHAR2(1) not null
)
;
comment on table SIGI_VAC
  is ' Vacantes ofertadas en Acto de Elección. ';
comment on column SIGI_VAC.NUM_VAC
  is ' Número identificativo de la vacante dentro del curso academico. ';
comment on column SIGI_VAC.COD_CUE
  is ' Código del cuerpo al que corresponde la vacante.  ';
comment on column SIGI_VAC.COD_ESP
  is ' Código de la especialidad a la que corresponde la vacante.  ';
comment on column SIGI_VAC.COD_MUN_VAC
  is ' Municipio / Localidad (a partir de 2012) en el que ha estado ocupando plaza el participante. ';
comment on column SIGI_VAC.COD_TIP_DUR
  is ' Código del tipo de Duración de la vacante.';
alter table SIGI_VAC
  add constraint PK_SIGI_VAC primary key (COD_OPC, NUM_VAC);


spool off
