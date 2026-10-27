!classDefinition: #Account category: 'Portfolio2'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Account methodsFor: 'testing' stamp: 'HAW 25/May/2019, 3:23:47 pm (UTC)'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 25/May/2019, 3:24:25 pm (UTC)'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 25/May/2019, 3:23:40 pm (UTC)'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 25/May/2019, 3:23:27 pm (UTC)'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 25/May/2019, 3:23:15 pm (UTC)'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:20:45 pm (UTC)'!
accept: anAccountReport

	self subclassResponsibility .! !

!Account methodsFor: 'visiting' stamp: 'AP 26/Oct/2026, 3:06:10 pm (UTC)'!
transactionsDo: aBlock

	self subclassResponsibility .! !


!Account methodsFor: 'composition' stamp: 'HAW 25/May/2019, 3:24:04 pm (UTC)'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'AP 26/Oct/2026, 2:08:14 pm (UTC)'!
initializeNamed: aName
	name := aName.! !


!Account methodsFor: 'accessing' stamp: 'AP 26/Oct/2026, 2:39:45 pm (UTC)'!
name
	^ name.! !


!classDefinition: #Portfolio category: 'Portfolio2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 25/May/2019, 2:49:20 pm (UTC)'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 25/May/2019, 3:05:04 pm (UTC)'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 25/May/2019, 2:49:06 pm (UTC)'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 25/May/2019, 3:19:20 pm (UTC)'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 25/May/2019, 3:17:31 pm (UTC)'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 25/May/2019, 3:03:18 pm (UTC)'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 25/May/2019, 2:19:36 pm (UTC)'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 25/May/2019, 2:42:55 pm (UTC)'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 25/May/2019, 2:38:32 pm (UTC)'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 25/May/2019, 3:02:59 pm (UTC)'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 25/May/2019, 3:20:56 pm (UTC)'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 25/May/2019, 2:28:29 pm (UTC)'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 29/May/2019, 7:24:54 pm (UTC)'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 25/May/2019, 3:17:31 pm (UTC)'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 25/May/2019, 3:20:36 pm (UTC)'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 25/May/2019, 2:48:34 pm (UTC)'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:31:01 pm (UTC)'!
accept: anAccountReport

	^ anAccountReport visitPortfolio: self.
! !

!Portfolio methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:36:37 pm (UTC)'!
accountsDo: aBlock

	^ accounts do: aBlock .! !

