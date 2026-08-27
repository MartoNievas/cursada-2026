!classDefinition: #Engine category: #'4.Replace-if-All'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Engine methodsFor: 'accelerating' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateFrom: aCurrentSpeedToAccelerate
	self subclassResponsibility.! !


!classDefinition: #ElectricEngine category: #'4.Replace-if-All'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!ElectricEngine methodsFor: 'accelerating' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateFrom: aCurrentSpeedToAccelerate
	^ aCurrentSpeedToAccelerate + (5 * kilometer / hour) * 2.! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-All'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!GasolineEngine methodsFor: 'accelerating' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateFrom: aCurrentSpeedToAccelerate
	^ 10 * kilometer / hour.! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-All'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!JetFueledEngine methodsFor: 'accelerating' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateFrom: aCurrentSpeedToAccelerate
	^ aCurrentSpeedToAccelerate amount + 1 ^ 2 * kilometer / hour.! !


!classDefinition: #Surrounding category: #'4.Replace-if-All'!
Object subclass: #Surrounding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Surrounding methodsFor: 'speed limit' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedLimit

	self subclassResponsibility .! !


!Surrounding methodsFor: 'limit' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
restrictSpeedToSurroundingLimit: aCurrentSpeedToBeLimited
	^ aCurrentSpeedToBeLimited min: self speedLimit.! !


!classDefinition: #City category: #'4.Replace-if-All'!
Surrounding subclass: #City
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!City methodsFor: 'speed limit' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedLimit
	
	^ 70 * kilometer / hour. ! !


!classDefinition: #OpenRoad category: #'4.Replace-if-All'!
Surrounding subclass: #OpenRoad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!OpenRoad methodsFor: 'speed limit' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedLimit
	
	^ 130 * kilometer / hour.! !


!classDefinition: #Skies category: #'4.Replace-if-All'!
Surrounding subclass: #Skies
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Skies methodsFor: 'speed limit' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedLimit

	^ 500 * kilometer / hour. ! !


!classDefinition: #Vehicle category: #'4.Replace-if-All'!
Object subclass: #Vehicle
	instanceVariableNames: 'state speed engine surrounding'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Vehicle methodsFor: 'initialization' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
initializeWithEngine: arg1 andSurroundings: arg2
	state := TurnedOff new.
	engine := arg1.
	surrounding := arg2.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerate
	state hitTheGasFrom: self.! !

!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleTurnedOn
	speed := surrounding restrictSpeedToSurroundingLimit: self speedWithAcceleration.! !

!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedAt: aSpeed

	^ speed = aSpeed! !

!Vehicle methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
speedWithAcceleration
	^ speed + (engine accelerateFrom: speed).! !


!Vehicle methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
turnOff

	state := TurnedOff new.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
turnOn

	state := TurnedOn new.! !


!Vehicle methodsFor: 'error messages' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerateWhenVehicleTunerdOff
	self error: self canNotAccelerateErrorMessage.! !

!Vehicle methodsFor: 'error messages' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-All'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
electricMotorcycle

	^ Motorcycle new initializeWithEngine: ElectricEngine new andSurroundings: City new .

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
gasolineMotorcycle

	^ Motorcycle new initializeWithEngine: GasolineEngine new andSurroundings: OpenRoad new ! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
helicopter

	^ Helicopter new! !


!classDefinition: #Helicopter category: #'4.Replace-if-All'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Helicopter methodsFor: 'initialization' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
initialize

	super initializeWithEngine: JetFueledEngine new andSurroundings: Skies new.
	altitude := 0 * meter.

	! !


!Helicopter methodsFor: 'error messages' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'.
	! !


!Helicopter methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
accelerate
	super  accelerate.
	altitude := altitude + (5 * meter).
! !

!Helicopter methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
altitudeAt: anAltitude

	^ altitude = anAltitude! !


!classDefinition: #Motorcycle category: #'4.Replace-if-All'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Motorcycle methodsFor: 'error messages' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
canNotAccelerateErrorMessage


	^'Can not run when turned off'.! !


!classDefinition: #VehicleState category: #'4.Replace-if-All'!
Object subclass: #VehicleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!VehicleState methodsFor: 'starting move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
hitTheGasFrom: aVehicle

	self subclassResponsibility .! !


!classDefinition: #TurnedOff category: #'4.Replace-if-All'!
VehicleState subclass: #TurnedOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!TurnedOff methodsFor: 'starting move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
hitTheGasFrom: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleTunerdOff.! !


!classDefinition: #TurnedOn category: #'4.Replace-if-All'!
VehicleState subclass: #TurnedOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!TurnedOn methodsFor: 'starting move' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
hitTheGasFrom: aVehicleToAccelerate

	aVehicleToAccelerate accelerateWhenVehicleTurnedOn.! !


!classDefinition: #VehicleTests category: #'4.Replace-if-All'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
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

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
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

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
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

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
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

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'MA 27/Aug/2026, 3:33:16 pm (UTC)'!
!methodProperties: {}!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !
