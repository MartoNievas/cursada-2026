# Modern Software Engineering

## Autor: David Farley

## Capítulo 1: Introducción

### Ingeniería: la aplicación práctica de la ciencia

El desarrollo de software es un proceso de descubrimiento y exploración; por lo tanto, para tener éxito, los ingenieros de software deben convertirse en expertos en aprender. El mejor enfoque para aprender es la ciencia.

Al aplicar las técnicas y estrategias de la ciencia nos referimos al método científico:

* **Caracterizar:** Realizar una observación del estado actual.
* **Plantear hipótesis:** Crear una descripción, una teoría que pueda explicar la observación.
* **Predecir:** Realizar una predicción basada en la hipótesis.
* **Experimentar:** Testear la predicción.

### ¿Qué es la ingeniería de software?

Para el autor, la ingeniería de software es la aplicación de un enfoque empírico y científico para encontrar soluciones eficientes y económicas a problemas prácticos en software.

El enfoque de ingeniería es importante por 2 razones:

1. El desarrollo de software es siempre un ejercicio de descubrimiento y aprendizaje (*learning*).
2. Si nuestro objetivo es ser "eficientes" y "económicos", nuestra capacidad de aprender debe ser sustentable.

Esto implica que debemos saber gestionar la complejidad de los sistemas que diseñamos de forma tal que preservemos nuestra capacidad de asimilar nuevos conocimientos y adaptarnos a ellos.

Existen 5 técnicas que forman las raíces de este enfoque en el aprendizaje:

1. **Iteración**
2. **Feedback**
3. **Incrementalismo**
4. **Experimentación**
5. **Empirismo**

Estas son herramientas que permiten llevar a cabo esa exploración y descubrimiento. Por lo tanto, además de mantener un foco absoluto en el aprendizaje, también requerimos de maneras que nos permitan avanzar cuando las respuestas o la dirección son inciertas.

Para lograr esto debemos convertirnos en expertos en gestionar la complejidad, que es el diferenciador central entre un sistema malo y uno bueno. Para eso necesitamos lo siguiente:

* **Modularidad**
* **Cohesión**
* **Separación de preocupaciones** (*Separation of Concerns*)
* **Abstracción**
* **Acoplamiento débil** (*Loose Coupling*)

Este texto detalla cómo emplear estas diez ideas como herramientas de dirección técnica. Luego expone una serie de principios que operan como instrumentos pragmáticos para articular una estrategia de desarrollo eficaz, entre ellos:

* **Testeabilidad / Verificabilidad**
* **Desplegabilidad**
* **Velocidad**
* **Controlar las variables**
* **Continuous delivery**


### Reivindicando la «ingeniería de software»

El software no es simplemente un sinónimo de "código", ni debe confundirse con burocracia procedimental. Ingeniería es, en esencia, "lo que funciona".

Si nuestras prácticas declaradas de "ingeniería de software" no nos permiten concebir software superior en menores plazos, entonces no constituyen ingeniería legítima.

### Cómo avanzar

Como bien sabemos, el desarrollo de software es una actividad compleja y sofisticada. Resulta insostenible asumir que cada profesional o equipo deba inventar de manera aislada y desde cero el enfoque operativo idóneo cada vez que inicia un proyecto.

Aquí el autor plantea la siguiente pregunta: ¿cómo podemos, como colectivo técnico e industria, progresar? Es fundamental establecer principios consensuados y una disciplina rigurosa que guíe nuestra actividad.

Otra problemática en nuestra área son las conductas dogmáticas. El autor plantea que, para poder desafiar estos dogmas, podemos hacer uso de un paradigma ejemplar al cual denominamos **ciencia**; este enfoque nos permitirá sustituir ideas defectuosas por postulados superiores y optimizar las prácticas eficaces.

Pero cuando trasladamos el rigor analítico a la resolución de problemas pragmáticos, lo denominamos **¡ingeniería!**.

### Origen histórico y la anomalía de Brooks

