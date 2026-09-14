!classDefinition: #Ambiente category: #'2025-2C-1erParcial'!
Object subclass: #Ambiente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Ambiente methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:49:33 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreBase 
	
	self subclassResponsibility .! !

!Ambiente methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:28:59 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreBase 
	self subclassResponsibility .! !

!Ambiente methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:49:56 pm (UTC)'!
siendoNavegadoPor: aRoverMarino reduciendoAreaDeAgarreEn: reduccion con: areaDeAgarreBase utilizando: unBloqueDeCaptura  
	
	| areaDeAgarreEfectiva especimenesEnAreaAgarre |
	areaDeAgarreEfectiva := aRoverMarino reducir: areaDeAgarreBase en: reduccion.
	
	especimenesEnAreaAgarre := aRoverMarino especimenesDentroDe: areaDeAgarreEfectiva .
	
	especimenesEnAreaAgarre do: [:unEspecimen |
			unBloqueDeCaptura value: unEspecimen value: areaDeAgarreEfectiva .
			].! !


!classDefinition: #Fangoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Fangoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Fangoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:44:48 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreBase 
	
	"Sabemos el modo, tipo de brazo y ambiente"
	"Como estamos en ambiente fangoso con brazo aspirador no reducimos el area"
	
	self siendoNavegadoPor: aRoverMarino reduciendoAreaDeAgarreEn: 0@0 con: areaDeAgarreBase utilizando: [:unEspecimen :areaDeAgarreEfectiva |
			unEspecimen siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva .
		].! !

!Fangoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:40:32 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreBase 
	"En ambiente fangoso con red el area se reduce a la mitad"

	self siendoNavegadoPor: aRoverMarino reduciendoAreaDeAgarreEn: 3@0 con: areaDeAgarreBase utilizando: [:unEspecimen :areaDeAgarreEfectiva |
			unEspecimen siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreEfectiva .
		].
	! !


!classDefinition: #Rocoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Rocoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Rocoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:41:08 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreBase

	"Se reduce el area de agarre en una fila"
	
	self siendoNavegadoPor: aRoverMarino reduciendoAreaDeAgarreEn: 0@1 con: areaDeAgarreBase utilizando: [:unEspecimen :areaDeAgarreEfectiva |
			unEspecimen siendoPerseguidoSobreUnAmbienteRocosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva .
		]
	! !

!Rocoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:29:44 pm (UTC)'!
siendoNavegadoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreBase 


	aRoverMarino brazoDañado .! !


!classDefinition: #BrazoRover category: #'2025-2C-1erParcial'!
Object subclass: #BrazoRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRover methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:09:54 pm (UTC)'!
siendoUtilizadoPor: aRoverMarino sobre: unAmbiente 
	
	self subclassResponsibility .! !


!BrazoRover methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 7:11:05 pm (UTC)'!
extensionBase
	self subclassResponsibility ! !


!classDefinition: #Aspirador category: #'2025-2C-1erParcial'!
BrazoRover subclass: #Aspirador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Aspirador methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:14:16 pm (UTC)'!
siendoUtilizadoPor: aRoverMarino sobre: unAmbiente 
	
	unAmbiente siendoNavegadoPor: aRoverMarino equipadoConBrazoAspiradorCon: (aRoverMarino areaDeAgarreConExtension: self extensionBase) . ! !


!Aspirador methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 7:11:12 pm (UTC)'!
extensionBase
	^3@3.! !


!classDefinition: #Red category: #'2025-2C-1erParcial'!
BrazoRover subclass: #Red
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Red methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:22:58 pm (UTC)'!
siendoUtilizadoPor: aRoverMarino sobre: unAmbiente 
	
	unAmbiente siendoNavegadoPor: aRoverMarino equipadoConBrazoRedCon: (aRoverMarino areaDeAgarreConExtension: self extensionBase) . ! !


!Red methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 7:23:16 pm (UTC)'!
extensionBase
	
	^6@1.! !


