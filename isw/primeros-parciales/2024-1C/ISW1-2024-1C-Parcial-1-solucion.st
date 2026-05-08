!classDefinition: #CapaDeSuelo category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!


!CapaDeSuelo methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:19:25'!
aSerPerforadoPor: unaPeforadora

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 11:05:55'!
arenosoConAltura: unaAltura

	^CapaArenosa new initializeConAltura: unaAltura .! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 11:09:03'!
arenosoConAlturaCero

	^CapaArenosa new initializeConAltura: 0.! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 09:13:36'!
concretoConResistencia: resistencia 
	
	^CapaDeConcreto new initializeConResistencia: resistencia .
	"
	^self new initializeConcretoConResistencia: resistencia "! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 11:06:15'!
tierraConAltura: unaAltura

	^CapaDeTierra new initializeConAltura: unaAltura .! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 11:08:44'!
tierraConAlturaCero

	^CapaDeTierra new initializeConAltura: 0.! !


!classDefinition: #CapaConPiedras category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaConPiedras
	instanceVariableNames: 'piedras'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaConPiedras methodsFor: 'perforar' stamp: 'Ma 5/8/2026 11:42:55'!
aSerPerforadoPor: unaPeforadora

	"Significa que encontramos piedras debemos meterlas en el container"
	
	unaPeforadora recolectarPiedraEncontrada: piedras .
	
	unaPeforadora pasarAProximaCapa .
! !


!CapaConPiedras methodsFor: 'initialization' stamp: 'Ma 5/8/2026 08:52:52'!
initializeCon: unasPiedras

	piedras := unasPiedras .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaConPiedras class' category: #'ISW1-2024-1C-Parcial-1'!
CapaConPiedras class
	instanceVariableNames: ''!

!CapaConPiedras class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 08:54:38'!
con: unasPiedras

	^self new initializeCon: unasPiedras .! !


!classDefinition: #CapaDeSueloPerforable category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaDeSueloPerforable
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaDeSueloPerforable methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:17:43'!
esArenoso

	self subclassResponsibility 
	! !

!CapaDeSueloPerforable methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:17:32'!
esConcreto

	self subclassResponsibility .! !

!CapaDeSueloPerforable methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:17:50'!
esTierra

	self subclassResponsibility .! !


!CapaDeSueloPerforable methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:28:48'!
scan

	self subclassResponsibility .! !


!CapaDeSueloPerforable methodsFor: 'altura' stamp: 'Ma 5/8/2026 09:30:58'!
altura

	^ altura.! !


!CapaDeSueloPerforable methodsFor: 'resistencia' stamp: 'Ma 5/8/2026 09:34:45'!
resistencia

	^0.! !


!CapaDeSueloPerforable methodsFor: 'initialization' stamp: 'Ma 5/8/2026 09:14:42'!
initializeConAltura: unaAltura

	altura := unaAltura .! !


!CapaDeSueloPerforable methodsFor: 'hash' stamp: 'Ma 5/8/2026 09:36:13'!
hash
    ^self class hash + self resistencia hash! !



!CapaDeSueloPerforable methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:25:32'!
aSerPerforadoPor: unaPeforadora

	"Delegamos a las subclases"
	
	self subclassResponsibility .! !


