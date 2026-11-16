!classDefinition: #CapacidadDeTrabajo category: #'ISW1-SmartBuilding'!
Object subclass: #CapacidadDeTrabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!CapacidadDeTrabajo methodsFor: 'tiempo de construccion' stamp: 'HAW 15/Nov/2026, 10:55:21 pm (UTC)'!
tiempoEnConstruir: unAreaAConstruir

	self subclassResponsibility! !


!classDefinition: #CapacidadFija category: #'ISW1-SmartBuilding'!
CapacidadDeTrabajo subclass: #CapacidadFija
	instanceVariableNames: 'capacidadDeConstruccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!CapacidadFija methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 8:12:52 pm (UTC)'!
initializeDe: unaCapacidadDeConstruccion 
	
	capacidadDeConstruccion := unaCapacidadDeConstruccion.! !


!CapacidadFija methodsFor: 'tiempo de construccion' stamp: 'HAW 16/Nov/2026, 3:11:06 am (UTC)'!
tiempoEnConstruir: unAreaAConstruir 
	
	^ (unAreaAConstruir / capacidadDeConstruccion ) ceiling .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapacidadFija class' category: #'ISW1-SmartBuilding'!
CapacidadFija class
	instanceVariableNames: ''!

!CapacidadFija class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 8:12:42 pm (UTC)'!
de: unaCapacidadDeConstruccion 
	
	^self new initializeDe: unaCapacidadDeConstruccion ! !


!classDefinition: #CapacidadVariable category: #'ISW1-SmartBuilding'!
CapacidadDeTrabajo subclass: #CapacidadVariable
	instanceVariableNames: 'areaDiariaInicial diasDeEtapaInicial areaDiariaPosterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!CapacidadVariable methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 3:11:42 am (UTC)'!
initializeDe: unAreaDiariaInicial losPrimeros: unaCantidadDeDias yElResto: unAreaDiariaPosterior 
	
	areaDiariaInicial := unAreaDiariaInicial.
	diasDeEtapaInicial := unaCantidadDeDias.
	areaDiariaPosterior := unAreaDiariaPosterior.! !


!CapacidadVariable methodsFor: 'tiempo de construccion' stamp: 'HAW 15/Nov/2026, 9:25:45 pm (UTC)'!
tiempoEnConstruir: unAreaAConstruir
    | areaRestante |

	unAreaAConstruir <= (areaDiariaInicial * diasDeEtapaInicial) ifTrue: [ ^ (unAreaAConstruir / areaDiariaInicial) ceiling  ].

	areaRestante := unAreaAConstruir - (areaDiariaInicial * diasDeEtapaInicial).

	^ (diasDeEtapaInicial + (areaRestante / areaDiariaPosterior)) ceiling ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapacidadVariable class' category: #'ISW1-SmartBuilding'!
CapacidadVariable class
	instanceVariableNames: ''!

!CapacidadVariable class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 9:31:11 pm (UTC)'!
de: unaCapacidadInicial losPrimeros: unaCantidadDeDias yElResto: otraCapacidadParaRestoDeDias 
	
	self assert: unaCapacidadInicial esMayorQue: otraCapacidadParaRestoDeDias .
	
	^self new initializeDe: unaCapacidadInicial losPrimeros: unaCantidadDeDias yElResto: otraCapacidadParaRestoDeDias ! !


!CapacidadVariable class methodsFor: 'error description' stamp: 'HAW 15/Nov/2026, 9:29:42 pm (UTC)'!
capacidadInicialNoPuedeSerMenorALaDelRestoDeDiasErrorDescription
	
	^ 'La capacidad inicial de los primeros n dias no puede ser menor a la del resto de dias'! !


!CapacidadVariable class methodsFor: 'asserting' stamp: 'HAW 15/Nov/2026, 9:31:40 pm (UTC)'!
assert: unaCapacidadInicial esMayorQue: otraCapacidadParaRestoDeDias 
	
	unaCapacidadInicial > otraCapacidadParaRestoDeDias ifFalse: [self error: self capacidadInicialNoPuedeSerMenorALaDelRestoDeDiasErrorDescription]! !


!classDefinition: #EquipoDeTrabajo category: #'ISW1-SmartBuilding'!
Object subclass: #EquipoDeTrabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 15/Nov/2026, 10:56:46 pm (UTC)'!
precioDeConstruir: unAreaAConstruir

	self subclassResponsibility! !

