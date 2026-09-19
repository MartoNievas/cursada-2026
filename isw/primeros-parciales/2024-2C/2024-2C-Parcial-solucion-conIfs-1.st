!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza puntoDeVida tipo itemsDeDefensa itemsDeAtaque'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'testing' stamp: 'HAW 19/Sep/2026, 1:04:39 pm (UTC)'!
tienePuntosDeVida: unaCantidadDeVida

	^ puntoDeVida = unaCantidadDeVida .! !


!Aventurero methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 1:36:54 pm (UTC)'!
equiparItemDeAtaque: itemDeAtaque 
	
	itemsDeAtaque add: itemDeAtaque .! !

!Aventurero methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 1:25:14 pm (UTC)'!
equiparItemDeDefensa: unItemDeDefensa

	itemsDeDefensa add: unItemDeDefensa .
	
	! !

!Aventurero methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 1:20:21 pm (UTC)'!
initializeDeTipo: tipoDeAventurero conFuerza: puntoDeFuerza yVida: puntosDeVida 
	
	tipo := tipoDeAventurero.
	fuerza := puntoDeFuerza.
	puntoDeVida := puntosDeVida.
	itemsDeDefensa := OrderedCollection new.
	itemsDeAtaque := OrderedCollection new.! !


!Aventurero methodsFor: 'defensa' stamp: 'HAW 19/Sep/2026, 1:30:37 pm (UTC)'!
calcularDefensaEfectiva

	^ itemsDeDefensa 
		inject: 0 * pv 
		into: [ :sumaParcial :itemDeDefensa | sumaParcial + itemDeDefensa defensa ]! !


!Aventurero methodsFor: 'recibir daño' stamp: 'HAW 19/Sep/2026, 1:50:11 pm (UTC)'!
reducirVidaACero
	
	puntoDeVida := 0.! !

!Aventurero methodsFor: 'recibir daño' stamp: 'HAW 19/Sep/2026, 1:30:53 pm (UTC)'!
reducirVidaEn: aPuntoDeVida 
	| defensaTotal dañoEfectivo |
	defensaTotal := self calcularDefensaEfectiva.
	dañoEfectivo := 0 * pv max: aPuntoDeVida - defensaTotal.
	puntoDeVida := 0 * pv max: puntoDeVida - dañoEfectivo.! !


!Aventurero methodsFor: 'ataque' stamp: 'HAW 19/Sep/2026, 1:38:06 pm (UTC)'!
assertItemDeAtqueDisponible: unItemDeAtaque

	^ (itemsDeAtaque  includes: unItemDeAtaque ) ifFalse: [self error: self itemNoDisponibleMensajeDeError]! !

!Aventurero methodsFor: 'ataque' stamp: 'HAW 19/Sep/2026, 2:06:09 pm (UTC)'!
atacarA: unMonstruo con: unItemDeAtaque
	
	self assertItemDeAtqueDisponible: unItemDeAtaque.
	
	tipo = #Guerrero ifTrue: [
			unItemDeAtaque tipo = #Espada ifTrue: [
					(unItemDeAtaque atacaA: unMonstruo) ifTrue: [
							unMonstruo reducirVidaEn: fuerza .
						]. 	
				].
			
			unItemDeAtaque tipo = #Baculo ifTrue: [
					"Si un guerrero usa un baculo se duplica pv de monstruo"
					unMonstruo tipo = #Goblin ifTrue: [
							unMonstruo duplicarVida.
						].
					unMonstruo tipo = #Ogro ifTrue: [
							unMonstruo reducirVidaEn: fuerza .
						].
				].
 		].
	
	tipo = #Mago ifTrue: [
			unItemDeAtaque tipo = #Espada ifTrue: [
					"Si usa una espada reduce toda su vida a 0"
					self reducirVidaACero.
				].
			
			unItemDeAtaque tipo = #Baculo ifTrue: [
					unMonstruo tipo = #Goblin ifTrue: [
							unMonstruo reducirVidaACero
						].
					unMonstruo  tipo = #Ogro ifTrue: [
							unMonstruo reducirVidaEn: fuerza .
						].
				].
 		].	
	! !


!Aventurero methodsFor: 'error message' stamp: 'HAW 19/Sep/2026, 1:36:06 pm (UTC)'!
itemNoDisponibleMensajeDeError
	^ 'Item no disponible'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Aventurero class' category: #'2024-2C-Parcial-1'!
Aventurero class
	instanceVariableNames: ''!

!Aventurero class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:48:14 pm (UTC)'!
crearGuerrero

	^self deTipo: #Guerrero conFuerza: 4 * pv yVida: 10 * pv! !

!Aventurero class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:48:50 pm (UTC)'!
crearMago
	^self deTipo: #Mago conFuerza: 2 * pv  yVida: 15 * pv! !

