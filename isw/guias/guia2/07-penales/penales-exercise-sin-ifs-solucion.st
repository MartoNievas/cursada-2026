!classDefinition: #Arquero category: #Penales!
Object subclass: #Arquero
	instanceVariableNames: 'estrategiaLanzarse fuerzaBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Arquero methodsFor: 'atajando penales' stamp: 'Martin 4/26/2026 17:09:39'!
recibirRemateAColocarJabulaniConFuerza: unaFuerzaAColocarConJabulani enDireccion: unaDireccionDeTiroAColocarConJabulani jugandoPenales: unosPenalesAColocarConJabulani

	estrategiaLanzarse atajarRemateAColocarJabulaniConFuerza: unaFuerzaAColocarConJabulani enDireccion: unaDireccionDeTiroAColocarConJabulani jugandoPenales: unosPenalesAColocarConJabulani .! !

!Arquero methodsFor: 'atajando penales' stamp: 'Martin 4/26/2026 17:12:44'!
recibirRemateAColocarPlayeraConFuerza: unaFuerzaAColocarPlayera enDireccion: unaDireccionAColocarConPlayera jugandoPenales: unosPenalesAColocarConPlayera.

	estrategiaLanzarse atajarRemateAColocarPlayeraConFuerza: unaFuerzaAColocarPlayera enDireccion: unaDireccionAColocarConPlayera jugandoPenales: unosPenalesAColocarConPlayera .! !

!Arquero methodsFor: 'atajando penales' stamp: 'Martin 4/26/2026 17:09:05'!
recibirRemateAMatarJabulaniConFuerza: unaFuerzaAMatarConJabulani enDireccion: unaDireccionDeTiroDesviadaPorAMatarConJabulani
jugandoPenales: unosPenalesAMatarConJabulani

	estrategiaLanzarse atajarRemateAMatarJabulaniConFuerza: unaFuerzaAMatarConJabulani enDireccion: unaDireccionDeTiroDesviadaPorAMatarConJabulani jugandoPenales: unosPenalesAMatarConJabulani .! !

!Arquero methodsFor: 'atajando penales' stamp: 'Martin 4/26/2026 17:10:20'!
recibirRemateAMatarPlayeraConFuerza: unaFuerzaAMatarConPlayera enDireccion: unaDireccionDesviadaPorAMatarConPlayera jugandoPenales: unosPenalesAMatarConPlayera

	estrategiaLanzarse atajarRemateAMatarPlayeraConFuerza: unaFuerzaAMatarConPlayera enDireccion: unaDireccionDesviadaPorAMatarConPlayera jugandoPenales: unosPenalesAMatarConPlayera .! !


!Arquero methodsFor: 'testing' stamp: 'Martin 4/26/2026 17:10:35'!
fuerza

	^fuerzaBase .! !


!Arquero methodsFor: 'initialization' stamp: 'Martin 4/26/2026 16:58:25'!
initializeConEstrategiaDeLanzarse: unaEstrategiaLanzarse conFuerza: unaFuerzaAtajada

	estrategiaLanzarse := unaEstrategiaLanzarse with: self.
	fuerzaBase := unaFuerzaAtajada .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: #Penales!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'instance creation' stamp: 'Martin 4/26/2026 17:01:29'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: unaFuerzaArquero

	^self new initializeConEstrategiaDeLanzarse: ElegirDireccionAntesDeTiro conFuerza: unaFuerzaArquero ! !

!Arquero class methodsFor: 'instance creation' stamp: 'Martin 4/26/2026 17:00:50'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: unaFuerzaArquero

	^self new initializeConEstrategiaDeLanzarse: EsperarTiroYSeAdelante conFuerza: unaFuerzaArquero ! !


!classDefinition: #Atajada category: #Penales!
Object subclass: #Atajada
	instanceVariableNames: 'delantero fuerzaDelantero puntosDelantero arquero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Atajada methodsFor: 'initialization' stamp: 'Martin 4/26/2026 17:02:01'!
initializeWith: unArquero

	arquero := unArquero .! !


