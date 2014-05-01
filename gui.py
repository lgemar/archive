# picture accessing
import file_management
import neural_network
import test_script
import csv_management

import Tkinter as tk

num_of_inputs = 3
num_of_outputs = 1
num_of_hidden_nodes = int((num_of_outputs + num_of_inputs) / 2)
network = neural_network.Network((num_of_inputs, num_of_hidden_nodes, num_of_outputs))


class Application(tk.Frame):
    jpg_path = file_management.randomDog()

    csv_path = csv_management.randomDog()

    net_input = test_script.csv_to_array(csv_path)

    def __init__(self, master=None):
        tk.Frame.__init__(self, master)
        self.pack()
        self.createWidgets()

    def createWidgets(self):

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
    	file_management.randomDog()

    # function meant to be exected when someone disapproves
    def say_no(self):
    	print("I don't approve!")

root = tk.Tk()
app = Application(master=root)
app.mainloop()