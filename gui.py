# picture accessing
import file_management
import neural_network
import test_script
import csv_management
import numpy as np 
import os

import Tkinter as tk
from PIL import ImageTk, Image
#define
num_of_inputs = 3
num_of_outputs = 1
num_of_hidden_nodes = int((num_of_outputs + num_of_inputs) / 2)
network = neural_network.Network((num_of_inputs, num_of_hidden_nodes, num_of_outputs))


class Application(tk.Frame):
    net_input = None
    jpgg = file_management.randomDog()
    
    def get_csv(self):
        while self.net_input == None:    
            self.jpgg = file_management.randomDog()
    
            csv_path = csv_management.randomDog(self.jpgg)
        
            if os.path.isfile(csv_path):
                self.net_input = test_script.csv_to_array(csv_path)

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

    # function meant to be executed when someone approves
    def say_yes(self):
        print("I approve")
        self.net_input = None
        self.get_csv();
        
        if self.net_input == None:
            err = "undefined: no input"
            print err
        else:
            count = 0
            while count < 100:
                err = network.Train(np.array(self.net_input), np.array([1]))
                print self.net_input
                count = count + 1
        if self.net_input == None:
            print "No CSV file"
        else:
            print(network.Run(np.array(self.net_input)))
            
        self.canvas.delete(self.item)
        self.jpgg = file_management.randomDog()   
        jpg = self.jpgg
        image = Image.open(jpg)
        self.photo = ImageTk.PhotoImage(image)
        self.item = self.canvas.create_image(0,0,image=self.photo,anchor="nw")
    # function meant to be exected when someone disapproves
    def say_no(self):
        print("I don't approve!")
        self.net_input = None
        self.get_csv()
        
        if self.net_input == None:
            err = "undefined: no input"
            print err
        else:
            count = 0
            while count < 100:
                err = network.Train(np.array(self.net_input), np.array([0]))
                print self.net_input
                count = count + 1
        if self.net_input == None:
            print "No CSV File"
        else:
            print(network.Run(np.array(self.net_input)))
            
        self.canvas.delete(self.item)
        self.jpgg = file_management.randomDog()   
        jpg = self.jpgg
        image = Image.open(jpg)
        self.photo = ImageTk.PhotoImage(image)
        self.item = self.canvas.create_image(0,0,image=self.photo,anchor="nw")
      

root = tk.Tk()
app = Application(master=root)
app.mainloop()