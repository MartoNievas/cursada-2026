# Cultures of Programming: The Development of Programming Concepts and Methodologies

Este documento presenta un resumen exhaustivo y estructurado del **Prefacio** y de la **Introducción (Capítulo 1)** del libro *Cultures of Programming*, utilizando una terminología técnica precisa y conservando los términos clave en inglés que son estándares en la industria del software.

---

## PARTE 1: RESUMEN DEL PREFACE

El Prefacio establece el marco conceptual y motivacional del libro, introduciendo el concepto de **culturas de la programación** (*cultures of programming*) como una herramienta para comprender la evolución técnica, social y filosófica de la disciplina.

### 1. El Origen: Desacuerdo Técnico en Oslo (2014)
* **La Anécdota Motivadora:** El autor relata un debate presenciado en la conferencia NDC Oslo (2014) entre dos programadores expertos: un defensor de **Erlang** y un defensor de **Haskell**. Su conversación evidenció una total falta de entendimiento mutuo debido a que operaban bajo premisas completamente distintas:
  * El defensor de Erlang sostenía que un esquema robusto de *error recovery* (recuperación de errores) y el reinicio de procesos garantizan la confiabilidad del software.
  * El defensor de Haskell argumentaba que los *type systems* (sistemas de tipos) matemáticos permiten eliminar los errores de programación antes de la ejecución.
* **La Lección:** Ambos analizaban el mismo problema técnico, pero desde perspectivas conceptuales incompatibles, lo que les impedía llegar a un terreno común.

### 2. Estabilidad de las Culturas de la Programación
* **Definición de "Cultura":** El autor utiliza el término "cultura" de forma figurada para describir un conjunto de creencias, premisas, valores y prácticas que determinan cómo se piensa, enseña y evalúa la programación.
* **Orígenes Históricos:** Estas culturas surgieron en la década de 1950 a partir de las disciplinas individuales que convergieron en la programación incipiente: la lógica, las matemáticas, la ingeniería eléctrica, los negocios, la psicología y la investigación militar.
* **Pluralismo de la Disciplina:** A diferencia de otras ciencias que maduran hacia un paradigma unificado, la programación ha mantenido estas culturas estables a lo largo de sus 70 años de historia, lo que demuestra que es una disciplina inherentemente pluralista.

### 3. Las Cinco Culturas de la Programación y sus Representantes
Para ilustrar las interacciones y choques entre culturas en cada capítulo, el autor utiliza diálogos de ficción estructurados alrededor de un profesor y cinco estudiantes, cuyos nombres sirven como regla mnemotécnica basada en filósofos griegos antiguos:
1. **Pitágoras (Cultura Matemática):** Ve los programas como entidades lógicas y formales; cree que la corrección del software se debe demostrar mediante pruebas formales (*formal verification*), y que todo principio informático es, en última instancia, matemático.
2. **Diógenes (Cultura Hacker):** Valora la acción directa sobre la máquina (*hands-on*), el acceso libre a la información, el juego creativo y el conocimiento del *hardware* (*bits and bytes*) sobre las teorías abstractas o burocracias organizacionales.
3. **Jenofonte (Cultura de Gestión / *Managerial*):** Se enfoca en la programación como un proceso de producción de negocio a gran escala; prioriza la planificación estructurada, la especificación estricta de requisitos, el control administrativo y la división del trabajo para mitigar la dependencia de programadores individuales.
4. **Arquímedes (Cultura de Ingeniería / *Engineering*):** Aborda el desarrollo mediante técnicas prácticas y pragmáticas (como *testing* y automatización); acepta la falibilidad humana y busca mitigarla mediante herramientas robustas y metodologías de desarrollo iterativas.
5. **Sócrates (Cultura Humanística):** Concibe la programación como un medio de alfabetización (*literacy*), autoexpresión y herramienta para expandir el pensamiento humano; se preocupa profundamente por los impactos éticos, políticos y sociales de la tecnología.

### 4. La Dualidad Socio-Técnica
El libro busca un balance entre la historia técnica de la programación y su historia social y política. Temas como la *software engineering* están íntimamente ligados a las luchas por el control administrativo y de género; la interactividad del software se vincula a la contracultura de los 60 y al movimiento del *free software* (software libre).

