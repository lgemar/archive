import pandas as pd
import os


# define a function that goes into a one row csv and pulls out a list of floats
def csv_to_array(filename):   
    # read csv into dataframe
    inputs_df = pd.read_csv(filename) 
    
    # take data from dataframe
    inputs = []
    inputs.append(map(float, list(inputs_df.columns.values)))

    return inputs

def check_csv(filename):
    if os.path.isfile(filename):
        df = pd.read_csv(filename)

        if 'NaN' in list(df.columns.values):
            print False
            return False
        else:
            return True
    else:
        return False
