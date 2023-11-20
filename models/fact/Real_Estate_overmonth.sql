

{{ config(materialized='table')}}

Select  ID_U
    , ID
  ,Min_price	
  ,Max_price
  ,price		
  ,Time
FROM {{ ref('Main_table') }}