!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 10:52:16'!
* aMultiplier 
	
	self subclassResponsibility .
	"	(type = #Entero and: [aMultiplier type = #Entero]) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	(type = #Fraccion and: [aMultiplier type = #Fraccion]) ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'
	"! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:37:12'!
+ anAdder 
	self subclassResponsibility .
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 10:52:51'!
// aDivisor 
	self subclassResponsibility .
	"
	type = #Entero ifTrue:
		[ ^self class with: value // aDivisor integerValue ].
		
	self error: 'Tipo de número no soportado'"! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:37:16'!
greatestCommonDivisorWith: anEntero 
	self subclassResponsibility .
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:37:20'!
negated
	self subclassResponsibility .
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:37:27'!
printOn: aStream
	
	self subclassResponsibility .
! !


!Numero methodsFor: 'testing' stamp: 'Martin 4/11/2026 11:27:06'!
isNegative
	
	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'Martin 4/11/2026 11:27:12'!
isOne
	
	self subclassResponsibility .
	! !

!Numero methodsFor: 'testing' stamp: 'Martin 4/11/2026 11:27:25'!
isZero

	self subclassResponsibility.! !




!Numero methodsFor: 'comparing' stamp: 'Martin 4/11/2026 11:37:45'!
= anObject
	
	self subclassResponsibility 
! !

!Numero methodsFor: 'comparing' stamp: 'Martin 4/11/2026 11:37:40'!
hash

	self subclassResponsibility 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'Martin 4/11/2026 11:36:51'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !



!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'testing' stamp: 'Martin 4/11/2026 10:41:19'!
isNegative

	^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'Martin 4/11/2026 10:41:05'!
isOne

	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'Martin 4/11/2026 10:40:55'!
isZero

	^value = 0.! !


!Entero methodsFor: 'accessing' stamp: 'Martin 4/11/2026 10:44:51'!
integerValue

	^value .! !


!Entero methodsFor: 'comparing' stamp: 'Martin 4/11/2026 10:50:02'!
= anObject

	^(anObject isKindOf: self class) and: [anObject integerValue = value ].! !

!Entero methodsFor: 'comparing' stamp: 'Martin 4/11/2026 10:49:12'!
hash

	^value hash.! !


!Entero methodsFor: 'initialization' stamp: 'Martin 4/11/2026 10:51:26'!
initializeWith: aValue

	value := aValue .! !


!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:06:59'!
* aMultiplier 

	^self class with: (aMultiplier integerValue * value).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:04:49'!
+ anAdder 

	^self class with: (anAdder integerValue + value).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:57:11'!
// aDivisor 

	^self class with: (value // aDivisor integerValue) .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:55:53'!
greatestCommonDivisorWith: anEntero 

	^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:10:40'!
negated

	^self * (self class with: -1).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:11:06'!
printOn: aStream

	^aStream print: value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'Martin 4/11/2026 10:59:54'!
with: aValue

	aValue isInteger ifFalse: [self error: 'aValue debe ser anIntger'].
	
	^self new initializeWith: aValue .

! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'denominator numerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'Martin 4/11/2026 11:48:24'!
isNegative

	^denominator  < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'Martin 4/11/2026 10:41:48'!
isOne

	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'Martin 4/11/2026 10:41:41'!
isZero

	^false.! !


!Fraccion methodsFor: 'accessing' stamp: 'Martin 4/11/2026 10:43:01'!
denominator

	^denominator .! !

!Fraccion methodsFor: 'accessing' stamp: 'Martin 4/11/2026 10:43:07'!
numerator 

	^numerator .! !


!Fraccion methodsFor: 'initialization' stamp: 'Martin 4/11/2026 11:11:47'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:16:01'!
* aMultiplier

	^self class with: (aMultiplier numerator * numerator ) over: (aMultiplier denominator * denominator ). ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:45:21'!
+ anAdder

	^self class with: ((numerator * anAdder denominator ) + (anAdder numerator * denominator ))  over: (anAdder denominator * denominator ).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:17:12'!
// aDivisor 


	^ self class with: (numerator * aDivisor denominator ) over: (denominator * aDivisor numerator ).
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:17:54'!
greatestCommonDivisorWith: anEntero 

	self error: 'Tipo de número no soportado'.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:20:45'!
negated

	^self class with: numerator * (Entero with: -1) over: denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Martin 4/11/2026 11:21:30'!
printOn: aStream

	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator! !


!Fraccion methodsFor: 'comparing' stamp: 'Martin 4/11/2026 12:02:09'!
= anObject


	^(anObject isKindOf: self class ) and: [(numerator * anObject denominator) = (denominator * anObject numerator)]! !

!Fraccion methodsFor: 'comparing' stamp: 'Martin 4/11/2026 11:29:37'!
hash

	^(numerator hash / denominator hash) hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'Martin 4/11/2026 11:25:34'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !



!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'Martin 4/11/2026 11:39:56'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'Martin 4/11/2026 11:39:37'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'Martin 4/11/2026 11:38:49'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'Martin 4/11/2026 11:39:21'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'Martin 4/11/2026 11:34:30'!
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
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !
