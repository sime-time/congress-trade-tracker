import os
import pandas as pd
import pyodbc
from datetime import datetime

# open the excel file with all congress members
filename = "senator_trades.xlsx"
df = pd.read_excel(filename)

# extract the values from each row into an array
# insert the values of the array into a sql stored procedure
# the stored procedure inserts values into the database

# make a 2D array of politician information
trade_list = []
for index, row in df.iterrows():
    # get the easy columns that don't need cleaning
    report_url = row["ptr_link"]
    asset_ticker = row["ticker"]

    # owner cell might be empty
    if pd.isnull(row["owner"]):
        trade_owner = 'NULL'
    else: 
        trade_owner = "'" + row["owner"] + "'"

    # asset type might be empty 
    if pd.isnull(row["asset_type"]):
        asset_type = 'NULL'
    else: 
        asset_type = "'" + row["asset_type"] + "'"

    # transform the dates to strings mm/dd/yyyy
    trade_timestamp = row["transaction_date"]
    trade_date = trade_timestamp.strftime('%Y-%m-%d')

    report_timestamp = row["disclosure_date"]
    report_date = report_timestamp.strftime('%Y-%m-%d')



    # take the first letter of the 'type' row to determine buy or sell
    if (row["type"][0] == 'S'):
        trade_type = 'SELL'
    else: 
        trade_type = 'BUY'

    # get the asset description remove any unneccessary strings
    # repair the ampersand symbol
    asset_desc = row["asset_description"]
    asset_desc = asset_desc.replace("&amp;", "&")
    asset_desc_list = asset_desc.split(" <")
    asset_name = asset_desc_list[0].replace("'", "")

    # get the minimum trade range but remove any dollar signs, commas, and spaces
    trade_range = row["amount"]
    trade_range = trade_range.replace("$", "")
    trade_range = trade_range.replace(",", "")
    trade_range = trade_range.replace(" ", "")
    trade_range_list = trade_range.split("-")
    # if it starts with 'O' that means Over 50 mil
    try: 
        trade_min = int(trade_range_list[0])
    except:
        trade_min = 50000001


    # parse the name into first initial and full last name
    # remove any punctuation and "Jr.'s"
    name = row["senator"].replace(", ", "")
    name = name.replace(".", "")

    # check if the second character is a space 
    # then it is not the first initial
    if (name[1] == " "):
        first_inital = name[2]
    else: 
        first_inital = name[0]

    # if the last element in the parsed name is only 2 characters,
    # then that is not the last name
    name_parse = name.split(" ")
    if (len(name_parse[len(name_parse) - 1]) == 2):
        last_name = name_parse[len(name_parse) - 2]
    else:
        last_name = name_parse[len(name_parse) - 1]

    trade = [report_date, report_url, asset_ticker, asset_name, asset_type, trade_type, trade_date, str(trade_min), trade_owner, first_inital, last_name]
    trade_list.append(trade)


# connect to sql database
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=IN-CSCI-MSSQL2.ADS.IU.EDU,11433\SQL2019DEV;'
                      'Database=FinalProject14;'
                      'UID=14Dun14;'
                      'PWD=Fobxoq4-CSCI44300;')

# now insert the list of politicians into database using stored procedure
for list in trade_list:
    try: 
        # open cursor
        cursor = conn.cursor()

        storedProc = """
        EXECUTE [dbo].[InsertTrade_SP]
            @ReportDate = '"""+ list[0] +"""',
            @ReportURL = '"""+ list[1] +"""',
            @AssetTicker = '"""+ list[2] +"""',
            @AssetName = '"""+ list[3] +"""',
            @AssetType = """+ list[4] +""",
            @TradeType = '"""+ list[5] +"""',
            @TradeDate = '"""+ list[6] +"""',
            @TradeMin = """+ list[7] +""",
            @TradeOwner = """+ list[8] +""",
            @FirstInitial = '"""+ list[9] +"""',
            @LastName = '"""+ list[10] +"""'
        """
        # execute and close cursor
        cursor.execute(storedProc)
        cursor.close()
        conn.commit()
    except:
        print(list)

# commit changes
conn.commit()