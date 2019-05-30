

DROP PROCEDURE IF EXISTS populateYearly;

DELIMITER $$
create procedure populateYearly(in p_account_id int(11))
BEGIN

declare v_start_year int(4) default 2008;
declare v_temp_year int(4) default 2008;
declare v_end_year int(4) default 2018;
declare v_temp_month int(6);

-- delete all the rows for the year
delete from inv_yearly_report where account_id = p_account_id and year_id >= v_start_year and year_id <= v_end_year;

-- loop through the years
while v_temp_year <= v_end_year do
  -- insert a new row
  insert into inv_yearly_report (year_id, account_id) values(v_temp_year, p_account_id);
  
  -- set the start total
  set v_temp_month = (v_temp_year -1) * 100 + 12;
  update inv_yearly_report
  set start_total = (select total_balance from inv_balance_sheet where account_id = p_account_id and month_id = v_temp_month)
  where account_id = p_account_id and year_id = v_temp_year;
  
  -- set the end total
  set v_temp_month = (v_temp_year) * 100 + 12;
  update inv_yearly_report
  set end_total = (select total_balance from inv_balance_sheet where account_id = p_account_id and month_id = v_temp_month)
  where account_id = p_account_id and year_id = v_temp_year;
  
  -- set the income
  update inv_yearly_report
  set income_total = (select sum(income) from inv_balance_sheet where account_id = p_account_id and (month_id DIV 100) = v_temp_year)
  where account_id = p_account_id and year_id = v_temp_year;
  
  -- set the transfer
  update inv_yearly_report
  set transfer_total = (select sum(transfer) from inv_balance_sheet where account_id = p_account_id and (month_id DIV 100) = v_temp_year)
  where account_id = p_account_id and year_id = v_temp_year;
  
  -- increment the year
  set v_temp_year = v_temp_year + 1;
end while;
commit;

-- calculate the return total
update inv_yearly_report set return_total = end_total - start_total - transfer_total
where account_id = p_account_id and year_id >= v_start_year and year_id <= v_end_year;

-- calculate the return percent
update inv_yearly_report set return_percent = return_total * 100 / start_total
where account_id = p_account_id and year_id >= v_start_year and year_id <= v_end_year;

-- calculate the income percent
update inv_yearly_report set income_percent = income_total * 100 / start_total
where account_id = p_account_id and year_id >= v_start_year and year_id <= v_end_year;
commit;

END $$
DELIMITER ;


-- scratch
call populateYearly(2);
select * from inv_yearly_report;

