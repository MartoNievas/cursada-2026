!classDefinition: #EscapeDeFlota category: #'ISW-Parcial1-1C25'!
Object subclass: #EscapeDeFlota
	instanceVariableNames: 'flota'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!EscapeDeFlota methodsFor: 'initialization' stamp: 'HAW 16/Sep/2026, 4:17:24 pm (UTC)'!
initializeEnrolar: unaFlotaDeNaves 
	
	flota := unaFlotaDeNaves.! !


!EscapeDeFlota methodsFor: 'atravesar' stamp: 'HAW 18/Sep/2026, 1:02:23 pm (UTC)'!
atravesar: unaRutaDeSectores

	self assertRutaNoVacia: unaRutaDeSectores .
	self assertRutaSinSectoresRepetidos: unaRutaDeSectores .

	 unaRutaDeSectores do: [:unSector |
			self flotaAtraviesa: unSector .
		].
	
	flota := flota select: [:unaNave | unaNave tieneCombustible and: [unaNave operativa]].! !

!EscapeDeFlota methodsFor: 'atravesar' stamp: 'HAW 18/Sep/2026, 1:37:20 pm (UTC)'!
flotaAtraviesa: unSector

	flota do: [:unaNave |
			unSector tipo = #Planetario ifTrue: [
					unaNave tipoPropulsor = #ImpulsoEstandar ifTrue: [
							"Consume 10 de combustible"
							unaNave consumoNormalDeCombustible.
							unaNave aplicarCondicionesDelSector: unSector
						].
					unaNave tipoPropulsor = #VelocidadLuz ifTrue: [
							unaNave consumoNormalDeCombustible.
							unaNave aplicarGravedadDelSector: unSector .
						].
					
					unaNave tipoPropulsor = #Gravitones ifTrue: [
							unaNave consumoNormalDeCombustible.
							unaNave reducirManiobravilidadEn: 0.8.
							unaNave aplicarCondicionesDelSector: unSector. 
						].
				].
			unSector tipo = #Asteroides ifTrue: [
					unaNave tipoPropulsor = #ImpulsoEstandar ifTrue: [
							unaNave reducirEscudosEn: 20.
							unaNave consumoNormalDeCombustible .
							unaNave aplicarCondicionesDelSector: unSector.
						].
					unaNave tipoPropulsor = #VelocidadLuz ifTrue: [
							unaNave escudosInutilizables.
							unaNave recibirDaño.
							unaNave consumoNormalDeCombustible .
							unaNave aplicarCondicionesDelSector: unSector.
						].
					unaNave tipoPropulsor = #Gravitones ifTrue: [
							unaNave consumirCombustible: 20.
							unaNave aplicarRadiacionDelSector: unSector .
						].
				].
			unSector tipo = #Nebulosa ifTrue: [
					unaNave tipoPropulsor = #ImpulsoEstandar ifTrue: [
							unaNave consumoNormalDeCombustible.
							unaNave reducirEscudosEn: unaNave escudos * 0.30.
							unaNave aplicarCondicionesDelSector: unSector .
						].
					unaNave tipoPropulsor = #Gravitones ifTrue: [
							unaNave consumirCombustible: 30.
							unaNave aplicarCondicionesDelSector: unSector 
						].
				]
		].
	
	
	! !


!EscapeDeFlota methodsFor: 'asserting' stamp: 'HAW 16/Sep/2026, 4:09:07 pm (UTC)'!
assertRutaNoVacia: unaRutaDeSectores 
	
	unaRutaDeSectores isEmpty ifTrue: [self error: EscapeDeFlota rutaVaciaDescripcionDeError ].! !

!EscapeDeFlota methodsFor: 'asserting' stamp: 'HAW 16/Sep/2026, 4:14:30 pm (UTC)'!
assertRutaSinSectoresRepetidos: unaRutaDeSectores 
	
	unaRutaDeSectores size ~= unaRutaDeSectores asSet size ifTrue: [self error: self class sectoresRepetidosDescripcionDeError ]! !


