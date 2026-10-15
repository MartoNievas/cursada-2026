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


!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'balance' stamp: 'HAW 12/Oct/2026, 3:49:42 pm (UTC)'!
balance 

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'testing' stamp: 'HAW 12/Oct/2026, 3:51:35 pm (UTC)'!
hasRegistered: aTrasaction


	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 12/Oct/2026, 3:51:24 pm (UTC)'!
manages: anAccount

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 12/Oct/2026, 4:11:02 pm (UTC)'!
managesAnyOf: aFinancialEntity

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'tree structure' stamp: 'HAW 12/Oct/2026, 3:52:25 pm (UTC)'!
addedTo: aPortfolio 
	
	parents add: aPortfolio .! !

!FinancialAsset methodsFor: 'tree structure' stamp: 'HAW 12/Oct/2026, 4:07:43 pm (UTC)'!
rootParents

    parents isEmpty ifTrue: [ ^ Set with: self ].
    ^ parents inject: Set new into: [ :allRoots :eachParent | 
        allRoots addAll: eachParent rootParents. 
        allRoots ]! !


!FinancialAsset methodsFor: 'initialization' stamp: 'HAW 12/Oct/2026, 3:52:56 pm (UTC)'!
initialize

	parents := OrderedCollection new.! !


!FinancialAsset methodsFor: 'transactions' stamp: 'HAW 12/Oct/2026, 3:51:00 pm (UTC)'!
transactions

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
balance

	^ financialAssets sum: [:aFinancialAsset | aFinancialAsset balance ] ifEmpty: 0.
	! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 15/Oct/2026, 4:14:55 pm (UTC)'!
transactions

    ^ financialAssets 
        inject: OrderedCollection new 
        into: [ :aFinancialAssetCollection :aFinancialAsset | 
            aFinancialAssetCollection addAll: aFinancialAsset transactions. 
            aFinancialAssetCollection ]! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
accountsIncludes: aFinancialAsset

	^ financialAssets includes: aFinancialAsset .! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
accountsIsEmpty

	^ financialAssets isEmpty ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
accountsSize

	^ financialAssets size.! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:14:31 pm (UTC)'!
hasRegistered: aTrasaction

	^ financialAssets anySatisfy: [:aFinancialAsset | aFinancialAsset hasRegistered: aTrasaction ] .! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
manages: aFinancialAssetToAdd

	^ self = aFinancialAssetToAdd or: [financialAssets anySatisfy: [:aFinancialEntity | aFinancialEntity manages: aFinancialAssetToAdd ]].! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
managesAnyOf: aFinancialAssetToAdd

	^ (aFinancialAssetToAdd manages: self) or: [ 
		financialAssets anySatisfy: [ :aCurrentPortfolioFinancialEntity | aCurrentPortfolioFinancialEntity managesAnyOf: aFinancialAssetToAdd ] ]! !


!Portfolio methodsFor: 'asserting' stamp: 'HAW 15/Oct/2026, 4:13:59 pm (UTC)'!
assertCanAdd: aFinancialAssetToAdd

	(self rootParents anySatisfy: [ :aParentRoot | aParentRoot managesAnyOf: aFinancialAssetToAdd ])
		ifTrue: [ self signalCannotAddAcount ]! !


!Portfolio methodsFor: 'error handling' stamp: 'HAW 12/Oct/2026, 4:39:19 am (UTC)'!
signalCannotAddAcount

	^ self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'adding' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
add: aFinancialAssetToAdd
	self assertCanAdd: aFinancialAssetToAdd.
	financialAssets add: aFinancialAssetToAdd .
	aFinancialAssetToAdd addedTo: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 15/Oct/2026, 4:14:19 pm (UTC)'!
initialize
	
	super initialize .
	financialAssets := OrderedCollection new.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 15/Oct/2026, 4:12:41 pm (UTC)'!
with: aFinancialAsset

	| portfolio |
	portfolio := self new.
	portfolio add: aFinancialAsset.

	^ portfolio! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 15/Oct/2026, 4:12:53 pm (UTC)'!
with: aFinancialAsset with: anAnotherFinancialAsset

	| portfolio |
	portfolio := self new.
	portfolio add: aFinancialAsset.
	portfolio add: anAnotherFinancialAsset.
	^ portfolio! !


