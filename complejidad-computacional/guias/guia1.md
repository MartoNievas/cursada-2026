# Práctica 1: Introducción a máquinas de Turing

[Enunciados](enunciados/practica1.pdf)

## Órdenes

### Ejercicio 1

**a)** $f(n) = f(n-1) + 10$

Vamos a analizar la fórmula recursiva:

$$
\begin{aligned}
f(n) &= f(n-1) + 10 \\
f(n-1) &= f(n-2) + 10 \\
f(n-2) &= f(n-3) + 10 \\
&\;\;\vdots \\
f(0) &= 0
\end{aligned}
$$

Haciendo las sustituciones en la fórmula original nos queda:

$$
\begin{aligned}
f(n) &= f(n-1) + 10 \\
&= f(n-2) + 2 \cdot 10 \\
&= f(n-3) + 3 \cdot 10 \\
&\;\;\vdots \\
&= f(n-k) + k \cdot 10
\end{aligned}
$$

Si tomamos $k = n$, nos queda que:

$$
f(n) = 10 \cdot n
$$

Entonces $f(n) = \Theta(n)$.

---

**b)** $f(n) = f(n-1) + n$

Utilizamos el mismo procedimiento que en el inciso anterior:

$$
\begin{aligned}
f(n-1) &= f(n-2) + (n-1) \\
f(n-2) &= f(n-3) + (n-2) \\
f(n-3) &= f(n-4) + (n-3) \\
&\;\;\vdots \\
f(0) &= 0
\end{aligned}
$$

Sustituyendo llegamos a la fórmula:

$$
f(n) = f(n-k) + k \cdot n
$$

Tomando $k = n$ nos queda:

$$
f(n) = f(0) + n^2 = n^2
$$

Por lo tanto, $f(n) = \Theta(n^2)$.

---

**c)** $f(n) = 2 \cdot f(n-1)$

Teniendo en cuenta que el caso base es $f(0) = 0$, vamos a demostrar por inducción que $\forall n \geq 1, \; f(n) = 0$.

**Caso base** ($n = 1$):

$$
f(1) = 2 \cdot f(0) = 2 \cdot 0 = 0
$$

Es trivial que el caso base se cumple. Ahora vamos con el caso inductivo, para lo cual tenemos la siguiente hipótesis inductiva:

$$
P(k) \Rightarrow P(k+1)
$$

donde $P(k): f(k) = 0$, y queremos ver que:

$$
P(k+1): f(k+1) = 0
$$

Utilizando la fórmula recursiva tenemos que:

$$
f(k+1) = 2 \cdot f(k)
$$

Por hipótesis inductiva sabemos que $f(k) = 0$, por lo tanto $f(k+1) = 2 \cdot 0 = 0$.

Luego, vale para todo $n \geq 1$.

---

**d)** $f(n) = 2 \cdot f(n/2) + 10$

Notemos que la función entra dentro del caso 1 del teorema maestro, el cual dice:

$$
f(n) = O\left(n^{\log_b a - \epsilon}\right)
$$

Sabiendo que $a = 2$ y $b = 2$, tenemos que $\log_2 2 = 1$. Luego, si tomamos $\epsilon = 1$, se cumple que $10 = O(n^0)$.

Por lo tanto, el caso 1 nos dice que:

$$
f(n) = \Theta\left(n^{\log_b a}\right) = \Theta(n)
$$

---

**e)** $f(n) = 2 \cdot f(n/2) + n$

Aquí también vamos a utilizar el teorema maestro. Primero calculemos $\log_b a$, el cual es igual a $\log_2 2 = 1$, y notemos que $f(n) = n$, entonces entra en el caso 2, ya que $n = \Theta(n^{\log_2 2}) = \Theta(n)$.

Por lo tanto:

$$
T(n) = \Theta(n \cdot \log n)
$$

---

### Ejercicio 2

**($\Rightarrow$) Si $f(n) = O(g(n)) \implies L < \infty$**

1. Por hipótesis, $f(n) = O(g(n))$. Por definición, existen constantes $c > 0$ y $n_0 \in \mathbb{N}$ tales que:
   $$f(n) \leq c \cdot g(n) \quad \forall n \geq n_0$$

2. Como $g(n) > 0$, dividimos por $g(n)$:
   $$\frac{f(n)}{g(n)} \leq c \quad \forall n \geq n_0$$

3. Dado que por hipótesis el límite $L = \lim_{n \to \infty} \frac{f(n)}{g(n)}$ existe, aplicamos el límite cuando $n \to \infty$ a ambos lados de la desigualdad:
   $$\lim_{n \to \infty} \frac{f(n)}{g(n)} \leq \lim_{n \to \infty} c$$
   $$L \leq c$$

4. Como $c$ es una constante real finita, concluimos que:
   $$L < \infty$$

---

**($\Leftarrow$) Si $L = \lim_{n \to \infty} \frac{f(n)}{g(n)} < \infty$**

Esto quiere decir que existe el límite. Entonces, por la definición de límite, para todo $\epsilon > 0$ existe un $n_0 \in \mathbb{N}$ tal que, para todo $n \geq n_0$:

$$
\left| \frac{f(n)}{g(n)} - L \right| < \epsilon
$$

Despejando el valor absoluto nos queda:

$$
L - \epsilon < \frac{f(n)}{g(n)} < L + \epsilon
$$

Si fijamos $\epsilon = 1$, para todo $n \geq n_0$ tenemos:

$$
\frac{f(n)}{g(n)} < L + 1
$$

Multiplicando por $g(n)$ (ya que $g(n) > 0$):

$$
f(n) < (L + 1) \cdot g(n)
$$

Si tomamos $L+1$ como la constante $c$, entonces tenemos la definición de $f(n) = O(g(n))$.

---

Sean $f, g > 0$ tales que $L = \lim_{n \to \infty} \frac{f(n)}{g(n)}$ existe. Los criterios análogos son:

* **Para $o$ (little-o):**
  $$f(n) = o(g(n)) \iff L = 0$$

* **Para $\Omega$ (big-omega):**
  $$f(n) = \Omega(g(n)) \iff L > 0 \quad (\text{incluye } L = \infty)$$

* **Para $\omega$ (little-omega):**
  $$f(n) = \omega(g(n)) \iff L = \infty$$

* **Para $\Theta$ (big-theta):**
  $$f(n) = \Theta(g(n)) \iff 0 < L < \infty$$

---

### Ejercicio 3

**a)** $f(n) = 50n$, $g(n) = n \log n$

Utilicemos los criterios del punto anterior. Vamos primero con $g = o(f)$:

$$
\lim_{n \to \infty} \frac{n \log n}{50n} = \lim_{n \to \infty} \frac{\log n}{50} = \infty
$$

Por lo tanto, $g \neq o(f)$.

Notar que, por el límite de la fracción inversa, sí se cumple que $f = o(g)$ (el límite es $0$).

Por último, veamos si $f = \Theta(g)$: por el resultado anterior, $L = 0$ en el límite de $\frac{f(n)}{g(n)}$, por lo tanto $f \neq \Theta(g)$.

---

**b)** $f(n) = n^2$, $g(n) = 2n^2 + 100\sqrt{n}$

La misma idea que en el inciso anterior. Empecemos por $g = o(f)$:

$$
\lim_{n \to \infty} \frac{2n^2 + 100\sqrt{n}}{n^2} = 2
$$

El límite es $L = 2$ (por reglas de análisis 1), por lo tanto $g \neq o(f)$.

De la misma manera, $f \neq o(g)$, ya que el límite en ese sentido sería $L = \frac{1}{2} \neq 0$.

Nos queda ver si $f = \Theta(g)$. Para eso utilizamos el criterio del límite:

$$
\lim_{n \to \infty} \frac{n^2}{2n^2 + 100\sqrt{n}} = \frac{1}{2}
$$

