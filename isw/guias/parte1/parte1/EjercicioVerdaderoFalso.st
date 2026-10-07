!classDefinition: #Falso category: #EjercicioVerdaderoFalso!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioVerdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #EjercicioVerdaderoFalso!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:53:35 pm (UTC)'!
!methodProperties: {}!
no
	^Verdadero .! !

!Falso class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:57:03 pm (UTC)'!
!methodProperties: {}!
o: unBooleano
	^unBooleano ! !

!Falso class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 10:01:42 pm (UTC)'!
!methodProperties: {}!
siFalso: unClousure
	^unClousure value ! !

!Falso class methodsFor: 'operaciones logicas' stamp: 'HAW 12/Aug/2026, 1:04:04 am (UTC)'!
!methodProperties: {}!
siVerdadero: unClousure
	
	^ nil.
	! !

!Falso class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:55:34 pm (UTC)'!
!methodProperties: {}!
y: unBooleano 
	^self! !


!classDefinition: #Verdadero category: #EjercicioVerdaderoFalso!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioVerdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #EjercicioVerdaderoFalso!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:53:59 pm (UTC)'!
!methodProperties: {}!
no
	^Falso ! !

!Verdadero class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:57:29 pm (UTC)'!
!methodProperties: {}!
o: unBooleano
	^Verdadero ! !

!Verdadero class methodsFor: 'operaciones logicas' stamp: 'HAW 12/Aug/2026, 1:02:55 am (UTC)'!
!methodProperties: {}!
siFalso: unClousure

	^ nil.! !

!Verdadero class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 10:00:33 pm (UTC)'!
!methodProperties: {}!
siVerdadero: unClousure
	^unClousure  value ! !

!Verdadero class methodsFor: 'operaciones logicas' stamp: 'Martin 5/Apr/2026, 9:56:19 pm (UTC)'!
!methodProperties: {}!
y: unBooleano
	^unBooleano ! !


!classDefinition: #VerdaderoFalsoTest category: #EjercicioVerdaderoFalso!
DenotativeObject subclass: #VerdaderoFalsoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioVerdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VerdaderoFalsoTest class' category: #EjercicioVerdaderoFalso!
VerdaderoFalsoTest class
	instanceVariableNames: ''!

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:04:48 pm (UTC)'!
!methodProperties: {}!
test01VerdaderoNegadoEsFalso
	Assert that: Verdadero  no isEqualTo: Falso.! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:06:11 pm (UTC)'!
!methodProperties: {}!
test02FalsoNegadoEsVerdadero

Assert that: Falso no isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:09:43 pm (UTC)'!
!methodProperties: {}!
test06VerdaderoOFalsoEsVerdadero

Assert that: (Verdadero  o: Falso ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:10:57 pm (UTC)'!
!methodProperties: {}!
test07FalsoSiFalsoEjecuta

Assert that: (Falso siFalso: ['Ejecuta']) isEqualTo: 'Ejecuta'.! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:06:21 am (UTC)'!
!methodProperties: {}!
test09VerdaderoSiVerdaderoSiEjecuta

Assert that: (Verdadero siVerdadero: ['Ejecuta']) isEqualTo: 'Ejecuta' .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:07:01 am (UTC)'!
!methodProperties: {}!
test10FalsoSiVerdaderoNoEjecuta

Assert that: (Falso siVerdadero: ['Ejecuta']) isEqualTo: nil .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:07:46 am (UTC)'!
!methodProperties: {}!
test11FalsoYFalsoEsFalso

Assert that: (Falso y: Falso) isEqualTo: Falso .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:09:56 am (UTC)'!
!methodProperties: {}!
test12FalsoOFalsoEsFalso

Assert that: (Falso o: Falso ) isEqualTo: Falso .
	! !


!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:04:48 pm (UTC)'!
!methodProperties: {}!
test01VerdaderoNegadoEsFalso
	Assert that: Verdadero  no isEqualTo: Falso.! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:06:11 pm (UTC)'!
!methodProperties: {}!
test02FalsoNegadoEsVerdadero

Assert that: Falso no isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 10:07:20 pm (UTC)'!
!methodProperties: {}!
test03VerdaderoYVerdaderoEsVerdadero

Assert that: (Verdadero  y: Verdadero) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 10:08:08 pm (UTC)'!
!methodProperties: {}!
test04VerdaderoYFalsoEsFalso
	Assert  that: (Verdadero y: Falso ) isEqualTo: Falso .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 10:09:04 pm (UTC)'!
!methodProperties: {}!
test05VerdaderoOVerdaderoEsVerdadero

Assert that: (Verdadero o: Verdadero ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:09:43 pm (UTC)'!
!methodProperties: {}!
test06VerdaderoOFalsoEsVerdadero

Assert that: (Verdadero  o: Falso ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:10:57 pm (UTC)'!
!methodProperties: {}!
test07FalsoSiFalsoEjecuta

Assert that: (Falso siFalso: ['Ejecuta']) isEqualTo: 'Ejecuta'.! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:05:22 am (UTC)'!
!methodProperties: {}!
test08VerdaderoSiFalsoNoEjecuta

Assert that: (Verdadero siFalso: ['Ejecuta']) isEqualTo: nil .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:06:21 am (UTC)'!
!methodProperties: {}!
test09VerdaderoSiVerdaderoSiEjecuta

Assert that: (Verdadero siVerdadero: ['Ejecuta']) isEqualTo: 'Ejecuta' .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:07:01 am (UTC)'!
!methodProperties: {}!
test10FalsoSiVerdaderoNoEjecuta

Assert that: (Falso siVerdadero: ['Ejecuta']) isEqualTo: nil .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:07:46 am (UTC)'!
!methodProperties: {}!
test11FalsoYFalsoEsFalso

Assert that: (Falso y: Falso) isEqualTo: Falso .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:09:56 am (UTC)'!
!methodProperties: {}!
test12FalsoOFalsoEsFalso

Assert that: (Falso o: Falso ) isEqualTo: Falso .
	! !
