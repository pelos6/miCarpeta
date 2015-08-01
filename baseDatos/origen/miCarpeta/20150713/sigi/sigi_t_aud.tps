CREATE OR REPLACE TYPE "SIGI_T_AUD" AS object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que contiene la información a grabar en la auditoria
  tipo_id varchar2(1),
  dni varchar2(15),
  val_1 varchar2(4000),
  val_2 varchar2(4000)
)
/

