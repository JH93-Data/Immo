{{ config(materialized='table')}}

with doublons as (
SELECT ID, count(ID) as count_
FROM {{ ref('Main_table') }}
GROUP BY ID
HAVING count_ > 1
)

, db as (
Select ID as ID_2
  , last_update
  ,ID_U
  , ROW_NUMBER() OVER(PARTITION BY (ID) ORDER BY ID, last_update DESC) as rank_
FROM {{ ref('Main_table') }}
INNER JOIN doublons
USING (ID)
ORDER BY ID, last_update
)

-- , out_put as (
-- SELECT *
-- FROM db
-- WHERE rank_ > 1
-- )

, NEW_DB as (
SELECT *
FROM {{ ref('Main_table') }}
LEFT OUTER JOIN db
USING (ID_U)
)

, to_clean as (
SELECT *
FROM NEW_DB
WHERE rank_ IS NULL OR rank_ = 1
)


,last_update_db as (
SELECT ID
  , MAX(last_update) as Last_version
FROM `realestate-400318.dbt_jh93data.Main_table` 
GROUP BY ID
)

SELECT to_clean.ID_U,
  to_clean.ID
  ,to_clean.Type	
  ,to_clean.Sub_Type	
  ,to_clean.bed_room	
  ,to_clean.net_surface	
  ,to_clean.land_surface	
  ,to_clean.nbr_room	
  ,to_clean.Min_surface	
  ,to_clean.Max_surface	
  ,to_clean.Min_price	
  ,to_clean.Max_price	
  ,to_clean.price	
  ,to_clean.postalCode	
  ,to_clean.street	
  ,to_clean.number	
  ,to_clean.box	
  ,to_clean.latitude	
  ,to_clean.longitude	
  ,to_clean.sub_site
  ,last_update_db.Last_version
FROM to_clean
LEFT JOIN last_update_db
USING (ID)
