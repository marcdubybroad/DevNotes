
-- test load of categorizing samples
select count(ID), origin from SAMPLE_17k group by origin;

select count(ID) as total, BMI from SAMPLE_17k group by BMI order by total asc;

select count(ID) as total, BMI from SAMPLE_17k
where BMI < 25 and t2d = 1
group by BMI order by total asc;


select count(ID) from SAMPLE_17k where BMI is not null;


