!classDefinition: #EscapeDeFlota category: #'ISW-Parcial1-1C25'!
Object subclass: #EscapeDeFlota
	instanceVariableNames: 'flota'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!EscapeDeFlota methodsFor: 'assert' stamp: 'Ma 5/1/2026 15:23:03'!
assertFlotaNoVacia: unaFlota 

	^unaFlota ifEmpty: [self error: self class flotaSinNavesDescripcionDeError ]! !

!EscapeDeFlota methodsFor: 'assert' stamp: 'Ma 5/1/2026 15:23:59'!
assertFlotaSinRepetidos: unaFlota
	
	^(unaFlota size = unaFlota asSet size) ifFalse: [self error: self class todasLasNavesDebenSerDiferentesDescripcionDeError ]
	! !

!EscapeDeFlota methodsFor: 'assert' stamp: 'Ma 5/1/2026 15:19:08'!
assertSecotoresSinRepetidos: unosSectores

	^unosSectores size = unosSectores asSet size ifFalse: [self error: self class sectoresRepetidosDescripcionDeError ].! !

!EscapeDeFlota methodsFor: 'assert' stamp: 'Ma 5/1/2026 13:53:24'!
assertSectoresNoVacios: unosSectores

	^ unosSectores ifEmpty: [ Error signal: EscapeDeFlota rutaVaciaDescripcionDeError ]! !


!EscapeDeFlota methodsFor: 'atrevasar' stamp: 'Ma 5/1/2026 12:29:34'!
atravesar: unosSectores

	self assertSectoresNoVacios: unosSectores .
	self assertSecotoresSinRepetidos: unosSectores.
	
	unosSectores do: [:unSector | self atravesarFlotaPorSector: unSector ].! !

!EscapeDeFlota methodsFor: 'atrevasar' stamp: 'Ma 5/1/2026 13:57:20'!
atravesarFlotaPorSector: unSector
	"atravieso y luego filtro"
	flota do: [:unaNaveEspacial | unaNaveEspacial atraviesaSector: unSector ].
	flota := flota select: [:unaNaveEspacial | unaNaveEspacial operativa ].! !


!EscapeDeFlota methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:18:12'!
haSobrevivido: unaNaveSobreviviente

	^flota includes: unaNaveSobreviviente .! !

!EscapeDeFlota methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:17:35'!
numeroDeSobrevivientesEs: unaCantidadDeSobrevivientes

	^flota size = unaCantidadDeSobrevivientes .! !


!EscapeDeFlota methodsFor: 'initialization' stamp: 'Ma 5/1/2026 15:22:43'!
initializeConFlota: unaFlota
	self assertFlotaNoVacia: unaFlota .
	self assertFlotaSinRepetidos: unaFlota .
	flota := unaFlota .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EscapeDeFlota class' category: #'ISW-Parcial1-1C25'!
EscapeDeFlota class
	instanceVariableNames: ''!

!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 15:19:54'!
enrolar: unaFlota
	^self new initializeConFlota: unaFlota .! !


!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 9/28/2025 00:38:12'!
flotaSinNavesDescripcionDeError

	^ 'La flota no puede estar vacia'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 9/28/2025 00:38:25'!
rutaVaciaDescripcionDeError

	^ 'La ruta no puede ser vacia'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 9/28/2025 00:40:29'!
sectoresRepetidosDescripcionDeError

	^ 'La ruta no puede tener sectores repetidos'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 9/28/2025 00:38:52'!
todasLasNavesDebenSerDiferentesDescripcionDeError

	^ 'Todas las naves de la flota deben ser unicas'! !


!classDefinition: #NaveEspacial category: #'ISW-Parcial1-1C25'!
Object subclass: #NaveEspacial
	instanceVariableNames: 'maniobravilidad propulsores escudos combustible maxNivelDaño nivelDaño'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!NaveEspacial methodsFor: 'assert' stamp: 'Ma 5/1/2026 12:12:30'!
assertMaxCombustible: unaCantidadDeCombustible

	^ unaCantidadDeCombustible strictlyPositive ifFalse: [ self shouldNotHappenBecause: 'Las naves deben diseñarse con capacidad maxima de combustible mayor a 0' ]! !


