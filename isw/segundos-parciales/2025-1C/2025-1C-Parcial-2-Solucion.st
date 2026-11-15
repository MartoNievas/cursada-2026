!classDefinition: #HistorialDeAcciones category: #'2025-1C-Parcial-2'!
Object subclass: #HistorialDeAcciones
	instanceVariableNames: 'accionesADeshacer accionesARehacer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!HistorialDeAcciones methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 5:24:46 pm (UTC)'!
initialize

	accionesADeshacer := OrderedCollection new .
	accionesARehacer := OrderedCollection new.! !


!HistorialDeAcciones methodsFor: 'hacer' stamp: 'HAW 15/Nov/2026, 5:33:54 pm (UTC)'!
hacer: unaAccion

	unaAccion hacer.
	accionesADeshacer add: unaAccion.
	accionesARehacer removeAll.! !


!HistorialDeAcciones methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:26:55 pm (UTC)'!
assertHayAccionesParaDeshacer

	^ accionesADeshacer ifEmpty: [self error: HistorialDeAcciones noHayAccionesADeshacerErrorDescription]! !

!HistorialDeAcciones methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:26:55 pm (UTC)'!
deshacer
	
	| ultimaAccionADeshacer |
	
	self assertHayAccionesParaDeshacer.
	ultimaAccionADeshacer := accionesADeshacer removeLast .
	ultimaAccionADeshacer deshacer.
	accionesARehacer add: ultimaAccionADeshacer .
	
! !

!HistorialDeAcciones methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:33:11 pm (UTC)'!
rehacer

	| ultimaAccionARehacer |
	accionesARehacer ifEmpty: [
		self error: self class noHayAccionesARehacerErrorDescription].

	ultimaAccionARehacer := accionesARehacer last.
	ultimaAccionARehacer rehacer.
	accionesARehacer removeLast.
	accionesADeshacer add: ultimaAccionARehacer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HistorialDeAcciones class' category: #'2025-1C-Parcial-2'!
HistorialDeAcciones class
	instanceVariableNames: ''!

!HistorialDeAcciones class methodsFor: 'error description' stamp: 'HAW 15/Nov/2026, 3:26:55 pm (UTC)'!
noHayAccionesADeshacerErrorDescription
	
	^ 'No hay acciones para deshacer'! !

!HistorialDeAcciones class methodsFor: 'error description' stamp: 'HAW 15/Nov/2026, 5:07:15 pm (UTC)'!
noHayAccionesARehacerErrorDescription
	
	^ 'No hay acciones a rehacer'! !


!classDefinition: #Pared category: #'2025-1C-Parcial-2'!
Object subclass: #Pared
	instanceVariableNames: 'lienzo pinturas'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!Pared methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 3:03:45 pm (UTC)'!
initializeDe: unaDimension 
	
	lienzo := 0@0 extent: unaDimension .
	pinturas := OrderedCollection new.! !


!Pared methodsFor: 'testing' stamp: 'HAW 15/Nov/2026, 3:09:06 pm (UTC)'!
contieneA: unaPintura 
	
	^ lienzo containsRect: unaPintura ! !

!Pared methodsFor: 'testing' stamp: 'HAW 15/Nov/2026, 3:13:01 pm (UTC)'!
hayPintura: unaPintura 
	
	^ pinturas anySatisfy: [:unaPinturaAgregada | unaPinturaAgregada  == unaPintura ]! !

!Pared methodsFor: 'testing' stamp: 'HAW 15/Nov/2026, 3:12:04 pm (UTC)'!
hayPinturaConMismoOrigenYExtensionQue: unaPintura 
	
	
	^ pinturas includes: unaPintura ! !


!Pared methodsFor: 'accion' stamp: 'HAW 15/Nov/2026, 3:12:24 pm (UTC)'!
agregarPintura: unaPintura 
	
	self assertPinturaDentroDeLaPared: unaPintura.
	self assertExtensionValidaDe: unaPintura.
	pinturas add: unaPintura ! !