!Portfolio class methodsFor: 'error description' stamp: 'HAW 15/Oct/2026, 4:13:10 pm (UTC)'!
canNotAddAccountErrorMessage

	^'Cannot add financial asset because it already exists in the portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HAW 12/Oct/2026, 3:52:44 pm (UTC)'!
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

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 12/Oct/2026, 4:47:02 am (UTC)'!
manages: anAccount

	^ self = anAccount .! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 12/Oct/2026, 4:16:27 pm (UTC)'!
managesAnyOf: aFinancialEntity

	^ aFinancialEntity manages: self.! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:38:25 pm (UTC)'!
test01EmptyPortfolioHasZeroBalance

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.
	self assert: portfolio accountsIsEmpty.
	self assert: 0 equals: portfolio accountsSize.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:39:02 pm (UTC)'!
test02PortfolioWithOneAccountHasItsBalance

	| portfolio account1 |
	account1 := self accountWithDeposit: 300 andWithdraw: 100.
	portfolio := Portfolio with: account1.

	self assert: 200 equals: portfolio balance.
	self assert: 1 equals: portfolio accountsSize.
	self assert: (portfolio accountsIncludes: account1).
	self deny: portfolio accountsIsEmpty.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:39:13 pm (UTC)'!
test03PortfolioWithMultipleAccountsHasTheSumOfTheirBalances

	| portfolio account1 account2 |
	account1 := self accountWithDeposit: 300 andWithdraw: 100.
	account2 := self accountWithDeposit: 500 andWithdraw: 300.
	portfolio := Portfolio with: account1 with: account2.

	self assert: 400 equals: portfolio balance.
	self assert: 2 equals: portfolio accountsSize.
	self assert: (portfolio accountsIncludes: account1).
	self assert: (portfolio accountsIncludes: account2).
	self deny: portfolio accountsIsEmpty.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:34:48 pm (UTC)'!
test04PortfolioWithOneSubPortfolioHasItsBalance

	| rootPortfolio childPortfolio account1 account2 |
	account1 := self accountWithDeposit: 400 andWithdraw: 200.
	account2 := self accountWithDeposit: 300 andWithdraw: 200.
	childPortfolio := Portfolio 
		with: account1 
		with: account2 .

	rootPortfolio := Portfolio with: childPortfolio.

	self assert: 300 equals: rootPortfolio balance.
	self assert: (childPortfolio accountsIncludes: account1 ).
	self assert: (childPortfolio accountsIncludes: account2 ).
	self assert: (rootPortfolio accountsIncludes: childPortfolio ).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:37:19 pm (UTC)'!
test05PortfolioWithMultiplePortfoliossHasTheSumOfTheirBalances

	| rootPortfolio childPortfolio1 childPortfolio2 account1 account2 account3 |
	account1 := self accountWithDeposit: 400 andWithdraw: 200.
	account2 := self accountWithDeposit: 300 andWithdraw: 200.
	account3 := self accountWithBalance: 500.

	childPortfolio1 := Portfolio with: account1 with: account2.
	childPortfolio2 := Portfolio with: account3.

	rootPortfolio := Portfolio with: childPortfolio1 with: childPortfolio2.

	self assert: 800 equals: rootPortfolio balance.
	self assert: 2 equals: rootPortfolio accountsSize.
	self assert: (rootPortfolio accountsIncludes: childPortfolio1).
	self assert: (rootPortfolio accountsIncludes: childPortfolio2).
	self deny: (rootPortfolio accountsIncludes: account1).
	self deny: (rootPortfolio accountsIncludes: account2).
	self deny: (rootPortfolio accountsIncludes: account3).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:37:56 pm (UTC)'!
test06PortfolioKnowsRegisteredTransactionsOfItsAccount

	| portfolio account1 deposit withdraw |
	account1 := ReceptiveAccount new.
	deposit := Deposit register: 400 on: account1.
	withdraw := Withdraw register: 200 on: account1.
	portfolio := Portfolio with: account1.

	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).
	self assert: 1 equals: portfolio accountsSize.
	self assert: (portfolio accountsIncludes: account1).
	self deny: portfolio accountsIsEmpty.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:19:24 pm (UTC)'!
