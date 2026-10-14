!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'HAW 11/Oct/2026, 6:26:44 pm (UTC)'!
initializeFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'value' stamp: 'HAW 10/Oct/2026, 12:04:41 am (UTC)'!
affectBalance: aPartialBalance

	self subclassResponsibility .! !

!AccountTransaction methodsFor: 'value' stamp: 'HAW 9/Oct/2026, 11:45:34 pm (UTC)'!
value

	^ value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HAW 11/Oct/2026, 6:46:23 pm (UTC)'!
register: aValue on: account

	| transaction |

	transaction := self for: aValue.
	account register: transaction.

	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'HAW 10/Oct/2026, 12:04:47 am (UTC)'!
affectBalance: aPartialBalance

	^ aPartialBalance + value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 13/Jul/2011, 9:38:00 pm (UTC)'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'HAW 10/Oct/2026, 12:04:53 am (UTC)'!
affectBalance: aPartialBalance

	^ aPartialBalance - value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 13/Jul/2011, 9:33:00 pm (UTC)'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialEntity category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialEntity
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialEntity methodsFor: 'transactions' stamp: 'HAW 13/Oct/2026, 10:56:42 pm (UTC)'!
register: aFinancialEntity

	self subclassResponsibility .! !

!FinancialEntity methodsFor: 'transactions' stamp: 'HAW 13/Oct/2026, 10:56:58 pm (UTC)'!
transactions

	self subclassResponsibility ! !


!FinancialEntity methodsFor: 'testing' stamp: 'HAW 13/Oct/2026, 10:58:44 pm (UTC)'!
hasRegistered: aTrasaction

	self subclassResponsibility .! !

!FinancialEntity methodsFor: 'testing' stamp: 'HAW 13/Oct/2026, 11:42:07 pm (UTC)'!
manage: aFinancialEntityToAdd

	self subclassResponsibility .! !

!FinancialEntity methodsFor: 'testing' stamp: 'HAW 14/Oct/2026, 2:30:00 am (UTC)'!
sharesWith: aFinancialEntity

	self subclassResponsibility .! !


!FinancialEntity methodsFor: 'initialization' stamp: 'HAW 14/Oct/2026, 1:29:35 am (UTC)'!
initialize

	parents := OrderedCollection new.! !


!FinancialEntity methodsFor: 'tree structure' stamp: 'HAW 14/Oct/2026, 1:52:41 am (UTC)'!
becomeChildOf: aPortfolio

	parents add: aPortfolio .! !

!FinancialEntity methodsFor: 'tree structure' stamp: 'HAW 14/Oct/2026, 1:33:18 am (UTC)'!
roots

	parents ifEmpty: [^ Set with: self].
	^ parents inject: Set new into: [:allRoots :aParent |
			allRoots addAll: aParent roots; yourself
		] .! !


!FinancialEntity methodsFor: 'balance' stamp: 'HAW 13/Oct/2026, 10:55:59 pm (UTC)'!
balance

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #Portfolio
	instanceVariableNames: 'financialEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'HAW 11/Oct/2026, 6:58:44 pm (UTC)'!
balance

	^ financialEntities sum: [:anAcount | anAcount balance ] ifEmpty: 0.
	! !


!Portfolio methodsFor: 'trasactions' stamp: 'HAW 14/Oct/2026, 1:49:13 am (UTC)'!
assertCanAdd: aFinancialEntityToAdd

	self roots do: [:aRoot |
			aRoot assertCanAddUnderTree: aFinancialEntityToAdd
		]! !

!Portfolio methodsFor: 'trasactions' stamp: 'HAW 14/Oct/2026, 1:29:15 am (UTC)'!
register: aFinancialEntityToAdd

	self assertCanAdd: aFinancialEntityToAdd.
	aFinancialEntityToAdd becomeChildOf: self.
	financialEntities add: aFinancialEntityToAdd .
	! !

!Portfolio methodsFor: 'trasactions' stamp: 'HAW 13/Oct/2026, 11:14:29 pm (UTC)'!
signalCannotAdd

	^ self error: self class cannotAddErrorDescription! !

