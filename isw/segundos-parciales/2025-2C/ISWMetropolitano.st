!classDefinition: #MedioDeTransporte category: #ISWMetropolitano!
Object subclass: #MedioDeTransporte
	instanceVariableNames: 'paradas cuadroTarifario reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!MedioDeTransporte methodsFor: 'asserting' stamp: 'HAW 12/Nov/2026, 4:10:05 pm (UTC)'!
assertParada: unaParadaOrigen esDistintaA: unaParadaDestino

	unaParadaOrigen  = unaParadaDestino ifTrue: [self error: self class paradasDebenSerDistintasErrorDescription].! !

!MedioDeTransporte methodsFor: 'asserting' stamp: 'HAW 12/Nov/2026, 4:03:54 pm (UTC)'!
assertParadaDentroDelRecorrido: unaParada

	^ (paradas includes: unaParada) ifFalse: [self error: self class paradaFueraDelRecorridoErrorDescription ].

	! !

!MedioDeTransporte methodsFor: 'asserting' stamp: 'HAW 12/Nov/2026, 4:56:56 pm (UTC)'!
assertViajeDesde: unOrigen hasta: unDestino

	self assertParada: unOrigen esDistintaA: unDestino.
	self assertParadaDentroDelRecorrido: unOrigen.
	self assertParadaDentroDelRecorrido: unDestino! !


!MedioDeTransporte methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 4:19:17 pm (UTC)'!
calcularImporteEnBaseA: unaDistanciaEntreParadas 
	
	| tramo |
	tramo := cuadroTarifario detect: [:unaAsociacion |  
			unaDistanciaEntreParadas <= unaAsociacion key
		].
	
	^ tramo value ! !


!MedioDeTransporte methodsFor: 'initialization' stamp: 'HAW 12/Nov/2026, 4:03:35 pm (UTC)'!
initializeConParadas: unaParadas yCuadroTarifario: unCuadroTarifario enFechaYHora: unReloj 
	
	paradas := unaParadas.
	cuadroTarifario := unCuadroTarifario.
	reloj := unReloj.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MedioDeTransporte class' category: #ISWMetropolitano!
MedioDeTransporte class
	instanceVariableNames: ''!

!MedioDeTransporte class methodsFor: 'error description' stamp: 'HAW 12/Nov/2026, 4:07:42 pm (UTC)'!
cantidadDeParadasMenorADosErrorDescription
	
	^ 'Un medio de transporte debe tener al menos dos paradas'! !

!MedioDeTransporte class methodsFor: 'error description' stamp: 'HAW 12/Nov/2026, 4:05:08 pm (UTC)'!
paradaFueraDelRecorridoErrorDescription
	
	^'Parada no forma parte del recorrido'! !

!MedioDeTransporte class methodsFor: 'error description' stamp: 'HAW 12/Nov/2026, 4:05:03 pm (UTC)'!
paradasDebenSerDistintasErrorDescription
	
	^ 'La parada de origen y destino deben ser distintas'.! !


!MedioDeTransporte class methodsFor: 'instance creation' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
conParadas: unaParadas yCuadroTarifario: unCuadroTarifario conReloj: unReloj

	unaParadas size < 2 ifTrue: [self error: self cantidadDeParadasMenorADosErrorDescription].

	^self new initializeConParadas: unaParadas yCuadroTarifario: unCuadroTarifario enFechaYHora: unReloj ! !


!classDefinition: #Colectivo category: #ISWMetropolitano!
MedioDeTransporte subclass: #Colectivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Colectivo methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 4:10:23 pm (UTC)'!
cobrarViajeCon: unaTarjeta desde: unaParadaOrigen hasta: unaParadaDestino 
	
	| distanciaEntreParadas importeACobrar |
	self assertViajeDesde: unaParadaOrigen hasta: unaParadaDestino.
	
	distanciaEntreParadas := unaParadaOrigen distanciaHasta: unaParadaDestino .
	
	importeACobrar := self calcularImporteEnBaseA: distanciaEntreParadas .
	
	unaTarjeta cobrar: importeACobrar enFechaYHora: reloj ahora ! !


