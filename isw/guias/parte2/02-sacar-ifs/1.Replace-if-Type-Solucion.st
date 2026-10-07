!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'MA 27/Aug/2026, 12:15:10 pm (UTC)'!
!methodProperties: {}!
initialize

	speed := 0 * kilometer / hour .! !


!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 12:17:35 pm (UTC)'!
!methodProperties: {}!
accelerate

	self  subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'1.Replace-if-Type'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 12:14:39 pm (UTC)'!
!methodProperties: {}!
helicopter

	^ Helicopter new.! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 12:14:47 pm (UTC)'!
!methodProperties: {}!
motorcycle

	^ Motorcycle new.! !


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'move' stamp: 'MA 27/Aug/2026, 12:17:01 pm (UTC)'!
!methodProperties: {}!
accelerate

	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter ).! !


!Helicopter methodsFor: 'initialization' stamp: 'MA 27/Aug/2026, 12:16:01 pm (UTC)'!
!methodProperties: {}!
initialize

	super initialize.
	altitude := 0 * meter .! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 12:17:29 pm (UTC)'!
!methodProperties: {}!
accelerate

	speed := speed + (20 * kilometer / hour). ! !
