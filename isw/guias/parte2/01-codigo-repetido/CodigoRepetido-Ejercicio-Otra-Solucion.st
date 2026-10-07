!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 3/Apr/2019, 1:14:26 pm (UTC)'!
!methodProperties: {}!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 3/Apr/2019, 1:14:26 pm (UTC)'!
!methodProperties: {}!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 17/Sep/2020, 10:23:04 am (UTC)'!
!methodProperties: {}!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 3/Apr/2019, 1:14:26 pm (UTC)'!
!methodProperties: {}!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 3/Apr/2019, 1:14:26 pm (UTC)'!
!methodProperties: {}!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 24/Aug/2026, 12:20:40 pm (UTC)'!
!methodProperties: {}!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 19/Sep/2018, 8:36:09 pm (UTC)'!
!methodProperties: {}!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 24/Aug/2026, 12:48:34 pm (UTC)'!
!methodProperties: {}!
removeCustomerNamed: aName 
	
	(self removeCustomerNamed:  aName from: active) ifTrue: [^ aName].
	(self removeCustomerNamed:  aName from: suspended ) ifTrue: [^ aName].
	
	^ NotFound signal.	

! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 6/Jul/2011, 8:52:00 pm (UTC)'!
!methodProperties: {}!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 6/Jul/2011, 8:51:00 pm (UTC)'!
!methodProperties: {}!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MA 26/Aug/2026, 6:27:45 pm (UTC)'!
!methodProperties: {}!
suspendCustomerNamed: aName 
	
	(self removeCustomerNamed: aName from: active) ifFalse: [^CantSuspend signal].
	
	"
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	"
	suspended add: aName
! !


!CustomerBook methodsFor: 'collections' stamp: 'MN 24/Aug/2026, 12:49:19 pm (UTC)'!
!methodProperties: {}!
removeCustomerNamed: aName from: aCollectionOfCustomers

    aCollectionOfCustomers do: [ :aCustomer |
        aName = aCustomer ifTrue: [
            aCollectionOfCustomers remove: aCustomer.
            ^ true
        ]
    ].
    ^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 10/Apr/2023, 1:25:52 am (UTC)'!
!methodProperties: {}!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'.! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 10/Apr/2023, 1:25:56 am (UTC)'!
!methodProperties: {}!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'.! !


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
	instanceVariableNames: 'johnLennon paulMcCartney customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing helper' stamp: 'MN 24/Aug/2026, 12:58:52 pm (UTC)'!
!methodProperties: {}!
checkTimeOfExecutionOf: anActionToExecute takesLessThan: aMountOfMilliseconds

	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anActionToExecute value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aMountOfMilliseconds .! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MN 24/Aug/2026, 2:09:37 pm (UTC)'!
!methodProperties: {}!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self checkTimeOfExecutionOf: [customerBook addCustomerNamed: johnLennon ] takesLessThan: (50 * millisecond ).
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:20:51 pm (UTC)'!
!methodProperties: {}!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	customerBook addCustomerNamed: paulMcCartney .
	
	self checkTimeOfExecutionOf: [customerBook removeCustomerNamed: paulMcCartney ] takesLessThan: (100 * millisecond ).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 24/Aug/2026, 2:05:33 pm (UTC)'!
!methodProperties: {}!
test03CanNotAddACustomerWithEmptyName 



	self assertThat: [customerBook addCustomerNamed: '']  
	raises:  Error
	andCheck: [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:21:06 pm (UTC)'!
!methodProperties: {}!
test04CanNotRemoveAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon .
	self 
        assertThat: [ customerBook removeCustomerNamed: paulMcCartney ]
        raises: NotFound
        leavesUnchanged: customerBook
        keepingCustomerNamed: johnLennon ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:21:25 pm (UTC)'!
!methodProperties: {}!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	
	customerBook addCustomerNamed: paulMcCartney .
	customerBook suspendCustomerNamed: paulMcCartney .
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0  suspendedCustomers: 1 andThenDo: [self assert: (customerBook includesCustomerNamed: paulMcCartney )].
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:21:36 pm (UTC)'!
!methodProperties: {}!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook


	customerBook addCustomerNamed: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.

	self assertCustomerBook: customerBook hasActiveCustomers: 0  suspendedCustomers: 0 andThenDo: [self deny: (customerBook includesCustomerNamed: paulMcCartney )].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:21:44 pm (UTC)'!
!methodProperties: {}!
test07CanNotSuspendAnInvalidCustomer
	
	customerBook addCustomerNamed: johnLennon .
	
	
	self 
        assertThat: [ customerBook suspendCustomerNamed: 'Ringo Starr' ]
        raises: CantSuspend 
        leavesUnchanged: customerBook
        keepingCustomerNamed: johnLennon 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MA 26/Aug/2026, 6:22:00 pm (UTC)'!
!methodProperties: {}!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	customerBook addCustomerNamed: johnLennon .
	customerBook suspendCustomerNamed: johnLennon .
	
	self 
        assertThat: [ customerBook suspendCustomerNamed: johnLennon ]
        raises: CantSuspend 
        leavesUnchanged: customerBook
        keepingCustomerNamed: johnLennon .
	
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'MN 24/Aug/2026, 1:55:35 pm (UTC)'!
!methodProperties: {}!
assertCustomerBook: aCustomerBook hasActiveCustomers: aNumberOfActiveCustomers suspendedCustomers: aNumberOfSuspendedCustomers andThenDo: anActionToTake


	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (aNumberOfActiveCustomers  + aNumberOfSuspendedCustomers ) equals: aCustomerBook numberOfCustomers.
	anActionToTake value.

	
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MN 24/Aug/2026, 1:27:34 pm (UTC)'!
!methodProperties: {}!
assertThat: anActionToFail raises: anErrorType andCheck: anAssertiveClosure.


		[ anActionToFail value.
	self fail ]
		on: anErrorType 
		do: anAssertiveClosure .! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MN 24/Aug/2026, 1:40:20 pm (UTC)'!
!methodProperties: {}!
assertThat: anActionBlock raises: anExceptionClass 
    leavesUnchanged: aCustomerBook 
    keepingCustomerNamed: aName

    self 
        assertThat: anActionBlock 
        raises: anExceptionClass
        andCheck: [ :anError | 
            self assert: aCustomerBook numberOfCustomers = 1.
            self assert: (aCustomerBook includesCustomerNamed: aName) ]! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'MN 24/Aug/2026, 2:08:08 pm (UTC)'!
!methodProperties: {}!
setUp

	super setUp .
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.! !
