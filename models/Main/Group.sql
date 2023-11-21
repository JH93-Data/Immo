{{ config(materialized='table')}}

SELECT ID
  ,Type	
  ,Min_surface	
  ,Max_surface	
  ,Min_price	
  ,Max_price	
  ,Last_version
FROM {{ ref('Main_Unique') }}
WHERE Type = "HOUSE_GROUP" OR Type = "APARTMENT_GROUP"