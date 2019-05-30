

-- totals for account by year
select ba.month_id div 100 as year_id, ba.account_id, min(ba.total_balance), max(ba.total_balance),
    max(ba.total_balance) - min(ba.total_balance) - sum(ba.transfer) as diff,
    100 * (max(ba.total_balance) - min(ba.total_balance) - sum(ba.transfer)) /  min(ba.total_balance) as percent,
    sum(ba.income), sum(ba.transfer)
from inv_balance_sheet ba
-- where ba.account_id = 2
where ba.account_id = 28
group by year_id, ba.account_id
order by year_id;



-- list all months for account