!classDefinition: #Especimen category: #'2025-2C-1erParcial'!
Object subclass: #Especimen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Especimen methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:56:51 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarre 
	
	self subclassResponsibility .! !

!Especimen methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 8:00:41 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreEfectiva 
	self subclassResponsibility .! !

!Especimen methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:50:53 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteRocosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva 
	self subclassResponsibility .! !



!classDefinition: #Escurridizo category: #'2025-2C-1erParcial'!
Especimen subclass: #Escurridizo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Escurridizo methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:51:35 pm (UTC)'!
intentarEscaparDesplazandoseEn: unDelta dentroDe: areaDeAgarreEfectiva del: aRoverMarino

	| nuevaPosicionDelEspecimen |
	nuevaPosicionDelEspecimen := (aRoverMarino posicionDe: self) + unDelta .
	
	(areaDeAgarreEfectiva containsPoint: nuevaPosicionDelEspecimen ) ifTrue: [
		aRoverMarino capturarA: self.
	] ifFalse: [
		aRoverMarino actualizarPosicionDe: self a: nuevaPosicionDelEspecimen .
	].! !

!Escurridizo methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:52:25 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva 
		
	self intentarEscaparDesplazandoseEn: 1@1 dentroDe: areaDeAgarreEfectiva del: aRoverMarino .
! !

!Escurridizo methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:52:48 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreEfectiva 

	self intentarEscaparDesplazandoseEn: -1@0 dentroDe: areaDeAgarreEfectiva del: aRoverMarino .! !

!Escurridizo methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 9:53:16 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteRocosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva 
	
	self intentarEscaparDesplazandoseEn: 0@1 dentroDe: areaDeAgarreEfectiva  del: aRoverMarino .
! !


!classDefinition: #Perezoso category: #'2025-2C-1erParcial'!
Especimen subclass: #Perezoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Perezoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:57:18 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarre 
	
	aRoverMarino capturarA: self.! !

!Perezoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 8:02:34 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteFangosoPor: aRoverMarino equipadoConBrazoRedCon: areaDeAgarreEfectiva 
	! !

!Perezoso methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:59:23 pm (UTC)'!
siendoPerseguidoSobreUnAmbienteRocosoPor: aRoverMarino equipadoConBrazoAspiradorCon: areaDeAgarreEfectiva 
	
	aRoverMarino capturarA: self.! !


!classDefinition: #EstadoRover category: #'2025-2C-1erParcial'!
Object subclass: #EstadoRover
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!EstadoRover methodsFor: 'initialization' stamp: 'HAW 12/Sep/2026, 6:36:56 pm (UTC)'!
initializePara: unRoverMarino 

	rover := unRoverMarino.! !


!EstadoRover methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:37:54 pm (UTC)'!
simularCapturaSobre: unAmbiente 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoRover class' category: #'2025-2C-1erParcial'!
EstadoRover class
	instanceVariableNames: ''!

!EstadoRover class methodsFor: 'instance creation' stamp: 'HAW 12/Sep/2026, 6:36:36 pm (UTC)'!
para: unRoverMarino 

	^self new initializePara: unRoverMarino ! !


!classDefinition: #Contingencia category: #'2025-2C-1erParcial'!
EstadoRover subclass: #Contingencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Contingencia methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:49:18 pm (UTC)'!
simularCapturaSobre: unAmbiente 

	rover simularCapturaEnModoContingenciaSobre: unAmbiente ! !


!classDefinition: #Normal category: #'2025-2C-1erParcial'!
EstadoRover subclass: #Normal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Normal methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:38:46 pm (UTC)'!
simularCapturaSobre: unAmbiente 
	
	rover simularCapturaEnModoNormalSobre: unAmbiente .! !


