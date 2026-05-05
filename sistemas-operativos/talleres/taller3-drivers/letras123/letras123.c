#include "asm-generic/errno-base.h"
#include "linux/gfp_types.h"
#include "linux/spinlock.h"
#include <linux/cdev.h>   // Char devices
#include <linux/device.h> // Nodos filesystem
#include <linux/fs.h>     // File operations
#include <linux/init.h>
#include <linux/kernel.h>  // Kernel cosas
#include <linux/module.h>  // THIS_MODULE
#include <linux/random.h>  // get_random_bytes
#include <linux/slab.h>    // kmalloc
#include <linux/uaccess.h> // copy_to_user

#define SLOT_COUNT 3
static spinlock_t lock;

// Contador de instancias activas
static int instances_count = 0;

typedef struct user_data {
  bool valid;
  char input;
} user_data;

static int letras_open(struct inode *inod, struct file *filp) {
  // Semaforo para poder aumentar la variable de instancias
  spin_lock(&lock);
  if (instances_count >= SLOT_COUNT) {
    spin_unlock(&lock);
    return -EPERM;
  }
  instances_count++;
  spin_unlock(&lock); // Liberamos el spinlock ANTES de kmalloc (no debe hacerse
                      // con lock tomado)

  // Asignamos espacio
  filp->private_data = kmalloc(sizeof(struct user_data), GFP_KERNEL);
  if (!filp->private_data) {
    // Si falla el kmalloc, devolvemos el slot
    spin_lock(&lock);
    instances_count--;
    spin_unlock(&lock);
    return -ENOMEM;
  }

  // La marcamos como invalida
  ((user_data *)filp->private_data)->valid = false;

  return 0;
}

static int letras_release(struct inode *inod, struct file *filp) {
  user_data *udata = (user_data *)filp->private_data;

  // Si el usuario no hizo el open() correctamente => fallamos
  if (!udata)
    return -EPERM;

  // Restamos la cantidad de slots en uso porque este proceso se va
  spin_lock(&lock);
  instances_count--;
  spin_unlock(&lock);

  // Hacemos el free de lo que pedimos en el open (DESPUÉS de liberar el lock)
  kfree(filp->private_data);

  return 0;
}

static ssize_t letras_read(struct file *filp, char __user *data, size_t size,
                           loff_t *offset) {
  user_data *udata = (user_data *)filp->private_data;
  unsigned char *buffer;
  unsigned int i = 0;

  if (!udata->valid)
    return -EPERM;

  buffer = kmalloc(size, GFP_KERNEL);
  if (!buffer)
    return -ENOMEM;

  while (i < size) {
    buffer[i] = udata->input;
    i++;
  }

  if (copy_to_user(data, buffer, size)) {
    kfree(buffer);
    return -EFAULT;
  }

  kfree(buffer);
  return size;
}

static ssize_t letras_write(struct file *filp, const char __user *data,
                            size_t size, loff_t *offset) {
  user_data *udata = (user_data *)filp->private_data;
  unsigned char letra;

  // Si nunca escribió es porque la data está invalidada
  if (!udata->valid) {
    // Copiamos una letra del usuario
    if (copy_from_user(&letra, data, 1) != 0) {
      return -EFAULT; // Error de segmentación en espacio de usuario
    }
    // La asignamos
    udata->input = letra;
    // Confirmamos que la info es válida
    udata->valid = true;
  }

  // Retornamos size para confirmar que "procesamos" todo el buffer,
  // aunque solo nos hayamos quedado con la primera letra.
  return size;
}

static struct file_operations letras_fops = {
    .owner = THIS_MODULE,
    .open = letras_open,
    .read = letras_read,
    .write = letras_write,
    .release = letras_release,
};

static dev_t letras_devno;
static struct cdev letras_cdev;
static struct class *letras_class;

static int __init letras_init(void) {
  spin_lock_init(&lock);
  cdev_init(&letras_cdev, &letras_fops);
  alloc_chrdev_region(&letras_devno, 0, 1, "SO-letras123");
  cdev_add(&letras_cdev, letras_devno, 1);
  letras_class = class_create(THIS_MODULE, "letras123");
  device_create(letras_class, NULL, letras_devno, NULL, "letras123");
  printk(KERN_ALERT "Loading module 'letras123'\n");
  return 0;
}

static void __exit letras_exit(void) {
  printk(KERN_ALERT "Unloading module 'letras123'\n");
  device_destroy(letras_class, letras_devno);
  class_destroy(letras_class);
  unregister_chrdev_region(letras_devno, 1);
  cdev_del(&letras_cdev);
}

module_init(letras_init);
module_exit(letras_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO");
MODULE_DESCRIPTION("Generador de números al letras");