!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 3:10:41 am (UTC)'!
tiempoEnConstruir: unaAreaDeConstruccion

	self subclassResponsibility! !


!EquipoDeTrabajo methodsFor: 'validacion' stamp: 'HAW 16/Nov/2026, 3:05:02 am (UTC)'!
registrarEquiposEn: unosEquiposVisitados

	self subclassResponsibility! !


!classDefinition: #EquipoCombinado category: #'ISW1-SmartBuilding'!
EquipoDeTrabajo subclass: #EquipoCombinado
	instanceVariableNames: 'coleccionDeEquipos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!EquipoCombinado methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 2:38:45 am (UTC)'!
initializeCon: unaColeccionDeEquipos 
	
	coleccionDeEquipos := unaColeccionDeEquipos copy.! !


!EquipoCombinado methodsFor: 'validacion' stamp: 'HAW 15/Nov/2026, 11:19:29 pm (UTC)'!
registrarEquiposEn: unosEquiposVisitados

	unosEquiposVisitados add: self.
	coleccionDeEquipos do: [ :equipo |
		equipo registrarEquiposEn: unosEquiposVisitados
	].! !


!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 2:32:32 am (UTC)'!
equipoConMenorPrecioDeConstruccionPara: unAreaAConstruir 
	
	| areaRepartida |
	areaRepartida := unAreaAConstruir / coleccionDeEquipos size.
	^ coleccionDeEquipos detectMin: [:unEquipoDeTrabajo | unEquipoDeTrabajo precioDeConstruir: areaRepartida ].! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 3:09:33 am (UTC)'!
equipoConMenorTiempoDeConstruccionPara: unAreaAConstruir 

	|areaRepartida|
	areaRepartida := unAreaAConstruir / coleccionDeEquipos size.
	^ coleccionDeEquipos detectMin: [:unEquipoDeTrabajo | unEquipoDeTrabajo tiempoEnConstruir: areaRepartida ].! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 3:09:39 am (UTC)'!
precioDeConstruir: unAreaAConstruir 
	
	| repartoDeArea |
	repartoDeArea := unAreaAConstruir / coleccionDeEquipos size .
	^coleccionDeEquipos sum: [:unEquipoDeTrabajo |
			unEquipoDeTrabajo precioDeConstruir: repartoDeArea .
		].
	! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 3:09:15 am (UTC)'!
preciosDeConstruccionPara: unAreaAConstruir

	| areaPorEquipo |
	areaPorEquipo := unAreaAConstruir / coleccionDeEquipos size.

	^ Dictionary newFrom: (
		coleccionDeEquipos collect: [:equipo |
		equipo -> (equipo precioDeConstruir: areaPorEquipo)
		])! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 15/Nov/2026, 11:27:26 pm (UTC)'!
tiempoEnConstruir: unaAreaAConstruir 
	
	|repartoDeArea| 
	repartoDeArea := unaAreaAConstruir / coleccionDeEquipos size.
	
	^ coleccionDeEquipos max: [:unEquipoDeTrabajo | unEquipoDeTrabajo tiempoEnConstruir: repartoDeArea ].! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 16/Nov/2026, 3:09:24 am (UTC)'!
tiemposDeConstruccionPara: unAreaAConstruir

	| areaPorEquipo |
	areaPorEquipo := unAreaAConstruir / coleccionDeEquipos size.

	^ Dictionary newFrom: (
		coleccionDeEquipos collect: [:equipo |
		equipo -> (equipo tiempoEnConstruir: areaPorEquipo)
	])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EquipoCombinado class' category: #'ISW1-SmartBuilding'!
EquipoCombinado class
	instanceVariableNames: ''!

!EquipoCombinado class methodsFor: 'error description' stamp: 'HAW 15/Nov/2026, 10:52:23 pm (UTC)'!
debeContenerPorLoMenosUnEquipoSimple
	
	^ 'Debe contener por lo menos un equipo simple'! !

!EquipoCombinado class methodsFor: 'error description' stamp: 'HAW 15/Nov/2026, 11:02:34 pm (UTC)'!
noPuedenHaberEquiposRepetidosErrorDescription
	
	^ 'No puede haber equipos repetidos'! !


