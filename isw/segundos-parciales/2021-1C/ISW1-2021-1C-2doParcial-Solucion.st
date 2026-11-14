!classDefinition: #CartaDeTruco category: #'ISW1-2021-1C-2doParcial'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTruco methodsFor: 'initialization' stamp: 'HAW 3/Jul/2021, 6:27:51 pm (UTC)'!
initializePalo: unPalo numero: unNumero 
	
	palo := unPalo.
	numero := unNumero.! !


!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 2/Jul/2021, 2:44:36 pm (UTC)'!
= unaCarta 
	
	^(unaCarta isKindOf: self class) and: [(unaCarta paloEs: palo) and: [ unaCarta numeroEs: numero ]]! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 5/Jul/2021, 1:49:51 pm (UTC)'!
empardaCon: cartaParda

	^self valor = cartaParda valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 2/Jul/2021, 2:43:24 pm (UTC)'!
hash
	
	^palo hash bitXor: numero hash ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 5/Jul/2021, 1:49:59 pm (UTC)'!
mataA: cartaPerdedora

	^self valor < cartaPerdedora valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 2/Jul/2021, 2:41:53 pm (UTC)'!
numeroEs: unNumero

	^numero = unNumero ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 2/Jul/2021, 2:41:39 pm (UTC)'!
paloEs: unPalo

	^palo = unPalo ! !


!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 4/Jul/2021, 8:50:20 pm (UTC)'!
esAncho

	^ self numeroEs: 1! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 4/Jul/2021, 8:50:31 pm (UTC)'!
