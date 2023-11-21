{{ config(materialized='table')}}

SELECT ID
  ,Type	
  ,Sub_Type	
  ,bed_room	
  ,net_surface	
  ,land_surface	
  ,nbr_room	
  ,price	
  ,Last_version
FROM {{ ref('Main_Unique') }}
WHERE Type != "HOUSE_GROUP" OR Type != "APARTMENT_GROUP"