!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 30/Jun/2018, 10:48:45 pm (UTC)'!
invalidCommandErrorDescription

	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 30/Jun/2018, 10:50:26 pm (UTC)'!
signalInvalidCommand

	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 17/Oct/2026, 12:44:17 am (UTC)'!
initializeAt: aPosition heading: aHeadingType

	position := ObservedValue for: aPosition .
	head := ObservedValue for: (aHeadingType for: self) .
	. ! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
headEast

	head changeValue: (​ MarsRoverHeadingEast for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
headNorth

	head changeValue: (MarsRoverHeadingNorth for: self) .
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
headSouth

	head changeValue:​( MarsRoverHeadingSouth for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
headWest

	head changeValue:​( MarsRoverHeadingWest for: self) .
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:04:40 am (UTC)'!
rotateLeft

	head value rotateLeft.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:04:46 am (UTC)'!
rotateRight

	head value rotateRight.
	! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 16/Oct/2026, 11:13:48 pm (UTC)'!
isAt: aPosition heading: aHeadingType

	^position value = aPosition and: [ head value isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 6/Jul/2018, 9:16:51 pm (UTC)'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 6/Jul/2018, 9:16:19 pm (UTC)'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 6/Jul/2018, 9:17:51 pm (UTC)'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 6/Jul/2018, 9:17:21 pm (UTC)'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:03:47 am (UTC)'!
moveBackward

	head value moveBackward.
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
moveEast

	position changeValue: ​ position value + (1@0).

! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:03:43 am (UTC)'!
moveForward

	head value moveForward.
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
moveNorth

	position  changeValue: ​ position value + (0@1).
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
moveSouth

	position changeValue:  position value + (0@-1).
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 17/Oct/2026, 12:44:52 am (UTC)'!
moveWest

	position changeValue:  position value + (-1@0).
! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 30/Jun/2018, 10:48:26 pm (UTC)'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 22/Aug/2019, 3:08:50 pm (UTC)'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'add observers' stamp: 'HAW 17/Oct/2026, 12:45:10 am (UTC)'!
addObserverForHeading: aLoggerFollowingHeading

	head addObserver: aLoggerFollowingHeading .
	! !

!MarsRover methodsFor: 'add observers' stamp: 'HAW 17/Oct/2026, 12:45:10 am (UTC)'!
addObserverForPosition: aLoggerFollowingPosition

	position addObserver: aLoggerFollowingPosition .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/Oct/2021, 11:10:30 pm (UTC)'!
at: aPosition heading: aHeadingType

	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
formatOn: aMarsRoverObserver

	self subclassResponsibility .! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/Oct/2021, 11:15:38 pm (UTC)'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:24 pm (UTC)'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:53 pm (UTC)'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 7/Oct/2021, 11:11:59 pm (UTC)'!
initializeFor: aMarsRover

	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 7/Oct/2021, 11:11:35 pm (UTC)'!
for: aMarsRover

	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:24 pm (UTC)'!
moveBackward

	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:53 pm (UTC)'!
moveForward

	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
formatOn: aMarsRoverObsever

	^ aMarsRoverObsever formatEast: self ! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft

	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight

	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:24 pm (UTC)'!
moveBackward

	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:53 pm (UTC)'!
moveForward

	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
formatOn: aMarsRoverObserver

	^ aMarsRoverObserver formatNorth: self. ! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft

	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight

	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:24 pm (UTC)'!
moveBackward

	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:53 pm (UTC)'!
moveForward

	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
formatOn: aMarsRoverObserver

	^ aMarsRoverObserver formatSouth: self.
	! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft

	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight

	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:24 pm (UTC)'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 7/Oct/2021, 11:13:53 pm (UTC)'!
moveForward

	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
formatOn: aMarsRoverObserver

	^ aMarsRoverObserver formatWest: self. ! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft

	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight

	^marsRover headNorth! !


!classDefinition: #MarsRoverLogger category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'HAW 17/Oct/2026, 12:07:10 pm (UTC)'!
initializeFor: aRover

	marsRover := aRover.
	log := WriteStream on: ''.
! !


!MarsRoverLogger methodsFor: 'events' stamp: 'HAW 17/Oct/2026, 12:03:16 pm (UTC)'!
headingChangedTo: aHeadingToChange

	log nextPutAll: (aHeadingToChange formatOn: self) ; newLine .

	! !

!MarsRoverLogger methodsFor: 'events' stamp: 'HAW 17/Oct/2026, 12:55:47 am (UTC)'!
positionChangedTo: aPostionToChange

	log nextPutAll: aPostionToChange asString; newLine .

	! !


!MarsRoverLogger methodsFor: 'subscriptions' stamp: 'HAW 17/Oct/2026, 10:38:05 pm (UTC)'!
followHeading

	marsRover addObserverForHeading: [:aNewHeading | self headingChangedTo: aNewHeading ].! !

!MarsRoverLogger methodsFor: 'subscriptions' stamp: 'HAW 17/Oct/2026, 12:07:10 pm (UTC)'!
followPosition

	marsRover addObserverForPosition: [:aNewHeading | self positionChangedTo: aNewHeading ].! !


!MarsRoverLogger methodsFor: 'log reading' stamp: 'AP 15/Oct/2026, 3:05:05 pm (UTC)'!
readStream
	^ ReadStream on: log contents.! !


!MarsRoverLogger methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:29 am (UTC)'!
formatEast: aMarsRoverObserver

	^ 'East'! !

!MarsRoverLogger methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:18 am (UTC)'!
formatNorth: aMarsRoverObserver

	^ 'North'! !

!MarsRoverLogger methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:02 am (UTC)'!
formatSouth: aMarsRoverObserver

	^ 'South'! !

!MarsRoverLogger methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:38 am (UTC)'!
formatWest: aMarsRoverObserver

	^ 'West'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: #'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'AP 15/Oct/2026, 3:06:57 pm (UTC)'!
for: aRover
	^ self new initializeFor: aRover.! !


!classDefinition: #MarsRoverStatusWindow category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverStatusWindow
	instanceVariableNames: 'marsRover textFieldPosition textFieldHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 17/Oct/2026, 10:53:10 am (UTC)'!
textFieldHeading

	^ textFieldHeading .! !

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 17/Oct/2026, 10:53:19 am (UTC)'!
textFieldPosition

	^ textFieldPosition ! !


!MarsRoverStatusWindow methodsFor: 'initialization' stamp: 'HAW 17/Oct/2026, 12:45:49 am (UTC)'!
initializeFor: aMarsRover

	marsRover := aMarsRover.
	textFieldPosition := ''.
	textFieldHeading := ''.! !


!MarsRoverStatusWindow methodsFor: 'events' stamp: 'HAW 17/Oct/2026, 10:34:26 pm (UTC)'!
newHeading: aHeadingToChange

	textFieldHeading := aHeadingToChange formatOn: self.

	! !

!MarsRoverStatusWindow methodsFor: 'events' stamp: 'HAW 17/Oct/2026, 10:35:02 pm (UTC)'!
newPosition: aPostionToChange

	textFieldPosition := aPostionToChange asString .! !


!MarsRoverStatusWindow methodsFor: 'subscription' stamp: 'HAW 17/Oct/2026, 10:34:26 pm (UTC)'!
followHeading

	marsRover addObserverForHeading: [:aNewHeading | self newHeading: aNewHeading ].! !

!MarsRoverStatusWindow methodsFor: 'subscription' stamp: 'HAW 17/Oct/2026, 10:35:02 pm (UTC)'!
followPosition

	marsRover addObserverForPosition: [:aNewPosition | self newPosition: aNewPosition ].! !


!MarsRoverStatusWindow methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:29 am (UTC)'!
formatEast: aMarsRoverHeading

	^ 'Apuntando Al Este'! !

!MarsRoverStatusWindow methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:18 am (UTC)'!
formatNorth: aMarsRoverHeading

	^ 'Apuntando Al Norte'! !

!MarsRoverStatusWindow methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:02 am (UTC)'!
formatSouth: aMarsRoverHeading

	^ 'Apuntando Al Sur'! !

!MarsRoverStatusWindow methodsFor: 'formating' stamp: 'HAW 17/Oct/2026, 11:59:38 am (UTC)'!
formatWest: aMarsRoverHeading

	^ 'Apuntando Al Oeste'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatusWindow class' category: #'MarsRover-WithHeading'!
MarsRoverStatusWindow class
	instanceVariableNames: ''!

!MarsRoverStatusWindow class methodsFor: 'instance creation' stamp: 'HAW 15/Oct/2026, 7:44:06 pm (UTC)'!
for: aMarsRover

	^self new initializeFor: aMarsRover ! !


!classDefinition: #ObservedValue category: #'MarsRover-WithHeading'!
Object subclass: #ObservedValue
	instanceVariableNames: 'observedValue observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObservedValue methodsFor: 'observing' stamp: 'HAW 17/Oct/2026, 11:56:39 am (UTC)'!
addObserver: aObserverToAdd

	observers add: aObserverToAdd .! !

!ObservedValue methodsFor: 'observing' stamp: 'HAW 17/Oct/2026, 11:56:39 am (UTC)'!
changeValue: aValueToChange

	observedValue := aValueToChange .
	observers do: [:anObserver | anObserver value: observedValue ]! !


!ObservedValue methodsFor: 'accesing' stamp: 'HAW 17/Oct/2026, 12:44:32 am (UTC)'!
value

	^ observedValue .! !


!ObservedValue methodsFor: 'initialization' stamp: 'HAW 17/Oct/2026, 11:56:39 am (UTC)'!
initializeFor: aValueToObserve

	observedValue := aValueToObserve .
	observers := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObservedValue class' category: #'MarsRover-WithHeading'!
ObservedValue class
	instanceVariableNames: ''!

!ObservedValue class methodsFor: 'instance creation' stamp: 'HAW 17/Oct/2026, 12:45:35 am (UTC)'!
for: aValueToObserve

	^ self new initializeFor: aValueToObserve .! !


!classDefinition: #MarsRoverObserversTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserversTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserversTest methodsFor: 'headings' stamp: 'HAW 17/Oct/2026, 10:55:20 am (UTC)'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverObserversTest methodsFor: 'headings' stamp: 'HAW 17/Oct/2026, 10:54:50 am (UTC)'!
north

	^ MarsRoverHeadingNorth! !

!MarsRoverObserversTest methodsFor: 'headings' stamp: 'HAW 17/Oct/2026, 10:55:02 am (UTC)'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverObserversTest methodsFor: 'headings' stamp: 'HAW 17/Oct/2026, 10:55:30 am (UTC)'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverObserversTest methodsFor: 'assertions' stamp: 'HAW 17/Oct/2026, 11:42:49 am (UTC)'!
assertLogIs: aExpectedLog afterProcessing: aCommandSequence startingAt: aPosition heading: aHeadingType configuringObserverWith: aConfigurationBlock

	|marsRover logger actualLog stream |
	marsRover := MarsRover at: aPosition heading: aHeadingType .
	logger := MarsRoverLogger for: marsRover .
	aConfigurationBlock value: logger.

	marsRover process: aCommandSequence .

	stream := logger readStream .
	actualLog := OrderedCollection new.

	[stream atEnd ] whileFalse: [actualLog add: stream nextLine ].

	self assert: aExpectedLog asOrderedCollection equals: actualLog .
	self assert: stream atEnd .


	! !

!MarsRoverObserversTest methodsFor: 'assertions' stamp: 'HAW 17/Oct/2026, 11:51:52 am (UTC)'!
assertStatusWindowShowsPosition: expectedPositionText heading: expectedHeadingText afterProcessing: aCommandSequence startingAt: aPosition heading: aHeading configuringWith: aConfigurationBlock

	| rover window |
	rover := MarsRover at: aPosition heading: aHeading.
	window := MarsRoverStatusWindow for: rover.
	aConfigurationBlock value: window.

	rover process: aCommandSequence.

	self assert: expectedPositionText equals: window textFieldPosition.
	self assert: expectedHeadingText equals: window textFieldHeading.! !


!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:35:14 am (UTC)'!
test01EmptyCommandDoesNotChangeLogger

	self
	assertLogIs:  #()
	afterProcessing: ''
	startingAt:  0@0
	heading:  self north
	configuringObserverWith: [:aLogger | aLogger followPosition ].
	! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:38:18 am (UTC)'!
test02LogsAllMovementCommandsOnYAxis

	self
	assertLogIs:  #('0@ -1' '0@0')
	afterProcessing:  'fb'
	startingAt:  0@0
	heading:  self south
	configuringObserverWith: [:aLogger | aLogger followPosition ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:39:29 am (UTC)'!
test03LogsAllMovementCommandsOnXAxis

	self
	assertLogIs: #('1@0' '0@0')
	afterProcessing:  'fb'
	startingAt:  0@0
	heading:  self east
	configuringObserverWith: [:aLogger | aLogger followPosition ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:40:33 am (UTC)'!
test04LogsNorthsLeftAndWestsRightCommands

	self
	assertLogIs:  #('West' 'North')
	afterProcessing:  'lr'
	startingAt:  0@0
	heading:  self north
	configuringObserverWith: [:aLogger | aLogger followHeading ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:42:33 am (UTC)'!
test05LogsAllRotationCommands

	self
	assertLogIs: #('North' 'West' 'South' 'East' 'South' 'West')
	afterProcessing:  'llllrr'
	startingAt:  0@0
	heading:  self east
	configuringObserverWith: [:aLogger | aLogger followHeading ]! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:44:27 am (UTC)'!
test06LogsPositionAndHeadingForForwardAndRightCommandsStartingOnNorth

	self
	assertLogIs: #('0@1' 'East')
	afterProcessing:  'fr'
	startingAt:  0@0
	heading:  self north
	configuringObserverWith: [:aLogger | aLogger followPosition; followHeading ] .! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:45:20 am (UTC)'!
test07LogsPositionAndHeadingForAllCommands

	self
	assertLogIs: #('1@0' 'South')
	afterProcessing:  'bl'
	startingAt:  0@0
	heading:  self west
	configuringObserverWith: [:aLogger | aLogger followPosition; followHeading ] .
	! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:46:03 am (UTC)'!
test08HeadingLoggerDoesNotLogMovements

	self
	assertLogIs: #()
	afterProcessing:  'fb'
	startingAt:  0@0
	heading:  self north
	configuringObserverWith: [:aLogger | aLogger followHeading ] .! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:48:11 am (UTC)'!
test09PositionLoggerDoesNotLogRotations

	self
	assertLogIs: #()
	afterProcessing:  'lr'
	startingAt:  0@0
	heading:  self north
	configuringObserverWith: [:aLogger | aLogger followPosition ] .! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:53:02 am (UTC)'!
test10EmptyCommandDoesNotChangeStatusWindow

	self
	assertStatusWindowShowsPosition:  ''
	heading:  ''
	afterProcessing: ''
	startingAt:  0@0
	heading:  self north
	configuringWith: [:aWindow | aWindow followPosition; followHeading ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:53:44 am (UTC)'!
test11PositionWindowUpdatesOnNorthAndWestAndIgnoresRotations

	self
	assertStatusWindowShowsPosition:  '-1@1'
	heading:  ''
	afterProcessing: 'frb'
	startingAt:  0@0
	heading:  self north
	configuringWith: [:aWindow | aWindow followPosition].
	! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:54:21 am (UTC)'!
test12PositionWindowUpdatesOnSouthAndEastAndIgnoresRotations

	self
	assertStatusWindowShowsPosition:  '-1@ -1'
	heading:  ''
	afterProcessing: 'flb'
	startingAt:  0@0
	heading:  self south
	configuringWith: [:aWindow | aWindow followPosition ].
! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:55:01 am (UTC)'!
test13HeadingWindowUpdatesHeadingOnLeftRotationsAndIgnoresMovements

	self
	assertStatusWindowShowsPosition:  ''
	heading:  'Apuntando Al Norte'
	afterProcessing: 'ffrrrrl'
	startingAt:  0@0
	heading:  self east
	configuringWith: [:aWindow | aWindow  followHeading ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:55:43 am (UTC)'!
test14HeadingWindowUpdatesHeadingOnRightRotationsAndIgnoresMovements

	self
	assertStatusWindowShowsPosition:  ''
	heading:  'Apuntando Al Sur'
	afterProcessing: 'ffllllr'
	startingAt:  0@0
	heading:  self east
	configuringWith: [:aWindow | aWindow followHeading ].! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'HAW 17/Oct/2026, 11:56:23 am (UTC)'!
test15HeadingAndPositionWindowUpdatesBothOnMovementsAndRotations

	self
	assertStatusWindowShowsPosition:  '1@1'
	heading:  'Apuntando Al Sur'
	afterProcessing: 'flbl'
	startingAt:  0@0
	heading:  self north
	configuringWith: [:aWindow | aWindow followPosition; followHeading ].! !


!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:21:23 pm (UTC)'!
test01DoesNotMoveWhenNoCommand

	self
		assertIsAt: 1@2
		heading: self north
		afterProcessing: ''
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:28:12 pm (UTC)'!
test02IsAtFailsForDifferentPosition

	| marsRover |

	marsRover := MarsRover at: 1@1 heading: self north .

	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:28:31 pm (UTC)'!
test03IsAtFailsForDifferentHeading

	| marsRover |

	marsRover := MarsRover at: 1@1 heading: self north .

	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:30:17 pm (UTC)'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self
		assertIsAt: 1@3
		heading: self north
		afterProcessing: 'f'
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:30:11 pm (UTC)'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self
		assertIsAt: 1@1
		heading: self north
		afterProcessing: 'b'
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:59 pm (UTC)'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self
		assertIsAt: 1@2
		heading: self east
		afterProcessing: 'r'
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:51 pm (UTC)'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self
		assertIsAt: 1@2
		heading: self west
		afterProcessing: 'l'
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:45 pm (UTC)'!
test09DoesNotProcessInvalidCommand

	| marsRover |

	marsRover := MarsRover at: 1@2 heading: self north.

	self
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:39 pm (UTC)'!
test10CanProcessMoreThanOneCommand

	self
		assertIsAt: 1@4
		heading: self north
		afterProcessing: 'ff'
		whenStartingAt: 1@2
		heading: self north
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:31 pm (UTC)'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self
		assertIsAt: 2@2
		heading: self east
		afterProcessing: 'f'
		whenStartingAt: 1@2
		heading: self east
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:19 pm (UTC)'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self
		assertIsAt: 0@2
		heading: self east
		afterProcessing: 'b'
		whenStartingAt: 1@2
		heading: self east
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:14 pm (UTC)'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self
		assertIsAt: 1@2
		heading: self south
		afterProcessing: 'r'
		whenStartingAt: 1@2
		heading: self east
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:05 pm (UTC)'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self
		assertIsAt: 1@2
		heading: self north
		afterProcessing: 'l'
		whenStartingAt: 1@2
		heading: self east
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:29:00 pm (UTC)'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self
		assertIsAt: 1@1
		heading: self west
		afterProcessing: 'ffblrr'
		whenStartingAt: 1@2
		heading: self south
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/Oct/2021, 11:28:52 pm (UTC)'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self
		assertIsAt: 0@2
		heading: self north
		afterProcessing: 'ffblrr'
		whenStartingAt: 1@2
		heading: self west
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 7/Oct/2021, 11:09:31 pm (UTC)'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 7/Oct/2021, 11:09:38 pm (UTC)'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 7/Oct/2021, 11:09:45 pm (UTC)'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 7/Oct/2021, 11:09:54 pm (UTC)'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 7/Oct/2021, 11:20:47 pm (UTC)'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |

	marsRover := MarsRover at: startPosition heading: startHeadingType.

	marsRover process: commands.

	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !
