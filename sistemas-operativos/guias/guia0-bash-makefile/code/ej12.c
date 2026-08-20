#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *name;
  int8_t age;
  char *cuit;
} user_t;

int cuitValidation(char *cuit) {
  if (strlen(cuit) != 11)
    return 0;
  int numeros[] = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};
  int verficador = 0;
  for (int i = 0; i < 10; i++) {
    int num = cuit[i] - '0';
    verficador += num * numeros[i];
  }
  verficador = 11 - (verficador % 11);
  int ldigit = cuit[10] - '0';
  if (ldigit == verficador) {
    return 1;
  } else {
    printf("CUIT invalido. Formato esperado: XX-XXXXXXXX-X\n");
    return 0;
  }
}

user_t *readFile(void) {
  FILE *file = fopen("ej12.txt", "r");
  if (!file)
    return NULL;
  user_t *user = malloc(sizeof(user_t));
  user->name = malloc(sizeof(char) * 25);
  user->cuit = malloc(sizeof(char) * 12);
  char line[256];
  if (!fgets(line, sizeof(line), file)) {
    fclose(file);
    free(user->name);
    free(user->cuit);
    free(user);
    return NULL;
  }
  sscanf(line, "%24s %hhd %11s", user->name, &user->age, user->cuit);
  fclose(file);
  return user;
}

void writeFile(user_t *user) {
  FILE *file = fopen("ej12.txt", "w");
  if (!file) {
    printf("Error: no se pudo abrir el archivo para escritura\n");
    return;
  }
  fprintf(file, "%s %hhd %s\n", user->name, user->age, user->cuit);
  fclose(file);
}

int main(void) {
  char *option = malloc(sizeof(char) * 64);
  const char *verInfo = "verInformacionUsuario";
  const char *agregarInfo = "agregarInformacionUsuario";

  while (1) {
    printf("Ingrese una opcion:\n");
    printf("1) %s \n", verInfo);
    printf("2) %s \n", agregarInfo);
    scanf("%63s", option);

    if (strcmp(verInfo, option) == 0) {
      user_t *user = readFile();
      if (!user) {
        printf("!Ningun usuario fue cargado a la plataforma todavia\n");
      } else {
        printf("Nombre: %s ,", user->name);
        printf("Edad: %hhd,", user->age);
        printf("Cuit: %s \n", user->cuit);
        free(user->name);
        free(user->cuit);
        free(user);
      }

    } else if (strcmp(agregarInfo, option) == 0) {
      char *name = malloc(sizeof(char) * 25);
      char *cuit = malloc(sizeof(char) * 12);
      uint8_t age = 0;
      user_t *user = malloc(sizeof(user_t));
      printf("Ingrese el name\n");
      scanf("%24s", name);
      printf("Ingrese una cuit:\n");
      scanf("%11s", cuit);
      printf("Ingrese una age:\n");
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

    } else {
      printf("Error: opcion no soportada\n");
      free(option);
      exit(1);
    }
  }

  return 0;
}
