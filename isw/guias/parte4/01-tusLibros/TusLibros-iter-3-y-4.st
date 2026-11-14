!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:10:00 pm (UTC)'!
test01NewCartsAreCreatedEmpty

	self assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:10:00 pm (UTC)'!
test02CanNotAddItemsThatDoNotBelongToStore

	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		failWith: cart invalidItemErrorMessage! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:10:00 pm (UTC)'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:10:00 pm (UTC)'!
test04CanNotAddNonPositiveNumberOfItems

	self
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		failWith: cart invalidQuantityErrorMessage! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:10:00 pm (UTC)'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	self
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		failWith: cart invalidItemErrorMessage! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:11:00 pm (UTC)'!
test06CartRemembersAddedItems

	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:11:00 pm (UTC)'!
test07CartDoesNotHoldNotAddedItems

	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 17/Jun/2013, 9:11:00 pm (UTC)'!
test08CartRemembersTheNumberOfAddedItems

	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
setUp 

	super setUp.
	testObjectsFactory := StoreTestObjectsFactory new.
	cart := testObjectsFactory createCart.! !


!CartTest methodsFor: 'test support' stamp: ''!
should: anOperation failWith: anErrorDescription

	self
		should: anOperation
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorDescription ].
	self assert: cart isEmpty! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior cart salesBook creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
setUp 

	super setUp.
	testObjectsFactory := StoreTestObjectsFactory new.
	cart := testObjectsFactory createCart.
	salesBook := OrderedCollection new.
	creditCard := testObjectsFactory notExpiredCreditCard.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 17/Jun/2013, 10:02:00 pm (UTC)'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test01CanNotCheckoutAnEmptyCart

	self
		should: [ self createCashierCharging: creditCard through: self ]
		failWith: Cashier cartCanNotBeEmptyErrorMessage! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test02CalculatedTotalIsCorrect

	| cashier |

	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  self createCashierCharging: creditCard through: self.

	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test03CanNotCheckoutWithAnExpiredCreditCart

	cart add: testObjectsFactory itemSellByTheStore.

	self
		should: [ self createCashierCharging: testObjectsFactory expiredCreditCard through: self ]
		failWith: Cashier canNotChargeAnExpiredCreditCardErrorMessage! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test04CheckoutRegistersASale

	| cashier total |

	cart add: testObjectsFactory itemSellByTheStore.

	cashier:= self createCashierCharging: creditCard through: self.

	total := cashier checkOut.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cashier total debitedAmount debitedCreditCard |

	cart add: testObjectsFactory itemSellByTheStore.

	cashier:= self createCashierCharging: creditCard through: self.

	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmount := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmount = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test05WithMock_CashierChargesCreditCardUsingMerchantProcessor

	| cashier total merchantProcessor mpReceivedMessages debitFromMessage |

	cart add: testObjectsFactory itemSellByTheStore.
	merchantProcessor := Mock onlyCollecting.

	cashier:= self createCashierCharging: creditCard through: merchantProcessor.

	total := cashier checkOut.
	mpReceivedMessages := merchantProcessor receivedMessages.

	self assert: 1 equals: mpReceivedMessages size.
	debitFromMessage := mpReceivedMessages first.
	self assert: debitFromMessage selector equals: #debit:from:.
	self assert: debitFromMessage arguments first equals: total.
	self assert: debitFromMessage arguments second equals: creditCard 
	! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cashier |

	cart add: testObjectsFactory itemSellByTheStore.
 	debitBehavior := [ :anAmount :aCreditCard | self error: MerchantProcessor creditCardHasNoCreditErrorMessage].

	cashier:= self createCashierCharging: creditCard through: self.

	self
		should: [cashier checkOut ]
		failWith: MerchantProcessor creditCardHasNoCreditErrorMessage! !

