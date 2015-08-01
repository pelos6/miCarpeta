create or replace package sigi_pck is
  /*************************************************************************************************/
  -- Author  : JIRANZO
  -- Created : 16/11/2012 10:16:24
  -- Purpose : Paquete que unifica los paquetes usados en SIGISSP, SIGIPSP, SIGIS06, SIGIP06
  --   que pasa a ser ahora SIGI
  -- Tratamiento de errores. Campos cod_men y men
  -- cod_err :
  -- 0 = OK.
  -- 1 = Es necesario dni y contraseña.
  -- 2 = Participante no convocado o mal identificado.
  -- 3 = Aplicación cerrada.
  -- 4 = Estado no controlado de la aplicación.
  -- 5 = Errores de Base de Datos. (when others)
  -- 6 = Código de solicitud (o de parametro) no encontrado.
  -- 7 = Se quiere guardar sin cambios.
  -- 8 = Error en las peticiones de vacantes
  -- 9 = Error forzado desde BBDD para mostrar el texto en retorno
  -- men_err : mensaje del error
  /*************************************************************************************************/
  -- INIcio de la aplicación: TITulo de la aplicación.
  -- Texto con AVIso CONsejo de uso
  -- AVIso LEGal,
  -- si se usa o no E_ADMimistración
 -- si se usa o no fecha de nacimiento para login
  Procedure ini(v_tit   out varchar2,
                avi_con out varchar2,
                avi_leg out varchar2,
                l_e_adm out varchar2,
                l_e_fec_nac out varchar2,
                cod_men out number,
                men     out varchar2);

  -- Validación del LOGin del usuario
  -- ARRay de OPCiones a usar segun la PERsona LOGedada
  Procedure log(v_per     in out sigi_t_per,
                v_arr_opc out sigi_array_opc,
                cod_men   out number,
                men       out varchar2);
  -- CARga por la OPCcion seleccionada la información relevante para esa opción de la PERsona logeada
  Procedure car_opc(v_per         in out SIGI_T_PER,
                    v_arr_opc     in sigi_array_opc,
                    v_arr_lis     out sigi_array_lis,
                    v_arr_esp     out sigi_array_esp_par,
                    v_arr_vac_par out sigi_array_vac_par,
                    cod_men       out number,
                    men           out varchar2);
  -- BUSca la SOLicitud de la PERsona en la OPCión seleccionada.
  -- si la encuentra carga la SOLicitud si no cod_men
  Procedure bus_sol(v_per     in SIGI_T_PER,
                    v_cod_sol in varchar2,
                    v_sol     out sigi_t_sol,
                    v_arr_opc in sigi_array_opc,
                    v_pre_ae  out varchar2,
                    cod_men   out number,
                    men       out varchar2);

  Procedure val_sol(v_per         in SIGI_T_PER,
                    v_cod_sol_mod in varchar2,
                    v_cod_sol_nue out varchar2,
                    v_sol         in out sigi_t_sol,
                    v_arr_opc     in sigi_array_opc,
                    v_pre_ae      out varchar2,
                    cod_men       out number,
                    men           out varchar2);

  Procedure car_est_pet(p_est   out sigi_array_est_pet,
                        cod_men out number,
                        men     out varchar2);
  -- Pdf mandado desde base de datos
  procedure lis_pdf(v_per     in SIGI_T_PER,
                    v_arr_opc in sigi_array_opc,
                    tex_tit   out varchar2,
                    tex_pdf   out clob,
                    cod_men   out number,
                    men       out varchar2);
  -- save_registro
  Procedure gra_reg_tel(v_per     SIGI_T_PER,
                        v_cod_sol sigi_sol.cod_sol%type,
                        p_reg     sigi_t_reg_tel,
                        v_arr_opc sigi_array_opc,
                        cod_men   out number,
                        men       out varchar2);
  -- busca el registro grabado
  Procedure car_reg_tel(v_per     SIGI_T_PER,
                        v_cod_sol sigi_sol.cod_sol%type,
                        v_arr_opc in sigi_array_opc,
                        p_reg     out sigi_t_reg_tel,
                        cod_men   out number,
                        men       out varchar2);

  /*******************************************************/
  /** Procedimiento PRE sentar SOL icitud AE            **/
  /*******************************************************/
  Procedure pre_sol_ae(p_per     in sigi_t_per,
                       p_cod_sol in sigi_sol.cod_sol%type,
                       p_sol     in out sigi_t_sol,
                       p_arr_opc in sigi_array_opc,
                       cod_men   out number,
                       men       out varchar2);
  -- privados a quitar cuando no sea necesario su depuración
  function f_opc_cerrada(v_opc   sigi_opc.cod_opc%type,
                         cod_men out number,
                         men     out varchar2) return boolean;

end sigi_pck;
/

