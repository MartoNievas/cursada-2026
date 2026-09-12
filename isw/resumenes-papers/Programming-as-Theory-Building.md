# Programming as Theory Building
## Autor: Peter Naur

### Resumen
El concepto central del paper es **la teoría**, la cual hace referencia
al conocimiento intrínseco que un programador adquiere por el mero hecho
de estar relacionado con un programa y trabajar en él de forma continuada.
Este conocimiento no está completamente capturado en la documentación ni
en el código mismo, sino que reside en la mente del programador. Esto
convierte a la documentación en un producto auxiliar o secundario, incapaz
de sustituir el conocimiento real del programador.

> **Aclaración:** Esta es la noción de teoría por parte de **Naur**, quien
> no la nombra explícitamente como "teoría", pero en esencia es eso lo que
> describe.

#### La teoría a ser construida por el programador
Lo que un programador debe construir, en términos de la noción de Ryle,
es una teoría de cómo manejar y representar ciertos aspectos de la
realidad a través de un programa.

Aquí se introduce la **Visión de Construcción de Teoría (VCT)**, cuyo
mayor desafío es demostrar que el conocimiento adquirido por el programador
va más allá de la simple documentación. Para ilustrarlo, Naur identifica
tres áreas donde ese conocimiento es superior a cualquier documento:

1. El programador puede explicar cómo la solución está estrechamente
   relacionada con los problemas del mundo real que busca resolver.
2. El programador conoce la razón de ser de cada parte del programa,
   pudiendo justificar cada decisión con fundamento racional.
3. El programador puede responder constructivamente ante cualquier
   demanda de modificación, evaluando el mejor camino posible.

#### Problemas y costos de la modificación de programas
La razón de ser de la **VCT** es comprender mejor por qué modificar un
programa es tan costoso y complejo. Cuando un programador nuevo intenta
modificar un programa sin haber construido la teoría detrás de él, corre
el riesgo de hacer cambios que sean superficialmente correctos pero
conceptualmente inconsistentes con el diseño original.

Aquí Naur rompe con la idea de que la modificación de un programa es barata
solo porque se trata de "texto editable". Según la **VCT**, el costo real
no está en editar el texto sino en reconstruir la teoría detrás del programa.

Diseñar programas "flexibles" por otro lado no soluciona el problema, ya que
implementar esta flexibilidad conlleva un costo enorme y dependerá de eventos
futuros que a priori son inciertos.

A lo que Naur quiere llegar es que solo el programador con la teoría es capaz
de determinar si un cambio es consistente y conveniente con el diseño original.
Sin esa teoría, los cambios resultan en meros "parches" que degradan la calidad
del software a largo plazo e imposibilitan la creación de una nueva teoría o la
expansión de la ya existente.

#### La vida, muerte y resurrección de un programa
Aquí Naur, mediante la **VCT**, nos da un panorama acerca de cómo es el
ciclo de vida de un programa. Se distinguen 3 etapas:

1. **Vida:** un equipo de desarrolladores que posee su propia teoría trabaja
   activamente en el programa y es el encargado de sus modificaciones.

2. **Muerte:** se da cuando el equipo de programadores que tenía la teoría
   se disuelve. Esto no implica que el programa pierda su utilidad, sino que
   habla sobre el enfoque de desarrollo detrás del mismo. El estado de muerte
   se hace evidente cuando las demandas de modificación no pueden resolverse
   de manera inteligente.

3. **Resurrección:** es la reconstrucción de la teoría por parte de un nuevo
   equipo de programadores.

Naur menciona que la extensión de la etapa de vida depende de cómo la nueva
generación de programadores toma posesión de la teoría, y para ello el nuevo
programador debe tener un contacto estrecho con quienes ya la poseen.

> **Observación:** Según la **VCT**, reconstruir la teoría de un programa
> basándose únicamente en su documentación es imposible. En casos donde no
> exista posibilidad de contacto con los programadores anteriores, la **VCT**
> sugiere descartar el programa y comenzar desde cero.

#### Método y construcción de teoría
Naur analiza la relación entre los métodos de programación y la **VCT**.