!CashierTest methodsFor: 'tests' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
test06WithMock_CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cashier merchantProcessor |

	cart add: testObjectsFactory itemSellByTheStore.
 	merchantProcessor := Mock whenReceives: #debit:from: do: [ :amount :aCreditCard | self error: MerchantProcessor creditCardHasNoCreditErrorMessage ].

	cashier:= self createCashierCharging: creditCard through: merchantProcessor.

	self
		should: [cashier checkOut ]
		failWith: MerchantProcessor creditCardHasNoCreditErrorMessage! !


!CashierTest methodsFor: 'test support' stamp: ''!
createCashierCharging: aCreditCard through: aMerchantProcessor

	^ Cashier
		toCheckout: cart
		charging: aCreditCard
		throught: aMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook! !

!CashierTest methodsFor: 'test support' stamp: ''!
should: anOperation failWith: anErrorDescription

	self
		should: anOperation
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorDescription ].
	self assert: salesBook isEmpty! !


!classDefinition: #TusLibrosSystemFacadeTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory debitBehavior systemFacade clock salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacadeTest methodsFor: 'users and passwords' stamp: ''!
invalidUser

	^ 'invalid user'! !

!TusLibrosSystemFacadeTest methodsFor: 'users and passwords' stamp: ''!
validPassword

	^ 'validPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'users and passwords' stamp: ''!
validUser

	^ 'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'users and passwords' stamp: 'HAW 14/Nov/2026, 12:51:47 am (UTC)'!
validUsers

	^ Dictionary with: self validUser -> self validPassword with: 'hola' -> 'mundo' with: 'andy' -> 'pandy'.! !


!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test01CannotCreateCartWithInvalidUser

	self
		should: [systemFacade createCartFor: self invalidUser authenticatedWith: self validPassword ]
		failWith: TusLibrosSystemFacade invalidUserAndOrPasswordErrorDescription! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test02CanCreateAnEmptyCartWithValidCredentials

	| cartId |

	cartId := self createCart.

	self assert: (systemFacade listCartIdentifiedAs: cartId ) isEmpty .

	
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test03CannotListCartWithInvalidId

	self
		should: [systemFacade listCartIdentifiedAs: -1]
		failWith: TusLibrosSystemFacade invalidCartIdErrorDescription.

	
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test04CanAddABookToCart

	| cartId book |

	cartId := self createCart.
	book := testObjectsFactory itemSellByTheStore .
	systemFacade add: 2 of: book toCartIdentifiedAs: cartId .

	self assert: ((systemFacade listCartIdentifiedAs: cartId ) occurrencesOf: book) equals: 2.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test05CannotAddABookToAnInvalidCart

	self
		should: [
            systemFacade
                add: 1
                of: testObjectsFactory itemSellByTheStore
                toCartIdentifiedAs: -1 ]
		failWith: TusLibrosSystemFacade invalidCartIdErrorDescription.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test06CannotListCartAfter30MinutesOfInactivity

	| cartId |
	cartId := self createCart.
	systemFacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId .
	clock advanceTime: systemFacade sessionDuration + 1 minutes .

	self
	should: [systemFacade listCartIdentifiedAs: cartId ]
		failWith: TusLibrosSystemFacade sessionHasExpiredErrorDescription! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test07ActivityOnOneCartDoesNotRenewAnotherCartSession

	| cartId1 cartId2 book |

	cartId1 := self createCart.
	cartId2 := systemFacade createCartFor: 'hola' authenticatedWith: 'mundo'.
	book := testObjectsFactory itemSellByTheStore .
	clock advanceTime: 20 minutes .
	systemFacade add: 2 of:  book toCartIdentifiedAs: cartId2 .
	clock advanceTime: 11 minutes .

	self
		should: [systemFacade listCartIdentifiedAs: cartId1 ]
		failWith: TusLibrosSystemFacade sessionHasExpiredErrorDescription.
	self assert: ((systemFacade listCartIdentifiedAs: cartId2) occurrencesOf: book) equals: 2.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test08CannotAddBooksToCartAfter30MinutesOfInactivity

	| cartId book1 book2 |
	cartId := self createCart.

	book1 := testObjectsFactory itemSellByTheStore .
	book2 := testObjectsFactory anotherItemSellByTheStore .
	systemFacade add: 2 of:  book1 toCartIdentifiedAs: cartId .
	clock advanceTime:  systemFacade sessionDuration  + 1 minutes .

	self
		should: [systemFacade add: 10 of: book2  toCartIdentifiedAs: cartId ]
		failWith: TusLibrosSystemFacade sessionHasExpiredErrorDescription.
	clock revertTime: systemFacade sessionDuration .
	self assert: ((systemFacade listCartIdentifiedAs: cartId ) occurrencesOf: book1) equals: 2.
	self assert: ((systemFacade listCartIdentifiedAs: cartId ) occurrencesOf: book2) equals: 0.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test09CannotCheckoutCartWithInvalidId

	self
		should: [self checkoutCart: -1]
		failWith: TusLibrosSystemFacade invalidCartIdErrorDescription.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:09:31 am (UTC)'!
