CREATE OR REPLACE TYPE "SP_SIT_HAB" as object
(
  -- Created : 05/08/2008
  -- Purpose : Tipo de dato que contiene la informaci�n de la
  --           SITuaci�n de las HABilitaciones del participante

 D_ESP_HAB          VARCHAR2(75),  -- Espscialidad que le habilita
 F_DESDE_HAB        VARCHAR2(10),   -- Fecha desde la que tiene la habilitaci�n
 N_ORDEN_DISP_ZA    VARCHAR2(4),   -- N�mero de orden de disponibilidad para vacantes Zaragoza
 N_ORDEN_DISP_HU    VARCHAR2(4),   -- N�mero de orden de disponibilidad para vacantes Huesca
 N_ORDEN_DISP_TE    VARCHAR2(4),   -- N�mero de orden de disponibilidad para vacantes Teruel
 N_ORDEN_CCAO       VARCHAR2(4)    -- N�mero de orden de disponibilidad para vacantes
                                   -- de Curso Completo de Aceptaci�n Obligatoria
)
/

