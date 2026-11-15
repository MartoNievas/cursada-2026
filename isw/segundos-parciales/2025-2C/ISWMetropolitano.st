!classDefinition: #CuadroTarifario category: #ISWMetropolitano!
Object subclass: #CuadroTarifario
	instanceVariableNames: 'tarifasPorDistancia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!CuadroTarifario methodsFor: 'initialization' stamp: 'HAW 13/Nov/2026, 6:14:07 pm (UTC)'!
initializeConTarifas: unaTarifasPorDistancia 
	
	tarifasPorDistancia := unaTarifasPorDistancia.! !


!CuadroTarifario methodsFor: 'calculo importe' stamp: 'HAW 13/Nov/2026, 6:21:57 pm (UTC)'!
importeDesde: unaParadaOrigen hasta: unaParadaDestino 
	
	| distanciaEntreParadas |
	distanciaEntreParadas := unaParadaOrigen distanciaHasta: unaParadaDestino.
	^ self importeParaDistancia: distanciaEntreParadas .! !

!CuadroTarifario methodsFor: 'calculo importe' stamp: 'HAW 13/Nov/2026, 6:19:31 pm (UTC)'!
importeParaDistancia: unaDistanciaEntreParadas 
	
	| tramo |
	tramo := tarifasPorDistancia detect: [:unaAsociacion |  
			unaDistanciaEntreParadas <= unaAsociacion key
		] .
	^ tramo value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CuadroTarifario class' category: #ISWMetropolitano!
CuadroTarifario class
	instanceVariableNames: ''!

!CuadroTarifario class methodsFor: 'instance creation' stamp: 'HAW 13/Nov/2026, 6:13:58 pm (UTC)'!
conTarifas: unaTarifasPorDistancia 

	^self new initializeConTarifas: unaTarifasPorDistancia ! !


!classDefinition: #MedioDeTransporte category: #ISWMetropolitano!
Object subclass: #MedioDeTransporte
	instanceVariableNames: 'paradas cuadroTarifario'
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



!MedioDeTransporte methodsFor: 'initialization' stamp: 'HAW 12/Nov/2026, 4:03:35 pm (UTC)'!
initializeConParadas: unaParadas yCuadroTarifario: unCuadroTarifario
	
	paradas := unaParadas.
	cuadroTarifario := unCuadroTarifario.! !

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
conParadas: unaParadas yCuadroTarifario: unCuadroTarifario

	unaParadas size < 2 ifTrue: [self error: self cantidadDeParadasMenorADosErrorDescription].

	^self new initializeConParadas: unaParadas yCuadroTarifario: unCuadroTarifario ! !


!classDefinition: #Colectivo category: #ISWMetropolitano!
MedioDeTransporte subclass: #Colectivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Colectivo methodsFor: 'tarifas' stamp: ''!
importeDesde: unaParadaOrigen hasta: unaParadaDestino
	self assertViajeDesde: unaParadaOrigen hasta: unaParadaDestino.
	^ cuadroTarifario importeDesde: unaParadaOrigen hasta: unaParadaDestino! !

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

!Subte methodsFor: 'tarifas' stamp: ''!
importeDesde: unaParadaOrigen conDireccion: unaParadaCabecera
	self assertViajeDesde: unaParadaOrigen hasta: unaParadaCabecera.
	self assertDireccionEsCabecera: unaParadaCabecera.
	^ cuadroTarifario! !

!classDefinition: #Tren category: #ISWMetropolitano!
MedioDeTransporteConDireccion subclass: #Tren
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!Tren methodsFor: 'tarifas' stamp: ''!
importeDesde: unaParadaOrigen conDireccion: unaParadaCabecera
	self assertViajeDesde: unaParadaOrigen hasta: unaParadaCabecera.
	self assertDireccionEsCabecera: unaParadaCabecera.
	^ cuadroTarifario importeDesde: unaParadaOrigen hasta: unaParadaCabecera! !

!Tren methodsFor: 'tarifas' stamp: ''!
importeDesde: unaParadaOrigen hasta: unaParadaDestino
	^ cuadroTarifario importeDesde: unaParadaOrigen hasta: unaParadaDestino! !

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