!CapaDeSueloPerforable methodsFor: 'comparing' stamp: 'Ma 5/8/2026 09:36:32'!
= unaCapaDeSuelo
    ^(unaCapaDeSuelo isKindOf: self class) 
        and: [ self resistencia = unaCapaDeSuelo resistencia ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSueloPerforable class' category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSueloPerforable class
	instanceVariableNames: ''!

!CapaDeSueloPerforable class methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:54:56'!
scan

	self subclassResponsibility .! !



!classDefinition: #CapaArenosa category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #CapaArenosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaArenosa methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:29:02'!
scan

	^ 7! !


!CapaArenosa methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:14'!
esArenoso

	^true! !

!CapaArenosa methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:00'!
esConcreto

	^false.! !

!CapaArenosa methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:20'!
esTierra

	^false! !


!CapaArenosa methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:27:26'!
aSerPerforadoPor: unaPeforadora


	unaPeforadora perforandoSueloArenoso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaArenosa class' category: #'ISW1-2024-1C-Parcial-1'!
CapaArenosa class
	instanceVariableNames: ''!

!CapaArenosa class methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:55:32'!
scan

	^7! !


!classDefinition: #CapaDeConcreto category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #CapaDeConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaDeConcreto methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:40'!
esArenoso

	^false.! !

!CapaDeConcreto methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:32'!
esConcreto

	^true.! !

!CapaDeConcreto methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:26'!
esTierra

	^false! !


!CapaDeConcreto methodsFor: 'testing' stamp: 'Ma 5/8/2026 09:20:26'!
sinResistencia
	^resistencia = 0! !


!CapaDeConcreto methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:29:37'!
scan

	^50! !


!CapaDeConcreto methodsFor: 'bajar resistencia' stamp: 'Ma 5/8/2026 09:30:17'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !


!CapaDeConcreto methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:40:40'!
aSerPerforadoPor: unaPeforadora

	unaPeforadora perforandoSueloDeConcreto.! !


!CapaDeConcreto methodsFor: 'initialization' stamp: 'Ma 5/8/2026 09:15:27'!
initializeConResistencia: unaResistencia
	
	super initializeConAltura: 0.
	resistencia := unaResistencia .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeConcreto class' category: #'ISW1-2024-1C-Parcial-1'!
CapaDeConcreto class
	instanceVariableNames: ''!

!CapaDeConcreto class methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:55:53'!
scan

	^50! !


!classDefinition: #CapaDeTierra category: #'ISW1-2024-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #CapaDeTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!CapaDeTierra methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:29:23'!
scan

	^ 10 ! !


!CapaDeTierra methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:18:47'!
esArenoso

	^false.! !

!CapaDeTierra methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:19:02'!
esConcreto

	^false.! !

!CapaDeTierra methodsFor: 'tipo' stamp: 'Ma 5/8/2026 09:19:08'!
esTierra

	^true.! !


!CapaDeTierra methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:53:00'!
aSerPerforadoPor: unaPeforadora


	unaPeforadora perforandoSueloDeTierra.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeTierra class' category: #'ISW1-2024-1C-Parcial-1'!
CapaDeTierra class
	instanceVariableNames: ''!

!CapaDeTierra class methodsFor: 'scan' stamp: 'Ma 5/8/2026 09:56:04'!
scan

	^10.! !


!classDefinition: #Mecha category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Mecha methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:49:34'!
perforandoSueloArenosoPor: unaPerforadora

	self subclassResponsibility .! !

!Mecha methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:49:44'!
perforandoSueloDeConcretoPor: unaPerforadora

	self subclassResponsibility .! !

!Mecha methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:49:50'!
perforandoSueloDeTierraUsando: unaPerforadora

	self subclassResponsibility .! !


!Mecha methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:11:09'!
esMechaRota

	self subclassResponsibility .! !

!Mecha methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:13:05'!
sinMechaPuesta

	self subclassResponsibility .! !


!classDefinition: #MechaFuncional category: #'ISW1-2024-1C-Parcial-1'!
Mecha subclass: #MechaFuncional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaFuncional methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:32:13'!
perforandoSueloArenosoPor: unaPerforadora

	self subclassResponsibility .! !

!MechaFuncional methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:41:30'!
perforandoSueloDeConcretoPor: unaPerforadora

	self subclassResponsibility .! !

!MechaFuncional methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 10:53:47'!
perforandoSueloDeTierraUsando: unaPerforadora

	self subclassResponsibility .! !


!MechaFuncional methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:11:20'!
esMechaRota
	
	^false.! !

!MechaFuncional methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:13:05'!
sinMechaPuesta

	^false.! !


!classDefinition: #MechaDiamante category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaDiamante methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:31:28'!
perforandoSueloArenosoPor: unaPerforadora


	unaPerforadora golpeandoSueloArenosoUsandoMechaDeDiamante.! !

!MechaDiamante methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:31:43'!
perforandoSueloDeConcretoPor: unaPerforadora

		
	unaPerforadora golpeandoSueloDeConcretoUsandoMechaDeDiamante.! !

!MechaDiamante methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:31:59'!
perforandoSueloDeTierraUsando: unaPerforadora
	
	
	unaPerforadora golpeandoSueloDeTierraUsandoMechaDeDiamante.! !


!classDefinition: #MechaSoft category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaSoft methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:34:54'!
perforandoSueloArenosoPor: unaPerforadora


	unaPerforadora golpeandoSueloArenosoUsandoMechaSoft .! !

!MechaSoft methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:34:27'!
perforandoSueloDeConcretoPor: unaPerforadora

		
	unaPerforadora golpeandoSueloDeConcretoUsandoMechaSoft.! !

!MechaSoft methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:35:06'!
perforandoSueloDeTierraUsando: unaPerforadora
	
	
	unaPerforadora golpeandoSueloDeTierraUsandoMechaSoft.! !


!classDefinition: #MechaWidia category: #'ISW1-2024-1C-Parcial-1'!
MechaFuncional subclass: #MechaWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaWidia methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:35:20'!
perforandoSueloArenosoPor: unaPerforadora


	unaPerforadora golpeandoSueloArenosoUsandoMechaDeWidia.! !

!MechaWidia methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:35:31'!
perforandoSueloDeConcretoPor: unaPerforadora

		
	unaPerforadora golpeandoSueloDeConcretoUsandoMechaDeWidia.! !

!MechaWidia methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:35:45'!
perforandoSueloDeTierraUsando: unaPerforadora
	
	
	unaPerforadora golpeandoSueloDeTierraUsandoMechaDeWidia.! !


!classDefinition: #MechaRota category: #'ISW1-2024-1C-Parcial-1'!
Mecha subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!MechaRota methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:11:49'!
esMechaRota

	^true.! !

!MechaRota methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:13:05'!
sinMechaPuesta

	^false.! !


!MechaRota methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:50:31'!
perforandoSueloArenosoPor: unaPerforadora


	self error: unaPerforadora class noSePuedeGolpearConMechaRotaErrorDescription .! !

!MechaRota methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:50:51'!
perforandoSueloDeConcretoPor: unaPerforadora


	self error: unaPerforadora class noSePuedeGolpearConMechaRotaErrorDescription .! !

!MechaRota methodsFor: 'perforacion' stamp: 'Ma 5/8/2026 12:50:59'!
perforandoSueloDeTierraUsando: unaPerforadora


	self error: unaPerforadora class noSePuedeGolpearConMechaRotaErrorDescription .! !


!classDefinition: #SinMecha category: #'ISW1-2024-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!SinMecha methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:11:36'!
esMechaRota

	^false.! !

!SinMecha methodsFor: 'comparing' stamp: 'Ma 5/8/2026 10:13:05'!
sinMechaPuesta

	^true.! !


!classDefinition: #Perforadora category: #'ISW1-2024-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'Ma 5/8/2026 11:43:33'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	self primeraCapaDebajo aSerPerforadoPor: self! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'Ma 5/8/2026 11:09:03'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenosoConAlturaCero;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'Ma 5/8/2026 13:06:02'!
darGolpeDeTaladro
	|primeraCapa|
	self assertTieneMechaPuesta.
	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.
	
	primeraCapa := self primeraCapaDebajo.
	
	primeraCapa aSerPerforadoPor: self.
	
	"
	self sobreSueloArenoso ifTrue: [
		mechaPuesta = #Soft ifTrue: [ ^self pasarAProximaCapa ].
		mechaPuesta = #Widia ifTrue: [ ^self pasarAProximaCapa ].
		mechaPuesta = #Diamante ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió' ].
		^self].
	
	self sobreSueloTierra ifTrue: [
		mechaPuesta = #Soft ifTrue: [ ^self ].
		mechaPuesta = #Widia ifTrue: [ 
			vecesQueGolpeoCapaActual = 2 ifTrue: [ ^self transformarCapaEnArenoso ].
			^self ].
		mechaPuesta = #Diamante ifTrue: [ ^self pasarAProximaCapa ]].
	
	self sobreSueloConcreto ifTrue: [
		mechaPuesta = #Soft ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió'  ].
		mechaPuesta = #Widia ifTrue: [ 
			vecesQueGolpeoCapaActual = 3 ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió' ].
			^self ].
		mechaPuesta = #Diamante ifTrue: [ 
			vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
			capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
			^vecesQueGolpeoCapaActual ]].
	
	self error: 'error'"! !