!Aventurero class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 12:56:26 pm (UTC)'!
deTipo: tipoDeAventurero conFuerza: puntoDeFuerza yVida: puntosDeVida 

	^self new initializeDeTipo: tipoDeAventurero conFuerza: puntoDeFuerza yVida: puntosDeVida ! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'accessing' stamp: 'HAW 19/Sep/2026, 1:43:47 pm (UTC)'!
tipo

	self subclassResponsibility ! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'accessing' stamp: 'HAW 19/Sep/2026, 1:43:59 pm (UTC)'!
tipo

	^ #Baculo! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'accessing' stamp: 'HAW 19/Sep/2026, 1:44:10 pm (UTC)'!
tipo

	^ #Espada! !


!Espada methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 1:33:50 pm (UTC)'!
initializeCrearEsparadaPara: aMonstruo 
	
	monstruo := aMonstruo.! !


!Espada methodsFor: 'objetivo' stamp: 'HAW 19/Sep/2026, 1:46:52 pm (UTC)'!
atacaA: unMonstruo 
	
	^ unMonstruo = monstruo ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'error message' stamp: 'HAW 19/Sep/2026, 2:00:17 pm (UTC)'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError

	^ 'No se puede atacar a monstruos menores a un metro'! !


!Espada class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 2:03:21 pm (UTC)'!
crearEsparadaPara: monstruo 
	
	self assertMonstruoMayorAUnMetro: monstruo .
	
	^self new initializeCrearEsparadaPara: monstruo ! !


!Espada class methodsFor: 'assert' stamp: 'HAW 19/Sep/2026, 2:03:59 pm (UTC)'!
assertMonstruoMayorAUnMetro: monstruo 
	
	monstruo esMenorAUnMetro ifTrue: [self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ]! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'tipoDeItemDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'defensa' stamp: 'HAW 19/Sep/2026, 1:27:54 pm (UTC)'!
defensa

	tipoDeItemDeDefensa = #Aramadura ifTrue: [^ 5 * pv].
	tipoDeItemDeDefensa = #EscudoMagico ifTrue: [^ 3 * pv]! !


!ItemDeDefensa methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 1:11:34 pm (UTC)'!
initializeDeTipo: unTipoDeItemDeDefensa 
	
	tipoDeItemDeDefensa := unTipoDeItemDeDefensa.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:12:17 pm (UTC)'!
crearArmadura

	^self deTipo: #Aramadura! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:11:01 pm (UTC)'!
crearEscudoMagico
	
	^self deTipo: #EscudoMagico! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:11:21 pm (UTC)'!
deTipo: unTipoDeItemDeDefensa 

	^self new initializeDeTipo: unTipoDeItemDeDefensa ! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'altura puntoDeVida tipo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'initialization' stamp: 'HAW 19/Sep/2026, 12:59:03 pm (UTC)'!
initializeDeTipo: tipoDeMonstruo conAltura: unaAlturaEnCm yVida: puntosDeVida 

	tipo := tipoDeMonstruo.
	altura := unaAlturaEnCm.
	puntoDeVida := puntosDeVida.! !


!Monstruo methodsFor: 'ataque' stamp: 'HAW 19/Sep/2026, 1:13:16 pm (UTC)'!
atacarA: guerrero 
	
	tipo = #Goblin ifTrue: [
			guerrero reducirVidaEn: puntoDeVida .
		].
	
	tipo = #Ogro ifTrue: [
			guerrero reducirVidaEn: puntoDeVida 
		].! !


!Monstruo methodsFor: 'testing' stamp: 'HAW 19/Sep/2026, 2:05:12 pm (UTC)'!
esMenorAUnMetro
	
	^ altura < (1 * meter) .! !

!Monstruo methodsFor: 'testing' stamp: 'HAW 19/Sep/2026, 1:36:31 pm (UTC)'!
tienePuntosDeVida: unaCantidadDeVida 

	^ puntoDeVida = unaCantidadDeVida 	! !


!Monstruo methodsFor: 'recibir daño' stamp: 'HAW 19/Sep/2026, 1:52:39 pm (UTC)'!
reducirVidaACero
	
	puntoDeVida := 0! !

!Monstruo methodsFor: 'recibir daño' stamp: 'HAW 19/Sep/2026, 1:47:22 pm (UTC)'!
reducirVidaEn: unaCantidadDeDaño

	puntoDeVida := puntoDeVida - unaCantidadDeDaño .! !


!Monstruo methodsFor: 'accessing' stamp: 'HAW 19/Sep/2026, 1:52:27 pm (UTC)'!
tipo
	
	^tipo! !


!Monstruo methodsFor: 'ventaja' stamp: 'HAW 19/Sep/2026, 1:54:33 pm (UTC)'!
duplicarVida
	
	puntoDeVida := puntoDeVida * 2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 12:58:05 pm (UTC)'!
crearGoblin
	
	^self deTipo: #Goblin conAltura: 90 * centimeter yVida: 5 * pv! !

!Monstruo class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 1:12:43 pm (UTC)'!
crearOgro

	^self deTipo: #Ogro conAltura: 220 * centimeter  yVida: 15 * pv! !

