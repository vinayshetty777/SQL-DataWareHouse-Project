'''Stored Procedure: Load Bronze Layer Source -> Bronze)
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the BULK INSERT command to load data from csv Files to bronze tables.
Parameters:
None.
This stored procedure does not accept any parameters or return any values.
Usage Example:
EXEC bronze.load_bronze'''


  
use DataWarehouse;
go
create or alter procedure bronze.load_bronze as
begin
    declare @start_time datetime, @end_time datetime;
    set @start_time= GETDATE();
    begin try
        RAISERROR('==========================================================', 0, 1) WITH NOWAIT;
        RAISERROR('loading bronze layer', 0, 1) WITH NOWAIT;
        RAISERROR('==========================================================', 0, 1) WITH NOWAIT;

        RAISERROR('==========================================================', 0, 1) WITH NOWAIT;
        RAISERROR('loading crm tables', 0, 1) WITH NOWAIT;
        RAISERROR('==========================================================', 0, 1) WITH NOWAIT;

        declare @starttime datetime, @endtime datetime;
        


        set @starttime= GETDATE();
        RAISERROR('>> truncating tables crm_cust_info', 0, 1) WITH NOWAIT;
        truncate table bronze.crm_cust_info;

        RAISERROR('inserting into table crm_cust_info', 0, 1) WITH NOWAIT;
        bulk insert bronze.crm_cust_info
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime=GETDATE();
        print 'load duration' +cast(datediff(second, @starttime, @endtime)as varchar) +'seconds';


        set @starttime= getdate();
        RAISERROR('>> truncating tables crm_prd_info', 0, 1) WITH NOWAIT;
        truncate table bronze.crm_prd_info;
        RAISERROR('inserting into table crm_prd_info', 0, 1) WITH NOWAIT;
        bulk insert bronze.crm_prd_info
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime= getdate();
        print 'loading time of crm_prd_info is' +cast(datediff(second,@starttime, @endtime) as varchar)+ 'seconds'


        set @starttime= getdate();
        RAISERROR('>> truncating tables crm_sales_details', 0, 1) WITH NOWAIT;
        truncate table bronze.crm_sales_details;
        RAISERROR('inserting into table crm_sales_details', 0, 1) WITH NOWAIT;
        bulk insert bronze.crm_sales_details
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime= getdate();
        print 'loading time of crm_sales_details is' +cast(datediff(second,@starttime, @endtime) as varchar)+ 'seconds'


        RAISERROR('-----------------------------------------------------------', 0, 1) WITH NOWAIT;
        print 'loading erp tables';
        RAISERROR('-----------------------------------------------------------', 0, 1) WITH NOWAIT;


        set @starttime= getdate();
        RAISERROR('truncating tables erp_cust_az12', 0, 1) WITH NOWAIT;
        truncate table bronze.erp_cust_az12;
        RAISERROR('inserting into table erp_cust_az12', 0, 1) WITH NOWAIT;
        bulk insert bronze.erp_cust_az12
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime= getdate();
        print 'loading time of erp_cust_az12 is' +cast(datediff(second,@starttime, @endtime) as varchar)+ 'seconds'


        set @starttime= getdate();
        RAISERROR('truncating tables erp_loc_a101', 0, 1) WITH NOWAIT;
        truncate table bronze.erp_loc_a101;
        RAISERROR('inserting into table erp_loc_a101', 0, 1) WITH NOWAIT;
        bulk insert bronze.erp_loc_a101
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime= getdate();
        print 'loading time of erp_loc_a101 is' +cast(datediff(second,@starttime, @endtime) as varchar)+ 'seconds'


        set @starttime= getdate();
        RAISERROR('truncating tables erp_px_cat_g1v2 --', 0, 1) WITH NOWAIT;
        truncate table bronze.erp_px_cat_g1v2;
        RAISERROR('inserting into table erp_px_cat_g1v2 --', 0, 1) WITH NOWAIT;
        bulk insert bronze.erp_px_cat_g1v2
        from 'C:\Users\asus\Documents\aa_docxx\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        with (
            firstrow=2,
            fieldterminator=',' ,
            tablock
            );
        set @endtime= getdate();
        print 'loading time of erp_px_cat_g1v2 is' +cast(datediff(second,@starttime, @endtime) as varchar)+ 'seconds'

        
    end try
    begin catch
    raiserror('error occured during loading of bronze layer',0,1) with nowait;
    print 'error message:' +error_message();
    end catch

    set @end_time=getdate();
     print'---------------------------------------------------'
     print'loading time of bronze layer is ' +cast(datediff(second,@start_time, @end_time) as varchar)+'seconds'
     print'---------------------------------------------------'

end



exec bronze.load_bronze



