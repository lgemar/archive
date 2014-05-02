import pandas as pd


# define a function that goes into a one row csv and pulls out a list of floats
def csv_to_array(filename):   

    # read csv into dataframe
    inputs_df = pd.read_csv(filename) 

    # take data from dataframe
    inputs = []
    inputs.append(map(float, list(inputs_df.columns.values)))

    return inputs


#print csv_to_array('image_processing_data_test.csv')
#print csv_to_array('/Users/Andre/Dropbox/final_project/CSVS/n02093754-Border_terrier/n02093754_7025.csv')
'''bpn = neural_network.Network((1,2,1))
err = bpn.Train(np.array(csv_to_array('image_processing_data_test.csv')), np.array([1]))'''
