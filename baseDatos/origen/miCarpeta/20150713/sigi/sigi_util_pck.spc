create or replace package sigi_util_pck is
  -- INS erta un INT erino en las OPC iones marcadas
  procedure ins_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2);
  -- BOR ra un INT erino en las OPC iones marcadas
  procedure bor_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2);
  -- MUE stra los datos para un INT erino por OPC iones
  procedure mue_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2);
  /*
  javier 12/06/2015
  para probar los actos de elección de inicio de curso con contraseña:
  pone una solicitud de algunos solicitantes a l_pre S 
  */
  procedure gra_sol_l_pre;
end sigi_util_pck;
/

