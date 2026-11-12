!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalog validBook anotherValidBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'running' stamp: 'ISW 5/Nov/2026, 1:00:00 pm (UTC)'!
setUp

	validBook := '978-0132350884'.
	anotherValidBook := '978-0201633610'.

	catalog := Dictionary new.
	catalog at: validBook put: 50.
	catalog at: anotherValidBook put: 100.! !


!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:01:00 pm (UTC)'!
test01NewCartIsEmpty

	| cart |
	cart := Cart acceptingItemsOf: catalog.

	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:02:00 pm (UTC)'!
test02AddingAnItemMakesCartNotEmpty

	| cart |
	cart := Cart acceptingItemsOf: catalog.
	cart add: validBook.

	self deny: cart isEmpty.
	self assert: (cart includes: validBook).
	self assert: (cart occurrencesOf: validBook) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:03:00 pm (UTC)'!
test03CanAddMultipleCopiesOfAnItem

	| cart |
	cart := Cart acceptingItemsOf: catalog.
	cart add: 3 of: validBook.

	self assert: (cart occurrencesOf: validBook) equals: 3.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:04:00 pm (UTC)'!
test04CannotAddAnItemNotInCatalog

	| cart |
	cart := Cart acceptingItemsOf: catalog.

	self
		should: [ cart add: 'invalid-isbn' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidItemErrorMessage.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:05:00 pm (UTC)'!
test05CannotAddNonPositiveQuantityOfAnItem

	| cart |
	cart := Cart acceptingItemsOf: catalog.

	self
		should: [ cart add: 0 of: validBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidQuantityErrorMessage.
			self assert: cart isEmpty.
		].

	self
		should: [ cart add: -1 of: validBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidQuantityErrorMessage.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:06:00 pm (UTC)'!
test06CartCalculatesTotalCorrectly

	| cart |
	cart := Cart acceptingItemsOf: catalog.
	cart add: 2 of: validBook.
	cart add: 1 of: anotherValidBook.

	self assert: cart total equals: 200.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'catalog validBook cart creditCard debitCalled debitAmount chargedCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'running' stamp: 'ISW 5/Nov/2026, 1:10:00 pm (UTC)'!
setUp

	validBook := '978-0132350884'.
	catalog := Dictionary new.
	catalog at: validBook put: 50.

	cart := Cart acceptingItemsOf: catalog.

	creditCard := CreditCard expiringOn: (Month month: 11 year: 2026).
	salesBook := OrderedCollection new.
	debitCalled := false.! !


!CashierTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:11:00 pm (UTC)'!
test01CannotCheckoutAnEmptyCart

	| cashier merchantProcessor today |
	today := DateAndTime year: 2026 month: 11 day: 5.
	merchantProcessor := self.

	cashier := Cashier
		toCheckout: cart
		charging: creditCard
		throught: merchantProcessor
		on: today
		registeringOn: salesBook.

	self
		should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty.
			self deny: debitCalled.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:12:00 pm (UTC)'!
test02CannotCheckoutWithAnExpiredCreditCard

	| cashier expiredCard merchantProcessor today |
	today := DateAndTime year: 2026 month: 11 day: 5.
	expiredCard := CreditCard expiringOn: (Month month: 10 year: 2026).
	merchantProcessor := self.

	cart add: validBook.

	cashier := Cashier
		toCheckout: cart
		charging: expiredCard
		throught: merchantProcessor
		on: today
		registeringOn: salesBook.

	self
		should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty.
			self deny: debitCalled.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:13:00 pm (UTC)'!
test03CreditCardIsValidDuringItsExpirationMonth

	| cashier cardExpiringThisMonth merchantProcessor today total |
	today := DateAndTime year: 2026 month: 11 day: 30 hour: 23 minute: 59 second: 59.
	cardExpiringThisMonth := CreditCard expiringOn: (Month month: 11 year: 2026).
	merchantProcessor := self.

	cart add: 2 of: validBook.

	cashier := Cashier
		toCheckout: cart
		charging: cardExpiringThisMonth
		throught: merchantProcessor
		on: today
		registeringOn: salesBook.

	total := cashier checkOut.

	self assert: total equals: 100.
	self assert: debitCalled.
	self assert: debitAmount equals: 100.
	self assert: chargedCard equals: cardExpiringThisMonth.
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: 100.! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 5/Nov/2026, 1:14:00 pm (UTC)'!
test04CheckOutFailsIfMerchantProcessorFails

	| cashier failingProcessor today |
	today := DateAndTime year: 2026 month: 11 day: 5.
	failingProcessor := MockFailingMerchantProcessor new.

	cart add: validBook.

	cashier := Cashier
		toCheckout: cart
		charging: creditCard
		throught: failingProcessor
		on: today
		registeringOn: salesBook.

	self
		should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: MerchantProcessor creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty.
		].! !


!CashierTest methodsFor: 'support' stamp: 'ISW 5/Nov/2026, 1:15:00 pm (UTC)'!
debit: anAmount from: aCreditCard

	debitCalled := true.
	debitAmount := anAmount.
	chargedCard := aCreditCard.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'ISW 5/Nov/2026, 1:20:00 pm (UTC)'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'ISW 5/Nov/2026, 1:21:00 pm (UTC)'!
add: anItem

	self add: 1 of: anItem.! !

!Cart methodsFor: 'adding' stamp: 'ISW 5/Nov/2026, 1:22:00 pm (UTC)'!
add: aQuantity of: anItem

	self assertCanAdd: aQuantity of: anItem.
	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'queries' stamp: 'ISW 5/Nov/2026, 1:23:00 pm (UTC)'!
includes: anItem

	^ items includes: anItem.! !

!Cart methodsFor: 'queries' stamp: 'ISW 5/Nov/2026, 1:24:00 pm (UTC)'!
isEmpty

	^ items isEmpty.! !

!Cart methodsFor: 'queries' stamp: 'ISW 5/Nov/2026, 1:25:00 pm (UTC)'!
occurrencesOf: anItem

	^ items occurrencesOf: anItem.! !

!Cart methodsFor: 'queries' stamp: 'ISW 5/Nov/2026, 1:26:00 pm (UTC)'!
total

	^ items sum: [ :anItem | catalog at: anItem ] ifEmpty: [ 0 ].! !


!Cart methodsFor: 'assertions' stamp: 'ISW 5/Nov/2026, 1:27:00 pm (UTC)'!
assertCanAdd: aQuantity of: anItem

	(aQuantity strictlyPositive) ifFalse: [ self error: self invalidQuantityErrorMessage ].
	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ].! !


