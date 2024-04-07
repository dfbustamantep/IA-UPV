;BASICO

;(bind) para guardar en una variable

;variable simple ?var1
;guardar en variable simple
(bind ?var1 5)

;variable multicampo   LISTA
(bind $?var2 2 hola 4.5)
(bind $?var3 (create$ otra 3 manera de 4 crear 5 variables multicampo))

;variables globales se delimitan entre **
(defglobal ?*varG* = 7)
(defglobal ?*varG2* = (create$ variable 3 multicampo global))

(clear);equivale a cerrar clips

;Entrada y salida
;Funcion (read) permite leer la informacion proporcionada
(bind $?var4 (read))

;(readline) lee toda la linea y se guarda en un string  
(bind $?var5 (readline))

;Convertir el string que se lee en un conjunto de simbolos variable multicampo
(bind $?var6 (explode$(readline)))

;Imprimir por pantalla
;crlf salto de linea
(printout t "Impresion por pantalla" crlf)

;Estructuras de control
(if (= 5 5) then
    (printout t "Son iguales" crlf)
    else
    (printout t "Son diferentes" crlf)
)

;bucles
(loop-for-count 2
    (printout t "Hola mundo" crlf)
)

(loop-for-count (?i 0 2)
    (loop-for-count (?j 1 3)
        (printout t "variable i " ?i " variable j "?j crlf)
    )
)

(foreach ?a(create$ 1 2 3 a)
    (printout t ?a)
)
;bucle while,funciona si se crea una funcion
(bind ?v 4)
(while (> ?v 0)
    (printout t "v es " ?v crlf)
    (bind ?v (- ?v 1))
)

;funciones de variables multicampo
;PROGN funciona si se crea una funcion
(progn$ (?var(create$ abc def ghi))
    (printout t "-->"?var"<--"crlf)
)


;SWITCH CASE
(deffunction switchCase(?var)
;(bind ?var )
(switch ?var
    (case 1 then
        (printout t "variable = 1 "crlf)
    )
    (case 2 then
        (printout t "variable = 2 "crlf)
    )
    (default
        (printout t "Variable diferente a 1 y a 2"crlf)
    )
))

;OPERADORES 
;OPERADORES LOGICOS
(deffunction operadorAnd()
    ;asiganmos el valor de un numero 
    (bind ?numeroSistema 3)
    ;leermos por consola un numero dado por el usuario
    (bind ?numeroUsuario (read))
    ;si ambos numeros son = a 3
    (if (and(= ?numeroSistema 3)(= ?numeroUsuario 3))then
         (printout t "Los numeros son iguales,tienen valor de 3" crlf)
    )

)

(deffunction operadorOR()
    ;asiganmos el valor de un numero 
    (bind ?numeroSistema 4)
    ;leemos por consola un numero dado por el usuario
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

;HECHOS
;para insertar un hecho
(assert (tiempo llueve))
;para eliminar un hecho usamos su identificador o * paraeliminar todos los hechos
(retract 1)

;para ver la lista de hechos
(facts)

;para listar los hechos a partir de un identificador
(facts 1);1 puede ser cualquier identificador

;para listar los hechos en un rango
 (facts <idmin> <idmax>)


(reset)
;insertamos hechos
(assert(bola azul))
(assert(bola roja))
;borramos el primero
(retract 1)

;DEFFFACTS
;definimos hechos como conocimineto inicial

(deffacts arranque "Estado inicial del frigorífico"
(frigorífico interruptor encendido)
(frigorífico puerta abierta)
) 

(reset)

;REGLAS
(defrule ejemplo
(frigorífico interruptor encendido)
(frigorífico puerta abierta)
=>
(assert (frigorífico comida estropeada)))

;para mostrar el contenido de una regla
(ppdefrule r1)

;para borrar una regla y para borrar todas en vez del nombre usamos *
(undefrule <nombre-regla>)

(clear)

(assert (tiempo llueve))

(defrule playa
(tiempo sol)
=>
(assert(coger chanclas))
)

(defrule paraguas
(or (tiempo llueve)(tiempo nieve))
=>
(printout t "Coger paraguas "crlf)
)


(assert (color rojo))

(defrule cielo
(color azul)
=>
(assert (cielo-es despejado))
)

(assert (color azul))