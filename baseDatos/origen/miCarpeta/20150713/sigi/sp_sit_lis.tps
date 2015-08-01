CREATE OR REPLACE TYPE "SP_SIT_LIS"    as object
(
  -- Created : 05/08/2008
  -- Purpose : Tipo de dato que contiene la información a nivel de LISta para
  --           informar la SITuación del Participante.

 DES_CUE              VARCHAR2(100),
 DES_ESP              VARCHAR2(100),
 TIP_LIS            VARCHAR2(10),
 FEC_ORI_BLO           VARCHAR2(10),   -- Fecha de origén de la lista
 DES_BLO              VARCHAR2(155), -- Secuencia bloque y descripción del mismo
 NUM_ORD_BLO          VARCHAR2(4) ,  -- Posición dentro del bloque
  PUN                VARCHAR2(7),   -- Puntuación
 PRO_REF            VARCHAR2(10),  -- Provincia de referencia
 DES_EST              VARCHAR2(10),  -- Estado a nivel de lista
 DES_CAU_EST          VARCHAR2(150), -- Descripción de la causa del estado
 FEC_EST_LIS          VARCHAR2(10),   -- Fecha del estado en lista
 DES_PRO_SUS_1        VARCHAR2(10),  -- Provincia 1 en la que esta suspendido
 FEC_PRO_SUS_1        VARCHAR2(10),   -- Fecha de suspensión en la provincia 1
 DES_PRO_SUS_2        VARCHAR2(10),  -- Provincia 2 en la que esta suspendido
 FEC_PRO_SUS_2        VARCHAR2(10),   -- Fecha de suspensión en la provincia 2
 NUM_ORD_DIS_ZA    VARCHAR2(4),   -- Número de orden de disponibilidad para vacantes Zaragoza
 NUM_ORD_DIS_HU    VARCHAR2(4),   -- Número de orden de disponibilidad para vacantes Huesca
 NUM_ORD_DIS_TE    VARCHAR2(4),   -- Número de orden de disponibilidad para vacantes Teruel
 NUM_ORD_CCAO       VARCHAR2(4)    -- Número de orden de disponibilidad para vacantes
                                   -- de Curso Completo de Aceptación Obligatoria
)
/

