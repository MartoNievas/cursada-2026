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
	instanceVariableNames: 'fuerzaDeAtajada estrategiaAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Arquero methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:48:22 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales

	estrategiaAtajada intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:48:22 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro  enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales .
	! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:48:22 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion:  coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales! !

!Arquero methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:48:22 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate jugando: unosPenales 
	
	estrategiaAtajada intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales .! !


!Arquero methodsFor: 'initialization' stamp: 'HAW 16/Sep/2026, 12:48:22 pm (UTC)'!
initializeConFuerza: unNivelDeFuerza atajandoA: unaEstrategiaDeAtajada 

	fuerzaDeAtajada := unNivelDeFuerza.
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
	instanceVariableNames: 'fuerzaDeTiro estrategiaTiro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!Delantero methodsFor: 'initialize' stamp: 'HAW 16/Sep/2026, 12:48:33 pm (UTC)'!
initializeConFuerzaBase: unNivelDeFuerza tirando: unaEstrategiaDeTiro 

	fuerzaDeTiro := unNivelDeFuerza.
	estrategiaTiro := unaEstrategiaDeTiro para: self.! !


!Delantero methodsFor: 'remate' stamp: 'HAW 16/Sep/2026, 12:48:33 pm (UTC)'!
patea: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales

	estrategiaTiro rematar: unaPelota conDireccion: coordenadaDeRemate yFuerza: fuerzaDeTiro aArquero: arquero jugando: unosPenales .! !

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


!EstrategiaAtajada methodsFor: 'reglas' stamp: 'HAW 16/Sep/2026, 1:16:31 pm (UTC)'!
arqueroIgnoraAlturaParaAtajar

	^ [:coordRemate :coordAtajada | coordRemate x = coordAtajada x]! !

!EstrategiaAtajada methodsFor: 'reglas' stamp: 'HAW 16/Sep/2026, 1:21:19 pm (UTC)'!
arqueroIgnoraAnchoParaAtajar

	^ [:coordRemate :coordAtajada | coordRemate y = coordAtajada y]! !


!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:51:34 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales

	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:50:50 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro  enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales

	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:51:43 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion:  coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales

	self subclassResponsibility .! !

!EstrategiaAtajada methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 12:51:59 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales

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

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:44:16 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales 

	| nuevaFuerzaDeAtajada |
	nuevaFuerzaDeAtajada := fuerzaDeAtajada * 1.5.
	unosPenales direccionDeRememateResultante: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: nuevaFuerzaDeAtajada .! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:06 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro  enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales 

	|trayectoriaDeTiro coordenadasCorrectasDeArquero |
	trayectoriaDeTiro := coordenadaDeRemate .
	(unosPenales tiroAlAngunlo: coordenadaDeRemate ) ifTrue: [
			trayectoriaDeTiro := coordenadaDeRemate x @ 1.
		] .
	
	coordenadasCorrectasDeArquero := self arqueroIgnoraAlturaParaAtajar.
	
	unosPenales direccionDeRemateResultante: trayectoriaDeTiro resolverCoordenadasCorrectasDeArqueroCon:  coordenadasCorrectasDeArquero conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada
	
	! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:48:49 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion:  coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales 

	"Se redujo la fuerza del remta en un 20%"
	"La fuerza del arquero aumenta en un 100% "
	| nuevaFuerzaDeAtajada |
	nuevaFuerzaDeAtajada := fuerzaDeAtajada * 2.
	
	unosPenales direccionDeRememateResultante: coordenadaDeRemate conFuerza: unaFuerzaTiro  atajandoConFuerza: nuevaFuerzaDeAtajada .! !

!EligeDireccionAntes methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:06 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales 

	| arqueroEnCoordenadasCorrectas |
	arqueroEnCoordenadasCorrectas :=  self arqueroIgnoraAnchoParaAtajar.
	
	unosPenales direccionDeRemateResultante: coordenadaDeRemate resolverCoordenadasCorrectasDeArqueroCon: arqueroEnCoordenadasCorrectas  conFuerzaTiro: unaFuerzaTiro atajandoConFuerza: fuerzaDeAtajada .	! !


!classDefinition: #EsperaPorTiroYSeAdelanta category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaAtajada subclass: #EsperaPorTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:06 pm (UTC)'!
intentaAtajarJabulaniAColocarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales 

	"remate a colocar con jabulani reduce fuerza del remate en 50%"
	"atajada a coloar con jabulani esperando por tiro y adelantandose arquero ignora altura"
	| arqueroEnCoordenadasCorrectas |
	arqueroEnCoordenadasCorrectas := self arqueroIgnoraAlturaParaAtajar .
	
	unosPenales direccionDeRemateResultante: coordenadaDeRemate resolverCoordenadasCorrectasDeArqueroCon: arqueroEnCoordenadasCorrectas  conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada .! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:27 pm (UTC)'!
intentaAtajarJabulaniAMatarConFuerza: unaFuerzaTiro  enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales 

		| arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas |
	arqueroConFuerzaSuficiente :=  self arqueroNuncaTieneFuerzaSuficiente.
	arqueroEnCoordenadasCorrectas :=  self arqueroSiempreEnCoordenadasCorrectas.

	unosPenales direccionDeRemateResultante: coordenadaDeRemate resolverCoordenadasCorrectasDeArqueroCon: arqueroEnCoordenadasCorrectas conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada  resolviendoFuerzaSuficienteCon: arqueroConFuerzaSuficiente .! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:27 pm (UTC)'!
intentaAtajarPlayeraAColocarConFuerza: unaFuerzaTiro enDireccion:  coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada jugando: unosPenales 

	| arqueroEnCoordenadasCorrectas arqueroConFuerzaSuficiente |
	arqueroEnCoordenadasCorrectas :=  self arqueroSiempreEnCoordenadasCorrectas.
	arqueroConFuerzaSuficiente :=  self arqueroNuncaTieneFuerzaSuficiente.
	
	unosPenales direccionDeRemateResultante: coordenadaDeRemate  resolverCoordenadasCorrectasDeArqueroCon:  arqueroEnCoordenadasCorrectas conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada resolviendoFuerzaSuficienteCon: arqueroConFuerzaSuficiente .! !

!EsperaPorTiroYSeAdelanta methodsFor: 'atajar' stamp: 'HAW 16/Sep/2026, 1:41:27 pm (UTC)'!
intentaAtajarPlayeraAMatarConFuerza: unaFuerzaTiro enDireccion: coordenadaDeRemate conFuerzaAtajada: fuerzaDeAtajada  jugando: unosPenales 

	| arqueroEnCoordenadasCorrectas arqueroConFuerzaSuficiente |
	arqueroEnCoordenadasCorrectas := self arqueroSiempreEnCoordenadasCorrectas .
	arqueroConFuerzaSuficiente := self arqueroSiempreConFuerzaSuficiente.
	
	unosPenales direccionDeRemateResultante: coordenadaDeRemate resolverCoordenadasCorrectasDeArqueroCon: arqueroEnCoordenadasCorrectas conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada  resolviendoFuerzaSuficienteCon: arqueroConFuerzaSuficiente .! !


!EsperaPorTiroYSeAdelanta methodsFor: 'reglas' stamp: 'HAW 16/Sep/2026, 1:22:58 pm (UTC)'!
arqueroNuncaTieneFuerzaSuficiente

	^ [:fuerzaRemate :fuerzaAtajada | false]! !

!EsperaPorTiroYSeAdelanta methodsFor: 'reglas' stamp: 'HAW 16/Sep/2026, 1:38:53 pm (UTC)'!
arqueroSiempreConFuerzaSuficiente
	
	^ [:fuerzaRemta :fuerzaAtajada | true].! !

!EsperaPorTiroYSeAdelanta methodsFor: 'reglas' stamp: 'HAW 16/Sep/2026, 1:23:20 pm (UTC)'!
arqueroSiempreEnCoordenadasCorrectas

	^ [:coordRemate :coordAtajada | true]! !


!classDefinition: #EstrategiaTiro category: #'penales-exercise-solucion-sinIfs-2'!
Object subclass: #EstrategiaTiro
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!EstrategiaTiro methodsFor: 'initialization' stamp: 'HAW 15/Sep/2026, 4:28:24 pm (UTC)'!
initializePara: unDelantero

	delantero := unDelantero .! !


