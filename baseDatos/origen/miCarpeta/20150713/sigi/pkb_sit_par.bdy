CREATE OR REPLACE PACKAGE BODY PKB_SIT_PAR AS
  v_apli VARCHAR2(10) := 'SIGIPSP';
  v_fec_rep varchar2(20);
  v_fccao varchar2(10) ;
  /*******************************************************/
  /**  Función para obtener el TIPO_ID del participante **/
  /*******************************************************/
  FUNCTION Obtener_TipoID(v_dni IN VARCHAR2) RETURN VARCHAR2 IS
    v_tipo_id VARCHAR2(1);
  BEGIN
    IF SUBSTR(v_dni, 1, 1) in  ('X','Y','Z') THEN
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
  BEGIN
    SELECT valor
      INTO v_fccao
      FROM inpri_param_ap
     WHERE VARIABLE = 'PA_DMA_FCCAO';
    RETURN v_fccao;
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

  /*\*****************************************************************************\
  \* Procedimiento para rellenar los datos de las especialidades que habilitan *\
  \* al participante para un bloque. Si no tiene, viene informada con 'XX'     *\
  \* y no devuelve ningún dato el cursor. El array se devuelve vacío           *\
  \*****************************************************************************\
  PROCEDURE carga_sit_hab(v_tipo_id IN sp_par.tipo_id%type,
                          v_dni     IN sp_par.dni%type,
                          v_tipo_lis IN sp_lis.tip_lis%type,
                          v_f_origen_bl IN sp_lis.fec_ori_blo%type,
                          v_bloque IN sp_lis.cod_blo%type,
                          v_sit_hab OUT sp_array_sit_hab,
                          n_campo   OUT NUMBER,
                          retorno   OUT VARCHAR2) IS
  
    Cursor c_sp_hab is  
      SELECT COD_ESP || ' -  ' || despec d_esp_hab,   
             ORD_DIS_ZA n_orden_disp_za,
             ORD_DIS_HU n_orden_disp_hu,
             ORD_DIS_TE n_orden_disp_te,
             ORD_CCAO n_orden_ccao
        FROM SP_LIS l, especialidades e
       where l.cod_esp = e.cespec
         and l.cod_cue = e.ccodcu
         and tipo_id = v_tipo_id
         and dni = v_dni
         and l.tip_lis = v_tipo_lis
         and l.fec_ori_blo = to_char(to_date(v_f_origen_bl,'dd/mm/rrrr'), 'rrrrmmdd')
         and l.cod_blo = v_bloque;
         
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
                                            \*  v_sp_hab.f_desde_hab,*\
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
  */

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
      select distinct cod_cue || ' - ' || c.dcuerpo des_cue,
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
        from sp_lis l, cuerpos c, especialidades e
       where l.cod_cue = c.ccodcu
         and l.cod_esp = e.cespec
         and c.ccodcu = e.ccodcu
         and tipo_id = v_tipo_id
         and dni = v_dni
         order by des_cue, des_esp;
    v_sp_lis c_sp_lis%rowtype;
    cont     number := 0;
  
    --sit_hab sp_array_sit_hab;
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
    
      /*   carga_sit_hab (v_tipo_id, v_dni,     
      v_sp_lis.tip_lis, v_sp_lis.f_ori_blo, v_sp_lis.d_blo, 
      sit_hab, n_campo, retorno); */
    
      v_sit_lis(v_sit_lis.last) := sp_sit_lis(v_sp_lis.des_cue,
                                              v_sp_lis.des_esp,
                                              v_sp_lis.des_tip_lis,
                                              v_sp_lis.fec_ori_blo,
                                              v_sp_lis.des_blo,
                                              v_sp_lis.num_ord_blo,
                                              v_sp_lis.pun,
                                              v_sp_lis.pro_ref,
                                              v_sp_lis.des_est,
                                              v_sp_lis.des_cau_est,
                                              v_sp_lis.fec_est_lis,
                                              v_sp_lis.des_pro_sus_1,
                                              v_sp_lis.fec_pro_sus_1,
                                              v_sp_lis.des_pro_sus_2,
                                              v_sp_lis.fec_pro_sus_2,
                                              v_sp_lis.ord_dis_za,
                                              v_sp_lis.ord_dis_hu,
                                              v_sp_lis.ord_dis_te,
                                              v_sp_lis.ord_ccao);
    
    end loop;
    close c_sp_lis;
    null;
  exception
    when others then
      n_campo := 1;
      retorno := 'Error proc Pkb_sit_par.Carga_sit_lis. ' || sqlerrm;
  END;
  /********************************************/
  /** Comprobar si está operativa la Aplicación
  /** y recuperación de la fecha de replica de datos
  /** que coincide con la fecha de inicio de disponibilidad */
  /********************************************/
  PROCEDURE PreLogin(v_fec_rep OUT VARCHAR2,
                     d_titulo1 OUT VARCHAR2,
                     avi_con   out varchar2,
                     avi_leg   out varchar2,
                     n_campo   OUT NUMBER,
                     retorno   OUT VARCHAR2) IS
    e_salida1 EXCEPTION;
  BEGIN
   -- Titulo a mostrar en caso de error
    d_titulo1 := 'Consulta de Situación del Participante';
    SELECT t.mensaje_texto, TO_CHAR(f_ini_disp, 'DD/MM/RRRR HH24:MI')
      INTO d_titulo1, v_fec_rep
      FROM t_seg_aplicaciones t
     WHERE t.codaplic = v_apli
       AND t.estado = 'A'
       AND sysdate BETWEEN t.f_ini_disp AND t.f_fin_disp;
  --avi_con := 'Los aspirantes que no dispongan de contraseña facilitada por el Departamento de Educación del Gobierno de Aragón, podrán acceder a la aplicación con su número de D.N.I. ';
  avi_leg := ' <b>AVISO LEGAL:</b> En cumplimiento de lo previsto en la Ley Orgánica 15/1999, de Protección de Datos de Caracter Personal, de 13 de diciembre, le informamos que los datos incluidos en su ficha se integrarán en un fichero titularidad de Diputación General de Aragón, previamente inscrito en la Agencia Española de Protección de Datos. La finalidad del tratamiento es la participación en procesos de provisión de puestos y en su caso realizar el proceso de adjudicación de vacantes, y la destinataria de los datos será la propia Diputación General de Aragón. Igualmente, le informamos que, en todo caso, usted podrá en cualquier momento ejercitar los derechos de acceso, rectificación, cancelación y oposición, que legalmente le corresponden, dirigiéndose por escrito a Diputación General de Aragón, Consejería de Educación, Universidad, Cultura y Deporte, con domicilio en Av/ Gómez Laguna 25, 10°, 50009, Zaragoza.  ';
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
 /*     
      PROCEDURE PreLogin(v_fec_rep OUT VARCHAR2,
                     d_titulo1 OUT VARCHAR2,
                     avi_con   out varchar2,

                     avi_leg   out varchar2,
                     n_campo   OUT NUMBER,
                     retorno   OUT VARCHAR2) IS
    e_salida1 EXCEPTION;
  BEGIN
  --avi_con := 'Los aspirantes que no dispongan de contraseña facilitada por el Departamento de Educación del Gobierno de Aragón, podrán acceder a la aplicación con su número de D.N.I. ';
  avi_leg := ' <b>AVISO LEGAL:</b> En cumplimiento de lo previsto en la Ley Orgánica 15/1999, de Protección de Datos de Caracter Personal, de 13 de diciembre, le informamos que los datos incluidos en su ficha se integrarán en un fichero titularidad de Diputación General de Aragón, previamente inscrito en la Agencia Española de Protección de Datos. La finalidad del tratamiento es la participación en procesos de provisión de puestos y en su caso realizar el proceso de adjudicación de vacantes, y la destinataria de los datos será la propia Diputación General de Aragón. Igualmente, le informamos que, en todo caso, usted podrá en cualquier momento ejercitar los derechos de acceso, rectificación, cancelación y oposición, que legalmente le corresponden, dirigiéndose por escrito a Diputación General de Aragón, Consejería de Educación, Universidad, Cultura y Deporte, con domicilio en Av/ Gómez Laguna 25, 10°, 50009, Zaragoza.  ';
    -- Titulo a mostrar en caso de error
    d_titulo1 := 'Consulta de Situación del Participante';
    SELECT t.mensaje_texto, TO_CHAR(f_ini_disp, 'DD/MM/RRRR HH24:MI')
      INTO d_titulo1, v_fec_rep
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
      */
      /************************************************************************
      Se n_campo := 9 es un error controlado que se utilizará por ejemplo
      en que el servicio este parado en caso de mantenimiento se controla
      desde la web
      *************************************************************************/
  END;
  procedure car_dat(sit_per IN OUT SP_SIT_PER,
                    sit_lis OUT SP_ARRAY_SIT_LIS,
                    n_campo OUT NUMBER,
                    retorno OUT VARCHAR2) IS
  begin
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
    carga_sit_lis(sit_per.tipo_id, sit_per.dni, sit_lis, n_campo, retorno);
    -- salida correcta
    ins_aud(sit_per.tipo_id, sit_per.dni, '0');
  end;
  /******************************************************************************/
  /********************  Validacion del participante (LOGIN) ********************/
  /******************************************************************************/
  PROCEDURE Login(sit_per IN OUT SP_SIT_PER,
                  sit_lis OUT SP_ARRAY_SIT_LIS,
                  v_fccao  OUT VARCHAR2,
                  n_campo OUT NUMBER,
                  retorno OUT VARCHAR2) IS
    e_salida1 EXCEPTION;
    e_salida3 EXCEPTION;
    c_estado  VARCHAR2(1) := NULL;
    e_salida EXCEPTION;
  BEGIN
    n_campo := 0;
    retorno := '';
    v_fccao  := f_fccao;
    -- Para comprobar en qué situación se encuentra la aplicación.
    SELECT t.estado
      INTO c_estado
      FROM t_seg_aplicaciones t
     WHERE t.codaplic = v_apli
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
                car_dat(sit_per, sit_lis, n_campo, retorno);
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
                retorno := 'Error proc Pkb_sit_par.Login . ' ||
                           n_campo || ' ' || sqlerrm;
                n_campo := 1;
                ins_aud(sit_per.tipo_id, sit_per.dni, '2');
            END;
            -- end If;
            IF sit_per.reen_password = 'S' THEN
              PKB_MANT_PARTIC_PSW.Reenvio_Clave(sit_per.tipo_id,
                                                sit_per.dni,
                                                v_apli,
                                                n_campo,
                                                retorno);
            END IF;
            --           end if;
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
      retorno := 'Error proc Pkb_sit_par.Login. ' || sqlerrm;
      ins_aud(sit_per.tipo_id, sit_per.dni, '6');
      ---  END;
  END login;
  -- LIStas en PDF mandadas desde base de datos
  procedure lis_pdf(d_per   in SP_SIT_PER,
                    tex_tit out varchar2,
                    tex_pdf out clob,
                    n_campo out number,
                    retorno out varchar2) is
     -- Vuelvo a hacer la consulta para tener más libertad a la hora de 
     -- generar el PDF
     Cursor c_sp_lis is
      select distinct cod_cue || ' - ' || c.dcuerpo des_cue,
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
        from sp_lis l, cuerpos c, especialidades e
       where l.cod_cue = c.ccodcu
         and l.cod_esp = e.cespec
         and c.ccodcu = e.ccodcu
         and tipo_id = d_per.tipo_id
         and dni = d_per.dni
         order by des_cue, des_esp;
