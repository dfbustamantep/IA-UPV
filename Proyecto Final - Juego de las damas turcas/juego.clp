
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
    (not (comprobar))
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
        (assert (comprobar))  
    
)

(defrule movimientoUsuario
    ?t<-(tablero (fichas $?fi)(colorUsuario ?c))
    ;test se usa para evaluar las expresiones de la parte izquierda de una regla
    ;(test (eq ?*turno* Usuario))
    ?tur<-(turno Usuario)
    (not (comprobar))
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
        (assert (comprobar))

    
    
)

;---------COMER-----
(deffunction hayOpcionComer()
    ;Para capturar, un peón debe saltar por encima de una pieza
    ;oponente, aterrizando en la casilla vacía inmediatamente detrás de ella. La pieza capturada se
    ;elimina del juego.
    ;Si en la posicion actual de una de las fichas -tamanioTablero() o +tamanioTablero() 

    ;COLUMNA
    ;0 1 1 1  F  0 fn fn fn
    ;1 0 0 0  I  fn 0 0 0
    ;-1 0 0 0 L  fb 0 0 0
    ;0 -1-1-1 A  0 fb fb fb
        ;en este caso es turno de CPU con color negro,la ficha negra en la posicion f2,c1 tiene la opcion de comer a la ficha blanca 
        ;que esta en la posicion f3,c1

        ;-----------------COMER VERTICALMENTE
        ;una opcion podria ser verificar si posicion por posicion si le sumo o resto el tamanio hay una ficha,
        ;y si se le suma dos veces el tamanio esta libre se puede comer

            ;(+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0)
            ;(+(*4 -2 1)1)(+(*4 -2 1)2)

        ;-----------------COMER HORIZONTALMENTE
        ;una opcion podria ser verificar si posicion por posicion si le sumo o resto 1 hay una ficha,
        ;y si se le suma dos  esta libre se puede comer,toca verificar si la columna donde esta la ficha a comer es el mismo numero que el tamanio(toca pasar y trabajar con coordenadas otra vez)
        ;si es asi no se debe permitir comer

        ;(bind $?fi (replace$ $?fi (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) 0))
    (printout t "hayOpcionComer" crlf)
        
)

;(defrule comer
    ;si la funcion de comer retorna true se le dice al usuario que debe comer y no se le permite mover otra ficha que no sea la que puede 
    ;comer 
;    (hayOpcionComer)
;    ?t<-(tablero (fichas $?fi))
;=>
;    (printout t "comer" crlf)
;)
;---------HACER REINA-----
;cuando la fila de destinosea igual a 1 o igual al tamanio se vuelve reina
;(deffunction hayFichaenExtremo()
;    (printout t "ficha en extremo" crlf)
    ;tamanio variable tablero
    ;(bind ?tamanioVT ())
                    ;variable inicio final
    ;(loop-for-count (?i 0 ?tamanioVT) do
    ;
    ;)
    ;para cada 
    ;la idea es recorrer todo el tablero y las fichas que esten en el extremo se hacen reinas
    ;(foreach ?pos )
;)

;(defrule hacerReina
;    ?t<-(tablero (fichas $?fi)(colorUsuario ?c))
    ;si hay una posicion en la primera o ultima fila(extremo) se hcae reina
    ;en el caso de 4x4,5x5 y 6x6
;    (hayFichaenExtremo)
    ;fila destino igual 1 o fila de destino igual tamanio
;=>
;    (printout t "La ficha ahora es reina" crlf)
;)

;---------FIANL PARTIDA-----
(deffunction comprobarFinalPartida($?tablero)
    ;si ya no hay piezas de un oponente
    ; posicion vacia 0
    ; posicion ficha blanca -1
    ; posicion ficha negra 1
    ; posicion reina blanca -10
    ; posicion reina negra 10
    (bind ?totalFichasBlancas 0)
    (bind ?totalFichasNegras 0)
    (printout t "Comprobando si hay ganador....." crlf)
    ;es una lista 
    (loop-for-count (?i 1 (* ?*tamanioTablero* ?*tamanioTablero*)) do
      
       
        (bind ?contenido (nth$  ?i $?tablero))
        (if (or (eq ?contenido -1)(eq ?contenido 1)(eq ?contenido -10)(eq ?contenido 10)) then
            ;(if (eq ?contenido ficha_blanca) then
            (if (eq ?contenido -1) then
                (bind ?totalFichasBlancas (+ ?totalFichasBlancas 1))
            )
            ;(if (eq ?contenido ficha_negra) then
            (if (eq ?contenido 1) then
                (bind ?totalFichasNegras (+ ?totalFichasNegras 1))
            )
            ;(if (eq ?contenido dama_blanca) then
            (if (eq ?contenido -10) then
                (bind ?totalFichasBlancas (+ ?totalFichasBlancas 1))
            )
            ;(if (eq ?contenido dama_negra) then
            (if (eq ?contenido 10) then
                (bind ?totalFichasNegras (+ ?totalFichasNegras 1))
            )
        ) 

        
    )
        (if(or (eq ?totalFichasBlancas 0)(eq ?totalFichasNegras 0))then
            (if (eq ?totalFichasBlancas 0)then
                (printout t "Las fichas negras han ganado" crlf)
                (assert (ganador Negro))
                ;(retract ?tur)
                ;(assert (turno Usuario))
            )
            (if (eq ?totalFichasNegras 0)then
                (printout t "Las fichas blancas han ganado" crlf)
                (assert (ganador Blanco))
            )
        else
            (printout t "Animo,todavia hay posibilidad" crlf)
            (assert (ganador noHay))
        )
)

(defrule finalPartida
    ;a) Vence la partida el jugador que captura todas las piezas del rival.
            ;Hacer funcion que compruebe el total de fichas si un jugador tiene 0 entonces se acaba la partida y si ambos tienen 1 tambien
    ;b) También vence el jugador que, sin haber capturado todas las piezas rivales, consigue
    ;bloquearlas, de modo que el rival no pueda mover.
    ;c) La partida acaba en empate en los siguientes casos:
    ; Por acuerdo entre ambos jugadores.
    ; Se repiten los mismos movimientos una y otra vez (punto anterior).
    ; Cada jugador queda con una sola pieza.
    ?t<-(tablero (fichas $?fi))
    ?comp<-(comprobar)
    
=>
    (comprobarFinalPartida $?fi)
    (retract ?comp)
    ;(if (eq (comprobarFinalPartida $?fi) true)then
    ;    (printout t "La partida se puede finalizar" crlf)
    ;else
    ;    (printout t "Todavia hay movimientos posibles" crlf)
    ;)
    
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