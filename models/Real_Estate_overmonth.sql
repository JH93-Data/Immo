

{{ config(materialized='table')}}

Select  ID_U
    , ID
  ,Min_price	
  ,Max_price
  ,price		
  ,last_update
FROM {{ ref('Main_table') }}