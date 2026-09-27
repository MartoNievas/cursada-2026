# Resumen: Una Técnica Simple para Manejar el Polimorfismo Múltiple
**Autor:** Daniel H. H. Ingalls (Apple Computer, Inc. / OOPSLA 1986)

---

## 1. Introducción y Contexto Histórico
El paper aborda las limitaciones del envío de mensajes convencional en la Programación Orientada a Objetos (POO) cuando nos enfrentamos a **expresiones con polimorfismo múltiple** —es decir, situaciones donde más de una variable involucrada en una operación o interacción varía dinámicamente de tipo de forma independiente.

Historicamente, los lenguajes de programación extensibles anteriores a la POO requerían que los procedimientos verificaran explícitamente el tipo de cada argumento mediante condicionales (`if/else` o `switch`). Esto violaba los principios básicos de la modularidad y provocaba una **explosión combinatoria de la complejidad** a medida que el sistema crecía.

---

## 2. Polimorfismo Simple vs. Polimorfismo Múltiple

### Polimorfismo Simple
* **Mecanismo:** El envío de mensajes estándar absorbe la verificación de clases.
* **Comportamiento:** La búsqueda del método (*method dispatch*) se realiza únicamente en función de la clase del **receptor** del mensaje.
* **Propiedad clave:** **Cada envío de mensaje reduce una variable polimórfica a una monomórfica**.
* **Ventaja:** Los métodos son locales a sus clases, no dependen del resto del sistema, y el mecanismo tiene un costo apenas superior al de una llamada a procedimiento convencional.

### El Problema del Polimorfismo Múltiple
Cuando la operación a realizar depende no solo del tipo del receptor, sino también del tipo de uno o más **argumentos**, el polimorfismo simple del receptor no alcanza. Ante esta limitación, muchos desarrolladores recaen involuntariamente en el estilo procedural: la **verificación explícita de tipos**.

---

## 3. Ejemplo del Paper: Objetos Gráficos y Puertos de Salida

### Dominio
* **Objetos Gráficos (Polimórficos):** `Rectangulo`, `Ovalo`, `MapaDeBits`, `Texto`, etc.
* **Puertos Gráficos / Salida (Polimórficos):** `PuertoDePantalla` (Monitor), `PuertoDeImpresora`, `PuertoDeRemoto`, etc.

### La Mala Práctica (Verificación Explícita de Tipos)
```smalltalk
<Rectangulo> representarseEn: unPuertoGrafico
    unPuertoGrafico isMemberOf: PuertoDeMonitor
        ifTrue: ["Código para dibujarse en un monitor"].
    unPuertoGrafico isMemberOf: PuertoDeImpresora
        ifTrue: ["Código para dibujarse en una impresora"].
    unPuertoGrafico isMemberOf: PuertoDeRemoto
        ifTrue: ["Código para dibujarse en un monitor remoto"].
```

#### Problemas de esta solución:
1. **Falta de Extensibilidad:** Agregar un nuevo puerto obliga a modificar los métodos de **todos** los objetos gráficos existentes.
2. **Fragilidad:** Modificar código existente para soportar nuevas variantes puede romper funcionalidades que ya funcionaban.
3. **Escalabilidad Combinatoria:** La complejidad crece multiplicativamente con el número de tipos en cada dimensión.

---

## 4. La Solución: Doble Despacho (*Double Dispatch*)

### Idea Fundamental
Dado que cada envío de mensaje elimina el polimorfismo de un objeto (convirtiéndolo en un tipo concreto dentro del método ejecutado), un problema con **$N$ variables polimórficas requiere una cadena de $N$ envíos de mensajes consecutivos**.

Para un problema de polimorfismo doble, se requieren **dos envíos de mensajes en cadena**.

---

### Paso a Paso de la Técnica

#### Paso 1: Retransmisión desde la primera jerarquía (Receptor inicial)
Cada clase de la primera dimensión (`ObjetoGrafico`) reenvía el mensaje al argumento (`Puerto`), enviando un **mensaje específico** que revela su propio tipo concreto pasándose a sí mismo (`self`) como argumento:

