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

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:16:43'!
* aNaturalNumber
	^ aNaturalNumber .! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:06:02'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:32:25'!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:57:55'!
nameOfNext
	^ 'II'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:05:32'!
next
	^II.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:20:21'!
previus
	Error signal: 'I no tiene previous.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:12:13'!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous.! !


!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:16:43'!
* aNaturalNumber
	^ aNaturalNumber .! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:06:02'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 20:09:32'!
- aNaturalNumber
	^ Error signal: 'No soporta cero ni numeros negativos'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:32:25'!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!I class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 21:40:33'!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ self.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:57:55'!
nameOfNext
	^ 'II'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:05:32'!
next
	^II.
	! !

!I class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 20:13:43'!
previous
	Error signal: 'I no tiene previo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:20:21'!
previus
	Error signal: 'I no tiene previous.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:12:13'!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous.! !

!I class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 21:39:13'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:13:35'!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 22:00:28'!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:54:07'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:13:19'!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !


!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 21:13:35'!
* aNaturalNumber

	^ (self previous * aNaturalNumber ) + aNaturalNumber .! !

!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 20:07:19'!
+ anAdder
	^ self previous + anAdder next.! !

!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 20:11:48'!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!II class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 21:40:01'!
/ aDivisor
    ^ aDivisor timesDivideTo: self.! !

!II class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 21:40:41'!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
    ^ [(aDividend - aDivisor) / aDivisor + I
        ] on: Error do: [I].! !

!II class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:40:29'!
initialize
	next := nil.
	previous := I.! !

!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 22:05:20'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 22:00:28'!
next
    next ifNil: [
        next := self cloneNamed: self nameOfNext .
        next previous: self.		
    ].
    ^ next.! !

!II class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 19:40:45'!
previous
	^previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 19:54:07'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Martin 4/5/2026 20:13:19'!
subtractFrom: aNaturalNumber
	^ aNaturalNumber previous - self previous .! !

!II class methodsFor: '-- all --' stamp: 'Martin 4/5/2026 21:38:08'!
timesDivideTo: aDividend
    ^ [(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor: aDividend and: self] 
        on: Error 
        do: [self error: 'No se puede dividir'].! !


!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 20:07:19'!
+ anAdder
	^ self previous + anAdder next.! !

!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 20:11:48'!
- aNaturalNumber
	^ aNaturalNumber subtractFrom: self! !

!II class methodsFor: 'operators' stamp: 'Martin 4/5/2026 22:05:20'!
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

II initialize!