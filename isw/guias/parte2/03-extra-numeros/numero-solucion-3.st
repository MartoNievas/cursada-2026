!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 8/May/2016, 1:48:00 am (UTC)'!
!methodProperties: {}!
* aMultiplier

  self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 8/May/2016, 1:49:00 am (UTC)'!
!methodProperties: {}!
+ anAdder

  self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 24/Sep/2018, 1:21:28 am (UTC)'!
!methodProperties: {}!
- aSubtrahend

  self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 8/May/2016, 1:49:00 am (UTC)'!
!methodProperties: {}!
/ aDivisor

  self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 24/Sep/2018, 2:37:13 am (UTC)'!
!methodProperties: {}!
negated
  
  ^self * (Entero with: -1)! !


!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:09 pm (UTC)'!
!methodProperties: {}!
addFraction: aFraccionAdder

	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:00 pm (UTC)'!
!methodProperties: {}!
addInteger: anEnteroAdder

	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:53 pm (UTC)'!
!methodProperties: {}!
divideFromFraction: aFraccionDividend
	
	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:42 pm (UTC)'!
!methodProperties: {}!
divideFromInteger: anEnteroDividend

	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:57 pm (UTC)'!
!methodProperties: {}!
multiplyFraction: aFraccionMultiplier

	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:47 pm (UTC)'!
!methodProperties: {}!
multiplyInteger: anEnteroMultiplier

	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:14 pm (UTC)'!
!methodProperties: {}!
subtractFromFraction: aFraccionMinuend

	self subclassResponsibility .! !

!Numero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:07 pm (UTC)'!
!methodProperties: {}!
subtractFromInteger: anEnteroMinuend

	self subclassResponsibility .! !


!Numero methodsFor: 'testing' stamp: 'NR 24/Sep/2018, 2:36:49 am (UTC)'!
!methodProperties: {}!
isNegative

  self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 8/May/2016, 1:49:00 am (UTC)'!
!methodProperties: {}!
isOne

  self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 8/May/2016, 1:49:00 am (UTC)'!
!methodProperties: {}!
isZero

  self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 15/Apr/2021, 7:42:02 pm (UTC)'!
!methodProperties: {}!
canNotDivideByZeroErrorDescription

  ^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:53:47 pm (UTC)'!
!methodProperties: {}!
* aMultiplier 
  ^ aMultiplier multiplyInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:52:00 pm (UTC)'!
!methodProperties: {}!
+ anAdder 
  ^ anAdder addInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:54:07 pm (UTC)'!
!methodProperties: {}!
- aSubtrahend 
  ^ aSubtrahend subtractFromInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:52:42 pm (UTC)'!
!methodProperties: {}!
/ aDivisor 

  ^ aDivisor divideFromInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
// aDivisor 
	
	^ aDivisor integerDivide: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 7:42:09 pm (UTC)'!
!methodProperties: {}!
fibonacci

	self subclassResponsibility .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 8/May/2016, 12:00:00 am (UTC)'!
!methodProperties: {}!
greatestCommonDivisorWith: anEntero 
  
  ^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 8/May/2016, 12:01:00 am (UTC)'!
!methodProperties: {}!
= anObject

  ^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 7/May/2016, 11:17:00 pm (UTC)'!
!methodProperties: {}!
hash

  ^value hash! !


!Entero methodsFor: 'initialization' stamp: 'MA 30/Aug/2026, 8:38:42 pm (UTC)'!
!methodProperties: {}!
initializeWith: aValue 
  
  value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 8/May/2016, 12:02:00 am (UTC)'!
!methodProperties: {}!
integerValue

  "Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
  
  ^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 24/Sep/2018, 11:53:19 am (UTC)'!
!methodProperties: {}!
printOn: aStream

  aStream print: value ! !


!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:09 pm (UTC)'!
!methodProperties: {}!
addFraction: aFraccionAdder

	^ aFraccionAdder addInteger: self! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:00 pm (UTC)'!
!methodProperties: {}!
addInteger: anEnteroAdder
	
	^ self class with: value + anEnteroAdder integerValue! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:32:13 pm (UTC)'!
!methodProperties: {}!
beDenominatorOf: anEnteroDividend

	self subclassResponsibility .! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:53 pm (UTC)'!