Y por el criterio de $\Theta$, vale que $f = \Theta(g)$.

---

**c)** $f(n) = n^{100}$, $g(n) = 2^{\frac{n}{100}}$

Veamos primero $g = o(f)$, para lo cual analizamos el límite:

$$
\begin{aligned}
\lim_{n \to \infty} \frac{2^{\frac{n}{100}}}{n^{100}}
&= \lim_{n \to \infty} \frac{\frac{d^{100}}{dn^{100}} \left( 2^{\frac{n}{100}} \right)}{\frac{d^{100}}{dn^{100}} \left( n^{100} \right)} \\
&= \lim_{n \to \infty} \frac{\left( \frac{\ln 2}{100} \right)^{100} 2^{\frac{n}{100}}}{100!} \\
&= \frac{\left( \frac{\ln 2}{100} \right)^{100}}{100!} \cdot \lim_{n \to \infty} 2^{\frac{n}{100}} \\
&= \infty
\end{aligned}
$$

Como el límite no existe (diverge), entonces $g \neq o(f)$.

Ahora vamos con $f = o(g)$, utilizando L'Hôpital:

$$
\begin{aligned}
\lim_{n \to \infty} \frac{n^{100}}{2^{\frac{n}{100}}}
&= \lim_{n \to \infty} \frac{\frac{d^{100}}{dn^{100}} \left( n^{100} \right)}{\frac{d^{100}}{dn^{100}} \left( 2^{\frac{n}{100}} \right)} \\
&= \lim_{n \to \infty} \frac{100!}{\left( \frac{\ln 2}{100} \right)^{100} 2^{\frac{n}{100}}} \\
&= \frac{100!}{\left( \frac{\ln 2}{100} \right)^{100}} \cdot \lim_{n \to \infty} \frac{1}{2^{\frac{n}{100}}} \\
&= \frac{100!}{\left( \frac{\ln 2}{100} \right)^{100}} \cdot 0 \\
&= 0
\end{aligned}
$$

Como el límite $L = 0$, esto quiere decir que se cumple que $f = o(g)$.

Por último nos queda ver si $f = \Theta(g)$. Como el límite anterior fue $L = 0$, y la regla para $f = \Theta(g)$ exige que $0 < L < \infty$, entonces $f \neq \Theta(g)$.

---

### Ejercicio 4

Primero vamos a probar que $\sim_\Theta$ es una relación de equivalencia; para eso debemos demostrar que es reflexiva, simétrica y transitiva.

Por enunciado sabemos que $f \in \mathbf{F}$, el conjunto de funciones no negativas, por lo tanto $f(n) \geq 0 \; \forall n \in \mathbb{N}$.

La relación $\sim_\Theta$ se define sobre $\mathbf{F}$ como:

$$
f \sim_\Theta g \iff f = \Theta(g)
$$

**Reflexiva:**

Es decir, $f \sim_\Theta f$. Basta con ver que $f = \Theta(f)$. Por definición de $\Theta$ sabemos que esto es equivalente a que existan $c_1, c_2 > 0$ y un $n_0 \in \mathbb{N}$ tales que:

$$
0 \leq c_1 f(n) \leq f(n) \leq c_2 f(n), \; \forall n \geq n_0
$$

Si tomamos las constantes $c_1$ y $c_2$ iguales a $1$, la desigualdad queda trivial. Por lo tanto, la relación $\sim_\Theta$ sobre $\mathbf{F}$ es reflexiva.

**Simétrica:**

Tenemos que probar que si $f \sim_\Theta g \Rightarrow g \sim_\Theta f$.

Tomemos como hipótesis que $f \sim_\Theta g$, es decir, $f = \Theta(g)$. Por lo tanto, existen $c_1, c_2 > 0$ y un $n_0 \in \mathbb{N}$ tales que:

$$
0 \leq c_1 g(n) \leq f(n) \leq c_2 g(n), \; \forall n \geq n_0
$$

