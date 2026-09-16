!classDefinition: #PenalesTest category: #'penales-exercise-solucion-sinIfs-2'!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:06 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:06 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:08 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:34 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:34 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:08 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:34 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:34 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:34:52 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:34:47 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:34:41 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:34:36 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:34:29 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:08 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:08 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:42:08 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:06 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:39:22 pm (UTC)'!
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

!PenalesTest methodsFor: 'tests' stamp: 'NR 24/Sep/2023, 9:41:05 am (UTC)'!
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


!classDefinition: #Arquero category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #Arquero
	instanceVariableNames: 'fuerzaBase estrategiaAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Arquero methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 8:27:10 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales

	estrategiaAtajada intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 8:27:16 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro  enDireccion: coordenadaDeRemate  jugando: unosPenales .
	! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 8:27:23 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 8:27:30 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate  jugando: unosPenales .! !


!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:37:34 pm (UTC)'!
intentaAtajarJabulaniAColocarEligiendoDireccionAntesConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	| nuevaFuerzaDeAtajada |
	nuevaFuerzaDeAtajada := fuerzaBase * 1.5.
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: nuevaFuerzaDeAtajada .! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:25:19 pm (UTC)'!
intentaAtajarJabulaniAColocarEsperandoPorTiroYSeAdelanteConFuerza: unFuerzaTiro enDireccion: coordenadaDeRemate  jugando: unosPenales 

	"remate a colocar con jabulani reduce fuerza del remate en 50%"
	"atajada a coloar con jabulani esperando por tiro y adelantandose arquero ignora altura"
	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | coordRemate x = coordAtajada x].
	
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unFuerzaTiro atajandoConFuerza: fuerzaBase .! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:33:33 pm (UTC)'!
intentaAtajarJabulaniAMatarEligiendoDireccionAntesConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	|trayectoriaDeTiro|
	trayectoriaDeTiro := coordenadaDeRemate .
	(unosPenales tiroAlAngunlo: coordenadaDeRemate ) ifTrue: [
			trayectoriaDeTiro := coordenadaDeRemate x @ 1.
		] .
	
	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | coordRemate x = coordAtajada x].
	
	unosPenales decidirRemateEnDireccion: trayectoriaDeTiro conFuerza: unaFuerzaTiro  atajandoConFuerza: fuerzaBase 
	
	! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:26:00 pm (UTC)'!
intentaAtajarJabulaniAMatarEsperandoPorTiroYSeAdelanteConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	unosPenales arqueroConFuerzaSuficiente: [:fuerzaRemate :fuerzaAtajada | false].
	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | true].

	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: fuerzaBase .! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:26:12 pm (UTC)'!
intentaAtajarPlayeraAColocarEligiendoDireccionAntesConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	"Se redujo la fuerza del remta en un 20%"
	"La fuerza del arquero aumenta en un 100% "
	| nuevaFuerzaDeAtajada |
	nuevaFuerzaDeAtajada := fuerzaBase * 2.
	
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: nuevaFuerzaDeAtajada .! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:26:20 pm (UTC)'!
intentaAtajarPlayeraAColocarEsperandoPorTiroYSeAdelanteConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | true].
	unosPenales arqueroConFuerzaSuficiente: [:fuerzaRemate :fuerzaAtajada | false].
	
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: fuerzaBase .! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:26:28 pm (UTC)'!
intentaAtajarPlayeraAMatarEligiendoDireccionAntesConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 


	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | coordRemate y = coordAtajada y].
	
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro atajandoConFuerza: fuerzaBase .
	! !

!Arquero methodsFor: 'atajar - estrategia' stamp: 'HAW 15/Sep/2026, 8:26:38 pm (UTC)'!
intentaAtajarPlayeraAMatarEsperandoPorTiroYSeAdelanteConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	unosPenales arqueroConFuerzaSuficiente: [:fuerzaRemate :fuerzaAtajada | true].
	unosPenales arqueroEnCoordenadasCorrectas: [:coordRemate :coordAtajada | true].
	
	unosPenales decidirRemateEnDireccion: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: fuerzaBase .! !


