create or replace trigger TRG_W_AUD_AE
  before insert on w_aud_ae
  for each row
declare
  -- local variables here
begin
  select nvl(max(num_reg),0)+1
  into :new.num_reg
  from w_aud_ae;
end TRG_W_AUD_AE;
/

