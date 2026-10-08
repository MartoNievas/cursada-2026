#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/uaccess.h>

#define BUFFER_SIZE 32
#define CANTIDAD_CLAVES 16
#define DEVICE_NAME "clave_valor"

// Variables para la sincronizacion
struct mutex clave_valor_mutex[CANTIDAD_CLAVES];

// Estado global del modulo: una tabla de CANTIDAD_CLAVES casilleros
// compartida por todos los procesos que abran /dev/clave_valor (no una
// tabla por cada apertura).
static long tabla[CANTIDAD_CLAVES];

// El read no recibe ninguna clave: cada proceso solo puede leer SU PROPIO
// casillero. Pista: calcular la clave usando el PID del proceso que llama.
static ssize_t clave_valor_read(struct file *filp, char __user *data,
                                size_t size, loff_t *offset) {
  long value;
  int res;
  char kbuff[BUFFER_SIZE] = {0};

  // Asi obtenemos el indice
  int index = task_tgid_nr(current) % CANTIDAD_CLAVES;

  // Seccion critica
  mutex_lock(&clave_valor_mutex[index]);
  value = tabla[index];
  mutex_unlock(&clave_valor_mutex[index]);

  int len = snprintf(kbuff, BUFFER_SIZE, "%ld\n", value);

  if (size < len) {
    return -EINVAL;
  }

  res = copy_to_user(data, kbuff, size);
  if (res < 0) {
    return -EINVAL;
  }

  *offset += len;

  return len;
}

// El write si recibe una clave (como texto, en el buffer): la clave de la
// tabla que hay que incrementar en 1. No hace falta mandar nada mas: el
// incremento siempre es de a uno.
static ssize_t clave_valor_write(struct file *filp, const char __user *data,
                                 size_t size, loff_t *offset) {
  int res;

  char kbuffer[BUFFER_SIZE];
  res = copy_from_user(kbuffer, data, size);

  if (res < 0) {
    return -EINVAL;
  }

  int index;

  res = kstrtoint(kbuffer, 10, &index);
  if (res == -ERANGE || res == -EINVAL) {
    return -EINVAL;
  }

  if (index < 0 || index >= CANTIDAD_CLAVES) {
    return -EINVAL;
  }

  mutex_lock(&clave_valor_mutex[index]);
  tabla[index]++;
  mutex_unlock(&clave_valor_mutex[index]);

  return size;
}

static struct file_operations clave_valor_operaciones = {
    .owner = THIS_MODULE,
    .read = clave_valor_read,
    .write = clave_valor_write,
};

static struct cdev clave_valor_device;
static dev_t major;
static struct class *clave_valor_class;

static int __init clave_valor_init(void) {
  int ret;

  cdev_init(&clave_valor_device, &clave_valor_operaciones);
  ret = alloc_chrdev_region(&major, 0, 1, DEVICE_NAME);
  if (ret < 0) {
    unregister_chrdev_region(major, 1);
    return ret;
  }

  ret = cdev_add(&clave_valor_device, major, 1);
  if (ret < 0) {
    unregister_chrdev_region(major, 1);
    return ret;
  }

  clave_valor_class = class_create(THIS_MODULE, DEVICE_NAME);
  device_create(clave_valor_class, NULL, major, NULL, DEVICE_NAME);

  for (int i = 0; i < CANTIDAD_CLAVES; i++) {
    tabla[i] = 0;
    // Inicializamos el mutex pera sincronizacion de procesos
    mutex_init(&clave_valor_mutex[i]);
  }

  return 0;
}

static void __exit clave_valor_exit(void) {
  unregister_chrdev_region(major, 1);
  cdev_del(&clave_valor_device);

  // Descargamos el nodo del file system borrando la clase y el dispositivo
  device_destroy(clave_valor_class, major);
  class_destroy(clave_valor_class);
}

module_init(clave_valor_init);
module_exit(clave_valor_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO");
MODULE_DESCRIPTION("Una base de datos clave-valor muy simplificada");