!Perforadora methodsFor: 'initialization' stamp: 'Ma 5/8/2026 10:08:43'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2024 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'Ma 5/8/2026 10:10:45'!
conMechaRota

	^mechaPuesta esMechaRota.! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2024 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'Ma 5/8/2026 10:13:05'!
sinMecha

	^mechaPuesta sinMechaPuesta.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'Ma 5/8/2026 10:18:34'!
primeraCapaDebajo

	^capasDeSueloDebajo first .! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'Ma 5/8/2026 10:08:59'!
ponerMechaDiamante
	mechaPuesta := MechaDiamante new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'Ma 5/8/2026 10:09:05'!
ponerMechaSoft
	mechaPuesta := MechaSoft new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'Ma 5/8/2026 10:09:12'!
ponerMechaWidia
	mechaPuesta := MechaWidia new.! !


!Perforadora methodsFor: 'assert' stamp: 'Ma 5/8/2026 10:15:14'!
assertTieneMechaPuesta


	self sinMecha ifTrue: [self error: self class sinMechaPuestaNoSePuedePerforarMensajeDeError].! !


!Perforadora methodsFor: 'recolectar piedras' stamp: 'Ma 5/8/2026 10:23:49'!
recolectarPiedraEncontrada: unaPiedra

	container addLast: unaPiedra .! !


