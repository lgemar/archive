# import important libraries
import numpy as np
import random
import matplotlib.pyplot as plt 

# implement a backpropagation neural network
class Network:
    # initialize some variables
    layerCount = 0
    shape = None
    weights = []
    threshold = 0.2
    
    #initialize the network
    def __init__(self, shape):
        
        # store the layer count, don't include input layer
        self.layer_number = len(shape) - 1
        
        # store the shape that the user inputted
        self.shape = shape
        
        # initialize the inputs and outputs to empty lists
        self._layerInput = []
        self._layerOutput = [] 
        
        # create a random matrix of weights
        length_of_shape = len(self.shape)
        for (list1, list2) in zip(self.shape[:length_of_shape], self.shape[1:]):
            # pull random variables from a gaussian distribution and append them to a list of weights 
            self.weights.append(np.random.normal(scale=0.1, size=(list2, list1+1)))
            
    # Transfer function 
    def sgm(self, x, Derivative=False):
        # if we don't want the derivative:
        if not Derivative :
            # transform the input with a sigmoid function (the -10 in the exponent trains the network faster, but makes it a little more imprecise)
            output = 1/(1+np.exp(-10*x))
            return output
        # if we want the derivative
        else:
            # transform the input with the derivative of the sigmoid function
            output = self.sgm(x)
            return output*(1-output)
                
    # run a given input through the network
    def Run(self, input):
        # store the number of inputs
        cases = input.shape[0]
            
        # clear input and output arrays
        self._layerInput = []
        self._layerOutput = []
            
        # run through network
        for index in range(self.layer_number):
            if index == 0:
                layerInput = self.weights[0].dot(np.vstack([input.T, np.ones([1, cases])]))
            else:
                layerInput = self.weights[index].dot(np.vstack([self._layerOutput[-1], np.ones([1, cases])]))
                
            # keep an array of all layer inputs
            self._layerInput.append(layerInput)
            # keep an array off all layer outputs
            self._layerOutput.append(self.sgm(layerInput))
        
        # return the last element of the array of layerOutputs. This should be the output value of the entire network
        return self._layerOutput[-1].T
       
    # train the network
    def Train(self, input, targetValue, trainingRate = .01):
       # initialize an empty array for deltas 
       delta = []
       # store a count of the number of input values
       cases = input.shape[0]
            
       # run the network
       self.Run(input)            
            
       # calculate deltas
       for index in reversed(range(self.layer_number)):
           # if we're at the layer before the output layer
           if index == self.layer_number - 1:
                # the delta is the difference between the output and the target value
                output_delta = self._layerOutput[index] - targetValue
                # the error is the sum of the total output deltas
                error = np.sum(output_delta**2)
                # append (delta* sig'(output)) to delta
                delta.append(output_delta * self.sgm(self._layerInput[index], True))
           else:
               # want to propagate the deltas backwards if we're not at the second to last layer. 
               delta_pullback = self.weights[index+1].T.dot(delta[-1])
               delta.append(delta_pullback[:-1, :] * self.sgm(self._layerInput[index], True))
    
       # compute the changes in weight
       for index in range(self.layer_number):
           # the index of the delta is one less than the number of layers minus the index (we do not count the output layer)
           delta_index = self.layer_number - 1 - index
           if index == 0:
               layerOutput = np.vstack([input.T, np.ones([1,cases])])
           else:
               layerOutput = np.vstack([self._layerOutput[index - 1], np.ones([1, self._layerOutput[index - 1].shape[1]])])
                
           weightDelta = np.sum(layerOutput[None,:,:].transpose(2,0,1)* delta[delta_index][None,:,:].transpose(2,1,0),axis = 0)
                
           self.weights[index] = self.weights[index] - trainingRate * weightDelta
       return error
       
    # this function will run the network on a given array and check if it's output is above a threshold value. returns a bool
    def check_threshold(self, net_input):
        output = self.Run(net_input)
        if output > self.threshold:
            return True
        else:
            return False

''' THIS CODE, WHEN UNCOMMENTED ALLOWS US TO TRAIN THE NEURAL NETWORK 1000 TIMES.
    WE CAN THEN CREATE A GRAPH OF RUN NUMBER VS OUTPUT. SEE REPORT FOR MORE INFO

# create a test object and iterate 1000 times, storing the outputs to an array
bpn_test = Network((1,2,1))
count = 0
output_test_data = []
net_input = np.array([0.8])
while count < 1000:
    target = 0
    bpn_test.Train(net_input, target)
    output_test_data.append(map(float, (bpn_test.Run(np.array(net_input))).flat))
    count += 1

# output the test_data into a graph
plt.plot(output_test_data)
plt.ylabel('Output Value')
plt.xlabel('Run Number')
plt.title('Training Rate = .01')
plt.show()

'''