!Arquero methodsFor: 'initialization' stamp: 'HAW 15/Sep/2026, 8:27:49 pm (UTC)'!
initializeConFuerza: unNivelDeFuerza atajandoA: unaEstrategiaDeAtajada 

	fuerzaBase := unNivelDeFuerza.
	estrategiaAtajada := unaEstrategiaDeAtajada para: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: #'penales-exercise-solucion-sinIfs-2'!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 8:27:49 pm (UTC)'!
conFuerzaBase: unNivelDeFuerza atajandoA: unaEstrategiaDeAtajada

	^ self new initializeConFuerza: unNivelDeFuerza atajandoA: unaEstrategiaDeAtajada .! !

!Arquero class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:26:05 pm (UTC)'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: unNivelDeFuerza 

	^ self conFuerzaBase:  unNivelDeFuerza atajandoA: EligeDireccionAntes.! !

!Arquero class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:26:08 pm (UTC)'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: unNivelDeFuerza 

	^self conFuerzaBase: unNivelDeFuerza atajandoA: EsperaPorTiroYSeAdelanta .! !


!classDefinition: #Delantero category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #Delantero
	instanceVariableNames: 'fuerzaBase estrategiaTiro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Delantero methodsFor: 'initialize' stamp: 'HAW 15/Sep/2026, 4:27:46 pm (UTC)'!
initializeConFuerzaBase: unNivelDeFuerza tirando: unaEstrategiaDeTiro 

	fuerzaBase := unNivelDeFuerza.
	estrategiaTiro := unaEstrategiaDeTiro para: self.! !


!Delantero methodsFor: 'remate - estrategia' stamp: 'HAW 15/Sep/2026, 4:06:56 pm (UTC)'!
remataAColocar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales

	|fuerzaAColocar|
	fuerzaAColocar := fuerzaBase * 0.5.
	unaPelota siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales .! !

!Delantero methodsFor: 'remate - estrategia' stamp: 'HAW 15/Sep/2026, 4:47:47 pm (UTC)'!
remataAMatar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales 
	
	"Tira con el 100% de la fuerza"
	unaPelota siendoPateadaAMatarConFuerza: fuerzaBase enDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales .! !


!Delantero methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:02:13 pm (UTC)'!
patea: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales

	estrategiaTiro rematar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: #'penales-exercise-solucion-sinIfs-2'!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'instance creation' stamp: 'HAW 14/Sep/2026, 10:56:14 pm (UTC)'!
conFuerzaBase: unNivelDeFuerza tirando: unaEstrategiaDeTiro

	^self new initializeConFuerzaBase: unNivelDeFuerza tirando: unaEstrategiaDeTiro .! !

!Delantero class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:27:27 pm (UTC)'!
decideTirarAColocarSuFuerzaBaseEs: unNivelDeFuerza 

	^self conFuerzaBase: unNivelDeFuerza tirando: AColocar.! !

!Delantero class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:27:22 pm (UTC)'!
decideTirarAMatarSuFuerzaBaseEs: unNivelDeFuerza 

	^self conFuerzaBase: unNivelDeFuerza tirando: AMatar.! !


!classDefinition: #EstrategiaAtajada category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #EstrategiaAtajada
	instanceVariableNames: 'arquero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EstrategiaAtajada methodsFor: 'initialization' stamp: 'HAW 15/Sep/2026, 4:27:14 pm (UTC)'!
initializePara: unArquero

	arquero := unArquero .! !




!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:11:32 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales

	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:28:47 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:43:27 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales 

	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:01:34 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstrategiaAtajada class' category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaAtajada class
	instanceVariableNames: ''!

!EstrategiaAtajada class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:26:55 pm (UTC)'!
para: unArquero

	^self new initializePara: unArquero .
	! !