!NaveEspacial methodsFor: 'initialization' stamp: 'Ma 5/1/2026 12:11:28'!
initializeConPropulsores: unosPropulsores maniobravilidad: unValorDeManiobravilidad escudos: unosEscudos combustible: unaCantidadDeCombustible yNivelesDeDaño: unNivelDeDañoMaximo


	self assertMaxCombustible: unaCantidadDeCombustible .
	
	propulsores := unosPropulsores .
	escudos := unosEscudos.
	maniobravilidad := unValorDeManiobravilidad .
	nivelDaño := 0.
	maxNivelDaño := unNivelDeDañoMaximo .
	combustible := unaCantidadDeCombustible .! !


!NaveEspacial methodsFor: 'atravesar' stamp: 'Ma 5/1/2026 12:37:37'!
atraviesaSector: unSector
	
	unSector esAtravesadorPor: self.! !


!NaveEspacial methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:14:13'!
dañada

	^nivelDaño  > 0.! !

!NaveEspacial methodsFor: 'testing' stamp: 'Ma 5/1/2026 13:28:51'!
destruida

	^nivelDaño > maxNivelDaño .! !

!NaveEspacial methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:23:57'!
fuerzaDeEscudosEn: unaFuerzaDeEscudos

	^escudos  = unaFuerzaDeEscudos .! !

!NaveEspacial methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:14:47'!
nivelDeDañoEs: unNivelDeDaño

	^nivelDaño  = unNivelDeDaño .! !

!NaveEspacial methodsFor: 'testing' stamp: 'Ma 5/1/2026 12:15:20'!
valorCombustible: unValorDeCombustible

	^combustible = unValorDeCombustible .! !


!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'Ma 5/1/2026 14:44:12'!
traspansadoConImpulsorEstandarSectorPlanetario: unSector

	self reducirCombustibleNormalmente ; aplicarCondicionesDelSector: unSector .! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'Ma 5/1/2026 15:16:25'!
traspansadoConImpulsorGravitonesSectorPlanetario: unSector

	"Consumo de combustible normal + 20% de perdida de maniobravilidad"
	
	self reducirCombustibleNormalmente ;
		aplicarRadiacionDelSector: unSector;
		aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: (maniobravilidad  * 0.80)! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'Ma 5/1/2026 15:14:52'!
traspansadoConImpulsorVelocidadLuzSectorPlanetario: unSector

	"Consumo de combustible normal y se ignoran los efectos de la radiacion"
	self reducirCombustibleNormalmente ;
		aplicarGravedadDelSector: unSector .! !


!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'Ma 5/1/2026 15:11:51'!
traspansandoConImpuslorGravitonesSectorNebulosa: unSector

	self reducirCombustibleEn: (self gastoNormalDeCombustible * 3);
		aplicarCondicionesDelSector: unSector .! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'Ma 5/1/2026 15:10:51'!
traspansandoConImpuslorVelocidadLuzSectorNebulosa: unSector

	"Basicamente no pasa nada jajajaj"! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'Ma 5/1/2026 15:25:18'!
traspasandoConImpulsorEstandarSectorNebulosa: unSector

	"Peride la cantidad de combustible normal pero pero los escudos se reducen un 30%"
	
	self reducirCombustibleNormalmente ; 
		aplicarGravedadDelSector: unSector ;
		aplicarRadiacionDelSector: unSector conEscudosEfectivos: (escudos * 0.70)

	! !


!NaveEspacial methodsFor: 'atravesar asteroide' stamp: 'Ma 5/1/2026 14:42:51'!
traspansandoConImpuslorEstandarSectorDeAsteroides: unSector


	self reducirCombustibleNormalmente; reducirEscudoDeEnergiaEn: 20; aplicarCondicionesDelSector: unSector .
	
	

	! !

!NaveEspacial methodsFor: 'atravesar asteroide' stamp: 'Ma 5/1/2026 15:08:07'!
traspansandoConImpuslorGravitonesSectorDeAsteroides: unSector
	"Gasto el doble de combustible  y solo aplico radiacion del sector"
	self reducirCombustibleEn: (self gastoNormalDeCombustible * 2);
		aplicarRadiacionDelSector: unSector .! !

