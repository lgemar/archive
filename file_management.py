import os
import random

# returns a random picture path
def randomDog():
	#Root Directory holding our image files
	rootdir = os.getcwd() + '/Images'

	# All of the image folders organized by dog type
	lst = os.listdir(rootdir)

	# Picks a random Folder
	randomDog = random.choice(lst)

	# Changes to that new directory
	pictureDirectory =rootdir + "/" + randomDog

	# All of the pictures of the randome dog
	doglist = os.listdir(pictureDirectory)

	# Picks a random picture
	randomPicture = random.choice(doglist)

	# Makes a path with a random dog and a random picture of said dog
	picturePath = pictureDirectory + "/" + randomPicture #"/Users/Andre/Dropbox/final_project/Images/n02093754-Border_terrier/n02093754_7025.jpg"

	# Simple print for verification of randomness
	return picturePath

# returns "num" random picture paths
def randomDogs (num) : 
	while num > 0 :
		randomDog()
		num = num - 1

randomDog()