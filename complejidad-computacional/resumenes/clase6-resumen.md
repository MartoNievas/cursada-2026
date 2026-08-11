# Complejidad Computacional — Clase 6

**Complejidad Computacional — FCEyN, Universidad de Buenos Aires**

---

## 1. La jerarquía de tiempos determinísticos

### 1.1 Notación de 'o chica' ($o$)

**Definición:** Sean $f,g : \mathbb{N} \to \mathbb{N}$. Decimos que $f(n) \in o(g(n))$ si para todo $\epsilon > 0$:

$$
f(n) \leq \epsilon \cdot g(n)
$$

para todo $n$ suficientemente grande o, equivalentemente, si:

$$
\lim_{n \to \infty} \frac{f(n)}{g(n)} = 0
$$

> **Nota:** Si $f(n) \in o(g(n))$, entonces $f(n) \in O(g(n))$.

### 1.2 Re-codificación de máquinas determinísticas

Ahora vamos a codificar cada máquina $M$ con *infinitas* cadenas $\langle \langle M \rangle, z \rangle$ para cualquier $z \in \{0,1\}^*$.

Lo importante es que dada una máquina $M$ existen infinitos $i$ tal que $M = M_i$.

**Teorema:** Si $f,g$ son construibles en tiempo y cumplen que:

$$
f(n) \cdot \log(f(n)) = o(g(n))
$$

[Demostración en página 8](../teoricas/clase6.pdf)

### 1.3 Diagonalización

Es la técnica usada para demostrar que el problema $\text{HALT}$ no es computable.

Para eso definimos una máquina $D$ tal que:

* $D$ corre en tiempo $O(g(n))$.
* $D$ se porta distinto a todas las máquinas que corren en tiempo $O(f(n) \cdot \log(f(n)))$, esta niega la salida de $M_x(x)$:
    * Cuando $M_x(x) = 1$, $D(x) = 0$.
    * Cuando $M_x(x) = 0$, $D(x) = 1$.
* $D$ puede diagonalizar en tiempo $O(n^3)$ y definir una función no computable en tiempo $O(n^2)$.

---

## 2. La jerarquía de tiempos no-determinísticos

### 2.1 Jerga de cómputos en máquinas no-determinísticas

Recordemos que un cómputo en una máquina no-determinística $N$, a partir de $x \in \{0,1\}^*$, es una secuencia $C_0, \dots, C_l$ de configuraciones tal que:

* $C_0$ es la configuración inicial a partir de $x$.
* $C_{i+1}$ es la evolución en un paso de $C_i$ dada por alguna de las 2 tuplas de $\delta$.
* $C_l$ está en estado $q_{\text{si}}$ o $q_{\text{no}}$.

### 2.2 Codificación de cómputos en máquinas no-determinísticas

Para codificar un cómputo de $N$ con una secuencia $y \in \{0,1\}^*$ que representa las alternativas de $\delta$, si $N$ es una máquina no-determinística que corre en tiempo $T(n)$, toda cadena de $y_x \in \{0,1\}^{T(|x|)}$ representa un cómputo de $N$ a partir de $x$.

> **Observación:** Secuencias más cortas que $T(|x|)$ son posiblemente cómputos incompletos.

### 2.3 Re-codificación de máquinas no-determinísticas

Ahora hacemos lo mismo que hicimos para máquinas determinísticas, entonces la nueva codificación es:

$$
(N_i)_{i \in \{0,1\}^*}
$$

tal que para toda máquina no-determinística $N$ existen infinitos $i$ tal que $N = N_i$.

**Teorema:** Si $f,g$ son construibles en tiempo, no decrecientes y cumplen que:

$$
f(n+1) \in o(g(n))
$$

entonces $\text{NDTIME}(f(n)) \subseteq \text{NDTIME}(g(n))$.

[Demostración a partir de la página 17](../teoricas/clase6.pdf)

---

## 3. Teorema de Ladner

### 3.1 Problemas **NP**-intermedios

**Teorema (Ladner):** Si $P \neq NP$, entonces existe un lenguaje $L$ tal que $L \in NP$, $L \notin P$, y $L$ no es $NP$-completo.

[Demostración a partir de la página 23](../teoricas/clase6.pdf)

Vamos con unas cuantas proposiciones a partir de esta demostración:

* **Proposición 1:** $SAT_H \in P \implies \exists c, \forall n, H(n) \leq c$.

[Demostración a partir de la página 25](../teoricas/clase6.pdf)

* **Proposición 2:** $\exists c, \exists^\infty n, H(n) \leq c \implies SAT_H \in P$.

[Demostración a partir de la página 26](../teoricas/clase6.pdf)

* **Proposición 3:** Existe $k$ tal que para todo $\psi$, $|\psi| > k \implies |F_{\psi}| < |\psi|$.

[Demostración a partir de la página 29](../teoricas/clase6.pdf)

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| Notación $o(g(n))$ | $f(n)/g(n) \to 0$; es una cota asintótica más fuerte que $O(g(n))$. |
| Re-codificación $\langle\langle M\rangle, z\rangle$ | Cada máquina tiene infinitos índices $i$ que la representan, lo cual es necesario para diagonalizar sobre todas las máquinas de una clase de tiempo. |
| Diagonalización | Técnica para construir una máquina $D$ que se comporta distinto a cualquier máquina de una clase de tiempo dada, usada para probar separaciones de clases (p. ej. HALT no computable). |
| Jerarquía de tiempos determinísticos | Si $f,g$ son construibles en tiempo y $f(n)\log f(n) = o(g(n))$, entonces $DTIME(f(n)) \subsetneq DTIME(g(n))$. |
| Jerarquía de tiempos no-determinísticos | Si $f,g$ son construibles en tiempo, no decrecientes, y $f(n+1) = o(g(n))$, entonces $NDTIME(f(n)) \subsetneq NDTIME(g(n))$. |
| Teorema de Ladner | Si $P \neq NP$, existe un lenguaje $L \in NP$ tal que $L \notin P$ y $L$ no es NP-completo (un problema "NP-intermedio"). |
