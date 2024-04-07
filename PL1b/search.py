# search.py

"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

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
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

def depthFirstSearch(problem):
    moves = util.Stack()  # Use a stack to keep track of nodes to explore
    visited = set()  # Set to keep track of already visited nodes
    actions = []  # List to store actions
    
    start_state = problem.getStartState()  # Initial state of the problem
    moves.push((start_state, []))  # Push the initial state onto the stack
    
    while not moves.isEmpty():
        state, actions_so_far = moves.pop()  # Extract the state and actions so far
        
        if state in visited:
            continue  # If the state has already been visited, move to the next state
        
        visited.add(state)  # Add the current state to the set of visited states
        
        if problem.isGoalState(state):
            actions = actions_so_far  # If the state is the goal state, store the actions
            break  # Exit the while loop
        
        successors = problem.getSuccessors(state)  # Get the successors of the current state
        
        for successor, action, _ in successors:
            moves.push((successor, actions_so_far + [action]))  # Push successors onto the stack with the actions

    return actions

def breadthFirstSearch(problem):
    moves = util.Queue()  # Use a queue to keep track of nodes to explore
    visited = set()  # Set to keep track of already visited nodes
    actions = []  # List to store actions
    
    start_state = problem.getStartState()  # Initial state of the problem
    moves.push((start_state, []))  # Push the initial state onto the queue
    
    while not moves.isEmpty():
        state, actions_so_far = moves.pop()  # Extract the state and actions so far
        if state in visited:
            continue  # If the state has already been visited, move to the next state
        
        visited.add(state)  # Add the current state to the set of visited states
        if problem.isGoalState(state):
            actions = actions_so_far  # If the state is the goal state, store the actions
            break  # Exit the while loop
        
        successors = problem.getSuccessors(state)  # Get the successors of the current state
        
        for successor, action, _ in successors:
            moves.push((successor, actions_so_far + [action]))  # Push successors onto the queue with the actions
    return actions


def uniformCostSearch(problem):
    """Search the node of least total cost first."""
    vstd = set()  # Set of visited nodes
    moves = util.PriorityQueue()  # Priority queue for moves
    start_state = problem.getStartState()  # Initial state of the problem
    
    # Add the initial state to the priority queue with priority 0
    moves.push((start_state,[],0), 0)
    
    while not moves.isEmpty():
        # Extract the state with the least cost
        state, actions, total_cost = moves.pop()
        
        # If the current state is a goal state, return the actions up to this point
        if problem.isGoalState(state):
            return actions
        
        # If the current state has not been visited yet
        if state not in vstd:
            # Add the current state to the set of visited states
            vstd.add(state)
            
            # For each successor of the current state
            for successor, action, step_cost in problem.getSuccessors(state):
                if successor not in vstd:
                    # Calculate the total cost of the path to this successor
                    successor_cost = total_cost + step_cost
                    # Add the successor to the priority queue with its total cost
                    moves.push((successor, actions + [action], successor_cost), successor_cost)
                    
    return []  # If no path is found, return an empty list

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    "*** YOUR CODE HERE ***"
    """Search the node of least total cost first."""
    vstd = set()  # Set of visited nodes
    moves = util.PriorityQueue()  # Priority queue for moves
    start_state = problem.getStartState()  # Initial state of the problem
    
    # Add the initial state to the priority queue with priority 0
    moves.push((start_state,[],0), 0)
    
    while not moves.isEmpty():
        # Extract the state with the least cost
        state,actions, total_cost = moves.pop()
        
        # If the current state is a goal state, return the actions up to this point
        if problem.isGoalState(state):
            return actions
        
        # If the current state has not been visited yet
        if state not in vstd:
            # Add the current state to the set of visited states
            vstd.add(state)
            
            # For each successor of the current state
            for successor, action, step_cost in problem.getSuccessors(state):
                if successor not in vstd:
                    # Calculate the total cost of the path to this successor
                    successor_cost = total_cost + step_cost
                    priority=successor_cost+heuristic(successor,problem)
                    # Add the successor to the priority queue with its total cost
                    moves.push((successor, actions + [action], successor_cost), priority)
                    
    return []  # Se non è stato trovato alcun percorso, restituisci una lista vuota


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
