
WITH c as (
SELECT Code
    ,StatBel_immo.function_province(Code) as Province
    ,Commune
    ,Sub_Commune
    ,REPLACE(Sub_Commune, "é","e") as sans_accent
FROM `realestate-400318.StatBel_immo.List_Commune`
)

SELECT Code
    ,Province
    ,Commune
    ,Sub_Commune
    ,UPPER(sans_accent) as Key_com
FROM c