# Complejidad Computacional — Clase 10

**Complejidad Computacional — FCEyN, Universidad de Buenos Aires**

---

## Circuitos booleanos

### Definición de circuito booleano

**Definición:** Un **circuito booleano** de $n$ entradas es un grafo acíclico dirigido tal que:

* tiene $n$ entradas (*sources*): nodos sin flechas de entrada.
* tiene 1 nodo destino o **salida** (*sink*, sumidero): nodo sin flechas de salida.

Los nodos que no son entradas se llaman **compuertas** (*gates*) y están etiquetados con:

* $\neg$: $\text{fan-in} = 1$
* $\land$: $\text{fan-in} = 2$
* $\lor$: $\text{fan-in} = 2$

El **tamaño** $|C|$ de un circuito booleano $C$ es la cantidad de vértices de $C$.

---

### Semántica de circuitos booleanos

**Definición:** Dado un circuito booleano $C = (V,E)$ con entradas $X = \{x_1, \dots, x_n\}$ y $x \in \{0,1\}^n$, definimos recursivamente $v : V \to \{0,1\}$ de esta forma:

* $v(x_i) = x(i)$. Es el caso base: llegamos a una hoja, entonces el valor es el bit de la valuación asignado a la variable.
* Si en $C$ tenemos $u_1 \to u$ y $u$ tiene $\text{fan-in} = 1$, entonces $v(u) = \neg v(u_1)$ ($u$ tiene etiqueta $\neg$). Básicamente, el valor del nodo $u$ invierte el valor de su predecesor.
* Si en $C$ tenemos $u_1 \to u$ y $u_2 \to u$, y
    * $u$ tiene etiqueta $\land$, entonces $v(u) = v(u_1) \land v(u_2)$.
    * $u$ tiene etiqueta $\lor$, entonces $v(u) = v(u_1) \lor v(u_2)$.

$C(x) = v(t)$, donde $t$ es el nodo de salida de $C$. El circuito $C$ calcula la función $x \mapsto C(x)$.

---

### La clase $\mathbf{SIZE}(S(n))$

**Definición:** Sea $S: \mathbb{N} \to \mathbb{N}$. Una **familia de circuitos de tamaño** $S(n)$ es una secuencia $(C_n)_{n \in \mathbb{N}}$ tal que:

* $C_n$ es un circuito con $n$ entradas.
* $|C_n| \leq S(n)$.

**Definición:** Una familia de circuitos $(C_n)_{n \in \mathbb{N}}$ de tamaño $S(n)$ **decide** un lenguaje $L$ si para todo $n \geq 1$ y todo $x \in \{0,1\}^n$:

$$
x \in L \iff C_n(x) = 1
$$

Identificamos la tupla $(x_1, \dots, x_n) \in \{0,1\}^n$ con la cadena $x_1 \dots x_n$.

También tenemos la clase de complejidad $\mathbf{SIZE}(S(n))$, que se define como la clase de lenguajes $L$ tales que existe una familia de circuitos $(C_n)_{n \in \mathbb{N}}$ de tamaño $S(n)$ que decide $L$.

---

### Codificación de un circuito de tamaño $S$

Cualquier circuito booleano de tamaño $S$ se puede codificar como una tira de $O(S \log S)$ bits.

**Puntos clave del esquema:**

* **Direccionamiento de nodos:** como el circuito tiene $S$ compuertas/nodos, identificar a cada nodo requiere $\lceil \log_2 S \rceil$ bits (un índice binario de $0$ a $S-1$).
* **Estructura por nodo ($\tau_i \sigma_i$):**
    * $\tau_i$ (2 bits): indica qué tipo de nodo es:
        * `00`: variable de entrada (sin predecesores).
        * `01`: compuerta $\neg$ (1 predecesor).
        * `10`: compuerta $\land$ (2 predecesores).
        * `11`: compuerta $\lor$ (2 predecesores).
    * $\sigma_i$: contiene los identificadores de los nodos de los cuales recibe señal (a lo sumo 2 direcciones de $\lceil \log_2 S \rceil$ bits cada una).
* **Cota de tamaño total:** cada nodo ocupa a lo sumo $2 + 2\lceil \log_2 S \rceil$ bits, lo que da una representación total acotada por:

$$
\leq 4 \cdot S \log S \text{ bits}
$$

---

## La clase $\mathbf{P}_{/\mathrm{poly}}$

Los circuitos que vimos antes sirven para representar funciones $\{0,1\}^n \to \{0,1\}^m$:

* hay $n$ nodos de entrada (con $\text{fan-in} = 0$).
* hay $m$ nodos de salida (con $\text{fan-out} = 0$).
* las representaciones son análogas a las que vimos, solo que además se representan los nodos de salida.

Recordando la idea de **Cook-Levin**, supongamos que tenemos $M$, una máquina determinística tal que:

* $M$ corre en tiempo $t(n)$.
* $M$ es *oblivious* y sin cinta de salida.
* $x \in L \iff$ existe una secuencia de mini-configuraciones $z_0, \dots, z_{t(|x|)}$ de $M$ con entrada $x$ tal que:
    * $z_0$ es inicial para $x$.
    * $z_i$ evoluciona en un paso en $z_{i+1}$.
    * $z_{t(|x|)}$ es aceptadora.
* Cada mini-configuración tiene información sobre el estado, el bit leído de la cinta de trabajo y el bit leído de la cinta de entrada.
* Recordar que, para $n = |x|$:
    * $|z_i| = k$, donde $k$ depende solo de $M$.
    * $z_0$ solo depende de $x$.
    * $z_{i+1}$ solo depende de $1$ bit de $x$, de $z_i$ y de $z_{\mathrm{prev}(i+1, n)}$, donde:
    $$\mathrm{prev}(i, n) = \max\big(\{j < i : t(j, n) = t(i, n)\} \cup \{0\}\big)$$
    ($t(j, n)$ es la posición de la cabeza de trabajo en el paso $j$).

Definimos la clase de complejidad $\mathbf{P}_{/\mathrm{poly}}$ como:

$$\mathbf{P}_{/\mathrm{poly}} = \bigcup_{c} \mathbf{SIZE}(c \cdot n^c)$$

**Teorema:** $\mathbf{P} \subseteq \mathbf{P}_{/\mathrm{poly}}$.

[Demostración en las páginas 16-17](../teoricas/clase11.pdf).

**Teorema:** $\mathbf{P} \subsetneq \mathbf{P}_{/\mathrm{poly}}$.

[Demostración en la página 18](../teoricas/clase11.pdf).

---

### Notación para reemplazo de variables por constantes

**Notación: variables de una fórmula booleana.**
Si $\varphi$ es una fórmula booleana con variables entre $x_1, \dots, x_n$ (pueden ser menos), la notamos:

$$\varphi(x_1, \dots, x_n)$$

**Notación: reemplazo de variable por constante.**
Sea $\varphi(x_1, \dots, x_n)$ una fórmula booleana. Representamos:

$$\varphi(x_1, \dots, x_{i-1}, b, x_{i+1}, \dots, x_n)$$

a la fórmula booleana que resulta de reemplazar todas las apariciones de $x_i$ por $b \in \{0, 1\}$.

Notar que:

$$\underbrace{b_1 \dots b_n}_{\substack{\text{valuación} \\ v \in \{0,1\}^n}} \models \varphi(\underbrace{x_1, \dots, x_n}_{\text{variables}}) \quad \text{sii} \quad \models \varphi(\underbrace{b_1, \dots, b_n}_{\substack{\text{constantes} \\ v \in \{0,1\}^n}})$$

---

### Encontrar valuaciones booleanas (autoreducibilidad de $\mathbf{SAT}$)

Dada una fórmula satisfacible $\varphi(x_1, \dots, x_n)$, podemos encontrar bit a bit una valuación $v \in \{0, 1\}^n$ que la satisfaga usando consultas a $\mathbf{SAT}$:

