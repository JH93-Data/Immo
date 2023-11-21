
{{ config(materialized='table')}}

SELECT ID
      ,sub_site
FROM {{ ref('Main_Unique') }}
