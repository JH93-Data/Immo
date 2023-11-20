
{{ config(materialized='table')}}

SELECT ID
    , ID_U
      ,sub_site
FROM {{ ref('Main_Unique') }}
