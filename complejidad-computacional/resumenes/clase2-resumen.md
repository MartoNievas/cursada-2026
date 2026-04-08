# Complejidad Computacional — Clase 2

## 1. Funciones computables

**Definicion.** Sean $f : \Gamma^* \to \Gamma^*$ y $M = (\Gamma', Q, \delta)$ una maquina. Se dice que $M$ **computa** $f$ si para todo $x \in \Gamma^*$ hay un computo $C_0, \ldots, C_\ell$ de $M$ a partir de $x$ tal que en $C_\ell$ la cinta de salida tiene escrito $f(x)$ seguido de blancos. En este caso se nota $M(x) = f(x)$. Se dice que $f$ es **computable** si existe una maquina que la computa.

**Definicion (funcion parcial).** Una **funcion parcial** $f : \subseteq \Gamma^* \to \Gamma^*$ es un mapeo posiblemente incompleto. Se usa la notacion:
- $f(x) \uparrow$: $f$ esta indefinida en $x$.
- $f(x) \downarrow$: $f$ esta definida en $x$.
- $\mathrm{dom}\, f = \{x : f(x) \downarrow\}$: dominio de $f$.

**Definicion.** Sea $f : \subseteq \Gamma^* \to \Gamma^*$ una funcion parcial y $M = (\Gamma', Q, \delta)$ una maquina. Se dice que $M$ **computa** $f$ si para todo $x \in \Gamma^*$:
- si $f(x) \downarrow$, entonces hay un computo $C_0, \ldots, C_\ell$ de $M$ a partir de $x$ y en $C_\ell$ la cinta de salida tiene escrito $f(x)$ seguido de blancos (se escribe $M(x) \downarrow$);
- si $f(x) \uparrow$, entonces hay una secuencia infinita de configuraciones $C_0, C_1, \ldots$ tal que $C_0$ es inicial, $C_{i+1}$ es la evolucion de $C_i$ en un paso y ningun $C_i$ es final (se dice que $M$ se **cuelga** con entrada $x$).

Se dice que $f$ es **parcial computable** si existe una maquina que la computa.

**Observacion.** En la Teoria de la Complejidad se trabaja principalmente con funciones totales (no parciales). La distincion es:
- **funcion** (o funcion total): mapeo de toda entrada a una salida, $f : \Gamma^* \to \Gamma^*$.
- **funcion parcial**: mapeo posiblemente incompleto, $f : \subseteq \Gamma^* \to \Gamma^*$.

**Observacion.** Para una funcion fija $f$ computable existen infinitas maquinas que la computan (se pueden agregar estados y transiciones espurias sin alterar la funcion computada).

---

## 2. Tiempo de computo

**Definicion.** Sean $f : \Gamma^* \to \Gamma^*$, $T : \mathbb{N} \to \mathbb{N}$ y $M = (\Gamma', Q, \delta)$ una maquina.
- $M$ **corre en tiempo $T(n)$** si para todo $x \in \Gamma^*$ hay un computo de $M$ a partir de $x$ de longitud $\leq T(|x|)$ (en particular, $M$ no se cuelga nunca).
- $M$ **computa $f$ en tiempo $T(n)$** si $M$ corre en tiempo $T(n)$ y $M$ computa $f$.

**Definicion (notacion $O$ grande).** Sean $f, g : \mathbb{N} \to \mathbb{N}$. Se dice que $f = O(g)$ si existe una constante $c$ tal que para todo $n$ suficientemente grande se tiene $f(n) \leq c \cdot g(n)$.

**Ejemplo.** $4(n+2) = O(n)$. $\quad n\log n = O(n^2)$. $\quad 5n^2 + 3n + 1 = O(n^2)$. $\quad 2^n \neq O(n^k)$ para ningun $k$.

**Definicion.** $M$ **corre en tiempo $O(T(n))$** si existe una constante $c$ tal que para todo $x \in \Gamma^*$, salvo finitos, hay un computo de $M$ a partir de $x$ de longitud a lo sumo $c \cdot T(|x|)$.

**Definicion.** $M$ **corre en tiempo polinomial** si existe un polinomio $p$ tal que $M$ corre en tiempo $O(p)$. Equivalentemente, existe una constante $c$ tal que $M$ corre en tiempo $O(n^c)$.

**Definicion.** Una funcion $f : \Gamma^* \to \Gamma^*$ es **computable en tiempo $T(n)$** (resp. **en tiempo $O(T(n))$**, **en tiempo polinomial**) si existe una maquina $M$ que computa $f$ y corre en tiempo $T(n)$ (resp. $O(T(n))$, polinomial).

**Definicion.** Un lenguaje $\mathcal{L}$ es **decidible en tiempo $T(n)$** (resp. $O(T(n))$, polinomial) si $\chi_\mathcal{L}$ es computable en tiempo $T(n)$ (resp. $O(T(n))$, polinomial).

**Observacion.** Para funciones de varios parametros $f : \{0,1\}^* \times \{0,1\}^* \to \{0,1\}^*$, la entrada $(σ, τ)$ no puede codificarse como la concatenacion $στ$ pues no hay forma de determinar donde termina $σ$ y donde empieza $τ$. Se usa codificacion autodelimitante sobre $\{0,1\}^*$.

**Definicion.** Una funcion $T : \mathbb{N} \to \mathbb{N}$ es **construible en tiempo** si:
- $T(n) \geq n$, y
- la funcion $1^n \mapsto [T(n)]$ es computable en tiempo $O(T(n))$.

**Ejemplo.** Son construibles en tiempo: $n$, $n\log n$, $n^2$, $2^n$.

**Notacion.** A partir de la clase 2, $f$ denota siempre una funcion $\{0,1\}^* \to \{0,1\}^*$ y $T : \mathbb{N} \to \mathbb{N}$ denota siempre una funcion construible en tiempo, salvo indicacion contraria.

---

## 3. Codificacion de maquinas

Las maquinas de Turing pueden codificarse como palabras en $\{0,1\}^*$. Se trabaja con el alfabeto estandar $\Sigma = \{0,1,\triangleright,\square\}$.

Los estados de $Q$ se numeran desde $0$ hasta $|Q|-1$ y se representan con $[n]$, reservando $0$ para $q_0$ y $1$ para $q_f$. Los simbolos de $\Sigma \cup \{L,R,S\}$ se codifican con palabras de longitud 3:

$$[0] = 000,\quad [1] = 001,\quad [\square] = 010,\quad [\triangleright] = 011,\quad [L] = 100,\quad [R] = 101,\quad [S] = 110$$

La funcion de transicion $\delta$ se codifica como un conjunto de tuplas, y la maquina completa $M = (\Sigma, Q, \delta)$ con $k$ cintas se codifica como:
$$\langle M \rangle = \langle [|Q|],\, [k],\, \langle \delta \rangle \rangle \in \{0,1\}^*$$

**Observacion.** Toda palabra $x \in \{0,1\}^*$ representa alguna maquina (si $x$ no respeta el patron $\langle M \rangle$, se interpreta como una maquina trivial fija). Se identifica cada maquina con su codificacion binaria; se habla de "la maquina $x$" o "la $x$-esima maquina".

**Observacion.** Hay una cantidad numerable de maquinas y por lo tanto una cantidad numerable de funciones $\{0,1\}^* \to \{0,1\}$ computables. Como hay una cantidad no numerable de funciones $\{0,1\}^* \to \{0,1\}$, deben existir funciones no computables.

---

## 4. Variantes de maquinas

Las siguientes variantes son equivalentes a la maquina estandar, con a lo sumo una penalizacion polinomial en el tiempo de computo.

**Proposicion (alfabeto no estandar).** Sea $\Gamma$ un alfabeto. Si $f$ es computable en tiempo $T(n)$ por una maquina $M = (\Gamma, Q, \delta)$, entonces $f$ es computable en tiempo $O(\log |\Gamma| \cdot T(n))$ por una maquina $M' = (\Sigma, Q', \delta')$ con $\Sigma = \{0,1,\triangleright,\square\}$.

*Idea de la prueba.* Cada simbolo de $\Gamma$ se codifica en binario usando $\lceil \log |\Gamma| \rceil$ celdas.

**Definicion (maquina de cinta unica).** Una **maquina de cinta unica** tiene una sola cinta con una cabeza de lectura y escritura. Su funcion de transicion es:
$$\delta : Q \times \Sigma \to \Sigma \times \{L,R,S\} \times Q$$

**Proposicion (cinta unica).** Si $f$ es computable en tiempo $T(n)$ por una maquina estandar de $k \geq 3$ cintas, entonces $f$ es computable en tiempo $O(T(n)^2)$ por una maquina de cinta unica.

*Idea de la prueba.* Las $k$ cintas de $M$ se codifican en la cinta unica de $M'$ usando un alfabeto extendido que marca las posiciones de las cabezas. Como $M$ usa a lo sumo $T(n)$ celdas por cinta, $M'$ usa a lo sumo $k \cdot T(n)$ celdas. Simular cada paso de $M$ requiere que $M'$ barra la cinta de izquierda a derecha y de derecha a izquierda, lo que cuesta $O(T(n))$ pasos por cada uno de los $T(n)$ pasos de $M$.

**Definicion (maquina oblivious).** Una maquina $M$ es **oblivious** si para cada entrada $x$ y cada $i \in \mathbb{N}$, la posicion de las cabezas de las cintas de entrada y trabajo en el $i$-esimo paso del computo de $M$ con entrada $x$ depende solo de $i$ y de $|x|$ (pero no de $x$), y las funciones que computan esas posiciones a partir de $i, |x|$ son computables en tiempo polinomial.

**Proposicion (oblivious).** Si $f$ es computable en tiempo $T(n)$ por una maquina estandar, entonces hay una maquina oblivious que computa $f$ en tiempo $O(T(n)^2)$.

*Demostracion.* La maquina $M'$ construida en la prueba de la proposicion de cinta unica es oblivious.

**Definicion (maquina con cintas bi-infinitas).** Una **maquina con cintas bi-infinitas** tiene cintas infinitas en ambas direcciones.

**Proposicion (cintas bi-infinitas).** Si $f$ es computable por una maquina con cintas bi-infinitas en tiempo $T(n)$, entonces $f$ es computable por una maquina estandar en tiempo $O(T(n))$.

*Idea de la prueba.* Se "pliega" cada cinta bi-infinita en una cinta semi-infinita codificando cada celda con un par de simbolos (uno para la parte positiva y uno para la parte negativa de la cinta), sobre el alfabeto $\{\triangleright\} \cup \{0,1,\square\}^2$. Luego se traduce al alfabeto estandar.