!classDefinition: #EligeDireccionAntes category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaAtajada subclass: #EligeDireccionAntes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:32:35 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarJabulaniAColocarEligiendoDireccionAntesConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate  jugando: unosPenales .! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:50:26 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarJabulaniAMatarEligiendoDireccionAntesConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate  jugando: unosPenales .! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:40:15 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarPlayeraAColocarEligiendoDireccionAntesConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate  jugando: unosPenales .! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:02:45 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 

	arquero intentaAtajarPlayeraAMatarEligiendoDireccionAntesConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate  jugando: unosPenales .
	
	! !


!classDefinition: #EsperaPorTiroYSeAdelanta category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaAtajada subclass: #EsperaPorTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:12:31 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales

	arquero intentaAtajarJabulaniAColocarEsperandoPorTiroYSeAdelanteConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate  jugando: unosPenales .! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:29:55 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarJabulaniAMatarEsperandoPorTiroYSeAdelanteConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate  jugando: unosPenales .! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 4:43:19 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarPlayeraAColocarEsperandoPorTiroYSeAdelanteConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate  jugando: unosPenales! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 15/Sep/2026, 5:32:03 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	arquero intentaAtajarPlayeraAMatarEsperandoPorTiroYSeAdelanteConFuerza: aFuerzaBase enDireccion: coordenadaDeRemate jugando: unosPenales .! !


!classDefinition: #EstrategiaTiro category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #EstrategiaTiro
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EstrategiaTiro methodsFor: 'initialization' stamp: 'HAW 15/Sep/2026, 4:28:24 pm (UTC)'!
initializePara: unDelantero

	delantero := unDelantero .! !


!EstrategiaTiro methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:02:34 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales 

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstrategiaTiro class' category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaTiro class
	instanceVariableNames: ''!

!EstrategiaTiro class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:28:04 pm (UTC)'!
para: unDelantero

	^ self new initializePara: unDelantero .! !


!classDefinition: #AColocar category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaTiro subclass: #AColocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!AColocar methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:05:19 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales 

	"Si se remata una pelota a colocar perdemos 50% fuerza"
	delantero remataAColocar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales.! !


!classDefinition: #AMatar category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaTiro subclass: #AMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!AMatar methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 7:57:20 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales 
	
	delantero remataAMatar: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales.! !


!classDefinition: #Pelota category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #Pelota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Pelota methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:08:18 pm (UTC)'!
siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales

	self subclassResponsibility .! !

!Pelota methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:58:02 pm (UTC)'!
siendoPateadaAMatarConFuerza: fuerzaBase enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales 

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: #'penales-exercise-solucion-sinIfs-2'!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:17:43 pm (UTC)'!
jabulaniSudafricanaRapida

	^Jabulani new.! !

!Pelota class methodsFor: 'instance creation' stamp: 'HAW 15/Sep/2026, 4:17:51 pm (UTC)'!
playeraLentaCostaAzul

	^Playera new.! !


!classDefinition: #Jabulani category: #'penales-exercise-solucion-sinIfs-2'!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Jabulani methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:10:15 pm (UTC)'!
siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales 

	unArquero intentaAtajarJabulaniAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate jugando: unosPenales .! !

!Jabulani methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:52:56 pm (UTC)'!
siendoPateadaAMatarConFuerza: fuerzaBase enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales 
	"Como es jabulani aumenta la fuerza en un 20%"
	
	unArquero intentaAtajarJabulaniAMatarConFuerza: fuerzaBase * 1.2 enDireccion: coordenadaDeRemate jugando: unosPenales .
	! !


!classDefinition: #Playera category: #'penales-exercise-solucion-sinIfs-2'!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Playera methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 4:37:14 pm (UTC)'!
siendoPateadaAColocarConFuerza: fuerzaAColocar enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales 
	"Se reduce la fuerza en un 20%"
	
	unArquero intentaAtajarPlayeraAColocarConFuerza: fuerzaAColocar * 0.80 enDireccion: coordenadaDeRemate jugando: unosPenales .! !