!Perforadora methodsFor: 'perforando suelo' stamp: 'Ma 5/8/2026 10:31:01'!
perforandoSueloArenoso

	mechaPuesta perforandoSueloArenosoPor: self.! !

!Perforadora methodsFor: 'perforando suelo' stamp: 'Ma 5/8/2026 10:41:11'!
perforandoSueloDeConcreto

	mechaPuesta perforandoSueloDeConcretoPor: self.! !

!Perforadora methodsFor: 'perforando suelo' stamp: 'Ma 5/8/2026 10:53:31'!
perforandoSueloDeTierra

	mechaPuesta perforandoSueloDeTierraUsando: self.! !


!Perforadora methodsFor: 'romper mecha' stamp: 'Ma 5/8/2026 10:39:04'!
romperMecha

	mechaPuesta := MechaRota new.! !


!Perforadora methodsFor: 'golpeando con mecha soft' stamp: 'Ma 5/8/2026 12:34:40'!
golpeandoSueloArenosoUsandoMechaSoft
	"Si estoy en suelo arenoso con mecha soft perforamos y pasamos a la siguiente capa"
	^self pasarAProximaCapa .! !

!Perforadora methodsFor: 'golpeando con mecha soft' stamp: 'Ma 5/8/2026 12:34:27'!
golpeandoSueloDeConcretoUsandoMechaSoft

	"Si es mecha soft sobre suelo de concreo la mecha se rompe"
	self romperMecha .
	self error: self class mechaRotaMensajeDeError .! !

!Perforadora methodsFor: 'golpeando con mecha soft' stamp: 'Ma 5/8/2026 12:35:06'!
golpeandoSueloDeTierraUsandoMechaSoft
	"Golpear con mecha soft suelo de tierra no hace nada"
	^self.! !


!Perforadora methodsFor: 'golpes' stamp: 'Ma 5/8/2026 11:11:03'!
golpeo: unaCantidadDeVeces

	^vecesQueGolpeoCapaActual  = unaCantidadDeVeces .! !


!Perforadora methodsFor: 'golpeando con mecha widia' stamp: 'Ma 5/8/2026 12:35:20'!
golpeandoSueloArenosoUsandoMechaDeWidia

"Si estoy en suelo arenoso con mecha de widia perforamos y pasamos a siguiente capa"

	^self pasarAProximaCapa .! !

!Perforadora methodsFor: 'golpeando con mecha widia' stamp: 'Ma 5/8/2026 12:35:31'!
golpeandoSueloDeConcretoUsandoMechaDeWidia

	"Si es mecha de widia en suelo de concreto, si golpeo mas de 3 veces se rompe, si no no hace nada"
	
	(self golpeo: 3) ifTrue: [self  romperMecha; error: self class mechaRotaMensajeDeError ].
	
	^self.! !

!Perforadora methodsFor: 'golpeando con mecha widia' stamp: 'Ma 5/8/2026 12:35:45'!
golpeandoSueloDeTierraUsandoMechaDeWidia

	"Si perforo suelo de tierra usando mecha de widia, si golpee 2 veces se tranforma en suelo areno, si no no hace nada"
	
	(self golpeo: 2) ifTrue: [^self transformarCapaEnArenoso ].
	^self.! !


