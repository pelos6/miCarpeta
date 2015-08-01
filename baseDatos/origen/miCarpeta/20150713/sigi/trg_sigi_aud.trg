create or replace trigger trg_sigi_aud
  before insert on sigi_aud
  for each row
declare
  -- local variables here
begin
  select max(num_aud) + 1
  into :new.num_aud
  from sigi_aud;
end trg_sigi_aud;
/

