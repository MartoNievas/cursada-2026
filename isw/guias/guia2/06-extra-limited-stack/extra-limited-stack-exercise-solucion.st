!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'Martin 4/17/2026 19:52:27'!
initialize 

	elements  := OrderedCollection new.! !


!OOStack methodsFor: 'adding' stamp: 'Martin 4/20/2026 18:09:56'!
push: anElement

	self subclassResponsibility .! !


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


!OOStack methodsFor: 'private' stamp: 'Martin 4/20/2026 18:04:29'!
state

	^ OOStackStatus stateFor: self.! !

!OOStack methodsFor: 'private' stamp: 'Martin 4/17/2026 20:33:42'!
topWhenIsEmpty

	^self error: self class stackEmptyErrorDescription .! !

!OOStack methodsFor: 'private' stamp: 'Martin 4/17/2026 20:34:02'!
topWhenNotEmpty

	^elements last.! !


!OOStack methodsFor: 'testing' stamp: 'Martin 4/17/2026 19:52:27'!
isEmpty

	^elements isEmpty .! !

!OOStack methodsFor: 'testing' stamp: 'Martin 4/20/2026 18:11:57'!
isFull

	self subclassResponsibility .! !

!OOStack methodsFor: 'testing' stamp: 'Martin 4/17/2026 20:26:04'!
notEmpty

	^elements notEmpty .! !

!OOStack methodsFor: 'testing' stamp: 'Martin 4/20/2026 18:29:01'!
notFull

	^self isFull not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #LimitedOOStack category: #'Stack-Exercise'!
OOStack subclass: #LimitedOOStack
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LimitedOOStack methodsFor: 'testing' stamp: 'Martin 4/20/2026 18:13:32'!
isFull

	^self size = limit .! !


!LimitedOOStack methodsFor: 'initialization' stamp: 'Martin 4/20/2026 18:13:19'!
initializeWith: aLimit

	limit := aLimit .! !


!LimitedOOStack methodsFor: 'private' stamp: 'Martin 4/20/2026 18:14:02'!
pushWhenEmpty: anElement

	^elements add: anElement .! !

!LimitedOOStack methodsFor: 'private' stamp: 'Martin 4/20/2026 18:14:28'!
pushWhenFull: anElement

	^self error: self class stackFullErrorDescription .! !

!LimitedOOStack methodsFor: 'private' stamp: 'Martin 4/20/2026 18:15:02'!
pushWhenNotEmpty: anElement

	^self pushWhenEmpty: anElement .! !

!LimitedOOStack methodsFor: 'private' stamp: 'Martin 4/20/2026 18:15:24'!
topWhenFull

	^self topWhenNotEmpty .! !


!LimitedOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:16:15'!
push: anElement

	^self state push: anElement .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LimitedOOStack class' category: #'Stack-Exercise'!
LimitedOOStack class
	instanceVariableNames: ''!

!LimitedOOStack class methodsFor: 'error descriptions' stamp: 'Martin 4/20/2026 18:19:16'!
limitMustBeIntegerErrorMessage

	^'El limite debe ser un integer'! !

!LimitedOOStack class methodsFor: 'error descriptions' stamp: 'Martin 4/20/2026 18:18:53'!
limitMustBeStrictlyPositiveErrorMessage

	^'El limite debe ser estrictamente positivo'! !

!LimitedOOStack class methodsFor: 'error descriptions' stamp: 'Martin 4/20/2026 18:11:08'!
stackFullErrorDescription

	^'El stack esta lleno'.! !


!LimitedOOStack class methodsFor: 'instance creation' stamp: 'Martin 4/20/2026 18:18:29'!
to: aLimit
	
	aLimit strictlyPositive ifFalse: [self error: self limitMustBeStrictlyPositiveErrorMessage].
	aLimit isInteger ifFalse: [self error: self limitMustBeIntegerErrorMessage].	
	^self new initializeWith: aLimit .! !


