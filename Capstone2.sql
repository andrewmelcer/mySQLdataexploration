#Create tables to have all the total steps counted by day of the week 

CREATE TABLE monday(
id bigint,
mondaysteps int
)

INSERT INTO monday 
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Mon'
group by id
order by sum(totalsteps) DESC

SELECT * FROM monday

CREATE TABLE tuesday(
id bigint,
tuesdaysteps int
);

INSERT INTO tuesday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Tue'
group by id
order by sum(totalsteps) DESC

SELECT * FROM tuesday

CREATE TABLE wednesday(
id bigint,
wednesdaysteps int
);

INSERT INTO wednesday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Wed'
group by id
order by sum(totalsteps) DESC

SELECT * FROM wednesday

CREATE TABLE thursday(
id bigint,
thursdaysteps int
);

INSERT INTO thursday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Thu'
group by id
order by sum(totalsteps) DESC

SELECT * FROM thursday

CREATE TABLE friday(
id bigint,
fridaysteps int
);

INSERT INTO friday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Fri'
group by id
order by sum(totalsteps) DESC

SELECT * FROM friday

CREATE TABLE saturday(
id bigint,
saturdaysteps int
);

INSERT INTO saturday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Sat'
group by id
order by sum(totalsteps) DESC

SELECT * FROM saturday

CREATE TABLE sunday(
id bigint,
sundaysteps int
);

INSERT INTO sunday
SELECT id, SUM(totalsteps) 
FROM daily_activity
WHERE WeekDay = 'Sun'
group by id
order by sum(totalsteps) DESC

SELECT * FROM sunday

#Join the tables together to create a view 

SELECT m.id,
m.mondaysteps,
t.tuesdaysteps,
w.wednesdaysteps,
th.thursdaysteps,
f.fridaysteps,
s.saturdaysteps,
su.sundaysteps
FROM monday m
JOIN tuesday t
ON m.id = t.id 
JOIN wednesday w
ON m.id = w.id
JOIN thursday th
ON m.id= th.id
JOIN friday f 
ON m.id = f.id
JOIN saturday s
ON m.id = s.id
JOIN sunday su 
ON m.id = su.id

#Find average calorie count per user

SELECT id, ROUND(sum(calories)/30 ,0) as AverageCalories
FROM daily_activity
GROUP BY id
ORDER BY sum(calories) DESC

#Find any correlation between activity and time needed to sleep 

SELECT id, ROUND(SUM(minutesneeded)/30, 0) as Averagetimetosleep FROM minutestosleep
WHERE id IS NOT NULL
GROUP BY id;

SELECT id,ROUND(SUM(veryactiveminutes + fairlyactiveminutes)/30, 0)
FROM daily_activity
GROUP BY id 

SELECT da.id,
ROUND(AVG(veryactiveminutes + fairlyactiveminutes), 0) as averageactiveminutes,
ROUND(AVG(minutesneeded), 0) as Averagetimetosleep
FROM daily_activity da
JOIN minutestosleep m on da.id = m.id
GROUP BY da.id


SELECT id,
ROUND(SUM(minutesneeded)/30, 0) as Averagetimetosleep
FROM minutestosleep
WHERE id IS NOT NULL
GROUP BY id 
