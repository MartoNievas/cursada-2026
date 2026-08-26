# Práctica 2: P, NPy reducciones

[Enunciados](enunciados/practica2.pdf)

## Ejercicio 1

Tenemos que probar que los siguiente lenguajes estan en **$P$**

### a) $COPRIME = \{\langle a, b \rangle : \text{mcd}(a,b) = 1, \text{ es decir, } a \text{ y } b \text{ son coprimos}\}$

**Demostración de que $COPRIME \in P$**

Para probar que el lenguaje está en $P$, diseñamos un algoritmo basado en el algoritmo de Euclides para calcular el máximo común divisor ($\text{mcd}(a,b)$), y analizamos su tiempo de ejecución en términos del tamaño de la representación binaria de la entrada.

**Codificación y tamaño de la entrada**

Representamos los enteros en binario de manera estándar. El tamaño físico de la entrada en la cinta de la máquina de Turing es:

$$
n = |\langle a, b \rangle| = \Theta(|a| + |b|) = \Theta(\log_2 a + \log_2 b)
$$

Por lo tanto, la longitud de cada número está acotada por $O(n)$ bits.

**Algoritmo de decisión**

*Entrada:* $\langle a, b \rangle$

1. Extraer los valores de $a$ y $b$ de la codificación autodelimitante de la entrada, a dos cintas de trabajo distintas.
2. Mientras $b \neq 0$:
   - Calcular $r = a \bmod b$ (el resto de la división entera).
   - Reemplazar $a \leftarrow b$.
   - Reemplazar $b \leftarrow r$.
3. Si $a = 1$, la máquina pasa al estado de aceptación $q_{\text{sí}}$ (escribe $1$ y acepta).
4. Si no, pasa al estado de rechazo $q_{\text{no}}$ (escribe $0$ y rechaza).

**Análisis de complejidad**

Para demostrar que el algoritmo corre en tiempo polinomial respecto de $n$, analizamos las dos componentes del cómputo.

*1. Cantidad de iteraciones del bucle (acotación de pasos)*

Existe una propiedad matemática fundamental del resto de la división entera: para cualquier par de enteros $a \geq b$, se cumple que el resto $r = a \bmod b$ es estrictamente menor que la mitad de $a$ ($r < \frac{a}{2}$).

- **Caso 1** ($b \leq \frac{a}{2}$): como el resto $r$ siempre es menor que el divisor $b$, entonces $r < b \leq \frac{a}{2}$.
- **Caso 2** ($b > \frac{a}{2}$): al realizar la división, el cociente es exactamente $1$, por lo que el resto es $r = a - b < a - \frac{a}{2} = \frac{a}{2}$.

Como los roles de los operandos se intercambian en cada iteración del bucle, el valor del dividendo se reduce al menos a la mitad cada dos iteraciones consecutivas. Dado que el valor inicial de los números es a lo sumo $2^n$, el número máximo de reducciones a la mitad es $n$. Por lo tanto, el bucle se ejecutará a lo sumo:

$$
\text{Iteraciones} \leq 2 \log_2(\max(a,b)) = O(n) \text{ veces}
$$

*2. Costo por iteración (la operación modular)*

La operación central en cada paso del bucle es calcular $a \bmod b$.

Por la hipótesis del problema, la multiplicación de dos números de $m$ bits requiere tiempo cuadrático $O(m^2)$.

Como la división entera con resto de dos números de a lo sumo $n$ bits puede resolverse mediante el algoritmo clásico de división binaria (restas y desplazamientos) —el cual computacionalmente tiene el mismo orden de complejidad que la multiplicación—, realizar la operación $a \bmod b$ sobre operandos de longitud acotada por $O(n)$ toma un tiempo de:

$$
\text{Tiempo de división} = O(n^2) \text{ pasos}
$$

*3. Tiempo de ejecución total*

Multiplicando la cantidad de iteraciones por el costo operativo de cada una de ellas en la máquina de Turing:

$$
\text{Tiempo total} = \text{Iteraciones} \times \text{Costo por división} = O(n) \times O(n^2) = O(n^3)
$$

Los pasos iniciales de extracción de las variables y la comparación final con $1$ requieren tiempo lineal $O(n)$, lo cual queda completamente absorbido por el término cúbico.

**Conclusión**

Dado que el algoritmo de Euclides decide el lenguaje $COPRIME$ en tiempo estrictamente acotado por una función polinomial en el tamaño de la entrada:

$$
T(n) = O(n^3)
$$

concluimos formalmente que $COPRIME \in P$.

**(Preguntar en clase)**
### b) $POWER = \{\langle a, e, b \rangle : a^e = b\}$

**Demostracion de que $POWER \in P$**

**Codificación y tamaño de la entrada**

La entrada nos llega con su representación en binario, por lo tanto el tamaño de la entrada es $O(\log{a} + \log{b} + \log{e})$