esAnchoDeBasto
	
	^self esAncho and: [ self esDeBasto ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 4/Jul/2021, 8:50:41 pm (UTC)'!
esAnchoDeEspada
	
	^self esAncho and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 4/Jul/2021, 8:50:20 pm (UTC)'!
esAnchoFalso
	
	^self esAncho and: [ self esDeOro or: [ self esDeCopa ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:19:32 pm (UTC)'!
esCaballo
	
	^self numeroEs: 11! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:25:29 pm (UTC)'!
esDeBasto
	
	^self paloEs: self basto! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:26:09 pm (UTC)'!
esDeCopa
	
	^self paloEs: self copa! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:26:18 pm (UTC)'!
esDeEspada
	
	^self paloEs: self espada ! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:26:35 pm (UTC)'!
esDeOro
	
	^self paloEs: self oro! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:19:22 pm (UTC)'!
esRey
	
	^self numeroEs: 12! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:16:57 pm (UTC)'!
esSiete
	
	^self numeroEs: 7! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:27:00 pm (UTC)'!
esSieteDeEspadas
	
	^self esSiete and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:27:15 pm (UTC)'!
esSieteDeOro
	
	^self esSiete and: [ self esDeOro ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:26:09 pm (UTC)'!
esSieteFalso
	
	^self esSiete and: [ self esDeCopa or: [ self esDeBasto ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 3/Jul/2021, 6:19:43 pm (UTC)'!
esSota
	
	^self numeroEs: 10! !


!CartaDeTruco methodsFor: 'printing' stamp: 'HAW 3/Jul/2021, 6:14:43 pm (UTC)'!
printOn: aStream

	aStream 
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: 	palo ! !


!CartaDeTruco methodsFor: 'valor' stamp: 'HAW 3/Jul/2021, 5:51:09 pm (UTC)'!
valor
	
	^self class valorDe: self! !


!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 6:24:33 pm (UTC)'!
basto
	
	^self class basto! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 6:24:44 pm (UTC)'!
copa

	^ self class copa! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 6:24:08 pm (UTC)'!
espada
	
	^self class espada! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 6:26:27 pm (UTC)'!
oro

	^ self class oro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: #'ISW1-2021-1C-2doParcial'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 4/Jul/2021, 8:49:37 pm (UTC)'!
anchoDeBasto
	
	^self bastoCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 4/Jul/2021, 8:49:57 pm (UTC)'!
anchoDeEspada
	
	^self espadaCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 5:57:03 pm (UTC)'!
bastoCon: unNumero

	^self palo: self basto numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 5:57:08 pm (UTC)'!
copaCon: unNumero

	^self palo: self copa numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 5:57:16 pm (UTC)'!
espadaCon: unNumero

	^self palo: self espada numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 5:57:34 pm (UTC)'!
oroCon: unNumero

	^self palo: self oro numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 4/Jul/2021, 9:06:08 pm (UTC)'!
palo: unPalo numero: unNumero 
	
	self assertNúmeroEsVálido: unNumero.
	self assertPaloEsVálido: unPalo.
	
	^self new initializePalo: unPalo numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 6:12:50 pm (UTC)'!
sieteDeEspada
	
	^self espadaCon: 7! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 3/Jul/2021, 6:17:44 pm (UTC)'!
sieteDeOro
	
	^self oroCon: 7! !


!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 5:56:25 pm (UTC)'!
basto
	
	^#basto! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 5:57:25 pm (UTC)'!
copa
	
	^#copa! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 5:55:44 pm (UTC)'!
espada
	
	^#espada! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 3/Jul/2021, 5:57:43 pm (UTC)'!
oro
	
	^#oro! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 4/Jul/2021, 9:07:36 pm (UTC)'!
palos

	"No se puede acceder a self en backtick, por eso se usa CartaDeTruco como receiver - Hernan"
	^ `{CartaDeTruco espada. CartaDeTruco basto. CartaDeTruco oro. CartaDeTruco copa }`! !


!CartaDeTruco class methodsFor: 'initialization' stamp: 'HAW 5/Jul/2021, 1:52:07 pm (UTC)'!
initializeOrdenDePrioridad
	
	"Cuanto más chico sea el índice de la carta en esta colección, más valor tiene - Hernan"
	ordenDePrioridad := OrderedCollection new.
	
	ordenDePrioridad 
		add: [ :carta | carta esAnchoDeEspada ];
		add: [ :carta | carta esAnchoDeBasto ];
		add: [ :carta | carta esSieteDeEspadas ];
		add: [ :carta | carta esSieteDeOro ];
		add: [ :carta | carta numeroEs: 3 ];
		add: [ :carta | carta numeroEs: 2 ];
		add: [ :carta | carta esAnchoFalso ];
		add: [ :carta | carta esRey ];
		add: [ :carta | carta esCaballo ];
		add: [ :carta | carta esSota ];
		add: [ :carta | carta esSieteFalso ];
		add: [ :carta | carta numeroEs: 6 ];
		add: [ :carta | carta numeroEs: 5 ];
		add: [ :carta | carta numeroEs: 4 ];
		yourself.
	
	! !


!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 3/Jul/2021, 5:54:01 pm (UTC)'!
ordenDePrioridad
	
	^ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ] ! !

!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 5/Jul/2021, 2:58:24 pm (UTC)'!
valorDe: unaCarta 
	
	self ordenDePrioridad withIndexDo: [ :bloqueDeVerificacion :index |
		(bloqueDeVerificacion value: unaCarta) ifTrue: [ ^index ]].
	
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
numeroDeCartaInvalidoErrorDescription
	
	^'El truco no se puede jugar con ochos ni con nueves'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 5/Jul/2021, 2:58:12 pm (UTC)'!
paloInvalidoErrorDescription
	
	^'Los palos de la carta solo pueden ser espada, basto, oro y copa'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 5/Jul/2021, 2:58:24 pm (UTC)'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	
	^'Error de programación: Tabla de valores incorrecta o carta inválida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
assertNúmeroEsVálido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 5/Jul/2021, 2:58:12 pm (UTC)'!
assertPaloEsVálido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #RondaDeTruco category: #'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDeMano cartasDePie cartasJugadaPorMano cartasJugadaPorPie turno puntosDeMano puntosDePie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 3:40:37 pm (UTC)'!
initializeConCartasDeMano: unaCartasDeMano yConCartasDePie: unasCartasDePie 

	
	cartasDeMano := unaCartasDeMano .
	cartasDePie := unasCartasDePie.
	cartasJugadaPorMano := OrderedCollection new.
	cartasJugadaPorPie := OrderedCollection new.
	turno := ComienzaMano jugando: self.
	puntosDeMano := 0.
	puntosDePie  := 0.! !


!RondaDeTruco methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 2:22:58 pm (UTC)'!
cartasJugadasPorManoSon: unasCartasJugadasDeMano 
	
	^ cartasJugadaPorMano asArray  = unasCartasJugadasDeMano .! !

!RondaDeTruco methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 2:22:51 pm (UTC)'!
cartasJugadasPorPieSon: unasCartasJugadadDePie 
	
	^ cartasJugadaPorPie asArray = unasCartasJugadadDePie .! !

!RondaDeTruco methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 3:59:07 pm (UTC)'!
puntosDeManoSon: unaCantidadDePuntos

	^ puntosDeMano  = unaCantidadDePuntos 
	
	! !

!RondaDeTruco methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 3:58:46 pm (UTC)'!
puntosDePieSon: unaCantidadDePuntos 

	^ puntosDePie = unaCantidadDePuntos 
	! !


!RondaDeTruco methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:40:33 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	self jugar: unaCartaAJugar de: cartasDeMano registrandoEn: cartasJugadaPorMano jugandoTurnoCon: [turno juegaManoCon: unaCartaAJugar ]. 
! !

!RondaDeTruco methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:40:37 pm (UTC)'!
juegaPieCon: unaCarta 
	
	self jugar: unaCarta de: cartasDePie  registrandoEn: cartasJugadaPorPie  jugandoTurnoCon: [turno juegaPieCon: unaCarta ]. 
	
! !

!RondaDeTruco methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 4:30:24 pm (UTC)'!
jugar: unaCarta de: unasCartasDisponibles registrandoEn: unaCartasJugadas jugandoTurnoCon: unBloqueDeJuego 

	
	self assertCartaDisponible: unaCarta en: unasCartasDisponibles .
	unBloqueDeJuego value.
	unasCartasDisponibles remove: unaCarta .
	
	! !


!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:40:12 pm (UTC)'!
juegaManoComenzandoManoCon: unaCartaJugada 
	
	cartasJugadaPorMano add: unaCartaJugada .
	turno := TerminaPie jugando: self.! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:40:06 pm (UTC)'!
juegaManoComenzandoPieCon: unaCartaJugada 
	
	self singalErrorTurnoInvalido .! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:57:56 pm (UTC)'!
juegaManoEnRondaFinalizadaCon: unaCarta 
	
	self singalErrorTurnoInvalido .! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:40:00 pm (UTC)'!
juegaManoTerminandoManoCon: unaCartaJugada 
	
	cartasJugadaPorMano add: unaCartaJugada .
	self decidirSiguienteTurnoEnBaseAlResultadoDelUltimoEnfrentamiento .
	! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:39:56 pm (UTC)'!
juegaManoTerminandoPieCon: unaCartaJugada 

	self singalErrorTurnoInvalido . ! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:39:44 pm (UTC)'!
juegaPieComenzandoManoCon: unaCartaJugada 

	self singalErrorTurnoInvalido .
! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:39:36 pm (UTC)'!
juegaPieComenzandoPieCon: unaCartaJugada 
	
	cartasJugadaPorPie add: unaCartaJugada .
	turno := TerminaMano jugando: self.! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 4:03:14 pm (UTC)'!
juegaPieEnRondaFinalizadaCon: unaCartaAJugar 
	
	self singalErrorTurnoInvalido ! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:40:22 pm (UTC)'!
juegaPieTerminandoManoCon: unaCartaJugada 
		
	self singalErrorTurnoInvalido .
! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'HAW 14/Nov/2026, 3:40:26 pm (UTC)'!
juegaPieTerminandoPieCon: unaCartaJugada 
	
	cartasJugadaPorPie add: unaCartaJugada .
	self decidirSiguienteTurnoEnBaseAlResultadoDelUltimoEnfrentamiento.! !


!RondaDeTruco methodsFor: 'error signaling' stamp: 'HAW 14/Nov/2026, 3:30:51 pm (UTC)'!
signalErrorCartaNoDisponible
	
	self error: self class cartaNoDisponibleErrorDescription ! !

!RondaDeTruco methodsFor: 'error signaling' stamp: 'HAW 14/Nov/2026, 3:22:48 pm (UTC)'!
singalErrorTurnoInvalido

	^self error:  self class turnoInvalidoErrorDescription! !


!RondaDeTruco methodsFor: 'ganador' stamp: 'HAW 14/Nov/2026, 4:27:48 pm (UTC)'!
decidirSiguienteTurnoEnBaseAlResultadoDelUltimoEnfrentamiento

	self primerEnfrentamientoFuePardo ifTrue: [
		puntosDeMano := puntosDeMano + 1.
		puntosDePie := puntosDePie + 1.
		turno := ComienzaMano jugando: self.
		^self
	].

	self ganoEnfrentamientoMano ifTrue: [
		puntosDeMano := puntosDeMano + 1.
		turno := ComienzaMano jugando: self.
	] ifFalse: [
		puntosDePie := puntosDePie + 1.
		turno := ComienzaPie jugando: self.
	].

    (puntosDeMano = 2 or: [puntosDePie = 2]) ifTrue: [
        turno := RondaFinalizada jugando: self.
    ].
! !

!RondaDeTruco methodsFor: 'ganador' stamp: 'HAW 14/Nov/2026, 2:12:17 pm (UTC)'!
ganoEnfrentamientoMano
	
	^ cartasJugadaPorMano last mataA: cartasJugadaPorPie last! !

!RondaDeTruco methodsFor: 'ganador' stamp: ''!
ganoMano

	^ puntosDeMano = 2! !

!RondaDeTruco methodsFor: 'ganador' stamp: ''!
ganoPie

	^ puntosDePie = 2! !

!RondaDeTruco methodsFor: 'ganador' stamp: ''!
primerEnfrentamientoFuePardo

	^ cartasJugadaPorMano size = 1
		and: [cartasJugadaPorMano first empardaCon: cartasJugadaPorPie first]! !


!RondaDeTruco methodsFor: 'asserting' stamp: 'HAW 14/Nov/2026, 3:31:41 pm (UTC)'!
assertCartaDisponible: unaCarta en: unasCartasDisponibles 
	
	 (unasCartasDisponibles includes: unaCarta ) ifFalse: [self signalErrorCartaNoDisponible]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: #'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 12:56:41 pm (UTC)'!
cartaNoDisponibleErrorDescription
	
	^ 'La carta que estas intentado jugar no pertenece al mazo del jugador'! !

!RondaDeTruco class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
cartasInvalidadErrorDescription
	
	^ 'Ambos jugadores deben tener exactamente 3 cartas distintas'! !

!RondaDeTruco class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 3:22:27 pm (UTC)'!
turnoInvalidoErrorDescription
	
	^ 'No es el turno del jugador'! !


!RondaDeTruco class methodsFor: 'signal error' stamp: 'HAW 14/Nov/2026, 12:40:51 pm (UTC)'!
signalErrorCartasInvalidas

	^ self error: self cartasInvalidadErrorDescription! !


!RondaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 3:05:08 pm (UTC)'!
ConCartasDeMano: unasCartasDeMano yConCartasDePie: unasCartasDePie 

	| unasCartasDeManoAsSet unasCartasDePieAsSet |
	unasCartasDeManoAsSet := unasCartasDeMano asSet .
	unasCartasDePieAsSet := unasCartasDePie asSet.

	self assertCartaDeMano: unasCartasDeManoAsSet cartasDePie: unasCartasDePieAsSet.
	
	^self new initializeConCartasDeMano: unasCartasDeManoAsSet yConCartasDePie: unasCartasDePieAsSet ! !


!RondaDeTruco class methodsFor: 'validation' stamp: 'HAW 14/Nov/2026, 3:03:40 pm (UTC)'!
assertCartaDeMano: unaCartasDeManoAsSet cartasDePie: unasCartasDePieAsSet

	
	unaCartasDeManoAsSet size = 3 ifFalse: [self signalErrorCartasInvalidas ].
	unasCartasDePieAsSet size = 3 ifFalse: [self signalErrorCartasInvalidas ].
	(unaCartasDeManoAsSet union: unasCartasDePieAsSet ) size = 6 ifFalse: [self signalErrorCartasInvalidas ]! !


!classDefinition: #Turno category: #'ISW1-2021-1C-2doParcial'!
Object subclass: #Turno
	instanceVariableNames: 'ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Turno methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 1:58:58 pm (UTC)'!
initializeJugando: unaRondaDeTruco 
	
	ronda := unaRondaDeTruco.! !


!Turno methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:05 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	self subclassResponsibility ! !

!Turno methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
juegaPieCon: unaCartaAJugarPorPie 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Turno class' category: #'ISW1-2021-1C-2doParcial'!
Turno class
	instanceVariableNames: ''!

!Turno class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 1:58:10 pm (UTC)'!
jugando: unaRondaDeTruco 

	^self new initializeJugando: unaRondaDeTruco ! !


!classDefinition: #ComienzaMano category: #'ISW1-2021-1C-2doParcial'!
Turno subclass: #ComienzaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ComienzaMano methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:05 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	ronda juegaManoComenzandoManoCon: unaCartaAJugar .! !

!ComienzaMano methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
juegaPieCon: unaCartaAJugarPorPie

	ronda juegaPieComenzandoManoCon: unaCartaAJugarPorPie ! !


!classDefinition: #ComienzaPie category: #'ISW1-2021-1C-2doParcial'!
Turno subclass: #ComienzaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ComienzaPie methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:19:27 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	ronda juegaManoComenzandoPieCon: unaCartaAJugar 
	! !

!ComienzaPie methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:17:21 pm (UTC)'!
juegaPieCon: unaCartaAJugarPorPie 
	
	ronda juegaPieComenzandoPieCon: unaCartaAJugarPorPie ! !


!classDefinition: #RondaFinalizada category: #'ISW1-2021-1C-2doParcial'!
Turno subclass: #RondaFinalizada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaFinalizada methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:57:34 pm (UTC)'!
juegaManoCon: unaCarta

	ronda juegaManoEnRondaFinalizadaCon: unaCarta .! !

!RondaFinalizada methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 4:02:52 pm (UTC)'!
juegaPieCon: unaCartaAJugar

	ronda juegaPieEnRondaFinalizadaCon: unaCartaAJugar ! !


!classDefinition: #TerminaMano category: #'ISW1-2021-1C-2doParcial'!
Turno subclass: #TerminaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaMano methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:05 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	
	ronda juegaManoTerminandoManoCon: unaCartaAJugar .! !

!TerminaMano methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
juegaPieCon: unaCartaAJugarPorPie 

	ronda juegaPieTerminandoManoCon: unaCartaAJugarPorPie .! !


!classDefinition: #TerminaPie category: #'ISW1-2021-1C-2doParcial'!
Turno subclass: #TerminaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaPie methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:05 pm (UTC)'!
juegaManoCon: unaCartaAJugar 
	
	ronda juegaManoTerminandoPieCon: unaCartaAJugar ! !

!TerminaPie methodsFor: 'juego' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
juegaPieCon: unaCartaAJugarPorPie 
	
	ronda juegaPieTerminandoPieCon: unaCartaAJugarPorPie .! !


!classDefinition: #CartaDeTrucoTest category: #'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 4/Jul/2021, 8:31:47 pm (UTC)'!
test01SonIgualesConMismoPaloYNumero

	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 4/Jul/2021, 8:31:47 pm (UTC)'!
test02SonDistintasConDistintoPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 4/Jul/2021, 8:31:47 pm (UTC)'!
test03SonDistintasConNumeroAunqueIgualPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 4/Jul/2021, 8:31:47 pm (UTC)'!
test04CartasIgualesTienenElMismoHash

	self assert: (CartaDeTruco bastoCon: 1) hash equals: (CartaDeTruco bastoCon: 1) hash

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 4/Jul/2021, 8:31:47 pm (UTC)'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta

	self deny: (CartaDeTruco bastoCon: 1) = 1! !


!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
test07NoHayCartaDeTrucoConNumeroOcho

	self 
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
test08NoHayCartaDeTrucoConNumeroNueve

	self 
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:12 pm (UTC)'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa

	self 
		should: [ CartaDeTruco palo: #otro numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
test10NoSePuedeCrearCartaConNumeroMenorAUno

	self 
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
test11NoSePuedeCrearCartaConNumeroMayorADoce

	self 
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 5/Jul/2021, 2:58:02 pm (UTC)'!
test12ElNumeroDeLaCartaDebeSerEntero

	self 
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 5/Jul/2021, 1:55:30 pm (UTC)'!
test13LaTablaDeValoresEsCorrecta

	self assert: (CartaDeTruco anchoDeEspada mataA: CartaDeTruco anchoDeBasto).
	self assert: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco sieteDeEspada).
	self assert: (CartaDeTruco sieteDeEspada mataA: CartaDeTruco sieteDeOro).
	self assert: (CartaDeTruco sieteDeOro mataA: (CartaDeTruco espadaCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) empardaCon: (CartaDeTruco oroCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) mataA: (CartaDeTruco espadaCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) empardaCon: (CartaDeTruco oroCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) mataA: (CartaDeTruco oroCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) empardaCon: (CartaDeTruco copaCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) mataA: (CartaDeTruco espadaCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) empardaCon: (CartaDeTruco oroCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) mataA: (CartaDeTruco espadaCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) empardaCon: (CartaDeTruco oroCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) mataA: (CartaDeTruco espadaCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) empardaCon: (CartaDeTruco oroCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) mataA: (CartaDeTruco copaCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) empardaCon: (CartaDeTruco bastoCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) mataA: (CartaDeTruco espadaCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) empardaCon: (CartaDeTruco oroCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) mataA: (CartaDeTruco espadaCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) empardaCon: (CartaDeTruco oroCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) mataA: (CartaDeTruco espadaCon: 4)).
	self assert: ((CartaDeTruco espadaCon: 4) empardaCon: (CartaDeTruco oroCon: 4)).

	{ 3. 2. 12. 11. 10. 6. 5. 4 } do: [ :unNumero |
		CartaDeTruco palos do: [ :unPalo | 
			self assert: ((CartaDeTruco espadaCon: unNumero) empardaCon: (CartaDeTruco palo: unPalo numero: unNumero)) ]]
	! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 5/Jul/2021, 1:49:51 pm (UTC)'!
test14HayCartasQueNoSonPardas

	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 5/Jul/2021, 1:49:59 pm (UTC)'!
test15HayCartasQuePierdenConOtras

	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 4/Jul/2021, 8:53:21 pm (UTC)'!
test16SieteDeCopasYDeBastoEsSieteFalso

	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 4/Jul/2021, 8:54:57 pm (UTC)'!
test17SieteDeOroYDeEspadaNoSonSieteFalso

	self deny: (CartaDeTruco sieteDeOro) esSieteFalso.
	self deny: (CartaDeTruco sieteDeEspada) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 4/Jul/2021, 8:55:53 pm (UTC)'!
test18AnchoDeOroYDeCopaSonAnchoFalsos

	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 4/Jul/2021, 8:56:28 pm (UTC)'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos

	self deny: (CartaDeTruco anchoDeEspada) esAnchoFalso.
	self deny: (CartaDeTruco anchoDeBasto) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 5/Jul/2021, 2:58:24 pm (UTC)'!
test20FallaBuscandoValorDeCartaInválida

	"Creo una carta de manera inválida para probar la correctitud del la tabla de valores - Hernan"
	self 
		should: [ CartaDeTruco new initializePalo: #invalido numero: 1; valor ]
		raise: Error 
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!classDefinition: #TrucoTest category: #'ISW1-2021-1C-2doParcial'!
TestCase subclass: #TrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test01ManoNoPuedeTenerMenosDe_3_Cartas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoInvalidoConDosCartas yConCartasDePie: self mazoValido ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test02PieNoPuedeTenerMenosDe_3_Cartas

	self 
	should: [RondaDeTruco ConCartasDeMano: self otroMazoValido yConCartasDePie: self mazoInvalidoConDosCartas ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test03ManoNoPuedeTenerMasDe_3_Cartas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoInvalidoConMasDeTresCartas yConCartasDePie: self mazoValido]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test04PieNoPuedeTenerMasDe_3_Cartas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self mazoInvalidoConMasDeTresCartas ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test05ManoNoPuedeTenerCartasRepetidas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoInvalidoConCartasRepetidas yConCartasDePie: self mazoValido]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:25 pm (UTC)'!
test06PieNoPuedeTenerCartasRepetidas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self mazoInvalidoConCartasRepetidas]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:39:37 pm (UTC)'!
test07AmbosMazosNoPuedenTenerCartasMismasCartas

	self 
	should: [RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self mazoValido ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco cartasInvalidadErrorDescription .! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 2:22:58 pm (UTC)'!
test08AlComenzarRondaNoHayCartasJugadas

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	
	self assert: (ronda cartasJugadasPorManoSon: {}).
	self assert: (ronda cartasJugadasPorPieSon: {}).
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:06 pm (UTC)'!
test09ManoNoPuedeJugarCartaQueNoTiene

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	
	
	self 
	should: [ronda juegaManoCon: CartaDeTruco anchoDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco cartaNoDisponibleErrorDescription.
			self assert: (ronda cartasJugadasPorManoSon: {} ).
			self assert: (ronda cartasJugadasPorPieSon: {}).
		].
	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test10PieNoPuedeJugarCartaQueNoTiene

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	self 
	should: [ronda juegaPieCon: CartaDeTruco anchoDeBasto ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco cartaNoDisponibleErrorDescription.
			self assert: (ronda cartasJugadasPorManoSon: {}).
			self assert: (ronda cartasJugadasPorPieSon: {}).
		].
	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:05 pm (UTC)'!
test11ManoPuedeJugarCartaDisponible

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	
	self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto}).
	self assert: (ronda cartasJugadasPorPieSon: {}).

	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:22:27 pm (UTC)'!
test12ManoNoPuedeJugarCuandoEsElTurnoDelPie

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	
	self
	should: [ronda juegaManoCon: CartaDeTruco sieteDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: RondaDeTruco turnoInvalidoErrorDescription .
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto}).
			self assert: (ronda cartasJugadasPorPieSon: {}).
		] .

	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:06 pm (UTC)'!
test13CartasJugadasPorManoNoContieneCartasNoJugadas

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	
	self deny: (ronda cartasJugadasPorManoSon: {CartaDeTruco sieteDeOro }).


	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:22:27 pm (UTC)'!
test14PieNoPuedeComenzarJugandoEnElPrimerEnfrentamiento

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	

	self
	should: [ronda juegaPieCon: CartaDeTruco anchoDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: RondaDeTruco turnoInvalidoErrorDescription.
			self assert: (ronda cartasJugadasPorManoSon: {}).
			self assert: (ronda cartasJugadasPorPieSon: {}).
		] .

	
	 ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test15PiePuedeJugarCartaDisponible

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.

	 self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco anchoDeEspada} ).! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test16CartasJugadasPorPieNoContieneCartasNoJugadas

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.

	 self deny: (ronda cartasJugadasPorPieSon: {CartaDeTruco sieteDeOro } ).! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test17PieEmpiezaElSegundoEnfrentamientoCuandoGanaElPrimero

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.
	ronda juegaPieCon: CartaDeTruco sieteDeOro .
	
	 self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco  anchoDeEspada .CartaDeTruco sieteDeOro } ).
	self assert: (ronda puntosDePieSon: 1).! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test18ManoEmpiezaTercerEnfrentamientoCuandoGanaElSegundo

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.
	ronda juegaPieCon: CartaDeTruco sieteDeOro .
	ronda juegaManoCon: CartaDeTruco sieteDeEspada .
	ronda juegaManoCon:( CartaDeTruco oroCon: 2).
	
	self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco  anchoDeEspada .CartaDeTruco sieteDeOro } ).
	self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto . CartaDeTruco sieteDeEspada . CartaDeTruco oroCon: 2})! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:22:27 pm (UTC)'!
