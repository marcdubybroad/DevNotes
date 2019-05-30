
-- select time between workout activity by year
select wday.date, wactivity.row, (wday.date - wday_inner.date) as gap
from wkt_day wday, wkt_activity wactivity, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear, wkt_day wday_inner
where wactivity.workout_id = workout.workout_id
    and workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name = 2016
    and wactivity.row > 0
    and wday_inner.date = (select max(wday2.date)
        from wkt_day wday2, wkt_activity wactivity2, wkt_workout workout2, wkt_week week2,
        wkt_period period2, wkt_year wyear2
        where wactivity2.workout_id = workout2.workout_id
            and workout2.day_id = wday2.day_id
            and wday2.week_id = week2.week_id
            and week2.period_id = period2.period_id
            and period2.year_id = wyear2.year_id
            and wyear2.name = 2016
            and wactivity2.row > 0
            and wday2.date < wday.date
    )
order by wday.date;
    
SELECT
    mt1.ID,
    mt1.Kilometers,
    mt1.date,
    mt1.Kilometers - IFNULL(mt2.Kilometers, 0) AS number_km_since_last_date   
FROM
    myTable mt1
    LEFT JOIN myTable mt2
        ON mt2.Date = (
            SELECT MAX(Date)
            FROM myTable mt3
            WHERE mt3.Date < mt1.Date
        )
ORDER BY mt1.date

-- alternative

SET @gap=0;

select wday.date, wactivity.lift, datediff(wday.date, @gap) as gap, @gap := wday.date
from wkt_day wday, wkt_activity wactivity, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear
where wactivity.workout_id = workout.workout_id
    and workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name = 2016
    and wactivity.lift > 10
order by wday.date

-- select last day of activity related workout
select max()

-- select sum of long od workouts

-- last swim day
select wday.date, wactivity.swim, workout.description
from wkt_day wday, wkt_activity wactivity, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear
where wactivity.workout_id = workout.workout_id
    and workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name in (2017, 2018)
    and wactivity.swim > 0
order by wday.date;

-- last xki day
select wday.date, wactivity.x_ski, workout.description
from wkt_day wday, wkt_activity wactivity, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear
where wactivity.workout_id = workout.workout_id
    and workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name = 2015
    and wactivity.x_ski > 0
order by wday.date;

-- first/last ski day by year
select min(wday.date), max(wday.date), wyear.name
from wkt_day wday, wkt_activity wactivity, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear
where wactivity.workout_id = workout.workout_id
    and workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wactivity.x_ski > 0
group by wyear.name;

-- last workout by type (31 is downhill)
select wday.date, workout.description
from wkt_day wday, wkt_workout workout, wkt_week week, wkt_period period,
    wkt_year wyear, wkt_workout_type workout_type
where workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and workout.workout_type_id = workout_type.workout_type_id
    and workout_type.workout_type_id = 31
    and wyear.name = 2019
order by wday.date;

-- select sum of rowing related workouts
select count(workout.workout_id), sum(activity.erg + activity.row), period.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name in (1994, 2002, 2013, 2014, 2015, 2016, 2017)
--    and period.name in (7, 8, 9, 10)
    and period.name in (1, 2)
    and (activity.row > 0 or activity.erg > 0)
group by period.name_text
order by wyear.name, period.period_id;



-- select sum of all workouts by week, order by max down
select sum(intensity.overdistance + intensity.endurance + intensity.strength + intensity.up_vertical + intensity.intensity + intensity.speed + intensity.race) as week_total, week.name_text
from wkt_workout workout, wkt_intensity intensity, wkt_day wday, wkt_week week
where workout.day_id = wday.day_id
    and intensity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
group by week.name_text
order by week_total;

-- select sum of all workouts by period, order by max down
select sum(intensity.overdistance + intensity.endurance + intensity.strength + intensity.up_vertical + intensity.intensity + intensity.speed + intensity.race) as period_total, period.name_text
from wkt_workout workout, wkt_intensity intensity, wkt_day wday, wkt_week week, wkt_period period
where workout.day_id = wday.day_id
    and intensity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
