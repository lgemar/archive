# picture accessing
import file_management
import neural_network
import csv_management
import numpy as np 
import Tkinter as tk
from PIL import ImageTk, Image

# define useful variables and build the neural network for this session
num_of_inputs = 4
num_of_outputs = 1
num_of_hidden_nodes = int((num_of_outputs + num_of_inputs) / 2)
network = neural_network.Network((num_of_inputs, num_of_hidden_nodes, num_of_outputs))


class Application(tk.Frame):
    # initialize the input array as None    
    net_input = None
    
    # select a random jpg as the initial image
    jpgg = file_management.randomDog()
    
    # a function that takes a jpg file and finds the corresponding csv file
    def get_input_array(self):
        # reset the input array as None        
        self.net_input = None
        
        while self.net_input == None:    
            # select a different random dog       
            self.jpgg = file_management.randomDog()

            # change .jpg file to a .csv file 
            csv_path = csv_management.randomDog(self.jpgg)
        
            # check to make sure the csv file exists and does not contain any NaN values
            if csv_management.check_csv(csv_path):
                self.net_input = csv_management.csv_to_array(csv_path)
                
                ''' IF UNCOMMENTED, THIS CODE WOULD TRY TO ONLY SHOW THE USER DOGS THAT THEY HAVE
                    A HIGH LIKLIHOOD OF LIKING. GIVEN OUR NETWORK'S SETUP AND THE WAY IT INTERACTS
                    WITH IMAGE PROCESSING DATA, IT DID NOT WORK WELL. SEE WRITE UP FOR MORE INFO
                    
                # check if the dog is likeable, if not, reset net_input and try again
                if not network.check_threshold(np.array(self.net_input)): 
                    print network.Run(np.array(self.net_input))
                    print "no"
                    self.net_input = None
                else:
                    print network.Run(np.array(self.net_input))
                    
                '''
    
    def __init__(self, master=None):
        tk.Frame.__init__(self, master)
        self.pack()
        self.createWidgets()

    def createWidgets(self):
        
        self.canvas = tk.Canvas(width=500, height=500)
        self.canvas.pack()
        jpg = self.jpgg
        image = Image.open(jpg)
        self.photo = ImageTk.PhotoImage(image)
        self.item = self.canvas.create_image(0,0,image=self.photo,anchor="nw")

    	# creates a button representing an approval
        self.approve = tk.Button(self)
        self.approve["text"] = "Yes"
        self.approve["command"] = self.say_yes
        self.approve.pack(side="top")

        # creates a button representing a disapproval
        self.disapprove = tk.Button(self)
        self.disapprove["text"] = "No"
        self.disapprove["command"] = self.say_no
        self.disapprove.pack(side="top")

        # creates a button for exiting the GUI
        self.QUIT = tk.Button(self, text="QUIT", fg="red",
                                            command=root.destroy)
        self.QUIT.pack(side="bottom")
    
    # a function that replaces the image displayed
    def replace_image(self):
        self.canvas.delete(self.item)
        self.jpgg = file_management.randomDog()   
        jpg = self.jpgg
        image = Image.open(jpg)
        self.photo = ImageTk.PhotoImage(image)
        self.item = self.canvas.create_image(0,0,image=self.photo,anchor="nw")
        
    # function meant to be executed when someone approves
    def say_yes(self):
        print("I approve")  
        # generate a jpg and get the associated array
        self.get_input_array()
        # initialize a counter        
        count = 0
        # train the network 20 times for each image with target value = 1
        while count < 20:          
            network.Train(np.array(self.net_input), 1)
            count = count + 1
        # run the network with the same input and print the output
        print(network.Run(np.array(self.net_input)))
        # replace the image
        self.replace_image()
    
    # function meant to be executed when someone disapproves
    def say_no(self):
        print("I don't approve!")
        # generate a jpg and get the associated array
        self.get_input_array()
        # initialize a counter        
        count = 0
        # train the network 20 times for each picture with target value = 0
        while count < 20:
            network.Train(np.array(self.net_input), 0)
            count = count + 1
        # run the network with the same input and print the output
        print(network.Run(np.array(self.net_input)))
        # replace the image
        self.replace_image()

      
# makes an empty gui 
root = tk.Tk()

# instantiates an Application class given a gui
app = Application(root)

# loops through to make sure we don't exit after one image
app.mainloop()