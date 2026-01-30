/*
====================================================================================
Create Database and Schemas
====================================================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, if is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver' and 'gold

WARNING:
    Execute this script only once in your SQL Server environment.
    Ensure no existing database or schemas exist with the same names to avoid accidental data loss.
    Review and adjust database and schema names according to your organization’s naming conventions.
    This script does not contain data; it only sets up the structure.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse; 
END;
GO

-- Create the 'DataWarehouse' database  
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
