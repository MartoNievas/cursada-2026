#include "utils.h"

void buscarInformacionUsuario(void) {
  printf("Ingrese un CUIT:\n");
  char *cuit = malloc(sizeof(char) * 12);
  scanf("%11s", cuit);
  user_t *user = findUser(cuit);
  free(cuit);

  if (!user) {
    printf("Usuario no encontrado\n");
  } else {
    printf("Nombre: %s, Edad: %hhd, CUIT: %s\n", user->name, user->age,
           user->cuit);
    free(user->name);
    free(user->cuit);
    free(user);
  }
}
