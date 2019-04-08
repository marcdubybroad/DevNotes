

-- number of row with Hudson 1x per year broken down by months
select count(workout.workout_id), month(wday.date) as wmonth
from wkt_workout workout, wkt_day wday, wkt_activity activity
where workout.day_id = wday.day_id and activity.workout_id = workout.workout_id
and year(wday.date) = 2013
and activity.row > 20
and lower(workout.description) like '%hudson%'
group by month(wday.date);

-- get all the rows with the Hudson 1x for 2018
select workout.workout_id, wday.date, activity.row, workout.description
from wkt_workout workout, wkt_day wday, wkt_activity activity
where workout.day_id = wday.day_id and activity.workout_id = workout.workout_id
and year(wday.date) = 2016
and activity.row > 20
and lower(workout.description) like '%hudson%'
order by wday.date;

-- get all the rows with the Hudson 1x for all years broken down by year
select count(workout.workout_id), year(wday.date) as year
from wkt_workout workout, wkt_day wday, wkt_activity activity
where workout.day_id = wday.day_id and activity.workout_id = workout.workout_id
and year(wday.date) > 2010
and activity.row > 20
and lower(workout.description) like '%hudson%'
group by year(wday.date);


-- debug query to look for hudson typos
select workout.workout_id, wday.date, workout.description
from wkt_workout workout, wkt_day wday
where workout.day_id = wday.day_id
and year(wday.date) = 2018
and lower(workout.description) not like '%hudson%'
and lower(workout.description) like '%son%'
order by wday.date;