!classDefinition: #MedioDeTransporteConDireccion category: #ISWMetropolitano!
MedioDeTransporte subclass: #MedioDeTransporteConDireccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!MedioDeTransporteConDireccion methodsFor: 'asserting' stamp: ''!
assertDireccionEsCabecera: unaParadaCabecera
	((paradas last = unaParadaCabecera) or: [paradas first = unaParadaCabecera])
		ifFalse: [self error: self class direccionDebeSerUnaCabeceraErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MedioDeTransporteConDireccion class' category: #ISWMetropolitano!
MedioDeTransporteConDireccion class
	instanceVariableNames: ''!

!MedioDeTransporteConDireccion class methodsFor: 'error description' stamp: ''!
direccionDebeSerUnaCabeceraErrorDescription
	^ 'La direccion debe ser la cabecera o la ultima parada'! !


!classDefinition: #Subte category: #ISWMetropolitano!
MedioDeTransporteConDireccion subclass: #Subte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Subte methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 4:10:52 pm (UTC)'!
cobrarViajeCon: tarjeta desde: unaParadaDeOrigen conDireccion: unaParadaCabecera
	
	self assertViajeDesde: unaParadaDeOrigen hasta: unaParadaCabecera.
	self assertDireccionEsCabecera: unaParadaCabecera .
	tarjeta cobrar: cuadroTarifario enFechaYHora: reloj ahora .! !


!classDefinition: #Tren category: #ISWMetropolitano!
MedioDeTransporteConDireccion subclass: #Tren
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Tren methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 4:48:27 pm (UTC)'!
cobrarViajeCon: unaTarjeta desde: unaParadaOrigen conDireccion: unaParadaCabecera
	| distanciaEntreParadas importeACobrar |
	self assertViajeDesde: unaParadaOrigen hasta: unaParadaCabecera.
	self assertDireccionEsCabecera: unaParadaCabecera.
	
	distanciaEntreParadas := unaParadaOrigen distanciaHasta: unaParadaCabecera.
	importeACobrar := self calcularImporteEnBaseA: distanciaEntreParadas.
	unaTarjeta iniciarViajeEnTrenDesde: unaParadaOrigen
		conTarifa: importeACobrar enFechaYHora: reloj ahora! !

!Tren methodsFor: 'cobro' stamp: ''!
finalizarViajeCon: unaTarjeta enEstacion: unaEstacionDestino
	| distancia tarifaReal |
	distancia := unaTarjeta origenEnTren distanciaHasta: unaEstacionDestino.
	tarifaReal := self calcularImporteEnBaseA: distancia.
	unaTarjeta finalizarViajeEnTrenConTarifa: tarifaReal! !


!classDefinition: #Parada category: #ISWMetropolitano!
Object subclass: #Parada
	instanceVariableNames: 'nombre distanciaACabecera'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Parada methodsFor: 'intialization' stamp: 'HAW 12/Nov/2026, 11:18:45 am (UTC)'!
initializeLlamada: unNombreDeEstacion aDistanciaDeCabecera: unaDistanciaACabecera

	nombre := unNombreDeEstacion.
	distanciaACabecera := unaDistanciaACabecera.! !


!Parada methodsFor: 'distancia' stamp: 'HAW 12/Nov/2026, 2:10:36 pm (UTC)'!
distanciaACabecera
	
	^distanciaACabecera! !

!Parada methodsFor: 'distancia' stamp: 'HAW 12/Nov/2026, 2:10:30 pm (UTC)'!
distanciaHasta: unaParadaDestino 
	
	^ (distanciaACabecera  - unaParadaDestino distanciaACabecera) abs! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Parada class' category: #ISWMetropolitano!
Parada class
	instanceVariableNames: ''!

!Parada class methodsFor: 'instance creation' stamp: 'HAW 12/Nov/2026, 11:18:15 am (UTC)'!
llamada: unNombreDeEstacion aDistanciaDeCabecera: unaDistanciaEnKilometros

	^self new initializeLlamada: unNombreDeEstacion aDistanciaDeCabecera: unaDistanciaEnKilometros ! !


!classDefinition: #TarjetaBAJE category: #ISWMetropolitano!
Object subclass: #TarjetaBAJE
	instanceVariableNames: 'saldo descuento viajes viajeEnTrenPendiente'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!TarjetaBAJE methodsFor: 'viajes en tren' stamp: ''!
finalizarViajeEnTrenConTarifa: unaTarifaReal
	saldo := saldo + (viajeEnTrenPendiente reintegroParaTarifa: unaTarifaReal).
	viajeEnTrenPendiente := nil! !

!TarjetaBAJE methodsFor: 'viajes en tren' stamp: ''!
iniciarViajeEnTrenDesde: unaParada conTarifa: unaTarifa enFechaYHora: unaFechaYHora
	| importePagado |
	importePagado := self cobrar: unaTarifa enFechaYHora: unaFechaYHora.
	viajeEnTrenPendiente := ViajeEnTren
		desde: unaParada
		conTarifa: unaTarifa
		importePagado: importePagado! !

!TarjetaBAJE methodsFor: 'viajes en tren' stamp: ''!
origenEnTren
	^ viajeEnTrenPendiente origen! !


!TarjetaBAJE methodsFor: 'initialization' stamp: 'HAW 12/Nov/2026, 1:12:03 pm (UTC)'!
initializeConSaldo: unSaldoEnPesos yDescuento: unTipoDeDescuento

	saldo := unSaldoEnPesos.
	descuento := unTipoDeDescuento.
	viajes := OrderedCollection new.! !


!TarjetaBAJE methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 11:29:01 am (UTC)'!
assertTieneSaldoSucienteParaPagar: unImporte

	unImporte > saldo ifTrue: [self error: self class saldoInsuficienteErrorDescription]! !

!TarjetaBAJE methodsFor: 'cobro' stamp: 'HAW 12/Nov/2026, 1:44:15 pm (UTC)'!
cobrar: unImporte enFechaYHora: unaFechaYHora

	| importeACobrar |
	importeACobrar := descuento aplicarA: unImporte enFechaYHora: unaFechaYHora conViajesDelDia: (self cantidadViajeEn: unaFechaYHora) .

	(self esTrasbordoEn: unaFechaYHora ) ifTrue: [
			importeACobrar := importeACobrar min: unImporte / 2.
		].

	self assertTieneSaldoSucienteParaPagar: importeACobrar .
	self registrarViajeEn: unaFechaYHora .
	saldo := saldo - importeACobrar.
	^ importeACobrar ! !


!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 12/Nov/2026, 1:44:08 pm (UTC)'!
cantidadViajeEn: unaFechaYHora

	^ viajes count: [:unViajeEnFechaYHora | unaFechaYHora date = unViajeEnFechaYHora date ]! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 12/Nov/2026, 1:42:38 pm (UTC)'!
esTrasbordoEn: unaFechaYHora

	^ viajes notEmpty and: [
		unaFechaYHora < (viajes last next: 2 * hour) ]! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 12/Nov/2026, 1:11:52 pm (UTC)'!
registrarViajeEn: unaFechaYHora

	viajes add: unaFechaYHora .! !


!TarjetaBAJE methodsFor: 'testing' stamp: 'HAW 12/Nov/2026, 11:21:15 am (UTC)'!
saldo

	^saldo! !

!TarjetaBAJE methodsFor: 'testing' stamp: 'HAW 12/Nov/2026, 7:57:38 pm (UTC)'!
viajes
	
	^viajes copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TarjetaBAJE class' category: #ISWMetropolitano!
TarjetaBAJE class
	instanceVariableNames: ''!

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 12/Nov/2026, 12:39:28 pm (UTC)'!
conSaldo: unSaldoEnPesos yDescuento: unTipoDeDescuento

	^self new initializeConSaldo: unSaldoEnPesos yDescuento: unTipoDeDescuento ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: ''!
estudiantilConSaldo: unSaldoEnPesos

	^ self conSaldo: unSaldoEnPesos yDescuento: DescuentoEstudiantil new! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: ''!
jubiladoConSaldo: unSaldoEnPesos

	^ self conSaldo: unSaldoEnPesos yDescuento: DescuentoJubilado new! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: ''!
sinDescuentoConSaldo: unSaldoEnPesos

	^ self conSaldo: unSaldoEnPesos yDescuento: SinDescuento new! !


!TarjetaBAJE class methodsFor: 'error description' stamp: 'HAW 12/Nov/2026, 11:29:23 am (UTC)'!
saldoInsuficienteErrorDescription

	^ 'No hay saldo suficiente para pagar el importe'! !


!classDefinition: #TipoDeDescuento category: #ISWMetropolitano!
Object subclass: #TipoDeDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!TipoDeDescuento methodsFor: 'aplicar descuento' stamp: 'HAW 12/Nov/2026, 1:13:19 pm (UTC)'!
aplicarA: unImporte enFechaYHora: unaFechaYHora conViajesDelDia: unaCantidadDeViajesEnElDia

	self subclassResponsibility .! !


!classDefinition: #DescuentoEstudiantil category: #ISWMetropolitano!
TipoDeDescuento subclass: #DescuentoEstudiantil
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!DescuentoEstudiantil methodsFor: 'aplicar descuento' stamp: 'HAW 12/Nov/2026, 1:19:31 pm (UTC)'!
aplicarA: unImporte enFechaYHora: unaFechaYHora conViajesDelDia: unaCantidadDeViajesEnElDia

	^ (unaFechaYHora date isSaturday or: [unaFechaYHora date isSunday ]) ifTrue: [unImporte ] ifFalse: [unImporte / 2]! !


!classDefinition: #DescuentoJubilado category: #ISWMetropolitano!
TipoDeDescuento subclass: #DescuentoJubilado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!DescuentoJubilado methodsFor: 'aplicar descuento' stamp: 'HAW 12/Nov/2026, 1:16:21 pm (UTC)'!
aplicarA: unImporte enFechaYHora: unaFechaYHora conViajesDelDia: unaCantidadDeViajesEnElDia

	 ^ unaCantidadDeViajesEnElDia >= 2 ifTrue: [unImporte ] ifFalse: [ 0*peso]! !


!classDefinition: #SinDescuento category: #ISWMetropolitano!
TipoDeDescuento subclass: #SinDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!SinDescuento methodsFor: 'aplicar descuento' stamp: 'HAW 12/Nov/2026, 1:13:19 pm (UTC)'!
aplicarA: unImporte enFechaYHora: unaFechaYHora conViajesDelDia: unaCantidadDeViajesEnElDia

	^ unImporte .! !


!classDefinition: #ViajeEnTren category: #ISWMetropolitano!
Object subclass: #ViajeEnTren
	instanceVariableNames: 'origen tarifaAlEntrar importePagadoAlEntrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!ViajeEnTren methodsFor: 'initialization' stamp: ''!
initializeDesde: unaParada conTarifa: unaTarifa importePagado: unImporte
	origen := unaParada.
	tarifaAlEntrar := unaTarifa.
	importePagadoAlEntrar := unImporte! !


!ViajeEnTren methodsFor: 'accessing' stamp: ''!
origen
	^ origen! !


!ViajeEnTren methodsFor: 'reintegro' stamp: ''!
reintegroParaTarifa: unaTarifaReal
	^ importePagadoAlEntrar
		- (importePagadoAlEntrar * (unaTarifaReal / tarifaAlEntrar))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ViajeEnTren class' category: #ISWMetropolitano!
ViajeEnTren class
	instanceVariableNames: ''!

!ViajeEnTren class methodsFor: 'instance creation' stamp: ''!
desde: unaParada conTarifa: unaTarifa importePagado: unImporte
	^ self new initializeDesde: unaParada conTarifa: unaTarifa importePagado: unImporte! !


!classDefinition: #TarjetaBAJETest category: #ISWMetropolitano!
TestCase subclass: #TarjetaBAJETest
	instanceVariableNames: 'fechaYHoraActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 8:00:34 pm (UTC)'!
test01ElSubteCobraLaTarifaCompletaAUnaTarjetaSinDescuento

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso .
	palermo := self palermo .

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 8:00:19 pm (UTC)'!
test02ElSubteRechazaElCobroConSaldoInsuficiente

	"Subte Línea D:
- Paradas: Congreso de Tucumán (0*kilometer) ↔ Tribunales (1.2*kilometer) ↔ Callao
(2.5*kilometer) ↔Palermo (6*kilometer)
- Cuadro tarifario: Siempre es 1000 * peso"

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 500*peso.
	congreso := self congreso .
	palermo := self palermo .

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	self should: [lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: TarjetaBAJE saldoInsuficienteErrorDescription.
				self assert: tarjeta saldo equals: 500*peso.
				self assert: tarjeta viajes isEmpty .
			].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 8:00:52 pm (UTC)'!
test03ElSubteRechazaUnViajeConOrigenYDireccionIguales

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso .
	palermo := self palermo .

	lineaD := self subteConParadas: {congreso. palermo } tarifa: 1000*peso.

	self should: [lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: congreso .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: Subte paradasDebenSerDistintasErrorDescription.
				self assert: tarjeta saldo equals: 2000*peso.
				self assert: tarjeta viajes isEmpty .
			].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 8:01:11 pm (UTC)'!
test04ElSubteRechazaUnaDireccionFueraDelRecorrido

	| congreso lineaD palermo tarjeta retiro |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso .
	palermo := self palermo .
	retiro := self retiro .

	lineaD := self subteConParadas: {congreso. palermo } tarifa: 1000*peso.

	self should: [lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: retiro .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: Subte paradaFueraDelRecorridoErrorDescription.
				self assert: tarjeta saldo equals: 2000*peso.
				self assert: tarjeta viajes isEmpty .
			].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test05ElSubteRechazaUnaDireccionQueEsUnaParadaIntermedia

	"Subte Línea D:
- Paradas: Congreso de Tucumán (0*kilometer) ↔ Tribunales (1.2*kilometer) ↔ Callao
(2.5*kilometer) ↔Palermo (6*kilometer)
- Cuadro tarifario: Siempre es 1000 * peso"

	| congreso lineaD palermo tarjeta callao tribunales |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	tribunales := self tribunales .
	callao := self callao .
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. tribunales . callao . palermo } tarifa: 1000*peso.

	self should: [lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: callao  .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: Subte direccionDebeSerUnaCabeceraErrorDescription.
				self assert: tarjeta saldo equals: 2000*peso.
				self assert: tarjeta viajes isEmpty .
			].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test06ElSubtePermiteViajarHaciaLaPrimeraParadaConTarjetaSinDescuento

	"Subte Línea D:
