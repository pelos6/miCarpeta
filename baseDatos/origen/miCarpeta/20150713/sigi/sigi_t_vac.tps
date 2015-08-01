CREATE OR REPLACE TYPE "SIGI_T_VAC" AS object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que contiene la vacante que ha pedido
  npos     varchar(3),
  cvacante varchar(4), --  representa el entero sin letra que identifica la vacante
  cerror   varchar2(2)
)
/

