# Resumen de la página 34 de *Smalltalk Best Practices Patterns: Method Object*

*Autor: Kent Beck*

## Introducción

La página nos introduce la siguiente pregunta:

**¿Cómo se escribe un método en el que muchas líneas de código comparten muchos argumentos y variables temporales?**

Como primera solución propone usar **Composed Method**, pero dice que esta solución oscurece la situación debido a que todas las variables y parámetros temporales también van a ser necesarios en el nuevo método.

La solución real es crear un objeto para representar la invocación del método y utilizar el espacio de nombres compartido de las variables de instancia en el objeto para permitir una mayor simplificación mediante **Composed Method**.

Estos objetos son diferentes a la mayoría de los objetos. Esto se debe a que los objetos suelen ser sustantivos, pero en este caso son verbos. Además, no suelen tener un análogo en la vida real. Sin embargo, valen la pena por su naturaleza extraña, debido a que representan una parte importante del comportamiento de un sistema.

## ¿Cómo utilizo Method Object?

1. Crear una clase nombrada a partir del método que generó la complejidad.
2. Añadir una variable de instancia para el receptor del método original, cada argumento y cada variable temporal.
3. Crear un mensaje de creación de instancia que tome el receptor original y los argumentos del método.
4. Crear un mensaje de instancia `#computar`, implementado copiando el cuerpo del método original.
5. Reemplazar el método original por uno que cree una instancia de la nueva clase y le envíe `#computar`.

**Kent Beck** menciona que no tenía pensado agregar este patrón, pero se dio cuenta de que, cuando lo necesitás, **REALMENTE** lo necesitás.
