;Crear un sistema para simular el estado de una persona
;Posibles estados:
    ;durmiendo
    ;comiendo
    ;estudiando (valor por defecto)

;el sistema preguntara el nuevo estado,se introducira por teclado
;y se cambiara el estado de la persona

;si no se introduce un estado valido no se modificara 
;el estado de la persona


(deffacts datos_iniciales
    (persona durmiendo)
)

(defrule estado_nuevo
    ?p<-(persona ?e)
=>
    (retract ?p)
    (printout t "cual es el nuevo estado?" crlf)
    (bind ?estado (read))
    (if (or(eq ?estado durmiendo)
    (eq ?estado estudiando)
    (eq ?estado comiendo)) then
    (assert (persona ?estado))
    else
    (printout t "ese estado no es posible" crlf)
    (assert (persona ?e))
    )
)