!classDefinition: #LectorDeColectivo category: #ISWMetropolitano!
Object subclass: #LectorDeColectivo
	instanceVariableNames: 'linea reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!LectorDeColectivo methodsFor: 'initialization' stamp: ''!
initializeEn: unaLinea conReloj: unReloj
	linea := unaLinea.
	reloj := unReloj! !

!LectorDeColectivo methodsFor: 'cobro' stamp: ''!
cobrarViajeCon: unaTarjeta desde: origen hasta: destino
	| importe |
	importe := linea importeDesde: origen hasta: destino.
	^ unaTarjeta cobrar: importe enFechaYHora: reloj ahora! !

!classDefinition: 'LectorDeColectivo class' category: #ISWMetropolitano!
LectorDeColectivo class
	instanceVariableNames: ''!

!LectorDeColectivo class methodsFor: 'instance creation' stamp: ''!
en: unaLinea conReloj: unReloj
	^ self new initializeEn: unaLinea conReloj: unReloj! !


!classDefinition: #LectorDeSubte category: #ISWMetropolitano!
Object subclass: #LectorDeSubte
	instanceVariableNames: 'linea parada direccion reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!LectorDeSubte methodsFor: 'initialization' stamp: ''!
initializeEn: unaLinea enParada: unaParada conDireccion: unaDireccion conReloj: unReloj
	linea := unaLinea.
	parada := unaParada.
	direccion := unaDireccion.
	reloj := unReloj! !

!LectorDeSubte methodsFor: 'cobro' stamp: ''!
cobrarViajeCon: unaTarjeta
	| importe |
	importe := linea importeDesde: parada conDireccion: direccion.
	^ unaTarjeta cobrar: importe enFechaYHora: reloj ahora! !

!classDefinition: 'LectorDeSubte class' category: #ISWMetropolitano!
LectorDeSubte class
	instanceVariableNames: ''!

!LectorDeSubte class methodsFor: 'instance creation' stamp: ''!
en: unaLinea enParada: unaParada conDireccion: unaDireccion conReloj: unReloj
	^ self new initializeEn: unaLinea enParada: unaParada
		conDireccion: unaDireccion conReloj: unReloj! !


!classDefinition: #LectorDeTren category: #ISWMetropolitano!
Object subclass: #LectorDeTren
	instanceVariableNames: 'linea parada direccion reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISWMetropolitano'!

!LectorDeTren methodsFor: 'initialization' stamp: ''!
initializeEn: unaLinea enParada: unaParada conDireccion: unaDireccion conReloj: unReloj
	linea := unaLinea.
	parada := unaParada.
	direccion := unaDireccion.
	reloj := unReloj! !

!LectorDeTren methodsFor: 'cobro' stamp: ''!
cobrarViajeCon: unaTarjeta
	| importe |
	importe := linea importeDesde: parada conDireccion: direccion.
	^ unaTarjeta iniciarViajeEnTrenDesde: parada
		conTarifa: importe enFechaYHora: reloj ahora! !

!LectorDeTren methodsFor: 'cobro' stamp: ''!
finalizarViajeCon: unaTarjeta
	| tarifaReal |
	tarifaReal := linea importeDesde: unaTarjeta origenEnTren hasta: parada.
	^ unaTarjeta finalizarViajeEnTrenConTarifa: tarifaReal! !

!classDefinition: 'LectorDeTren class' category: #ISWMetropolitano!
LectorDeTren class
	instanceVariableNames: ''!

!LectorDeTren class methodsFor: 'instance creation' stamp: ''!
en: unaLinea enParada: unaParada conReloj: unReloj
	^ self en: unaLinea enParada: unaParada conDireccion: nil conReloj: unReloj! !

