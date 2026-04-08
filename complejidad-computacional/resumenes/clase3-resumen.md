# Complejidad Computacional — Clase 3

## 1. Halt y máquina universal

**Definición (Problema de la detención).** Definimos la función $halt: \{0,1\}^* \to \{0,1\}$ como:

$$
halt(x) = \begin{cases} 
1 & \text{si la máquina } x \text{ con entrada } x \text{ termina} \\ 
0 & \text{si no} 
\end{cases}
$$

**Teorema (Turing 1936).** La función $halt$ no es computable.
**Demostración.** Supongamos que $halt$ es computable. Definimos una máquina $M$ tal que $M(x)$ termina sii $halt(x)=0$. Sea $y = \langle M \rangle$. Entonces, $M(y)$ termina sii la máquina $y$ con entrada $y$ no termina, sii $M(y)$ no termina. Esto es un absurdo.

**Definición (Máquina Universal).** Llamemos $M_i$ a la máquina tal que $\langle M \rangle = i$. Definimos la función parcial $u: \subseteq \{0,1\}^* \to \{0,1\}^*$ como $u(\langle i,x \rangle) = M_i(x)$. En particular, $u(\langle i,x \rangle) \ne \text{ sii } M_i(x) \ne$.

**Teorema.** Existe una máquina $U$ que computa la función $u(\langle i,x \rangle) = M_i(x)$. Más aún, si $M_i$ con entrada $x$ termina en $t$ pasos, entonces $U$ con entrada $(i,x)$ termina en $c \cdot t \cdot \log t$ pasos, donde $c$ depende solo de $i$.
**Idea de la prueba.** $U$ tiene 3 cintas de trabajo. Supongamos $M$ con una sola cinta de trabajo. $U$ copia $x$ en la cinta 1, escribe el estado inicial en la cinta 3, y mientras no llegue al estado final, busca en la cinta de entrada la información que necesita y actualiza las cintas 2 y 3 de manera acorde. El caso general requiere transformar una máquina multicinta en una de una sola cinta (que tomaría tiempo $O(t^2)$), por lo que la demostración para mantener la cota $O(t \log t)$ es más técnica.

**Definición (Máquina Universal con tiempo acotado).** Definimos la función total $\tilde{u}: \{0,1\}^* \to \{0,1\}^*$ como:

$$
\tilde{u}(\langle i,t,x \rangle) = \begin{cases} 
1 \circ M_i(x) & \text{si } M_i(x) \text{ termina en } \le t \text{ pasos} \\ 
0 & \text{si no} 
\end{cases}
$$

**Teorema.** Existe una máquina $\tilde{U}$ que computa la función $\tilde{u}(\langle i,t,x \rangle)$ en tiempo $c \cdot t \log t$, donde $c$ depende solo de $i$. 
**Idea de la prueba.** Funciona como antes, pero ahora $\tilde{U}$ tiene una 4ta cinta de trabajo que usa para llevar la cuenta de la cantidad de pasos ($\le t$) en la simulación.

---

## 2. La clase P

**Definición.** Sea $\mathcal{L} \subseteq \{0,1\}^*$ un lenguaje. Una máquina $M=(Q,\Sigma,\delta)$ decide $\mathcal{L}$ en tiempo $T(n)$ si $M$ computa $\chi_\mathcal{L}$ en tiempo $T(n)$. Decimos que $M$ acepta $x$ cuando $M(x)=1$ y que rechaza $x$ cuando $M(x)=0$. El lenguaje decidido por $M$ es $\mathcal{L}(M)$.

**Clase de complejidad DTIME.** $DTIME(T(n))$ es la clase de lenguajes $\mathcal{L}$ tal que existe una máquina $M$ que decide $\mathcal{L}$ en tiempo $O(T(n))$.

**Clase de complejidad P.** $P = \bigcup_{c>0} DTIME(n^c)$.
* Son los problemas que se resuelven por una máquina (determinística) en tiempo polinomial respecto al tamaño de su entrada.
* $P$ es considerada la clase de problemas "factibles".

**Ejemplo (Conectividad de un grafo).** $CON = \{ \langle G \rangle : G \text{ es un grafo conexo} \}$.
* Representando $G$ con su matriz de adyacencia, una máquina $M$ puede explorar $G$ usando *depth first search* y marcar los nodos visitados.
* Escribe 0 si quedó un nodo sin visitar; si no, escribe 1. Esto toma tiempo $O(n^2)$, por lo que $CON \in P$.

**Proposición (Simplificación de máquinas).** Para calcular funciones valuadas en $\{0,1\}$, no hace falta una cinta de salida. Si $\mathcal{L}$ es decidible en tiempo $T(n)$ por una máquina estándar de 3 cintas, entonces $\mathcal{L}$ es decidible en tiempo $O(T(n))$ por una máquina sin cinta de salida.

---

## 3. La clase NP

**Clase de complejidad NP.** $NP$ es la clase de lenguajes $\mathcal{L}$ tal que existe un polinomio $p: \mathbb{N} \to \mathbb{N}$ y una máquina $M$ tal que:
* $M$ corre en tiempo polinomial.
* Para todo $x$: $x \in \mathcal{L}$ sii existe $u \in \{0,1\}^{p(|x|)}$ tal que $M(\langle x,u \rangle) = 1$.
* $M$ se llama el verificador para $\mathcal{L}$; $u$ se llama certificado para $x$.
*(Nota: $M(\langle x,u \rangle) = 1$ es equivalente a $M(xu) = 1$ ya que la máquina puede usar $p(|x|)$ para saber dónde termina $x$ y empieza $u$)*.

**Teorema.** $P \subseteq NP$.
**Demostración.** Supongamos que $\mathcal{L} \in P$. Existe una máquina $M$ que decide $\mathcal{L}$ en tiempo polinomial. Tomamos $p(n)=0$. Definimos $M'$ que, dado $\langle x, \epsilon \rangle$, simula $M$ con entrada $x$. Así, $x \in \mathcal{L} \iff M(x)=1 \iff M'(\langle x,\epsilon \rangle)=1 \iff \exists u \in \{0,1\}^0 \text{ tal que } M'(\langle x,u \rangle)=1$.

**Ejemplo (Conjunto Independiente).** $INDSET = \{ \langle G, k \rangle : G \text{ tiene un conjunto independiente de } \ge k \text{ vértices} \}$.
* Certificado $u$: lista de $k$ nodos distintos de $V$ que forman un conjunto independiente.
* Se codifica en una palabra $u$ de tamaño $O(k \lceil \log |V| \rceil)$. Como $k \le |V|$, $|u| = O(n \log n)$, por lo que $|u| = p(n)$ para un polinomio cuadrático $p$.
* El verificador $M$ recibe $x$; si es de la forma $\langle \langle G, k \rangle, u \rangle$ y $u$ codifica un conjunto independiente válido, escribe 1; si no, 0. $M$ corre en tiempo polinomial, por ende $INDSET \in NP$.