- Paradas: Congreso de Tucumán (0*kilometer) ↔ Tribunales (1.2*kilometer) ↔ Callao
(2.5*kilometer) ↔Palermo (6*kilometer)
- Cuadro tarifario: Siempre es 1000 * peso"

	| congreso lineaD palermo tarjeta callao tribunales |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	tribunales := self tribunales .
	callao := self callao .
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. tribunales . callao . palermo } tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: tribunales conDireccion: congreso.
	self assert: tarjeta saldo equals: 1000*peso.
	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test07ElSubteNoPuedeCrearseConMenosDeDosParadas

	"Subte Línea D:
- Paradas: Congreso de Tucumán (0*kilometer) ↔ Tribunales (1.2*kilometer) ↔ Callao
(2.5*kilometer) ↔Palermo (6*kilometer)
- Cuadro tarifario: Siempre es 1000 * peso"

	| congreso lineaD tarjeta |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.

	self should: [lineaD := self subteConParadas: {congreso} tarifa: 1000*peso]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError  |
				self assert: anError messageText equals: Subte cantidadDeParadasMenorADosErrorDescription.
			]



	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test08ElSubteRechazaUnOrigenFueraDelRecorrido

	| congreso lineaD palermo tarjeta retiro |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.
	retiro := self retiro.

	lineaD := self subteConParadas: {congreso. palermo } tarifa: 1000*peso.

	self should: [lineaD cobrarViajeCon: tarjeta desde: retiro conDireccion: palermo .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: Subte paradaFueraDelRecorridoErrorDescription.
				self assert: tarjeta saldo equals: 2000*peso.
				self assert: tarjeta viajes isEmpty .
			].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test09ElSubteCobraLaTarifaConfiguradaAUnaTarjetaSinDescuento

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 500*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test10LaTarjetaEstudiantilPagaLaMitadDeLaTarifaUnDiaDeSemana

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test11LaTarjetaEstudiantilPagaLaTarifaCompletaUnSabado

	| congreso lineaD palermo tarjeta |
	fechaYHoraActual := fechaYHoraActual next: 1*day.
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test12LaTarjetaEstudiantilPagaLaTarifaCompletaUnDomingo

	| congreso lineaD palermo tarjeta |
	fechaYHoraActual := fechaYHoraActual next: 2*day.
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test13LaTarjetaEstudiantilPuedePagarConSaldoJustoParaLaTarifaConDescuento

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE estudiantilConSaldo: 500*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 0*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test14LaTarjetaDeJubiladoTieneElPrimerViajeDelDiaGratis

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 2000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test15LaTarjetaDeJubiladoPagaLaTarifaCompletaEnElTercerViajeDelDiaSinTrasbordo

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	"Avanzo 3 horas para que no haya trasbordo"
	fechaYHoraActual := fechaYHoraActual next: 3*hour.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test16LaTarjetaDeJubiladoVuelveATenerViajesGratisAlCambiarDeDia

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	fechaYHoraActual := fechaYHoraActual next: 1*day.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 2000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test17LaTarjetaSinDescuentoPagaLaMitadPorTrasbordoDentroDeLasDosHoras

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30*minute .
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test18LaTarjetaSinDescuentoPagaLaTarifaCompletaTresHorasDespuesDelUltimoViaje

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 3*hour .
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 0*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test19LaTarjetaEstudiantilPagaLaMitadPorTrasbordoUnSabado

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	fechaYHoraActual := fechaYHoraActual next: 1*day .
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30*minute .
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test20LaTarjetaDeJubiladoTieneLosDosPrimerosViajesGratisAunqueHagaTrasbordo
	| congreso palermo lineaD tarjeta |

	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	lineaD := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 2000 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test21LaTarjetaDeJubiladoPagaLaMitadPorTrasbordoEnElTercerViajeDelDia
	| congreso palermo lineaD tarjeta |

	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	lineaD := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	lineaD cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1500 * peso! !

