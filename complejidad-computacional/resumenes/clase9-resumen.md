# Resumen — Clase 9: La Jerarquía Polinomial

## Problemas NP

**Problema: SAT** (Satisfacción booleana en CNF)

$$SAT = \{ \langle \varphi \rangle : \varphi \in CNF \text{ es satisfacible} \}$$

$$\langle \varphi \rangle \in SAT \quad \text{sii} \quad \exists v \; v \models \varphi \quad \text{(verificación polinomial)}$$

**Problema: Conjunto independiente**

$$INDSET = \{ \langle G, k \rangle \mid G \text{ tiene un conjunto independiente de} \geq k \text{ vértices} \}$$

$$\langle (V,E), k \rangle \in INDSET \quad \text{sii} \quad \exists C \; C \subseteq V, |C| = k, \neg\exists u,v \in C, (u,v) \in E$$

---

## Problemas coNP

**Problema: Tautología**

$$TAUT = \{ \langle \varphi \rangle : \varphi \in CNF \text{ es una tautología} \}$$

$$\langle \varphi \rangle \in TAUT \quad \text{sii} \quad \forall v \; v \models \varphi \quad \text{(verificación polinomial)}$$

---

## Motivación: problemas con cuantificadores alternados

**Problema: Conjunto independiente máximo**

$$MAXINDSET = \{ \langle G, k \rangle : \text{el conjunto independiente más grande de } G \text{ tiene } k \text{ vértices} \}$$

No alcanza un solo $\exists$ ni un solo $\forall$, pero sí:

$$\langle (V,E), k \rangle \in MAXINDSET \quad \text{sii} \quad \exists C \; \forall D \underbrace{\left( C \subseteq V, |C| = k \land \neg\exists u,v \in C \land (u,v) \in E \land (D \subseteq V \land \neg\exists u,v \in D \land (u,v) \in E) \to |D| \leq |C| \right)}_{\text{polinomial}}$$

---

## La jerarquía polinomial

### Definición: $\Sigma_i^p$, $\Pi_i^p$

Para $i > 0$, $\Sigma_i^p$ es la clase de lenguajes $\mathcal{L}$ tales que existe una máquina determinística $M$ en tiempo polinomial y un polinomio $q$ tal que:

$$x \in \mathcal{L} \quad \text{sii} \quad \exists u_1 \in \{0,1\}^{q(|x|)} \; \forall u_2 \in \{0,1\}^{q(|x|)} \; \cdots \; Q_i u_i \in \{0,1\}^{q(|x|)} \; M(\langle x, u_1, \dots, u_i \rangle) = 1$$

donde $Q_i = \begin{cases} \forall & \text{si } i \text{ es par} \\ \exists & \text{si } i \text{ es impar} \end{cases}$

- $\Sigma_0^p = P$
- $\mathbf{PH} = \bigcup_{i \geq 0} \Sigma_i^p$ es la **jerarquía polinomial**
- Para $i \geq 0$, $\Pi_i^p = \{ \bar{\mathcal{L}} : \mathcal{L} \in \Sigma_i^p \}$

> **Nota sobre alternancia:** Lo que importa es que la fórmula empiece con $\exists$ (resp. $\forall$) y haya $i-1$ alternancias de cuantificadores. Los bloques $\exists\exists$ se pueden unir en un solo $\exists$, y análogamente para $\forall\forall$.

---

## Propiedades de la jerarquía polinomial

**Proposición:**
- $\Sigma_1^p = \mathbf{NP}$, $\quad \Pi_1^p = \mathbf{coNP}$
- $\Sigma_i^p \subseteq \Sigma_{i+1}^p$, $\quad \Pi_i^p \subseteq \Pi_{i+1}^p$
- $\Sigma_i^p \subseteq \Pi_{i+1}^p$, $\quad \Pi_i^p \subseteq \Sigma_{i+1}^p$
- $\mathbf{PH} = \bigcup_{i \geq 0} \Sigma_i^p$

### Ejemplo: MAXINDSET $\in \Sigma_2^p$