/*         and tipo_id = decode(substr(d_per.dni,1,1),'X','P','Y','P','Z','P','D')
         and dni = decode(substr(d_per.dni,1,1),'X',d_per.dni,'Y',d_per.dni,'Z',d_per.dni,'0'||substr(d_per.dni,1,length(d_per.dni)-1));
*/    v_sp_lis c_sp_lis%rowtype;
  begin
  v_fccao  := f_fccao;
   select to_char(f_ini_disp, 'DD/MM/RRRR HH24:MI')
     into v_fec_rep
     from t_seg_aplicaciones t
    where t.codaplic = v_apli
      and t.estado = 'A'
      and sysdate between t.f_ini_disp and t.f_fin_disp;
  tex_tit := 'SITUACIÓN EN LISTAS DE PRIMARIA 
  Solamente a efectos informativos a fecha: '||v_fec_rep;
        open c_sp_lis;
      fetch c_sp_lis
        into v_sp_lis;
      close c_sp_lis;
  tex_pdf := '<table border="1">
    <tr>
        <td colspan="4" align="center" bgcolor="#bcbcbc"><b>DATOS PERSONALES</b></td> 
  </tr>
    <tr>
        <td><b>DNI/NIF:</b>&nbsp;'||d_per.dni||'</td>
        <td colspan="3"><b>NOMBRE:</b>&nbsp;'||d_per.ape1||' '||d_per.ape2||', '||d_per.nombre||'</td>
  </tr>  
    <tr>
        <td>Estado:&nbsp;'||d_per.est_per||'</td>
        <td colspan="2">Causa:&nbsp;'||d_per.d_causa_est_per||'</td>
        <td>Fecha:&nbsp;'||d_per.f_ini_per||'</td>
    </tr>      
