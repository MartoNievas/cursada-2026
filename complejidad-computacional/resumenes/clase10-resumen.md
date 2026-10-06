# Complejidad Computacional — Clase 10: Máquinas con oráculo

**Complejidad Computacional — FCEyN, Universidad de Buenos Aires**

## Máquinas con oráculo

Son idénticas a las máquinas de Turing estándar, con las siguientes diferencias:

* **Dependencia externa:** Su comportamiento depende de un lenguaje oráculo $X \subseteq \{0, 1\}^*$.
* **Cinta adicional:** Cuenta con una cinta exclusiva de consulta (*query tape*).
* **Estados distinguidos adicionales:** Se incorporan tres nuevos estados:
  * $q_{\text{consulta}}$ (estado de consulta)
  * $q_{\text{resp:sí}}$ (respuesta afirmativa del oráculo)
  * $q_{\text{resp:no}}$ (respuesta negativa del oráculo)
* **Instrucción de consulta:** Si la máquina alcanza el estado $q_{\text{consulta}}$ y la cinta de consulta contiene la cadena $\triangleright x \sqcup$ (con $x \in \{0, 1\}^*$), la máquina transita en un solo paso al estado $q_{\text{resp:sí}}$ si $x \in X$, o al estado $q_{\text{resp:no}}$ si $x \notin X$.

---

Para estas máquinas se mantienen las nociones estándar de cómputo, aceptación, rechazo, tiempo de ejecución y uso de espacio; no obstante, la traza de ejecución de la máquina $M$ depende de las respuestas provistas por el oráculo $X$.

### Notación

Si $M$ es una máquina de Turing con oráculo (determinística o no determinística):
* Se denota como $M^X(x)$ a la salida (o cómputo) de $M$ sobre la entrada $x$ utilizando al lenguaje $X$ como oráculo.
* Se denota como $L(M^X)$ al lenguaje reconocido por $M$ con oráculo $X$.

---

## Propiedades fundamentales del cómputo con oráculo

### Localidad y finitud de las consultas

Si $M^X(x)$ termina, solo puede realizar una cantidad finita de consultas al oráculo. En consecuencia, si modificamos el oráculo en elementos que nunca son consultados, el resultado del cómputo no varía.

* **Invarianza ante oráculos coincidentes en las consultas:** Si $M^X(x)$ termina habiendo consultado a lo largo de su ejecución la secuencia finita de cadenas $y_1, \dots, y_m$ al oráculo, entonces para cualquier lenguaje $Y$ tal que:
  $$y_j \in X \iff y_j \in Y \quad \text{para todo } j \in \{1, \dots, m\}$$
  se cumple rigurosamente que $M^X(x) = M^Y(x)$.

* **Acotación por pasos de cómputo:** En el paso $t$, la máquina $M^X(x)$ solo puede haber realizado una cantidad finita de consultas, independientemente de las respuestas recibidas. Dado que cada consulta toma al menos un paso de ejecución, al paso $t$ se pueden haber realizado a lo sumo $t$ consultas.

### Enumerabilidad de las máquinas con oráculo

La descripción sintáctica de una máquina con oráculo $M$ (su conjunto de estados, alfabeto y función de transición) es finita y completamente independiente del lenguaje $X$ que luego se use como oráculo. 

Por lo tanto, **las máquinas con oráculo se pueden listar/codificar** como cadenas binarias $\langle M \rangle$, de la misma forma que las máquinas de Turing determinísticas o no determinísticas estándar:

$$M_1, M_2, M_3, \dots$$

---

## Clases de complejidad relativizadas a oráculos

Fijado un lenguaje oráculo $X \subseteq \{0, 1\}^*$, extendemos las nociones clásicas de complejidad temporal a máquinas con acceso al oráculo $X$.

### Clases $\text{P}^X$ y $\text{NP}^X$

* **$\text{P}^X$:** Es la clase de lenguajes decidibles por una máquina de Turing determinística que corre en tiempo polinomial y tiene acceso al oráculo $X$:
  $$\text{P}^X = \bigcup_{c \ge 1} \text{DTIME}^X(n^c)$$

* **$\text{NP}^X$:** Es la clase de lenguajes decidibles por una máquina de Turing no determinística que corre en tiempo polinomial y tiene acceso al oráculo $X$:
  $$\text{NP}^X = \bigcup_{c \ge 1} \text{NTIME}^X(n^c)$$

> **Observación sobre el tiempo y la longitud de consulta:** Una consulta al oráculo toma un único paso de cómputo ($O(1)$). Sin embargo, escribir la cadena $y \in \{0, 1\}^*$ en la cinta de consulta insume $|y|$ pasos. Por lo tanto, si la máquina está acotada por un polinomio $p(n)$, toda consulta realizada satisface $|y| \le p(n)$, y la máquina puede realizar a lo sumo $p(n)$ consultas en total.