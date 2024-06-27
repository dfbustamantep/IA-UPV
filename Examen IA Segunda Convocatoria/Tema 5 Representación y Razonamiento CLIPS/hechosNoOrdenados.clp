;Hecho forma basica de representari infromacion
;Exiten hechos ordenados y no ordenados

;En los no ordenados cada campo tiene su nombre y valor
;Para los hechos no ordenados toca definir una pantilla con el cosntructor deftemplate

(deftemplate datos-persona
    ;puede contener varios valores
    (multislot nombre)
    (multislot apellidos)
    ;puede contener solo un valor
    (slot edad)
    (slot peso)
    (slot altura)
    (multislot presion-arterial)
)

;en una platilla podemos definir el tipo,valores por defecto y el rango de sus slots o multislots
;Tipo para definir el tipo de dato se usa type
    ;LEXEME equivale a SYMBOL y STRING
    ;NUMBER equivale a INTEGER y FLOAT
    ;?VARIBALE cualquier tipo de dato (por defecto)

    ;allowed define los valores concretos permitidos

;range permite restringir los valores de un tipo numerico a un rango determinado
    ;range ?VARIABLE 3 quiere decir que va desde menos infinito hasta 3
    ;tange 14 ?VARIABLE quiere decir que va desde 14 a infinito


;diapositiva 7
(deftemplate datos-persona2
    ;puede contener varios valores
    (multislot nombre (type SYMBOL))
    (multislot apellidos (type SYMBOL))
    ;puede contener solo un valor
    (slot edad (type NUMBER)(range 0 120))
    (slot peso (type NUMBER))
    (slot altura (type NUMBER))
    (multislot presion-arterial (type NUMBER))
    (slot estado-civil) (type SYMBOL)(allowed-symbols soltero casado union_libre) 
)