!methodProperties: {}!
divideFromFraction: aFraccionDividend

	  | newDenominator |
	  newDenominator := self * aFraccionDividend denominator.
	  ^ aFraccionDividend numerator / newDenominator! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:42 pm (UTC)'!
!methodProperties: {}!
divideFromInteger: anEnteroDividend

	^ Fraccion with: anEnteroDividend over: self! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
integerDivide: aDividend

	self subclassResponsibility .! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:57 pm (UTC)'!
!methodProperties: {}!
multiplyFraction: aFraccionMultiplier
  ^ aFraccionMultiplier multiplyInteger: self! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:47 pm (UTC)'!
!methodProperties: {}!
multiplyInteger: anEnteroMultiplier

  ^ self class with: value * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:14 pm (UTC)'!
!methodProperties: {}!
subtractFromFraction: aFraccionMinuend
  | newNumerator |
  newNumerator := aFraccionMinuend numerator - (self * aFraccionMinuend denominator).
  ^ newNumerator / aFraccionMinuend denominator! !

!Entero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:07 pm (UTC)'!
!methodProperties: {}!
subtractFromInteger: anEnteroMinuend

	^ self class with: anEnteroMinuend integerValue - value! !


!Entero methodsFor: 'testing' stamp: 'NR 24/Sep/2018, 1:17:55 am (UTC)'!
!methodProperties: {}!
isNegative
  
  ^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 7/May/2016, 11:14:00 pm (UTC)'!
!methodProperties: {}!
isOne
  
  ^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 7/May/2016, 11:12:00 pm (UTC)'!
!methodProperties: {}!
isZero
  
  ^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 15/Apr/2021, 7:42:24 pm (UTC)'!
!methodProperties: {}!
negativeFibonacciErrorDescription
  ^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'MA 30/Aug/2026, 8:38:42 pm (UTC)'!
!methodProperties: {}!
with: aValue 
  
  "Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
  aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
  

	(aValue = 0) ifTrue: [^ Cero new initializeWith: aValue ].
	(aValue = 1) ifTrue: [^ Uno new initializeWith: aValue ].
	(aValue  < 0) ifTrue: [^ EnteroNegativo new initializeWith: aValue ].
	^ EnteroPositivoMayorAUno new initializeWith: aValue .! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:43:56 pm (UTC)'!
!methodProperties: {}!
beDenominatorOf: anEnteroDividend

	self error: Entero canNotDivideByZeroErrorDescription .! !

!Cero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:53 pm (UTC)'!
!methodProperties: {}!
divideFromFraction: aFractionDividend
	
	^ self error: Entero canNotDivideByZeroErrorDescription.
	! !

!Cero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:42 pm (UTC)'!
!methodProperties: {}!
divideFromInteger: anEnteroDividend 

	^self error: Entero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
integerDivide: aDividend

	self error: Entero canNotDivideByZeroErrorDescription! !


!Cero methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 7:40:19 pm (UTC)'!
!methodProperties: {}!
fibonacci

	^ Entero with: 1.! !


!classDefinition: #EnteroNegativo category: #'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:43:12 pm (UTC)'!
!methodProperties: {}!
beDenominatorOf: anEnteroDividend

	^ Fraccion with: anEnteroDividend negated over: self negated .! !

!EnteroNegativo methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
integerDivide: aDividend

	^ Entero with: aDividend integerValue // value.! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 7:41:04 pm (UTC)'!
!methodProperties: {}!
fibonacci
	
	self error: Entero negativeFibonacciErrorDescription. ! !


!classDefinition: #EnteroPositivoMayorAUno category: #'Numero-Exercise'!
Entero subclass: #EnteroPositivoMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivoMayorAUno methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 7:45:29 pm (UTC)'!
!methodProperties: {}!
fibonacci

	| one two |
	  
	one := Entero with: 1.
	two := Entero with: 2.

	^ (self - one) fibonacci + (self - two) fibonacci

		 ! !


!EnteroPositivoMayorAUno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:42:45 pm (UTC)'!
!methodProperties: {}!
beDenominatorOf: anEnteroDividend

	| greatestCommonDivisor numerator denominator |
  
	  greatestCommonDivisor := anEnteroDividend greatestCommonDivisorWith: self. 
	  numerator := anEnteroDividend // greatestCommonDivisor.
	  denominator := self // greatestCommonDivisor.
	  

	  ^denominator createFractionWithNumerator: numerator .! !

