!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza puntosVida inventario'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'error description' stamp: 'Ma 5/5/2026 14:28:45'!
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


!Mago methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:09:57'!
atacaAGoblinUsandoBaculo: unMonstruo

	"Como soy mago atacando a goblin con baculo lo mato de un golpe"
	
	unMonstruo goblinSiendoAtacadoPorUnMagoConBaculo.! !

!Mago methodsFor: 'atacar' stamp: 'Ma 5/5/2026 14:48:41'!
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

!Monstruo methodsFor: 'testing' stamp: 'Ma 5/5/2026 14:44:02'!
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

TestMyA initialize!