---

## PARTE 2: RESUMEN DE LA INTRODUCCIÓN (CAPÍTULO 1)

La Introducción profundiza en las interacciones concretas de estas culturas a través de un diálogo de debate y el análisis detallado de fallos históricos, conceptos compartidos y debates contemporáneos.

### 1. El Diálogo Inicial: ¿Qué es la Programación y cuáles son sus Logros?
* **Definición de Programación:**
  * Para **Jenofonte (*Managerial*)**, es un proceso ordenado para construir sistemas de software que solucionen problemas de negocio.
  * Para **Sócrates (Humanística)**, es una herramienta de comprensión del mundo y una forma de alfabetización que enseña a pensar.
  * Para **Pitágoras (Matemática)**, es matemática aplicada; un proceso de construir entidades formales en lenguajes lógicos.
  * Para **Diógenes (*Hacker*)**, es hacer que la máquina real ejecute lo que uno quiere mediante la manipulación práctica de *bits*.
* **Logros Paradigmáticos en Disputa:**
  * **Arquímedes (Ingeniería)** celebra que los grandes sistemas a nuestro alrededor funcionen de forma confiable, destacando el movimiento *Agile* como un gran avance que acerca a desarrolladores y gente de negocios.
  * **Sócrates** critica a *Agile* por subordinar la programación a intereses comerciales y funcionar como un mecanismo de control administrativo. Señala la falta de diversidad al notar que los 17 creadores del Manifiesto Agile son hombres.
  * **Jenofonte** destaca el software de guía del **Apollo** (liderado por Margaret Hamilton) como un éxito de especificación de requerimientos rigurosos y pruebas exhaustivas.
  * **Pitágoras** argumenta que incluso el Apollo tenía *bugs* (los cuales la tripulación tuvo que evadir manualmente). Él propone la **verificación formal** (*formal verification*), citando el microkernel **sel4** como un software provisto de pruebas matemáticas de corrección. Su logro paradigmático es el lenguaje **Algol**, por introducir la idea del programa como entidad matemática analizable.
  * **Diógenes** prefiere **UNIX** y el lenguaje **C** debido a su principio de dar acceso total al *hardware* y la libre comunicación con el sistema.
  * **Sócrates** prefiere usos más artísticos y educativos de la programación, como el sistema gráfico **Sketchpad**, el lenguaje **Logo**, o el *live coding* musical en eventos **Algorave** usando herramientas como **Sonic Pi**.

* **El Debate sobre el Sesgo Algorítmico (Amazon AI Recruitment Tool):**
  * Ante la revelación de que el software secreto de reclutamiento de Amazon discriminaba sistemáticamente los currículums de mujeres, las culturas difieren en su diagnóstico:
    * **Pitágoras** insiste en que el algoritmo en sí es neutro y matemático, atribuyendo el fallo únicamente a un problema de datos de entrenamiento sesgados.
    * **Sócrates** sostiene que el sesgo humano puede entrar en cualquier etapa (diseño, construcción u operación) porque la programación es una actividad humana intrínsecamente socio-política.
    * **Diógenes** señala que configurar una red neuronal requiere decisiones prácticas (capas, funciones de propagación, hiperparámetros) que dependen del conocimiento tácito humano y pueden introducir sesgos.
    * **Arquímedes** propone soluciones técnicas basadas en ingeniería, como algoritmos de *counterfactual fairness* (equidad contrafáctica) para garantizar decisiones neutras.
    * **Jenofonte** exige estándares industriales y regulaciones gubernamentales (como el derecho a la explicación del GDPR de la UE) que las empresas puedan seguir formalmente.