!Atajada methodsFor: 'reglas' stamp: 'Martin 4/26/2026 17:17:48'!
arqueroAtajaIgnorandoAlturaDeTiro

	^[:coordTiro :coordAtajada | coordTiro x = coordAtajada x].! !


!Atajada methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:11:44'!
atajarRemateAColocarJabulaniConFuerza: unaFuerzaAColocarConJabulani enDireccion: unaDireccionDeTiroAColocarConJabulani jugandoPenales: unosPenalesAColocarConJabulani

	self subclassResponsibility .! !

!Atajada methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:14:08'!
atajarRemateAColocarPlayeraConFuerza: unaFuerzaAColocarPlayera enDireccion: unaDireccionAColocarConPlayera jugandoPenales: unosPenalesAColocarConPlayera

	self subclassResponsibility .! !

!Atajada methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:14:31'!
atajarRemateAMatarJabulaniConFuerza: unaFuerzaAMatarConJabulani enDireccion: unaDireccionDeTiroDesviadaPorAMatarConJabulani jugandoPenales: unosPenalesAMatarConJabulani

	self subclassResponsibility .! !

!Atajada methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:15:18'!
atajarRemateAMatarPlayeraConFuerza: unaFuerzaAMatarConPlayera enDireccion: unaDireccionDesviadaPorAMatarConPlayera jugandoPenales: unosPenalesAMatarConPlayera

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Atajada class' category: #Penales!
Atajada class
	instanceVariableNames: ''!

!Atajada class methodsFor: 'instance creation' stamp: 'Martin 4/26/2026 17:02:17'!
with: unArquero

	^self new initializeWith: unArquero .! !


!classDefinition: #ElegirDireccionAntesDeTiro category: #Penales!
Atajada subclass: #ElegirDireccionAntesDeTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!ElegirDireccionAntesDeTiro methodsFor: 'reglas' stamp: 'Martin 4/26/2026 17:42:34'!
arqueroAtajaIgnorandoAnchoDeTiro

	^ [ :coordTiro :coordAtajda | coordTiro  y = coordAtajda y].! !


!ElegirDireccionAntesDeTiro methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:20:12'!
atajarRemateAColocarJabulaniConFuerza: unaFuerzaAColocarConJabulani enDireccion: unaDireccionDeTiroAColocarConJabulani jugandoPenales: unosPenalesAColocarConJabulani

	|fuerzaDeAtajadaPorElegirAntes|
	
	fuerzaDeAtajadaPorElegirAntes := arquero fuerza * 1.5.
	unosPenalesAColocarConJabulani fuerzaDeTiroResultanteEnPenal: unaFuerzaAColocarConJabulani; fuerzaDeAtajadaResultanteEnPenal: fuerzaDeAtajadaPorElegirAntes .

	! !

!ElegirDireccionAntesDeTiro methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:19:18'!
atajarRemateAColocarPlayeraConFuerza: unaFuerzaAColocarPlayera enDireccion: unaDireccionAColocarConPlayera jugandoPenales: unosPenalesAColocarConPlayera

	|fuerzaAtajada|
	
	fuerzaAtajada := arquero fuerza * 2.
	
	unosPenalesAColocarConPlayera fuerzaDeTiroResultanteEnPenal: unaFuerzaAColocarPlayera; fuerzaDeAtajadaResultanteEnPenal: fuerzaAtajada .! !

!ElegirDireccionAntesDeTiro methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:35:03'!
atajarRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales
	
	| arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas := self arqueroAtajaIgnorandoAlturaDeTiro .
	
penales fuerzaDeTiroResultanteEnPenal: fuerzaTiroAMatarConJabulani; 
        direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatar; 
        resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas.! !

!ElegirDireccionAntesDeTiro methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:39:28'!
atajarRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales

	| arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  :=  self arqueroAtajaIgnorandoAnchoDeTiro .
	
	penales 
    direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar;
    resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas! !


