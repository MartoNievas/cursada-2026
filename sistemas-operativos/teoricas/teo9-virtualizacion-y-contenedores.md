# Virtualización y Contenedores

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. Virtualización

### 1.1 Definición de virtualización

**Definición:** es la posibilidad de que un conjunto de recursos físicos se vean como varias copias de recursos lógicos.

Los objetivos de la virtualización son variados:

* **Portabilidad:** un ejemplo es la **Java Virtual Machine** (en teoría)
* **Simulación/Testing**
* Aislamiento (como chroot, jail, etc.)
* Particionamiento de HW
* Agrupamiento de funciones
* Protección ante fallas de HW (migración de HW)
* Migración entre HW sin pérdida de servicio

---

### 1.2 Requerimientos para la virtualización

Un **Virtual Machine Monitor (VMM)**, también conocido como **Hipervisor**, formalizado por **Popek y Goldberg**, controla la ejecución de una o más máquinas virtuales. Para ser considerado como tal, debe cumplir ciertas propiedades clásicas:

* **Control de recursos (resource control):** el VMM conserva el control de los recursos físicos de la máquina.

* **Fidelidad (equivalence):** el comportamiento de un programa en una máquina virtual debería ser idéntico al del programa corriendo en el hardware físico.

* **Eficiencia:** la mayoría del código en la máquina virtual debería correr sin intervención del hipervisor, es decir, debería usar las instrucciones del procesador.


## 2. Contenedores

## 3. Cloud