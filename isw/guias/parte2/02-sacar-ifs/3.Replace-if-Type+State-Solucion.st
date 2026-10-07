!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed powerState'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'Martin 10/Apr/2026, 5:51:09 pm (UTC)'!
!methodProperties: {}!
initialize
	
	self turnOff.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:16:36 pm (UTC)'!
!methodProperties: {}!
accelerate
	
	powerState accelerateWith: self.! !

!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:15:23 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOff

	self error: self canNotAccelerateErrorMessage .! !

!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:15:36 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOn

	self subclassResponsibility .! !


!Vehicle methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 8:14:50 pm (UTC)'!
!methodProperties: {}!
turnOff

	powerState := TurnedOff new.! !

!Vehicle methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 8:14:55 pm (UTC)'!
!methodProperties: {}!
turnOn

	powerState := TurnedOn new.! !


!Vehicle methodsFor: 'error messages' stamp: 'Martin 10/Apr/2026, 6:10:24 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage

	self subclassResponsibility .
"
	type = #Helicopter ifTrue:[^'Can not fly when turned off'].
	type = #Motorcycle ifTrue:[^'Can not run when turned off']."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 10/Apr/2026, 6:17:55 pm (UTC)'!
!methodProperties: {}!
helicopter

	^Helicopter new.
! !

!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 10/Apr/2026, 6:18:11 pm (UTC)'!
!methodProperties: {}!
motorcycle

	^Motorcycle new.! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:15:36 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOn
	
	speed := speed + (10 * kilometer / hour ).
	altitude  := altitude + (5 * meter).! !


!Helicopter methodsFor: 'initialization' stamp: 'Martin 10/Apr/2026, 6:17:16 pm (UTC)'!
!methodProperties: {}!
initialize

	super initialize.
	altitude  := 0 * meter .
	! !


!Helicopter methodsFor: 'error messages' stamp: 'Martin 10/Apr/2026, 6:08:15 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 8:15:36 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleIsTurnedOn

	speed := speed + (20 * kilometer / hour).! !


!Motorcycle methodsFor: 'error messages' stamp: 'Martin 10/Apr/2026, 6:08:26 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage

	^'Can not run when turned off'! !


!classDefinition: #VehicleState category: #'3.Replace-if-Type+State'!
Object subclass: #VehicleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!VehicleState methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:14:05 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	self subclassResponsibility .! !


!classDefinition: #TurnedOff category: #'3.Replace-if-Type+State'!
VehicleState subclass: #TurnedOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!TurnedOff methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:15:23 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleIsTurnedOff .! !


!classDefinition: #TurnedOn category: #'3.Replace-if-Type+State'!
VehicleState subclass: #TurnedOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!TurnedOn methodsFor: 'accelerate with' stamp: 'MA 27/Aug/2026, 8:15:36 pm (UTC)'!
!methodProperties: {}!
accelerateWith: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleIsTurnedOn .! !
