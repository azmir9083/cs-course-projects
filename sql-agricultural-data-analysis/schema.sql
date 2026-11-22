-- Agricultural Data Analysis of Bangladesh (Tropical & Temperate Regions)
-- Schema (MySQL). Tables are ordered so foreign keys resolve.

CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Farmer (
    Farmer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Location_ID INT
);

CREATE TABLE Crop (
    Crop_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Type VARCHAR(100),
    Ideal_Climate VARCHAR(100)
);

CREATE TABLE Land (
    Land_ID INT PRIMARY KEY,
    Size DECIMAL(10, 2),
    Soil_Type VARCHAR(100),
    Location_ID INT
);

-- Junction table for the many-to-many Farmer <-> Land relationship
CREATE TABLE Farmer_Land (
    Farmer_ID INT,
    Land_ID INT,
    PRIMARY KEY (Farmer_ID, Land_ID),
    FOREIGN KEY (Farmer_ID) REFERENCES Farmer(Farmer_ID),
    FOREIGN KEY (Land_ID) REFERENCES Land(Land_ID)
);

CREATE TABLE Production (
    Production_ID INT PRIMARY KEY,
    Crop_ID INT,
    Land_ID INT,
    Year INT,
    Quantity DECIMAL(10, 2),
    FOREIGN KEY (Crop_ID) REFERENCES Crop(Crop_ID),
    FOREIGN KEY (Land_ID) REFERENCES Land(Land_ID)
);

CREATE TABLE Weather (
    Weather_ID INT PRIMARY KEY,
    Date DATE,
    Location_ID INT,
    Temperature DECIMAL(5, 2),
    Rainfall DECIMAL(5, 2),
    Humidity DECIMAL(5, 2),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

CREATE TABLE Market (
    Market_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location_ID INT
);

CREATE TABLE Sales (
    Sales_ID INT PRIMARY KEY,
    Market_ID INT,
    Crop_ID INT,
    Date DATE,
    Quantity DECIMAL(10, 2),
    Price DECIMAL(10, 2),
    FOREIGN KEY (Market_ID) REFERENCES Market(Market_ID),
    FOREIGN KEY (Crop_ID) REFERENCES Crop(Crop_ID)
);

CREATE TABLE Pest (
    Pest_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(255)
);
