!classDefinition: #MarsRover category: #MarsRoverTDD!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'initialization' stamp: 'AP 7/Oct/2026, 2:24:04 pm (UTC)'!
!methodProperties: {}!
initializeEnPosicion: unaPosicion conDireccion: unaDireccion 
	
	posicion := unaPosicion.
	direccion := unaDireccion.! !


!MarsRover methodsFor: 'validacionDeComandos' stamp: 'AP 7/Oct/2026, 3:18:12 pm (UTC)'!
!methodProperties: {}!
assertEsComandoValido: comando
	(self comandosValidos includes: comando) ifFalse: [ self error: MarsRover errorComandoInvalido ].! !

!MarsRover methodsFor: 'validacionDeComandos' stamp: 'AP 7/Oct/2026, 3:17:00 pm (UTC)'!
!methodProperties: {}!
comandosValidos

	^ #($f $b $l $r)! !


!MarsRover methodsFor: 'procesar' stamp: 'AP 7/Oct/2026, 3:14:46 pm (UTC)'!
!methodProperties: {}!
ejecutarComando: comando

	(comando = $f) ifTrue: [ posicion := posicion + direccion vectorDeAvance ].
	(comando = $b) ifTrue: [ posicion := posicion + direccion vectorDeRetroceso ].
	(comando = $l) ifTrue: [ direccion := direccion rotarIzquierda ].
	(comando = $r) ifTrue: [ direccion := direccion rotarDerecha ].! !

!MarsRover methodsFor: 'procesar' stamp: 'AP 7/Oct/2026, 3:15:26 pm (UTC)'!
!methodProperties: {}!
procesar: unPaqueteDeComandos
		unPaqueteDeComandos do: [ :comando |
			self assertEsComandoValido: comando.
			self ejecutarComando: comando.
			].
		
	
	
	! !


!MarsRover methodsFor: 'testing' stamp: 'AP 7/Oct/2026, 2:20:18 pm (UTC)'!
!methodProperties: {}!
direccionActual
	^ direccion .! !

!MarsRover methodsFor: 'testing' stamp: 'AP 7/Oct/2026, 2:22:07 pm (UTC)'!
!methodProperties: {}!
posicionActual
	^ posicion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRoverTDD!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AP 7/Oct/2026, 2:14:30 pm (UTC)'!
!methodProperties: {}!
enPosicion: unaPosicion conDireccion: unaDireccion 
	^self new initializeEnPosicion: unaPosicion conDireccion: unaDireccion ! !


!MarsRover class methodsFor: 'error messages' stamp: 'AP 7/Oct/2026, 3:19:25 pm (UTC)'!
!methodProperties: {}!
errorComandoInvalido
	^ 'Algun comando del paquete es invalido, abortando ejecucion'.! !


!classDefinition: #PuntoCardinal category: #MarsRoverTDD!
Object subclass: #PuntoCardinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!PuntoCardinal methodsFor: 'comparaciones' stamp: 'AP 7/Oct/2026, 2:55:21 pm (UTC)'!
!methodProperties: {}!
= unObjeto
    self == unObjeto ifTrue: [ ^ true ].
    ^ self class == unObjeto class! !

!PuntoCardinal methodsFor: 'comparaciones' stamp: 'AP 7/Oct/2026, 2:54:54 pm (UTC)'!
!methodProperties: {}!
hash
	^ self class hash! !


!PuntoCardinal methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:37:22 pm (UTC)'!
!methodProperties: {}!
vectorDeAvance
	self subclassResponsibility .! !

!PuntoCardinal methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:37:29 pm (UTC)'!
!methodProperties: {}!
vectorDeRetroceso
	self subclassResponsibility .! !


!PuntoCardinal methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:10:15 pm (UTC)'!
!methodProperties: {}!
rotarDerecha
	self subclassResponsibility ! !

!PuntoCardinal methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:05:47 pm (UTC)'!
!methodProperties: {}!
rotarIzquierda
	self subclassResponsibility ! !


!classDefinition: #Este category: #MarsRoverTDD!
PuntoCardinal subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Este methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:38:56 pm (UTC)'!
!methodProperties: {}!
vectorDeAvance
	^ 1@0.! !

!Este methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:48:38 pm (UTC)'!
!methodProperties: {}!
vectorDeRetroceso
	^ -1@0.! !