!EquipoCombinado class methodsFor: 'asserting' stamp: 'HAW 16/Nov/2026, 2:57:22 am (UTC)'!
assertNoHayEquiposRepetidosEn: unaColeccionDeEquipos
	| equiposVisitados |
	equiposVisitados := Set new.

	unaColeccionDeEquipos do: [:unEquipo |
		unEquipo registrarEquiposEn: equiposVisitados]! !


!EquipoCombinado class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 3:00:38 am (UTC)'!
assertHayAlMenosUnEquipoEn: unaColeccionDeEquipos

	 unaColeccionDeEquipos size > 0 ifFalse: [self error: self debeContenerPorLoMenosUnEquipoSimple ]! !

!EquipoCombinado class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 3:00:38 am (UTC)'!
con: unaColeccionDeEquipos 
	
	self assertHayAlMenosUnEquipoEn: unaColeccionDeEquipos.
	self assertNoHayEquiposRepetidosEn: unaColeccionDeEquipos .
	
	^self new initializeCon: unaColeccionDeEquipos ! !


!classDefinition: #EquipoSimple category: #'ISW1-SmartBuilding'!
EquipoDeTrabajo subclass: #EquipoSimple
	instanceVariableNames: 'capacidadDeConstruccion costoDeConstruccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!EquipoSimple methodsFor: 'initialization' stamp: 'HAW 16/Nov/2026, 3:10:18 am (UTC)'!
initializeConCapacidadDeTrabajo: unaCapacidadDeConstruccion a: unCosto 
	
	capacidadDeConstruccion := unaCapacidadDeConstruccion.
	costoDeConstruccion := unCosto.! !


!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 15/Nov/2026, 8:27:32 pm (UTC)'!
precioDeConstruir: unAreaAConstruir 
	
	|diasDeConstruccion|
	diasDeConstruccion := self tiempoEnConstruir: unAreaAConstruir .
	^ costoDeConstruccion calcularPrecioDeConstruirDurante: diasDeConstruccion  .
	! !

!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 15/Nov/2026, 8:14:16 pm (UTC)'!
tiempoEnConstruir: unaDimensionDeConstruccion 
	
	^ capacidadDeConstruccion tiempoEnConstruir: unaDimensionDeConstruccion .! !


!EquipoSimple methodsFor: 'error signaling' stamp: 'HAW 16/Nov/2026, 3:07:04 am (UTC)'!
signalErrorEquipoCombinadoInvalido

	^ self error: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription! !


!EquipoSimple methodsFor: 'validacion' stamp: 'HAW 16/Nov/2026, 3:09:56 am (UTC)'!
registrarEquiposEn: unosEquiposVisitados 
	
	(unosEquiposVisitados includes: self) ifTrue: [self signalErrorEquipoCombinadoInvalido ].
	
	unosEquiposVisitados add: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EquipoSimple class' category: #'ISW1-SmartBuilding'!
EquipoSimple class
	instanceVariableNames: ''!

!EquipoSimple class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 10:56:42 pm (UTC)'!
construyendoCon: unaCapacidadDeConstruccion a: unCostoFijo 
	
	^self new initializeConCapacidadDeTrabajo: unaCapacidadDeConstruccion a: unCostoFijo ! !


!classDefinition: #EstacionMeteorologica category: #'ISW1-SmartBuilding'!
Object subclass: #EstacionMeteorologica
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!EstacionMeteorologica methodsFor: 'dias lluviosos' stamp: 'HAW 15/Nov/2026, 10:32:08 pm (UTC)'!
cantidadDeDiasLluviososDurante: unosDiasDeConstruccion 
	"Estacion a la que es polimorfica el test para usarse como objeto stub"
	self subclassResponsibility .! !


!classDefinition: #PrecioDeTrabajo category: #'ISW1-SmartBuilding'!
Object subclass: #PrecioDeTrabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!PrecioDeTrabajo methodsFor: 'costo de construccion' stamp: 'HAW 15/Nov/2026, 10:55:45 pm (UTC)'!
calcularPrecioDeConstruirDurante: unosDiasDeConstruccion

	self subclassResponsibility! !


!classDefinition: #PrecioDependienteDelClima category: #'ISW1-SmartBuilding'!
PrecioDeTrabajo subclass: #PrecioDependienteDelClima
	instanceVariableNames: 'precioParaDiasLluviosos precioParaDiasNoLluviosos estacionMeteorologica'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!PrecioDependienteDelClima methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 9:45:37 pm (UTC)'!
