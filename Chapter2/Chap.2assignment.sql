SELECT SKU, SKU Description FROM INVENTORY;

SELECT SKU Description , SKU FROM INVENTORY;

SELECT WAREHOUSEID FROM INVENTORY;

SELECT Distinct WAREHOUSEID FROM INVENTORY;

SELECT WAREHOUSEID, SKU, SKU_DESCRIPTION, QUANTITYONHAND, QUANTITYONORDER FROM INVENTORY;

SELECT * FROM INVENTORY;

SELECT QUANTITYONHAND FROM INVENTORY WHERE QuantityOnHand > 0;

SELECT SKU, SKU_DESCRIPTION FROM INVENTORY WHERE QUANTITYONHAND = 0;

SELECT SKU, SKU_DESCRIPTION, WAREHOUSEID FROM INVENTORY WHERE QUANTITYONHAND = 0 ORDER BY WAREHOUSEID asc;

SELECT SKU, SKU_DESCRIPTION, WAREHOUSEID FROM  INVENTORY WHERE QUANTITYONHAND > 0 ORDER BY WAREHOUSEID desc, SKU asc;

SELECT SKU, SKU_Description, WarehouseID FROM INVENTORY WHERE QuantityOnHand = 0 AND QuantityOnOrder > 0 ORDER BY WarehouseID desc, SKU asc;

SELECT SKU, SKU_Description, WarehouseID FROM INVENTORY WHERE QuantityOnHand = 0 OR QuantityOnOrder = 0 ORDER BY WarehouseID desc, SKU asc; 

SELECT SKU, SKU_Description, WarehouseID, QuantityOnHand FROM INVENTORY WHERE QuantityOnHand > 1 AND QuantityOnHand < 10;

SELECT SKU, SKU_Description, WarehouseID, QuantityOnHand FROM INVENTORY WHERE QuantityOnHand BETWEEN 2 AND 9;

SELECT DISTINCT SKU, SKU_Description FROM INVENTORY WHERE SKU_Description LIKE 'Half-Dome%';

SELECT DISTINCT SKU, SKU_Description FROM INVENTORY WHERE SKU_Description LIKE '%Climb%';

SELECT DISTINCT SKU, SKU_Description FROM INVENTORY WHERE SKU_Description LIKE '__d%';

SELECT MIN(QuantityOnHand) AS MinQuantityOnHand, MAX(QuantityOnHand) AS MaxQuantityOnHand, AVG(QuantityOnHand) AS AvgQuantityOnHand, SUM(QuantityOnHand) AS SumQuantityOnHand, COUNT(QuantityOnHand) AS CountQuantityOnHand FROM INVENTORY;

SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHand FROM INVENTORY GROUP BY WarehouseID ORDER BY TotalItemsOnHand desc;

SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHandLT3 FROM INVENTORY WHERE QuantityOnHand < 3 GROUP BY WarehouseID ORDER BY TotalItemsOnHandLT3 desc;

SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHandLT3 FROM INVENTORY WHERE QuantityOnHand < 3 GROUP BY WarehouseID HAVING COUNT(*) < 2 ORDER BY TotalItemsOnHandLT3 DESC;


show tables;
show databases;
use cape_codd;

SELECT SKU, SKU_Description FROM INVENTORY;

SELECT INVENTORY.SKU, INVENTORY.SKU_Description, WAREHOUSE.WarehouseID, WAREHOUSE.WarehouseCity, WAREHOUSE.WarehouseState
FROM INVENTORY JOIN WAREHOUSE ON INVENTORY.WarehouseID = WAREHOUSE.WarehouseID WHERE WAREHOUSE.WarehouseCity = 'Atlanta' OR WAREHOUSE.WarehouseCity = 'Bangor' OR WAREHOUSE.WarehouseCity = 'Chicago';

