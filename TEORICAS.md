# Estándar de Escritura para Teóricas

Este documento define el formato que deben seguir todos los apuntes/resúmenes de clases teóricas de este repositorio, sin importar la materia. Sirve como referencia humana y como base de la skill de Claude Code `teoricas` (`.claude/skills/teoricas/SKILL.md`), que aplica este estándar automáticamente al escribir o editar este tipo de archivos.

Aplica a:

- `sistemas-operativos/teoricas/*.md`
- `isw/resumen-teoricas/*.md`
- `complejidad-computacional/resumenes/*.md`
- Cualquier carpeta equivalente de una materia futura (resúmenes/apuntes de teóricas, no guías de ejercicios ni resúmenes de papers).

---

## 1. Estructura del documento

Todo archivo de teórica sigue este esqueleto, en este orden:

```markdown
# Título de la clase o tema

**<Nombre completo de la materia> — FCEyN, Universidad de Buenos Aires**

---

## 1. Primera sección
...

---

## 2. Segunda sección
...

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| ... | ... |
```

- **Título (`#`):** describe la clase o el tema, no solo "Clase N" a secas si el tema tiene nombre propio (ej. `# Scheduling (Planificación de Procesos)`, no `# Teórica 3`).
- **Subtítulo:** siempre en negrita, siempre `**<Materia> — FCEyN, Universidad de Buenos Aires**`, en una línea sola después del título.
- **`---` inicial:** separa el subtítulo del contenido.
- **`## Resumen` final:** sin numerar (es la única sección `##` sin número), siempre al final del documento, siempre con una tabla de dos columnas `Concepto | Descripción`.

### 1.1 Subtítulo por materia

| Carpeta | Subtítulo |
|---------|-----------|
| `sistemas-operativos/teoricas/` | `**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**` |
| `isw/resumen-teoricas/` | `**Ingeniería de Software — FCEyN, Universidad de Buenos Aires**` |
| `complejidad-computacional/resumenes/` | `**Complejidad Computacional — FCEyN, Universidad de Buenos Aires**` |

Si se agrega una materia nueva, seguir el mismo patrón con su nombre completo.

---

## 2. Jerarquía de encabezados

- **`## N. Título`** — secciones de primer nivel, numeradas correlativamente desde 1 en todo el documento (no reinician por sub-tema).
- **`### N.M Título`** — subsecciones, numeradas dentro de su sección padre (`### 3.1`, `### 3.2`, ...).
- **No usar `####` ni niveles más profundos.** Si dentro de una subsección `###` hace falta un tercer nivel de desglose (por ejemplo, varios sub-casos o "Esquema 1 / Esquema 2"), resolverlo con **texto en negrita como inicio de párrafo** en lugar de un heading nuevo:

  ```markdown
  **Ventaja frente a la FAT.** La gran ventaja de los i-nodes es el uso de memoria...
  ```

  en vez de:

  ```markdown
  #### Ventaja frente a la FAT
  ```

- **Separador `---`** antes de cada sección `##` nueva (no antes de `###`). La única excepción es la primera sección del documento, que ya queda separada por el `---` del encabezado.
- Cuando una sección tiene un caso de uso recurrente que se repite varias veces con el mismo patrón (por ejemplo, "Ejemplo" en cada algoritmo de scheduling), es aceptable usar `####` **solo si ya es el patrón establecido y consistente en ese archivo particular** (ver `sistemas-operativos/teoricas/teo3-scheduling.md`, que usa `#### Ejemplo X` bajo cada `### algoritmo`). Fuera de ese caso, preferir negrita en vez de un cuarto nivel de heading.

---

## 3. Tono y contenido

- Prosa explicativa en español, tono de apunte de estudio: directo, sin relleno, pero completo — no es una lista de keywords, es una explicación que alguien que faltó a la clase pueda seguir.
- **Negrita** para destacar el término técnico la primera vez que se define (`Un **proceso** es un programa en ejecución.`).
- Tablas markdown para comparaciones, enumeraciones de propiedades, algoritmos o parámetros — no para prosa continua.
- Bloques de código con el lenguaje anotado (` ```c `, ` ```bash `, ` ```asm `, etc.), nunca bloques sin anotar si el contenido es código.
- Fórmulas matemáticas en LaTeX cuando corresponda: `$...$` inline, `$$...$$` en bloque (uso intensivo en Complejidad Computacional, ocasional en Sistemas Operativos y en Ingeniería de Software).
- Diagramas ASCII (como en las teóricas de procesos/IPC/scheduling de SO) o imágenes ya alojadas (`<p align="center"><img src="..." alt="..."/></p>`) para ilustrar cuando aporten más que el texto.
- Notas o advertencias como blockquote: `> **Nota:** ...` / `> **Importante:** ...` / `> **Problema:** ...`.
- No corregir el contenido técnico ni la terminología del apunte al estandarizar formato — el estándar es sobre estructura, no sobre reescribir lo que el apunte dice. Sí corregir errores tipográficos evidentes (typos, palabras cortadas, tildes faltantes en prosa nueva) cuando se toca esa sección de todos modos.

---

## 4. La tabla de Resumen final

- Siempre la última sección, siempre titulada `## Resumen` (sin número).
- Siempre tabla de 2 columnas: `| Concepto | Descripción |`.
- Una fila por cada definición, algoritmo, teorema o término clave introducido en el documento — prioridad a lo que definiría un examen, no a detalles de implementación.
- Fiel al contenido real del archivo: no se agregan conceptos que no aparecen en el cuerpo del documento.
- Sirve como repaso rápido — alguien debería poder estudiar solo de esa tabla para un repaso exprés.

---

## 5. Archivos de referencia

Ejemplos ya estandarizados con este formato, uno por materia:

- `sistemas-operativos/teoricas/teo1-procesos.md` — ejemplo canónico (prosa + diagramas ASCII).
- `isw/resumen-teoricas/teorica-primer-parcial.md` — ejemplo con heurísticas numeradas (H1–H4) integradas a la numeración de secciones.
- `complejidad-computacional/resumenes/clase1-resumen.md` — ejemplo con notación matemática/LaTeX densa.

Ante la duda de cómo resolver un caso particular, mirar cómo se resolvió un caso análogo en alguno de estos tres antes de improvisar un patrón nuevo.