!Pared methodsFor: 'validacion' stamp: 'HAW 15/Nov/2026, 3:11:50 pm (UTC)'!
assertExtensionValidaDe: unaPintura

	^ (self hayPinturaConMismoOrigenYExtensionQue: unaPintura ) ifTrue: [self error: self class pinturaConLaMismaExtensionErrorDescription ]! !

!Pared methodsFor: 'validacion' stamp: 'HAW 15/Nov/2026, 3:07:38 pm (UTC)'!
assertPinturaDentroDeLaPared: unaPintura 
	
	(self contieneA: unaPintura)
		ifFalse: [
			self error: self class pinturaFueraDeLaParedErrorDescription ]! !


!Pared methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 4:23:41 pm (UTC)'!
sacarPintura: unaPintura 

	pinturas remove: unaPintura 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #'2025-1C-Parcial-2'!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 3:06:28 pm (UTC)'!
de: unaDimension 
	
	self assertEsDimensionValida: unaDimension.
	^self new initializeDe: unaDimension ! !


!Pared class methodsFor: 'asserting' stamp: ''!
assertEsDimensionValida: unaDimension

	(unaDimension x > 0 and: [unaDimension y > 0])
		ifFalse: [self error: self dimensionInvalidaErrorDescription]! !


!Pared class methodsFor: 'error description' stamp: ''!
dimensionInvalidaErrorDescription

	^ 'Las dimensiones de la pared son invalidas'! !

!Pared class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 8:24:10 pm (UTC)'!
pinturaConLaMismaExtensionErrorDescription
	
	^ 'No puede haber dos pinturas con la misma extensión'! !

!Pared class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 8:19:53 pm (UTC)'!
pinturaFueraDeLaParedErrorDescription
	
	^ 'La pintura esta fuera de la pared'! !


!classDefinition: #Pintor category: #'2025-1C-Parcial-2'!
Object subclass: #Pintor
	instanceVariableNames: 'pinturasSeleccionadas pared accionesADeshacer accionesARehacer historialDeAcciones'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!Pintor methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 5:25:05 pm (UTC)'!
initializePintandoEn: unaPared 
	
	pared := unaPared.
	pinturasSeleccionadas := OrderedCollection new.
	historialDeAcciones := HistorialDeAcciones new.
	! !


!Pintor methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 10:14:58 pm (UTC)'!
cantidadDePinturasSeleccionadas: unaCantidadDePinturasSeleccionadas 
	
	
	^ pinturasSeleccionadas size = unaCantidadDePinturasSeleccionadas .! !

!Pintor methodsFor: 'testing' stamp: 'HAW 15/Nov/2026, 2:37:05 pm (UTC)'!
estaSeleccionada: unaPintura 

	^ pinturasSeleccionadas anySatisfy: [:unaPinturaSeleccionada | unaPinturaSeleccionada == unaPintura ].! !

!Pintor methodsFor: 'testing' stamp: 'HAW 15/Nov/2026, 3:12:38 pm (UTC)'!
hayPintura: unaPintura

	^ pared hayPintura: unaPintura ! !


!Pintor methodsFor: 'validacion' stamp: 'HAW 14/Nov/2026, 11:05:00 pm (UTC)'!
assertCantidadDePinturasSeleccionadasEsValida

	^ pinturasSeleccionadas size <= 1 ifTrue: [self error: self class alineacionInvalidaErrorDescription]! !

!Pintor methodsFor: 'validacion' stamp: 'HAW 15/Nov/2026, 3:13:30 pm (UTC)'!
assertSiEsUnaSeleccionValida: unaPintura 
	
	((self estaSeleccionada: unaPintura) or: [ (self hayPintura: unaPintura) not ])
		ifTrue: [self error: self class seleccionInvalidaErrorDescription]! !