SELECT INVENTORY.SKU, INVENTORY.SKU_Description, INVENTORY.WarehouseID, WarehouseCity, WarehouseState 
FROM INVENTORY, WAREHOUSE WHERE INVENTORY.WarehouseID = WAREHOUSE.WarehouseID AND WarehouseCity <> 'Atlanta' AND WarehouseCity <> 'Bangor' AND WarehouseCity <> 'Chicago';

SELECT CONCAT(INVENTORY.SKU_Description, ' is located in ', WAREHOUSE.WarehouseCity)AS ItemLocation
FROM INVENTORY JOIN WAREHOUSE ON INVENTORY.WarehouseID = WAREHOUSE.WarehouseID;

SELECT WarehouseID
FROM WAREHOUSE
WHERE Manager = 'Lucille Smith';

SELECT INVENTORY.SKU, INVENTORY.SKU_Description, INVENTORY.WarehouseID
FROM INVENTORY WHERE WarehouseID = (SELECT WarehouseID FROM WAREHOUSE WHERE Manager = 'Lucille Smith');

SELECT INVENTORY.WarehouseID,
QuantityOnOrder, SUM(QuantityOnOrder) AS TotalItemsOnOrder, SUM(QuantityOnHand) AS TotalItemsOnHand FROM INVENTORY GROUP BY WarehouseID, QuantityOnOrder;


show tables;

SELECT 
-- FROM INVENTORY
-- WHERE WarehouseID = (
--     SELECT WarehouseID
--     FROM WAREHOUSE
--     ...
-- );
-- you can't use subquery because it doesn't solve anything.
--  There's no need to retrieve information from another table
-- or another query. Everything needed is in inventory. 
-- The appropriate operation is GROUP BY with SUM()

-- A join combines row from two or more tables based on the related column
    -- Happens when you combine INVENTORY + WAREHOUSE using warehouseID
    -- A subquery is a query inside abother query. The inner query runs to find the warehouseID
    -- The outer query uses that result. 
SELECT * 
FROM INVENTORY
JOIN WAREHOUSE
ON INVENTORY.WarehouseID = WAREHOUSE.WarehouseID;

SELECT INVENTORY.SKU,
       INVENTORY.SKU_Description
FROM INVENTORY
WHERE WarehouseID = (
    SELECT WarehouseID
    FROM WAREHOUSE
    WHERE Manager = 'Lucille Smith'
);

SELECT WAREHOUSE.WarehouseID,
       WAREHOUSE.WarehouseCity,
       WAREHOUSE.WarehouseState,
       WAREHOUSE.Manager,
       INVENTORY.SKU,
       INVENTORY.SKU_Description,
       INVENTORY.QuantityOnHand,
       INVENTORY.QuantityOnOrder
FROM WAREHOUSE
LEFT JOIN INVENTORY
ON WAREHOUSE.WarehouseID = INVENTORY.WarehouseID;

SELECT SKU, SKU_Description, Department
FROM CATALOG_SKU_2016 UNION SELECT SKU, SKU_Description, Department FROM CATALOG_SKU_2017;
	
SELECT SKU, SKU_Description, Department
FROM CATALOG_SKU_2016 WHERE CatalogPage IS NOT NULL UNION SELECT SKU, SKU_Description, Department FROM CATALOG_SKU_2017 WHERE CatalogPage IS NOT NULL;

SELECT SKU, SKU_Description, Department
FROM CATALOG_SKU_2016 INTERSECT SELECT SKU, SKU_Description, Department FROM CATALOG_SKU_2017;

SELECT SKU, SKU_Description, Department
FROM CATALOG_SKU_2016 WHERE CatalogPage IS NOT NULL INTERSECT SELECT SKU, SKU_Description, Department FROM CATALOG_SKU_2017 WHERE CatalogPage IS NOT NULL; 

SELECT C16.SKU, C16.SKU_Description, C16.Department FROM CATALOG_SKU_2016 AS C16 WHERE NOT EXISTS (SELECT * FROM CATALOG_SKU_2017 AS C17 WHERE C17.SKU = C16.SKU);





