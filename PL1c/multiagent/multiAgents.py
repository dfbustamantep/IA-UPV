# multiAgents.py
# --------------


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states//acciones legales y acciones futuras
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

         
        "*** YOUR CODE HERE ***"
        scared = False
        for newScaredTime in newScaredTimes:
            if(newScaredTime>2):
                scared=True
            else:
                scared=False

            #return successorGameState.getScore()
        score=successorGameState.getScore()
        minDistance=10000
        
        for food in newFood:
            if food:
                if manhattanDistance(newPos,food)<minDistance:
                    minDistance=manhattanDistance(newPos,food)
            score+=10
        minGhostDistance=0
        for newGhostState in newGhostStates:
            if(manhattanDistance(newPos,newGhostState.getPosition())>minGhostDistance):
                minGhostDistance=manhattanDistance(newPos,newGhostState.getPosition())
        if(scared==False and minGhostDistance<=1):
            score-=1000
         
        return score
    
def scoreEvaluationFunction(currentGameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """
    
    def getAction(self, gameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """
        "*** YOUR CODE HERE ***"
        #return self.minimax(gameState,self.depth,0)
        bestAction = None
        bestValue = float('-inf')
        
        for action in gameState.getLegalActions(0):
            succesor = gameState.generateSuccessor(0, action)
            value = self.minimax(succesor,0,1)
            
            if value > bestValue:
                bestAction =action
                bestValue = value
                #print("BA ",bestAction)
        return bestAction
        
        
    def minimax(self,state,depth,agentIndex):
        #Verify the state or the depth,when depth is equal to self.depth the max profundity was reach
        if state.isWin() or state.isLose() or depth == self.depth:
            return self.evaluationFunction(state)
            
        # If the actual agent is Pacaman (MAX)
        if agentIndex == 0:
            return self.max_value(state,depth,agentIndex)
            # If the actual agent is a ghost (MIN)
        else: 
            return self.min_value(state,depth,agentIndex)


    def max_value(self,state,depth,agentIndex):
        #iniciliaze vMax with a big number
        #vMax = -999999
        #manera de expresar infinito en python
        vMax = float('-inf')
        #save the legal actions for the agent if is pacman agentindex is 0 if is a ghost agentindex is 1
        legalActions = state.getLegalActions(agentIndex)
       
        #for each action in legalaction
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)     
            #vMax =self.minimax(succesor, depth,agentIndex)
            vMax = max(vMax,self.minimax(succesor, depth, (agentIndex+1)))  
            #print("max",val)
            #val = float(val)
            
            #if val > vMax:
            #    vMax = val
            #    newAction = action
              
            #print(newAction) '''
            #vMax = max(vMax,val)
        return vMax#newAction
    
    def min_value(self,state,depth,agentIndex):
        #Can have more than 1 ghost
        #vMin = 999999
        #manera de expresar infinito en python
        vMin = float('inf')
        legalActions = state.getLegalActions(agentIndex)
        
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)  
            
            if(agentIndex == state.getNumAgents()-1):
                vMin = min(vMin,self.minimax(succesor,(depth+1),0))
            else:
                vMin = min(vMin,self.minimax(succesor,depth,(agentIndex+1)))
                
            #vMin = min(val,vMin)  
            #print("min",vMin)
        return vMin

    
     
    '''def minimax(self,state,depth):
            #Verify the step or the depth,when depth is 0 this is the lowest node,if you are in the lowest node you win or lost
            if state.isWin() or state.isLose() or depth == 0:
                return self.evaluationFunction(state)
            
            agentIndex = 0
            
            # If the actual agent is Pacaman MAX
            if agentIndex == 0:
                return self.max_value(state,depth,agentIndex)
            # If the actual agent is a ghost MIN
            else: 
                return self.min_value(state,depth,agentIndex)

        

    def max_value(self,state,depth,agentIndex):
        #iniciliaze vMax with a big number
        vMax = -999999
        #save the legal actions for the agent if is pacman agentindex is 0 if is a ghost agentindex is 1
        legalActions = state.getLegalActions(agentIndex)
       
        #for each action in legalaction
        for action in legalActions:
            print(action)
            
            succeseor = state.generateSuccessor(agentIndex, action) 
            val = self.minimax(succeseor, depth - 1,agentIndex + 1)  
            print("max",val)
            #val = float(val)
            
            if val > vMax:
                vMax = val
                newAction = action
              
            print(newAction) 
        return newAction'''