> 📄 [Demostración — p. 10 del PDF](../teoricas/clase9.pdf#page=14)

---

## ¿Es la jerarquía estrictamente creciente?

La pregunta $P \stackrel{?}{=} NP$ se generaliza a $\Sigma_i^p \stackrel{?}{=} \Sigma_{i+1}^p$; ninguna se conoce.

**Proposición:** Si $P = NP$ entonces $PH = P$.

> 📄 [Demostración — p. 13 del PDF](../teoricas/clase9.pdf#page=17)

**Ejercicio:** Para todo $i > 0$, si $\Sigma_i^p = \Pi_i^p$ entonces $PH = \Sigma_i^p$.

---

## Clausura bajo reducciones polinomiales

**Proposición:**
- Si $\mathcal{L} \in \Sigma_i^p$ y $\mathcal{L}' \leq_p \mathcal{L}$, entonces $\mathcal{L}' \in \Sigma_i^p$.
- Si $\mathcal{L} \in \Pi_i^p$ y $\mathcal{L}' \leq_p \mathcal{L}$, entonces $\mathcal{L}' \in \Pi_i^p$.

> 📄 [Demostración — p. 14 del PDF](../teoricas/clase9.pdf#page=24)

---

## Problemas $\Sigma_i^p$-completos

### Definición: $\Sigma_i^p$-hard y $\Sigma_i^p$-completo

- $\mathcal{L}$ es $\Sigma_i^p$**-hard** si $\mathcal{L}' \leq_p \mathcal{L}$ para todo $\mathcal{L}' \in \Sigma_i^p$.
- $\mathcal{L}$ es $\Sigma_i^p$**-completo** si $\mathcal{L} \in \Sigma_i^p$ y $\mathcal{L}$ es $\Sigma_i^p$-hard.

Análogamente se definen $\Pi_i^p$-hard, $\Pi_i^p$-completo, PH-hard, PH-completo.

### Problema canónico: $\Sigma_i\mathsf{SAT}$

$$\Sigma_i\mathsf{SAT} = \left\{ \langle \varphi \rangle : \varphi \text{ es una QBF de la forma } \exists \bar{y}_1 \forall \bar{y}_2 \cdots Q_i \bar{y}_i \; \psi(\bar{y}_1, \dots, \bar{y}_i) \text{ con cuantificadores alternados y } \models \varphi \right\}$$

**Proposición:** Para todo $i > 0$, $\Sigma_i\mathsf{SAT}$ es $\Sigma_i^p$-completo.

> 📄 [Demostración ($\Sigma_i\mathsf{SAT} \in \Sigma_i^p$) — p. 21 del PDF](../teoricas/clase9.pdf#page=37)  
> 📄 [Demostración ($\Sigma_i\mathsf{SAT}$ es $\Sigma_i^p$-hard) — p. 22 del PDF](../teoricas/clase9.pdf#page=38)

---

## ¿Existen problemas PH-completos?

**Proposición:** Si existe $\mathcal{L} \in \mathbf{PH}$-completo, entonces existe $i$ tal que $PH = \Sigma_i^p$.

> 📄 [Demostración — p. 17 del PDF](../teoricas/clase9.pdf#page=30)

Se cree que para todo $i$, $\Sigma_i^p \subsetneq \Sigma_{i+1}^p$ (la jerarquía **no colapsa**). Si la jerarquía no colapsa en ningún nivel, se cree que **no existen problemas PH-completos**.

---

## Relación con otras clases

**Ejercicio:** $PH \subseteq \mathbf{PSpace}$.

**Corolario:** Si la jerarquía polinomial no colapsa en ningún nivel, entonces $PH \neq \mathbf{PSpace}$.

> 📄 [Demostración — p. 18 del PDF](../teoricas/clase9.pdf#page=34)

Mapa de inclusiones conocidas:

$$L \subseteq NL = coNL \subseteq P \subseteq NP, coNP \subseteq \Sigma_2^p, \Pi_2^p \subseteq \cdots \subseteq PH \subseteq PSpace = NPSpace \subseteq ExpTime \subseteq \cdots$$
