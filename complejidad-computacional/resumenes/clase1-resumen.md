# Complejidad Computacional — Clase 1

## 1. Preliminares: Notación sobre palabras

**Definicion.** Dado un alfabeto $\Gamma$, se define:
- $\Gamma^*$: conjunto de todas las palabras formadas sobre $\Gamma$.
- $\varepsilon$: la palabra vacía.
- $|\sigma|$: longitud de la palabra $\sigma$ (cantidad de letras).
- $\Gamma^k$: conjunto de todas las palabras de longitud exactamente $k$ sobre $\Gamma$ (equivalentemente, tuplas de dimension $k$).
- $\sigma\tau$: concatenacion de $\sigma$ con $\tau$.
- $\sigma(i)$: la $(i+1)$-esima letra de $\sigma$, para $i \in \{0, \ldots, |\sigma|-1\}$.

**Ejemplo.** Si $\Gamma = \{0,1\}$ y $\sigma = 101$, entonces $|\sigma| = 3$, $\sigma(0) = 1$, $\sigma(1) = 0$, $\sigma(2) = 1$.

---

## 2. Representaciones en binario

**Definicion.** Para $n \in \mathbb{N}$, se denota $[n]$ a la representacion de $n$ en binario y $|n| = \lceil \log n \rceil$ al tamano de dicha representacion.

**Ejemplo.** $[0] = 0,\ |0| = 1$. $\quad [5] = 101,\ |5| = 3$.

**Definicion (codificacion autodelimitante).** Para $\sigma = b_1 b_2 \cdots b_n$ con $b_i \in \{0,1\}$, se define:
$$\langle \sigma \rangle = b_1 b_1\, b_2 b_2\, \cdots\, b_n b_n\, 10$$
El sufijo $10$ marca el final de la cadena y hace que $\langle \sigma \rangle$ sea autodelimitante.

**Ejemplo.** $\langle 101 \rangle = 11\,00\,11\,10$. $\quad \langle \varepsilon \rangle = 10$.

**Definicion (codificacion de listas).** Para una lista $L = \sigma_1, \ldots, \sigma_n$ con $\sigma_i \in \{0,1\}^*$:
$$\langle L \rangle = \langle \sigma_1 \rangle\, \langle \sigma_2 \rangle\, \cdots\, \langle \sigma_n \rangle\, 01$$
El sufijo $01$ marca el fin de la lista. Las tuplas y conjuntos se codifican de la misma forma.

**Ejemplo.** $\langle \emptyset \rangle = 01$.

**Observacion.** Se asume siempre que todo objeto matematico $O$ (numero, grafo, lista, etc.) admite una codificacion razonable $\langle O \rangle$ en binario. Se usa la notacion abreviada $\langle O_1, \ldots, O_n \rangle$ para tuplas, y $|O|$ en lugar de $|\langle O \rangle|$ para referirse al tamano de la codificacion.

**Ejemplo (grafo).** Si $G = (E,V)$ es un digrafo, se lo puede representar mediante su matriz de adyacencia binaria. Para el grafo con 3 nodos y aristas $1\to2$, $1\to3$, $2\to3$, $3\to1$:
$$\langle G \rangle = 00111110000011101100001001 \qquad |\langle G \rangle| = 26$$

---

## 3. Problemas de decision

**Definicion.** Un problema de decision es una funcion booleana $f: \{0,1\}^* \to \{0,1\}$. Cada tal funcion representa el lenguaje:
$$L(f) = \{x : f(x) = 1\} \subseteq \{0,1\}^*$$
Reciprocamente, todo lenguaje $L \subseteq \{0,1\}^*$ se representa por su funcion caracteristica $\chi_L$.

**Observacion.** Las nociones de problema de decision, funcion booleana y lenguaje son intercambiables:
$$\text{problemas de decision} = \text{funciones booleanas} = \text{lenguajes}$$

**Notacion.** A partir de la clase 1, $\mathcal{L}$ denota un lenguaje en $\{0,1\}^*$.

