import pandas as pd
import numpy as np
import Neural_Network

# define a function that goes into a one row csv and pulls out a list of floats
def csv_to_array(filename):   

    # read csv into dataframe
    inputs_df = pd.read_csv(filename) 

    # take data from dataframe
    inputs = list(map(float, list(inputs_df.columns.values)))

    return inputs


print csv_to_array('image_processing_data_test.csv')
bpn = neural_network.Network((1,2,1))
err = bpn.Train(np.array(csv_to_array('image_processing_data_test.csv')), np.array([1]))
