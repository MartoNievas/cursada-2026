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
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:13:09 pm (UTC)'!
followingHeadingChangesOn: aMarsRover

	aMarsRover addObserverForHeading: [:aNewHeading | self headingChangedTo: aNewHeading ].

	! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:13:02 pm (UTC)'!
followingPostionChangesOn: aMarsRover

	aMarsRover addObserverForPosition: [:aNewPosition | self positionChangedTo: aNewPosition ].
	! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:12:22 pm (UTC)'!
initialize

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

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:11:58 pm (UTC)'!
followHeadingChangesOn: aMarsRover

	^ self new followingHeadingChangesOn: aMarsRover .! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:12:05 pm (UTC)'!
followPositionAndHeadingChangesOn: aMarsRover

	^ self new followingHeadingChangesOn: aMarsRover ;followingPostionChangesOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:12:08 pm (UTC)'!
followPositionChangesOn: aMarsRover

		^self new followingPostionChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverStatusWindow category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverStatusWindow
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 19/Oct/2026, 6:15:48 pm (UTC)'!
headingTextFieldModel

	^ headingTextFieldModel .! !

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 19/Oct/2026, 6:15:55 pm (UTC)'!
positionTextFieldModel

	^ positionTextFieldModel ! !


!MarsRoverStatusWindow methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:08:21 pm (UTC)'!
followingHeadingChangesOn: aMarsRover

	aMarsRover addObserverForHeading: [:aNewHeading | self newHeading: aNewHeading ].

	! !

!MarsRoverStatusWindow methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:10:36 pm (UTC)'!
followingPostionChangesOn: aMarsRover

	aMarsRover addObserverForPosition: [:aNewPosition | self newPosition: aNewPosition ].
	! !

!MarsRoverStatusWindow methodsFor: 'initialization' stamp: 'HAW 19/Oct/2026, 6:15:55 pm (UTC)'!
initialize

	positionTextFieldModel := ''.
	headingTextFieldModel := ''.! !


!MarsRoverStatusWindow methodsFor: 'events' stamp: 'HAW 19/Oct/2026, 6:15:48 pm (UTC)'!
newHeading: aHeadingToChange

	headingTextFieldModel := aHeadingToChange formatOn: self.

	! !

!MarsRoverStatusWindow methodsFor: 'events' stamp: 'HAW 19/Oct/2026, 6:15:55 pm (UTC)'!
newPosition: aPostionToChange

	positionTextFieldModel := aPostionToChange asString .! !


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

!MarsRoverStatusWindow class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:09:28 pm (UTC)'!
followHeadingChangesOn: aMarsRover

	^ self new followingHeadingChangesOn: aMarsRover .! !

!MarsRoverStatusWindow class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:09:18 pm (UTC)'!
followPositionAndHeadingChangesOn: aMarsRover

	^ self new followingHeadingChangesOn: aMarsRover ;followingPostionChangesOn: aMarsRover ! !

!MarsRoverStatusWindow class methodsFor: 'instance creation' stamp: 'HAW 19/Oct/2026, 6:08:58 pm (UTC)'!
followPositionChangesOn: aMarsRover

		^self new followingPostionChangesOn: aMarsRover ! !


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


!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test01EmptyCommandDoesNotChangeLogger

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.

	marsRover process: ''.

	stream := logger readStream.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test02LogsAllMovementCommandsOnYAxis

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self south.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.

	marsRover process: 'fb'.

	stream := logger readStream.
	self assert: '0@ -1' equals: stream nextLine.
	self assert: '0@0' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test03LogsAllMovementCommandsOnXAxis

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self east.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.

	marsRover process: 'fb'.

	stream := logger readStream.
	self assert: '1@0' equals: stream nextLine.
	self assert: '0@0' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test04LogsNorthsLeftAndWestsRightCommands

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.

	marsRover process: 'lr'.

	stream := logger readStream.
	self assert: 'West' equals: stream nextLine.
	self assert: 'North' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test05LogsAllRotationCommands

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self east.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.

	marsRover process: 'llllrr'.

	stream := logger readStream.
	self assert: 'North' equals: stream nextLine.
	self assert: 'West' equals: stream nextLine.
	self assert: 'South' equals: stream nextLine.
	self assert: 'East' equals: stream nextLine.
	self assert: 'South' equals: stream nextLine.
	self assert: 'West' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test06LogsPositionAndHeadingForForwardAndRightCommandsStartingOnNorth

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger followPositionAndHeadingChangesOn: marsRover.

	marsRover process: 'fr'.

	stream := logger readStream.
	self assert: '0@1' equals: stream nextLine.
	self assert: 'East' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test07LogsPositionAndHeadingForAllCommands

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self west.
	logger := MarsRoverLogger followPositionAndHeadingChangesOn: marsRover.

	marsRover process: 'bl'.

	stream := logger readStream.
	self assert: '1@0' equals: stream nextLine.
	self assert: 'South' equals: stream nextLine.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test08HeadingLoggerDoesNotLogMovements

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.

	marsRover process: 'fb'.

	stream := logger readStream.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test09PositionLoggerDoesNotLogRotations

	| marsRover logger stream |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.

	marsRover process: 'lr'.

	stream := logger readStream.
	self assert: stream atEnd.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test10EmptyCommandDoesNotChangeStatusWindow

	| rover window |
	rover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverStatusWindow followPositionChangesOn: rover.

	rover process: ''.

	self assert: '' equals: window positionTextFieldModel.
	self assert: '' equals: window headingTextFieldModel.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test11PositionWindowUpdatesOnNorthAndWestAndIgnoresRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverStatusWindow followPositionChangesOn: rover.

	rover process: 'frb'.

	self assert: '-1@1' equals: window positionTextFieldModel.
	self assert: '' equals: window headingTextFieldModel.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test12PositionWindowUpdatesOnSouthAndEastAndIgnoresRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: self south.
	window := MarsRoverStatusWindow followPositionChangesOn: rover.

	rover process: 'flb'.

	self assert: '-1@ -1' equals: window positionTextFieldModel.
	self assert: '' equals: window headingTextFieldModel.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test13HeadingWindowUpdatesHeadingOnLeftRotationsAndIgnoresMovements

	| rover window |
	rover := MarsRover at: 0@0 heading: self east.
	window := MarsRoverStatusWindow followHeadingChangesOn: rover.

	rover process: 'ffrrrrl'.

	self assert: '' equals: window positionTextFieldModel.
	self assert: 'Apuntando Al Norte' equals: window headingTextFieldModel.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test14HeadingWindowUpdatesHeadingOnRightRotationsAndIgnoresMovements

	| rover window |
	rover := MarsRover at: 0@0 heading: self east.
	window := MarsRoverStatusWindow followHeadingChangesOn: rover.

	rover process: 'ffllllr'.

	self assert: '' equals: window positionTextFieldModel.
	self assert: 'Apuntando Al Sur' equals: window headingTextFieldModel.! !

!MarsRoverObserversTest methodsFor: 'tests' stamp: 'StreamRead 19/Oct/2026, 3:20:00 pm (UTC)'!
test15HeadingAndPositionWindowUpdatesBothOnMovementsAndRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverStatusWindow followPositionAndHeadingChangesOn: rover.

	rover process: 'flbl'.

	self assert: '1@1' equals: window positionTextFieldModel.
	self assert: 'Apuntando Al Sur' equals: window headingTextFieldModel.! !


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
