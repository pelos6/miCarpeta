CREATE OR REPLACE PACKAGE BODY PKB_SIT_PAR_old AS
  /*******************************************************/
  /**  Función para obtener el TIPO_ID del participante **/
  /*******************************************************/
  FUNCTION Obtener_TipoID(v_dni IN VARCHAR2) RETURN VARCHAR2 IS
    v_tipo_id VARCHAR2(1);
  BEGIN
    IF SUBSTR(v_dni, 1, 1) = 'X' THEN
      v_tipo_id := 'P';
    elsif LENGTH(v_dni) = 9 THEN
      v_tipo_id := 'D';
    ELSE
      v_tipo_id := 'P';
    END IF;
    RETURN v_tipo_id;
  END;
  /***************************************************************************/
  /**Función para sacar la fecha hasta las vacantes de curso completo son de */
  /* aceptación obligatoria                                                  */
  /***************************************************************************/
  FUNCTION F_fccao RETURN VARCHAR2 IS
    v_valor VARCHAR2(10);
  BEGIN
    SELECT valor
      INTO v_valor
      FROM inpri_param_ap
     WHERE VARIABLE = 'PA_DMA_FCCAO';
    RETURN v_valor;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error en f_fccao ' || sqlerrm;
  END;
  /***************************************************************************/
  /**Procedimiento para mantener información de uso en una tabla de auditoria */
  /***************************************************************************/
  PROCEDURE ins_aud(v_tipo_id sp_par.tipo_id%type,
                    v_dni     sp_par.dni%type,
                    v_modo    varchar2) is
  begin
    insert into w_aud values (v_tipo_id, v_dni, v_modo, sysdate);
    -- commit;
  exception
    when others then
      null;
  end;
  /*****************************************************************************/
  /* Procedimiento para rellenar los datos de las especialidades que habilitan */
  /* al participante para un bloque. Si no tiene, viene informada con 'XX'     */
  /* y no devuelve ningún dato el cursor. El array se devuelve vacío           */
  /*****************************************************************************/
  PROCEDURE carga_sit_hab(v_tipo_id     IN sp_par.tipo_id%type,
                          v_dni         IN sp_par.dni%type,
                          v_tipo_lis    IN sp_lis.tipo_lis_il%type,
                          v_f_origen_bl IN sp_lis.f_origen_bl_il%type,
                          v_bloque      IN sp_lis.blo_il%type,
                          v_sit_hab     OUT sp_array_sit_hab,
                          n_campo       OUT NUMBER,
                          retorno       OUT VARCHAR2) IS
  
    Cursor c_sp_hab is
      SELECT C_ESPEC_HAB || ' -  ' || despec d_esp_hab,
             TO_CHAR(l.f_desde_ha, 'DD/MM/RRRR') f_desde_hab,
             ORDEN_DISP_ZA n_orden_disp_za,
             ORDEN_DISP_HU n_orden_disp_hu,
             ORDEN_DISP_TE n_orden_disp_te,
             ORDEN_CCAO n_orden_ccao
        FROM SP_LIS l, especialidades e
       where l.c_espec_hab = e.cespec
         and l.c_cuerpo_il = e.ccodcu
         and tipo_id = v_tipo_id
         and dni = v_dni
         and l.tipo_lis_il = v_tipo_lis
         and l.f_origen_bl_il =
             to_char(to_date(v_f_origen_bl, 'dd/mm/rrrr'), 'rrrrmmdd')
         and l.blo_il = v_bloque;
  
    v_sp_hab c_sp_hab%rowtype;
    cont     number := 0;
  BEGIN
    v_sit_hab := sp_array_sit_hab(sp_sit_hab(null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null));
    open c_sp_hab;
    loop
      fetch c_sp_hab
        into v_sp_hab;
      exit when c_sp_hab%notfound;
    
      if cont > 0 then
        v_sit_hab.extend(1);
      end if;
      cont := cont + 1;
      v_sit_hab(v_sit_hab.last) := sp_sit_hab(v_sp_hab.d_esp_hab,
                                              v_sp_hab.f_desde_hab,
                                              v_sp_hab.n_orden_disp_za,
                                              v_sp_hab.n_orden_disp_hu,
                                              v_sp_hab.n_orden_disp_te,
                                              v_sp_hab.n_orden_ccao);
    
    end loop;
    close c_sp_hab;
  
  exception
    when others then
      n_campo := 1;
      retorno := 'Error proc Pkb_sit_par.Carga_sis_lis. ' || sqlerrm;
  END;

  /*************************************************************************/
  /**Procedimiento para cargar el array con los datos de las listas en las */
  /* que se encuentra el participante                                      */
  /*************************************************************************/
  PROCEDURE carga_sit_lis(v_tipo_id IN sp_par.tipo_id%type,
                          v_dni     IN sp_par.dni%type,
                          v_sit_lis OUT sp_array_sit_lis,
                          n_campo   OUT NUMBER,
                          retorno   OUT VARCHAR2) IS
  
    Cursor c_sp_lis is
      SELECT distinct C_CUERPO_IL || ' - ' || c.dcuerpo d_cue,
                      C_ESPEC_PREF || ' -  ' || despec d_esp,
                      tipo_lis_il tip_lis,
                      'Lista ' || TIPO_LIS_IL d_tip_lis,
                      to_char(to_Date(f_origen_bl_il, 'rrrrmmdd'),
                              'DD/MM/RRRR') f_ori_blo,
                      BLO_IL d_blo,
                      N_ORDEN_IL n_ord_blo,
                      R_TOTAL_IL pun,
                      D_PROV_REFER_IL pro_ref,
                      EST_LIS d_est,
                      D_CAUSA_EST_LIS d_cau_est,
                      TO_CHAR(F_INICIO_EST_LIS, 'DD/MM/RRRR') f_est_lis,
                      D_PROV1_SUSP_ILG d_pro_sus_1,
                      TO_CHAR(F_PROV1_SUSP_ILG, 'DD/MM/RRRR') f_pro_sus_1,
                      D_PROV2_SUSP_ILG d_pro_sus_2,
                      TO_CHAR(F_PROV2_SUSP_ILG, 'DD/MM/RRRR') f_pro_sus_2
        FROM SP_LIS l, cuerpos c, especialidades e
       where l.c_cuerpo_il = c.ccodcu
         and l.c_espec_pref = e.cespec
         and c.ccodcu = e.ccodcu
         and tipo_id = v_tipo_id
         and dni = v_dni;
    v_sp_lis c_sp_lis%rowtype;
    cont     number := 0;
  
    sit_hab sp_array_sit_hab;
  BEGIN
    v_sit_lis := sp_array_sit_lis(sp_sit_lis(null,
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
    open c_sp_lis;
    loop
      fetch c_sp_lis
        into v_sp_lis;
      exit when c_sp_lis%notfound;
      if cont > 0 then
        v_sit_lis.extend(1);
      end if;
      cont := cont + 1;
    
      carga_sit_hab(v_tipo_id,
                    v_dni,
                    v_sp_lis.tip_lis,
                    v_sp_lis.f_ori_blo,
                    v_sp_lis.d_blo,
                    sit_hab,
                    n_campo,
                    retorno);
    
      v_sit_lis(v_sit_lis.last) := sp_sit_lis(v_sp_lis.d_cue,
                                              v_sp_lis.d_esp,
                                              v_sp_lis.d_tip_lis,
                                              v_sp_lis.f_ori_blo,
                                              v_sp_lis.d_blo,
                                              v_sp_lis.n_ord_blo,
                                              v_sp_lis.pun,
                                              v_sp_lis.pro_ref,
                                              v_sp_lis.d_est,
                                              v_sp_lis.d_cau_est,
                                              v_sp_lis.f_est_lis,
                                              v_sp_lis.d_pro_sus_1,
                                              v_sp_lis.f_pro_sus_1,
                                              v_sp_lis.d_pro_sus_2,
                                              v_sp_lis.f_pro_sus_2,
                                              sit_hab);
    
    end loop;
    close c_sp_lis;
    null;
  exception
    when others then
      n_campo := 1;
      retorno := 'Error proc Pkb_sit_par.Carga_sis_lis. ' || sqlerrm;
  END;
  /********************************************/
  /** Comprobar si está operativa la Aplicación
  /** y recuperación de la fecha de replica de datos
  /** que coincide con la fecha de inicio de disponibilidad */
  /********************************************/
  PROCEDURE PreLogin(f_replica OUT VARCHAR2,
                     d_titulo1 OUT VARCHAR2,
                     n_campo   OUT NUMBER,
                     retorno   OUT VARCHAR2) IS
    v_apli VARCHAR2(10) := 'SIGIPSP';
    e_salida1 EXCEPTION;
  BEGIN
    -- Titulo a mostrar en caso de error
    d_titulo1 := 'Consulta de Situación del Participante';
    SELECT t.mensaje_texto, TO_CHAR(f_ini_disp, 'DD/MM/RRRR HH24:MI')
      INTO d_titulo1, f_replica
      FROM t_seg_aplicaciones t
     WHERE t.codaplic = v_apli
       AND t.estado = 'A'
       AND sysdate BETWEEN t.f_ini_disp AND t.f_fin_disp;
    -- Se podría poner aquí el mensaje de la variable d_aplicacion pero se mantiene así para comprobar que hace un correcto funcionamiento
    n_campo := 0;
  EXCEPTION
    WHEN no_data_found THEN
      n_campo := 3;
      retorno := 'Aplicación cerrada';
    WHEN e_salida1 THEN
      -- Esta excepcion es controlar cuando desde la aplicación no nos envía un Cod. Aplicación correcta.
      n_campo := 2;
      retorno := 'Error proc Pkb_sit_par.Ini. Código de aplicación incorrecto';
    WHEN OTHERS THEN
      n_campo := 1;
      retorno := 'Error proc Pkb_sit_par.Ini. ' || sqlerrm;
      /************************************************************************
      Se n_campo := 9 es un error controlado que se utilizará por ejemplo
      en que el servicio este parado en caso de mantenimiento se controla
      desde la web
      *************************************************************************/
  END;
  /******************************************************************************/
  /********************  Validacion del participante (LOGIN) ********************/
  /******************************************************************************/
  PROCEDURE Login(sit_per IN OUT SP_SIT_PER,
                  sit_lis OUT SP_ARRAY_SIT_LIS,
                  F_CCAO  OUT VARCHAR2,
                  n_campo OUT NUMBER,
                  retorno OUT VARCHAR2) IS
    e_salida1 EXCEPTION;
    e_salida3 EXCEPTION;
    c_estado  VARCHAR2(1) := NULL;
    v_aux     NUMBER;
    f_replica VARCHAR2(60);
    e_salida EXCEPTION;
    cont1        NUMBER;
    d_aplicacion VARCHAR2(8) := 'SIGIPSP';
  BEGIN
    n_campo := 0;
    retorno := '';
    f_ccao  := f_fccao;
    -- Para comprobar en qué situación se encuentra la aplicación.
    SELECT t.estado
      INTO c_estado
      FROM t_seg_aplicaciones t
     WHERE t.codaplic = d_aplicacion
       AND t.estado = 'A'
       AND sysdate BETWEEN t.f_ini_disp AND t.f_fin_disp;
    -- Se comprueba que el parámetro exista.
    IF sit_per IS NOT NULL THEN
      IF sit_per.dni IS NULL THEN
        -- Comprueba que el dni no es nulo.
        raise e_salida1;
      ELSE
        sit_per.tipo_id := Obtener_TipoID(sit_per.dni);
        IF sit_per.password IS NOT NULL THEN
          IF upper(sit_per.reen_password) = 'S' THEN
            -- El participante a rellenado la password y pide reenvio de la misma, esto es un fallo lógico.
            raise e_salida3;
          ELSE
            -- Comprobar que existe la PASSWORD.
            BEGIN
              PKB_MANT_PARTIC_PSW.Comprueba_Clave(sit_per.tipo_id,
                                                  sit_per.dni,
                                                  sit_per.password,
                                                  n_campo,
                                                  retorno);
              IF n_campo = 0 THEN
                -- Identificación Correcta,
                -- Aplicación sólo en modo consulta
                retorno := 'R';
                SELECT a.nombre,
                       a.apellido1,
                       a.apellido2,
                       TO_CHAR(a.f_ini_per, 'DD/MM/RRRR'),
                       a.est_per,
                       a.d_causa_est_per
                  INTO sit_per.nombre,
                       sit_per.ape1,
                       sit_per.ape2,
                       sit_per.f_ini_per,
                       sit_per.est_per,
                       sit_per.d_causa_est_per
                  FROM sp_par a
                 WHERE a.tipo_id = sit_per.tipo_id
                   AND a.dni = sit_per.dni;
                carga_sit_lis(sit_per.tipo_id,
                              sit_per.dni,
                              sit_lis,
                              n_campo,
                              retorno);
                -- salida correcta              
                ins_aud(sit_per.tipo_id, sit_per.dni, '0');
              ELSE
                -- salida con contraseña incorrecta
                ins_aud(sit_per.tipo_id, sit_per.dni, '9');
              END IF;
            EXCEPTION
              WHEN no_data_found THEN
                -- Ha introducido mal el DNI o la Password.
                retorno := 'Participante no convocado o mal identificado.';
                n_campo := 2;
                ins_aud(sit_per.tipo_id, sit_per.dni, '1');
              WHEN OTHERS THEN
                retorno := 'Error proc Pkb_opoem_val_web.Login . ' ||
                           n_campo || ' ' || sqlerrm;
                n_campo := 1;
                ins_aud(sit_per.tipo_id, sit_per.dni, '2');
            END;
            IF sit_per.reen_password = 'S' THEN
              PKB_MANT_PARTIC_PSW.Reenvio_Clave(sit_per.tipo_id,
                                                sit_per.dni,
                                                d_aplicacion,
                                                n_campo,
                                                retorno);
            END IF;
          END IF;
        ELSE
          raise e_salida1;
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN e_salida1 THEN
      -- Esta excepcion es para errores controlados
      retorno := 'Para entrar en la aplicación de oposición es necesario dni y contraseña.';
      n_campo := 2;
      ins_aud(sit_per.tipo_id, sit_per.dni, '3');
    WHEN e_salida3 THEN
      -- Esta excepcion es para errores controlados
      retorno := 'No se puede pedir reenvío de contraseña, si se ha rellenado el dato de la contraseña.';
      n_campo := 2;
      ins_aud(sit_per.tipo_id, sit_per.dni, '4');
    WHEN no_data_found THEN
      n_campo := 3;
      retorno := 'La Aplicación está cerrada.';
      ins_aud(sit_per.tipo_id, sit_per.dni, '5');
    WHEN OTHERS THEN
      n_campo := 1;
      retorno := 'Error proc Pkb_opoem_val_web.Login. ' || sqlerrm;
      ins_aud(sit_per.tipo_id, sit_per.dni, '6');
  END login;
END PKB_SIT_PAR_old;
/