Queremos ver que $g \sim_\Theta f$, es decir, $g = \Theta(f)$, lo cual por definición de $\Theta$ es equivalente a que existan $c_1', c_2' > 0$ y un $n_0' \in \mathbb{N}$ tales que:

$$
0 \leq c_1' f(n) \leq g(n) \leq c_2' f(n), \; \forall n \geq n_0'
$$

Si tomamos $c_1' = \frac{1}{c_2}$, $c_2' = \frac{1}{c_1}$ y $n_0' = n_0$, nos queda:

$$
0 \leq \frac{1}{c_2} f(n) \leq g(n) \leq \frac{1}{c_1} f(n), \; \forall n \geq n_0
$$

Despejando ambas desigualdades de la hipótesis, vemos que son equivalentes a la que queríamos demostrar. Por lo tanto, la relación también es simétrica.

**Transitiva:**

Esta es un poco más directa. Tenemos que ver que si $f \sim_\Theta g \; \land \; g \sim_\Theta h \Rightarrow f \sim_\Theta h$.

Vamos directo con la definición de $\Theta$ para la hipótesis:

$$
0 \leq c_1 g(n) \leq f(n) \leq c_2 g(n), \; \forall n \geq n_0
$$
$$
0 \leq c_1' h(n) \leq g(n) \leq c_2' h(n), \; \forall n \geq n_0'
$$

con todas las constantes $c > 0$ y $n_0, n_0' \in \mathbb{N}$.

Para simplificar, tomemos todas las constantes iguales a $1$:

$$
0 \leq g(n) \leq f(n) \leq g(n), \; \forall n \geq n_0
$$
$$
0 \leq h(n) \leq g(n) \leq h(n), \; \forall n \geq n_0'
$$

Como $\leq$ es transitiva, podemos afirmar que:

$$
0 \leq h(n) \leq f(n) \leq h(n), \; \forall n \geq n_0'
$$

Por lo tanto, $f = \Theta(h)$, luego vale que $f \sim_\Theta h$. Por lo tanto, es transitiva.

**Infinitas clases de equivalencia**

Ahora debemos demostrar que $\mathbf{F}/\sim_\Theta$ tiene infinitas clases de equivalencia.

1. **Construcción de una familia de funciones**

    Consideremos la familia de funciones polinómicas indexadas por $k \in \mathbb{N}$:
    $$
    f_k(n) = n^k, \quad \text{para } k \geq 1
    $$
    Todas estas funciones pertenecen a $\mathbf{F}$, pues $n^k \geq 0, \; \forall n \in \mathbb{N}$.

2. **Prueba de no equivalencia entre elementos distintos**

    Primero debemos ver que no haya dos elementos distintos en la misma clase de equivalencia.

    Sean dos índices distintos $a, b$ con $a \neq b$ y $a < b$.

    Evaluamos el límite del cociente de ambas funciones cuando $n \to \infty$:

    $$
    \lim_{n \to \infty} \frac{f_a(n)}{f_b(n)} = \lim_{n \to \infty} \frac{n^a}{n^b} = \lim_{n \to \infty} \frac{1}{n^{b-a}}
    $$

    Como $b - a > 0$, el denominador tiende a infinito:

    $$
    \lim_{n \to \infty} \frac{1}{n^{b-a}} = 0
    $$

    Como el límite del cociente es $0$, por el criterio del límite de $\Theta$ concluimos que $f_a \not\sim_\Theta f_b$ cuando $a \neq b$.

    Por lo tanto, cada función $f_k(n) = n^k$ define su propia clase de equivalencia $k$-ésima $[n^k]$. Como el conjunto de índices $\mathbb{N}$ es infinito, las clases de equivalencia $[n^k]$ también lo son. Luego, $\mathbf{F}/\sim_\Theta$ contiene infinitas clases de equivalencia distintas.

---

### Ejercicio 5

Es la misma idea que el ejercicio anterior.

---

### Ejercicio 6

