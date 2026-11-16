!classDefinition: #BuscadorDeVuelos category: #'2024-2C-Parcial'!
Object subclass: #BuscadorDeVuelos
	instanceVariableNames: 'definicionesDeVuelos contadorDePasajeros descuentos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!BuscadorDeVuelos methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 5:47:19 pm (UTC)'!
initializeCon: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos contandoCon: unContadorDePasajeros  
	
	
	definicionesDeVuelos := unasDefinicionesDeVuelos.
	contadorDePasajeros := unContadorDePasajeros .
	descuentos := unosTiposDeDescuentos .! !


!BuscadorDeVuelos methodsFor: 'busqueda' stamp: 'HAW 16/Nov/2026, 3:36:56 pm (UTC)'!
desde: unOrigen a: unDestino partiendoEn: unaFechaDePartida para: unaCantidadDePasajeros 
	
	
	
	^ definicionesDeVuelos select: [:unaDefinicionDeVuelo | (unaDefinicionDeVuelo 
		parteDe: unOrigen 
		hacia: unDestino  
		en: unaFechaDePartida) 
		and: [unaCantidadDePasajeros  <= contadorDePasajeros asientosDisponibles ] ] thenCollect: [:unaDefinicionDeVueloEncontrada | 
			self vueloPara: unaDefinicionDeVueloEncontrada en: unaFechaDePartida.
		] .	! !

!BuscadorDeVuelos methodsFor: 'busqueda' stamp: 'HAW 16/Nov/2026, 4:56:15 pm (UTC)'!
desde: unOrigen a: unDestino partiendoEn: unaFechaDePartida regresandoEn: unaFechaDeRegreso para: unaCantidadDePasajeros 
	
	| tramoIda tramoVuelta |
	tramoIda := Tramo desde: unOrigen a: unDestino  partiendoEn: unaFechaDePartida .
	tramoVuelta := Tramo desde: unDestino a: unOrigen partiendoEn: unaFechaDeRegreso .
	
	^ self porTramos: {tramoIda. tramoVuelta } para: unaCantidadDePasajeros .! !

!BuscadorDeVuelos methodsFor: 'busqueda' stamp: 'HAW 16/Nov/2026, 5:22:55 pm (UTC)'!
porTramos: unosTramos para: unaCantidadDePasajeros 
	
	| vuelosPorTramo |
	vuelosPorTramo := unosTramos collect: [:unTramo | 
			self desde: unTramo origen 
			a:  unTramo destino
			partiendoEn:  unTramo fechaDePartida
			para: unaCantidadDePasajeros 
		]  .
	
	^ vuelosPorTramo todasLasCombinaciones select: [:unaCombinacion |
			self esUnaCombinacionValida: unaCombinacion .
		] thenCollect: [:unaCombinacion |
			VueloMultitramo con: unaCombinacion .
		].
	
	! !

!BuscadorDeVuelos methodsFor: 'busqueda' stamp: 'HAW 16/Nov/2026, 5:49:23 pm (UTC)'!
vueloPara: unaDefinicion en: unaFecha

	^ VueloIda
		definidoPor: unaDefinicion
		partiendoEn: unaFecha 
		conDescuentos: descuentos! !


!BuscadorDeVuelos methodsFor: 'validacion' stamp: 'HAW 16/Nov/2026, 5:26:47 pm (UTC)'!
esUnaCombinacionValida: unaCombinacion 

	1 to: unaCombinacion size - 1 do: [:indice |
		((unaCombinacion at: indice) llegada <
			(unaCombinacion at: indice + 1) partida)
				ifFalse: [^ false]].

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BuscadorDeVuelos class' category: #'2024-2C-Parcial'!
BuscadorDeVuelos class
	instanceVariableNames: ''!

!BuscadorDeVuelos class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 5:46:58 pm (UTC)'!
con: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos contandoCon: unContadorDePasajeros  
	
	^self new initializeCon: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos contandoCon: unContadorDePasajeros ! !


!classDefinition: #DefinicionDeVuelo category: #'2024-2C-Parcial'!
Object subclass: #DefinicionDeVuelo
	instanceVariableNames: 'codigo origen destino diasDePartida horaDePartida duracion costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!DefinicionDeVuelo methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 1:55:51 pm (UTC)'!