!Monstruo class methodsFor: 'instance creation' stamp: 'HAW 19/Sep/2026, 12:58:38 pm (UTC)'!
deTipo: tipoDeMonstruo conAltura: unaAlturaEnCm yVida: puntosDeVida 

	^self new initializeDeTipo: tipoDeMonstruo conAltura: unaAlturaEnCm yVida: puntosDeVida ! !


!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 6:49:05 am (UTC)'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:09:06 am (UTC)'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:08:35 am (UTC)'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 27/Sep/2024, 12:04:39 pm (UTC)'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'LL 27/Sep/2024, 1:48:15 pm (UTC)'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 27/Sep/2024, 12:46:06 pm (UTC)'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:08:52 am (UTC)'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:08:49 am (UTC)'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:42:13 am (UTC)'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:08:45 am (UTC)'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:08:38 am (UTC)'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 27/Sep/2024, 7:29:01 am (UTC)'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'HAW 19/Sep/2026, 1:02:00 pm (UTC)'!
crearArmadura

	^ ItemDeDefensa crearArmadura! !

!TestMyA methodsFor: 'crear items' stamp: 'HAW 19/Sep/2026, 1:50:44 pm (UTC)'!
crearBaculo
	
	^ Baculo new.! !

!TestMyA methodsFor: 'crear items' stamp: 'HAW 19/Sep/2026, 1:02:17 pm (UTC)'!
crearEscudoMagico

	^ ItemDeDefensa crearEscudoMagico
! !

!TestMyA methodsFor: 'crear items' stamp: 'HAW 19/Sep/2026, 1:32:52 pm (UTC)'!
crearEspadaPara: monstruo

	^ Espada crearEsparadaPara: monstruo 
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'HAW 19/Sep/2026, 12:53:49 pm (UTC)'!
crearGoblin

	^ Monstruo crearGoblin.
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'HAW 19/Sep/2026, 12:55:04 pm (UTC)'!
crearGuerrero
	
	^ Aventurero crearGuerrero! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'HAW 19/Sep/2026, 12:54:32 pm (UTC)'!
crearMago

	^ Aventurero crearMago
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'HAW 19/Sep/2026, 12:54:03 pm (UTC)'!
crearOgro

	^ Monstruo crearOgro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 26/Sep/2024, 11:21:50 pm (UTC)'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !

TestMyA initialize!(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 61 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 56 53 60 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 63 65 59 64 65 59 57 39 74 118 116 119 112 115 108 121 65 39 56 56 53 59 53 55 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 55 57 65 56 59 53 64 60 63 63 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 61 63 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 60 56 65 56 59 53 60 59 63 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 64 58 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 58 59 65 56 60 53 60 57 55 57 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 55 61 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 59 65 56 55 53 59 61 55 62 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 61 65 56 59 53 57 60 58 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 56 61 65 56 59 53 59 55 60 58 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 61 65 60 61 53 63 61 64 56 64 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 62 65 56 64 53 57 57 59 64 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 57 65 60 57 65 57 58 53 60 64 63 57 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 64 55 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 59 65 60 59 65 56 61 53 63 55 56 58 55 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 59 61 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 63 65 58 61 53 64 60 64 61 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 64 65 56 59 53 58 60 57 60 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 57 55 65 55 55 65 57 61 53 58 64 57 62 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 56 58 65 57 57 53 58 61 60 64 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 63 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 57 59 65 60 56 53 59 57 63 62 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 57 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 59 62 65 55 56 53 62 63 55 61 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 58 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 56 65 55 63 65 59 63 53 57 59 57 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 62 55 64 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 57 65 59 57 65 59 58 53 64 64 59 57 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 62 62 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 58 65 56 61 65 59 57 53 58 64 60 57 59 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 60 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 56 56 65 56 57 53 55 58 64 56 60 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 60 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 57 55 65 60 57 53 55 61 55 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 62 63 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 61 65 55 61 53 62 64 64 61 55 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 63 65 57 55 53 58 63 62 61 61 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 60 56 65 57 64 53 61 58 63 57 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 60 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 55 64 65 60 60 65 59 64 53 55 64 59 59 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 61 56 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 59 65 57 56 53 57 64 63 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 57 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 61 65 58 60 53 63 64 63 59 58 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 64 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 55 56 53 63 57 55 63 61 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 58 65 57 55 65 58 55 53 62 59 61 62 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 55 56 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 55 56 65 59 59 53 57 63 57 63 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 111 118 115 104 53 122 123 17 58 56 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 55 65 58 63 65 55 55 53 56 64 59 60 59 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 58 61 62 59 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 57 65 56 62 65 60 56 53 62 58 64 60 59 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 58 59 56 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 63 91 56 57 65 57 58 65 56 64 53 57 62 63 59 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 58 58 57 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 64 91 56 56 65 55 62 65 55 58 53 63 61 56 55 55 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 56 61 60 58 59 17 52 52 52 52 52 52 52 52 52 52 17 17))!