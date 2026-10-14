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

> **Proposición:** Si $X \in P$, entonces $P = P^{X}$

**Demostración**
Probemos $P^X \subseteq P$, sea $M$ una máquina determinística que corre en tiempo polinomial y decide $X$.
Sea $L \in P^X$ y supongamos que $M'$ es una máquina determinística que corre en tiempo polinomial y decide $L$ con acceso al oŕaculo $X$.
La máquina $M''$ hace lo mismo que $M'$ pero reemplaza cada pregunta x al oráculo $X$ por la llamada a $M(x)$.
$M''$ corre en tiempo polinomial y decide $L$.
Entonces $L \in P$.

> **Proposición:** **ExpTime** $\subseteq$ **$P^{EXPCOM}$**

> **Proposición:** **$NP^{EXPCOM}$** $\subseteq$ **ExpTime**

> **Corolario:** **$P^{EXPCOM}$** = **$NP^{EXPCOM}$**

## Teorema de Baker, Gill, Solovay

> **Teorema (Baker, Gill, Solovay):** Existen oráculos $\mathcal{A}$ y $\mathcal{B}$ tales que:
> $$P^{\mathcal{A}} = NP^{\mathcal{A}} \quad \text{y} \quad P^{\mathcal{B}} \ne NP^{\mathcal{B}}$$

### Consecuencia metodológica
Las técnicas estándar de demostración basadas en simulación y diagonalización **relativizan** (su validez se mantiene intacta si todas las máquinas involucradas acceden al mismo oráculo). Por ende, ninguna técnica puramente relativizable puede resolver el problema $P \stackrel{?}{=} NP$, ya que debería concluir simultáneamente la igualdad y la desigualdad en presencia de distintos oráculos.

---

### Caso 1: Oráculo $\mathcal{A}$ tal que $P^{\mathcal{A}} = NP^{\mathcal{A}}$

Basta tomar $\mathcal{A} = \text{EXPCOM}$ (cómputos exponenciales):
$$\text{EXPTIME} \subseteq P^{\text{EXPCOM}} \subseteq NP^{\text{EXPCOM}} \subseteq \text{EXPTIME}$$

En consecuencia:
$$P^{\text{EXPCOM}} = NP^{\text{EXPCOM}} = \text{EXPTIME}$$

---

### Caso 2: Oráculo $\mathcal{B}$ tal que $P^{\mathcal{B}} \ne NP^{\mathcal{B}}$

Dado cualquier lenguaje $\mathcal{B} \subseteq \{0, 1\}^*$, se define el lenguaje:
$$\mathcal{U}_{\mathcal{B}} = \{1^n : \exists x \in \mathcal{B}, |x| = n\}$$

- **$\mathcal{U}_{\mathcal{B}} \in NP^{\mathcal{B}}$ para todo $\mathcal{B}$:** Una máquina no determinística $N$ con entrada $1^n$ conjetura de forma no determinística una cadena $x$ tal que $|x| = n$, consulta al oráculo si $x \in \mathcal{B}$ y devuelve dicha respuesta en tiempo lineal.
- **Construcción de $\mathcal{B}$ por diagonalización ($\mathcal{U}_{\mathcal{B}} \notin P^{\mathcal{B}}$):**  
  Se toma una enumeración estándar de todas las máquinas determinísticas con oráculo: $M_1, M_2, \dots$  
  Se construye $\mathcal{B} = \bigcup_{i} \mathcal{B}_i$ en etapas finitas sucesivas asegurando que cada máquina polinomial $M_i$ falle en decidir $\mathcal{U}_{\mathcal{B}}$ para la entrada $1^{n_i}$:
  1. Se elige $n_i > n_{i-1}$ estrictamente mayor a las longitudes de cualquier consulta efectuada en las etapas previas.
  2. Se simula $M_i$ con entrada $1^{n_i}$ durante a lo sumo $2^{n_i - 1}$ pasos. Para consultas de longitud $< n_i$ se responde según $\mathcal{B}_{i-1}$; para consultas $\ge n_i$, se responde negativamente.
  3. **Si $M_i$ acepta $1^{n_i}$ en $\le 2^{n_i - 1}$ pasos:** Se define $\mathcal{B}_i = \mathcal{B}_{i-1}$. No se agregan cadenas de longitud $n_i$, con lo cual $1^{n_i} \notin \mathcal{U}_{\mathcal{B}}$ y $M_i$ clasifica erróneamente.
  4. **Si $M_i$ rechaza o no termina en $2^{n_i - 1}$ pasos:** Dado que en ese lapso consultó a lo sumo $2^{n_i - 1}$ cadenas, pero existen $2^{n_i}$ cadenas binarias de longitud $n_i$, existe al menos una cadena $x$ de longitud $n_i$ que nunca fue consultada. Se fija $\mathcal{B}_i = \mathcal{B}_{i-1} \cup \{x\}$. Así, $1^{n_i} \in \mathcal{U}_{\mathcal{B}}$, pero la máquina rechaza (o no decide a tiempo).

