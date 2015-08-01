CREATE OR REPLACE TYPE "SIGI_T_OPC"  as object
(
-- Created : 25/11/2012
-- Purpose : Tipo de dato que describe una opci�n a seleccionar o seleccionada (acto de eleccion pri o sec, consulta situaci�n participante pri o sec)
COD_OPC               VARCHAR2(10), --  sigissp, sisipsp, sigisae, sigipae
TEX_OPC               VARCHAR2(200), -- Texto del menu a mostrar
TEX_OPC_CAB               VARCHAR2(200), -- Texto de la opci�n a mostrar en la CABecera de la p�gina web
TEX_OPC_PDF               VARCHAR2(200), -- Texto de la opci�n a mostrar en el PDF a mostrar
FEC_CUR_COM    VARCHAR2(10), -- FECha hasta la que se consideran vacantes de CURso COMpleto de aceptaci�n obligatoria FCCAO
L_VIS         VARCHAR2(1), --  Si es visible o no la opci�n de men�
L_ACT         VARCHAR2(1), --  Si esta activa o no la opci�n de men�
L_PET_MAS VARCHAR2(1), --  Si el acto de elecci�n tiene peticiones masivas (por provincia y especialidad)
L_RES_VIS VARCHAR2(1), --  Si el acto de elecci�n tiene la opci�n de reserva visible
L_RES_ACT VARCHAR2(1), --  Si el acto de elecci�n tiene la opci�n de reserva activa
L_SEL           VARCHAR2(1)) --  Si la opci�n ha sido seleccionado o no)
/

