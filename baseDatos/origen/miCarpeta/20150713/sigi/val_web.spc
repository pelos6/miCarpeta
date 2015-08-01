create or replace package VAL_WEB is
  -- Author  : Javier Iranzo
  -- Created : 19/02/2008
  -- Purpose : Paquete que gestiona la aplicación Web SIGIP06
  -- Modificado: 20/08/2012
  -- Purpose : Al modificar la aplicación por normas AST no se permiten
  --             consultas directas a base de datos
  /*********************************************************************/
  -- Procedure Ini(p_titulo1 out varchar2);
  -- prelogin
  Procedure Ini(p_titulo1 out varchar2,
                avi_con   out varchar2,
                avi_leg   out varchar2);
  -- login
  Procedure Val_par(p_partic ae_reg_partic,
                    param2   out number,
                    param3   out varchar2,
                    param4   out varchar2);
  -- save
  Procedure Val_sol(param1   varchar2,
                    p_partic ae_reg_partic,
                    p_petic  in ae_reg_aux,
                    p_solic  in out ae_array_vac,
                    perror1  out number,
                    perror2  out varchar2);
  -- search
  Procedure bus_sol(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    l_sol     out varchar2,
                    cod_err   out number,
                    men_err   out varchar2);
  -- load_peticiones
  Procedure car_pet(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_pet     out ae_array_vac,
                    cod_err   out number,
                    men_err   out varchar2);
  -- load_reserva                   
  Procedure car_res(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    l_res     out varchar2,
                    cod_err   out number,
                    men_err   out varchar2);
  -- load_prov
  Procedure car_pro(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_pro     out ae_reg_pro,
                    cod_err   out number,
                    men_err   out varchar2);
  -- load_espec
  Procedure car_esp(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_esp     out ae_reg_esp,
                    cod_err   out number,
                    men_err   out varchar2);
  -- especialidades_user
  Procedure esp_pre(p_par   ae_reg_partic,
                    p_esp   out ae_reg_esp,
                    cod_err out number,
                    men_err out varchar2);
  -- load_codetable
  Procedure car_est_pet(p_est out ae_array_est_pet,
                    cod_err out number,
                    men_err out varchar2);
  -- titles ver_res_prov_espec ver_opc_reserva
  Procedure car_act(p_ae out ae_reg_ae,
                    cod_err   out number,
                    men_err   out varchar2);
end VAL_WEB;
/

