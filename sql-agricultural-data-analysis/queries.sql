-- Agricultural Data Analysis: queries (MySQL)

-- =========================================================
-- BASIC
-- =========================================================

-- HAVING: lands whose total production exceeds 500 units
SELECT Land_ID, SUM(Quantity) AS Total_Quantity
FROM Production
GROUP BY Land_ID
HAVING SUM(Quantity) > 500;

-- COUNT: number of markets in each location
SELECT Location_ID, COUNT(Market_ID) AS Number_of_Markets
FROM Market
GROUP BY Location_ID;

-- ORDER BY: all crops ordered by type
SELECT * FROM Crop
ORDER BY Type ASC;

-- GROUP BY: average temperature per location
SELECT Location_ID, AVG(Temperature) AS Average_Temperature
FROM Weather
GROUP BY Location_ID;

-- LIKE: farmers whose names start with 'M'
SELECT * FROM Farmer
WHERE Name LIKE 'M%';

-- =========================================================
-- INTERMEDIATE (joins)
-- =========================================================

-- INNER JOIN: farmers and the crops they produced
SELECT Farmer.Name AS Farmer_Name, Crop.Name AS Crop_Name
FROM Farmer
INNER JOIN Farmer_Land ON Farmer.Farmer_ID = Farmer_Land.Farmer_ID
INNER JOIN Production  ON Farmer_Land.Land_ID = Production.Land_ID
INNER JOIN Crop        ON Production.Crop_ID = Crop.Crop_ID;

-- FULL OUTER JOIN (emulated with LEFT JOIN + UNION, since MySQL has no FULL JOIN)
SELECT Market.Name AS Market_Name, Location.Name AS Location_Name
FROM Market
LEFT JOIN Location ON Market.Location_ID = Location.Location_ID
UNION
SELECT Market.Name AS Market_Name, Location.Name AS Location_Name
FROM Location
LEFT JOIN Market ON Location.Location_ID = Market.Location_ID;

-- RIGHT JOIN: all farmed lands and their farmers
SELECT Land.*, Farmer.Name AS Farmer_Name
FROM Land
RIGHT JOIN Farmer_Land ON Land.Land_ID = Farmer_Land.Land_ID
LEFT JOIN Farmer ON Farmer_Land.Farmer_ID = Farmer.Farmer_ID;

-- LEFT JOIN: every farmer's total production (including farmers with none)
SELECT Farmer.Name AS Farmer_Name, SUM(Production.Quantity) AS Total_Quantity
FROM Farmer
LEFT JOIN Farmer_Land ON Farmer.Farmer_ID = Farmer_Land.Farmer_ID
LEFT JOIN Production  ON Farmer_Land.Land_ID = Production.Land_ID
GROUP BY Farmer.Name;

-- CROSS JOIN: random sample of crop x market combinations
SELECT
    Crop.Name AS Crop_Name,
    Crop.Type AS Crop_Type,
    Market.Name AS Market_Name,
    Market.Location_ID AS Market_Location_ID
FROM Crop
CROSS JOIN Market
WHERE Crop.Ideal_Climate <> Market.Location_ID
ORDER BY RAND()
LIMIT 20;

-- =========================================================
-- ADVANCED (nested joins & subqueries)
-- =========================================================

-- Nested INNER JOIN: avg temperature where each crop is grown + total sales of that crop
SELECT Crop.Name AS Crop_Name,
       AVG(Weather.Temperature) AS Average_Temperature,
       SalesDetails.Total_Sales_Quantity
FROM Crop
INNER JOIN Production ON Crop.Crop_ID = Production.Crop_ID
INNER JOIN (
    SELECT Land.Land_ID, Location_ID
    FROM Land
) AS LandDetails ON Production.Land_ID = LandDetails.Land_ID
INNER JOIN Weather ON LandDetails.Location_ID = Weather.Location_ID
INNER JOIN (
    SELECT Crop_ID, SUM(Quantity) AS Total_Sales_Quantity
    FROM Sales
    GROUP BY Crop_ID
) AS SalesDetails ON Crop.Crop_ID = SalesDetails.Crop_ID
GROUP BY Crop.Name, SalesDetails.Total_Sales_Quantity;

