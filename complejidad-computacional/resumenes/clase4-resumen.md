# Complejidad Computacional — Clase 4

## 1. Máquinas no-determinísticas

**Máquinas determinísticas:** Hasta ahora vimos máquinas donde cada configuración evoluciona de una única forma. Un cómputo es una secuencia lineal $C_0 \Rightarrow C_1 \Rightarrow C_2 \Rightarrow \dots \Rightarrow C_l$ donde $C_l$ es final.

**Definición (Máquina no-determinística).** Es una tripla $N=(\Sigma, Q, \delta)$ con dos diferencias principales respecto a las determinísticas:
1.  **Transición bifurcada:** La función $\delta$ puede devolver hasta **dos** evoluciones posibles en un solo paso:
    $\delta: Q \times \Sigma^{k-1} \rightarrow \left( \text{movimiento entrada} \times \text{escritura y mov. trabajo} \times \text{salida y estado} \right)^2$
2.  **Estados distinguidos:** $Q$ tiene tres estados especiales: $q_0$ (inicial), $q_{si}$ (aceptación) y $q_{no}$ (rechazo).

**Cómputo en $N$.** Un cómputo de $N$ a partir de $x$ es una secuencia de configuraciones $C_0, \dots, C_l$ donde:
* $C_0$ es inicial.
* $C_{i+1}$ es una de las (hasta) dos evoluciones válidas desde $C_i$ según $\delta$.
* $C_l$ está en estado $q_{si}$ o $q_{no}$ (configuración final).
* **Cómputo aceptador:** Aquel donde $C_l$ termina en $q_{si}$.
A diferencia de las determinísticas, aquí el árbol de cómputo se ramifica y hay múltiples caminos posibles.

**Lenguaje aceptado $\mathcal{L}(N)$.**
* $N$ **acepta** $x$ (notado $N(x)=1$) si existe **al menos un** cómputo aceptador.
* $N$ **rechaza** $x$ (notado $N(x)=0$) si **ningún** cómputo es aceptador (todos terminan en $q_{no}$ o no terminan).
* $N$ decide $\mathcal{L}$ si: $x \in \mathcal{L} \iff N$ acepta $x$.
*(Nota: La cinta de salida es irrelevante para decidir lenguajes en estas máquinas).*

**Tiempo de cómputo.**
* $N$ corre en tiempo $T(n)$ si **todo** cómputo posible a partir de $x$ tiene longitud $\le T(|x|)$.
* La clase **NDTIME$(T(n))$** agrupa a los lenguajes decidibles por una máquina no-determinística en tiempo $O(T(n))$.

**Codificación de cómputos.** Al tener dos opciones ($\delta_0$ y $\delta_1$) en cada paso, un cómputo de longitud $T(n)$ se puede representar unívocamente con una cadena binaria $u \in \{0,1\}^{T(n)}$ (el certificado), donde cada bit indica qué rama de $\delta$ tomar en ese paso.

**Simulación determinística.** Si $N$ corre en tiempo $T(n)$, genera $O(2^{T(n)})$ ramas. Una máquina determinística puede simular $N$ explorando todas las ramas una por una en tiempo exponencial $O(2^{T(n)} \cdot T(n))$, lo que está acotado por $O(2^{T(n)^2})$.

---

## 2. Redefinición de la clase NP

**Teorema de equivalencia.** $NP = \bigcup_{c \in \mathbb{N}} NDTIME(n^c)$.
La clase NP se puede definir de dos formas equivalentes:
1.  **Definición de Verificador (determinística):** Existe un verificador $M$ en tiempo polinomial tal que $x \in \mathcal{L} \iff \exists u \in \{0,1\}^{p(|x|)}$ tal que $M(\langle x,u \rangle)=1$.
2.  **Definición de Máquina (no-determinística):** Existe una máquina no-determinística $N$ que corre en tiempo polinomial tal que $x \in \mathcal{L} \iff$ existe un cómputo aceptador de $N$ a partir de $x$.

**Idea de la equivalencia:**
* **$NDTIME(n^c) \subseteq \text{Verificador NP}:$** Si $N$ es no-determinística, la cadena de decisiones tomadas en un cómputo exitoso funciona como el "certificado" $u$. El verificador determinístico simplemente lee $x$ y el certificado $u$ paso a paso para chequear si esa rama específica de $N$ lleva a $q_{si}$.
* **$\text{Verificador NP} \subseteq NDTIME(n^c):$** Si tenemos un verificador $M$, armamos una máquina $N$ que usa su no-determinismo para "inventar" mágicamente el certificado $u$ bit por bit en una cinta de trabajo en tiempo polinomial. Luego, simula de forma determinística al verificador $M(x,u)$. Si $M$ acepta, $N$ va a $q_{si}$.

---

## 3. Reducibilidad Polinomial y NP-Completitud

**Definición (Reducción Karp).** $\mathcal{L}$ es reducible polinomialmente a $\mathcal{L}'$ (notado $\mathcal{L} \le_p \mathcal{L}'$) si existe una función $f: \{0,1\}^* \to \{0,1\}^*$ computable en tiempo polinomial tal que:
$x \in \mathcal{L} \iff f(x) \in \mathcal{L}'$

**Propiedades de $\le_p$:**
* Si $\mathcal{L} \le_p \mathcal{L}'$ y $\mathcal{L}' \in P$, entonces $\mathcal{L} \in P$. (Si puedo transformar mi problema rápido a uno fácil, mi problema es fácil).
* Es transitiva: $\mathcal{L} \le_p \mathcal{L}'$ y $\mathcal{L}' \le_p \mathcal{L}'' \implies \mathcal{L} \le_p \mathcal{L}''$.

**Clases NP-Hard y NP-Completo.**
* $\mathcal{L}$ es **NP-hard** si $\forall \mathcal{L}' \in NP$, se cumple que $\mathcal{L}' \le_p \mathcal{L}$ (es al menos tan difícil como cualquier problema en NP).
* $\mathcal{L}$ es **NP-completo** si $\mathcal{L} \in NP$ y $\mathcal{L}$ es NP-hard (son los problemas "más difíciles" dentro de NP).

**Teoremas fundamentales:**
* Si NP-hard $\cap \ P \ne \emptyset$, entonces $P = NP$.
* Si $\mathcal{L} \in \text{NP-completo}$, entonces $\mathcal{L} \in P \iff P = NP$.

**Ejemplo NP-Completo (TMSAT).**
$TMSAT = \{ \langle y,x,1^n,1^t \rangle : \exists u \in \{0,1\}^n \text{ tal que } M_y(xu)=1 \text{ en } \le t \text{ pasos} \}$
Cualquier problema $\mathcal{L} \in NP$ se reduce a TMSAT pasando el código del verificador de $\mathcal{L}$ ($y = \langle M \rangle$), la entrada ($x$), el tamaño del certificado ($1^{p(|x|)}$) y el tiempo límite polinomial ($1^{q(|x|+p(|x|))}$).

---

## 4. Lógica Proposicional y SAT

**Sintaxis y Semántica:**
* Fórmulas booleanas generadas por $\varphi ::= p \mid \neg\varphi \mid (\varphi \wedge \varphi) \mid (\varphi \vee \varphi)$.
* Una **valuación** $v: PROP \to \{0,1\}$ asigna valores de verdad.
* $v \models \varphi$ significa que la valuación $v$ satisface (hace verdadera) a $\varphi$.
* Para saber si $v \models \varphi(p_1, \dots, p_n)$, alcanza con conocer el valor de esas $n$ variables, representable como una cadena $u \in \{0,1\}^n$.

**Forma Normal Conjuntiva (CNF).**
* **Literal:** Variable $p$ o su negación $\neg p$.
* **Cláusula:** Disyunción de literales $(l_1 \vee l_2 \vee \dots)$.
* **CNF:** Conjunción de cláusulas $C_1 \wedge C_2 \wedge \dots \wedge C_m$.
* **3CNF:** CNF donde cada cláusula tiene exactamente o a lo sumo 3 literales.

**El problema SAT.**
* $SAT = \{ \langle \varphi \rangle : \varphi \in CNF \text{ es satisfacible (existe valuación que la haga verdadera)} \}$.
* $3SAT = \{ \langle \varphi \rangle : \varphi \in 3CNF \text{ es satisfacible} \}$.

**Teorema.** SAT y 3SAT pertenecen a NP.
* **Demostración (SAT):** El verificador recibe la fórmula $\langle \varphi \rangle$ y el certificado $u \in \{0,1\}^n$ (la valuación propuesta). En tiempo polinomial evalúa si $u \models \varphi$. Si da verdadero, acepta.

**Representación de funciones.**
Cualquier función booleana $F: \{0,1\}^l \to \{0,1\}$ puede representarse con una fórmula $\varphi_F$ en CNF de tamaño $O(l \cdot 2^l)$, construida armando cláusulas para descartar explícitamente los casos donde la función da $0$.
