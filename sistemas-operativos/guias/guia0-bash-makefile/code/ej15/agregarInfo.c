#include "utils.h"

void agregarInformacionUsuario(void) {
  char *name = malloc(sizeof(char) * 25);
  char *cuit = malloc(sizeof(char) * 12);
  uint8_t age = 0;
  user_t *user = malloc(sizeof(user_t));
  printf("Ingrese el nombre:\n");
  scanf("%24s", name);
  printf("Ingrese la cuit:\n");
  scanf("%11s", cuit);
  printf("Ingrese la edad:\n");
  scanf("%hhu", &age);
  if (age > 18 && age < 99 && cuitValidation(cuit)) {
    user->age = age;
    user->name = name;
    user->cuit = cuit;
    writeFile(user);
    free(user->name);
    free(user->cuit);
    free(user);
  } else {
    printf("Informacion invalida, por favor, intente de nuevo\n");
    free(name);
    free(cuit);
    free(user);
  }
}
