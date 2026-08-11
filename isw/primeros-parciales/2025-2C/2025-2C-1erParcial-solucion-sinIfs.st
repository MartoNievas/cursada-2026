!classDefinition: #Ambiente category: #'2025-2C-1erParcial'!
Object subclass: #Ambiente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Ambiente methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 11:30:30'!
intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRover reduciendoAreaEn: unaReduccion utilizando: unaFormaDeCaptura

	|areaDeAgarreEfectiva especimenesEnAreaDeAgarre|
	
	areaDeAgarreEfectiva := unRover reducirAreaDeAgarra: unAreaDeAgarre en: unaReduccion .
	especimenesEnAreaDeAgarre := unRover especimenesDentroDelAreaDeAgarre: areaDeAgarreEfectiva .
	
	especimenesEnAreaDeAgarre do: [:unEspecimen |  unaFormaDeCaptura value: unEspecimen value: areaDeAgarreEfectiva ].! !

!Ambiente methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 11:13:12'!
siendoNavegadoPor: unRoverMarino conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre

	self subclassResponsibility .! !

!Ambiente methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 11:13:06'!
siendoNavegadoPor: unRoverMarino conBrazoRedEn: unMapa conAreaDeAgarre: unAreaDeAgarre 

	self subclassResponsibility .! !


!classDefinition: #Fangoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Fangoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Fangoso methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 11:33:24'!
siendoNavegadoPor: unRoverMarino conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre
	
	"Como es fangoso con brazo aspirador el area permance igual de 3x3"
	"Entonces buscamos especimenes en el area con el rover"
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRoverMarino  reduciendoAreaEn: (0@0) utilizando: [:unEspecimen :areaDeAgarre | 
			unEspecimen enUnAmbienteFangosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre .
		] 
	! !

!Fangoso methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 12:13:12'!
siendoNavegadoPor: unRoverMarino conBrazoRedEn: unMapa conAreaDeAgarre: unAreaDeAgarre 

	"Como estamos con un brazo de red en ambiente fangoso el area se reduce a la mida osea que queda de 3@1"
	
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre  por: unRoverMarino  reduciendoAreaEn: 2@0  utilizando: [:unEspecimen :areaDeAgarre |
			unEspecimen enUnAmbienteFangosoDe: unMapa con: unRoverMarino  intentarCapturarEspecimenUtilizandoUnBrazoDeRedCon: areaDeAgarre .
		]. ! !


!classDefinition: #Rocoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Rocoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Rocoso methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 12:00:56'!
siendoNavegadoPor: unRoverMarino conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre
	
	"Como el terreno es rocoso el area se reduce en una fila"
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRoverMarino  reduciendoAreaEn: (0@1) utilizando: [:unEspecimen :areaDeAgarre | 
			unEspecimen enUnAmbienteRocosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre .
		] .
	! !

!Rocoso methodsFor: 'captura en ambiente' stamp: 'Ma 4/29/2026 11:37:47'!
siendoNavegadoPor: unRoverMarino conBrazoRedEn: unMapa conAreaDeAgarre: unAreaDeAgarre 

	"Al intentar capurar con red el brazo se daña"
	
	unRoverMarino brazoDañado .! !


!classDefinition: #BrazoRover category: #'2025-2C-1erParcial'!
Object subclass: #BrazoRover
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRover methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:00:46'!
capturaEspecimenesSobreAmbiente: unAmbiente

	self subclassResponsibility .! !


!BrazoRover methodsFor: 'area' stamp: 'Ma 4/29/2026 11:23:56'!
extension

	self subclassResponsibility .! !


!BrazoRover methodsFor: 'initialization' stamp: 'Ma 4/29/2026 10:58:31'!
initializeConRoverMarino: unRoverMarino

	rover := unRoverMarino .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BrazoRover class' category: #'2025-2C-1erParcial'!
BrazoRover class
	instanceVariableNames: ''!

!BrazoRover class methodsFor: 'instance creation' stamp: 'Ma 4/29/2026 10:58:56'!
with: unRoverMarino

	^self new initializeConRoverMarino: unRoverMarino .! !


!classDefinition: #BrazoAspirador category: #'2025-2C-1erParcial'!
BrazoRover subclass: #BrazoAspirador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoAspirador methodsFor: 'area' stamp: 'Ma 4/29/2026 11:24:06'!
extension
	
	^3@3. ! !


!BrazoAspirador methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:01:27'!
capturaEspecimenesSobreAmbiente: unAmbiente

	rover capturaEspecimenesSobreAmbienteConBrazoAspirador: unAmbiente .! !


!classDefinition: #BrazoRed category: #'2025-2C-1erParcial'!
BrazoRover subclass: #BrazoRed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRed methodsFor: 'area' stamp: 'Ma 4/29/2026 11:24:18'!
extension

	^6@1. ! !


!BrazoRed methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:08:55'!
capturaEspecimenesSobreAmbiente: unAmbiente

	rover capturaEspecimenesSobreAmbienteConBrazoRed: unAmbiente .! !