!EnteroPositivoMayorAUno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:37:07 pm (UTC)'!
!methodProperties: {}!
createFractionWithNumerator: aNumerator

	^ Fraccion new initializeWith: aNumerator over: self.! !

!EnteroPositivoMayorAUno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
integerDivide: aDividend

	^Entero with: aDividend integerValue // value. ! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:42:35 pm (UTC)'!
!methodProperties: {}!
beDenominatorOf: anEnteroDividend

	^ anEnteroDividend .! !

!Uno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:36:50 pm (UTC)'!
!methodProperties: {}!
createFractionWithNumerator: aNumerator

	^ aNumerator .! !

!Uno methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:47:05 pm (UTC)'!
!methodProperties: {}!
integerDivide: aDividend

	^ aDividend .! !


!Uno methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 7:41:27 pm (UTC)'!
!methodProperties: {}!
fibonacci

	^ Entero with: 1.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:53:57 pm (UTC)'!
!methodProperties: {}!
* aMultiplier 
  ^ aMultiplier multiplyFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:52:09 pm (UTC)'!
!methodProperties: {}!
+ anAdder 
  ^ anAdder addFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:54:14 pm (UTC)'!
!methodProperties: {}!
- aSubtrahend 
  ^ aSubtrahend subtractFromFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MA 30/Aug/2026, 8:52:53 pm (UTC)'!
!methodProperties: {}!
/ aDivisor 
  ^ aDivisor divideFromFraction: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 7/May/2016, 11:42:00 pm (UTC)'!
!methodProperties: {}!
= anObject

  ^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 7/May/2016, 11:50:00 pm (UTC)'!
!methodProperties: {}!
hash

  ^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 8/May/2016, 12:56:00 am (UTC)'!
!methodProperties: {}!
denominator

  ^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 8/May/2016, 12:56:00 am (UTC)'!
!methodProperties: {}!
numerator

  ^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 8/May/2016, 1:54:00 am (UTC)'!
!methodProperties: {}!
initializeWith: aNumerator over: aDenominator

  "Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
  aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
  aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
  
  numerator := aNumerator.
  denominator := aDenominator! !


!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:09 pm (UTC)'!
!methodProperties: {}!
addFraction: aFraccionAdder

	  | newNumerator newDenominator |
	  newNumerator := (numerator * aFraccionAdder denominator) + (aFraccionAdder numerator * denominator).
	  newDenominator := denominator * aFraccionAdder denominator.
	  ^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:00 pm (UTC)'!
!methodProperties: {}!
addInteger: anEnteroAdder

	  | newNumerator |
	  newNumerator := numerator + (anEnteroAdder * denominator).
	  ^ newNumerator / denominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:53 pm (UTC)'!
!methodProperties: {}!
divideFromFraction: aFraccionDividend

	  | newNumerator newDenominator |
	  newNumerator := aFraccionDividend numerator * denominator.
	  newDenominator := aFraccionDividend denominator * numerator.
	  ^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:52:42 pm (UTC)'!
!methodProperties: {}!
divideFromInteger: anEnteroDividend

	  | newNumerator |
	  newNumerator := anEnteroDividend * denominator.
	  ^ newNumerator / numerator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:57 pm (UTC)'!
!methodProperties: {}!
multiplyFraction: aFraccionMultiplier

	  | newNumerator newDenominator |
	  newNumerator := numerator * aFraccionMultiplier numerator.
	  newDenominator := denominator * aFraccionMultiplier denominator.
	  ^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:53:47 pm (UTC)'!
!methodProperties: {}!
multiplyInteger: anEnteroMultiplier

	  ^ (numerator * anEnteroMultiplier) / denominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:14 pm (UTC)'!
!methodProperties: {}!
subtractFromFraction: aFraccionMinuend

	| newNumerator newDenominator |
	newNumerator := (aFraccionMinuend numerator * denominator) - (numerator * aFraccionMinuend denominator).
	newDenominator := aFraccionMinuend denominator * denominator.
	^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'private' stamp: 'MA 30/Aug/2026, 8:54:07 pm (UTC)'!
!methodProperties: {}!
subtractFromInteger: anEnteroMinuend

	  | newNumerator |
	  newNumerator := (anEnteroMinuend * denominator) - numerator.
	  ^ newNumerator / denominator! !


!Fraccion methodsFor: 'testing' stamp: 'MA 30/Aug/2026, 4:00:00 am (UTC)'!
!methodProperties: {}!
isNegative
  ^numerator isNegative! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 8/May/2016, 1:51:00 am (UTC)'!
!methodProperties: {}!
isOne

  ^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 8/May/2016, 1:51:00 am (UTC)'!
!methodProperties: {}!
isZero

  ^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 24/Sep/2018, 11:54:46 am (UTC)'!
!methodProperties: {}!
printOn: aStream

  aStream 
    print: numerator;
    nextPut: $/;
    print: denominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'MA 30/Aug/2026, 8:37:56 pm (UTC)'!
!methodProperties: {}!
with: aDividend over: aDivisor

	^ aDivisor beDenominatorOf: aDividend .! !


!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:11:00 pm (UTC)'!
!methodProperties: {}!
test01isCeroReturnsTrueWhenAskToZero

  self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:12:00 pm (UTC)'!
!methodProperties: {}!
test02isCeroReturnsFalseWhenAskToOthersButZero

  self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:13:00 pm (UTC)'!
!methodProperties: {}!
test03isOneReturnsTrueWhenAskToOne

  self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:13:00 pm (UTC)'!
!methodProperties: {}!
test04isOneReturnsFalseWhenAskToOtherThanOne

  self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:14:00 pm (UTC)'!
!methodProperties: {}!
test05EnteroAddsWithEnteroCorrectly

  self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:18:00 pm (UTC)'!
!methodProperties: {}!
test06EnteroMultipliesWithEnteroCorrectly

  self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:20:00 pm (UTC)'!
!methodProperties: {}!
test07EnteroDividesEnteroCorrectly

  self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:38:00 pm (UTC)'!
!methodProperties: {}!
test08FraccionAddsWithFraccionCorrectly
"
  La suma de fracciones es:
   
  a/b + c/d = (a.d + c.b) / (b.d)
   
  SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
  TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
  | sevenTenths |

  sevenTenths := (Entero with: 7) / (Entero with: 10).

  self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:52:00 pm (UTC)'!
!methodProperties: {}!
test09FraccionMultipliesWithFraccionCorrectly
"
  La multiplicacion de fracciones es:
   
  (a/b) * (c/d) = (a.c) / (b.d)
"

  self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/May/2016, 11:56:00 pm (UTC)'!
!methodProperties: {}!
test10FraccionDividesFraccionCorrectly
"
  La division de fracciones es:
   
  (a/b) / (c/d) = (a.d) / (b.c)
"

  self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:07:00 am (UTC)'!
!methodProperties: {}!
test11EnteroAddsFraccionCorrectly
"
  Ahora empieza la diversion!!
"

  self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:07:00 am (UTC)'!
!methodProperties: {}!
test12FraccionAddsEnteroCorrectly

  self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:50:00 am (UTC)'!
!methodProperties: {}!
test13EnteroMultipliesFraccionCorrectly

  self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:52:00 am (UTC)'!
!methodProperties: {}!
test14FraccionMultipliesEnteroCorrectly

  self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:57:00 am (UTC)'!
!methodProperties: {}!
test15EnteroDividesFraccionCorrectly

  self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 12:59:00 am (UTC)'!
!methodProperties: {}!
test16FraccionDividesEnteroCorrectly

  self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:38:00 am (UTC)'!
!methodProperties: {}!
test17AFraccionCanBeEqualToAnEntero

  self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:39:00 am (UTC)'!
!methodProperties: {}!
test18AparentFraccionesAreEqual

  self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:40:00 am (UTC)'!
!methodProperties: {}!
test19AddingFraccionesCanReturnAnEntero

  self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:42:00 am (UTC)'!
!methodProperties: {}!
test20MultiplyingFraccionesCanReturnAnEntero

  self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:42:00 am (UTC)'!
!methodProperties: {}!
test21DividingFraccionesCanReturnAnEntero

  self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:43:00 am (UTC)'!
!methodProperties: {}!
test22DividingEnterosCanReturnAFraccion

  self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:46:00 am (UTC)'!
!methodProperties: {}!
test23CanNotDivideEnteroByZero

  self 
    should: [ one / zero ]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:46:00 am (UTC)'!
!methodProperties: {}!
test24CanNotDivideFraccionByZero

  self 
    should: [ oneHalf / zero ]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:50:00 am (UTC)'!
!methodProperties: {}!
test25AFraccionCanNotBeZero

  self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 8/May/2016, 1:50:00 am (UTC)'!
!methodProperties: {}!
test26AFraccionCanNotBeOne

  self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 15/Apr/2021, 7:45:35 pm (UTC)'!
!methodProperties: {}!
test27EnteroSubstractsEnteroCorrectly

  self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:47:41 am (UTC)'!
!methodProperties: {}!
test28FraccionSubstractsFraccionCorrectly
  
  self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:48:00 am (UTC)'!
!methodProperties: {}!
test29EnteroSubstractsFraccionCorrectly

  self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 24/Sep/2018, 11:48:05 am (UTC)'!
!methodProperties: {}!
test30FraccionSubstractsEnteroCorrectly

  | sixFifth |
  
  sixFifth := (Entero with: 6) / (Entero with: 5).
  
  self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 24/Sep/2018, 11:48:08 am (UTC)'!
!methodProperties: {}!
test31SubstractingFraccionesCanReturnAnEntero

  | threeHalfs |
  
  threeHalfs := (Entero with: 3) / (Entero with: 2).
  
  self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:48:48 am (UTC)'!
!methodProperties: {}!
test32SubstractingSameEnterosReturnsZero

  self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:01 am (UTC)'!
!methodProperties: {}!
test33SubstractingSameFraccionesReturnsZero

  self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 24/Sep/2018, 11:48:14 am (UTC)'!
!methodProperties: {}!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

  | negativeThreeHalfs |
  
  negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

  self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:23 am (UTC)'!
!methodProperties: {}!
test35FibonacciZeroIsOne

  self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:32 am (UTC)'!
!methodProperties: {}!
test36FibonacciOneIsOne

  self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:39 am (UTC)'!
!methodProperties: {}!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

  self assert: four fibonacci equals: five.
  self assert: three fibonacci equals: three. 
  self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:47 am (UTC)'!
!methodProperties: {}!
test38FibonacciNotDefinedForNegativeNumbers

  self 
    should: [negativeOne fibonacci]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:49:55 am (UTC)'!
!methodProperties: {}!
test39NegationOfEnteroIsCorrect

  self assert: two negated equals: negativeTwo.
    ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:50:03 am (UTC)'!
!methodProperties: {}!
test40NegationOfFraccionIsCorrect

  self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:50:11 am (UTC)'!
!methodProperties: {}!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

  self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 24/Sep/2018, 2:50:17 am (UTC)'!
!methodProperties: {}!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

  self assert: oneHalf negated equals: (one / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'MA 30/Aug/2026, 8:25:46 pm (UTC)'!
!methodProperties: {}!
testFraccionConDenominadorNegativoSeNormalizaCorrectamente
    | fraccionEsperada fraccionObtenida |
    
    fraccionEsperada := (Entero with: -1) / (Entero with: 2).
    fraccionObtenida := (Entero with: 1) / (Entero with: -2).
    
    self assert: fraccionObtenida equals: fraccionEsperada.
    self assert: fraccionObtenida numerator equals: (Entero with: -1).
    self assert: fraccionObtenida denominator equals: (Entero with: 2).! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 24/Sep/2018, 2:46:28 am (UTC)'!
!methodProperties: {}!
setUp

  zero := Entero with: 0.
  one := Entero with: 1.
  two := Entero with: 2.
  three:= Entero with: 3.
  four := Entero with: 4.
  five := Entero with: 5.
  eight := Entero with: 8.
  negativeOne := Entero with: -1.
  negativeTwo := Entero with: -2.
  
  oneHalf := one / two.
  oneFifth := one / five.
  twoFifth := two / five.
  twoTwentyfifth := two / (Entero with: 25).
  fiveHalfs := five / two.! !