class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        def maxAgent(state, depth, alpha, beta):
            if state.isWin() or state.isLose():
                return state.getScore()
            actions=state.getLegalActions(0)
            bestScore=-9999999
            score=bestScore
            for action in actions:
                score=minAgent(state.generateSuccessor(0, action), depth, 1, alpha, beta)
                if score>bestScore:
                    bestScore=score
                    bestAction=action
                alpha=max(alpha, bestScore)
                if bestScore>beta:
                    return bestScore
            if depth==0:
                return bestAction
            else:
                return bestScore
            
        def minAgent(state, depth, ghost, alpha, beta):
            if state.isLose() or state.isWin():
                return state.getScore()
            nextGhost=ghost + 1
            if ghost==state.getNumAgents()-1:
                nextGhost=0
            actions=state.getLegalActions(ghost)
            bestScore=9999999
            score=bestScore
            for action in actions:
                if nextGhost==0:
                    if depth==self.depth-1:
                        score=self.evaluationFunction(state.generateSuccessor(ghost, action))
                    else:
                        score=maxAgent(state.generateSuccessor(ghost, action), depth+1, alpha, beta)
                else:
                    score=minAgent(state.generateSuccessor(ghost, action), depth, nextGhost, alpha, beta)
                if score<bestScore:
                    bestScore=score
                beta=min(beta, bestScore)
                if bestScore<alpha:
                    return bestScore
            return bestScore
        return maxAgent(gameState, 0, -999999, 9999999)

        
    '''    
    def alphabeta(self,state,depth,agentIndex,alpha,beta):
        #Verify the state or the depth,when depth is equal to self.depth the max profundity was reach
        if state.isWin() or state.isLose() or depth == self.depth:
            return self.evaluationFunction(state)
            
        # If the actual agent is Pacaman (MAX)
        if agentIndex == 0:
            return self.max_value(state,depth,agentIndex,alpha,beta)
            # If the actual agent is a ghost (MIN)
        else: 
            return self.min_value(state,depth,agentIndex,alpha,beta)


    def max_value(self,state,depth,agentIndex,alpha,beta):
        #iniciliaze vMax with a big number
        #manera de expresar infinito en python
        vMax = float('-inf')
        #save the legal actions for the agent if is pacman agentindex is 0 if is a ghost agentindex is 1
        legalActions = state.getLegalActions(agentIndex)
       
        #for each action in legalaction
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)     
            #vMax =self.minimax(succesor, depth,agentIndex)
            vMax = self.alphabeta(succesor, depth, agentIndex+1,alpha,beta)
            
            if vMax >= beta:
                return vMax  # Prune the search if vMax is greater than or equal to beta
            
            alpha = max(alpha, vMax)  # Update alpha with the new maximum value

        return vMax
    
    def min_value(self,state,depth,agentIndex,alpha,beta):
        #Can have more than 1 ghost
        #manera de expresar infinito en python
        vMin = float('inf')
        legalActions = state.getLegalActions(agentIndex)
        
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)  
            
            if(agentIndex == state.getNumAgents()-1):
                vMin = min(vMin,self.alphabeta(succesor,depth+1,0,alpha,beta))
            else:
                vMin = min(vMin,self.alphabeta(succesor,depth,agentIndex+1,alpha,beta))

            if vMin <= alpha:
                return vMin  # Prune the search if vMin is less than or equal to alpha
            
            beta = min(beta, vMin)  # Update beta with the new minimum value
        
        return vMin
    '''
