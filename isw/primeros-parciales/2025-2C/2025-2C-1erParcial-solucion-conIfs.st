!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa coordenanda modo tanque brazo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 12:20:55'!
areaDeAgarreConExtension: unaExtension

	^ Rectangle origin: coordenanda  corner: coordenanda  + unaExtension .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 13:44:57'!
capturarSobreAmbiente: unAmbiente
    | areaDeAgrarre especimenesEnElAreaDeAgarre |
	"Modo contigencia"
  modo = #Contingencia ifTrue: [
		areaDeAgrarre := self areaDeAgarreConExtension: 1@1.
		especimenesEnElAreaDeAgarre := self especimenesDentroDelAreaDeAgarre: areaDeAgrarre.
		especimenesEnElAreaDeAgarre do: [:unEspecimen | self caputurarUnEspecimen: unEspecimen ].
	].
	
    modo = #Normal ifTrue: [
        brazo = #BrazoAspirador ifTrue: [
            unAmbiente = #Fangoso ifTrue: [
                areaDeAgrarre := self areaDeAgarreConExtension: 3@3.
                especimenesEnElAreaDeAgarre := self especimenesDentroDelAreaDeAgarre: areaDeAgrarre.
                especimenesEnElAreaDeAgarre do: [:unEspecimen |
                    unEspecimen = #Perezoso ifTrue: [
                        self caputurarUnEspecimen: unEspecimen.
                    ].
                    unEspecimen = #Escurridizo ifTrue: [
                        | posicionDesplazadaEspecimen |
                        posicionDesplazadaEspecimen := (self posicionDe: unEspecimen) + (1@1).
                        (areaDeAgrarre containsPoint: posicionDesplazadaEspecimen)
                            ifTrue: [ self caputurarUnEspecimen: unEspecimen. ]
                            ifFalse: [ self nuevaPosicionEspecimen: unEspecimen es: posicionDesplazadaEspecimen. ].
                    ].
                ].
            ].
            unAmbiente = #Rocoso ifTrue: [
                areaDeAgrarre := self areaDeAgarreConExtension: 3@2.
                especimenesEnElAreaDeAgarre := self especimenesDentroDelAreaDeAgarre: areaDeAgrarre.
                especimenesEnElAreaDeAgarre do: [:unEspecimen |
                    unEspecimen = #Perezoso ifTrue: [
                        self caputurarUnEspecimen: unEspecimen.
                    ].
                    unEspecimen = #Escurridizo ifTrue: [
                        | nuevaPosicionEspecimen |
                        nuevaPosicionEspecimen := (self posicionDe: unEspecimen) + (0@1).
                        (areaDeAgrarre containsPoint: nuevaPosicionEspecimen)
                            ifTrue: [ self caputurarUnEspecimen: unEspecimen. ]
                            ifFalse: [ self nuevaPosicionEspecimen: unEspecimen es: nuevaPosicionEspecimen. ].
                    ].
                ].
            ].
        ].
        brazo = #BrazoRed ifTrue: [
            unAmbiente = #Fangoso ifTrue: [
                areaDeAgrarre := self areaDeAgarreConExtension: 3@1.
                especimenesEnElAreaDeAgarre := self especimenesDentroDelAreaDeAgarre: areaDeAgrarre.
                especimenesEnElAreaDeAgarre do: [:unEspecimen |
                    unEspecimen = #Perezoso ifTrue: [
                        "Si es perezoso con brazo de red en terreno fangoso se sumerge y evita ser atrapado"
                    ].
                    unEspecimen = #Escurridizo ifTrue: [
                        | nuevaPosicionEspecimen |
                        nuevaPosicionEspecimen := (self posicionDe: unEspecimen) + (-1@0).
                        (areaDeAgrarre containsPoint: nuevaPosicionEspecimen)
                            ifTrue: [ self caputurarUnEspecimen: unEspecimen. ]
                            ifFalse: [ self nuevaPosicionEspecimen: unEspecimen es: nuevaPosicionEspecimen. ].
                    ].
                ].
            ].
            unAmbiente = #Rocoso ifTrue: [   
			"Aqui la red se rompe"
			self brazoDañado .
            ].
        ].
    ].! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 12:17:22'!
