!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 11:34:59'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName ) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 11:35:40'!
numberOfCustomers
	
	^self numberOfActiveCustomers  + self numberOfSuspendedCustomers .! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 12:04:56'!
removeCustomerNamed: aName 
 

	^ self removeFrom: active lookingFor: aName ifAbsent: [
			self removeFrom: suspended lookingFor: aName ifAbsent:
			[^ NotFound signal.]
		]! !

!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 11:40:27'!
signalCustomerAlreadyExists 
    self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 11:40:57'!
signalCustomerNameCannotBeEmpty 
    self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'Martin 4/10/2026 12:10:17'!
suspendCustomerNamed: aName 
	
	self removeFrom: active lookingFor: aName  ifAbsent: [^CantSuspend signal ].
	
	suspended add: aName .
! !


!CustomerBook methodsFor: 'private' stamp: 'Martin 4/10/2026 12:08:36'!
removeFrom: aCollection lookingFor: aName ifAbsent: aBlockToContinue

	1 to: aCollection size  do: [
			:index | 
				aName  = (aCollection  at: index)
					ifTrue: [
							aCollection removeAt: index.
							^ aName.
						   ].
		].
	
	^aBlockToContinue value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !


!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!
!CustomerBookTest commentStamp: '<historical>' prior: 0!
CustomerBookTest setUp!


!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 12:47:29'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	
	self should: [customerBook addCustomerNamed: 'John Lennon' ] takeLessThan: 50 * millisecond .	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 12:46:34'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	 
	
	self should: [customerBook removeCustomerNamed: paulMcCartney ] takeLessThan: 100 * millisecond .	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 13:09:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self 
		should: [customerBook addCustomerNamed: '']  
		raise:  Error
		assert: [ :anError |
				self assert: anError messageText = CustomerBook  customerCanNotBeEmptyErrorMessage .
				self assert: customerBook isEmpty 
			]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 12:59:55'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [customerBook removeCustomerNamed: 'Paul McCartney']  
		raise:  NotFound 
		assert: [:anError |
				self assert: customerBook numberOfActiveCustomers = 1.
				self assert: (customerBook includesCustomerNamed: johnLennon )
			].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 13:33:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0  andSuspendedIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 13:29:53'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0 andSuspendedIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 12:52:53'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [customerBook suspendCustomerNamed: 'George Harrison']
		raise: CantSuspend 
		assert: [:anError |
				self assert: customerBook numberOfCustomers  = 1.
				self assert: (customerBook includesCustomerNamed: johnLennon) 
			].
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Martin 4/10/2026 12:58:35'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self 
		should: [customerBook suspendCustomerNamed: johnLennon ]
		raise: CantSuspend  
		assert: [ :anError |
				self assert: customerBook numberOfCustomers  = 1.
				self assert: (customerBook includesCustomerNamed: johnLennon )			
			]
! !


!CustomerBookTest methodsFor: 'private' stamp: 'Martin 4/10/2026 13:07:45'!
executeAndMeasureMillisenconds: aBlockToMeasure

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning  := Time millisecondClockValue * millisecond .
	aBlockToMeasure value.
	millisecondsAfterRunning  := Time millisecondClockValue * millisecond .
	
	^ millisecondsAfterRunning - millisecondsBeforeRunning .! !

!CustomerBookTest methodsFor: 'private' stamp: 'Martin 4/10/2026 13:03:00'!
should: aBlockThatShouldFail raise: anExceptionType assert: aVerificationBlock 
	
	[aBlockThatShouldFail value.
		self fail] on: anExceptionType 
		do: aVerificationBlock .! !

!CustomerBookTest methodsFor: 'private' stamp: 'Martin 4/10/2026 13:01:06'!
should: aBlockToMeasure takeLessThan: aTimeLimit

	^ self assert: (self executeAndMeasureMillisenconds: aBlockToMeasure ) < aTimeLimit ! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'Martin 4/10/2026 13:31:38'!
assertNumberOfActiveCustomersIn: aCustomerBook is: aNumberOfActiveCustomers andSuspendedIs: aNumberOfSuspendedCustomers

self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (aNumberOfActiveCustomers  + aNumberOfSuspendedCustomers ) equals: aCustomerBook numberOfCustomers. 
	! !