test10CheckoutRegistersASaleWithTheCorrectTotalAndReturnsItsTransactionId

	| cartId transactionId |
	cartId := self createCart.
	systemFacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId.

	debitBehavior := [:amount :card |
		self assert: amount equals: testObjectsFactory itemSellByTheStorePrice * 2.
		self assert: card number equals: testObjectsFactory notExpiredCreditCardNumber.
		self assert: card owner equals: testObjectsFactory notExpiredCreditCardOwner].

	transactionId := self checkoutCart: cartId .

	self assert: salesBook size equals: 1.
	self assert: salesBook first total equals: testObjectsFactory itemSellByTheStorePrice * 2.
	self deny: transactionId isNil.
	self assert: transactionId equals: salesBook first transactionId.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:04:56 am (UTC)'!
test11CannotCheckoutTheSameCartTwice

	| book cartId |
	book := testObjectsFactory itemSellByTheStore .

	
	cartId := self createCart. 
	systemFacade add: 2 of: book  toCartIdentifiedAs: cartId .

	self checkoutCart: cartId .

	self
	should: [self checkoutCart: cartId ]
		failWith: TusLibrosSystemFacade invalidCartIdErrorDescription.
	self assert: salesBook size equals: 1.

	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:04:56 am (UTC)'!
test12CustomerWithNoPurchasesHasEmptyItemsAndZeroTotal

	| purchases |

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validPassword.

	self assert: purchases items isEmpty.
	self assert: purchases total equals: 0! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:04:56 am (UTC)'!
test13CustomerWithPurchasesHasPurchasedBooksAndCorrectTotal

	| purchases book cartId |
	book := testObjectsFactory itemSellByTheStore .

	cartId := self createCart.
	systemFacade add: 2 of: book   toCartIdentifiedAs: cartId.
	self checkoutCart: cartId .

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validPassword.

	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice * 2.
	self assert: (purchases items occurrencesOf: book) equals: 2.
	purchases := systemFacade listPurchasesOf: 'hola' authenticatingWith: 'mundo'.
	self assert: purchases items isEmpty.
	self assert: purchases total equals: 0.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 1:04:56 am (UTC)'!
test14CannotListPurchasesWithInvalidUser

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validPassword]
		failWith: TusLibrosSystemFacade invalidUserAndOrPasswordErrorDescription.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'HAW 14/Nov/2026, 12:51:47 am (UTC)'!
test15EachCheckoutReturnsADifferentTransactionId

	| firstCartId secondCartId firstTransactionId secondTransactionId |
	firstCartId := self createCart.
	secondCartId := self createCart.
	systemFacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: firstCartId.
	systemFacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: secondCartId.

	firstTransactionId := self checkoutCart: firstCartId.
	secondTransactionId := self checkoutCart: secondCartId.

	self deny: firstTransactionId = secondTransactionId.
	self assert: firstTransactionId equals: salesBook first transactionId.
	self assert: secondTransactionId equals: salesBook second transactionId.! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HAW 13/Nov/2026, 1:34:05 pm (UTC)'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: ''!
