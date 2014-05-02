# returns a random picture path
def randomDog(picturepath):
    
    # replace parts of the filepath to get csv
    csvPath = picturepath.replace("/Images/", "/CSVS/").replace(".jpg",".csv")
    
    # Simple print for verification of randomness
    return csvPath
