!classDefinition: #CapaDeSuelo category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'initialization' stamp: 'HAW 21/Sep/2026, 9:18:18 pm (UTC)'!
initializeConAltura: unaAltura 
	
	altura := unaAltura.
! !


!CapaDeSuelo methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:35:07 pm (UTC)'!
siendoPerforadaPorMechaDeDiamanteUtilizando: unaPerforadora

	self subclassResponsibility .! !

!CapaDeSuelo methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:49:53 pm (UTC)'!
siendoPerforadaPorMechaDeWidiaUtilizando: unaPerforadora 
	
	self subclassResponsibility .! !

!CapaDeSuelo methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:46:31 pm (UTC)'!
siendoPerforadaPorMechaSoftUtilizando: unaPerforadora 
	
	self subclassResponsibility .! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'HAW 21/Sep/2026, 9:26:17 pm (UTC)'!
= unaCapaDeSuelo

		^(unaCapaDeSuelo isKindOf: self class) and: [ unaCapaDeSuelo tieneMismaAltura: altura ].
! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'HAW 21/Sep/2026, 9:25:47 pm (UTC)'!
hash

	^altura hash.! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'HAW 21/Sep/2026, 9:26:29 pm (UTC)'!
tieneMismaAltura: unaAltura

	^ altura = unaAltura ! !


!CapaDeSuelo methodsFor: 'accesing' stamp: 'HAW 21/Sep/2026, 9:56:30 pm (UTC)'!
altura
	
	^altura! !

!CapaDeSuelo methodsFor: 'accesing' stamp: 'HAW 21/Sep/2026, 9:57:17 pm (UTC)'!
tipo
	
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 9:20:44 pm (UTC)'!
arenosoConAltura: unaAltura

	^Arenoso conAltura: unaAltura.! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 9:20:02 pm (UTC)'!
conAltura: unaAltura 

	^self new initializeConAltura: unaAltura ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 9:29:28 pm (UTC)'!
concretoConAltura: unaAltura yConResistencia: unaResistencia

	^ Concreto conAltura: unaAltura yResistencia: unaResistencia .
	! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 9:20:49 pm (UTC)'!
tierraConAltura: unaAltura
	
	^ Tierra conAltura: unaAltura.! !


!classDefinition: #Arenoso category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Arenoso methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:43:37 pm (UTC)'!
siendoPerforadaPorMechaDeDiamanteUtilizando: unaPerforadora 
	"Se rompe la mecha"
	unaPerforadora romperMecha ! !

!Arenoso methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:50:16 pm (UTC)'!
siendoPerforadaPorMechaDeWidiaUtilizando: unaPerforadora 
	
	"Remueve capa inmediata"
	unaPerforadora removerCapaInmediata ! !

!Arenoso methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:46:59 pm (UTC)'!
siendoPerforadaPorMechaSoftUtilizando: unaPerforadora 
	"Remueve capa inmediata"
	unaPerforadora removerCapaInmediata .! !


!Arenoso methodsFor: 'accesing' stamp: 'HAW 21/Sep/2026, 9:57:27 pm (UTC)'!
tipo
	^ #Arenoso.! !


!classDefinition: #Concreto category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Concreto methodsFor: 'comparing' stamp: 'HAW 21/Sep/2026, 9:55:56 pm (UTC)'!
= unaCapaDeSuelo 

	^(unaCapaDeSuelo isKindOf: self class) and: [  resistencia = unaCapaDeSuelo resistencia].! !

!Concreto methodsFor: 'comparing' stamp: 'HAW 21/Sep/2026, 9:23:15 pm (UTC)'!
hash

	^tipoDeSuelo hash + resistencia hash! !


!Concreto methodsFor: 'recibir impacto' stamp: 'HAW 21/Sep/2026, 9:24:19 pm (UTC)'!
bajarResistenciaEnUnDecimo
	
	resistencia := resistencia - 1.! !


!Concreto methodsFor: 'accessing' stamp: 'HAW 21/Sep/2026, 9:24:32 pm (UTC)'!
resistencia

	^ resistencia .! !


!Concreto methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:42:10 pm (UTC)'!
siendoPerforadaPorMechaDeDiamanteUtilizando: unaPerforadora

	unaPerforadora luegoDeImpactos: 2 hacer: [self bajarResistenciaEnUnDecimo ]! !

!Concreto methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:51:26 pm (UTC)'!
siendoPerforadaPorMechaDeWidiaUtilizando: unaPerforadora 
	
	unaPerforadora luegoDeImpactos: 3 hacer: [unaPerforadora romperMecha ] ! !

!Concreto methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:52:04 pm (UTC)'!
siendoPerforadaPorMechaSoftUtilizando: unaPerforadora 
	
	unaPerforadora romperMecha .! !


