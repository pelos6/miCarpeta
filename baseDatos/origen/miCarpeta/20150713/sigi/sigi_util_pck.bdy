create or replace package body sigi_util_pck is
  procedure ins_sigi_per(v_tipo_id sigi_per.tipo_id%type,
                         v_dni     sigi_per.dni%type,
                         cod_men   out number,
                         men       out varchar2) is
  begin
    men := 'inserción en sigi_per OK';
    insert into sigi_per
      (dni, tipo_id, f_nac, nom, ape_1, ape_2)
      select v_dni,
             v_tipo_id,
             to_date('01/01/1960', 'DD/MM/RRRR'),
             a.nom,
             a.ape_1,
             a.ape_2
        from (select * from sigi_per order by dbms_random.random) a
       where rownum = 1;
  exception
    when dup_val_on_index then
      men := 'Dni ' || v_tipo_id || ' ' || v_dni || ' ya en sigi_per';
    when others then
      men := 'Excepcion ' || sqlerrm || ' en inserta sigi_per';
  end;
  procedure ins_sigi_par(v_tipo_id sigi_per.tipo_id%type,
                         v_dni     sigi_per.dni%type,
                         v_cod_opc sigi_opc.cod_opc%type,
                         cod_men   out number,
                         men       out varchar2) is
  begin
    men := 'inserción en sigi_par OK';
    insert into sigi_par
      (dni, tipo_id, cod_opc, est_per, des_cau_est_per, f_ini_per)
      select v_dni,
             v_tipo_id,
             v_cod_opc,
             a.est_per,
             a.des_cau_est_per,
             a.f_ini_per
        from (select *
                from sigi_par
               where cod_opc = v_cod_opc
               order by dbms_random.random) a
       where rownum = 1;
  exception
    when dup_val_on_index then
      men := 'Dni ' || v_tipo_id || ' ' || v_dni ||
             ' ya en sigi_par para la opción ' || v_cod_opc;
    when others then
      men := 'Excepcion ' || sqlerrm || ' en inserta sigi_par para ' ||
             v_tipo_id || ' ' || v_dni || ' ' || v_cod_opc;
  end;
  -- inserción en situación del participante listas
  procedure ins_sigi_lis(v_tipo_id sigi_per.tipo_id%type,
                         v_dni     sigi_per.dni%type,
                         v_cod_opc sigi_opc.cod_opc%type,
                         cod_men   out number,
                         men       out varchar2) is
  begin
    men := 'inserción en sigi_lis OK';
    insert into sigi_lis
      (dni,
       tipo_id,
       cod_opc,
       cod_cue,
       cod_esp,
       tip_lis,
       fec_ori_blo,
       cod_blo,
       num_ord,
       res_tot,
       cod_est,
       des_cau_est,
       fec_ini_est,
       des_pro_1_sus,
       fec_pro_1_sus,
       des_pro_2_sus,
       fec_pro_2_sus,
       ord_dis_za,
       ord_dis_hu,
       ord_dis_te,
       ord_ccao,
       des_pro_ref,
       l_res)
      select v_dni,
             v_tipo_id,
             v_cod_opc,
             a.cod_cue,
             a.cod_esp,
             a.tip_lis,
             a.fec_ori_blo,
             a.cod_blo,
             a.num_ord,
             a.res_tot,
             a.cod_est,
             a.des_cau_est,
             a.fec_ini_est,
             a.des_pro_1_sus,
             a.fec_pro_1_sus,
             a.des_pro_2_sus,
             a.fec_pro_2_sus,
             a.ord_dis_za,
             a.ord_dis_hu,
             a.ord_dis_te,
             a.ord_ccao,
             a.des_pro_ref,
             a.l_res
        from (select *
                from sigi_lis
               where cod_opc = v_cod_opc
               order by dbms_random.random) a
       where rownum = 1;
  exception
    when dup_val_on_index then
      men := 'Dni ' || v_tipo_id || ' ' || v_dni ||
             ' ya en sigi_lis para la opción ' || v_cod_opc;
    when others then
      men := 'Excepcion ' || sqlerrm || ' en inserta sigi_lis para ' ||
             v_tipo_id || ' ' || v_dni || ' ' || v_cod_opc;
  end;
  -- inserta en las tablas de situación del participante
  -- SIGIXSP para primaria y secundaria
  procedure ins_sigixsp(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        v_cod_opc sigi_opc.cod_opc%type,
                        cod_men   out number,
                        men       out varchar2) is
    v_men varchar2(32658);
  begin
    v_men := 'inserción en ' || v_cod_opc || ' OK';
    ins_sigi_per(v_tipo_id, v_dni, cod_men, men);
    v_men := v_men || men;
    ins_sigi_par(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    v_men := v_men || men;
    ins_sigi_lis(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    v_men := v_men || men;
  end;

  -- inserción en candidato a acto de eleccion
  procedure ins_sigi_can_pre_ae(v_tipo_id sigi_per.tipo_id%type,
                                v_dni     sigi_per.dni%type,
                                v_cod_opc sigi_opc.cod_opc%type,
                                cod_men   out number,
                                men       out varchar2) is
  begin
    men := 'inserción en sigi_can_pre_ae OK';
    insert into sigi_can_pre_ae
      (tipo_id, dni, cod_opc, cod_col, l_med, cod_mun)
      select v_tipo_id, v_dni, v_cod_opc, a.cod_col, a.l_med, a.cod_mun
        from (select *
                from sigi_can_pre_ae
               where cod_opc = v_cod_opc
               order by dbms_random.random) a
       where rownum = 1;
  exception
    when dup_val_on_index then
      men := 'Dni ' || v_tipo_id || ' ' || v_dni ||
             ' ya en sigi_can_pre_ae para la opción ' || v_cod_opc;
    when others then
      men := 'Excepcion ' || sqlerrm || ' en inserta sigi_can_pre_ae para ' ||
             v_tipo_id || ' ' || v_dni || ' ' || v_cod_opc;
  end;
  --- insertamos las especialidades por las que esta preseleccionado
  -- las que le dan más opciones de pruebas o sea las que tiene más vacantes posibles a pedir
  procedure ins_sigi_esp_can_pre_ae(v_tipo_id sigi_per.tipo_id%type,
                                    v_dni     sigi_per.dni%type,
                                    v_cod_opc sigi_opc.cod_opc%type,
                                    cod_men   out number,
                                    men       out varchar2) is
  begin
    men := 'inserción en sigi_esp_can_pre_ae OK';
    insert into sigi_esp_can_pre_ae
      (tipo_id,
       dni,
       cod_opc,
       cod_cue,
       cod_esp,
       cod_pro_1_sus,
       cod_pro_2_sus,
       l_lis_sus)
      select v_tipo_id,
             v_dni,
             cod_opc,
             cod_cue,
             cod_esp,
             cod_pro_1_sus,
             cod_pro_2_sus,
             l_lis_sus
        from sigi_esp_can_pre_ae b
       where (b.tipo_id, b.dni) in
             (select a.tipo_id, a.dni
                from (select e.tipo_id, e.dni, count(*) con
                        from sigi_esp_can_pre_ae e, sigi_vac v
                       where e.cod_opc = v.cod_opc
                         and e.cod_cue = v.cod_cue
                         and e.cod_esp = v.cod_esp
                         and e.cod_opc = v_cod_opc
                       group by e.tipo_id, e.dni
                       order by 3 desc) a
               where rownum = 1)
         and b.cod_opc = v_cod_opc;
  exception
    when dup_val_on_index then
      men := 'Dni ' || v_tipo_id || ' ' || v_dni ||
             ' ya en sigi_esp_can_pre_ae para la opción ' || v_cod_opc;
    when others then
      men := 'Excepcion ' || sqlerrm || ' en inserta sigi_can_pre_ae para ' ||
             v_tipo_id || ' ' || v_dni || ' ' || v_cod_opc;
  end;
  procedure ins_sigixae(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        v_cod_opc sigi_opc.cod_opc%type,
                        cod_men   out number,
                        men       out varchar2) is
    v_men varchar2(32658);
  begin
    v_men := 'inserción en ' || v_cod_opc || ' OK';
    ins_sigi_per(v_tipo_id, v_dni, cod_men, men);
    v_men := v_men || men;
    ins_sigi_can_pre_ae(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    v_men := v_men || men;
    ins_sigi_esp_can_pre_ae(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    v_men := v_men || men;
  end;
  procedure ins_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2) is
    v_men     varchar2(32658);
    v_cod_opc sigi_opc.cod_opc%type;
  begin
    if l_sigissp = 'S' then
      v_cod_opc := 'SIGISSP';
      ins_sigixsp(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    end if;
    if l_sigipsp = 'S' then
      v_cod_opc := 'SIGIPSP';
      ins_sigixsp(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    end if;
    if l_sigisae = 'S' then
      v_cod_opc := 'SIGISAE';
      ins_sigixae(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    end if;
    if l_sigipae = 'S' then
      v_cod_opc := 'SIGIPAE';
      ins_sigixae(v_tipo_id, v_dni, v_cod_opc, cod_men, men);
    end if;
  end;

  procedure bor_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2) is
  begin
    if l_sigissp = 'S' then
      delete sigi_lis
       where cod_opc = 'SIGISSP'
         and tipo_id = v_tipo_id
         and dni = v_dni;
      delete sigi_par
       where cod_opc = 'SIGISSP'
         and tipo_id = v_tipo_id
         and dni = v_dni;
    end if;
    if l_sigipsp = 'S' then
      delete sigi_lis
       where cod_opc = 'SIGIPSP'
         and tipo_id = v_tipo_id
         and dni = v_dni;
      delete sigi_par
       where cod_opc = 'SIGIPSP'
         and tipo_id = v_tipo_id
         and dni = v_dni;
    end if;
    if l_sigisae = 'S' then
      delete sigi_esp_can_pre_ae
       where cod_opc = 'SIGISAE'
         and tipo_id = v_tipo_id
         and dni = v_dni;
      delete sigi_can_pre_ae
       where cod_opc = 'SIGISAE'
         and tipo_id = v_tipo_id
         and dni = v_dni;
    end if;
    if l_sigipae = 'S' then
      delete sigi_esp_can_pre_ae
       where cod_opc = 'SIGIPAE'
         and tipo_id = v_tipo_id
         and dni = v_dni;
      delete sigi_can_pre_ae
       where cod_opc = 'SIGIPAE'
         and tipo_id = v_tipo_id
         and dni = v_dni;
    end if;
  end;
  -- muestra los datos de situación del participante primaria y secundaria
  procedure mue_sp_opc(v_tipo_id sigi_per.tipo_id%type,
                       v_dni     sigi_per.dni%type,
                       v_cod_opc sigi_opc.cod_opc%type) is
  begin
    dbms_output.put_line('Datos en sigi_lis ' || v_cod_opc);
    for b in (select *
                from sigi_lis p
               where p.tipo_id = v_tipo_id
                 and p.dni = v_dni
                 and p.cod_opc = v_cod_opc) loop
      dbms_output.put_line('    ' || b.tipo_id || ' ' || b.dni || ' ' ||
                           b.cod_cue || ' ' || b.cod_esp || ' ' ||
                           b.tip_lis || ' ' || b.fec_ori_blo || ' ' ||
                           b.cod_blo || ' ' || b.num_ord);
    end loop;
    dbms_output.put_line('Datos en sigi_par ' || v_cod_opc);
    for c in (select *
                from sigi_par p
               where p.tipo_id = v_tipo_id
                 and p.dni = v_dni
                 and p.cod_opc = v_cod_opc) loop
      dbms_output.put_line('    ' || c.tipo_id || ' ' || c.dni || ' ' ||
                           c.est_per || ' ' || c.des_cau_est_per || ' ' ||
                           c.f_ini_per);
    end loop;
  end;
  -- muestra los datos de Actos de Eleccion primaria y secundaria
  procedure mue_ae_opc(v_tipo_id sigi_per.tipo_id%type,
                       v_dni     sigi_per.dni%type,
                       v_cod_opc sigi_opc.cod_opc%type) is
  begin
    dbms_output.put_line('Datos en sigi_can_pre_ae ' || v_cod_opc);
    for b in (select *
                from sigi_can_pre_ae p
               where p.tipo_id = v_tipo_id
                 and p.dni = v_dni
                 and p.cod_opc = v_cod_opc) loop
      dbms_output.put_line('    ' || b.tipo_id || ' ' || b.dni || ' ' ||
                           b.cod_col || ' ' || b.l_med || ' ' || b.cod_mun);
    end loop;
    dbms_output.put_line('Datos en sigi_esp_can_pre_ae ' || v_cod_opc);
    for c in (select *
                from sigi_esp_can_pre_ae p
               where p.tipo_id = v_tipo_id
                 and p.dni = v_dni
                 and p.cod_opc = v_cod_opc) loop
      dbms_output.put_line('    ' || c.tipo_id || ' ' || c.dni || ' ' ||
                           c.cod_cue || ' ' || c.cod_esp || ' ' ||
                           c.cod_pro_1_sus || ' ' || c.cod_pro_2_sus || ' ' ||
                           c.l_lis_sus);
    end loop;
  end;
  procedure mue_int_opc(v_tipo_id sigi_per.tipo_id%type,
                        v_dni     sigi_per.dni%type,
                        l_sigissp varchar2 default 'S',
                        l_sigipsp varchar2 default 'S',
                        l_sigisae varchar2 default 'S',
                        l_sigipae varchar2 default 'S',
                        cod_men   out number,
                        men       out varchar2) is
    v_cod_opc sigi_opc.cod_opc%type;
  begin
    dbms_output.put_line('Datos en sigi_per ');
    for a in (select *
                from sigi_per p
               where p.tipo_id = v_tipo_id
                 and p.dni = v_dni) loop
      dbms_output.put_line('    ' || a.tipo_id || ' ' || a.dni || ' ' ||
                           a.f_nac || ' ' || a.nom || ' ' || a.ape_1 || ' ' ||
                           a.ape_2);
    end loop;
    if l_sigissp = 'S' then
      v_cod_opc := 'SIGISSP';
      mue_sp_opc(v_tipo_id, v_dni, v_cod_opc);
    end if;
    if l_sigipsp = 'S' then
      v_cod_opc := 'SIGIPSP';
      mue_sp_opc(v_tipo_id, v_dni, v_cod_opc);
    end if;
    if l_sigisae = 'S' then
      v_cod_opc := 'SIGISAE';
      mue_ae_opc(v_tipo_id, v_dni, v_cod_opc);
    end if;
    if l_sigipae = 'S' then
      v_cod_opc := 'SIGIPAE';
      mue_ae_opc(v_tipo_id, v_dni, v_cod_opc);
    end if;
  end;

  procedure gra_sol_l_pre is
    /*
    javier 12/06/2015
    para probar los actos de elección de inicio de curso con contraseña:
    pone una solicitud de algunos solicitantes a l_pre S 
    */
    v_con     number := 0;
    v_con_act number := 0;
    v_cod_sol sigi_sol.cod_sol%type;
  begin
    for x in (select distinct tipo_id, dni
                from sigi_sol
               where cod_opc = 'SIGIPAE') loop
      select s.cod_sol
        into v_cod_sol
        from sigi_sol s
       where s.dni = x.dni
         and s.tipo_id = x.tipo_id
         and rownum = 1
       order by dbms_random.random;
      dbms_output.put_line('El dni ' || x.dni || ' ' || v_cod_sol);
      if v_con < 200 then
        update sigi_sol s
           set s.f_hor_pre = sysdate, s.l_pre = 'S'
         where s.tipo_id = x.tipo_id
           and s.dni = x.dni
           and s.cod_sol = v_cod_sol
           and s.cod_opc = 'SIGIPAE';
        v_con_act := v_con_act + 1;
      end if;
      v_con := v_con + 1;
    end loop;
    dbms_output.put_line('¿cuantos van? ' || v_con);
    dbms_output.put_line('¿cuantos se actualizan? ' || v_con_act);
  end;

end sigi_util_pck;
/