!Pintor methodsFor: 'alineacion' stamp: 'HAW 15/Nov/2026, 2:41:14 pm (UTC)'!
obtenerElMayorBordeDerechoDePinturasSeleccionadas
	
	^ pinturasSeleccionadas max: [:unaPinturaSeleccionada | unaPinturaSeleccionada right].! !

!Pintor methodsFor: 'alineacion' stamp: 'HAW 15/Nov/2026, 2:44:55 pm (UTC)'!
obtenerElMenorBordeIzquierdoDePinturasSeleccionadas

	^ (pinturasSeleccionadas min: [:unaPinturaSeleccionada | unaPinturaSeleccionada left] )! !


!Pintor methodsFor: 'acciones' stamp: 'HAW 15/Nov/2026, 4:19:44 pm (UTC)'!
agregarPintura: unaPintura 
	
	self hacer: (PintorAgregar pintura: unaPintura en: pared ).
! !

!Pintor methodsFor: 'acciones' stamp: 'HAW 15/Nov/2026, 4:53:31 pm (UTC)'!
alinearADerecha
	
	| maximoX |
	self assertCantidadDePinturasSeleccionadasEsValida.
	maximoX := self obtenerElMayorBordeDerechoDePinturasSeleccionadas.
	self hacer: (AlinearADerecha seleccion: pinturasSeleccionadas con: maximoX ).
! !

!Pintor methodsFor: 'acciones' stamp: 'HAW 15/Nov/2026, 4:42:20 pm (UTC)'!
alinearAIzquierda
	
	| minimoX |
	self assertCantidadDePinturasSeleccionadasEsValida.
	minimoX := self obtenerElMenorBordeIzquierdoDePinturasSeleccionadas.
	self hacer: (AlinearAIzquerda seleccion: pinturasSeleccionadas con: minimoX ).! !

!Pintor methodsFor: 'acciones' stamp: 'HAW 15/Nov/2026, 5:25:32 pm (UTC)'!
hacer: unaAccion 
	
	historialDeAcciones hacer: unaAccion .
	! !

!Pintor methodsFor: 'acciones' stamp: 'HAW 15/Nov/2026, 4:32:34 pm (UTC)'!
seleccionarPintura: unaPintura 
	
	self assertSiEsUnaSeleccionValida: unaPintura .
	
	self hacer: (PintorSeleccionar pintura: unaPintura en: pinturasSeleccionadas ).
	
! !


!Pintor methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:26:19 pm (UTC)'!
deshacer
	
	historialDeAcciones deshacer .! !

!Pintor methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:27:20 pm (UTC)'!
rehacer
	
	historialDeAcciones rehacer .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pintor class' category: #'2025-1C-Parcial-2'!
Pintor class
	instanceVariableNames: ''!

!Pintor class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 10:28:16 pm (UTC)'!
alineacionInvalidaErrorDescription
	
	^'Para alinear deben haber por lo menos 2 pinturas seleccionadas'! !

!Pintor class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 10:14:30 pm (UTC)'!
seleccionInvalidaErrorDescription
	
	^'Seleccion invalida'! !


!Pintor class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 3:04:04 pm (UTC)'!
pintandoEn: unaPared 
	
	^self new initializePintandoEn: unaPared ! !

!Pintor class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 3:05:20 pm (UTC)'!
sobreParedDe: unaDimension 
	
	^self pintandoEn: (Pared de: unaDimension ).! !


!classDefinition: #PintorAccion category: #'2025-1C-Parcial-2'!
Object subclass: #PintorAccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAccion methodsFor: 'hacer' stamp: 'HAW 15/Nov/2026, 4:36:48 pm (UTC)'!
hacer

	self subclassResponsibility! !


!PintorAccion methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 4:37:00 pm (UTC)'!
deshacer

	self subclassResponsibility! !


!classDefinition: #PintorAgregar category: #'2025-1C-Parcial-2'!
PintorAccion subclass: #PintorAgregar
	instanceVariableNames: 'pintura pared'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAgregar methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 4:17:51 pm (UTC)'!