### 2. El Bug de los 440 Millones de Dólares (Knight Capital)
* **El Suceso (1 de agosto de 2012):** Al desplegar una nueva versión del sistema de enrutamiento SMARS para acceder al *Retail Liquidity Program* (RLP), Knight Capital reutilizó una bandera (*flag*) técnica que previamente activaba una función obsoleta llamada "Power Peg". El despliegue falló en uno de los ocho servidores, el cual continuó ejecutando el código antiguo con el nuevo *flag* activado. Debido a la falta de validación del número de órdenes hijas generadas, este único servidor comenzó a enviar millones de órdenes no deseadas al mercado. Los técnicos de la firma entraron en pánico, revirtieron la versión del software en los otros siete servidores (lo que empeoró el problema al activar el código "Power Peg" en todos ellos), y para cuando desconectaron el sistema, la firma había acumulado pérdidas por 440 millones de dólares en 45 minutos.
* **Perspectivas Culturales de Prevención:**
  1. **Perspectiva Matemática:** Propone la formalización del emparejamiento de órdenes financieras y la verificación formal tanto del código como del despliegue (*deployment*). Considera los sistemas financieros como el *killer app* de los métodos formales.
  2. **Perspectiva de Ingeniería (DevOps / Agile):** Atribuye el error a la falta de automatización del despliegue y a la presencia de *dead code* (código muerto como el de "Power Peg"). Aboga por despliegues repetibles y automatizados, herramientas de control de configuración y pruebas automáticas continuas.
  3. **Perspectiva de Gestión (*Managerial*):** Se enfoca en las auditorías de procesos y controles de supervisión de riesgos. Destaca la imposición de regulaciones institucionales (como la Regla 15c3-5 de la SEC) que exigen controles de gestión y certificaciones anuales por parte de los ejecutivos de la empresa para mitigar riesgos en accesos directos al mercado.
  4. **Otras Culturas:** Los *hackers* cuestionarían por qué el despliegue lo realizó otra área y por qué los programadores tardaron tanto en comprender la situación. Los humanistas cuestionarían la utilidad social de implementar sistemas de *automated trading* de alta velocidad sin interacción humana.

### 3. Las Cinco Culturas de Programación Analizadas Individualmente

#### A. La Cultura Matemática (*Program as a Mathematical Entity*)
* **Premisa:** Concibe el programa como un objeto matemático riguroso cuyas propiedades de corrección se pueden demostrar formalmente mediante lógica deductiva.
* **Desarrollo Histórico:** Al inicio, la programación era física (conectar cables en la ENIAC). El paso al software requirió la invención de fórmulas simbólicas (como FORTRAN) y la búsqueda de legitimidad académica para las ciencias de la computación en las universidades de la década de 1950.
* **Ejemplo Paradigmático: Algol.** Diseñado por un comité de la ACM a fines de los 50, fue especificado formalmente y de forma independiente de cualquier *hardware*. Aunque fracasó a nivel comercial, su sintaxis matemática (soportada por variantes de lenguajes de publicación para revistas académicas) inspiró décadas de teoría sobre tipos e ingeniería de lenguajes de programación.
* **Desafíos:** La verificación formal enfrenta problemas de escala (el código real es inmenso frente a proposiciones lógicas simples), la dificultad de capturar con precisión lo que es un comportamiento "correcto", y el hecho de que el software causa efectos físicos en máquinas reales que no siempre se pueden abstraer de forma matemática perfecta.

#### B. La Cultura Hacker (*The Hands-on Imperative*)
* **Premisa:** Prioriza el acceso directo, físico e interactivo con el ordenador y el dominio del funcionamiento a bajo nivel de la máquina.
* **Desarrollo Histórico:** Surgió en el MIT a principios de la década de 1960 gracias al acceso liberal y directo a ordenadores como el **TX-0** y el **PDP-1**, que permitían ejecutar instrucciones de manera inmediata. Muchos de sus pioneros provenían del club de modelismo de trenes de MIT (*Tech Model Railroad Club*, TMRC).
* **La Ética Hacker:** Valora la habilidad técnica e individual sobre títulos académicos, promueve el libre intercambio de información, defiende que el conocimiento técnico debe descentralizarse y cree que el ordenador puede usarse para el juego y la creatividad (ej. el videojuego *Spacewar!*).
* **Ejemplo Paradigmático: UNIX y el Lenguaje C.** Creados en los laboratorios Bell Labs a fines de los 60, UNIX y C proporcionaban acceso eficiente al *hardware* y flexibilidad total de comunicación de bajo nivel. Fueron diseñados por *hackers* para otros *hackers* y distribuidos libremente en sus inicios, lo que más tarde inspiró el nacimiento del movimiento del software libre (GNU) cuando AT&T comercializó UNIX en los 80.