</table>
<br/> ';
open c_sp_lis;
loop
fetch c_sp_lis into v_sp_lis;
exit when c_sp_lis%notfound;
tex_pdf := tex_pdf ||
'<table border="1">
    <tr>
        <td colspan="8" align="center" bgcolor="#bcbcbc"><b>LISTAS</b></td>
    </tr>
    <tr>
        <td colspan="4"><b>Cuerpo:</b>&nbsp;'||v_sp_lis.des_cue||'</td>
        <td colspan="4"><b>Especialidad:</b>&nbsp;'||v_sp_lis.des_esp||'</td>
    </tr><tr>
        <td><b>Tipo Lista:</b>&nbsp;'||v_sp_lis.tip_lis||'</td>
        <td colspan="2"><b>Fec. Bloque:</b>&nbsp;'||v_sp_lis.fec_ori_blo||'</td>
        <td colspan="5"><b>Bloque:</b>&nbsp;'||v_sp_lis.des_blo||'</td>
    </tr><tr>
        <td colspan="2"><b>Nº de Orden:</b>&nbsp;'||v_sp_lis.num_ord_blo||'</td>
        <td><b>Reserva:</b>&nbsp;</td>
        <td><b>Puntos:</b>&nbsp;'||v_sp_lis.pun||'</td>
        <td colspan="4"><b>Provincia Referencia:</b>&nbsp;'||v_sp_lis.pro_ref||'</td></tr>
