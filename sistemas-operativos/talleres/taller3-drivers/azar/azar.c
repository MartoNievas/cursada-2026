#include "asm-generic/errno-base.h"
#include "linux/gfp_types.h"
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/random.h>
#include <linux/slab.h>
#include <linux/uaccess.h>

static int upper_bound = -1;

static int azar_open(struct inode *inode, struct file *filp) {
  upper_bound = -1;
  return 0;
}

static ssize_t azar_read(struct file *filp, char __user *data, size_t size,
                         loff_t *offset) {
  char buffer[32];
  int n, random_val;

  if (upper_bound < 0)
    return -EPERM;

  if (*offset > 0)
    return 0;

  get_random_bytes(&random_val, sizeof(int));
  random_val = (unsigned int)random_val % (upper_bound + 1);

  n = snprintf(buffer, sizeof(buffer), "%d\n", random_val);

  if (copy_to_user(data, buffer, n))
    return -EFAULT;

  return n;
}

static ssize_t azar_write(struct file *filp, const char __user *data,
                          size_t size, loff_t *offset) {
  char *k_buffer;
  int val;

  k_buffer = kmalloc(size + 1, GFP_KERNEL);
  if (!k_buffer)
    return -ENOMEM;

  if (copy_from_user(k_buffer, data, size)) {
    kfree(k_buffer);
    return -EFAULT;
  }

  k_buffer[size] = '\0';

  if (size > 0 && k_buffer[size - 1] == '\n')
    k_buffer[size - 1] = '\0';

  if (kstrtoint(k_buffer, 10, &val) != 0) {
    kfree(k_buffer);
    return -EPERM;
  }

  upper_bound = val;
  kfree(k_buffer);
  return size;
}

static struct file_operations azar_fops = {
    .owner = THIS_MODULE,
    .open = azar_open,
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
