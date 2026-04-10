!classDefinition: #PowerState category: #'3.Replace-if-Type+State'!
Object subclass: #PowerState
	instanceVariableNames: 'vehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerState methodsFor: 'initialize' stamp: 'Martin 4/10/2026 14:56:25'!
initializePowerStateof: aVehicle

	vehicleToPower := aVehicle .! !


!PowerState methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 14:57:57'!
accelerate

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerState class' category: #'3.Replace-if-Type+State'!
PowerState class
	instanceVariableNames: ''!

!PowerState class methodsFor: 'new' stamp: 'Martin 4/10/2026 14:56:55'!
on: aVehicle

	^self new initializePowerStateof: aVehicle .! !


!classDefinition: #PowerOff category: #'3.Replace-if-Type+State'!
PowerState subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOff methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 15:08:59'!
accelerate

	vehicleToPower accelerateWhenTurnedOff .! !


!classDefinition: #PowerOn category: #'3.Replace-if-Type+State'!
PowerState subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOn methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 15:09:18'!
accelerate

	vehicleToPower accelerateWhenTurnedOn .! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed powerState'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'Martin 4/10/2026 14:51:09'!
initialize
	
	self turnOff.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 15:15:43'!
accelerate
	
	powerState accelerate .! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 15:12:53'!
accelerateWhenTurnedOff

	self error: self canNotAccelerateErrorMessage .! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 15:00:40'!
accelerateWhenTurnedOn

	self subclassResponsibility .! !


!Vehicle methodsFor: 'on/off' stamp: 'Martin 4/10/2026 14:58:44'!
turnOff

	powerState := PowerOff on: self.! !

!Vehicle methodsFor: 'on/off' stamp: 'Martin 4/10/2026 14:53:25'!
turnOn

	powerState := PowerOn on: self.! !


!Vehicle methodsFor: 'error messages' stamp: 'Martin 4/10/2026 15:10:24'!
canNotAccelerateErrorMessage

	self subclassResponsibility .
"
	type = #Helicopter ifTrue:[^'Can not fly when turned off'].
	type = #Motorcycle ifTrue:[^'Can not run when turned off']."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 4/10/2026 15:17:55'!
helicopter

	^Helicopter new.
! !

!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 4/10/2026 15:18:11'!
motorcycle

	^Motorcycle new.! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 15:11:03'!
accelerateWhenTurnedOn
	
	speed := speed + (10 * kilometer / hour ).
	altitude  := altitude + (5 * meter).! !


!Helicopter methodsFor: 'initialization' stamp: 'Martin 4/10/2026 15:17:16'!
initialize

	super initialize.
	altitude  := 0 * meter .
	! !


!Helicopter methodsFor: 'error messages' stamp: 'Martin 4/10/2026 15:08:15'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 15:11:25'!
accelerateWhenTurnedOn

	speed := speed + (20 * kilometer / hour).! !


!Motorcycle methodsFor: 'error messages' stamp: 'Martin 4/10/2026 15:08:26'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'! !
