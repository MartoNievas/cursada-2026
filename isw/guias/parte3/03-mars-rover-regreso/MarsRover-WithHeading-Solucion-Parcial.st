!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head loggers windows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 30/Jun/2018, 10:48:45 pm (UTC)'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 30/Jun/2018, 10:50:26 pm (UTC)'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 15/Oct/2026, 7:48:34 pm (UTC)'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	loggers := OrderedCollection new.
	windows := OrderedCollection new.
! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 6:55:04 pm (UTC)'!
headEast
	
	head := MarsRoverHeadingEast for: self.
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 6:55:06 pm (UTC)'!
headNorth
	
	head := MarsRoverHeadingNorth for: self .
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 6:55:09 pm (UTC)'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 6:55:10 pm (UTC)'!
headWest
	
	head := MarsRoverHeadingWest for: self .
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 7:54:00 pm (UTC)'!
rotateLeft
	
	head rotateLeft.
	self notifyHeadingChanged .! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 15/Oct/2026, 7:40:14 pm (UTC)'!
rotateRight
	
	head rotateRight.
	self notifyHeadingChanged .
	! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 7/Oct/2021, 11:16:32 pm (UTC)'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

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


!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 7:54:15 pm (UTC)'!
moveBackward
	
	head moveBackward.
	self notifyPositionChanged .
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 7:04:45 pm (UTC)'!
moveEast
	
	position := position + (1@0).

! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 7:54:19 pm (UTC)'!
moveForward
	
	head moveForward.
	self notifyPositionChanged .
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 7:04:41 pm (UTC)'!
moveNorth
	
	position := position + (0@1).
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 6:54:49 pm (UTC)'!
moveSouth
	
	position := position + (0@-1).
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 15/Oct/2026, 6:54:51 pm (UTC)'!
moveWest
	
	position := position + (-1@0).
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


!MarsRover methodsFor: 'notify' stamp: 'HAW 15/Oct/2026, 7:40:42 pm (UTC)'!
notifyHeadingChanged

    loggers do: [ :aLogger | aLogger headingChangedTo: head ].
    windows do: [:aWindow | aWindow newHeading: head printString ]! !

!MarsRover methodsFor: 'notify' stamp: 'HAW 15/Oct/2026, 8:08:22 pm (UTC)'!
notifyPositionChanged

	loggers do: [ :aLogger | aLogger positionChangedTo: position ].
	windows do: [:aWindow | aWindow newPosition: position printString ]
! !


!MarsRover methodsFor: 'logger' stamp: 'HAW 15/Oct/2026, 6:57:42 pm (UTC)'!
addLogger: aLogger

	loggers add: aLogger.
        ! !


!MarsRover methodsFor: 'window' stamp: 'HAW 15/Oct/2026, 7:48:55 pm (UTC)'!
addWindow: aMarsRoverWindowPosition 
	
	windows add: aMarsRoverWindowPosition ! !

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


!MarsRoverHeading methodsFor: 'printing' stamp: 'AP 15/Oct/2026, 2:11:21 pm (UTC)'!
printString
	self subclassResponsibility .! !

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


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'printing' stamp: 'HAW 15/Oct/2026, 7:37:49 pm (UTC)'!
printString
	^ 'Este'.! !


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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'printing' stamp: 'HAW 15/Oct/2026, 7:37:54 pm (UTC)'!
printString
	^ 'Norte'.! !


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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'printing' stamp: 'HAW 15/Oct/2026, 7:37:57 pm (UTC)'!
printString
	^ 'Sur'.! !


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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:20 pm (UTC)'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 7/Oct/2021, 11:14:44 pm (UTC)'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'printing' stamp: 'HAW 15/Oct/2026, 7:38:03 pm (UTC)'!
printString
	^ 'Oeste'.! !


!classDefinition: #MarsRoverLogger category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'rover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AP 15/Oct/2026, 3:06:25 pm (UTC)'!
initializeFor: aRover
	rover := aRover.
	log := WriteStream on: ''.
	aRover addLogger: self.! !


!MarsRoverLogger methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:53:30 pm (UTC)'!
headingChangedTo: aHeading

	aHeading yourself .! !

!MarsRoverLogger methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:53:39 pm (UTC)'!
positionChangedTo: aPosition

	aPosition yourself .! !


!MarsRoverLogger methodsFor: 'log reading' stamp: 'AP 15/Oct/2026, 3:05:05 pm (UTC)'!
readStream
	^ ReadStream on: log contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: #'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'AP 15/Oct/2026, 3:06:57 pm (UTC)'!
for: aRover
	^ self new initializeFor: aRover.! !


