create or replace trigger TRG_W_ERR
  before insert on w_err
  for each row
declare
  -- local variables here
begin
  select nvl(max(num_err),0)+1
  into :new.num_err
  from w_err;
end TRG_W_ERR;
/

