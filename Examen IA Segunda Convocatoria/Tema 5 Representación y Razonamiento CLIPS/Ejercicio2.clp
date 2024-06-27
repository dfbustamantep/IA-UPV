;Crea un sistema para simular un restaurante donde
; solamente se dan postres.
;Como postre se puede escoger fruta o dulce.
    ;fruta: plátano, manzana o kiwi
    ;dulce: tarta de queso, tarta de manzana o coulant
;Solamente hay X unidades de productos. Cuando se acaben 
;las unidades, ese postre desaparecerá del menú.

;Al principio el restaurante está vacío.
; En la puerta existe una cámara que reconoce los clientes,
; generando el hecho automáticamente:
;(nuevo cliente nombre_cliente)
;De la misma manera, cuando el cliente salga de la puerta
; se generará el hecho:
;(adiós nombre_cliente) para poder eliminar el cliente
;Cuando un cliente le diga lo que quiere al camarero, 
;éste generará el hecho:
;(quiere nombre_cliente nombre_postre)

(deffacts estado_inicial "definimos como hechos iniciales la cantidad de postres disponibles"
    ;platano,manzana,kiwi
    (fruta 5 5 5)
    ;tarta de queso,tarta de manzana,coulant
    (dulce 5 5 5)
)

(defrule anadir_cliente
    (nuevo_cliente ?nombre)
    ?fr<-(fruta ?f1 ?f2 ?f3)
    ?dl<-(dulce ?d1 ?d2 ?d3)
=>
    (assert (cliente ?nombre))
    (printout t "Productos" crlf)
    (printout t "--------------------------------" crlf)
    (if (> ?f1 0)then
        (printout t "   Platano" crlf)
    )

    (if (> ?f2 0)then
        (printout t "   Manzana" crlf)
    )

    (if (> ?f3 0)then
        (printout t "   Kiwi" crlf)
    )

    (if (> ?d1 0)then
            (printout t "   Tarta de queso" crlf)
        )

    (if (> ?d2 0)then
            (printout t "   Tarta de manzana" crlf)
        )

    (if (> ?d3 0)then
            (printout t "   Coulant" crlf)
        )
    (printout t "--------------------------------" crlf)
    (printout t "Que desea llevar?" crlf)
    (bind ?pedido (read))
    (assert (quiere ?nombre ?pedido))
)

(defrule salida_cliente
    (adios ?nombre)
    ?p <- (cliente ?nombre)
=>
    (retract ?p)
)

(defrule platano
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCliente platano)
    ?fr <- (fruta ?p1 ?p2 ?p3)
=>
    (if (> ?p1 0) then
        (retract ?pedido)
        (retract ?fr)
        (assert (fruta (- ?p1 1) ?p2 ?p3))
        else
            (printout t "no queda platano" crlf)
    )
)

(defrule manzana
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCLiente manzana)
    ?fr <- (fruta ?p1 ?p2 ?p3)
    =>
    (if (> ?p2 0)then
        (retract ?pedido)
        (retract ?fr)
        (assert (fruta ?p1 (- ?p2 1) ?p3))
        else    
            (printout t "no queda manzana")
    )
)

(defrule kiwi
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCLiente kiwi)
    ?fr <- (fruta ?p1 ?p2 ?p3)
    =>
    (if (> ?p3 0)then
        (retract ?pedido)
        (retract ?fr)
        (assert (fruta ?p1 ?p2 (- ?p3 1)))
        else    
            (printout t "no queda kiwi")
    )
)
;tarta de queso,tarta de manzana,coulant
(defrule tartaQueso
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCliente tarta_de_queso)
    ?dl <- (dulce ?d1 ?d2 ?d3)
=>
    (if (> ?d1 0) then
        (retract ?pedido)
        (retract ?dl)
        (assert (dulce (- ?d1 1) ?d2 ?d3))
        else
            (printout t "no queda tarta de queso" crlf)
    )
)

(defrule tartaManzana
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCliente tarta_de_manzana)
    ?dl <- (dulce ?d1 ?d2 ?d3)
=>
    (if (> ?d2 0) then
        (retract ?pedido)
        (retract ?d2)
        (assert (dulce ?d1 (- ?d2 1) ?d3))
        else
            (printout t "no queda tarta de manzana" crlf)
    )
)

(defrule coulant
    (cliente ?nombre)
    ?pedido <- (quiere ?nombreCliente coulant)
    ?dl <- (dulce ?d1 ?d2 ?d3)
=>
    (if (> ?d2 0) then
        (retract ?pedido)
        (retract ?dl)
        (assert (dulce ?d1 ?d2 (- ?d3 1)))
        else
            (printout t "no queda coulant" crlf)
    )
)