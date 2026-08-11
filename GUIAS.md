# Estándar de Escritura para Guías Prácticas

Este documento define el formato que deben seguir las guías de ejercicios resueltas de este repositorio. Es el análogo de [`TEORICAS.md`](TEORICAS.md) pero para guías prácticas en vez de apuntes de teóricas — son géneros distintos: una teórica explica conceptos, una guía resuelve ejercicios puntuales de un enunciado. Sirve como referencia humana y como base de la skill de Claude Code `guias` (`.claude/skills/guias/SKILL.md`).

## Alcance

- `sistemas-operativos/guias-practicas-so/*.md`
- `isw/guias/**/*.md`
- Cualquier carpeta equivalente de una materia futura.

**Complejidad Computacional no tiene guías** (solo teóricas en PDF y sus resúmenes) — no aplica.

**Fuera de alcance**, son géneros distintos con su propio formato:
- `sistemas-operativos/talleres/*` — son consignas de taller con su propia dinámica de respuestas, no ejercicios de una guía numerada.
- `isw/primeros-parciales/*`, `isw/papers-resumenes/*` — parciales resueltos y resúmenes de papers, no guías.

## De dónde sale este estándar

Ninguna de las 7 guías existentes en `sistemas-operativos/guias-practicas-so/` sigue el mismo formato al 100% — hay inconsistencias en el título (`Práctica 4` vs `Practica 5`, sin tilde), en si se referencia el PDF del enunciado original, y en cuánto se usa `---` como separador. La que más cerca está de un formato completo y disciplinado es **`guia0-bash-makefile/guia0-bash.md`**: separa cada ejercicio y sub-ítem con `---`, le da a cada ejercicio un título descriptivo corto (no solo el número), y referencia el código externo con una convención clara (`> Código fuente: [...]`). Se usó como base, sumándole la referencia al PDF del enunciado (presente en `guia2`, `guia3`, `guia4`, `guia5`, y también en `isw/guias/guia1/parte2/guia1-parte2.md`) que `guia0` no tiene.

---

## 1. Estructura del documento

```markdown
# Práctica N: Título de la guía

**<Materia> — FCEyN, Universidad de Buenos Aires**

---

> Enunciado: [PDF](pN.pdf)

---

## Ejercicio 1 — Título corto descriptivo

Contenido de la resolución...

---

## Ejercicio 2 — Título corto descriptivo
...
```

- **Título (`#`):** sigue la convención de numeración propia de la materia — en Sistemas Operativos es `Práctica N: Tema` (siempre con tilde en "Práctica" y espacio antes de los dos puntos; no `Practica 5`, no `Práctica2`); en Ingeniería de Software es `Guía N — Sección M: Tema`, que es como ya se referencian en el `README.md` principal. Si una guía no tiene número formal (no hay PDF de enunciado numerado), usar un título temático simple.
- **Subtítulo:** igual que en teóricas, `**<Materia> — FCEyN, Universidad de Buenos Aires**` en negrita, línea propia. Ver tabla de subtítulos por materia en `TEORICAS.md` §1.1 (son las mismas).
- **Referencia al enunciado:** si existe un PDF con el enunciado original en la misma carpeta, se referencia con un blockquote justo después del primer `---`: `> Enunciado: [PDF](nombre.pdf)`. Si no existe PDF (ej. el enunciado se dio en clase o solo en el campus), omitir esta línea.

### 1.1 Título por ejercicio

Cada ejercicio, en lo posible, lleva un título corto que resuma de qué trata además del número — no solo `## Ejercicio 4`, sino `## Ejercicio 4 — Diagrama de Estados`. Esto es lo que hace a `guia0-bash-makefile` más navegable que el resto. Si el ejercicio no tiene un tema resumible en pocas palabras (frecuente en guías muy matemáticas, como scheduling o sincronización), es aceptable dejar solo `## Ejercicio N`.

---

## 2. Jerarquía de encabezados

