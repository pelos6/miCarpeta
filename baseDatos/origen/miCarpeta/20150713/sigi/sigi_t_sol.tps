CREATE OR REPLACE TYPE "SIGI_T_SOL" AS object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que contiene la solicitud
  cvac    sigi_array_vac, --   cvac array de vacantes
  cesp     sigi_array_esp, --   cesp array de especialidades (petici�n masiva)
  cpro     sigi_array_pro, --   cpro array de provincias (petici�n masiva)
  l_res    varchar2(1),        -- si la persona se reserva o no
  l_reg_tel varchar2(1),        -- si la solicitud se presento o no en REG istro TEL em�tico
  l_pre_ae varchar2(1),         -- si la solicitud se ha presentado o no al acto de elecci�n(con contrase�a)
  f_pre_ae varchar2(20)         -- la fecha en la que se ha presentado al acto de elecci�n
)
/

