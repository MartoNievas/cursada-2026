# Null Pattern Object

## Intencion

Proveer un sustituto para otro objeto que comparte la misma interfaz pero en realidad no hace nada. Por eso Objeto Nulo ya que encapsula las decisiones de implementacion de como "no hacer nada" y esconde los detalles de sus colaboradores.

A este mismo patron tambien se lo conoce como **Stub** o **Active Nothing**.

## Motivacion

A veces una clase que requiere un colaborador necesita que el mismo no haga nada. Pero a la vez, la clase desea tratarlo de la misma manera que trata a uno que si tenga comportamiento.

En el paper se menciona el ejemplo del paradigma Modelo-Vista-Controlador el cual tambien es un ejemplo del patron **strategy**, introduce este ejemplo que pueden existir vistas que no necesariamente requieren un controlador.