group by period.name_text
order by period_total;

-- select sum of ski workouts by year, sorted by year
select sum(activity.x_ski) as xski_total, wyear.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
group by wyear.name_text
order by wyear.name;

-- select sum of ski workouts by year and period, sorted by year
select sum(activity.x_ski) as xski_total, wyear.name_text, period.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and activity.x_ski > 0
    and period.name in (7)
group by wyear.name_text, period.name_text
order by wyear.name, period.name_text;

-- select sum of ski workouts by year, sorted by total
select sum(activity.x_ski) as xski_total, wyear.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
group by wyear.name_text
order by xski_total desc;

select sum(activity.x_ski) as xski_total, count(1) as ski_workouts, sum(activity.x_ski)/count(1) as workout_avg,
    count(distinct wday.day_id) as ski_days, sum(activity.x_ski)/count(distinct wday.day_id) as day_avg, wyear.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and activity.x_ski > 0
group by wyear.name_text
order by xski_total desc, ski_workouts desc;

-- select # downhill ski workouts per year
select count(1) as downhill_ski_total, wyear.name_text
from wkt_workout workout, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and workout.workout_type_id = 31
group by wyear.name_text;

-- select description of all downhill workouts for year
select wday.date, workout.description, wyear.name_text
from wkt_workout workout, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and workout.workout_type_id = 31
    and wyear.name = 2019
order by wday.date;


select count(1) as downhill_ski_total, wyear.name_text
from wkt_workout workout, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and lower(workout.description) like '%down hill%'
group by wyear.name_text;

-- select sum of rowing/erg workouts by year, sorted by year
select sum(activity.row) as row_total, sum(activity.erg) as erg_total, wyear.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
group by wyear.name_text
order by wyear.name;

-- select sum of rowing/erg workouts by year, sorted by year
select count(activity.row) as row_count, sum(activity.row) as row_total, wyear.name_text, wyear.rating
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and activity.row > 0
    and period.name > 5
group by wyear.name_text
order by wyear.name;

-- get all workouts and days where description contains word
select wday.date as day, wkt.description
from wkt_workout wkt, wkt_day wday
where wkt.day_id = wday.day_id
--    and lower(wkt.description) like '%hocr%'
and wkt.workout_type_id = 11
order by wday.date;

-- select all bike workouts together that are over a time
select day.date, workout.description
from wkt_workout workout, wkt_activity activity, wkt_day day
where workout.workout_id = activity.workout_id
    and workout.day_id = day.day_id
    and activity.bike > 90
    and lower(workout.description) like '%litchfield%'
    order by day.date;

-- select all workouts by description
select day.date, workout.description
from wkt_workout workout, wkt_day day
where workout.day_id = day.day_id
--    and lower(workout.description) like '%great brook%'
    and lower(workout.description) like '%rangeley%'
    order by day.date;
    
    
-- ski workout averages until current month/day every year
select sum(activity.x_ski) as xski_total, count(1) as ski_workouts, sum(activity.x_ski)/count(1) as workout_avg,
    count(distinct wday.day_id) as ski_days, sum(activity.x_ski)/count(distinct wday.day_id) as day_avg,
    sum(activity.x_ski)/dayofyear(sysdate()) as running_avg, wyear.name
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and activity.x_ski > 0
    and (dayofyear(wday.date) <= dayofyear(sysdate()) or year(wday.date) < wyear.name)
group by wyear.name_text
order by wyear.name


-- xski totals
select sum(activity.x_ski) as xski_total, count(1) as ski_workouts, sum(activity.x_ski)/count(1) as workout_avg,
    count(distinct wday.day_id) as ski_days, sum(activity.x_ski)/count(distinct wday.day_id) as day_avg, wyear.name
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and activity.x_ski > 0 
    and (dayofyear(wday.date) <= dayofyear(sysdate()) or year(wday.date) < wyear.name)
group by wyear.name_text
order by wyear.name