!NaveEspacial methodsFor: 'atravesar asteroide' stamp: 'Ma 5/1/2026 15:05:55'!
traspansandoConImpuslorVelocidadLuzSectorDeAsteroides: unSector

	self reducirCombustibleNormalmente ;
		eliminarEscudo ;
		recibirNivelDeDaño ;
		aplicarCondicionesDelSector: unSector .! !


!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:55:53'!
aplicarCondicionesDelSector: unSector

	self aplicarGravedadDelSector: unSector .
	self aplicarRadiacionDelSector: unSector .! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:57:05'!
aplicarGravedadDelSector: unSector

	self aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidad .

	! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 15:00:21'!
aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: unaManiobravilidad

	(unSector afectaManiobravilidad: unaManiobravilidad ) ifTrue: [self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:57:45'!
aplicarRadiacionDelSector: unSector

	
	self aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudos .

! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:59:01'!
aplicarRadiacionDelSector: unSector conEscudosEfectivos: unosEscudos

	(unSector radiacionAtraviesaEscudosEn: unosEscudos ) ifTrue: [self recibirNivelDeDaño]! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:32:02'!
traspasandoSectorDeAsteroides: unSector


	propulsores propulsandoA: self aTravesDeSectorDeAsteriodes: unSector ! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:38:31'!
traspasandoSectorNebulosa: unSector

	propulsores propulsandoA: self aTravesDeSectorNebulosa: unSector .! !

!NaveEspacial methodsFor: 'atravesar sectores' stamp: 'Ma 5/1/2026 14:35:33'!
traspasandoSectorPlanetario: unSector


	propulsores propulsandoA: self aTravesDeSectorPlanetario: unSector ! !


!NaveEspacial methodsFor: 'casco' stamp: 'Ma 5/1/2026 14:59:31'!
recibirNivelDeDaño

	nivelDaño := nivelDaño + 1.
	! !


!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:29:05'!
eliminarEscudo

	^escudos := 0.! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:26:49'!
gastoNormalDeCombustible

	^10.! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:29:53'!
noOperativa

	^combustible  < 0! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:54:55'!
operativa
    ^ self destruida not and: [ self noOperativa not ]! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:26:13'!
reducirCombustibleEn: unaCantidadDeCombustible
	combustible := combustible  - unaCantidadDeCombustible .
	
	
	
	! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:26:40'!
reducirCombustibleNormalmente

	self reducirCombustibleEn: self gastoNormalDeCombustible.! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:29:35'!
reducirEscudoDeEnergiaEn: valorDeReduccion

	^ escudos := escudos  - valorDeReduccion .! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:27:08'!
sinCombustible

	^ combustible <= 0.! !

!NaveEspacial methodsFor: 'escudo/combustible' stamp: 'Ma 5/1/2026 13:27:34'!
tieneSuficienteCombustible: unGastoDeCombustible

	^combustible  >= unGastoDeCombustible .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveEspacial class' category: #'ISW-Parcial1-1C25'!
NaveEspacial class
	instanceVariableNames: ''!

!NaveEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 13:01:59'!
cazaLigeroConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 90 escudos: 30 combustible: 30 yNivelesDeDaño: 2! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 13:01:22'!
cruceroPesadoConPropulsores: propulsores 
		
	^self new initializeConPropulsores: propulsores maniobravilidad: 50 escudos: 100 combustible:  50 yNivelesDeDaño: 5.! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 13:01:50'!
naveContrabandistaConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 70 escudos: 50 combustible: 95 yNivelesDeDaño: 2! !


!classDefinition: #Propulsores category: #'ISW-Parcial1-1C25'!
Object subclass: #Propulsores
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Propulsores methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 14:33:19'!
propulsandoA: unaNaveEspacial aTravesDeSectorDeAsteriodes: unSector

	self subclassResponsibility .! !

!Propulsores methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 14:38:20'!
propulsandoA: unaNaveEspacial aTravesDeSectorNebulosa: unSector

	self subclassResponsibility .! !

!Propulsores methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 14:35:33'!
propulsandoA: unaNaveEspacial aTravesDeSectorPlanetario: unSector

	self subclassResponsibility .! !


!classDefinition: #Estandar category: #'ISW-Parcial1-1C25'!
Propulsores subclass: #Estandar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Estandar methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 14:37:06'!
propulsandoA: unaNaveEspacial aTravesDeSectorDeAsteriodes: unSector

	^ unaNaveEspacial traspansandoConImpuslorEstandarSectorDeAsteroides: unSector .


	
! !

!Estandar methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 14:38:45'!
propulsandoA: unaNaveEspacial aTravesDeSectorNebulosa: unSector


	^ unaNaveEspacial traspasandoConImpulsorEstandarSectorNebulosa: unSector .! !

!Estandar methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:12:30'!
propulsandoA: unaNaveEspacial aTravesDeSectorPlanetario: unSector

	^ unaNaveEspacial traspansadoConImpulsorEstandarSectorPlanetario: unSector .
! !


!classDefinition: #Gravitones category: #'ISW-Parcial1-1C25'!
Propulsores subclass: #Gravitones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Gravitones methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:02:22'!
propulsandoA: unaNaveEspacial aTravesDeSectorDeAsteriodes: unSector

	^ unaNaveEspacial traspansandoConImpuslorGravitonesSectorDeAsteroides: unSector! !

!Gravitones methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:08:57'!
propulsandoA: unaNaveEspacial aTravesDeSectorNebulosa: unSector

	^ unaNaveEspacial traspansandoConImpuslorGravitonesSectorNebulosa: unSector! !

!Gravitones methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:13:04'!
propulsandoA: unaNaveEspacial aTravesDeSectorPlanetario: unSector


	^ unaNaveEspacial traspansadoConImpulsorGravitonesSectorPlanetario: unSector .

! !


!classDefinition: #VelocidadLuz category: #'ISW-Parcial1-1C25'!
Propulsores subclass: #VelocidadLuz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!VelocidadLuz methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:02:55'!
propulsandoA: unaNaveEspacial aTravesDeSectorDeAsteriodes: unSector

		^ unaNaveEspacial traspansandoConImpuslorVelocidadLuzSectorDeAsteroides: unSector
! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:09:18'!
propulsandoA: unaNaveEspacial aTravesDeSectorNebulosa: unSector

			^ unaNaveEspacial traspansandoConImpuslorVelocidadLuzSectorNebulosa: unSector
! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'Ma 5/1/2026 15:13:24'!
propulsandoA: unaNaveEspacial aTravesDeSectorPlanetario: unSector

	^ unaNaveEspacial traspansadoConImpulsorVelocidadLuzSectorPlanetario: unSector .

! !


!classDefinition: #SectorEspacial category: #'ISW-Parcial1-1C25'!
Object subclass: #SectorEspacial
	instanceVariableNames: 'radiacion gravedad'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!SectorEspacial methodsFor: 'atravesar sector' stamp: 'Ma 5/1/2026 12:38:09'!
esAtravesadorPor: unaNaveEspacial

	self subclassResponsibility .! !


!SectorEspacial methodsFor: 'reglas' stamp: 'Ma 5/1/2026 14:51:50'!
afectaManiobravilidad: maniobravilidad
	
	^ gravedad > maniobravilidad! !

!SectorEspacial methodsFor: 'reglas' stamp: 'Ma 5/1/2026 14:52:56'!
radiacionAtraviesaEscudosEn: valorDeEscudos

	^ radiacion > valorDeEscudos! !


!SectorEspacial methodsFor: 'initialization' stamp: 'Ma 5/1/2026 12:02:47'!
initializeConGravedad: unaGravedad yRadiacion: unaRadiacion

	gravedad := unaGravedad .
	radiacion := unaRadiacion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SectorEspacial class' category: #'ISW-Parcial1-1C25'!
SectorEspacial class
	instanceVariableNames: ''!

!SectorEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 12:02:47'!
sectorDeAteroideConGravedad: gravedad yRadiacion: radiacion

	^Asteroides new initializeConGravedad: gravedad yRadiacion: radiacion .! !

!SectorEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 12:03:45'!
sectorNebulosaConGravedad: gravedad yRadiacion: radiacion

	^Nebulosa new initializeConGravedad: gravedad yRadiacion: radiacion .! !

!SectorEspacial class methodsFor: 'instance creation' stamp: 'Ma 5/1/2026 12:04:43'!
sectorPlanetarioConGravedad: gravedad yRadiacion: radiacion

	^Planetario new initializeConGravedad: gravedad yRadiacion: radiacion .! !


!classDefinition: #Asteroides category: #'ISW-Parcial1-1C25'!
SectorEspacial subclass: #Asteroides
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Asteroides methodsFor: 'atravesar' stamp: 'Ma 5/1/2026 14:32:26'!
esAtravesadorPor: unaNaveEspacial
	
	 
	unaNaveEspacial traspasandoSectorDeAsteroides: self.
	
! !


!classDefinition: #Nebulosa category: #'ISW-Parcial1-1C25'!
SectorEspacial subclass: #Nebulosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Nebulosa methodsFor: 'atravesar sector' stamp: 'Ma 5/1/2026 14:32:37'!
esAtravesadorPor: unaNaveEspacial
	
	unaNaveEspacial traspasandoSectorNebulosa: self.! !


!classDefinition: #Planetario category: #'ISW-Parcial1-1C25'!
SectorEspacial subclass: #Planetario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Planetario methodsFor: 'atravesar sector' stamp: 'Ma 5/1/2026 14:32:48'!
esAtravesadorPor: unaNaveEspacial
	
	unaNaveEspacial traspasandoSectorPlanetario: self.! !


!classDefinition: #EscapeDeFlotaTests category: #'ISW-Parcial1-1C25'!
TestCase subclass: #EscapeDeFlotaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/10/2025 19:58:18'!
test01LaFlotaDebeTenerAlMenosUnaNave
	
	self 
		should: [ EscapeDeFlota enrolar: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/10/2025 19:58:49'!
test02LaFlotaNoPuedeTenerNavesDuplicadas

	| cruceroPesadoConImpulsoEstandar |
	
	cruceroPesadoConImpulsoEstandar := self nuevoCruceroPesadoConImpulsoEstandar.
	
	self 
		should: [ EscapeDeFlota enrolar: { cruceroPesadoConImpulsoEstandar. cruceroPesadoConImpulsoEstandar } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 05:58:13'!
test03LaRutaDeSectoresARecorrerNoPuedeSerVacia

	| cruceroPesadoConImpulso flota |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	self 
		should: [ flota atravesar: {  } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota rutaVaciaDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 05:58:22'!
test04CombustibleDeLaNaveDebeSerSuficienteParaAtravesarUnicoSectorPlanetarioYSobrevivir

	| sector flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	flota atravesar: { sector }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: (cruceroPesadoConImpulso valorCombustible: (50 - 10))
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:58'!
test05LaRutaDeSectoresARecorrerNoPuedeTenerSectoresRepetidos

	| cruceroPesadoConImpulso flota sector |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	self 
		should: [ flota atravesar: { sector. sector } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota sectoresRepetidosDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:39'!
test06NaveQueSeQuedaSinCombustibleMientrasCruzaSectorNoSobrevive

	| flota naveContrabandistaConImpulso |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso sinCombustible.

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso }.
	
	"Secuencia de 10 sistemas planetarios seguidos con combustible para 9.5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 10 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: naveContrabandistaConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:34'!
test07NavePuedeQuedarseSinCombustiblePeroSobrevivir

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"Secuencia de 5 sistemas planetarios seguidos... Llega justo!!"
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso sinCombustible.
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:30'!
test08NaveQueSeQuedaSinCombustibleAntesDePasarPorTodosLosSectoresNoSobrevive

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.

	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"Secuencia de 6 sistemas planetarios seguidos con combustible para 5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:25'!
test09NaveQueAtraviesaSectorConMayorGravedadQueSuManiobravilidadSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).

	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:21'!
test10NaveQueAtraviesaSectorConMayorRadiacionQueSusEscudosDeEnergiaSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:15'!
test11NaveAtravesandoSectorConMayorGravedadYRadiacionQueSuManiobravilidadYEscudosDeEnergiaSufreElDobleDeDaño

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 2).
	
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:11'!
test12NaveQueSufreMasNivelesDeDañoQueLaCapacidadDeSuCascoEsDestruidaYNoSobreviveAlEscape

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso destruida.
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"6 niveles de daño en una clase de naves que sólo admite 5 como máximo..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 70 yRadiacion: 200).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso destruida
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:07'!
test13NaveAtravesandoSectorPlanetarioUsandoVelocidadLuzIgnoraRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector planetario utilizando velocidad luz (Warp, Light Speed, Subluminal, FTL: Faster Than Light, o como tu autor de ciencia ficción favorito lo llame), se puede pasar tan rápido que se ignoran los efectos de la radiación"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz}.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: (95 - 10)).
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 90 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	
	"El daño proviene aquí de la alta gravedad y no de la radiación..."	
	self assert: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: (95 - 20))
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:02'!
test14NaveAtravesandoSectorPlanetarioUsandoGravitonesDecrementaManiobravilidadEn20Porciento

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector planetario utilizando propulsion por gravitones el piloto tiene mayor dificultad en controlar la nave en el sector. 20% de penalización en su maniobravilidad"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 * 0.8 yRadiacion: 40 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 10).
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: (70 * 0.8) + 1 yRadiacion: 40 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	
	"La gravedad supera la coordinacion del piloto navegando sector planetario con gravitones, luego la nave es dañada"
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 20).

! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:58'!
test15NaveAtravesandoSectorDeAsteroidesUsandoImpulsoEstandarReduceSusEscudosDeEnergia

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa un sector de asteroides utilizando el propulsor de impulso estandar, los escudos indefectiblemente reciben el impacto de los asteroides (nada que pueda hacer el piloto con ese tipo de propulsores) y se reducen permanentemente en 20"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso}.
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 35 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50 - 20).
	
	"La nave sufre daño porque los escudos de energia descendieron por debajo de la radiacion del sector"
	self assert: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 1).
	
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:53'!
test16NaveAtravesandoSectorDeAsteroidesUsandoVelocidadLuzAgotaSusEscudosACeroYSufreDaños

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector de asteroides utilizando velocidad luz, vas derecho al desastre... quien sea que haya trazado ese curso estará condenado, porque irá en linea recta contra un cinturón de asteroides a la velocidad de la luz (duh!!). En terminos prácticos, la nave pierde todos sus escudos de energía permanentemente (pasan a 0) debido a los impactos con los asteroides, se le inflinje 1 nivel de daño al casco y además casi seguro se le suma otro nivel más por radiación al esta no contar más con sus escudos"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50).
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 30 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	
	"Usar Velocidad Luz con asteroides acaba con los escudos y suma 1 nivel de daño al casco".
	"La radición daña adicionalmente al casco de la nave ya que sus escudos se reducen a 0"
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 0).
	self assert: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1 + 1).
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:48'!
test17NaveAtravesandoSectorDeAsteroidesUsandoGravitonesIgnoraGravedadPeroConsumeElDobleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector de asteroides utilizando el avanzado sistema de propulsores basado en Gravitones, el piloto automático de la nave puede sin problema eludirlos sin impactos. Como el piloto no participa, no se tiene en cuenta el rating de maniobrabilidad de la nave, ni la gravedad del sector"
	
	"Al mismo tiempo, lamentablemente el sistema consume el doble de combustible que lo normal"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones}.
	
	"La alta gravedad no son nada para el sistema avanzado de propulsores de Gravitones"
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 90 yRadiacion: 30 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	"Doble gasto de combustible"
	self assert: (naveContrabandistaConGravitones valorCombustible: (95 - 20)).

	"La radiación del sector es la que produce el daño (60 supera a los 50 de los escudos de la nave) y no la gravedad..."
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 90 yRadiacion: 60 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	"Doble gasto de combustible"
	self assert: (naveContrabandistaConGravitones valorCombustible: (95 - 40))
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:47:51'!
test18NaveAtravesandoSectorNebulosaUsandoImpulsoEstandarDecrementaEscudosAl30Porciento

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa una nebulosa con propulsores de impulso estandar, se esta mucho tiempo dentro de la misma y los escudos empiezan a perder efectividad. 30% de penalizacion a los escudos mientras se la cruza"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar .
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 50 yRadiacion: 50 * 0.7 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso valorCombustible: 95 - 10).


	flota atravesar: { self nuevoSectorNebulosaConGravedad: 50 yRadiacion: (50 * 0.7) + 1}.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	"La radiación supera el desgaste extremo de los escudos, y por lo tanto la nave es dañada"
	self assert: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConImpulso valorCombustible: 95 - 20).
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:37'!
test19NaveAtravesandoSectorNebulosaUsandoVelocidadLuzNoConsumeCombustibleEIgnoraGravedadYRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se viaja hacia una nebulosa utilizando velocidad luz, el modulo Warp se revigoriza por un efecto cuántico bien conocido por el contacto con los gases de la nébula, y casi la teletransporta de inmediato al próximo sector galáctico de la trayectoria del viaje. Luego no se consume combustible, y no se efectua ninguno de los chequeos típicos de supervivencia en el sector"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:31'!
test20NaveAtravesandoSectorNebulosaUsandoGravitonesEsAfectadaPorGravedadYRadiacionNormalmentePeroConsumientoElTripleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"La nebulosa afecta los propulsores de gravitones haciendolos menos eficientes. Consume 3 veces el valor de combustible normal sin ningun otro beneficio"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones .
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 70 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 30).

	flota atravesar: { self nuevoSectorNebulosaConGravedad: 71 yRadiacion: 51 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 2).
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 60)! !