!classDefinition: #EsperarTiroYSeAdelante category: #Penales!
Atajada subclass: #EsperarTiroYSeAdelante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!EsperarTiroYSeAdelante methodsFor: 'para penales' stamp: 'Martin 4/26/2026 17:46:21'!
atajarRemateAColocarJabulaniConFuerza: unaFuerzaAColocarConJabulani enDireccion: unaDireccionDeTiroAColocarConJabulani jugandoPenales: unosPenalesAColocarConJabulani

	|arqueroEnCoordenadasCorrectas|
	
	arqueroEnCoordenadasCorrectas := self arqueroAtajaIgnorandoAlturaDeTiro .
	
	unosPenalesAColocarConJabulani fuerzaDeTiroResultanteEnPenal: unaFuerzaAColocarConJabulani; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas.
	! !

!EsperarTiroYSeAdelante methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:36:39'!
atajarRemateAColocarPlayeraConFuerza: unaFuerzaAColocarPlayera enDireccion: unaDireccionAColocarConPlayera jugandoPenales: unosPenalesAColocarConPlayera

	|arqueroConSuficienteFuerza arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  := self arqueroSiempreSeTiraBien.
	arqueroConSuficienteFuerza := self arqueroNuncaLeAlcanzaLaFuerza.
	
	unosPenalesAColocarConPlayera fuerzaDeAtajadaResultanteEnPenal: unaFuerzaAColocarPlayera ; 
        resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas; 
        resolverFuerzaSuficienteDeArqueroEnPenalCon: arqueroConSuficienteFuerza ! !

!EsperarTiroYSeAdelante methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:30:42'!
atajarRemateAMatarJabulaniConFuerza: unaFuerzaTiroAMatarConJabulani enDireccion: unaDireccionTiroDesviadoPorAMatar jugandoPenales: unosPenalesAMatarConJabulani

		|arqueroConSuficienteFuerza arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  := self arqueroSiempreSeTiraBien.
	arqueroConSuficienteFuerza := self arqueroNuncaLeAlcanzaLaFuerza.
	
unosPenalesAMatarConJabulani 
    fuerzaDeTiroResultanteEnPenal: unaFuerzaTiroAMatarConJabulani;
    direccionDeRemateResultanteEnPenal: unaDireccionTiroDesviadoPorAMatar;
    resolverCoordenadasDeArqueroCorrectasDePenalCon: self arqueroSiempreSeTiraBien;
    resolverFuerzaSuficienteDeArqueroEnPenalCon: self arqueroNuncaLeAlcanzaLaFuerza.! !

!EsperarTiroYSeAdelante methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:32:27'!
atajarRemateAMatarPlayeraConFuerza: unaFuerzaTiroAMatar enDireccion: unaDireccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: unosPenalesAMatarConPlayera
	"Aca siempre ataja la pelota en este caso"
	|arqueroConSuficienteFuerza arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas := self arqueroSiempreSeTiraBien .
	arqueroConSuficienteFuerza := self arqueroSiempreConFuerzaSuficiente.
	
	unosPenalesAMatarConPlayera fuerzaDeAtajadaResultanteEnPenal: unaFuerzaTiroAMatar ; direccionDeRemateResultanteEnPenal: unaDireccionTiroDesviadoPorAMatarOPorPlayeraAMatar ;
	resolverCoordenadasDeArqueroCorrectasDePenalCon: self arqueroSiempreSeTiraBien;
        resolverFuerzaSuficienteDeArqueroEnPenalCon: self arqueroSiempreConFuerzaSuficiente .
	! !


!EsperarTiroYSeAdelante methodsFor: 'reglas' stamp: 'Ma 4/27/2026 16:02:59'!
arqueroNuncaLeAlcanzaLaFuerza

	^ [:fuerzaRemate :fuerzaAtajada | false].! !

!EsperarTiroYSeAdelante methodsFor: 'reglas' stamp: 'Ma 4/27/2026 16:04:15'!
arqueroSiempreConFuerzaSuficiente

	^[:fuerzaRemate :fuerzaAtajada | true].! !

!EsperarTiroYSeAdelante methodsFor: 'reglas' stamp: 'Ma 4/27/2026 16:04:25'!
arqueroSiempreSeTiraBien

	^[:fuerzaRemate :fuerzaAtajada | true].! !


!classDefinition: #Delantero category: #Penales!
Object subclass: #Delantero
	instanceVariableNames: 'estrategiaDeTiro fuerzaBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Delantero methodsFor: 'caracteristicas base' stamp: 'Ma 4/27/2026 16:08:00'!
