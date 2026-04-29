# Complejidad Computacional — Clase 8

## Espacio logarítmico: L y NL

Las clases de complejidad **L** y **NL** se definen de la siguiente manera:

$$L = \text{SPACE}(\log n)$$

$$NL = \text{NSPACE}(\log n)$$

> **Observación:** $L \subseteq NL \subseteq P$. A continuación demostramos esta proposición.

**Demostración:** Si $S$ es construible en espacio, sabemos por clases anteriores que $\text{NSPACE}(S(n)) \subseteq \text{DTIME}(2^{O(S(n))})$. Tomamos $S(n) = \log n$. $\square$

---

### Ejemplo: EVEN ∈ L

Sea el problema:

$$\text{EVEN} = \{x \in \{0,1\}^* : \text{hay una cantidad par de 1s en } x\}$$

Para demostrar que $\text{EVEN} \in L$, construimos una máquina de Turing determinística $M$ que decide **EVEN** en espacio $O(\log n)$.

> **Nota:** La codificación de un número $x$ en binario tiene longitud $O(\log n)$, es decir, $x$ ocupa espacio logarítmico.

La máquina $M$ funciona así:

1. Crear variable `paridad = 1`. Si no se cuenta ningún 1, hay cero unos, que es par. Costo: $O(1)$.
2. Recorrer $x$ bit a bit: si el bit actual es 1, invertir el valor de paridad con `paridad = x[i] - paridad`. Costo espacial: $O(\log n)$.
3. Si `paridad = 1`, aceptar; si `paridad = 0`, rechazar.

La complejidad espacial total es $O(\log n)$, luego $\text{EVEN} \in L$. $\square$

---

### Ejemplo de problema en NL

**Problema PATH** (existencia de un camino de $s$ a $t$)

No sabemos si **PATH** $\in L$, pero sí sabemos que:

> **Proposición:** **PATH** $\in$ **NL**.

[Demostración a partir de página 7](../teoricas/clase8.pdf)

---

### Reducibilidad para NL

Recordemos que para la pregunta $P = NP$ usamos la reducibilidad polinomial $\leq_p$. Para la pregunta $L = NL$, esta no nos sirve.

> **Proposición:** Si $\mathcal{L} \notin \{\{0,1\}^*, \emptyset\}$, entonces $\mathcal{L}$ es **NL-hard** con respecto a $\leq_p$.

[Demostración en página 8](../teoricas/clase8.pdf)

---

## Funciones computables en L

### Computable implícitamente en L

> **Definición:** Una función $f$ es **computable implícitamente en L** si:
> - Existe un polinomio $p$ tal que para todo $x \in \{0,1\}^*$, $|f(x)| \leq p(|x|)$.
> - $\{\langle x, i \rangle : f(x)(i) = 1\}$ y $\{\langle x, i \rangle : i \leq |f(x)|\}$ están en **L**.

### Trabajo-L computable

> **Definición:** Una función $f$ es **trabajo-L computable** si existe una máquina determinística que computa $f$ en espacio $O(\log n)$, contando solo el espacio de las cintas de trabajo y no el de la cinta de salida.

> **Ejercicio:** Una función es computable implícitamente en **L** si y solo si es trabajo-**L** computable.

**($\Rightarrow$)** Si tenemos un algoritmo que decide el bit $i$ usando espacio $\log n$, podemos construir una máquina que itera desde $i = 1$ hasta $|f(x)|$, calcula cada bit y lo escribe en la cinta de salida. Como solo guarda el índice $i$ en la cinta de trabajo (que mide $\log |f(x)|$), y en reducciones típicas $|f(x)|$ es polinomial, entonces $\log |f(x)| = O(\log n)$.

**($\Leftarrow$)** Si tenemos una máquina que escribe $f(x)$ en la cinta de salida usando espacio $\log n$, para saber el bit $i$ basta simular esa máquina llevando un contador de cuántos bits se han "generado". Cuando el contador llega a $i$, ese es el resultado.

---

### Composición de funciones computables implícitamente en L

> **Proposición:** Sean $f, g$ computables implícitamente en **L**. Entonces $g \circ f$ es computable implícitamente en **L**.

[Demostración a partir de página 12](../teoricas/clase8.pdf)

---

## Reducibilidad L

> **Definición:** $\mathcal{L}$ es **L-reducible** a $\mathcal{L}'$, notado $\mathcal{L} \leq_l \mathcal{L}'$, si existe una función $f$ computable implícitamente en **L** tal que para todo $x$:
> $$x \in \mathcal{L} \iff f(x) \in \mathcal{L}'$$

Con esta definición podemos hacer una analogía con las clases **NP-hard** y **NP-completo**, pero utilizando la reducibilidad **L**.

---

> **Ejercicio:** Si $\mathcal{L} \leq_l \mathcal{L}'$ y $\mathcal{L}' \in L$, entonces $\mathcal{L} \in L$.

**Demostración:** Como $\mathcal{L} \leq_l \mathcal{L}'$, existe $f$ computable implícitamente en L tal que $x \in \mathcal{L} \iff f(x) \in \mathcal{L}'$. Como $\mathcal{L}' \in L$, existe una máquina $M$ determinística que decide $\mathcal{L}'$ en espacio $O(\log n)$.

Construimos $M'$ que decide $\mathcal{L}$:

1. Simular $M$, que espera leer $f(x)$ como entrada.
2. Cada vez que $M$ quiere leer el símbolo $i$-ésimo de su entrada, $M'$ computa el $i$-ésimo bit de $f(x)$ en espacio $O(\log n)$.
3. Continuar la simulación de $M$.

La complejidad espacial total es $O(\log n)$, por lo tanto $\mathcal{L} \in L$. $\square$

---

> **Ejercicio:** La relación $\leq_l$ es transitiva.

**Demostración:** Si $\mathcal{L} \leq_l \mathcal{L}'$ y $\mathcal{L}' \leq_l \mathcal{L}''$, existen $f$ y $f'$ computables implícitamente en L tales que:

$$x \in \mathcal{L} \iff f(x) \in \mathcal{L}' \iff f'(f(x)) \in \mathcal{L}''$$

Por la proposición de composición, $f' \circ f$ también es computable implícitamente en L, luego $\mathcal{L} \leq_l \mathcal{L}''$. $\square$

---

## Teorema de Immerman-Szelepcsényi

> **Teorema:** PATH es **NL-completo**.

[Demostración a partir de página 17](../teoricas/clase8.pdf)

### Caracterización de NL con certificados

Se puede dar un verificador y certificado que use espacio $O(\log n)$.

> **Teorema (Immerman-Szelepcsényi):** $\overline{\text{PATH}} \in NL$.

[Demostración a partir de página 20](../teoricas/clase8.pdf)

### Versión general

> **Teorema:** Si $S(n) \geq \log n$ es construible en espacio, entonces $\text{NSPACE}(S(n)) = \text{coNSPACE}(S(n))$.