setUp

	super setUp.
	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clock := testObjectsFactory createManualClock.
	salesBook := OrderedCollection new.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsers
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: salesBook
		debitingThrought: self
		measuringTimeWith: clock.! !


!TusLibrosSystemFacadeTest methodsFor: 'test support' stamp: ''!
checkoutCart: cartId

	^ systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear! !

!TusLibrosSystemFacadeTest methodsFor: 'test support' stamp: ''!
createCart

	^ systemFacade createCartFor: self validUser authenticatedWith: self validPassword! !

!TusLibrosSystemFacadeTest methodsFor: 'test support' stamp: ''!
should: anOperation failWith: anErrorDescription

	self
		should: anOperation
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorDescription ]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 17/Jun/2013, 10:09:00 pm (UTC)'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 17/Jun/2013, 8:45:00 pm (UTC)'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 17/Jun/2013, 8:45:00 pm (UTC)'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 17/Jun/2013, 8:44:00 pm (UTC)'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 17/Jun/2013, 8:51:00 pm (UTC)'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 17/Jun/2013, 8:44:00 pm (UTC)'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 17/Jun/2013, 8:44:00 pm (UTC)'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'queries' stamp: ''!
contents

	^ items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 17/Jun/2013, 8:45:00 pm (UTC)'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 17/Jun/2013, 9:06:00 pm (UTC)'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 17/Jun/2013, 8:51:00 pm (UTC)'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart user lastActivity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: ''!
initializeFor: aCart ownedBy: aUser lastActiveOn: aDateAndTime

	cart := aCart.
	user := aUser.
	lastActivity := aDateAndTime! !


!CartSession methodsFor: 'accessing' stamp: ''!
cart

	^ cart! !

!CartSession methodsFor: 'accessing' stamp: ''!
lastActivity

	^ lastActivity! !

!CartSession methodsFor: 'accessing' stamp: ''!
lastActivity: aDateAndTime

	lastActivity := aDateAndTime! !

!CartSession methodsFor: 'accessing' stamp: ''!
user

	^ user! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: ''!
for: aCart ownedBy: aUser lastActiveOn: aDateAndTime

	^ self new initializeFor: aCart ownedBy: aUser lastActiveOn: aDateAndTime! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total sale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 17/Jun/2013, 10:08:00 pm (UTC)'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 17/Jun/2013, 10:07:00 pm (UTC)'!
createSale

	^ Sale of: total identifiedAs: salesBook size + 1
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 17/Jun/2013, 10:06:00 pm (UTC)'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 17/Jun/2013, 10:06:00 pm (UTC)'!
registerSale

	sale := self createSale.
	salesBook add: sale
! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 17/Jun/2013, 10:06:00 pm (UTC)'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 17/Jun/2013, 9:53:00 pm (UTC)'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !


!Cashier methodsFor: 'accessing' stamp: ''!
transactionId

	^ sale transactionId! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 17/Jun/2013, 9:22:00 pm (UTC)'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 17/Jun/2013, 9:23:00 pm (UTC)'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 17/Jun/2013, 9:21:00 pm (UTC)'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 17/Jun/2013, 8:56:00 pm (UTC)'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'managment time' stamp: 'HAW 14/Nov/2026, 12:47:21 am (UTC)'!
now

	self subclassResponsibility .! !

!Clock methodsFor: 'managment time' stamp: 'HAW 14/Nov/2026, 12:47:30 am (UTC)'!
today

	self subclassResponsibility .! !


!Clock methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 12:46:52 am (UTC)'!
initializeNow: aDateAndTime 
	
	dateAndTime := aDateAndTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: #TusLibros!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 12:46:36 am (UTC)'!
now: aDateAndTime 

	^self new initializeNow: aDateAndTime ! !


!classDefinition: #ManualClock category: #TusLibros!
Clock subclass: #ManualClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'managment time' stamp: 'HAW 13/Nov/2026, 12:27:41 pm (UTC)'!
advanceTime: aDuration

	dateAndTime := dateAndTime + aDuration
! !

