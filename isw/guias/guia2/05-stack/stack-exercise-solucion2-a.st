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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


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
