# Resumen del Patrón: Template Method Pattern
**Autores:** Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides (Gang of Four)

---

## 1. Intención

Definir un esqueleto de un algoritmo dentro de una operación, difiriendo algunos pasos a las subclases. **Template Method** permite que las subclases redefinan ciertos pasos de un algoritmo sin cambiar la estructura del mismo.

## 2. Motivación

Considere un framework de aplicaciones que provee las clases abstractas `Application` y `Document`. La clase `Application` es responsable de gestionar y abrir documentos existentes almacenados en formatos externos (como archivos en disco). Un objeto `Document`, a su vez, representa el modelo de datos una vez que ha sido leído e instanciado.

Las aplicaciones construidas sobre este framework deben derivar mediante herencia ambas abstracciones para satisfacer requerimientos específicos. Por ejemplo:

* Una aplicación de dibujo define las subclases `DrawingApplication` y `DrawingDocument`.
* Una aplicación de hojas de cálculo define las subclases `SpreadsheetApplication` y `SpreadsheetDocument`.

### El problema: la necesidad de fijar el algoritmo sin fijar las variantes

El framework debe coordinar el flujo global para abrir un documento. Esta secuencia incluye verificar permisos, instanciar la clase concreta adecuada, registrarla internamente, preparar el contexto y leer el contenido.

Si cada aplicación concreta reimplementara este procedimiento completo, se produciría una duplicación sistemática de la lógica de control. Sin embargo, la clase abstracta `Application` no puede conocer de antemano qué subclase concreta de `Document` debe instanciarse ni cómo lee sus datos cada formato particular.

### La solución: el método plantilla (*Template Method*)

El patrón resuelve este dilema definiendo el algoritmo en una operación de la clase madre —el **método plantilla**— expresado en términos de pasos invariantes y pasos abstractos diferidos a las subclases.

En la clase abstracta `Application`, el método plantilla `OpenDocument` fija el esqueleto y el orden de ejecución:

```cpp
void Application::OpenDocument (const char* name) {
    if (!CanOpenDocument(name)) {
        // No se puede abrir el documento
        return;
    }

    Document* doc = DoCreateDocument();

    if (doc) {
        _docs->AddDocument(doc);
        AboutToOpenDocument(doc);
        doc->Open();
        doc->Read();
    }
}
```

## 3. Aplicabilidad

El patrón **Template Method** debe utilizarse:

* Para implementar las partes invariantes de un algoritmo una sola vez y dejar que las subclases implementen el comportamiento que puede variar.

* Cuando el comportamiento común entre subclases debe ser factorizado y concentrado en una clase común para evitar la duplicación de código.

* Para controlar las extensiones de las subclases.

## 4. Estructura y Participantes

* **AbstractClass (`Application`):**

    * Define **operaciones primitivas** abstractas que las subclases concretas definen para implementar los pasos de un algoritmo.
    * Implementa un método plantilla que define el esqueleto de un algoritmo. El método plantilla invoca operaciones primitivas, así como operaciones definidas en `AbstractClass`.

* **ConcreteClass (`MyApplication`):**

    * Implementa operaciones primitivas para llevar a cabo los pasos del algoritmo específico de la subclase.

En cuanto a las colaboraciones, `ConcreteClass` se apoya en `AbstractClass` para implementar la parte invariante del algoritmo.

## 5. Consecuencias

Los **Template Methods** son fundamentales para la reutilización de código, los mismos conducen a una estructura de control invertida que a veces se denomina *the Hollywood principle*, esto hace referencia a cómo una clase madre invoca las operaciones de una subclase, y no al revés.

Los métodos plantilla llaman a los siguientes tipos de operaciones:

* Operaciones concretas.
* Operaciones concretas de `AbstractClass`.
* Operaciones primitivas.
* *Factory Methods*.
* **Hook operations**, que proveen un comportamiento predeterminado que las subclases pueden extender si es necesario.

Es de vital importancia que los **Template Methods** especifiquen con claridad cuáles operaciones son **Hook operations** y cuáles operaciones son abstractas.

## 6. Implementación

Al implementar un método plantilla, se destacan tres aspectos de diseño:

* **Control de acceso e invariancia:** El método plantilla no debe ser virtual para impedir que las subclases alteren la estructura del algoritmo. Las operaciones primitivas se declaran protegidas (`protected`) para restringir su invocación, y virtuales puras (`pure virtual`) si su redefinición es obligatoria.
* **Minimización de operaciones primitivas:** Conviene reducir al mínimo la cantidad de pasos abstractos que las subclases deben implementar; demasiadas operaciones primitivas hacen tediosa la extensión del framework o clase base.
* **Convenciones de nomenclatura:** Se recomienda usar prefijos consistentes (por ejemplo, el prefijo `Do-` como en `DoCreateDocument` o `DoRead`) para identificar explícitamente qué métodos están diseñados para ser sobrescritos por las subclases.

## 7. Usos Conocidos

* En **Smalltalk-80**, la clase `Magnitude` define operadores de comparación `>`, `<=` y `>=` en términos primitivos del método `<`. Las subclases implementan solo el método `<`, y heredan el resto de la semántica relacional invariante sin duplicar código.

* En **ET++ e InterViews**, los métodos de visualización de vistas y componentes gráficos están estructurados como **Template Methods** que preparan el contexto gráfico, delegan el dibujo a las subclases y restablecen el contexto.

## 8. Patrones Relacionados

* **Factory Method:** Los métodos de fábrica son frecuentemente invocados desde **Template Methods**. En el ejemplo de la Motivación, el método `DoCreateDocument` es un Factory Method invocado por el template method `OpenDocument`.

* **Strategy:** Los template methods usan la herencia para variar partes de un algoritmo (alcance de clase). Las estrategias usan la delegación y composición para variar el algoritmo completo (alcance de objeto).