!EstrategiaTiro methodsFor: 'remate' stamp: 'HAW 16/Sep/2026, 12:42:59 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate yFuerza: fuerzaBase aArquero: arquero jugando: unosPenales 

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

!AColocar methodsFor: 'remate' stamp: 'HAW 16/Sep/2026, 12:43:50 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate yFuerza: fuerzaBase aArquero: arquero jugando: unosPenales

	| nuevaFuerzaTiro |
	nuevaFuerzaTiro := fuerzaBase *0.5.
	unaPelota siendoPateadaAColocarConFuerza: nuevaFuerzaTiro enDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales .! !


!classDefinition: #AMatar category: #'penales-exercise-solucion-sinIfs-2'!
EstrategiaTiro subclass: #AMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'penales-exercise-solucion-sinIfs-2'!

!AMatar methodsFor: 'remate' stamp: 'HAW 16/Sep/2026, 12:44:36 pm (UTC)'!
rematar: unaPelota conDireccion: coordenadaDeRemate yFuerza: fuerzaBase aArquero: arquero jugando: unosPenales
	"Usa el 100% de la fuerza"
	unaPelota siendoPateadaAMatarConFuerza: fuerzaBase enDireccion: coordenadaDeRemate aArquero: arquero jugando: unosPenales .! !


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

!Penales methodsFor: 'penales juego' stamp: 'HAW 16/Sep/2026, 1:56:23 pm (UTC)'!
arbitroPitaConPelota: unaPelota delanteroRemataAlArcoConDireccion: coordenadaDeRemate arqueroSeLanzaEnDirección: coordenadaDeAtajada
		self registrarValoresDelVARPreviosAlRemateConDireccion: coordenadaDeRemate yArqueroLanzandoseA: coordenadaDeAtajada .

	    self establecerReglasBasicasDePenales.

	    self assertVerficar: coordenadaDeRemate y: coordenadaDeAtajada.
	
	delantero patea: unaPelota conDireccion: coordenadaDeRemate aArquero: arquero jugando: self.
	
	self varDecideResultadoLuegoDePatear .! !

!Penales methodsFor: 'penales juego' stamp: 'HAW 16/Sep/2026, 1:56:14 pm (UTC)'!
varDecideResultadoLuegoDePatear

	| coordenadasIguales fuerzaDelArqueroSuficiente |
	coordenadasIguales := arqueroEnCoordenadasCorrectas value: varDireccionRemate value: varDireccionDeAtajada.
	fuerzaDelArqueroSuficiente := arqueroConFuerzaSuficiente value: varFuerzaResultanteDeTiro value: varFuerzaResultanteDeAtajada .
	
	(self coordenadasDentroDelArco: varDireccionRemate )
		ifFalse: [ ^ self puntoParaArquero ].

	(coordenadasIguales and: [ fuerzaDelArqueroSuficiente ])
		ifTrue: [ self puntoParaArquero ]
		ifFalse: [ self puntoParaDelantero ]! !


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


!Penales methodsFor: 'VAR' stamp: 'HAW 16/Sep/2026, 1:48:16 pm (UTC)'!
direccionDeRemateResultante: trayectoriaDeTiro resolverCoordenadasCorrectasDeArqueroCon: coordenadasCorrectasDeArquero conFuerzaTiro: unaFuerzaTiro atajandoConFuerza: fuerzaDeAtajada 
	
	varDireccionRemate := trayectoriaDeTiro .
	varFuerzaResultanteDeTiro := unaFuerzaTiro .
	varFuerzaResultanteDeAtajada := fuerzaDeAtajada .
	
	arqueroEnCoordenadasCorrectas := coordenadasCorrectasDeArquero .

	
	
	! !