!EscapeDeFlota methodsFor: 'testing' stamp: 'HAW 16/Sep/2026, 4:17:57 pm (UTC)'!
haSobrevivido: unaNaveEspacial

	^ flota includes: unaNaveEspacial .
	
	! !

!EscapeDeFlota methodsFor: 'testing' stamp: 'HAW 16/Sep/2026, 4:15:02 pm (UTC)'!
numeroDeSobrevivientesEs: unNumeroDeSobrevivientes 
	
	^ flota size = unNumeroDeSobrevivientes .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EscapeDeFlota class' category: #'ISW-Parcial1-1C25'!
EscapeDeFlota class
	instanceVariableNames: ''!

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 28/Sep/2025, 3:38:12 am (UTC)'!
flotaSinNavesDescripcionDeError

	^ 'La flota no puede estar vacia'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 28/Sep/2025, 3:38:25 am (UTC)'!
rutaVaciaDescripcionDeError

	^ 'La ruta no puede ser vacia'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 28/Sep/2025, 3:40:29 am (UTC)'!
sectoresRepetidosDescripcionDeError

	^ 'La ruta no puede tener sectores repetidos'! !

!EscapeDeFlota class methodsFor: 'message error' stamp: 'NR 28/Sep/2025, 3:38:52 am (UTC)'!
todasLasNavesDebenSerDiferentesDescripcionDeError

	^ 'Todas las naves de la flota deben ser unicas'! !


!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'HAW 16/Sep/2026, 4:05:38 pm (UTC)'!
enrolar: unaFlotaDeNaves 
	
	self assertFlotaDeNavesNoVacia: unaFlotaDeNaves .
	self assertFlotaDeNavesSinRepetidos: unaFlotaDeNaves .
	^self new initializeEnrolar: unaFlotaDeNaves ! !


!EscapeDeFlota class methodsFor: 'asserting' stamp: 'HAW 16/Sep/2026, 3:58:00 pm (UTC)'!
assertFlotaDeNavesNoVacia: unaFlotaDeNaves 
	
	unaFlotaDeNaves isEmpty ifTrue: [self error: self flotaSinNavesDescripcionDeError ]! !

!EscapeDeFlota class methodsFor: 'asserting' stamp: 'HAW 16/Sep/2026, 4:07:07 pm (UTC)'!
assertFlotaDeNavesSinRepetidos: unaFlotaDeNaves

	unaFlotaDeNaves size ~= unaFlotaDeNaves asSet size ifTrue: [self error: self todasLasNavesDebenSerDiferentesDescripcionDeError ]! !


!classDefinition: #NaveEspacial category: #'ISW-Parcial1-1C25'!
Object subclass: #NaveEspacial
	instanceVariableNames: 'maniobravilidad nivelEscudo nivelMaximoDaño combustible nivelDaño tipoDePropulsor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!NaveEspacial methodsFor: 'initialization' stamp: 'HAW 18/Sep/2026, 12:59:39 pm (UTC)'!
initializeWithManiobravilidad: aManiobravilidad escudos: unNivelDeEscudo combustible: aCombustible maxinoNivelDeDañoEnCasco: maximoNivelDaño yPropulsores: unTipoDePropulsor 
	
	maniobravilidad := aManiobravilidad.
	nivelEscudo := unNivelDeEscudo.
	combustible := aCombustible.
	nivelMaximoDaño  := maximoNivelDaño.
	tipoDePropulsor := unTipoDePropulsor.
	nivelDaño := 0.! !


!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:09:15 pm (UTC)'!
aplicarCondicionesDelSector: unSector

	self aplicarGravedadDelSector: unSector.
	self aplicarRadiacionDelSector: unSector .
	! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:12:01 pm (UTC)'!
aplicarGravedadDelSector: unSector

	(unSector gravedadSuperaManiobravilidad: maniobravilidad ) ifTrue: [self recibirDaño]! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:11:05 pm (UTC)'!
aplicarRadiacionDelSector: unSector

	(unSector radiacionSuperaEscudos: nivelEscudo ) ifTrue: [self recibirDaño]! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 12:44:38 pm (UTC)'!