!Perforadora methodsFor: 'bajar resistencia' stamp: 'Ma 5/8/2026 10:51:01'!
bajarResistenciaSiGolpeNumeroParDeVeces

	vecesQueGolpeoCapaActual even ifTrue: [self primeraCapaDebajo bajaUnDecimoDeResistencia ].! !

!Perforadora methodsFor: 'bajar resistencia' stamp: 'Ma 5/8/2026 10:51:35'!
convertirEnCapaArenosaSiNoTieneResistencia

	self primeraCapaDebajo sinResistencia ifTrue: [^self transformarCapaEnArenoso ].! !


!Perforadora methodsFor: 'golpeando con mecha diamante' stamp: 'Ma 5/8/2026 12:31:28'!
golpeandoSueloArenosoUsandoMechaDeDiamante

	"si estoy en suelo arenoso con mecha de diamante la mecha se rompe"
	
	self romperMecha.
	self error: self class mechaRotaMensajeDeError.
! !

!Perforadora methodsFor: 'golpeando con mecha diamante' stamp: 'Ma 5/8/2026 12:31:43'!
golpeandoSueloDeConcretoUsandoMechaDeDiamante

	"Si es suelo de concreto con mecha de diamante, si golpeamos cantidad par baja un decimo la resistencia, si ya no tiene resistencia se convierte en capa de arena"
	
	self bajarResistenciaSiGolpeNumeroParDeVeces;
	convertirEnCapaArenosaSiNoTieneResistencia.
	
	^vecesQueGolpeoCapaActual .
	
	! !

!Perforadora methodsFor: 'golpeando con mecha diamante' stamp: 'Ma 5/8/2026 12:31:59'!
golpeandoSueloDeTierraUsandoMechaDeDiamante

	"Si perforo suelo de tierra con mecha de diamante vamos directo a la proxima capa"
	
	^self pasarAProximaCapa.! !


!Perforadora methodsFor: 'scan' stamp: 'Ma 5/8/2026 11:32:00'!
calcularProfundidadDelSuelo
	

	^ capasDeSueloDebajo  sum: [:unaCapaDeSuelo | unaCapaDeSuelo altura ] .
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'Ma 5/8/2026 10:05:02'!
calcularProfundidadDelSueloHasta: tipoDeCapa
    | acc |
    acc := 0.
    capasDeSueloDebajo do: [:capa |
        (tipoDeCapa  scan = capa scan) ifTrue: [ ^acc ].
        acc := acc + capa altura.
    ].
    ^acc! !

!Perforadora methodsFor: 'scan' stamp: 'Ma 5/8/2026 11:31:18'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	^capasDeSueloDebajo count: [:unaCapaDeSuelo | unaCapaDeSuelo scan = tipoDeCapa scan].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: #'ISW1-2024-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'mensajes de error' stamp: 'Ma 5/8/2026 10:39:36'!
mechaRotaMensajeDeError

	^ 'se rompio la mecha'! !

!Perforadora class methodsFor: 'mensajes de error' stamp: 'Ma 5/8/2026 12:41:21'!
noPuedeHaberCapasDelMismoTipoSeguidas

	^ 'No puede haber capas de mismo tipo seguidas'! !

!Perforadora class methodsFor: 'mensajes de error' stamp: 'Ma 5/8/2026 10:15:44'!
sinMechaPuestaNoSePuedePerforarMensajeDeError

	^'No se puede perforar sin mecha'! !


!Perforadora class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 12:46:38'!
assertNoHayDosCapasPerforablesIgualesConsecutivas: capasDeSueloDebajo

	^ capasDeSueloDebajo withNextDo: [:capaDeArriba :capaDeAbajo | 
			(self puede: capaDeAbajo  estarSobre: capaDeArriba ) ifFalse: [
					self error: self  noPuedeHaberCapasDelMismoTipoSeguidas.
				].
		]
	! !

!Perforadora class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 12:48:19'!
noSePuedeGolpearConMechaRotaErrorDescription

	^ 'No se puede golpear con mecha rota'! !

!Perforadora class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 12:43:48'!
puede: capaDeAbajo  estarSobre: capaDeArriba

	^ ((capaDeArriba  isKindOf: CapaDeSueloPerforable ) and: [capaDeArriba  class = capaDeAbajo class]) not.! !

