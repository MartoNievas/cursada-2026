!classDefinition: #Engine category: #'4.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Engine methodsFor: 'move' stamp: 'Martin 4/10/2026 19:52:43'!
acceleration

	self subclassResponsibility .! !


!classDefinition: #ElectricEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!ElectricEngine methodsFor: 'move' stamp: 'Martin 4/10/2026 19:54:32'!
acceleration: aCurrentSpeed

	^ (aCurrentSpeed + (5 * kilometer  / hour)) * 2.! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!GasolineEngine methodsFor: 'move' stamp: 'Martin 4/10/2026 19:56:54'!
acceleration: aCurrentSpeed

	^ 10 * kilometer / hour .! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!JetFueledEngine methodsFor: 'move' stamp: 'Martin 4/10/2026 19:58:08'!
acceleration: aCurrentSpeed

	^ ((aCurrentSpeed amount  + 1) ^ 2) * kilometer / hour .
! !


!classDefinition: #PowerStatus category: #'4.Replace-if-Strategy'!
Object subclass: #PowerStatus
	instanceVariableNames: 'vehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerStatus methodsFor: 'move' stamp: 'Martin 4/10/2026 19:37:11'!
accelerate

	self subclassResponsibility .! !


!PowerStatus methodsFor: 'initialization' stamp: 'Martin 4/10/2026 19:36:14'!
initializePowerStatusOf: aVehicle

	vehicleToPower := aVehicle .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerStatus class' category: #'4.Replace-if-Strategy'!
PowerStatus class
	instanceVariableNames: ''!

!PowerStatus class methodsFor: 'as yet unclassified' stamp: 'Martin 4/10/2026 19:35:39'!
on: aVehicle

	^self new initializePowerStatusOf: aVehicle .! !


!classDefinition: #PowerOff category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerOff methodsFor: 'move' stamp: 'Martin 4/10/2026 19:39:06'!
accelerate

	vehicleToPower accelerateWhenTurnedOff.! !


!classDefinition: #PowerOn category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerOn methodsFor: 'move' stamp: 'Martin 4/10/2026 19:39:00'!
accelerate

	vehicleToPower accelerateWhenTurnedOn.! !


!classDefinition: #SpeedLimit category: #'4.Replace-if-Strategy'!
Object subclass: #SpeedLimit
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!SpeedLimit methodsFor: 'initialization' stamp: 'Martin 4/10/2026 19:50:00'!
initializeWithLimit: aSpeedLimit

	limit := aSpeedLimit .! !


!SpeedLimit methodsFor: 'limit' stamp: 'Martin 4/10/2026 19:50:41'!
limit: aSpeed

	^ aSpeed min: limit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpeedLimit class' category: #'4.Replace-if-Strategy'!
SpeedLimit class
	instanceVariableNames: ''!

!SpeedLimit class methodsFor: 'instance creation' stamp: 'Martin 4/10/2026 19:51:21'!
limit: aSpeedLimit

	^self new initializeWithLimit: aSpeedLimit .! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerStatus speed engine speedLimiter'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Vehicle methodsFor: 'initialization' stamp: 'Martin 4/10/2026 20:25:13'!
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter

	self turnOff.
	speed := 0 * kilometer / hour .
	engine := anEngine .
	speedLimiter := aSpeedLimiter .! !


!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 20:00:26'!
accelerate

	powerStatus accelerate .	
"	
	state = #Off ifTrue: [ self error: self canNotAccelerateErrorMessage ].

	engineType = #ElectricEngine ifTrue: [ acceleration := (speed + (5 * kilometer / hour)) * 2 ].
	engineType = #GasolineEngine ifTrue: [ acceleration := 10 * kilometer / hour ].
	engineType = #JetFueledEngine ifTrue: [ acceleration := ((speed amount + 1) ^ 2) * kilometer / hour ].

	type = #Helicopter
		ifTrue:[ speed := speed + acceleration.
			altitude := altitude + (5 * meter) ].
		
	type = #Motorcycle
		ifTrue:[ speed := speed + acceleration ].
	
	where = #city ifTrue: [ speed > (70 * kilometer / hour) ifTrue: [ speed := 70 * kilometer / hour ] ].
	where = #openRoad ifTrue: [ speed > (130 * kilometer / hour) ifTrue: [ speed := 130 * kilometer / hour ] ].
	where = #skies ifTrue: [ speed > (500 * kilometer / hour) ifTrue: [ speed := 500 * kilometer / hour ] ]"! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 20:14:25'!
accelerateWhenTurnedOff

	self error: self canNotAccelerateErrorMessage .! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 20:01:54'!
accelerateWhenTurnedOn

	speed := speedLimiter limit: self accelerationSpeed.
.! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 20:02:22'!
accelerationSpeed

	^ speed + (engine acceleration: speed ).! !

!Vehicle methodsFor: 'move' stamp: 'Martin 4/10/2026 19:43:57'!
altitudeAt: anAltitude

	self subclassResponsibility .! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:23:27'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'Martin 4/10/2026 19:41:09'!
turnOff

	powerStatus := PowerOff on: self.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'Martin 4/10/2026 19:41:38'!
turnOn

	powerStatus := PowerOn on: self.! !


!Vehicle methodsFor: 'error messages' stamp: 'Martin 4/10/2026 20:03:14'!
canNotAccelerateErrorMessage
	
	self subclassResponsibility .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'testing' stamp: 'Martin 4/10/2026 20:21:11'!
electricMotorcycle

	^ Motorcycle initializeWithEngine:  ElectricEngine new andSpeedLimiter: (SpeedLimit limit: 70 * kilometer / hour).! !

!Vehicle class methodsFor: 'testing' stamp: 'Martin 4/10/2026 20:21:26'!
gasolineMotorcycle

	^ Motorcycle initializeWithEngine: GasolineEngine new andSpeedLimiter: (SpeedLimit limit: 130 * kilometer / hour).! !

!Vehicle class methodsFor: 'testing' stamp: 'Martin 4/10/2026 20:21:42'!
helicopter

	^ Helicopter  initializeWithEngine: JetFueledEngine new andSpeedLimiter: (SpeedLimit limit: 500 * kilometer / hour).! !


!Vehicle class methodsFor: 'instance creation' stamp: 'Martin 4/10/2026 20:04:26'!
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter

	^self new initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter .! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Helicopter methodsFor: 'initialization' stamp: 'Martin 4/10/2026 20:06:17'!
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter

	super initializeWithEngine:  anEngine andSpeedLimiter: aSpeedLimiter .
	altitude := 0 * meter .! !


!Helicopter methodsFor: 'error messages' stamp: 'Martin 4/10/2026 19:46:20'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'! !


!Helicopter methodsFor: 'move' stamp: 'Martin 4/10/2026 20:06:52'!
accelerateWhenTurnedOn
	super accelerateWhenTurnedOn .
	altitude := altitude  + (5 * meter).! !

!Helicopter methodsFor: 'move' stamp: 'Martin 4/10/2026 20:47:17'!
altitudeAt: anAltitude

	^altitude = anAltitude .! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Motorcycle methodsFor: 'error messages' stamp: 'Martin 4/10/2026 19:47:21'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'! !


!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:25:03'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:27:17'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:20'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := Vehicle electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:16'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := Vehicle gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:11'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := Vehicle helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:47:14'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:05'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:53:50'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:55:32'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !
