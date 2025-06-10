EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '=======================================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================================================================='  ;

			PRINT '---------------------------------------------------------------------------------------';
			PRINT 'Loading CRM Tables'
			PRINT '---------------------------------------------------------------------------------------';

			PRINT ' >> Truncating Table: bronze.crm_cust_info ' ;
			TRUNCATE TABLE bronze.crm_cust_info;

			PRINT ' >> Inserting Data Into : bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
					);

			PRINT ' >> Truncating Table: bronze.crm_prd_info';
			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT ' >> Inserting Data Into : bronze.crm_prd_info';
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
					);

			PRINT ' >> Truncating Table: bronze.crm_sales_details';
			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT ' >> Inserting Data Into : bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
					);

			PRINT '---------------------------------------------------------------------------------------';
			PRINT 'Loading ERP Tables'
			PRINT '---------------------------------------------------------------------------------------';

			PRINT ' >> Truncating Table: bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT ' >> Inserting Data Into : bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
					);

			PRINT ' >> Truncating Table: bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT ' >> Inserting Data Into : bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
					);

			PRINT ' >> Truncating Table: bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT ' >> Inserting Data Into : bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\Klara\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
		);
	END TRY
	BEGIN CATCH
		DECLARE @msg NVARCHAR(MAX) = ERROR_MESSAGE();
		DECLARE @num INT = ERROR_NUMBER();
		DECLARE @state INT = ERROR_STATE();

		PRINT '=================================================';
		PRINT 'Error Message: ' + @msg;
		PRINT 'Error Number: ' + CAST(@num AS NVARCHAR);
		PRINT 'Error State: ' + CAST(@state AS NVARCHAR);
		PRINT '=================================================';

		-- Uložení chyby do logovací tabulky
		INSERT INTO bronze.error_log (error_message, error_number, error_state)
		VALUES (@msg, @num, @state);
	END CATCH
END