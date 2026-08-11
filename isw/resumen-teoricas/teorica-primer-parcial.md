# Resumen Primer Parcial — TEO

**Ingeniería de Software — FCEyN, Universidad de Buenos Aires**

---

## 1. Software

**Definición:** Es un modelo computable de un dominio de problema de la realidad, el modelo computable representa "el que" e implementa el "como". Tambien representa conocimiento sobre el problema.

## 2. Modelo y Dominio del Problema

**Definición:**
> Representamos el *qué* e implementamos el *cómo* como software: un modelo computable de un dominio de problema de la realidad.

| Concepto | Definición |
|----------|-----------|
| **Modelo** | Representación de aquello que se está modelando |
| **Computable** | Puede ejecutar en una máquina de Turing |
| **Dominio del problema** | Lo que una persona/organización entiende sobre un problema |

**Características de un buen modelo:**
- Funcional
- Descriptivo

---

## 3. Conceptos Fundamentales de OOP

### 3.1 Objetos y mensajes

| Concepto | Definición |
|----------|-----------|
| **Objeto** | Representación esencial de un ente del dominio del problema |
| **Mensaje** | Qué declarativo que se envía a un objeto |
| **Método** | Especificación de las colaboraciones que ejecuta un objeto al recibir un mensaje |
| **Colaboración** | El hecho de enviar un mensaje |
| **Contexto (Ctx)** | Estado de ejecución de un método |

**Programas** = conjunto de objetos que colaboran entre sí enviándose mensajes.

### 3.2 Propiedades de la colaboración

1. Sincrónica
2. Dirigida
3. Siempre se espera un resultado
4. El receptor desconoce al emisor

### 3.3 Prioridad de mensajes

1. **Unario** (mayor prioridad) — ej: `factorial`
2. **Binario** — ej: `+ - * /`
3. **Keyword** (menor prioridad) — ej: `at:put:`

### 3.4 Variables especiales

| Variable | Descripción |
|----------|------------|
| `self` | El objeto receptor del mensaje actual |
| `thisContext` | El contexto de ejecución actual |

> No hay que definirlas ni inicializarlas.

---

## 4. Relaciones entre Objetos

### 4.1 Relación de conocimiento

```
[ObjetoA] ----nombre----> [ObjetoB]
```

- Se implementa mediante **variables de instancia**
- El nombre de un objeto representa el rol que cumple en el contexto donde está siendo nombrado

---

## 5. Heurísticas de Diseño

> Son reglas a seguir según el contexto, no reglas absolutas.

### 5.1 H1 — Minimizar el acoplamiento
- Medida de relación entre objetos
- A menor acoplamiento, mejor

### 5.2 H2 — Maximizar la cohesión funcional
- Cuanto menos cosas hace un objeto, más cohesivo es
- Hace más, hace bien

### 5.3 H3 — No romper el encapsulamiento
- Evitar getters innecesarios
- Evitar setters innecesarios

### 5.4 H4 — Reglas de creación de objetos

- Siempre crear objetos **completos** (ej: una fecha no puede definirse parcialmente)
- Un único método de creación de instancia que use `new`, el resto se implementa en base a él
- Solo crear objetos **válidos** (verificar en el momento de creación)
- Favorecer objetos **inmutables**
- Evitar `nil` / `null`

---

## 6. Polimorfismo

**Definición:** Relación entre un conjunto de objetos y un conjunto de mensajes. Los objetos son polimórficos entre sí respecto de un conjunto de mensajes si saben responder dichos mensajes con semántica equivalente.

### 6.1 Clase vs Prototipo

| | Clase (Aristóteles) | Prototipo (Wittgenstein) |
|-|---------------------|--------------------------|
| **Idea** | Esencia / idea de algo | El molde de los objetos |
| **En Smalltalk** | Toda clase es un objeto | Solo objetos, no hay clases en el sentido clásico |

### 6.2 Protocolo
- Conjunto ordenado de mensajes de un objeto
- `subclassResponsibility` — indica que el mensaje debe ser implementado por la subclase

---

## 7. Abstracción — Eliminar Código Repetido

> Las abstracciones surgen de ver código repetido concreto.

**Algoritmo:**

1. Mover el código a una nueva abstracción (objeto / mensaje / ...)
2. Parametrizar lo que cambia
3. **Nombrar** la nueva abstracción ← *lo más importante*
4. Reemplazar el código repetido original por el uso de la nueva abstracción

> ⚠️ No se pueden usar ciclos en nodos de más arriba del árbol de ejecución.

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| **Software** | Modelo computable de un dominio de problema; implementa el "cómo" de un "qué". |
| **Objeto** | Representación esencial de un ente del dominio del problema. |
| **Mensaje** | Qué declarativo enviado a un objeto; el receptor decide el "cómo" (método). |
| **self / thisContext** | Variables especiales: el receptor actual y el contexto de ejecución actual. |
| **Relación de conocimiento** | Se implementa mediante variables de instancia con nombre según el rol. |
| **H1–H4** | Heurísticas de diseño: minimizar acoplamiento, maximizar cohesión, no romper encapsulamiento, crear objetos completos y válidos. |
| **Polimorfismo** | Un conjunto de objetos responde con semántica equivalente a un mismo conjunto de mensajes. |
| **Protocolo** | Conjunto ordenado de mensajes que entiende un objeto. |
| **Abstracción** | Se extrae de código repetido concreto; el paso clave es nombrarla bien. |

