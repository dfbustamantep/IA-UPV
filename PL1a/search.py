"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

# Abstract class, do not implement
class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    return ['South', 'South', 'West', 'South', 'West', 'West', 'South', 'West']

def depthFirstSearch(problem):
    moves = util.Stack()  # Utiliza una pila para llevar un seguimiento de los nodos por explorar
    visited = set()  # Conjunto para llevar un seguimiento de los nodos ya visitados
    actions = []  # Lista para almacenar las acciones
    
    start_state = problem.getStartState()  # Estado inicial del problema
    moves.push((start_state, []))  # Inserta el estado inicial en la pila
    
    while not moves.isEmpty():
        state, actions_so_far = moves.pop()  # Extrae el estado y las acciones hasta ahora
        
        if state in visited:
            continue  # Si el estado ya ha sido visitado, pasa al siguiente estado
        
        visited.add(state)  # Añade el estado actual al conjunto de nodos visitados
        
        if problem.isGoalState(state):
            actions = actions_so_far  # Si el estado es el estado objetivo, almacena las acciones
            break  # Sale del bucle while
        
        successors = problem.getSuccessors(state)  # Obtiene los sucesores del estado actual
        
        for successor, action, _ in successors:
            moves.push((successor, actions_so_far + [action]))  # Inserta los sucesores en la pila con las acciones
    
    return actions

def breadthFirstSearch(problem):
    moves = util.Queue()  # Utiliza una cola para llevar un seguimiento de los nodos por explorar
    visited = set()  # Conjunto para llevar un seguimiento de los nodos ya visitados
    actions = []  # Lista para almacenar las acciones
    
    start_state = problem.getStartState()  # Estado inicial del problema
    moves.push((start_state, []))  # Inserta el estado inicial en la cola
    
    while not moves.isEmpty():
        state, actions_so_far = moves.pop()  # Extrae el estado y las acciones hasta ahora
        
        if state in visited:
            continue  # Si el estado ya ha sido visitado, pasa al siguiente estado
        
        visited.add(state)  # Añade el estado actual al conjunto de nodos visitados
        
        if problem.isGoalState(state):
            actions = actions_so_far  # Si el estado es el estado objetivo, almacena las acciones
            break  # Sale del bucle while
        
        successors = problem.getSuccessors(state)  # Obtiene los sucesores del estado actual
        
        for successor, action, _ in successors:
            moves.push((successor, actions_so_far + [action]))  # Inserta los sucesores en la cola con las acciones
    
    return actions

def uniformCostSearch(problem):
    """Busca el nodo con el costo total más bajo primero."""
    visited = set()  # Conjunto de nodos visitados
    moves = util.PriorityQueue()  # Cola de prioridad para los movimientos
    start_state = problem.getStartState()  # Estado inicial del problema
    
    # Añade el estado inicial a la cola de prioridad con prioridad 0
    moves.push((start_state, [], 0), 0)
    
    while not moves.isEmpty():
        # Extrae el estado con el costo más bajo
        state, actions, total_cost = moves.pop()
        
        # Si el estado actual es un estado objetivo, devuelve las acciones hasta este punto
        if problem.isGoalState(state):
            return actions
        
        # Si el estado actual aún no ha sido visitado
        if state not in visited:
            # Añade el estado actual al conjunto de nodos visitados
            visited.add(state)
            
            # Para cada sucesor del estado actual
            for successor, action, step_cost in problem.getSuccessors(state):
                if successor not in visited:
                    # Calcula el costo total del camino hasta este sucesor
                    successor_cost = total_cost + step_cost
                    
                    # Añade el sucesor a la cola de prioridad con su costo total
                    moves.push((successor, actions + [action], successor_cost), successor_cost)
                    
    return []  # Si no se encuentra un camino, devuelve una lista vacía


def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.     
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    "*** YOUR CODE HERE ***"
    util.raiseNotDefined()

# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch

