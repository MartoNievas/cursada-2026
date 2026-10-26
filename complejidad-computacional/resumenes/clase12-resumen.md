# Complejidad Computacional — Clase 12

**Complejidad Computacional — FCEyN, Universidad de Buenos Aires**

---

## Las clases $NC_{nu}$ y $AC_{nu}$

### Definiendo las clases $NC_{nu}$ y $AC_{nu}$

A continuacion vamos con la definicion de ambas clases de complejidad:

**Clase de complejidad: $NC^d_{nu}$ y $NC_{nu}$**

* **$NC^d_{nu}$** es la clase de complejidad de lenguajes decidibles por una familia de circuitos $(C_n)_{n \in N}$ tal que
    * $|C_n|$ es polinomial en $n$ y
    * $prof(C_n) = O(\log^d{n})$ 

* **$NC_{nu} = \bigcup_{i \geq 0} NC^i_{nu}$** 

**Clase de complejidad: $AC^d_{nu}$ y $AC_{nu}$**

* **$AC^d_{nu}$** se define igual que **$NC^d_{nu}$** pero permitimos nodos $\land$ y $\lor$ con $fan-in$ arbitrario.

* **$AC_{nu} = \bigcup_{i \geq 0} AC^i_{nu}$**

> **Nota:** el nombre 'nu' es por 'no uniforme'.

---

### Las clases $NC^0_{nu}, AC^0_{nu}, NC^1_{nu}$ y propiedades

Mientras que **$NC^0_{nu}$** es muy limitada debido a que solo depende de una cantidad finita de bits de entrada,  por otro lado tenemos la clase **$AC^0_{nu}$** que no tiene la misma limitacion por ejemplo el siguiente lenguaje pertenece:

$$
\{1^n : n \geq 1\} \in AC^0_{nu}
$$

[Demostración en las páginas 6](../teoricas/clase12.pdf).

**Proposicion:** $PARITY \in NC^1_{nu}$, donde $PARITY$ se define como:

**Proposicion:** $PARITY \notin AC^0{nu}$

$$
PARITY \space = \space {x: \text{x tiene una cantidad impar de 1s}}
$$

**Proposicion:** $SUMA \in AC^0_{nu}$. Donde $SUMA$ es:

[Demostración en las páginas 8](../teoricas/clase12.pdf).

$$
SUMA \space = \{xyz: |x| = |y| = i, |z| = i + 1, x + y = z, i \geq 1\}
$$

[Demostración en las páginas 9](../teoricas/clase12.pdf).

**Proposicion:** $NC^d_{nu} \subseteq AC^d_{nu} \subseteq NC^{d+1}_{nu}. Por lo tanto, AC_{nu} = NC_{nu}$

---

## Uniformidad: las clases $NC$ y $AC$

### Circuitos **P**-uniformes y **P**

Puede parecer extraño que lenguajes indecidibles esten en $\mathbf{P}_{/\mathrm{poly}}$. El origen de este fenomeno es la no uniformidad del modelo de circuitos.

**Definicion:** Una familia de circuitos $(C_n)_{n \in N}$ es **P-uniforme** si existe una maquina deterministica tal que

* $M$ corre en tiempo polinomial
* $M(1^n) = \langle C_n \rangle$

[Demostración en las páginas 12](../teoricas/clase12.pdf).

**Teorema:** $L$ es decidible por una familia **P**-uniforme de circuitos sii $L \in P$.

---

### Circuitos **L**-uniformes

**Definicion:** Una familia de circuitos $(C_n)_{n \in N}$ es **L-uniforme** si existe una funcion $f: \{0,1\}^0 \to \{0,1\}^0$ computable implicitamente en **L** tal que 

$$
f(1^n) = \langle C_n \rangle.
$$

[idea de la demostración en las páginas 14](../teoricas/clase12.pdf).

**Teorema:** $L$ es decidible por una familia de circuitos **L**-uniforme sii $L \in P$.

---

### Las clases $NC_{nu}$ y $AC_{nu}$ generadas **L**-uniformemente

Se definen igual que antes nada nuevo y se preservan todos los resultadas ya vistos con respecto a las clases.

---

### Computo paralelo

Decimos que un problema tiene una **solucion paralela eficiente** cuando puede ser resuelto para entradad de tamaño $n$ usando una computadora paralela con una cantidad polinomial ($n^{O(1)}$) de procesadores en tiempo polilogaritmico ($\log^{O(1)}{n}$).

**Teorema:** $L$ tiene una solucion paralela eficiente sii $L \in NC$.