!Concreto methodsFor: 'initialization' stamp: 'HAW 21/Sep/2026, 9:18:51 pm (UTC)'!
initializeConAltura: unaAltura yResistencia: unaResistencia
	
	altura := unaAltura.
	resistencia := unaResistencia .! !


!Concreto methodsFor: 'accesing' stamp: 'HAW 21/Sep/2026, 9:57:53 pm (UTC)'!
tipo
	^ #Concreto! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Concreto class' category: #'ISW1-2024-1C-Parcial-1'!
Concreto class
	instanceVariableNames: ''!

!Concreto class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 9:22:28 pm (UTC)'!
conAltura: unaAltura yResistencia: unaResistencia

	^ self new initializeConAltura: unaAltura yResistencia: unaResistencia ! !


!classDefinition: #Tierra category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Tierra methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:39:30 pm (UTC)'!
siendoPerforadaPorMechaDeDiamanteUtilizando: unaPerforadora 

	"Remueve la capa inmediata"
	unaPerforadora removerCapaInmediata .! !

!Tierra methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:50:57 pm (UTC)'!
siendoPerforadaPorMechaDeWidiaUtilizando: unaPerforadora 
	
	unaPerforadora luegoDeImpactos: 2 hacer: [unaPerforadora transformarCapaEnArenoso ] ! !

!Tierra methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:47:16 pm (UTC)'!
siendoPerforadaPorMechaSoftUtilizando: unaPerforadora 
	
	! !


!Tierra methodsFor: 'accesing' stamp: 'HAW 21/Sep/2026, 9:57:43 pm (UTC)'!
tipo
	^ #Tierra.! !


!classDefinition: #MechaDePerforadora category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #MechaDePerforadora
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaDePerforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:12:39 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unTipoDeCapa

	self subclassResponsibility .! !


!MechaDePerforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 9:55:15 pm (UTC)'!
estaRota
	
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MechaDePerforadora class' category: #'ISW1-2024-1C-Parcial-1'!
MechaDePerforadora class
	instanceVariableNames: ''!

!MechaDePerforadora class methodsFor: 'error message' stamp: 'HAW 21/Sep/2026, 9:07:38 pm (UTC)'!
noSePuedePerforarConMechaRotaErrorMessage

	^ 'No se puede perforar con mecha rota'! !

!MechaDePerforadora class methodsFor: 'error message' stamp: 'HAW 21/Sep/2026, 9:08:40 pm (UTC)'!
sinMechaErrorMessage

	^'No puede perforar'! !


!classDefinition: #MechaFuncional category: #'ISW1-2024-1C-Parcial-1'!
MechaDePerforadora subclass: #MechaFuncional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaFuncional methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:45:44 pm (UTC)'!
utilizadaPor: aPerforadora sobre: aRenameMe 
	
	self subclassResponsibility .! !


!classDefinition: #MechaDiamante category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaDiamante methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:30:28 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unaCapa

	
	unaCapa siendoPerforadaPorMechaDeDiamanteUtilizando: unaPerforadora .! !


!classDefinition: #MechaSoft category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaSoft methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:46:20 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unaCapaDeSuelo

	unaCapaDeSuelo siendoPerforadaPorMechaSoftUtilizando: unaPerforadora 
	
	! !


!classDefinition: #MechaWidia category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaWidia methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:49:45 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unaCapaDeSuelo

	unaCapaDeSuelo siendoPerforadaPorMechaDeWidiaUtilizando: unaPerforadora ! !


!classDefinition: #MechaRota category: #'ISW1-2024-1C-Parcial-1'!
MechaDePerforadora subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaRota methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 9:55:27 pm (UTC)'!
estaRota

	^ true. ! !


!MechaRota methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:12:39 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unTipoDeCapa 

	self error: MechaDePerforadora noSePuedePerforarConMechaRotaErrorMessage.! !


!classDefinition: #SinMecha category: #'ISW1-2024-1C-Parcial-1'!
MechaDePerforadora subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!SinMecha methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:12:39 pm (UTC)'!
utilizadaPor: unaPerforadora sobre: unTipoDeCapa 

	self error: MechaDePerforadora sinMechaErrorMessage! !


!classDefinition: #Perforadora category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Perforadora methodsFor: 'initialization' stamp: 'HAW 21/Sep/2026, 9:45:10 pm (UTC)'!
initializeSobreSuelo: sueloAExcavar 
	
	capasDeSueloDebajo := sueloAExcavar asOrderedCollection .
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.
	vecesQueGolpeoCapaActual := 0.
	! !


!Perforadora methodsFor: 'cambio mecha' stamp: 'HAW 21/Sep/2026, 9:44:49 pm (UTC)'!
ponerMechaDiamante
	
	mechaPuesta := MechaDiamante new! !

