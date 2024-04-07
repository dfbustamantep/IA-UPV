
;para definir funciones hay que usar la palabra deffuncttion,seguido por el nombre ,se indican los parametros y
;despues el cuerpo del programa
;los parametros o variables simples se indican con ? y el nombre ?nombre 
;para usar listas se define con dolar y signo de interrogacion $?nombre
;para crear listas se usa el comando create$
;para saignar un valor a una variable se usa el comando bind (bind ?a 5)
;para las listas variables multicampos usamos (bind$?a (create$ 1 2 3 4 5))
;para definir variables globales usamos defglobal (defgloabl ?*a* = 3)
;para cambiar el valor de una variable global (bind *?varglobal* 5)

(deffunction suma (?a ?b)
    ;las funciones se indican al inicio por eso el mas va de primeras   
    (return (+ ?a ?b))
 )

;antes de cada funcion siempre necesitaremos parentesis

;para ejecutar en la interfaz de CLIPS 
;pestaña file,seleccionamos load  y cargamos el programa prueba.clp 


;casting
;(integer 1.3) → 1

;pregunta tipo dato
;(integerp 1.3) → FALSE 

;deffunction Definir funciones
;defglobal Definir variables globales
;deftemplate: Para definir plantillas
;deffacts: Para definir hechos
;defrule: Para definir reglas

;bind asigna valor (=)

;Variables simpes guardan un solo valor  (bind ?var1 5)

;Variables multicampo  $?nombreVariable 
    ;(bind $?var2 5 hola "adios")
    ;(bind $?var2 (create$ 5 hola 89 "adios"))

;Variables globales defglobal
    ;(defglobal ?*var1* = 7)
    ;TOCA DEJAR ESPACIO DESPUES DEL ASTERISCO Y DESPUES DEL IGUAL 
    ;(defglobal ?*var2* = (create$ adios 5 "hola"))

    ;se usa reset para que las variables globales retomen su valor original(de cuando fueron creadas)

; CLEAR se elimina todo de la memoria


;ENTRADA Y SALIDA 
;Funcion read--ENTRADA
;Permite leer informacion proporcionada por el usuario
    ;(bind ?var1(read))

;funcion readline
;permite leer la informacion proporcionada pr el usuario,incluyendo espacios,se guarda com una cadena de texto STRING
    ;(bind ?var1(readline))

;convertir un STRING a un conjunto de simbolos se usa la funcion explode$
    ;(bind ?var1(explode$(readline)))

;Funcion  printout--SALIDA
;permite imprimir por pantalla como por fichero
    ;(printout t"¡Hola!" crlf) 
    ;CRLF salto de linea

