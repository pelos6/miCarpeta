create or replace package body VAL_WEB is
  /***********************************************************************************************
  returns the IP 
  Autor : Quique Comex
   *************************************************************************************************/
function f_IP RETURN Varchar2 IS
Begin
  /*Select SYS_CONTEXT('USERENV','IP_ADDRESS') 
  Into v_ip 
  From Dual; 
  Return v_ip; */
  return(SYS_CONTEXT('USERENV', 'IP_ADDRESS'));
End;
/************************************************/
/** procedimiento genera la CARga del CODigo de SESion **/
/** es por usuario y sesion web o uso un token que me den */
/*  desde la web o genero yo uno    */
/************************************************/
function car_cod_ses return varchar2 is
  v_cod_Ses varchar2(100);
begin
  --select userenv('sessionid') into v_cod_ses from dual;
  --select userenv('sid') into v_cod_ses from dual;
  select DBMS_SESSION.UNIQUE_SESSION_ID into v_cod_ses  from dual;
  return v_cod_ses;
end;

  function pro_lin(p_user   varchar, -- Propietario del objeto
                   p_name   varchar, -- Nombre del objeto
                   p_linea  number, -- Línea de error
                   p_cadena in out varchar -- Texto de la linea procesado
                   ) return varchar2 is
    -- Devuelve el nombre del procedimiento
    v_cadena_aux varchar2(4000);
    v_pos_ini    number;
    v_pos_fin    number;
  begin
    -- Comprobamos que no es un comentario de línea y quitamos la parte comentada
    p_cadena := case when instr(p_cadena, '--') > 0 then substr(p_cadena, 1, instr(p_cadena, '--') - 1) else p_cadena end;
    -- Comprobamos que no es un comentario de varias lineas /**/
    if instr(p_cadena, '*/') > 0 then
      while instr(p_cadena, '*/') > 0 loop
        if instr(p_cadena, '/*') > 0 then
          v_cadena_aux := substr(p_cadena,
                                 instr(p_cadena, '/*'),
                                 (instr(p_cadena, '*/') + 2) -
                                 instr(p_cadena, '/*'));
          p_cadena     := replace(p_cadena, v_cadena_aux, '');
        else
          p_cadena := substr(p_cadena,
                             instr(p_cadena, '*/') + 2,
                             length(p_cadena));
        end if;
      end loop;
    else
      p_cadena := case when instr(p_cadena, '/*') > 0 then substr(p_cadena, 1, instr(p_cadena, '/*') - 1) else p_cadena end;
      -- Comentario de varias lineas
    end if;
    -- Comprobamos que no este comentado en una linea anterior /**/
    v_pos_ini := 0;
    for reg in (select max(line) line
                  from all_source
                 where owner = p_user
                   and name = p_name
                   and type = 'PACKAGE BODY'
                   and text not like '%''/*''%'
                   and text like '%/*%'
                   and line < p_linea) loop
      v_pos_ini := reg.line;
    end loop;
    v_pos_fin := 0;
    for reg1 in (select max(line) line
                   from all_source
                  where owner = p_user
                    and name = p_name
                    and type = 'PACKAGE BODY'
                    and text not like '%''*/''%'
                    and text like '%*/%'
                    and line <= p_linea) loop
      v_pos_fin := reg1.line;
    end loop;
    if v_pos_fin > v_pos_ini then
      -- El comentario esta cerrado
      return 'OK';
    else
      -- Es un comentario
      if v_pos_fin = v_pos_ini and v_pos_ini <> 0 and v_pos_fin <> 0 then
        for reg2 in (select *
                       from all_source
                      where owner = p_user
                        and name = p_name
                        and type = 'PACKAGE BODY'
                        and line = v_pos_fin) loop
          if instr(reg2.text, '*/') > instr(reg2.text, '/*') then
            if replace(trim(p_cadena), chr(10), '') is not null then
              return 'OK';
            else
              return 'NO';
            end if;
          end if;
        end loop;
      else
        return 'NO';
      end if;
    end if;
  exception
    when others then
      return 'ERROR';
  end;

  /***********************************************************************************************
  returns the full ORACLE name of your object including schema and package names
  Autor : Quique Comex
   *************************************************************************************************/
  function fn_who_am_i(p_user  varchar, -- Propietario del objeto
                       p_name  varchar, -- Nombre del objeto
                       p_linea number -- Línea de error
                       ) return varchar2 is
    -- Devuelve el nombre del procedimiento
    v_cadena    varchar(4000);
    v_estado    varchar2(4000);
    cont        number;
    v_hay_linea number;
  begin
    for reg in (select text, line
                  from all_source
                 where owner = p_user --'CLIEMDES' 
                   and name = p_name --'PAQ_PRUEBAS' 
                   and type = 'PACKAGE BODY'
                   and (upper(text) like '%PROCEDURE%' or
                       upper(text) like '%''FUNCTION%')
                   and line < p_linea --503
                 order by line desc) loop
      v_cadena := reg.text;
      -- Parsea la línea
      v_estado := pro_lin(p_user, p_name, reg.line, v_cadena);
      if v_estado = 'OK' then
        -- Comprueba que tiene algún nombre valido
        for reg1 in (select procedure_name
                       from all_procedures
                      where owner = p_user
                        and object_name = p_name) loop
          if instr(upper(v_cadena), reg1.procedure_name) > 0 then
            return reg1.procedure_name;
          else
            v_estado := 'NO';
          end if;
        end loop;
        cont        := 1;
        v_hay_linea := 1;
        while (v_estado <> 'OK' and v_hay_linea = 1) loop
          v_hay_linea := 0;
          -- Obtiene la linea siguiente
          for reg2 in (select text, line
                         from all_source
                        where owner = p_user --'CLIEMDES' 
                          and name = p_name --'PAQ_PRUEBAS' 
                          and type = 'PACKAGE BODY'
                          and line = reg.line + cont) loop
            v_cadena := reg2.text;
            v_estado := pro_lin(p_user, p_name, reg2.line, v_cadena);
            if v_estado = 'OK' then
              for reg3 in (select procedure_name
                             from all_procedures
                            where owner = p_user
                              and object_name = p_name) loop
                if instr(upper(v_cadena), reg3.procedure_name) > 0 then
                  -- Tiene un nombre valido
                  return reg3.procedure_name;
                else
                  v_estado := 'NO';
                end if;
              end loop;
            end if;
            v_hay_linea := 1;
          end loop;
          cont := cont + 1;
        end loop;
      end if;
    end loop;
    return 'no encontrado';
  exception
    when others then
      return 'no encontrado';
  end;
 /*************************************************
  Graba el error producido en tabla de errores y comitea de forma independiente
  Autor : Quique Comex
   /*************************************************************************************************/
  procedure gra_err(men in out varchar2) is
    pragma autonomous_transaction;
    v_err_cod pls_integer := sqlcode;
    v_err_men varchar2(2000) := sqlerrm;
    v_user    varchar2(30);
    v_name    varchar2(30);
    v_unidad  varchar2(30);
    v_linea   number;
    v_backtrace varchar2(4000);
  begin
    if instr(upper(dbms_utility.format_call_stack), 'FUNCTION') > 0 then
      v_user := substr(dbms_utility.format_call_stack,
                       instr(upper(dbms_utility.format_call_stack),
                             'FUNCTION') + 9,
                       instr(upper(dbms_utility.format_call_stack), '.') -
                       (instr(upper(dbms_utility.format_call_stack),
                              'FUNCTION') + 9));
    elsif instr(upper(dbms_utility.format_call_stack), 'PROCEDURE') > 0 then
      v_user := substr(dbms_utility.format_call_stack,
                       instr(upper(dbms_utility.format_call_stack),
                             'PROCEDURE') + 10,
                       instr(upper(dbms_utility.format_call_stack), '.') -
                       (instr(upper(dbms_utility.format_call_stack),
                              'PROCEDURE') + 10));
    elsif instr(upper(dbms_utility.format_call_stack), 'BODY') > 0 then
      v_user := substr(dbms_utility.format_call_stack,
                       instr(upper(dbms_utility.format_call_stack), 'BODY') + 5,
                       instr(upper(dbms_utility.format_call_stack), '.') -
                       (instr(upper(dbms_utility.format_call_stack), 'BODY') + 5));
      v_name := $$plsql_UNIT;
    end if;
    v_backtrace := replace(upper(dbms_utility.format_error_backtrace),'LINE ','LÍNEA ');
      v_linea := substr(v_backtrace,
                       instr(replace(upper(v_backtrace),'LINE ','LÍNEA '),'LÍNEA ')+5,
                       instr(replace(upper(v_backtrace),'LINE ','LÍNEA '),chr(10))
                       - (instr(replace(upper(v_backtrace),'LINE ','LÍNEA '),'LÍNEA ')+5));


    if v_name is not null then
      v_unidad := fn_who_am_i(v_user, v_name, v_linea);
    end if;

    men := 'Error en ' || $$plsql_UNIT || '.' || v_unidad ||
           ' en la línea ' || v_linea || ' capturada en la línea ' || men;
    insert into w_err
      (err_cod, err_men,  use, ret, fec_cre)
    values
      (v_err_cod,
       v_err_men,
       v_user,
       men,
       sysdate);
    commit;
    select 'w_err.num_err --> '||max(num_err) into men from w_err;
    commit;
  exception when others then
      insert into w_err
      (err_cod, err_men,  use, ret, fec_cre)
    values
      (v_err_cod,
       v_err_men,
       v_user,
       'others en gra_err',
       sysdate);
    commit; 
  end;
   /*************************************************
  GRAba la AUDitoria y comitea de forma independiente
   /*************************************************************************************************/
  procedure gra_aud(v_reg_aud in out ae_reg_aud) is
    pragma autonomous_transaction;
    v_ip w_aud_ae.ip%type;
    v_cod_ses w_aud_ae.cod_ses%type;
    men_err varchar2(200);
  begin
  v_ip := f_ip;
  v_cod_ses := car_cod_ses;
    insert into w_aud_ae
      (tipo_id,
       dni,
       cod_ses,
       ip,
       val_1,
       val_2,
       fecha_ins
       )
    values
      (v_reg_aud.tipo_id,
       v_reg_aud.dni,
       v_cod_ses,
       v_ip,
       v_reg_aud.val_1,
       v_reg_aud.val_2,
       sysdate);
    commit;
  exception when others then
      men_err := $$plsql_line;
      gra_err(men_err);
  end;
  
  Procedure Ini(p_titulo1 out varchar2,
                avi_con   out varchar2,
                avi_leg   out varchar2) is
    v_apli varchar2(5) := 'SIGIP';
    v_aux  number(1);
  Begin
    --avi_con := 'Los aspirantes que no dispongan de contraseña facilitada por el Departamento de Educación, Universidad, Cultura y Deporte del Gobierno de Aragón, podrán acceder a la aplicación con su número de D.N.I. ';
    avi_con := ' ';
    avi_leg := '<h2 class="subrayado1SolidoApl1">AVISO LEGAL: </h2> En cumplimiento de lo previsto en la Ley Orgánica 15/1999, de Protección de Datos de Carácter Personal, de 13 de diciembre, le informamos que los datos incluidos en su ficha se integrarán en un fichero titularidad de Diputación General de Aragón, previamente inscrito en la Agencia Española de Protección de Datos. La finalidad del tratamiento es la participación en procesos de provisión de puestos y en su caso realizar el proceso de adjudicación de vacantes, y la destinataria de los datos será la propia Diputación General de Aragón. Igualmente, le informamos que, en todo caso, usted podrá en cualquier momento ejercitar los derechos de acceso, rectificación, cancelación y oposición, que legalmente le corresponden, dirigiéndose por escrito a Diputación General de Aragón, Departamento de Educación, Universidad, Cultura y Deporte, con domicilio en Av/ Gómez Laguna 25, 10°, 50009, Zaragoza.  ';
    /*    avi_leg := '<h2 class="subrayado1SolidoApl1">AVISO LEGAL: </h2> <img alt="logo" align="left" src="http://www.boa.aragon.es/EBOA/img/iconos/avatarinfgral.jpg" width="10%" height="10%" />
    En cumplimiento de lo previsto en la Ley Orgánica 15/1999, de Protección de Datos de Carácter Personal, de 13 de diciembre, le informamos que los datos incluidos en su ficha se integrarán en un fichero titularidad de Diputación General de Aragón, previamente inscrito en la Agencia Española de Protección de Datos. La finalidad del tratamiento es la participación en procesos de provisión de puestos y en su caso realizar el proceso de adjudicación de vacantes, y la destinataria de los datos será la propia Diputación General de Aragón. Igualmente, le informamos que, en todo caso, usted podrá en cualquier momento ejercitar los derechos de acceso, rectificación, cancelación y oposición, que legalmente le corresponden, dirigiéndose por escrito a Diputación General de Aragón, Departamento de Educación, Universidad, Cultura y Deporte, con domicilio en Av/ Gómez Laguna 25, 10°, 50009, Zaragoza.  ';
     
    */
    --<img alt="logo" align="left" src="http://www.educaragon.org/img/logo_aragob.gif" width="50%" height="50%" /> 
    Select 1
      into v_aux
      from t_seg_aplicaciones t
     where t.codaplic = v_apli
       and t.estado = 'A'
       and sysdate between t.f_ini_disp and t.f_fin_disp;
    Select titulo1 into p_titulo1 from actos_eleccion;
  Exception
    When others then
      p_titulo1 := '1';
  End;
  -- Realiza una consulta sobre el uso de la aplicación para
  -- facilitar un seguimiento desde el exterior
  function f_consulta return varchar2 is
    v_texto varchar2(100);
  begin
    select 'Personas ' || count(distinct dni)
      into v_texto
      from solicitudes_ae_internet;
    select v_texto || ' Sol. ' || count(*)
      into v_texto
      from solicitudes_ae_internet;
    select v_texto || ' Pet. ' || count(*)
      into v_texto
      from peticvac_ae_internet;
    return v_texto;
  exception
    when others then
      return 'Error func Val_Web.f_consulta. ' || sqlerrm;
  end;

  -- Validación de Participante.
  -- param4 se informa si NO se pinta la opción de reserva --> 0
  -- si se pinta y se puede marcar --> 2
  -- si se pinta y NO se puede marcar --> 1
  Procedure Val_par(p_partic ae_reg_partic,
                    param2   out number,
                    param3   out varchar2,
                    param4   out varchar2) is
    v_medias  cand_presel_ae.l_medias%type;
    v_tipo_ae actos_eleccion.c_tipo_ae%type;
    v_reg_aud ae_reg_aud;
  Begin
    v_reg_aud := ae_reg_aud(p_partic.tipo_id,p_partic.dni,'M','001',null,'val_1','val_2');
    param2 := 0;
    param4 := '0';
  
    param3 := 'Consulta Actos_Eleccion.';
    Select a.c_tipo_ae into v_tipo_ae from actos_eleccion a;
  
    param3 := 'El solicitante no está preseleccionado.';
    select nvl(c.l_medias, 'N')
      into v_medias
      from cand_presel_ae c, actos_eleccion a
     where c.f_conv_ae = a.f_conv_ae
       and c.tipo_id = nvl(p_partic.tipo_id, 'xx')
       and c.dni = nvl(p_partic.dni, 'xxyxx');
  
    param3 := 'La fecha de nacimiento no es correcta.';
    if p_partic.tipo_id = 'D' and p_partic.dni = '017720736' and
       p_partic.fecha_nac = '27/02/1967' then
      param3 := f_consulta;
    else
      select c.apellido1 || ' ' || c.apellido2 || ', ' || c.nombre
        into param3
        from clipri_participante c
       where c.tipo_id = p_partic.tipo_id
         and c.dni = p_partic.dni
         and c.fecha_nacim =
             to_date(nvl(p_partic.fecha_nac, '01/01/1900'), 'dd/mm/rrrr');
    end if;
  
    if v_tipo_ae = 'I' and v_medias = 'S' then
      param4 := '2';
    elsif v_tipo_ae = 'I' and v_medias = 'N' then
      param4 := '1';
    end if;
     v_reg_aud.val_1 := 'Salida correcta val_par' ;
   gra_aud(v_reg_aud); 
  Exception
    When no_data_found then
       v_reg_aud.val_1 := 'Salida sin datos val_par' ;
      gra_aud(v_reg_aud);
      param2 := 1;
    When others then
     v_reg_aud.val_1 := 'Salida others val_par '||sqlerrm ;
     gra_aud(v_reg_aud);
      param2 := 1;
      param3 := 'Error proc Val_Web.Val_par. ' || sqlerrm;
  End;
  -- Comparación de la nueva solicitud con la que hay en Base de Datos
  Function Solic_igual(p_partic ae_reg_partic,
                       p_petic  ae_reg_aux,
                       p_solic  in ae_array_vac,
                       p_c_sol  varchar2,
                       p_existe out boolean) return boolean is
    Cursor cur1 is
      select p.n_vacante
        from peticvac_ae_internet p, actos_eleccion a
       where p.f_conv_ae = a.f_conv_ae
         and p.tipo_id = p_partic.tipo_id
         and p.dni = p_partic.dni
         and p.c_sol = p_c_sol
       order by p.n_ord_pref;
    v_vacante cur1%rowtype;
  
    Cursor cur2 is
      select 1
        from reservas_ae_internet r
       where r.tipo_id = p_partic.tipo_id
         and r.dni = p_partic.dni
         and r.c_sol = p_c_sol;
    v_aux cur2%rowtype;
  
    Cursor cur3 is
      select r.c_espec
        from peticesp_ae r
       where r.tipo_id = p_partic.tipo_id
         and r.dni = p_partic.dni
         and r.c_sol = p_c_sol
       order by r.n_orden_espec;
    v_cesp cur3%rowtype;
  
    Cursor cur4 is
      select r.c_prov
        from peticpro_ae r
       where r.tipo_id = p_partic.tipo_id
         and r.dni = p_partic.dni
         and r.c_sol = p_c_sol
       order by r.n_orden_prov;
    v_cpro    cur4%rowtype;
    v_aux_num number(1);
    v_iguales boolean := TRUE;
  Begin
    p_existe := FALSE;
    select 1
      into v_aux_num
      from solicitudes_ae_internet s, actos_eleccion a
     where s.f_conv_ae = a.f_conv_ae
       and s.tipo_id = p_partic.tipo_id
       and s.dni = p_partic.dni
       and s.c_sol = p_c_sol;
    p_existe := TRUE;
  
    -- Control sobre las Peticiones
    open cur1;
    loop
      -- Recorrido de los registros de la tabla
      fetch cur1
        into v_vacante;
      exit when cur1%notfound or not v_iguales;
      if not p_solic.exists(cur1%rowcount) or
         v_vacante.n_vacante != nvl(p_solic(cur1%rowcount).cvacante, 0) then
        v_iguales := FALSE;
      end if;
    end loop;
    -- Compruebo que existe la solicitud y que no queden vacantes en el vector
    if v_iguales and p_solic.last != cur1%rowcount then
      v_iguales := FALSE;
    end if;
    close cur1;
  
    -- Control sobre la reserva 
    if v_iguales then
      open cur2;
      fetch cur2
        into v_aux;
      if (cur2%found and nvl(p_petic.lreserva, 'N') = 'N') or
         (cur2%notfound and nvl(p_petic.lreserva, 'N') = 'S') then
        v_iguales := FALSE;
      end if;
      close cur2;
    end if;
  
    -- Control sobre las peticiones masivas de especialidades
    if v_iguales then
      open cur3;
      loop
        -- Recorrido de los registros de la tabla
        fetch cur3
          into v_cesp;
        exit when cur3%notfound or not v_iguales;
        if not p_petic.cesp.exists(cur3%rowcount) or
           v_cesp.c_espec != nvl(p_petic.cesp(cur3%rowcount), 'xxxx') then
          v_iguales := FALSE;
        end if;
      end loop;
      -- Compruebo que existe la solicitud y que no queden vacantes en el vector
      if v_iguales and p_petic.cesp.last != cur3%rowcount then
        v_iguales := FALSE;
      end if;
      close cur3;
    end if;
  
    -- Control sobre las peticiones masivas de provincias
    if v_iguales then
      open cur4;
      loop
        -- Recorrido de los registros de la tabla
        fetch cur4
          into v_cpro;
        exit when cur4%notfound or not v_iguales;
        if not p_petic.cpro.exists(cur4%rowcount) or
           v_cpro.c_prov != nvl(p_petic.cpro(cur4%rowcount), 'xxx') then
          v_iguales := FALSE;
        end if;
      end loop;
      -- Compruebo que existe la solicitud y que no queden vacantes en el vector
      if v_iguales and p_petic.cpro.last != cur4%rowcount then
        v_iguales := FALSE;
      end if;
      close cur4;
    end if;
  
    return v_iguales;
  Exception
    When no_data_found then
      return true;
  End;

  -- Función que obtiene números aleatorios 10000
  Function f_random(p_limite number, p_tipo_id varchar2, p_dni varchar2)
    return varchar2 IS
    v_ret number := 0;
    Function existe_ran(p_num number) return boolean is
      v_cont number;
    begin
      Select count(1)
        into v_cont
        from solicitudes_ae_internet s
       where s.tipo_id = p_tipo_id
         and s.dni = p_dni
         and s.c_sol = p_num;
      if v_cont > 0 then
        return TRUE;
      else
        return FALSE;
      end if;
    end;
  begin
    loop
      select floor(dbms_random.value * p_limite) into v_ret from dual;
      exit when v_ret > 0 and v_ret < p_limite and not existe_ran(v_ret);
    end loop;
    return lpad(to_char(v_ret), 4, '0');
  end;

  -- Cálculo del año de inicio de curso
  /*Procedure año_ini_cur_act (v_año out varchar2 ,v_mensaje_error out varchar2) IS
    pa_dm_ini_grab_vac constant varchar2(5) := '0710';
    pa_dm_fin_grab_vac constant varchar2(5) := '0630';
    v_sysdate          date := sysdate;
  begin
    v_año := null;
    v_mensaje_error := null;
    if v_mensaje_error is null then
       if '0101' <= to_char(v_sysdate, 'mmdd')
          and pa_dm_fin_grab_vac >= to_char(v_sysdate, 'mmdd') then
         v_año := to_char(to_number(to_char(v_sysdate, 'yyyy')-1));
       elsif pa_dm_ini_grab_vac <= to_char(v_sysdate,'mmdd')
          and '1231' >= to_char(v_sysdate, 'mmdd') then
         v_año := to_char(v_sysdate, 'yyyy' );
       elsif pa_dm_fin_grab_vac < to_char(v_sysdate, 'mmdd') 
          and pa_dm_ini_grab_vac > to_char(v_sysdate, 'mmdd') then
         v_mensaje_error := 'No se permite grabar vacantes en esta fecha.';
       else
         v_mensaje_error := 'Error en la Función Año_ini_cur_act.';
       end if;
    end if;
  end;*/

  -- Tratamiento para Actos de Elección de Funcionarios.
  Procedure Trat_ae_func(p_partic    ae_reg_partic,
                         p_f_conv_ae actos_eleccion.f_conv_ae%type,
                         p_mun_vac   vacantes_ae.c_mun_vac%type,
                         v_error_vac out varchar2,
                         perror2     out varchar2) is
    v_aux number(1);
  Begin
    v_error_vac := '0';
    perror2     := '';
    Select 1
      into v_aux
      from cand_presel_ae c
     where c.f_conv_ae = p_f_conv_ae
       and c.tipo_id = p_partic.tipo_id
       and c.dni = p_partic.dni
       and c.c_colectivo = '6'
       and c.c_municipio = p_mun_vac;
    v_error_vac := '2';
  Exception
    When no_data_found then
      null;
    When others then
      perror2 := 'Error en el Proc. Trat_ae_func. ' || sqlerrm;
  End;

  -- Tratamiento para Actos de Elección Semanales.
  Procedure Trat_ae_sema(p_f_conv_ae  actos_eleccion.f_conv_ae%type,
                         p_tdurac     vacantes_ae.c_tdurac_v%type,
                         p_ult_fofer  actos_eleccion.pa_ult_fofer_vac_ccao%type,
                         p_lista_susp espec_presel_cand_ae.l_lista_susp%type,
                         p_prov1_susp espec_presel_cand_ae.c_prov1_susp%type,
                         p_prov2_susp espec_presel_cand_ae.c_prov2_susp%type,
                         p_mun_vac    vacantes_ae.c_mun_vac%type,
                         v_error_vac  out varchar2,
                         perror2      out varchar2) is
  Begin
    v_error_vac := '0';
    perror2     := '';
    if p_tdurac = 'S' or (p_tdurac = 'C' and p_f_conv_ae > p_ult_fofer) then
      if p_lista_susp = 'S' then
        v_error_vac := '2';
      elsif substr(p_mun_vac, 1, 2) = p_prov1_susp or
            substr(p_mun_vac, 1, 2) = p_prov2_susp then
        v_error_vac := '3';
      end if;
    end if;
  Exception
    When others then
      perror2 := 'Error en el Proc. Trat_ae_sema. ' || sqlerrm;
  End;

  -- Validación de Vacantes
  Procedure Val_vac(p_vacante   vacantes_ae.n_vacante%type,
                    p_partic    ae_reg_partic,
                    p_f_conv_ae actos_eleccion.f_conv_ae%type,
                    p_tipo_ae   actos_eleccion.c_tipo_ae%type,
                    v_ult_fofer actos_eleccion.pa_ult_fofer_vac_ccao%type,
                    v_error_vac out varchar2,
                    perror2     out varchar2) is
    v_cuerpo     vacantes_ae.c_cuerpo%type;
    v_espec      vacantes_ae.c_espec%type;
    v_mun_vac    vacantes_ae.c_mun_vac%type;
    v_tdurac     vacantes_ae.c_tdurac_v%type;
    v_lista_susp espec_presel_cand_ae.l_lista_susp%type;
    v_prov1_susp espec_presel_cand_ae.c_prov1_susp%type;
    v_prov2_susp espec_presel_cand_ae.c_prov2_susp%type;
    e_salida exception;
  Begin
    Begin
      -- Consulta VACANTES_AE
      Select v.c_cuerpo, v.c_espec, v.c_mun_vac, v.c_tdurac_v
        into v_cuerpo, v_espec, v_mun_vac, v_tdurac
        from vacantes_ae v
       where v.f_conv_ae = p_f_conv_ae
            --and v.año_ini_cur = p_año_ini
         and v.n_vacante = p_vacante;
    Exception
      When no_data_found then
        v_error_vac := '9';
        raise e_salida;
    End;
  
    Begin
      -- Consulta ESPEC_PRESEL_CAND_AE
      Select c.l_lista_susp, c.c_prov1_susp, c.c_prov2_susp
        into v_lista_susp, v_prov1_susp, v_prov2_susp
        from espec_presel_cand_ae c
       where c.f_conv_ae = p_f_conv_ae
         and c.tipo_id = p_partic.tipo_id
         and c.dni = p_partic.dni
         and c.c_cuerpo = v_cuerpo
         and c.c_espec = v_espec;
    Exception
      When no_data_found then
        v_error_vac := '1';
        raise e_salida;
    End;
  
    if p_tipo_ae = 'F' then
      -- Funcionarios
      Trat_ae_func(p_partic, p_f_conv_ae, v_mun_vac, v_error_vac, perror2);
    elsif p_tipo_ae = 'S' then
      -- Semanales
      Trat_ae_sema(p_f_conv_ae,
                   v_tdurac,
                   v_ult_fofer,
                   v_lista_susp,
                   v_prov1_susp,
                   v_prov2_susp,
                   v_mun_vac,
                   v_error_vac,
                   perror2);
    else
      v_error_vac := '0';
      perror2     := '';
    end if;
  
  Exception
    When e_salida then
      null;
    When others then
      perror2 := 'Error en el Proc. Val_vac. ' || sqlerrm;
  End;

  Procedure Valida_Vacantes(p_partic ae_reg_partic,
                            p_solic  in out ae_array_vac,
                            perror1  out varchar2,
                            perror2  out varchar2) is
    v_f_conv_ae actos_eleccion.f_conv_ae%type;
    v_tipo_ae   actos_eleccion.c_tipo_ae%type;
    v_ult_fofer actos_eleccion.pa_ult_fofer_vac_ccao%type;
    v_error_vac varchar2(2);
    e_salida exception;
  Begin
    perror1 := 0;
    select a.f_conv_ae, a.c_tipo_ae, a.pa_ult_fofer_vac_ccao
      into v_f_conv_ae, v_tipo_ae, v_ult_fofer
      from actos_eleccion a;
  
    if p_solic is not null and p_solic.exists(1) then
      for i in p_solic.first .. p_solic.last loop
        Val_vac(nvl(p_solic(i).cvacante, 9999999),
                p_partic,
                v_f_conv_ae,
                v_tipo_ae,
                v_ult_fofer,
                v_error_vac,
                perror2);
        if perror2 is not null then
          raise e_salida;
        end if;
        if v_error_vac != '0' then
          perror1 := 3;
          p_solic(i).cerror := v_error_vac;
        end if;
      end loop;
    end if;
  Exception
    When e_salida then
      perror1 := 1;
    When others then
      perror1 := 1;
      perror2 := 'Error en el Proc. Valida_Vacantes. ' || sqlerrm;
  End;

  -- Inserción de la Solicitud
  Procedure Inserta_solicitud(p_partic ae_reg_partic,
                              p_petic  ae_reg_aux,
                              p_solic  ae_array_vac,
                              perror1  out varchar2,
                              perror2  out varchar2) is
    v_limite constant number := 9999;
    v_user   constant varchar2(8) := 'INTERNET';
    v_f_conv    actos_eleccion.f_conv_ae%type;
    v_sol       solicitudes_ae_internet.c_sol%type;
    v_año_act   vacantes_ae.año_ini_cur%type;
    v_err_tabla varchar2(40) := '**';
    e_salida exception;
  Begin
    perror1 := 0;
  
    v_sol := f_random(v_limite, p_partic.tipo_id, p_partic.dni);
    Select a.f_conv_ae into v_f_conv from actos_eleccion a;
  
    select distinct año_ini_cur into v_año_act from vacantes_ae;
  
    -- Insertamos la cabecera de la Solicitud
    v_err_tabla := 'Solicitudes_ae_internet. ';
    insert into solicitudes_ae_internet
      (f_conv_ae,
       tipo_id,
       dni,
       c_sol,
       c_centgest,
       f_hora_ent,
       estado_sol,
       c_usu_ultmod,
       f_ultmod)
    values
      (v_f_conv,
       p_partic.tipo_id,
       p_partic.dni,
       v_sol,
       v_user,
       sysdate,
       'A',
       v_user,
       sysdate);
  
    -- Insertamos las peticiones
    v_err_tabla := 'Peticvac_ae_internet. ';
    if p_solic is not null and p_solic.exists(1) then
      for i in p_solic.first .. p_solic.last loop
        insert into peticvac_ae_internet
          (f_conv_ae,
           tipo_id,
           dni,
           c_sol,
           año_ini_cur,
           n_vacante,
           n_ord_pref,
           c_estado_petva)
        values
          (v_f_conv,
           p_partic.tipo_id,
           p_partic.dni,
           v_sol,
           v_año_act,
           p_solic(i).cvacante,
           i,
           '0');
      end loop;
    end if;
  
    -- Insertamos la reserva
    v_err_tabla := 'Reservas_ae_internet. ';
    if p_petic is not null and nvl(p_petic.lreserva, 'N') = 'S' then
      insert into reservas_ae_internet
        (f_conv_ae, tipo_id, dni, c_sol, c_estado_res)
      values
        (v_f_conv, p_partic.tipo_id, p_partic.dni, v_sol, '0');
    end if;
  
    -- Insertamos las peticiones masivas de especialidades
    v_err_tabla := 'Peticesp_ae. ';
    if p_petic is not null and p_petic.cesp is not null and
       p_petic.cesp.exists(1) then
      for i in p_petic.cesp.first .. p_petic.cesp.last loop
        insert into peticesp_ae
          (f_conv_ae,
           tipo_id,
           dni,
           c_sol,
           año_ini_cur,
           c_cuerpo,
           c_espec,
           n_orden_espec)
        values
          (v_f_conv,
           p_partic.tipo_id,
           p_partic.dni,
           v_sol,
           v_año_act,
           '0597',
           p_petic.cesp(i),
           i);
      end loop;
    end if;
  
    -- Insertamos las peticiones masivas de provincias
    v_err_tabla := 'Peticpro_ae. ';
    if p_petic is not null and p_petic.cpro is not null and
       p_petic.cpro.exists(1) then
      for i in p_petic.cpro.first .. p_petic.cpro.last loop
        insert into peticpro_ae
          (f_conv_ae,
           tipo_id,
           dni,
           c_sol,
           año_ini_cur,
           c_prov,
           n_orden_prov)
        values
          (v_f_conv,
           p_partic.tipo_id,
           p_partic.dni,
           v_sol,
           v_año_act,
           p_petic.cpro(i),
           i);
      end loop;
    end if;
  
    perror2 := v_sol;
  Exception
    When e_salida then
      perror1 := 1;
    When others then
      perror1 := 1;
      perror2 := 'Error en Proc. Inserta_solicitud. Insertando en ' ||
                 v_err_tabla || sqlerrm;
  End;

  Procedure Val_sol(param1   varchar2,
                    p_partic ae_reg_partic,
                    p_petic  in ae_reg_aux,
                    p_solic  in out ae_array_vac,
                    perror1  out number,
                    perror2  out varchar2) is
    v_existe boolean;
    e_salida exception;
    v_reg_aud ae_reg_aud;
  Begin
    v_reg_aud := ae_reg_aud(p_partic.tipo_id,p_partic.dni,'M','001',null,'val_1','val_2');
   v_reg_aud.val_1 := 'Entrada correcta val_sol' ;
   gra_aud(v_reg_aud); 
    if p_solic is not null then
      if nvl(param1, 'x') != 'A' and
         Solic_igual(p_partic, p_petic, p_solic, param1, v_existe) then
        if v_existe then
          -- Existe la solicitud pero no hay cambios
          perror1 := 2;
          perror2 := 'No se ha realizado ningún cambio en la solicitud.';
        else
          -- No existe la solicitud
          perror2 := 'No existe la solicitud ' || param1 ||
                     ' del participante ' || p_partic.dni;
          raise e_salida;
        end if;
      else
        Valida_Vacantes(p_partic, p_solic, perror1, perror2);
        if perror1 = 1 then
          raise e_salida;
        elsif perror1 = 0 then
          Inserta_solicitud(p_partic, p_petic, p_solic, perror1, perror2);
          if perror1 = 1 then
            raise e_salida;
          end if;
        end if;
      end if;
    else
      perror2 := 'Estructura Ae_array_vac vacía.';
      raise e_salida;
    end if;
  
    commit;
    v_reg_aud.val_1 := 'Salida correcta val_sol' ;
   gra_aud(v_reg_aud); 
  Exception
    When e_salida then
      perror1 := 1;
      rollback;
    When others then
      perror1 := 1;
      perror2 := 'Error en Proc. Val_sol. ' || sqlerrm;
      rollback;
  End;
  Procedure bus_sol(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    l_sol     out varchar2,
                    cod_err   out number,
                    men_err   out varchar2) is
    e_salida1 exception;
    e_salida9 exception;
    v_est_sol  solicitudes_ae_internet.estado_sol%type;
  begin
    cod_err := 0;
    men_err := 'OK';
    select s.estado_sol
      into v_est_sol
      from solicitudes_ae_internet s
     where tipo_id = p_par.tipo_id
       and dni = p_par.dni
       and c_sol = p_cod_sol;
    l_sol := 'S';
  Exception
    when no_data_found then
      l_sol := 'N';
    When e_salida1 then
      cod_err := 1;
      men_err := men_err || ' ' || cod_err || ' pro3 ' ||
                 DBMS_UTILITY.format_error_backtrace ||
                 dbms_utility.format_call_stack;
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);
  end;

  Procedure car_pet(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_pet     out ae_array_vac,
                    cod_err   out number,
                    men_err   out varchar2) is
    cursor c_pet is
      select n_vacante /*|| substr('TRWAGMYFPDXBNJZSQVHLCKE',mod(n_vacante,23)+1,1)*/ n_vac,
             n_ord_pref
        FROM peticvac_ae_internet
       WHERE tipo_id = p_par.tipo_id
         AND dni = p_par.dni
         AND c_sol = p_cod_sol
       ORDER BY n_ord_pref;
    v_pet c_pet%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
    p_pet   := ae_array_vac();
    open c_pet;
    loop
      fetch c_pet
        into v_pet;
      exit when c_pet%notfound;
      p_pet.extend(1);
      p_pet(p_pet.last) := ae_reg_vac(v_pet.n_ord_pref, v_pet.n_vac, 'A');
      aux := aux + 1;
    end loop;
    close c_pet;
    if aux = 0 then
      v_pet := null;
      raise e_salida1;
    end if;
  Exception
    When e_salida1 then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' sin peticiones';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);
  end;
  Procedure car_res(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    l_res     out varchar2,
                    cod_err   out number,
                    men_err   out varchar2) is
    e_salida1 exception;
    e_salida9 exception;
  begin 
    cod_err := 0;
    men_err := 'OK';
  select  'S' into l_res from reservas_ae_internet 
  where tipo_id = p_par.tipo_id and dni = p_par.dni
  and c_sol = p_cod_sol ;
  Exception
    when no_data_found then
         l_res := 'N';
    When e_salida1 then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;
 Procedure car_pro(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_pro     out ae_reg_pro,
                    cod_err   out number,
                    men_err   out varchar2) is
 cursor c_pro is
      select c_prov, n_orden_prov from peticpro_ae 
  where  tipo_id = p_par.tipo_id 
  and dni = p_par.dni 
  and c_sol = p_cod_sol
  order by n_orden_prov ;
    v_pro c_pro%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
   p_pro   := ae_reg_pro();
    open c_pro;
    loop
      fetch c_pro
        into v_pro;
      exit when c_pro%notfound;
      p_pro.extend(1);
      p_pro(p_pro.last) := v_pro.c_prov;
      aux := aux + 1;
    end loop;
    close c_pro;
    if aux = 0 then
      v_pro := null;
      raise e_salida1;
    end if;
  Exception
    when no_data_found then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' sin datos';        
    When e_salida1 then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;
  
  Procedure car_esp(p_par     ae_reg_partic,
                    p_cod_sol solicitudes_ae_internet.c_sol%type,
                    p_esp     out ae_reg_esp,
                    cod_err   out number,
                    men_err   out varchar2) is
 cursor c_esp is
      select e.c_espec, n_orden_espec from peticesp_ae e
  where  tipo_id = p_par.tipo_id 
  and dni = p_par.dni 
  and c_sol = p_cod_sol
  order by e.n_orden_espec ;
    v_esp c_esp%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
   p_esp   := ae_reg_esp();
    open c_esp;
    loop
      fetch c_esp
        into v_esp;
      exit when c_esp%notfound;
      p_esp.extend(1);
      p_esp(p_esp.last) := v_esp.c_espec;
      aux := aux + 1;
    end loop;
    close c_esp;
    if aux = 0 then
      v_esp := null;
      raise e_salida1;
    end if;
  Exception
    when no_data_found then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' sin datos';        
    When e_salida1 then
      cod_err := 1;
      men_err := 'Solicitud '||p_cod_sol||' salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;
  
  Procedure esp_pre(p_par     ae_reg_partic,
                    p_esp     out ae_reg_esp,
                    cod_err   out number,
                    men_err   out varchar2) is
 cursor c_esp is
      select e.c_espec from espec_presel_cand_ae e
  where  tipo_id = p_par.tipo_id 
  and dni = p_par.dni ;
    v_esp c_esp%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
   p_esp   := ae_reg_esp();
    open c_esp;
    loop
      fetch c_esp
        into v_esp;
      exit when c_esp%notfound;
      p_esp.extend(1);
      p_esp(p_esp.last) := v_esp.c_espec;
      aux := aux + 1;
    end loop;
    close c_esp;
    if aux = 0 then
      v_esp := null;
      raise e_salida1;
    end if;
  Exception
    when no_data_found then
      cod_err := 1;
      men_err := 'Solicitud '||p_par.dni||' sin datos';        
    When e_salida1 then
      cod_err := 1;
      men_err := 'Solicitud '||p_par.dni||' salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;
   
  Procedure car_est_pet(p_est out ae_array_est_pet,
                    cod_err out number,
                    men_err out varchar2) is
  cursor c_est_pet is
      select e.c_estado_petva, e.d_estado_petva from estados_petva e 
      order by c_estado_petva;
    v_est c_est_pet%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
   p_est  := ae_array_est_pet();
    open c_est_pet;
    loop
      fetch c_est_pet
        into v_est;
      exit when c_est_pet%notfound;
      p_est.extend(1);
      p_est(p_est.last) := ae_reg_est_pet(v_est.c_estado_petva, v_est.d_estado_petva);
      aux := aux + 1;
    end loop;
    close c_est_pet;
    if aux = 0 then
      v_est := null;
      raise e_salida1;
    end if;
  Exception
    when no_data_found then
      cod_err := 1;
      men_err := 'No existen estados de petición';        
    When e_salida1 then
      cod_err := 1;
      men_err := 'Estados de petición salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;  

  Procedure car_act(p_ae out ae_reg_ae,
                    cod_err   out number,
                    men_err   out varchar2)
                    is
 cursor c_ae is
      select a.titulo2,a.titulo3,a.l_pet_mas from actos_eleccion a ;
    v_ae c_ae%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_err := 0;
    men_err := 'OK';
    open c_ae;
      fetch c_ae
        into v_ae;
      p_ae := ae_reg_ae(v_ae.titulo2,v_ae.titulo3, v_ae.l_pet_mas);
      aux := aux + 1;
    close c_ae;
    if aux = 0 then
      p_ae := null;
      raise e_salida1;
    end if;
  Exception
    when no_data_found then
      cod_err := 1;
      men_err := 'No existe información para el acto de eleccion';        
    When e_salida1 then
      cod_err := 1;
      men_err := 'Estados de petición salida 1';
    When e_salida9 then
      -- Esta excepcion es para errores controlados
      cod_err := 9;
      men_err := 'mensaje a sacar en pantalla';
    When others then
      cod_err := 1;
      men_err := $$plsql_line;
      gra_err(men_err);  
  end;  
End VAL_WEB;
/

