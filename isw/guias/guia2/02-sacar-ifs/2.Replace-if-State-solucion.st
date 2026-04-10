!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'powerState speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'Martin 4/10/2026 14:28:45'!
initialize

	self turnOff .
	speed := 0 * kilometer / hour! !


!Automobile methodsFor: 'move' stamp: 'Martin 4/10/2026 14:29:51'!
accelerate
	
	powerState accelerate.
	"
	state = #Off ifTrue:[self error: 'Can not accelerate when turned off'].
	state = #On ifTrue:[speed := speed + (10 * kilometer / hour)].
	"! !

!Automobile methodsFor: 'move' stamp: 'Martin 4/10/2026 14:31:04'!
accelerateWhenTurnedOff

	self error: 'Can`t not accelerate when turned off'.! !

!Automobile methodsFor: 'move' stamp: 'Martin 4/10/2026 14:31:42'!
accelerateWhenTurnedOn


	speed := speed + (10 * kilometer / hour).
	! !


!Automobile methodsFor: 'on/off' stamp: 'Martin 4/10/2026 14:26:11'!
turnOff

	powerState := PowerOn on: self.! !

!Automobile methodsFor: 'on/off' stamp: 'Martin 4/10/2026 14:26:33'!
turnOn

	powerState  := PowerOn on: self .! !


!classDefinition: #PowerState category: #'2.Replace-if-State'!
Object subclass: #PowerState
	instanceVariableNames: 'vehicle'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!PowerState methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 14:32:55'!
accelerate

	self subclassResponsibility .! !


!PowerState methodsFor: 'initialize' stamp: 'Martin 4/10/2026 14:34:57'!
initializePowerStatusOf: aVehicle

	vehicle  := aVehicle .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerState class' category: #'2.Replace-if-State'!
PowerState class
	instanceVariableNames: ''!

!PowerState class methodsFor: 'as yet unclassified' stamp: 'Martin 4/10/2026 14:36:46'!
on: aVehicle

	^self new initializePowerStatusOf: aVehicle .! !


!classDefinition: #PowerOff category: #'2.Replace-if-State'!
PowerState subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!PowerOff methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 14:38:32'!
accelerate

	vehicle accelerateWhenTurnedOff .! !


!classDefinition: #PowerOn category: #'2.Replace-if-State'!
PowerState subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!PowerOn methodsFor: 'accelerate' stamp: 'Martin 4/10/2026 14:38:50'!
accelerate

	vehicle accelerateWhenTurnedOn .! !
