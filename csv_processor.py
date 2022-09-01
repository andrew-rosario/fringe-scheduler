import csv
import sqlite3
from pathlib import Path
from time import sleep

csv_file = None


def processor():
    pre_check()
    connection = sqlite3.connect('schedule_database.db')






def pre_check():
    # This checks the CSV for existence and format check.
    # If the format is not correct, the program will refuse to run.
    file_to_check = Path('schedule.csv')
    all_good = False
    while all_good is False:
        if file_to_check.is_file():
            with open('schedule.csv', newline='') as f:
                reader = csv.reader(f)
                row1 = next(reader)
                if row1 is "name,company,genre,date,time,location":
                    print("Successfully passed CSV checks.")
                    print("WARNING: This does not verify the accuracy of the data.")
                    print("If the data is changed, please run Update SQLite Database if the CSV data has changed.")
                    sleep(5)
                    all_good = True
                else:
                    print("This CSV file is not formatted correctly.")
                    raise Exception("The first row should adhere to the specifications in the source code.")
        else:
            raise Exception("The CSV file does not exist in root. Put a CSV file in root or use example CSV.")