!classDefinition: #Especimen category: #'2025-2C-1erParcial'!
Object subclass: #Especimen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Especimen methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:43:16'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre 

	self subclassResponsibility .! !

!Especimen methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:42:13'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino  intentarCapturarEspecimenUtilizandoUnBrazoDeRedCon: areaDeAgarre

	self subclassResponsibility .! !

!Especimen methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:42:37'!
enUnAmbienteRocosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre

	self subclassResponsibility .! !


!classDefinition: #Escurridizo category: #'2025-2C-1erParcial'!
Especimen subclass: #Escurridizo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Escurridizo methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:46:42'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre 


	"Como estamos en ambiente fangoso y con brazo aspirador se mueve en la digonal 1@1"
	
	"Lo que tengo que hacer es moverlo y ver si puedo capturarlo, ademas agregarlo al mapa"
	
	self partiendoDe: (unMapa at: self) seDeplaza: 1@1 dentroDelAreaDeAgarre: areaDeAgarre del: unRoverMarino en: unMapa .
! !

!Escurridizo methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:54:20'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino  intentarCapturarEspecimenUtilizandoUnBrazoDeRedCon: areaDeAgarre

"Si estamos en un ambiente fangoso con brazo de red y somos escurridizos nos movemos hacia abajo (-1@0)"

	self partiendoDe: (unMapa at: self)  seDeplaza: (-1@0) dentroDelAreaDeAgarre: areaDeAgarre  del: unRoverMarino en: unMapa .! !

!Escurridizo methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:55:47'!
enUnAmbienteRocosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre

	"Ahora estmaos con brazo aspirador en terreno rocoso siendo escurridizo entonces no movemos hacia abajo (0@1)"
	
	self partiendoDe: (unMapa at: self) seDeplaza: (0@1)  dentroDelAreaDeAgarre: areaDeAgarre  del: unRoverMarino en: unMapa .! !

!Escurridizo methodsFor: 'captura' stamp: 'Ma 4/29/2026 12:28:23'!
partiendoDe: unaPosicionDeInico seDeplaza: unDesplazamiento dentroDelAreaDeAgarre: unAreaDeAgarreEfectiva del: unRoverMarino en: unMapa

	"Ahora tengo que desplazar la posicioon de inicio y fijarme si sigo estando en el area efectiva"
	
	|nuevaPosicionDelEspecimen|
	nuevaPosicionDelEspecimen := unaPosicionDeInico + unDesplazamiento .
	
	"si sigo en el area capturo, sino actualizo la direccion en el mapa"
	(unAreaDeAgarreEfectiva containsPoint: nuevaPosicionDelEspecimen ) 
	ifTrue: [unRoverMarino capturarUnEspecimen: self]
	ifFalse: [self actualizarPosicionEn: unMapa a: nuevaPosicionDelEspecimen ]! !


!Escurridizo methodsFor: 'mapa' stamp: 'Ma 4/29/2026 11:52:04'!
actualizarPosicionEn: unMapa a: nuevaPosicionDelEspecimen

	unMapa at: self put: nuevaPosicionDelEspecimen .! !


!classDefinition: #Perezoso category: #'2025-2C-1erParcial'!
Especimen subclass: #Perezoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Perezoso methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:56:58'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre 

	
	"Si soy perezo en un ambiente fangoso no tengo posibilidad de escape"
	
	unRoverMarino capturarUnEspecimen: self.! !

!Perezoso methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:57:51'!
enUnAmbienteFangosoDe: unMapa con: unRoverMarino  intentarCapturarEspecimenUtilizandoUnBrazoDeRedCon: areaDeAgarre
	
	"Si soy perezoso en terreno fango con red me sumergo en el fango y escapo"
	
	"No hago nada"! !

!Perezoso methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:59:12'!
enUnAmbienteRocosoDe: unMapa con: unRoverMarino intentarCapturarEspcimenUtilizandoUnBrazoAspiradorCon: areaDeAgarre


	"Si soy peresozo con terreno rocoso y brazo aspirador me capturan"
	
	unRoverMarino capturarUnEspecimen: self.! !


!classDefinition: #ModoRover category: #'2025-2C-1erParcial'!
Object subclass: #ModoRover
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!ModoRover methodsFor: 'initialization' stamp: 'Ma 4/29/2026 10:42:50'!
initializeConRover: unRoverMarion

	rover :=unRoverMarion .! !


!ModoRover methodsFor: 'captura' stamp: 'Ma 4/29/2026 10:52:28'!
capturarSobreAmbiente: unAmbiente

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModoRover class' category: #'2025-2C-1erParcial'!
ModoRover class
	instanceVariableNames: ''!

!ModoRover class methodsFor: 'instance creation' stamp: 'Ma 4/29/2026 10:43:38'!
with: unRoverMarino

	^self new initializeConRover: unRoverMarino .! !