initializeIdentificadoCon: unCodigo desde: unOrigen hasta: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida conDuracion: unaDuracion yCosto: unCosto 
	
	codigo := unCodigo.
	origen := unOrigen.
	destino := unDestino.
	diasDePartida := unosDiasDePartida.
	horaDePartida := unaHoraDePartida.
	duracion := unaDuracion.
	costo := unCosto.! !


!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:44:15 pm (UTC)'!
codigo
	
	^codigo! !

!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:06:03 pm (UTC)'!
costo
	
	^costo! !

!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:49:56 pm (UTC)'!
destino
	
	^destino! !

!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:05:56 pm (UTC)'!
duracion
	
	^duracion! !

!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:04:35 pm (UTC)'!
horaDePartida
	
	^horaDePartida! !

!DefinicionDeVuelo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:49:49 pm (UTC)'!
origen
	
	^origen! !


!DefinicionDeVuelo methodsFor: 'testing' stamp: 'HAW 16/Nov/2026, 2:27:55 pm (UTC)'!
parteDe: unOrigen hacia: unDestino en: unaFechaDePartida  
	
	^ (unOrigen = origen and: [unDestino  = destino ] ) and: [diasDePartida includes: unaFechaDePartida day].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DefinicionDeVuelo class' category: #'2024-2C-Parcial'!
DefinicionDeVuelo class
	instanceVariableNames: ''!

!DefinicionDeVuelo class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 2:57:59 pm (UTC)'!
identificadoCon: unCodigo desde: unOrigen a: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida conDuracion: unaDuracion yCosto: unCosto 
	
	^self new initializeIdentificadoCon: unCodigo desde: unOrigen hasta: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida conDuracion: unaDuracion yCosto: unCosto .! !


!classDefinition: #DescuentoPorFechaEspecial category: #'2024-2C-Parcial'!
Object subclass: #DescuentoPorFechaEspecial
	instanceVariableNames: 'fecha porcentaje'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!DescuentoPorFechaEspecial methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 5:35:09 pm (UTC)'!
initializeEn: unaFechaEspecial porcentaje: unPorcentajeDeDescuento 
	
	fecha := unaFechaEspecial.
	porcentaje := unPorcentajeDeDescuento.! !


!DescuentoPorFechaEspecial methodsFor: 'aplicar descuento' stamp: 'HAW 16/Nov/2026, 5:55:58 pm (UTC)'!
aplicaA: unVuelo

	^ fecha = unVuelo partida date .
	! !

!DescuentoPorFechaEspecial methodsFor: 'aplicar descuento' stamp: 'HAW 16/Nov/2026, 5:53:09 pm (UTC)'!
montoPara: unVuelo 

	^ unVuelo costo * porcentaje 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorFechaEspecial class' category: #'2024-2C-Parcial'!
DescuentoPorFechaEspecial class
	instanceVariableNames: ''!

!DescuentoPorFechaEspecial class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 5:34:51 pm (UTC)'!
en: unaFechaEspecial porcentaje: unPorcentajeDeDescuento 

	^self new initializeEn: unaFechaEspecial porcentaje: unPorcentajeDeDescuento ! !


!classDefinition: #DescuentoPorTramo category: #'2024-2C-Parcial'!
Object subclass: #DescuentoPorTramo
	instanceVariableNames: 'origen destino porcentaje'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!DescuentoPorTramo methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 6:01:26 pm (UTC)'!
initializePartiendoDe: unOrigen conDestinoA: unDestino conPorcentaje: unPorcentaje 
	
	origen := unOrigen.
	destino := unDestino.
	porcentaje := unPorcentaje.! !


!DescuentoPorTramo methodsFor: 'aplicar descuento' stamp: 'HAW 16/Nov/2026, 6:02:13 pm (UTC)'!
aplicaA: unVuelo 

	^ unVuelo origen = origen and: [unVuelo destino = destino ].
	! !

!DescuentoPorTramo methodsFor: 'aplicar descuento' stamp: 'HAW 16/Nov/2026, 6:02:41 pm (UTC)'!
montoPara: unVuelo 

	^ unVuelo costoBruto * porcentaje .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorTramo class' category: #'2024-2C-Parcial'!
DescuentoPorTramo class
	instanceVariableNames: ''!

!DescuentoPorTramo class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 6:01:16 pm (UTC)'!
partiendoDe: unOrigen conDestinoA: unDestino conPorcentaje: unPorcentaje 

	^self new initializePartiendoDe: unOrigen conDestinoA: unDestino conPorcentaje: unPorcentaje ! !


