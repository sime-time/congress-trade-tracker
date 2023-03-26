# insert congress members from 2013-2022
import os
import pandas as pd
import pyodbc

# open the excel file with all congress members
filename = "congress_members.xlsx"
df = pd.read_excel(filename)

# extract the values from each row into an array
# insert the values of the array into a sql stored procedure
# the stored procedure inserts values into the database

# make a 2D array of politician information
politician_list = []
for index, row in df.iterrows():
    # parse the name into first, middle, last
    name_parse = row["Name"].split(', ')
    last = name_parse[0].replace("'", " ")

    name_parse_2nd_half = name_parse[1].split(' ')
    first = name_parse_2nd_half[0].replace('.', '')
    first = first.replace("'", " ")
    # check for middle initial and remove dot
    try:
        middle = name_parse_2nd_half[1].replace('.', '')
        if (middle == '-'):
            raise Exception("middle name cannot be a dash.")
        else:
            # add 'quotes' to the middle name for sql query
            middle = "'" + middle + "'"
    except: 
        middle = 'NULL'

    # check if district is a number
    try: 
        district = int(row["District"])
    except ValueError:
        district = "NULL"

    # take the first 5 letters of the 'terms' row to determine house or senator
    if (row["Terms"][0:5] == 'Senat'):
        chamber = 'Senate'
    else: 
        chamber = 'House'

    # parse the 'term' row to retrieve start and end of term
    term_parse = row["Terms"].split(': ', 1)
    term_years = term_parse[1].split('-')
    term_start = int(term_years[0])
    try:
        term_end = int(term_years[1])
    except:
        term_end = "NULL"
        
    politician = [first, middle, last, row["URL"], row["State"], row["Party"], str(district), chamber, str(term_start), str(term_end)]
    politician_list.append(politician)



# connect to sql database
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=IN-CSCI-MSSQL2.ADS.IU.EDU,11433\SQL2019DEV;'
                      'Database=FinalProject14;'
                      'UID=14Dun14;'
                      'PWD=Fobxoq4-CSCI44300;')

# now insert the list of politicians into database using stored procedure
for list in politician_list:
    try: 
        # open cursor
        cursor = conn.cursor()

        storedProc = """
        EXECUTE [dbo].[InsertPolitician_SP]
            @FirstName = '"""+ list[0] +"""',
            @MiddleName = """ + list[1] +""",
            @LastName = '"""+ list[2] +"""',
            @URL = '"""+ list[3] +"""',
            @State = '"""+ list[4] +"""',
            @Party = '"""+ list[5] +"""',
            @District = """+ list[6] +""",
            @Chamber = '"""+ list[7] +"""', 
            @TermStart = """+ list[8] +""", 
            @TermEnd = """+ list[9]

        # execute and close cursor
        cursor.execute(storedProc)
        cursor.close()
    except:
        print(list)

# commit changes
conn.commit()