consumirCombustible: unaCantidadDeCombustible

	combustible := combustible - unaCantidadDeCombustible .! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 12:44:56 pm (UTC)'!
consumoNormalDeCombustible

	self consumirCombustible: 10.! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:13:14 pm (UTC)'!
destruida
	
	^ nivelDaño > nivelMaximoDaño .! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:29:18 pm (UTC)'!
escudosInutilizables
	
	nivelEscudo := 0.! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:10:29 pm (UTC)'!
recibirDaño

	nivelDaño := nivelDaño + 1.! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:24:55 pm (UTC)'!
reducirEscudosEn: unNivelDeEscudos

	nivelEscudo := nivelEscudo  - unNivelDeEscudos .! !

!NaveEspacial methodsFor: 'modificar' stamp: 'HAW 18/Sep/2026, 1:21:11 pm (UTC)'!
reducirManiobravilidadEn: unFactorDeReduccion

	maniobravilidad := maniobravilidad * unFactorDeReduccion .! !


!NaveEspacial methodsFor: 'accessing' stamp: 'HAW 18/Sep/2026, 1:35:12 pm (UTC)'!
escudos
	
	^ nivelEscudo .! !

!NaveEspacial methodsFor: 'accessing' stamp: 'HAW 18/Sep/2026, 1:15:53 pm (UTC)'!
tipoPropulsor

	^tipoDePropulsor .! !


!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 1:06:12 pm (UTC)'!
dañada
	
	^ nivelDaño >= 1.! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 1:21:29 pm (UTC)'!
fuerzaDeEscudosEn: unNivelDeEscudos

	^ nivelEscudo = unNivelDeEscudos .! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 1:06:42 pm (UTC)'!
nivelDeDañoEs: unNivelDeDaño

	^ nivelDaño = unNivelDeDaño .! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 12:54:52 pm (UTC)'!
operativa

	^ nivelDaño <= nivelMaximoDaño .! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 12:48:05 pm (UTC)'!
sinCombustible
	
	^combustible <= 0.! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 18/Sep/2026, 1:05:53 pm (UTC)'!
tieneCombustible
	
	^combustible >=  0.! !

!NaveEspacial methodsFor: 'testing' stamp: 'HAW 16/Sep/2026, 4:07:38 pm (UTC)'!
valorCombustible: unNivelDeCombustible

	^ combustible  = unNivelDeCombustible .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveEspacial class' category: #'ISW-Parcial1-1C25'!
NaveEspacial class
	instanceVariableNames: ''!

!NaveEspacial class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 1:18:40 pm (UTC)'!
contrabandistaConGravitones
	
	^ self withManiobravilidad: 70 escudos: 50  combustible: 95  maxinoNivelDeDañoEnCasco: 2 yPropulsores: #Gravitones ! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 12:47:38 pm (UTC)'!
contrabandistaConImpulsoEstandar

	^self withManiobravilidad: 70 escudos: 50  combustible: 95  maxinoNivelDeDañoEnCasco: 2 yPropulsores: #ImpulsoEstandar ! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 1:14:19 pm (UTC)'!
contrabandistaConVelocidadLuz

	^self withManiobravilidad: 70 escudos: 50  combustible: 95  maxinoNivelDeDañoEnCasco: 2  yPropulsores: #VelocidadLuz ! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'HAW 16/Sep/2026, 4:02:16 pm (UTC)'!
cruceroPesadoConImpulsorEstandar


	^self  withManiobravilidad: 50 escudos: 100 combustible: 50 maxinoNivelDeDañoEnCasco: 5 yPropulsores: #ImpulsoEstandar! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'HAW 16/Sep/2026, 4:03:09 pm (UTC)'!
withManiobravilidad: maniobravilidad escudos: unNivelDeEscudo combustible: combustible maxinoNivelDeDañoEnCasco: maximoNivelDaño yPropulsores: unTipoDePropulsor 
	
	^self new initializeWithManiobravilidad: maniobravilidad escudos: unNivelDeEscudo combustible: combustible maxinoNivelDeDañoEnCasco: maximoNivelDaño yPropulsores: unTipoDePropulsor ! !


