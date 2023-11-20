{{ config(materialized='table')}}

with doublons as (
SELECT ID, count(ID) as count_
FROM {{ ref('Main_table') }}
GROUP BY ID
HAVING count_ > 1
)

, db as (
Select ID as ID_2
  , Time
  ,ID_U
  , ROW_NUMBER() OVER(PARTITION BY (ID) ORDER BY ID, Time DESC) as rank_
FROM {{ ref('Main_table') }}
INNER JOIN doublons
USING (ID)
ORDER BY ID, Time
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

SELECT ID_U,
  ID
  ,Type	
  ,Sub_Type	
  ,bed_room	
  ,net_surface	
  ,land_surface	
  ,nbr_room	
  ,Min_surface	
  ,Max_surface	
  ,Min_price	
  ,Max_price	
  ,price	
  ,postalCode	
  ,street	
  ,number	
  ,box	
  ,latitude	
  ,longitude	
  ,sub_site	
FROM to_clean