Aquí tenemos que demostrar que $\forall k \geq 0$ y $c > 1$ vale que $n^k = o(c^n)$, es decir, que cualquier polinomio crece más lento que cualquier función exponencial.

Por definición de la notación $o$-pequeña mediante límites, esto equivale a probar que:

$$
\lim_{n \to \infty} \frac{n^k}{c^n} = 0
$$

Vamos a utilizar inducción en $k$.

**Caso base ($k = 0$):**

$$
\lim_{n \to \infty} \frac{n^0}{c^n} = \lim_{n \to \infty} \frac{1}{c^n} = 0
$$

Como $c > 1$, el denominador diverge a infinito mientras que el numerador es constante, por lo tanto vale el caso base.

**Caso inductivo:**

Queremos ver que $P(k) \Rightarrow P(k+1)$, donde nuestra hipótesis inductiva es:

$$
P(k): \lim_{n \to \infty} \frac{n^k}{c^n} = 0
$$

Y queremos probar que vale $P(k+1)$, es decir:

$$
P(k+1): \lim_{n \to \infty} \frac{n^{k+1}}{c^n} = 0
$$

Tomando el límite y aplicando la regla de L'Hôpital (derivando numerador y denominador respecto de $n$):

$$
\begin{aligned}
\lim_{n \to \infty} \frac{n^{k+1}}{c^n}
&= \lim_{n \to \infty} \frac{(k+1) \cdot n^k}{\ln(c) \cdot c^n} \\
&= \frac{k+1}{\ln(c)} \cdot \lim_{n \to \infty} \frac{n^k}{c^n}
\end{aligned}
$$

Usando la hipótesis inductiva, sabemos que $\lim_{n \to \infty} \frac{n^k}{c^n} = 0$, por lo tanto:

$$
\frac{k+1}{\ln(c)} \cdot 0 = 0
$$

Queda demostrado el paso inductivo, y concluimos que $n^k = o(c^n)$ para todo $k \geq 0$ y $c > 1$.

---

### Ejercicio 8

**a)** Si $f(n) = \Theta(g(n))$, entonces $2^{f(n)} = \Theta(2^{g(n)})$.

La afirmación es **falsa**. Damos el siguiente contraejemplo: $f(n) = 2n$ y $g(n) = n$.

Se cumple que $2n = \Theta(n)$: usando el criterio del límite obtenemos $L = 2$, y $0 < 2 < \infty$.

Ahora, si analizamos $2^{2n}$ frente a $2^n$, vemos el siguiente límite:

$$
\lim_{n \to \infty} \frac{2^{2n}}{2^n} = \lim_{n \to \infty} 2^{n} = \infty
$$

Por lo tanto, $2^{f(n)} \neq \Theta(2^{g(n)})$.

---

**b)** $f(n) = 2^{\Theta(\log n)}$ si y solamente si $f(n)$ es un polinomio.

La afirmación es **falsa**. Mostraremos un contraejemplo para el sentido ($\Rightarrow$): una función que cumple $f(n) = 2^{\Theta(\log n)}$ pero no es un polinomio.

Tomemos $f(n) = \sqrt{n} = n^{1/2}$.

Reescribiendo la función en base $2$:

$$
f(n) = n^{1/2} = 2^{\log_2\left(n^{1/2}\right)} = 2^{\frac{1}{2}\log_2 n}
$$

El exponente es $h(n) = \frac{1}{2}\log_2 n$. Tomando $c_1 = \frac{1}{4}$ y $c_2 = 1$, para todo $n \geq 1$:

$$
c_1 \log_2 n \leq \frac{1}{2}\log_2 n \leq c_2 \log_2 n \implies \frac{1}{2}\log_2 n = \Theta(\log n)
$$

Por lo tanto:

$$
\sqrt{n} = 2^{\Theta(\log n)}
$$

