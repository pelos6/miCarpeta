CREATE OR REPLACE TYPE "SP_SIT_PER"
as object
(
  -- Created : 05/08/2008
  -- Purpose : Tipo de dato que contiene la información a nivel de PERsona para
  --           informar la SITuación del Participante.

 TIPO_ID            VARCHAR2(1),
 DNI                VARCHAR2(15),
 PASSWORD           VARCHAR2(20),
 REEN_PASSWORD      VARCHAR2(1),
 APE1               VARCHAR2(22),
 APE2               VARCHAR2(22),
 NOMBRE             VARCHAR2(14),
 F_INI_PER          VARCHAR2(10),  -- Originalmente es DATE --
 EST_PER            VARCHAR2(10),
 D_CAUSA_EST_PER    VARCHAR2(200),  --  Descripción del estado de la persona
                                   --  incluye información de la vacante ocupada
                                   --  si esta contratado como interino
 l_DNI_E              VARCHAR2(1)  --   Si se ha logeado con dni electrónico
)
/