!Playera methodsFor: 'remate' stamp: 'HAW 15/Sep/2026, 5:35:06 pm (UTC)'!
siendoPateadaAMatarConFuerza: fuerzaBase enDireccion: coordenadaDeRemate aArquero: unArquero jugando: unosPenales 
	
		|trayectoriaTiro|
	trayectoriaTiro := coordenadaDeRemate .
	(unosPenales tiroAlAngunlo: coordenadaDeRemate ) ifFalse: [
			trayectoriaTiro := coordenadaDeRemate + (0@2)
	] ifTrue: [
		trayectoriaTiro := coordenadaDeRemate x @ 1.
	].
	
	unArquero intentaAtajarPlayeraAMatarConFuerza:  fuerzaBase enDireccion: trayectoriaTiro  jugando: unosPenales .
	
	! !


!classDefinition: #Penales category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #Penales
	instanceVariableNames: 'delantero arquero puntajeDelantero puntajeArquero varDireccionRemate varFuerzaResultanteDeTiro varFuerzaResultanteDeAtajada varDireccionDeAtajada arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Penales methodsFor: 'penales juego' stamp: 'HAW 15/Sep/2026, 11:52:07 pm (UTC)'!
arbitroPitaConPelota: unaPelota delanteroRemataAlArcoConDireccion: coordenadaDeRemate arqueroSeLanzaEnDirección: coordenadaDeAtajada
		self registrarValoresDelVARPreviosAlRemateConDireccion: coordenadaDeRemate yArqueroLanzandoseA: coordenadaDeAtajada .

	    self establecerReglasBasicasDePenales.

	    self assertVerficar: coordenadaDeRemate y: coordenadaDeAtajada.
	
	delantero patea: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: self.
! !


!Penales methodsFor: 'initialization' stamp: 'HAW 14/Sep/2026, 4:15:53 pm (UTC)'!
initializeConDelantero: unDelantero yArquero: unArquero 

	delantero := unDelantero.
	arquero := unArquero.
	puntajeDelantero := 0.
	puntajeArquero := 0.
! !


!Penales methodsFor: 'assertion' stamp: 'HAW 14/Sep/2026, 5:51:20 pm (UTC)'!
assertDireccionCoordenada: unaDireccion dentroDelArcoSinoError: unMensajeDeError
	(unaDireccion between: 0@0 and: 2@2)
		ifFalse: [ ^self error: unMensajeDeError ]! !

!Penales methodsFor: 'assertion' stamp: 'HAW 15/Sep/2026, 3:53:36 pm (UTC)'!
assertVerficar: coordenadaDeRemate y: coordenadaDeAtajada

	self assertDireccionCoordenada: coordenadaDeRemate dentroDelArcoSinoError: Penales direccionTiroFueraDeRango.
	    self assertDireccionCoordenada: coordenadaDeAtajada dentroDelArcoSinoError: Penales direccionArqueroFueraDeRango! !


!Penales methodsFor: 'area del arco' stamp: 'HAW 15/Sep/2026, 5:09:01 pm (UTC)'!
coordenadasDentroDelArco: unasCoordenadas

	^ unasCoordenadas between: 0@0 and: 2@2! !

!Penales methodsFor: 'area del arco' stamp: 'HAW 14/Sep/2026, 5:35:19 pm (UTC)'!
tiroAlAngunlo: coordenadaDeRemate 
	
	| areaDelArco |
	areaDelArco := Rectangle origin: 0@0 corner: 2@2.
	^ areaDelArco corners includes: coordenadaDeRemate .! !


