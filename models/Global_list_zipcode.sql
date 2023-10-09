{{ config(materialized='table')}}


SELECT Code
    , CASE
        WHEN Province =  "Bruxelle" then "Région de Bruxelle"
        WHEN Province = "Brabant wallon" or  Province = "Liège" or Province = "Namur" or Province = "Hainaut" or Province = "Luxembourg" then "Région Wallonne"
        WHEN Province = "Brabant flamand" or Province = "Antwerpen" or Province ="Brabant flamand" or Province = "Limbourg" or Province = "Flandre-Occidentale" or Province = "Flandre-Orientale" then "Région Flamande"
       END as Region 
    ,Province
    ,Commune
    ,Sub_Commune
    ,Key_com
FROM {{ ref('List_commune') }}