#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/uaccess.h>

static dev_t major;
static struct cdev nulo_device;
static struct class *nulo_class;

static ssize_t nulo_read(struct file *filp, char __user *data, size_t s,
                         loff_t *off) {
  // Si el offset es mayor a 0, significa que ya "leímos" el final del archivo
  if (*off > 0)
    return 0;

  // /dev/null siempre devuelve 0 (EOF) inmediatamente
  return 0;
}

static ssize_t nulo_write(struct file *filp, const char __user *data, size_t s,
                          loff_t *off) {
  // IMPORTANTE: Devolvemos s (la cantidad de bytes recibidos).
  // Si devolvemos 0, el kernel cree que no pudo escribir y reintenta
  // infinitamente.
  *off += s;
  return s;
}

static struct file_operations nulo_operaciones = {
    .owner = THIS_MODULE,
    .read = nulo_read,
    .write = nulo_write,
};

static int __init hello_init(void) {
  // 1. Reservar el número mayor dinámicamente
  if (alloc_chrdev_region(&major, 0, 1, "nulo") < 0) {
    printk(KERN_ERR "Nulo: Error al reservar región de caracteres\n");
    return -1;
  }

  // 2. Inicializar el cdev y asociarlo a las operaciones
  cdev_init(&nulo_device, &nulo_operaciones);
  if (cdev_add(&nulo_device, major, 1) < 0) {
    unregister_chrdev_region(major, 1);
    return -1;
  }

  // 3. Crear la clase de dispositivo
  nulo_class = class_create(THIS_MODULE, "nulo_class");
  if (IS_ERR(nulo_class)) {
    cdev_del(&nulo_device);
    unregister_chrdev_region(major, 1);
    return PTR_ERR(nulo_class);
  }

  // 4. Crear el nodo /dev/nulo automáticamente
  device_create(nulo_class, NULL, major, NULL, "nulo");

  printk(KERN_INFO "Nulo: Dispositivo registrado en /dev/nulo\n");
  return 0;
}

static void __exit hello_exit(void) {
  // El orden de destrucción es el inverso al de creación
  device_destroy(nulo_class, major);
  class_destroy(nulo_class);
  cdev_del(&nulo_device);
  unregister_chrdev_region(major, 1);

  printk(KERN_INFO "Nulo: Dispositivo descargado\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO/Martin Nievas");
MODULE_DESCRIPTION("Driver nulo que emula /dev/null");