!Perforadora methodsFor: 'cambio mecha' stamp: 'HAW 21/Sep/2026, 9:44:54 pm (UTC)'!
ponerMechaSoft
	
	mechaPuesta := MechaSoft new.! !

!Perforadora methodsFor: 'cambio mecha' stamp: 'HAW 21/Sep/2026, 9:44:59 pm (UTC)'!
ponerMechaWidia
	
	mechaPuesta := MechaWidia new.! !

!Perforadora methodsFor: 'cambio mecha' stamp: 'HAW 21/Sep/2026, 9:54:07 pm (UTC)'!
romperMecha

	mechaPuesta := MechaRota new.
	
	self error: Perforadora mechaRotaErrorMessage.! !


!Perforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 10:03:11 pm (UTC)'!
darGolpeDeTaladro
	
	mechaPuesta utilizadaPor: self sobre: self capaDeSueloInmediata . 
	
	! !

!Perforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 7:54:44 pm (UTC)'!
darImpactoACapaDeSuelo
	
	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.! !

!Perforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:43:04 pm (UTC)'!
luegoDeImpactos: unaCantidadDeImpactos hacer: unBloqueDePerforacion

	self darImpactoACapaDeSuelo .
	vecesQueGolpeoCapaActual = unaCantidadDeImpactos ifTrue: [
			unBloqueDePerforacion value.
		]! !

!Perforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:03:04 pm (UTC)'!
removerCapaInmediata
	
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst .
	self recolectarPiedrasInmediatas.! !

!Perforadora methodsFor: 'perforar' stamp: 'HAW 21/Sep/2026, 9:03:28 pm (UTC)'!
transformarCapaEnArenoso
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst asOrderedCollection 
	addFirst: (CapaDeSuelo arenosoConAltura: 0);
	yourself .! !


!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 10:07:42 pm (UTC)'!
calcularProfundidadDelSuelo
	
	^ capasDeSueloDebajo sum: [:capa | capa altura ]! !

!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 10:06:23 pm (UTC)'!
calcularProfundidadDelSueloHasta: tipoDeCapa

    | profundidad |
    profundidad := 0.
    capasDeSueloDebajo do: [ :capa |
            (capa isKindOf: tipoDeCapa) ifTrue: [ ^ profundidad ].
            profundidad := profundidad + capa altura.
    ].
    ^ profundidad! !

!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 7:56:14 pm (UTC)'!
capaDeSueloInmediata
	
	^ capasDeSueloDebajo first.! !

!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 9:54:58 pm (UTC)'!
conMechaRota

	^ mechaPuesta estaRota.! !

!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 10:05:20 pm (UTC)'!
contarCapas: tipoDeCapa

	^ capasDeSueloDebajo count: [:capa | capa isKindOf: tipoDeCapa ]
	! !

!Perforadora methodsFor: 'testing' stamp: 'HAW 21/Sep/2026, 8:06:39 pm (UTC)'!
elementsInContainer
	
	^ container asArray .! !


!Perforadora methodsFor: 'recolectar' stamp: 'HAW 21/Sep/2026, 8:13:13 pm (UTC)'!
recolectarPiedrasInmediatas

