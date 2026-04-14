!classDefinition: #Cashier category: #'IRobot-Enunciado'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Cashier methodsFor: 'closing buy order' stamp: 'Martin 4/14/2026 14:33:38'!
receiveOrder: aRobot
	
	^aRobot closeOrderUsing: self.
! !

!Cashier methodsFor: 'closing buy order' stamp: 'Martin 4/14/2026 14:34:44'!
receiveOrderFromMechanicalFailure: aRobot
	    aRobot outOfOrder.
	^self receiveOrderFromNormal: aRobot .! !

!Cashier methodsFor: 'closing buy order' stamp: 'Martin 4/14/2026 14:20:05'!
receiveOrderFromSensorsFailure: aRobot

	aRobot outOfOrder.
	self signalRobotSensorsFailure! !

!Cashier methodsFor: 'closing buy order' stamp: 'Martin 4/14/2026 14:29:10'!
receiveOrderFromWorkingNormal: aRobot
	
	^ self receiveOrderFromNormal: aRobot .! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'private' stamp: 'Martin 4/14/2026 14:21:03'!
receiveOrderFromNormal: aRobot
	|aTrailer|
	aTrailer := aRobot trailer.	
		self assertTrailerNotEmpty: aTrailer.
		
		"Comentario: en este punto el cashier realizaría el checkout de los productos."
		
		^ true! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'IRobot-Enunciado'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'IRobot-Enunciado'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'IRobot-Enunciado'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'IRobot-Enunciado'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'IRobot-Enunciado'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: #'IRobot-Enunciado'!
Object subclass: #Robot
	instanceVariableNames: 'state trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Robot methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:10:58'!
carry: aProduct

	trailer carry: aProduct .! !

!Robot methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:41:34'!
closeOrderUsing: aCashier
	
	^ state closeOrderUsing: aCashier .
! !

!Robot methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:12:53'!
take: aProduct

	state take: aProduct .! !


!Robot methodsFor: 'status' stamp: 'Martin 4/14/2026 14:38:31'!
outOfOrder

	state := StateOutOfOrder for: self.! !

!Robot methodsFor: 'status' stamp: 'Martin 4/14/2026 14:38:52'!
withMechanicalFailure
	
	state := StateMechanicalFailure for: self.! !

!Robot methodsFor: 'status' stamp: 'Martin 4/14/2026 14:39:13'!
withSensorsFailure

	state := StateSensorFailure for: self.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'Martin 4/14/2026 14:37:36'!
initializeWith: aTrailer

	trailer := aTrailer.
	state := StateWorkingNormal for: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'IRobot-Enunciado'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #StateOfRobot category: #'IRobot-Enunciado'!
Object subclass: #StateOfRobot
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!StateOfRobot methodsFor: 'initialization' stamp: 'Martin 4/14/2026 10:54:47'!
initializeWith: aRobot

	robot := aRobot .! !


!StateOfRobot methodsFor: 'actions' stamp: 'Martin 4/14/2026 10:57:59'!
closeOrderUsing: aCashier

	self subclassResponsibility .! !

!StateOfRobot methodsFor: 'actions' stamp: 'Martin 4/14/2026 10:58:12'!
take: aProduct

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StateOfRobot class' category: #'IRobot-Enunciado'!
StateOfRobot class
	instanceVariableNames: ''!

!StateOfRobot class methodsFor: 'instance creation' stamp: 'Martin 4/14/2026 10:54:18'!
for: aRobot

	^self new initializeWith: aRobot .! !


!classDefinition: #StateMechanicalFailure category: #'IRobot-Enunciado'!
StateOfRobot subclass: #StateMechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!StateMechanicalFailure methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:30:20'!
closeOrderUsing: aCashier

	^aCashier receiveOrderFromMechanicalFailure: robot .! !

!StateMechanicalFailure methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:12:11'!
take: aProduct
	
	 robot carry: aProduct.! !


!classDefinition: #StateOutOfOrder category: #'IRobot-Enunciado'!
StateOfRobot subclass: #StateOutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!StateOutOfOrder methodsFor: 'actions' stamp: 'Martin 4/14/2026 11:07:39'!
closeOrderUsing: aCashier

	^ Robot signalOutOfOrder .! !

!StateOutOfOrder methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:13:52'!
take: aProduct

	Robot signalOutOfOrder .! !


!classDefinition: #StateSensorFailure category: #'IRobot-Enunciado'!
StateOfRobot subclass: #StateSensorFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!StateSensorFailure methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:30:29'!
closeOrderUsing: aCashier

	^aCashier receiveOrderFromSensorsFailure: robot ! !

!StateSensorFailure methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:14:10'!
take: aProduct

	robot carry: aProduct .! !


!classDefinition: #StateWorkingNormal category: #'IRobot-Enunciado'!
StateOfRobot subclass: #StateWorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!StateWorkingNormal methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:29:30'!
closeOrderUsing: aCashier

	^ aCashier receiveOrderFromWorkingNormal: robot .! !

!StateWorkingNormal methodsFor: 'actions' stamp: 'Martin 4/14/2026 14:14:34'!
take: aProduct

	robot carry: aProduct .! !


!classDefinition: #Trailer category: #'IRobot-Enunciado'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'Martin 4/14/2026 14:49:19'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"
	
	^ (container select: [:aProduct | aProduct isStackable ] )inject: 0 into: [:aSubTotal :aProduct | aSubTotal  + aProduct height ].! !

!Trailer methodsFor: 'accessing' stamp: 'Martin 4/14/2026 14:47:49'!
totalProductsWeight
	
	^ container inject: 0 into: [:aSubTotal :aProduct | aSubTotal  + aProduct weight ] ! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'Martin 4/14/2026 15:00:58'!
