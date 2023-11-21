{{ config(materialized='table')}}

SELECT ROW_NUMBER() over() as ID_U
    ,ID
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
    ,Time as last_update
FROM `realestate-400318.Immo_web.data_immoweb`