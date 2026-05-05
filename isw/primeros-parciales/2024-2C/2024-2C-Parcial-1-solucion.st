!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza puntosVida inventario'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'testing' stamp: 'Ma 5/5/2026 14:28:45'!
itemNoDisponibleMensajeDeError
	^ self class ItemNoDisponibleMensajeDeError! !

!Aventurero methodsFor: 'testing' stamp: 'Ma 5/5/2026 13:08:11'!
tieneElItem: unItem

	^inventario includes: unItem .! !

!Aventurero methodsFor: 'testing' stamp: 'Ma 5/5/2026 12:41:52'!
tienePuntosDeVida: unaCantidadDePuntoDeVida

	^puntosVida = unaCantidadDePuntoDeVida .! !


!Aventurero methodsFor: 'equipar items' stamp: 'Ma 5/5/2026 12:44:48'!
equiparItemDeAtaque: unItemDeAtaque

	inventario addLast: unItemDeAtaque .! !

!Aventurero methodsFor: 'equipar items' stamp: 'Ma 5/5/2026 12:44:12'!
equiparItemDeDefensa: unItemDeDefensa

	inventario addLast: unItemDeDefensa .

	! !


!Aventurero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:02:45'!
atacaAGoblinUsandoBaculo: unMonstruo

	self subclassResponsibility .! !

!Aventurero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:02:33'!
atacaAOgroUsandoBaculo: unMonstruo

	self subclassResponsibility .! !

!Aventurero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:42:49'!
atacarA: unMonstruo con: itemDeAtaque
	(self tieneElItem: itemDeAtaque) ifFalse: [Error signal: self itemNoDisponibleMensajeDeError].
	itemDeAtaque atacarA: unMonstruo usadoPor: self.

	! !

!Aventurero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:50:06'!
atacarUsandoBaculoA: unMonstruo

	self subclassResponsibility .! !

!Aventurero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:45:01'!
atacarUsandoEspadaA: unMonstruo

	self subclassResponsibility .! !


!Aventurero methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:31:56'!
siendoAtacadoConFuerza: unPv

	|defensaEfectiva dañoEfectivo|
	
	defensaEfectiva := inventario 
		inject: 0 * pv  into: [:acc :item | acc + item defensa ] .
		
dañoEfectivo := (unPv - defensaEfectiva) max: unPv * 0.		
		puntosVida := puntosVida  - dañoEfectivo .! !


!Aventurero methodsFor: 'initialization' stamp: 'Ma 5/5/2026 12:39:42'!
initializeConFuerza: unaFuerza vida: unNivelVida 

	puntosVida := unNivelVida .
	fuerza := unaFuerza .
	inventario := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Aventurero class' category: #'2024-2C-Parcial-1'!
Aventurero class
	instanceVariableNames: ''!

!Aventurero class methodsFor: 'error description' stamp: 'Ma 5/5/2026 14:27:51'!
ItemNoDisponibleMensajeDeError

	^ 'Item no disponible en inventario'! !


!Aventurero class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 14:44:25'!
nuevoGuerrero

	^Guerrero new initializeConFuerza: 4 vida: 10 * pv.! !

!Aventurero class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 14:44:30'!
nuevoMago

	^Mago new initializeConFuerza: 2 vida: 15 * pv.! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:05:07'!
atacaAGoblinUsandoBaculo: unMonstruo
	
	"Como soy guerrero usando baculo atacando a goblin recibo penalizacion y se le duplica la vida"
	
	unMonstruo penalizacionPorAtacarAGoblinConBaculoSiendoGuerrero.! !

!Guerrero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:48:49'!
atacaAOgroUsandoBaculo: unMonstruo
	
	"Como soy guerrero usando baculo atacando a un ogro le quito lo equivalente a mi fuerza"
	
	unMonstruo recibirDaño: fuerza * pv .! !

!Guerrero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:56:41'!
atacarUsandoBaculoA: unMonstruo
	
	"Como soy guerrero con baculo hay 2 posibilidad si es goblin le duplico la vida, sino le quito lo equivalente a mi fuerza"

	unMonstruo siendoAtacadoUsandoBaculoPor: self.! !

!Guerrero methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:48:27'!
atacarUsandoEspadaA: unMonstruo

	"Como soy guerrero y uso espado le saco mi fuerz en danio al monstruo"
	
	unMonstruo recibirDaño: fuerza * pv .! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:55:02'!
atacarUsandoBaculoA: unMonstruo

	"Como soy mago y uso baculo a los goblin los mato de un golpe y al resto les quito lo equivalente a mi fuerza"
	
	unMonstruo siendoAtacadoUsandoBaculoPor: self.! !