fuerza

	^fuerzaBase .! !


!Delantero methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:16:22'!
patea: unaPelota conDireccion: unaDireccionTiro aArquero: unArquero jugandoPenales: unosPenales


	estrategiaDeTiro rematar: unaPelota conDireccion:  unaDireccionTiro aArquero: unArquero  jugandoPenales: unosPenales .! !


!Delantero methodsFor: 'intialization' stamp: 'Ma 4/27/2026 18:18:11'!
initializeConEstrategiaDeTiro: unaEstrategiaDeTiro conFuerza: unaFuerzaBase

	estrategiaDeTiro := unaEstrategiaDeTiro with: self.
	fuerzaBase := unaFuerzaBase .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: #Penales!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:06:42'!
decideTirarAColocarSuFuerzaBaseEs: unaFuerzaBase

	^self new initializeConEstrategiaDeTiro: AColocar conFuerza: unaFuerzaBase .! !

!Delantero class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:07:16'!
decideTirarAMatarSuFuerzaBaseEs: unaFuerzaBase

	^self new initializeConEstrategiaDeTiro: AMatar conFuerza: unaFuerzaBase ! !


!classDefinition: #Pelota category: #Penales!
Object subclass: #Pelota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Pelota methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:24:38'!
siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: unaDireccionTiroAColocar aArquero: unArquero  jugandoPenales: unosPenales

	self subclassResponsibility .! !

!Pelota methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:26:44'!
siendoPateadaAMatarConFuerza: unaFuerzaAMatar enDireccion: unaDireccionDeTiroDesviadaPorAMatar aArquero: unArquero jugandoPenales: unosPenales 


	self subclassResponsibility .

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: #Penales!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:11:29'!
jabulaniSudafricanaRapida

	^Jabulani new.! !

!Pelota class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:11:44'!
playeraLentaCostaAzul

	^Playera new.! !


!classDefinition: #Jabulani category: #Penales!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Jabulani methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:29:46'!
siendoPateadaAColocarConFuerza: unaFuerzaAColocar enDireccion: unaDireccionTiroAColocar aArquero: unArquero  jugandoPenales: unosPenales
	
	unArquero recibirRemateAColocarJabulaniConFuerza: unaFuerzaAColocar  enDireccion: unaDireccionTiroAColocar  jugandoPenales: unosPenales .! !

!Jabulani methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:38:50'!
siendoPateadaAMatarConFuerza: unaFuerzaAMatar conDireccionOriginal: unaDireccionOriginal yendoEnDireccion: unaDireccionDeTiroDesviadaPorAMatar aArquero: unArquero jugandoPenales: unosPenales 
		
	|fuerzaTiroAMatarConJabulani|
	
	fuerzaTiroAMatarConJabulani := unaFuerzaAMatar * 1.2.
	
	unArquero recibirRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: unaDireccionDeTiroDesviadaPorAMatar jugandoPenales: unosPenales 


	! !


!classDefinition: #Playera category: #Penales!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Playera methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:33:25'!
siendoPateadaAColocarConFuerza: unaFuerzaAColocar enDireccion: unaDireccionTiroAColocar aArquero: unArquero  jugandoPenales: unosPenales
	
	|fuerzaTiroAColocar|
	
	fuerzaTiroAColocar := unaFuerzaAColocar * 0.8.
	
	unArquero recibirRemateAColocarPlayeraConFuerza: fuerzaTiroAColocar enDireccion:  unaDireccionTiroAColocar jugandoPenales: unosPenales .

	! !

!Playera methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:28:47'!
siendoPateadaAMatarConFuerza: unaFuerzaAMatar conDireccionOriginal: unaDireccionTiroOriginal  yendoEnDireccion: unaDireccionDeTiroDesviadaPorAMatar aArquero: unArquero jugandoPenales: unosPenales 


	|direccionTiroDesviadoPorAMatarOPorPlayeraAMatar |
	
	direccionTiroDesviadoPorAMatarOPorPlayeraAMatar := unaDireccionDeTiroDesviadaPorAMatar .
	
	(unosPenales tiroAlAngulo: unaDireccionTiroOriginal ) ifFalse: [direccionTiroDesviadoPorAMatarOPorPlayeraAMatar := self desviarDireccionDosHaciaArriba: unaDireccionDeTiroDesviadaPorAMatar ].
	
	unArquero recibirRemateAMatarPlayeraConFuerza: unaFuerzaAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar  jugandoPenales: unosPenales .! !


