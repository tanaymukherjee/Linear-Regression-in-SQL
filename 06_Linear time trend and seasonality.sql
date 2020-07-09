with complete_years_only as (
  select *
  from tutorial.us_housing_units
  where year <= 2013
),
predictors as (
  select year
    , month
    , south as housing_units
    , (year * 12) + (month - 1) as time
    , (year * 12) + (month - 1) - avg((year * 12) + (month - 1)) over () as time_c
    , case when month = 2 then 1 when month < 2 then -1 else 0 end as month_1
    , case when month = 3 then 2 when month < 3 then -1 else 0 end as month_2
    , case when month = 4 then 3 when month < 4 then -1 else 0 end as month_3
    , case when month = 5 then 4 when month < 5 then -1 else 0 end as month_4
    , case when month = 6 then 5 when month < 6 then -1 else 0 end as month_5
    , case when month = 7 then 6 when month < 7 then -1 else 0 end as month_6
    , case when month = 8 then 7 when month < 8 then -1 else 0 end as month_7
    , case when month = 9 then 8 when month < 9 then -1 else 0 end as month_8
    , case when month = 10 then 9 when month < 10 then -1 else 0 end as month_9
    , case when month = 11 then 10 when month < 11 then -1 else 0 end as month_10
    , case when month = 12 then 11 when month < 12 then -1 else 0 end as month_11
  from complete_years_only
),
sums_squares as (
  select count(*) as num_rows
    , sum(housing_units) as housing_units_sum
    , sum(housing_units * housing_units) as housing_units_sum_sq
    , sum(time_c) as time_c_sum
    , sum(time_c * time_c) as time_c_sum_sq
    , sum(housing_units * time_c) as housing_units_time_c_sum_prod
    , sum(month_1) as month_1_sum
    , sum(month_1 * month_1) as month_1_sum_sq
    , sum(housing_units * month_1) as housing_units_month_1_sum_prod
    , sum(month_2) as month_2_sum
    , sum(month_2 * month_2) as month_2_sum_sq
    , sum(housing_units * month_2) as housing_units_month_2_sum_prod
    , sum(month_3) as month_3_sum
    , sum(month_3 * month_3) as month_3_sum_sq
    , sum(housing_units * month_3) as housing_units_month_3_sum_prod
    , sum(month_4) as month_4_sum
    , sum(month_4 * month_4) as month_4_sum_sq
    , sum(housing_units * month_4) as housing_units_month_4_sum_prod
    , sum(month_5) as month_5_sum
    , sum(month_5 * month_5) as month_5_sum_sq
    , sum(housing_units * month_5) as housing_units_month_5_sum_prod
    , sum(month_6) as month_6_sum
    , sum(month_6 * month_6) as month_6_sum_sq
    , sum(housing_units * month_6) as housing_units_month_6_sum_prod
    , sum(month_7) as month_7_sum
    , sum(month_7 * month_7) as month_7_sum_sq
    , sum(housing_units * month_7) as housing_units_month_7_sum_prod
    , sum(month_8) as month_8_sum
    , sum(month_8 * month_8) as month_8_sum_sq
    , sum(housing_units * month_8) as housing_units_month_8_sum_prod
    , sum(month_9) as month_9_sum
    , sum(month_9 * month_9) as month_9_sum_sq
    , sum(housing_units * month_9) as housing_units_month_9_sum_prod
    , sum(month_10) as month_10_sum
    , sum(month_10 * month_10) as month_10_sum_sq
    , sum(housing_units * month_10) as housing_units_month_10_sum_prod
    , sum(month_11) as month_11_sum
    , sum(month_11 * month_11) as month_11_sum_sq
    , sum(housing_units * month_11) as housing_units_month_11_sum_prod
  from predictors
),
b_components as (
  select *
    , housing_units_time_c_sum_prod - (housing_units_sum * time_c_sum / num_rows) as time_c_b_numer
    , time_c_sum_sq - (time_c_sum * time_c_sum / num_rows) as time_c_b_denom
    , housing_units_month_1_sum_prod - (housing_units_sum * month_1_sum / num_rows) as month_1_b_numer
    , month_1_sum_sq - (month_1_sum * month_1_sum / num_rows) as month_1_b_denom
    , housing_units_month_2_sum_prod - (housing_units_sum * month_2_sum / num_rows) as month_2_b_numer
    , month_2_sum_sq - (month_2_sum * month_2_sum / num_rows) as month_2_b_denom
    , housing_units_month_3_sum_prod - (housing_units_sum * month_3_sum / num_rows) as month_3_b_numer
    , month_3_sum_sq - (month_3_sum * month_3_sum / num_rows) as month_3_b_denom
    , housing_units_month_4_sum_prod - (housing_units_sum * month_4_sum / num_rows) as month_4_b_numer
    , month_4_sum_sq - (month_4_sum * month_4_sum / num_rows) as month_4_b_denom
    , housing_units_month_5_sum_prod - (housing_units_sum * month_5_sum / num_rows) as month_5_b_numer
    , month_5_sum_sq - (month_5_sum * month_5_sum / num_rows) as month_5_b_denom
    , housing_units_month_6_sum_prod - (housing_units_sum * month_6_sum / num_rows) as month_6_b_numer
    , month_6_sum_sq - (month_6_sum * month_6_sum / num_rows) as month_6_b_denom
    , housing_units_month_7_sum_prod - (housing_units_sum * month_7_sum / num_rows) as month_7_b_numer
    , month_7_sum_sq - (month_7_sum * month_7_sum / num_rows) as month_7_b_denom
    , housing_units_month_8_sum_prod - (housing_units_sum * month_8_sum / num_rows) as month_8_b_numer
    , month_8_sum_sq - (month_8_sum * month_8_sum / num_rows) as month_8_b_denom
    , housing_units_month_9_sum_prod - (housing_units_sum * month_9_sum / num_rows) as month_9_b_numer
    , month_9_sum_sq - (month_9_sum * month_9_sum / num_rows) as month_9_b_denom
    , housing_units_month_10_sum_prod - (housing_units_sum * month_10_sum / num_rows) as month_10_b_numer
    , month_10_sum_sq - (month_10_sum * month_10_sum / num_rows) as month_10_b_denom
    , housing_units_month_11_sum_prod - (housing_units_sum * month_11_sum / num_rows) as month_11_b_numer
    , month_11_sum_sq - (month_11_sum * month_11_sum / num_rows) as month_11_b_denom
  from sums_squares
),
reg_coefs as (
  select *
    , time_c_b_numer / time_c_b_denom as time_c_b
    , month_1_b_numer / month_1_b_denom as month_1_b
    , month_2_b_numer / month_2_b_denom as month_2_b
    , month_3_b_numer / month_3_b_denom as month_3_b
    , month_4_b_numer / month_4_b_denom as month_4_b
    , month_5_b_numer / month_5_b_denom as month_5_b
    , month_6_b_numer / month_6_b_denom as month_6_b
    , month_7_b_numer / month_7_b_denom as month_7_b
    , month_8_b_numer / month_8_b_denom as month_8_b
    , month_9_b_numer / month_9_b_denom as month_9_b
    , month_10_b_numer / month_10_b_denom as month_10_b
    , month_11_b_numer / month_11_b_denom as month_11_b
    , (housing_units_sum / num_rows) -
        (time_c_b_numer / time_c_b_denom) * (time_c_sum / num_rows) -
        (month_1_b_numer / month_1_b_denom) * (month_1_sum / num_rows) -
        (month_2_b_numer / month_2_b_denom) * (month_2_sum / num_rows) -
        (month_3_b_numer / month_3_b_denom) * (month_3_sum / num_rows) -
        (month_4_b_numer / month_4_b_denom) * (month_4_sum / num_rows) -
        (month_5_b_numer / month_5_b_denom) * (month_5_sum / num_rows) -
        (month_6_b_numer / month_6_b_denom) * (month_6_sum / num_rows) -
        (month_7_b_numer / month_7_b_denom) * (month_7_sum / num_rows) -
        (month_8_b_numer / month_8_b_denom) * (month_8_sum / num_rows) -
        (month_9_b_numer / month_9_b_denom) * (month_9_sum / num_rows) -
        (month_10_b_numer / month_10_b_denom) * (month_10_sum / num_rows) -
        (month_11_b_numer / month_11_b_denom) * (month_11_sum / num_rows)
      as a
  from b_components
),
predicted_values as (
  select predictors.*
    , num_rows
    , housing_units_sum
    , a
    , time_c_b
    , month_1_b
    , month_2_b
    , month_3_b
    , month_4_b
    , month_5_b
    , month_6_b
    , month_7_b
    , month_8_b
    , month_9_b
    , month_10_b
    , month_11_b
    , a + time_c_b * time_c +
        month_1_b * month_1 +
        month_2_b * month_2 +
        month_3_b * month_3 +
        month_4_b * month_4 +
        month_5_b * month_5 +
        month_6_b * month_6 +
        month_7_b * month_7 +
        month_8_b * month_8 +
        month_9_b * month_9 +
        month_10_b * month_10 +
        month_11_b * month_11
      as housing_units_pred
  from predictors
  join reg_coefs
  on 1=1
)
select year, month, housing_units, time_c
  , housing_units_pred
  , housing_units - housing_units_pred as deviations
  , housing_units - housing_units_pred + (housing_units_sum / num_rows) as detrend_deseas_data
from predicted_values
order by 1,2;
