#include <stddef.h>
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

user_t **readFile(int *count) {
  *count = 0;
  FILE *file = fopen("ej13.txt", "r");
  if (!file)
    return NULL;

  int capacity = 4;
  user_t **users = malloc(sizeof(user_t *) * capacity);

  char *line = NULL;
  size_t len = 0;

  while (getline(&line, &len, file) != -1) {
    if (*count == capacity) {
      capacity *= 2;
      users = realloc(users, sizeof(user_t *) * capacity);
      if (!users) {
        printf("Error: Null pointer\n");
        free(line);
        fclose(file);
        return NULL;
      }
    }
    user_t *user = malloc(sizeof(user_t));
    user->name = malloc(sizeof(char) * 25);
    user->cuit = malloc(sizeof(char) * 12);
    sscanf(line, "%24s %hhd %11s", user->name, &user->age, user->cuit);
    users[*count] = user;
    (*count)++;
  }

  free(line);
  fclose(file);
  return users;
}

user_t *findUser(char *cuit) {
  FILE *file = fopen("ej13.txt", "r");
  if (!file)
    return NULL;

  user_t *user = malloc(sizeof(user_t));
  user->name = malloc(sizeof(char) * 25);
  user->cuit = malloc(sizeof(char) * 12);

  char *line = NULL;
  size_t len = 0;

  while (getline(&line, &len, file) != -1) {
    sscanf(line, "%24s %hhd %11s", user->name, &user->age, user->cuit);
    if (strcmp(cuit, user->cuit) == 0) {
      free(line);
      fclose(file);
      return user;
    }
  }

  free(line);
  fclose(file);
  free(user->name);
  free(user->cuit);
  free(user);
  return NULL;
}

void writeFile(user_t *user) {
  FILE *file = fopen("ej13.txt", "a");
  if (!file) {
    printf("Error: no se pudo abrir el archivo para escritura\n");
    return;
  }
  fprintf(file, "%s %hhd %s\n", user->name, user->age, user->cuit);
  fclose(file);
}

int main(void) {
  char *option = malloc(sizeof(char) * 3);
  const char *verInfo = "verInformacionUsuario";
  const char *agregarInfo = "agregarInformacionUsuario";
  const char *buscarInfo = "buscarInformacionUsuario";

  while (1) {
    printf("Ingrese una opcion:\n");
    printf("1) %s \n", verInfo);
    printf("2) %s \n", agregarInfo);
    printf("3) %s\n", buscarInfo);
    scanf("%2s", option);

    if (strcmp("1", option) == 0) {
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

    } else if (strcmp("2", option) == 0) {
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

    } else if (strcmp(option, "3") == 0) {
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

    } else {
      printf("Error: opcion no soportada\n");
    }
  }

  free(option);
  return 0;
}
