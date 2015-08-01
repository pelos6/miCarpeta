CREATE OR REPLACE PACKAGE PKB_SIT_PAR AS
  -- Author  : Patricia 
  -- Created : 13/08/2008
  -- Purpose : Implementar la l�gica de negocio de la aplicaci�n Web que servir� para consultar
  --           la SITuaci�n del PARticipante

  -- Comprobar si est� operativa la Aplicaci�n y consultar la fecha de replica de datos
  -- avi_con AVIso sobre si se puede pasar sin CONtrase�a
  -- avi_leg AVIso LEGal sobre la ley de protecci�n de datos de caracter personal
/*  Procedure PreLogin(v_fec_rep out VARCHAR2,
                     d_titulo1 out varchar2,
                     avi_con   out varchar2,
                     avi_leg   out varchar2,
                     n_campo   out number,
                     retorno   out varchar2);*/
  Procedure PreLogin(v_fec_rep out VARCHAR2,
                     d_titulo1 out varchar2,
                     avi_con   out varchar2,
                     avi_leg   out varchar2,
                     n_campo   out number,
                     retorno   out varchar2);
  -- Validaci�n del Login del usuario
  Procedure Login(sit_per in out SP_SIT_PER,
                  sit_lis out SP_ARRAY_SIT_LIS,
                  v_fccao  out varchar2,
                  n_campo out number, -- (0,1,2,3,4,5)
                  -- 0 = OK.
                  -- 1 = Es necesario dni y contrase�a.
                  -- 2 = Participante no convocado o mal identificado.
                  -- 3 = Errores de Base de Datos.
                  -- 5 = Tramitaci�n reenvio de password.
                  retorno out varchar2);
  -- Pdf mandado desde base de datos
  procedure lis_pdf(d_per in SP_SIT_PER, 
                      tex_tit  out varchar2, 
                      tex_pdf  out clob,
                      n_campo  out number, 
                      retorno out varchar2);                  

END PKB_SIT_PAR;
/