class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState):
        bestAction = None
        bestValue = float('-inf')
        
        for action in gameState.getLegalActions(0):
            succesor = gameState.generateSuccessor(0, action)
            value = self.expectimax(succesor,0,1)
            
            if value > bestValue:
                bestAction =action
                bestValue = value
                
        return bestAction
        
        
    def expectimax(self,state,depth,agentIndex):
        #Verify the state or the depth,when depth is equal to self.depth the max profundity was reach
        if state.isWin() or state.isLose() or depth == self.depth:
            return self.evaluationFunction(state)
            
        # If the actual agent is Pacaman (MAX)
        if agentIndex == 0:
            return self.max_value(state,depth,agentIndex)
            # If the actual agent is a ghost (MIN)
        else: 
            return self.exp_value(state,depth,agentIndex)


    def max_value(self,state,depth,agentIndex):
        #iniciliaze vMax with a big number
        #vMax = -999999
        #manera de expresar infinito en python
        vMax = float('-inf')
        #save the legal actions for the agent if is pacman agentindex is 0 if is a ghost agentindex is 1
        legalActions = state.getLegalActions(agentIndex)
       
        #for each action in legalaction
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)     
            #vMax =self.minimax(succesor, depth,agentIndex)
            vMax = max(vMax,self.expectimax(succesor, depth, (agentIndex+1)))  
            
        return vMax
    
    def exp_value(self,state,depth,agentIndex):
        #Can have more than 1 ghost
        #vMin = 999999
        #manera de expresar infinito en python
        v = 0
        legalActions = state.getLegalActions(agentIndex)
        nActions = len(legalActions)
        probability = float(1/nActions)
        
        for action in legalActions:
            succesor = state.generateSuccessor(agentIndex, action)  
            
            if(agentIndex == state.getNumAgents()-1):
                v += probability* self.expectimax(succesor,(depth+1),0)
            else:
                v += probability*self.expectimax(succesor,depth,(agentIndex+1))

        return v

def betterEvaluationFunction(currentGameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: The idea is to create a better evaluation function, evaluating states similarly to the agentReflex evaluation function.
    """
    "*** YOUR CODE HERE ***"
    # Useful information you can extract from a GameState (pacman.py) - its similar information that the point 1
    pacmanPos = currentGameState.getPacmanPosition()
    foodPos = currentGameState.getFood().asList()
    ghostStates = currentGameState.getGhostStates()
    capsulePos = currentGameState.getCapsules()
    score = currentGameState.getScore()

    # Calculate distances
    closestFood = min(manhattanDistance(food, pacmanPos) for food in foodPos) if foodPos else 1
    closestCap = min(manhattanDistance(caps, pacmanPos) for caps in capsulePos) if capsulePos else 9999999

    # Evaluate scores

    # Adjust penalties and bonuses based on ghost scared timers
    for ghost in ghostStates:
        scaredTimer = ghost.scaredTimer
        if scaredTimer > 8:
            if manhattanDistance(ghost.getPosition(), pacmanPos) <= 1:
                score += 90
            elif manhattanDistance(ghost.getPosition(), pacmanPos) <= 2:
                score += 70
            elif manhattanDistance(ghost.getPosition(), pacmanPos) <= 3:
                score += 60
            elif manhattanDistance(ghost.getPosition(), pacmanPos) <= 4:
                score += 50
        elif scaredTimer == 0:
            score -= manhattanDistance(ghost.getPosition(), pacmanPos) + 10

    # Adjust score
    #If pacman dosent be neaar to the food it be penalaized
    score -= 0.35 * sum(manhattanDistance(food, pacmanPos) for food in foodPos)
    score += 40 * (1 / closestCap)  # Bonus for being close to capsules
    score += 20 * (1 / closestFood)  # Bonus for being close to food
    score -= 10 * len(capsulePos)  # Penalty for remaining capsules

    return score
   
 

    
    


# Abbreviation
better = betterEvaluationFunction
