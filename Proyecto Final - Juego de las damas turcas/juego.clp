
;---------------------VARIABLES GLOBALES--------------------------------
;(defglobal ?*turno* = CPU);turno actual
(defglobal ?*tamanioTablero* = 0)
;(defglobal ?*dadoParaInicio* = 0)
;para el empate por piezas deberia tener el total de piezas de cada uno

;------------------------PLANTILLAS-----------------------------
;plantilla para tablero (hecho no ordenado)
(deftemplate tablero
    ;(slot tamanio(type INTEGER))
    (multislot fichas)
    (slot colorUsuario (allowed-values blanco negro))
    (slot colorCPU (allowed-values blanco negro))
)

;---------------------------HECHOS INICIALES--------------------------
;hechos como conocimiento inicial
(deffacts inicio "Estado inicial del juego"

)

;----------------------------FUNCIONES-------------------------

;-------------------TABLERO-------------------

;------------CREACION E IMPRESION----------------
;tablero,ayuda del profesor
(deffunction generarLineas (?x)
  (printout t crlf)
  (printout t "      |")
  (loop-for-count ?x
    (printout t "-----|")
  )
  (printout t crlf)
)

(deffunction generarLineas2 (?x)
  (printout t " ")
  (loop-for-count ?x
    (printout t "     |")
  )
  (printout t "     |")
  (printout t crlf)
)

;Imprimir el estado actual del mapeo
(deffunction imprimir ($?mapeo)
   ; posicion vacia 0
    ; posicion ficha blanca -1
    ; posicion ficha negra 1
    ; posicion reina blanca -10
    ; posicion reina negra 10
    (printout t crlf)
    (printout t  crlf)
    (loop-for-count (?i 0 ?*tamanioTablero*) do
      (if (= ?i 0) then
      (printout t "       ")
      else
      (printout t "  "?i "   "))
    )
    (generarLineas ?*tamanioTablero*)
    (loop-for-count (?fila 1 ?*tamanioTablero* ) do
      (generarLineas2 ?*tamanioTablero*)
      (printout t "   " ?fila "  |" )
      (loop-for-count (?columna 1 ?*tamanioTablero*) do
            (bind ?contenido (nth$  (+ (* ?*tamanioTablero* (- ?fila 1)) ?columna) $?mapeo))
			;(if (or (eq ?contenido ficha_blanca)(eq ?contenido ficha_negra)(eq ?contenido dama_blanca)(eq ?contenido dama_negra)) then
            (if (or (eq ?contenido -1)(eq ?contenido 1)(eq ?contenido -10)(eq ?contenido 10)) then
                ;(if (eq ?contenido ficha_blanca) then
                (if (eq ?contenido -1) then
                    (printout t  "  fb |")
                )
				;(if (eq ?contenido ficha_negra) then
                (if (eq ?contenido 1) then
                    (printout t  "  fn |")
                )
                ;(if (eq ?contenido dama_blanca) then
                (if (eq ?contenido -10) then
                    (printout t  " db |")
                )
				;(if (eq ?contenido dama_negra) then
                (if (eq ?contenido 10) then
                    (printout t  " dn |")
                )
			else
				(printout t "     |")
			)
      )
      (generarLineas ?*tamanioTablero*)
    )
)
;----------------------------------------------

(deffunction definirTablero() 
    ; posicion vacia 0
    ; posicion ficha blanca -1
    ; posicion ficha negra 1
    ; posicion reina blanca -10
    ; posicion reina negra 10

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
    (bind ?*tamanioTablero* (read))

    ;creacion del tablero en una variable multicampo
    (if (eq ?*tamanioTablero* 4) then 
        (bind $?fi (create$ 1 1 1 1  0 0 0 0  0 0 0 0  -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 5) then 
        (bind $?fi (create$ 1 1 1 1 1  0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  -1 -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 6) then 
        (bind $?fi (create$ 1 1 1 1 1 1  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  -1 -1 -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 7) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0  1 1 1 1 1 1 1  0 0 0 0 0 0 0  0 0 0 0 0 0 0  0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0))
    else (if (eq ?*tamanioTablero* 8) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0 0  1 1 1 1 1 1 1 1  1 1 1 1 1 1 1 1  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1 -1  -1 -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0 0))
        )
    ))))
    
    (printout t crlf)
    (printout t "Quien empieza? (CPU/Usuario):" crlf)
    ;(bind ?*turno* (read))
    ;bind ?tur (read))
    (assert (turno (read)))

    (printout t "De que color va a ser el usuario (blanco/negro):")
    (bind ?colorUsuario (read))
    
    (if (eq ?colorUsuario blanco)then
        (bind ?colorCPU negro)
        else
        (bind ?colorCPU blanco)
    )

    (assert(tablero(colorUsuario ?colorUsuario)(colorCPU ?colorCPU)(fichas $?fi)))

    (imprimir $?fi)
)