!Playera methodsFor: 'reglas' stamp: 'Ma 4/27/2026 16:44:18'!
desviarDireccionDosHaciaArriba: unaDireccion

	^(unaDireccion x)@(unaDireccion y+2).! !


!classDefinition: #Penales category: #Penales!
Object subclass: #Penales
	instanceVariableNames: 'delantero fuerzaDelantero puntosDelantero arquero fuerzaArquero puntosArquero arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas varDireccionRemate varDireccionAtajada varFuerzaResultanteDeTiro varFuerzaResultanteAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 17:48:08'!
arbitroPitaConPelota: unaPelota delanteroRemataAlArcoConDireccion: unaDireccionTiro arqueroSeLanzaEnDirección: unaDireccionLanzarseArquero

	self assetValidaDireccionTiro: unaDireccionTiro direccionArquero: unaDireccionLanzarseArquero .
	
	self registrarValoresDelVARPrevioAlRemteConDirccion: unaDireccionTiro yArqueroLanzandoseA: unaDireccionLanzarseArquero .
	self registrarReglasBisicasDePenales.
	
	delantero patea: unaPelota  conDireccion: unaDireccionTiro aArquero:  arquero jugandoPenales: self.
	
	self arbitroDeterminaGanadorEnBaseAReglasYVAR.


	! !

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 17:51:20'!
direccionDeRemateResultanteEnPenal: unaDireccionResultante

	varDireccionRemate := unaDireccionResultante .! !

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 18:09:04'!
fuerzaDeAtajadaResultanteEnPenal: fuerzaAtajadaResultante
	
	varFuerzaResultanteAtajada := fuerzaAtajadaResultante! !

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 17:52:59'!
fuerzaDeTiroResultanteEnPenal: fuerzaTiroResultante
	
	varFuerzaResultanteDeTiro := fuerzaTiroResultante! !

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 18:18:47'!
varFuerzaResultanteDeAtajada

	^varFuerzaResultanteAtajada .! !

!Penales methodsFor: 'juego' stamp: 'Ma 4/27/2026 17:49:10'!
varFuerzaResultanteDeTiro

	^varFuerzaResultanteDeTiro ! !


!Penales methodsFor: 'testing' stamp: 'Ma 4/27/2026 16:49:23'!
puntajeDeArquero

	^puntosArquero .! !

!Penales methodsFor: 'testing' stamp: 'Ma 4/27/2026 16:49:10'!
puntajeDeDelantero

	^puntosDelantero ! !

!Penales methodsFor: 'testing' stamp: 'Ma 4/27/2026 18:07:26'!
varDireccionRemateResultante

	^varDireccionRemate .! !


!Penales methodsFor: 'assertion' stamp: 'Ma 4/27/2026 17:00:54'!
assertValidaDireccion: unaDireccion error: unMensajeError

	(self coordenadaDentroDelArco: unaDireccion ) ifFalse: [self error: unMensajeError ].! !

!Penales methodsFor: 'assertion' stamp: 'Ma 4/27/2026 16:59:04'!
assetValidaDireccionTiro: unaDireccionTiro direccionArquero: unaDireccionLanzarseArquero

	self assertValidaDireccion: unaDireccionTiro error: Penales direccionTiroFueraDeRango .
	self assertValidaDireccion: unaDireccionLanzarseArquero error: Penales direccionArqueroFueraDeRango .! !


!Penales methodsFor: 'reglas' stamp: 'Ma 4/27/2026 17:01:19'!
coordenadaDentroDelArco: unaCoordenada

	^unaCoordenada between: 0@0 and: 2@2. ! !

