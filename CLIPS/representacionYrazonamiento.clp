;Ejemplo diapositivas
(deffacts datos_iniciales
(amigo 3)
)
(defrule quitar_amigo
?a <-(amigo ?x)
=>
(retract ?a)
(bind ?x (- ?x 1))
(assert (amigo ?x))
)
(defrule sumar_amigo
?a <-(amigo ?x)
=>
(retract ?a)
(bind ?x (+ ?x 1))
(assert (amigo ?x))
)