test07PortfolioDoesNotKnowNotRegisteredTransactions

	| portfolio acount1 deposit |
	acount1 := self accountWithDeposit: 400 andWithdraw: 200.
	deposit := Deposit for: 100.
	portfolio := Portfolio with: acount1.

	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:19:37 pm (UTC)'!
test08PortfolioKnowsRegisteredTransactionsWhenHavingMultipleAccounts

	| portfolio acount1 acount2 deposit2 withdraw2 |
	acount1 := self accountWithDeposit: 400 andWithdraw: 200.
	acount2 := ReceptiveAccount new.
	deposit2 := Deposit register: 500 on: acount2.
	withdraw2 := Withdraw register: 100 on: acount2.

	portfolio := Portfolio with: acount1 with: acount2.

	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw2).! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 12/Oct/2026, 1:47:56 am (UTC)'!
test09EmptyPortfolioHasNoTransactions
	
	|portofolio|
	portofolio := Portfolio new.
	
	self assert: OrderedCollection new equals: portofolio transactions .! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:19:52 pm (UTC)'!
test10PortfolioWithOneAccountKnowsItsTransactions

	| portfolio account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	portfolio := Portfolio with: account.

	self assert: (OrderedCollection with: deposit with: withdraw) equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:22:31 pm (UTC)'!
test11PortfolioTransactionsIncludesTransactionsFromAccountsAndNestedPortfolios

	| rootPortfolio childPortfolio account1 account2 account3 deposit1 withdraw1 deposit2 deposit3 expectedTransactions |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.

	deposit1 := Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.

	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.

	childPortfolio := Portfolio with: account2.
	rootPortfolio := Portfolio with: account1 with: childPortfolio.
	rootPortfolio add: account3.

	expectedTransactions := OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: deposit3.

	self assert: rootPortfolio transactions equals: expectedTransactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test12PortfolioCanNotAddTheSameAccountTwice

	| portfolio acount |
	acount := self accountWithBalance: 500.
	portfolio := Portfolio with: acount .

	self
	should: [portfolio add: acount ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText .
			self assert: portfolio accountsSize equals: 1.
		].! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test13PortfolioCanNotAddItself

	| portfolio |
	portfolio := Portfolio new.

	self
	should: [portfolio add: portfolio ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText .
			self assert: portfolio accountsSize equals: 0.
		].! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test14PortfolioCanNotAddAccountAlreadyIncludedInChildPortfolio

	| rootPortfolio acount childPortfolio |
	acount := ReceptiveAccount new.
	childPortfolio := Portfolio with: acount .
	rootPortfolio := Portfolio with: childPortfolio .

	self
	should: [rootPortfolio add: acount ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText .
			self assert: rootPortfolio accountsSize equals: 1.
		].! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test15ChildPortfolioCanNotAddAccountAlreadyIncludedInParentPortfolio

	| rootPortfolio acount childPortfolio |
	acount := ReceptiveAccount new.
	childPortfolio := Portfolio new.
	rootPortfolio := Portfolio with: acount with: childPortfolio .


	self
	should: [childPortfolio add: acount ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText .
			self assert: rootPortfolio accountsSize equals: 2.
		].! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test16ChildPortfolioCanNotAddAccountAlreadyIncludedInGrandParentPortfolio

	| grandParent parent child account |
	account := ReceptiveAccount new.
	child := Portfolio new.
	parent := Portfolio with: child.
	grandParent := Portfolio with: account with: parent.

	self 
		should: [ child add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: child accountsSize equals: 0 ].! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 15/Oct/2026, 4:32:17 pm (UTC)'!
test17PortfolioCanNotAddAnotherPortfolioSharingAnAccount

	| rootPortfolio child1 child2 sharedAccount |
	sharedAccount := ReceptiveAccount new.
	child1 := Portfolio with: sharedAccount.
	child2 := Portfolio with: sharedAccount.
	rootPortfolio := Portfolio with: child1.

	self 
		should: [ rootPortfolio add: child2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: rootPortfolio accountsSize equals: 1 ].! !


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
