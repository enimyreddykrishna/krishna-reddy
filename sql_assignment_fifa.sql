create database assignment_1;
use assignment_1;

# first ,we know the table data 
select * from fifa;  

# How many players are there in the dataset?                           # total  count of the players
select count(distinct id) as cnt from fifa;                                         # answer : 16643

# How many nationalities do these players belong to?                              
                                                                                     
select count(distinct nationality) as cnt_nationality  from fifa;                   
 SELECT DISTINCT
    nationality AS cnt_nationality
FROM
    fifa; 


# What is the total wage given to all players? What's the average and standard deviation?
select sum(wage) as total_wage,
avg(wage) as avg_wage,
stddev(wage) as std_wage
from fifa;


#Which nationality has the highest number of players, what are the top 3 nationalities by # of players?
SELECT nationality, COUNT(*) AS player_count
FROM fifa
GROUP BY nationality
ORDER BY player_count DESC
LIMIT 3;

# Which player has the highest wage? Who has the lowest?
 -- Highest Wage (with ties)
SELECT name, wage
FROM fifa
ORDER BY wage DESC
LIMIT 1;


-- Lowest Wage (with ties)
SELECT name, wage
FROM fifa
ORDER BY wage asc
LIMIT 1;

#The player having the – best overall rating? Worst overall rating?
select name,overall
from fifa
order by overall desc 
limit  1;

#  ---low rating
select name,overall
from fifa
order by overall asc 
limit  1;

# Club having the highest total of overall rating? Highest Average of overall rating?
##--high  

SELECT club, SUM(overall) AS total_overall
FROM fifa
GROUP BY club
ORDER BY total_overall DESC
LIMIT 1;

#---low 
SELECT club, AVG(overall) AS average_rating
FROM fifa
GROUP BY club
ORDER BY average_rating DESC
LIMIT 1;


# What are the top 5 clubs based on the average ratings of their players and their corresponding averages?
SELECT club,AVG(overall) AS average_rating
FROM fifa
GROUP BY club,o
ORDER BY average_rating DESC
LIMIT 5;
 

# ----assignment 1-2
###What is the distribution of players whose preferred foot is left vs right?

SELECT preferred_foot, COUNT(*) AS player_count
FROM fifa
GROUP BY preferred_foot;

### Which jersey number is the luckiest?

SELECT jersey_number, COUNT(*) AS top_players
FROM fifa
WHERE overall >= 85
GROUP BY jersey_number
ORDER BY top_players DESC
LIMIT 1;

#What is the frequency distribution of nationalities among players whose club name starts with M?
SELECT nationality, COUNT(*) AS player_count
FROM fifa
WHERE club LIKE 'M%'
GROUP BY nationality
ORDER BY player_count DESC;

#How many players have joined their respective clubs in the date range 20 May 2018 to 10 April 2019 (both inclusive)?
select count(*) as player 
from fifa
where str_to_date(joined,'%d-%m-%Y')
between '2018-05-20' and '2019-04-10';


select str_to_date(joined,'%d-%m-%Y') as join_date,
count(*) as player_joined from fifa
where joined is not null
group by join_date
order by join_date;


#How many players have joined their respective clubs yearly?

select  year (str_to_date(joined,'%d-%m-%Y')) as join_date,
count(*) as player_joined from fifa
where joined is not null
group by join_date
order by join_date;