!classDefinition: #UnlimitedOOStack category: #'Stack-Exercise'!
OOStack subclass: #UnlimitedOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!UnlimitedOOStack methodsFor: 'adding' stamp: 'Martin 4/20/2026 18:20:16'!
push: anElement

	elements add: anElement .! !


!UnlimitedOOStack methodsFor: 'testing' stamp: 'Martin 4/20/2026 18:27:33'!
isFull

	^false.! !


!classDefinition: #OOStackStatus category: #'Stack-Exercise'!
Object subclass: #OOStackStatus
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStatus methodsFor: 'initialization' stamp: 'Martin 4/17/2026 20:13:22'!
initializeFor: aStack

	stack := aStack .! !


!OOStackStatus methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:07:30'!
push: anElement

	self subclassResponsibility .! !

!OOStackStatus methodsFor: 'stack operations' stamp: 'Martin 4/17/2026 20:13:44'!
top 

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStatus class' category: #'Stack-Exercise'!
OOStackStatus class
	instanceVariableNames: ''!

!OOStackStatus class methodsFor: 'instance creation' stamp: 'Martin 4/17/2026 20:21:17'!
for: aStack

	^self new initializeFor: aStack .! !


!OOStackStatus class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:23:07'!
canHandle: aStack

	self subclassResponsibility .! !

!OOStackStatus class methodsFor: 'state selection' stamp: 'Martin 4/17/2026 20:22:39'!
stateFor: aStack

	^(self subclasses detect: [:aStackStatusClass | aStackStatusClass canHandle: aStack]) for: aStack .! !


!classDefinition: #EmptyOOStack category: #'Stack-Exercise'!
OOStackStatus subclass: #EmptyOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:21:53'!
push: anElement

	^stack pushWhenEmpty: anElement .! !

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


!classDefinition: #FullOOStack category: #'Stack-Exercise'!
OOStackStatus subclass: #FullOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FullOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:23:01'!
push: anElement

	^stack pushWhenFull: anElement .! !

!FullOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:22:46'!
top

	^stack topWhenFull .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FullOOStack class' category: #'Stack-Exercise'!
FullOOStack class
	instanceVariableNames: ''!

!FullOOStack class methodsFor: 'state selection' stamp: 'Martin 4/20/2026 18:23:38'!
canHandle: aStack

	^aStack isFull .! !


!classDefinition: #NotEmptyAndNotFullOOStack category: #'Stack-Exercise'!
OOStackStatus subclass: #NotEmptyAndNotFullOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyAndNotFullOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:25:24'!
push: anElement

	^stack pushWhenNotEmpty: anElement .! !

!NotEmptyAndNotFullOOStack methodsFor: 'stack operations' stamp: 'Martin 4/20/2026 18:24:59'!
top

	^stack topWhenNotEmpty .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyAndNotFullOOStack class' category: #'Stack-Exercise'!
NotEmptyAndNotFullOOStack class
	instanceVariableNames: ''!

!NotEmptyAndNotFullOOStack class methodsFor: 'state selection' stamp: 'Martin 4/20/2026 18:26:20'!
canHandle: aStack

	^aStack notEmpty and: [aStack notFull.]! !


!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 21:59:32'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := self createStack .
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 21:59:57'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := self createStack .
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:05'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := self createStack .
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:14'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := self createStack .
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:20'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := self createStack .
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:27'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := self createStack .
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:40'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := self createStack .
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:35'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := self createStack .
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:47'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := self createStack .
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'Martin 4/20/2026 22:00:53'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := self createStack .
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!OOStackTest methodsFor: 'setup' stamp: 'Martin 4/20/2026 21:49:33'!
createStack

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackTest class' category: #'Stack-Exercise'!
OOStackTest class
	instanceVariableNames: ''!

!OOStackTest class methodsFor: 'testing' stamp: 'Martin 4/20/2026 21:57:24'!
isAbstract

	^true.! !


!classDefinition: #LimitedOOStackTest category: #'Stack-Exercise'!
OOStackTest subclass: #LimitedOOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LimitedOOStackTest methodsFor: 'setup' stamp: 'Martin 4/20/2026 21:53:55'!
createStack

	^LimitedOOStack to: 10.! !


!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:05:53'!
test01PushElementeInAFullStackRaisesError
    | stack |
    stack := LimitedOOStack to: 1.
    stack push: 'hola'.
    self
        should: [ stack push: 'chau' ]
        raise: Error
        withExceptionDo: [ :anError |
            self assert: anError messageText = LimitedOOStack stackFullErrorDescription ]! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:08:26'!
test02PushingAnElementInAnEmptyStackIncreasesItsSizeByOne

|stack|

stack := LimitedOOStack to: 10.
stack push: 'hello world'.

self assert: stack size = 1.! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:12:51'!
test03LimitMustBeAnInteger
    self
        should: [ LimitedOOStack to: 1.5 ]
        raise: Error
        withExceptionDo: [ :anError |
            self assert: anError messageText = LimitedOOStack limitMustBeIntegerErrorMessage ]! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:13:34'!
test04LimitMustBeAnIntegerStrictlyPosivite

self
        should: [ LimitedOOStack to: 0 ]
        raise: Error
        withExceptionDo: [ :anError |
            self assert: anError messageText = LimitedOOStack limitMustBeStrictlyPositiveErrorMessage ]! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:16:15'!
test05FullMessageInAFullStackIsTrue

	|stack|
	stack := LimitedOOStack to: 2.
	stack push: 'Mi amigo el elefante'.
	stack push: 'Los autos son rapidos'.
	    self assert: stack isFull.! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:17:19'!
test06FullMessageInANotFullStackIsFalse

	|stack|
	stack := LimitedOOStack to:2.
	stack push: 1.
	self assert: stack notFull .! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:18:55'!
test07TopReturnsLastElementAndDoesNotModify

	|stack| 
	stack := LimitedOOStack to: 10.
    stack push: 'hello'.
    self assert: stack top = 'hello'.
    self assert: stack size = 1.! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:20:07'!
test08PopReturnsLastElementAndModifiesSizeAndTopElement
    | stack |
    stack := LimitedOOStack to: 10.
    stack push: 'first'.
    stack push: 'second'.
    self assert: stack pop = 'second'.
    self assert: stack size = 1.
    self assert: stack top = 'first'.! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:20:45'!
test09FillStackThenEmptyItAndFillItAgain
    | stack |
    stack := LimitedOOStack to: 2.
    stack push: 'first'.
    stack push: 'second'.
    self assert: stack isFull.
    stack pop.
    stack pop.
    self assert: stack isEmpty.
    stack push: 'third'.
    stack push: 'fourth'.
    self assert: stack isFull.! !

!LimitedOOStackTest methodsFor: 'testing' stamp: 'Martin 4/20/2026 22:21:12'!
test10PopInAFullStackMakesItNotFull
    | stack |
    stack := LimitedOOStack to: 2.
    stack push: 'first'.
    stack push: 'second'.
    self assert: stack isFull.
    stack pop.
    self deny: stack isFull.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LimitedOOStackTest class' category: #'Stack-Exercise'!
LimitedOOStackTest class
	instanceVariableNames: ''!

!LimitedOOStackTest class methodsFor: 'testing' stamp: 'Martin 4/20/2026 21:57:10'!
isAbstract

	^false.! !


!classDefinition: #UnlimitedOOStackTest category: #'Stack-Exercise'!
OOStackTest subclass: #UnlimitedOOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!UnlimitedOOStackTest methodsFor: 'setup' stamp: 'Martin 4/20/2026 21:56:30'!
createStack

	^UnlimitedOOStack new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnlimitedOOStackTest class' category: #'Stack-Exercise'!
UnlimitedOOStackTest class
	instanceVariableNames: ''!

!UnlimitedOOStackTest class methodsFor: 'testing' stamp: 'Martin 4/20/2026 21:56:53'!
isAbstract

	^false.! !