carryProductA: aProduct
	
	self add: aProduct  asserting: [	self assertWeightAdding: aProduct.]
! !

!Trailer methodsFor: 'action' stamp: 'Martin 4/14/2026 15:01:26'!
carryProductB: aProduct
	
	self add: aProduct asserting: [
				self assertWeightAdding: aProduct.
					self assertHeightAdding: aProduct.

		].! !


!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:29'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:41'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !


!Trailer methodsFor: 'private' stamp: 'Martin 4/14/2026 15:00:16'!
add: aProduct asserting: aBlock

	aBlock value.
	
	container add: aProduct .
	
	! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'IRobot-Enunciado'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !


!classDefinition: #CashierTest category: #'IRobot-Enunciado'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'Martin 4/14/2026 15:14:35'!
shouldRaise: errorMessage when: aBlock


| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.
	
	self
		should: [aBlock value: aRobot  value: aCashier ]
		raise:  Error
		withMessageText: errorMessage .

! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'Martin 4/14/2026 15:17:41'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot
	
	self shouldRaise: Cashier trailerIsEmptyErrorDescription when: [:aRobot :aCashier | aCashier receiveOrder: aRobot ].! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'Martin 4/14/2026 15:19:01'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	self shouldRaise:  Cashier trailerIsEmptyErrorDescription 
	when: [:aRobot :aCashier | aRobot withMechanicalFailure .
			aCashier receiveOrder: aRobot .
		].! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'Martin 4/14/2026 15:20:00'!
test03ShouldNotAcceptSensorsFailureRobot
	
	self shouldRaise: Cashier robotSensorsFailureErrorDescription 
	when: [:aRobot :aCashier | aRobot withSensorsFailure . aCashier  receiveOrder: aRobot ].
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'Martin 4/14/2026 15:22:10'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	self shouldRaise: Robot outOfOrderErrorDescription 
	when: [:aRobot :aCashier | aRobot take: (ProductA with: 1 and: 1). 
				aRobot withMechanicalFailure .
				
				aCashier receiveOrder: aRobot .
				aRobot take: (ProductA with: 1 and: 1)
		].! !


!classDefinition: #ProductTest category: #'IRobot-Enunciado'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: #'IRobot-Enunciado'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: #'IRobot-Enunciado'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 16:06:37'!
test01ShouldNotBeCreateTrailerWithZeroOrLessMaxWeight

	self assertCreatingTrailerWith: 0 and: 100 raiseError: Trailer invalidWeightCapacityErrorDescription .
	
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 16:06:29'!
test02ShouldNotBeCreateTrailerWithZeroOrLessMaxHeight

	self assertCreatingTrailerWith: 1 and: 0  raiseError: Trailer invalidHeightCapacityErrorDescription .! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 16:06:21'!
test03ShouldNotBeCreateTrailerWithNoIntegerMaxWeight

	self assertCreatingTrailerWith: 1.5 and: 100  raiseError: Trailer weightCapacityMustBeIntegerErrorDescription .
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 16:07:00'!
test04ShouldNotBeCreateTrailerWithNoIntegerMaxHeight

	self assertCreatingTrailerWith: 100 and: 1.5  raiseError: Trailer heightCapacityMustBeIntegerErrorDescription .
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 16:10:54'!
test05ShouldRejectProductAIfWeightExceeded
	
	
	self assertCreatingATrailerWith: ProductA.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 15:37:20'!
test06ShouldRejectProductBIfWeightExceeded
	
	
	self assertCreatingATrailerWith: ProductB.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 15:53:58'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity
	
	self assertWithBaseTrailerDoing: [:aTrailer | ] resultsInAmount:  4 weight: 10.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'Martin 4/14/2026 15:53:58'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity
	
	self assertWithBaseTrailerDoing: [:aTrailer | aTrailer carry: (ProductB  with: 1 and:1 )] resultsInAmount: 5  weight: 11. ! !


!TrailerTest methodsFor: 'height capacity' stamp: 'Martin 4/14/2026 16:08:17'!
test09ShouldNotCountNonStackableProductsHeightTowardsCapacity
	
	self assertHeightShouldBe: [:anHeight | 0] whenAdding: ProductA 
! !

!TrailerTest methodsFor: 'height capacity' stamp: 'Martin 4/14/2026 16:08:55'!
test10ShouldOnlyCountStackableProductsTowardsHeightCapacity
	
	self assertHeightShouldBe: [:anHeight | anHeight ] whenAdding: ProductB .! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:16'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !


!TrailerTest methodsFor: 'assertions' stamp: 'Martin 4/14/2026 15:36:35'!
assertCreatingATrailerWith: aProductType

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (aProductType with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.	! !

!TrailerTest methodsFor: 'assertions' stamp: 'Martin 4/14/2026 15:30:21'!
assertCreatingTrailerWith: aWeightCapacity and: aHeightCapacity raiseError: anErrorMessage

	self should: [Trailer with:  aWeightCapacity and: aHeightCapacity ] 
		raise: Error
		withMessageText: anErrorMessage .
		! !

!TrailerTest methodsFor: 'assertions' stamp: 'Martin 4/14/2026 15:59:38'!
assertHeightShouldBe: anExpectedHeightBlock whenAdding: aProductType

| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (aProductType with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals:( anExpectedHeightBlock value: halfExceededHeightCapacity).! !

!TrailerTest methodsFor: 'assertions' stamp: 'Martin 4/14/2026 15:53:58'!
assertWithBaseTrailerDoing: aTrailerBlock resultsInAmount: anExpectedAmount weight: anExpectedWeight

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
	aTrailerBlock value: aTrailer .
	
	self assert: aTrailer totalProductsAmount equals: anExpectedAmount .
	self assert: aTrailer totalProductsWeight equals: anExpectedWeight .! !
