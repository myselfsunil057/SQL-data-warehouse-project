/*
====================================================================================
Create Database and Schemas
====================================================================================
Script Purpose:
    This script initializes the foundational structures of the data warehouse by:
    Creating the main database for the project.
    Defining schemas for each layer of the data pipeline:
      Bronze: Raw ingested data, untransformed.
      Silver: Cleaned and curated data ready for analytics.
      Gold: Aggregated, business-ready datasets for reporting and BI.

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