!Penales methodsFor: 'reglas' stamp: 'Ma 4/27/2026 17:42:22'!
registrarReglasBisicasDePenales

	arqueroConFuerzaSuficiente := [:fuerzaTiro :fuerzaAtajada | fuerzaAtajada >= fuerzaTiro ].
	arqueroEnCoordenadasCorrectas := [:coordTiro :coordAtajada | coordTiro = coordAtajada ].! !

!Penales methodsFor: 'reglas' stamp: 'Ma 4/27/2026 18:12:34'!
resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroCoordenadasCorrectas

	arqueroEnCoordenadasCorrectas := arqueroCoordenadasCorrectas .! !

!Penales methodsFor: 'reglas' stamp: 'Ma 4/27/2026 18:12:55'!
resolverFuerzaSuficienteDeArqueroEnPenalCon: arqueroFuerzaSuficiente
	
	arqueroConFuerzaSuficiente  := arqueroFuerzaSuficiente! !


!Penales methodsFor: 'initialization' stamp: 'Ma 4/27/2026 16:47:59'!
initializeConDelantero: unDelantero yArquero: unArquero

	delantero := unDelantero .
	arquero := unArquero .
	puntosDelantero := 0.
	puntosArquero := 0.! !


!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 17:57:24'!
arbitroDeterminaGanadorEnBaseAReglasYVAR

	^ (self remateVaAlArco ) 
		ifFalse: [self puntoParaArquero]  
		ifTrue: [ self arqueroEligeCorrectamenteYTieneLaFuerzaParaDetenerTiro
			ifTrue: [self atajoArquero ]  
			ifFalse: [self golDelantero ]
			].! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:00:48'!
arqueroEligeCorrectamenteYTieneLaFuerzaParaDetenerTiro

	^self arqueroSeLanzaAPosicionDelTiroCorrecta and: [self arqueroTieneLaFuerzaSuficienteParaDetenerTiro.]! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:00:54'!
arqueroSeLanzaAPosicionDelTiroCorrecta

	^ arqueroEnCoordenadasCorrectas value: varDireccionRemate value: varDireccionAtajada .! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:01:52'!
arqueroTieneLaFuerzaSuficienteParaDetenerTiro

	^arqueroConFuerzaSuficiente value: varFuerzaResultanteDeTiro value: varFuerzaResultanteAtajada .! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:08:23'!
atajoArquero

	self puntoParaArquero .! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 17:03:58'!
golDelantero

	self puntoParaDelantero .! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:03:05'!
puntoParaArquero

	puntosArquero := 1.! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 17:03:28'!
puntoParaDelantero

	puntosDelantero := 1.! !

!Penales methodsFor: 'ganador' stamp: 'Ma 4/27/2026 18:07:41'!
remateVaAlArco

	^self coordenadaDentroDelArco: varDireccionRemate ! !


!Penales methodsFor: 'VAR' stamp: 'Ma 4/27/2026 17:49:36'!
registrarValoresDelVARPrevioAlRemteConDirccion: unaDireccionTiro yArqueroLanzandoseA: unaDireccionLanzarseArquero

	varDireccionRemate := unaDireccionTiro .
	varDireccionAtajada := unaDireccionLanzarseArquero .
	varFuerzaResultanteDeTiro := delantero fuerza .
	varFuerzaResultanteAtajada := arquero fuerza .
	! !

!Penales methodsFor: 'VAR' stamp: 'Ma 4/27/2026 16:53:29'!
tiroAlAngulo: unaDireccionTiro

	^ self esquinasDelArco includes: unaDireccionTiro .! !


!Penales methodsFor: 'private' stamp: 'Ma 4/27/2026 18:44:19'!
esquinasDelArco

	^ {0@0. 0@2. 2@0. 2@2.}! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: #Penales!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:48:28'!
conDelantero: unDelantero yArquero: unArquero

	^self new initializeConDelantero: unDelantero yArquero:unArquero .! !


!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:49'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:32'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !


!classDefinition: #Remate category: #Penales!
Object subclass: #Remate
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Remate methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:14:34'!
rematar: unaPelota conDireccion: unaDireccionTiro aArquero: unArquero jugandoPenales: unosPenales .

	self subclassResponsibility .! !