!Portfolio methodsFor: 'trasactions' stamp: 'HAW 13/Oct/2026, 11:19:04 pm (UTC)'!
transactions
	^ financialEntities inject: OrderedCollection new into: [:aCollection :aFinancialEntity | aCollection addAll: aFinancialEntity transactions ; yourself ].

! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 11/Oct/2026, 7:07:35 pm (UTC)'!
hasRegistered: aTrasaction

	^ financialEntities anySatisfy: [:aFinancialEntity | aFinancialEntity hasRegistered: aTrasaction ] .! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 14/Oct/2026, 1:51:44 am (UTC)'!
manage: aFinancialEntityToManage

	^ (self = aFinancialEntityToManage) or: [
		financialEntities anySatisfy: [ :aFinancialEntity | aFinancialEntity manage: aFinancialEntityToManage ]
	]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 13/Oct/2026, 11:15:10 pm (UTC)'!
numberOfFinancialEntities

	^ financialEntities size.! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 14/Oct/2026, 2:30:10 am (UTC)'!
sharesWith: aFinancialEntity

	^ (self = aFinancialEntity) or: [
		financialEntities anySatisfy: [ :each | each sharesWith: aFinancialEntity ]
	]! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 14/Oct/2026, 1:29:50 am (UTC)'!
initialize

	super initialize .
	financialEntities := OrderedCollection new.! !


!Portfolio methodsFor: 'asserting' stamp: 'HAW 14/Oct/2026, 2:30:20 am (UTC)'!
assertCanAddUnderTree: aFinancialEntityToAdd

	(self sharesWith: aFinancialEntityToAdd) ifTrue: [
		self signalCannotAdd
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 13/Oct/2026, 11:12:28 pm (UTC)'!
cannotAddErrorDescription

	^ 'Cannot add a financial entity'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HAW 14/Oct/2026, 1:29:55 am (UTC)'!
initialize

	super initialize .
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 11/Oct/2026, 6:44:45 pm (UTC)'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 13/Jul/2011, 9:37:00 pm (UTC)'!
transactions

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 10/Oct/2026, 12:04:31 am (UTC)'!
balance

	^ transactions inject: 0 into: [:partialBalance :aTrasaction | aTrasaction affectBalance: partialBalance ] .! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 17/Oct/2019, 6:28:43 am (UTC)'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 13/Oct/2026, 11:42:21 pm (UTC)'!
manage: aFinancialEntityToAdd

	^ self = aFinancialEntityToAdd! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 14/Oct/2026, 2:30:30 am (UTC)'!
sharesWith: aFinancialEntity

	^ aFinancialEntity manage: self! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'portfolios' stamp: 'HAW 11/Oct/2026, 8:42:00 pm (UTC)'!
createPortfolioWith: anAccount

	| portfolio |
	portfolio := Portfolio new.
	portfolio register: anAccount.
	^ portfolio! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'HAW 11/Oct/2026, 8:43:00 pm (UTC)'!
createPortfolioWith: anAccount with: anotherAccount

	| portfolio |
	portfolio := Portfolio new.
	portfolio register: anAccount.
	portfolio register: anotherAccount.
	^ portfolio! !


!PortfolioTest methodsFor: 'accounts' stamp: 'HAW 11/Oct/2026, 8:40:00 pm (UTC)'!
accountWithBalance: aDepositAmount

	| account |
	account := ReceptiveAccount new.
	Deposit register: aDepositAmount on: account.
	^ account! !

!PortfolioTest methodsFor: 'accounts' stamp: 'HAW 11/Oct/2026, 8:41:00 pm (UTC)'!
accountWithDeposit: aDepositAmount andWithdraw: aWithdrawAmount

	| account |
	account := ReceptiveAccount new.
	Deposit register: aDepositAmount on: account.
	Withdraw register: aWithdrawAmount on: account.
	^ account! !


!PortfolioTest methodsFor: 'test' stamp: 'HAW 10/Oct/2026, 12:31:18 am (UTC)'!
test01EmptyPortfolioHasZeroBalance

	self assert: 0 equals: Portfolio new balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 11/Oct/2026, 6:57:31 pm (UTC)'!
test02PortfolioWithOneAccountHasItsBalance

	| portfolio acount1 |
	acount1 := self accountWithDeposit: 300 andWithdraw: 100.
	portfolio := self createPortfolioWith: acount1.

	self assert: 200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 11/Oct/2026, 6:57:31 pm (UTC)'!
test03PortfolioWithMultipleAccountsHasTheSumOfTheirBalances

	| portfolio acount1 acount2 |
	acount1 := self accountWithDeposit: 300 andWithdraw: 100.
	acount2 := self accountWithDeposit: 500 andWithdraw: 300.
	portfolio := self createPortfolioWith: acount1 with: acount2.

	self assert: 400 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:47:12 am (UTC)'!
test04PortfolioWithOneSubPortfolioHasItsBalance

	| rootPortfolio childPortfolio |
	childPortfolio := self
		createPortfolioWith: (self accountWithDeposit: 400 andWithdraw: 200)
		with: (self accountWithDeposit: 300 andWithdraw: 200).

	rootPortfolio := self createPortfolioWith: childPortfolio.

	self assert: 300 equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:46:40 am (UTC)'!
test05PortfolioWithMultiplePortfoliossHasTheSumOfTheirBalances

	| rootPortfolio childPortfolio1 childPortfolio2 |
	childPortfolio1 := self
		createPortfolioWith: (self accountWithDeposit: 400 andWithdraw: 200)
		with: (self accountWithDeposit: 300 andWithdraw: 200).
	childPortfolio2 := self createPortfolioWith: (self accountWithBalance: 500).

	rootPortfolio := self createPortfolioWith: childPortfolio1 with: childPortfolio2.

	self assert: 800 equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:46:54 am (UTC)'!
test06PortfolioKnowsRegisteredTransactionsOfItsAccount

	| portfolio acount1 deposit withdraw |
	acount1 := ReceptiveAccount new.
	deposit := Deposit register: 400 on: acount1.
	withdraw := Withdraw register: 200 on: acount1.
	portfolio := self createPortfolioWith: acount1.

	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:47:27 am (UTC)'!
test07PortfolioDoesNotKnowNotRegisteredTransactions

	| portfolio acount1 deposit |
	acount1 := self accountWithDeposit: 400 andWithdraw: 200.
	deposit := Deposit for: 100.
	portfolio := self createPortfolioWith: acount1.

	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:47:32 am (UTC)'!
test08PortfolioKnowsRegisteredTransactionsWhenHavingMultipleAccounts

	| portfolio acount1 acount2 deposit2 withdraw2 |
	acount1 := self accountWithDeposit: 400 andWithdraw: 200.
	acount2 := ReceptiveAccount new.
	deposit2 := Deposit register: 500 on: acount2.
	withdraw2 := Withdraw register: 100 on: acount2.

	portfolio := self createPortfolioWith: acount1 with: acount2.

	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw2).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:47:56 am (UTC)'!