!Perforadora class methodsFor: 'instance creation' stamp: 'Ma 5/8/2026 12:44:08'!
sobreSuelo: capasDeSueloAExcavar 
	
	self assertNoHayDosCapasPerforablesIgualesConsecutivas: capasDeSueloAExcavar .
	
	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !


!classDefinition: #TestDePerforación category: #'ISW1-2024-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial-1'!

!TestDePerforación methodsFor: 'assert' stamp: 'Ma 5/8/2026 12:01:21'!
assertContarCantidadDeCapasDe: unTipoDeCapa son: unaCantidad

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2. CapaDeSuelo tierraConAltura: 40 . CapaDeSuelo arenosoConAlturaCero. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: unaCantidad equals: (excavadora contarCapas: unTipoDeCapa ).! !

!TestDePerforación methodsFor: 'assert' stamp: 'Ma 5/8/2026 12:30:58'!
assertPara: sueloAExcavar haciendo: unBloqueDePerforadora seEspera: unTipoDeCapa

	|perforadora|
	
	perforadora := Perforadora sobreSuelo: sueloAExcavar.
	unBloqueDePerforadora value: perforadora .
	
	self assert: unTipoDeCapa equals: perforadora capaDeSueloInmediata

	! !

!TestDePerforación methodsFor: 'assert' stamp: 'Ma 5/8/2026 12:21:03'!
assertPara: unSueloAExcavar haciendo: unBloqueDePerforadora seEspera: unTipoDeCapa conResistencia: unNivelDeResistencia
	|perforadora |
	perforadora := Perforadora sobreSuelo: unSueloAExcavar .
	
	unBloqueDePerforadora value: perforadora .
	self assert: (CapaDeSuelo concretoConResistencia: unNivelDeResistencia ) equals: perforadora capaDeSueloInmediata! !

!TestDePerforación methodsFor: 'assert' stamp: 'Ma 5/8/2026 11:58:34'!
assertProfundidadDeSueloHastaCapaDe: unTipoDeCapa son: unaCantidad

| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2 . CapaDeSuelo tierraConAltura: 40 . CapaDeSuelo arenosoConAlturaCero. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: unaCantidad equals: (excavadora calcularProfundidadDelSueloHasta: unTipoDeCapa ).! !

!TestDePerforación methodsFor: 'assert' stamp: 'Ma 5/8/2026 12:54:16'!
assertSeDebeRomperMechaParar: sueloAExcavar poniendoMecha: unBloque 

	| excavadora  |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	unBloque value: excavadora.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: excavadora class mechaRotaMensajeDeError equals: unError messageText.
			self assert: excavadora conMechaRota.].! !


!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:30:58'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertPara: sueloAExcavar haciendo: [:unaPerforadora | unaPerforadora ponerMechaSoft ; darGolpeDeTaladro ] seEspera: CapaDeSuelo tierraConAlturaCero .
		
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:30:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertPara: sueloAExcavar haciendo: [:unaPerforadora | unaPerforadora ponerMechaSoft ; darGolpeDeTaladro ]  seEspera: CapaDeSuelo tierraConAlturaCero .
		
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:53:08'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierraConAlturaCero.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assertSeDebeRomperMechaParar: sueloAExcavar poniendoMecha: [:unaPerforadora | 
		
		unaPerforadora ponerMechaSoft ]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:30:58'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertPara: sueloAExcavar haciendo: [:unaPerforadora | unaPerforadora ponerMechaWidia ; darGolpeDeTaladro ]  seEspera: CapaDeSuelo tierraConAlturaCero .
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:30:58'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertPara: sueloAExcavar 
		haciendo: [:unaPerforadora | unaPerforadora ponerMechaWidia ; darGolpeDeTaladro ; darGolpeDeTaladro ]
		seEspera: CapaDeSuelo arenosoConAlturaCero .
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:55:33'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierraConAlturaCero.
} .
	
	self assertSeDebeRomperMechaParar: sueloAExcavar 
	poniendoMecha: [:unaPerforadora | unaPerforadora ponerMechaWidia ; darGolpeDeTaladro ; darGolpeDeTaladro ].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:56:10'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertSeDebeRomperMechaParar: sueloAExcavar 
	poniendoMecha: [:unaPerforadora | unaPerforadora ponerMechaDiamante ].
		! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:22:24'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAlturaCero.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertPara: sueloAExcavar haciendo: [:unaPerforadora | unaPerforadora ponerMechaDiamante ; darGolpeDeTaladro ]  seEspera: CapaDeConcreto conResistencia: 5.
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:21:22'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia
	
	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierraConAlturaCero.
			} .

	self assertPara: sueloAExcavar 
		haciendo: [:unaExcavadora | unaExcavadora ponerMechaDiamante; darGolpeDeTaladro ; darGolpeDeTaladro ]
		seEspera: CapaDeConcreto 
		conResistencia: 4.
	

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 11:24:53'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			CapaConPiedras con: 'Mica'.
			CapaConPiedras con:  'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 11:09:03'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:59:03'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenosoConAlturaCero.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: Perforadora sinMechaPuestaNoSePuedePerforarMensajeDeError equals: unError messageText.
			self assert: (CapaDeSuelo arenosoConAlturaCero) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:02:40'!