!Portfolio methodsFor: 'visiting' stamp: 'AP 26/Oct/2026, 3:06:10 pm (UTC)'!
transactionsDo: aBlock

	^ accounts do: [:anAccount | anAccount transactionsDo: aBlock ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 27/Oct/2026, 3:22:02 pm (UTC)'!
named: aNameForPortfolio

	^ self new initializeNamed: aNameForPortfolio ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 27/Oct/2026, 3:22:09 pm (UTC)'!
named: aNameForPortfolio with: aFinancialAsset

	^ self named: aNameForPortfolio; add: aFinancialAsset ; yourself .! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 27/Oct/2026, 3:25:48 pm (UTC)'!
named: aName with: anAccount with: anotherAccount
	
	^(self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 25/May/2019, 2:18:21 pm (UTC)'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 25/May/2019, 2:23:59 pm (UTC)'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 25/May/2019, 2:48:55 pm (UTC)'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AP 26/Oct/2026, 2:09:20 pm (UTC)'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 25/May/2019, 2:38:52 pm (UTC)'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AP 26/Oct/2026, 2:44:21 pm (UTC)'!
register: aTransaction

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 13/Jul/2011, 9:37:00 pm (UTC)'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 25/May/2019, 2:24:46 pm (UTC)'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 21/Oct/2019, 9:55:56 pm (UTC)'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 25/May/2019, 2:54:51 pm (UTC)'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 25/May/2019, 3:03:32 pm (UTC)'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:31:27 pm (UTC)'!
accept: anAccountReport

	^ anAccountReport visitReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'visiting' stamp: 'AP 26/Oct/2026, 3:06:10 pm (UTC)'!
transactionsDo: aBlock

	^ transactions do: aBlock .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'AP 26/Oct/2026, 2:08:49 pm (UTC)'!
named: aName
	^ self new initializeNamed: aName.! !


!classDefinition: #AccountReport category: 'Portfolio2'!
Object subclass: #AccountReport
	instanceVariableNames: 'financialAsset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:51:25 pm (UTC)'!
visitDeposit: aDeposit 

	self subclassResponsibility .! !

!AccountReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:51:21 pm (UTC)'!
visitDepositLeg: aDepositLeg 

	self subclassResponsibility .! !

!AccountReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:53:45 pm (UTC)'!
visitPortfolio: aPortfolio

	 aPortfolio accountsDo: [:anAccount | anAccount accept: self].! !

!AccountReport methodsFor: 'visiting' stamp: 'AP 26/Oct/2026, 3:06:10 pm (UTC)'!
visitReceptiveAccount: aReceptiveAccount

	 aReceptiveAccount transactionsDo: [:aTrasaction | aTrasaction accept: self].! !

!AccountReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:51:42 pm (UTC)'!
visitWithdraw: aWithdraw 

	self subclassResponsibility .! !

!AccountReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:51:53 pm (UTC)'!
visitWithdrawLeg: aWithdrawLeg 

	self subclassResponsibility .! !



!AccountReport methodsFor: 'initialization' stamp: 'HAW 26/Oct/2026, 1:17:42 pm (UTC)'!
initializeFor: aFinancialAsset
	
	financialAsset := aFinancialAsset .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio2'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'HAW 27/Oct/2026, 3:07:04 pm (UTC)'!
on: aFinancialAsset

	^ self new initializeFor: aFinancialAsset .! !


!classDefinition: #AccountSummary category: 'Portfolio2'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountSummary methodsFor: 'report' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
lines
	
	financialAsset accept: self.
	lines add: 'Balance = ', financialAsset balance asString.
	^ lines! !


!AccountSummary methodsFor: 'initialization' stamp: 'HAW 26/Oct/2026, 1:40:04 pm (UTC)'!
initializeFor: aFinancialAsset

	super initializeFor: aFinancialAsset .
	lines := OrderedCollection new.! !


!AccountSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:44:46 pm (UTC)'!
visitDeposit: aDeposit 
	
	lines add: 'Deposito por ', aDeposit value asString .! !

!AccountSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:47:57 pm (UTC)'!
visitDepositLeg: aDepositLeg 
	
	lines add: 'Entrada por transferencia de ', aDepositLeg value asString.! !

!AccountSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:43:56 pm (UTC)'!
visitWithdraw: aWithdraw 
	
	^ lines add: 'Extraccion por ', aWithdraw value asString.! !

!AccountSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:46:47 pm (UTC)'!
visitWithdrawLeg: aWithdrawLeg 
	
	lines add: 'Salida por transferencia de ', aWithdrawLeg value asString! !


!classDefinition: #AccountTransferNet category: 'Portfolio2'!
AccountReport subclass: #AccountTransferNet
	instanceVariableNames: 'transferNetBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransferNet methodsFor: 'initialization' stamp: 'HAW 26/Oct/2026, 1:54:37 pm (UTC)'!
initializeFor: aFinancialAsset

	super initializeFor: aFinancialAsset .
	transferNetBalance := 0.! !


!AccountTransferNet methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:55:08 pm (UTC)'!
visitDeposit: aDeposit

	! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:55:25 pm (UTC)'!
visitDepositLeg: aDepositLeg

	transferNetBalance := transferNetBalance + aDepositLeg value .! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:52:48 pm (UTC)'!
visitWithdraw: aWithdraw ! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:55:39 pm (UTC)'!
visitWithdrawLeg: aWithdrawLeg 

	transferNetBalance := transferNetBalance - aWithdrawLeg value .! !


!AccountTransferNet methodsFor: 'report' stamp: 'HAW 27/Oct/2026, 3:19:00 pm (UTC)'!
value
	
	financialAsset accept: self.
	^ transferNetBalance .! !


!classDefinition: #PortfolioTreeReport category: 'Portfolio2'!
AccountReport subclass: #PortfolioTreeReport
	instanceVariableNames: 'lines indentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioTreeReport methodsFor: 'report' stamp: 'HAW 27/Oct/2026, 3:29:26 pm (UTC)'!
lines
	
	financialAsset accept: self.
	^ lines! !


!PortfolioTreeReport methodsFor: 'initialization' stamp: 'HAW 26/Oct/2026, 4:16:43 pm (UTC)'!
initializeFor: aFinancialAsset

	super initializeFor: aFinancialAsset .
	lines := OrderedCollection new.
	indentationLevel := 0.! !


!PortfolioTreeReport methodsFor: 'indentation' stamp: 'HAW 27/Oct/2026, 3:24:24 pm (UTC)'!
currentIndentation
    ^ String new: indentationLevel * 3 withAll: Character space.! !

!PortfolioTreeReport methodsFor: 'indentation' stamp: 'HAW 26/Oct/2026, 4:18:18 pm (UTC)'!
indentDuring: aBlock

	indentationLevel := indentationLevel + 1.
	aBlock ensure: [ indentationLevel := indentationLevel - 1 ]! !


!PortfolioTreeReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:33:30 pm (UTC)'!
visitPortfolio: aPortfolio

	self subclassResponsibility .! !

!PortfolioTreeReport methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:33:24 pm (UTC)'!
visitReceptiveAccount: aReceptiveAccount

	self subclassResponsibility .! !


!PortfolioTreeReport methodsFor: 'printing' stamp: 'HAW 26/Oct/2026, 4:18:14 pm (UTC)'!
addLine: aString

	lines add: self currentIndentation , aString.! !


!classDefinition: #PortfolioSummary category: 'Portfolio2'!
PortfolioTreeReport subclass: #PortfolioSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:36:41 pm (UTC)'!
visitDeposit: aDeposit 

	self addLine: 'Deposito por ', aDeposit value asString.
! !

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:37:31 pm (UTC)'!
visitDepositLeg: aDepositLeg 

	self addLine: 'Entrada por transferencia de ', aDepositLeg value asString.
! !

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 27/Oct/2026, 3:31:43 pm (UTC)'!
visitPortfolio: aPortfolio
    self addLine: aPortfolio name.
    self indentDuring: [
        aPortfolio accountsDo: [ :anAccount | anAccount accept: self ].
    ].
    self addLine: 'Balance = ' , aPortfolio balance asString.! !

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
visitReceptiveAccount: aReceptiveAccount

	| accountSummaryLines |
	self addLine: aReceptiveAccount name.
	accountSummaryLines := (AccountSummary on: aReceptiveAccount) lines.
	self indentDuring: [
		accountSummaryLines do: [ :aLine | self addLine: aLine ]
	].! !

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:37:01 pm (UTC)'!
visitWithdraw: aWithdraw 
	
	self addLine: 'Extraccion por ', aWithdraw value asString.
! !

!PortfolioSummary methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:37:16 pm (UTC)'!
visitWithdrawLeg: aWithdrawLeg 

	self addLine: 'Salida por transferencia de ', aWithdrawLeg value asString.
! !


!classDefinition: #PortfolioTreePrinter category: 'Portfolio2'!
PortfolioTreeReport subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 4:19:08 pm (UTC)'!
visitPortfolio: aPortfolio
	self addLine: aPortfolio name.
	self indentDuring: [
		aPortfolio accountsDo: [ :anAccount | anAccount accept: self ].
	].! !

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 4:20:32 pm (UTC)'!
visitReceptiveAccount: aReceptiveAccount

	self addLine: aReceptiveAccount name.! !


!classDefinition: #AccountTransaction category: 'Portfolio2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 12/Sep/2011, 3:25:00 pm (UTC)'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:50:33 pm (UTC)'!
accept: anAccountReport

	self subclassResponsibility .! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 25/May/2019, 2:25:39 pm (UTC)'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 22/Oct/2026, 2:09:22 pm (UTC)'!
affectTransferBalance: aCurrentBalance

	^ aCurrentBalance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 21/Oct/2019, 9:54:27 pm (UTC)'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 13/Jul/2011, 9:45:00 pm (UTC)'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 13/Jul/2011, 9:38:00 pm (UTC)'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 25/May/2019, 2:25:02 pm (UTC)'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:42:07 pm (UTC)'!
accept: anAccountReport

	anAccountReport visitDeposit: self
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 13/Jul/2011, 9:38:00 pm (UTC)'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'associatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferLeg methodsFor: 'testing' stamp: 'HAW 27/Oct/2026, 3:14:31 pm (UTC)'!
transfer

	^ associatedTransfer.! !


!TransferLeg methodsFor: 'initialization' stamp: 'HAW 21/Oct/2026, 12:52:51 am (UTC)'!
initializeFor: anAmountToWithdraw of: anAssociatedTransaction

	associatedTransfer := anAssociatedTransaction .! !


!TransferLeg methodsFor: 'balance' stamp: 'HAW 21/Oct/2026, 12:53:20 am (UTC)'!
affectBalance: aBalance

	self subclassResponsibility .! !

!TransferLeg methodsFor: 'balance' stamp: 'HAW 22/Oct/2026, 2:09:35 pm (UTC)'!
affectTransferBalance: aCurrentBalance

	self subclassResponsibility .! !


!TransferLeg methodsFor: 'value' stamp: 'HAW 21/Oct/2026, 12:56:20 am (UTC)'!
value

	^associatedTransfer value.! !


!TransferLeg methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 6:40:46 pm (UTC)'!
accept: anAccountReport 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 21/Oct/2026, 12:52:33 am (UTC)'!
register: anAmountToTransfer on: aDestinationAccount of: anAssociatedTransaction
	|deposit|
	deposit := self new.
	aDestinationAccount register: deposit .
	
	^ deposit initializeFor: anAmountToTransfer of: anAssociatedTransaction .! !


!classDefinition: #DepositLeg category: 'Portfolio2'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!DepositLeg methodsFor: 'balance' stamp: 'HAW 21/Oct/2026, 12:54:12 am (UTC)'!
affectBalance: aBalance

	^ aBalance + self value .! !


!DepositLeg methodsFor: 'testing' stamp: 'HAW 27/Oct/2026, 3:14:31 pm (UTC)'!
transfer

	^ associatedTransfer.! !

!DepositLeg methodsFor: 'testing' stamp: 'HAW 27/Oct/2026, 3:15:01 pm (UTC)'!
withdrawLeg

	^ associatedTransfer withdrawLeg .! !


!DepositLeg methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:47:25 pm (UTC)'!
accept: anAccountReport 

	anAccountReport visitDepositLeg: self ! !


!classDefinition: #WithdrawLeg category: 'Portfolio2'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!WithdrawLeg methodsFor: 'balance' stamp: 'HAW 21/Oct/2026, 12:54:33 am (UTC)'!
affectBalance: aBalance

	^ aBalance - self value .! !


!WithdrawLeg methodsFor: 'testing' stamp: 'HAW 27/Oct/2026, 3:15:15 pm (UTC)'!
depositLeg

	^ associatedTransfer depositLeg .! !

!WithdrawLeg methodsFor: 'testing' stamp: 'HAW 27/Oct/2026, 3:14:31 pm (UTC)'!
transfer

	^associatedTransfer! !


!WithdrawLeg methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:46:09 pm (UTC)'!
accept: anAccountReport

	anAccountReport visitWithdrawLeg: self ! !


!classDefinition: #Withdraw category: 'Portfolio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 13/Jul/2011, 9:46:00 pm (UTC)'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 13/Jul/2011, 9:33:00 pm (UTC)'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 25/May/2019, 2:25:15 pm (UTC)'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visiting' stamp: 'HAW 26/Oct/2026, 1:43:31 pm (UTC)'!
accept: anAccountReport 
	
	anAccountReport visitWithdraw: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 13/Jul/2011, 9:33:00 pm (UTC)'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio2'!
Object subclass: #Transfer
	instanceVariableNames: 'sourceAccount destinationAccount value withdrawTransfer depositTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Transfer methodsFor: 'testing' stamp: 'HAW 21/Oct/2026, 12:55:30 am (UTC)'!
depositLeg
	^ depositTransfer .! !

!Transfer methodsFor: 'testing' stamp: 'HAW 21/Oct/2026, 12:55:20 am (UTC)'!
withdrawLeg
	^ withdrawTransfer .! !


!Transfer methodsFor: 'value' stamp: 'HAW 21/Oct/2026, 12:51:35 am (UTC)'!
value

	^ value ! !


!Transfer methodsFor: 'initialization' stamp: 'HAW 21/Oct/2026, 12:51:35 am (UTC)'!
initializeFrom: aSourceAccount to: aDestinationAccount withAmount: anAmountToTransfer   .

	sourceAccount := aSourceAccount .
	destinationAccount := aDestinationAccount .
	value := anAmountToTransfer .
	depositTransfer := DepositLeg register: anAmountToTransfer on: aDestinationAccount of: self .
	withdrawTransfer := WithdrawLeg register: anAmountToTransfer on: aSourceAccount of: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error description' stamp: 'HAW 20/Oct/2026, 11:44:35 pm (UTC)'!
amountMustBeStrictlyPositiveErrorDescription

	^'Amount must be strictly positive'! !

!Transfer class methodsFor: 'error description' stamp: 'AP 26/Oct/2026, 3:34:27 pm (UTC)'!
cantTransferToYourselfErrorDescription

	^'You cant transfer money to yourself!!'.! !


!Transfer class methodsFor: 'instance creation' stamp: 'HAW 27/Oct/2026, 3:05:07 pm (UTC)'!
register: anAmountToTransfer from: aSourceAccount to: aDestinationAccount
	
	self assertAmountIsGreaterThanZero: anAmountToTransfer .
	self assertNotTransferingTo: aSourceAccount whileBeingPossiblyYourself: aDestinationAccount.
	
	^self new initializeFrom: aSourceAccount to: aDestinationAccount withAmount: anAmountToTransfer.

! !


!Transfer class methodsFor: 'asserting' stamp: 'HAW 20/Oct/2026, 11:44:48 pm (UTC)'!
assertAmountIsGreaterThanZero: anAmountToTransfer

	anAmountToTransfer strictlyPositive ifFalse: [self error: self amountMustBeStrictlyPositiveErrorDescription ]! !

!Transfer class methodsFor: 'asserting' stamp: 'AP 26/Oct/2026, 3:34:27 pm (UTC)'!
assertNotTransferingTo: aSourceAccount whileBeingPossiblyYourself: aPossiblyYourselfAccount

	aSourceAccount == aPossiblyYourselfAccount ifTrue: [self error: self cantTransferToYourselfErrorDescription ].! !


!classDefinition: #AccountReportsTest category: 'Portfolio2'!
TestCase subclass: #AccountReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test01AnEmptyAccountHasEmptySummaryReport

	|account accountReport |
	account := ReceptiveAccount new.
	accountReport := AccountSummary on: account .
	
	self assert: accountReport lines equals: (OrderedCollection with: 'Balance = 0').! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test02AnAccountWithoutTransfersHasAnAccountSummaryWithoutTransfers

	|account expectedSummary accountReport |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account .
	accountReport := AccountSummary on: account .
	
	expectedSummary := OrderedCollection with: 'Deposito por 100' with: 'Extraccion por 50' with: 'Balance = 50'.
	
	self assert: accountReport lines equals: expectedSummary .! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test03AnAccountWithTransfersHasAccountSummaryWithTransferReport

	|account1 expectedSummaryAccount1 account2 expectedSummaryAccount2 accountReport1 accountReport2 |
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1 .
	account2 := ReceptiveAccount new.
	Transfer register: 100 from: account1  to: account2 .
	Transfer register: 50 from: account2  to: account1 .
	
	accountReport1 := AccountSummary on: account1. 
	accountReport2 := AccountSummary on: account2 .
	
	
	
	expectedSummaryAccount1 := OrderedCollection with: 'Deposito por 100' with: 'Salida por transferencia de 100' with: 'Entrada por transferencia de 50' with: 'Balance = 50'.
	expectedSummaryAccount2 := OrderedCollection with: 'Entrada por transferencia de 100' with: 'Salida por transferencia de 50' with: 'Balance = 50'..
	
	self assert: accountReport1 lines equals: expectedSummaryAccount1 .
	self assert: accountReport2 lines equals: expectedSummaryAccount2 .! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test04EmptyPortfolioAccountSummaryHasOnlyZeroBalance

    | portfolio expectedSummary portfolioReport |
    
    portfolio := Portfolio new.
    expectedSummary := OrderedCollection with: 'Balance = 0'.
    portfolioReport := AccountSummary on: portfolio .
    
    self assert: expectedSummary equals: portfolioReport lines! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test05PortfolioAccountSummaryIncludesDirectAccountsTransactions

    | account1 account2 portfolio expectedSummary portfolioReport |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    Deposit register: 100 on: account1.
    Withdraw register: 30 on: account2.
    
    portfolio := Portfolio with: account1 with: account2.
    portfolioReport := AccountSummary on: portfolio .  

    expectedSummary := OrderedCollection new.
    expectedSummary add: 'Deposito por 100'.
    expectedSummary add: 'Extraccion por 30'.
    expectedSummary add: 'Balance = 70'.
    
    self assert: expectedSummary equals: portfolioReport lines! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:30 pm (UTC)'!
test06ComposedPortfolioAccountSummaryIncludesSubportfolioTransactions

    | account1 account2 childPortfolio rootPortfolio expectedSummary rootReport |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    Deposit register: 100 on: account1.
    Withdraw register: 30 on: account2.
    
    childPortfolio := Portfolio with: account1.
    rootPortfolio := Portfolio with: childPortfolio with: account2.
    rootReport := AccountSummary on: rootPortfolio .

    expectedSummary := OrderedCollection new.
    expectedSummary add: 'Deposito por 100'.
    expectedSummary add: 'Extraccion por 30'.
    expectedSummary add: 'Balance = 70'.
    
    self assert: expectedSummary equals: rootReport lines! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:18:45 pm (UTC)'!
test07AnAccountWithOnlyTransferHasNetReportEqualsToBalance

	| account1 account2 transferNet1 transferNet2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer  register:  100 from: account1  to: account2 . 
	transferNet1 := AccountTransferNet on: account1 .
	transferNet2 := AccountTransferNet on: account2 .
	
	self assert: transferNet1 value equals: -100.
	self assert: transferNet2 value equals: 100.
	! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:19:08 pm (UTC)'!
test08AnEmptyPortfolioHasNetTranferEqualsZero

	|portfolio portfolioTransferNet |
	portfolio := Portfolio new.
	portfolioTransferNet := AccountTransferNet on: portfolio .
	
	self assert: portfolioTransferNet value equals: 0.	! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:19:16 pm (UTC)'!
test09AnAccountWithTransferAndTrasactionsHasNetReportEqualsToSumOfTransfersAmount

	| account1 account2 transferNet1 transferNet2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on: account1 .
	Withdraw register: 50 on: account1.
	Transfer  register:  100 from: account1  to: account2 . 
	
	transferNet1 := AccountTransferNet on: account1 .
	transferNet2 := AccountTransferNet on: account2 .
	
	
	self assert: transferNet1 value equals: -100.
	self assert: transferNet2 value equals: 100.
	! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:19:20 pm (UTC)'!
test10APortfolioWithAccountWithOnlyTransfersHasNetReportIsSumTransfersAmount

	|portfolio account1 account2 portfolioTransferNet |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer register: 100 from: account1  to: account2.
	portfolio := Portfolio with: account1 .
	
	portfolioTransferNet := AccountTransferNet on: portfolio .
	
	self assert: portfolioTransferNet value equals: -100.	! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:19:26 pm (UTC)'!
test11ComposedPortfolioTransferNetReportConsidersSubportfolios

    | rootPortfolio childPortfolio account1 account2 account3 rootTransferNet |
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.
    
    Deposit register: 200 on: account1.
    Withdraw register: 50 on: account1.
    Transfer register: 100 from: account2 to: account1.
    Transfer register: 30 from: account1 to: account3.
    
    childPortfolio := Portfolio with: account1.
    rootPortfolio := Portfolio with: childPortfolio with: account3.
    rootTransferNet := AccountTransferNet on: rootPortfolio .  

    self assert: rootTransferNet value equals: 100.! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:29:26 pm (UTC)'!
test12TreeStructureReportForASimplePortfolio

	| account1 account2 portfolio treeReport expectedReport |
	account1 := ReceptiveAccount named: 'Juancete01'.
	account2 := ReceptiveAccount named: 'ElMomoLaDinastia'.
	
	portfolio := Portfolio named: 'Portfolio de la CoscuArmy' with: account1 with: account2.
	treeReport := PortfolioTreePrinter on: portfolio.
	
	expectedReport := OrderedCollection with: 'Portfolio de la CoscuArmy' with: '   Juancete01' with: '   ElMomoLaDinastia'.
	
	self assert: expectedReport equals: treeReport lines .
	
	! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:29:26 pm (UTC)'!
test13TreeStructureReportForPortfolioWithSubPortfolios

    | account1 account2 portfolio1 treeReport expectedReport account3 portfolio2 |
    account1 := ReceptiveAccount named: 'Juancete01'.
    account2 := ReceptiveAccount named: 'ElMomoLaDinastia'.
    account3 := ReceptiveAccount named: 'ElVikingo'.

    portfolio2 := Portfolio named: 'Portfolio Fantasmagorico' with: account2 with: account3.
    portfolio1 := Portfolio named: 'Portfolio de la CoscuArmy' with: account1 with: portfolio2.
    treeReport := PortfolioTreePrinter on: portfolio1.

    expectedReport := OrderedCollection 
        with: 'Portfolio de la CoscuArmy' 
        with: '   Juancete01' 
        with: '   Portfolio Fantasmagorico' 
        with: '      ElMomoLaDinastia' 
        with: '      ElVikingo'.

    self assert: expectedReport equals: treeReport lines.! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:33:32 pm (UTC)'!
test14PortfolioTreePrinterSummaryForAPortfolioWithAccountsWithDeposits

    | account1 account2 portfolio1 treeSummaryReport expectedReport |
    account1 := ReceptiveAccount named: 'Juancete01'.
    account2 := ReceptiveAccount named: 'ElMomoLaDinastia'.
    Deposit register: 100 on: account1. 
    Deposit register: 67 on: account2. 
    
    portfolio1 := Portfolio named: 'Portfolio de la CoscuArmy' with: account1 with: account2.
    treeSummaryReport := PortfolioSummary on: portfolio1.
    
    expectedReport := OrderedCollection new.
    expectedReport add: 'Portfolio de la CoscuArmy'.
    expectedReport add: '   Juancete01'.
    expectedReport add: '      Deposito por 100'.
    expectedReport add: '      Balance = 100'.
    expectedReport add: '   ElMomoLaDinastia'.
    expectedReport add: '      Deposito por 67'.
    expectedReport add: '      Balance = 67'.
    expectedReport add: 'Balance = 167'.
    
    self assert: expectedReport equals: treeSummaryReport lines.! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:33:41 pm (UTC)'!
test15PortfolioTreePrinterSummaryForAPortolioWithAccountsWithWithdraws

    | account1 account2 portfolio1 treeSummaryReport expectedReport |
    account1 := ReceptiveAccount named: 'Juancete01'.
    account2 := ReceptiveAccount named: 'ElMomoLaDinastia'.
    Withdraw register: 100 on: account1. 
    Withdraw register: 67 on: account2. 
    
    portfolio1 := Portfolio named: 'Portfolio de la CoscuArmy' with: account1 with: account2.
    treeSummaryReport := PortfolioSummary on: portfolio1.
    
    expectedReport := OrderedCollection new.
    expectedReport add: 'Portfolio de la CoscuArmy'.
    expectedReport add: '   Juancete01'.
    expectedReport add: '      Extraccion por 100'.
    expectedReport add: '      Balance = -100'.
    expectedReport add: '   ElMomoLaDinastia'.
    expectedReport add: '      Extraccion por 67'.
    expectedReport add: '      Balance = -67'.
    expectedReport add: 'Balance = -167'.
    
    self assert: expectedReport equals: treeSummaryReport lines.! !

!AccountReportsTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:33:50 pm (UTC)'!
test16PortfolioTreePrinterSummaryForAPortolioWithAccountsWithTransfers

    | account1 account2 portfolio1 treeSummaryReport expectedReport |
    account1 := ReceptiveAccount named: 'Juancete01'.
    account2 := ReceptiveAccount named: 'ElMomoLaDinastia'.
    Transfer register: 100 from: account1 to: account2.
    
    portfolio1 := Portfolio named: 'Portfolio de la CoscuArmy' with: account1 with: account2.
    treeSummaryReport := PortfolioSummary on: portfolio1.
    
    expectedReport := OrderedCollection new.
    expectedReport add: 'Portfolio de la CoscuArmy'.
    expectedReport add: '   Juancete01'.
    expectedReport add: '      Salida por transferencia de 100'.
    expectedReport add: '      Balance = -100'.
    expectedReport add: '   ElMomoLaDinastia'.
    expectedReport add: '      Entrada por transferencia de 100'.
    expectedReport add: '      Balance = 100'.
    expectedReport add: 'Balance = 0'.
    
    self assert: expectedReport equals: treeSummaryReport lines.! !


!classDefinition: #PortfolioTest category: 'Portfolio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:16:26 pm (UTC)'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 27/May/2021, 8:36:04 pm (UTC)'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:23:25 pm (UTC)'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:43:15 pm (UTC)'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:43:11 pm (UTC)'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:06 pm (UTC)'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:10 pm (UTC)'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 22/Jun/2020, 10:31:19 am (UTC)'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:20 pm (UTC)'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:24 pm (UTC)'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:28 pm (UTC)'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 2:58:32 pm (UTC)'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 3:01:51 pm (UTC)'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 25/May/2019, 3:12:16 pm (UTC)'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 29/May/2019, 7:31:18 pm (UTC)'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:19:48 pm (UTC)'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:19:54 pm (UTC)'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:20:02 pm (UTC)'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:20:54 pm (UTC)'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 23/May/2019, 6:21:24 pm (UTC)'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: 'Portfolio2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:12:18 pm (UTC)'!
test01TransferDebitsOriginAccountAndCreditsDestinationAccount

	|transfer destinationAccount originAccount |
	
	destinationAccount := ReceptiveAccount new.
	originAccount := ReceptiveAccount new.
	Deposit register: 1000 on: destinationAccount .
	Deposit register: 10000 on: originAccount.
	transfer :=  Transfer register: 5000 from: originAccount to: destinationAccount.
	
	self assert: destinationAccount balance equals: 6000.
	self assert: originAccount balance equals: 5000.
	! !

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:12:45 pm (UTC)'!
test02TransferAmountMustBeStrictlyPositive

	|transfer account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 1000 on: account1 .
	Deposit register: 10000 on: account2.
	
	self 
	should: [transfer :=  Transfer register:  0 from: account2 to: account1.]  
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: Transfer amountMustBeStrictlyPositiveErrorDescription.
		]! !

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:13:11 pm (UTC)'!
test03AccountRegisterTheAssociatedTransferAsLegs

	|transfer account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 1000 on: account1 .
	Deposit register: 10000 on: account2.
	
	transfer :=  Transfer register:  5000 from: account2 to: account1.
	
	
	self assert: (account1 hasRegistered: transfer depositLeg ).
	self assert: (account2 hasRegistered: transfer withdrawLeg ).
! !

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:14:31 pm (UTC)'!
test04BothLegsAreAssociatedToTheSameTransfer

	|transfer account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 1000 on: account1 .
	Deposit register: 10000 on: account2.
	
	transfer :=  Transfer register: 5000 from: account2 to: account1.
	
	
	self assert: (transfer withdrawLeg transfer) equals: transfer .
	self assert: (transfer depositLeg transfer) equals: transfer.
! !

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:16:17 pm (UTC)'!
test05CanGoFromOneLegToAnother

	|transfer account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 1000 on: account1 .
	Deposit register: 10000 on: account2.
	
	transfer :=  Transfer register: 5000 from: account2 to: account1.
	
	
	self assert: (transfer withdrawLeg transfer depositLeg ) equals: (transfer depositLeg transfer depositLeg ) .
	self assert: (transfer withdrawLeg transfer withdrawLeg ) equals: (transfer depositLeg transfer withdrawLeg ) .
! !

!TransferTest methodsFor: 'tests' stamp: 'HAW 27/Oct/2026, 3:13:50 pm (UTC)'!
test06CannotTransferToYourself

	|transfer account1 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 1000 on: account1 .
	
	
	self should: [ transfer :=  Transfer register: 1000 from: account1 to: account1. ]  
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Transfer cantTransferToYourselfErrorDescription].
	
	
! !