1. **Determinación del primer bit ($x_1$):**
   Fijamos tentativamente $x_1 = 1$ y consultamos si la fórmula reducida sigue siendo satisfacible:
   * $\varphi(1, x_2, \dots, x_n) \in \mathbf{SAT} \implies \exists v \in \{0, 1\}^{n-1}$ tal que $v \models \varphi(1, x_2, \dots, x_n)$.
   * $\varphi(1, x_2, \dots, x_n) \notin \mathbf{SAT} \implies \exists v \in \{0, 1\}^{n-1}$ tal que $v \models \varphi(0, x_2, \dots, x_n)$.

   El bit $b_1 \in \{0, 1\}$ queda determinado por la función característica:
   $$b_1 = \chi_{\mathbf{SAT}}(\varphi(1, x_2, \dots, x_n))$$
   garantizando que la fórmula simplificada $\varphi(b_1, x_2, \dots, x_n)$ es satisfacible.

2. **Paso inductivo (siguientes bits):**
   Fijado $b_1$, determinamos $b_2$ probando $x_2 = 1$:
   $$b_2 = \chi_{\mathbf{SAT}}(\varphi(b_1, 1, x_3, \dots, x_n)) \in \{0, 1\}$$
   de modo que $\varphi(b_1, b_2, x_3, \dots, x_n)$ se mantiene satisfacible.

Repitiendo el proceso sucesivamente para cada variable $x_i$, tras $n$ llamadas a $\mathbf{SAT}$ se obtiene la valuación completa $(b_1, \dots, b_n)$ que satisface $\varphi$.

---

### Circuito para encontrar valuaciones booleanas

* **Codificación:** las fórmulas booleanas con constantes $\{0, 1\}$ se codifican en binario.
* **Entrada/salida:** toda fórmula de longitud $n$ tiene a lo sumo $n$ variables ($x_1, \dots, x_i$, con $i \le n$), y se consideran circuitos con múltiples salidas que computan funciones $\{0, 1\}^n \to \{0, 1\}^m$.

---

### Proposición (reducción de decisión a búsqueda en circuitos)

Sea $(C_n)_{n \in \mathbb{N}}$ una familia de circuitos de tamaño $S(n)$ que decide satisfacibilidad:

$$C_n(\varphi) = \chi_{\mathbf{SAT}}(\varphi), \quad \forall\, |\varphi| = n$$

Entonces existe una familia de circuitos $(C'_n)_{n \in \mathbb{N}}$ de tamaño $\mathrm{poly}(S(n))$ con $n$ salidas tal que:

$$\varphi(C'_n(\varphi)) = \chi_{\mathbf{SAT}}(\varphi)$$

> **Interpretación:** si se puede decidir $\mathbf{SAT}$ con circuitos de tamaño $S(n)$, se puede construir un circuito de tamaño polinomial en $S(n)$ que produce explícitamente un testigo/valuación que satisface la fórmula (siempre que esta sea satisfacible).

[Demostración en la página 22](../teoricas/clase11.pdf).

La idea de la demostración es ir retroalimentando la entrada con la salida de setear $x_i = 1$: si el resultado es 1, al intentar con la variable $x_{i+1}$ se pone un 1 en el lugar $i$-ésimo; caso contrario, se pone 0. Así se continúa hasta completar las $n$ variables.

---

### Problemas $\Pi^p_i$-completos

**Proposición:** para todo $i > 0$, $\Pi_i\mathrm{SAT}$ es $\Pi^p_i$-completo.

---

### Teorema de Karp-Lipton

**Teorema:** si $\mathbf{NP} \subseteq \mathbf{P}_{/\mathrm{poly}}$, entonces $\mathbf{PH} = \Sigma^p_2$.

[Demostración en las páginas 26-27](../teoricas/clase11.pdf).

---

## Tamaño y profundidad de circuitos

### Profundidad de un circuito

**Definición:** la **profundidad** de un circuito $C$, notada $\mathrm{prof}(C)$, es la longitud del camino más largo desde alguna entrada hasta alguna salida.

**Definición:** una familia de circuitos $(C_n)_{n \in \mathbb{N}}$ tiene profundidad $d(n)$ si $\mathrm{prof}(C_n) \leq d(n)$ para todo $n$.

---

### Conjunciones y disyunciones de aridad arbitraria

A veces vamos a considerar circuitos con $\land$ y $\lor$ de $\text{fan-in}$ arbitrario. Esto permite profundidades más bajas.