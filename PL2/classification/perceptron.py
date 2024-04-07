# perceptron.py
# -------------

# Perceptron implementation
import util
import pickle

PRINT = True

class PerceptronClassifier:
    """
    Perceptron classifier.

    Note that the variable 'datum' in this code refers to a counter of features
    (not to a raw samples.Datum).
    """
    def __init__( self, legalLabels, max_iterations):
        #indica el numero de clases y sus nombres porque son numeros de 1 a 9
        self.legalLabels = legalLabels
        self.type = "perceptron"
        self.max_iterations = 5 # max_iterations
        self.weights = {}
        for label in legalLabels:
            self.weights[label] = util.Counter() # this is the data-structure you should use

    def setWeights(self, weights):
        assert len(weights) == len(self.legalLabels)
        self.weights = weights

    
#Funcion a rellenar
#trainigData debe ser la lista de caracteristicas        
    def train( self, trainingData, trainingLabels, validationData, validationLabels):
        """
        The training loop for the perceptron passes through the training data several
        times and updates the weight vector for each label based on classification errors.
        See the project description for details.

        Use the provided self.weights[label] data structure so that
        the classify method works correctly. Also, recall that a
        datum is a counter from features to values for those features
        (and thus represents a vector a values).
        """
    #Lista de caracteristicas f,el perceptron predice la clase y' en base al producto escalar f*w
    #El puntaje btenido(SCORE) sera score(f,y'')=Sumatoria f(i)*W(i)

    #y'' representa una de las posibles clases o predicciones
    #y' representa lo que el sistema calculara coo su prediccion favorita
    #Despues seleccionara la clase y'' que tenga el mayor valor,score

    #se compara y con y

    #si y'=y la clasificacion a sido correcta NO SE DEBE ACTUALIZAR
    #si y' o corresponde con y tendremos que actualizar los pesos
    #Eso implica que w·y''
    #donde y'' es y debería haber obtenido una puntuación f más alta, y por el contrario w·y′ debería
    #haber obtenido una puntuación f más baja

    #Se actualiza de la siguiente manera
    #wy =wy + f
    #wy′ =wy′ − f  
        
        self.features = trainingData[0].keys() # could be useful later
        # DO NOT ZERO OUT YOUR WEIGHTS BEFORE STARTING TRAINING, OR
        # THE AUTOGRADER WILL LIKELY DEDUCT POINTS.
        
        for iteration in range(self.max_iterations):
            print ("Starting iteration ", iteration, "...")
            
            #queremos iterar sobre todas las caracteristicas para multiplicar con el vector de pesos
            for i in range (len(trainingData)):
                puntaje = util.Counter()
                for labels in self.legalLabels:
                    
                    #producto escalar f*w                    
                    puntaje[labels]=self.weights[labels]*trainingData[i] 

                yPrima = puntaje.argMax()
                #si es diferente se actualizan los pesos
                # actualizar valores del peso
                if(yPrima!=trainingLabels[i]):
                    self.weights[yPrima]=self.weights[yPrima] - trainingData[i]
                    self.weights[trainingLabels[i]]=self.weights[trainingLabels[i]] + trainingData[i]
            #counter tiene funciones para retornar un item,incrementar
            
        
        
    #La funcion rescibe unos datos de validacion los cuales son carractersisticas de 100 imagenes,usamos los pesos aprendidos en el 
    # punto anterior,indicando a que digito pertenece cada imagen 
                        #datos de validacion
    def classify(self, data ):
        """
        Classifies each datum as the label that most closely matches the prototype vector
        for that label.  See the project description for details.

        Recall that a datum is a util.counter...
        """    
        guesses = []
        #for i in range(len(data)):
  
        for d in data:
            puntaje = util.Counter()
            for labels in self.legalLabels:
                puntaje[labels]=self.weights[labels]*d
                
            yPrima = puntaje.argMax()
                #agregamos el elemto       
            guesses.append(yPrima) 

        return guesses
      