!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa posicion brazo biobox modo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!RoverMarino methodsFor: 'initializartion' stamp: 'HAW 12/Sep/2026, 6:38:26 pm (UTC)'!
initializeUtilizando: unMapa paradoSobre: unPunto equipadoCon: unBrazo 
	
	modo := Normal para: self.
	mapa := unMapa.
	posicion := unPunto.
	brazo := unBrazo.	
	biobox := OrderedCollection new.! !


!RoverMarino methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:47:44 pm (UTC)'!
capturarA: unEspecimen 
	
	biobox add: unEspecimen .
	mapa removeKey: unEspecimen .! !

!RoverMarino methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:43:01 pm (UTC)'!
capturoA: unEspecimen 
	
	^ biobox includes: unEspecimen .! !

!RoverMarino methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 7:02:01 pm (UTC)'!
simularCapturaEnModoContingenciaSobre: unAmbiente 
	
	| areaDeAgarre especimenesEnAreaAgarre |
	areaDeAgarre := self areaDeAgarreConExtension: 1@1.
	especimenesEnAreaAgarre := self especimenesDentroDe: areaDeAgarre .
	
	especimenesEnAreaAgarre do: [:unEspecimen | 
			self capturarA: unEspecimen .
		]
	! !

!RoverMarino methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 8:03:55 pm (UTC)'!
simularCapturaEnModoNormalSobre: unAmbiente 
	
	"Ahora requerimos saber el tipo de brazo"
	
	brazo siendoUtilizadoPor: self sobre: unAmbiente .
	! !

!RoverMarino methodsFor: 'captura' stamp: 'HAW 12/Sep/2026, 6:37:40 pm (UTC)'!
simularCapturaSobre: unAmbiente 
	"Como simulamos la captura depende del modo"
	modo simularCapturaSobre: unAmbiente .! !


!RoverMarino methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 6:44:00 pm (UTC)'!
areaDeAgarreConExtension: unDelta

	^ Rectangle origin: posicion  corner: posicion + unDelta .! !

!RoverMarino methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 6:42:28 pm (UTC)'!
especimenesDentroDe: areaDeAgarre 
	
	^ (mapa select: [:unaPosicion | (areaDeAgarre containsPoint: unaPosicion )]) collect: [:unaPosicion | mapa keyAtValue: unaPosicion ].! !

!RoverMarino methodsFor: 'area agarre' stamp: 'HAW 12/Sep/2026, 6:54:46 pm (UTC)'!
reducir: areaDeAgarre en: unDelta 
	^ areaDeAgarre extendBy: 0@0 - unDelta .! !


!RoverMarino methodsFor: 'error handling' stamp: 'HAW 12/Sep/2026, 7:01:04 pm (UTC)'!
brazoDañado
	
	modo := Contingencia para: self.
	
	self error: self class brazoDañadoErrorMessage .! !


!RoverMarino methodsFor: 'posicion' stamp: 'HAW 12/Sep/2026, 6:48:37 pm (UTC)'!
actualizarPosicionDe: unEspecimen a: nuevaPosicionDelEspecimen 
	
	mapa removeKey: unEspecimen .
	mapa at: unEspecimen put: nuevaPosicionDelEspecimen .! !

!RoverMarino methodsFor: 'posicion' stamp: 'HAW 12/Sep/2026, 6:48:11 pm (UTC)'!
posicionDe: unEspecimen 
	
	^ mapa at: unEspecimen .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 3/Oct/2025, 9:08:53 am (UTC)'!
brazoDañadoErrorMessage

	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 3/Oct/2025, 9:08:35 am (UTC)'!
elMapaDebeTenerEspecimenesErrorMessage

	^ 'El mapa debe tener al menos un especimen para capturar'! !


!RoverMarino class methodsFor: 'instance creation' stamp: 'HAW 12/Sep/2026, 6:33:50 pm (UTC)'!
utilizando: unMapa paradoSobre: unPunto equipadoCon: unBrazo 
	
	self assertMapaNoVacio: unMapa.
	
	^self new initializeUtilizando: unMapa paradoSobre: unPunto equipadoCon: unBrazo ! !


