---
name: teoricas
description: Aplica el estándar de formato del repo (título + subtítulo de materia, secciones numeradas, tabla de Resumen final) al escribir, editar o estandarizar apuntes de teóricas/clases. Usar cuando se crea un apunte nuevo de una teórica, cuando se pide "resumir la clase X", o cuando se pide estandarizar/prolijar el formato de archivos existentes en sistemas-operativos/teoricas, isw/resumen-teoricas, complejidad-computacional/resumenes o carpetas equivalentes de otras materias.
---

# Skill: Teóricas

Estandariza apuntes de clases teóricas de cualquier materia de este repo. El estándar completo, con ejemplos y justificación, vive en [`TEORICAS.md`](../../../TEORICAS.md) en la raíz del repo — **leelo antes de escribir o reestructurar un archivo**, sobre todo la sección 2 (jerarquía de encabezados) y la 4 (tabla de Resumen), porque ahí están los casos borde (cuándo usar negrita en vez de `####`, cómo numerar subsecciones que ya tienen su propia numeración temática como "H1–H4", etc.).

## Checklist rápido

Al crear o editar un archivo de teórica:

1. **Encabezado:**
   ```markdown
   # Título de la clase o tema

   **<Materia> — FCEyN, Universidad de Buenos Aires**

   ---
   ```
   Usar el subtítulo exacto según la carpeta (tabla en `TEORICAS.md` §1.1). Si es una materia nueva sin precedente, usar `**<Nombre completo de la materia> — FCEyN, Universidad de Buenos Aires**`.

2. **Secciones numeradas**, sin reiniciar la numeración por sub-tema:
   - `## N. Título` para secciones de primer nivel.
   - `### N.M Título` para subsecciones.
   - Nunca `####` o más profundo (salvo un patrón ya establecido y consistente en ese archivo puntual, ver `TEORICAS.md` §2) — si hace falta un tercer nivel, usar `**Sub-tema.** texto...` en negrita al inicio del párrafo.
   - `---` antes de cada `##` nuevo.

3. **Cierre obligatorio:**
   ```markdown
   ## Resumen

   | Concepto | Descripción |
   |----------|-------------|
   | ... | ... |
   ```
   Sin numerar, tabla de 2 columnas, fiel al contenido real del archivo (no inventar conceptos), cubriendo definiciones/algoritmos/teoremas centrales.

4. **No tocar contenido técnico** al reformatear un archivo existente — la tarea es de estructura, no de reescritura. Sí corregir typos evidentes de paso.

## Cuándo NO aplica

- Guías de ejercicios resueltas (`*/guias/*`, `*/guias-practicas-so/*`) — tienen su propio formato de enunciado/solución, no el de teóricas.
- Resúmenes de papers (`isw/papers-resumenes/*`) — formato de resumen de paper académico, distinto género.
- Parciales resueltos.

## Archivos de referencia

Si hay dudas sobre cómo resolver un caso concreto, mirar cómo se resolvió antes en:

- `sistemas-operativos/teoricas/teo1-procesos.md` y `teo7-memoria.md`
- `isw/resumen-teoricas/teorica-primer-parcial.md` y `metamodelo-method-lookup-excepciones.md`
- `complejidad-computacional/resumenes/clase1-resumen.md`