!classDefinition: #Tramo category: #'2024-2C-Parcial'!
Object subclass: #Tramo
	instanceVariableNames: 'origen destino fechaDePartida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!Tramo methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 4:36:27 pm (UTC)'!
initializeDesde: unOrigen a: unDestino partiendoEn: unaFechaDePartida 
	
	origen := unOrigen.
	destino := unDestino.
	fechaDePartida := unaFechaDePartida.! !


!Tramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:43:25 pm (UTC)'!
destino
	
	^destino! !

!Tramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:43:32 pm (UTC)'!
fechaDePartida
	
	^fechaDePartida! !

!Tramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:43:20 pm (UTC)'!
origen
	
	^origen! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tramo class' category: #'2024-2C-Parcial'!
Tramo class
	instanceVariableNames: ''!

!Tramo class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 4:36:17 pm (UTC)'!
desde: unOrigen a: unDestino partiendoEn: unaFechaDePartida 

	^self new initializeDesde: unOrigen a: unDestino partiendoEn: unaFechaDePartida ! !


!classDefinition: #VueloIda category: #'2024-2C-Parcial'!
Object subclass: #VueloIda
	instanceVariableNames: 'definicion fechaDePartida descuentosAplicables'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!VueloIda methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 5:58:09 pm (UTC)'!
initializeDefinidoPor: unaDefinicion partiendoEn: unaFechaDePartida conDescuentos: unosDescuentos 
	
	definicion := unaDefinicion.
	fechaDePartida := unaFechaDePartida.
	descuentosAplicables := unosDescuentos select: [:unTipoDeDescuento | unTipoDeDescuento aplicaA: self].! !


!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:37:49 pm (UTC)'!
codigo
	
	^ definicion codigo! !

!VueloIda methodsFor: 'accesing' stamp: ''!
costo

	^ definicion costo! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:17:49 pm (UTC)'!
costoBruto
	
	^ self costo ! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:58:17 pm (UTC)'!
costoNeto
	
	^ self costoBruto - (descuentosAplicables inject: 0*dollar into: [:total :unDescuento |
			total + (unDescuento montoPara: self)
		] )! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:59:13 pm (UTC)'!
descuentos
	
	^ descuentosAplicables ! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:07:19 pm (UTC)'!
destino
	
	^ definicion destino! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:08:22 pm (UTC)'!
llegada
	
	^ self partida next: definicion duracion! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:07:13 pm (UTC)'!
origen
	
	^ definicion origen! !

!VueloIda methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 2:09:45 pm (UTC)'!
partida
	
	^ fechaDePartida at: definicion horaDePartida! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloIda class' category: #'2024-2C-Parcial'!
VueloIda class
	instanceVariableNames: ''!

!VueloIda class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 5:48:53 pm (UTC)'!
definidoPor: unaDefinicion partiendoEn: unaFechaDePartida conDescuentos: unosDescuentos 

	^ self new initializeDefinidoPor: unaDefinicion partiendoEn: unaFechaDePartida conDescuentos: unosDescuentos! !


!classDefinition: #VueloMultitramo category: #'2024-2C-Parcial'!
Object subclass: #VueloMultitramo
	instanceVariableNames: 'vuelosPorTramo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!VueloMultitramo methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 4:45:19 pm (UTC)'!
initializeCon: unosVuelosPorTramo 
	
	vuelosPorTramo := unosVuelosPorTramo.! !


!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:16:20 pm (UTC)'!
costoBruto
	
	^ vuelosPorTramo sum: [:unVueloDeIda | unVueloDeIda costoBruto ] .! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 6:10:47 pm (UTC)'!
costoNeto
	
	^ vuelosPorTramo sum: [:unVuelo | unVuelo costoNeto ]! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 6:12:23 pm (UTC)'!
descuentos
	
	^ (vuelosPorTramo collect: [:unVuelo | unVuelo descuentos ] )flatten asArray ! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:03:31 pm (UTC)'!
destino

	^ vuelosPorTramo last destino! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:48:02 pm (UTC)'!
llegada
	
	^ vuelosPorTramo last llegada! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:46:23 pm (UTC)'!
origen
	
	^vuelosPorTramo first origen.! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:47:46 pm (UTC)'!