* **Nacimiento del término:** Margaret Hamilton acuñó el término a finales de los años 60 liderando el software de vuelo del programa Apollo (MIT). En 1968, la conferencia de la OTAN en Garmisch formalizó la disciplina en respuesta a la llamada "crisis del software" (la brecha entre la capacidad del hardware y la dificultad de construir software fiable).
* **La anomalía de Brooks (*No Silver Bullet*):** Fred Brooks observó que no existe ningún desarrollo técnico o de gestión que prometa por sí solo una mejora de un orden de magnitud en productividad en una década. La percepción de que el software progresa lento es una ilusión: lo verdaderamente anómalo fue la explosión vertiginosa del hardware (Ley de Moore). En el software, la dificultad reside en la complejidad conceptual y el aprendizaje humano.

### Cambiando el paradigma

La idea de cambio de paradigma fue introducida por el físico Thomas Kuhn.

La mayoría del aprendizaje se da por acumulación (acreción), pero un cambio de paradigma exige cambiar fundamentalmente la perspectiva y descartar dogmas previos obsoletos:
* Tratar al desarrollo de software como una disciplina genuina de ingeniería obliga a desaprender prácticas heredadas de la era industrial (como la planificación predictiva rígida tipo cascada o la autoridad directiva no respaldada por datos).
* Se reemplazan por modelos empíricos validados como DORA y Continuous Delivery.

---

## Capítulo 2: ¿Qué es la ingeniería?

El autor desarma la falsa analogía entre el software y la construcción tradicional (como "construir puentes") marcando la distinción entre:

* **Ingeniería de producción (*Production engineering*):** Lidia con problemas físicos de manufactura, ensamblaje, tolerancias de materiales, transporte y logística para fabricar unidades idénticas a escala. En el mundo material, esta suele ser la fase más cara y compleja.
* **Ingeniería de diseño (*Design engineering*):** Es el proceso analítico, intelectual y experimental de resolver un problema, modelar, calcular y diseñar una solución adecuada.

El autor hace esta distinción ya que los activos digitales son distintos. El coste de producción de cualquier tipo de activo digital es esencialmente nulo o, al menos, debería serlo.

### La producción no es nuestro problema

* **La singularidad del software:** Toda la actividad del desarrollo de software es 100% ingeniería de diseño. En el software, la "producción" (fabricar la copia ejecutable) equivale a disparar el *build* (`trigger the build`). Es un proceso automatizado, instantáneo, escalable y de costo marginal prácticamente cero.
* **El error de Waterfall:** El modelo en cascada es una importación directa de las líneas de montaje de la manufactura industrial. Tratar al software con mentalidad de "ingeniería de producción" asume falsamente que el diseño ya está resuelto y que programar es una mera fase de ensamblado en serie.
* **Foco real:** Dado que producir copias digitales es gratis, todo el esfuerzo ingenieril debe ponerse en optimizar el diseño, la capacidad de experimentar, aprender rápido y descartar malas ideas mediante ciclos de feedback continuos.

### Ingeniería de diseño, no de producción

Aquí se plantean dos problemas que surgen al crear un producto físico nuevo, uno relevante para el desarrollo de software y otro no:

1. **El irrelevante para software (producción física):** En el mundo material, construir la primera unidad acarrea enormes fricciones de logística, materiales y montaje. En software, esto se ignora porque la replicación digital es trivial.
2. **El relevante para software (diseño complejo):** El diseño de algo novedoso es intrínsecamente difícil. En ingeniería física, iterar sobre el diseño es lento y costoso, por lo que recurren a simulaciones y modelos que solo son aproximaciones inexactas de la realidad.

* **Nuestra ventaja:** En software, **el modelo es el producto mismo**. No simulamos una aproximación: ejecutamos el sistema real. Podemos evaluarlo y modificarlo a un costo drásticamente inferior que en cualquier disciplina física. Ya que no necesitamos que nuestros modelos se ajusten a la realidad porque estos constituyen la realidad ejecutable de nuestro sistema.

### La ingeniería como matemática y sus límites

A finales de los 80 y principios de los 90 se debatió intensamente sobre cómo estructurar el desarrollo para eliminar defectos de raíz.

