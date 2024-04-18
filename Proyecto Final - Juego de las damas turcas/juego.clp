(defglobal ?*turno* = CPU)
(defglobal ?*tamanioTablero* = 0)
;(defglobal ?*dadoParaInicio* = 0)

;plantilla para tablero (hecho no ordenado)
(deftemplate tablero
    ;(slot tamanio(type INTEGER))
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
    (bind ?*tamanioTablero* (read))


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
    (if (eq ?*tamanioTablero* 4) then 
        (bind $?fi (create$ 1 1 1 1  0 0 0 0  0 0 0 0  0 0 0 0  -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 5) then 
        (bind $?fi (create$ 1 1 1 1 1  0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  -1 -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 6) then 
        (bind $?fi (create$ 1 1 1 1 1 1  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  0 0 0 0 0 0  -1 -1 -1 -1 -1 -1))
    else (if (eq ?*tamanioTablero* 7) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0  1 1 1 1 1 1 1  0 0 0 0 0 0 0  0 0 0 0 0 0 0  0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0))
    else (if (eq ?*tamanioTablero* 8) then 
        (bind $?fi (create$ 0 0 0 0 0 0 0 0  1 1 1 1 1 1 1 1  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0  -1 -1 -1 -1 -1 -1 -1 -1  0 0 0 0 0 0 0 0))
        )
    ))))


    
    (printout t crlf)
    (printout t "Quién empieza? (CPU/Usuario):" crlf)
    (bind ?*turno* (read))
    (printout t "De que color va a ser el usuario (blanco/negro):")
    (bind ?colorUsuario (read))
    ;(if (= ?colorUsuario blanco)then
    (if (eq ?colorUsuario blanco)then
        (bind ?colorCPU negro)
        else
        (bind ?colorCPU blanco)
    )
    (assert(tablero(colorUsuario ?colorUsuario)(colorCPU ?colorCPU)(fichas $?fi)))
    ;(?*tablero*  create$ ?*tamanioTablero* ?*tamanioTablero*)
    ;se define la posicion de los peones
)

(defrule inicio
    (not (tablero))
=>
    (definirTablero)
)

(deffunction moverCPU (?c ?fo ?co ?fd ?cd $?fi)
(printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)
(if (eq ?*turno* CPU) then
    (printout t "turnoCPU" crlf)
    (if (eq ?c negro) then
        (bind ?ficha 1)
    else
        (bind ?ficha -1)
    )

    
   (if (eq ?ficha -1) then
        (if (eq -1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) -1))
        else
            (if (eq -10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) -10))
            )
        )
    else
        (if (eq 1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) 1))
        else
            (if (eq 10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) 10))
            )
        )
    )
    (printout t $?fi crlf)
    (return $?fi)
    )
)

(deffunction moverUsuario (?c ?fo ?co ?fd ?cd $?fi)
(printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)
(if (eq ?*turno* Usuario) then
    (printout t "turnoUsuario" crlf)
    (if (eq ?c negro) then
        (bind ?ficha 1)
    else
        (bind ?ficha -1)
    )

    
    (if (eq ?ficha -1) then
        (if (eq -1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) -1))
        else
            (if (eq -10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) -10))
            )
        )
    else
        (if (eq 1 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
            (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) 1))
        else
            (if (eq 10 (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi)) then
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fo 1)) ?co) $?fi) 0))
                (bind $?fi (replace$ $?fi (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) (nth$ (+ (* ?*tamanioTablero* (- ?fd 1)) ?cd) $?fi) 10))
            )
        )
    )
    (printout t $?fi crlf)
    (return $?fi)
    )
)

(defrule movimientoCPU
    ?t<-(tablero (fichas $?fi)(colorCPU ?c))
    (test (eq ?*turno* CPU))
    =>
    ;movimiento IA (arbol)
    (printout t "Turno CPU con color " ?c crlf)
    (printout t "Inserte fila origen: " crlf)
    (bind ?fo (read))
    (printout t "Inserte columna origen: " crlf)
    (bind ?co (read))
    (printout t "Inserte fila destino: " crlf)
    (bind ?fd (read))
    (printout t "Inserte columna destino: " crlf)
    (bind ?cd (read))
   
    (bind $?fi (moverCPU ?c ?fo ?co ?fd ?cd $?fi))
    (modify ?t (fichas $?fi))
    (bind ?*turno* Usuario)
    (imprimir $?fi)
)

(defrule movimientoUsuario
    ?t<-(tablero (fichas $?fi)(colorUsuario ?c))
    (test (eq ?*turno* Usuario))
    =>
    (printout t "Turno Usuario con color " ?c crlf)
    (printout t "Inserte fila origen: " crlf)
    (bind ?fo (read))
    (printout t "Inserte columna origen: " crlf)
    (bind ?co (read))
    (printout t "Inserte fila destino: " crlf)
    (bind ?fd (read))
    (printout t "Inserte columna destino: " crlf)
    (bind ?cd (read))
    (printout t "(" ?fo "," ?co ")" "->" "(" ?fd "," ?cd ")" crlf)
    (bind $?fi (moverUsuario ?c ?fo ?co ?fd ?cd $?fi))
    (modify ?t (fichas $?fi))
    (bind ?*turno* CPU)
    (imprimir $?fi)
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