test19PieNoPuedeJugarCuandoLeTocaAMano

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.
	ronda juegaPieCon: CartaDeTruco sieteDeOro .
	
	self
	should: [ronda juegaPieCon: (CartaDeTruco copaCon: 2)]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco turnoInvalidoErrorDescription .
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto }).
			self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco anchoDeEspada . CartaDeTruco sieteDeOro }).
			self assert: (ronda puntosDePieSon: 1)
		]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test20PieEmpiezaTercerEnfrentamientoSiGanaElSegundo

    | ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.

	ronda juegaManoCon: CartaDeTruco sieteDeEspada.
	ronda juegaPieCon: CartaDeTruco sieteDeOro.
	ronda juegaManoCon: CartaDeTruco anchoDeBasto.
	ronda juegaPieCon: CartaDeTruco anchoDeEspada.
	ronda juegaPieCon: (CartaDeTruco copaCon: 2).

	self assert: (ronda cartasJugadasPorPieSon: {
        CartaDeTruco sieteDeOro.
        CartaDeTruco anchoDeEspada.
        CartaDeTruco copaCon: 2 }).

	self assert: (ronda cartasJugadasPorManoSon: {
        CartaDeTruco sieteDeEspada.
        CartaDeTruco anchoDeBasto }).! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test21ManoNoPuedeLanzarVolverALanzarUnaCartaYaJugada

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco sieteDeOro .
	
	self
	should: [ronda juegaManoCon: CartaDeTruco anchoDeBasto ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: RondaDeTruco cartaNoDisponibleErrorDescription .
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto }).
		]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:07:14 pm (UTC)'!
