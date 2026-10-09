!classDefinition: #CardinalPoint category: #MarsRover!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'evaluating' stamp: 'MNW 8/Oct/2026, 9:30:00 pm (UTC)'!
isRepresentedBy: unSimbolo
	self subclassResponsibility! !


!CardinalPoint methodsFor: 'comparing' stamp: 'AP 7/Oct/2026, 2:55:21 pm (UTC)'!
= unObjeto
	self == unObjeto ifTrue: [ ^ true ].
	^ self class == unObjeto class! !

!CardinalPoint methodsFor: 'comparing' stamp: 'AP 7/Oct/2026, 2:54:54 pm (UTC)'!
hash
	^ self class hash! !


!CardinalPoint methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:27 am (UTC)'!
backwardVector
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:19 am (UTC)'!
forwardVector
	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:09 am (UTC)'!
rotateLeft
	self subclassResponsibility! !

!CardinalPoint methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:01 am (UTC)'!
rotateRight
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #MarsRover!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'instance creation' stamp: 'HAW 9/Oct/2026, 12:43:00 am (UTC)'!
for: aHeading
    ^ (self subclasses 
        detect: [ :aSubclass | aSubclass isRepresentedBy: aHeading ]
        ifNone: [ self error: self invalidCardinalPointErrorDescription ]) new! !


!CardinalPoint class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:43:58 am (UTC)'!
isRepresentedBy: aSymbol

	self subclassResponsibility .! !


!CardinalPoint class methodsFor: 'error description' stamp: 'HAW 9/Oct/2026, 12:21:45 am (UTC)'!
invalidCardinalPointErrorDescription

	^ 'Unknown cardinal point'! !


!classDefinition: #East category: #MarsRover!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'evaluating' stamp: 'HAW 8/Oct/2026, 1:38:39 am (UTC)'!
isRepresentedBy: unSimbolo
	^ unSimbolo = #East! !


!East methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:27 am (UTC)'!
backwardVector
	^ -1@0.! !

!East methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:19 am (UTC)'!
forwardVector
	^ 1@0.! !


!East methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:09 am (UTC)'!
rotateLeft
	^ North new.! !

!East methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:01 am (UTC)'!
rotateRight
	^ South new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:44:16 am (UTC)'!
isRepresentedBy: aSymbol
	
	^ aSymbol = #East! !


!classDefinition: #North category: #MarsRover!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'evaluating' stamp: 'HAW 8/Oct/2026, 1:38:39 am (UTC)'!
isRepresentedBy: unSimbolo
	^ unSimbolo = #North! !


!North methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:27 am (UTC)'!
backwardVector
	^ 0@-1.! !

!North methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:19 am (UTC)'!
forwardVector
	^ 0@1.! !


!North methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:09 am (UTC)'!
rotateLeft
	^ West new.! !

!North methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:01 am (UTC)'!
rotateRight
	^ East new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:44:30 am (UTC)'!
isRepresentedBy: aSymbol

	^ aSymbol = #North! !


!classDefinition: #South category: #MarsRover!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'evaluating' stamp: 'HAW 8/Oct/2026, 1:38:40 am (UTC)'!
isRepresentedBy: unSimbolo
	^ unSimbolo = #South! !


!South methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:27 am (UTC)'!
backwardVector
	^ 0@1.! !

!South methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:19 am (UTC)'!
forwardVector
	^ 0@-1.! !


!South methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:09 am (UTC)'!
rotateLeft
	^ East new.! !

!South methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:01 am (UTC)'!
rotateRight
	^ West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:44:42 am (UTC)'!
isRepresentedBy: aSymbol

	^ aSymbol = #South! !


!classDefinition: #West category: #MarsRover!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'evaluating' stamp: 'HAW 8/Oct/2026, 1:38:40 am (UTC)'!
isRepresentedBy: unSimbolo
	^ unSimbolo = #West! !


!West methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:27 am (UTC)'!
backwardVector
	^ 1@0.! !

!West methodsFor: 'step' stamp: 'HAW 8/Oct/2026, 1:39:19 am (UTC)'!
forwardVector
	^ -1@0.! !