!classDefinition: #ModoContingencia category: #'2025-2C-1erParcial'!
ModoRover subclass: #ModoContingencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!ModoContingencia methodsFor: 'captura' stamp: 'Ma 4/29/2026 10:53:50'!
capturarSobreAmbiente: unAmbiente

	rover roverCapturaEnModoContingenciaSobreAmbiente: unAmbiente ! !


!classDefinition: #ModoNormal category: #'2025-2C-1erParcial'!
ModoRover subclass: #ModoNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!ModoNormal methodsFor: 'captura' stamp: 'Ma 4/29/2026 10:54:21'!
capturarSobreAmbiente: unAmbiente 


	rover roverCapturaEnModoNormalSobreAmbiente: unAmbiente ! !


!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa coordenanda modo tanque brazo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 12:20:55'!
areaDeAgarreConExtension: unaExtension

	^ Rectangle origin: coordenanda  corner: coordenanda  + unaExtension .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/29/2026 10:52:50'!
capturarSobreAmbiente: unAmbiente
    
	
	modo capturarSobreAmbiente: unAmbiente.
	
"
	
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
			
			self brazoDañado .
            ].
        ].
    ].
"! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:50:54'!
capturarUnEspecimen: unEspecimen

	mapa removeKey: unEspecimen .
	tanque add: unEspecimen .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/29/2026 11:50:54'!
roverCapturaEnModoContingenciaSobreAmbiente: unAmbiente

	|areaDeAgarre especimenesEnAreaDeAgarre|
	areaDeAgarre := self areaDeAgarreConExtension: 1@1.
	especimenesEnAreaDeAgarre := self especimenesDentroDelAreaDeAgarre: areaDeAgarre .
	especimenesEnAreaDeAgarre do: [:unEspecimen | self capturarUnEspecimen: unEspecimen ].
	! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/29/2026 10:57:18'!
roverCapturaEnModoNormalSobreAmbiente: unAmbiente 

	brazo capturaEspecimenesSobreAmbiente: unAmbiente .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/28/2026 13:36:13'!
tanqueContieneA: unEspecimen

	^tanque includes: unEspecimen .! !


!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/29/2026 10:45:15'!
brazoDañado

	modo := ModoContingencia with: self.
	self error: self class brazoDañadoErrorMessage .! !

!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/29/2026 12:23:56'!
capturaEspecimenesSobreAmbienteConBrazoAspirador: unAmbiente

	unAmbiente siendoNavegadoPor: self conBrazoAspiradorEn: mapa conAreaDeAgarre: (self areaDeAgarreConExtension: brazo extension) .! !

!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/29/2026 12:23:30'!
capturaEspecimenesSobreAmbienteConBrazoRed: unAmbiente


	unAmbiente siendoNavegadoPor: self conBrazoRedEn: mapa conAreaDeAgarre: ( self areaDeAgarreConExtension: (brazo extension)) .! !

!RoverMarino methodsFor: 'brazo' stamp: 'Ma 4/29/2026 12:10:22'!
especimenesDentroDelAreaDeAgarre: unAreaAgarre
	"Primero filtramos los puntos en el area de agarre, luego tomamos los especimenes de esos puntos"
	^ (mapa select: [:unaPosicion | unAreaAgarre containsPoint: unaPosicion ]) collect: [:unaPoscion | 
			mapa keyAtValue: unaPoscion .
		].! !


!RoverMarino methodsFor: 'mapa' stamp: 'Ma 4/28/2026 12:50:08'!
nuevaPosicionEspecimen: unEspecimen es: unPosicion


	mapa at: unEspecimen put: unPosicion .! !

!RoverMarino methodsFor: 'captura' stamp: 'Ma 4/29/2026 12:19:33'!
reducirAreaDeAgarra: unAreaDeAgarre en: unaReduccion

	^ unAreaDeAgarre extendBy: 0@0 - unaReduccion.! !


!RoverMarino methodsFor: 'initialization' stamp: 'Ma 4/29/2026 10:59:32'!
initializeConMapa: unMapa  yParadoSobre: unPunto conBrazo: unBrazo

	mapa := unMapa.
	coordenanda := unPunto .
	brazo := unBrazo with: self.
	modo := ModoNormal with: self.
	tanque := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'instance creation' stamp: 'Ma 4/29/2026 10:59:12'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto
	unMapa isEmpty ifTrue: [self error: self elMapaDebeTenerEspecimenesErrorMessage ].
	^self new initializeConMapa: unMapa  yParadoSobre: unPunto  conBrazo: BrazoAspirador.! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'Ma 4/29/2026 10:59:17'!
roverConRedUtilizando: unMapa paradoSobre: unPunto 

	^self new initializeConMapa: unMapa yParadoSobre: unPunto conBrazo: BrazoRed ! !


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

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'Ma 4/29/2026 12:00:02'!
especimenEscurridizo

	^Escurridizo new.! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'Ma 4/29/2026 12:00:11'!
especimenPerezoso

	^Perezoso new.! !


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


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'Ma 4/29/2026 12:03:08'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: Fangoso new! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'Ma 4/29/2026 12:03:03'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover  enAmbiente: Rocoso new! !