test22PieNoPuedeLanzarVolverALanzarUnaCartaYaJugada

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido.
	
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada .
	
	self
	should: [ronda juegaPieCon: CartaDeTruco anchoDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: RondaDeTruco cartaNoDisponibleErrorDescription .
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeBasto }).
		]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 3:20:02 pm (UTC)'!
test23ManoNoPuedeComenzarElSegundoEnfrentamientoSiPieGanoElPrimero

    | ronda |
    ronda := RondaDeTruco
        ConCartasDeMano: self mazoValido
        yConCartasDePie: self otroMazoValido.

    ronda juegaManoCon: CartaDeTruco anchoDeBasto.
    ronda juegaPieCon: CartaDeTruco anchoDeEspada.

    self
        should: [ronda juegaManoCon: CartaDeTruco sieteDeEspada]
        raise: Error - MessageNotUnderstood .

    self assert: (ronda cartasJugadasPorManoSon: {
        CartaDeTruco anchoDeBasto }).

    self assert: (ronda cartasJugadasPorPieSon: {
        CartaDeTruco anchoDeEspada })! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 4:26:24 pm (UTC)'!
test24ManoGanaRondaTrasGanar_2_Enfrentamientos

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mejorMazo yConCartasDePie: self peorMazo .
	
	ronda juegaManoCon: CartaDeTruco anchoDeEspada .
	ronda juegaPieCon: (CartaDeTruco copaCon: 4).
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: (CartaDeTruco oroCon: 4).
	
	self
	should: [ronda juegaManoCon: CartaDeTruco sieteDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco turnoInvalidoErrorDescription .
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco anchoDeEspada . CartaDeTruco anchoDeBasto }).
			self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco copaCon: 4. CartaDeTruco oroCon: 4}).
			self assert: ronda ganoMano .
			self deny: ronda ganoPie .
		]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 4:25:54 pm (UTC)'!