* **Métodos formales (*Formal Methods*):** Buscan demostrar matemáticamente la corrección de un sistema. La falla pragmática es que si ya es difícil programar un sistema complejo, es exponencialmente más difícil escribir código que además demuestre formalmente su propia corrección.
* **El límite del determinismo:** Funcionan en contextos muy reducidos, aislados y deterministas. Cuando aparecen la concurrencia, la interacción con usuarios/mundo real o la complejidad de dominio, la demostrabilidad matemática explota y se vuelve inviable.
* **La postura aeroespacial (el caso SpaceX):** En ingeniería aeroespacial se usan modelos matemáticos rigurosos, pero aun así SpaceX construye prototipos rápidos y los presuriza hasta destruirlos. Los números y las fórmulas orientan el diseño, pero solo la prueba empírica valida el comportamiento real frente a variables imprevistas. El software debe seguir este mismo camino empírico y guiado por datos.

### La primera definición de ingeniería de software

**Margaret Hamilton** acuñó el término de **software engineering** para darle seriedad frente a las ingenierías tradicionales, en un contexto donde no había antecedentes ni literatura y el software debía ser **man-rated** (cero margen de error humano).

Continuando con la definición, la ingeniería no asume que se puede planificar la perfección desde el inicio. El enfoque racional trata toda hipótesis o código con escepticismo, buscando cómo puede romperse antes de darlo por bueno.

Es imposible anticipar todos los escenarios de falla en tiempo de ejecución. La arquitectura debe permitir que el sistema degrade con gracia, priorice tareas críticas y se recupere (como ocurrió con la sobrecarga de trabajo de la computadora del LEM en el Apollo 11 gracias al reinicio selectivo).

### La verdadera definición de ingeniería

Citando a Glenn Vanderburg (*"Real Software Engineering"*):
* En otras disciplinas, **ingeniería significa "las cosas que funcionan"**.
* En el software, un enfoque académico rígido y burocrático provocó que muchos procesos solo funcionaran cuando la gente capaz decidía eludirlos para poder avanzar. Si un proceso solo funciona cuando se lo desobedece, no es ingeniería.
* **Criterio de validación:** Si una práctica autodenominada de "ingeniería" no permite construir **mejor software más rápido**, entonces no califica como ingeniería. El software es puramente un ejercicio de diseño, exploración y aprendizaje.

---

## Capítulo 3: Fundamentos de un enfoque de ingeniería

Todas las ingenierías (aeroespacial, civil, química) son diferentes en sus dominios materiales, pero comparten el mismo núcleo: **racionalismo científico y empirismo pragmático**. Para la ingeniería de software, los principios rectores deben ser duraderos y resistir el paso del tiempo frente a los cambios superficiales de la industria.

### ¿Una industria en constante cambio?

Mucho de lo que la industria vende como "innovación" tecnológica o librerías de moda (como el caso Hibernate vs. SQL directo) resulta ser un cambio cosmético o introduce accidentalmente más complejidad y código innecesario. Por otro lado, el estancamiento conceptual y metodológico del software pasó desapercibido históricamente gracias a que el hardware se volvió exponencialmente más veloz y barato.

Lo que realmente transforma la capacidad de construir sistemas no es saltar entre lenguajes sintácticamente similares, sino los **saltos en los niveles de abstracción y paradigmas** (como pasar de Assembler a C, o de programación procedimental a OO).

* **La asimetría de Brooks (no hay mejoras 10x, pero sí pérdidas 10x):** Mientras que ninguna herramienta mágica multiplica la productividad por diez, las malas decisiones metodológicas, burocráticas o arquitectónicas pueden fácilmente degradar o paralizar por completo el avance de un equipo (organizaciones que pasan años sin poder desplegar a producción).

La industria sufre una enorme dificultad no solo para aprender y adoptar enfoques empíricos basados en evidencia, sino sobre todo para **desechar prácticas disfuncionales obsoletas**, por muy desacreditadas que estén.

### La importancia de la medición

Una de las razones por las cuales nos resulta tan difícil descartar las malas ideas en ingeniería de software es que no medimos nuestro desempeño de manera muy efectiva.