initializeEnDiasLluviosos: unPrecioParaDiasLluviosos yEnDiasNoLluviosos: unPrecioParaDiasNoLluviosos usando: unaEstacionMeteorologica 
	
	precioParaDiasLluviosos := unPrecioParaDiasLluviosos.
	precioParaDiasNoLluviosos := unPrecioParaDiasNoLluviosos.
	estacionMeteorologica := unaEstacionMeteorologica.! !


!PrecioDependienteDelClima methodsFor: 'costo de construccion' stamp: 'HAW 15/Nov/2026, 10:09:59 pm (UTC)'!
calcularPrecioDeConstruirDurante: unosDiasDeConstruccion 
	
	| diasLluviosos diasNoLluviosos |
	diasLluviosos := estacionMeteorologica cantidadDeDiasLluviososDurante: unosDiasDeConstruccion .
	diasNoLluviosos := unosDiasDeConstruccion - diasLluviosos .
	
	^ diasNoLluviosos * precioParaDiasNoLluviosos + (diasLluviosos * precioParaDiasLluviosos )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioDependienteDelClima class' category: #'ISW1-SmartBuilding'!
PrecioDependienteDelClima class
	instanceVariableNames: ''!

!PrecioDependienteDelClima class methodsFor: 'instance creation' stamp: 'HAW 16/Nov/2026, 2:54:07 am (UTC)'!
enDiasLluviosos: unPrecioParaDiasLluviosos yEnDiasNoLluviosos: unPrecioParaDiasNoLluviosos usando: unaEstacionMeteorologica 
	
	self assert: unPrecioParaDiasLluviosos esMayorQue: unPrecioParaDiasNoLluviosos .
	
	^self new initializeEnDiasLluviosos: unPrecioParaDiasLluviosos yEnDiasNoLluviosos: unPrecioParaDiasNoLluviosos usando: unaEstacionMeteorologica ! !


!PrecioDependienteDelClima class methodsFor: 'error description' stamp: 'HAW 16/Nov/2026, 2:53:25 am (UTC)'!
elPrecioDeLosDiasLluviososDebeSerMayorAlDeLosNoLluviososErrorDescription
	
	^ 'El precio de los dias lluviosos debe ser mayor que el de los no lluviosos'! !


!PrecioDependienteDelClima class methodsFor: 'asserting' stamp: 'HAW 16/Nov/2026, 2:54:35 am (UTC)'!
assert: unPrecioParaDiasLluviosos esMayorQue: unPrecioParaDiasNoLluviosos 
	
	unPrecioParaDiasLluviosos > unPrecioParaDiasNoLluviosos ifFalse: [self error: self elPrecioDeLosDiasLluviososDebeSerMayorAlDeLosNoLluviososErrorDescription ]! !


!classDefinition: #PrecioFijo category: #'ISW1-SmartBuilding'!
PrecioDeTrabajo subclass: #PrecioFijo
	instanceVariableNames: 'costoPorDia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!PrecioFijo methodsFor: 'initialization' stamp: 'HAW 15/Nov/2026, 8:27:59 pm (UTC)'!
initializeDe: unCostoPorTiempo 
	
	costoPorDia := unCostoPorTiempo.! !


!PrecioFijo methodsFor: 'costo de construccion' stamp: 'HAW 15/Nov/2026, 8:27:59 pm (UTC)'!
calcularPrecioDeConstruirDurante: unosDiasDeConstruccion 
	
	^ unosDiasDeConstruccion * costoPorDia .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioFijo class' category: #'ISW1-SmartBuilding'!
PrecioFijo class
	instanceVariableNames: ''!

!PrecioFijo class methodsFor: 'instance creation' stamp: 'HAW 15/Nov/2026, 8:13:17 pm (UTC)'!
de: unCostoPorTiempo 
	
	^self new initializeDe: unCostoPorTiempo ! !


!classDefinition: #SmartBuildingTest category: #'ISW1-SmartBuilding'!
TestCase subclass: #SmartBuildingTest
	instanceVariableNames: 'diasLluviosos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-SmartBuilding'!

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:41:42 am (UTC)'!
test01TiempoEnConstruirConCapacidadFijaEsAreaSobreCapacidad

	
	| equipoDeTrabajo |
	equipoDeTrabajo := self equipoVerde .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: 50 * meter * meter ) equals: 10 *day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:45:37 am (UTC)'!
