#include "utils.h"

void verInformacionUsuario(void) {
  int count = 0;
  user_t **users = readFile(&count);
  if (!users || count == 0) {
    printf("Ningun usuario fue cargado a la plataforma todavia\n");
    free(users);
  } else {
    for (int i = 0; i < count; i++) {
      printf("Usuario %d - Nombre: %s, Edad: %hhd, Cuit: %s\n", i + 1,
             users[i]->name, users[i]->age, users[i]->cuit);
      free(users[i]->name);
      free(users[i]->cuit);
      free(users[i]);
    }
    free(users);
  }
}
