CREATE OR REPLACE TYPE "AE_REG_AUD" AS object
(
  tipo_id varchar2(1),
  dni varchar2(15),
  modo varchar2(1),
  cod_ses varchar2(30), -- se puede sustituir
  ip varchar2(40),-- se puede sustituir
  val_1 varchar2(4000),
  val_2 varchar2(4000)
)
/

