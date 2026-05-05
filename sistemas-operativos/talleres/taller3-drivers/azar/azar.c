#include "asm-generic/errno-base.h"
#include "linux/gfp_types.h"
#include <linux/cdev.h>   // Char devices
#include <linux/device.h> // Nodos filesystem
#include <linux/fs.h>     // File operations
#include <linux/init.h>
#include <linux/kernel.h>  // Kernel cosas
#include <linux/module.h>  // THIS_MODULE
#include <linux/random.h>  // get_random_bytes
#include <linux/slab.h>    // kmalloc
#include <linux/uaccess.h> // copy_to_user

static int upper_bound = -1;

static ssize_t azar_read(struct file *filp, char __user *data, size_t size,
                         loff_t *offset) {
  char buffer[32];
  int n, random_val;

  if (upper_bound < 0)
    return -EPERM;

  if (*offset > 0)
    return 0;

  // Generamos el numero al azar
  get_random_bytes(&random_val, sizeof(int));
  random_val = (unsigned int)random_val % (upper_bound + 1);

  // Lo pasamos a formato stirng
  n = snprintf(buffer, sizeof(buffer), "%d\n", random_val);

  // Ahora copiamos al usuario
  if (copy_to_user(data, buffer, n)) {
    return -EFAULT;
  }

  *offset += n;
  return n;
}

static ssize_t azar_write(struct file *filp, const char __user *data,
                          size_t size, loff_t *offset) {
  // Primero necesitamos el buffer para copiar la data del usuario
  char *k_buffer;
  int val; // Numero entero representado por el string

  k_buffer = kmalloc(size + 1, GFP_KERNEL);
  if (!k_buffer)
    return -ENOMEM;

  // Ahora con el buffer de size + 1 para poner \0 al final
  if (copy_from_user(k_buffer, data, size)) {
    kfree(k_buffer);
    return -EFAULT;
  }
  // Ponemos el ultimo caracter \0
  k_buffer[size] = '\0';

  // Intentamos convetir a int
  if (kstrtoint(k_buffer, 10, &val) != 0) {
    kfree(k_buffer);
    return -EPERM;
  }

  // Sin conseguimos leer 1
  upper_bound = val;
  kfree(k_buffer);
  return size;
}

static struct file_operations azar_fops = {
    .owner = THIS_MODULE,
    .read = azar_read,
    .write = azar_write,
};

static dev_t azar_devno;
static struct cdev azar_cdev;
static struct class *azar_class;

static int __init azar_init(void) {
  cdev_init(&azar_cdev, &azar_fops);
  alloc_chrdev_region(&azar_devno, 0, 1, "SO-azar");
  cdev_add(&azar_cdev, azar_devno, 1);

  azar_class = class_create(THIS_MODULE, "azar");
  device_create(azar_class, NULL, azar_devno, NULL, "azar");

  printk(KERN_ALERT "Loading module 'azar'\n");
  return 0;
}

static void __exit azar_exit(void) {
  printk(KERN_ALERT "Unloading module 'azar'\n");

  device_destroy(azar_class, azar_devno);
  class_destroy(azar_class);

  unregister_chrdev_region(azar_devno, 1);
  cdev_del(&azar_cdev);
}

module_init(azar_init);
module_exit(azar_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO");
MODULE_DESCRIPTION("Generador de números al azar/Martin Nievas");
