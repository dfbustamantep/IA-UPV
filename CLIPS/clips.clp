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

;ELEMENTOS CONDICIONALES 
;or Cuando la menos uno de los elementos que aparece se satisfacen
;and CLIPS supone que todas las reglas tienen un and implicito 
;←  

;-----HECHOS
;Existen 2 tipos de hechos ordenasdos y no ordenados

;En los hechos ordenados importa el orden de los elementos 
;En los hechos no ordenados cada campo tiene su nombre y valor
;Para los hechos no ordenados se necesita tener una plantilla por medio de deftemplate
(deftemplate datos-persona ;nombre de la plantilla
    (multislot nombre);puede tener varios valores
    (multislot apellido)
    (slot edad);solo tendra un valor
    (slot peso)
    (slot altura)
    (multislot presion-arterial)
)
(list-deftemplates);listamos el nombre de las plantilla ya definidas
(ppdeftemplate nombrePlantilla);muestra el contenido de la plantilla
(undeftemplate nombrePlantilla);elimina la definicion siempre que no hayan hechos en la base de datos que sigan esta plantilla

;ejemplo de como usar hechos desordenados por medio de una plantilla
;(assert(datos-persona(nombre Samuel)(edad 20)(peso 80)(altura 188)(presion-arterial 80 130)))

;se puede definir el nombre,el tipo,los valores por defecto y el rango de los slots o multislots
;Datos posibles SYMBOL, STRING, LEXEME, NUMBER, INTEGER y FLOAT
;para definir el tipo de dato se usa type

;LEXEME equivale a especificar SYMBOL y STRING conjuntamente
;NUMBER equivale a especificar INTEGER y FLOAT
;?VARIABLE cualquier tipo de dato

;allowed especifica los valores concretos permitidos
;(allowed-values ?VARIABLE) cualquier valor es legal

(deftemplate persona
    (multislot nombre(type SYMBOL))
    (slot edad(type INTEGER))
    (slot altura(type SYMBOL)(allowed-symbols alto bajo))

)
;(assert(persona(nombre Daniel Felipe)(edad 19)(altura alto)))
;range permite restringir los valores de un tipo numerico a un rango determinado a un valor numerico o ?VAIRABLE (infinito)
;(range ?VARIABLE 3) desde menos infinito hasta 3
;(range 14 ?VARIABLE) desde 14 hasta inifinito
;(range ?VARIABLE ?VARIABLE) desde menos infinito hasta infinito

(deftemplate Personas1
    (multislot nombre(type SYMBOL))
    (slot edad(type INTEGER)(range 0 125))
)

;(assert(Personas1(nombre Daniel Felipe)(edad 19)))
;cardinality permite especificar numero minimo y maximo de valores que un multislot puede contener ambos limites pueden ser un valor entero positivo o ?VARIABLE,por defecto simepre son ?VARIABLE ambos lados

(deftemplate equipo-voleibol
    (slot nombre-equipo (type STRING))
    (multislot jugadores (type STRING)(cardinality 6 6));debe tener 6 o 6 jugadores
    (multislot sustitutos (type STRING)(cardinality 0 2));puede haber 0 a 2 sustitutos
)

;defualt permite especificar un valor por defecto (defualt especificacion)
;la especificacion puede ser ?DERIVE ?NONE o una expresion(valor)

;(?DERIVE) se deriva un valor para el slot que satisfaga todos los atributos del slot 
;para string "" para integer 0 para symbol nil para float 0.0

(deftemplate datos-persona
    (slot nombre (type STRING) (default ?DERIVE))
    (slot apellido (type STRING) (default ?NONE))
    (slot edad (type FLOAT) (default (* 2.0 3.5)) (range 0.0 120.0)) 
)

(deftemplate ejemplo
    (slot a);por defecto symbol
    (slot b(type INTEGER));el valor por defecto de INTEGER es 0
    (slot c(allowed-values rojo verde azul));el valor por defecto sera el primero
    (multislot d);el valor por defecto sera ()
    (multislot e(cardinality 2 2)(type FLOAT)(range 3.5 10.0));el valor por defecto sera el minimo
)