test02TiempoEnConstruirConCapacidadFijaEstaExpresadoEnDiasEnteros

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadFija de:   self veinticincoMetrosCuadradosPorDia ) a: (PrecioFijo de: self milPesosPorDia) .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: 2.5 * meter * meter ) equals: 1 *day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:42:41 am (UTC)'!
test03CostosParaConstruirConPreciosFijosEsTiempoPorPrecio

	
	| equipoDeTrabajo |
	equipoDeTrabajo := self equipoVerde .
	
	self assert: (equipoDeTrabajo precioDeConstruir: self cienMetrosCuadrados ) equals: 16000 * peso.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test04UsaCapacidadInicialSiTerminaDentroDeLaPrimeraEtapa

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadVariable de: self diezMetrosCuadradosPorDia losPrimeros: 10*day yElResto: 5*meter*meter/day)  a: (PrecioFijo de: self milPesosPorDia) .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: self cienMetrosCuadrados ) equals: 10*day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test05CalculaTiempoUsandoAmbasCapacidadesSiSuperaLaEtapaInicial

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadVariable de: self diezMetrosCuadradosPorDia losPrimeros: 10*day yElResto: 5*meter*meter/day)  a: (PrecioFijo de: self milPesosPorDia) .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: 110 * meter * meter ) equals: 12*day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:24:42 am (UTC)'!
test06RedondeaHaciaArribaLosDiasDeConstruccionDentroDeLaEtapaInicial

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadVariable de: self diezMetrosCuadradosPorDia losPrimeros: 11*day yElResto: 5*meter*meter/day)  a: (PrecioFijo de: self milPesosPorDia) .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: self cienMetrosCuadrados + (1 *meter *meter )) equals: 11*day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test07RedondeaHaciaArribaLosDiasDeConstruccionAlSuperarLaEtapaInicial

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadVariable de: self diezMetrosCuadradosPorDia losPrimeros: 10*day yElResto: 3*meter*meter/day)  a: (PrecioFijo de: self milPesosPorDia) .
	
	self assert: (equipoDeTrabajo tiempoEnConstruir: 110 * meter * meter ) equals: 14*day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test08LaCapacidadInicialDebeSerMayorQueCapacidadDeRestoDeDias


	self should: [EquipoSimple construyendoCon: (CapacidadVariable de: self diezMetrosCuadradosPorDia losPrimeros: 10*day yElResto: self diezMetrosCuadradosPorDia)  a: (PrecioFijo de: self milPesosPorDia) ]   
	raise:  Error - MessageNotUnderstood 
	withMessageText: CapacidadVariable capacidadInicialNoPuedeSerMenorALaDelRestoDeDiasErrorDescription.
	
	! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test09SiNoHayDiasLluvisosSoloUtilizaCostoDeDiasNoLluvisos

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadFija de:  self diezMetrosCuadradosPorDia ) a: (PrecioDependienteDelClima enDiasLluviosos: self milPesosPorDia yEnDiasNoLluviosos: 500*peso/day usando: self) .
	
	self assert: (equipoDeTrabajo precioDeConstruir: self cienMetrosCuadrados ) equals: 5000*peso.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test10SiTodosLosDiasSonLluvisosSoloUtilizaCostoDeDiasLluvisos

	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadFija de:  self diezMetrosCuadradosPorDia ) a: (PrecioDependienteDelClima enDiasLluviosos: self milPesosPorDia yEnDiasNoLluviosos: 500*peso/day usando: self) .
	diasLluviosos := 11*day.
	
	self assert: (equipoDeTrabajo precioDeConstruir: self cienMetrosCuadrados ) equals: 10000*peso.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:52:56 am (UTC)'!
test11_1
	
	self 
	should: [EquipoSimple construyendoCon: (CapacidadFija de: self veinticincoMetrosCuadradosPorDia ) a: (PrecioDependienteDelClima enDiasLluviosos: 500*peso/day yEnDiasNoLluviosos: self milPesosPorDia usando: self) ]
	raise:  Error - MessageNotUnderstood 
	withMessageText: PrecioDependienteDelClima elPrecioDeLosDiasLluviososDebeSerMayorAlDeLosNoLluviososErrorDescription! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
