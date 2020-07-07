with centered_time as (
  select *
    , (year * 12) + (month - 1) as time
    , (year * 12) + (month - 1) - avg((year * 12) + (month - 1)) over () as time_c
    , format('%s-%s-%s', year, month, 01)::date as date_month
  from tutorial.us_housing_units
)
select *
from centered_time;