!classDefinition: #Sector category: #'ISW-Parcial1-1C25'!
Object subclass: #Sector
	instanceVariableNames: 'gravedad radiacion tipoDeSector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Sector methodsFor: 'accessing' stamp: 'HAW 18/Sep/2026, 12:39:02 pm (UTC)'!
tipo

	^tipoDeSector .! !


!Sector methodsFor: 'condiciones' stamp: 'HAW 18/Sep/2026, 1:12:15 pm (UTC)'!
gravedadSuperaManiobravilidad: unaManiobravilidad

	^ gravedad > unaManiobravilidad .! !

!Sector methodsFor: 'condiciones' stamp: 'HAW 18/Sep/2026, 1:11:33 pm (UTC)'!
radiacionSuperaEscudos: unNivelDeEscudos

	^ radiacion > unNivelDeEscudos .! !


!Sector methodsFor: 'initialization' stamp: 'HAW 16/Sep/2026, 4:13:35 pm (UTC)'!
initializeDeTipo: unTipoDeSector conGravedad: unaGravedad yRadiacion: unaRadiacion 
	
	tipoDeSector := unTipoDeSector.
	gravedad := unaGravedad.
	radiacion := unaRadiacion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: #'ISW-Parcial1-1C25'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 1:22:39 pm (UTC)'!
asteroidesConGravedad: gravedad yRadiacion: radiacion 
	
	^ self deTipo: #Asteroides conGravedad: gravedad  yRadiacion: radiacion .! !

!Sector class methodsFor: 'instance creation' stamp: 'HAW 16/Sep/2026, 4:13:13 pm (UTC)'!
deTipo: unTipoDeSector conGravedad: gravedad yRadiacion: radiacion 
	
	^self new initializeDeTipo: unTipoDeSector conGravedad: gravedad yRadiacion: radiacion ! !

!Sector class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 1:31:54 pm (UTC)'!
nebulosaConGravedad: gravedad yRadiacion: radiacion 
	
	^ self deTipo: #Nebulosa conGravedad: gravedad  yRadiacion: radiacion ! !

!Sector class methodsFor: 'instance creation' stamp: 'HAW 18/Sep/2026, 12:58:48 pm (UTC)'!
planetarioConGravedad: gravedad yRadiacion: radiacion 

	^self deTipo: #Planetario conGravedad: gravedad yRadiacion: radiacion .! !


