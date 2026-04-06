#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s <CUIT>\n", argv[0]);
    exit(1);
  }

  int numeros[] = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};
  int verficador = 0;

  char *cuit = argv[1];

  for (int i = 0; i < 10; i++) {
    int num = cuit[i] - '0';

    verficador += num * numeros[i];
  }

  verficador = 11 - (verficador % 11);
  int ldigit = cuit[10] - '0';

  if (ldigit == verficador) {
    printf("El cuit ingresado es VALIDO\n");
  } else {
    char correct_cuit[14];
    snprintf(correct_cuit, sizeof(correct_cuit), "%2.2s-%8.8s-%1.1s", cuit,
             cuit + 2, cuit + 10);
    printf("El CUIT ingresado no es valido, Su informacion corregida %s\n",
           correct_cuit);
  }
  return 0;
}