!TarjetaBAJETest methodsFor: 'tests'!
test22LaTarjetaSinDescuentoCalculaCadaTrasbordoDesdeElUltimoViaje

	| tarjeta congreso palermo subte |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 3000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	subte := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	subte cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 90 * minute.
	subte cobrarViajeCon: tarjeta desde: palermo conDireccion: congreso.
	fechaYHoraActual := fechaYHoraActual next: 90 * minute.
	subte cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.

	self assert: tarjeta saldo equals: 1000 * peso.
	self assert: tarjeta viajes size equals: 3.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test23ElColectivoCobra600PesosPorUnViajeDeCincoKilometrosSinDescuento
"🚌Colectivo Línea 60:
- Paradas: Constitución (0*kilometer) ↔ Plaza de Mayo (5*kilometer) ↔ Retiro (8*kilometer)
↔ Belgrano (12*kilometer)
- Cuadro tarifario:
- Hasta 5 km: 600 * peso
- Hasta 10 km: 1000 * peso
- Más de 10 km: 1300 * peso"
	| tarjeta constitucion plazaDeMayo linea60 |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	constitucion := self constitucionSinTilde .
	plazaDeMayo := self plazaDeMayo.
	
	linea60 := self colectivoConParadas: {constitucion . plazaDeMayo }.
	
	linea60 cobrarViajeCon: tarjeta desde: constitucion hasta: plazaDeMayo .
	self assert: tarjeta saldo equals: 1400 * peso
! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test24ElColectivoCobra1000PesosPorUnViajeDeOchoKilometrosSinDescuento
	| constitucion retiro linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	retiro := self retiro.

	linea60 := self colectivoConParadas: { constitucion. retiro }.

	linea60 cobrarViajeCon: tarjeta desde: constitucion hasta: retiro.

	self assert: tarjeta saldo equals: 1000 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test25ElColectivoCobra1300PesosPorUnViajeDeDoceKilometrosSinDescuento
	| constitucion belgrano linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.

	linea60 := self colectivoConParadas: { constitucion. belgrano }.

	linea60 cobrarViajeCon: tarjeta desde: constitucion hasta: belgrano.

	self assert: tarjeta saldo equals: 700 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test26ElColectivoRechazaUnOrigenFueraDelRecorrido	

	| constitucion belgrano linea60 tarjeta retiro |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.
	retiro := self retiro .
	linea60 := self colectivoConParadas: { constitucion. belgrano }.

	self 
	should: [	linea60 cobrarViajeCon: tarjeta desde: retiro hasta: belgrano.]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: Colectivo paradaFueraDelRecorridoErrorDescription.
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]

! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test27ElColectivoRechazaUnDestinoFueraDelRecorrido	

	| constitucion belgrano linea60 tarjeta retiro |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.
	retiro := self retiro .
	linea60 := self colectivoConParadas: { constitucion. belgrano }.

	self 
	should: [	linea60 cobrarViajeCon: tarjeta desde: constitucion hasta: retiro .]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: Colectivo paradaFueraDelRecorridoErrorDescription.
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]

! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test28ElColectivoRechazaUnViajeConOrigenYDestinoIguales	

	| constitucion belgrano linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.

	linea60 := self colectivoConParadas: { constitucion. belgrano }.

	self 
	should: [	linea60 cobrarViajeCon: tarjeta desde: constitucion hasta: constitucion .]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: Colectivo paradasDebenSerDistintasErrorDescription.
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]

! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test29ElColectivoNoPuedeCrearseConMenosDeDosParadas	

	| constitucion belgrano linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.


	self 
	should: [linea60 := self colectivoConParadas: { constitucion }.]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: Colectivo cantidadDeParadasMenorADosErrorDescription.
		]

	! !

!TarjetaBAJETest methodsFor: 'tests'!
test30ElColectivoCobra1000PesosPorExactamenteDiezKilometrosSinDescuento

	| tarjeta constitucion destino colectivo |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	destino := Parada llamada: 'Destino' aDistanciaDeCabecera: 10 * kilometer.
	colectivo := self colectivoConParadas: { constitucion. destino }.

	colectivo cobrarViajeCon: tarjeta desde: constitucion hasta: destino.

	self assert: tarjeta saldo equals: 1000 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test31ElColectivoCobraLaMismaTarifaAlViajarEnSentidoInverso

	| tarjeta constitucion belgrano colectivo |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.
	colectivo := self colectivoConParadas: { constitucion. belgrano }.

	colectivo cobrarViajeCon: tarjeta desde: belgrano hasta: constitucion.

	self assert: tarjeta saldo equals: 700 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test32ElTrenCobraHastaLaCabeceraIndicadaAlEntrarSinDescuento

	| tarjeta retiro sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. sanIsidro. tigre }. 
		
	tren cobrarViajeCon: tarjeta desde: sanIsidro  conDireccion: retiro.
	
	self assert: tarjeta saldo equals: 1400*peso.
	self assert: tarjeta viajes size equals: 1 .
	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test33ElTrenReintegraLaDiferenciaAlSalirSinRegistrarOtroViaje

	| tarjeta retiro sanIsidro tigre tren belgrano |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren .
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }. 
		
	tren cobrarViajeCon: tarjeta desde: sanIsidro  conDireccion: retiro.
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano .
	
	
	self assert: tarjeta saldo equals: 1600*peso.
	self assert: tarjeta viajes size equals: 1.
	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test34ElTrenRechazaUnaDireccionQueEsUnaParadaIntermedia

	| tarjeta retiro sanIsidro tigre tren belgrano |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren .
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }. 
		
	self 
	should: [	tren cobrarViajeCon: tarjeta desde: belgrano  conDireccion: sanIsidro ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Tren direccionDebeSerUnaCabeceraErrorDescription .
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]


	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test35ElTrenRechazaUnViajeConOrigenYDireccionIguales

	| tarjeta retiro sanIsidro tigre tren belgrano |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren .
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre}. 
		
	self 
	should: [	tren cobrarViajeCon: tarjeta desde: retiro conDireccion: retiro ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Tren paradasDebenSerDistintasErrorDescription .
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]


	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test36ElTrenRechazaUnaDireccionFueraDelRecorrido

	| tarjeta retiro sanIsidro tigre tren belgrano |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren .
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. belgrano. sanIsidro.}. 
		
	self 
	should: [	tren cobrarViajeCon: tarjeta desde: retiro conDireccion: tigre ]  
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Tren paradaFueraDelRecorridoErrorDescription .
			self assert: tarjeta saldo equals: 2000*peso.
			self assert: tarjeta viajes isEmpty .
		]


	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test37ElTrenReintegraLaDiferenciaAlSalirSinRegistrarOtroViaje

	| tarjeta retiro sanIsidro tigre tren belgrano |
	tarjeta := TarjetaBAJE estudiantilConSaldo: 2000*peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren .
	sanIsidro := self sanIsidro.
	tigre := self tigre.
		
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }. 
		
	tren cobrarViajeCon: tarjeta desde: sanIsidro  conDireccion: retiro.
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano .
	
	
	self assert: tarjeta saldo equals: 1800*peso.
	self assert: tarjeta viajes size equals: 1.
	! !

