CREATE OR REPLACE PACKAGE PKB_SIT_PAR_old AS
  -- Author  : Patricia
  -- Created : 13/08/2008
  -- Purpose : Implementar la l�gica de negocio de la aplicaci�n Web que servir� para consultar
  --           la SITuaci�n del PARticipante

  -- Comprobar si est� operativa la Aplicaci�n y consultar la fecha de replica de datos
  Procedure PreLogin(f_replica out VARCHAR2,
                     d_titulo1 out varchar2,
                     n_campo   out number,
                     retorno   out varchar2);
  -- Validaci�n del Login del usuario
  Procedure Login(sit_per in out SP_SIT_PER,
                  sit_lis out SP_ARRAY_SIT_LIS,
                  F_CCAO  out varchar2,
                  n_campo out number, -- (0,1,2,3)
                  -- 0 = OK.
                  -- 1 = Es necesario dni y contrase�a.
                  -- 2 = Participante no convocado o mal identificado.
                  -- 3 = Errores de Base de Datos.
                  retorno out varchar2);

END PKB_SIT_PAR_old;
/