Sin embargo, por definición algebraica, un polinomio solo admite potencias con exponentes enteros no negativos ($k \in \mathbb{N}_0$). Como el exponente de $\sqrt{n}$ es $\frac{1}{2} \notin \mathbb{N}_0$, $f(n) = \sqrt{n}$ **no es un polinomio**.

Al existir una función que pertenece a $2^{\Theta(\log n)}$ pero no es un polinomio, la doble implicación es falsa.

---

## Modelos de cómputo

### Ejercicio 9 (Preguntar a los profesores)

**(a)** Máquina de Turing con cinta bi-infinita

- **Descripción de la simulación:** la máquina bi-infinita imita de forma idéntica las transiciones de la máquina semi-infinita. Para evitar que la cabeza se mueva a la izquierda de la posición inicial (lo cual causaría un comportamiento no deseado si la máquina simulada dependiera de rebotar en el extremo izquierdo), la máquina simuladora simplemente emula la restricción física estándar de que, si la cabeza intenta moverse a la izquierda de la primera celda, se quede inmóvil.

- **Complejidad:** cada transición de la máquina semi-infinita se simula en exactamente $1$ paso de la máquina bi-infinita. Si la máquina original corre en tiempo $T(n)$, la simulación toma tiempo $O(T(n))$, lo cual es lineal.

**(b)**

- **Descripción de la simulación:**

- **Complejidad:**

**(c)**

- **Descripción de la simulación:**

- **Complejidad:**

---

### Ejercicio 10

**1. Prueba por cardinalidad**

Un lenguaje $L$ es un conjunto de palabras sobre el alfabeto $\{0,1\}^*$.

*El conjunto de todos los lenguajes es no numerable.*

Por definición sabemos que $\{0,1\}^*$ es infinito numerable, ya que sus elementos se pueden listar en un orden bien definido.

Un lenguaje $L$ es un subconjunto de $\{0,1\}^*$, por lo tanto el conjunto de todos los lenguajes posibles es $\mathcal{P}(\{0,1\}^*)$, que por el **teorema de Cantor** sabemos que tiene cardinalidad $2^{\aleph_0}$.

*El conjunto de lenguajes computables es numerable.*

También por definición sabemos que cada lenguaje computable es decidido por una máquina de Turing $M$, y esta misma máquina tiene su representación en binario $\langle M \rangle \in \{0,1\}^*$ (recordar que las palabras que no siguen el patrón de codificación de las máquinas de Turing representan a una máquina trivial).

De esta forma podemos construir una función biyectiva que mapea las máquinas de Turing al conjunto numerable $\{0,1\}^*$, por lo tanto las máquinas de Turing son un conjunto numerable, y en consecuencia el conjunto de lenguajes computables también lo es.

**Conclusión:** dado que el conjunto de todos los lenguajes posibles tiene cardinalidad $2^{\aleph_0}$ y el conjunto de lenguajes computables tiene cardinalidad $\aleph_0$, es imposible establecer una biyección entre ambos conjuntos. Por lo tanto, existe una cantidad no numerable de lenguajes que no son computables.

---

**2. Definición de un lenguaje no computable por diagonalización**

**Construcción:**

1. Enumeramos de manera ordenada todas las palabras (por ejemplo, en orden lexicográfico):

    $$
    w_1, w_2, w_3, w_4, \dots
    $$

2. Asociamos a cada palabra $w_i$ la máquina de Turing $M_i$ que tiene a $w_i$ como su codificación binaria. Obtenemos así una lista ordenada de todas las máquinas de Turing posibles:

    $$
    M_1, M_2, M_3, M_4, \dots
    $$

3. Definimos el **lenguaje diagonal $L_D$** de la siguiente manera:

    $$
    L_D = \{w_i \in \{0,1\}^* : M_i \text{ no acepta a } w_i\}
    $$

**Demostración de que $L_D$ no es computable:**

Supongamos que el lenguaje $L_D$ es computable (decidible).

- Si $L_D$ fuera computable, entonces debería existir una máquina de Turing $M_k$ en nuestra lista que decida $L_D$.

