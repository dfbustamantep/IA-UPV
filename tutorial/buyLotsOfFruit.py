# buyLotsOfFruit.py

"""
To run this script, type

  python buyLotsOfFruit.py

Once you have correctly implemented the buyLotsOfFruit function,
the script should produce the output:

Cost of [('apples', 2.0), ('pears', 3.0), ('limes', 4.0)] is 12.25
"""
from __future__ import print_function

#Diccionario con el nombre de la fruta y su precio
fruitPrices = {'apples': 2.00, 
               'oranges': 1.50, 
               'pears': 1.75,
               'limes': 0.75,
                'strawberries': 1.00}


def buyLotsOfFruit(orderList):
    """
        orderList: List of (fruit, numPounds) tuples

    Returns cost of order
    """
    totalCost = 0.0
    for fruit,numPounds in orderList:
        if fruit in fruitPrices:
            totalCost +=  fruitPrices[fruit] * numPounds
    
    "*** YOUR CODE HERE ***"
    return totalCost


# Main Method
if __name__ == '__main__':
    "This code runs when you invoke the script from the command line"
    orderList = [('apples', 2.0), ('pears', 3.0), ('limes', 4.0)]
    print('Cost of', orderList, 'is', buyLotsOfFruit(orderList))
