!classDefinition: #I category: #'Numero Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numero Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:16:43 pm (UTC)'!
!methodProperties: {}!
* aNaturalNumber
	^ aNaturalNumber .! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:06:02 pm (UTC)'!
!methodProperties: {}!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:32:25 am (UTC)'!
!methodProperties: {}!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:57:55 am (UTC)'!
!methodProperties: {}!
nameOfNext
	^ 'II'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:05:32 pm (UTC)'!
!methodProperties: {}!
next
	^II.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:20:21 pm (UTC)'!
!methodProperties: {}!
previus
	Error signal: 'I no tiene previous.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:12:13 pm (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous.! !


!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:16:43 pm (UTC)'!
!methodProperties: {}!
* aNaturalNumber
	^ aNaturalNumber .! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:06:02 pm (UTC)'!
!methodProperties: {}!
+ anAdder
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 11:09:32 pm (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ Error signal: 'No soporta cero ni numeros negativos'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:32:25 am (UTC)'!
!methodProperties: {}!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!I class methodsFor: '-- all --' stamp: 'Martin 6/Apr/2026, 12:40:33 am (UTC)'!
!methodProperties: {}!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ self.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:57:55 am (UTC)'!
!methodProperties: {}!
nameOfNext
	^ 'II'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:05:32 pm (UTC)'!
!methodProperties: {}!
next
	^II.
	! !

!I class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 11:13:43 pm (UTC)'!
!methodProperties: {}!
previous
	Error signal: 'I no tiene previo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:20:21 pm (UTC)'!
!methodProperties: {}!
previus
	Error signal: 'I no tiene previous.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:12:13 pm (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous.! !

!I class methodsFor: '-- all --' stamp: 'Martin 6/Apr/2026, 12:39:13 am (UTC)'!
!methodProperties: {}!
timesDivideTo: aDividend
    ^ aDividend.! !


!classDefinition: #II category: #'Numero Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numero Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:13:35 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 1:00:28 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:54:07 pm (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:13:19 pm (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !


!II class methodsFor: 'operators' stamp: 'Martin 5/Apr/2026, 11:07:19 pm (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!II class methodsFor: 'operators' stamp: 'Martin 5/Apr/2026, 11:11:48 pm (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!II class methodsFor: 'operators' stamp: 'Martin 6/Apr/2026, 1:05:20 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !


!II class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 12:13:35 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!II class methodsFor: 'operators' stamp: 'Martin 5/Apr/2026, 11:07:19 pm (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!II class methodsFor: 'operators' stamp: 'Martin 5/Apr/2026, 11:11:48 pm (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!II class methodsFor: '-- all --' stamp: 'Martin 6/Apr/2026, 12:40:01 am (UTC)'!
!methodProperties: {}!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!II class methodsFor: '-- all --' stamp: 'Martin 6/Apr/2026, 12:40:41 am (UTC)'!
!methodProperties: {}!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ [(aDividend - aDivisor) / aDivisor + I
        ] on: Error do: [I].! !

!II class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 10:40:29 pm (UTC)'!
!methodProperties: {}!
initialize
	next := nil.
	previous := I.! !

!II class methodsFor: 'operators' stamp: 'Martin 6/Apr/2026, 1:05:20 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 6/Apr/2026, 1:00:28 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!II class methodsFor: '-- all --' stamp: 'Martin 5/Apr/2026, 10:40:45 pm (UTC)'!
!methodProperties: {}!
previous
	^previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 10:54:07 pm (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 5/Apr/2026, 11:13:19 pm (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !

!II class methodsFor: '-- all --' stamp: 'Martin 6/Apr/2026, 12:38:08 am (UTC)'!
!methodProperties: {}!
timesDivideTo: aDividend
    ^ [(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor: aDividend and: self] 
        on: Error 
        do: [self error: 'No se puede dividir'].! !


!classDefinition: #III category: #'Numero Naturales'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numero Naturales'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !


!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !


!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!III class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!III class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ [(aDividend - aDivisor) / aDivisor + I
        ] on: Error do: [I].! !

!III class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
initialize
	next := nil.
	previous := I.! !

!III class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!III class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous
	^previous ! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!III class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !

!III class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
timesDivideTo: aDividend
    ^ [(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor: aDividend and: self] 
        on: Error 
        do: [self error: 'No se puede dividir'].! !


!classDefinition: #IV category: #'Numero Naturales'!
DenotativeObject subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: #'Numero Naturales'!
IV class
	instanceVariableNames: 'next previous'!

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !


!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !


!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
+ anAdder
	^ self previous + anAdder next.! !

!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!IV class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!IV class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ [(aDividend - aDivisor) / aDivisor + I
        ] on: Error do: [I].! !

!IV class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
initialize
	next := nil.
	previous := I.! !

!IV class methodsFor: 'operators' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
nameOfNext
    (self name endsWith: 'DCCCC') ifTrue: [^ (self name withoutSuffix: 'DCCCC'), 'CM'].
    (self name endsWith: 'CCCC') ifTrue: [^ (self name withoutSuffix: 'CCCC'), 'CD'].
    (self name endsWith: 'LXXXX') ifTrue: [^ (self name withoutSuffix: 'LXXXX'), 'XC'].
    (self name endsWith: 'XXXX') ifTrue: [^ (self name withoutSuffix: 'XXXX'), 'XL'].
    (self name endsWith: 'VIIII') ifTrue: [^ (self name withoutSuffix: 'VIIII'), 'IX'].
    (self name endsWith: 'IIII') ifTrue: [^ (self name withoutSuffix: 'IIII'), 'V'].
    (self name endsWith: 'III') ifTrue: [^ (self name withoutSuffix: 'III'), 'IV'].
    (self name endsWith: 'IX') ifTrue: [^ (self name withoutSuffix: 'IX'), 'X'].
    (self name endsWith: 'IV') ifTrue: [^ (self name withoutSuffix: 'IV'), 'V'].
    (self name endsWith: 'XC') ifTrue: [^ (self name withoutSuffix: 'XC'), 'C'].
    (self name endsWith: 'XL') ifTrue: [^ (self name withoutSuffix: 'XL'), 'L'].
    (self name endsWith: 'CD') ifTrue: [^ (self name withoutSuffix: 'CD'), 'D'].
    (self name endsWith: 'CM') ifTrue: [^ (self name withoutSuffix: 'CM'), 'M'].
    ^ self name, 'I'.! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!IV class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous
	^previous ! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!IV class methodsFor: 'as yet unclassified' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !

!IV class methodsFor: '-- all --' stamp: 'HAW 12/Aug/2026, 1:21:34 am (UTC)'!
!methodProperties: {}!
timesDivideTo: aDividend
    ^ [(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor: aDividend and: self] 
        on: Error 
        do: [self error: 'No se puede dividir'].! !


!classDefinition: #NumeroNaturalesTests category: #'Numero Naturales'!
DenotativeObject subclass: #NumeroNaturalesTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumeroNaturalesTests class' category: #'Numero Naturales'!
NumeroNaturalesTests class
	instanceVariableNames: ''!

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:15:45 am (UTC)'!
!methodProperties: {}!
test01UnoMasUnoEsDos

	Assert that: (I + I) isEqualTo: II.! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:24:38 am (UTC)'!
!methodProperties: {}!
test02RestaQueDaCeroONegativoEsError

    Assert should: [ I - I ] 
           signal: Error 
           withDescription: 'No soporta cero ni numeros negativos'.! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:20:42 am (UTC)'!
!methodProperties: {}!
test03UnoPorUnoEsUno

	Assert that: (I * I) isEqualTo: I.! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:22:35 am (UTC)'!
!methodProperties: {}!
test04CualquierNumeroPorUnoEsCualquierNumero
	|cuatro|
	cuatro := II + II.
	Assert that: (cuatro * I) isEqualTo: cuatro .! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:23:32 am (UTC)'!
!methodProperties: {}!
test05NumeroDivididoPorSiMismoEsUno

	Assert that: (II / II) isEqualTo: I! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:23:59 am (UTC)'!
!methodProperties: {}!
test06UnoDivididoUnoEsUno

	Assert that: (I  / I) isEqualTo: I.! !

!NumeroNaturalesTests class methodsFor: 'testing' stamp: 'HAW 12/Aug/2026, 1:30:08 am (UTC)'!
!methodProperties: {}!
test07NumeradorMenorQueDenominadorDaUno

	Assert should: [ I / II ] 
	       signal: Error 
	       withDescription: 'No se puede dividir'! !

II initialize!
III initialize!
IV initialize!