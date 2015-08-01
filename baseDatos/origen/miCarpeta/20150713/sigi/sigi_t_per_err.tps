CREATE OR REPLACE TYPE "SIGI_T_PER_ERR" as object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que contiene la información de los interinos a nivel de persona
  TIPO_ID     VARCHAR2(1),
  DNI         VARCHAR2(15),
  PAS         VARCHAR2(20),
  APE_1       VARCHAR2(22),
  APE_2       VARCHAR2(22),
  NOM         VARCHAR2(14),
  F_NAC       VARCHAR2(10),
  DOM_SRT     VARCHAR2(100), -- El domicilio que se mete en Registro telemático
  COR_ELE     VARCHAR2(100), -- la cuenta de correo electrónico
  F_REP       VARCHAR2(20),
 F_INI_PER          VARCHAR2(10),
 EST_PER            VARCHAR2(10),
 D_CAUSA_EST_PER    VARCHAR2(200),  --  Descripción del estado de la persona
                                   --  incluye información de la vacante ocupada
                                   --  si esta contratado como interino
  L_CER          varchar2(1) -- Si se logea con CERtificado digital  ?S? o ?N?
)
/