partida
	
	^ vuelosPorTramo first partida! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 5:01:49 pm (UTC)'!
regreso
	
	^ vuelosPorTramo second partida .! !

!VueloMultitramo methodsFor: 'accesing' stamp: 'HAW 16/Nov/2026, 4:59:10 pm (UTC)'!
vuelta
	
	^ vuelosPorTramo second ! !


!VueloMultitramo methodsFor: 'as yet unclassified' stamp: 'HAW 16/Nov/2026, 4:59:01 pm (UTC)'!
ida
	
	^ vuelosPorTramo first
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloMultitramo class' category: #'2024-2C-Parcial'!
VueloMultitramo class
	instanceVariableNames: ''!

!VueloMultitramo class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 4:45:07 pm (UTC)'!
con: unosVuelosPorTramo 

	^self new initializeCon:  unosVuelosPorTramo ! !


!classDefinition: #AterrizarComTest category: #'2024-2C-Parcial'!
TestCase subclass: #AterrizarComTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test01BuscadorSinDefinicionesDeVueloNoEncuentraVuelosDeIda

	| buscador vuelosEncontrados |
	buscador := BuscadorDeVuelos con: {} descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: November / 16 / 2026 para: 3.
	
	self assert: vuelosEncontrados isEmpty .! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test02BuscadorEncuentraUnaCoincidencia

	| buscador vuelosEncontrados vueloAR100 vueloEncontrado |
	"AR100, desde Ezeiza a Barcelona, parte de Lunes a Domingo (todos los días de la
semana) a las 22:00, el viaje dura 12 horas y cuesta 1.000 dólares."
	vueloAR100 := self vueloAR100.
	buscador := BuscadorDeVuelos con: {vueloAR100 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1 .
	self assert: vueloEncontrado origen equals: 'Ezeiza'.
	self assert: vueloEncontrado destino equals: 'Barcelona'.
	self assert: vueloEncontrado costoNeto equals: 1000*dollar.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado partida equals: (November / 16 / 2026 at: 22:00).
	self assert: vueloEncontrado llegada equals: (November / 17 / 2026 at: 10:00).! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test03BuscadorSiNoCoincideOrigenNoDevuelveVuelos

	| buscador vuelosEncontrados vueloAR100 |
	"AR100, desde Ezeiza a Barcelona, parte de Lunes a Domingo (todos los días de la
semana) a las 22:00, el viaje dura 12 horas y cuesta 1.000 dólares."
	vueloAR100 := self vueloAR100.
	buscador := BuscadorDeVuelos con: {vueloAR100 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Aeroparque' a: 'Barcelona' partiendoEn: (November / 16 / 2026) para: 3.

	
	self assert: vuelosEncontrados isEmpty .
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test04BuscadorSiNoCoincideDestinoNoDevuelveVuelos

	| buscador vuelosEncontrados vueloAR100 |
	"AR100, desde Ezeiza a Barcelona, parte de Lunes a Domingo (todos los días de la
semana) a las 22:00, el viaje dura 12 horas y cuesta 1.000 dólares."
	vueloAR100 := self vueloAR100.
	buscador := BuscadorDeVuelos con: {vueloAR100 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Aeroparque' partiendoEn: (November / 16 / 2026) para: 3.

	
	self assert: vuelosEncontrados isEmpty .
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test05BuscadorSiNoCoincideDiaDeSalidaNoDevuelveVuelos

	| buscador vuelosEncontrados vueloIB300 |
	"IB300, desde Ezeiza a Barcelona, parte de Lunes a Viernes a las 1:00, el viaje dura
12 horas y cuesta 1.000 dólares"
	vueloIB300 := self vueloIB300.
	buscador := BuscadorDeVuelos con: {vueloIB300 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 15 / 2026) para: 3.

	
	self assert: vuelosEncontrados isEmpty .
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test06BuscadorSiNoHaySuficientesAsientosLibresNoDevuelveVuelos

	| buscador vuelosEncontrados vueloIB300 |

	vueloIB300 := self vueloIB300.
	buscador := BuscadorDeVuelos con: {vueloIB300 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026) para: 5.

	
	self assert: vuelosEncontrados isEmpty .
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test07BuscadorEncuentraMultiplesCoincidencias

	| buscador vuelosEncontrados vueloIB300 vueloAR100 |

	vueloIB300 := self vueloIB300.
	vueloAR100 := self vueloAR100 .
	buscador := BuscadorDeVuelos con: {vueloIB300. vueloAR100 } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026) para: 3.

	self assert: vuelosEncontrados size equals: 2.
	self assert: (vuelosEncontrados anySatisfy: [:unVueloEncontrado | unVueloEncontrado codigo = 'AR100']) .
	self assert: (vuelosEncontrados anySatisfy: [:unVueloEncontrado | unVueloEncontrado codigo = 'IB300']) .	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test08BuscadorSinDefinicionesDeVueloNoEncuentraVuelosDeIdaYVuelta
	
	"Desde Ezeiza a Barcelona, partiendo el 9 de Dic. de 2025 y volviendo el 15 de Dic. de
