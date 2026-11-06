!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'running' stamp: 'ISW 6/Nov/2026, 6:15:00 pm (UTC)'!
setUp

	testObjectsFactory := TusLibrosTestObjectsFactory new.! !


!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:16:00 pm (UTC)'!
test01NewCartIsEmpty

	| cart |
	cart := testObjectsFactory createCart.

	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:17:00 pm (UTC)'!
test02AddingAnItemMakesCartNotEmpty

	| cart book |
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByStore.
	cart add: book.

	self deny: cart isEmpty.
	self assert: (cart includes: book).
	self assert: (cart occurrencesOf: book) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:18:00 pm (UTC)'!
test03CanAddMultipleCopiesOfAnItem

	| cart book |
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByStore.
	cart add: 3 of: book.

	self assert: (cart occurrencesOf: book) equals: 3.! !

!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:19:00 pm (UTC)'!
test04CannotAddAnItemNotInCatalog

	| cart |
	cart := testObjectsFactory createCart.

	self
		should: [ cart add: testObjectsFactory itemNotSellByStore ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidItemErrorMessage.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 1:05:00 pm (UTC)'!
test05CannotAddNonPositiveQuantityOfAnItem

	| cart book |
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByStore.

	self
		should: [ cart add: 0 of: book ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidQuantityErrorMessage.
			self assert: cart isEmpty.
		].

	self
		should: [ cart add: -1 of: book ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart invalidQuantityErrorMessage.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:20:00 pm (UTC)'!
test06CartCalculatesTotalCorrectly

	| cart book anotherBook expectedTotal |
	cart := testObjectsFactory createCart.
	book := testObjectsFactory itemSellByStore.
	anotherBook := testObjectsFactory anotherItemSellByStore.

	cart add: 2 of: book.
	cart add: 1 of: anotherBook.

	expectedTotal := (2 * testObjectsFactory itemSellByStorePrice) + testObjectsFactory anotherItemSellByStorePrice.
	self assert: cart total equals: expectedTotal.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitCalled debitAmount chargedCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'running' stamp: 'ISW 6/Nov/2026, 6:25:00 pm (UTC)'!
setUp

	testObjectsFactory := TusLibrosTestObjectsFactory new.
	salesBook := OrderedCollection new.
	debitCalled := false.! !


!CashierTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:26:00 pm (UTC)'!
test01CannotCheckoutAnEmptyCart

	| cashier |
	cashier := Cashier
		toCheckout: testObjectsFactory createCart
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	self
		should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty.
			self deny: debitCalled.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:27:00 pm (UTC)'!
test02CannotCheckoutWithAnExpiredCreditCard

	| cashier cart |
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByStore.

	cashier := Cashier
		toCheckout: cart
		charging: testObjectsFactory expiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	self
		should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty.
			self deny: debitCalled.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:28:00 pm (UTC)'!
test03CreditCardIsValidDuringItsExpirationMonth

	| cashier cardExpiringThisMonth cart total lastMomentOfMonth |
	cardExpiringThisMonth := testObjectsFactory creditCardExpiringThisMonth.
	lastMomentOfMonth := DateAndTime year: 2026 month: 11 day: 30 hour: 23 minute: 59 second: 59.

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByStore.

	cashier := Cashier
		toCheckout: cart
		charging: cardExpiringThisMonth
		throught: self
		on: lastMomentOfMonth
		registeringOn: salesBook.

	total := cashier checkOut.

	self assert: total equals: 100.
	self assert: debitCalled.
	self assert: debitAmount equals: 100.
	self assert: chargedCard equals: cardExpiringThisMonth.
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: 100.! !

!CashierTest methodsFor: 'tests' stamp: 'ISW 6/Nov/2026, 6:29:00 pm (UTC)'!
test04CheckOutFailsIfMerchantProcessorFails

	| cashier cart |
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByStore.

	cashier := Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		throught: MockFailingMerchantProcessor new
		on: testObjectsFactory today
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


!classDefinition: #TusLibrosTestObjectsFactory category: #TusLibros!
Object subclass: #TusLibrosTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectsFactory methodsFor: 'cart items' stamp: 'ISW 6/Nov/2026, 6:00:00 pm (UTC)'!
itemSellByStore

	^ '978-0132350884'.! !

!TusLibrosTestObjectsFactory methodsFor: 'cart items' stamp: 'ISW 6/Nov/2026, 6:01:00 pm (UTC)'!
itemNotSellByStore

	^ 'invalid-isbn'.! !

!TusLibrosTestObjectsFactory methodsFor: 'cart items' stamp: 'ISW 6/Nov/2026, 6:02:00 pm (UTC)'!
anotherItemSellByStore

	^ '978-0201633610'.! !

!TusLibrosTestObjectsFactory methodsFor: 'cart items' stamp: 'ISW 6/Nov/2026, 6:03:00 pm (UTC)'!
itemSellByStorePrice

	^ 50.! !

!TusLibrosTestObjectsFactory methodsFor: 'cart items' stamp: 'ISW 6/Nov/2026, 6:04:00 pm (UTC)'!
anotherItemSellByStorePrice

	^ 100.! !


!TusLibrosTestObjectsFactory methodsFor: 'cart creation' stamp: 'ISW 6/Nov/2026, 6:05:00 pm (UTC)'!
defaultCatalog

	| catalog |
	catalog := Dictionary new.
	catalog at: self itemSellByStore put: self itemSellByStorePrice.
	catalog at: self anotherItemSellByStore put: self anotherItemSellByStorePrice.
	^ catalog.! !

!TusLibrosTestObjectsFactory methodsFor: 'cart creation' stamp: 'ISW 6/Nov/2026, 6:06:00 pm (UTC)'!
createCart

	^ Cart acceptingItemsOf: self defaultCatalog.! !


!TusLibrosTestObjectsFactory methodsFor: 'dates' stamp: 'ISW 6/Nov/2026, 6:07:00 pm (UTC)'!
today

	^ DateAndTime year: 2026 month: 11 day: 5.! !


!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'ISW 6/Nov/2026, 6:08:00 pm (UTC)'!
notExpiredCreditCard

	^ CreditCard expiringOn: (Month month: 12 year: 2026).! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'ISW 6/Nov/2026, 6:09:00 pm (UTC)'!
expiredCreditCard

	^ CreditCard expiringOn: (Month month: 10 year: 2026).! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'ISW 6/Nov/2026, 6:10:00 pm (UTC)'!
creditCardExpiringThisMonth

	^ CreditCard expiringOn: (Month month: 11 year: 2026).! !


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


!CreditCard methodsFor: 'testing' stamp: 'HAW 6/Nov/2026, 4:12:11 pm (UTC)'!
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
