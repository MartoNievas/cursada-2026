!classDefinition: #Ejercicio1 category: #Ejercicio1!
DenotativeObject subclass: #Ejercicio1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ejercicio1 class' category: #Ejercicio1!
Ejercicio1 class
	instanceVariableNames: 'aVar'!

!Ejercicio1 class methodsFor: 'as yet unclassified' stamp: 'Martin 4/7/2026 16:19:25'!
m1
	|b|
	
	b := 42.
	aVar  := 1.
	
	^ self m2: b! !

!Ejercicio1 class methodsFor: 'as yet unclassified' stamp: 'Martin 4/7/2026 16:20:34'!
m2: anotherValue

	|b|
	
	b := 24.
	aVar < 3 ifTrue: [aVar := aVar  + anotherValue ].
	
	^ aVar  + b.! !
