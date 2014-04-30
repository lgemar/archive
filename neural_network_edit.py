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
        self.layerCount = len(shape) - 1
        
        # store the shape that the user inputted
        self.shape = shape
        
        # initialize the inputs and outputs to empty lists
        self._layerInput = []
        self._layerOutput = [] 
        
        # create a random matrix of weights
        length_of_shape = len(self.shape)
        for (list1, list2) in zip(self.shape[:length_of_shape], self.shape[1:]):
            # we want to pull random variables from a gaussian distribution and append them to a list of weights 
            self.weights.append(np.random.normal(scale=0.1, size=(list2, list1+1)))
            
    # Transfer function 
    def sgm(self, x, Derivative=False):
        if not Derivative :
            return 1/(1+np.exp(-x))
        else:
            output = self.sgm(x)
            return output*(1-output)
                
        # run a given input through the network
    def Run(self, input):
        # store the number of inputs
        lnCases = input.shape[0]
            
        # clear input and output arrays
        self._layerInput = []
        self._layerOutput = []
            
        # run through network
        for index in range(self.layerCount):
            # determine layer input
            if index == 0:
                layerInput = self.weights[0].dot(np.vstack([input.T, np.ones([1, lnCases])]))
            else:
                print self._layerOutput
                layerInput = self.weights[index].dot(np.vstack([self._layerOutput[-1], np.ones([1, lnCases])]))
                
            
            self._layerInput.append(layerInput)
            self._layerOutput.append(self.sgm(layerInput))
       
        return self._layerOutput[-1].T
       
    # train the network
    def Train(self, input, targetValue, trainingRate = 1):
       delta = []
       lnCases = input.shape[0]
            
       # run the network
       self.Run(input)            
            
       # calculate deltas
       for index in reversed(range(self.layerCount)):
           if index == self.layerCount - 1:
                output_delta = self._layerOutput[index] - targetValue.T
                error = np.sum(output_delta**2)
                delta.append(output_delta * self.sgm(self._layerInput[index], True))
           else:
               delta_pullback = self.weights[index+1].T.dot(delta[-1])
               delta.append(delta_pullback[:-1, :] * self.sgm(self._layerInput[index], True))
    
       # compute the changes in weight
       for index in range(self.layerCount):   
           delta_index = self.layerCount - 1 - index
           if index == 0:
               layerOutput = np.vstack([input.T, np.ones([1,lnCases])])
           else:
               layerOutput = np.vstack([self._layerOutput[index - 1], np.ones([1, self._layerOutput[index - 1].shape[1]])])
                
           weightDelta = np.sum(layerOutput[None,:,:].transpose(2,0,1)* delta[delta_index][None,:,:].transpose(2,1,0),axis = 0)
                
           self.weights[index] -= trainingRate * weightDelta
       return error

'''# create a test object
if __name__ == "__main__":
    bpn = Network((1,2,1))
    
    lvInput = np.array([[.8], [.6], [.2], [.5]])
    lvTarget = np.array([1])

    lnMax = 100000
    lnErr = .0003
    for i in range(lnMax+1):
        err = bpn.Train(lvInput, lvTarget)
        if i % 2500 == 0:
            print err
        if err <= lnErr:
            print("Minimum error reached at iteration {0}".format(i))
            break
    lvOutput = bpn.Run(lvInput)
    print("Input: {0}\nOutput: {1}".format(lvInput,lvOutput))'''
    
        
        
    
''' USER INTERFACE '''

# given a csv file of an array of image processing data and a user preference, run the network


bpn.Train(inputs, 0, )