test25PieGanaRondaTrasGanar_2_Enfrentamientos

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self peorMazo yConCartasDePie: self mejorMazo .

	ronda juegaManoCon: (CartaDeTruco copaCon: 4).	
	ronda juegaPieCon: CartaDeTruco anchoDeEspada .
	ronda juegaPieCon: CartaDeTruco anchoDeBasto .
	ronda juegaManoCon: (CartaDeTruco oroCon: 4).
	
	self
	should: [ronda juegaPieCon: CartaDeTruco sieteDeEspada ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: RondaDeTruco turnoInvalidoErrorDescription .
			self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco anchoDeEspada . CartaDeTruco anchoDeBasto }).
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco copaCon: 4. CartaDeTruco oroCon: 4}).
			self deny: ronda ganoMano.
			self assert: ronda ganoPie.
		]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 4:11:29 pm (UTC)'!
test26GanaManoConPardaEnLaPrimeraYGanandoElSegundoEnfrentamiento

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido .

	ronda juegaManoCon: (CartaDeTruco oroCon: 2).	
	ronda juegaPieCon: (CartaDeTruco copaCon: 2) .
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco sieteDeOro .

	
	self assert: ronda ganoMano.
	self deny: ronda ganoPie.! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 4:27:15 pm (UTC)'!