!ManualClock methodsFor: 'managment time' stamp: 'HAW 13/Nov/2026, 12:17:35 pm (UTC)'!
now
	^ dateAndTime .! !

!ManualClock methodsFor: 'managment time' stamp: 'HAW 14/Nov/2026, 12:47:41 am (UTC)'!
revertTime: aDuration

	dateAndTime := dateAndTime + aDuration negated .! !

!ManualClock methodsFor: 'managment time' stamp: 'HAW 13/Nov/2026, 1:32:20 pm (UTC)'!
today

	^ dateAndTime date
! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 17/Jun/2013, 9:39:00 pm (UTC)'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 17/Jun/2013, 9:38:00 pm (UTC)'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: ''!
initializeNumbered: aNumber ownedBy: anOwner expiringOn: anExpirationMonth

	self initializeExpiringOn: anExpirationMonth.
	number := aNumber.
	owner := anOwner! !


!CreditCard methodsFor: 'accessing' stamp: ''!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: ''!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: ''!
numbered: aNumber ownedBy: anOwner expiringOn: anExpirationMonth

	^ self new initializeNumbered: aNumber ownedBy: anOwner expiringOn: anExpirationMonth! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 22/Jun/2013, 5:31:00 pm (UTC)'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 22/Jun/2013, 5:30:00 pm (UTC)'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'ARM 17/Jun/2025, 6:03:52 pm (UTC)'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #PurchaseHistory category: #TusLibros!
Object subclass: #PurchaseHistory
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseHistory methodsFor: 'accesing' stamp: 'HAW 13/Nov/2026, 2:01:22 pm (UTC)'!
items

	^ items copy
! !

!PurchaseHistory methodsFor: 'accesing' stamp: 'HAW 13/Nov/2026, 2:01:29 pm (UTC)'!
total

	^ total
! !


!PurchaseHistory methodsFor: 'initialization' stamp: ''!
initialize

	super initialize.
	items := OrderedCollection new.
	total := 0! !


!PurchaseHistory methodsFor: 'registering' stamp: ''!
addItems: purchasedItems total: anAmount

	items addAll: purchasedItems.
	total := total + anAmount! !


!PurchaseHistory methodsFor: 'copying' stamp: ''!
postCopy

	super postCopy.
	items := items copy! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 17/Jun/2013, 9:48:00 pm (UTC)'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 17/Jun/2013, 9:47:00 pm (UTC)'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: ''!
initializeTotal: aTotal identifiedAs: aTransactionId

	self initializeTotal: aTotal.
	transactionId := aTransactionId! !


!Sale methodsFor: 'accessing' stamp: ''!
transactionId

	^ transactionId! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: ''!
of: aTotal identifiedAs: aTransactionId

	^ self new initializeTotal: aTotal identifiedAs: aTransactionId! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 22/Jun/2013, 3:02:00 pm (UTC)'!
customer

	^'aCustomer'! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HAW 14/Nov/2026, 1:04:56 am (UTC)'!
createManualClock

	^ ManualClock now: self today
! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 17/Jun/2013, 9:37:00 pm (UTC)'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 17/Jun/2013, 9:37:00 pm (UTC)'!
initialize

	today := DateAndTime year: 2026 month: 11 day: 13 hour: 9 minute: 0
! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 17/Jun/2013, 9:37:00 pm (UTC)'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 22/Jun/2013, 2:24:00 pm (UTC)'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 17/Jun/2013, 9:36:00 pm (UTC)'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 19/Jun/2018, 2:45:30 pm (UTC)'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 19/Jun/2018, 2:45:48 pm (UTC)'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 22/Jun/2013, 2:06:00 pm (UTC)'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 22/Jun/2013, 3:16:00 am (UTC)'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 22/Jun/2013, 3:16:00 am (UTC)'!
anotherItemSellByTheStorePrice

	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 17/Jun/2013, 9:08:00 pm (UTC)'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 17/Jun/2013, 9:08:00 pm (UTC)'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 17/Jun/2013, 9:08:00 pm (UTC)'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 17/Jun/2013, 9:08:00 pm (UTC)'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!classDefinition: #TusLibrosSystemFacade category: #TusLibros!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'users cartsById catalog nextCartId clock saleBook merchantProcessor purchaseHistoryByUser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HAW 13/Nov/2026, 2:06:51 pm (UTC)'!