!LectorDeTren class methodsFor: 'instance creation' stamp: ''!
en: unaLinea enParada: unaParada conDireccion: unaDireccion conReloj: unReloj
	^ self new initializeEn: unaLinea enParada: unaParada
		conDireccion: unaDireccion conReloj: unReloj! !


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

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

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

	self should: [(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.]
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

	self should: [(LectorDeSubte en: lineaD enParada: congreso conDireccion: congreso conReloj: self) cobrarViajeCon: tarjeta .]
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

	self should: [(LectorDeSubte en: lineaD enParada: congreso conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta .]
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

	self should: [(LectorDeSubte en: lineaD enParada: congreso conDireccion: callao conReloj: self) cobrarViajeCon: tarjeta  .]
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

	(LectorDeSubte en: lineaD enParada: tribunales conDireccion: congreso conReloj: self) cobrarViajeCon: tarjeta.
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

	self should: [(LectorDeSubte en: lineaD enParada: retiro conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta .]
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

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test10LaTarjetaEstudiantilPagaLaMitadDeLaTarifaUnDiaDeSemana

	| congreso lineaD palermo tarjeta |
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test11LaTarjetaEstudiantilPagaLaTarifaCompletaUnSabado

	| congreso lineaD palermo tarjeta |
	fechaYHoraActual := fechaYHoraActual next: 1*day.
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test12LaTarjetaEstudiantilPagaLaTarifaCompletaUnDomingo

	| congreso lineaD palermo tarjeta |
	fechaYHoraActual := fechaYHoraActual next: 2*day.
	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test13LaTarjetaEstudiantilPuedePagarConSaldoJustoParaLaTarifaConDescuento

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE estudiantilConSaldo: 500*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 0*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test14LaTarjetaDeJubiladoTieneElPrimerViajeDelDiaGratis

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 2000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test15LaTarjetaDeJubiladoPagaLaTarifaCompletaEnElTercerViajeDelDiaSinTrasbordo

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	"Avanzo 3 horas para que no haya trasbordo"
	fechaYHoraActual := fechaYHoraActual next: 3*hour.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test16LaTarjetaDeJubiladoVuelveATenerViajesGratisAlCambiarDeDia

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE jubiladoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	fechaYHoraActual := fechaYHoraActual next: 1*day.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 2000*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test17LaTarjetaSinDescuentoPagaLaMitadPorTrasbordoDentroDeLasDosHoras

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30*minute .
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:08 pm (UTC)'!
test18LaTarjetaSinDescuentoPagaLaTarifaCompletaTresHorasDespuesDelUltimoViaje

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE sinDescuentoConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 3*hour .
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 0*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test19LaTarjetaEstudiantilPagaLaMitadPorTrasbordoUnSabado

	| congreso lineaD palermo tarjeta |

	tarjeta :=TarjetaBAJE estudiantilConSaldo: 2000*peso.
	congreso := self congreso.
	palermo := self palermo.

	lineaD := self subteConParadas: {congreso. palermo} tarifa: 1000*peso.

	fechaYHoraActual := fechaYHoraActual next: 1*day .
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30*minute .
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 500*peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test20LaTarjetaDeJubiladoTieneLosDosPrimerosViajesGratisAunqueHagaTrasbordo
	| congreso palermo lineaD tarjeta |

	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	lineaD := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 2000 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test21LaTarjetaDeJubiladoPagaLaMitadPorTrasbordoEnElTercerViajeDelDia
	| congreso palermo lineaD tarjeta |

	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	lineaD := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeSubte en: lineaD enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1500 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test22LaTarjetaSinDescuentoCalculaCadaTrasbordoDesdeElUltimoViaje

	| tarjeta congreso palermo subte |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 3000 * peso.
	congreso := self congreso.
	palermo := self palermo.
	subte := self subteConParadas: { congreso. palermo } tarifa: 1000 * peso.

	(LectorDeSubte en: subte enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 90 * minute.
	(LectorDeSubte en: subte enParada: palermo conDireccion: congreso conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 90 * minute.
	(LectorDeSubte en: subte enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.

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
	
	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: plazaDeMayo .
	self assert: tarjeta saldo equals: 1400 * peso
! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test24ElColectivoCobra1000PesosPorUnViajeDeOchoKilometrosSinDescuento
	| constitucion retiro linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	retiro := self retiro.

	linea60 := self colectivoConParadas: { constitucion. retiro }.

	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: retiro.

	self assert: tarjeta saldo equals: 1000 * peso! !

!TarjetaBAJETest methodsFor: 'tests' stamp: 'HAW 12/Nov/2026, 7:57:09 pm (UTC)'!
test25ElColectivoCobra1300PesosPorUnViajeDeDoceKilometrosSinDescuento
	| constitucion belgrano linea60 tarjeta |

	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.

	linea60 := self colectivoConParadas: { constitucion. belgrano }.

	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: belgrano.

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
	should: [	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: retiro hasta: belgrano.]
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
	should: [	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: retiro .]
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
	should: [	(LectorDeColectivo en: linea60 conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: constitucion .]
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

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test30ElColectivoCobra1000PesosPorExactamenteDiezKilometrosSinDescuento

	| tarjeta constitucion destino colectivo |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	destino := Parada llamada: 'Destino' aDistanciaDeCabecera: 10 * kilometer.
	colectivo := self colectivoConParadas: { constitucion. destino }.

	(LectorDeColectivo en: colectivo conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: destino.

	self assert: tarjeta saldo equals: 1000 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test31ElColectivoCobraLaMismaTarifaAlViajarEnSentidoInverso

	| tarjeta constitucion belgrano colectivo |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	constitucion := self constitucion.
	belgrano := self belgranoDelColectivo.
	colectivo := self colectivoConParadas: { constitucion. belgrano }.

	(LectorDeColectivo en: colectivo conReloj: self) cobrarViajeCon: tarjeta desde: belgrano hasta: constitucion.

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
		
	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	
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
		
	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta .
	
	
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
	should: [	(LectorDeTren en: tren enParada: belgrano conDireccion: sanIsidro conReloj: self) cobrarViajeCon: tarjeta ]
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
	should: [	(LectorDeTren en: tren enParada: retiro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta ]
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
	should: [	(LectorDeTren en: tren enParada: retiro conDireccion: tigre conReloj: self) cobrarViajeCon: tarjeta ]
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
		
	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta .
	
	
	self assert: tarjeta saldo equals: 1800*peso.
	self assert: tarjeta viajes size equals: 1.
	! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test38ElTrenNoReintegraDineroAlFinalizarUnViajeGratisDeJubilado

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE jubiladoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 2000 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
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

	(LectorDeSubte en: subte enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	self assert: tarjeta saldo equals: 700 * peso.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 800 * peso.
	self assert: tarjeta viajes size equals: 2.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test40ElTrenNoReintegraDineroSiLaSalidaMantieneElTramoTarifario

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	(LectorDeTren en: tren enParada: tigre conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1400 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test41ElTrenMantieneIndependientesLosViajesDeDosTarjetas

	| tarjeta otraTarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.
	otraTarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.

	(LectorDeTren en: tren enParada: sanIsidro conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta.
	(LectorDeTren en: tren enParada: tigre conDireccion: retiro conReloj: self) cobrarViajeCon: otraTarjeta.
	fechaYHoraActual := fechaYHoraActual next: 30 * minute.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: tarjeta.
	(LectorDeTren en: tren enParada: belgrano conReloj: self) finalizarViajeCon: otraTarjeta.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: otraTarjeta saldo equals: 1400 * peso.
	self assert: tarjeta viajes size equals: 1.
	self assert: otraTarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test42ElTrenCobra400PesosPorExactamenteQuinceKilometrosSinDescuento

	| tarjeta retiro destino tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	destino := Parada llamada: 'Destino' aDistanciaDeCabecera: 15 * kilometer.
	tren := self trenConParadas: { retiro. destino }.

	(LectorDeTren en: tren enParada: retiro conDireccion: destino conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test43ElTrenCobraSegunLaDistanciaAlViajarHaciaLaUltimaParada

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. belgrano. sanIsidro. tigre }.

	(LectorDeTren en: tren enParada: sanIsidro conDireccion: tigre conReloj: self) cobrarViajeCon: tarjeta.

	self assert: tarjeta saldo equals: 1600 * peso.
	self assert: tarjeta viajes size equals: 1.! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
test44ElTrenRechazaUnOrigenFueraDelRecorrido

	| tarjeta retiro belgrano sanIsidro tigre tren |
	tarjeta := TarjetaBAJE sinDescuentoConSaldo: 2000 * peso.
	retiro := self retiroDelTren.
	belgrano := self belgranoDelTren.
	sanIsidro := self sanIsidro.
	tigre := self tigre.
	tren := self trenConParadas: { retiro. sanIsidro. tigre }.

	self
		should: [ (LectorDeTren en: tren enParada: belgrano conDireccion: retiro conReloj: self) cobrarViajeCon: tarjeta ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Tren paradaFueraDelRecorridoErrorDescription.
			self assert: tarjeta saldo equals: 2000 * peso.
			self assert: tarjeta viajes isEmpty ].! !

!TarjetaBAJETest methodsFor: 'tests' stamp: ''!
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
	
	(LectorDeColectivo en: colectivo conReloj: self) cobrarViajeCon: tarjeta desde: constitucion hasta: plazaDeMayo .
	fechaYHoraActual := fechaYHoraActual next: 30*minute.
	(LectorDeSubte en: subte enParada: congreso conDireccion: palermo conReloj: self) cobrarViajeCon: tarjeta .
	
	self assert: tarjeta saldo equals: 900*peso.
	self assert: tarjeta viajes size equals: 2.! !


!TarjetaBAJETest methodsFor: 'setup' stamp: 'HAW 12/Nov/2026, 1:19:20 pm (UTC)'!
setUp

	fechaYHoraActual := November / 28 / 2025 at: 10:00! !


!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
belgranoDelColectivo
	^ Parada llamada: 'Belgrano' aDistanciaDeCabecera: 12 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
belgranoDelTren
	^ Parada llamada: 'Belgrano' aDistanciaDeCabecera: 8 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:50:42 pm (UTC)'!
callao

	^ Parada llamada: 'Callao' aDistanciaDeCabecera: 2.5* kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:49:28 pm (UTC)'!
congreso

	^ Parada llamada: 'Congreso de Tucumán' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
constitucion
	^ Parada llamada: 'Constitución' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
constitucionSinTilde
	^ Parada llamada: 'Constitucion' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:49:40 pm (UTC)'!
palermo

	^ Parada llamada: 'Palermo' aDistanciaDeCabecera: 6 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
plazaDeMayo
	^ Parada llamada: 'Plaza de Mayo' aDistanciaDeCabecera: 5 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: 'HAW 12/Nov/2026, 12:51:07 pm (UTC)'!
retiro

	^ Parada llamada: 'Retiro' aDistanciaDeCabecera: 8 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
retiroDelTren
	^ Parada llamada: 'Retiro' aDistanciaDeCabecera: 0 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
sanIsidro
	^ Parada llamada: 'San Isidro' aDistanciaDeCabecera: 18 * kilometer! !

!TarjetaBAJETest methodsFor: 'paradas' stamp: ''!
tigre
	^ Parada llamada: 'Tigre' aDistanciaDeCabecera: 28 * kilometer! !

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
		yCuadroTarifario: self cuadroTarifarioDeColectivo! !

!TarjetaBAJETest methodsFor: 'creacion de medios de transporte' stamp: ''!
subteConParadas: unasParadas tarifa: unaTarifa
	^ Subte
		conParadas: unasParadas
		yCuadroTarifario: unaTarifa! !

!TarjetaBAJETest methodsFor: 'creacion de medios de transporte' stamp: ''!
trenConParadas: unasParadas
	^ Tren
		conParadas: unasParadas
		yCuadroTarifario: self cuadroTarifarioDeTren! !


!TarjetaBAJETest methodsFor: 'cuadros tarifarios' stamp: 'HAW 13/Nov/2026, 6:13:33 pm (UTC)'!
cuadroTarifarioDeColectivo
	^ CuadroTarifario conTarifas: {
		(5 * kilometer) -> (600 * peso).
		(10 * kilometer) -> (1000 * peso).
		PlusInfinity new -> (1300 * peso) }! !

!TarjetaBAJETest methodsFor: 'cuadros tarifarios' stamp: 'HAW 13/Nov/2026, 6:17:43 pm (UTC)'!
cuadroTarifarioDeTren
	^ CuadroTarifario conTarifas: {
		(15 * kilometer) -> (400 * peso).
		PlusInfinity new -> (600 * peso) }! !
