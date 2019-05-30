

-- add in the version table
drop table if exists inv_yearly_report;
create table inv_yearly_report (
yearly_report_id 	         int not null auto_increment primary key,
year_id                      int(4) not null,
account_id                   int not null,
start_total                  decimal(19, 2),
end_total                  decimal(19, 2),
transfer_total                  decimal(19, 2),
income_total                  decimal(19, 2),
return_total                  decimal(19, 2),
return_percent               decimal(8,2),
income_percent               decimal(8,2),
date_created    datetime default CURRENT_TIMESTAMP,
version         bigint(20) default 0
);