test09EmptyPortfolioHasNoTransactions

	|portofolio|
	portofolio := Portfolio new.

	self assert: OrderedCollection new equals: portofolio transactions .! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 11/Oct/2026, 7:37:59 pm (UTC)'!
test10PortfolioWithOneAccountKnowsItsTransactions

	| portfolio account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	portfolio := self createPortfolioWith: account.

	self assert: (OrderedCollection with: deposit with: withdraw) equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 11/Oct/2026, 7:33:35 pm (UTC)'!
test11PortfolioTransactionsIncludesTransactionsFromAccountsAndNestedPortfolios

	| rootPortfolio childPortfolio account1 account2 account3 deposit1 withdraw1 deposit2 deposit3 expectedTransactions |
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.

	deposit1 := Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.

	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.

	childPortfolio register: account2.

	rootPortfolio register: account1.
	rootPortfolio register: childPortfolio.
	rootPortfolio register: account3.

	expectedTransactions := OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: deposit3.

	self assert: rootPortfolio transactions equals: expectedTransactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 13/Oct/2026, 11:23:38 pm (UTC)'!
test12CannotAddDirectlyTheSameFinancialEntityTwice

	| portfolio acount |

	portfolio := Portfolio new.
	acount := self accountWithBalance: 500.

	portfolio register: acount .
	self
	should: [portfolio register: acount ]
	raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription.
			self assert: 1 equals: portfolio numberOfFinancialEntities.
		]

	! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 14/Oct/2026, 2:09:29 am (UTC)'!
