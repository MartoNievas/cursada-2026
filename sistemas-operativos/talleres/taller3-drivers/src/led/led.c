#include <asm/io.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/uaccess.h>

// Usamos el registro de datos del puerto paralelo.
#define LED_PORT 0x378
#define LED_BIT_ON 0x01
#define LED_BIT_OFF 0x00
#define DEVICE_NAME "led"

// Memoria compartida para sincronizacion de procesos
struct mutex led_mutex;

// Formato binario compartido con Python ("<BBBBf"), 8 bytes:
// status (0/1), rojo, verde, azul.
// En C de usuario: bool status; uint8_t r, g, b; float brillo;
struct led_estado {
  u8 status;
  struct {
    u8 r, g, b;
  } color;
  __le32 brillo;
};

// Estado global del modulo, compartido por todos los procesos que abran
// /dev/led. El campo status de aca no es la fuente de verdad: el
// encendido/apagado real vive en el bit LED_BIT_ON del puerto.
static struct led_estado estado = {
    .color = {.r = 0, .g = 255, .b = 0},
    .brillo = cpu_to_le32(0x3f800000), // 1.0f
};

static struct cdev led_device;
static dev_t led_dev;
static struct class *led_class;

static ssize_t led_read(struct file *filp, char __user *data, size_t size,
                        loff_t *offset) {
  /* Completar:
   *  - Si ya se leyeron los 8 bytes (*offset >= sizeof(struct led_estado))
   *    o si size es 0, devolver 0 (fin de archivo).
   *  - Armar una copia del estado actual, con status tomado del bit
   *    LED_BIT_ON de LED_PORT (inb).
   *  - Copiar al usuario a partir de *offset, como mucho size bytes,
        actualizar *offset y devolver cuantos se copiaron.
   */

  if (*offset >= sizeof(struct led_estado) || size == 0)
    return 0;

  struct led_estado led_status_to_read;

  // Seccion critica
  mutex_lock(&led_mutex);
  led_status_to_read.status = inb(LED_PORT) & 0x01;
  led_status_to_read.color = estado.color;
  led_status_to_read.brillo = estado.brillo;
  mutex_unlock(&led_mutex);

  size_t restantes, a_copiar;
  restantes = sizeof(led_status_to_read) - *offset;
  a_copiar = min(size, restantes);

  if (copy_to_user(data, (char *)&led_status_to_read + *offset, a_copiar))
    return -EFAULT;

  *offset += a_copiar;
  return a_copiar;
}

// Solo para el log: convierte un brillo ya validado a milesimas redondeadas.
static u32 brillo_milesimas(u32 bits) {
  u32 exponente = (bits >> 23) & 0xff;
  u32 desplazamiento;
  u64 escalado;

  // Estos valores son menores a media milesima (incluye ambos ceros).
  if (exponente < 116)
    return 0;

  desplazamiento = 150 - exponente;
  escalado = (u64)((bits & 0x7fffff) | 0x800000) * 1000;
  return (escalado + (1ULL << (desplazamiento - 1))) >> desplazamiento;
}

static ssize_t led_write(struct file *filp, const char __user *data,
                         size_t size, loff_t *offset) {

  if (size == 0)
    return 0;

  if (size != 8)
    return -EINVAL;

  struct led_estado status_led;

  int res = copy_from_user(&status_led, data, size);

  if (res < 0) {
    return -EINVAL;
  }

  if (status_led.status != 0 && status_led.status != 1)
    return -EINVAL;

  u32 bits = le32_to_cpu(status_led.brillo);

  if (!(bits <= 0x3f800000 || bits == 0x80000000))
    return -EINVAL;

  // Seccion critica
  mutex_lock(&led_mutex);
  estado.brillo = status_led.brillo;
  estado.color = status_led.color;
  outb(status_led.status, LED_PORT);
  mutex_unlock(&led_mutex);

  // Print Kirk?
  printk(KERN_INFO "led: LED %s, RGB(%u, %u, %u), brillo=%u.%03u\n",
         status_led.status ? "ON" : "OFF", status_led.color.r,
         status_led.color.g, status_led.color.b,
         brillo_milesimas(status_led.brillo) / 1000,
         brillo_milesimas(status_led.brillo) % 1000);

  return size;
}

static struct file_operations led_operaciones = {
    .owner = THIS_MODULE, .read = led_read, .write = led_write};

static int __init led_init(void) {
  int ret;
  outb(LED_BIT_OFF, LED_PORT);
  estado.status = LED_BIT_OFF;

  cdev_init(&led_device, &led_operaciones);
  ret = alloc_chrdev_region(&led_dev, 0, 1, DEVICE_NAME);
  if (ret < 0) {
    unregister_chrdev_region(led_dev, 1);
    return ret;
  }

  ret = cdev_add(&led_device, led_dev, 1);
  if (ret < 0) {
    unregister_chrdev_region(led_dev, 1);
    return ret;
  }

  led_class = class_create(THIS_MODULE, DEVICE_NAME);
  device_create(led_class, NULL, led_dev, NULL, DEVICE_NAME);

  // Inicializamos el mutex pera sincronizacion de procesos
  mutex_init(&led_mutex);

  return 0;
}

static void __exit led_exit(void) {
  /* Completar: apagar el LED y destruir el character device. */
  outb(LED_BIT_OFF, LED_PORT);
  estado.status = LED_BIT_OFF;

  unregister_chrdev_region(led_dev, 1);
  cdev_del(&led_device);

  // Descargamos el nodo del file system borrando la clase y el dispositivo
  device_destroy(led_class, led_dev);
  class_destroy(led_class);
}

module_init(led_init);
module_exit(led_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("La banda de SO");
MODULE_DESCRIPTION("LED controlado por el puerto paralelo con outb e inb");
