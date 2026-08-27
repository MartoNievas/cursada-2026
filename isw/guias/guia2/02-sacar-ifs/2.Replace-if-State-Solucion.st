!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'powerState speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'Martin 10/Apr/2026, 5:28:45 pm (UTC)'!
!methodProperties: {}!
initialize

	self turnOff .
	speed := 0 * kilometer / hour! !


!Automobile methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:08:41 pm (UTC)'!
!methodProperties: {}!
accelerate
	
	powerState accelerateWith: self.! !

!Automobile methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:10:38 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOff

	self error: 'Can not accelerate when turned off'.! !

!Automobile methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:07:25 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOn


	speed := speed + (10 * kilometer / hour).
	! !


!Automobile methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 8:07:53 pm (UTC)'!
!methodProperties: {}!
turnOff

	powerState := TurnedOff new.! !

!Automobile methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 8:08:02 pm (UTC)'!
!methodProperties: {}!
turnOn

	powerState  := TurnedOn new .! !


!classDefinition: #AutomobileState category: #'2.Replace-if-State'!
Object subclass: #AutomobileState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutomobileState methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:08:41 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	self subclassResponsibility .! !


!classDefinition: #TurnedOff category: #'2.Replace-if-State'!
AutomobileState subclass: #TurnedOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!TurnedOff methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:10:56 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleIsTurnedOff .! !


!classDefinition: #TurnedOn category: #'2.Replace-if-State'!
AutomobileState subclass: #TurnedOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!TurnedOn methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:08:41 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleIsTurnedOn.! !