2025, para 5 pasajeros: Debería ofrecer un vuelo de ida y vuelta compuesto por los
vuelos AR100 y AR101"
	
	| buscador vuelosEncontrados |

	buscador := BuscadorDeVuelos con: { } descontandoCon: {} contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona' partiendoEn: November / 16 / 2026 regresandoEn: November / 17 / 2026 para: 3.

	self assert: vuelosEncontrados isEmpty .! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test09BuscadorEncuentraUnaCoincidenciaDeIdaYVuelta

	| buscador vuelosEncontrados vueloEncontrado |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloAR101}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		desde: 'Ezeiza'
		a: 'Barcelona'
		partiendoEn: (November / 16 / 2026)
		regresandoEn: (November / 18 / 2026)
		para: 3.

	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado origen equals: 'Ezeiza'.
	self assert: vueloEncontrado destino equals: 'Ezeiza'.

	self
		assert: vueloEncontrado partida
		equals: (November / 16 / 2026 at: 22:00).
	self
		assert: vueloEncontrado regreso
		equals: (November / 18 / 2026 at: 22:00).

	self assert: vueloEncontrado costoNeto equals: 2000*dollar.
	self assert: vueloEncontrado costoBruto equals: 2000*dollar! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test10BuscadorDevuelveTodasLasCombinacionesDeIdaYVueltaPosibles

	| buscador vuelosEncontrados |
	
	
	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloAR101. self vueloIB300 . self vueloIB301}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		desde: 'Ezeiza'
		a: 'Barcelona'
		partiendoEn: (November / 16 / 2026)
		regresandoEn: (November / 18 / 2026)
		para: 3.

	self assert: vuelosEncontrados size equals: 4.

	self assert: (vuelosEncontrados anySatisfy: [:unVuelo |
		unVuelo ida codigo = 'AR100' and: [
			unVuelo vuelta codigo = 'AR101']]).

	self assert: (vuelosEncontrados anySatisfy: [:unVuelo |
		unVuelo ida codigo = 'AR100' and: [
			unVuelo vuelta codigo = 'IB301']]).

	self assert: (vuelosEncontrados anySatisfy: [:unVuelo |
		unVuelo ida codigo = 'IB300' and: [
			unVuelo vuelta codigo = 'AR101']]).

	self assert: (vuelosEncontrados anySatisfy: [:unVuelo |
		unVuelo ida codigo = 'IB300' and: [
			unVuelo vuelta codigo = 'IB301']]).! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test11BuscadorSinDefinicionesNoEncuentraVuelosMultitramos

	| buscador vuelosEncontrados |

	buscador := BuscadorDeVuelos
		con: {}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: November / 16 / 2026.
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: November / 18 / 2026.
		}
		para: 3.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test12BuscadorEncuentraUnaCoincidenciaMultitramos

	| buscador vuelosEncontrados vueloEncontrado |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100 . self vueloIB301 }
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: November / 16 / 2026.
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: November / 18 / 2026.
		}
		para: 3.
	
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado origen equals: 'Ezeiza'.
	self assert: vueloEncontrado destino equals: 'Ezeiza'.
	self assert: vueloEncontrado partida equals: (November / 16 / 2026 at: 22:00).
	self assert: vueloEncontrado llegada equals: (November / 19 / 2026 at: 02:00).
	self assert: vueloEncontrado costoBruto equals: 1900*dollar.
	self assert: vueloEncontrado costoNeto equals: 1900*dollar! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test13BuscadorEncuentraTodasLasCombinacionesMultitramos

	| buscador vuelosEncontrados |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB300. self vueloAR101. self vueloIB301}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 18 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados size equals: 4.

	self assert: (vuelosEncontrados count: [:unVuelo |
		unVuelo partida = (November / 16 / 2026 at: 22:00)
			and: [unVuelo llegada = (November / 19 / 2026 at: 10:00)]]) equals: 1.

	self assert: (vuelosEncontrados count: [:unVuelo |
		unVuelo partida = (November / 16 / 2026 at: 22:00)
			and: [unVuelo llegada = (November / 19 / 2026 at: 02:00)]]) equals: 1.

	self assert: (vuelosEncontrados count: [:unVuelo |
		unVuelo partida = (November / 16 / 2026 at: 01:00)
			and: [unVuelo llegada = (November / 19 / 2026 at: 10:00)]]) equals: 1.

	self assert: (vuelosEncontrados count: [:unVuelo |
		unVuelo partida = (November / 16 / 2026 at: 01:00)
			and: [unVuelo llegada = (November / 19 / 2026 at: 02:00)]]) equals: 1.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test14CostoBrutoYNetoDeMultitramoEsLaSumaDeTodosSusTramos

	| buscador vuelosEncontrados vueloEncontrado |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB503. self vueloIB301}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Madrid' a: 'Paris' partiendoEn: (November / 18 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 20 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado costoBruto equals: (1000 + 300 + 900)*dollar.
	self assert: vueloEncontrado costoNeto equals: (1000 + 300 + 900)*dollar.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test15BuscadorDescartaMultitramoSiElSiguienteVueloParteAntesDeLaLlegadaDelAnterior

	| buscador vuelosEncontrados |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB301}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 16 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados isEmpty.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:29:38 pm (UTC)'!
