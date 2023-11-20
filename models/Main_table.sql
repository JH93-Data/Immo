{{ config(materialized='table')}}

SELECT *
  , ROW_NUMBER() over() as ID_U
FROM `realestate-400318.Immo_web.data_immoweb`