#### C. La Cultura de Gestión (*Managerial Culture*)
* **Premisa:** Ve la programación como una actividad industrial o de manufactura masiva. Prioriza la predictibilidad, la especificación, la reducción de costes y la minimización de la dependencia en la genialidad individual mediante procesos rígidos.
* **Desarrollo Histórico:** Nació en el ámbito militar y corporativo ante la complejidad inesperada de los sistemas en los 50.
* **Ejemplo Paradigmático: El Sistema SAGE.** SAGE fue un proyecto masivo de defensa aérea estadounidense de fines de los 50 que utilizó el ordenador Whirlwind del MIT. Ante la falta de programadores entrenados, requirió la creación de la corporación SDC para entrenar a más de 7,000 personas bajo metodologías de desarrollo estructurado. Redefinió al programador no como un artista creativo, sino como un obrero intercambiable de fábrica que implementa especificaciones de código preestablecidas en distintas fases secuenciales.
* **La Gestión del Programa Apollo:** El software del Apollo en el MIT requirió una estricta gestión de configuración (como el *Software Configuration Control Board* de la NASA) donde no se podía cambiar un solo *bit* de código sin aprobación oficial previa.

#### D. La Cultura de Ingeniería (*A Proper Engineering Discipline*)
* **Premisa:** Aborda la creación de software como una verdadera disciplina de ingeniería que aplica principios científicos y empíricos para resolver problemas prácticos. Reconoce que los humanos cometen errores y desarrolla técnicas de diseño de código, automatización y herramientas de validación para mitigar su frecuencia e impacto.
* **Desarrollo Histórico:** Se popularizó a partir de la **Conferencia de la OTAN sobre Software Engineering en 1968**, la cual declaró formalmente la necesidad de transformar el "arte oscuro de la programación" en una ciencia de ingeniería estructurada.
* **Ejemplos de Productos Técnicos:**
  1. **Estilos de Programación (Programación Estructurada):** Dijkstra popularizó en 1968 la eliminación de saltos incondicionales (*GOTO*) en favor de bucles e instrucciones condicionales, facilitando que el código "quepa en la cabeza" de los programadores.
  2. **Metodologías de Proceso Ligero (*Extreme Programming* y *Agile*):** XP (fines de los 90) introdujo prácticas centradas en el código, tales como el *pair programming* (programación en pareja) y el *Test-Driven Development* (TDD), donde se escribe una prueba fallida antes de implementar la funcionalidad.
  3. **Evolución del Testing:** Las pruebas pasaron de ser una fase administrativa de validación de especificaciones (antes de 1979) a convertirse en una herramienta de descubrimiento de errores orientada al programador, y finalmente en la fuerza de diseño central de TDD. El Manifiesto Agile de 2001 consolidó estas metodologías ligeras sobre los pesados procesos de gestión secuencial (*waterfall*).

#### E. La Cultura Humanística (*New Media for Thinking*)
* **Premisa:** Considera el ordenador y la programación no como una utilidad industrial o un cálculo lógico, sino como un medio dinámico de autoexpresión, educación y alfabetización que expande el intelecto humano.
* **Desarrollo Histórico:** Sus raíces se remontan al influyente ensayo de Vannevar Bush **"As We May Think" (1945)**, que describía el *memex* como una máquina mecánica para asistir en la organización y ampliación del pensamiento asociativo humano.
* **Pioneros e Hitos Técnicos:**
  * **Sketchpad (Ivan Sutherland, 1963):** El primer software con interfaz gráfica de usuario e interacción directa con lápiz óptico, diseñado para hacer los ordenadores más accesibles utilizando el dibujo como medio de comunicación.
  * **Logo (años 60):** Diseñado no para enseñar programación propiamente dicha, sino para que los niños experimentaran "ideas potentes" y pensamiento matemático mediante el control de una "tortuga" gráfica y física.
  * **Smalltalk (Alan Kay y Adele Goldberg, años 70):** Concebido en Xerox PARC como un prototipo de medio dinámico personal de la dimensión de un libro de notas (*notebook*), donde programar se definía como "comunicarse con el sistema".
  * **Sonic Pi y Arte Generativo:** Evolución del uso interactivo del software como instrumento musical artístico, desde bandas pioneras de microordenadores en los 80 como *The Hub* hasta las comunidades contemporáneas de *live coding* en eventos *Algorave*.
