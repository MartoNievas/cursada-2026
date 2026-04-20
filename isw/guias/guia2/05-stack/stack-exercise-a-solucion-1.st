!classDefinition: #OOSStackStatus category: #'Stack-Exercise'!
Object subclass: #OOSStackStatus
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOSStackStatus methodsFor: 'initialization' stamp: 'Martin 4/17/2026 20:13:22'!
initializeFor: aStack

	stack := aStack .! !


!OOSStackStatus methodsFor: 'stack operations' stamp: 'Martin 4/17/2026 20:13:44'!
top 

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOSStackStatus class' category: #'Stack-Exercise'!
OOSStackStatus class
	instanceVariableNames: ''!

!OOSStackStatus class methodsFor: 'instance creation' stamp: 'Martin 4/17/2026 20:21:17'!
for: aStack

	^self new initializeFor: aStack .! !


!OOSStackStatus class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:23:07'!
canHandle: aStack

	self subclassResponsibility .! !

!OOSStackStatus class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:22:39'!
stateFor: aStack

	^(self subclasses detect: [:aStackStatusClass | aStackStatusClass canHandle: aStack]) for: aStack .! !


!classDefinition: #EmptyOOStack category: #'Stack-Exercise'!
OOSStackStatus subclass: #EmptyOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!EmptyOOStack methodsFor: 'stack operations' stamp: 'Martin 4/17/2026 20:33:08'!
top
	
	^stack topWhenIsEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyOOStack class' category: #'Stack-Exercise'!
EmptyOOStack class
	instanceVariableNames: ''!

!EmptyOOStack class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:43:37'!
canHandle: aStack

	^aStack isEmpty .! !


!classDefinition: #NotEmptyOOStack category: #'Stack-Exercise'!
OOSStackStatus subclass: #NotEmptyOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyOOStack methodsFor: 'stack operations' stamp: 'Martin 4/17/2026 20:38:30'!
top

	^ stack topWhenNotEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyOOStack class' category: #'Stack-Exercise'!
NotEmptyOOStack class
	instanceVariableNames: ''!

!NotEmptyOOStack class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:38:10'!
canHandle: aStack

	^ aStack notEmpty .! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'Martin 4/17/2026 19:52:27'!
initialize 

	elements  := OrderedCollection new.! !


!OOStack methodsFor: 'adding' stamp: 'Martin 4/17/2026 19:52:27'!
push: anElement

	elements addLast: anElement .! !


!OOStack methodsFor: 'accessing' stamp: 'Martin 4/17/2026 20:54:50'!
pop
	|top|
	top := self top.
	elements removeLast.
	^top! !

!OOStack methodsFor: 'accessing' stamp: 'Martin 4/17/2026 19:52:56'!
size

	^elements size.! !

!OOStack methodsFor: 'accessing' stamp: 'Martin 4/17/2026 20:17:50'!
top
		
	^ self state top.! !


!OOStack methodsFor: 'private' stamp: 'Martin 4/17/2026 20:18:40'!
state

	^ OOSStackStatus stateFor: self.! !

!OOStack methodsFor: 'private' stamp: 'Martin 4/17/2026 20:33:42'!
topWhenIsEmpty

	^self error: self class stackEmptyErrorDescription .! !

!OOStack methodsFor: 'private' stamp: 'Martin 4/17/2026 20:34:02'!
topWhenNotEmpty

	^elements last.! !


!OOStack methodsFor: 'testing' stamp: 'Martin 4/17/2026 19:52:27'!
isEmpty

	^elements isEmpty .! !

!OOStack methodsFor: 'testing' stamp: 'Martin 4/17/2026 20:26:04'!
notEmpty

	^elements notEmpty .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


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