test27GanaPieConPardaEnLaPrimeraYGanandoElSegundoEnfrentamiento

	| ronda |
	ronda := RondaDeTruco ConCartasDeMano: self mazoValido yConCartasDePie: self otroMazoValido .

	ronda juegaManoCon: (CartaDeTruco oroCon: 2).	
	ronda juegaPieCon: (CartaDeTruco copaCon: 2) .
	ronda juegaManoCon: CartaDeTruco anchoDeBasto .
	ronda juegaPieCon: CartaDeTruco anchoDeEspada .

	
	self deny: ronda ganoMano.
	self assert: ronda ganoPie.! !


!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 12:32:36 pm (UTC)'!
mazoInvalidoConCartasRepetidas

	^ {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada }! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 12:25:30 pm (UTC)'!
mazoInvalidoConDosCartas

	^ {CartaDeTruco anchoDeBasto. CartaDeTruco }! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 12:28:25 pm (UTC)'!
mazoInvalidoConMasDeTresCartas

	^ {CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada . CartaDeTruco copaCon: 2. CartaDeTruco espadaCon: 3}! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 1:34:20 pm (UTC)'!
mazoValido

	^ {CartaDeTruco anchoDeBasto . CartaDeTruco sieteDeEspada . CartaDeTruco oroCon: 2}! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 3:50:52 pm (UTC)'!
mejorMazo
	
	^ {CartaDeTruco anchoDeEspada . CartaDeTruco anchoDeBasto . CartaDeTruco sieteDeEspada }.! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 2:33:37 pm (UTC)'!
otroMazoValido

	^ {CartaDeTruco anchoDeEspada . CartaDeTruco sieteDeOro . CartaDeTruco copaCon: 2}! !

!TrucoTest methodsFor: 'creacion - mazo' stamp: 'HAW 14/Nov/2026, 3:51:17 pm (UTC)'!
peorMazo
	
	^ {CartaDeTruco copaCon: 4. CartaDeTruco oroCon: 4. CartaDeTruco bastoCon: 4}.! !
