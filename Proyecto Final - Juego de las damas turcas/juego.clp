;(defglobal ?*dimes* = 0)
(defglobal ?*tamanioTablero* = 0)
(defglobal ?*dadoParaInicio* = 0)

(deftemplate tablero
    (slot )
)
;hechos como conocimiento inicial
(deffacts inicio "Estado inicial del juego"

)

(deffunction definirTablero ()
    (printout t "De que tamanio desea el tablero 4*4 ,5*5 ,6*6 ,7*7 o 8*8 :")
    (bind ?*tamanioTablero* (read))
    (printout t crlf)
    (?*tablero*  create$ ?*tamanioTablero* ?*tamanioTablero*)
    ;se define la posicion de los peones
)

(defrule inicio
(not tablero)
=>
    (definirTablero)
)




;funcion para mover las fichas
(deffunction moverFichaBlanca 

;toca comprobar que la posicion dada sea valida
;en esta tocaria comprobar lo de comer 
)

;funcion para mover las fichas
(deffunction moverFichaNegra 

;toca comprobar que la posicion dada sea valida
;en esta tocaria comprobar lo de comer 
)

;regla para hacer reina
(defrule convertirReina
;comprobar la posicion
)

(deffunction moverReina
;comprobar la posicion
)

(deffunction quitarFicha

)

(deffunction impimirMovimiento
    ;impirmir fila origen,columna origen
    ;impirmir fila nueva,columna nueva
)

(deffunction opcionCaptura

)

(deffunction empatePorAcuerdo

)

(defrule empatePorPiezas

)