!Mago methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:47:50'!
atacarUsandoEspadaA: unMonstruo

	"Como soy mago atancando con espada penalizacion pierdo toda mi vida"
	
	self penalizacionPorUsarEspadaSiendoMago.! !

!Mago methodsFor: 'atacar' stamp: 'Ma 5/5/2026 13:47:50'!
penalizacionPorUsarEspadaSiendoMago

	^ puntosVida := puntosVida * 0! !


!Mago methodsFor: 'as yet unclassified' stamp: 'Ma 5/5/2026 14:09:57'!
atacaAGoblinUsandoBaculo: unMonstruo

	"Como soy mago atacando a goblin con baculo lo mato de un golpe"
	
	unMonstruo goblinSiendoAtacadoPorUnMagoConBaculo.! !

!Mago methodsFor: 'as yet unclassified' stamp: 'Ma 5/5/2026 14:48:41'!
atacaAOgroUsandoBaculo: unMonstruo

	"Como soy mago atacando a un ogro con baculo le causo daño equivalente a mi fuerza"
	
	unMonstruo recibirDaño: fuerza *pv .! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'defensa' stamp: 'Ma 5/5/2026 14:22:56'!
defensa 

	^0 * pv.! !


!ItemDeAtaque methodsFor: 'atacar usando item' stamp: 'Ma 5/5/2026 12:58:39'!
atacarA: unMonstruo usadoPor: unAventurero

	self subclassResponsibility .! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'atacar usando item' stamp: 'Ma 5/5/2026 13:33:38'!
atacarA: unMonstruo usadoPor: unAventurero

	unAventurero atacarUsandoBaculoA: unMonstruo .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Baculo class' category: #'2024-2C-Parcial-1'!
Baculo class
	instanceVariableNames: ''!

!Baculo class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 12:54:51'!
nuevoBaculo

	^Baculo new.! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoObjetivo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'atacar usando item' stamp: 'Ma 5/5/2026 13:43:55'!
atacarA: unMonstruo usadoPor: unAventurero

	
	(unMonstruo  = monstruoObjetivo) ifTrue:  [unAventurero atacarUsandoEspadaA: unMonstruo] .! !


!Espada methodsFor: 'initialization' stamp: 'Ma 5/5/2026 12:54:11'!
initializeConMonstruoObjetivo: unMonstruoObjetivo

	monstruoObjetivo := unMonstruoObjetivo .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'error description' stamp: 'Ma 5/5/2026 13:06:01'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError

	^ 'No se puede atacar a monstruo menos a un metro de altura con espada'! !


!Espada class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 13:06:56'!
nuevaEspadaCon: unMonstruoObjetivo
		
	unMonstruoObjetivo mideMenosDeUnMetro ifTrue: [Error error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError].
	
	^self new initializeConMonstruoObjetivo: unMonstruoObjetivo .
	! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'defensa' stamp: 'Ma 5/5/2026 14:15:24'!
defensa

	self subclassResponsibility .! !


!classDefinition: #Armadura category: #'2024-2C-Parcial-1'!
ItemDeDefensa subclass: #Armadura
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Armadura methodsFor: 'defensa' stamp: 'Ma 5/5/2026 14:23:03'!
defensa
	"La armadura defiende 5 puntos"
	^5 * pv.! !


!classDefinition: #EscudoMagico category: #'2024-2C-Parcial-1'!
ItemDeDefensa subclass: #EscudoMagico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!EscudoMagico methodsFor: 'defensa' stamp: 'Ma 5/5/2026 14:23:08'!
defensa 

	^3 * pv.! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'altura pv'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'altura' stamp: 'Ma 5/5/2026 14:44:02'!
mideMenosDeUnMetro

	^ altura < (100 * centimeter) .! !


!Monstruo methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:25:42'!
recibirDaño: unNivelDeDañoRecibido

	|nuevaVida|
	
	nuevaVida := pv  - unNivelDeDañoRecibido .
	
	pv := 0 * pv max: nuevaVida .! !

!Monstruo methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:00:32'!
siendoAtacadoUsandoBaculoPor: unAventurero

	self subclassResponsibility .! !


!Monstruo methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:18:21'!
atacarA: unAventurero
	
	unAventurero siendoAtacadoConFuerza: pv.! !


!Monstruo methodsFor: 'testing' stamp: 'Ma 5/5/2026 14:26:12'!
tienePuntosDeVida: unaCantidad
^ pv = unaCantidad! !


!Monstruo methodsFor: 'initialization' stamp: 'Ma 5/5/2026 14:14:19'!
initializeConVida: unNivelDeVida yConAltura: unaAltura

	pv := unNivelDeVida .
	altura := unaAltura .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 14:38:20'!
