USE FinalProject14;
GO

-- Party Inserts
INSERT INTO Party VALUES('D', 'Democrat');
INSERT INTO Party VALUES('R', 'Republican');
INSERT INTO Party VALUES('I', 'Independent'); 
INSERT INTO Party VALUES('L', 'Libertarian');


-- State Inserts
INSERT INTO State VALUES('AL', 'Alabama');          INSERT INTO State VALUES('AK', 'Alaska');
INSERT INTO State VALUES('AZ', 'Arizona');          INSERT INTO State VALUES('AR', 'Arkansas');
INSERT INTO State VALUES('CA', 'California');       INSERT INTO State VALUES('CO', 'Colorado');
INSERT INTO State VALUES('CT', 'Connecticut');      INSERT INTO State VALUES('DE', 'Delaware');
INSERT INTO State VALUES('FL', 'Florida');          INSERT INTO State VALUES('DC', 'District of Columbia'); 
INSERT INTO State VALUES('GA', 'Georgia');          INSERT INTO State VALUES('HI', 'Hawaii');
INSERT INTO State VALUES('ID', 'Idaho');            INSERT INTO State VALUES('IL', 'Illinois');
INSERT INTO State VALUES('IN', 'Indiana');          INSERT INTO State VALUES('IA', 'Iowa');
INSERT INTO State VALUES('KS', 'Kansas');           INSERT INTO State VALUES('KY', 'Kentucky');
INSERT INTO State VALUES('LA', 'Louisiana');        INSERT INTO State VALUES('ME', 'Maine');
INSERT INTO State VALUES('MD', 'Maryland');         INSERT INTO State VALUES('MA', 'Massachusetts');
INSERT INTO State VALUES('MI', 'Michigan');         INSERT INTO State VALUES('MN', 'Minnesota');
INSERT INTO State VALUES('MS', 'Mississippi');      INSERT INTO State VALUES('MO', 'Missouri');
INSERT INTO State VALUES('MT', 'Montana');          INSERT INTO State VALUES('NE', 'Nebraska');
INSERT INTO State VALUES('NV', 'Nevada');           INSERT INTO State VALUES('NH', 'New Hampshire');
INSERT INTO State VALUES('NJ', 'New Jersey');       INSERT INTO State VALUES('NM', 'New Mexico');
INSERT INTO State VALUES('NY', 'New York');         INSERT INTO State VALUES('NC', 'North Carolina');
INSERT INTO State VALUES('ND', 'North Dakota');     INSERT INTO State VALUES('OH', 'Ohio');
INSERT INTO State VALUES('OK', 'Oklahoma');         INSERT INTO State VALUES('OR', 'Oregon');
INSERT INTO State VALUES('PA', 'Pennsylvania');     INSERT INTO State VALUES('PR', 'Puerto Rico');
INSERT INTO State VALUES('RI', 'Rhode Island');     INSERT INTO State VALUES('SC', 'South Carolina');
INSERT INTO State VALUES('SD', 'South Dakota');     INSERT INTO State VALUES('TN', 'Tennessee');
INSERT INTO State VALUES('TX', 'Texas');            INSERT INTO State VALUES('UT', 'Utah');
INSERT INTO State VALUES('VT', 'Vermont');          INSERT INTO State VALUES('VA', 'Virginia');
INSERT INTO State VALUES('WA', 'Washington');       INSERT INTO State VALUES('WV', 'West Virginia');
INSERT INTO State VALUES('WI', 'Wisconsin');        INSERT INTO State VALUES('WY', 'Wyoming');
INSERT INTO State VALUES('GU', 'Guam');             INSERT INTO State VALUES('PR', 'Puerto Rico');
INSERT INTO State VALUES('AS', 'American Samoa');   INSERT INTO State VALUES('MP', 'Northern Mariana Islands');
INSERT INTO State VALUES('VI', 'Virgin Islands');

-- TradeRange Inserts
INSERT INTO TradeRange VALUES(1, 1, 1000);
INSERT INTO TradeRange VALUES(2, 1001, 15000);
INSERT INTO TradeRange VALUES(3, 15001, 50000);
INSERT INTO TradeRange VALUES(4, 50001, 100000);
INSERT INTO TradeRange VALUES(5, 100001, 250000);
INSERT INTO TradeRange VALUES(6, 250001, 500000);
INSERT INTO TradeRange VALUES(7, 500001, 1000000);
INSERT INTO TradeRange VALUES(8, 1000001, 5000000);
INSERT INTO TradeRange VALUES(9, 5000001, 25000000);
INSERT INTO TradeRange VALUES(10, 25000001, 50000000);
INSERT INTO TradeRange(rng_id, rng_min) VALUES(11, 50000001); -- over 50 mil

-- Committee Inserts
INSERT INTO Committee(cmt_id, cmt_name) VALUES(1, 'Agriculture');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(2, 'Appropriations');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(3, 'Armed Services');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(4, 'Budget');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(5, 'Education and Labor');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(6, 'Foreign Affairs');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(7, 'Transporation and Infrastructure');
INSERT INTO Committee(cmt_id, cmt_name) VALUES(8, 'Ethics');

-- Assignment inserts for Foreign Affairs committee
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 548);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 110);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 743);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 163);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 579);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 423);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 516);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 64);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 723);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 6, 825);

-- Assignment inserts for Agriculture committee
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 769);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 474);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 85);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 450);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 39);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 295);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 761);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 225);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 64);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 500);
INSERT INTO Assignment(assign_id, cmt_id, pol_id) VALUES(NEXT VALUE FOR Assignment_SQ, 1, 842);
