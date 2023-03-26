USE FinalProject14;
GO
-- create stored procedure that cleans raw member data and inserts into tables
ALTER PROCEDURE InsertPolitician_SP
    @FirstName nvarchar(50),
    @MiddleName nvarchar(30),
    @LastName nvarchar(50),
    @URL nvarchar(300),
    @State nvarchar(50), 
    @Party nvarchar(25),
    @District int,
    @Chamber nvarchar(20),
    @TermStart int,
    @TermEnd int
AS 
BEGIN
    SET NOCOUNT ON;
    -- use @State to query the right state abv 
    DECLARE @StateAbv nvarchar(2) 
    SET @StateAbv = (SELECT state_abv FROM State WHERE state_name = @State)

    -- take the first letter of the @Party to insert as party_id
    DECLARE @PartyID char(1) 
    SET @PartyID = LEFT(@Party, 1) 

    -- insert a new politician using sequence
    INSERT INTO Politician (pol_id, pol_fname, pol_mname, pol_lname, pol_url, pol_term_start, pol_term_end, state_abv, party_id)
    VALUES(NEXT VALUE FOR Politician_SQ, @FirstName, @MiddleName, @LastName, @URL, @TermStart, @TermEnd, @StateAbv, @PartyID);

    -- get the current value of the Politician_SQ that was just used
    DECLARE @CurrentPoliSQ int 
    SET @CurrentPoliSQ = CONVERT(int, (SELECT current_value FROM sys.sequences WHERE name = 'Politician_SQ'))

    -- use @Chamber to determine if the politician is a senator or house rep
    IF @Chamber = 'Senate'
        INSERT INTO Senator (senator_id, pol_id)
        VALUES(NEXT VALUE FOR Senator_SQ, @CurrentPoliSQ);
    ELSE 
        INSERT INTO HouseRep (house_id, pol_id, house_district)
        VALUES(NEXT VALUE FOR HouseRep_SQ, @CurrentPoliSQ, @District);     
END