* **El problema de medir productividad:** Como señaló Martin Fowler, no existe una medida defendible para cuantificar la "productividad" de un programador o equipo. Métricas comunes como las líneas de código o la cobertura ciega de tests suelen ser perjudiciales, mientras que la "velocidad" ágil no correlaciona con resultados reales.
* **El modelo DORA / Accelerate (Forsgren, Humble y Kim):** En lugar de medir productividad individual, el modelo evalúa la efectividad del proceso de entrega mediante dos dimensiones clave correlacionadas estadísticamente con el éxito comercial y organizacional:
  * **Estabilidad (*Stability* - calidad técnica):**
    * *Change Failure Rate:* Porcentaje de cambios desplegados que provocan una falla en el sistema.
    * *Recovery Failure Time (MTTR):* Tiempo que toma recuperar el servicio tras una degradación o incidente.

  Monitorear la estabilidad es importante pues representa una medida objetiva de la calidad intrínseca del trabajo de ingeniería. Esta métrica no nos dice si las funcionalidades son las correctas para el mercado, pero sí cuantifica con certeza la eficacia del equipo para desplegar software provisto de calidad verificable.

  * **Rendimiento (*Throughput* - eficiencia y oportunidades de aprendizaje):**
    * *Lead Time for Changes:* Tiempo que tarda un cambio desde que se escribe la primera línea de código hasta que está ejecutándose en producción.
    * *Deployment Frequency:* Frecuencia con la que se despliegan cambios funcionales a producción.

  El rendimiento del flujo mide la agilidad de un equipo técnico para materializar conceptos e hipótesis en software operativo.

* **El fin del falso dilema (Velocidad vs. Calidad):** Los datos empíricos derriban el mito de que para ir rápido hay que sacrificar calidad. Velocidad y estabilidad van de la mano: el camino a la velocidad es el software de alta calidad; el camino a la alta calidad es la velocidad del feedback; y el camino hacia ambos es una ingeniería disciplinada (Continuous Delivery).

### Aplicando estabilidad y throughput

La correlación de estas métricas nos ofrece una vara objetiva para evaluar cualquier cambio de proceso, tecnología, cultura u organización sin depender de conjeturas:

* **El contraejemplo del Change Approval Board (CAB):** Intuitivamente parecería que sumar un comité externo de aprobación aumenta la calidad. Sin embargo, los datos de DORA demuestran que empeora el *lead time*, la frecuencia de despliegue y el tiempo de recuperación, sin reducir la tasa de fallas. Ralentizar el proceso perjudica la estabilidad: tener un CAB es estadísticamente peor que no tener ninguna aprobación externa.
* **Toma de decisiones experimental:** Cada equipo debe medir su propia estabilidad y throughput actuales, aplicar un cambio puntual y evaluar empíricamente si la aguja se mueve en la dirección correcta.

### Los fundamentos de una disciplina de ingeniería de software

Para definir ideas que sigan siendo válidas dentro de 100 años sin importar la tecnología de turno, la disciplina debe asentarse sobre dos competencias centrales:

1. **Ser expertos en aprender (*Experts at Learning*):**
   * Reconocer que el software es diseño creativo puro y dominar las herramientas de exploración y descubrimiento basadas en el razonamiento científico.
   * Se sostiene en 5 conductas: **trabajar iterativamente, feedback rápido y de calidad, incrementalismo, experimentación y empirismo**.
2. **Ser expertos en gestionar la complejidad (*Experts at Managing Complexity*):**
   * Construimos sistemas que no entran completos en la cabeza de una persona y que escalan a nivel organizacional.
   * **Concurrencia y acoplamiento (*Coupling*):** Son problemas fundamentales de las ciencias de la información que aplican tanto al software como a las organizaciones humanas (reflejado en la ley de Conway: la estructura del sistema copia la estructura de comunicación de la empresa).
   * La falta de control sobre la complejidad genera sistemas *big-ball-of-mud*, deuda técnica descontrolada y miedo a hacer cambios.
   * Para mitigar la sobreestimación humana al resolver problemas, se debe asumir que las ideas iniciales pueden fallar y aplicar 5 principios estructurales: **modularidad, cohesión, separación de preocupaciones, abstracción/ocultamiento de información y bajo acoplamiento**.

### Resumen del enfoque

Las herramientas reales de la profesión no son los frameworks ni los lenguajes temporales, sino los principios que facilitan el aprendizaje y el control de la complejidad. Cualquier decisión técnica o metodológica debe evaluarse bajo la misma vara: **¿aumenta la calidad (estabilidad) o incrementa la eficiencia para producir esa calidad (throughput)?** Si no mejora ninguna de las dos, no hay justificación empírica para adoptarla.