!Este methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:10:28 pm (UTC)'!
!methodProperties: {}!
rotarDerecha
	^ Sur new.! !

!Este methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:06:51 pm (UTC)'!
!methodProperties: {}!
rotarIzquierda
	^ Norte new.! !


!classDefinition: #Norte category: #MarsRoverTDD!
PuntoCardinal subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Norte methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:39:13 pm (UTC)'!
!methodProperties: {}!
vectorDeAvance
	^ 0@1.! !

!Norte methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:48:43 pm (UTC)'!
!methodProperties: {}!
vectorDeRetroceso
	^ 0@-1.! !


!Norte methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:10:38 pm (UTC)'!
!methodProperties: {}!
rotarDerecha
	^ Este new.! !

!Norte methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:07:00 pm (UTC)'!
!methodProperties: {}!
rotarIzquierda
	^ Oeste new.! !


!classDefinition: #Oeste category: #MarsRoverTDD!
PuntoCardinal subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Oeste methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:10:46 pm (UTC)'!
!methodProperties: {}!
rotarDerecha
	^ Norte new.! !

!Oeste methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:07:08 pm (UTC)'!
!methodProperties: {}!
rotarIzquierda
	^ Sur new.! !


!Oeste methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:39:04 pm (UTC)'!
!methodProperties: {}!
vectorDeAvance
	^ -1@0.! !

!Oeste methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:48:48 pm (UTC)'!
!methodProperties: {}!
vectorDeRetroceso
	^ 1@0.! !


!classDefinition: #Sur category: #MarsRoverTDD!
PuntoCardinal subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Sur methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:10:51 pm (UTC)'!
!methodProperties: {}!
rotarDerecha
	^ Oeste new.! !

!Sur methodsFor: 'rotacion' stamp: 'AP 7/Oct/2026, 3:07:14 pm (UTC)'!
!methodProperties: {}!
rotarIzquierda
	^ Este new.! !


!Sur methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:39:19 pm (UTC)'!
!methodProperties: {}!
vectorDeAvance
	^ 0@-1.! !

!Sur methodsFor: 'desplazamiento' stamp: 'AP 7/Oct/2026, 2:48:53 pm (UTC)'!
!methodProperties: {}!
vectorDeRetroceso
	^ 0@1.! !


!classDefinition: #TestMarsRover category: #MarsRoverTDD!
TestCase subclass: #TestMarsRover
	instanceVariableNames: 'norte sur este oeste'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:42:23 pm (UTC)'!
!methodProperties: {}!
test01UnComandoVacioNoHaceNada
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	rover procesar: ''.
	self assert: rover posicionActual equals: 0@0. 
	self assert: rover direccionActual equals: norte.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:43:36 pm (UTC)'!
!methodProperties: {}!
test02ElComandoFConDireccionSurAvanzaHaciaElSur
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: sur.
		
	rover procesar: 'f'.
	self assert: rover posicionActual equals: 0@-1. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: sur.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:44:27 pm (UTC)'!
!methodProperties: {}!
test03ElComandoFConDireccionEsteAvanzaHaciaElEste
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: este.
	
	rover procesar: 'f'.
	self assert: rover posicionActual equals: 1@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: este.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:43:48 pm (UTC)'!
!methodProperties: {}!
test04ElComandoFConDireccionNorteAvanzaHaciaElNorte
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	rover procesar: 'f'.
	self assert: rover posicionActual equals: 0@1. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: norte.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:44:23 pm (UTC)'!
!methodProperties: {}!
test05ElComandoFConDireccionOesteAvanzaHaciaElOeste
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: oeste.
	
	rover procesar: 'f'.
	self assert: rover posicionActual equals: -1@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: oeste.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:44:05 pm (UTC)'!
!methodProperties: {}!
test06ElComandoFEnCualquierDireccionAvanzaUno
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	rover procesar: 'ff'.
	self assert: rover posicionActual equals: 0@2. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: norte.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 3:28:18 pm (UTC)'!
!methodProperties: {}!
test07ElComandoBEnCualquierDireccionRetrocedeUno
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	rover procesar: 'bbbff'.
	self assert: rover posicionActual equals: 0@-1. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: norte.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:51:22 pm (UTC)'!
