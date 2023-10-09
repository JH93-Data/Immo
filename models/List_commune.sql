SELECT Code
    ,StatBel_immo.function_province(Code) as Province
    ,Commune
    ,Sub_Commune
FROM `realestate-400318.StatBel_immo.List_Commune`