USE FinalProject14;
GO

-- Drop Sequences
DROP SEQUENCE Asset_SQ
DROP SEQUENCE Politician_SQ
DROP SEQUENCE HouseRep_SQ 
DROP SEQUENCE Senator_SQ
DROP SEQUENCE Committee_SQ
DROP SEQUENCE Assignment_SQ
DROP SEQUENCE Report_SQ
DROP SEQUENCE Trade_SQ

-- Asset Sequence
CREATE SEQUENCE Asset_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

-- Politician Sequence
CREATE SEQUENCE Politician_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

-- HouseRep Sequence
CREATE SEQUENCE HouseRep_SQ 
    AS INT
    START WITH 1
    INCREMENT BY 1;

-- Senator Sequence
CREATE SEQUENCE Senator_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

--Committee Sequence
CREATE SEQUENCE Committee_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

--Assignment Sequence
CREATE SEQUENCE Assignment_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

--Report Sequence
CREATE SEQUENCE Report_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;

--Trade Sequence
CREATE SEQUENCE Trade_SQ
    AS INT
    START WITH 1
    INCREMENT BY 1;