initializeAuthenticatingWith: usersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSaleBook debitingThrought: aMerchantProcessor measuringTimeWith: aClock   
	
	
	
	users := usersAndPasswords.
	cartsById := Dictionary new.
	catalog := aCatalog .
	clock := aClock .
	nextCartId := 0.
	saleBook := aSaleBook .
	merchantProcessor := aMerchantProcessor .
	purchaseHistoryByUser := Dictionary new.! !


!TusLibrosSystemFacade methodsFor: 'cart creation' stamp: 'HAW 13/Nov/2026, 12:38:02 pm (UTC)'!
createCartFor: aCustomerUser authenticatedWith: aCustomerPassword

	| cart cartId |
	self assertValidUser: aCustomerUser password: aCustomerPassword.
	cart := Cart acceptingItemsOf: catalog.
	cartId := nextCartId.
	cartsById at: cartId put: (CartSession for: cart ownedBy: aCustomerUser lastActiveOn: clock now).
	nextCartId := nextCartId + 1.
	^ cartId
! !


!TusLibrosSystemFacade methodsFor: 'asserting' stamp: 'HAW 13/Nov/2026, 12:44:48 pm (UTC)'!
assertSessionHasNotExpiredFor: cartId

	| session |
	session := self sessionIdentifiedAs: cartId.
	(clock now - session lastActivity) >= self sessionDuration
		ifTrue: [self error: self sessionHasExpiredErrorDescription]
! !

!TusLibrosSystemFacade methodsFor: 'asserting' stamp: 'HAW 13/Nov/2026, 12:43:41 pm (UTC)'!
assertValidUser: aCustomerUser password: aCustomerPassword 
	
	| storedPassword |
	storedPassword := users at: aCustomerUser ifAbsent: [self error: self invalidUserAndOrPasswordErrorDescription].
	aCustomerPassword = storedPassword ifFalse: [self error: self invalidUserAndOrPasswordErrorDescription].! !


!TusLibrosSystemFacade methodsFor: 'accesing' stamp: 'HAW 13/Nov/2026, 12:44:48 pm (UTC)'!
listCartIdentifiedAs: cartId

	^ (self activeSessionIdentifiedAs: cartId) cart contents
! !

!TusLibrosSystemFacade methodsFor: 'accesing' stamp: 'HAW 13/Nov/2026, 2:01:03 pm (UTC)'!
listPurchasesOf: aUserName authenticatingWith: aUserPassword

	self assertValidUser: aUserName password: aUserPassword.
	^ (purchaseHistoryByUser at: aUserName ifAbsent: [PurchaseHistory new]) copy
! !


!TusLibrosSystemFacade methodsFor: 'add item' stamp: 'HAW 13/Nov/2026, 11:48:54 am (UTC)'!
add: aBooksAmount of: aBookToAdd toCartIdentifiedAs: aCartId

	(self activeSessionIdentifiedAs: aCartId) cart add: aBooksAmount of: aBookToAdd
! !


!TusLibrosSystemFacade methodsFor: 'session' stamp: 'HAW 13/Nov/2026, 12:24:45 pm (UTC)'!
sessionDuration
	
	^ (Duration minutes: 30)! !


!TusLibrosSystemFacade methodsFor: 'checkout' stamp: 'HAW 13/Nov/2026, 2:07:46 pm (UTC)'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCardNumber ownedBy: aCreditCardOwner expiringOn: anExpirationMonth

	| session cart creditCard cashier total purchases |
	session := self activeSessionIdentifiedAs: aCartId.
	cart := session cart.
	creditCard := CreditCard numbered: aCreditCardNumber ownedBy: aCreditCardOwner expiringOn: anExpirationMonth.
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: clock today registeringOn: saleBook.
	total := cashier checkOut.
	purchases := purchaseHistoryByUser at: session user ifAbsentPut: [PurchaseHistory new].
	purchases addItems: cart contents total: total.
	cartsById removeKey: aCartId.
	^ cashier transactionId
