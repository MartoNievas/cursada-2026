!classDefinition: #Automobile category: '0.Replace-if-Strategy'!
Object subclass: #Automobile
	instanceVariableNames: 'speed engine'
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Strategy'!

!Automobile methodsFor: 'initialization' stamp: 'MA 27/Aug/2026, 3:41:03 pm (UTC)'!
!methodProperties: {}!
initializeWithEngine: anEngine
	
	engine := anEngine.
	speed := 0 * kilometer / hour! !


!Automobile methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:44:09 pm (UTC)'!
!methodProperties: {}!
accelerate
	
	speed  := self acceleratedSpeed.! !

!Automobile methodsFor: 'move' stamp: 'MA 27/Aug/2026, 3:43:10 pm (UTC)'!
!methodProperties: {}!
acceleratedSpeed

	^ speed + engine accelerationFrom: speed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Automobile class' category: '0.Replace-if-Strategy'!
Automobile class
	instanceVariableNames: ''!

!Automobile class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:41:03 pm (UTC)'!
!methodProperties: {}!
electric

	^ self new initializeWithEngine: ElectricEngine new.

! !

!Automobile class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:41:03 pm (UTC)'!
!methodProperties: {}!
gasoline

	^ self new initializeWithEngine: GasolineEngine new.! !

!Automobile class methodsFor: 'instance creation' stamp: 'MA 27/Aug/2026, 3:41:03 pm (UTC)'!
!methodProperties: {}!
jetFueled

	^ self new initializeWithEngine:  JetFueledEngine new.! !


!classDefinition: #Engine category: '0.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Strategy'!

!Engine methodsFor: 'acceleration' stamp: 'MA 27/Aug/2026, 3:43:35 pm (UTC)'!
!methodProperties: {}!
accelerationFrom: aCurrentSpeedToAccelerate

	self subclassResponsibility .! !


!classDefinition: #ElectricEngine category: '0.Replace-if-Strategy'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Strategy'!

!ElectricEngine methodsFor: 'acceleration' stamp: 'MA 27/Aug/2026, 3:45:05 pm (UTC)'!
!methodProperties: {}!
accelerationFrom: aCurrentSpeedToAccelerate
	
	^ (aCurrentSpeedToAccelerate + (5 * kilometer / hour))* 2

! !


!classDefinition: #GasolineEngine category: '0.Replace-if-Strategy'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Strategy'!

!GasolineEngine methodsFor: 'acceleration' stamp: 'MA 27/Aug/2026, 3:45:26 pm (UTC)'!
!methodProperties: {}!
accelerationFrom: aCurrentSpeedToAccelerate
	
	^ (10 * kilometer / hour)

! !


!classDefinition: #JetFueledEngine category: '0.Replace-if-Strategy'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Strategy'!

!JetFueledEngine methodsFor: 'acceleration' stamp: 'MA 27/Aug/2026, 3:46:07 pm (UTC)'!
!methodProperties: {}!
accelerationFrom: aCurrentSpeedToAccelerate
	
	^ ((aCurrentSpeedToAccelerate amount + 1) ^ 2) * kilometer / hour
! !