test11CalculaPrecioDeConstruccionConDiasLluviososYNoLluviosos
	
	| equipoDeTrabajo |
	equipoDeTrabajo := EquipoSimple construyendoCon: (CapacidadFija de:  self diezMetrosCuadradosPorDia ) a: (PrecioDependienteDelClima enDiasLluviosos: self milPesosPorDia yEnDiasNoLluviosos: 500*peso/day usando: self) .
	diasLluviosos := 5*day.
	
	self assert: (equipoDeTrabajo precioDeConstruir: self cienMetrosCuadrados ) equals: 7500*peso.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 15/Nov/2026, 10:53:58 pm (UTC)'!
test12EquipoCombinadoDebeContenerPorLoMenosUnEquipoSimple

	self should: [EquipoCombinado con: {}]  
	raise:  Error - MessageNotUnderstood 
	withMessageText: EquipoCombinado debeContenerPorLoMenosUnEquipoSimple.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:40:43 am (UTC)'!
test13NoPuedeHaberEquiposSimplesRepetidos

	| equipo |
	equipo := self equipoVerde . 
	
	self should: [EquipoCombinado con: {equipo. equipo }]  
	raise:  Error - MessageNotUnderstood 
	withMessageText: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:41:14 am (UTC)'!
test14NoSePuedeCrearUnEquipoCombinadoConUnEquipoYaIncluidoEnUnSubequipo

    | equipoSimple equipoCombinado |
    equipoSimple := self equipoVerde .

    equipoCombinado := EquipoCombinado con: { equipoSimple }.

    self
        should: [
            EquipoCombinado con: { equipoSimple . equipoCombinado}
        ]
        raise: Error - MessageNotUnderstood
        withMessageText:
            EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:44:59 am (UTC)'!
test15ElTiempoDelEquipoCombinadoEsElMayorDeSusEquipos

| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: { equipoRojo. equipoBeta }.

	self
		assert: (equipoAlfa tiempoEnConstruir: self cienMetrosCuadrados)
		equals: 5 * day.! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 1:44:59 am (UTC)'!
test16ElPrecioDelEquipoCombinadoEsLaSumaDeSusEquipos

| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: { equipoRojo. equipoBeta }.

	self
	assert: (equipoAlfa precioDeConstruir: self cienMetrosCuadrados)
	equals: 9000 * peso.
! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:26:38 am (UTC)'!
test17ObtieneTiemposDeConstruccionDeUnEquipoCombinadoParaUnAreaDeterminada

	| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa tiemposDeEquipos |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: { equipoRojo. equipoBeta }.
	
	tiemposDeEquipos := equipoAlfa tiemposDeConstruccionPara: self cienMetrosCuadrados .
	
	self assert: (tiemposDeEquipos at: equipoRojo ) equals: 2*day.
	self assert: (tiemposDeEquipos at: equipoBeta ) equals: 5*day.
! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:27:09 am (UTC)'!
test18ObtienePreciosDeConstruccionDeUnEquipoCombinadoParaUnAreaDeterminada

	| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa preciosDeEquipos |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: { equipoRojo. equipoBeta }.
	
	preciosDeEquipos := equipoAlfa preciosDeConstruccionPara: self cienMetrosCuadrados .
	
	self assert: (preciosDeEquipos at: equipoRojo ) equals: 2000*peso.
	self assert: (preciosDeEquipos at: equipoBeta ) equals: 7000*peso.
! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 3:01:14 am (UTC)'!
test19ElEquipoMasRapidoEsElQueMenosTardaEnConstruirSuParteDelArea

	| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: {  equipoBeta. equipoRojo }.
	
	self assert: (equipoAlfa equipoConMenorTiempoDeConstruccionPara: self cienMetrosCuadrados)  equals: equipoRojo 
! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 3:01:07 am (UTC)'!
test20ElEquipoMasBaratoEsElQueMenosCuestaParaConstruirSuParteDelArea

	| equipoAzul equipoRojo equipoVerde equipoBeta equipoAlfa |

	equipoRojo := self equipoRojo.

	equipoAzul := self equipoAzul.

	equipoVerde := self equipoVerde.

	equipoBeta := EquipoCombinado con: { equipoAzul. equipoVerde }.
	equipoAlfa := EquipoCombinado con: {  equipoBeta. equipoRojo }.
	
	self assert: (equipoAlfa equipoConMenorPrecioDeConstruccionPara: self cienMetrosCuadrados)  equals: equipoRojo 
! !

