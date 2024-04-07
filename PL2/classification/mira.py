# mira.py
# -------


# Mira implementation

import util
PRINT = True

class MiraClassifier:
    """
    Mira classifier.

    Note that the variable 'datum' in this code refers to a counter of features
    (not to a raw samples.Datum).
    """
    def __init__( self, legalLabels, max_iterations):
        self.legalLabels = legalLabels
        self.type = "mira"
        self.automaticTuning = False
        self.C = 0.001
        self.max_iterations = max_iterations
        self.initializeWeightsToZero()

    def initializeWeightsToZero(self):
        "Resets the weights of each label to zero vectors"
        self.weights = {}
        for label in self.legalLabels:
            self.weights[label] = util.Counter() # this is the data-structure you should use

    def train(self, trainingData, trainingLabels, validationData, validationLabels):
        "Outside shell to call your method. Do not modify this method."

        if (self.automaticTuning):
            Cgrid = [0.002, 0.004, 0.008]
        else:
            Cgrid = [self.C]

        return self.trainAndTune(trainingData, trainingLabels, validationData, validationLabels, Cgrid)

    
    
    #Funcion a rellenar 
    #Diferentes valores de C que se encuentran en Cgrid

    def trainAndTune(self, trainingData, trainingLabels, validationData, validationLabels, Cgrid):
    
    
    
    
    #Para probar el codigo python dataClassifier.py -c mira --autotune
    
        # DO NOT ZERO OUT YOUR WEIGHTS BEFORE STARTING TRAINING, OR
        # THE AUTOGRADER WILL LIKELY DEDUCT POINTS.
        

        self.features = trainingData[0].keys()
        
        #Para cada valor de C se calcularan los pesos,posteriormente usaremos los valores de validationDAta con los de validationLabels
        #Llamaremos a la funcion classify para saber cual de los pesos de los distintos C son mejores y quedarnos con esos
    
        #Si hay empate escoger el valor mas bajo de C
    
        newWeights = self.weights.copy()
        aux_max = 0
        for c in Cgrid:
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
                        a=(self.weights[yPrima] - self.weights[trainingLabels[i]]) * (trainingData[i])
                        a=a+1
                        b=0
                        for h in self.features:
                            b=b+(trainingData[i][h]*trainingData[i][h])
                        b=b*2
                        d=a/b
                        tau = min(c, d)
                        #((self.weights[yPrima] - self.weights[trainingLabels[i]]) * (1.0+trainingData[i])) / (2.0 * (trainingData[i]*trainingData[i])))
                        t=util.Counter()
                        for h in self.features:
                            t[h]=(tau*trainingData[i][h])
                            #t[h]=[h]*tau
                        #print(t)
                        self.weights[yPrima]=self.weights[yPrima] -(t) 
                        self.weights[trainingLabels[i]]=self.weights[trainingLabels[i]] + (t)
            lista=self.classify(validationData) 
            total=0
            for i in range (len(validationLabels)):
                if lista[i]==validationLabels[i]:
                    total=total+1
            if total>aux_max:
                bestWeight=self.weights
                aux_max=total      
                
        self.weights = bestWeight        
              
    
    
    #Implementar
    #Esta funcion recibe unos datos de validacion (caracteristicas de 100 imagenes) usando los pesos aprendidos debera clasificar 
    # cada imagen indicando a que digito pertenece la imagen (0-9)        
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

