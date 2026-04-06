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

!Falso class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:53:35'!
no
	^Verdadero .! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:57:03'!
o: unBooleano
	^unBooleano ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:01:42'!
siFalso: unClousure
	^unClousure value ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:59:41'!
siVerdadero: unClousure
	! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:55:34'!
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

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:53:59'!
no
	^Falso ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:57:29'!
o: unBooleano
	^Verdadero ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:02:07'!
siFalso: unClousure! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:00:33'!
siVerdadero: unClousure
	^unClousure  value ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 18:56:19'!
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

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:04:48'!
test01VerdaderoNegadoEsFalso
	Assert that: Verdadero  no isEqualTo: Falso.! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:06:11'!
test02FalsoNegadoEsVerdadero

Assert that: Falso no isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:07:20'!
test03VerdaderoYVerdaderoEsVerdadero

Assert that: (Verdadero  y: Verdadero) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:08:08'!
test04VerdaderoYFalsoEsFalso
	Assert  that: (Verdadero y: Falso ) isEqualTo: Falso .! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:09:04'!
test05VerdaderoOVerdaderoEsVerdadero

Assert that: (Verdadero o: Verdadero ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:09:43'!
test06VerdaderoOFalsoEsVerdadero

Assert that: (Verdadero  o: Falso ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:10:57'!
test07FalsoSiFalsoEjecuta

Assert that: (Falso siFalso: ['Ejecuta']) isEqualTo: 'Ejecuta'.! !

!VerdaderoFalsoTest class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:11:52'!
test08VerdaderoSiFalsoNoEjecuta

Assert that: (Verdadero siFalso: ['Ejecuta']) isEqualTo: Verdadero .! !


!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:04:48'!
test01VerdaderoNegadoEsFalso
	Assert that: Verdadero  no isEqualTo: Falso.! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:06:11'!
test02FalsoNegadoEsVerdadero

Assert that: Falso no isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:09:43'!
test06VerdaderoOFalsoEsVerdadero

Assert that: (Verdadero  o: Falso ) isEqualTo: Verdadero .! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:10:57'!
test07FalsoSiFalsoEjecuta

Assert that: (Falso siFalso: ['Ejecuta']) isEqualTo: 'Ejecuta'.! !