!West methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:09 am (UTC)'!
rotateLeft
	^ South new.! !

!West methodsFor: 'rotation' stamp: 'HAW 8/Oct/2026, 1:39:01 am (UTC)'!
rotateRight
	^ North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:44:57 am (UTC)'!
isRepresentedBy: aSymbol

	^ aSymbol = #West! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MNW 8/Oct/2026, 1:30:00 am (UTC)'!
initializeAt: aPosition heading: aHeading
	position := aPosition.
	heading := aHeading.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/Oct/2026, 1:38:40 am (UTC)'!
isAt: aPosition heading: aHeading
	^ (position = aPosition) and: [ heading isRepresentedBy: aHeading ]! !


!MarsRover methodsFor: 'movement' stamp: 'HAW 9/Oct/2026, 12:37:00 am (UTC)'!
moveBackward

	position := position + heading backwardVector .! !

!MarsRover methodsFor: 'movement' stamp: 'HAW 9/Oct/2026, 12:36:41 am (UTC)'!
moveForward

	position := position + heading forwardVector .! !

!MarsRover methodsFor: 'movement' stamp: 'HAW 9/Oct/2026, 12:36:01 am (UTC)'!
rotateLeft

	heading := heading rotateLeft .! !

!MarsRover methodsFor: 'movement' stamp: 'HAW 9/Oct/2026, 12:36:10 am (UTC)'!
rotateRight

	heading := heading rotateRight ! !


!MarsRover methodsFor: 'process' stamp: 'HAW 9/Oct/2026, 12:40:57 am (UTC)'!
process: unPaqueteDeComandos
	unPaqueteDeComandos do: [ :comando |
		self processCommand: comando.
	].! !

!MarsRover methodsFor: 'process' stamp: 'HAW 9/Oct/2026, 12:37:54 am (UTC)'!
processCommand: aCommand
	
	|command|
	command := MarsRoverCommand for: aCommand .
	command executeOn: self .

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/Oct/2026, 1:37:59 am (UTC)'!
at: aPosition heading: aHeading
	^ self new initializeAt: aPosition heading: (CardinalPoint for: aHeading)! !


!MarsRover class methodsFor: 'error description' stamp: 'HAW 9/Oct/2026, 12:42:22 am (UTC)'!
invalidCommandErrorDescription
	^ 'One of the package commands is invalid. Aborting execution.'.! !


!classDefinition: #MarsRoverCommand category: #MarsRover!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'execution' stamp: 'HAW 9/Oct/2026, 12:33:50 am (UTC)'!
executeOn: aMarsRover

    self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: #MarsRover!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:32:04 am (UTC)'!
canHandle: aCharacter

	self subclassResponsibility .! !


!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'HAW 9/Oct/2026, 12:42:15 am (UTC)'!
for: aCharacter
    ^ self subclasses 
        detect: [ :aSubclass | aSubclass canHandle: aCharacter ]
        ifFound: [ :aSubclass | aSubclass new ]
        ifNone: [ self error: MarsRover invalidCommandErrorDescription ].! !


!classDefinition: #MoveBackwardCommand category: #MarsRover!
MarsRoverCommand subclass: #MoveBackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwardCommand methodsFor: 'execution' stamp: 'HAW 9/Oct/2026, 12:40:29 am (UTC)'!
executeOn: aMarsRover

	aMarsRover moveBackward .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardCommand class' category: #MarsRover!
MoveBackwardCommand class
	instanceVariableNames: ''!

!MoveBackwardCommand class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:40:00 am (UTC)'!
canHandle: aCharacter

	^ aCharacter = $b.! !


!classDefinition: #MoveForwardCommand category: #MarsRover!
MarsRoverCommand subclass: #MoveForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForwardCommand methodsFor: 'execution' stamp: 'HAW 9/Oct/2026, 12:40:24 am (UTC)'!
executeOn: aMarsRover

	aMarsRover moveForward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardCommand class' category: #MarsRover!
MoveForwardCommand class
	instanceVariableNames: ''!

!MoveForwardCommand class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:40:10 am (UTC)'!
canHandle: aCharacter

	^  aCharacter  = $f.! !


