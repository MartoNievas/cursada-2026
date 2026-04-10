!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'Martin 4/10/2026 13:50:02'!
initialize
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 13:48:12'!
accelerate
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'1.Replace-if-Type'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 4/10/2026 13:42:26'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'move' stamp: 'Martin 4/10/2026 13:47:21'!
accelerate

speed  := speed + (10 * kilometer  / hour ).
altitude := altitude + (5 * meter ).! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'move' stamp: 'Martin 4/10/2026 13:48:06'!
accelerate

speed  := speed + (20 * kilometer  / hour ).! !
