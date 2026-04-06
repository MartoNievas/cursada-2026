!classDefinition: #Zombie category: #Ejercicio3!
DenotativeObject subclass: #Zombie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zombie class' category: #Ejercicio3!
Zombie class
	instanceVariableNames: 'energia'!

!Zombie class methodsFor: 'new' stamp: 'Martin 4/5/2026 18:34:38'!
nuevo
	energia := 28! !


!Zombie class methodsFor: 'accesing' stamp: 'Martin 4/5/2026 18:35:00'!
energia
	^energia! !


!Zombie class methodsFor: 'modified' stamp: 'Martin 4/5/2026 18:42:49'!
caminar: unaCantidadDeKilometros
	energia := energia - (unaCantidadDeKilometros + 3)! !

!Zombie class methodsFor: 'modified' stamp: 'Martin 4/5/2026 18:39:44'!
comer: unaCantidadDeKilosDeCerebro
	energia := energia + (4 * unaCantidadDeKilosDeCerebro )! !
