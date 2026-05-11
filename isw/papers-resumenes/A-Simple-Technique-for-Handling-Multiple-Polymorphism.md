# Una Técnica Simple para Manejar el Polimorfismo Múltiple

## Introducción

El paper trata sobre el problema del **polimorfismo múltiple** en la programación orientada a objetos: situaciones donde más de una variable en una expresión es independientemente polimórfica. En tales casos, los mecanismos habituales de la POO dejan de funcionar, llevando a código no modular.

El autor propone una técnica simple que preserva todos los beneficios de las buenas prácticas orientadas a objetos, sin importar el grado de polimorfismo. El ejemplo está escrito en sintaxis de Smalltalk-80, pero la técnica es aplicable a cualquier lenguaje orientado a objetos.

---

## Polimorfismo y Mensajes

Al crear un lenguaje orientado a objetos, el envío de mensajes fue introducido como solución al problema del polimorfismo en lenguajes extensibles.

Los intentos anteriores fallaban porque los procedimientos tenían que verificar explícitamente el tipo de cada argumento y ejecutar el código correspondiente. Esto violaba los principios de modularidad y generaba una explosión combinatoria de complejidad.

La solución fue el **envío de mensajes**:

- El mecanismo de búsqueda de mensajes absorbe la verificación de tipos.
- Los métodos, siendo locales a su propia clase, no son polimórficos entre sí.
- Solo el receptor es polimórfico, y el sistema selecciona el método correcto automáticamente.

Todos los lenguajes orientados a objetos actuales soportan esta forma de **polimorfismo simple**, con un costo apenas mayor al de una llamada convencional a un procedimiento.

---

## El Problema

Surgen ciertas situaciones donde más de una variable en una expresión es independientemente polimórfica. En esos casos, el polimorfismo del receptor no alcanza y los programadores suelen revertirse a la verificación explícita de tipos.

Tomemos como ejemplo la representación de objetos gráficos en distintos tipos de puertos de salida:

- Una variable que contiene un **objeto gráfico** puede ser un rectángulo, óvalo, bitmap, texto, overlay, etc.
- Una variable que contiene un **puerto gráfico** puede ser un monitor, impresora, monitor remoto, etc.

Tenemos entonces una **interacción polimórfica doble**.

La solución ingenua consiste en verificar el tipo del puerto dentro de cada objeto gráfico:

```smalltalk
<Rectangulo> representarseEn: unPuertoGrafico
    unPuertoGrafico isMemberOf: PuertoDeMonitor
        ifTrue: ["Codigo para representarse en un monitor"].
    unPuertoGrafico isMemberOf: PuertoDeImpresora
        ifTrue: ["Codigo para representarse en una impresora"].
    unPuertoGrafico isMemberOf: PuertoDeRemoto
        ifTrue: ["Codigo para representarse en un monitor remoto"].
```

Si bien el código queda distribuido por objeto gráfico, presenta serios problemas:

- Agregar un nuevo tipo de puerto obliga a modificar **todos** los objetos gráficos existentes.
- La complejidad crece combinatoriamente con el grado de polimorfismo.
- Un error al modificar puede romper el soporte completo del ambiente.

Todos estos son problemas que la programación orientada a objetos debería haber resuelto.

---

## La Solución

Afortunadamente, la solución está disponible en todos los lenguajes orientados a objetos. La clave está en comprender la conexión entre el polimorfismo y el envío de mensajes.

**Cada envío de mensaje reduce una variable polimórfica a una monomórfica** por el tipo de despacho inherente a la búsqueda de mensajes. Si el problema tiene dos dimensiones de polimorfismo, entonces se necesitan **dos envíos de mensajes** en cadena.

### Paso 1 — Retransmisión desde el objeto gráfico

Cada objeto gráfico reenvía el mensaje al puerto, pasándose a sí mismo como argumento con un mensaje específico de su tipo:

```smalltalk
<Rectangulo> representarseEn: unPuerto
    unPuerto representarRectangulo: self

<Ovalo> representarseEn: unPuerto
    unPuerto representarOvalo: self

<MapaDeBits> representarseEn: unPuerto
    unPuerto representarMapaDeBits: self
```

### Paso 2 — Implementación en cada clase de puerto

Ahora cada clase de puerto implementa la familia completa de mensajes específicos:

```smalltalk
<PuertoDePantalla> representarRectangulo: unRec
    "Codigo para representar un rectangulo en pantalla"

<PuertoDePantalla> representarOvalo: unOvalo
    "Codigo para representar un ovalo en pantalla"

<PuertoDeImpresora> representarRectangulo: unRec
    "Codigo para representar un rectangulo en impresora"

<PuertoDeImpresora> representarOvalo: unOvalo
    "Codigo para representar un ovalo en impresora"
```

Esta solución conserva la modularidad del estilo orientado a objetos:

- **Agregar un nuevo objeto gráfico:** solo definir el mensaje de retransmisión en la nueva clase y los métodos correspondientes en cada puerto. El código existente no se toca.
- **Agregar un nuevo puerto:** solo implementar la familia completa de mensajes `representarX:`. Nada más.

La solución inversa —donde los puertos se retransmiten a los objetos gráficos— tiene propiedades de modularidad igualmente buenas. La elección depende de una decisión de diseño sobre dónde pertenecen conceptualmente los métodos finales.

La técnica también se puede extender a **grados más altos de polimorfismo**: cada envío de mensaje subsiguiente reduce una dimensión adicional. Afortunadamente, así como el polimorfismo doble es mucho menos común que el simple, los grados más altos son aún más raros.

---

## Experiencia

El enfoque ha demostrado su eficacia en varias situaciones más allá del ejemplo de visualización:

- **Eventos y controladores:** la interacción entre diferentes tipos de eventos y sus manejadores.
- **Programación lógica:** el mensaje `unificarseCon:` donde tanto el receptor como el argumento son polimórficos en constantes, variables, términos y otras formas.
- **Coerción aritmética:** una reescritura experimental de la lógica de coerción aritmética en el sistema Smalltalk-80.

---

## Referencias

[1] *CommonLoops: Merging Lisp and Object-Oriented Programming*, Daniel Bobrow et al., Proceedings of OOPSLA '86, September 1986, Portland Oregon.