test13PuedeCalcularProfundidadDelSuelo
	
	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoConAltura: 2 . CapaDeSuelo tierraConAltura: 40 . CapaDeSuelo arenosoConAlturaCero} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:02:11'!
test14PuedeContarLasCapasDeTipoArenoso
	
	self assertContarCantidadDeCapasDe: CapaArenosa son: 2.
		! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:01:49'!
test15PuedeContarLasCapasDeTipoTierra
	
	self assertContarCantidadDeCapasDe: CapaDeTierra son: 1. 
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:01:09'!
test16PuedeContarLasCapasDeTipoConcreto

	 self assertContarCantidadDeCapasDe: CapaDeConcreto son: 1.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 11:58:34'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	self assertProfundidadDeSueloHastaCapaDe: CapaArenosa son: 0 ! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 11:58:34'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra
	
	self assertProfundidadDeSueloHastaCapaDe: CapaDeTierra son: 2. 
	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 11:59:18'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto
	
	self assertProfundidadDeSueloHastaCapaDe: CapaDeConcreto son: 42. 

	! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:45:50'!
test20NoHabraCapasDelMismoTipoSeguidas

| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierraConAlturaCero .
			CapaDeSuelo tierraConAlturaCero .} .
	
	self should: [Perforadora sobreSuelo: sueloAExcavar ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: Perforadora noPuedeHaberCapasDelMismoTipoSeguidas equals: unError messageText ].



! !

!TestDePerforación methodsFor: 'test' stamp: 'Ma 5/8/2026 12:48:03'!
test21NoSePuedeDarGolpeConMechaRota

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierraConAlturaCero .} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	excavadora romperMecha .
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: excavadora class noSePuedeGolpearConMechaRotaErrorDescription equals: unError messageText.
			self assert: CapaDeConcreto equals: excavadora capaDeSueloInmediata class ].! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 55 53 58 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 64 91 57 55 65 58 64 65 57 64 53 61 55 56 58 57 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 55 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 57 59 53 57 61 55 60 56 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 58 59 53 56 62 62 61 59 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 55 65 57 62 65 55 57 53 64 63 62 59 59 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 61 62 61 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 55 63 65 59 60 65 57 61 53 55 57 58 59 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 56 74 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 62 59 61 60 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 59 65 58 59 53 55 63 61 58 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 60 65 55 63 53 56 61 56 61 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 58 56 65 60 57 53 55 63 55 62 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 58 63 61 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 59 61 65 60 63 53 61 60 58 63 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 57 58 64 57 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 58 65 59 63 65 60 59 53 64 58 59 58 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 58 61 61 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 60 65 57 62 65 55 59 53 55 63 64 56 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 53 122 123 17 59 56 63 64 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 55 64 65 57 59 65 57 61 53 61 64 56 58 59 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 46 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 64 64 55 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 55 64 65 57 60 65 56 55 53 60 61 58 63 59 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 64 64 55 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 56 56 65 58 58 65 60 64 53 60 55 62 60 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 58 55 64 59 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 56 56 65 59 56 65 58 63 53 63 61 64 55 64 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 58 56 55 60 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 63 91 56 58 65 55 61 65 60 57 53 60 63 57 59 58 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 56 74 54 80 90 94 56 52 57 55 57 59 52 56 74 52 87 104 121 106 112 104 115 52 56 52 122 118 115 124 106 112 118 117 53 122 123 17 58 58 60 55 59 17 52 52 52 52 52 52 52 52 52 52 17 17))!