!Penales methodsFor: 'VAR' stamp: 'HAW 15/Sep/2026, 4:30:44 pm (UTC)'!
decidirRemateEnDireccion: coordenadaDeRemate conFuerza: fuerzaAColocar atajandoConFuerza: fuerzaAtajada
	
	| coordenadasIguales fuerzaDelArqueroSuficiente |
	
	varDireccionRemate := coordenadaDeRemate .
	varFuerzaResultanteDeTiro := fuerzaAColocar .
	varFuerzaResultanteDeAtajada := fuerzaAtajada.

	coordenadasIguales := arqueroEnCoordenadasCorrectas value: coordenadaDeRemate value: varDireccionDeAtajada.
	fuerzaDelArqueroSuficiente := arqueroConFuerzaSuficiente value: fuerzaAColocar value: fuerzaAtajada.

	(self coordenadasDentroDelArco: coordenadaDeRemate )
		ifFalse: [ ^ self puntoParaArquero ].

	(coordenadasIguales and: [ fuerzaDelArqueroSuficiente ])
		ifTrue: [ self puntoParaArquero ]
		ifFalse: [ self puntoParaDelantero ].
	! !

!Penales methodsFor: 'VAR' stamp: 'HAW 14/Sep/2026, 4:21:34 pm (UTC)'!
puntoParaArquero
	puntajeArquero := puntajeArquero  + 1.! !

!Penales methodsFor: 'VAR' stamp: 'HAW 14/Sep/2026, 4:20:20 pm (UTC)'!
puntoParaDelantero
	
	puntajeDelantero := puntajeDelantero + 1.! !

!Penales methodsFor: 'VAR' stamp: 'HAW 15/Sep/2026, 11:51:44 pm (UTC)'!
registrarValoresDelVARPreviosAlRemateConDireccion: coordenadaDeRemate yArqueroLanzandoseA: coordenadaDeAtajada

	varDireccionRemate := coordenadaDeRemate .
	varDireccionDeAtajada := coordenadaDeAtajada .
! !

!Penales methodsFor: 'VAR' stamp: 'HAW 14/Sep/2026, 4:21:05 pm (UTC)'!
varDireccionRemateResultante
	
	^ varDireccionRemate .! !

!Penales methodsFor: 'VAR' stamp: 'HAW 14/Sep/2026, 5:05:49 pm (UTC)'!
varFuerzaResultanteDeAtajada

	^ varFuerzaResultanteDeAtajada ! !

!Penales methodsFor: 'VAR' stamp: 'HAW 14/Sep/2026, 4:21:51 pm (UTC)'!
varFuerzaResultanteDeTiro

	^varFuerzaResultanteDeTiro! !


!Penales methodsFor: 'testing' stamp: 'HAW 14/Sep/2026, 3:44:52 pm (UTC)'!
puntajeDeArquero
	
	^puntajeArquero .! !

!Penales methodsFor: 'testing' stamp: 'HAW 14/Sep/2026, 3:44:43 pm (UTC)'!
puntajeDeDelantero
	
	^puntajeDelantero ! !


!Penales methodsFor: 'reglas' stamp: 'HAW 15/Sep/2026, 4:45:52 pm (UTC)'!
arqueroConFuerzaSuficiente: unBloqueDeComparacion 
	
	arqueroConFuerzaSuficiente := unBloqueDeComparacion! !

!Penales methodsFor: 'reglas' stamp: 'HAW 15/Sep/2026, 7:50:51 pm (UTC)'!
arqueroEnCoordenadasCorrectas: unBloqueDeComparacion 
	
	arqueroEnCoordenadasCorrectas := unBloqueDeComparacion! !

!Penales methodsFor: 'reglas' stamp: 'HAW 15/Sep/2026, 3:58:05 pm (UTC)'!
establecerReglasBasicasDePenales

	arqueroConFuerzaSuficiente := [:fuerzaRemate :fuerzaAtajada | fuerzaAtajada >= fuerzaRemate].
	arqueroEnCoordenadasCorrectas := [:coordRemate :coordAtajada | coordRemate = coordAtajada]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: #'penales-exercise-solucion-sinIfs-2'!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'message errors' stamp: 'NR 19/Sep/2023, 9:12:49 am (UTC)'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 19/Sep/2023, 9:12:32 am (UTC)'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !


!Penales class methodsFor: 'instance creation' stamp: 'HAW 14/Sep/2026, 3:35:13 pm (UTC)'!
conDelantero: delantero yArquero: arquero 

	^self new initializeConDelantero: delantero yArquero: arquero ! !