El conflicto con la **VCT** es claro: los métodos asumen que programar es
una secuencia ordenada de acciones con resultados documentados, mientras que
la **VCT** sostiene que construir una teoría no puede seguir un orden fijo,
ya que por definición una teoría no tiene una división inherente en partes
ni una secuencia predefinida.

Por lo tanto, según la **VCT**, no puede existir un método único y correcto
para programar.

Naur responde a dos posibles contraargumentos:

1. **"La programación debe seguir el método científico":** Naur refuta esto
   señalando que la noción de un método científico como conjunto fijo de
   instrucciones es en sí misma errónea, según autores como Feyerabend y
   Medawar.

2. **"Algunos métodos han demostrado ser exitosos":** Naur responde que no
   existe hasta ahora un estudio riguroso y controlado que demuestre la
   eficacia real de los métodos de programación.

Por último, lo que Naur sí rescata de los métodos es su valor educativo:
conocer técnicas, modelos y principios de estructuración ayuda al programador
a construir mejores teorías. La diferencia está en que la **VCT** deja en
manos del programador decidir qué técnicas usar y en qué orden, según el
problema específico.

#### El estatus del programador y la Visión de Construcción de Teoría

La visión predominante en la industria trata al programador como un componente
reemplazable dentro de una cadena de producción industrial, controlado por reglas
de procedimiento. Esta visión asume que los programadores rinden más siguiendo
reglas formales, lo que lleva a tratarlos como trabajadores de baja responsabilidad.

La **VCT** se opone directamente a esta idea. Dado que la teoría es una posesión
mental del programador, este no puede ser reemplazado fácilmente sin perder el
conocimiento esencial del programa. Por lo tanto, Naur propone que el programador
debe ser considerado un profesional responsable, con un estatus similar al de un
ingeniero o abogado, cuya contribución surge de su competencia intelectual y no
de seguir reglas.

Esto implica también una reorientación en la educación de los programadores: si
bien el dominio de notaciones y estructuras de datos sigue siendo importante, el
énfasis debería estar en desarrollar el talento para construir teorías. El enfoque más
prometedor, según Naur, es que el estudiante trabaje en problemas concretos bajo
supervisión, en un entorno activo y constructivo.

#### Conclusiones del paper

Naur concluye que, aceptando que las modificaciones a los programas son una
parte esencial de la programación, el objetivo principal de la misma no es producir
un programa sino que los programadores construyan una teoría que respalde su
funcionamiento.

De esta visión se desprenden tres consecuencias principales:

1. La vida de un programa depende del mantenimiento continuo por parte de
   los programadores que poseen su teoría.
2. La noción de un método de programación como conjunto de reglas fijas
   está basada en supuestos inválidos y debe ser rechazada.
3. El programador debe ser reconocido como un desarrollador responsable y
   permanente, y su educación debe enfatizar la construcción de teoría por
   sobre la adquisición mecánica de técnicas.

### Conceptos Clave

#### La noción de teoría según Ryle
Naur apoya su argumento en el filósofo **Gilbert Ryle** para justificar
por qué ese conocimiento del programador debe ser considerado una teoría.

Según Ryle, una persona *tiene* una teoría cuando:
- Sabe **cómo** hacer ciertas cosas
- Puede **justificar** sus métodos
- Puede dar **explicaciones** y responder preguntas al respecto

Es decir, no basta con ejecutar una tarea correctamente, sino que se
debe poder razonar sobre ella. Naur traslada esta noción al programador:
conocer un programa en profundidad implica poder explicar sus decisiones
de diseño y relacionarlo con el problema real que resuelve.

### Visión de Construcción de Teoría (VCT)
Es la perspectiva que propone Naur sobre lo que realmente significa programar.
Sostiene que programar no es simplemente escribir código o documentación,
sino construir una teoría sobre cómo ciertos aspectos del mundo real pueden
ser manejados y representados a través de un programa.

En otras palabras, el verdadero producto de la programación no es el programa
en sí, sino la teoría que el programador construye en su mente al crearlo.

### Método de programación
Naur define un método de programación como un conjunto de reglas de trabajo
para los programadores, que les dicen qué cosas deberían hacer, en qué orden,
qué notaciones o lenguajes usar, y qué tipos de documentos producir.
