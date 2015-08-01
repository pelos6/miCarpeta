create or replace trigger trg_sigi_err
  before insert on sigi_err
  for each row
declare
  -- local variables here
begin
  select max(num_err) + 1
  into :new.num_err
  from sigi_err;
end trg_sigi_err;
/

