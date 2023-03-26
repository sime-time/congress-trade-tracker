USE FinalProject14;
GO
-- create stored procedure that cleans raw trade data and inserts into tables
ALTER PROCEDURE InsertTrade_SP
    @ReportDate date,
    @ReportURL nvarchar(300),
    @AssetTicker nvarchar(20),
    @AssetName nvarchar(300),
    @AssetType nvarchar(50),
    @TradeType nvarchar(5), 
    @TradeDate date, 
    @TradeMin int,
    @TradeOwner varchar(20),
    @FirstInitial nvarchar(2),
    @LastName nvarchar(50)
AS 
BEGIN  
    SET NOCOUNT ON;
    BEGIN TRY 
        BEGIN TRANSACTION
        -- insert into report table if it doesn't already exist or grab the report_id 
        DECLARE @ReportID int 
        SET @ReportID = (SELECT report_id FROM Report WHERE report_url = @ReportURL)
        IF NOT EXISTS (SELECT report_id FROM Report WHERE report_url = @ReportURL)
            INSERT INTO Report (report_id, report_date, report_url)
                VALUES (NEXT VALUE FOR Report_SQ, @ReportDate, @ReportURL);
            SET @ReportID = CONVERT(int, (SELECT current_value FROM sys.sequences WHERE name = 'Report_SQ'))

        -- insert into asset table if it doesn't already exist or grab the asset_id
        DECLARE @AssetID int 
        SET @AssetID = (SELECT asset_id FROM Asset WHERE asset_name = @AssetName)
        IF NOT EXISTS (SELECT asset_id FROM Asset WHERE asset_name = @AssetName)
            INSERT INTO Asset (asset_id, asset_ticker, asset_name, asset_type)
                VALUES (NEXT VALUE FOR Asset_SQ, @AssetTicker, @AssetName, @AssetType);
            SET @AssetID = CONVERT(int, (SELECT current_value FROM sys.sequences WHERE name = 'Asset_SQ'))
            
        -- use @TradeMin to find the correct trade range id 
        DECLARE @TradeRangeID int 
        SET @TradeRangeID = (SELECT rng_id FROM TradeRange WHERE rng_min = @TradeMin)

        -- use @FirstInitial and @LastName to grab the pol_id
        DECLARE @PolID int 
        SET @PolID = (SELECT pol_id FROM Politician WHERE pol_fname LIKE @FirstInitial + '%' AND pol_lname = @LastName)

        -- insert into trade table 
        INSERT INTO Trade (trd_id, trd_type, trd_date, trd_owner, rng_id, pol_id, asset_id, report_id)
        VALUES (NEXT VALUE FOR Trade_SQ, @TradeType, @TradeDate, @TradeOwner, @TradeRangeID, @PolID, @AssetID, @ReportID);   

        COMMIT
            
    END TRY 
    BEGIN CATCH 
        ROLLBACK
        SELECT ERROR_NUMBER() AS ErrorNumber
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END 