initializePintura: unaPintura en: unaPared 
	
	pintura := unaPintura.
	pared := unaPared.! !


!PintorAgregar methodsFor: 'hacer' stamp: 'HAW 15/Nov/2026, 4:19:37 pm (UTC)'!
hacer
	
	pared agregarPintura: pintura .! !


!PintorAgregar methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 4:23:10 pm (UTC)'!
deshacer
	
	pared sacarPintura: pintura .! !

!PintorAgregar methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:15:15 pm (UTC)'!
rehacer
	
	pared agregarPintura: pintura .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAgregar class' category: #'2025-1C-Parcial-2'!
PintorAgregar class
	instanceVariableNames: ''!

!PintorAgregar class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 4:17:37 pm (UTC)'!
pintura: unaPintura en: unaPared 

	^self new initializePintura: unaPintura en: unaPared ! !


!classDefinition: #PintorAlinear category: #'2025-1C-Parcial-2'!
PintorAccion subclass: #PintorAlinear
	instanceVariableNames: 'originales seleccionDePinturas x'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAlinear methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 4:57:33 pm (UTC)'!
initializeSeleccion: unaSeleccionDePinturas con: unX 
	
	seleccionDePinturas := unaSeleccionDePinturas.
	originales := seleccionDePinturas collect: [:unaPintura | unaPintura copy].
	x := unX.! !


!PintorAlinear methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 4:58:23 pm (UTC)'!
deshacer
	
	 seleccionDePinturas with: originales do: [:unaPintura :unaPinturaOriginal |
			unaPintura setOrigin: unaPinturaOriginal origin corner: unaPinturaOriginal corner 
		] ! !

!PintorAlinear methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:27:47 pm (UTC)'!
rehacer
	
	self hacer.! !


!PintorAlinear methodsFor: 'origen' stamp: 'HAW 15/Nov/2026, 5:04:56 pm (UTC)'!
nuevoOrigenPara: unaPintura
	
	self subclassResponsibility .! !


