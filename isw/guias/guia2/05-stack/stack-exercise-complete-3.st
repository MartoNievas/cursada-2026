!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'HAW 4/Sep/2026, 8:55:22 pm (UTC)'!
!methodProperties: {}!
initialize

	topNode  := OOStackBase new.! !


!OOStack methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:59:41 pm (UTC)'!
!methodProperties: {}!
isEmpty
	
	^ topNode isBase .
	! !

!OOStack methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:58:01 pm (UTC)'!
!methodProperties: {}!
size

	^ topNode size.! !

!OOStack methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:00:17 pm (UTC)'!
!methodProperties: {}!
top

	^ topNode value.! !


!OOStack methodsFor: 'removing' stamp: 'HAW 4/Sep/2026, 9:04:32 pm (UTC)'!
!methodProperties: {}!
pop
	
	| poppedValue |
	poppedValue := self top.
	topNode := topNode previousNode.
	^poppedValue .! !


!OOStack methodsFor: 'adding' stamp: 'HAW 4/Sep/2026, 8:59:05 pm (UTC)'!
!methodProperties: {}!
push: aValueToPush

	topNode := OOStackItem withValue: aValueToPush andPreviousNode: topNode .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 14/Sep/2023, 11:12:21 am (UTC)'!
!methodProperties: {}!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:49:52 pm (UTC)'!
!methodProperties: {}!
isBase

	self subclassResponsibility .! !

!OOStackNode methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:56:07 pm (UTC)'!
!methodProperties: {}!
isEmpty

	^ self subclassResponsibility .! !

!OOStackNode methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:04:32 pm (UTC)'!
!methodProperties: {}!
previousNode

	self subclassResponsibility .! !

!OOStackNode methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:04:05 pm (UTC)'!
!methodProperties: {}!
value

	self subclassResponsibility .! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:50:36 pm (UTC)'!
!methodProperties: {}!
isBase

	^true.! !

!OOStackBase methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:05:17 pm (UTC)'!
!methodProperties: {}!
previousNode

	self error: OOStack stackEmptyErrorDescription .
	! !

!OOStackBase methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:57:05 pm (UTC)'!
!methodProperties: {}!
size

	^0.! !

!OOStackBase methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:05:31 pm (UTC)'!
!methodProperties: {}!
value

	self error: OOStack stackEmptyErrorDescription .! !


!classDefinition: #OOStackItem category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackItem
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackItem methodsFor: 'initialization' stamp: 'HAW 4/Sep/2026, 8:53:18 pm (UTC)'!
!methodProperties: {}!
initializeWithValue: aValueNode andPreviousNode: aPreviousNode

	value := aValueNode.
	previous := aPreviousNode .! !


!OOStackItem methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:50:29 pm (UTC)'!
!methodProperties: {}!
isBase

	^false.! !

!OOStackItem methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:04:32 pm (UTC)'!
!methodProperties: {}!
previousNode

	^ previous .! !

!OOStackItem methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 8:57:49 pm (UTC)'!
!methodProperties: {}!
size

	^ 1 + previous size.! !

!OOStackItem methodsFor: 'consulting' stamp: 'HAW 4/Sep/2026, 9:00:28 pm (UTC)'!
!methodProperties: {}!
value

	^value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackItem class' category: #'Stack-Exercise'!
OOStackItem class
	instanceVariableNames: ''!

!OOStackItem class methodsFor: 'instance creation' stamp: 'HAW 4/Sep/2026, 8:52:40 pm (UTC)'!
!methodProperties: {}!
withValue: aValueNode andPreviousNode: aPreviousNode

	^ self new initializeWithValue: aValueNode andPreviousNode: aPreviousNode .! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentencesStack reverseOriginalStack prefix sentencesFound'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'MA 5/Sep/2026, 2:53:40 pm (UTC)'!
!methodProperties: {}!
find
	sentencesFound := OrderedCollection new.
	self findAllSentencesThatMatchWithPrefix. 
	self rebuildOriginalStack.
	^ sentencesFound .! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'MA 4/Sep/2026, 5:21:48 pm (UTC)'!
