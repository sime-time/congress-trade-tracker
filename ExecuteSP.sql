USE FinalProject14;
GO

EXECUTE [dbo].[InsertTrade_SP]
    @ReportDate = '2020-06-10',
    @ReportURL = 'https://disclosures-clerk.house.gov/public_disc/ptr-pdfs/2020/20016738.pdf',
    @AssetTicker = 'USB',
    @AssetName =  'U.S. Bancorp',
    @AssetType = NULL,
    @TradeType = 'SELL',
    @TradeDate = '2020-04-09',
    @TradeMin = 1001,
    @TradeOwner = '--',
    @FirstInitial = 'E',
    @LastName = 'Perlmutter'

select * from Politician;
select * from HouseRep;
--select * from Senator;
select * from TradeRange;
--select * from State;
--select * from Party;

select * from Asset order by asset_ticker ;
select * from Report;
select count(*) from Trade;
select * from Assignment;
select * from Committee;

SELECT asset_id FROM Asset WHERE asset_name = 'Liberty Media Corporation - Series C Liberty Brave'
select * from Politician Where pol_lname like 'Lee%'