[ capasDeSueloDebajo notEmpty and: [ (capasDeSueloDebajo first isKindOf: CapaDeSuelo) not ] ]
        whileTrue: [
            container add: capasDeSueloDebajo removeFirst ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: #'ISW1-2024-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'error message' stamp: 'HAW 21/Sep/2026, 8:28:04 pm (UTC)'!
mechaRotaErrorMessage

	^ 'Se rompió'! !


!Perforadora class methodsFor: 'instance creation' stamp: 'HAW 21/Sep/2026, 7:26:48 pm (UTC)'!
sobreSuelo: sueloAExcavar 

	^self new initializeSobreSuelo: sueloAExcavar ! !


!classDefinition: #TestDePerforación category: #'ISW1-2024-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:43 pm (UTC)'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo tierraConAltura: 0 )equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:52 pm (UTC)'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo tierraConAltura: 0 )equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:10 pm (UTC)'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5.
			CapaDeSuelo tierraConAltura: 0.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:32:14 pm (UTC)'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo tierraConAltura: 0) equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:32:24 pm (UTC)'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo arenosoConAltura: 0) equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:10 pm (UTC)'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5.	
			CapaDeSuelo tierraConAltura: 0.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:10 pm (UTC)'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:10 pm (UTC)'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAltura: 0.
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConAltura: 0 yConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:31:10 pm (UTC)'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConAltura: 0 yConResistencia: 5.
			CapaDeSuelo tierraConAltura: 0.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConAltura: 0 yConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:29:35 pm (UTC)'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:29:35 pm (UTC)'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:29:35 pm (UTC)'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAltura: 0.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenosoConAltura: 0) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:33:10 pm (UTC)'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2 . CapaDeSuelo tierraConAltura: 40 . CapaDeSuelo arenosoConAltura: 0} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 10:06:29 pm (UTC)'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2. CapaDeSuelo tierraConAltura: 0. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapas: Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 10:06:33 pm (UTC)'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2. CapaDeSuelo tierraConAltura:  40. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 10:06:36 pm (UTC)'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura:  2. CapaDeSuelo tierraConAltura: 40. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: Concreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 10:06:39 pm (UTC)'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2. CapaDeSuelo tierraConAltura: 40. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 10:06:42 pm (UTC)'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura:  2. CapaDeSuelo tierraConAltura:  40. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 21/Sep/2026, 8:34:53 pm (UTC)'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2. CapaDeSuelo tierraConAltura:  40. CapaDeSuelo arenosoConAltura: 0. CapaDeSuelo concretoConAltura: 0 yConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: #Concreto).

	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 61 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 56 53 60 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 63 65 59 64 65 59 57 39 74 118 116 119 112 115 108 121 65 39 56 56 53 59 53 55 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 55 57 65 56 59 53 64 60 63 63 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 61 63 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 60 56 65 56 59 53 60 59 63 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 64 58 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 58 59 65 56 60 53 60 57 55 57 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 55 61 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 59 65 56 55 53 59 61 55 62 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 61 65 56 59 53 57 60 58 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 56 61 65 56 59 53 59 55 60 58 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 61 65 60 61 53 63 61 64 56 64 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 62 65 56 64 53 57 57 59 64 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 57 65 60 57 65 57 58 53 60 64 63 57 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 64 55 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 59 65 60 59 65 56 61 53 63 55 56 58 55 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 59 61 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 63 65 58 61 53 64 60 64 61 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 64 65 56 59 53 58 60 57 60 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 57 55 65 55 55 65 57 61 53 58 64 57 62 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 56 58 65 57 57 53 58 61 60 64 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 63 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 57 59 65 60 56 53 59 57 63 62 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 57 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 59 62 65 55 56 53 62 63 55 61 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 58 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 56 65 55 63 65 59 63 53 57 59 57 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 62 55 64 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 57 65 59 57 65 59 58 53 64 64 59 57 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 62 62 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 58 65 56 61 65 59 57 53 58 64 60 57 59 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 60 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 56 56 65 56 57 53 55 58 64 56 60 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 60 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 57 55 65 60 57 53 55 61 55 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 62 63 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 61 65 55 61 53 62 64 64 61 55 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 63 65 57 55 53 58 63 62 61 61 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 60 56 65 57 64 53 61 58 63 57 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 60 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 55 64 65 60 60 65 59 64 53 55 64 59 59 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 61 56 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 59 65 57 56 53 57 64 63 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 57 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 61 65 58 60 53 63 64 63 59 58 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 64 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 55 56 53 63 57 55 63 61 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 58 55 53 62 59 61 62 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 55 56 65 59 59 53 57 63 57 63 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 111 118 115 104 53 122 123 17 58 56 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 58 63 65 55 55 53 56 64 59 60 59 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 61 62 59 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 57 65 56 62 65 60 56 53 62 58 64 60 59 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 58 59 56 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 57 65 57 58 65 56 64 53 57 62 63 59 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 58 58 57 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 56 65 55 62 65 55 58 53 63 61 56 55 55 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 61 60 58 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 56 65 59 60 65 55 60 53 58 64 55 57 57 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 64 55 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 56 65 60 62 65 55 64 53 60 55 62 57 56 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 63 58 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 56 65 60 62 65 58 56 53 62 61 57 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 58 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 57 65 56 55 65 60 56 53 64 55 56 59 63 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 61 62 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 57 65 56 57 65 55 56 53 62 55 62 64 61 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 61 62 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 57 65 56 57 65 58 61 53 60 60 55 56 55 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 61 62 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 57 65 60 56 65 55 62 53 57 57 57 62 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 60 61 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 57 65 60 58 65 57 62 53 55 55 56 56 56 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 63 60 57 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 57 56 91 56 61 65 59 57 65 59 61 53 60 64 64 63 59 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 111 118 115 104 53 122 123 17 56 57 61 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 57 56 91 56 62 65 57 56 65 57 63 53 59 56 64 62 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 61 61 60 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 57 56 91 56 63 65 58 58 65 56 57 53 57 59 57 60 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 57 56 59 55 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 57 56 91 56 63 65 60 63 65 58 64 53 57 56 55 58 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 57 60 55 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 57 56 91 56 64 65 55 63 65 60 60 53 59 59 55 61 57 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 56 74 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 57 59 56 56 61 17 52 52 52 52 52 52 52 52 52 52 17 17))!