;usamos el default
(deftemplate ejemplo
(slot a (default 3))
(slot b (default (+ 3 4)))
(multislot c (default a b e))
(multislot d (default (+ 1 2) (+ 3 4)))
)

(deftemplate estudiante
    (multislot nombre)
    (slot fuma(allowed-values si no))
    (slot alojado (allowed-values si no)(default no))
)

(deffacts estudiantes "Todos los estudiantes iniciales"
    (estudiante(nombre Juan)(fuma no)(alojado no))
    (estudiante(nombre Pepe)(fuma si)(alojado no))
    (estudiante(nombre Luisa)(fuma no)(alojado no))
    (estudiante(nombre Pedro)(fuma no)(alojado no))
)

;HECHOS operaciones
;Para insertar hechos (assert hecho)
;(duplicate <especificador hecho><slot>)
;Borrar hechos (retract <especificador hecho>) 
;   tambien podemos usar * para eliminat todos los hechos
;modificar elementos (modify <especificador hecho><slot>*)

;<especificador hecho> puede ser:
;una variable previamente ligada a la direccion del hecho a duplicar,borrar o modificar
;un indice de un hecho

;REGLAS
;permiten operar con los hechos
;Consta de un antecedente tambien llamado parte si o parte izquierda (LHS)
;Consta de un consecuente tambien llamado parte entonces o parte derecha (RHS)

;el antecedete esta formado por un conjunto de condiciones tambien lladas elementos condicionales (EC) que deben satisfacerse para que la regla sea aplicable
;el consecuente de una regla es un conjunto de acciones a ser ejecutadas cuando la regla es aplicable


;COMODINES
;los comodines permiten que encaje cualquier valor sin atraparlo
;? para un solo campo
;$? para un multicampo

;TIPOS DE ELEMENTOS CONDICIONALES (LHS)
;pattern 
;se puedene espefcificar restricciones al comparar un patron 
;           ORDEN DE PRIORIDAD
;           Negacion ~
;           Disyuncion |
;           Conjuncion &
;Con predicados o llamada a funciones deben ir precedidosdel signo :
;       (habitacion(capacidad ?c)(plazas-libres ?p & :(> ?c ?p)))
;       (datos $?x & :(>(lengh$ $?x)2))

;Predicados
;de tipo todos terminan en p numberp,floatp,symbolp
;comparaciones numericas =,<>,<,<=,>,>=
;igualdad(desigualdad) en tipo y valor eq (neq)
;predicados definidos por el usuario

;test se usa para evaluar expresiones en la parte izquierda de una regla,el elemento condicional test se satisface si la llamada a la funcion qe aparezca dentro de el devuelve cualquier valor distinto de false

;or este EC se satisface cuando al menos uno de los componentes que aparece se satisface

;and todas las reglas tienen un and implicito que rodea todos los elementos condicionales de la LHS

;not un elemento condicional negativo se satisface si no existe ninguna entidad que cumpla las restricciones expresadas

;exists este EC permite que se produzca el pattern matching cuando al menos exista un hecho que satisfaga la regla

;forall su funcionamiento es el contrario que el exists

;← 
(deftemplate estudiantes
    (multislot nombre)
    (slot sexo)
    (slot fuma(allowed-values si no))
    (slot alojado (allowed-values si no)(default no))
)

(deffacts estudiantes1 "Todos los estudiantes iniciales"
 (estudiantes (nombre Juan)(sexo varon)(fuma no)(alojado no))
 (estudiantes (nombre Pepe)(sexo varon)(fuma no)(alojado no))
 (estudiantes (nombre Luisa)(sexo mujer)(fuma no)(alojado no))
 (estudiantes (nombre Pedro)(sexo varon)(fuma no)(alojado no))
 )

 (defrule pepe1
 ?x <-(estudiantes (nombre Pepe)(sexo varon)(fuma no)(alojado no))
 =>
 (printout t "se ha alojado pepe?" crlf)
 (bind ?aux (read))
 (modify ?x (alojado ?aux))
 )

 (defrule pepe2
 ?x <-(estudiantes (nombre Pepe)(sexo ?)(fuma no)(alojado ?))
 =>
 (printout t "se ha alojado pepe?" crlf)
 (bind ?aux (read))
 (modify ?x (alojado ?aux))
 )
 