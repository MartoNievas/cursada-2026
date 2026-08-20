# Práctica 1: Introducción a máquinas de Turing

[Enunciados](enunciados/practica1.pdf)

## Ordenes

### Ejercicio 1

a) $f(n) \space = \space f(n - 1) \space + 10$

Vamos a analizar la formula recursiva:

$$
f(n) \space = \space f(n-1) + 10 \\
f(n-1) \space = \space f(n-2) \space + \space 10 \\
f(n-2) \space = \space f(n-3) \space + \space 10 \\
\dots \\
f(0) = 0
$$

Haciendo las sustituciones en la formula original nos queda:

$$
f(n) \space = \space f(n-1) + 10 \\
= f(n-2) \space + 2 \cdot 10 \\
= f(n-3) \space + 3 \cdot 10 \\
... \\
= f(n - k) \space + k \cdot 10 
$$

Luego si tomamos $k = n$ nos queda que 

$$
f(n) \space = 10 \cdot n 
$$

Entonces $f(n) \space = \space \Theta(n)$

b) $f(n) \space = \space f(n-1) \space + \space n$

Utilizamos el mismo procedimiento que en el ejercicio anterior y nos queda:

$$
f(n-1) \space = \space f(n-2) + (n-1) \\
f(n-2) \space = \space f(n-3) + (n-2) \\
f(n-3) \space = \space f(n-4) + (n-3) \\
\dots \\
f(0) = 0
$$

Sustituyendo llegamos a la formula

$$
f(n) \space = \space f(n-k) \space + \space k \cdot n
$$

Tomando $k = n$ nos queda:

$$
f(n) \space = \space f(0) \space + n^2 \\
f(n) \space = \space n^2
$$

Por lo tanto $f(n) \space = \space \Theta(n^2)$

c) $f(n) \space = \space 2 \cdot f(n-1)$

Teniendo en cuenta que el caso base $f(0) = 0$ vamos a demotrar por induccion que $\forall n \geq 1, \space f(n) = 0$

Caso base $n = 1$: 

$$
f(1) = 2 \cdot f(0) \\
= 2 \cdot 0 \\
= 0
$$

Por lo tanto es trivial que el caso base cumple, ahora vamos con el caso inductivo para eso tenemos la siguiente hipotesis inductiva:

$$
P(k) \Rightarrow P(k+1)
$$

Donde $P(k) : f(k) = 0$ y queremos ver que:

$$
P(k+1): f(k+1) = 0
$$

Utilizando la formula recursiva entonces tenemos que $f(k+1)$ es:

$$
f(k+1) = 2 \cdot f(k) 
$$

Por hiposis inductiva sabemos que $f(k) = 0$ por lo tanto $f(k+1) = 2 \cdot 0 = 0$

Luego vale para todo $n \geq 1$.

d) $f(n) = 2 \cdot f(n/2) + 10$

Notemos que la funcion entra dentro del caso 1 del teorema maestro el cual dice:

$$
f(n) = O(n^{\log_b{a} - \epsilon})
$$

sabiendo que $a = 2$ y $b = 2$ tenemos que $log_2{2} = 1$ luego si tomamos $\epsilon = 1$ cumple que $10 = O(n^0)$.

Por lo tanto el caso 1 nos dice que $f(n) = \Theta(n^{log_b{a}}) = \Theta(n)$

e) $f(n) = 2 \cdot f(n/2) + n$

Aqui tambien vamos a utilizar el teorema maestro, primero calculemos $log_b{a}$ el cual es igual $log_2{2} = 1$ y notemos que $f(n) = n$ entonces entraria en el caso ya que $n = \Theta(n^{log_2{2}}) = \Theta(n)$

Por lo tanto $T(n) = \Theta(n \cdot log_n)$

---

### Ejercicio 2

**$(\Rightarrow)$ Si $f(n) = O(g(n)) \implies L < \infty$**

1. Por hipótesis, $f(n) = O(g(n))$. Por definición, existen constantes $c > 0$ y $n_0 \in \mathbb{N}$ tales que:
   $$f(n) \leq c \cdot g(n) \quad \forall n \geq n_0$$

2. Como $g(n) > 0$, dividimos por $g(n)$:
   $$\frac{f(n)}{g(n)} \leq c \quad \forall n \geq n_0$$

3. Dado que por hipótesis el límite $L = \lim_{n \to \infty} \frac{f(n)}{g(n)}$ existe, aplicamos el límite cuando $n \to \infty$ a ambos lados de la desigualdad:
   $$\lim_{n \to \infty} \frac{f(n)}{g(n)} \leq \lim_{n \to \infty} c$$
   $$L \leq c$$

4. Como $c$ es una constante real finita, concluimos que:
   $$L < \infty$$

Supongamos que $L = \infty$, es decir el $\lim_{n \to \infty} \frac{f(n)}{g(n)} = \infty$

---

**($\Leftarrow$) Si $L = \lim_{n \to \infty} \frac{f(n)}{g(n)} \lt \infty $**

eso quiere decir  que existe el limite, entonces por la definicion de limite, para todo $\epsilon > 0$, exise un $n_0 \in \mathbf{N}$ tal que para todo $n \geq n_0$:

$$
\left| \frac{f(n)}{g(n)} - L\right| < \epsilon
$$

Despejando el valor absoluto nos queda:

$$
L - \epsilon \lt \frac{f(n)}{g(n)} \lt L + \epsilon
$$

Si fijamos $\epsilon = 1$ para todo $n \geq n_0$ entonces tenemos:

$$
\frac{f(n)}{g(n)} \lt L + 1
$$

Multiplicando por $g(n)$ (ya que $g(n) \gt 0$):

$$
f(n) \lt (L + 1) \cdot g(n)
$$

Si tomamos $L+1$ como la constante c entonces tenemos la definicion de $f(n) = O(g(n))$

---

Sean $f, g > 0$ tales que $L = \lim_{n \to \infty} \frac{f(n)}{g(n)}$ existe. Los criterios análogos son:

* **Para $o$ (Little-o):**
  $$f(n) = o(g(n)) \iff L = 0$$

* **Para $\Omega$ (Big-Omega):**
  $$f(n) = \Omega(g(n)) \iff L > 0 \quad (\text{incluye } L = \infty)$$

* **Para $\omega$ (Little-omega):**
  $$f(n) = \omega(g(n)) \iff L = \infty$$

* **Para $\Theta$ (Big-Theta):**
  $$f(n) = \Theta(g(n)) \iff 0 < L < \infty$$

---

### Ejercicio 3

a) $f(n) = 50n$, $g(n) = n \log{n}$

Utilizemos los criterios del punto anterior, vamos primero con $g = o(f)$

$$
\lim_{n \to \infty}{\frac{n \log{n}}{50n}}

= \lim_{n \to \infty}{\frac{\log{n}}{50}} 

= \infty
$$

por lo tanto $g \neq o(f)$.

Pero notar que si $f = o(g)$ por el limite de la fraccion inversa si es 0.


Por ultimo ver si $f = \Theta(g)$ por el resultado anterior L = 0 del limie de $\frac{f(n)}{g(n)}$ por lo tanto $f \neq \Theta(g)$.

## Módelos de cómputo