test16BuscadorDescartaMultitramoSiElTercerVueloParteAntesDeLaLlegadaDelSegundo

	| buscador vuelosEncontrados |

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB503. self vueloIB301}
		descontandoCon: {} contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Madrid' a: 'Paris' partiendoEn: (November / 18 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 17 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados isEmpty.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:59:04 pm (UTC)'!
test17UnDescuentoPorFechaEspecialAplicaSiCoincideLaFecha

	
	| buscador vuelosEncontrados vueloEncontrado descuento |
	descuento := DescuentoPorFechaEspecial 
						en: (November / 16 / 2026) 
						porcentaje: 10/100 .
	buscador := BuscadorDeVuelos con: {self vueloAR100. } 
	descontandoCon: {descuento} 
	contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona'  partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1.
	self assert: vueloEncontrado codigo equals: 'AR100'.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado costoNeto equals: 900*dollar .
	self assert: vueloEncontrado descuentos equals: {descuento }! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 5:58:52 pm (UTC)'!
test18UnDescuentoPorFechaEspecialNoAplicaSiNoCoincideLaFecha

	
	| buscador vuelosEncontrados vueloEncontrado descuento |
	descuento := DescuentoPorFechaEspecial 
						en: (November / 17 / 2026) 
						porcentaje: 10/100 .
	buscador := BuscadorDeVuelos con: {self vueloAR100. } 
	descontandoCon: {descuento} 
	contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona'  partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1.
	self assert: vueloEncontrado codigo equals: 'AR100'.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado costoNeto equals: 1000*dollar .
	self assert: vueloEncontrado descuentos equals: {}.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:04:13 pm (UTC)'!
test19DescuentoPorTramoAplicaSiCoincideOrigenYDestino

	
	| buscador vuelosEncontrados vueloEncontrado descuento |
	descuento := DescuentoPorTramo partiendoDe: 'Ezeiza' conDestinoA: 'Barcelona' conPorcentaje: 10/100.
	buscador := BuscadorDeVuelos con: {self vueloAR100. } 
	descontandoCon: {descuento} 
	contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona'  partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1.
	self assert: vueloEncontrado codigo equals: 'AR100'.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado costoNeto equals: 900*dollar .
	self assert: vueloEncontrado descuentos equals: {descuento }.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:04:28 pm (UTC)'!