-- Nested RIGHT JOIN (two-way): all locations, their markets and sales totals
SELECT Market.*, SalesDetails.Total_Sales_Quantity, Location.Name AS Location_Name
FROM Market
RIGHT JOIN (
    SELECT Sales.Market_ID, SUM(Sales.Quantity) AS Total_Sales_Quantity
    FROM Sales
    GROUP BY Sales.Market_ID
) AS SalesDetails ON Market.Market_ID = SalesDetails.Market_ID
RIGHT JOIN Location ON Market.Location_ID = Location.Location_ID;

-- Nested EQUI JOIN: farmer, crop, and total sales of that crop
SELECT Farmer.Name AS Farmer_Name, Crop.Name AS Crop_Name, SalesDetails.Total_Sales_Quantity
FROM Farmer
JOIN (
    SELECT Farmer_Land.Farmer_ID, Production.Crop_ID
    FROM Farmer_Land
    JOIN Production ON Farmer_Land.Land_ID = Production.Land_ID
) AS FarmerProduction ON Farmer.Farmer_ID = FarmerProduction.Farmer_ID
JOIN Crop ON FarmerProduction.Crop_ID = Crop.Crop_ID
JOIN (
    SELECT Crop_ID, SUM(Quantity) AS Total_Sales_Quantity
    FROM Sales
    GROUP BY Crop_ID
) AS SalesDetails ON Crop.Crop_ID = SalesDetails.Crop_ID;

-- Nested LEFT JOIN (three-way): farmer, crop, sales and avg temperature,
-- keeping farmers/crops with no sales or weather data (COALESCE -> 0)
SELECT Farmer.Name AS Farmer_Name, Crop.Name AS Crop_Name,
       COALESCE(SalesDetails.Total_Sales_Quantity, 0) AS Total_Sales_Quantity,
       COALESCE(WeatherDetails.Average_Temperature, 0) AS Average_Temperature
FROM Farmer
LEFT JOIN (
    SELECT Farmer_Land.Farmer_ID, Production.Crop_ID, Production.Land_ID
    FROM Farmer_Land
    LEFT JOIN Production ON Farmer_Land.Land_ID = Production.Land_ID
) AS FarmerProduction ON Farmer.Farmer_ID = FarmerProduction.Farmer_ID
LEFT JOIN Crop ON FarmerProduction.Crop_ID = Crop.Crop_ID
LEFT JOIN (
    SELECT Sales.Crop_ID, SUM(Sales.Quantity) AS Total_Sales_Quantity
    FROM Sales
    GROUP BY Sales.Crop_ID
) AS SalesDetails ON Crop.Crop_ID = SalesDetails.Crop_ID
LEFT JOIN (
    SELECT Land.Land_ID, AVG(Weather.Temperature) AS Average_Temperature
    FROM Land
    LEFT JOIN Weather ON Land.Location_ID = Weather.Location_ID
    GROUP BY Land.Land_ID
) AS WeatherDetails ON FarmerProduction.Land_ID = WeatherDetails.Land_ID;

-- Nested INNER-LEFT JOIN: farmer, crop, avg temperature (crops without weather data kept)
SELECT Farmer.Name AS Farmer_Name, Crop.Name AS Crop_Name,
       COALESCE(WeatherDetails.Average_Temperature, 0) AS Average_Temperature
FROM Farmer
INNER JOIN (
    SELECT Farmer_Land.Farmer_ID, Production.Crop_ID, Production.Land_ID
    FROM Farmer_Land
    INNER JOIN Production ON Farmer_Land.Land_ID = Production.Land_ID
) AS FarmerProduction ON Farmer.Farmer_ID = FarmerProduction.Farmer_ID
INNER JOIN Crop ON FarmerProduction.Crop_ID = Crop.Crop_ID
LEFT JOIN (
    SELECT Land.Land_ID, AVG(Weather.Temperature) AS Average_Temperature
    FROM Land
    LEFT JOIN Weather ON Land.Location_ID = Weather.Location_ID
    GROUP BY Land.Land_ID
) AS WeatherDetails ON FarmerProduction.Land_ID = WeatherDetails.Land_ID;