!PintorAlinear methodsFor: 'hacer' stamp: 'HAW 15/Nov/2026, 5:04:03 pm (UTC)'!
hacer
	
	seleccionDePinturas do: [:unaPintura | | nuevoOrigen |
	nuevoOrigen := self nuevoOrigenPara: unaPintura .
	unaPintura setOrigin: nuevoOrigen corner: nuevoOrigen + unaPintura extent
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAlinear class' category: #'2025-1C-Parcial-2'!
PintorAlinear class
	instanceVariableNames: ''!

!PintorAlinear class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 4:57:47 pm (UTC)'!
seleccion: unaSeleccionDePinturas con: unX 
	
	^self new initializeSeleccion: unaSeleccionDePinturas con: unX ! !


!classDefinition: #AlinearADerecha category: #'2025-1C-Parcial-2'!
PintorAlinear subclass: #AlinearADerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!AlinearADerecha methodsFor: 'origen' stamp: 'HAW 15/Nov/2026, 5:04:31 pm (UTC)'!
nuevoOrigenPara: unaPintura

	^ (x - unaPintura width) @ unaPintura top! !


!classDefinition: #AlinearAIzquerda category: #'2025-1C-Parcial-2'!
PintorAlinear subclass: #AlinearAIzquerda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!AlinearAIzquerda methodsFor: 'origen' stamp: 'HAW 15/Nov/2026, 5:01:48 pm (UTC)'!
nuevoOrigenPara: unaPintura 
	
	^ x @ unaPintura origin y! !


!classDefinition: #PintorSeleccionar category: #'2025-1C-Parcial-2'!
PintorAccion subclass: #PintorSeleccionar
	instanceVariableNames: 'pintura seleccionDePinturas'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorSeleccionar methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 4:31:45 pm (UTC)'!
initializePintura: unaPintura en: unaSeleccionDePinturas 
	
	pintura := unaPintura.
	seleccionDePinturas := unaSeleccionDePinturas.! !


!PintorSeleccionar methodsFor: 'hacer' stamp: 'HAW 15/Nov/2026, 4:32:14 pm (UTC)'!
hacer
	
	seleccionDePinturas add: pintura .! !


!PintorSeleccionar methodsFor: 'hacer/deshacer' stamp: 'HAW 15/Nov/2026, 4:33:33 pm (UTC)'!
deshacer
	
	seleccionDePinturas remove: pintura .! !


!PintorSeleccionar methodsFor: 'rehacer/deshacer' stamp: 'HAW 15/Nov/2026, 5:17:28 pm (UTC)'!
rehacer
	
	seleccionDePinturas add: pintura .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorSeleccionar class' category: #'2025-1C-Parcial-2'!
PintorSeleccionar class
	instanceVariableNames: ''!

!PintorSeleccionar class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 4:31:35 pm (UTC)'!
pintura: unaPintura en: unaSeleccionDePinturas 
	
	^self new initializePintura: unaPintura en: unaSeleccionDePinturas ! !


!classDefinition: #PintorTest category: #'2025-1C-Parcial-2'!
TestCase subclass: #PintorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:02:21 pm (UTC)'!
test01ExtensionXEnParedDebeSerEstrictamentePositiva

	self
	should: [Pintor sobreParedDe: 0@1]  
	raise: Error - MessageNotUnderstood 
	withMessageText: Pared dimensionInvalidaErrorDescription! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:02:15 pm (UTC)'!
test02ExtensionYEnParedDebeSerEstrictamentePositiva

	self
	should: [Pintor sobreParedDe: 1@0]  
	raise: Error - MessageNotUnderstood 
	withMessageText: Pared dimensionInvalidaErrorDescription! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:12:18 pm (UTC)'!
test03UnaPinturaAgregadaEstaEnLaPared

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	pintor agregarPintura: pintura .
	
	self assert: (pintor hayPintura: pintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:11:51 pm (UTC)'!
test04NoEstanLasPinturasNoAgregadas

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	self deny: (pintor hayPintura: pintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:12:29 pm (UTC)'!
test05SePuedenAgregarMultiplesPinturasYEstanPresentes

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 20@20 extent: 30@30.
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .

	self assert: (pintor hayPintura: pintura ).	
	self assert: (pintor hayPintura: otraPintura ).
! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 8:20:44 pm (UTC)'!
test06NoSePuedeColocarUnaPinturaFueraDeLaPared

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@-1 extent: 20@20.
	
	self should: [pintor agregarPintura: pintura ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pared pinturaFueraDeLaParedErrorDescription .
			self deny: (pintor hayPintura: pintura ).
		]! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 9:56:17 pm (UTC)'!
test07NoSePuedenAgregarDosPinturasConMismoOrigenYExtension

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 20@20.
	otraPintura := 0@0 extent: 20@20.
	
	pintor agregarPintura: pintura.
	
	self should: [pintor agregarPintura: otraPintura ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pared pinturaConLaMismaExtensionErrorDescription .
			self assert: (pintor hayPintura: pintura ).
			self deny: (pintor hayPintura: otraPintura )
		].! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:37:05 pm (UTC)'!
test08SePuedeSeleccionarUnaPinturaDeLaParedYEstaPresente

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 20@20.
	
	pintor agregarPintura: pintura.
	
	pintor seleccionarPintura: pintura .
	
	self assert: (pintor estaSeleccionada: pintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:57:01 pm (UTC)'!
test09UnaPinturaNoSeleccionadaNoEstaEnLaSeleccion

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 20@20.

	pintor agregarPintura: pintura.
	
	self deny: (pintor estaSeleccionada: pintura ).
	self assert: (pintor cantidadDePinturasSeleccionadas: 0).
! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:37:05 pm (UTC)'!
test10SePuedenSeleccionarMultiplesPinturasDeLaParedYEstanPresentes

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 20@20.
	otraPintura := 30@30 extent: 40@40.
	
	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	
	pintor seleccionarPintura: pintura .
	pintor seleccionarPintura: otraPintura .
	
	self assert: (pintor estaSeleccionada: pintura ).
	self assert: (pintor estaSeleccionada: otraPintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:37:05 pm (UTC)'!
test11NoSePuedeSeleccionarUnaPinturaYaSeleccionada

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	pintor agregarPintura: pintura.
	pintor seleccionarPintura: pintura.
	
	self should: [pintor seleccionarPintura: pintura ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pintor seleccionInvalidaErrorDescription.
			self assert: (pintor estaSeleccionada: pintura).
			self assert: (pintor cantidadDePinturasSeleccionadas: 1).
		]! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 3:17:10 pm (UTC)'!
test12NoSePuedeSeleccionarUnaPinturaQueNoEsteEnLaPared

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	self should: [pintor seleccionarPintura: pintura ]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pintor seleccionInvalidaErrorDescription.
			self deny: (pintor estaSeleccionada: pintura).
			self deny: (pintor cantidadDePinturasSeleccionadas: 1).
		]! !

!PintorTest methodsFor: 'test' stamp: 'HAW 14/Nov/2026, 10:31:37 pm (UTC)'!
test13NoSePuedeAlinearAIzquierdaSinPinturasSeleccionadas

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 10@10 extent: 20@20. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	self should: [pintor alinearAIzquierda]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pintor alineacionInvalidaErrorDescription.
			self assert: (pintor cantidadDePinturasSeleccionadas: 0).
			self assert: pintura equals: (0@0 extent: 10@10).
			self assert: otraPintura equals: (10@10 extent: 20@20)
		]
	! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:57:11 pm (UTC)'!
test14NoSePuedeAlinearAIzquierdaConUnaSolaPinturaSeleccionada

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 10@10 extent: 20@20. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	pintor seleccionarPintura: pintura .
	
	self should: [pintor alinearAIzquierda]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pintor alineacionInvalidaErrorDescription.
			self assert: (pintor cantidadDePinturasSeleccionadas: 1).
			self assert: pintura equals: (0@0 extent: 10@10).
			self assert: otraPintura equals: (10@10 extent: 20@20)
		]
	! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:38:29 pm (UTC)'!
test15AlinearAIzquierda_2_PinturasSeleccionadasDejaTodasEnElMinimoX

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5.
	otraPintura := 5@3 extent: 10@10. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	pintor seleccionarPintura: pintura .
	pintor seleccionarPintura: otraPintura .
	
	pintor alinearAIzquierda .
	
	self assert: pintura equals: (0@0 extent: 5@5).
	self assert: otraPintura equals: (0@3 extent: 10@10)
! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:38:37 pm (UTC)'!
test16AlinearAIzquierdaMultiplesPinturasSeleccionadasDejaATodasEnElMinimoX

	| pintor pintura otraPintura otraOtraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 5@0 extent: 5@5.
	otraPintura := 8@3 extent: 10@10.
	otraOtraPintura := 2@6 extent: 7@8.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	pintor agregarPintura: otraOtraPintura.

	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: otraPintura.
	pintor seleccionarPintura: otraOtraPintura.

	pintor alinearAIzquierda.

	self assert: pintura equals: (2@0 extent: 5@5).
	self assert: otraPintura equals: (2@3 extent: 10@10).
	self assert: otraOtraPintura equals: (2@6 extent: 7@8).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:37:47 pm (UTC)'!
test17NoSePuedeAlinearADerechaConUnaSolaPinturaSeleccionada

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 10@10 extent: 20@20. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	pintor seleccionarPintura: pintura.
	
	self should: [pintor alinearADerecha]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Pintor alineacionInvalidaErrorDescription.
			self assert: (pintor cantidadDePinturasSeleccionadas: 1).
			self assert: pintura equals: (0@0 extent: 10@10).
			self assert: otraPintura equals: (10@10 extent: 20@20)
		]
	! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 2:39:40 pm (UTC)'!
test18AlinearADerechaDejaTodasLasPinturasSeleccionadasEnElMaximoX

	| pintor pintura otraPintura otraOtraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 5@0 extent: 5@5.
	otraPintura := 8@3 extent: 10@10.
	otraOtraPintura := 2@6 extent: 7@8.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	pintor agregarPintura: otraOtraPintura.

	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: otraPintura.
	pintor seleccionarPintura: otraOtraPintura.

	pintor alinearADerecha .

	self assert: pintura equals: (13@0 extent: 5@5).
	self assert: otraPintura equals: (8@3 extent: 10@10).
	self assert: otraOtraPintura equals: (11@6 extent: 7@8).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 3:19:40 pm (UTC)'!
test19LaParedConservaLasPinturasEntrePintores

	| pared pintor otroPintor pintura |
	pared := Pared de: 100@100.
	pintor := Pintor pintandoEn: pared.
	pintura := 5@0 extent: 5@5.

	pintor agregarPintura: pintura.

	otroPintor := Pintor pintandoEn: pared.

	self assert: (otroPintor hayPintura: pintura).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:24:33 pm (UTC)'!
test20NoSePuedeDeshacerSiNoHayAccionesADeshacer

	| pintor |
	pintor := Pintor sobreParedDe: 100@100.
	
	self should: [pintor deshacer]  
	raise:  Error - MessageNotUnderstood 
	withMessageText: HistorialDeAcciones noHayAccionesADeshacerErrorDescription! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:25:17 pm (UTC)'!
test21DeshacerAgregarPinturaLaQuitaDeLaPared

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	pintor agregarPintura: pintura.
	
	pintor deshacer .
	
	self deny: (pintor hayPintura: pintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:26:38 pm (UTC)'!
test22SePuedenDeshacerSucesivosAgregadosDePinturas

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 20@20 extent: 5@5.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.

	pintor deshacer.
	pintor deshacer.

	self deny: (pintor hayPintura: pintura).
	self deny: (pintor hayPintura: otraPintura).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:35:51 pm (UTC)'!
test23SePuedenDeshacerMultiplesSeleccionesDePinturas
	
	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 11@11 extent: 20@20.
	
	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura .

	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: otraPintura .
		
	pintor deshacer; deshacer .

	self deny: (pintor estaSeleccionada: pintura).
	self deny: (pintor estaSeleccionada: otraPintura ).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:49:57 pm (UTC)'!
test24DeshacerUnaAlineacionAIzquierdaRestauraXOriginal

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5.
	otraPintura := 5@3 extent: 10@10. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	pintor seleccionarPintura: pintura .
	pintor seleccionarPintura: otraPintura .
	
	pintor alinearAIzquierda .
	
	pintor deshacer .	
	
	self assert: pintura equals: (0@0 extent: 5@5).
	self assert: otraPintura equals: (5@3 extent: 10@10)
! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 4:56:09 pm (UTC)'!
test25DeshacerUnaAlineacionADerechaRestauraXOriginal

	| pintor pintura otraPintura otraOtraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 5@0 extent: 5@5.
	otraPintura := 8@3 extent: 10@10.
	otraOtraPintura := 2@6 extent: 7@8.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	pintor agregarPintura: otraOtraPintura.

	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: otraPintura.
	pintor seleccionarPintura: otraOtraPintura.

	pintor alinearADerecha .
	
	pintor deshacer .

	self assert: pintura equals: (5@0 extent: 5@5).
	self assert: otraPintura equals: (8@3 extent: 10@10).
	self assert: otraOtraPintura equals: (2@6 extent: 7@8).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 5:07:02 pm (UTC)'!
test26NoSePuedeRehacerSiNoHayAccionesARehacer

	| pintor |
	pintor := Pintor sobreParedDe: 100@100.
	
	self should: [pintor rehacer]  
	raise:  Error - MessageNotUnderstood 
	withMessageText: HistorialDeAcciones noHayAccionesARehacerErrorDescription! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 5:17:00 pm (UTC)'!
test27SePuedenRehacerSucesivasSeleccionesDePinturas

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 20@20 extent: 5@5.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	
	pintor seleccionarPintura: pintura .
	pintor seleccionarPintura: otraPintura .

	pintor deshacer; deshacer .
	pintor rehacer; rehacer .

	self assert: (pintor estaSeleccionada: pintura).
	self assert: (pintor estaSeleccionada: otraPintura).! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 5:19:39 pm (UTC)'!
test28RehacerUnaAlineacionAIzquierdaDejaPinturasSeleccionadasAlineadas

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5.
	otraPintura := 5@3 extent: 10@10. 
	
	pintor agregarPintura: pintura .
	pintor agregarPintura: otraPintura .
	
	pintor seleccionarPintura: pintura .
	pintor seleccionarPintura: otraPintura .
	
	pintor alinearAIzquierda .
	
	pintor deshacer; rehacer .	
	
	self assert: pintura equals: (0@0 extent: 5@5).
	self assert: otraPintura equals: (0@3 extent: 10@10).
! !

!PintorTest methodsFor: 'test' stamp: 'HAW 15/Nov/2026, 5:23:45 pm (UTC)'!
test29RehacerUnaAlineacionADerechaDejaPinturasSeleccionadasAlineadas

	| pintor pintura otraPintura otraOtraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 5@0 extent: 5@5.
	otraPintura := 8@3 extent: 10@10.
	otraOtraPintura := 2@6 extent: 7@8.

	pintor agregarPintura: pintura.
	pintor agregarPintura: otraPintura.
	pintor agregarPintura: otraOtraPintura.

	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: otraPintura.
	pintor seleccionarPintura: otraOtraPintura.

	pintor alinearADerecha .
	
	pintor deshacer; rehacer .

	self assert: pintura equals: (13@0 extent: 5@5).
	self assert: otraPintura equals: (8@3 extent: 10@10).
	self assert: otraOtraPintura equals: (11@6 extent: 7@8)! !

!PintorTest methodsFor: 'test' stamp: ''!
test30HacerUnaNuevaAccionDescartaLasAccionesARehacer

	| pintor pintura otraPintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	otraPintura := 20@20 extent: 5@5.

	pintor agregarPintura: pintura.
	pintor deshacer.
	pintor agregarPintura: otraPintura.

	self
		should: [pintor rehacer]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:unError |
			self assert: unError messageText equals: HistorialDeAcciones noHayAccionesARehacerErrorDescription.
			self deny: (pintor hayPintura: pintura).
			self assert: (pintor hayPintura: otraPintura)].! !

!PintorTest methodsFor: 'test' stamp: ''!
test31SePuedeDeshacerUnaAccionRehecha

	| pintor pintura |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pintor agregarPintura: pintura.

	pintor deshacer; rehacer; deshacer.

	self deny: (pintor hayPintura: pintura).! !

!PintorTest methodsFor: 'test' stamp: ''!
test32UnAgregadoFallidoNoSeRegistraComoAccionADeshacer

	| pintor pintura pinturaFueraDeLaPared |
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pinturaFueraDeLaPared := 0@-1 extent: 5@5.
	pintor agregarPintura: pintura.

	self
		should: [pintor agregarPintura: pinturaFueraDeLaPared]
		raise: Error - MessageNotUnderstood
		withMessageText: Pared pinturaFueraDeLaParedErrorDescription.

	pintor deshacer.

	self deny: (pintor hayPintura: pintura).
	self deny: (pintor hayPintura: pinturaFueraDeLaPared).! !