caputurarUnEspecimen: unEspecimen

	mapa removeKey: unEspecimen .
	tanque add: unEspecimen .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 13:36:13'!
tanqueContieneA: unEspecimen

	^tanque includes: unEspecimen .! !


!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/28/2026 13:45:57'!
brazoDañado

	modo := #Contingencia.
	self error: self class brazoDañadoErrorMessage .! !

!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/28/2026 12:36:54'!
especimenesDentroDelAreaDeAgarre: unAreaAgarre
	"Primero filtramos los puntos en el area de agarre, luego tomamos los especimenes de esos puntos"
	^ (mapa select: [:unaPosicion | unAreaAgarre containsPoint: unaPosicion ]) collect: [:unaPoscion | 
			mapa keyAtValue: unaPoscion .
		]! !


!RoverMarino methodsFor: 'mapa' stamp: 'Ma 4/28/2026 12:50:08'!
nuevaPosicionEspecimen: unEspecimen es: unPosicion


	mapa at: unEspecimen put: unPosicion .! !

!RoverMarino methodsFor: 'mapa' stamp: 'Ma 4/28/2026 12:49:48'!
posicionDe: unEspecimen

	^mapa at: unEspecimen .! !


!RoverMarino methodsFor: 'initialization' stamp: 'Ma 4/28/2026 13:37:24'!
initializeConMapa: unMapa  yParadoSobre: unPunto conBrazo: unBrazo

	mapa := unMapa.
	coordenanda := unPunto .
	brazo := unBrazo.
	modo := #Normal.
	tanque := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'instance creation' stamp: 'Ma 4/28/2026 13:41:51'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto
	unMapa isEmpty ifTrue: [self error: self elMapaDebeTenerEspecimenesErrorMessage ].
	^self new initializeConMapa: unMapa  yParadoSobre: unPunto  conBrazo: #BrazoAspirador.! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'Ma 4/28/2026 13:37:24'!
roverConRedUtilizando: unMapa paradoSobre: unPunto 

	^self new initializeConMapa: unMapa yParadoSobre: unPunto conBrazo: #BrazoRed ! !


!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:53'!
brazoDañadoErrorMessage

	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:35'!
elMapaDebeTenerEspecimenesErrorMessage

	^ 'El mapa debe tener al menos un especimen para capturar'! !


!classDefinition: #CapturaSubmarinaTest category: #'2025-2C-1erParcial'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'Ma 4/27/2026 19:35:53'!
especimenEscurridizo

	^#Escurridizo! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'Ma 4/27/2026 19:36:03'!
especimenPerezoso

	^#Perezoso! !


!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:08'!
test01LasSimulacionesDebenTenerEspecimenesACapturar

	self should: [ self roverConAspiradorUtilizando: self mapaVacio paradoSobre: 0@0 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception | self assert: exception messageText = RoverMarino elMapaDebeTenerEspecimenesErrorMessage ]


! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:15'!
test02ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenPerezosoEnSuAreaDeAgarre

	|unRoverMaritimo unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMaritimo := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMaritimo.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMaritimo).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

	"   0 1 2 3 4
	0  x x x o o
	1  P x x o o
	2  x x x o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:19'!
test03ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenPerezosoFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o x x x o
	3  o x x x o
	4  o o o o o

	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:22'!
test04ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@3)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o x x x o o           0  o x x x o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o o o o o o          3  o o E o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:25'!
test05ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x x x o o          3  o x E x o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:28'!
test06ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 2@2)

	"   0 1 2 3 4 5
	0  x x x o o o
	1  x x x o o o
	2  o o P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:31'!