!classDefinition: #MarsRoverLoggerHeading category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerHeading methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:35:16 pm (UTC)'!
headingChangedTo: aHeading
    log nextPutAll: aHeading printString; newLine.! !


!classDefinition: #MarsRoverLoggerPosition category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerPosition methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:37:32 pm (UTC)'!
positionChangedTo: aPosition
    log nextPutAll: aPosition asString; newLine.! !


!classDefinition: #MarsRoverLoggerPositionAndHeading category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerPositionAndHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerPositionAndHeading methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:35:27 pm (UTC)'!
headingChangedTo: aHeading
    log nextPutAll: aHeading printString; newLine.! !

!MarsRoverLoggerPositionAndHeading methodsFor: 'events' stamp: 'HAW 15/Oct/2026, 3:35:24 pm (UTC)'!
positionChangedTo: aPosition
    log nextPutAll: aPosition asString; newLine.! !


!classDefinition: #MarsRoverStatusWindow category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverStatusWindow
	instanceVariableNames: 'rover textFieldPositionModel textFieldHeadingModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 8:12:57 pm (UTC)'!
newHeading: aHeadingString


	aHeadingString yourself .! !

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 8:13:06 pm (UTC)'!
newPosition: aPositionString

	aPositionString yourself .! !

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 7:44:30 pm (UTC)'!
textFieldHeadingModel

	^ textFieldHeadingModel .! !

!MarsRoverStatusWindow methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 7:45:31 pm (UTC)'!
textFieldPositionModel

	^ textFieldPositionModel ! !


!MarsRoverStatusWindow methodsFor: 'initialization' stamp: 'HAW 15/Oct/2026, 7:43:40 pm (UTC)'!
initializeFor: aMarsRover 

	rover := aMarsRover addWindow: self.
	textFieldPositionModel := ''.
	textFieldHeadingModel := ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatusWindow class' category: #'MarsRover-WithHeading'!
MarsRoverStatusWindow class
	instanceVariableNames: ''!

!MarsRoverStatusWindow class methodsFor: 'instance creation' stamp: 'HAW 15/Oct/2026, 7:44:06 pm (UTC)'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverStatusWindowHeading category: #'MarsRover-WithHeading'!
MarsRoverStatusWindow subclass: #MarsRoverStatusWindowHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindowHeading methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 7:45:00 pm (UTC)'!
newHeading: aHeading

	textFieldHeadingModel := 'Apuntando Al ', aHeading ! !


!classDefinition: #MarsRoverStatusWindowHeadingAndPostion category: #'MarsRover-WithHeading'!
MarsRoverStatusWindow subclass: #MarsRoverStatusWindowHeadingAndPostion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindowHeadingAndPostion methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 8:11:47 pm (UTC)'!
newHeading: aHeading

	textFieldHeadingModel := 'Apuntando Al ', aHeading ! !

!MarsRoverStatusWindowHeadingAndPostion methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 8:08:45 pm (UTC)'!
newPosition: aPostionString

	textFieldPositionModel := aPostionString .! !


!classDefinition: #MarsRoverStatusWindowPosition category: #'MarsRover-WithHeading'!
MarsRoverStatusWindow subclass: #MarsRoverStatusWindowPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindowPosition methodsFor: 'text fields' stamp: 'HAW 15/Oct/2026, 8:08:48 pm (UTC)'!
newPosition: aPositionString

	textFieldPositionModel := aPositionString .! !


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


!classDefinition: #MarsRoverXXX category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverXXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:21:33 pm (UTC)'!
test01EmptyCommandDoesNotChangeLogger

	| rover logger|
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := MarsRoverLoggerPosition for: rover.
	
	rover process: ''.
	
	self assert: logger readStream atEnd.
	
! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 5:13:48 pm (UTC)'!
test02LogsAllMovementCommandsOnYAxis

	| rover logger logStream|
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth .
	logger := MarsRoverLoggerPosition for: rover.
	
	rover process: 'fb'.
	
	logStream := logger readStream.
	
	self assert: logStream nextLine equals: '0@ -1'.
	self assert: logStream nextLine equals: '0@0'.
	self assert: logStream atEnd.
	
	
! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 5:14:53 pm (UTC)'!
test03LogsAllMovementCommandsOnXAxis

	| rover logStream logger |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	logger := MarsRoverLoggerPosition for: rover.
	
	rover process: 'fb'.
	
	logStream := logger readStream.
	
	self assert: logStream nextLine equals: '1@0'.
	self assert: logStream nextLine equals: '0@0'.
	self assert: logStream atEnd.
	
! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 7:38:15 pm (UTC)'!
test04LogsNorthsLeftAndWestsRightCommands

	| rover logger logStream |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := MarsRoverLoggerHeading for: rover.
	
	rover process: 'lr'.
	
	logStream := logger readStream.
	
	self assert: logStream nextLine equals: 'Oeste'.
	self assert: logStream nextLine equals: 'Norte'.
	self assert: logStream atEnd.
	
! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 7:38:34 pm (UTC)'!
test05LogsAllRotationCommands

        | rover logger logStream |
        rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
        logger := MarsRoverLoggerHeading for: rover.

        rover process: 'llllrr'.

        logStream := logger readStream.

        self assert: logStream nextLine equals: 'Norte'.
        self assert: logStream nextLine equals: 'Oeste'.
        self assert: logStream nextLine equals: 'Sur'.
        self assert: logStream nextLine equals: 'Este'.
        self assert: logStream nextLine equals: 'Sur'.
        self assert: logStream nextLine equals: 'Oeste'.
        self assert: logStream atEnd.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 7:38:38 pm (UTC)'!
test06LogsPositionAndHeadingForForwardAndRightCommandsStartingOnNorth

    | rover logger logStream |
    rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
    logger := MarsRoverLoggerPositionAndHeading for: rover.

    rover process: 'fr'.

    logStream := logger readStream.

    self assert: logStream nextLine equals: '0@1'.
    self assert: logStream nextLine equals: 'Este'.
    self assert: logStream atEnd.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 7:38:45 pm (UTC)'!
test07LogsPositionAndHeadingForAllCommands

	| rover logger logStream |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest .
	logger := MarsRoverLoggerPositionAndHeading for: rover.

	rover process: 'bl'.
	
	logStream := logger readStream.

	self assert: logStream nextLine equals: '1@0'.
	self assert: logStream nextLine equals: 'Sur'.
	self assert: logStream atEnd.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 5:15:30 pm (UTC)'!
test08HeadingLoggerDoesNotLogMovements
	| rover logger logStream |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := MarsRoverLoggerHeading for: rover.

	rover process: 'fb'.
	
	logStream := logger readStream .
	
	self assert: logStream atEnd.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 5:14:19 pm (UTC)'!
test09PositionLoggerDoesNotLogRotations

	| rover logger logStream |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := MarsRoverLoggerPosition for: rover.

	rover process: 'lr'.
	
	logStream := logger readStream .
	
	self assert: logStream atEnd.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:21:15 pm (UTC)'!
test10EmptyCommandDoesNotChangeStatusWindow

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	window := MarsRoverStatusWindowPosition for: rover.

	rover process: ''.
	
	self assert: window textFieldPositionModel isEmpty .
	self assert: window textFieldHeadingModel isEmpty .
	
	! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:25:44 pm (UTC)'!
test11PositionWindowUpdatesOnNorthAndWestAndIgnoresRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	window := MarsRoverStatusWindowPosition for: rover.

	rover process: 'frb'.
	
	self assert: window textFieldPositionModel equals: '-1@1'.
	self assert: window textFieldHeadingModel isEmpty .
	
	! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:28:13 pm (UTC)'!
test12PositionWindowUpdatesOnSouthAndEastAndIgnoresRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	window := MarsRoverStatusWindowPosition for: rover.

	rover process: 'flb'.
	
	self assert: window textFieldPositionModel equals: '-1@ -1'.
	self assert: window textFieldHeadingModel isEmpty.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:26:22 pm (UTC)'!
test13HeadingWindowUpdatesHeadingOnLeftRotationsAndIgnoresMovements

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	window := MarsRoverStatusWindowHeading for: rover.

	rover process: 'ffrrrrl'.

	self assert: window textFieldHeadingModel equals: 'Apuntando Al Norte'.
	self assert: window textFieldPositionModel isEmpty.! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:26:33 pm (UTC)'!
test14HeadingWindowUpdatesHeadingOnRightRotationsAndIgnoresMovements

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	window := MarsRoverStatusWindowHeading for: rover.

	rover process: 'ffllllr'.

	self assert: window textFieldHeadingModel equals: 'Apuntando Al Sur'.
	self assert: window textFieldPositionModel isEmpty! !

!MarsRoverXXX methodsFor: 'tests' stamp: 'HAW 15/Oct/2026, 8:28:01 pm (UTC)'!
test15HeadingAndPositionWindowUpdatesBothOnMovementsAndRotations

	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	window := MarsRoverStatusWindowHeadingAndPostion for: rover.

	rover process: 'flbl'.

	self assert: window textFieldHeadingModel equals: 'Apuntando Al Sur'.
	self assert: window textFieldPositionModel equals: '1@1'.! !
