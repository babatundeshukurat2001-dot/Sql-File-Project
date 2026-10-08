SHOW DATABASES;
USE mi_ch02;

-- Question A
SELECT * 
FROM ITEM, SHIPMENT, SHIPMENT_ITEM;

-- QUESTION B 
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber 
FROM SHIPMENT;

-- Question C 
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber 
FROM SHIPMENT
WHERE InsuredValue > 10000;

#Question D 
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber 
FROM SHIPMENT
WHERE ShipperName like 'AB%';

-- QUESTION E 
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate 
FROM SHIPMENT 
WHERE MONTH(DEPARTUREDATE) = 12;

-- QUESTION F 
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate 
FROM SHIPMENT
WHERE DAY(DEPARTUREDATE) = 10;

-- QUESTION G 
SELECT  max(InsuredValue), min(InsuredValue) 
FROM SHIPMENT;

-- QUESTION H 
SELECT AVG(InsuredValue) 
FROM SHIPMENT;

-- QUESTION I 
SELECT COUNT(*) AS TotalShipments 
FROM SHIPMENT;

-- QUESTION J 
SELECT ItemID, Description, Store, (LocalCurrencyAmount*ExchangeRate) 
As USCurrencyAmount 
FROM ITEM;

-- Question K 
SELECT City, Store FROM ITEM GROUP BY City, Store;

-- Question L 
SELECT City, Store, COUNT(*) 
AS TotalPurchases 
FROM ITEM 
GROUP BY City, Store;

-- QUESTION M
SELECT ShipperName, ShipmentID, DepartureDate 
FROM SHIPMENT 
WHERE ShipmentID IN (
    SELECT ShipmentID 
    FROM SHIPMENT_ITEM 
    WHERE `Value` >= 1000
) 
ORDER BY ShipperName ASC, DepartureDate DESC;

-- QUESTION N
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate 
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
WHERE si.`Value` >= 1000 
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- QUESTION O
SELECT ShipperName, ShipmentID, DepartureDate 
FROM SHIPMENT 
WHERE ShipmentID IN (
    SELECT si.ShipmentID 
    FROM SHIPMENT_ITEM si
    JOIN ITEM i ON si.ItemID = i.ItemID
    WHERE i.City = 'Singapore'
) 
ORDER BY ShipperName ASC, DepartureDate DESC;

-- QUESTION P
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate 
FROM SHIPMENT s, SHIPMENT_ITEM si, ITEM i 
WHERE s.ShipmentID = si.ShipmentID 
  AND si.ItemID = i.ItemID 
  AND i.City = 'Singapore' 
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- QUESTION Q
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate 
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
JOIN ITEM i ON si.ItemID = i.ItemID
WHERE i.City = 'Singapore' 
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;


-- QUESTION R
SELECT s.ShipperName, s.ShipmentID, s.DepartureDate, si.`Value` 
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
WHERE si.ItemID IN (
    SELECT ItemID 
    FROM ITEM 
    WHERE City = 'Singapore'
)
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;


-- QUESTION S
SELECT s.ShipperName, s.ShipmentID, s.DepartureDate, si.`Value` 
FROM SHIPMENT s
LEFT JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
LEFT JOIN ITEM i ON si.ItemID = i.ItemID AND i.City = 'Singapore'
ORDER BY si.`Value` ASC, s.ShipperName ASC, s.DepartureDate DESC;