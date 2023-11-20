
{{ config(materialized='table')}}

WITH db_loca as (

SELECT *
    ,RANK() over(PARTITION BY ID order by ID, Time) as rank_2
FROM {{ ref('Main_Unique') }}
)

SELECT ID
  ,postalCode	
  ,street	
  ,number 
  ,box
  ,CASE
    WHEN number is Not NULL and box is null then CONCAT(street,", ", number)
    WHEN number is Not NULL and box is Not null then CONCAT(street,", ", number, '/', box)
    ELSE street
  END as address
  ,CAST(latitude as string) as latitude
  ,CAST(longitude as string) as longitude
FROM db_loca
WHERE rank_2 = 1