test20DescuentoPorTramoNoAplicaSiNoCoincideOrigen

	
	| buscador vuelosEncontrados vueloEncontrado descuento |
	descuento := DescuentoPorTramo partiendoDe: 'Aeroparque' conDestinoA: 'Barcelona' conPorcentaje: 10/100.
	buscador := BuscadorDeVuelos con: {self vueloAR100. } 
	descontandoCon: {descuento} 
	contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona'  partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1.
	self assert: vueloEncontrado codigo equals: 'AR100'.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado costoNeto equals: 1000*dollar .
	self assert: vueloEncontrado descuentos equals: { }.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:08:25 pm (UTC)'!
test21DescuentoPorTramoNoAplicaSiNoCoincideDestino

	
	| buscador vuelosEncontrados vueloEncontrado descuento |
	descuento := DescuentoPorTramo partiendoDe: 'Ezeiza' conDestinoA: 'Aeroparque' conPorcentaje: 10/100.
	buscador := BuscadorDeVuelos con: {self vueloAR100. } 
	descontandoCon: {descuento} 
	contandoCon: self.
	
	vuelosEncontrados := buscador desde: 'Ezeiza' a: 'Barcelona'  partiendoEn: (November / 16 / 2026) para: 3.
	vueloEncontrado := vuelosEncontrados anyOne .
	
	self assert: vuelosEncontrados size equals: 1.
	self assert: vueloEncontrado codigo equals: 'AR100'.
	self assert: vueloEncontrado costoBruto equals: 1000*dollar.
	self assert: vueloEncontrado costoNeto equals: 1000*dollar .
	self assert: vueloEncontrado descuentos equals: { }.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:12:08 pm (UTC)'!
test22MultitramoAplicaDescuentoPorFechaEspecial

	| buscador vuelosEncontrados vueloEncontrado descuento |

	descuento := DescuentoPorFechaEspecial
		en: (November / 16 / 2026)
		porcentaje: 10/100.

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB301}
		descontandoCon: {descuento}
		contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 18 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado costoBruto equals: 1900*dollar.
	self assert: vueloEncontrado costoNeto equals: 1800*dollar.
	self assert: vueloEncontrado descuentos equals: {descuento }.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:12:59 pm (UTC)'!
test23MultitramoAplicaDescuentoPorTramo

	| buscador vuelosEncontrados vueloEncontrado descuento |

	descuento := DescuentoPorTramo
		partiendoDe: 'Barcelona'
		conDestinoA: 'Ezeiza'
		conPorcentaje: 10/100.

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB301}
		descontandoCon: {descuento}
		contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 18 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado costoBruto equals: 1900*dollar.
	self assert: vueloEncontrado costoNeto equals: 1810*dollar.
	self assert: vueloEncontrado descuentos equals: {descuento }.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 6:14:47 pm (UTC)'!
test24MultitramoAplicaVariosDescuentosDelMismoTipoYDeDistintoTipo

	| buscador vuelosEncontrados vueloEncontrado descuentoFecha descuentoTramo1 descuentoTramo2 |

	descuentoFecha := DescuentoPorFechaEspecial
		en: (November / 16 / 2026)
		porcentaje: 10/100.

	descuentoTramo1 := DescuentoPorTramo
		partiendoDe: 'Ezeiza'
		conDestinoA: 'Barcelona'
		conPorcentaje: 20/100.

	descuentoTramo2 := DescuentoPorTramo
		partiendoDe: 'Ezeiza'
		conDestinoA: 'Barcelona'
		conPorcentaje: 5/100.

	buscador := BuscadorDeVuelos
		con: {self vueloAR100. self vueloIB301}
		descontandoCon: {descuentoFecha. descuentoTramo1. descuentoTramo2}
		contandoCon: self.

	vuelosEncontrados := buscador
		porTramos: {
			Tramo desde: 'Ezeiza' a: 'Barcelona' partiendoEn: (November / 16 / 2026).
			Tramo desde: 'Barcelona' a: 'Ezeiza' partiendoEn: (November / 18 / 2026)
		}
		para: 3.

	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.

	self assert: vueloEncontrado costoBruto equals: 1900*dollar.
	self assert: vueloEncontrado costoNeto equals: 1550*dollar.
		self
		assert: vueloEncontrado descuentos
		equals: {descuentoFecha. descuentoTramo1. descuentoTramo2}.
! !


!AterrizarComTest methodsFor: 'creacion - vuelos' stamp: 'HAW 16/Nov/2026, 2:58:21 pm (UTC)'!
vueloAR100

	^ DefinicionDeVuelo identificadoCon: 'AR100' 
	desde: 'Ezeiza' 
	a: 'Barcelona' 
	partiendoLos: (Monday to: Sunday ) 
	aLas: 22:00 
	conDuracion: 12*hour 
	yCosto: 1000*dollar. ! !