test07ElRoverUtilizandoBrazoAspiradorEnSueloRocosoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

      "   0 1 2 3 4 5
	0  o o o o o o
	1  x x x o o o
	2  x x P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:34'!
test08ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  x x x o o o           0  x x x o o o
	1  x x E o o o           1  x x x o o o
	2  o o o o o o   ->  2  o o E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:37'!
test09ElRoverUtilizandoBrazoApiradorEnSueloRocosoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

     "     0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  x x E o o o           1  x x x o o o
	2  x x x o o o   ->  2  x x E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:42'!
test10ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenPerezoso

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o o o o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:45'!
test11ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 1@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  o E x x x o   ->  2  E x x x x o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:49'!
test12ElRoverUtilizandoBrazoRedEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: (1@2).
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1  o o o o o o
	2  x E x x o o   ->  2  E x x x o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:52'!
test13ElRoverUtilizandoBrazoRedEnSueloRocosoNoCapturaNingunEspecimenYRompeLaRed

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage
	]

	"   0 1 2 3 4 5 6
	0  o o o o o o o
	1  o o o o o o o
	2  E P x x x x o
	3  o o o o o o o
	4  o o o o o	 o o
	"
! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:56'!
test14ElRoverCapturaTodosLosEspecimenesDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenEscurridizo:= self especimenEscurridizo.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2 y: otroEspecimenEscurridizo en: 2@2.

	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1   o o o o o o
	2  x E E x x x   ->  2  x x x o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:59'!
test15ElRoverCapturaTodosLosEspecimenesAunSiEstanEnLaMismaPosicion

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenPerezoso:= self especimenPerezoso.

	unMapa := self mapaCon:  unEspecimenEscurridizo en: 1@2 y: otroEspecimenPerezoso en: 2@3.

	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenPerezoso)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x P x o o          3  o x x x o o
	4  o o o o o o          4  o o o o o o
	"

	! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:01:02'!
test16ElRoverUtilizandoBrazoRedEnSueloRocosoSeRompeYCambiaAModoContingencia

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage .
	].

	 "  0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  E P x x x x   ->  2  x P x x x x
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"

	"Se hacen las capturas en modo contingencia"

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2)
! !


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'Ma 4/28/2026 12:12:41'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente

	unRover capturarSobreAmbiente: unAmbiente .

! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'Ma 4/28/2026 13:30:55'!
mapaCon: unEspecimen en: unaPosicion

	|mapa|
	mapa := self mapaVacio .
	
	mapa  at: unEspecimen put: unaPosicion .
	^mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'Ma 4/27/2026 19:51:45'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion

	
	|mapa|
	mapa := self mapaVacio .
	mapa at: unEspecimen put: unaPosicion .
	mapa at: otroEspecimen put: otraPosicion .
	^mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'Ma 4/27/2026 19:37:16'!
mapaVacio

	^ Dictionary new.! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'Ma 4/27/2026 19:47:58'!
mapa: unMapa contiene: unEspecimen

	^ unMapa keys  includes: unEspecimen .! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'Ma 4/27/2026 19:48:45'!
mapa: unMapa contiene: unEspecimen en: unPunto

	^ (unMapa at: unEspecimen ) = unPunto .! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'Ma 4/28/2026 13:38:24'!
verificarCapturaDeEspecimen: unEspecimen por: unRover

	^unRover tanqueContieneA: unEspecimen .! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'Ma 4/28/2026 12:06:32'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto
	
	^ RoverMarino roverConAspiradorUtilizando: unMapa paradoSobre: unPunto .! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'Ma 4/28/2026 12:10:21'!
roverConRedUtilizando: unMapa paradoSobre: unPunto

	^RoverMarino roverConRedUtilizando: unMapa paradoSobre: unPunto .! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'Ma 4/28/2026 12:48:05'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: #Fangoso! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'Ma 4/28/2026 12:47:44'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: #Rocoso ! !
