with daily_weather as (
    select 
     date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
     from
    {{ source('demo', 'weather') }}

),

daily_weather_agg as (
select 
daily_weather,
weather,
round(avg(temp),2) as AVG_TEMP,
round(avg(pressure),2) as AVG_PRESSURE,
round(avg(humidity),2) as AVG_HUMIDITY,
round(avg(clouds),2) as AVG_CLOUDS
from daily_weather
group by daily_weather, weather
qualify ROW_NUMBER() OVER (partition by daily_weather ORDER BY count(weather) desc)=1

)
select * 
from daily_weather_agg