Por lo tanto, ninguna máquina polinomial determinística puede decidir $\mathcal{U}_{\mathcal{B}}$.

---

## Clases de complejidad relativizadas a clases de complejidad

Dada una clase de complejidad $\mathcal{C}$, se generaliza la noción de oráculo como:
$$P^{\mathcal{C}} = \bigcup_{X \in \mathcal{C}} P^X, \qquad NP^{\mathcal{C}} = \bigcup_{X \in \mathcal{C}} NP^X$$

> **Observación:** Si $X$ es un problema $\mathcal{C}$-completo bajo reducciones polinomiales de Karp, entonces:
> $$P^{\mathcal{C}} = P^X \quad \text{y} \quad NP^{\mathcal{C}} = NP^X$$

**Ejemplo fundamental:**
$$P^{NP} = P^{SAT} = P^{\overline{SAT}} = P^{\text{coNP}}$$

---

## La Jerarquía Polinomial y $NP$ con oráculos

La jerarquía polinomial ($\text{PH}$) puede reformularse de manera inductiva mediante máquinas de Turing con oráculos de problemas completos de niveles inferiores.

### Caracterización de $\Sigma_{i+1}^p$

> **Teorema:** Para todo $i \ge 1$:
> $$\Sigma_{i+1}^p = NP^{\Sigma_i SAT} = NP^{\Sigma_i^p}$$

**Casos particulares:**
- $\Sigma_1^p = NP$
- $\Sigma_2^p = NP^{\Sigma_1 SAT} = NP^{SAT} = NP^{NP}$
- $\Sigma_3^p = NP^{\Sigma_2 SAT} = NP^{NP^{NP}}$

#### Esquema de la demostración:
1. **$\Sigma_{i+1}^p \subseteq NP^{\Sigma_i SAT}$:**  
   Sea $L \in \Sigma_{i+1}^p$, de modo que $x \in L \iff \exists u_1 \forall u_2 \dots Q u_{i+1} M(\langle x, u_1, \dots \rangle) = 1$.  
   El predicado tras el primer cuantificador existencial define un lenguaje $L' \in \Pi_i^p \le_p \overline{\Sigma_i SAT}$. Una máquina no determinística adivina en tiempo polinomial la tupla $u_1$, formula la consulta $\langle x, u_1 \rangle$ al oráculo para $L'$ (o $\Sigma_i SAT$) y acepta si este responde afirmativamente.
2. **$NP^{\Sigma_i SAT} \subseteq \Sigma_{i+1}^p$:**  
   Sea $N$ una máquina no determinística polinomial con oráculo $\Sigma_i SAT$. En una traza de cómputo aceptadora $u$, $N$ efectúa una secuencia de consultas $\varphi_1, \dots, \varphi_k$ con respuestas $r_1, \dots, r_k \in \{0, 1\}$.  
   Adivinar de forma no determinística la traza $u$ y los certificados de las respuestas afirmativas ($r_j = 1$) requiere cuantificadores de tipo $\exists$. Las respuestas negativas ($r_j = 0$) corresponden al complemento de fórmulas $\Sigma_i$, introduciendo alternancias de cuantificadores complementarias. Reordenando y agrupando los bloques de cuantificadores independientes, se obtiene una fórmula con $i+1$ alternancias que comienza con $\exists$, demostrando que $L \in \Sigma_{i+1}^p$.

---

### La clase $\Delta_{i+1}^p$

Corresponde a los niveles determinísticos con acceso a oráculos de la jerarquía:
- $\Delta_1^p = P$
- $\Delta_{i+1}^p = P^{\Sigma_i^p}$

**Ejemplos:**
- $\Delta_2^p = P^{\Sigma_1^p} = P^{NP}$
- $\Delta_3^p = P^{\Sigma_2^p} = P^{NP^{NP}}$

> **Problema $\Delta_2^p$-completo:**  
> **$\text{LEXSAT}$:** Dadas una fórmula booleana proposicional $\varphi$ y una variable, decidir el valor que toma dicha variable en la menor valuación de verdad (en orden lexicográfico) que satisface a $\varphi$.

---

### Estructura de inclusiones de la Jerarquía Polinomial

$$
\begin{array}{c}
\vdots \\
\Sigma_2^p \cup \Pi_2^p = NP^{NP} \cup \text{coNP}^{NP} \\
\Sigma_2^p = NP^{NP} \qquad\qquad \Pi_2^p = \text{coNP}^{NP} \\
\Sigma_2^p \cap \Pi_2^p = NP^{NP} \cap \text{coNP}^{NP} \\
\uparrow \\
\Delta_2^p = P^{NP} \\
\uparrow \\
\Sigma_1^p \cup \Pi_1^p = NP \cup \text{coNP} \\
\Sigma_1^p = NP \qquad\qquad \Pi_1^p = \text{coNP} \\
\Sigma_1^p \cap \Pi_1^p = NP \cap \text{coNP} \\
\uparrow \\
P = \Sigma_0^p = \Pi_0^p = \Delta_1^p
\end{array}
$$