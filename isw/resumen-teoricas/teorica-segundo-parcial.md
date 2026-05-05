# Test Driven Development (TDD)

## ¿Qué es TDD?

Empezemos por responder una pregunta elementar, el **TDD** es una tecnica tanto de aprendizaje como de desarrollo de software, que tiene las siguientes caracterisiticas:

- Es iterativa e incremental, es decir la solución se va armando de manera gradual.

- Basada en el feedback inmediato.

Como efectos secundarios esta técnica tiene:

- Se recuerda mejor todo lo aprendido

- Y permite asegurarnos no haber desaprendido.

La misma incluye análisis, diseño, programación y testing.

## ¿Cómo se hace TDD?

A continuación se detalla un algoritmo para poder aplicar está técnica al desarrollo:

1. Escribir un test sobre el modelo a desarrollar.

  - Debe ser el más sencillo que nos ocurra.
  - Debe fallar al correrlo.

2. Correr todos los tests del modelo.
  
  - Implementar la solución más simple que haga pasar los tests.

  - GOTO 2 hasta que "todos los tests" pasen.

3. Reflixiono - ¿Se puede mejorar el código?

  - Si -> Refactorizar. GOTO 2
  
  - No -> GOTO 1

## Estructura de los tests

Vamos a dividir los tests en 3 secciones siguiendo el siguiente orden:

- **Setup:** Aquí establecemos el contexto inicial para la ejecución del test Pre'condición del test (puede ser reufucado en mensaje setUp).

- **Exercise:** Ejecita la funcionalidad específica que se está testeando. Determina QUÉ se está testeando.

- **Assert:** Verifica que los resultado sean los esperado. Post-condición del test.
