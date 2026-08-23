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



