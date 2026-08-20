
-- metricflow_time_spine.sql
with 

days as (
    
    --for BQ adapters use "DATE('01/01/2000','mm/dd/yyyy')"
{{ dbt_utils.date_spine(
    datepart="hour",
    start_date="to_date('01/01/1990', 'mm/dd/yyyy')",
    end_date="dateadd(year, 1, current_date)"
   )
}} 

),

cast_to_date as (

    select 
        cast(date_hour as timestamp) as date_hour
    
    from days

)

select * from cast_to_date
