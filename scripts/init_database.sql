/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

/*
What it does:
Switches the current database context to the master system database.
Why it matters:
You cannot drop a database you're currently using.
If you’re connected to DataWarehouse, this command switches you away from it so the script can safely drop it.
*/

USE master;
GO
/*
Drop and recreate the 'DataWarehouse' database
The IF EXISTS part looks for at least one row from the inner query. If a row exists, the IF condition is true, and the code inside BEGIN ... END runs.
What it does:
Forces the database into single-user mode, meaning only one connection (you) is allowed.
WITH ROLLBACK IMMEDIATE forcibly disconnects all other users and rolls back any uncommitted transactions.
Why it matters:
If others are connected to the DB (even idle), DROP DATABASE will fail.
This makes sure the drop will succeed without manual intervention. 
*/
	
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
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

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