!SmartBuildingTest methodsFor: 'tests' stamp: 'HAW 16/Nov/2026, 2:39:22 am (UTC)'!
test21ModificarLasColeccionesOriginalesNoModificaLosEquiposCombinados

	| equipos1 equipos2 equipoBeta equipoAlfa preciosAlfa preciosBeta tiemposAlfa tiemposBeta |
	equipos1 := {self equipoAzul . self equipoRojo }.
	equipoBeta := EquipoCombinado con: equipos1 .
	equipos2 := {self equipoRojo . equipoBeta }.
	
	equipoAlfa := EquipoCombinado con: equipos2 .	
	
	tiemposBeta := equipoBeta tiemposDeConstruccionPara: self cienMetrosCuadrados.
	preciosBeta := equipoBeta preciosDeConstruccionPara: self cienMetrosCuadrados.
	tiemposAlfa := equipoAlfa tiemposDeConstruccionPara: self cienMetrosCuadrados.
	preciosAlfa := equipoAlfa preciosDeConstruccionPara: self cienMetrosCuadrados.
	
	equipos1 at: 1 put: self equipoVerde.
	equipos2 at: 2 put: self equipoVerde.
	
	self
		assert: (equipoBeta tiemposDeConstruccionPara: self cienMetrosCuadrados)
		equals: tiemposBeta.
	self
		assert: (equipoBeta preciosDeConstruccionPara: self cienMetrosCuadrados)
		equals: preciosBeta.
	self
		assert: (equipoAlfa tiemposDeConstruccionPara: self cienMetrosCuadrados)
		equals: tiemposAlfa.
	self
		assert: (equipoAlfa preciosDeConstruccionPara: self cienMetrosCuadrados)
		equals: preciosAlfa.! !


!SmartBuildingTest methodsFor: 'setup' stamp: 'HAW 15/Nov/2026, 10:01:24 pm (UTC)'!
setUp

	diasLluviosos := 0*day! !


!SmartBuildingTest methodsFor: 'creacion - dimensiones' stamp: 'HAW 16/Nov/2026, 1:44:58 am (UTC)'!
cienMetrosCuadrados

	^ 100 * meter * meter! !

!SmartBuildingTest methodsFor: 'creacion - dimensiones' stamp: 'HAW 16/Nov/2026, 1:46:00 am (UTC)'!
diezMetrosCuadradosPorDia

	^ 10*meter*meter/ day! !

!SmartBuildingTest methodsFor: 'creacion - dimensiones' stamp: 'HAW 16/Nov/2026, 1:45:37 am (UTC)'!
milPesosPorDia

	^ 1000*peso/day! !

!SmartBuildingTest methodsFor: 'creacion - dimensiones' stamp: 'HAW 16/Nov/2026, 1:45:20 am (UTC)'!
veinticincoMetrosCuadradosPorDia

	^ 25 * meter * meter / day! !


!SmartBuildingTest methodsFor: 'creacion - equipos' stamp: 'HAW 16/Nov/2026, 1:43:14 am (UTC)'!
equipoAzul

	^ EquipoSimple
		construyendoCon: (CapacidadVariable
			de: 150 * meter * meter / week
			losPrimeros: 10 * day
			yElResto: 20 * meter * meter / day)
		a: (PrecioDependienteDelClima
			enDiasLluviosos: 1700 * peso / day
			yEnDiasNoLluviosos: 1500 * peso / day
			usando: self)! !

!SmartBuildingTest methodsFor: 'creacion - equipos' stamp: 'HAW 16/Nov/2026, 1:45:37 am (UTC)'!
equipoRojo

	^ EquipoSimple
		construyendoCon: (CapacidadFija
			de: 250000 * centimeter * centimeter / day)
		a: (PrecioFijo
			de: self milPesosPorDia)! !

!SmartBuildingTest methodsFor: 'creacion - equipos' stamp: 'HAW 16/Nov/2026, 1:43:24 am (UTC)'!
equipoVerde

	^ EquipoSimple
		construyendoCon: (CapacidadFija
			de: 5 * meter * meter / day)
		a: (PrecioFijo
			de: 800 * peso / day)! !


!SmartBuildingTest methodsFor: 'estacion meteorologica' stamp: 'HAW 15/Nov/2026, 10:11:18 pm (UTC)'!
cantidadDeDiasLluviososDurante: unosDiasDeConstruccion 
	
	^ diasLluviosos min: unosDiasDeConstruccion .! !