nuevoGoblin

	^Goblin new initializeConVida: 5 * pv yConAltura: (90 * centimeter )! !

!Monstruo class methodsFor: 'instance creation' stamp: 'Ma 5/5/2026 14:47:18'!
nuevoOgro

	^ Ogro new initializeConVida: 15 * pv yConAltura: (220 * centimeter ).! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'penalizacion' stamp: 'Ma 5/5/2026 14:14:19'!
penalizacionPorAtacarAGoblinConBaculoSiendoGuerrero


	pv := pv * 2.! !


!Goblin methodsFor: 'efectos de ataque' stamp: 'Ma 5/5/2026 14:14:19'!
muerte

	^ pv := pv  * 0! !


!Goblin methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:10:52'!
goblinSiendoAtacadoPorUnMagoConBaculo

	self muerte.! !

!Goblin methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:02:57'!
siendoAtacadoUsandoBaculoPor: unAventurero

	unAventurero atacaAGoblinUsandoBaculo: self.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'siendo atacado' stamp: 'Ma 5/5/2026 14:02:19'!
siendoAtacadoUsandoBaculoPor: unAventurero

	unAventurero atacaAOgroUsandoBaculo: self.! !


!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
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

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
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

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:29:01'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'Ma 5/5/2026 13:35:58'!
crearArmadura

	^ Armadura new.! !

!TestMyA methodsFor: 'crear items' stamp: 'Ma 5/5/2026 12:55:53'!
crearBaculo
	
	^ Baculo nuevoBaculo .! !

!TestMyA methodsFor: 'crear items' stamp: 'Ma 5/5/2026 13:36:09'!
crearEscudoMagico

	^ EscudoMagico new.
! !

!TestMyA methodsFor: 'crear items' stamp: 'Ma 5/5/2026 12:56:12'!
crearEspadaPara: monstruo

	^ Espada nuevaEspadaCon: monstruo .
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'Ma 5/5/2026 13:11:54'!
crearGoblin

	^Monstruo nuevoGoblin.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'Ma 5/5/2026 12:40:14'!
crearGuerrero
	
	^ Aventurero nuevoGuerrero.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'Ma 5/5/2026 12:41:11'!
crearMago

	^Aventurero nuevoMago .! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'Ma 5/5/2026 13:12:35'!
crearOgro

	^Monstruo  nuevoOgro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !

TestMyA initialize!(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 55 53 58 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 64 91 57 55 65 58 64 65 57 64 53 61 55 56 58 57 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 55 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 57 59 53 57 61 55 60 56 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 56 65 59 64 65 58 59 53 56 62 62 61 59 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 57 59 62 60 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 55 65 57 62 65 55 57 53 64 63 62 59 59 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 61 62 61 55 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 59 65 58 59 53 55 63 61 58 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 64 65 60 60 65 55 63 53 56 61 56 61 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 56 63 55 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 58 56 65 60 57 53 55 63 55 62 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 58 63 61 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 63 91 56 58 65 59 61 65 60 63 53 61 60 58 63 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 53 122 123 17 57 58 64 57 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 58 65 59 63 65 60 59 53 64 58 59 58 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 53 122 123 17 58 61 61 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 56 91 56 60 65 57 62 65 55 59 53 55 63 64 56 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 60 52 56 74 54 80 90 94 52 87 104 121 106 112 104 115 56 52 56 74 57 60 52 122 118 115 124 106 112 118 117 53 122 123 17 59 56 63 64 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 58 65 55 56 65 55 58 53 61 60 60 59 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 55 61 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 58 65 58 63 65 58 62 53 57 63 55 59 59 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 58 57 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 57 57 65 58 61 53 59 57 61 63 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 62 62 64 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 57 59 65 59 63 53 56 61 63 61 63 58 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 62 63 56 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 57 63 65 57 59 53 55 58 56 59 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 63 55 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 58 55 65 59 56 53 56 60 55 58 64 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 63 55 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 58 62 65 55 58 53 63 58 57 61 56 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 53 122 123 17 56 63 55 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 60 52 55 60 91 56 59 65 59 64 65 60 64 53 59 63 64 56 55 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 119 121 112 116 108 121 118 122 52 119 104 121 106 112 104 115 108 122 54 57 55 57 59 52 57 74 54 57 55 57 59 52 57 74 52 87 104 121 106 112 104 115 52 56 52 122 118 115 124 106 112 118 117 53 122 123 17 56 63 56 56 61 17 52 52 52 52 52 52 52 52 52 52 17 17))!