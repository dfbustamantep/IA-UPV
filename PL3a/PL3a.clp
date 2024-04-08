;Crea una función donde recibiendo dos números como parámetros, le pedirá al usuario un
;número que deberá estar dentro del rango que limitan los dos parámetros. Si no lo estuviera, se le
;pedirá al usuario una y otra vez hasta que el valor introducido sea correcto

(deffunction dentroDelRango (?num1 ?num2)
    
    (if (> ?num1 ?num2) then
        (bind ?nMayor ?num1)
        (bind ?nMenor ?num2)
        
    else
        (bind ?nMayor ?num2)
        (bind ?nMenor ?num1)
    )
    (bind ?numeroUsuario 9999999999)
    (while (or(< ?numeroUsuario ?nMenor)(> ?numeroUsuario ?nMayor))
        (printout t "Introduzca un numero ")
        (bind ?numeroUsuario (read))
    )
    (printout t "El numero esta en el rango" crlf) 
    ;(if (and(?numeroUsuario>?nMenor)(?numeroUsuario<?nMayor))then
    ;    ()
    ;else
    ;    ()     
)


;2) Crea una función para calcular y mostrar por pantalla el máximo común divisor (mcd) de dos
;números que se le pasarán a la función como parámetro. El mcd de estos números se calcula
;teniendo en cuenta:
;Si a = b mcd ( a, a ) = a
;Si a > b mcd ( a, b ) = mcd ( a − b , b )
;Si a < b mcd ( a, b ) = mcd ( a , b − a )
;> (mcd 3 6) → 3

(deffunction mcd (?num1 ?num2)
    (if (= ?num1 ?num2) then
        (printout t "El maximo comun divisor es " ?num1 crlf)
    )
    (if (> ?num1 ?num2) then
        return (mcd (- ?num1 ?num2) ?num2)
        else 
            (return (mcd ?num1 (- ?num2 ?num1)))
    )
)

;3) Crea una función para calcular y mostrar por pantalla el mínimo común múltiplo (mcm) de dos
;números que se le pasarán a la función como parámetro. El mcm de estos números se calcula
;teniendo en cuenta:
;mcm (a,b)= (a*b) / mcd(a,b)
;> (mcm 72 50) → 1800

(deffunction mcm (?num1 ?num2)
    (return(/ (* ?num1 ?num2) (mcm ?num1 ?num2)))
)

;4) Crea una función donde recibiendo un parámetro multicampo de enteros, devuelva el multicampo
;con los enteros ordenados de menos a más.


(deffunction ascendente (?variableMulticampo)
    (sort ?variableMulticampo))