!classDefinition: #RotateLeftCommand category: #MarsRover!
MarsRoverCommand subclass: #RotateLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeftCommand methodsFor: 'execution' stamp: 'HAW 9/Oct/2026, 12:34:53 am (UTC)'!
executeOn: aMarsRover

	aMarsRover rotateLeft .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommand class' category: #MarsRover!
RotateLeftCommand class
	instanceVariableNames: ''!

!RotateLeftCommand class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:32:54 am (UTC)'!
canHandle: aCharacter

	^ aCharacter = $l! !


!classDefinition: #RotateRightCommand category: #MarsRover!
MarsRoverCommand subclass: #RotateRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRightCommand methodsFor: 'execution' stamp: 'HAW 9/Oct/2026, 12:35:10 am (UTC)'!
executeOn: aMarsRover

	aMarsRover rotateRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommand class' category: #MarsRover!
RotateRightCommand class
	instanceVariableNames: ''!

!RotateRightCommand class methodsFor: 'testing' stamp: 'HAW 9/Oct/2026, 12:33:06 am (UTC)'!
canHandle: aCharacter

	^ aCharacter = $r.! !


!classDefinition: #TestMarsRover category: #MarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:42:43 am (UTC)'!
test01EmptyCommandSequenceDoesNothing
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	rover process: ''.

	self assert: (rover isAt: 0@0 heading: #North).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:43:15 am (UTC)'!
test02CommandFMovesSouthWhenHeadingSouth
	| rover |
	rover := MarsRover at: 0@0 heading: #South.

	rover process: 'f'.

	self assert: (rover isAt: 0@-1 heading: #South).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:43:34 am (UTC)'!
test03CommandFMovesEastWhenHeadingEast
	| rover |
	rover := MarsRover at: 0@0 heading: #East.

	rover process: 'f'.

	self assert: (rover isAt: 1@0 heading: #East).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:43:49 am (UTC)'!
test04CommandFMovesNorthWhenHeadingNorth
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	rover process: 'f'.

	self assert: (rover isAt: 0@1 heading: #North).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:02 am (UTC)'!
test05CommandFMovesWestWhenHeadingWest
	| rover |
	rover := MarsRover at: 0@0 heading: #West.

	rover process: 'f'.

	self assert: (rover isAt: -1@0 heading: #West).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:22 am (UTC)'!
test06CommandFRepeatedMovesMultipleTimesInHeadingDirection
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	rover process: 'ff'.

	self assert: (rover isAt: 0@2 heading: #North).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:30 am (UTC)'!
test07CommandBMovesBackwardInHeadingDirection
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	rover process: 'bbbff'.

	self assert: (rover isAt: 0@-1 heading: #North).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:40 am (UTC)'!
test08CommandLChangesHeadingToWestFromNorth
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	rover process: 'l'.

	self assert: (rover isAt: 0@0 heading: #West).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:47 am (UTC)'!
test09CommandLChangesHeadingToSouthFromWest
	| rover |
	rover := MarsRover at: 0@0 heading: #West.

	rover process: 'l'.

	self assert: (rover isAt: 0@0 heading: #South).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:44:52 am (UTC)'!
test10CommandLRepeatedRotatesCounterClockwise
	| rover |
	rover := MarsRover at: 0@0 heading: #South.

	rover process: 'lll'.

	self assert: (rover isAt: 0@0 heading: #West).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:45:05 am (UTC)'!
test11CommandRRepeatedRotatesClockwise
	| rover |
	rover := MarsRover at: 0@0 heading: #South.

	rover process: 'rrr'.

	self assert: (rover isAt: 0@0 heading: #East).! !

!TestMarsRover methodsFor: 'tests' stamp: 'HAW 8/Oct/2026, 1:45:11 am (UTC)'!
test12InvalidCommandStopsProcessingRemainingSequence
	| rover |
	rover := MarsRover at: 0@0 heading: #North.

	self should: [ rover process: 'frflfbXffff'. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: MarsRover invalidCommandErrorDescription.
		].

	self assert: (rover isAt: 1@1 heading: #North).! !