- **`## Parte N — Título`** *(opcional)*: solo si el enunciado original divide la guía en partes (ej. "Parte 1: Terminal", "Parte 2: Makefile"). Es un separador temático, no un contenedor — los ejercicios que siguen NO se anidan como `###` dentro de la parte, siguen siendo `##`. Esto evita profundizar innecesariamente la jerarquía cuando la mayoría de las guías no tienen partes.
- **`## Ejercicio N — Título`**: la unidad organizativa principal. Numeración correlativa según el enunciado original (no renumerar).
- **`### a)` / `### b)` / ...** o **`### N.1` / `### N.2` / ...**: sub-ítems de un ejercicio, usando la misma convención de numeración/lettering que usa el enunciado original (letras si el enunciado usa letras, decimales si usa decimales — no mezclar convenciones dentro de una misma guía).
- **`####`**: solo para comparar alternativas nombradas dentro de un mismo sub-ítem (ej. `#### First Fit` vs `#### Worst Fit`, o `#### Con reemplazo LRU` vs `#### Con reemplazo FIFO`, como en `guia6-administracion-de-memoria.md`). No usar `####` para lo que puede ser un párrafo con **negrita** al inicio — mismo criterio que en `TEORICAS.md` §2.
- **Separador `---`** antes de cada `##` (Parte o Ejercicio). Dentro de un ejercicio largo con sub-ítems bien diferenciados, también se puede separar cada `###` con `---` (como hace `guia0`) — no es obligatorio en ejercicios cortos de un solo párrafo.

---

## 3. Contenido

- **Código de solución:** si la solución completa está en un archivo aparte dentro de `code/` (patrón ya usado en todas las guías de SO), referenciarlo con un blockquote: `> Código fuente: [`archivo.c`](code/archivo.c)`. Solo pegar el código inline cuando es corto (< ~20 líneas) o cuando vale la pena mostrar un fragmento puntual dentro de la explicación.
- **Bloques de código** siempre con el lenguaje anotado: ` ```c `, ` ```bash `, ` ```Smalltalk `, ` ```asm `, etc. Las transcripciones de terminal van con el prompt `$` y se anotan como ` ```bash `.
- **Imágenes:** `![Alt](img/archivo.png)` para diagramas simples, o el wrapper `<p align="center"><img src="..." alt="..."/></p>` para imágenes grandes — mismo criterio que en teóricas.
- **Tablas** para comparar opciones de un comando, algoritmos, parámetros o resultados numéricos de un ejercicio (cálculos de fragmentación, tiempos de scheduling, etc.).
- **Aclaraciones/abreviaturas** usadas a lo largo de la guía como blockquote al principio: `> **Aclaración:** turnaround lo abrevio con **TT**.` (patrón de `guia2-scheduling.md`).
- **Prosa de resolución:** explicar el razonamiento, no solo dar el resultado — el objetivo es que sirva para repasar antes de un parcial, no solo como respuestario.
- No corregir el contenido técnico de una resolución ya escrita al estandarizar formato — igual que en teóricas, es una tarea de estructura. Sí corregir typos evidentes de paso.

---

## 4. Qué NO lleva una guía (a diferencia de una teórica)

- **No lleva tabla de `## Resumen` final.** Una guía es una serie de ejercicios resueltos, no un resumen conceptual — el "resumen" de una guía es la lista de sus ejercicios, no una tabla de conceptos. No aplicar la regla de cierre de `TEORICAS.md` acá.
- **No lleva numeración `N.` en los `##` de Ejercicio/Parte** (a diferencia de las secciones de una teórica). El número ya está en el propio título (`Ejercicio 4`, `Parte 2`), duplicarlo como `## 4. Ejercicio 4` es redundante.

---

## 5. Subtítulo por materia

Igual que en `TEORICAS.md`:

| Carpeta | Subtítulo |
|---------|-----------|
| `sistemas-operativos/guias-practicas-so/` | `**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**` |
| `isw/guias/` | `**Ingeniería de Software — FCEyN, Universidad de Buenos Aires**` |

---

## 6. Archivos de referencia

- `sistemas-operativos/guias-practicas-so/guia0-bash-makefile/guia0-bash.md` — el más disciplinado en separadores y títulos descriptivos por ejercicio.
- `sistemas-operativos/guias-practicas-so/guia4-drivers/guia4-drivers.md` — buen ejemplo de `## Parte N` + referencia al enunciado + código con lenguaje anotado.
- `sistemas-operativos/guias-practicas-so/guia6-administracion-memoria/guia6-administracion-de-memoria.md` — buen ejemplo del uso de `####` para comparar alternativas nombradas (First Fit vs Worst Fit, LRU vs FIFO vs Second Chance).
- `isw/guias/guia1/parte2/guia1-parte2.md` — único ejemplo de ISW; muestra la convención decimal (`### 0.1`, `### 0.2`) en vez de lettering, un título con formato `Guía N — Sección M` (en vez de `Práctica N`), y bloques de código Smalltalk.

Las 7 guías de `guias-practicas-so/` y esta guía de ISW ya están reformateadas al 100% según este estándar. Al agregar una guía nueva o resolver un ejercicio en una existente, seguirlo desde el principio evita tener que reformatear después.
