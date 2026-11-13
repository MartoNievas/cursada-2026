# ejercicio-3-p4-tus-libros-final

## Aclaraciones para la entrega

La clase principal se debe llamar TusLibrosSystemFacade

El protocolo de instancia que debe respetar es:

```
TusLibrosSystemFacade >> createCartFor: authenticatedWith:
TusLibrosSystemFacade >> listCartIdentifiedAs:
TusLibrosSystemFacade >> add:of:toCartIdentifiedAs:
TusLibrosSystemFacade >> checkOutCartIdentifiedAs:withCreditCardNumbered:ownedBy:expiringOn:
TusLibrosSystemFacade >> listPurchasesOf:authenticatingWith:
TusLibrosSystemFacade >> sessionDuration (elejimos dejar este valor en un único lugar)
TusLibrosSystemFacade >> invalidUserAndOrPasswordErrorDescription
TusLibrosSystemFacade >> invalidCartIdErrorDescription
TusLibrosSystemFacade >> sessionHasExpiredErrorDescription
```

La clase se crear de este modo:

```
TusLibrosSystemFacade class >>
authenticatingWith: diccionario de ususarios y passwords
acceptingItemsOf: diccionario catalogo
registeringOn: collección ordenada de libro de ventas
debitingThrought: merchantProcessor
measuringTimeWith: reloj
```

El reloj debe responder now y today, y se debe crear con now: que recibe un DateAndTime.

Mensaje del reloj para adelantar el tiempo

```
clock advanceTime: aDuration
clock revertTime: aDuration
```

Ejemplo de código que debe funcionar al crear la interfaz en los tests:

```
testObjectsFactory := StoreTestObjectsFactory new.
clock := ManualClock now: testObjectsFactory today.
systemFacade := TusLibrosSystemFacade
authenticatingWith: self validUsersAndPasswords
acceptingItemsOf: testObjectsFactory defaultCatalog
registeringOn: self createSalesBook
debitingThrought: self merchantProcessor
measuringTimeWith: clock

listCartIdentifiedAs: cartId
listPurchasesOf: user authenticatingWith: password
```

No estamos implementando la cara externa de la interfaz sino la interna. Solo objetos y mensajes. Por lo que no abordamos esos strings que provendrían de una response http.

El manejo de Error en la cara interna es por excepciones, nunca códigos de error.

En el repo van a encontrar el `StoreTestObjectsFactory.st` con: `TestObjectFactory` que también tiene mensajes nuevos que se necesitan desde los tests