!Remate methodsFor: 'initialization' stamp: 'Ma 4/27/2026 16:13:33'!
initializeConDelantero: unDelantero

	delantero := unDelantero .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Remate class' category: #Penales!
Remate class
	instanceVariableNames: ''!

!Remate class methodsFor: 'instance creation' stamp: 'Ma 4/27/2026 16:13:51'!
with: unDelantero

	^self new initializeConDelantero: unDelantero ! !


!classDefinition: #AColocar category: #Penales!
Remate subclass: #AColocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!AColocar methodsFor: 'para penales' stamp: 'Ma 4/27/2026 16:16:14'!
rematar: unaPelota conDireccion: unaDireccionTiroAColocar aArquero: unArquero jugandoPenales: unosPenales

	|fuerzaAColocar|
	
	fuerzaAColocar := delantero fuerza * 0.5.
	
	unaPelota siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: unaDireccionTiroAColocar aArquero: unArquero  jugandoPenales: unosPenales .! !


!classDefinition: #AMatar category: #Penales!
Remate subclass: #AMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!AMatar methodsFor: 'reglas' stamp: 'Ma 4/27/2026 16:23:44'!
desviarDireccionAAlturaMedia: unaDireccionTiro

	^(unaDireccionTiro x)@1.! !


!AMatar methodsFor: 'para penales' stamp: 'Ma 4/27/2026 18:06:04'!
rematar: unaPelota conDireccion: unaDireccionTiroOriginal aArquero: unArquero jugandoPenales: unosPenales 
	
	| unaFuerzaAMatar unaDireccionDeTiroDesviadaPorAMatar|
	
	unaFuerzaAMatar := delantero fuerza.
	unaDireccionDeTiroDesviadaPorAMatar := unaDireccionTiroOriginal.
	
	(unosPenales tiroAlAngulo: unaDireccionTiroOriginal ) ifTrue: [unaDireccionDeTiroDesviadaPorAMatar := self desviarDireccionAAlturaMedia: unaDireccionDeTiroDesviadaPorAMatar ].
	
	unaPelota siendoPateadaAMatarConFuerza: unaFuerzaAMatar conDireccionOriginal: unaDireccionTiroOriginal  yendoEnDireccion: unaDireccionDeTiroDesviadaPorAMatar aArquero: unArquero jugandoPenales: unosPenales .
! !


