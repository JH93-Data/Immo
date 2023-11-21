
{{ config(materialized='table')}}

SELECT ID
  ,postalCode	
  ,street	
  ,number 
  ,box
  ,CASE
    WHEN number is Not NULL and box is null then CONCAT(street,", ", number)
    WHEN number is Not NULL and box is Not null then CONCAT(street,", ", number, "/", box)
    ELSE street
   END as address
  ,CAST(latitude as string) as latitude
  ,CAST(longitude as string) as longitude
FROM {{ ref('Main_Unique') }}