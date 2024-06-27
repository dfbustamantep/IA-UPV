(deffunction suma (?a ?b)
    (return (+ ?a ?b))
)
;PL3a
(deffunction dentroDelRango (?a ?b)
    (bind ?varU (+ ?a ?b))
    (while (or(< ?varU ?a)(> ?varU ?b))
        (printout t "Digite un numero para determinar si esta dentro del rango "crlf)
        (bind ?varU(read))
    )
)


;Crea una función para calcular y mostrar por pantalla el máximo común divisor (mcd) de dos
;números que se le pasarán a la función como parámetro. El mcd de estos números se calcula
;teniendo en cuenta:
;Si a = b mcd ( a, a ) = a
;Si a > b mcd ( a, b ) = mcd ( a − b , b )
;Si a < b mcd ( a, b ) = mcd ( a , b − a )



(deffunction mcd (?a ?b)
    (if (= ?a ?b) then
        (return ?a)
    )
    (if (> ?a ?b) then
        return (mcd (- ?a ?b) ?b)
      
        else 
            (return (mcd ?a (- ?b ?a)))
    )   
)

;mcm (a,b)= (a*b) / mcd(a,b)

(deffunction mcm (?a ?b)
    (return(/ (* ?a ?b) (mcd ?a ?b)))
)

;falta 4 5 6

(deffunction concatenacion (?a $?b)
    
)