!classDefinition: #EscapeDeFlotaTests category: #'ISW-Parcial1-1C25'!
TestCase subclass: #EscapeDeFlotaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 10/Jul/2025, 10:58:18 pm (UTC)'!
test01LaFlotaDebeTenerAlMenosUnaNave
	
	self 
		should: [ EscapeDeFlota enrolar: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 10/Jul/2025, 10:58:49 pm (UTC)'!
test02LaFlotaNoPuedeTenerNavesDuplicadas

	| cruceroPesadoConImpulsoEstandar |
	
	cruceroPesadoConImpulsoEstandar := self nuevoCruceroPesadoConImpulsoEstandar.
	
	self 
		should: [ EscapeDeFlota enrolar: { cruceroPesadoConImpulsoEstandar. cruceroPesadoConImpulsoEstandar } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 17/Jul/2025, 8:58:13 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 17/Jul/2025, 8:58:22 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:58 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:39 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:34 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:30 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:25 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:21 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:15 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:11 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:07 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:06:02 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:05:58 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:05:53 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:05:48 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 1:47:51 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:05:37 am (UTC)'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 18/Jul/2025, 12:05:31 am (UTC)'!
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


!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'HAW 18/Sep/2026, 1:18:13 pm (UTC)'!
nuevaNaveContrabandistaConGravitones

	^ NaveEspacial contrabandistaConGravitones! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'HAW 18/Sep/2026, 12:46:23 pm (UTC)'!
nuevaNaveContrabandistaConImpulsoEstandar

	^NaveEspacial contrabandistaConImpulsoEstandar! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'HAW 18/Sep/2026, 1:13:42 pm (UTC)'!
nuevaNaveContrabandistaConVelocidadLuz

	^ NaveEspacial contrabandistaConVelocidadLuz.! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'HAW 16/Sep/2026, 3:58:52 pm (UTC)'!
nuevoCruceroPesadoConImpulsoEstandar

	^ NaveEspacial cruceroPesadoConImpulsorEstandar ! !


!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'HAW 18/Sep/2026, 1:22:12 pm (UTC)'!
nuevoSectorDeAsteroidesConGravedad: gravedad yRadiacion: radiacion

	^ Sector asteroidesConGravedad: gravedad yRadiacion: radiacion .! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'HAW 18/Sep/2026, 1:32:21 pm (UTC)'!
nuevoSectorNebulosaConGravedad: gravedad yRadiacion: radiacion
 
	^ Sector nebulosaConGravedad: gravedad yRadiacion: radiacion .! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'HAW 16/Sep/2026, 4:12:07 pm (UTC)'!
nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion

	^ Sector planetarioConGravedad: gravedad yRadiacion: radiacion .
! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'HAW 18/Sep/2026, 12:51:09 pm (UTC)'!
nuevoTrayectoDeSectoresPlanetariosDeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion

	^ (1 to: numeroDeSectores ) collect: [:indice |
			self nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion .
		].
	! !


!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 28/Sep/2025, 3:33:03 am (UTC)'!
propulsoresDeGravitones

	self shouldBeImplemented ! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 28/Sep/2025, 3:32:59 am (UTC)'!
propulsoresDeImpulsoEstandar

	self shouldBeImplemented ! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 28/Sep/2025, 3:32:53 am (UTC)'!
propulsoresDeVelocidadLuz

	self shouldBeImplemented ! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 61 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 56 53 60 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 63 65 59 64 65 59 57 39 74 118 116 119 112 115 108 121 65 39 56 56 53 59 53 55 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 55 57 65 56 59 53 64 60 63 63 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 61 63 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 60 56 65 56 59 53 60 59 63 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 64 58 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 58 59 65 56 60 53 60 57 55 57 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 55 61 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 59 65 56 55 53 59 61 55 62 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 61 65 56 59 53 57 60 58 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 56 61 65 56 59 53 59 55 60 58 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 61 65 60 61 53 63 61 64 56 64 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 62 65 56 64 53 57 57 59 64 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 57 65 60 57 65 57 58 53 60 64 63 57 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 64 55 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 59 65 60 59 65 56 61 53 63 55 56 58 55 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 59 61 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 63 65 58 61 53 64 60 64 61 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 64 65 56 59 53 58 60 57 60 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 57 55 65 55 55 65 57 61 53 58 64 57 62 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 56 58 65 57 57 53 58 61 60 64 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 63 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 57 59 65 60 56 53 59 57 63 62 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 57 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 59 62 65 55 56 53 62 63 55 61 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 58 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 56 65 55 63 65 59 63 53 57 59 57 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 62 55 64 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 57 65 59 57 65 59 58 53 64 64 59 57 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 62 62 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 58 65 56 61 65 59 57 53 58 64 60 57 59 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 60 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 56 56 65 56 57 53 55 58 64 56 60 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 60 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 57 55 65 60 57 53 55 61 55 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 62 63 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 61 65 55 61 53 62 64 64 61 55 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 63 65 57 55 53 58 63 62 61 61 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 60 56 65 57 64 53 61 58 63 57 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 60 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 55 64 65 60 60 65 59 64 53 55 64 59 59 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 61 56 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 59 65 57 56 53 57 64 63 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 57 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 61 65 58 60 53 63 64 63 59 58 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 64 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 55 56 53 63 57 55 63 61 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 58 55 53 62 59 61 62 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 55 56 65 59 59 53 57 63 57 63 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 111 118 115 104 53 122 123 17 58 56 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 58 63 65 55 55 53 56 64 59 60 59 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 61 62 59 57 17 52 52 52 52 52 52 52 52 52 52 17 17))!