!methodProperties: {}!
addSentenceIfMatchWithPrefix: aSentence

	(aSentence beginsWith: prefix) ifTrue: [sentencesFound add: aSentence ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'HAW 4/Sep/2026, 7:51:31 pm (UTC)'!
!methodProperties: {}!
findAllSentencesThatMatchWithPrefix

	^ self popAllFrom: sentencesStack doing: [ :aSentence |
		reverseOriginalStack push: aSentence .
		self addSentenceIfMatchWithPrefix: aSentence.
	].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'MA 5/Sep/2026, 8:46:39 pm (UTC)'!
!methodProperties: {}!
popAllFrom: aStack doing: aBlock
	
	^ [aStack isEmpty ] whileFalse: [
		|currentValue|
		currentValue := aStack pop.
		aBlock value: currentValue ] .! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'HAW 4/Sep/2026, 7:51:31 pm (UTC)'!
!methodProperties: {}!
rebuildOriginalStack

	^ self popAllFrom: reverseOriginalStack doing: [:poppedValue | 
		sentencesStack push: poppedValue .
	].! !


!SentenceFinderByPrefix methodsFor: 'asserting' stamp: 'HAW 4/Sep/2026, 10:34:27 pm (UTC)'!
!methodProperties: {}!
assertIsValidPrefix: aPrefix

	^ (aPrefix isEmpty or: [aPrefix includes: $  ] )ifTrue: [self error: SentenceFinderByPrefix emptyOrWithSpacesPrefixErrorMessage]! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'MA 5/Sep/2026, 3:37:24 pm (UTC)'!
!methodProperties: {}!
initializeWith: aPrefix and: aStack
	
	self assertIsValidPrefix: aPrefix .
	
	prefix := aPrefix .
	sentencesStack := aStack .
	reverseOriginalStack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'MA 5/Sep/2026, 3:07:09 pm (UTC)'!
!methodProperties: {}!
withPrefix: aPrefix andStack: aStack


	^ self new initializeWith: aPrefix and: aStack .! !


!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'MA 5/Sep/2026, 7:13:55 pm (UTC)'!
!methodProperties: {}!
emptyOrWithSpacesPrefixErrorMessage

	^ 'El prefijo no puede ser vacio o contener espacios en blanco'! !


!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 7/May/2012, 2:30:00 pm (UTC)'!
!methodProperties: {}!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:29:55 pm (UTC)'!
!methodProperties: {}!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:30:01 pm (UTC)'!
!methodProperties: {}!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:30:09 pm (UTC)'!
!methodProperties: {}!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 16/Sep/2021, 8:40:17 pm (UTC)'!
!methodProperties: {}!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:30:20 pm (UTC)'!
!methodProperties: {}!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:30:24 pm (UTC)'!
!methodProperties: {}!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 15/Apr/2017, 1:48:26 am (UTC)'!
!methodProperties: {}!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 13/May/2020, 4:30:31 pm (UTC)'!
!methodProperties: {}!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 15/Apr/2017, 1:48:44 am (UTC)'!
!methodProperties: {}!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:01:15 pm (UTC)'!
!methodProperties: {}!
test01PrefixCannotBeEmpty

    self assertInvalidPrefixRaisesError: ''.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:01:15 pm (UTC)'!
!methodProperties: {}!
test02PrefixCannotBeASingleSpace

    self assertInvalidPrefixRaisesError: ' '.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:01:15 pm (UTC)'!
!methodProperties: {}!
test03PrefixCannotBeMultipleSpaces

    self assertInvalidPrefixRaisesError: '      '.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:29:04 pm (UTC)'!
!methodProperties: {}!
test04FindSentenceWithMatchingPrefix

	| stack finder foundSentences |
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.

	finder := SentenceFinderByPrefix withPrefix: 'Wint' andStack: stack.
	foundSentences := finder find.

	self assert: foundSentences size equals: 1.
	self assert: (foundSentences includes: 'Winter is here').

	self assertStack: stack popsInOrder: (OrderedCollection
		with: 'Winter is here'
		with: 'The winds of Winter'
		with: 'winning is everything'
		with: 'winter is coming').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:29:48 pm (UTC)'!
!methodProperties: {}!
test05FindSentencesWithMatchingPrefix

	| finder stack foundSentences expectedSentences |
	stack := OOStack new.
	stack push: 'Shifu'.
	stack push: 'Messi'.
	stack push: 'hola'.
	stack push: 'HolA'.
	stack push: 'Hola como estas'.
	stack push: ' Hola'.

	finder := SentenceFinderByPrefix withPrefix: 'Ho' andStack: stack.
	foundSentences := finder find.

	expectedSentences := OrderedCollection with: 'Hola como estas' with: 'HolA'.
	self assert: foundSentences equals: expectedSentences.

	self assertStack: stack popsInOrder: (OrderedCollection
		with: ' Hola'
		with: 'Hola como estas'
		with: 'HolA'
		with: 'hola'
		with: 'Messi'
		with: 'Shifu')! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:07:09 pm (UTC)'!
!methodProperties: {}!
test06FindOnEmptyStackReturnsEmptyCollection

	| finder foundSetences |
	finder := SentenceFinderByPrefix withPrefix: 'Wint' andStack: OOStack new.
	
	foundSetences := finder find.
	
	self assert: foundSetences isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:12:00 pm (UTC)'!
!methodProperties: {}!
test07FindReturnsEmptyCollectionWhenNoSentenceMatchesPrefix

	| stack sentenceFinder foundSentences |
	stack := OOStack new.
	stack push: 'Martin'.
	stack push: 'Andy'.
	stack push: 'Nico'.
	stack push: 'Hernan'.
	
	sentenceFinder := SentenceFinderByPrefix withPrefix: 'Juan' andStack: stack.
	
	foundSentences := sentenceFinder find.
	
	self assert: foundSentences isEmpty .
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:31:31 pm (UTC)'!
!methodProperties: {}!
test08FindWithAllSentencesMatchingReturnsAllSentences

	| stack sentenceFinder foundSentences expectedSentences |
	stack := OOStack new.
	stack push: 'Wadu Wadu'.
	stack push: 'Watermelon'.
	stack push: 'Wish You Were Here'.

	sentenceFinder := SentenceFinderByPrefix withPrefix: 'W' andStack: stack.
	
	foundSentences := sentenceFinder find.
	
	expectedSentences := OrderedCollection
	with: 'Wish You Were Here'
	with: 'Watermelon'
	with: 'Wadu Wadu'.
	
	self assert: foundSentences size equals: 3.
	self assert: foundSentences equals: expectedSentences .

	self assertStack: stack popsInOrder: (OrderedCollection
		with: 'Wish You Were Here'
		with: 'Watermelon'
		with: 'Wadu Wadu').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:36:47 pm (UTC)'!
!methodProperties: {}!
test09FindIsCaseSensitive

	| stack sentenceFinder foundSentences |
	stack := OOStack new.
	stack push: 'winter'.
	
	sentenceFinder := SentenceFinderByPrefix withPrefix: 'Wint' andStack: stack .
	
	foundSentences := sentenceFinder find.
	
	self assert: foundSentences isEmpty .
	self assertStack: stack popsInOrder: (OrderedCollection with: 'winter')
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:36:00 pm (UTC)'!
!methodProperties: {}!
test10FindCalledTwiceOnSameInstanceReturnsSameResult

	| stack sentenceFinder firstResult secondResult |
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'Winter is here'.

	sentenceFinder := SentenceFinderByPrefix withPrefix: 'Wint' andStack: stack.

	firstResult := sentenceFinder find.
	secondResult := sentenceFinder find.

	self assert: firstResult equals: secondResult! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:38:52 pm (UTC)'!
!methodProperties: {}!
test11FindMatchesSentenceEqualToPrefix

	| stack sentenceFinder foundSentences |
	stack := OOStack new.
	stack push: 'Winter'.

	sentenceFinder := SentenceFinderByPrefix withPrefix: 'Winter' andStack: stack.

	foundSentences := sentenceFinder find.

	self assert: foundSentences equals: (OrderedCollection with: 'Winter').
	self assertStack: stack popsInOrder: (OrderedCollection with: 'Winter').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MA 5/Sep/2026, 3:39:03 pm (UTC)'!
!methodProperties: {}!
test12FindDoesNotMatchSentenceShorterThanPrefix

	| stack sentenceFinder foundSentences |
	stack := OOStack new.
	stack push: 'Wint'.

	sentenceFinder := SentenceFinderByPrefix withPrefix: 'Winter' andStack: stack.

	foundSentences := sentenceFinder find.

	self assert: foundSentences isEmpty.
	self assertStack: stack popsInOrder: (OrderedCollection with: 'Wint').! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'MA 5/Sep/2026, 3:07:09 pm (UTC)'!
!methodProperties: {}!
assertInvalidPrefixRaisesError: anInvalidPrefix

	^ self
		should: [ SentenceFinderByPrefix withPrefix: anInvalidPrefix andStack: OOStack new ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyOrWithSpacesPrefixErrorMessage ]! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'MA 5/Sep/2026, 3:38:02 pm (UTC)'!
!methodProperties: {}!
assertStack: aStack popsInOrder: anOrderedCollection

	anOrderedCollection do: [ :expectedValue |
			self assert: expectedValue  equals: aStack pop
	].
	self assert: aStack isEmpty .

	 
	! !
