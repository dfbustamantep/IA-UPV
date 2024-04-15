;(defglobal ?*dimes* = 0)
;(defglobal ?*tamanioTablero* = 0)
;(defglobal ?*dadoParaInicio* = 0)

;plantilla para tablero (hecho no ordenado)
(deftemplate tablero
    (slot tamanio(type INTEGER))
    (multislot fichas)
    (slot colorUsuario (allowed-values blanco negro))
    (slot colorCPU (allowed-values blanco negro))
)

;hechos como conocimiento inicial
(deffacts inicio "Estado inicial del juego"

)

(deffunction definirTablero() 
    ; posicion vacia 0
    ; posicion ficha blanca 1
    ; posicion ficha negra -1
    ; posicion reina blanca 10
    ; posicion reina negra -10

    ;"0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
    ;"1" "1" "1" "1" "1" "1" "1" "1" "1" "1"
    ;"1" "1" "1" "1" "1" "1" "1" "1" "1" "1"
    ;"0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
    ;"0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
    ;"-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1"
    ;"-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1" "-1"
    ;"0" "0" "0" "0" "0" "0" "0" "0" "0" "0"

    ;"_" "_" "_" "_" "_""_" "_" "_" "_" "_"
    ;"fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn"
    ;"fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn" "fn"
    ;"_" "_" "_" "_" "_""_" "_" "_" "_" "_"
    ;"_" "_" "_" "_" "_""_" "_" "_" "_" "_"
    ;"fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb"
    ;"fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb" "fb"
    ;"_" "_" "_" "_" "_""_" "_" "_" "_" "_"

    (printout t "De que tamanio desea el tablero 4*4 ,5*5 ,6*6 ,7*7 o 8*8 :")
    (bind ?tamanioTablero (read))


    ; (switch ?tamanioTablero)
    ;    (case 5 then
    ;       (bind $?fi (create$ 1 1 1 1 1  0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  -1 -1 -1 -1 -1))
    ;    )
    ;    (case 6 then
    ;        (bind $?fi (create$ 1 1 1 1 1 1  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  -1 -1 -1 -1 -1 -1))
    ;    )
    ;    (case 7 then
    ;        (bind $?fi (create$ 0 0 0 0 0 0 0  1 1 1 1 1 1 1  0 0 0 0 0 0 0  0 0 0 0 0 0 0  0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0))
    ;    )
    ;    (case 8 then
    ;        (bind $?fi (create$ 0 0 0 0 0 0 0 0  1 1 1 1 1 1 1 1  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0 0))
    ;    )
    ;    (default
    ;        (printout t "Valor invalido")
    ;    )
    ;)
    ;(bind ?tamanioTablero (integerp tamanioTablero))
    (if (eq ?tamanioTablero 5) then 
        (bind $?fi (create$ 1 1 1 1 1  0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  -1 -1 -1 -1 -1))
    else (eq ?tamanioTablero 6) then 
        (bind $?fi (create$ 1 1 1 1 1 1  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  -1 -1 -1 -1 -1 -1))
    else (eq ?tamanioTablero 7) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0  1 1 1 1 1 1 1  0 0 0 0 0 0 0  0 0 0 0 0 0 0  0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0))
    else (eq ?tamanioTablero 8) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0 0  1 1 1 1 1 1 1 1  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0 0))
    )


    (printout t crlf)
    (printout t "De que color va a ser el usuario (blanco/negro):")
    (bind ?colorUsuario (read))
    (if (= ?colorUsuario blanco)then
        (bind ?colorCPU negro)
        else
        (bind ?colorCPU blanco)
    )
    (assert(tablero(tamanio ?tamanioTablero)(colorUsuario ?colorUsuario)(colorCPU ?colorCPU)(fichas $?fi)))
    ;(?*tablero*  create$ ?*tamanioTablero* ?*tamanioTablero*)
    ;se define la posicion de los peones
)

(defrule inicio
    (not tablero)
=>
    (definirTablero)
)




;funcion para mover las fichas
;(deffunction moverFichaBlanca 

;toca comprobar que la posicion dada sea valida
;en esta tocaria comprobar lo de comer 
;)

;funcion para mover las fichas
;(deffunction moverFichaNegra 

;toca comprobar que la posicion dada sea valida
;en esta tocaria comprobar lo de comer 
;)

;regla para hacer reina
;(defrule convertirReina
;comprobar la posicion
;)

;(deffunction moverReina
;comprobar la posicion
;)

;(deffunction quitarFicha

;)

;(deffunction impimirMovimiento
    ;impirmir fila origen,columna origen
    ;impirmir fila nueva,columna nueva
;)

;(deffunction opcionCaptura

;)

;(deffunction empatePorAcuerdo

;)

;(defrule empatePorPiezas

;)