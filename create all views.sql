ALTER VIEW vUsers AS
SELECT usr.usr_id, usr.usrt_id, usrt.usrt_name, usrt.usrt_description, usr.usr_name, usr.usr_username, usr.usr_password, usr.usr_birthdate,
usr.usr_address, usr.usr_city, usr.usr_zipcode, usr.usr_email, usr.usr_phone, usr.usr_status, usrt.usrt_customer, usrt.usrt_admin, usrt.usrt_status
FROM Users usr
inner join UserTypes usrt on usr.usrt_id = usrt.usrt_id
;

select * from vUsers --where usrt_admin = 1

ALTER VIEW vProducts AS
SELECT prod.prod_id, prod.prodt_id, prodty.prodt_name, prodty.prodt_description, prod.prod_name, prod.prod_brand, prod.prod_condition, prod.prod_description,
prod.prod_price, prod.prod_status, prodty.prodt_status
FROM Products prod
inner join ProductsTypes prodty on prod.prodt_id = prodty.prodt_id
;

--update Products set prodt_id = 2 where prod_id = 10

select * from vProducts --where prodt_id = 6

ALTER VIEW vInvoice AS
SELECT 
invc.invc_id, invc.usr_id, usr.usr_name, usr.usr_email, usr.usr_phone, paym.paym_id, paym.paym_name, paym.paym_method,
invc.invc_orders, ord.ord_id, ord.ord_date, ord.ord_content, 
(SELECT STRING_AGG(prodq.prod_name, ', ')
        FROM vProducts prodq
        WHERE prodq.prod_id IN (SELECT value 
                                 FROM STRING_SPLIT(ord.ord_content, ',')))[Products],
(SELECT STRING_AGG(prodq.prodt_name, ', ')
        FROM vProducts prodq
        WHERE prodq.prod_id IN (SELECT value 
                                 FROM STRING_SPLIT(ord.ord_content, ',')))[Products_Types],
ord.shp_id,isnull(shipp.shp_name, 'No Shipping')[shp_name],isnull(shipp.shp_address, 'No Shipping')[shp_address],
isnull(shipp.shp_city, 'No Shipping')[shp_city],isnull(shipp.shp_state, 'No Shipping')[shp_state],shipp.shp_zipcode,
isnull(shipp.shp_tracking, 'No Shipping')[shp_tracking],
invc.invc_subtotal, invc.invc_discount, invc.invc_total, invc.invc_date, invc.invc_status
FROM Invoice invc
inner join Users usr on invc.usr_id = usr.usr_id
left join Payment paym on invc.paym_id = paym.paym_id
inner join Orders ord ON EXISTS (
        SELECT 1
        FROM STRING_SPLIT(invc.invc_orders, ',') AS s
        WHERE s.value = ord.ord_id
    )  
	left join Shipping shipp on ord.shp_id = shipp.shp_id
;

select * from vInvoice


CREATE VIEW vInventory AS
SELECT inv.inv_id, inv.prod_id, prod.prod_name, prod.prod_condition, prod.prod_price, prod.prodt_id, 
prod.prodt_name, inv.inv_quantity, inv.usr_id, usr.usr_name, inv.inv_mod_date, inv.inv_state
FROM Inventory inv
inner join Users usr on inv.usr_id = usr.usr_id
inner join vProducts prod on inv.prod_id = prod.prod_id
;

select * from vInventory