test13CannotAddAccountAlreadyContainedInASubPortfolio

	| rootPortfolio account childPortfolio |
	account := self accountWithBalance: 500.
	rootPortfolio := Portfolio new.
	childPortfolio := self createPortfolioWith: account.

	rootPortfolio register: childPortfolio .

	self
	should: [rootPortfolio register: account ]
	raise:   Error - MessageNotUnderstood
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription .
			self assert: 1 equals: rootPortfolio numberOfFinancialEntities .
		]




! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 14/Oct/2026, 2:10:04 am (UTC)'!
test14PortfolioCannotAddItself

	| account portfolio |
	account := self accountWithBalance: 500.
	portfolio := self createPortfolioWith: account .

	self
	should: [portfolio register: portfolio ]
	raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription .
			self assert: 1 equals: portfolio numberOfFinancialEntities .
		]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 14/Oct/2026, 2:10:44 am (UTC)'!
test15ChildPortfolioCannotAddAccountAlreadyContainerInParent

	| account rootPortfolio childPortfolio|
	account := self accountWithBalance: 500.
	rootPortfolio := self createPortfolioWith: account .
	childPortfolio := Portfolio new.
	rootPortfolio register: childPortfolio .

	self
	should: [childPortfolio register: account ]
	raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription .
			self assert: 0 equals: childPortfolio numberOfFinancialEntities .
			self assert: 2 equals: rootPortfolio numberOfFinancialEntities .
		]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 14/Oct/2026, 2:10:57 am (UTC)'!
test16ChildPortfolioCannotAddAccountAlreadyContainedInGrandParent

	| account rootPortfolio childPortfolio1 childPortfolio2 |
	account := self accountWithBalance: 500.
	rootPortfolio := self createPortfolioWith: account .
	childPortfolio1 := Portfolio new.
	childPortfolio2 := Portfolio new.
	childPortfolio1 register: childPortfolio2 .
	rootPortfolio register: childPortfolio1 .


	self
	should: [childPortfolio2 register: account ]
	raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription .
			self assert: 2 equals: rootPortfolio numberOfFinancialEntities .
			self assert: 1 equals: childPortfolio1 numberOfFinancialEntities .
			self assert: 0 equals: childPortfolio2 numberOfFinancialEntities .
		]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 14/Oct/2026, 1:26:29 am (UTC)'!
test17CannotAddPortfolioWhenSharingAnAccountWithAnotherRegisteredPortfolio

	| account portfolio1 portfolio2 rootPortfolio |
	account := self accountWithBalance: 500.
	portfolio1 := self createPortfolioWith: account.
	portfolio2 := self createPortfolioWith: account.

	rootPortfolio := Portfolio new.
	rootPortfolio register: portfolio1.

	self
		should: [ rootPortfolio register: portfolio2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorDescription.
			self assert: 1 equals: rootPortfolio numberOfFinancialEntities.
		]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 2/Nov/2020, 8:13:44 pm (UTC)'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated

	| account |

	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 2/Nov/2020, 8:13:48 pm (UTC)'!
test02DepositIncreasesBalanceOnTransactionValue

	| account |

	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.

	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 2/Nov/2020, 8:13:52 pm (UTC)'!
test03WithdrawDecreasesBalanceOnTransactionValue

	| account |

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.

	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:20:32 pm (UTC)'!
test04WithdrawValueMustBePositive

	| account withdrawValue |

	account := ReceptiveAccount new.
	withdrawValue := 50.

	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:20:46 pm (UTC)'!
test05ReceptiveAccountKnowsRegisteredTransactions

	| account deposit withdraw |

	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.

	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 17/May/2021, 8:29:53 pm (UTC)'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |

	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.

	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 2/Nov/2020, 8:14:01 pm (UTC)'!
test07AccountKnowsItsTransactions

	| account1 deposit1 |

	account1 := ReceptiveAccount new.

	deposit1 := Deposit register: 50 on: account1.

	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !
