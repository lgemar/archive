''' imports '''
import numpy as np

''' Neural Network '''
# implement a backpropagation neural network
class Network:
    # initialize some variables
    layerCount = 0
    shape = None
    weights = []
    
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
            # determine layer input
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
    def Train(self, input, targetValue, trainingRate = 1):
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

# create a test object
if __name__ == "__main__":
    bpn = Network((4,2,1))
    
    lvInput1 = np.array([[.8, .6, .2, .5]])
    lvTarget1 = 1
    lvInput2 = np.array([[.3, .4, .8, .32]])
    lvTarget2 = 0

    lnMax = 100000
    lnErr = .0001
    count = 0
    for i in range(lnMax+1):
        if count % 2 == 0:
            err = bpn.Train(lvInput1, lvTarget1)
            count += 1
        else:
            err = bpn.Train(lvInput2, lvTarget2)
            count += 1
        if err <= lnErr:
            print("Minimum error reached at iteration {0}".format(i))
            break
    lvOutput = bpn.Run(lvInput1)
    print("Input: {0}\nOutput: {1}".format(lvInput1,lvOutput))
    lvOutput = bpn.Run(lvInput2)
    print("Input: {0}\nOutput: {1}".format(lvInput2, lvOutput))
    
    