entonces llamemos $n$ a la cantidad de bits de la entrada.

**Algoritmo de decisión**

Ahora vamos a dar un algoritmo y analizarlo para demostrar que corre en tiempo polinomial.

```python

def potencia_rapida(a, e, b):
   if e == 0:
      return 1
   if a > b:
      return -1

   # Caso par
   if e % 2 == 0:
      sub = potencia_rapida(a, e / 2, b)
      if sub == -1 or sub * sub > b:
         return -1
      return sub * sub
   
   # Caso impar
   if e % 2 == 1:
      sub = potencia_rapida(a, e - 1, b)
      if e == -1 or sub * sub > b:
         return -1
      return a * sub

def power(a, e, b):
   res = potencia_rapida(a,e,b)
   if res == b:
      return 1
   else:
      return 0

```

**Análisis de complejidad**

En cada paso dividimos a $e$ entre 2 o restamos 1 pero en el siguiente paso lo dividimos. El numero total de llamadas recursivas es $O(\log{e})$.

En cada nivel de la recursion se realiza a lo sumo una multiplicación y una comparacion, teniendo en cuentra que la comparacion es lineal y la multiplicacion cuadratica. Como abortamos ni bien todos los operandos superan b, todos ellos tiene a los sumo $O(\log{b})$ bits, luego el tiempo total seria algo como:

$$
T(n) = O(\log{e} \cdot (\log{b})^2)
$$

Dado que la entrada tiene tamaño $n$ entonces el tiempo esta acotado superiormete por $O(n^3)$, el cual es polinomial por lo tanto $POWER \in P$.

### c)  $TREE = \{\langle G \rangle : G \space es \space un \space grafo \space conexo \space sin \space ciclos \}$

**Codificación y tamaño de la entrada**

La codificación es la misma en binario osea que seria $\langle G \rangle $, ahora para saber el el tamaño de la entrada seria $ n = |\langle G \rangle| = 2|V|^2  + |V| + 2 \space bits$. Entonces el comportamiento asintotico es $\Theta(|V|^2)$.

**Algoritmo de desición**

El algoritmo es simple basicamente BFS o DFS y si visito un nodo que ya visite recazho y si visito todos sin repetir acepto.

**Analisis de complejidad** 

Recordemos que la complejidad de DFS o BFS es $O(n + m)$ como vimos antes la entrada depende unicamente de la cantidad de vertices, por lo tanto la complejidad del algritmo seria $O(|V|^2)$ y por la comparcion se le suma el numero de nodo, pero como esta acotado por $|V|$ no lo ponemos.

Por lo tanto es polinomial con respecto al tamaño de la entrada por lo tanto $TREE \in P$.

**(Preguntar)**
### d) $L$ donde $|L| \lt \infty$ (es decir, probar que todo lenguaje finito está en $P$)

## Ejercicio 2

Tenemos que probar que la clase de complejidad $P$ está cerrada por unión, intersección y complemento.

### Unión

Sean $L_1, L_2 \in P$, como ambos pertenecen a $P$ entonces existen $M_1, M_2$ maquinas de Turing deterministicas que deciden $L_2 \space y \space L_2$ en tiempo polinomial con respecto al tamaño de la entrada.

Entonces podemos construir $M$ que simule $M_1$ o $M_2$, si tomamos $x \in \{0,1\}^*$ y hacemos $M(x)$ simulamos de la siguiente manera:

1. Pasamos la entrada $x$ a $M$.
2. Primero probamos $M_1(x)$ si acepta termina la simulación de $M_1$.
3. Si rechazo probamos $M_2(x)$ si acepta termina la simulacion y la palabra x es aceptada.
4. Caso contrario $x \notin L_1 \cup L_2$.

De esta manera la complejidad total es la suma de las complejidades de ambas maquinas mas un overhead de poner la entrada de nuevo en la cinta para ambas simulaciones.

Por lo tanto $L_1 \cup L_2 \in P$.

### Complemento

Este es mucho mas facíl, supongamos que tenemso $L \in P$, entonces existe $M$ que decide $L$ en tiempo polinomial, luego para obtener el complemento es decidir todo lo que no esta en $L$, podemos definir $M^c$ como:

$$
M^c(x) = 1 - M(x).
$$

Entonces simular $M$ nos lleva tiempo polinomial mas la resta que como siempre es un bit podriamos considerarlo como $O(1)$ por lo tanto $M^c$ corre en tiempo polinomial por lo tanto $L^c \in P$.

### Intersección

Aqui sale por reglas de algebra de boole, podemos escribir la insterseccion como:

$$
L_1 \cap L_2 = L_{1}^c \cup L_{2}^c
$$

Y como sabemos que esta cerrado por complemento y por union entonces vale que esta cerrado por interseccion. Por lo tanto $L_2 \cap L_2 \in P$.
