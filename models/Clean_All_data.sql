

{{ config(materialized='table')}}


With Filtered as (
SELECT CD_YEAR as Y
        ,CD_TYPE_FR
        ,CD_REFNIS as Post_code
        ,CD_REFNIS_FR as Commune
        ,CD_PERIOD as Quarter
        ,CONCAT(CD_YEAR, " - ", CD_PERIOD) as Y_Quater
        ,MS_TOTAL_TRANSACTIONS as Nbr_trans
        ,MS_P_25 as Price_25
        ,MS_P_50_median as Price_median
        ,MS_P_75 as Price_75
        ,CD_niveau_refnis as Level_commune	
FROM {{ ref('AllInfoStatBel') }}
WHERE (CD_PERIOD = "Q1" or CD_PERIOD = "Q2" or CD_PERIOD = "Q3" or CD_PERIOD = "Q4") and CD_niveau_refnis = 5 and (CD_TYPE_FR = "Maisons avec 2 ou 3 façades (type fermé + type demi-fermé)" or 
CD_TYPE_FR = "Maisons avec 4 ou plus de façades (type ouvert)" or CD_TYPE_FR = "Appartements")
)

Select Y
        ,Quarter
        ,Y_Quater
        ,CASE
            when CD_TYPE_FR = "Maisons avec 2 ou 3 façades (type fermé + type demi-fermé)" then "House"
            When CD_TYPE_FR = "Maisons avec 4 ou plus de façades (type ouvert)"  then "Villa"
            When CD_TYPE_FR = "Appartements" then "Flat" 
        End as Type
        ,Post_code
        ,Commune
        ,Nbr_trans
        ,Price_25
        ,Price_median
        ,Price_75
FROM Filtered