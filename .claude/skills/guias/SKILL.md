---
name: guias
description: Aplica el estándar de formato del repo (título + subtítulo de materia, referencia al enunciado, Ejercicio como unidad organizativa, sin tabla de Resumen) al escribir, editar o estandarizar guías de ejercicios resueltas. Usar cuando se crea una guía nueva, cuando se resuelve un ejercicio de una práctica, o cuando se pide estandarizar/prolijar el formato de archivos existentes en sistemas-operativos/guias-practicas-so, isw/guias o carpetas equivalentes de otras materias.
---

# Skill: Guías Prácticas

Estandariza guías de ejercicios resueltos de cualquier materia de este repo. El estándar completo, con ejemplos y justificación, vive en [`GUIAS.md`](../../../GUIAS.md) en la raíz del repo — **leelo antes de escribir o reestructurar una guía**, sobre todo la sección 2 (jerarquía de encabezados) y la 4 (qué NO lleva una guía, a diferencia de una teórica).

No confundir con la skill `teoricas`: una guía resuelve ejercicios de un enunciado puntual, una teórica resume conceptos de una clase. Tienen estructura de cierre distinta (una guía no lleva tabla de Resumen final) y unidad organizativa distinta (Ejercicio vs Sección numerada).

## Checklist rápido

Al crear o editar una guía:

1. **Encabezado:**
   ```markdown
   # Práctica N: Título de la guía

   **<Materia> — FCEyN, Universidad de Buenos Aires**

   ---

   > Enunciado: [PDF](pN.pdf)

   ---
   ```
   `Práctica` siempre con tilde y espacio antes de los dos puntos. Omitir la línea de enunciado si no hay PDF en la carpeta. Subtítulo según la tabla en `GUIAS.md` §5 (mismos valores que `TEORICAS.md`).

2. **Ejercicios como unidad principal**, sin numerar con `N.` (el número ya está en el título):
   - `## Parte N — Título` — opcional, solo si el enunciado original tiene partes; es un separador temático, NO se anidan los ejercicios debajo como `###`.
   - `## Ejercicio N — Título corto` — título descriptivo si es posible, no solo el número.
   - `### a)` / `### b)` o `### N.1` / `### N.2` — sub-ítems, siguiendo la convención (letras o decimales) que use el enunciado original, sin mezclarlas.
   - `####` solo para comparar alternativas nombradas dentro de un sub-ítem (ej. First Fit vs Worst Fit). Si no es una comparación con nombre propio, usar negrita en vez de un heading.
   - `---` antes de cada `##`.

3. **Código:** si la solución es un archivo aparte en `code/`, referenciarlo con `> Código fuente: [`archivo`](code/archivo)` en vez de pegarlo entero. Bloques de código siempre con el lenguaje anotado.

4. **NO agregar tabla de `## Resumen` al final** — eso es exclusivo del estándar de teóricas (`TEORICAS.md`), no aplica a guías.

5. **No tocar contenido técnico** al reformatear una guía existente — la tarea es de estructura. Sí corregir typos evidentes de paso.

## Cuándo NO aplica

- `sistemas-operativos/talleres/*` — formato de taller, no de guía.
- `isw/primeros-parciales/*` — parciales resueltos, formato propio.
- `isw/papers-resumenes/*` — resúmenes de papers, formato propio.
- Apuntes de teóricas/clase → usar la skill `teoricas` en su lugar.

## Archivos de referencia

- `sistemas-operativos/guias-practicas-so/guia0-bash-makefile/guia0-bash.md` — separadores y títulos descriptivos por ejercicio.
- `sistemas-operativos/guias-practicas-so/guia4-drivers/guia4-drivers.md` — `## Parte N` + referencia a enunciado.
- `sistemas-operativos/guias-practicas-so/guia6-administracion-memoria/guia6-administracion-de-memoria.md` — uso correcto de `####` para alternativas nombradas.
- `isw/guias/guia1/parte2/guia1-parte2.md` — convención decimal de sub-ítems y código Smalltalk.