!RoverMarino class methodsFor: 'verificacion' stamp: 'HAW 12/Sep/2026, 6:34:19 pm (UTC)'!
assertMapaNoVacio: unMapa 
	
	unMapa isEmpty ifTrue: [self error: self elMapaDebeTenerEspecimenesErrorMessage ]! !


!classDefinition: #CapturaSubmarinaTest category: #'2025-2C-1erParcial'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'HAW 12/Sep/2026, 7:50:25 pm (UTC)'!
especimenEscurridizo

	^Escurridizo new.! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'HAW 12/Sep/2026, 7:50:30 pm (UTC)'!
especimenPerezoso

	^Perezoso new.! !


!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:08 am (UTC)'!
test01LasSimulacionesDebenTenerEspecimenesACapturar

	self should: [ self roverConAspiradorUtilizando: self mapaVacio paradoSobre: 0@0 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception | self assert: exception messageText = RoverMarino elMapaDebeTenerEspecimenesErrorMessage ]


! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:15 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:19 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:22 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:25 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:28 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:31 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:34 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:37 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:42 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:45 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:49 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:52 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:56 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:00:59 am (UTC)'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 3/Oct/2025, 9:01:02 am (UTC)'!
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


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'HAW 12/Sep/2026, 6:28:43 pm (UTC)'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente

	unRover simularCapturaSobre: unAmbiente .

! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 12/Sep/2026, 6:29:37 pm (UTC)'!
mapaCon: unEspecimen en: unaPosicion

	| mapa |
	mapa := self mapaVacio .
	mapa at: unEspecimen put: unaPosicion .
	^mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 12/Sep/2026, 6:30:09 pm (UTC)'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion

	| mapa |
	mapa := self mapaVacio.
	mapa at: unEspecimen put: unaPosicion .
	mapa at: otroEspecimen put: otraPosicion .
	^ mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 12/Sep/2026, 6:29:12 pm (UTC)'!
mapaVacio
	"Lo representamos como un Diccionario Especimen -> Punto del mapa"
	^Dictionary new.! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 12/Sep/2026, 6:30:28 pm (UTC)'!
mapa: unMapa contiene: unEspecimen

	^ unMapa keys includes: unEspecimen .! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 12/Sep/2026, 6:30:45 pm (UTC)'!
mapa: unMapa contiene: unEspecimen en: unPunto

	^ (unMapa at: unEspecimen ) = unPunto.! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 12/Sep/2026, 6:31:06 pm (UTC)'!
verificarCapturaDeEspecimen: unEspecimen por: unRover

	^ unRover capturoA: unEspecimen .! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'HAW 12/Sep/2026, 7:06:36 pm (UTC)'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto

	^ RoverMarino utilizando: unMapa paradoSobre: unPunto equipadoCon: Aspirador new.! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'HAW 12/Sep/2026, 7:07:13 pm (UTC)'!
roverConRedUtilizando: unMapa paradoSobre: unPunto

		^ RoverMarino utilizando: unMapa paradoSobre: unPunto equipadoCon: Red new.! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'HAW 12/Sep/2026, 7:12:10 pm (UTC)'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: Fangoso new. ! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'HAW 12/Sep/2026, 7:12:05 pm (UTC)'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: Rocoso new.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 61 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 56 53 60 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 63 65 59 64 65 59 57 39 74 118 116 119 112 115 108 121 65 39 56 56 53 59 53 55 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 55 57 65 56 59 53 64 60 63 63 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 61 63 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 60 56 65 56 59 53 60 59 63 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 64 58 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 58 59 65 56 60 53 60 57 55 57 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 55 61 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 59 65 56 55 53 59 61 55 62 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 61 65 56 59 53 57 60 58 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 56 61 65 56 59 53 59 55 60 58 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 64 61 17 52 52 52 52 52 52 52 52 52 52 17 17))!