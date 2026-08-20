#include "utils.h"

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
