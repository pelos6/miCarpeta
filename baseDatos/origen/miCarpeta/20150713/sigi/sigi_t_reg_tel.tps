CREATE OR REPLACE TYPE SIGI_T_REG_TEL AS object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que contiene la información devuelta por registro telemático
  cod_asi   varchar2(200), -- idAsiento
  rec         CLOB, --  receipt (recibo)
  det_fir       CLOB, --  detachedSignatura
  for_fir       varchar2(200), -- formatSignatura
  mime_tip     varchar2(200) ,             -- mimeType
  fec         date ,                -- fecha
  csv        varchar2(200)                  -- csv
)
/

