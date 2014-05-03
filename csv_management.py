''' csv_management selects and works with csv files '''
import pandas as pd
import os

# returns a random picture path
def randomDog(picturepath):
    
    # replace parts of the filepath to get csv
    csvPath = picturepath.replace("/Images/", "/CSVS/").replace(".jpg",".csv")
    
    # Simple print for verification of randomness
    return csvPath

# define a function that goes into a one row csv and pulls out a list of floats
def csv_to_array(filename):   
    # read csv into dataframe
    inputs_df = pd.read_csv(filename) 
    
    # take data from dataframe
    inputs = []
    inputs.append(map(float, list(inputs_df.columns.values)))

    return inputs

# a function that makes sure the csv file is valid
def check_csv(filename):
    # check if it is truly a file  
    if os.path.isfile(filename):
        # read the values into an array. The invariant is that the csv file only has 1 row
        df = pd.read_csv(filename)
        # check if any of the values are NaN
        if 'NaN' in list(df.columns.values):
            # if so, return False            
            return False
        else:
            # return True if none are NaN
            return True
    else:
        # if not a file, return True
        return False