;color fila origen columna origen fila destino columna destino
(deffunction moverCPU (?c ?fo ?co ?fd ?cd $?fi)
    (printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)
    ;aca es donde no entra
    ;(printout t "antes del condicional CPU" crlf)
    ;(if (eq ?*turno* CPU) then
        ;(printout t "dentro del condicional cpu" crlf)
        ;(printout t "turno CPU" crlf)
        (if (eq ?c negro) then
            ;(printout t "ficha 1" crlf)
            (bind ?ficha 1)
        else
            ;(printout t "ficha -1" crlf)
            (bind ?ficha -1)
        )
    
    ; posicion vacia 0
    ; posicion ficha blanca -1
    ; posicion ficha negra 1
    ; posicion reina blanca -10
    ; posicion reina negra 10

    ;si la ficha es blanca
    (if (eq ?ficha -1) then
            ;(printout t "Entrada condicional moverCPU" crlf)
            ; si -1 eq nth ((tamanioTablero*(fo-1))+co) en fichas
            (if (eq -1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                            ;replace variableMulticampo inicio fin nuevoValor
                            ;nth devuelve el valor en esa posicion
                            ;variables multicampo indices desde 1
                    (printout t (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) crlf)
                    (printout t (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) crlf)
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co)(+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd)(+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) -1))

            else
                (if (eq -10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                    ;(printout t "Entrada condicional if else moverCPU" crlf)
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co)(+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd)(+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) -10))
                )
            )
        else
            ;(printout t "Entrada condicional else moverCPU" crlf)
            (if (eq 1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                ;(printout t "Entrada condicional else if moverCPU" crlf)
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co)   (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd)  (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) 1))
            else
                ;(printout t "Entrada condicional else else moverCPU" crlf)
                (if (eq 10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co)   (+ (* ?*tamanioTablero* (- ?fo 1)) ?co)  0))
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd)   (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd)  10))
                )
            )
        )
        (printout t $?fi crlf)
        (return $?fi)
        ;)
    )

(deffunction moverUsuario (?c ?fo ?co ?fd ?cd $?fi)
    (printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)
    ;(printout t "antes del condicional Usuario" crlf)
    ;(if (eq ?*turno* Usuario) then
        ;(printout t "dentro del condicional Usuario" crlf)
        ;(printout t "turno Usuario" crlf)
        (if (eq ?c negro) then
            ;(printout t "ficha 1" crlf)
            (bind ?ficha 1)
        else
            ;(printout t "ficha -1" crlf)
            (bind ?ficha -1)
        )

        
        (if (eq ?ficha -1) then
            ;(printout t "Entrada condicional moverUsuario" crlf)
            (if (eq -1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                ;(printout t "Entrada condicional if if moverUsuario" crlf)
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) -1))
            else
                (if (eq -10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                    ;(printout t "Entrada condicional if else moverUsuario" crlf)
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) -10))
                )
            )
        else
            (if (eq 1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                ;(printout t "Entrada condicional else if moverUsuario" crlf)
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) 1))
            else
                (if (eq 10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                    ;(printout t "Entrada condicional else else moverUsuario" crlf)
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
                    (bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) 10))
                )
            )
        )
        (printout t $?fi crlf)
        (return $?fi)
        
        ;else(
        ;    (if(eq ?*turno* Usuario) then
                ;moverCPU
        ;    )
        ;)
        ;)
)

(defrule movimientoCPU
    ?t<-(tablero (fichas $?fi)(colorCPU ?c))
    ;test se usa para evaluar las expresiones de la parte izquierda de una regla
    ;(test (eq ?*turno* CPU))
    ?tur<-(turno CPU)
    =>
    ;movimiento IA (arbol)
    ;(if (eq ?*turno* CPU) then
        ;(printout t "Movimiento CPU " ?*turno* crlf)

        (printout t "Turno CPU con color " ?c crlf)
        (printout t "Inserte fila origen: " crlf)
        (bind ?fo (read))
        (printout t "Inserte columna origen: " crlf)
        (bind ?co (read))
        (printout t "Inserte fila destino: " crlf)
        (bind ?fd (read))
        (printout t "Inserte columna destino: " crlf)
        (bind ?cd (read))
        ;;;;;;
        ;(printout t "MCPU" crlf)
        ;(printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)

        (bind $?fi (moverCPU ?c ?fo ?co ?fd ?cd $?fi))
        (modify ?t (fichas $?fi))

        (retract ?tur)
        (assert (turno Usuario))
        ;(bind ?*turno* Usuario)
        (imprimir $?fi)
        ;(printout t "Movimiento CPU parte final" crlf)    
    
)

(defrule movimientoUsuario
    ?t<-(tablero (fichas $?fi)(colorUsuario ?c))
    ;test se usa para evaluar las expresiones de la parte izquierda de una regla
    ;(test (eq ?*turno* Usuario))
    ?tur<-(turno Usuario)
    =>
    ;(if (eq ?*turno* Usuario) then
        ;(printout t "Movimiento usuario " ?*turno* crlf)
        (printout t "Turno Usuario con color " ?c crlf)
        (printout t "Inserte fila origen: " crlf)
        (bind ?fo (read))
        (printout t "Inserte columna origen: " crlf)
        (bind ?co (read))
        (printout t "Inserte fila destino: " crlf)
        (bind ?fd (read))
        (printout t "Inserte columna destino: " crlf)
        (bind ?cd (read))

        ;(printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)

        (bind $?fi (moverUsuario ?c ?fo ?co ?fd ?cd $?fi))
        (printout t "tablero: " $?fi crlf)
        (modify ?t (fichas $?fi))
        ;(bind ?*turno* CPU)
        (imprimir $?fi)
        ;(printout t ?*turno* crlf)
        (retract ?tur)
        (assert (turno CPU))

    
    
)

(defrule inicio
    (not (tablero))
=>
    (definirTablero)
)
;funcion para mover las fichas
;(deffunction movimiento

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

;(deffunction opcionCaptura

;)

;(deffunction empatePorAcuerdo

;)

;(defrule empatePorPiezas

;)