!Cart methodsFor: 'error messages' stamp: 'ISW 5/Nov/2026, 1:28:00 pm (UTC)'!
invalidItemErrorMessage

	^ 'Item is not accepted in this cart catalog'.! !

!Cart methodsFor: 'error messages' stamp: 'ISW 5/Nov/2026, 1:29:00 pm (UTC)'!
invalidQuantityErrorMessage

	^ 'Item quantity must be strictly positive'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ISW 5/Nov/2026, 1:30:00 pm (UTC)'!
acceptingItemsOf: aCatalog

	^ self new initializeAcceptingItemsOf: aCatalog.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard merchantProcessor date salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'ISW 5/Nov/2026, 1:35:00 pm (UTC)'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	date := aDate.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'checkout' stamp: 'ISW 5/Nov/2026, 1:36:00 pm (UTC)'!
checkOut

	| total |
	self assertCanCheckOut.

	total := cart total.
	merchantProcessor debit: total from: creditCard.
	salesBook add: total.

	^ total.! !


!Cashier methodsFor: 'assertions' stamp: 'ISW 5/Nov/2026, 1:37:00 pm (UTC)'!
assertCanCheckOut

	cart isEmpty ifTrue: [ self error: self class cartCanNotBeEmptyErrorMessage ].
	(creditCard isExpiredOn: date) ifTrue: [ self error: self class canNotChargeAnExpiredCreditCardErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'ISW 5/Nov/2026, 1:38:00 pm (UTC)'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	^ self new
		initializeToCheckout: aCart
		charging: aCreditCard
		throught: aMerchantProcessor
		on: aDate
		registeringOn: aSalesBook.! !


!Cashier class methodsFor: 'error messages' stamp: 'ISW 5/Nov/2026, 1:39:00 pm (UTC)'!
canNotChargeAnExpiredCreditCardErrorMessage

	^ 'Cannot charge an expired credit card'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ISW 5/Nov/2026, 1:40:00 pm (UTC)'!
cartCanNotBeEmptyErrorMessage

	^ 'Cart cannot be empty to checkout'.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'ISW 5/Nov/2026, 1:45:00 pm (UTC)'!
initializeExpiringOn: aMonth

	expirationMonth := aMonth.! !


!CreditCard methodsFor: 'testing' stamp: 'HAW 5/Nov/2026, 12:32:24 pm (UTC)'!
isExpiredOn: aDateAndTime

	| expirationEnd |
	expirationEnd := expirationMonth start + expirationMonth duration.
	^ aDateAndTime >= expirationEnd.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ISW 5/Nov/2026, 1:47:00 pm (UTC)'!
expiringOn: aMonth

	^ self new initializeExpiringOn: aMonth.! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debiting' stamp: 'ISW 5/Nov/2026, 1:50:00 pm (UTC)'!
debit: anAmount from: aCreditCard

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error messages' stamp: 'ISW 5/Nov/2026, 1:51:00 pm (UTC)'!
creditCardHasNoCreditErrorMessage

	^ 'Credit card has no credit'.! !


!classDefinition: #MockFailingMerchantProcessor category: #TusLibros!
MerchantProcessor subclass: #MockFailingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockFailingMerchantProcessor methodsFor: 'debiting' stamp: 'ISW 5/Nov/2026, 1:52:00 pm (UTC)'!
debit: anAmount from: aCreditCard

	self error: MerchantProcessor creditCardHasNoCreditErrorMessage.! !
