#ifndef UTILS_H
#define UTILS_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *name;
  int8_t age;
  char *cuit;
} user_t;

int cuitValidation(char *cuit);
user_t **readFile(int *count);
user_t *findUser(char *cuit);
void writeFile(user_t *user);

#endif // !UTILS_H