* **Impacto Social:** Es la cultura más inclusiva con respecto al reconocimiento de la contribución histórica de mujeres pioneras (como Cynthia Solomon, Radia Perlman, Adele Goldberg o Diana Merry-Shapiro).

---

## PARTE 3: ANÁLISIS DE LOS DEBATES CONTEMPORÁNEOS

El pluralismo de estas culturas se mantiene vigente y explica los desacuerdos actuales en la industria sobre tres pilares fundamentales:

| Tema / Debate | Cultura Matemática | Cultura de Ingeniería | Cultura de Gestión (*Managerial*) | Cultura Hacker | Cultura Humanística |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Definición de Software Sin Errores** | Correspondencia lógica formal entre el código y una especificación abstracta matemática. | Satisfacción de las necesidades reales descubiertas de forma empírica y ágil mediante testing preventivo. | Conformidad rigurosa del sistema con un documento de especificaciones preacordado con el cliente. | Capacidad del programador para corregir fallos directamente; tolera el *bug* si el sistema da control directo. | Evaluación socio-política de los efectos del software; un programa "correcto" es el que empodera de forma justa a la sociedad. |
| **Comprensión y Explicabilidad** | Delegación en pruebas matemáticas que certifiquen el comportamiento formal del sistema. | Pruebas de detección sistemática y automatización de validaciones de sesgo (*counterfactual fairness*). | Adopción de marcos normativos, estándares y regulaciones gubernamentales (derecho a la explicación del GDPR). | Diseño simple de código que "quepa en un solo cerebro" y la libertad para estudiar y modificar el código fuente. | Concientización mediante el arte creativo sobre los sesgos, y proyectos de educación diversa para evitar la alienación. |
| **Educación ideal en Programación** | Carreras de ciencias de la computación formales centradas en algoritmos lógicos, lenguajes formales y matemáticas abstractas. | *Coding bootcamps* e instrucción enfocada en herramientas y metodologías de desarrollo que evolucionan rápido. | Programas curriculares amplios orientados a sistemas de información, gestión empresarial y teoría de operaciones. | Autoaprendizaje, análisis de código abierto y experimentación directa asistida por mentores experimentados. | Currículos de artes liberales que integren ciencias sociales, filosofía y humanidades junto al uso del software como medio creativo. |

---

## CONCLUSIÓN: LA INTERACCIÓN COMO MOTOR DE INNOVACIÓN

El principal argumento del libro es que los avances más notables de la informática no ocurren dentro de una sola cultura aislada, sino cuando dos o más de estas culturas de la programación interactúan:
* **La idea misma del Lenguaje de Programación** surgió como un objeto matemático formal para los teóricos, una herramienta de eficiencia técnica para los *hackers* y un medio de independencia corporativa del hardware para los gestores.
* **Los Sistemas de Tipos (*Type Systems*)** se consolidaron como un terreno común donde confluyeron las necesidades de rendimiento de la cultura *hacker*, el rigor lógico de la cultura matemática y la confiabilidad práctica de la cultura de ingeniería.
* **La Programación Orientada a Objetos** nació inicialmente a partir de visiones de las culturas matemática y humanística, pero evolucionó como el paradigma dominante gracias al enfoque de diseño modular de la ingeniería y fue finalmente adaptado por la cultura de gestión para organizar equipos de trabajo.

Aunque estas culturas a menudo chocan en disputas sobre la naturaleza de la programación o el significado de la corrección de un sistema, es precisamente este pluralismo el que dota a la disciplina de estabilidad, permitiéndole contar con múltiples perspectivas listas para enfrentar nuevos retos socio-técnicos en el futuro.
