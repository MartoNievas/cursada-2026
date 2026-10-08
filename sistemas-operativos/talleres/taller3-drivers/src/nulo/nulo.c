#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

#define DEVICE_NAME "nulo"

static ssize_t nulo_read(struct file *filp, char __user *data, size_t s,
                         loff_t *off) {
  // No lee nada entonces retorna 0
  return 0;
}

static ssize_t nulo_write(struct file *filp, const char __user *data, size_t s,
                          loff_t *off) {
  // Descarta todo lo que escribe, retona s  y no hace nada
  return s;
}

static struct file_operations nulo_operaciones = {
    .owner = THIS_MODULE, .read = nulo_read, .write = nulo_write};

static struct cdev nulo_device;
static dev_t major;
static struct class *nulo_class;

static int __init hello_init(void) {

  // Inicializar el dispositivo
  cdev_init(&nulo_device, &nulo_operaciones);

  // Conseguimos el major de manera dinamica, seteamos el minor, count y el
  // nombre del dispositivo
  alloc_chrdev_region(&major, 0, 1, DEVICE_NAME);

  // Asinamos el major al dispositivo
  cdev_add(&nulo_device, major, 1);

  /*
   Ahora inicializamos los nodos en el sistema de archivos, creando la clase y
   el dispositivo
  */
  nulo_class = class_create(THIS_MODULE, DEVICE_NAME);
  device_create(nulo_class, NULL, major, NULL, DEVICE_NAME);

  return 0;
}

static void __exit hello_exit(void) {
  // Con esto borramos el major, count y el dispositivo
  unregister_chrdev_region(major, 1);
  cdev_del(&nulo_device);

  // Descargamos el nodo del file system borrando la clase y el dispositivo
  device_destroy(nulo_class, major);
  class_destroy(nulo_class);
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO");
MODULE_DESCRIPTION("Una suerte de '/dev/null'");