!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'Ma 5/1/2026 11:57:22'!
nuevaNaveContrabandistaConGravitones

	^NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeGravitones.! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'Ma 5/1/2026 11:58:01'!
nuevaNaveContrabandistaConImpulsoEstandar

	^ NaveEspacial  naveContrabandistaConPropulsores: self propulsoresDeImpulsoEstandar .! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'Ma 5/1/2026 13:02:36'!
nuevaNaveContrabandistaConVelocidadLuz

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeVelocidadLuz ! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'Ma 5/1/2026 11:59:11'!
nuevoCruceroPesadoConImpulsoEstandar

	^NaveEspacial  cruceroPesadoConPropulsores: self propulsoresDeImpulsoEstandar .! !


!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'Ma 5/1/2026 12:02:01'!
nuevoSectorDeAsteroidesConGravedad: gravedad yRadiacion: radiacion

	  ^ SectorEspacial sectorDeAteroideConGravedad: gravedad yRadiacion: radiacion .! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'Ma 5/1/2026 12:03:30'!
nuevoSectorNebulosaConGravedad: gravedad yRadiacion: radiacion
 
	^ SectorEspacial sectorNebulosaConGravedad: gravedad yRadiacion: radiacion .! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'Ma 5/1/2026 12:04:20'!
nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion

	^ SectorEspacial sectorPlanetarioConGravedad: gravedad yRadiacion: radiacion .
! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'Ma 5/1/2026 12:05:55'!
nuevoTrayectoDeSectoresPlanetariosDeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion

	^ (1 to: numeroDeSectores ) collect: [:numeroDeSector | self nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion ]. 
	! !


!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'Ma 5/1/2026 11:56:00'!
propulsoresDeGravitones

	^Gravitones new.! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'Ma 5/1/2026 11:56:07'!
propulsoresDeImpulsoEstandar

	^Estandar new! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'Ma 5/1/2026 11:56:14'!
propulsoresDeVelocidadLuz

	^VelocidadLuz new.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 64 53 56 59 52 104 121 106 111 56 52 56 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 64 91 57 55 65 58 64 65 57 64 53 61 55 56 58 57 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 55 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 57 59 53 57 61 55 60 56 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 58 59 53 56 62 62 61 59 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 59 65 58 59 53 55 63 61 58 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 60 65 55 63 53 56 61 56 61 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 58 56 65 60 57 53 55 63 55 62 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 58 63 61 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 59 61 65 60 63 53 61 60 58 63 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 57 58 64 57 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 58 65 59 63 65 60 59 53 64 58 59 58 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 58 61 61 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 60 65 57 62 65 55 59 53 55 63 64 56 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 53 122 123 17 59 56 63 64 60 17 52 52 52 52 52 52 52 52 52 52 17 17))!