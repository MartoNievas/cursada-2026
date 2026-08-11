# Test Driven Development (TDD)

**Ingeniería de Software — FCEyN, Universidad de Buenos Aires**

---

## 1. ¿Qué es TDD?

Empezamos por responder una pregunta elemental: el **TDD** es una técnica tanto de aprendizaje como de desarrollo de software, que tiene las siguientes características:

- Es iterativa e incremental, es decir la solución se va armando de manera gradual.
- Está basada en el feedback inmediato.

Como efectos secundarios, esta técnica permite:

- Recordar mejor todo lo aprendido.
- Asegurarnos de no haber desaprendido.

La misma incluye análisis, diseño, programación y testing.

---

## 2. ¿Cómo se hace TDD?

A continuación se detalla un algoritmo para poder aplicar esta técnica al desarrollo:

1. **Escribir un test** sobre el modelo a desarrollar.
   - Debe ser el más sencillo que se nos ocurra.
   - Debe fallar al correrlo.
2. **Correr todos los tests** del modelo.
   - Implementar la solución más simple que haga pasar los tests.
   - Volver al paso 2 hasta que todos los tests pasen.
3. **Reflexionar:** ¿se puede mejorar el código?
   - Sí → refactorizar y volver al paso 2.
   - No → volver al paso 1.

---

## 3. Estructura de los Tests

Vamos a dividir los tests en 3 secciones, siguiendo el siguiente orden:

- **Setup:** establece el contexto inicial para la ejecución del test. Es la pre-condición del test (puede estar refactorizada en un mensaje `setUp`).
- **Exercise:** ejecuta la funcionalidad específica que se está testeando. Determina QUÉ se está testeando.
- **Assert:** verifica que los resultados sean los esperados. Es la post-condición del test.

---

## Resumen

| Concepto | Descripción |
|----------|-------------|
| **TDD** | Técnica de aprendizaje y desarrollo iterativa, incremental y basada en feedback inmediato. |
| **Ciclo TDD** | Escribir un test que falle → hacerlo pasar con la solución más simple → reflexionar y refactorizar. |
| **Setup** | Sección del test que arma el contexto inicial (pre-condición). |
| **Exercise** | Sección del test que ejecuta la funcionalidad testeada. |
| **Assert** | Sección del test que verifica el resultado esperado (post-condición). |