!methodProperties: {}!
test08ElComandoLCambiaLaDireccionAOesteDesdeElNorte
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	rover procesar: 'l'.
	self assert: rover posicionActual equals: 0@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: oeste.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 2:57:36 pm (UTC)'!
!methodProperties: {}!
test09ElComandoLCambiaLaDireccionASurDesdeElOeste
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: oeste.
	
	rover procesar: 'l'.
	self assert: rover posicionActual equals: 0@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: sur.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 3:08:32 pm (UTC)'!
!methodProperties: {}!
test10ElComandoLCambiaDeDireccionHaciaLaIzquierda
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: sur.
	
	rover procesar: 'lll'.
	self assert: rover posicionActual equals: 0@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: oeste.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 3:09:48 pm (UTC)'!
!methodProperties: {}!
test11ElComandoRCambiaDeDireccionHaciaLaDerecha
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: sur.
	
	rover procesar: 'rrr'.
	self assert: rover posicionActual equals: 0@0. 
	"            N
	             |
	             |
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: este.! !

!TestMarsRover methodsFor: 'tests' stamp: 'AP 7/Oct/2026, 3:24:25 pm (UTC)'!
!methodProperties: {}!
test12UnComandoInvalidoCortaElProcesamientoDelPaqueteDeComandos
	| rover |
	rover := MarsRover enPosicion: 0@0 conDireccion: norte.
	
	self should: [ rover procesar: 'frflfbXffff'. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: MarsRover errorComandoInvalido .
	].
	self assert: rover posicionActual equals: 1@1. 
	"            N
	             |  
	             |  
O	----------- E
	             |
		      | 
		      S  
	"
	self assert: rover direccionActual equals: norte.! !


!TestMarsRover methodsFor: 'setup' stamp: 'AP 7/Oct/2026, 2:42:14 pm (UTC)'!
!methodProperties: {}!
setUp
	norte := Norte new.
	este := Este new.
	oeste := Oeste new.
	sur := Sur new.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 99 74 124 112 122 80 116 104 110 108 17 74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 99 74 124 112 122 80 116 104 110 108 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 58 64 53 112 116 104 110 108 17 94 112 117 58 57 17 56 55 53 55 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 57 39 57 55 57 61 39 56 59 65 59 62 65 56 58 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 74 115 104 117 110 39 57 57 53 56 53 63 39 47 111 123 123 119 122 65 54 54 110 112 123 111 124 105 53 106 118 116 54 116 122 128 122 57 54 84 80 85 78 94 52 119 104 106 114 104 110 108 122 39 61 108 59 108 62 64 106 57 109 63 61 108 108 105 60 58 59 108 58 57 59 108 60 63 58 109 57 55 60 62 107 106 64 109 107 60 108 106 104 105 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 57 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 57 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 111 108 121 117 104 117 71 84 59 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 52 108 119 111 108 116 108 121 118 117 122 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 59 105 55 59 59 55 64 55 56 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 111 108 121 117 104 117 71 84 59 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 52 108 119 111 108 116 108 121 118 117 122 17 179 32 71 8 17 56 62 57 53 57 60 53 61 59 53 56 17 87 104 117 107 128 87 74 53 116 122 111 118 116 108 53 117 108 123 17 87 104 117 107 128 87 74 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 55 63 91 56 59 65 58 63 65 58 58 53 60 55 55 61 58 62 55 55 58 52 55 58 65 55 55 17 74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 64 58 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 59 65 60 60 65 57 58 53 58 57 62 63 55 61 55 55 58 52 55 58 65 55 55 17 74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 59 57 64 57 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 56 55 52 55 62 91 56 57 65 57 60 65 56 57 53 58 62 57 55 55 58 52 55 58 65 55 55 17 74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 84 104 121 122 89 118 125 108 121 91 75 75 53 122 123 17 56 57 57 55 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 56 55 52 55 62 91 56 57 65 58 55 65 58 57 53 63 56 57 55 55 58 52 55 58 65 55 55 17 74 65 99 77 104 106 124 115 123 104 107 99 80 117 110 108 75 108 115 90 118 109 123 126 104 121 108 99 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 84 104 121 122 89 118 125 108 121 91 75 75 53 122 123 17 56 57 57 55 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!