! !


!TusLibrosSystemFacade methodsFor: 'session - private' stamp: ''!
activeSessionIdentifiedAs: cartId

	| session |
	session := self sessionIdentifiedAs: cartId.
	self assertSessionHasNotExpiredFor: cartId.
	session lastActivity: clock now.
	^ session! !

!TusLibrosSystemFacade methodsFor: 'session - private' stamp: ''!
sessionIdentifiedAs: cartId

	^ cartsById at: cartId ifAbsent: [self error: self invalidCartIdErrorDescription]! !


!TusLibrosSystemFacade methodsFor: 'error descriptions' stamp: ''!
invalidCartIdErrorDescription

	^ self class invalidCartIdErrorDescription! !

!TusLibrosSystemFacade methodsFor: 'error descriptions' stamp: ''!
invalidUserAndOrPasswordErrorDescription

	^ self class invalidUserAndOrPasswordErrorDescription! !

!TusLibrosSystemFacade methodsFor: 'error descriptions' stamp: ''!
sessionHasExpiredErrorDescription

	^ self class sessionHasExpiredErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #TusLibros!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:13 pm (UTC)'!
authenticatingWith: usersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSaleBook debitingThrought: aMerchantProcessor measuringTimeWith: aClock   

	^self new initializeAuthenticatingWith: usersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSaleBook debitingThrought: aMerchantProcessor measuringTimeWith: aClock ! !


!TusLibrosSystemFacade class methodsFor: 'error description' stamp: 'HAW 13/Nov/2026, 2:06:31 am (UTC)'!
invalidCartIdErrorDescription
	
	^ 'Cart id is invalid'! !

!TusLibrosSystemFacade class methodsFor: 'error description' stamp: 'HAW 13/Nov/2026, 1:44:52 am (UTC)'!
invalidUserAndOrPasswordErrorDescription
	
	^'Invalid password and/or user'! !

!TusLibrosSystemFacade class methodsFor: 'error description' stamp: 'HAW 13/Nov/2026, 12:28:11 pm (UTC)'!
sessionHasExpiredErrorDescription

    ^ 'Cart session has expired'! !


!classDefinition: #Mock category: #TusLibros!
ProtoObject subclass: #Mock
	instanceVariableNames: 'receivedMessages blockBySelectors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Mock methodsFor: 'system primitives' stamp: 'HAW 8/Nov/2024, 4:37:50 pm (UTC)'!
doesNotUnderstand: aMessage

	receivedMessages add: aMessage.
	
	^blockBySelectors 
		at: aMessage selector 
		ifPresent: [ :aBlock | aBlock valueWithArguments: aMessage arguments ]
		ifAbsent: [ self ]! !

!Mock methodsFor: 'system primitives' stamp: 'HAW 8/Nov/2024, 4:32:55 pm (UTC)'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!Mock methodsFor: 'system primitives' stamp: 'HAW 8/Nov/2024, 4:33:06 pm (UTC)'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	Object primitiveFailed! !


!Mock methodsFor: 'initialization' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
initializeDoingAll: aBlocksBySelectors 

	blockBySelectors := aBlocksBySelectors.
	receivedMessages := OrderedCollection new! !


!Mock methodsFor: 'received messages' stamp: 'HAW 8/Nov/2024, 4:46:46 pm (UTC)'!
receivedMessages

	^receivedMessages copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mock class' category: #TusLibros!
Mock class
	instanceVariableNames: ''!

!Mock class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
doingAll: aBlocksBySelectors

	^self new initializeDoingAll: aBlocksBySelectors ! !

!Mock class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
onlyCollecting

	^self doingAll: Dictionary new! !

!Mock class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 1:25:52 pm (UTC)'!
whenReceives: aSelector do: aBlock

	^self doingAll: (Dictionary new
		at: aSelector put: aBlock;
		yourself)! !