;Para hacer uso de ficheros primero toca abrirlo
    ;(open "ruta/miFichero.txt" File1 "w") --> abrimos el fichero en modo escritura
    ;(close File1)-->Cerramos el fichero
    ;(printout File1 "hola mundo" crlf) --->Escribimos en el fichero y hacemos un salto de linea
    ;(format File1/nil “Nombre: %s y Edad: %d” “Ekaitz” 18) → escribe datos en File1(fichero) o nil (pantalla). No necesita crlf.
    ;(bind ?palabra (read File1) → lee del fichero sólo hasta el primer espacio en blanco o EOF.
    ;(bind ?palabra (readline File1) → lee del fichero hasta salto de línea o EOF.
    ;(rename “miFichero.txt” “tuFichero.txt”) → cambia el nombre del fichero
    ;(remove “tuFichero.txt”) → elimina el fichero
(deffunction iguales(?a ?b)
    (if (= ?a ?b) then
        (printout t "son iguales" crlf)
    else
        (printout t "no son iguales" crlf)
    ) 
)

;CONDICIONALES IF
    ;(if (<condición>) then
    ;(<acción>)
    ;[else (<acción>)])

;----------------------------
(deffunction BucleforCount(?a)
    (loop-for-count 2
        (printout t "Hola mundo" crlf)
    )
    (loop-for-count (?i 0 2)
        (loop-for-count (?j 1 3)
            (printout t ?i " " ?j crlf)
        )
)
)

(deffunction BucleForeach()
    (foreach ?a (create$ 1 2 3)
        (printout t ?a )    
    ) 
)

(deffunction Buclewhile()
    (bind ?v 4)
    (while (> ?v 0)
        (printout t "v es " ?v crlf)
        (bind ?v (- ?v 1))
    )
)
;BUCLES O SENTENCIAS REPETITIVAS
;(loop-for-count (<var> <inicio><final>) [do] <acción>)
;(while (<condición>) [do] (<acción>))
;(foreach <var> <varMulti> (<accion>))


;FUNCIONES VARIABLES MULTICAMPO
;progn --es similar al for each
(deffunction VMulticampoProgn()
    (progn$ (?var (create$ abc def ghi))
    (printout t "-->" ?var "<--" crlf)
    )
)


;SWITCH
;(switch <expresión-test>
;(case <comparación> then <acción>)
;...
;(case <comparación> then <acción>)
;[(default <acción>)])
(deffunction switchCase()
    (bind ?vari (read))
    (switch ?vari
        (case 1 then
            (printout t "variable = 1" crlf))
        (case 2 then
            (printout t "variable = 2" crlf))
        (default
            (printout t "Numero no valido" crlf)
        )
    )
)

;OPERADORES 
;OPERADORES LOGICOS
(deffunction operadorAnd()
    ;asiganmos el valor de un numero 
    (bind ?numeroSistema 3)

    (bind ?numeroUsuario (read))
    (if (and(= ?numeroSistema 3)(= ?numeroUsuario 3))then
         (printout t "Los numeros son iguales,tienen valor de 3" crlf)
    )
    ;else
    ;    (printout t "Los numero")
)

(deffunction operadorOR()
    ;asiganmos el valor de un numero 
    (bind ?numeroSistema 4)

    (bind ?numeroUsuario (read))
    (if (or(= ?numeroSistema 3)(= ?numeroUsuario 3))then
         (printout t "Alguno de los numeros tiene valor de 3" crlf)
    )

)
;OPERADORES MATEMATICOS
(deffunction valorAbsoluto(?numero)
    (printout t "El valor abosluto del numero "?numero" es "(abs ?numero)crlf)
)

(deffunction operacionesBasicas(?n1 ?n2)
    (printout t "La suma es " (+ ?n1 ?n2)crlf)
    (printout t "La resta es " (- ?n1 ?n2)crlf)
    (printout t "La division es " (/ ?n1 ?n2) crlf)
    (printout t "El resto de la division es " (mod ?n1 ?n2) crlf)
    (printout t "La multiplicacion es " (* ?n1 ?n2)crlf)
    (printout t "e elevado a "?n1 " es "(exp ?n1)crlf)
    (printout t "Logaritmo en base e de "?n1 " es "(log ?n1)crlf)
    (printout t "Logaritmo en base 10 de "?n1 " es "(log10 ?n1)crlf)
    (printout t "Raiz cuadrada de "?n1 "es"(sqrt ?n1)crlf)
    (printout t "El numero "?n1 " elevado a "?n2 " es "(** ?n1 ?n2)crlf)
    (printout t "Numero aleatorio entre "?n2 " y "?n1 " es "(random ?n1 ?n2)crlf)
)

(deffunction funcionesTrigonometricas(?n1)
    (printout t "El seno de "?n1 " es "(sin ?n1)crlf)
    (printout t "El coseno de "?n1 " es "(cos ?n1)crlf)
    (printout t "La tangente de "?n1 " es "(tan ?n1)crlf)
    (printout t "La cotangente de "?n1 " es "(cot ?n1)crlf)
    (printout t "La secante de "?n1 " es "(sec ?n1)crlf)
)

(deffunction funcionesStringsYSimbolos()
    (bind ?variable "HoLa")
    (printout t (lowcase ?variable)crlf)
    ;concatena y devuelve un string
    (printout t (str-cat ?variable 4)crlf)
    ;concatena y devuelve un simbolo
    (printout t (sym-cat funciones ?variable 1) crlf)
    (printout t (str-index "o" ?variable)crlf)
    (printout t (str-length ?variable)crlf)
    
)

;---------------REGLAS
;Cada regla representa un paso de la solucion del problema,se utilizan para representar las acciones
;del problema
;Una regla es un conjunto de condiciones junto con las operaciones a realizar si las condiciones se satisfacen

;Son como sentencias IF THEN

;----------------HECHOS
;Forma basica de representar la informacion

;para insertar un hecho
(assert ())
;para borrar un hecho
(retract identificador)
;(retract *) para borrar todos los hechos


;-------------------HECHOS INICIALES
;constructor deffacts permite especificar un conjunto de hechos como conocimineto inicial

;(deffacts <nombre-colección-hechos> [<comentario>] <patrón-RHS>*)
;
;
;con el comando reset se eliminan todos los hechos que hubiera en la lista de hechos actual
;a continuacion añade los hechos correspondientes a sentencias deffacts


;----------------REGLAS
;Permiten operar con los hechos
;Consta de un antecedente  TAMBIEN DENOMINADA PARTE SI O PARTE IZQUIERDA DE LA REGLA
;Consta de un consecuente TAMBIEN DENOMINADA PARTE ENTONCES O PARTE DERECHA DE LA REGLA 

;EL ANTECEDENTE esta formado por un conjunto de codiciones tambien llamadas elementos condicionales
;EL CONSECUENTE de una regla es un conjunto de acciones a ser ejecutadas cuando la regla es aplicable

(defrule regla-ejemplo
(frigorífico interruptor encendido)
(frigorífico puerta abierta)
(assert (frigorífico comida estropeada)))
