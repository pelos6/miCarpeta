create or replace package body sigi_pck is
  v_apli  VARCHAR2(10) := 'SIGI';
  v_fccao varchar2(10);
  type charTable is table of varchar2(10);
  /***********************************************************************************************
  returns the IP
  Autor : Quique Comex
   *************************************************************************************************/
  function f_ip RETURN Varchar2 IS
  Begin
    /*Select SYS_CONTEXT('USERENV','IP_ADDRESS')
    Into v_ip
    From Dual;
    Return v_ip; */
    return(SYS_CONTEXT('USERENV', 'IP_ADDRESS'));
  End;
  /*******************************************************/
  /** Procedimiento tab_to_char  **/
  /** Pasa un tipo tabla a char  **/
  /*******************************************************/
  function tab_to_char(v_tab in charTable) return varchar2 is
    v_cha varchar2(32767);
  begin
    for x in 1 .. v_tab.count loop
      v_cha := v_cha || v_tab(x);
    end loop;
    return v_cha;
  end;
  /***************************************************************************/
  /**Función para sacar la fecha hasta las vacantes de curso completo son de */
  /* aceptación obligatoria                                                  */
  /***************************************************************************/
  FUNCTION F_fccao(v_opc sigi_opc.cod_opc%type) RETURN VARCHAR2 IS
  BEGIN
    select o.fec_cur_com
      into v_fccao
      from sigi_opc o
     where o.cod_opc = v_opc;
    RETURN v_fccao;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error en f_fccao ' || sqlerrm;
  END;
  /************************************************/
  /** procedimiento genera la CARga del CODigo de SESion **/
  /** es por usuario y sesion web o uso un token que me den */
  /*  desde la web o genero yo uno    */
  /*  ahora mismo es la sesión oracle */
  /************************************************/
  function car_cod_ses return varchar2 is
    v_cod_Ses varchar2(100);
  begin
    --select userenv('sessionid') into v_cod_ses from dual;
    --select userenv('sid') into v_cod_ses from dual;
    select DBMS_SESSION.UNIQUE_SESSION_ID into v_cod_ses from dual;
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
  /*************************************************
  Graba el error producido en tabla de errores y comitea de forma independiente
  En el campo ret de sigi_err la traza del error con el
  numero de linea
  Autor : Javier
  /*************************************************************************************************/
  PROCEDURE gra_err(men IN OUT VARCHAR2) IS
    pragma autonomous_transaction;
    v_err_cod pls_integer := SQLCODE;
    v_err_men VARCHAR2(2000) := sqlerrm || ' ' || men;
    v_user    VARCHAR2(30);
  BEGIN
    INSERT INTO sigi_err
      (err_cod, err_men, use, ret, fec_cre)
    VALUES
      (v_err_cod,
       v_err_men,
       v_user,
       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
       sysdate);
    COMMIT;
    SELECT 'sigi_err.num_err --> ' || MAX(num_err) INTO men FROM sigi_err;
  EXCEPTION
    WHEN OTHERS THEN
      INSERT INTO sigi_err
        (err_cod, err_men, use, ret, fec_cre)
      VALUES
        (v_err_cod,
         v_err_men,
         v_user,
         'others en gra_err ' || '
      ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
         sysdate);
      COMMIT;
  END;
  /*************************************************
  Graba el error producido en tabla de errores y comitea de forma independiente
  Autor : Javier
   /*************************************************************************************************/
  procedure gra_err_olb(men in out varchar2) is
    pragma autonomous_transaction;
    v_err_cod   pls_integer := sqlcode;
    v_err_men   varchar2(2000) := sqlerrm;
    v_user      varchar2(30);
    v_name      varchar2(30);
    v_unidad    varchar2(30);
    v_linea     number;
    v_backtrace varchar2(4000);
  begin
    -- null;
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
    v_backtrace := replace(upper(dbms_utility.format_error_backtrace),
                           'LINE ',
                           'LÍNEA ');
    v_linea     := substr(v_backtrace,
                          instr(replace(upper(v_backtrace),
                                        'LINE ',
                                        'LÍNEA '),
                                'LÍNEA ') + 5,
                          instr(replace(upper(v_backtrace),
                                        'LINE ',
                                        'LÍNEA '),
                                chr(10)) -
                          (instr(replace(upper(v_backtrace),
                                         'LINE ',
                                         'LÍNEA '),
                                 'LÍNEA ') + 5));

    /*  if v_name is not null then
      v_unidad := fn_who_am_i(v_user, v_name, v_linea);
    end if;*/
    v_unidad := '';
    men      := 'Error en ' || $$plsql_UNIT || ' en la línea ' || v_linea || ' ' || men;
    insert into sigi_err
      (err_cod, err_men, use, ret, fec_cre)
    values
      (v_err_cod, v_err_men, v_user, men, sysdate);
    commit;
    select 'sigi_err.num_err --> ' || max(num_err) into men from sigi_err;
  exception
    when others then
      insert into sigi_err
        (err_cod, err_men, use, ret, fec_cre)
      values
        (v_err_cod, v_err_men, v_user, 'others en gra_err', sysdate);
      commit;
  end;
  /*************************************************
  GRAba la AUDitoria y comitea de forma independiente
  **************************************************/
  procedure gra_aud(v_reg_aud in out sigi_t_aud) is
    pragma autonomous_transaction;
    v_ip      sigi_aud.ip%type;
    v_cod_ses sigi_aud.cod_ses%type;
    men_err   varchar2(200);
  begin
    v_ip      := f_ip;
    v_cod_ses := car_cod_ses;
    insert into sigi_aud
      (tipo_id, dni, cod_ses, ip, val_1, val_2, f_ins)
    values
      (v_reg_aud.tipo_id,
       v_reg_aud.dni,
       v_cod_ses,
       v_ip,
       v_reg_aud.val_1,
       v_reg_aud.val_2,
       sysdate);
    commit;
  exception
    when others then
      --men_err := $$plsql_line;
      men_err := v_reg_aud.dni;
      gra_err(men_err);
  end;
  /*******************************************************/
  /** Procedimiento plantilla  **/
  /*******************************************************/
  procedure plantilla(cod_men out number, men out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    -- Llamada a otro procedmientos
    -- pro1(cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    else
      null; -- para tratar errores especiales
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);

      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /***********************************************************/
  /** Procedimiento CON sulta PAR ametro de la aplicación  **/
  /** en la tabla sigi_par_apl                            **/
  /**    .- v_nom_par el parametro a consultar                  **/
  /**    .- v_val_par el valor de la parametro                  **/
  /**********************************************************/
  procedure con_par(v_nom_par in varchar2,
                    v_val_par out varchar2,
                    cod_men   out number,
                    men       out varchar2) is
    -- e_salida1 exception;
    -- e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    select val_par
      into v_val_par
      from sigi_par_apl
     where nom_par = v_nom_par;
  Exception
    When no_data_found then
      cod_men := 6;
      men     := 'Error al consultar el parametro (no data found) ' ||
                 v_nom_par;
      men     := men || ' ' || $$plsql_line;
      gra_err(men);
    When others then
      cod_men := 5;
      men     := 'Error al consultar el parametro others' || v_nom_par;
      men     := men || ' ' || cod_men ||
                 sys.DBMS_UTILITY.format_error_backtrace;
      gra_err(men);
  end;
  /*******************************************************/
  /**  Función para obtener el TIPO_ID del participante **/
  /*******************************************************/
  FUNCTION obt_tip_id(v_dni IN VARCHAR2) RETURN VARCHAR2 IS
    v_tipo_id VARCHAR2(1);
  BEGIN
    IF SUBSTR(v_dni, 1, 1) in ('X', 'Y', 'Z') THEN
      v_tipo_id := 'P';
    elsif LENGTH(v_dni) = 9 THEN
      v_tipo_id := 'D';
    ELSE
      v_tipo_id := 'P';
    END IF;
    RETURN v_tipo_id;
  END;
  /*******************************************************/
  /** Procedimiento INI cio                            **/
  /*******************************************************/
  Procedure ini(v_tit   out varchar2,
                avi_con out varchar2,
                avi_leg out varchar2,
                l_e_adm out varchar2,
                l_e_fec_nac out varchar2,
                cod_men out number,
                men     out varchar2) is
    e_salida1 EXCEPTION;
    v_val_par sigi_par_apl.val_par%type;
    v_aud     sigi_t_aud;
  BEGIN
     /*     v_aud := sigi_t_aud(null, null, 'en ini '||user, null);
    gra_aud(v_aud);*/
    cod_men := 0;
    men     := 'OK';
    -- Titulo a mostrar en caso de error
    v_tit := 'GESTION DE VACANTES';
    SELECT t.mensaje_texto
      INTO v_tit
      FROM t_seg_aplicaciones t
     WHERE t.codaplic = v_apli
       AND t.estado = 'A'
       AND sysdate BETWEEN t.f_ini_disp AND t.f_fin_disp;
    avi_con := '';
    avi_leg := ' <b>AVISO LEGAL:</b> En cumplimiento de lo previsto en la Ley Orgánica 15/1999, de Protección de Datos de Caracter Personal, de 13 de diciembre, le informamos que los datos incluidos en su ficha se integrarán en un fichero titularidad de Diputación General de Aragón, previamente inscrito en la Agencia Española de Protección de Datos. La finalidad del tratamiento es la participación en procesos de provisión de puestos y en su caso realizar el proceso de adjudicación de vacantes, y la destinataria de los datos será la propia Diputación General de Aragón. Igualmente, le informamos que, en todo caso, usted podrá en cualquier momento ejercitar los derechos de acceso, rectificación, cancelación y oposición, que legalmente le corresponden, dirigiéndose por escrito a Diputación General de Aragón, Consejería de Educación, Cultura y Deporte, con domicilio en Parque Empresarial Dinamiza (Recinto Expo) Calle Pablo Ruiz Picasso, 65D 1º 50018, Zaragoza';
    con_par('PA_L_E_ADMIN', l_e_adm, cod_men, men);
    if cod_men <> 0 then
      raise e_salida1;
    end if;
     con_par('PA_L_FEC_NAC', l_e_fec_nac, cod_men, men);
    if cod_men <> 0 then
      raise e_salida1;
    end if;
   /*    v_aud := sigi_t_aud(null, null, 'l_e_adm '||l_e_adm||' '||'l_e_fec_nac '||l_e_fec_nac, null);
    gra_aud(v_aud);*/
  EXCEPTION
    WHEN e_salida1 then
      cod_men := 5;
    when no_data_found THEN
      cod_men := 3;
      men     := 'Aplicación no disponible temporalmente. ';
    WHEN OTHERS THEN
      cod_men := 5;
      men     := $$plsql_line;
      gra_err(men);
  END;
  /*******************************************************/
  /** CARga de las OPCiones del PARticipante            **/
  /** sensible al tipo de login                         **/
  /*******************************************************/
  procedure car_opc_par(v_per       in out SIGI_T_PER,
                        cod_tip_log in varchar2,
                        v_arr_opc   out sigi_array_opc,
                        cod_men     out number,
                        men         out varchar2) is
    cursor c_opc is
      select cod_opc,
             tex_opc,
             tex_opc_cab,
             tex_opc_pdf,
             fec_cur_com,
             l_vis,
             l_act,
             l_pet_mas,
             l_res_vis,
             l_res_act,
             f_ini_opc,
             f_fin_opc,
             'N' l_sel -- por defecto no esta seleccionada
        from sigi_opc o
       where o.l_act = 'S'
         and sysdate between o.f_ini_opc and o.f_fin_opc
       order by tex_opc;

    v_opc c_opc%rowtype;
    e_salida1 exception;
    e_salida9 exception;
    v_con       number := 0;
    v_con_opc   number := 0; -- contador de opciones
    l_act       boolean := false; -- alguna opción activa
    v_l_act     varchar2(1) := 'N'; -- activa o no la opción concreta
    v_l_res_act varchar2(1) := 'N'; -- activo o no la opción de reserva para la persona
  begin
    cod_men   := 0;
    men       := 'OK';
    v_arr_opc := sigi_array_opc(sigi_t_opc(null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null));
    open c_opc;
    loop
      fetch c_opc
        into v_opc;
      exit when c_opc%notfound;
      if v_con > 0 then
        v_arr_opc.extend(1);
      end if;

      v_con     := v_con + 1;
      v_con_opc := 0;
      -- la persona esta PRE seleccionado para un acto de elección
      -- de esa OPC ción
      select count(*)
        into v_con_opc
        from (select a.tipo_id, a.dni, a.cod_opc
                from sigi_can_pre_ae a
              union
              select b.tipo_id, b.dni, b.cod_opc from sigi_par b) u
       where u.tipo_id = v_per.tipo_id
         and u.dni = v_per.dni
         and u.cod_opc = v_opc.cod_opc;

      -- v_l_act := v_opc.l_act;
      -- el tipo de login F echa de nacimiento no da opción a la consulta del participante
      if v_con_opc < 1 or
         (cod_tip_log = 'F' and v_opc.cod_opc in ('SIGISSP', 'SIGIPSP')) then
        v_l_act := 'N';
      else
        v_l_act := 'S';
        l_act   := true;
      end if;
      -- lo opción de reserva esta activa según la persona
      -- tiene que estar visible y activa para la opción
      -- y ademas estar preseleccionado para enseñanzas medias
      if v_opc.l_res_vis = 'S' and v_opc.l_res_act = 'S' then
        v_l_res_act := v_opc.l_res_act;
        begin
          select nvl(c.l_med, 'N')
            into v_l_res_act
            from sigi_can_pre_ae c
           where c.tipo_id = v_per.tipo_id
             and c.dni = v_per.dni
             and c.cod_opc = v_opc.cod_opc;
        exception
          when no_data_found then
            null;
        end;
      end if;
      v_arr_opc(v_arr_opc.last) := sigi_t_opc(v_opc.cod_opc,
                                              v_opc.tex_opc,
                                              v_opc.tex_opc_cab,
                                              v_opc.tex_opc_pdf,
                                              v_opc.fec_cur_com,
                                              v_opc.l_vis,
                                              v_l_act,
                                              v_opc.l_pet_mas,
                                              v_opc.l_res_vis,
                                              v_l_res_act,
                                              v_opc.l_sel);

    end loop;

    close c_opc;
    if not l_act then
      cod_men := 2;
      men     := 'Ninguna opción activa para el usuario';
    end if;

  end;

  /*******************************************************/
  /** CARga de los DATos PERsonales            **/
  /*******************************************************/
  procedure car_dat_per(v_per   in out SIGI_T_PER,
                        cod_err out number,
                        men_err out varchar2) is
    cursor c_dat_per is
      select nom, ape_1, ape_2
        from sigi_per p
       where p.tipo_id = v_per.tipo_id
         and p.dni = v_per.dni;
    v_dat_per c_dat_per%rowtype;
    l_act     boolean := false;
    e_salida1 exception;
    e_salida9 exception;
    cont number;
  begin
    cod_err := 0;
    men_err := 'OK';
    open c_dat_per;
    loop
      fetch c_dat_per
        into v_dat_per;
      exit when c_dat_per%notfound;
      v_per.nom   := v_dat_per.nom;
      v_per.ape_1 := v_dat_per.ape_1;
      v_per.ape_2 := v_dat_per.ape_2;
      l_act       := true;
    end loop;
    close c_dat_per;
    if not l_act then
      cod_err := 2;
      men_err := 'Ningun dato personal';
    end if;
  end;

  /******************************************************************************/
  /********************  Validacion del participante (LOGIN) ********************/
  /******************************************************************************/
  PROCEDURE log(v_per     in out sigi_t_per,
                v_arr_opc out sigi_array_opc,
                cod_men   out number,
                men       out varchar2) is
    e_salida1 exception;
    e_salida2 exception;
    v_tra varchar2(2000);
    v_aud sigi_t_aud;
    -- indica si el login es correcto y el tipo de login
    cod_tip_log varchar2(1) := 'N'; -- (N,E,F,P) login No, E e-dni , F echa nacimiento , P assword
    v_fec       varchar2(10);
    cod_err_p   number := 0;
    men_err_p   varchar2(200);
    cont        number;
  BEGIN
    cod_men := 0;
    men     := 'OK';
    -- correcto para e-dni o (tipo_id + dni + (al menos f_nac o pas))
    if nvl(v_per.l_cer, 'N') = 'S' and v_per.dni is not null then
      cod_tip_log := 'E'; -- login correcto electronico
    end if;
    -- comprobación de datos de entrada
    if cod_tip_log = 'N' then
      if v_per is null then
        v_tra := 'llega v_per vacia';
        raise e_salida2;
      end if;
      if v_per.dni is null then
        v_tra := 'llega dni nulo';
        raise e_salida2;
      end if;
      if nvl(v_per.l_cer, 'N') = 'N' and v_per.tipo_id is null then
        v_tra := 'llega tipo de identificador nulo y no se ha logeado con e-dni';
        raise e_salida2;
      end if;
      if nvl(v_per.l_cer, 'N') = 'N' and
         (v_per.f_nac is null and v_per.pas is null) then
        v_tra := 'llega tipo de fecha de nacimiento y contraseña nulo y no se ha logeado con e-dni';
        raise e_salida2;
      end if;
      -- comprobando contraseña correcta
      if v_per.pas is not null then
        begin
          pkb_mant_partic_psw.comprueba_clave(v_per.tipo_id,
                                              v_per.dni,
                                              v_per.pas,
                                              cod_err_p,
                                              men_err_p);
          if cod_err_p = 0 then
            cod_tip_log := 'P'; -- Identificación Correcta, password
          else
            v_tra := cod_err_p || ' ' || men_err_p;
          end if;
        exception
          when no_data_found then
            v_tra := 'Participante con contraseña sale por no_data_found ';
        end;
      end if;
     /* v_aud := sigi_t_aud(v_per.tipo_id,
                          v_per.dni,
                          'fecha nacimiento ' || v_per.f_nac,
                          to_char(sysdate, 'dd/mm/rrrr'));
      gra_aud(v_aud);*/
      if cod_tip_log = 'N' then
        if v_per.f_nac is not null then
          begin
            select to_char(p.f_nac, 'dd/mm/rrrr')
              into v_fec
              from sigi_per p
             where to_char(f_nac, 'dd/mm/rrrr') = v_per.f_nac
               and tipo_id = v_per.tipo_id
               and dni = v_per.dni;
            cod_tip_log := 'F'; -- Identificación Correcta, Fecha nacimiento
            v_aud       := sigi_t_aud(v_per.tipo_id,
                                      v_per.dni,
                                      'fecha nacimiento ' || v_fec,
                                      sysdate);
          exception
            when no_data_found then
              v_tra := v_tra ||
                       ' Participante sin fecha nacimiento correcta';
          end;
        end if;
      end if;
    end if;
    -- si el login es correcto
    if cod_tip_log <> 'N' then
      car_opc_par(v_per, cod_tip_log, v_arr_opc, cod_men, men);
      if cod_men = 2 then
        v_tra := v_tra || ' ' || men;
        raise e_salida2; -- login correcto pero ninguna opción a usar
      end if;
      -- cargo los datos
      car_dat_per(v_per, cod_men, men);
      if v_per.pas is not null then
        v_per.l_pass := 'S';
      end if;
    else
      raise e_salida2;
    end if;
    v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'Tipo de login ' || cod_tip_log,
                        null);
    gra_aud(v_aud);
  exception
    when e_salida2 then
      v_aud := sigi_t_aud(v_per.tipo_id, v_per.dni, v_tra, null);
      gra_aud(v_aud);
      cod_men := 2;
      men     := 'El solicitante no está habilitado para acceder a la aplicación o está mal identificado.';
    when others then
      cod_men := 5;
      gra_err(men);
  end;
  /******************************************************************************/
  /* CAR ga de los DAT os PER sonales para SIT uación del participante************/
  /******************************************************************************/
  procedure car_dat_per_sit(v_per   in out SIGI_T_PER,
                            v_opc   in sigi_opc.cod_opc%type,
                            cod_men out number,
                            men     out varchar2) is
  begin
    cod_men := 0;
    men     := 'OK';
    select a.nom,
           a.ape_1,
           a.ape_2,
           to_char(c.f_ini_per, 'DD/MM/RRRR'),
           c.est_per,
           c.des_cau_est_per
      into v_per.nom,
           v_per.ape_1,
           v_per.ape_2,
           v_per.f_ini_per,
           v_per.est_per,
           v_per.d_causa_est_per
      from sigi_per a, sigi_par c
     where a.tipo_id = v_per.tipo_id
       and a.dni = v_per.dni
       and a.tipo_id = c.tipo_id
       and a.dni = c.dni
       and c.cod_opc = v_opc;

    select to_char(o.f_ini_opc, 'DD/MM/RRRR hh24:mi')
      into v_per.f_rep
      from sigi_opc o
     where o.cod_opc = v_opc;

  exception
    when others then
      cod_men := 5;
      men     := 'Error otro en car_dat_per_sit ' || ' ' || cod_men ||
                 ' car_dat_per_sit others ' ||
                 sys.DBMS_UTILITY.format_error_backtrace;
      gra_err(men);
  end;
  /******************************************************************************/
  /* CAR ga de la información de la tabla sigi_con_pre CON dición para estar en **/
  /* en lista PRE ferente  para el pdf                                             *******/
  /******************************************************************************/
  function f_car_con_pre_pdf(v_per     in SIGI_T_PER,
                             v_cod_cue in varchar2,
                             v_cod_esp in varchar2,
                             cod_men   out number,
                             men       out varchar2) return varchar2 is
    v_tex varchar2(1000);
  begin
    cod_men := 0;
    men     := 'OK';
    if v_cod_cue = '0590' and
       v_cod_esp in ('004', '005', '006', '010', '018') then
      select /*'<br> NOTAS:*/
       '<br> Ultima oposición: convocatoria en curso <br> Penúltima oposición: ' ||
       decode(c.fec_opo1,
              'NC',
              'no convocada',
              c.fec_opo1 ||
              decode(c.not1, 'NP', ' no presentado', ' nota:' || c.not1) ||
              ' <br> Antepenúltima oposición: ' ||
              decode(c.fec_opo2,
                     'NC',
                     'no convocada',
                     c.fec_opo2 || decode(c.not2,
                                          'NP',
                                          ' no presentado',
                                          ' nota:' || c.not2)))
        into v_tex
        from sigi_con_pre c
       where c.dni = v_per.dni
         and c.cod_cue = v_cod_cue
         and c.cod_esp = v_cod_esp;
    else
      select /*'<br> NOTAS:*/
       '<br> Ultima oposición: ' ||
       decode(c.fec_opo1,
              'NC',
              'no convocada',
              c.fec_opo1 ||
              decode(c.not1, 'NP', ' no presentado', ' nota:' || c.not1) ||
              ' <br> Penúltima oposición: ' ||
              decode(c.fec_opo2,
                     'NC',
                     'no convocada',
                     c.fec_opo2 || decode(c.not2,
                                          'NP',
                                          ' no presentado',
                                          ' nota:' || c.not2) ||
                     ' <br> Antepenúltima oposición: ' ||
                     decode(c.fec_opo3,
                            'NC',
                            'no convocada',
                            c.fec_opo3 ||
                            decode(c.not3,
                                   'NP',
                                   ' no presentado',
                                   ' nota:' || c.not3))))
      /*  select 'ultima oposición '||decode(c.fec_opo1, 'NC', 'no convocada', c.fec_opo1 ||decode(c.not1, 'NP', ' no presentado', c.not1)) || ' ' ||
                                           'penultima oposición '||decode(c.fec_opo2, 'NC', 'no convocada', c.fec_opo2 ||decode(c.not2, 'NP', ' no presentado', c.not2)) || ' ' ||
                                           'antepenultima oposición '||decode(c.fec_opo3, 'NC', 'no convocada', c.fec_opo3 ||decode(c.not3, 'NP', ' no presentado', c.not3))
                                   */ /*    select decode(c.fec_opo1,'NC','no convocada',c.fec_opo1) || ' ' ||decode(c.not1,'NP','no presentado',c.not1) || ' ' ||
                                               decode(c.fec_opo2,'NC','no convocada',c.fec_opo2) || ' ' ||decode(c.not2,'NP','no presentado',c.not2) || ' ' ||
                                               decode(c.fec_opo3,'NC','no convocada',c.fec_opo3) || ' ' ||decode(c.not3,'NP','no presentado',c.not3) */
        into v_tex
        from sigi_con_pre c
       where c.dni = v_per.dni
         and c.cod_cue = v_cod_cue
         and c.cod_esp = v_cod_esp;
    end if;
    return v_tex;
  exception
    when no_data_found then
      return 'sin datos para ' || v_per.dni || ' ' || v_cod_cue || ' ' || v_cod_esp;
    when others then
      cod_men := 5;
      men     := 'Error en car_con_pre_pdf ' || ' ' || cod_men ||
                 ' car_con_pre_pdf others ' ||
                 sys.DBMS_UTILITY.format_error_backtrace;
      gra_err(men);
  end;
  /******************************************************************************/
  /* CAR ga de la información de la tabla sigi_con_pre CON dición para estar en **/
  /* en lista PRE ferente                                                  *******/
  /******************************************************************************/
  function f_car_con_pre(v_per     in SIGI_T_PER,
                         v_cod_cue in varchar2,
                         v_cod_esp in varchar2,
                         cod_men   out number,
                         men       out varchar2) return varchar2 is
    v_tex varchar2(1000);
  begin
    cod_men := 0;
    men     := 'OK';

    if v_cod_cue = '0590' and
       v_cod_esp in ('004', '005', '006', '010', '018') then
      select /*'<br> NOTAS:*/
       ' NOTAS: Ultima oposición: convocatoria en curso ; Penúltima oposición: ' ||
       decode(c.fec_opo1,
              'NC',
              'no convocada',
              c.fec_opo1 ||
              decode(c.not1, 'NP', ' no presentado', ' nota:' || c.not1) ||
              ' ; Antepenúltima oposición: ' ||
              decode(c.fec_opo2,
                     'NC',
                     'no convocada',
                     c.fec_opo2 || decode(c.not2,
                                          'NP',
                                          ' no presentado',
                                          ' nota:' || c.not2)))
        into v_tex
        from sigi_con_pre c
       where c.dni = v_per.dni
         and c.cod_cue = v_cod_cue
         and c.cod_esp = v_cod_esp;
    else
      select ' NOTAS: Ultima oposición: ' ||
             decode(c.fec_opo1,
                    'NC',
                    'no convocada',
                    c.fec_opo1 || decode(c.not1,
                                         'NP',
                                         ' no presentado',
                                         ' nota:' || c.not1) ||
                    '; Penúltima oposición: ' ||
                    decode(c.fec_opo2,
                           'NC',
                           'no convocada',
                           c.fec_opo2 ||
                           decode(c.not2,
                                  'NP',
                                  ' no presentado',
                                  ' nota:' || c.not2) ||
                           '; Antepenúltima oposición: ' ||
                           decode(c.fec_opo3,
                                  'NC',
                                  'no convocada',
                                  c.fec_opo3 ||
                                  decode(c.not3,
                                         'NP',
                                         ' no presentado',
                                         ' nota:' || c.not3))))
      /*  select 'ultima oposición '||decode(c.fec_opo1, 'NC', 'no convocada', c.fec_opo1 ||decode(c.not1, 'NP', ' no presentado', c.not1)) || ' ' ||
                                       'penultima oposición '||decode(c.fec_opo2, 'NC', 'no convocada', c.fec_opo2 ||decode(c.not2, 'NP', ' no presentado', c.not2)) || ' ' ||
                                       'antepenultima oposición '||decode(c.fec_opo3, 'NC', 'no convocada', c.fec_opo3 ||decode(c.not3, 'NP', ' no presentado', c.not3))
                               */ /*    select decode(c.fec_opo1,'NC','no convocada',c.fec_opo1) || ' ' ||decode(c.not1,'NP','no presentado',c.not1) || ' ' ||
                                           decode(c.fec_opo2,'NC','no convocada',c.fec_opo2) || ' ' ||decode(c.not2,'NP','no presentado',c.not2) || ' ' ||
                                           decode(c.fec_opo3,'NC','no convocada',c.fec_opo3) || ' ' ||decode(c.not3,'NP','no presentado',c.not3) */
        into v_tex
        from sigi_con_pre c
       where c.dni = v_per.dni
         and c.cod_cue = v_cod_cue
         and c.cod_esp = v_cod_esp;
    end if;
    return v_tex;
  exception
    when no_data_found then
      return 'sin datos para ' || v_per.dni || ' ' || v_cod_cue || ' ' || v_cod_esp;
    when others then
      cod_men := 5;
      men     := 'Error en car_con_pre ' || ' ' || cod_men ||
                 ' car_con_pre others ' ||
                 sys.DBMS_UTILITY.format_error_backtrace;
      gra_err(men);
  end;
  /******************************************************************************/
  /* CAR ga de los DAT os de LIS tas para SIT uación del participante************/
  /******************************************************************************/
  procedure car_dat_lis_sit(v_per     in SIGI_T_PER,
                            v_opc     in sigi_opc.cod_opc%type,
                            v_arr_lis out sigi_array_lis,
                            cod_men   out number,
                            men       out varchar2) is
    Cursor c_sigi_lis is
      select distinct cod_cue,
                      cod_esp,
                      cod_cue || ' - ' || c.dcuerpo des_cue,
                      cod_esp || ' -  ' || despec des_esp,
                      tip_lis tip_lis,
                      'lista ' || tip_lis des_tip_lis,
                      to_char(to_date(fec_ori_blo, 'rrrrmmdd'),
                              'dd/mm/rrrr') fec_ori_blo,
                      cod_blo des_blo,
                      num_ord num_ord_blo,
                      res_tot pun,
                      des_pro_ref pro_ref,
                      cod_est des_est,
                      des_cau_est des_cau_est,
                      to_char(fec_ini_est, 'dd/mm/rrrr') fec_est_lis,
                      des_pro_1_sus des_pro_sus_1,
                      to_char(fec_pro_1_sus, 'dd/mm/rrrr') fec_pro_sus_1,
                      des_pro_2_sus des_pro_sus_2,
                      to_char(fec_pro_2_sus, 'dd/mm/rrrr') fec_pro_sus_2,
                      l.ord_dis_za,
                      l.ord_dis_hu,
                      l.ord_dis_te,
                      l.ord_ccao
        from sigi_lis l, cuerpos c, especialidades e
       where l.cod_cue = c.ccodcu
         and l.cod_esp = e.cespec
         and c.ccodcu = e.ccodcu
         and tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and l.cod_opc = v_opc
       order by des_cue, des_esp;
    v_sigi_lis   c_sigi_lis%rowtype;
    cont         number := 0;
    v_sigi_t_lis sigi_t_lis;
    v_des_blo    varchar2(1000);
  BEGIN
    cod_men   := 0;
    men       := 'OK';
    v_arr_lis := sigi_array_lis(sigi_t_lis(null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null,
                                           null));
    open c_sigi_lis;
    loop
      fetch c_sigi_lis
        into v_sigi_lis;
      exit when c_sigi_lis%notfound;
      if cont > 0 then
        v_arr_lis.extend(1);
      end if;
      cont := cont + 1;
      v_des_blo := v_sigi_lis.des_blo ||
                   f_car_con_pre(v_per,
                                 v_sigi_lis.cod_cue,
                                 v_sigi_lis.cod_esp,
                                 cod_men,
                                 men);
      v_arr_lis(v_arr_lis.last) := sigi_t_lis(v_sigi_lis.des_cue,
                                              v_sigi_lis.des_esp,
                                              v_sigi_lis.des_tip_lis,
                                              v_sigi_lis.fec_ori_blo,
                                              --v_sigi_lis.des_blo,
                                              v_des_blo,
                                              v_sigi_lis.num_ord_blo,
                                              v_sigi_lis.pun,
                                              v_sigi_lis.pro_ref,
                                              v_sigi_lis.des_est,
                                              v_sigi_lis.des_cau_est,
                                              v_sigi_lis.fec_est_lis,
                                              v_sigi_lis.des_pro_sus_1,
                                              v_sigi_lis.fec_pro_sus_1,
                                              v_sigi_lis.des_pro_sus_2,
                                              v_sigi_lis.fec_pro_sus_2,
                                              v_sigi_lis.ord_dis_za,
                                              v_sigi_lis.ord_dis_hu,
                                              v_sigi_lis.ord_dis_te,
                                              v_sigi_lis.ord_ccao);

    end loop;
    close c_sigi_lis;
  exception
    when others then
      cod_men := 5;
      men     := 'Error otro en car_dat_lis_sit ' || ' ' || cod_men ||
                 ' car_dat_lis_sit others ' ||
                 sys.DBMS_UTILITY.format_error_backtrace;
      gra_err(men);
  end;
  /*******************************************************************************/
  /*   CAR ga las ESP ecialidades que la persona puede pedir de forma masiva       */
  /*******************************************************************************/
  procedure car_esp(v_per     in SIGI_T_PER,
                    v_opc     in sigi_opc.cod_opc%type,
                    v_arr_esp out sigi_array_esp_par,
                    cod_men   out number,
                    men       out varchar2) is
    cursor c_esp is
      select e.cod_esp
        from sigi_esp_can_pre_ae e
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and e.cod_opc = v_opc;
    v_esp c_esp%rowtype;
    v_aux number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men   := 0;
    men       := 'OK';
    v_arr_esp := sigi_array_esp_par();
    open c_esp;
    loop
      fetch c_esp
        into v_esp;
      exit when c_esp%notfound;
      v_arr_esp.extend(1);
      v_arr_esp(v_arr_esp.last) := v_esp.cod_esp;
      v_aux := v_aux + 1;
    end loop;
    close c_esp;
    if v_aux = 0 then
      v_arr_esp := null;
      raise e_salida1;
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para errores controlados
      cod_men := 1;
      men     := 'codigo mensaje--> ' || cod_men;
      gra_err(men);
    When others then
      cod_men := 1;
      men     := ' when others codigo mensaje--> ' || cod_men;
      gra_err(men);
  end;
  /***********************************************************************/
  /** Procedimiento CAR ga VAC antes que puede pedir el PAR ticipante  **/
  /** sensible a colectivo de preseleccionado en acto de elección de funcionario **/
  /** y a las suspensiones en los actos de eleccion de interinos semanales **/
  /*************************************************************************/
  procedure car_vac_par(v_per         in sigi_t_per,
                        v_opc         in sigi_opc.cod_opc%type,
                        v_arr_vac_par out sigi_array_vac_par,
                        cod_men       out number,
                        men           out varchar2) is
    -- Vacantes para funcionarios no del colectivo 6 e interinos de inicio de curso
    cursor c_vac is
      select num_vac ||
             substr('TRWAGMYFPDXBNJZSQVHLCKE', mod(num_vac, 23) + 1, 1) num_vac_let,
             num_vac
        from sigi_vac v, sigi_esp_can_pre_ae e
       where v.cod_opc = e.cod_opc
         and v.cod_cue = e.cod_cue
         and v.cod_esp = e.cod_esp
         and e.tipo_id = v_per.tipo_id
         and e.dni = v_per.dni
         and e.cod_opc = v_opc
       order by to_number(num_vac);
    v_vac c_vac%rowtype;
    -- en los actos de elección de funcionarios los del colectivo 6 no pueden pedir vacantes de
    -- la misma localidad (era municipio hasta 2012)
    cursor c_vac_col_6 is
      select num_vac ||
             substr('TRWAGMYFPDXBNJZSQVHLCKE', mod(num_vac, 23) + 1, 1) num_vac_let,
             num_vac
        from sigi_vac v, sigi_esp_can_pre_ae e, sigi_can_pre_ae c
       where v.cod_opc = e.cod_opc
         and e.tipo_id = c.tipo_id
         and e.dni = c.dni
         and v.cod_cue = e.cod_cue
         and v.cod_esp = e.cod_esp
         and c.cod_mun <> v.cod_mun_vac
         and e.tipo_id = v_per.tipo_id
         and e.dni = v_per.dni
         and e.cod_opc = v_opc
       order by to_number(num_vac);
    v_vac_col_6 c_vac_col_6%rowtype;
    l_col_6     varchar2(1);
    -- vacantes para actos de eleccion semanales
    -- lista de vacantes que puede pedir una persona en un AE semanal
    -- son las de las especialidades por las que esta convocado
    -- menos las de S ustitución en el caso de que este suspendido
    -- a nivel de la lista  o
    -- este suspendido a nivel de provincia para la provincia de la vacante
    -- las vacantes de curso completo cuando el acto de elección es superior a
    -- la fecha de curso completo(31/10/ año inicio curso )
    -- tienen la consideración de S ustitución
    cursor c_vac_sem is
      select num_vac ||
             substr('TRWAGMYFPDXBNJZSQVHLCKE', mod(num_vac, 23) + 1, 1) num_vac_let,
             num_vac
        from sigi_vac            v,
             sigi_esp_can_pre_ae e,
             sigi_can_pre_ae     c,
             sigi_opc            o
       where v.cod_opc = e.cod_opc
         and e.tipo_id = c.tipo_id
         and e.dni = c.dni
         and v.cod_cue = e.cod_cue
         and v.cod_esp = e.cod_esp
         and e.tipo_id = v_per.tipo_id
         and e.dni = v_per.dni
         and e.cod_opc = v_opc
         and e.cod_opc = o.cod_opc
         and not ((v.cod_tip_dur = 'S' or
              (v.cod_tip_dur = 'C' and
              --              o.f_con_ae > to_date(o.fec_cur_com))) and
              o.f_con_ae > to_date(o.fec_cur_com, 'dd/mm/rrrr'))) and
              (e.l_lis_sus = 'S' or
              nvl(e.cod_pro_1_sus, 'X') = substr(v.cod_mun_vac, 1, 2) or
              nvl(e.cod_pro_2_sus, 'X') = substr(v.cod_mun_vac, 1, 2)))
         and e.cod_opc = c.cod_opc
       order by to_number(num_vac);
    v_vac_sem c_vac_sem%rowtype;
    l_sem     varchar2(1);
    v_aux     number := 0;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    v_aud sigi_t_aud;
  begin
    cod_men := 0;
    men     := 'OK';
    l_col_6 := 'N';
    -- consulto el colectivo del candidato
    begin
      select decode(nvl(c.cod_col, '0'), '6', 'S', 'N')
        into l_col_6
        from sigi_can_pre_ae c
       where c.tipo_id = v_per.tipo_id
         and c.dni = v_per.dni
         and c.cod_opc = v_opc;
    end;
    -- consulto el tipo de acto de eleccion
    begin
      select decode(o.cod_tip_ae, 'S', 'S', 'N')
        into l_sem
        from sigi_opc o
       where o.cod_opc = v_opc;
    end;
    v_arr_vac_par := sigi_array_vac_par();
    if l_col_6 = 'S' then
      open c_vac_col_6;
      loop
        fetch c_vac_col_6
          into v_vac_col_6;
        exit when c_vac_col_6%notfound;
        v_arr_vac_par.extend(1);
        v_arr_vac_par(v_arr_vac_par.last) := v_vac_col_6.num_vac;
        v_aux := v_aux + 1;
      end loop;
      close c_vac_col_6;
    elsif l_sem = 'S' then
      open c_vac_sem;
      loop
        fetch c_vac_sem
          into v_vac_sem;
        exit when c_vac_sem%notfound;
        v_arr_vac_par.extend(1);
        v_arr_vac_par(v_arr_vac_par.last) := v_vac_sem.num_vac;
        v_aux := v_aux + 1;
      end loop;
      close c_vac_sem;
    else
      open c_vac;
      loop
        fetch c_vac
          into v_vac;
        exit when c_vac%notfound;
        v_arr_vac_par.extend(1);
        v_arr_vac_par(v_arr_vac_par.last) := v_vac.num_vac;
        v_aux := v_aux + 1;
      end loop;
      close c_vac;
    end if;
    if v_aux = 0 then
      v_arr_vac_par := null;
      raise e_salida1;
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para errores controlados
      cod_men := 1;
      men     := 'codigo mensaje--> ' || cod_men ||' col_6 '||l_col_6||' semanal '||l_sem;
      gra_err(men);
    When others then
      cod_men := 1;
      men     := ' when others codigo mensaje--> ' || cod_men || ' ' ||
                 v_aux;
      gra_err(men);
  end;
  /************************************************************************/
  /*   Comprueba si la opción esta cerrada                         */
  /*******************************************************************************/
  function f_opc_cerrada(v_opc   sigi_opc.cod_opc%type,
                         cod_men out number,
                         men     out varchar2) return boolean is
    v_t_opc sigi_t_opc;
    v_con   number := 0;
    e_salida2 exception;
    v_aux varchar2(1);
  begin
    cod_men := 0;
    men     := 'OK';
    select 1
      into v_aux
      from sigi_opc o
     where o.cod_opc = v_opc
       and o.f_fin_opc > sysdate;
    return false;
  exception
    when no_data_found then
      return true;
    When others then
      cod_men := 1;
      men     := ' f_opc_cerrada when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /************************************************************************/
  /*   BUS ca la OPC ión seleccionada en el array de opciones             */
  /*******************************************************************************/
  procedure bus_opc(v_arr_opc in sigi_array_opc,
                    v_opc     out sigi_opc.cod_opc%type,
                    cod_men   out number,
                    men       out varchar2) is
    v_t_opc sigi_t_opc;
    v_con   number := 0;
    e_salida2 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    -- compruebo que llega una y solo una opción seleccionada
    if v_arr_opc is null then
      men := 'llega v_arr_opc vacia';
      raise e_salida2;
    end if;
    for i in v_arr_opc.first .. v_arr_opc.last loop
      v_t_opc := v_arr_opc(i);
      if v_t_opc.l_sel = 'S' then
        v_opc := v_t_opc.cod_opc;
        v_con := v_con + 1;
      end if;
    end loop;
    if v_con > 1 then
      men := 'mas de una opción marcada como seleccionada';
      raise e_salida2;
    end if;
    if v_con < 1 then
      men := 'ninguna opción marcada como seleccionada';
      raise e_salida2;
    end if;
  exception
    When e_salida2 then
      -- Esta excepcion es para errores controlados
      cod_men := 2;
      men     := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
    When others then
      cod_men := 1;
      men     := ' when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************************************/
  /*   CARga por la OPCcion seleccionada la información relevante                */
  /*   para esa opción de la persona logeada                                     */
  /*******************************************************************************/
  Procedure car_opc(v_per         in out SIGI_T_PER,
                    v_arr_opc     in sigi_array_opc,
                    v_arr_lis     out sigi_array_lis,
                    v_arr_esp     out sigi_array_esp_par,
                    v_arr_vac_par out sigi_array_vac_par,
                    cod_men       out number,
                    men           out varchar2) is
    e_salida1 exception;
    e_salida9 exception;
    v_aud sigi_t_aud;
    v_opc sigi_opc.cod_opc%type;
    v_con number := 0;
  begin
    cod_men := 0;
    men     := 'OK';
    if v_per is null then
      men := 'llega v_per vacia';
      raise e_salida1;
    end if;
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida1;
    end if;
    if v_opc in ('SIGISSP', 'SIGIPSP') then
      car_dat_per_sit(v_per, v_opc, cod_men, men);
      car_dat_lis_sit(v_per, v_opc, v_arr_lis, cod_men, men);
    elsif v_opc in ('SIGISAE', 'SIGIPAE') THEN
      car_esp(v_per, v_opc, v_arr_esp, cod_men, men);
      car_vac_par(v_per, v_opc, v_arr_vac_par, cod_men, men);
    end if;
    --  v_arr_vac_par := sigi_array_vac_par('12','13','14');
    v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'Opción seleccionada ' || v_opc,
                        null);
    gra_aud(v_aud);
  exception
    when e_salida1 then
      v_aud := sigi_t_aud(v_per.tipo_id, v_per.dni, men, null);
      gra_aud(v_aud);
      men     := 'codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      cod_men := 9;
      gra_err(men);
    when others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /****************************************************/
  /*   CAR ga EST ado de la PET ición                 */
  /****************************************************/
  Procedure car_est_pet(p_est   out sigi_array_est_pet,
                        cod_men out number,
                        men     out varchar2) is
    cursor c_est_pet is
      select e.cod_est_pet, e.des_est_pet
        from sigi_est_pet e
       order by cod_est_pet;
    v_est c_est_pet%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    p_est   := sigi_array_est_pet();
    open c_est_pet;
    loop
      fetch c_est_pet
        into v_est;
      exit when c_est_pet%notfound;
      p_est.extend(1);
      p_est(p_est.last) := sigi_t_est_pet(v_est.cod_est_pet,
                                          v_est.des_est_pet);
      aux := aux + 1;
    end loop;
    close c_est_pet;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;

  -- Quique 02/12/2014
  /**************************************************************/
  /** Procedimiento CAR ga la PRE sentación de SOL icitude al AE
  /**************************************************************/
  Procedure car_pre_sol_ae(v_per       in SIGI_T_PER,
                           v_cod_sol   in varchar2,
                           v_opc       in sigi_opc.cod_opc%type,
                           p_l_pre     out sigi_sol.l_pre%type,
                           p_f_hor_pre out varchar2,
                           cod_men     out number,
                           men         out varchar2) is
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    select r.l_pre, to_char(r.f_hor_pre, 'dd/mm/rrrr HH24:MI:SS')
      into p_l_pre, p_f_hor_pre
      from sigi_sol r
     where tipo_id = v_per.tipo_id
       and dni = v_per.dni
       and r.cod_sol = v_cod_sol
       and r.cod_opc = v_opc;
  Exception
    When others then
      --p_res := 'N';
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  -- fin quique 02/12/2014
  /*******************************************************/
  /** Procedimiento CAR ga la RES erva de la SOL icitud   **/
  /*******************************************************/
  Procedure car_res_sol(v_per     in SIGI_T_PER,
                        v_cod_sol in varchar2,
                        v_opc     in sigi_opc.cod_opc%type,
                        p_res     out varchar2,
                        cod_men   out number,
                        men       out varchar2) is
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    select 'S'
      into p_res
      from sigi_res r
     where tipo_id = v_per.tipo_id
       and dni = v_per.dni
       and r.cod_sol = v_cod_sol
       and r.cod_opc = v_opc;
  Exception
    when no_data_found then
      --  p_res := 'N';
      p_res := null;
    When others then
      --p_res := 'N';
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento CAR ga PET iciones de la SOL icitud **/
  /*******************************************************/
  Procedure car_pet_sol(v_per     in SIGI_T_PER,
                        v_cod_sol in varchar2,
                        v_opc     in sigi_opc.cod_opc%type,
                        p_pet     out sigi_array_vac,
                        cod_men   out number,
                        men       out varchar2) is
    cursor c_pet is
      select p.num_vac, p.ord_pre
        from sigi_pet p
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and p.cod_sol = v_cod_sol
         and p.cod_opc = v_opc
       order by ord_pre;
    v_pet c_pet%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
    p_res varchar2(1);
  begin
    cod_men := 0;
    men     := 'OK';
    p_pet   := sigi_array_vac();
    open c_pet;
    loop
      fetch c_pet
        into v_pet;
      exit when c_pet%notfound;
      p_pet.extend(1);
      p_pet(p_pet.last) := sigi_t_vac(v_pet.ord_pre, v_pet.num_vac, '0');
      aux := aux + 1;
    end loop;
    close c_pet;
    if aux = 0 then
      v_pet := null;
      -- puede tener reserva
      car_res_sol(v_per, v_cod_sol, v_opc, p_res, cod_men, men);
      if cod_men = 9 then
        raise e_salida9;
      end if;
      if nvl(p_res, 'N') <> 'S' then
        men := 'Solicitud de ' || v_per.dni ||
               ' para el código de solicitud ' || v_cod_sol ||
               ' sin peticiones';
        raise e_salida1;
      end if;
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := 'codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento CAR ga ESP ecialidades masivas     **/
  /** de la SOL icitud                                 **/
  /*******************************************************/
  Procedure car_esp_sol(v_per     in SIGI_T_PER,
                        v_cod_sol in varchar2,
                        v_opc     in sigi_opc.cod_opc%type,
                        p_esp     out sigi_array_esp,
                        cod_men   out number,
                        men       out varchar2) is
    cursor c_esp is
      select e.cod_esp, e.ord_esp
        from sigi_pet_esp e
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and e.cod_sol = v_cod_sol
         and e.cod_opc = v_opc
       order by e.ord_esp;
    v_esp c_esp%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    p_esp   := sigi_array_esp();
    open c_esp;
    loop
      fetch c_esp
        into v_esp;
      exit when c_esp%notfound;
      p_esp.extend(1);
      p_esp(p_esp.last) := v_esp.cod_esp;
      aux := aux + 1;
    end loop;
    close c_esp;
    if aux = 0 then
      v_esp := null;
      /*     men   := 'Solicitud de ' || v_per.dni ||
               ' para el código de solicitud ' || v_cod_sol ||
               ' sin peticiones';
      raise e_salida1;*/
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := 'codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento CAR ga PRO vincias masivas          **/
  /** de la SOL icitud                                 **/
  /*******************************************************/
  Procedure car_pro_sol(v_per     in SIGI_T_PER,
                        v_cod_sol in varchar2,
                        v_opc     in sigi_opc.cod_opc%type,
                        p_pro     out sigi_array_pro,
                        cod_men   out number,
                        men       out varchar2) is
    cursor c_pro is
      select p.cod_pro, p.ord_pro
        from sigi_pet_pro p
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and p.cod_sol = v_cod_sol
         and p.cod_opc = v_opc
       order by p.ord_pro;
    v_pro c_pro%rowtype;
    aux   number := 0;
    e_salida1 exception;
    e_salida9 exception;
  begin
    cod_men := 0;
    men     := 'OK';
    p_pro   := sigi_array_pro();
    open c_pro;
    loop
      fetch c_pro
        into v_pro;
      exit when c_pro%notfound;
      p_pro.extend(1);
      p_pro(p_pro.last) := v_pro.cod_pro;
      aux := aux + 1;
    end loop;
    close c_pro;
    if aux = 0 then
      v_pro := null;
      /*      men   := 'Solicitud de ' || v_per.dni ||
               ' para el código de solicitud ' || v_cod_sol ||
               ' sin peticiones';
      raise e_salida1;*/
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := 'codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*********************************************************************************/
  /** Procedimiento CAR ga si se grabo en REG istro TEL emático la SOL icitud     **/
  /*********************************************************************************/
  procedure car_reg_tel_sol(v_per     in SIGI_T_PER,
                            v_cod_sol in varchar2,
                            v_opc     in sigi_opc.cod_opc%type,
                            p_reg_tel out varchar2,
                            cod_men   out number,
                            men       out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men   := 0;
    men       := 'OK';
    p_reg_tel := 'N';
    select 'S'
      into p_reg_tel
      from sigi_sol_reg r
     where r.tipo_id = v_per.tipo_id
       and r.dni = v_per.dni
       and r.cod_opc = v_opc
       and r.cod_sol = v_cod_sol;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    when no_data_found then
      null;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento EXI ste SOL icitud             **/
  /** comprueba si existe la solicitud             **/
  /*******************************************************/
  procedure exi_sol(v_per     in SIGI_T_PER,
                    v_cod_sol in varchar2,
                    v_sol     in sigi_t_sol,
                    v_opc     in sigi_opc.cod_opc%type,
                    l_exi_sol out varchar2,
                    cod_men   out number,
                    men       out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    select 'S'
      into l_exi_sol
      from sigi_sol s
     where tipo_id = v_per.tipo_id
       and dni = v_per.dni
       and s.cod_opc = v_opc
       and s.cod_sol = v_cod_sol;
  Exception
    when no_data_found then
      l_exi_sol := 'N';
      men       := 'No existe la solicitud ' || v_cod_sol ||
                   ' para el dni ' || v_per.dni || ' en la opción ' ||
                   v_opc;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;

  -- quique 02/12/2014
  /*******************************************************/
  /** Procedimiento COM prueba PRE sentar SOL icitud AE **/
  /*******************************************************/
  Procedure com_pre_sol_ae(p_per   in sigi_t_per,
                           p_opc   in sigi_sol.cod_opc%type,
                           cod_men in out number,
                           men     in out varchar2) is
    v_err_tab varchar2(200) := '**';
    cont      number; -- Contador de registros para solicitudes presentadas
  begin
    cod_men := 0;
    men     := 'OK';
    -- Comprueba si tiene una solicitud presentada en el acto de elección (con contraseña o con certificado)
    select count(*)
      into cont
      from (select tipo_id, dni, cod_opc, cod_sol, f_hor_pre
              from sigi_sol ss
             where ss.f_hor_pre is not null
               and nvl(ss.l_pre, 'X') = 'P'
            union all
            select tipo_id, dni, cod_opc, cod_sol, f_ult_mod
              from sigi_sol_reg) s
     where s.tipo_id = p_per.tipo_id
       and s.dni = p_per.dni
       and s.cod_opc = p_opc;
    -- Tiene al menos una solicitud presentada al acto de elección
    if cont > 0 then
      cont := 1; -- Iniciamos el contador para buscar el primer registro
      for reg in (select s.cod_sol, s.f_hor_pre, s.l_pre
                    from (select tipo_id,
                                 dni,
                                 cod_opc,
                                 cod_sol,
                                 f_hor_pre,
                                 l_pre
                            from sigi_sol ss
                           where ss.f_hor_pre is not null
                             and nvl(ss.l_pre, 'X') = 'P'
                          union all
                          select tipo_id,
                                 dni,
                                 cod_opc,
                                 cod_sol,
                                 f_ult_mod,
                                 null lpre
                            from sigi_sol_reg) s
                   where s.tipo_id = p_per.tipo_id
                     and s.dni = p_per.dni
                     and s.cod_opc = p_opc
                   order by f_hor_pre desc) loop
        if cont = 1 then
          if reg.l_pre is null then
            men := 'La última solicitud presentada al acto de elección es la ' ||
                   reg.cod_sol ||
                   ' presentada con certificado digital el día ' ||
                   to_char(reg.f_hor_pre, 'dd/mm/rrrr HH24:MI:SS') || '. ';
          else
            men := 'La última solicitud presentada al acto de elección es la ' ||
                   reg.cod_sol || ' presentada con contraseña el día ' ||
                   to_char(reg.f_hor_pre, 'dd/mm/rrrr HH24:MI:SS') || '. ';
          end if;
        else
          exit;
        end if;
        cont := cont + 1;
      end loop;
    else
      men := 'No tiene ninguna solicitud grabada presentada al acto de elección. ';
    end if;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || v_err_tab || sqlerrm;
      gra_err(men);
  end;
  -- fin quique 02/12/2014
  /*******************************************************************************/
  /*  BUSca la SOLicitud de la PERsona en la OPCión seleccionada.                */
  /*  si la encuentra carga la SOLicitud si no cod_men                           */
  /*******************************************************************************/
  Procedure bus_sol(v_per     in SIGI_T_PER,
                    v_cod_sol in varchar2,
                    v_sol     out sigi_t_sol,
                    v_arr_opc in sigi_array_opc,
                    v_pre_ae  out varchar2,
                    cod_men   out number,
                    men       out varchar2) is
    v_est_sol   sigi_sol.cod_est_sol%type;
    v_opc       sigi_opc.cod_opc%type;
    l_exi_sol   varchar2(1) := 'N';
    p_pet       sigi_array_vac;
    p_esp       sigi_array_esp;
    p_pro       sigi_array_pro;
    p_res       varchar2(1);
    p_reg_tel   varchar2(1);
    v_l_pre     sigi_sol.l_pre%type;
    v_f_hor_pre varchar2(20);
    e_salida1 exception;
    e_salida2 exception;
    e_salida6 exception;
    e_salida9 exception;
    v_aud sigi_t_aud;
  begin
    cod_men := 0;
    men     := 'OK';
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    /*    v_aud := sigi_t_aud(null,
                        null,
                        'bus_sol ' || v_opc || ' ' || v_cod_sol,
                        null);
    gra_aud(v_aud);*/
    if cod_men <> 0 then
      raise e_salida2;
    end if;
    exi_sol(v_per, v_cod_sol, v_sol, v_opc, l_exi_sol, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    if l_exi_sol = 'N' then
      raise e_salida6; --
    end if;
    -- carga las peticiones
    car_pet_sol(v_per, v_cod_sol, v_opc, p_pet, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- carga las especialidades pedidas de forma masiva
    car_esp_sol(v_per, v_cod_sol, v_opc, p_esp, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- carga las provincias pedidas de forma masiva
    car_pro_sol(v_per, v_cod_sol, v_opc, p_pro, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- carga la reserva
    car_res_sol(v_per, v_cod_sol, v_opc, p_res, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- carga la información de si esta o no presentado por registro telemático
    car_reg_tel_sol(v_per, v_cod_sol, v_opc, p_reg_tel, cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- Carga la información de si esta presentado o no
    -- quique 02/12/2014
    com_pre_sol_ae(v_per, v_opc, cod_men, v_pre_ae);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- Carga si la solicitude esta presentada o no al acto de elección
    car_pre_sol_ae(v_per,
                   v_cod_sol,
                   v_opc,
                   v_l_pre,
                   v_f_hor_pre,
                   cod_men,
                   men);
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- fin quique 02/12/2014
    v_sol := sigi_t_sol(p_pet,
                        p_esp,
                        p_pro,
                        p_res,
                        p_reg_tel,
                        v_l_pre,
                        v_f_hor_pre);
  Exception
    When e_salida1 then
      cod_men := 1;
    when e_salida6 then
      cod_men := 6;
    When e_salida9 then
      -- Esta excepcion es para sacar el mensaje de error en pantalla o en la web
      cod_men := 9;
      men     := men || ' codigo mensaje--> ' || cod_men;
    When others then
      cod_men := 1;
      men     := ' when others codigo mensaje--> ' || cod_men;
      gra_err(men);
  end;
  /**********************************************************/
  /** Procedimiento SOL icitud con IGU ales PET iciones  **/
  /** sale con la primera diferencia                     **/
  /*******************************************************/
  procedure sol_igu_pet(v_per         in SIGI_T_PER,
                        v_cod_sol_mod in varchar2,
                        v_vac         in sigi_array_vac,
                        v_opc         in sigi_opc.cod_opc%type,
                        l_sol_igu     out varchar2,
                        cod_men       out number,
                        men           out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    Cursor c_pet is
      select p.num_vac
        from sigi_pet p
       where p.tipo_id = v_per.tipo_id
         and p.dni = v_per.dni
         and p.cod_sol = v_cod_sol_mod
         and p.cod_opc = v_opc
       order by p.ord_pre;
    v_pet          c_pet%rowtype;
    c_pet_rowcount number;
    v_vac_cvacante varchar2(2);
    v_vac_last     number;
  begin
    cod_men   := 0;
    men       := 'OK';
    l_sol_igu := 'S';
    -- Control sobre las Peticiones
    open c_pet;
    loop
      -- Recorrido de los registros de la tabla
      fetch c_pet
        into v_pet;
      exit when c_pet%notfound or l_sol_igu = 'N';
      c_pet_rowcount := c_pet%rowcount;
      v_vac_cvacante := v_vac(c_pet%rowcount).cvacante;
      if not v_vac.exists(c_pet%rowcount) or
         v_pet.num_vac != nvl(v_vac(c_pet%rowcount).cvacante, 0) then
        l_sol_igu := 'N';
      end if;
    end loop;
    v_vac_last := v_vac.last;
    -- Compruebo que existe la solicitud y que no queden vacantes en el vector
    if l_sol_igu = 'S' and v_vac.last != c_pet%rowcount then
      l_sol_igu := 'N';
    end if;
    close c_pet;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /**********************************************************/
  /** Procedimiento SOL icitud con IGU ales PET iciones  **/
  /** masivas por ESP ecialidad
  /** sale con la primera diferencia                     **/
  /*******************************************************/
  procedure sol_igu_pet_esp(v_per         in SIGI_T_PER,
                            v_cod_sol_mod in varchar2,
                            v_pet_esp     in sigi_array_esp,
                            v_opc         in sigi_opc.cod_opc%type,
                            l_sol_igu     out varchar2,
                            cod_men       out number,
                            men           out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    Cursor c_pet is
      select p.cod_esp
        from sigi_pet_esp p
       where p.tipo_id = v_per.tipo_id
         and p.dni = v_per.dni
         and p.cod_sol = v_cod_sol_mod
         and p.cod_opc = v_opc
       order by p.ord_esp;
    v_pet c_pet%rowtype;
  begin
    cod_men   := 0;
    men       := 'OK';
    l_sol_igu := 'S';
    -- Control sobre las Peticiones masivas por especialidad
    open c_pet;
    loop
      -- Recorrido de los registros de la tabla
      fetch c_pet
        into v_pet;
      exit when c_pet%notfound or l_sol_igu = 'N';
      if not v_pet_esp.exists(c_pet%rowcount) or
         v_pet.cod_esp != nvl(v_pet_esp(c_pet%rowcount), 0) then
        l_sol_igu := 'N';
      end if;
    end loop;
    -- Compruebo que existe la solicitud y que no queden vacantes en el vector
    if l_sol_igu = 'S' and v_pet_esp.last != c_pet%rowcount then
      l_sol_igu := 'N';
    end if;
    close c_pet;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /**********************************************************/
  /** Procedimiento SOL icitud con IGU ales PET iciones  **/
  /** masivas por PRO vincia
  /** sale con la primera diferencia                     **/
  /*******************************************************/
  procedure sol_igu_pet_pro(v_per         in SIGI_T_PER,
                            v_cod_sol_mod in varchar2,
                            v_pet_pro     in sigi_array_pro,
                            v_opc         in sigi_opc.cod_opc%type,
                            l_sol_igu     out varchar2,
                            cod_men       out number,
                            men           out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    Cursor c_pet is
      select p.cod_pro
        from sigi_pet_pro p
       where p.tipo_id = v_per.tipo_id
         and p.dni = v_per.dni
         and p.cod_sol = v_cod_sol_mod
         and p.cod_opc = v_opc
       order by p.ord_pro;
    v_pet c_pet%rowtype;
    --l_sol_i boolean := TRUE;
  begin
    cod_men   := 0;
    men       := 'OK';
    l_sol_igu := 'S';
    -- Control sobre las Peticiones masivas por especialidad
    open c_pet;
    loop
      -- Recorrido de los registros de la tabla
      fetch c_pet
        into v_pet;
      exit when c_pet%notfound or l_sol_igu = 'N';
      if not v_pet_pro.exists(c_pet%rowcount) or
         v_pet.cod_pro != nvl(v_pet_pro(c_pet%rowcount), 0) then
        l_sol_igu := 'N';
      end if;
    end loop;
    -- Compruebo que existe la solicitud y que no queden vacantes en el vector
    if l_sol_igu = 'S' and v_pet_pro.last != c_pet%rowcount then
      l_sol_igu := 'N';
    end if;
    close c_pet;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************************/
  /** Procedimiento SOL icitud con IGU ales en cuanto a RES erva **/
  /** sale con la primera diferencia                             **/
  /****************************************************************/
  procedure sol_igu_res(v_per         in SIGI_T_PER,
                        v_cod_sol_mod in varchar2,
                        v_res         in varchar2,
                        v_opc         in sigi_opc.cod_opc%type,
                        l_sol_igu     out varchar2,
                        cod_men       out number,
                        men           out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    Cursor c_pet is
      select p.cod_est_res
        from sigi_res p
       where p.tipo_id = v_per.tipo_id
         and p.dni = v_per.dni
         and p.cod_sol = v_cod_sol_mod
         and p.cod_opc = v_opc;
    v_pet c_pet%rowtype;
  begin
    cod_men   := 0;
    men       := 'OK';
    l_sol_igu := 'S';
    -- Control sobre la Reserva
    open c_pet;
    fetch c_pet
      into v_pet;
    if (c_pet%found and nvl(v_res, 'N') = 'N') or
       (c_pet%notfound and nvl(v_res, 'N') = 'S') then
      l_sol_igu := 'N';
    end if;
    close c_pet;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;

  /******************************************************************/
  /** Procedimiento SOL icitud IGU al                              **/
  /** comprueba si la solicitud existe y si ha tenido algún cambio **/
  /******************************************************************/
  procedure sol_igu_old(v_per         in SIGI_T_PER,
                        v_cod_sol_mod in varchar2,
                        v_sol         in sigi_t_sol,
                        v_opc         in sigi_opc.cod_opc%type,
                        l_sol_igu     out varchar2,
                        cod_men       out number,
                        men           out varchar2) is
    l_exi_sol varchar2(1) := 'N';
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida2 exception; -- existe la solicitud a modificar y no es igual
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    -- compruebo que existe la solicitud a modificar
    exi_sol(v_per, v_cod_sol_mod, v_sol, v_opc, l_exi_sol, cod_men, men);
    -- ante un error o si no existe la solicitud fuera
    if cod_men = 9 or l_exi_sol = 'N' then
      raise e_salida9;
    end if;
    -- compruebo que las peticiones sean iguales
    sol_igu_pet(v_per,
                v_cod_sol_mod,
                v_sol.cvac,
                v_opc,
                l_sol_igu,
                cod_men,
                men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- si la solicitud tiene distintas peticiones fuera
    if l_sol_igu = 'N' then
      raise e_salida2;
    end if;
    -- compruebo que las especialidades masivas sean iguales
    sol_igu_pet_esp(v_per,
                    v_cod_sol_mod,
                    v_sol.cesp,
                    v_opc,
                    l_sol_igu,
                    cod_men,
                    men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- si la solicitud tiene distintas peticiones fuera
    if l_sol_igu = 'N' then
      raise e_salida2;
    end if;
    -- compruebo que las provincias masivas sean iguales
    sol_igu_pet_pro(v_per,
                    v_cod_sol_mod,
                    v_sol.cpro,
                    v_opc,
                    l_sol_igu,
                    cod_men,
                    men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- si la solicitud tiene distintas peticiones fuera
    if l_sol_igu = 'N' then
      raise e_salida2;
    end if;
    -- compruebo que la reserva sea igual
    sol_igu_res(v_per,
                v_cod_sol_mod,
                v_sol.l_res,
                v_opc,
                l_sol_igu,
                cod_men,
                men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- si la solicitud tiene distintas peticiones fuera
    if l_sol_igu = 'N' then
      raise e_salida2;
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
    When e_salida2 then
      null;
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento que pone la solicitud grabada a un tipo table  **/
  /*******************************************************/
  procedure sol_gra_to_table(v_per         in SIGI_T_PER,
                             v_cod_sol_mod in sigi_sol.cod_sol%type,
                             v_opc         in sigi_opc.cod_opc%type,
                             tab_1         out charTable,
                             cod_men       out number,
                             men           out varchar2) is
    cursor c_sol is
    -- -- 025187215  5102
      select 1 ord, p.ord_pre, to_char(num_vac) val
        from sigi_pet p
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and cod_opc = v_opc
         and cod_sol = v_cod_sol_mod
      union
      select 2 ord, e.ord_esp ord_pre, e.cod_esp val
        from sigi_pet_esp e
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and cod_opc = v_opc
         and cod_sol = v_cod_sol_mod
      union
      select 3 ord, o.ord_pro ord_pre, o.cod_pro val
        from sigi_pet_pro o
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and cod_opc = v_opc
         and cod_sol = v_cod_sol_mod
      union
      select 4 ord, 1 ord_pre, cod_est_res val
        from sigi_res r
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and cod_opc = v_opc
         and cod_sol = v_cod_sol_mod
       order by ord, ord_pre, val;
    v_sol c_sol%rowtype;
  begin
    cod_men := 0;
    men     := 'OK';
    tab_1   := chartable();
    for x in c_sol loop
      tab_1.extend(1);
      -- tab_1(tab_1.last) := x.val;
      tab_1(tab_1.last) := x.ord_pre || x.val;
    end loop;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /*******************************************************/
  /** Procedimiento que pone la solicitud a grabar en un tipo table  **/
  /*******************************************************/
  procedure sol_nue_to_table(v_sol   in sigi_t_sol,
                             tab_2   out charTable,
                             cod_men out number,
                             men     out varchar2) is
  begin
    cod_men := 0;
    men     := 'OK';
    tab_2   := chartable();
    for x in 1 .. v_sol.cvac.count loop
      tab_2.extend(1);
      --tab_2(tab_2.last) := v_sol.cvac(x).cvacante;
      tab_2(tab_2.last) := x || v_sol.cvac(x).cvacante;
    end loop;
    for x in 1 .. v_sol.cesp.count loop
      tab_2.extend(1);
      tab_2(tab_2.last) := x || v_sol.cesp(x);
    end loop;
    for x in 1 .. v_sol.cpro.count loop
      tab_2.extend(1);
      tab_2(tab_2.last) := x || v_sol.cpro(x);
    end loop;
    if v_sol.l_res = 'S' then
      tab_2.extend(1);
      tab_2(tab_2.last) := '1' || v_sol.l_res;
      /* else
      tab_2(tab_2.last) := '1';*/
    end if;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /******************************************************************/
  /** Procedimiento SOL icitud IGU al                              **/
  /** comprueba si la solicitud existe y si ha tenido algún cambio **/
  /** intento hacerlo mas sencillo **/
  /******************************************************************/
  procedure sol_igu(v_per         in SIGI_T_PER,
                    v_cod_sol_mod in varchar2,
                    v_sol         in sigi_t_sol,
                    v_opc         in sigi_opc.cod_opc%type,
                    l_sol_igu     in out varchar2,
                    cod_men       out number,
                    men           out varchar2) is
    tab_1     charTable;
    tab_2     charTable;
    l_tab_igu boolean;
    l_exi_sol varchar2(1) := 'N';
    v_aud     sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida2 exception; -- existe la solicitud a modificar y no es igual
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    -- compruebo que existe la solicitud a modificar
    exi_sol(v_per, v_cod_sol_mod, v_sol, v_opc, l_exi_sol, cod_men, men);
    -- ante un error o si no existe la solicitud fuera
    if cod_men = 9 or l_exi_sol = 'N' then
      raise e_salida9;
    end if;
    -- los datos de la solicitud nueva a grabar a un tipo table
    sol_nue_to_table(v_sol, tab_1, cod_men, men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    -- los datos de la solicitud grabada a un tipo table
    sol_gra_to_table(v_per, v_cod_sol_mod, v_opc, tab_2, cod_men, men);
    -- ante un error fuera
    if cod_men = 9 then
      raise e_salida9;
    end if;
    /*    v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'sol nueva
                        '||tab_to_char(tab_1)||' '||tab_1.count,
                        'sol vieja
                        '||tab_to_char(tab_2)||' '||tab_2.count);
    gra_aud(v_aud);*/
    -- son iguales las tablas ?
    l_tab_igu := tab_1 = tab_2;
    if not l_tab_igu then
      -- son diferentes
      l_sol_igu := 'N';
      raise e_salida2;
    end if;
    /*             v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'l_sol_igu '||l_sol_igu,
                        null);
    gra_aud(v_aud);*/
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
    When e_salida2 then
      null;
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /***************************************************************/
  /** Procedimiento TRA ta A cto de E leccion de FUN cionarios  **/
  /**************************************************************/
  procedure tra_ae_fun(v_per      in SIGI_T_PER,
                       v_f_con_ae sigi_opc.f_con_ae%type,
                       v_mun_vac  sigi_vac.cod_mun_vac%type,
                       cod_men    out number,
                       men        out varchar2) is
    v_aux number;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := '';
    Select 1
      into v_aux
      from sigi_can_pre_ae c
     where c.tipo_id = v_per.tipo_id
       and c.dni = v_per.dni
       and c.cod_col = '6'
       and c.cod_mun = v_mun_vac;
    cod_men := '2';
  Exception
    When no_data_found then
      null;
    When others then
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
  End;
  /***************************************************************/
  /** Procedimiento TRA ta A cto de E leccion de FUN cionarios  **/
  /**************************************************************/
  procedure tra_ae_sem(v_f_con_ae      sigi_opc.f_con_ae%type,
                       v_cod_tip_dur   sigi_vac.cod_tip_dur%type,
                       v_fec_cur_com   sigi_opc.fec_cur_com%type,
                       v_l_lis_sus     sigi_esp_can_pre_ae.l_lis_sus%type,
                       v_cod_pro_1_sus sigi_esp_can_pre_ae.cod_pro_1_sus%type,
                       v_cod_pro_2_sus sigi_esp_can_pre_ae.cod_pro_2_sus%type,
                       v_mun_vac       sigi_vac.cod_mun_vac%type,
                       cod_men         out number,
                       men             out varchar2) is
    v_aux number;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := '';
    if v_cod_tip_dur = 'S' or
       (v_cod_tip_dur = 'C' and v_f_con_ae > v_fec_cur_com) then
      if v_l_lis_sus = 'S' then
        cod_men := '2';
      elsif substr(v_mun_vac, 1, 2) = v_cod_pro_1_sus or
            substr(v_mun_vac, 1, 2) = v_cod_pro_2_sus then
        cod_men := '3';
      end if;
    end if;
  Exception
    When others then
      men := 'Error en el Proc. tra_ae_sem. ' || sqlerrm;
  End;
  /****************************************************************/
  /** Procedimiento VAL ida VAC antes pedidas en un determinado  **/
  /** acto de eleccion para un candidato concreto                **/
  /****************************************************************/
  procedure val_vac(v_num_vac     sigi_vac.num_vac%type,
                    v_per         SIGI_T_PER,
                    v_opc         sigi_opc.cod_opc%type,
                    v_cod_tip_ae  sigi_opc.cod_tip_ae%type,
                    v_fec_cur_com sigi_opc.fec_cur_com%type,
                    cod_men       out number,
                    men           out varchar2) is
    v_cod_cue       sigi_vac.cod_cue%type;
    v_cod_esp       sigi_vac.cod_esp%type;
    v_cod_mun_vac   sigi_vac.cod_mun_vac%type;
    v_cod_tip_dur   sigi_vac.cod_tip_dur%type;
    v_f_con_ae      sigi_opc.f_con_ae%type;
    v_l_lis_sus     sigi_esp_can_pre_ae.l_lis_sus%type;
    v_cod_pro_1_sus sigi_esp_can_pre_ae.cod_pro_1_sus%type;
    v_cod_pro_2_sus sigi_esp_can_pre_ae.cod_pro_2_sus%type;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida2 exception; -- excepción para informar de porque la vacante no es valida
    e_salida9 exception; -- error ya grabado se pasa el número de error
    v_aud sigi_t_aud;
  begin
    cod_men := 0;
    men     := 'OK';
    /*       v_aud   := sigi_t_aud(v_per.TIPO_ID,
                          v_per.DNI,
                          'val_vac ' || v_f_con_ae || ' ' || v_num_vac,
                          null);
    gra_aud(v_aud);*/
    Begin
      -- Consulta SIGI_VAC
      Select v.cod_cue, v.cod_esp, v.cod_mun_vac, v.cod_tip_dur
        into v_cod_cue, v_cod_esp, v_cod_mun_vac, v_cod_tip_dur
        from sigi_vac v
       where v.num_vac = v_num_vac
         and v.cod_opc = v_opc;
    Exception
      When no_data_found then
        cod_men := '9'; -- la vacante no existe
        men     := 'La vacante: ' || v_num_vac || ' para la opción: ' ||
                   v_opc || ' no existe ';
        -- gra_err(men);
        raise e_salida2;
    End;
    Begin
      -- Consulta SIGI_ESP_CAN_PRE_AE
      Select c.l_lis_sus, c.cod_pro_1_sus, c.cod_pro_2_sus
        into v_l_lis_sus, v_cod_pro_1_sus, v_cod_pro_2_sus
        from sigi_esp_can_pre_ae c
       where c.tipo_id = v_per.tipo_id
         and c.dni = v_per.dni
         and c.cod_cue = v_cod_cue
         and c.cod_esp = v_cod_esp;
    Exception
      When no_data_found then
        cod_men := '1'; -- el preseleccionado no lo esta para la espec y cuerpo de la vacante
        men     := 'El candidato ' || v_per.dni ||
                   ' no esta preseleccionado para la especialidad ' ||
                   v_cod_cue || ' ' || v_cod_esp || ' de la vacante ' ||
                   v_num_vac;
        raise e_salida2;
    End;
    if v_cod_tip_ae = 'F' then
      -- Funcionarios
      tra_ae_fun(v_per, v_opc, v_cod_mun_vac, cod_men, men);
    elsif v_cod_tip_ae = 'S' then
      -- Semanales
      select f_con_Ae into v_f_con_ae from sigi_opc where cod_opc = v_opc;
      tra_ae_sem(v_f_con_ae,
                 v_cod_tip_dur,
                 v_fec_cur_com,
                 v_l_lis_sus,
                 v_cod_pro_1_sus,
                 v_cod_pro_2_sus,
                 v_cod_mun_vac,
                 cod_men,
                 men);
    else
      cod_men := '0';
      men     := '';
    end if;
    -- Llamada a otro procedmientos
    -- pro1(cod_men, men);
    if cod_men = 9 then
      raise e_salida9;
    else
      null; -- para tratar errores especiales
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida2 then
      -- Esta excepcion es para grabar el error en base de datos
      men     := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;

  /***********************************************************/
  /** Procedimiento VAL ida ARR ay de VAC antes            **/
  /** valida dependiendo el tipo de Acto de elección que   **/
  /** las vacantes pedidas sean correctas para el          **/
  /** solicitante v_per                                    **/
  /** devuelve el error de la vacante para cada vacantes   **/
  /**********************************************************/
  procedure val_arr_vac(v_per     in SIGI_T_PER,
                        v_arr_vac in out sigi_array_vac,
                        v_opc     in sigi_opc.cod_opc%type,
                        cod_men   out number,
                        men       out varchar2) is
    v_f_con_ae    sigi_opc.f_con_ae%type;
    v_cod_tip_ae  sigi_opc.cod_tip_ae%type;
    v_fec_cur_com sigi_opc.fec_cur_com%type;
    v_aud         sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    /*  v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'En v_opc ' || v_opc,
                        'v_sol.cvac 1: ' || v_arr_vac(1).cvacante);
    gra_aud(v_aud);*/
    begin
      select to_date(a.fec_cur_com, 'dd/mm/rrrr'), a.f_con_ae, a.cod_tip_ae
        into v_fec_cur_com, v_f_con_ae, v_cod_tip_ae
        from sigi_opc a
       where a.cod_opc = v_opc;
    Exception
      when others then
        raise e_salida1;
    end;
    /*v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'En v_opc 1 ' || v_fec_cur_com,
                        'v_sol.cvac 1: ' || v_f_con_ae||' '||v_cod_tip_ae);
    gra_aud(v_aud);*/
    for i in v_arr_vac.first .. v_arr_vac.last loop
      if v_arr_vac(i).cvacante <> 0 then
        val_vac(v_arr_vac(i).cvacante,
                v_per,
                v_opc,
                v_cod_tip_ae,
                v_fec_cur_com,
                cod_men,
                men);
      else
        null;
        /*  v_aud := sigi_t_aud(v_per.tipo_id,
                            v_per.dni,
                            'v_opc ' || v_opc,
                            'v_sol.cvac 1: ' || v_arr_vac(i).cvacante);
        gra_aud(v_aud);*/
      end if;
      -- si el error es 9 a salir de la ejecucción si no es que es  un error de
      -- petición  incorrecta y lo grabo en la vacantes ...
      if cod_men = 9 then
        raise e_salida9;
      else
        v_arr_vac(i).cerror := cod_men;
        --null; -- para tratar errores especiales

      end if;
      /* Val_vac(nvl(p_solic(i).cvacante, 9999999), p_partic, v_f_conv_ae,
              v_tipo_ae, v_ult_fofer, v_error_vac, perror2);
      if perror2 is not null then
        raise e_salida;
      end if;
      if v_error_vac != '0' then
        perror1 := 3;
        p_solic(i).cerror := v_error_vac;
      end if;*/
    end loop;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  -- Función que obtiene números aleatorios 10000
  Function f_ran(p_limite  number,
                 v_cod_opc sigi_opc.cod_opc%type,
                 p_tipo_id varchar2,
                 p_dni     varchar2) return varchar2 IS
    v_ret number := 0;
    Function existe_ran(p_num number) return boolean is
      v_cont number;
    begin
      Select count(1)
        into v_cont
        from sigi_sol s
       where s.tipo_id = p_tipo_id
         and s.dni = p_dni
         and s.cod_opc = v_cod_opc
         and s.cod_sol = p_num;
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

  /*******************************************************/
  /** Procedimiento INS erta SOL icitud  **/
  /*******************************************************/
  Procedure ins_sol(v_per     in SIGI_T_PER,
                    v_sol     in sigi_t_sol,
                    v_opc     in sigi_opc.cod_opc%type,
                    v_cod_sol out sigi_sol.cod_sol%type,
                    cod_men   out number,
                    men       out varchar2) is
    v_lim  constant number := 9999;
    v_user constant varchar2(8) := 'INTERNET';
    v_err_tab     varchar2(200) := '**';
    v_cod_est_sol varchar2(1);
    --v_año_ini_cur varchar2(4);
    v_aud sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men   := 0;
    men       := 'OK';
    v_cod_sol := f_ran(v_lim, v_opc, v_per.tipo_id, v_per.dni);
    /*    select distinct año_ini_cur
     into v_año_ini_cur
     from sigi_vac v
    where v.cod_opc = v_opc;*/
    men := ' tabla sigi_sol ';
    /*Añadido quique
    if v_per.l_pass = 'P' then
       v_cod_est_sol := 'P';
    else
       v_cod_est_sol := 'A';
    end if;
    fin quique*/
    insert into sigi_sol
      (tipo_id, dni, cod_opc, cod_sol, f_hor_ent, cod_est_sol, cod_usu, l_pre)
    values
      (v_per.tipo_id, v_per.dni, v_opc, v_cod_sol, sysdate, 'A', v_user,'N');
    --(v_per.tipo_id, v_per.dni, v_opc, v_cod_sol, sysdate, v_cod_est_sol, v_user);  -- quique
    men := ' tabla sigi_pet. ';
    if v_sol.cvac is not null and v_sol.cvac.exists(1) then
      for i in v_sol.cvac.first .. v_sol.cvac.last loop
        if v_sol.cvac(i).cvacante <> 0 then
          /*         v_aud := sigi_t_aud(v_per.tipo_id,
                              v_per.dni,
                              'en ins_sol v_cod_sol: ' || v_cod_sol || '
              ' || 'v_opc ' || v_opc,
                              'v_año_ini_cur: ' || v_año_ini_cur || '
              v_sol.cvac(i).cvacante ' ||
                              v_sol.cvac(i).cvacante || '
              i ' || i);
          gra_aud(v_aud);*/
          insert into sigi_pet
            (tipo_id,
             dni,
             cod_opc,
             cod_sol,
             /* año_ini_cur,*/
             num_vac,
             ord_pre,
             cod_est_pet)
          values
            (v_per.tipo_id,
             v_per.dni,
             v_opc,
             v_cod_sol,
             /* v_año_ini_cur,*/
             v_sol.cvac(i).cvacante,
             i,
             '0');
        end if;
      end loop;
    end if;
    -- Insertamos las peticiones masivas de especialidades
    men := ' tabla sigi_pet_esp ';
    if v_sol.cesp is not null and v_sol.cesp.exists(1) then
      for i in v_sol.cesp.first .. v_sol.cesp.last loop
        insert into sigi_pet_esp
          (tipo_id, dni, cod_opc, cod_sol, cod_cue, cod_esp, ord_esp)
        values
          (v_per.tipo_id,
           v_per.dni,
           v_opc,
           to_char(v_cod_sol),
           '0597',
           to_char(v_sol.cesp(i)),
           i);
      end loop;
    end if;
    -- Insertamos las peticiones masivas por provincia
    men := ' tabla sigi_pet_pro ';
    if v_sol.cpro is not null and v_sol.cpro.exists(1) then
      for i in v_sol.cpro.first .. v_sol.cpro.last loop
        insert into sigi_pet_pro
          (tipo_id, dni, cod_opc, cod_sol, cod_pro, ord_pro)
        values
          (v_per.tipo_id, v_per.dni, v_opc, v_cod_sol, v_sol.cpro(i), i);
      end loop;
    end if;
    -- Insertamos la reserva
    men := ' tabla sigi_res ';
    -- atención vienen 'N'
    if v_sol.l_res is not null /*and nvl(v_sol.l_res, 'N') = 'S' */
     then
      insert into sigi_res
        (tipo_id, dni, cod_opc, cod_sol, cod_est_res)
      values
        (v_per.tipo_id, v_per.dni, v_opc, v_cod_sol, v_sol.l_res);
    end if;
    men := 'OK';
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9; --
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || v_err_tab || sqlerrm;
      gra_err(men);
  end;

  /*******************************************************/
  /** Procedimiento PRE sentar SOL icitud AE            **/
  /*******************************************************/
  Procedure pre_sol_ae(p_per     in sigi_t_per,
                       p_cod_sol in sigi_sol.cod_sol%type,
                       p_sol     in out sigi_t_sol,
                       p_arr_opc in sigi_array_opc,
                       cod_men   out number,
                       men       out varchar2) is
    v_err_tab varchar2(200) := '**';
    v_fecha   varchar2(20);
    v_opc     sigi_sol.cod_opc%type;
    e_salida9 exception; -- error ya grabado se pasa el número de error
    e_salida3 exception; -- aplicación cerrada
    cont  number;
    v_aud sigi_t_aud;
  begin
    cod_men := 0;
    bus_opc(p_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    -- comprobando si la opción se ha cerrado mientras se estaba dentro
    if f_opc_cerrada(v_opc, cod_men, men) then
      v_aud := sigi_t_aud(p_per.tipo_id,
                          p_per.dni,
                          'en pre_sol_ae opc_cerrada con solicitud ' ||
                          p_cod_sol || ' en la opción ' || v_opc ||
                          ' cerrada en fecha ' || to_char(sysdate,'dd/mm/rrrr hh24:mi:ss'),
                          null);
      gra_aud(v_aud);
      raise e_salida3;
    end if;
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    -- Comprueba si existe la solicitud
    select count(*)
      into cont
      from sigi_sol ss
     where cod_sol = p_cod_sol
       and ss.cod_opc = v_opc
       and ss.tipo_id = p_per.tipo_id
       and ss.dni = p_per.dni;

    -- Si existe la solicitud
    if cont > 0 then
      p_sol.l_pre_ae := 'P';
      p_sol.f_pre_ae := to_char(sysdate, 'dd/mm/rrrr HH24:MI:SS');

      update sigi_sol ss
         set l_pre     = 'S',
             f_hor_pre = to_date(p_sol.f_pre_ae, 'dd/mm/rrrr HH24:MI:SS')
       where cod_sol = p_cod_sol
         and ss.cod_opc = v_opc
         and ss.tipo_id = p_per.tipo_id
         and ss.dni = p_per.dni;

    else
      raise e_salida9;
    end if;

  Exception
    When e_salida3 then
      cod_men := 3;
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;

  /*****************************************************************************/
  /** Procedimiento VAL ida SOL icitud                                        **/
  /** v_cod_sol_mod: lleva el código de la solicitud que se modifica o        **/
  /**    A para A lta de una nueva                                            **/
  /** v_pre_ae: el mensaje sobre si tiene o no alguna solicitud presentada    **/
  /**       al acto de eleccion sea con cotraseña o por registro telemático   **/
  /*****************************************************************************/
  Procedure val_sol(v_per         in SIGI_T_PER,
                    v_cod_sol_mod in varchar2,
                    v_cod_sol_nue out varchar2,
                    v_sol         in out sigi_t_sol,
                    v_arr_opc     in sigi_array_opc,
                    v_pre_ae      out varchar2,
                    cod_men       out number,
                    men           out varchar2) is
    l_sol_igu varchar2(1) := 'S';
    v_opc     sigi_opc.cod_opc%type;
    v_aud     sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida2 exception; -- solicitud a modificar igual o no existe
    e_salida3 exception; -- aplicación cerrada
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    -- comprobando si la opción se ha cerrado mientras se estaba dentro
    if f_opc_cerrada(v_opc, cod_men, men) then
      v_aud := sigi_t_aud(v_per.tipo_id,
                          v_per.dni,
                          'en val_sol opc_cerrada con solicitud ' ||
                          v_cod_sol_mod || ' en la opción ' || v_opc ||
                          ' cerrada en fecha ' ||to_char(sysdate,'dd/mm/rrrr hh24:mi:ss'),
                          null);
      gra_aud(v_aud);
      raise e_salida3;
    end if;
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    -- para ver que entra en val_sol
    /* v_aud := sigi_t_aud(v_per.tipo_id,
                        v_per.dni,
                        'En val sol. v_cod_sol_mod: ' || v_cod_sol_mod || '
                        ' || 'v_opc ' || v_opc,
                         'valores v_sol.cvac 1: ' || v_sol.cvac(1).cvacante
                                                ||'  v_sol.cpro(1): ' || nvl(v_sol.cpro(1),'X')||'  v_sol.cpro(2): ' || nvl(v_sol.cpro(2),'X')||'  v_sol.cpro(3): ' || nvl(v_sol.cpro(3),'X')
                                               ||'  v_sol.cesp(1): ' || nvl(v_sol.cesp(1),'X')||'  v_sol.cesp(2): ' || nvl(v_sol.cesp(2),'X')||'  v_sol.cesp(3): ' ||  nvl(v_sol.cesp(3),'X')
                                                ||
                        '  v_sol.l_res: ' || v_sol.l_res ||
                        '  v_sol.l_reg_tel: ' || v_sol.l_reg_tel);
    gra_aud(v_aud);*/
    if not (v_sol.cvac.exists(1)) and nvl(v_sol.l_res, 'N') = 'N' then
      men := 'Llega solicitud sin peticiones';
      raise e_salida1;
    end if;
    -- no es un Alta, es una modificación
    if nvl(v_cod_sol_mod, 'A') != 'A' then
      -- comprobamos que la solicitud modificada no es la misma
      sol_igu(v_per, v_cod_sol_mod, v_sol, v_opc, l_sol_igu, cod_men, men);
      if cod_men <> 0 then
        raise e_salida9;
      end if;
      if l_sol_igu = 'S' then
        men := 'Solicitud ' || v_cod_sol_mod || ' sin cambios';
        raise e_salida2;
      end if;
    end if;
    -- luego es un alta o una modificación correcta
    -- valido las vacantes para esa persona
    if v_sol.cvac.exists(1) and v_sol.cvac is not null then
      val_arr_vac(v_per, v_sol.cvac, v_opc, cod_men, men);
    end if;
    -- si son validas a grabar
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    -- Inserta la solicitud
    ins_sol(v_per, v_sol, v_opc, v_cod_sol_nue, cod_men, men);
    com_pre_sol_ae(v_per, v_opc, cod_men, v_pre_ae);
    if cod_men = 0 then
      -- el commit
      commit;
    end if;
  Exception
    When e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
    When e_salida2 then
      cod_men := 7;
    When e_salida3 then
      cod_men := 3;
    When e_salida9 then
      -- Esta excepcion es para informar que se ha dado un error ya grabado en base de datos
      -- se propaga el numero de error grabado
      cod_men := 9;
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  ----
  /*   v_sol         := sigi_t_sol(sigi_array_vac(sigi_t_vac('1', '12N', '0'),
                                             sigi_t_vac('2', '13J', '1')),
                              sigi_array_esp('AL', 'PT'),
                              sigi_array_pro('50', '22'), 'N');
  v_cod_sol_nue := 1234;
  cod_err       := 0;*/
  /*******************************************************/
  /** Procedimiento CON sulta FEC ha REP lica       **/
  /*******************************************************/
  procedure con_fec_rep(v_opc     sigi_opc.cod_opc%type,
                        v_fec_rep out sigi_opc.f_ini_opc%type,
                        cod_men   out number,
                        men       out varchar2) is
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    select o.f_ini_opc
      into v_fec_rep
      from sigi_opc o
     where o.cod_opc = v_opc;
  Exception
    When others then
      cod_men := 9;
      men     := 'en when others codigo mensaje--> ' || cod_men ||
                 ' mensaje ' || men;
      gra_err(men);
  end;
  /************************************************************************/
  /** Procedimiento LIStas en PDF mandadas desde base de datos           **/
  /************************************************************************/
  procedure lis_pdf(v_per     in SIGI_T_PER,
                    v_arr_opc in sigi_array_opc,
                    tex_tit   out varchar2,
                    tex_pdf   out clob,
                    cod_men   out number,
                    men       out varchar2) is
    v_opc sigi_opc.cod_opc%type;
    -- Vuelvo a hacer la consulta para tener más libertad a la hora de
    -- generar el PDF
    Cursor c_sigi_lis is
      select distinct cod_cue,
                      cod_esp,
                      cod_cue || ' - ' || c.dcuerpo des_cue,
                      cod_esp || ' -  ' || despec des_esp,
                      tip_lis tip_lis,
                      'lista ' || tip_lis des_tip_lis,
                      to_char(to_date(fec_ori_blo, 'rrrrmmdd'),
                              'dd/mm/rrrr') fec_ori_blo,
                      cod_blo des_blo,
                      num_ord num_ord_blo,
                      res_tot pun,
                      des_pro_ref pro_ref,
                      cod_est des_est,
                      des_cau_est des_cau_est,
                      to_char(fec_ini_est, 'dd/mm/rrrr') fec_est_lis,
                      des_pro_1_sus des_pro_sus_1,
                      to_char(fec_pro_1_sus, 'dd/mm/rrrr') fec_pro_sus_1,
                      des_pro_2_sus des_pro_sus_2,
                      to_char(fec_pro_2_sus, 'dd/mm/rrrr') fec_pro_sus_2,
                      l.ord_dis_za,
                      l.ord_dis_hu,
                      l.ord_dis_te,
                      l.ord_ccao
        from sigi_lis l, cuerpos c, especialidades e
       where l.cod_cue = c.ccodcu
         and l.cod_esp = e.cespec
         and c.ccodcu = e.ccodcu
         and tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and cod_opc = v_opc
       order by des_cue, des_esp;
    /*         and tipo_id = decode(substr(d_per.dni,1,1),'X','P','Y','P','Z','P','D')
             and dni = decode(substr(d_per.dni,1,1),'X',d_per.dni,'Y',d_per.dni,'Z',d_per.dni,'0'||substr(d_per.dni,1,length(d_per.dni)-1));
    */
    v_sigi_lis c_sigi_lis%rowtype;
    cursor c_sigi_par is
      select p.est_per, p.des_cau_est_per, p.f_ini_per
        from sigi_par p
       where tipo_id = v_per.tipo_id
         and dni = v_per.dni
         and p.cod_opc = v_opc;
    v_sigi_par    c_sigi_par%rowtype;
    v_fec_rep     sigi_opc.f_ini_opc%type;
    v_fec_cur_com sigi_opc.fec_cur_com%type;
    cha_tex_pdf   varchar2(32767); -- para almacenar el buffer para el clob
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
    v_aud     sigi_t_aud;
    v_des_blo varchar2(1000);
  begin
    cod_men := 0;
    men     := 'OK';
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida1;
    end if;
    /*           v_aud := sigi_t_aud(null, null, 'en lis_pdf '||v_opc , null);
    gra_aud(v_aud);*/
    if v_opc = 'SIGISSP' then
      tex_tit := 'SITUACIÓN EN LISTAS DE SECUNDARIA';
    elsif v_opc = 'SIGIPSP' then
      tex_tit := 'SITUACIÓN EN LISTAS DE PRIMARIA';
    end if;
    v_fec_cur_com := f_fccao(v_opc);
    con_fec_rep(v_opc, v_fec_rep, cod_men, men);
    if cod_men <> 0 then
      raise e_salida1;
    end if;
    tex_tit := tex_tit || '
    Solamente a efectos informativos a fecha: ' ||
               to_char(v_fec_rep, 'dd/mm/rrrr hh24:mi');
    DBMS_LOB.createtemporary(lob_loc => tex_pdf, cache => TRUE);
    cha_tex_pdf := to_char('<table border="1">
    <tr>
        <td colspan="4" align="center" bgcolor="#bcbcbc"><b>DATOS PERSONALES</b></td>
  </tr>
    <tr>
        <td><b>DNI/NIF:</b>' || v_per.dni ||
                           '</td>
        <td colspan="3"><b>NOMBRE:</b>' ||
                           v_per.ape_1 || ' ' || v_per.ape_2 || ', ' ||
                           v_per.nom || '</td>
  </tr>');
    -- escribiendo en el clob
    dbms_lob.write(tex_pdf,
                   dbms_lob.getlength(cha_tex_pdf),
                   1,
                   cha_tex_pdf);
    -- los datos a nivel de persona en listas
    open c_sigi_par;
    loop
      fetch c_sigi_par
        into v_sigi_par;
      exit when c_sigi_par%notfound;
      cha_tex_pdf := to_Char(' <tr>
        <td>Estado:' || v_sigi_par.est_per ||
                             '</td>
        <td colspan="2">Causa:' ||
                             v_sigi_par.des_cau_est_per ||
                             '</td>
        <td>Fecha:' || v_sigi_par.f_ini_per ||
                             '</td>
    </tr>');
    end loop;
    close c_sigi_par;
    cha_tex_pdf := cha_tex_pdf || to_Char(' </table><br>');
    dbms_lob.write(tex_pdf,
                   dbms_lob.getlength(cha_tex_pdf),
                   dbms_lob.getlength(tex_pdf) + 1,
                   cha_tex_pdf);
    -- Las listas en las que esta
    open c_sigi_lis;
    loop
      fetch c_sigi_lis
        into v_sigi_lis;
      exit when c_sigi_lis%notfound;
      v_des_blo   := v_sigi_lis.des_blo ||
                     f_car_con_pre_pdf(v_per,
                                       v_sigi_lis.cod_cue,
                                       v_sigi_lis.cod_esp,
                                       cod_men,
                                       men);
      cha_tex_pdf := to_Char('<table border="1">
    <tr>
        <td colspan="8" align="center" bgcolor="#bcbcbc"><b>LISTAS</b></td>
    </tr>
    <tr>
        <td colspan="4"><b>Cuerpo:</b>' ||
                             v_sigi_lis.des_cue ||
                             '</td>
        <td colspan="4"><b>Especialidad:</b>' ||
                             v_sigi_lis.des_esp ||
                             '</td>
    </tr><tr>
        <td><b>Tipo Lista:</b>' ||
                             v_sigi_lis.tip_lis ||
                             '</td>
        <td colspan="2"><b>Fec. Bloque:</b>' ||
                             v_sigi_lis.fec_ori_blo ||
                             '</td>
        <td colspan="5"><b>Bloque:</b>' ||
                             /* v_sigi_lis.des_blo*/
                             v_des_blo ||
                             '</td>
    </tr><tr>
        <td colspan="2"><b>Nº de Orden:</b>' ||
                             v_sigi_lis.num_ord_blo ||
                             '</td>
        <td><b>Reserva:</b> </td>
        <td><b>Puntos:</b>' || v_sigi_lis.pun ||
                             '</td>
        <td colspan="4"><b>Provincia Referencia:</b>' ||
                             v_sigi_lis.pro_ref ||
                             '</td></tr>
</table><table border="1"><tr>
        <td><b>Estado:</b>' ||
                             v_sigi_lis.des_est ||
                             '</td><td colspan="5"><b>Causa:</b>' ||
                             v_sigi_lis.des_cau_est || '</td>
<td><b>Fecha:</b>' || v_sigi_lis.fec_est_lis ||
                             '</td></tr>
</table>
<table border="1">
    <tr>
        <td colspan="2"><b>Provincia 1 Suspensión:</b>' ||
                             v_sigi_lis.des_pro_sus_1 ||
                             '</td>
        <td><b>Fecha:</b>' ||
                             v_sigi_lis.fec_pro_sus_1 ||
                             '</td>
        <td colspan="2"><b>Provincia 2 Suspensión:</b>' ||
                             v_sigi_lis.des_pro_sus_2 ||
                             '</td>
        <td><b>Fecha:</b>' ||
                             v_sigi_lis.fec_pro_sus_2 || '</td>
    </tr><tr align="center">
        <td colspan="6" bgcolor="#bcbcbc"><b>Nº ORDEN DE DISPONIBILIDAD PARA VACANTES</b></td></tr>
     ');
      if v_fec_cur_com is not null then
        cha_tex_pdf := cha_tex_pdf || to_Char('<tr>
        <td colspan="6"><b>De Curso Completo ofertadas hasta el ' ||
                                              v_fec_cur_com || ':</b>' ||
                                              v_sigi_lis.ord_ccao ||
                                              '</td>
    </tr>
    <tr>
        <td colspan="6"><b>De Sustitución o Curso Completo después del ' ||
                                              v_fec_cur_com || '</b></td>
    </tr>');
      end if;
      cha_tex_pdf := cha_tex_pdf ||
                     to_Char('<tr align="center">
        <td colspan="2"><b>En Zaragoza:</b>' ||
                             v_sigi_lis.ord_dis_za ||
                             '</td><td colspan="2"><b>En Huesca:</b>' ||
                             v_sigi_lis.ord_dis_hu ||
                             '</td><td colspan="2"><b>En Teruel:</b>' ||
                             v_sigi_lis.ord_dis_te || '</td>
    </tr>
</table><br>');
      dbms_lob.write(tex_pdf,
                     dbms_lob.getlength(cha_tex_pdf),
                     dbms_lob.getlength(tex_pdf) + 1,
                     cha_tex_pdf);
    end loop;
    close c_sigi_lis;
  Exception
    when e_salida1 then
      -- Esta excepcion es para grabar el error en base de datos
      men := ' codigo mensaje--> ' || cod_men || ' mensaje ' || men;
      gra_err(men);
      cod_men := 9;
    When others then
      cod_men := 1;
      men     := $$plsql_line;
      gra_err(men);
  end;
  /****************************************************************/
  /** Procedimiento CAR ga el REG istro  TEL ematico grabado para **/
  /** mostrar el recibo                                          **/
  /***************************************************************/
  Procedure car_reg_tel(v_per     SIGI_T_PER,
                        v_cod_sol sigi_sol.cod_sol%type,
                        v_arr_opc in sigi_array_opc,
                        p_reg     out sigi_t_reg_tel,
                        cod_men   out number,
                        men       out varchar2) is
    v_user constant varchar2(8) := 'INTERNET';
    v_opc sigi_opc.cod_opc%type;
    cursor c_reg is
      select *
        from sigi_sol_reg r
       where r.tipo_id = v_per.tipo_id
         and r.dni = v_per.dni
         and r.cod_opc = v_opc
         and r.cod_sol = v_cod_sol;
    v_reg     c_reg%rowtype;
    v_f_conv  sigi_opc.f_con_ae%type;
    v_reg_aud sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    open c_reg;
    loop
      p_reg := sigi_t_reg_tel(v_reg.cod_asi,
                              v_reg.rec,
                              v_reg.det_fir,
                              v_reg.for_fir,
                              v_reg.mime_tip,
                              v_reg.f_hor_ent,
                              v_reg.csv);
      fetch c_reg
        into v_reg;
      exit when c_reg%notfound;

    end loop;
    close c_reg;

  Exception
    When others then
      cod_men := 1;
      men     := $$plsql_line;
      gra_err(men);
  end;
  /****************************************************************/
  /** Procedimiento GRA ba los datos de la solicitud REG istrada  **/
  /** e-administración                                          **/
  /***************************************************************/
  Procedure gra_reg_tel(v_per     SIGI_T_PER,
                        v_cod_sol sigi_sol.cod_sol%type,
                        p_reg     sigi_t_reg_tel,
                        v_arr_opc sigi_array_opc,
                        cod_men   out number,
                        men       out varchar2) is
    v_user constant varchar2(8) := 'INTERNET';
    v_reg_aud sigi_t_aud;
    v_opc     sigi_opc.cod_opc%type;
    v_aud     sigi_t_aud;
    e_salida1 exception; -- excepción para grabar el error en base de datos
    e_salida9 exception; -- error ya grabado se pasa el número de error
  begin
    cod_men := 0;
    men     := 'OK';
    bus_opc(v_arr_opc, v_opc, cod_men, men);
    if cod_men <> 0 then
      raise e_salida9;
    end if;
    /*    v_aud := sigi_t_aud(null, null, 'gra_reg_tel  '||v_opc||' '||v_cod_sol, null);
    gra_aud(v_aud);*/
    insert into sigi_sol_reg
      (tipo_id,
       dni,
       cod_opc,
       cod_sol,
       cod_asi,
       rec,
       det_fir,
       for_fir,
       mime_tip,
       f_hor_ent,
       csv,
       cod_usu,
       f_ult_mod)
    values
      (v_per.tipo_id,
       v_per.dni,
       v_opc,
       v_cod_sol,
       p_reg.cod_asi,
       p_reg.rec,
       p_reg.det_fir,
       p_reg.for_fir,
       p_reg.mime_tip,
       --to_char(to_date(p_reg.fec),'dd/mm/rrrr hh24:mi:ss'),
       p_reg.fec,
       p_reg.csv,
       v_user,
       sysdate);
  Exception
    When others then
      cod_men := 1;
      men     := $$plsql_line;
      gra_err(men);
  end;
end sigi_pck;
/