!Penales methodsFor: 'VAR' stamp: 'HAW 16/Sep/2026, 1:43:26 pm (UTC)'!
direccionDeRemateResultante: trayectoriaDeTiro  resolverCoordenadasCorrectasDeArqueroCon:  coordenadasCorrectasDeArquero conFuerzaTiro: unaFuerzaTiro  atajandoConFuerza: fuerzaDeAtajada resolviendoFuerzaSuficienteCon: fuerzaSuficienteDeArquero

	varDireccionRemate := trayectoriaDeTiro .
	varFuerzaResultanteDeTiro := unaFuerzaTiro .
	varFuerzaResultanteDeAtajada := fuerzaDeAtajada .
	
	arqueroEnCoordenadasCorrectas := coordenadasCorrectasDeArquero .
	arqueroConFuerzaSuficiente := fuerzaSuficienteDeArquero .! !

!Penales methodsFor: 'VAR' stamp: 'HAW 16/Sep/2026, 1:45:15 pm (UTC)'!
direccionDeRememateResultante: coordenadaDeRemate conFuerza: unaFuerzaTiro atajandoConFuerza: nuevaFuerzaDeAtajada 
	
	varDireccionRemate := coordenadaDeRemate .
	varFuerzaResultanteDeTiro := unaFuerzaTiro .
	varFuerzaResultanteDeAtajada := nuevaFuerzaDeAtajada .! !

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
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 61 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 62 53 56 53 60 52 104 121 106 111 56 52 57 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 63 65 59 64 65 59 57 39 74 118 116 119 112 115 108 121 65 39 56 56 53 59 53 55 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 121 118 118 123 71 59 56 106 104 104 107 56 104 59 62 56 59 65 54 126 118 121 114 17 199 175 8 20 17 56 64 57 53 56 61 63 53 56 53 56 58 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 104 121 106 111 115 112 117 124 127 52 107 108 122 114 123 118 119 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 55 57 65 56 59 53 64 60 63 63 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 61 63 63 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 56 65 60 56 65 56 59 53 60 59 63 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 64 58 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 58 59 65 56 60 53 60 57 55 57 63 63 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 55 61 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 59 65 56 55 53 59 61 55 62 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 57 91 56 63 65 59 61 65 56 59 53 57 60 58 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 60 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 56 61 65 56 59 53 59 55 60 58 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 61 65 60 61 53 63 61 64 56 64 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 56 65 57 62 65 56 64 53 57 57 59 64 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 60 59 62 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 57 65 60 57 65 57 58 53 60 64 63 57 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 58 64 55 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 59 65 60 59 65 56 61 53 63 55 56 58 55 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 59 61 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 63 65 58 61 53 64 60 64 61 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 112 122 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 56 64 65 60 64 65 56 59 53 58 60 57 60 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 106 118 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 59 91 57 55 65 55 55 65 57 61 53 58 64 57 62 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 60 62 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 56 58 65 57 57 53 58 61 60 64 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 63 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 57 59 65 60 56 53 59 57 63 62 64 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 57 57 62 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 55 65 59 62 65 55 56 53 62 63 55 61 61 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 58 62 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 56 65 55 63 65 59 63 53 57 59 57 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 62 55 64 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 57 65 59 57 65 59 58 53 64 64 59 57 59 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 59 62 62 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 58 65 56 61 65 59 57 53 58 64 60 57 59 64 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 56 60 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 56 56 65 56 57 53 55 58 64 56 60 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 60 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 57 55 65 60 57 53 55 61 55 55 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 55 62 63 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 61 65 55 61 53 62 64 64 61 55 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 58 63 65 57 55 53 58 63 62 61 61 57 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 58 57 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 56 59 65 60 56 65 57 64 53 61 58 63 57 60 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 61 57 60 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 55 64 65 60 60 65 59 64 53 55 64 59 59 60 59 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 61 56 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 59 65 57 56 53 57 64 63 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 57 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 61 91 56 55 65 60 61 65 58 60 53 63 64 63 59 58 62 52 55 58 65 55 55 17 54 111 118 116 108 54 116 104 121 123 112 117 54 75 108 122 114 123 118 119 54 106 124 121 122 104 107 104 52 57 55 57 61 54 112 122 126 54 110 124 112 104 122 54 110 124 112 104 57 54 55 62 52 119 108 117 104 115 108 122 54 119 108 117 104 115 108 122 52 108 127 108 121 106 112 122 108 52 122 118 115 124 106 112 118 117 52 122 112 117 80 109 122 52 57 53 122 123 17 60 63 61 64 58 17 52 52 52 52 52 52 52 52 52 52 17 17))!