</table>
<table border="1"><tr>
        <td><b>Estado:</b>&nbsp;'||v_sp_lis.des_est||'</td><td colspan="5"><b>Causa:</b>&nbsp;'||v_sp_lis.des_cau_est||'</td>
<td><b>Fecha:</b>&nbsp;'||v_sp_lis.fec_est_lis||'</td></tr>
</table>
<table border="1">
    <tr>
        <td colspan="2"><b>Provincia 1 Suspensión:</b>&nbsp;'||v_sp_lis.des_pro_sus_1||'</td>
        <td><b>Fecha:</b>&nbsp;'||v_sp_lis.fec_pro_sus_1||'</td>
        <td colspan="2"><b>Provincia 2 Suspensión:</b>&nbsp;'||v_sp_lis.des_pro_sus_2||'</td>
        <td><b>Fecha:</b>&nbsp;'||v_sp_lis.fec_pro_sus_2||'</td>
    </tr><tr align="center">
        <td colspan="6" bgcolor="#bcbcbc"><b>Nº ORDEN DE DISPONIBILIDAD PARA VACANTES</b></td></tr>
     '; 
   if v_fccao is not null then
      tex_pdf := tex_pdf ||
   '<tr>
        <td colspan="6"><b>De Curso Completo ofertadas hasta el '||v_fccao||':</b>&nbsp;'||v_sp_lis.ord_ccao||'</td>
    </tr>
    <tr>
        <td colspan="6"><b>De Sustitución o Curso Completo después del '||v_fccao||'</b></td>
    </tr>';
   end if;
   tex_pdf := tex_pdf || 
   '<tr align="center">                     
        <td colspan="2"><b>En Zaragoza:</b>&nbsp;'||v_sp_lis.ord_dis_za||'</td><td colspan="2"><b>En Huesca:</b>&nbsp;'||v_sp_lis.ord_dis_hu||'</td><td colspan="2"><b>En Teruel:</b>&nbsp;'||v_sp_lis.ord_dis_te||'</td>
    </tr>
</table>
<br/>';

end loop;
exception when others then
          n_campo := 1;
          retorno := 'Error en lis_pdf '||sqlerrm ;
  end;
END PKB_SIT_PAR;
/