!AterrizarComTest methodsFor: 'creacion - vuelos' stamp: 'HAW 16/Nov/2026, 3:07:24 pm (UTC)'!
vueloAR101

	^ DefinicionDeVuelo
		identificadoCon: 'AR101'
		desde: 'Barcelona'
		a: 'Ezeiza'
		partiendoLos: (Monday to: Sunday)
		aLas: 22:00
		conDuracion: 12*hour
		yCosto: 1000*dollar! !

!AterrizarComTest methodsFor: 'creacion - vuelos' stamp: 'HAW 16/Nov/2026, 2:58:14 pm (UTC)'!
vueloIB300
	
	^ DefinicionDeVuelo identificadoCon: 'IB300' 
	desde: 'Ezeiza'  
	a: 'Barcelona' 
	partiendoLos: (Monday to: Friday )  
	aLas: 1:00 
	conDuracion:  12*hour 
	yCosto: 1000*dollar. ! !

!AterrizarComTest methodsFor: 'creacion - vuelos' stamp: 'HAW 16/Nov/2026, 3:20:42 pm (UTC)'!
vueloIB301
	"IB301, desde Barcelona a Ezeiza, parte de Lunes a Viernes a las 14:00, dura 12:00
horas y cuesta 900 dólares"
	^ DefinicionDeVuelo identificadoCon:  'IB301'
	desde:  'Barcelona'
	a:  'Ezeiza'
	partiendoLos: (Monday to: Friday )  
	aLas:  14:00
	conDuracion:  12*hour
	yCosto: 900*dollar.! !

!AterrizarComTest methodsFor: 'creacion - vuelos' stamp: 'HAW 16/Nov/2026, 5:15:46 pm (UTC)'!
vueloIB503

	^ DefinicionDeVuelo
		identificadoCon: 'IB503'
		desde: 'Madrid'
		a: 'Paris'
		partiendoLos: (Monday to: Friday)
		aLas: 06:00
		conDuracion: 90*minute
		yCosto: 300*dollar
! !


!AterrizarComTest methodsFor: 'contador de pasajeros' stamp: 'HAW 16/Nov/2026, 2:33:52 pm (UTC)'!
asientosDisponibles
	
	^ 3! !


!classDefinition: #TodasLasCombinacionesTest category: #'2024-2C-Parcial'!
TestCase subclass: #TodasLasCombinacionesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial'!

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 9/Dec/2025, 2:30:10 pm (UTC)'!
test01ParaUnaColecciónDeUnElemento

	self 
		assert: (OrderedCollection with: #(1)) todasLasCombinaciones 
		equals: (OrderedCollection with: (OrderedCollection with: 1))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 9/Dec/2025, 2:30:14 pm (UTC)'!
test02ParaUnaColecciónDeMásDeUnElemento

	self 
		assert: (OrderedCollection with: #(1 2)) todasLasCombinaciones 
		equals: (OrderedCollection with: (OrderedCollection with: 1) with: (OrderedCollection with: 2))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 9/Dec/2025, 2:30:28 pm (UTC)'!
test03ParaDosColeccionesDeDosYUnElemento

	self 
		assert: (OrderedCollection with: #(1 2) with: #(3)) todasLasCombinaciones 
		equals: (OrderedCollection 
			with: (OrderedCollection with: 1 with: 3) 
			with: (OrderedCollection with: 2 with: 3))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 9/Dec/2025, 2:30:42 pm (UTC)'!
test04ParaDosColeccionesDeMásDeUnElemento

	self 
		assert: (OrderedCollection with: #(1 2) with: #(3 4)) todasLasCombinaciones 
		equals: (OrderedCollection 
			with: (OrderedCollection with: 1 with: 3) 
			with: (OrderedCollection with: 1 with: 4)
			with: (OrderedCollection with: 2 with: 3)
			with: (OrderedCollection with: 2 with: 4))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 9/Dec/2025, 2:30:54 pm (UTC)'!
test05CuandoHayUnaColecciónVacía

	self assert: (OrderedCollection with: #(1 2) with: #() with: #(3 4)) todasLasCombinaciones isEmpty! !