```smalltalk
<Rectangulo> representarseEn: unPuerto
    unPuerto representarRectangulo: self

<Ovalo> representarseEn: unPuerto
    unPuerto representarOvalo: self

<MapaDeBits> representarseEn: unPuerto
    unPuerto representarMapaDeBits: self
```

#### Paso 2: Implementación en la segunda jerarquía (Familia de mensajes polimórficos)
Cada clase concreta de la segunda dimensión (`Puerto`) implementa la **familia completa** de mensajes específicos (`representarX:`):

```smalltalk
<PuertoDePantalla> representarRectangulo: unRec
    "Código concreto para dibujar un rectángulo en pantalla"

<PuertoDePantalla> representarOvalo: unOvalo
    "Código concreto para dibujar un óvalo en pantalla"

<PuertoDeImpresora> representarRectangulo: unRec
    "Código concreto para dibujar un rectángulo en impresora"

<PuertoDeImpresora> representarOvalo: unOvalo
    "Código concreto para dibujar un óvalo en impresora"
```

---

## 5. Matriz de Extensibilidad y Modularidad

La técnica mantiene la modularidad completa orientada a objetos:

| Operación de Mantenimiento | Acción Requerida | Impacto en Código Existente |
|:--- |:--- |:--- |
| **Agregar nuevo Objeto Gráfico** (`Triangulo`) | 1. Definir `representarseEn:` en `Triangulo`.<br>2. Agregar `representarTriangulo:` en cada `Puerto`. | **Cero impacto** en rectángulos, óvalos, etc. existentes. |
| **Agregar nuevo Puerto** (`PuertoPDF`) | Implementar la familia `representarX:` en `PuertoPDF`. | **Cero impacto** en objetos gráficos ni puertos existentes. |

---

## 6. Decisión de Diseño: Dirección de la Retransmisión
El paper aclara que la dirección de la llamada puede invertirse (los puertos retransmiten hacia los objetos gráficos). La decisión de cuál es la jerarquía que inicia el doble despacho depende de **dónde pertenecen conceptualmente los métodos finales** y cuál dimensión es más probable que se extienda con mayor frecuencia.

---

## 7. Analogía Conceptual
Se puede entender el polimorfismo múltiple como **despejar incógnitas en un sistema de ecuaciones**:
* El estado inicial tiene 2 incógnitas (dos variables de tipo desconocido).
* El **primer envío de mensaje** resuelve/despeja la primera incógnita (identifica la clase concreta del receptor).
* El **segundo envío de mensaje** resuelve la segunda incógnita (identifica la clase concreta del argumento).
* Una vez resueltas ambas incógnitas, se ejecuta el bloque de código concreto sin condicionales ni `ifTrue:`.

---

## 8. Casos de Aplicación y Experiencia Práctica
El paper menciona tres aplicaciones reales donde esta técnica demostró su valor:
1. **Eventos y Controladores (Handlers):** Despacho de interacciones entre distintos tipos de eventos de usuario y sus respectivos manejadores.
2. **Programación Lógica (Unificación):** El método `unificarseCon:` donde tanto el receptor como el argumento pueden variar entre constantes, variables y términos.
3. **Coerción Aritmética:** Reescritura de la lógica de conversión entre tipos numéricos (enteros, flotantes, fracciones) en Smalltalk-80.

> **Nota sobre Multimétodos:** Algunos lenguajes (como CommonLoops o CLOS) soportan despacho múltiple nativo a nivel del lenguaje (*multimethods*). Para lenguajes con despacho simple (Smalltalk, Java, C++, C#, Python, etc.), esta técnica de **Doble Despacho** es el patrón estándar.

---

## 9. Conclusiones Clave
* El polimorfismo múltiple es un problema común pero resolible dentro del paradigma estándar de POO sin recurrir a type checking explícito.
* El principio rector es: **Chaining Messages / Double Dispatch**.
* Previene la explosión combinatoria de `if/else` y maximiza la adhesión al principio Open/Closed (Abierto a extensión, cerrado a modificación).