!TarjetaBAJETest methodsFor: 'tests'!
test38ElTrenNoReintegraDineroAlFinalizarUnViajeGratisDeJubilado

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	tren cobrarViajeCon: tarjeta desde: sanIsidro conDireccion: retiro.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano.

	self assert: tarjeta saldo equals: 2000 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test39ElTrenReintegraLaDiferenciaRespetandoElDescuentoPorTrasbordo

	| tarjeta retiro belgrano sanIsidro tigre tren congreso palermo subte |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.
	congreso := self congreso.
	palermo := self palermo.
	subte := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	subte cobrarViajeCon: tarjeta desde: congreso conDireccion: palermo.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	tren cobrarViajeCon: tarjeta desde: sanIsidro conDireccion: retiro.
	self assert: tarjeta saldo equals: 700 * peso.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano.

	self assert: tarjeta saldo equals: 800 * peso.
	self assert: tarjeta viajes size equals: 2.! !

!TarjetaBAJETest methodsFor: 'tests'!
test40ElTrenNoReintegraDineroSiLaSalidaMantieneElTramoTarifario

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	tren cobrarViajeCon: tarjeta desde: tigre conDireccion: retiro.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano.

	self assert: tarjeta saldo equals: 1400 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test41ElTrenMantieneIndependientesLosViajesDeDosTarjetas

	| tarjeta otraTarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.
	otraTarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.

	tren cobrarViajeCon: tarjeta desde: sanIsidro conDireccion: retiro.
	tren cobrarViajeCon: otraTarjeta desde: tigre conDireccion: retiro.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	tren finalizarViajeCon: tarjeta enEstacion: belgrano.
	tren finalizarViajeCon: otraTarjeta enEstacion: belgrano.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: otraTarjeta saldo equals: 1400 * peso.
	self assert: tarjeta viajes size equals: 1.
	self assert: otraTarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test42ElTrenCobra400PesosPorExactamenteQuinceKilometrosSinDescuento

	| tarjeta retiro destino tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	destino := Parada llamada: 'Destino' aDistanciaDeCabecera: 15 * kilometer.
	tren := self trenConParadas: { retiro. destino }.

	tren cobrarViajeCon: tarjeta desde: retiro conDireccion: destino.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test43ElTrenCobraSegunLaDistanciaAlViajarHaciaLaUltimaParada

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	tren cobrarViajeCon: tarjeta desde: sanIsidro conDireccion: tigre.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests'!
test44ElTrenRechazaUnOrigenFueraDelRecorrido

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. sanIsidro. tigre }.

	self
		should: [ tren cobrarViajeCon: tarjeta desde: belgrano conDireccion: retiro ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Tren paradaFueraDelRecorridoErrorDescription.
			self assert: tarjeta saldo equals: 2000 * peso.
			self assert: tarjeta viajes isEmpty ].! !

!TarjetaBAJETest methodsFor: 'tests'!
test45ElTrenNoPuedeCrearseConMenosDeDosParadas

	| retiro |
	retiro := self retiroDelTren.

	self
		should: [ self trenConParadas: { retiro } ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Tren cantidadDeParadasMenorADosErrorDescription ].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test46LaTarjetaSinDescuentoPagaLaMitadDelSubteAlHacerTrasbordoDesdeUnColectivo
	
	"🚌Colectivo Línea 60:
- Paradas: Constitución (0*kilometer) ↔ Plaza de Mayo (5*kilometer) ↔ Retiro (8*kilometer)
↔ Belgrano (12*kilometer)
- Cuadro tarifario:
- Hasta 5 km: 600 * peso
- Hasta 10 km: 1000 * peso
- Más de 10 km: 1300 * peso"
	
	| constitucion plazaDeMayo retiro belgrano colectivo congreso tribunales callao palermo subte tarjeta |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000*peso.


	constitucion := self constitucionSinTilde .
	plazaDeMayo := self plazaDeMayo .
	retiro := self retiro .
	belgrano := self belgranoDelColectivo .
	
	colectivo := self colectivoConParadas: {constitucion . plazaDeMayo . retiro. belgrano }.
		
		
		"Subte Línea D:
- Paradas: Congreso de Tucumán (0*kilometer) ↔ Tribunales (1.2*kilometer) ↔ Callao
(2.5*kilometer) ↔Palermo (6*kilometer)
- Cuadro tarifario: Siempre es 1000 * peso"
	
	congreso := self congreso .
	tribunales := self tribunales .
	callao := self callao .
	palermo := self palermo .
	
	subte := self subteConParadas: {congreso . tribunales . callao . palermo } tarifa: 1000*peso.
	
	colectivo cobrarViajeCon: tarjeta desde: constitucion hasta: plazaDeMayo .
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	subte cobrarViajeCon: tarjeta desde: congreso  conDireccion: palermo .
	
	self assert: tarjeta saldo equals: 900*peso.
	self assert: tarjeta viajes size equals: 2.! !




!TarjetaBAJETest methodsFor: 'setup' stamp: 'HAW 12/Nov/2026, 1:19:20 pm (UTC)'!
setUp

	fechaYHoraActual := November / 28 / 2025 at: 10:00! !


!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:50:42 pm (UTC)'!
callao

	^ Parada llamada: 'Callao' aDistanciaDeCabecera: 2.5* kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:49:28 pm (UTC)'!
congreso

	^ Parada llamada: 'Congreso de Tucumán' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:49:40 pm (UTC)'!
palermo

	^ Parada llamada: 'Palermo' aDistanciaDeCabecera: 6 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:51:07 pm (UTC)'!
retiro

	^ Parada llamada: 'Retiro' aDistanciaDeCabecera: 8 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:55:01 pm (UTC)'!
tribunales

	^ Parada llamada: 'Tribunales' aDistanciaDeCabecera: 1.2*kilometer ! !


!TarjetaBAJETest methodsFor: 'reloj' stamp: 'HAW 12/Nov/2026, 12:43:32 pm (UTC)'!
ahora

	^fechaYHoraActual ! !


!TarjetaBAJETest methodsFor: 'creacion de medios de transporte' stamp: ''!
colectivoConParadas: unasParadas
	^ Colectivo
		conParadas: unasParadas
		yCuadroTarifario: self cuadroTarifarioDeColectivo
		conReloj: self! !

!TarjetaBAJETest methodsFor: 'creacion de medios de transporte' stamp: ''!
subteConParadas: unasParadas tarifa: unaTarifa
	^ Subte
		conParadas: unasParadas
		yCuadroTarifario: unaTarifa
		conReloj: self! !

!TarjetaBAJETest methodsFor: 'creacion de medios de transporte' stamp: ''!
trenConParadas: unasParadas
	^ Tren
		conParadas: unasParadas
		yCuadroTarifario: self cuadroTarifarioDeTren
		conReloj: self! !


!TarjetaBAJETest methodsFor: 'cuadros tarifarios' stamp: ''!
cuadroTarifarioDeColectivo
	^ {
		(5 * kilometer) -> (600 * peso).
		(10 * kilometer) -> (1000 * peso).
		PlusInfinity new -> (1300 * peso) }! !

!TarjetaBAJETest methodsFor: 'cuadros tarifarios' stamp: ''!
cuadroTarifarioDeTren
	^ {
		(15 * kilometer) -> (400 * peso).
		PlusInfinity new -> (600 * peso) }! !

!TarjetaBAJETest methodsFor: 'paradas'!
retiroDelTren
	^ Parada llamada: 'Retiro' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
belgranoDelTren
	^ Parada llamada: 'Belgrano' aDistanciaDeCabecera: 8 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
belgranoDelColectivo
	^ Parada llamada: 'Belgrano' aDistanciaDeCabecera: 12 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
sanIsidro
	^ Parada llamada: 'San Isidro' aDistanciaDeCabecera: 18 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
tigre
	^ Parada llamada: 'Tigre' aDistanciaDeCabecera: 28 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
constitucion
	^ Parada llamada: 'Constitución' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
constitucionSinTilde
	^ Parada llamada: 'Constitucion' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas'!
plazaDeMayo
	^ Parada llamada: 'Plaza de Mayo' aDistanciaDeCabecera: 5 * kilometer! !