**Ejemplo.** El problema de decidir si $x$ es par se formaliza como:
$$f([x]) = \begin{cases} 1 & \text{si } x \text{ es par} \\ 0 & \text{si no} \end{cases}$$
o equivalentemente con el lenguaje $\mathcal{L} = \{[x] : x \text{ es par}\}$.

**Ejemplo.** El problema de decidir si un grafo $G$ tiene un $k$-coloreo:
$$f(\langle \langle G \rangle, [k] \rangle) = \begin{cases} 1 & \text{si } G \text{ tiene un } k\text{-coloreo} \\ 0 & \text{si no} \end{cases}$$

---

## 4. Maquinas de Turing

**Definicion.** Una maquina de Turing (con $k$ cintas, $k \geq 3$) es una tripla $(\Sigma, Q, \delta)$ donde:
- $Q$: conjunto finito de **estados**, con estado inicial $q_0 \in Q$ y estado final $q_f \in Q$.
- $\Sigma$: **alfabeto** (conjunto finito de simbolos), que incluye el simbolo de comienzo de cinta $\triangleright \in \Sigma$ y el blanco $\square \in \Sigma$. El **alfabeto estandar** es $\Sigma = \{0, 1, \triangleright, \square\}$.
- $\delta$: la **funcion de transicion**:
$$\delta : Q \times \Sigma^{k-1} \to \{L,R,S\} \times \Sigma^{k-2} \times \{L,R,S\}^{k-2} \times (\Sigma \cup \{S\}) \times Q$$
donde $L$ = izquierda, $R$ = derecha, $S$ = quedarse.

La maquina tiene una cinta de entrada (solo lectura), $k-2$ cintas de trabajo (lectura/escritura) y una cinta de salida (solo escritura).

**Observacion (restricciones sobre $\delta$).**
- La cabeza de entrada no puede moverse a la izquierda del simbolo $\triangleright$.
- La cabeza de trabajo no puede moverse a la izquierda del simbolo $\triangleright$.
- En el estado $q_f$, la maquina no realiza ninguna accion: $\delta(q_f, a, b) = (S, b, S, S, q_f)$.

**Observacion.** La funcion de transicion $\delta$ formaliza la siguiente instruccion: dado el estado actual $q$, el simbolo leido en la cinta de entrada $a$ y en la cinta de trabajo $b$, se determina la direccion de movimiento de la cabeza de entrada, el simbolo a escribir y la direccion de la cabeza de trabajo, el simbolo a escribir en la salida (o $S$ para no hacer nada), y el nuevo estado $r$.

---

## 5. Configuraciones y computos

**Definicion.** Una **configuracion** de una maquina $M$ es una descripcion completa del estado de la maquina en un momento dado: el contenido de todas las cintas, la posicion de cada cabeza lectora y el estado actual.

**Definicion.** La **configuracion inicial** de $M$ con entrada $x \in \Gamma^*$ es aquella donde:
- la cinta de entrada contiene $x$ (el resto en blanco),
- todas las cintas de trabajo y la cinta de salida estan en blanco,
- todas las cabezas apuntan a la segunda celda (despues de $\triangleright$),
- el estado es $q_0$.

**Definicion.** Una **configuracion final** es cualquier configuracion en que el estado es $q_f$. Se dice que es **aceptadora** si en la cinta de salida esta escrito $\triangleright 1$ seguido de blancos.

**Definicion.** Un **computo** de $M = (\Gamma', Q, \delta)$ a partir de $x \in \Gamma^*$ es una secuencia de configuraciones $C_0, C_1, \ldots, C_\ell$ tal que:
- $C_0$ es la configuracion inicial para $x$,
- $C_\ell$ es una configuracion final,
- $C_{i+1}$ es la configuracion que resulta de aplicar $\delta$ a $C_i$ en un paso.

La **longitud** del computo es $\ell$. Se dice que $M$ **termina** con entrada $x$ si existe un computo de $M$ a partir de $x$.

**Notacion.** Se fija un alfabeto finito $\Gamma$ con $\triangleright \notin \Gamma$ y se define $\Gamma' = \Gamma \cup \{\triangleright, \square\}$. Las maquinas trabajan con el alfabeto $\Gamma'$; las entradas y salidas son palabras sobre $\Gamma$.
