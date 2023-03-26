USE FinalProject14;
GO

-- Get a list of tables and views in the current database
SELECT table_catalog [database], table_schema [schema], table_name [name], table_type [type]
FROM INFORMATION_SCHEMA.TABLES
GO

DROP TABLE Trade;
DROP TABLE TradeRange;
DROP TABLE Report;
DROP TABLE Senator;
DROP TABLE HouseRep;
DROP TABLE Assignment;
DROP TABLE Committee;
DROP TABLE Politician;
DROP TABLE State;
DROP TABLE Party;
DROP TABLE Asset;


CREATE TABLE Asset (
    asset_id        int             NOT NULL,
    asset_ticker    varchar(20)     NULL,
    asset_name      varchar(300)    NULL,
    asset_type      varchar(50)     NULL,
    CONSTRAINT Asset_PK PRIMARY KEY (asset_id)
);

CREATE TABLE Party (
    party_id    char(1)         NOT NULL,
    party_name  varchar(20)     NOT NULL,
    CONSTRAINT Party_PK PRIMARY KEY  (party_id)
);

CREATE TABLE State (
    state_abv       varchar(2)      NOT NULL, -- natural primary key
    state_name      varchar(40)     NOT NULL,
    CONSTRAINT State_PK PRIMARY KEY (state_abv)
);

CREATE TABLE Politician (
    pol_id          int             NOT NULL,
    pol_fname       varchar(50)     NOT NULL,
    pol_mname       varchar(50)     NULL,
    pol_lname       varchar(50)     NOT NULL,
    pol_term_start  int             NULL,
    pol_term_end    int             NULL,
    pol_url         varchar(300)    NULL,
    party_id        char(1)         NOT NULL,
    state_abv       varchar(2)      NULL,
    CONSTRAINT Politician_PK PRIMARY KEY  (pol_id),
    CONSTRAINT Politician_Party FOREIGN KEY (party_id) REFERENCES Party (party_id),
    CONSTRAINT Politician_State FOREIGN KEY (state_abv) REFERENCES State (state_abv),
    CONSTRAINT Term_Start_End CHECK (pol_term_start < pol_term_end OR pol_term_end IS NULL)
);

CREATE TABLE HouseRep (
    house_id        int     NOT NULL,
    house_district  int     NULL,
    pol_id          int     NOT NULL,
    CONSTRAINT HouseRep_PK PRIMARY KEY  (house_id),
    CONSTRAINT HouseRep_Politician FOREIGN KEY (pol_id) REFERENCES Politician (pol_id)
);

CREATE TABLE Senator (
    senator_id      int     NOT NULL,
    pol_id          int     NOT NULL,
    CONSTRAINT Senator_PK PRIMARY KEY  (senator_id),
    CONSTRAINT Senator_Politician FOREIGN KEY (pol_id) REFERENCES Politician (pol_id)
);

CREATE TABLE Committee (
    cmt_id      int             NOT NULL,
    cmt_name    varchar(200)    NOT NULL,
    CONSTRAINT Committee_PK PRIMARY KEY  (cmt_id)
);

CREATE TABLE Assignment ( 
    assign_id   int     NOT NULL,
    pol_id      int     NOT NULL,
    cmt_id      int     NOT NULL,
    CONSTRAINT Assignment_PK PRIMARY KEY (assign_id),
    CONSTRAINT Assignment_Committee FOREIGN KEY (cmt_id) REFERENCES Committee (cmt_id),
    CONSTRAINT Assignment_Politician FOREIGN KEY (pol_id) REFERENCES Politician (pol_id)
);

CREATE TABLE Report (
    report_id       int             NOT NULL,
    report_url      varchar(300)    NULL,
    report_date     date            NULL,
    CONSTRAINT Report_PK PRIMARY KEY  (report_id)
);

CREATE TABLE TradeRange (
    rng_id      int     NOT NULL,
    rng_min     int     NOT NULL,
    rng_max     int     NULL,
    CONSTRAINT TradeRange_PK PRIMARY KEY  (rng_id)
);

CREATE TABLE Trade (
    trd_id      int         NOT NULL,
    trd_type    varchar(5)  NULL,
    trd_date    date        NULL,
    trd_owner   varchar(20) NULL,
    rng_id      int         NOT NULL,
    pol_id      int         NOT NULL,
    asset_id    int         NOT NULL,
    report_id   int         NOT NULL,
    CONSTRAINT Trade_PK PRIMARY KEY  (trd_id),
    CONSTRAINT Trade_Report FOREIGN KEY (report_id) REFERENCES Report (report_id),
    CONSTRAINT Trade_Asset FOREIGN KEY (asset_id) REFERENCES Asset (asset_id),
    CONSTRAINT Trade_Politician FOREIGN KEY (pol_id) REFERENCES Politician (pol_id),
    CONSTRAINT Trade_Range FOREIGN KEY (rng_id) REFERENCES TradeRange (rng_id)
);