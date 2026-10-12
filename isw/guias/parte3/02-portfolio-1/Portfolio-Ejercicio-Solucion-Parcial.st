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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'financialEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'HAW 11/Oct/2026, 6:58:44 pm (UTC)'!
balance

	^ financialEntities sum: [:anAcount | anAcount balance ] ifEmpty: 0.
	! !


!Portfolio methodsFor: 'register' stamp: 'HAW 11/Oct/2026, 6:58:14 pm (UTC)'!
register: anAcount

	financialEntities add: anAcount .
	! !

!Portfolio methodsFor: 'register' stamp: 'HAW 11/Oct/2026, 7:35:53 pm (UTC)'!
transactions
	^ financialEntities inject: OrderedCollection new into: [:acc :aFinancialEntity | acc addAll: aFinancialEntity transactions. acc ].

! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 11/Oct/2026, 7:07:35 pm (UTC)'!
hasRegistered: aTrasaction

	^ financialEntities anySatisfy: [:aFinancialEntity | aFinancialEntity hasRegistered: aTrasaction ] .! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 11/Oct/2026, 6:58:20 pm (UTC)'!
initialize

	financialEntities := OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 17/Oct/2019, 6:06:56 pm (UTC)'!
initialize

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
