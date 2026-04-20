!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initilization' stamp: 'Martin 4/20/2026 10:01:04'!
initialize

	head := EmptyStackNode new.! !


!OOStack methodsFor: 'testing' stamp: 'Martin 4/20/2026 09:55:52'!
isEmpty

	^head isEmpty .! !


!OOStack methodsFor: 'pop/push' stamp: 'Martin 4/20/2026 10:05:53'!
pop
	|top|
	top := head top.
	head := head pop.

	^top! !

!OOStack methodsFor: 'pop/push' stamp: 'Martin 4/20/2026 09:57:27'!
push: anElement

	head := StackNode value: anElement next: head.! !


!OOStack methodsFor: 'accessing' stamp: 'Martin 4/20/2026 10:02:03'!
size

	^head size! !

!OOStack methodsFor: 'accessing' stamp: 'Martin 4/20/2026 09:56:42'!
top
	
	^head top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'prefix stack auxiliarReverseStack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Martin 4/20/2026 10:28:21'!
addToFoundSetencesIfPrefix: aSentence 

	(aSentence beginsWith: prefix ) ifTrue: [foundSentences add: aSentence ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Martin 4/20/2026 10:33:07'!
findAllSetencesByPrefixFromStack

	stack size timesRepeat: [self findSentencesByPrefixOnTopOfStack ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Martin 4/20/2026 10:32:26'!
findSentencesByPrefixOnTopOfStack

	|top|
	top := stack pop.
	auxiliarReverseStack push: top.
	self addToFoundSetencesIfPrefix: top.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Martin 4/20/2026 10:34:03'!
pushBackAnOriginalElement

	stack push: auxiliarReverseStack pop.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Martin 4/20/2026 10:34:33'!
rebuildOriginalStack
	
	auxiliarReverseStack size timesRepeat: [self pushBackAnOriginalElement ].! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'Martin 4/20/2026 10:18:59'!
initializeWith: aPrefix on: aStack

	prefix := aPrefix .
	stack := aStack .
	auxiliarReverseStack := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'Martin 4/20/2026 10:33:22'!
find

	foundSentences := OrderedCollection new.
	
	self findAllSetencesByPrefixFromStack .
	
	self rebuildOriginalStack.
	
	^ foundSentences .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Martin 4/20/2026 10:20:42'!
emptyPrefixErrorDescription

	^ 'Prefijo vacio!!!!!!'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Martin 4/20/2026 10:21:09'!
spaceInPrefixErrorDescription

	^'Espacio en el prefijo!!!!!!'.! !


!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'Martin 4/20/2026 10:24:14'!
assertHasNoEmpty: aPrefix

	(aPrefix isEmpty ) ifTrue: [self error: self emptyPrefixErrorDescription ].! !

!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'Martin 4/20/2026 10:23:44'!
assertHasNoSpace: aPrefix

	(aPrefix includes:  $ ) ifTrue: [self error: self spaceInPrefixErrorDescription ].! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'Martin 4/20/2026 10:28:50'!
with: aPrefix on: aStack
		
	self assertHasNoSpace: aPrefix.
	self assertHasNoEmpty: aPrefix .
		
	^self new initializeWith: aPrefix on: aStack .! !


!classDefinition: #StackNode category: #'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'testing' stamp: 'Martin 4/20/2026 09:56:07'!
isEmpty

	^false.! !

!StackNode methodsFor: 'testing' stamp: 'Martin 4/20/2026 10:02:33'!
size
	
	^ 1 + next size.! !


!StackNode methodsFor: 'accessing' stamp: 'Martin 4/20/2026 10:05:12'!
pop
	^next! !

!StackNode methodsFor: 'accessing' stamp: 'Martin 4/20/2026 09:53:35'!
top

	^ value! !


!StackNode methodsFor: 'initialization' stamp: 'Martin 4/20/2026 10:01:25'!
initializeWith: aValue next: aNextNode

	value := aValue.
	next := aNextNode .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackNode class' category: #'Stack-Exercise'!
StackNode class
	instanceVariableNames: ''!

!StackNode class methodsFor: 'instance creation' stamp: 'Martin 4/20/2026 09:58:45'!
value: aValue next: aNextNode

	^self new initializeWith: aValue next: aNextNode .! !


!classDefinition: #EmptyStackNode category: #'Stack-Exercise'!
StackNode subclass: #EmptyStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackNode methodsFor: 'accessing' stamp: 'Martin 4/20/2026 09:54:14'!
pop

	^ self error: OOStack stackEmptyErrorDescription .! !

!EmptyStackNode methodsFor: 'accessing' stamp: 'Martin 4/20/2026 09:54:09'!
top

	^ self error: OOStack stackEmptyErrorDescription .! !


!EmptyStackNode methodsFor: 'testing' stamp: 'Martin 4/20/2026 09:56:20'!
isEmpty

	^ true! !

!EmptyStackNode methodsFor: 'testing' stamp: 'Martin 4/20/2026 10:02:16'!
size

	^0.! !


!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
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

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:48:56'!
test01FindInEmptyStackReturnsEmptyCollection

    | stack finder result |
    
    stack := OOStack new.
    finder := SentenceFinderByPrefix with: 'Win' on: stack.
    result := finder find.
    
    self assert: result isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:49:01'!
test02FindWithEmptyPrefixRaisesError

    | stack |
    
    stack := OOStack new.
    stack push: 'Mi nombre es Martin'.
    stack push: 'Hola'.
    
    self
        should: [ SentenceFinderByPrefix with: '' on: stack ]
        raise: Error
        withExceptionDo: [ :anError |
            self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:49:13'!
test03FindWithAPrefixWithSpacesRaisesError

    | stack |
    
    stack := OOStack new.
    stack push: 'Mi nombre es Martin'.
    stack push: 'Hola'.
    
    self
        should: [ SentenceFinderByPrefix with: 'Win ter' on: stack ]
        raise: Error
        withExceptionDo: [ :anError |
            self assert: anError messageText = SentenceFinderByPrefix spaceInPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:52:18'!
test04FindReturnsSentencesThatMatchPrefix

    | stack finder result |
    
    stack := OOStack new.
    stack push: 'winter is coming'.
    stack push: 'winning is everything'.
    stack push: 'The winds of Winter'.
    stack push: 'Winter is here'.
    
    finder := SentenceFinderByPrefix with: 'Win' on: stack.
    result := finder find.
    
    self assert: result size = 1.
    self assert: (result includes: 'Winter is here').! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:58:40'!
test05FindPreservesStackOrder

	|stack finder|
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'Winter is Here'.
	stack push: 'Are you winning son'.
	stack push: 'Comming soon'.
	
	finder := SentenceFinderByPrefix with: 'Win' on: stack .
	
	finder find.
	
	self assert: stack pop = 'Comming soon'.
	self assert: stack pop = 'Are you winning son'.
	self assert: stack pop = 'Winter is Here'.
	self assert: stack pop = 'winter is coming'.
	self assert: stack isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 10:59:18'!
test06FindReturnsAllMatchingSentences

    | stack finder result |
    
    stack := OOStack new.
    stack push: 'winter is coming'.
    stack push: 'Winter is here'.
    stack push: 'Winter is coming too'.
    
    finder := SentenceFinderByPrefix with: 'Win' on: stack.
    result := finder find.
    
    self assert: result size = 2.
    self assert: (result includes: 'Winter is here').
    self assert: (result includes: 'Winter is coming too').! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Martin 4/20/2026 11:00:15'!
test07FindReturnsEmptyCollectionWhenNothingMatches

    | stack finder result |
    
    stack := OOStack new.
    stack push: 'winter is coming'.
    stack push: 'The winds of Winter'.
    stack push: 'Are you winning son'.
    
    finder := SentenceFinderByPrefix with: 'Win' on: stack.
    result := finder find.
    
    self assert: result isEmpty.! !
