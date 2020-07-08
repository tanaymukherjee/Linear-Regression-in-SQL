with centered_time as (
  select *
    , (year * 12) + (month - 1) as time
    , (year * 12) + (month - 1) - avg((year * 12) + (month - 1)) over () as time_c
  from tutorial.us_housing_units
),
sums_squares as (
  select count(*) as num_rows
    , sum(south) as south_sum
    , sum(south * south) as south_sum_sq
    , sum(time_c) as time_c_sum
    , sum(time_c * time_c) as time_c_sum_sq
    , sum(south * time_c) as south_time_c_sum_prod
  from centered_time
),
b_components as (
  select *
    , south_time_c_sum_prod - (south_sum * time_c_sum / num_rows) as b_numer
    , time_c_sum_sq - (time_c_sum * time_c_sum / num_rows) as b_denom
  from sums_squares
),
reg_coefs as (
  select *
    , b_numer / b_denom as b
    , (south_sum / num_rows) - (b_numer / b_denom) * (time_c_sum / num_rows) as a
  from b_components
),
sum_deviations as (
  select a, b
    , b_denom
    , num_rows
    , sum((south - (a + b * time_c))^2) as south_sse
  from centered_time
  join reg_coefs
  on 1=1
  group by 1,2,3,4
)
select a, b
  , sqrt(south_sse / (b_denom * (num_rows - 2))) as b_se
  , b / sqrt(south_sse / (b_denom * (num_rows - 2))) as t_stat
from sum_deviations;