- Por definición de decidibilidad, para cualquier palabra en $\{0,1\}^*$ se debe cumplir que:

$$
w \in L_D \iff M_k \text{ acepta } w
$$

Pero si tomamos $w = w_k$, es decir, la palabra que tiene el mismo índice que nuestra máquina de Turing que decide $L_D$, nos queda:

$$
w_k \in L_D \iff M_k \text{ acepta } w_k
$$

Esto es una contradicción, ya que por definición del lenguaje $L_D$, $M_k$ rechaza $w_k$. El absurdo vino de suponer que $L_D$ es computable. Por lo tanto, queda definido un lenguaje no computable por diagonalización.

---

### Ejercicio 11

**Descripción de la simulación:**

Una máquina de Turing que no es *oblivious* puede decidir hacia dónde mover su cabeza dependiendo de los símbolos que va leyendo. En cambio, una máquina oblivious tiene que tener el recorrido de su cabeza determinado solamente por el tiempo, es decir, no puede depender de la entrada.

Para simular la máquina original, podemos hacer que la máquina oblivious recorra la cinta siguiendo un recorrido predeterminado y mantenga la información necesaria para saber qué posición de la máquina original está simulando. De esta forma, aunque la máquina simuladora no pueda moverse directamente a la posición que necesita, puede encontrar y actualizar la información realizando recorridos sobre la cinta.

**Complejidad:**

La máquina original realiza como máximo $T(n)$ pasos. Para cada uno de estos pasos, la máquina oblivious puede necesitar realizar un recorrido de hasta $O(T(n))$ para encontrar la información correspondiente.

Por lo tanto, el tiempo total de la simulación es:

$$
O(T(n)) \cdot O(T(n)) = O\left(T(n)^2\right)
$$

Por lo tanto, toda máquina de Turing que utilice tiempo $T(n)$ puede ser simulada por una máquina oblivious utilizando tiempo $O(T(n)^2)$.

---

### Ejercicio 12

**Descripción de la simulación:**

Una máquina de Turing que no es oblivious puede decidir qué posiciones de la cinta utilizar dependiendo de los símbolos que va leyendo. En cambio, una máquina oblivious tiene que utilizar un recorrido de la cinta que no dependa de la entrada.

Como la máquina original utiliza a lo sumo $T(n)$ celdas de la cinta, la máquina oblivious solo necesita representar esas $T(n)$ celdas. Podemos hacer que la máquina simuladora recorra estas posiciones siguiendo un orden fijo, independientemente de la entrada, y mantenga en cada posición la información que tendría la máquina original.

**Complejidad:**

Como la máquina original utiliza $T(n)$ celdas de la cinta, la máquina oblivious necesita como máximo $T(n)$ celdas para representar la configuración necesaria de la máquina original.

Por lo tanto, podemos concluir que toda máquina de Turing que utilice espacio $T(n)$ puede ser simulada por una máquina oblivious utilizando espacio $O(T(n))$.

---

### Ejercicio 13

**Descripción de la simulación:**

Sabemos que la máquina original tarda $T(n)$ pasos en terminar. Para simular esta máquina podemos utilizar la representación binaria de los símbolos del alfabeto: reemplazamos cada símbolo de $\Gamma$ por una secuencia de aproximadamente $\log|\Gamma|$ símbolos en un alfabeto binario.

**Complejidad:**

De aquí sale la complejidad $T(n) \cdot \log|\Gamma|$ de la simulación. En cada paso, la máquina original puede:

- Leer un símbolo de $\Gamma$.
- Escribir un símbolo de $\Gamma$.
- Moverse.

En la máquina que definimos, cada símbolo de $\Gamma$, representado ahora como una secuencia de bits, ocupa $\log|\Gamma|$ posiciones.

Entonces, para leer o modificar un símbolo, la máquina simulada debe recorrer en el peor de los casos $\log|\Gamma|$ posiciones por cada paso de su ejecución. De ahí se obtiene esa complejidad.