!classDefinition: #PenalesTest category: #Penales!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test01DelanteroNoPuedeApuntarHaciaAfueraDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: -1@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test02DelanteroNoPuedeApuntarHaciaAfueraDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 3@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test03DelanteroNoPuedeApuntarHaciaAbajoDelArco
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@-1 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test04DelanteroNoPuedeApuntarHaciaArribaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@3 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test05ArqueroNoPuedePasarseDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: -1@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test06ArqueroNoPuedePasarseDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 3@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test07ArqueroNoPuedeMeterseAbajoDeLaTierra
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@-1.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test08ArqueroNoPuedeSaltarPorEncimaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@3.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test09DireccionesDiferentesGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante
	"varXXXX es por VAR, de 'Video Assistant Referee'"! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test10MismasDireccionesInsuficienteFuerzaGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 10.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test11MismasDireccionesSuficienteFuerzaAtajaArquero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test12DelanteroQueTiraAColocarPierde50PorcFuerza
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"(delantero sacrificia potencia para ganar mayor precisión)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test13ArqueroQueEligeAntesDeTiroVsJabulaniAColocarSuma50PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige donde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	"(el arquero llega más cómodo y aprovecha mejor su fuerza)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 34.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 51 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test14FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige adonde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 32.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 48 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test15ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAColocarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que espera y se adelanta ante un tiro de jabulani a colocar ignora la 2da coordenada (altura) al atajar..."	
	"(al adelanterse encara la pelota antes de que su elevación se transforme en un problema)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test16PelotaPlayeraUsadaAColocarLeHacePerder20PorcFuerzaExtraAlDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% de fuerza adicional al delantero que la use para colocar... (no importa el arquero)"
	"(no debería ser reglamentaria... al menos no es de trapo, nos responden)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test17ArqueroQueEligeAntesDeTiroVsPlayeraAColocarSuma100PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	"(a quien madruga...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 20.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test18FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsPlayeraAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 19.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 38 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test19ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAColocarEsDescubiertoYPuntoParaDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Arquero que espera y se adelanta ante tiro con la lenta pelota playera, siempre es descubierto por el Árbitro, y el punto se le otorga al Delantero..."
	"(lo que servía de ventaja ante la Jabulani rápida, acá es tan obvio por lo que tarda en llegar la pelota al arco, que marchás preso...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:52'!
test20DelanteroTiraAMatarAlAnguloInferiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:47'!
test21DelanteroTiraAMatarAlAnguloSuperiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:41'!
test22DelanteroTiraAMatarAlAnguloInferiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:36'!
test23DelanteroTiraAMatarAlAnguloSuperiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:29'!
test24DelanteroTiraAMatarNoAlAnguloMantieneDireccionTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@1.

	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test25DelanteroTiraAMatarUsa100PorcFuerzaBase
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:150.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 150 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test26DelanteroTiraAMatarConJabulaniGana20PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	"(Jabulani a matar es la elección de los guerreros Z)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 120.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test27FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAMatar
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 119.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test28ArqueroQueEligeAntesDeTiroVsJabulaniAMatarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que elige donde tirarse antes de un tiro de jabulani a matar, ignora la 2da coordenada (altura) al atajar..."		
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test29ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAMatarNuncaAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera a ver la dirección del remate de una pelota jabulani rápida a matar antes de lanzarse, nunca la ataja sin importar nada, siquiera que se adelantó..."	
	"(su poder era de más de 9000!! era impresionante, no podía moverme, sólo la ví pasar... f )"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@1 arqueroSeLanzaEnDirección: 1@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test30DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAdentro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(y voló.. y me hizo volar... y yo volé de él...  pero acá por la arbolada... y el voló.. y se estrelló por acá por la pared...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 1@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test31DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAfuera
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(El caso auspiciado por el Pipita...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@1 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@3 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test32ArqueroQueEligeAntesDeTiroVsPlayeraAMatarAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 18:39:22'!
test33ArqueroQueEligeAntesDeTiroVsPlayeraAMatarNoAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test34ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAMatarSiempreAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera y se adelanta ante una pelota playera lenta a matar, siempre la ataja sin importar nada..."	
	"(como la pelota es taaaan lentaaa, el arquero se puede ir a tomar un cafe, verse una serie, volver y aún atajar la pelota habiendose tirado a cualquier lado. Pero igual es más rapida que cuando se la tira a colocar, donde indefectiblemente el arbitro lo detecta...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 64 53 56 59 52 104 121 106 111 56 52 56 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 60 65 59 56 65 59 60 53 59 62 58 64 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 108 122 108 52 122 112 117 52 112 109 122 52 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 53 122 123 17 59 58 56 58 64 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 62 65 55 60 65 60 56 53 56 55 62 60 64 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 122 118 115 124 106 112 118 117 52 119 104 121 106 112 104 115 52 119 108 117 104 115 108 122 53 122 123 17 60 60 55 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 55 57 65 56 61 53 60 59 63 55 59 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 62 63 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 55 61 65 57 61 53 58 62 59 64 64 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 62 63 62 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 55 64 65 57 57 53 60 58 57 57 55 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 62 63 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 57 61 65 56 58 53 63 60 60 64 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 57 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 57 64 65 57 63 53 60 61 62 55 56 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 56 59 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 58 56 65 56 62 53 58 56 63 61 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 59 64 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 58 62 65 57 62 53 58 61 64 62 61 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 59 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 58 62 65 60 56 53 61 62 61 59 58 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 59 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 59 58 65 58 56 53 57 61 58 56 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 87 108 117 104 115 108 122 53 122 123 17 60 63 59 59 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 59 52 57 62 91 56 63 65 59 60 65 60 58 53 60 56 61 63 58 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 108 122 106 121 112 123 118 121 112 118 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 112 117 52 112 109 122 52 122 118 115 124 106 112 118 117 53 122 123 17 60 63 59 59 59 17 52 52 52 52 52 52 52 52 52 52 17 17))!